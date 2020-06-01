Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB87C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 12:08:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B2BC2077D
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 12:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zc3Lkgru"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B2BC2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfjEs-0004u4-N8
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 08:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jfjDq-0004AS-AD
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 08:07:18 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:33926)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jfjDp-0005XD-Br
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 08:07:18 -0400
Received: by mail-lf1-x141.google.com with SMTP id e125so3791006lfd.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 05:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=X9gOE/op6dsDy6+1xYc3Kah1d1aojjJGXnTlp845jFc=;
 b=zc3LkgruGBTeM0RTsVCFUHUoEL+e2fhQxDOt1+Wfc/7TdEt65kOeFsiHYO2rbh6fHF
 IFt+vlpQEF/fjOPmCOxJHu//6F9HuxzD8cMlgQXE5T7Y0KgId1eJwfaUpn3Bq0EDFxGH
 LXxs5tAIUCwZj65jgCDfbWjt3Xn8WeWeWjQTWdScv05FYCUyFtD6oukgYMhnPARl+FEy
 fduANDXy+N/x0itk7I3rbII44AqqSMTh0Dn5oQ6AVWCqbtmrFVsb8bsB+Fq6M3FYYXUe
 OqWl+iS3Hlz2JFlttjz+szZn8FcSI3ks6Ue9PraGrxKBbXtof5VQHm5rkFXfpcHsGA3d
 ZHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=X9gOE/op6dsDy6+1xYc3Kah1d1aojjJGXnTlp845jFc=;
 b=CmMKt8ualXxqTvrwt50zLV5ysiqyHn1pxdhJZus8IlXEhjRi0JnlAJei1uROJFy/ka
 6zicbwfmbCoZ2cQsVTx1PZs+TKPgrWE85c9sz+s5mJ6xs7kzDKZ06MfVD+435H/yNP43
 UlZZ98cOr3PMGn54sbyQIZR8nj9xB/jvs3mjefzkiiqpiLeQ3Ab6w2NGhr04N0+MePxB
 3RWhEuWOuaN2I/X1ROvPmbCNtl0+9pDOSoezAU32Sbp073e3CerLPo4BvkdrEQEhFtWw
 GG/nMkvvgzVIc7wN5+xvPl2Rj6JMBZ+MaQJTXILDGsWjipoSXyleRHKaFVEIVBKLW+CK
 MuVA==
X-Gm-Message-State: AOAM532EWyzVhhSvgR0YFI8z9+totKwvLhTzf0a/OXTFX+moR4XnYp0p
 zNs6zYcBGwNawHIpW9huoPDfCr25FmNcEaBOHUOFi57V6uA=
X-Google-Smtp-Source: ABdhPJx1OQVSTxKIJ/rh+GkP8nD8hPChr/AeL0xACW7FFO4kjVZ+77KwclC4uwOUyAN8/gzabL/Fhc4bngVN3P33/IM=
X-Received: by 2002:a19:550e:: with SMTP id n14mr11259786lfe.81.1591013235166; 
 Mon, 01 Jun 2020 05:07:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200529203458.1038-1-robert.foley@linaro.org>
 <20200529203458.1038-8-robert.foley@linaro.org>
 <3cfd11c3-a99b-3766-4607-39c2174f1652@redhat.com>
In-Reply-To: <3cfd11c3-a99b-3766-4607-39c2174f1652@redhat.com>
From: Robert Foley <robert.foley@linaro.org>
Date: Mon, 1 Jun 2020 08:07:13 -0400
Message-ID: <CAEyhzFsU1GgmQk3mxC4qc7m8KLkGPuyZXz0EODtOPx0Rh_ZzAg@mail.gmail.com>
Subject: Re: [PATCH v8 07/12] tests/vm: Add common Ubuntu python module
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::141;
 envelope-from=robert.foley@linaro.org; helo=mail-lf1-x141.google.com
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
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 31 May 2020 at 06:37, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> On 5/29/20 10:34 PM, Robert Foley wrote:
> > Add a common Ubuntu python module and make use of
> > it with the ubuntu.i386 script.
> > This is preparation for adding an Ubuntu script
> > ubuntu.aarch64.  Splitting out the common
> > logic such as build_image() will reduce duplication.
<snip>
> > diff --git a/tests/vm/ubuntuvm.py b/tests/vm/ubuntuvm.py
> > new file mode 100644
> > index 0000000000..96f29dcc15
> > --- /dev/null
> > +++ b/tests/vm/ubuntuvm.py
> > @@ -0,0 +1,58 @@
> > +#!/usr/bin/env python3
> > +#
> > +# Ubuntu VM testing library
> > +#
>
> Maybe:
>
>    # Copyright 2017 Red Hat Inc.
>
> > +# Copyright 2020 Linaro
> > +#
> > +# Authors:
>
> And:
>
>    #  Fam Zheng <famz@redhat.com>
>
> or a line "copied from ..."?

Good catch!  Will update this with all of the above suggestions.

Thanks & Regards,
-Rob
>
> > +#  Robert Foley <robert.foley@linaro.org>
> > +#
> > +# This code is licensed under the GPL version 2 or later.  See
> > +# the COPYING file in the top-level directory.
> > +
> > +import os
> > +import subprocess
> > +import basevm
> > +
> > +class UbuntuVM(basevm.BaseVM):
> > +
> > +    def __init__(self, args, config=3DNone):
> > +        self.login_prompt =3D "ubuntu-{}-guest login:".format(self.arc=
h)
> > +        basevm.BaseVM.__init__(self, args, config)
> > +
> > +    def build_image(self, img):
> > +        """Build an Ubuntu VM image.  The child class will
> > +           define the install_cmds to init the VM."""
> > +        os_img =3D self._download_with_cache(self.image_link,
> > +                                           sha256sum=3Dself.image_sha2=
56)
> > +        img_tmp =3D img + ".tmp"
> > +        subprocess.check_call(["cp", "-f", os_img, img_tmp])
> > +        self.exec_qemu_img("resize", img_tmp, "+50G")
> > +        ci_img =3D self.gen_cloud_init_iso()
> > +
> > +        self.boot(img_tmp, extra_args =3D [ "-device", "VGA", "-cdrom"=
, ci_img, ])
> > +
> > +        # First command we issue is fix for slow ssh login.
> > +        self.wait_ssh(wait_root=3DTrue,
> > +                      cmd=3D"chmod -x /etc/update-motd.d/*")
> > +        # Wait for cloud init to finish
> > +        self.wait_ssh(wait_root=3DTrue,
> > +                      cmd=3D"ls /var/lib/cloud/instance/boot-finished"=
)
> > +        self.ssh_root("touch /etc/cloud/cloud-init.disabled")
> > +        # Disable auto upgrades.
> > +        # We want to keep the VM system state stable.
> > +        self.ssh_root('sed -ie \'s/"1"/"0"/g\' '\
> > +                      '/etc/apt/apt.conf.d/20auto-upgrades')
> > +        self.ssh_root("sed -ie s/^#\ deb-src/deb-src/g /etc/apt/source=
s.list")
> > +
> > +        # If the user chooses not to do the install phase,
> > +        # then we will jump right to the graceful shutdown
> > +        if self._config['install_cmds'] !=3D "":
> > +            # Issue the install commands.
> > +            # This can be overriden by the user in the config .yml.
> > +            install_cmds =3D self._config['install_cmds'].split(',')
> > +            for cmd in install_cmds:
> > +                self.ssh_root(cmd)
> > +        self.graceful_shutdown()
> > +        os.rename(img_tmp, img)
> > +        return 0
> >
>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>

