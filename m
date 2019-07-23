Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3933C7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:25:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D90422512
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jQ/dJAQK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D90422512
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hprzA-0002NN-Qi
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 06:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33598)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hpryz-0001wV-Di
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:25:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hpryy-00066R-7T
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:25:21 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54430)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hpryx-00064j-Vk
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:25:20 -0400
Received: by mail-wm1-x342.google.com with SMTP id p74so37935152wme.4
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 03:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=qHhIES4oEU4OWFkZAfQ9eWzQ+JbrxCoKuaRRAvHytLY=;
 b=jQ/dJAQKIs46JN2rOG+bUshrYQtieEPsf7g2M1RzCFiL5HyEY6W+LVayLcKxO0x9Wz
 WBrh1p7rM58z/6zZul3LDjpXllBu9WYwV52BS6CIFTvgd1MVXKcKmId+kqR9GBphsIBU
 GXvGb/e/7iyJSp1uVIHnLpqLZor4Rd4eoO9GYIWAjIRPJ+BUnN2iWoIHz4zsJ0gf453m
 NoW6xqVfEz6m1TLtPw6Gqsy6Pdas5i+XGKfByZpdgTvVZ1CLXMJdGUdu2a0S+cpygH9j
 igtY4n7xSus6+dfSj6elafK563YJTY0a1UzLpU+vgnE1hvjbpgn1gS1TN2NvVxxX47iD
 W6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=qHhIES4oEU4OWFkZAfQ9eWzQ+JbrxCoKuaRRAvHytLY=;
 b=XFVH6+0lsqdFggFuiNPc6w7KfKkIKOR3LsL++hIx3+UGXvq3Gn5VLOVJNZPI4cGqvj
 wW+KrjTAKlWdzmhZthhdM+S3r/yPPqRSw7i7gesFyY+gmX5iFmkCvy4A/H0iNNN0mlTx
 4cbRSDjkgaHguXnPNJvz7jNmcw9qZcc+QUhzzmioLcA+7lSoki99Gr/qpCyyRiyX4Hkb
 +K8+0Qq89r7DhgMTcjPAcC4guVcaLDkl/8FmhCtM40OSSWp9feSOhMc5GAr+QwVM4gTw
 ZVP3HzaFEOsOG/KbOEJ9QZzHd5iv87GEnimQxre8JIZc04rTq9P83aC25QouVWyVv3lw
 wvqg==
X-Gm-Message-State: APjAAAV3uIV49AmaZY9eiPrA22syYuyYQJKSuPvpJC96znVvVm6yo9/i
 A5xnFsDJQxSC12PnuIj7yUdOZ9RkieQ=
X-Google-Smtp-Source: APXvYqwkRjCisjHcldCQjNavyXi3wiTtcvDpkD7wNZzs/NxJs/yzgHQDSfVLyRFGJGBLw4vVCrE4UA==
X-Received: by 2002:a05:600c:2146:: with SMTP id
 v6mr3219554wml.59.1563877516916; 
 Tue, 23 Jul 2019 03:25:16 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id o3sm34790759wrs.59.2019.07.23.03.25.16
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 23 Jul 2019 03:25:16 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EE6181FF87;
 Tue, 23 Jul 2019 11:25:15 +0100 (BST)
References: <20190723070218.3606-1-philmd@redhat.com>
User-agent: mu4e 1.3.3; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
In-reply-to: <20190723070218.3606-1-philmd@redhat.com>
Date: Tue, 23 Jul 2019 11:25:15 +0100
Message-ID: <87lfwp120k.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v2] NSIS: Add missing firmware blobs
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
Cc: Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Various firmwares has been added in the pc-bios/ directory:
>
> - CCW     (since commit 0c1fecdd523)
> - skiboot (since commit bcad45de6a0)
> - EDK2    (since commit f7fa38b74c3)
>
> Since we install qemu-system able to run the architectures
> targetted by these firmware, include them in the NSIS exe.
>
> Reviewed-by: Stefan Weil <sw@weilnetz.de>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Queued to testing/next, thanks.
> ---
> v2: Add *.ndrv, update the Uninstall section (Stefan)
> ---
>  qemu.nsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/qemu.nsi b/qemu.nsi
> index 75f1608b9e..d0df0f4e3a 100644
> --- a/qemu.nsi
> +++ b/qemu.nsi
> @@ -106,6 +106,9 @@ RequestExecutionLevel admin
>  ;--------------------------------
>
>  ; The stuff to install.
> +;
> +; Remember to keep the "Uninstall" section in sync.
> +
>  Section "${PRODUCT} (required)"
>
>      SectionIn RO
> @@ -122,6 +125,10 @@ Section "${PRODUCT} (required)"
>      File "${BINDIR}\*.bmp"
>      File "${BINDIR}\*.bin"
>      File "${BINDIR}\*.dtb"
> +    File "${BINDIR}\*.fd"
> +    File "${BINDIR}\*.img"
> +    File "${BINDIR}\*.lid"
> +    File "${BINDIR}\*.ndrv"
>      File "${BINDIR}\*.rom"
>      File "${BINDIR}\openbios-*"
>
> @@ -210,6 +217,10 @@ Section "Uninstall"
>      Delete "$INSTDIR\*.bin"
>      Delete "$INSTDIR\*.dll"
>      Delete "$INSTDIR\*.dtb"
> +    Delete "$INSTDIR\*.fd"
> +    Delete "$INSTDIR\*.img"
> +    Delete "$INSTDIR\*.lid"
> +    Delete "$INSTDIR\*.ndrv"
>      Delete "$INSTDIR\*.rom"
>      Delete "$INSTDIR\openbios-*"
>      Delete "$INSTDIR\qemu-img.exe"


--
Alex Benn=C3=A9e

