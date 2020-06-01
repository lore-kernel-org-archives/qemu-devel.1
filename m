Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57E8C433E1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 13:12:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0D782074B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 13:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p2gI8yF/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0D782074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfkEy-00083v-Q8
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 09:12:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jfkEM-0007bi-T6
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 09:11:54 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:35296)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jfkEL-0003UD-QW
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 09:11:54 -0400
Received: by mail-lj1-x243.google.com with SMTP id c11so8077291ljn.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 06:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=1iT2pOBXp3eLUD3uypKfu4vPN6DJMP/+obMKt/Y+Po0=;
 b=p2gI8yF//WVHEDWzsN6tkEsIuDyh3R40ZHDEZlP6gw6QmotX5euHYThiCVut0reJxF
 aMGPqmSpYlYPqSAXXBBHL3TE78sIrYVTuDLYGtxZNrqxNhNTu0hdrA0Hzk3NYxLXQ0Yn
 nLrt9oulLU9dUwuMZyHXTjIOJsoDiNmXPIbuyG1tR8/MCsu6m2Y2uwi+VBB3E+clKRfj
 dRY9j8jqtZ9B/57REX+V5sDa4Eyviuuu1nwe/oIqyRa21io7vIabuGR/yfxWV88fVALQ
 P8k9byu9jvcgpfg4y1WJWKjf2Nl8CtWjLeir3yfLC2OrX+fzH/CSV0WNwRjayjdIAHCq
 z72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=1iT2pOBXp3eLUD3uypKfu4vPN6DJMP/+obMKt/Y+Po0=;
 b=IGeXr1Csf8ZR41am9Tys1RyIbT94PmUFr2DQ88+OlLvLZelqG1+OXzowfbfpPyPybW
 BAjYnyonoViRZpUzwpVpENRRZ3KPSx+bDlHlmxgpMvT+OmQPsg1wnjWUn27jRnMALLlV
 d14xvyNv1j4mY68SH2sp4oIRP8YWUWfJcDTC3AK76uzyP0NzmTPiUCpQmbu3xoKvjZIU
 dyIfdEYNjpmrrlIUTCexVJ1z7yZuvyWj3HgZxUR5EqSadhwg3mSCmTQXXjoF2UW7c0MK
 tAMZl+I4Yd8DWb1Jz9a0IxQ+rbcCP3hU4JoFt8y7jKjRkYVbl0XCRFwPWRTTXlv/xn0Q
 ZtXg==
X-Gm-Message-State: AOAM531WXvbLpMc/3SAo5Qfd+kTETHDFqMiAeYGS4xoI1j7X20PHOVZx
 N98WElmCMuRvklRZIE61baUY0ZDu5UygKd3Rm5UbQw==
X-Google-Smtp-Source: ABdhPJycQ3vbaafjm4kd3hdpnjz4MOATiezt8oaNrkpR4rqPAiQfdFv7MTOsYc4Agj77PsuGxnMlS8fekREPW6gE62c=
X-Received: by 2002:a2e:150f:: with SMTP id s15mr10292986ljd.102.1591017112187; 
 Mon, 01 Jun 2020 06:11:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200529203458.1038-1-robert.foley@linaro.org>
 <20200529203458.1038-9-robert.foley@linaro.org>
 <6f29b51c-b8d6-772c-eb24-b4c88c6c2d62@redhat.com>
 <878sh8v0h5.fsf@linaro.org>
