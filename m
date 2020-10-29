Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1F1C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 14:44:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D809F20732
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 14:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o2zsKOUd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D809F20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY9AH-0000X7-Q6
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 10:44:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kY981-0007AC-7t
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 10:42:13 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43251)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kY97y-00081f-7e
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 10:42:12 -0400
Received: by mail-wr1-x443.google.com with SMTP id g12so3030899wrp.10
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 07:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=8t1JEggWEgtOw/O52D17ErYztHoM3WZWQIZcbzThXIQ=;
 b=o2zsKOUdeuO1VVA3FdfgXIaZoUuRQfkkcFOV+MaFYBCXk7sLkd8BpWofdCLgIGtJdS
 r+uWafUlFeowgGdCnEw7aPkCR99uRkPG/CiG0A/CaZA5fXbmIuiwVyzFT9AHAtT6P6Aw
 YkQxSFKW/r2Vedo5W96wUpGyh3SAl9hWdgU4k/v5eFDGuS8EjaQ95ixdyKHvtFDrxooV
 oZHEBkBbGNrx+HLFqvK7zzfyhHTlTIgKxo/z3eO8JxuDAhXNh7sN54SLyOWWh2rD+ftA
 m06a55RnJ/WfSLoKg01SHA+xO7sdBaq0lxBTXJl1+matLSYv1ZovqT++mFMGLrjOjqMh
 TUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=8t1JEggWEgtOw/O52D17ErYztHoM3WZWQIZcbzThXIQ=;
 b=jqQB0/9hUtPdUAewBQN7bw267u6cpf6h7MFDJzcALPKseLNnkBeTBz82AZ/dG8mMNX
 /VxwXvoxnnn90nhsTbTKldwglQoFbUSxA/JrXBPcxSVCl93MAyCh7hjmLOVTxAagcGB9
 apQUPZiW8sOx0nN9Tj/XNYehirlES8IMSSUXfFqtUC7V6+Da9Z9DTIHRbPdy/UECZzFe
 nlPEI5vE5S13IxnomCDmqHGKCfu7MZHh98hpxQ93GVfV9jPWc02CeFmQ8YquHzmHQRo+
 kxDT7/T6NCX6Xei9VqaRGlOjsXS9mJzvo4HUuQwn+3I9tWyB7Yg9b7vLCOisFa98kms4
 jUlQ==
X-Gm-Message-State: AOAM532pe7620eoRnV2hML6K7u1aVoZ0wgssrNKwpqoj7DI70K6KD3oa
 KBi1+eMCTY48yRJ+KzNnzIKJ5g==
X-Google-Smtp-Source: ABdhPJyFztNdzsOcFqgEaV8G1/MCWpVBV3pvI3gNTGD17vpSbltjoPZC/IhLl2d+zQgDjvZWjlUbag==
X-Received: by 2002:adf:97cb:: with SMTP id t11mr6485498wrb.292.1603982527380; 
 Thu, 29 Oct 2020 07:42:07 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b136sm103369wmb.21.2020.10.29.07.42.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 07:42:05 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 00B2A1FF7E;
 Thu, 29 Oct 2020 14:42:04 +0000 (GMT)
References: <20200915134317.11110-1-alex.bennee@linaro.org>
 <20200915134317.11110-9-alex.bennee@linaro.org>
 <599acb88-ab14-c8c7-5ba6-6526b6e7c629@redhat.com>
User-agent: mu4e 1.5.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2 8/8] configure: add [lm32|unicore32]-softmmu to
 deprecation logic
