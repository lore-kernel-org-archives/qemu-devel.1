Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9E4C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 08:25:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3924A20709
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 08:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="GBrCqeeK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3924A20709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxR6q-0007ci-DM
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 04:25:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1jxR4h-000726-Sv; Mon, 20 Jul 2020 04:23:04 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:44655)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1jxR4f-0001ZO-E4; Mon, 20 Jul 2020 04:23:03 -0400
Received: by mail-ej1-x643.google.com with SMTP id ga4so17113816ejb.11;
 Mon, 20 Jul 2020 01:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ps9sxJqWf6+f62TxYNrCyTGHKofiYB1akozfykT/4iI=;
 b=GBrCqeeK74Q7AYZVaJASz1oFBRHsfOI9QJJiE0DZrzuQAfGt9vEjMu6TkrK9h7G4Jf
 DMHUS3jWTmRtF0QAc4NJqlzvIyKBgsEDoX1IfKWUzlVjZFT0Oim/+//55D68aWH2nkzG
 nUegZsz9WDQWHK5Tv1GurBWJnjoGyLzEiV0vY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ps9sxJqWf6+f62TxYNrCyTGHKofiYB1akozfykT/4iI=;
 b=cOiszoppoCYY1l2h6HLRe7F91XixosTZ3ozuNmb24M2J3A2osqSbf5wsDrW70Vh8vd
 gWunVPGzXwBeULrYlh1eAWCFT8KcJwUbpr6iTi7YNKu/or0gj3c/xGGX27MvHTZkH6wk
 5M9mKs8Lrd/qn6S427xx5G/QNcLPdN5ql/K63r7oQQi2D5Hs+hl+DcqVAuEKyrrDgZJP
 g3oai1b6842QHU3n4Cu+3RTO2esFrUvK/WzI94HtefYPf6AwdzmTQTQMavsj8fR5WRhk
 yt78R5Psk32yrTzHJHOfzhmAN5MQLEHyg6CmUU4XEno6Q3bPTO0YZH+Zdiv6mQdpLHKY
 s2Hg==
X-Gm-Message-State: AOAM532jF+7KD/q048KMPhDPrXvab7h2zQema4jP2lf7NOCHa+qe4F01
 egW6a4Sp7l8zka27UExM+MEhfRSWXaU96tLlaJk=
X-Google-Smtp-Source: ABdhPJwaCB1bUKylXeAy43b1IdKuzUk86dKIgvkk73Nbh7JoTudWtZulkLLUIeZqErOPd+ZsjDiMTc/CBsdRzkBhbfY=
X-Received: by 2002:a17:906:cce6:: with SMTP id
 ot38mr19453646ejb.266.1595233378570; 
 Mon, 20 Jul 2020 01:22:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200717060258.1602319-1-hskinnemoen@google.com>
 <20200717060258.1602319-14-hskinnemoen@google.com>
 <f098aa02-28cd-f86b-1641-5e164ba5ca7f@kaod.org>
In-Reply-To: <f098aa02-28cd-f86b-1641-5e164ba5ca7f@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 20 Jul 2020 08:22:46 +0000
Message-ID: <CACPK8Xe_COP0sLCZnjnRYgA13W73BPnw9g0B5u6DK4++MDy5-A@mail.gmail.com>
Subject: Re: [PATCH v6 13/13] tests/acceptance: console boot tests for
 quanta-gsj
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=joel.stan@gmail.com; helo=mail-ej1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Havard Skinnemoen <hskinnemoen@google.com>,
 QEMU Developers <qemu-devel@nongnu.org>, CS20 KFTing <kfting@nuvoton.com>,
 qemu-arm <qemu-arm@nongnu.org>, Avi Fishman <Avi.Fishman@nuvoton.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 Jul 2020 at 12:33, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> On 7/17/20 8:02 AM, Havard Skinnemoen wrote:
> > This adds two acceptance tests for the quanta-gsj machine.
> >
> > One test downloads a lightly patched openbmc flash image from github an=
d
> > verifies that it boots all the way to the login prompt.
> >
> > The other test downloads a kernel, initrd and dtb built from the same
> > openbmc source and verifies that the kernel detects all CPUs and boots
> > to the point where it can't find the root filesystem (because we have n=
o
> > flash image in this case).
> >
> > Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
>
> It looks good but I am not sure it's a good idea to have tests
> point to URLs like :
>
> https://github.com/hskinnemoen/openbmc/releases/download/20200711-gsj-qem=
u-0/obmc-phosphor-initramfs-gsj.cpio.xz
>
> Philippe, Peter, is that OK ?
>
>
> If so, Joel, Andrew, could we host FW images on the OpenBMC github ?
> and do the same for Aspeed.

Yeah, we can do that if it would be preferred.

Nice work on adding a test Havard. I have been meaning to do the same
for the aspeed machines for a while.

