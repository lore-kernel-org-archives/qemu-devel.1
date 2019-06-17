Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AE3C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 16:02:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEE1620644
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 16:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b8CZRBQk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEE1620644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48834 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcu5a-00046o-PL
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 12:02:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51098)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hcswX-000156-F4
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:49:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hcswV-0001xR-FZ
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:49:09 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36927)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hcswV-0001vO-8y
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:49:07 -0400
Received: by mail-wr1-x444.google.com with SMTP id v14so10292463wrr.4
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 07:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=4eADj56o5J+lh84KGfNJMQOHvIfyZq5AYuDxFcffxaU=;
 b=b8CZRBQky6XilAtlI9R97bXgr+tj4F0J+hodsenugNdxkqyKtLBRKVVuqk28XKyaG6
 D7wer/fIxN0pZ8YsYwZyEv68lXqX9JWmg4NU3sJpxHiHPVCaRHXQaN2FBQvncRoFbH1l
 mG6wqkrjJl/PEpOc6hDkoKcjyrLwvqDPpK1BTeqFt3cCnrqbEXRf2v/ygE1U3XEP1Phm
 yiLPJsrlZRmRK05AmSsQBZDeE7poR0o6B1l/IB4GR35gC26xoJwQBbOmfFX9zE21y+ih
 /2qUZPEh7KoXnKJIY3jqfDt9vu4xFqnMwG2axrRnOJyXFAJb+p35JiJ9w26qD9LrWc+I
 RdzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=4eADj56o5J+lh84KGfNJMQOHvIfyZq5AYuDxFcffxaU=;
 b=bERus50UTAXx/hcrOU5xLkRmzUx0N4/VYziBUylROXutmgLjCgUphaOb+H9eZroYz/
 j4L8iJaIW08PJzsNz5KFS31CaaOggTZiuSE5Dr7mfMcs29krdHewhCYlQQsZ261Q4MiP
 NnhBP8W5hFfV/D2qBoFsJnqoaOQPnOpSHeirLSGhM2rbNViS6byXzajQ6oWp/jvsl61u
 U/+/rzwYO29EgPebN9F6A0IHqT3SpdTrKqXsKdBoRpJ+thcQx3Yar/S9z9ZbQVB5AQ3q
 N2hj4B2osIPOZTx7QLWO+3FWqnGTNqGDxhg8i9jojbhEqZ1pmXJRABdeaWK/Yg8M+lzk
 pCFg==
X-Gm-Message-State: APjAAAUOmIOhDx/gWzgLyyPQJrGybo7sDxZDUXskqnjX1f+jGE9mNxOn
 dJT6paQDFwRY78BpZW4+70CLjg==
X-Google-Smtp-Source: APXvYqymG/d0xGaOEoMoE+bd55X3sLfu7J12dVM7MXCDK0XWTgd0qJvR1GQeJe8zS4f8boNMIOsgDw==
X-Received: by 2002:adf:e88e:: with SMTP id d14mr14855696wrm.189.1560782943215; 
 Mon, 17 Jun 2019 07:49:03 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id l124sm17676421wmf.36.2019.06.17.07.49.02
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 17 Jun 2019 07:49:02 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5B1391FF87;
 Mon, 17 Jun 2019 15:49:02 +0100 (BST)
References: <20190615154352.26824-1-philmd@redhat.com>
 <20190615154352.26824-22-philmd@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
In-reply-to: <20190615154352.26824-22-philmd@redhat.com>
Date: Mon, 17 Jun 2019 15:49:02 +0100
Message-ID: <87ef3s9sip.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 21/23] target/arm: Do not
 build TCG objects when TCG is off
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Robert Bradford <robert.bradford@intel.com>,
 Samuel Ortiz <sameo@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> From: Samuel Ortiz <sameo@linux.intel.com>
>
> We can now safely turn all TCG dependent build off when CONFIG_TCG is
> off. This allows building ARM binaries with --disable-tcg.
>
> Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Robert Bradford <robert.bradford@intel.com>
> [PMD: Rebased]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>
> We can also use:
>
>   ifeq ($(CONFIG_TCG),y)
>   ...
>   endif
>
> But long single line with macros from rules.mak are way easier to
> rebase. Now that this series is stable, I could change to ifeq if
> required.

Given you spent that time re-ordering stuff to keep it together I think
ifeq for blocks would be better. Some commentary in the Makefile.objs so
people know where to put their new files would also help.

>
>  target/arm/Makefile.objs | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
> index 5f3f965cc6..b8aa9c032a 100644
> --- a/target/arm/Makefile.objs
> +++ b/target/arm/Makefile.objs
> @@ -3,7 +3,7 @@ obj-y +=3D cpu.o helper.o gdbstub.o
>  obj-$(TARGET_AARCH64) +=3D cpu64.o gdbstub64.o
>
>  obj-$(CONFIG_SOFTMMU) +=3D machine.o arch_dump.o monitor.o arm-powerctl.o
> -obj-$(CONFIG_SOFTMMU) +=3D psci.o
> +obj-$(call land,$(CONFIG_TCG),$(CONFIG_SOFTMMU)) +=3D psci.o
>
>  obj-$(CONFIG_KVM) +=3D kvm.o
>  obj-$(call land,$(CONFIG_KVM),$(call lnot,$(TARGET_AARCH64))) +=3D kvm32=
.o
> @@ -31,12 +31,12 @@ target/arm/translate-sve.o: target/arm/decode-sve.inc=
.c
>  target/arm/translate.o: target/arm/decode-vfp.inc.c
>  target/arm/translate.o: target/arm/decode-vfp-uncond.inc.c
>
> -obj-y +=3D translate.o op_helper.o
> -obj-y +=3D crypto_helper.o
> -obj-y +=3D iwmmxt_helper.o vec_helper.o
> -obj-y +=3D neon_helper.o vfp_helper.o
> -obj-$(call lor,$(CONFIG_USER_ONLY),$(CONFIG_ARM_V7M)) +=3D v7m_helper.o
> +obj-$(CONFIG_TCG) +=3D translate.o op_helper.o
> +obj-$(CONFIG_TCG) +=3D crypto_helper.o
> +obj-$(CONFIG_TCG) +=3D iwmmxt_helper.o vec_helper.o
> +obj-$(CONFIG_TCG) +=3D neon_helper.o vfp_helper.o
> +obj-$(call lor,$(CONFIG_USER_ONLY),$(call land,$(CONFIG_TCG),$(CONFIG_AR=
M_V7M))) +=3D v7m_helper.o
>
> -obj-$(TARGET_AARCH64) +=3D translate-a64.o helper-a64.o
> -obj-$(TARGET_AARCH64) +=3D translate-sve.o sve_helper.o
> -obj-$(TARGET_AARCH64) +=3D pauth_helper.o
> +obj-$(call land,$(CONFIG_TCG),$(TARGET_AARCH64)) +=3D translate-a64.o he=
lper-a64.o
> +obj-$(call land,$(CONFIG_TCG),$(TARGET_AARCH64)) +=3D translate-sve.o sv=
e_helper.o
> +obj-$(call land,$(CONFIG_TCG),$(TARGET_AARCH64)) +=3D pauth_helper.o


--
Alex Benn=C3=A9e