In-reply-to: <599acb88-ab14-c8c7-5ba6-6526b6e7c629@redhat.com>
Date: Thu, 29 Oct 2020 14:42:04 +0000
Message-ID: <874kmdm6v7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> On 15/09/2020 15.43, Alex Benn=C3=A9e wrote:
>> While we are at it move the few places where they are into the
>> deprecation build bucket.
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  configure      | 2 +-
>>  .gitlab-ci.yml | 9 +++++----
>>  .shippable.yml | 2 +-
>>  3 files changed, 7 insertions(+), 6 deletions(-)
>
>  Hi Alex,
>
> I noticed that these deprecated targets do not show up in the
> output of "configure --help" at all anymore:
>
>  --target-list=3DLIST       set target list (default: build everything)
>                            Available targets: aarch64-softmmu alpha-softm=
mu=20
>                            arm-softmmu avr-softmmu cris-softmmu hppa-soft=
mmu=20
>                            i386-softmmu m68k-softmmu microblazeel-softmmu=
=20
>                            microblaze-softmmu mips64el-softmmu mips64-sof=
tmmu=20
>                            mipsel-softmmu mips-softmmu moxie-softmmu=20
>                            nios2-softmmu or1k-softmmu ppc64-softmmu ppc-s=
oftmmu=20
>                            riscv32-softmmu riscv64-softmmu rx-softmmu=20
>                            s390x-softmmu sh4eb-softmmu sh4-softmmu=20
>                            sparc64-softmmu sparc-softmmu tricore-softmmu=
=20
>                            x86_64-softmmu xtensaeb-softmmu xtensa-softmmu=
=20
>                            aarch64_be-linux-user aarch64-linux-user=20
>                            alpha-linux-user armeb-linux-user arm-linux-us=
er=20
>                            cris-linux-user hppa-linux-user i386-linux-use=
r=20
>                            m68k-linux-user microblazeel-linux-user=20
>                            microblaze-linux-user mips64el-linux-user=20
>                            mips64-linux-user mipsel-linux-user mips-linux=
-user=20
>                            mipsn32el-linux-user mipsn32-linux-user=20
>                            nios2-linux-user or1k-linux-user ppc64le-linux=
-user=20
>                            ppc64-linux-user ppc-linux-user riscv32-linux-=
user=20
>                            riscv64-linux-user s390x-linux-user sh4eb-linu=
x-user=20
>                            sh4-linux-user sparc32plus-linux-user=20
>                            sparc64-linux-user sparc-linux-user=20
>                            x86_64-linux-user xtensaeb-linux-user=20
>                            xtensa-linux-user
>
> The text "default: build everything" is now also not accurate anymore.
> How is a user who is still interested in these targets supposed to find
> the right --target-list parameters now?

How about:

--8<---------------cut here---------------start------------->8---
modified   configure
@@ -1644,9 +1644,11 @@ Standard options:
   --prefix=3DPREFIX          install in PREFIX [$prefix]
   --interp-prefix=3DPREFIX   where to find shared libraries, etc.
                            use %M for cpu name [$interp_prefix]
-  --target-list=3DLIST       set target list (default: build everything)
+  --target-list=3DLIST       set target list (default: build all non-deprc=
ated)
 $(echo Available targets: $default_target_list | \
   fold -s -w 53 | sed -e 's/^/                           /')
+$(echo Deprecated targets: $deprecated_targets_list | \
+  fold -s -w 53 | sed -e 's/^/                           /')
   --target-list-exclude=3DLIST exclude a set of targets from the default t=
arget-list
=20
 Advanced options (experts only):
--8<---------------cut here---------------end--------------->8---

Which would give:


  --target-list=3DLIST       set target list (default: build all non-deprca=
ted)
                           Available targets: aarch64-softmmu alpha-softmmu=
=20
                           arm-softmmu avr-softmmu cris-softmmu hppa-softmm=
u=20
                           i386-softmmu m68k-softmmu microblaze-softmmu=20
                           microblazeel-softmmu mips-softmmu mips64-softmmu=
=20
                           mips64el-softmmu mipsel-softmmu moxie-softmmu=20
                           nios2-softmmu or1k-softmmu ppc-softmmu ppc64-sof=
tmmu=20
                           riscv32-softmmu riscv64-softmmu rx-softmmu=20
                           s390x-softmmu sh4-softmmu sh4eb-softmmu=20
                           sparc-softmmu sparc64-softmmu tricore-softmmu=20
                           x86_64-softmmu xtensa-softmmu xtensaeb-softmmu=20
                           aarch64-linux-user aarch64_be-linux-user=20
                           alpha-linux-user arm-linux-user armeb-linux-user=
=20
                           cris-linux-user hppa-linux-user i386-linux-user=
=20
                           m68k-linux-user microblaze-linux-user=20
                           microblazeel-linux-user mips-linux-user=20
                           mips64-linux-user mips64el-linux-user=20
                           mipsel-linux-user mipsn32-linux-user=20
                           mipsn32el-linux-user nios2-linux-user=20
                           or1k-linux-user ppc-linux-user ppc64-linux-user=
=20
                           ppc64le-linux-user riscv32-linux-user=20
                           riscv64-linux-user s390x-linux-user sh4-linux-us=
er=20
                           sh4eb-linux-user sparc-linux-user=20
                           sparc32plus-linux-user sparc64-linux-user=20
                           x86_64-linux-user xtensa-linux-user=20
                           xtensaeb-linux-user
                           Deprecated targets:=20
                           ppc64abi32-linux-user,tilegx-linux-user,lm32-sof=
tmmu,
                           unicore32-softmmu
  --target-list-exclude=3DLIST exclude a set of targets from the default ta=
rget-list

--=20
Alex Benn=C3=A9e