>
> Thanks,
>
> C.
>
> > ---
> >  tests/acceptance/boot_linux_console.py | 65 ++++++++++++++++++++++++++
> >  1 file changed, 65 insertions(+)
> >
> > diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/=
boot_linux_console.py
> > index 73cc69c499..1d82fc7ff8 100644
> > --- a/tests/acceptance/boot_linux_console.py
> > +++ b/tests/acceptance/boot_linux_console.py
> > @@ -569,6 +569,71 @@ class BootLinuxConsole(LinuxKernelTest):
> >                                                  'sda')
> >          # cubieboard's reboot is not functioning; omit reboot test.
> >
> > +    def test_arm_quanta_gsj(self):
> > +        """
> > +        :avocado: tags=3Darch:arm
> > +        :avocado: tags=3Dmachine:quanta-gsj
> > +        """
> > +        # 25 MiB compressed, 32 MiB uncompressed.
> > +        image_url =3D (
> > +                'https://github.com/hskinnemoen/openbmc/releases/downl=
oad/'
> > +                '20200711-gsj-qemu-0/obmc-phosphor-image-gsj.static.mt=
d.gz')
> > +        image_hash =3D '14895e634923345cb5c8776037ff7876df96f6b1'
> > +        image_path_gz =3D self.fetch_asset(image_url, asset_hash=3Dima=
ge_hash)
> > +        image_name =3D os.path.splitext(os.path.basename(image_path_gz=
))[0]
> > +        image_path =3D os.path.join(self.workdir, image_name)
> > +        archive.gzip_uncompress(image_path_gz, image_path)
> > +
> > +        self.vm.set_console()
> > +        drive_args =3D 'file=3D' + image_path + ',if=3Dmtd,bus=3D0,uni=
t=3D0'
> > +        self.vm.add_args('-drive', drive_args)
> > +        self.vm.launch()
> > +
> > +        self.wait_for_console_pattern('> BootBlock by Nuvoton')
> > +        self.wait_for_console_pattern('>Device: Poleg BMC NPCM730')
> > +        self.wait_for_console_pattern('>Skip DDR init.')
> > +        self.wait_for_console_pattern('U-Boot ')
> > +        self.wait_for_console_pattern('Booting Linux on physical CPU 0=
x0')
> > +        self.wait_for_console_pattern('CPU1: thread -1, cpu 1, socket =
0')
> > +        self.wait_for_console_pattern('OpenBMC Project Reference Distr=
o')
> > +        self.wait_for_console_pattern('gsj login:')
> > +
> > +    def test_arm_quanta_gsj_initrd(self):
> > +        """
> > +        :avocado: tags=3Darch:arm
> > +        :avocado: tags=3Dmachine:quanta-gsj
> > +        """
> > +        initrd_url =3D (
> > +                'https://github.com/hskinnemoen/openbmc/releases/downl=
oad/'
> > +                '20200711-gsj-qemu-0/obmc-phosphor-initramfs-gsj.cpio.=
xz')
> > +        initrd_hash =3D '98fefe5d7e56727b1eb17d5c00311b1b5c945300'
> > +        initrd_path =3D self.fetch_asset(initrd_url, asset_hash=3Dinit=
rd_hash)
> > +        kernel_url =3D (
> > +                'https://github.com/hskinnemoen/openbmc/releases/downl=
oad/'
> > +                '20200711-gsj-qemu-0/uImage-gsj.bin')
> > +        kernel_hash =3D 'fa67b2f141d56d39b3c54305c0e8a899c99eb2c7'
> > +        kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkern=
el_hash)
> > +        dtb_url =3D (
> > +                'https://github.com/hskinnemoen/openbmc/releases/downl=
oad/'
> > +                '20200711-gsj-qemu-0/nuvoton-npcm730-gsj.dtb')
> > +        dtb_hash =3D '18315f7006d7b688d8312d5c727eecd819aa36a4'
> > +        dtb_path =3D self.fetch_asset(dtb_url, asset_hash=3Ddtb_hash)
> > +
> > +        self.vm.set_console()
> > +        kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
> > +                               'console=3DttyS0,115200n8 '
> > +                               'earlycon=3Duart8250,mmio32,0xf0001000'=
)
> > +        self.vm.add_args('-kernel', kernel_path,
> > +                         '-initrd', initrd_path,
> > +                         '-dtb', dtb_path,
> > +                         '-append', kernel_command_line)
> > +        self.vm.launch()
> > +
> > +        self.wait_for_console_pattern('Booting Linux on physical CPU 0=
x0')
> > +        self.wait_for_console_pattern('CPU1: thread -1, cpu 1, socket =
0')
> > +        self.wait_for_console_pattern(
> > +                'Give root password for system maintenance')
> > +
> >      def test_arm_orangepi(self):
> >          """
> >          :avocado: tags=3Darch:arm
> >
>