In-Reply-To: <878sh8v0h5.fsf@linaro.org>
From: Robert Foley <robert.foley@linaro.org>
Date: Mon, 1 Jun 2020 09:11:50 -0400
Message-ID: <CAEyhzFv_UPbzDxfuj5gQdpz+EKVBN_9nzhVUPJrvs2h=d2zKmQ@mail.gmail.com>
Subject: Re: [PATCH v8 08/12] tests/vm: Added a new script for ubuntu.aarch64.
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=robert.foley@linaro.org; helo=mail-lj1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Peter Puhov <peter.puhov@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 31 May 2020 at 06:54, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>
> > Hi Robert,
> >
> > On 5/29/20 10:34 PM, Robert Foley wrote:
> <snip>
> >> diff --git a/configure b/configure
> >> index d82de47fdd..8a286e75a5 100755
> >> --- a/configure
> >> +++ b/configure
> >> @@ -411,6 +411,7 @@ prefix=3D"/usr/local"
> >>  mandir=3D"\${prefix}/share/man"
> >>  datadir=3D"\${prefix}/share"
> >>  firmwarepath=3D"\${prefix}/share/qemu-firmware"
> >> +efi_aarch64=3D""
> >>  qemu_docdir=3D"\${prefix}/share/doc/qemu"
> >>  bindir=3D"\${prefix}/bin"
> >>  libdir=3D"\${prefix}/lib"
> >> @@ -1099,6 +1100,8 @@ for opt do
> >>    ;;
> >>    --firmwarepath=3D*) firmwarepath=3D"$optarg"
> >>    ;;
> >> +  --efi-aarch64=3D*) efi_aarch64=3D"$optarg"
> >> +  ;;
> >>    --host=3D*|--build=3D*|\
> >>    --disable-dependency-tracking|\
> >>    --sbindir=3D*|--sharedstatedir=3D*|\
> >> @@ -1753,6 +1756,7 @@ Advanced options (experts only):
> >>    --sysconfdir=3DPATH        install config in PATH$confsuffix
> >>    --localstatedir=3DPATH     install local state in PATH (set at runt=
ime on win32)
> >>    --firmwarepath=3DPATH      search PATH for firmware files
> >> +  --efi-aarch64=3DPATH       PATH of efi file to use for aarch64 VMs.
> >>    --with-confsuffix=3DSUFFIX suffix for QEMU data inside datadir/libd=
ir/sysconfdir [$confsuffix]
> >>    --with-pkgversion=3DVERS   use specified string as sub-version of t=
he package
> >>    --enable-debug           enable common debug build options
> >> @@ -3548,6 +3552,20 @@ EOF
> >>    fi
> >>  fi
> >>
> >> +############################################
> >> +# efi-aarch64 probe
> >> +# Check for efi files needed by aarch64 VMs.
> >> +# By default we will use the efi included with QEMU.
> >> +# Allow user to override the path for efi also.
> >> +if ! test -f "$efi_aarch64"; then
> >> +    if test -f $source_path/pc-bios/edk2-aaarch64-code.fd.bz2; then
> >> +        # valid after build
> >> +        efi_aarch64=3D$PWD/pc-bios/edk2-aarch64-code.fd
> >> +    else
> >> +        efi_aarch64=3D""
> >> +    fi
> >> +fi
> >> +
> <snip>
> >>
> >>  IMAGES_DIR :=3D $(HOME)/.cache/qemu-vm/images
> >> @@ -23,6 +26,11 @@ vm-help vm-test:
> >>  ifneq ($(GENISOIMAGE),)
> >>      @echo "  vm-build-centos                 - Build QEMU in CentOS V=
M, with Docker"
> >>      @echo "  vm-build-ubuntu.i386            - Build QEMU in ubuntu i=
386 VM"
> >> +ifneq ($(EFI_AARCH64),)
> >> +    @echo "  vm-build-ubuntu.aarch64         - Build QEMU in ubuntu a=
arch64 VM"
> >> +else
> >> +    @echo "  (install qemu-efi-aarch64 to build centos/ubuntu aarch64=
 images.)"
> >
> > I'm not sure your test is working well, I have qemu-efi-aarch64
> > installed and it not automatically discovered.
> >
> > # apt install qemu-efi-aarch64
> > qemu-efi-aarch64 is already the newest version
> > (0~20191122.bd85bf54-2ubuntu3).
> >
> > Hint: I'm using out-of-tree builds.
>
> I think efi_aarch64=3D"" needs to be the default path, which can then be
> overridden by the command line or finally fall back to the built in
> image.

I think what we are saying here is that if we want to use the qemu-efi-aarc=
h64
package's image we should override it on the command line via --efi-aarch64=
.

Seems like the text above needs adjustment to something like:
> +ifneq ($(EFI_AARCH64),)
> +    @echo "  vm-build-ubuntu.aarch64         - Build QEMU in ubuntu aarc=
h64 VM"
> +else
       @echo "  to build centos/ubuntu aarch64 images use configure
--efi-aarch64"

Thanks & Regards,
-Rob
>
> --
> Alex Benn=C3=A9e

