Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3E7C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 15:30:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAEA120659
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 15:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ny+0Zv5y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAEA120659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhyG6-0006J5-Ma
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 11:30:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35125)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hhxqG-0004HE-G0
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 11:03:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hhxqE-00029f-Ue
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 11:03:40 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:39316)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hhxqB-000265-Lj; Mon, 01 Jul 2019 11:03:35 -0400
Received: by mail-oi1-x244.google.com with SMTP id m202so10206390oig.6;
 Mon, 01 Jul 2019 08:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=B+A0hFAVCheAwsnwyOOvGgSh2Ve5m1gtOdssRqihzKA=;
 b=Ny+0Zv5yuCIhwi5lRvING1hLhyWtLqDmURc1PtK83Skr2k2tPMT7cnr/rglA4Iz0YS
 xVHzBUhG5oPRbReRV33HOUri+W/PHe4VC1SemXJLtk+kSjpOIfLs6qyyiImqSLrgfs7y
 PFdpXfGEtEb6pnrtwY70J7dBsRCSKbOfAqp4ZXj7Juu4A6MnAc0bSdF4HEA0mapHanDe
 2zvi4DVw9ICTpeznxvikIE81NJvyPB5R3CKTvV/2qvbQVq9OAhi8BCdmAs5tUYmYPM+z
 Ha1r1zZjGMoEjR27Itj4W+GBo7BuGZeQJPP+hGrMK9j6LdwlBBxJ7RsgYR5ixFByeZPS
 vaDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=B+A0hFAVCheAwsnwyOOvGgSh2Ve5m1gtOdssRqihzKA=;
 b=QCmd8XTY4IO0LqgWFangP3eO6bhNc9mWe0AreQsGcjXC2Nn848WiEL10Yr2cpxCtEq
 EmpuZn/HaPEtmaFkOqT0BkIplPYnzdlnMzbyRb/yx1kr5/FC6c+7jazCfwTXQUEE0TVO
 k8gW1gwNzPSOjZ3sfy5b/FUeJZ3l1Bqb3GDA7LoW3LoTDjjY0bT7ANLnk1b2zNWu9x68
 jg1KgjhD5N/FhMbsx91BXYg8qWseiMpOmarKD2wo8GXngxDQV9txtT3qhN2F4tdm4wwI
 gnBgpP//BHf5GldIrnfHCpwCUCWoOt5uo5lCFMGliXlPnElsQ6OQPimP70WdRU7j8QiA
 +KdA==
X-Gm-Message-State: APjAAAXi3OtNoaVDLzKXxc5O1+fNfMUn/Kyz72Yd/zUYrY1Bs6ZYOhR0
 +YXdlkCJjbgcBzkG2JkDr0uxPqAQMTKSOK9/f/w=
X-Google-Smtp-Source: APXvYqxHWwGhso8Mz2wTb49BqOq4IT1XfDdKLJRXcz6pN7y9jHYoeVaRCDbp8V2MyaXhbb5BS66mKF6509ErPEsvakU=
X-Received: by 2002:aca:310a:: with SMTP id x10mr7327300oix.62.1561993414062; 
 Mon, 01 Jul 2019 08:03:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4798:0:0:0:0:0 with HTTP;
 Mon, 1 Jul 2019 08:03:33 -0700 (PDT)
Received: by 2002:a9d:4798:0:0:0:0:0 with HTTP;
 Mon, 1 Jul 2019 08:03:33 -0700 (PDT)
In-Reply-To: <a09936fe-4fdc-1623-6300-43f4891ff389@redhat.com>
References: <20190607174953.22342-1-philmd@redhat.com>
 <a09936fe-4fdc-1623-6300-43f4891ff389@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 1 Jul 2019 17:03:33 +0200
Message-ID: <CAL1e-=hoWQpmttzUGGbW7x8gGme7VMfEKhw=cFpL5Pg9A9sHDQ@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH] BootLinuxSshTest: Only use 'test' for
 unittest.TestCase method names
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org, Aleksandar Rikalo <arikalo@wavecomp.com>,
 Cleber Rosa <crosa@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jul 1, 2019 4:22 PM, "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com> w=
rote:
>
> ping?
>
> On 6/7/19 7:49 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> > In commit f6e501a28ef9, Eduardo started to use "check_" as a
> > prefix for methods of similar purpose. Follow this prior art,
> > since it might become the conventions when writting Avocado
> > tests.
> >
> > Suggested-by: Cleber Rosa <crosa@redhat.com>
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > ---

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

> >  tests/acceptance/linux_ssh_mips_malta.py | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/tests/acceptance/linux_ssh_mips_malta.py
b/tests/acceptance/linux_ssh_mips_malta.py
> > index aafb0c39f6..134f10cac3 100644
> > --- a/tests/acceptance/linux_ssh_mips_malta.py
> > +++ b/tests/acceptance/linux_ssh_mips_malta.py
> > @@ -162,7 +162,7 @@ class LinuxSSH(Test):
> >          self.assertIn(True, ["0dfbe8aa4c20b52e1b8bf3cb6cbdf193" in lin=
e
> >                               for line in stdout])
> >
> > -    def do_test_mips_malta(self, endianess, kernel_path, uname_m):
> > +    def check_mips_malta(self, endianess, kernel_path, uname_m):
> >          self.boot_debian_wheezy_image_and_ssh_login(endianess,
kernel_path)
> >
> >          stdout, stderr =3D self.ssh_command('uname -a')
> > @@ -184,7 +184,7 @@ class LinuxSSH(Test):
> >          kernel_hash =3D '592e384a4edc16dade52a6cd5c785c637bcbc9ad'
> >          kernel_path =3D self.fetch_asset(kernel_url,
asset_hash=3Dkernel_hash)
> >
> > -        self.do_test_mips_malta('be', kernel_path, 'mips')
> > +        self.check_mips_malta('be', kernel_path, 'mips')
> >
> >      @skipIf(os.getenv('CONTINUOUS_INTEGRATION'), 'Running on
Travis-CI')
> >      def test_mips_malta32el_kernel3_2_0(self):
> > @@ -199,7 +199,7 @@ class LinuxSSH(Test):
> >          kernel_hash =3D 'a66bea5a8adaa2cb3d36a1d4e0ccdb01be8f6c2a'
> >          kernel_path =3D self.fetch_asset(kernel_url,
asset_hash=3Dkernel_hash)
> >
> > -        self.do_test_mips_malta('le', kernel_path, 'mips')
> > +        self.check_mips_malta('le', kernel_path, 'mips')
> >
> >      @skipIf(os.getenv('CONTINUOUS_INTEGRATION'), 'Running on
Travis-CI')
> >      def test_mips_malta64eb_kernel3_2_0(self):
> > @@ -213,7 +213,7 @@ class LinuxSSH(Test):
> >                        'vmlinux-3.2.0-4-5kc-malta')
> >          kernel_hash =3D 'db6eea7de35d36c77d8c165b6bcb222e16eb91db'
> >          kernel_path =3D self.fetch_asset(kernel_url,
asset_hash=3Dkernel_hash)
> > -        self.do_test_mips_malta('be', kernel_path, 'mips64')
> > +        self.check_mips_malta('be', kernel_path, 'mips64')
> >
> >      @skipIf(os.getenv('CONTINUOUS_INTEGRATION'), 'Running on
Travis-CI')
> >      def test_mips_malta64el_kernel3_2_0(self):
> > @@ -227,4 +227,4 @@ class LinuxSSH(Test):
> >                        'vmlinux-3.2.0-4-5kc-malta')
> >          kernel_hash =3D '6a7f77245acf231415a0e8b725d91ed2f3487794'
> >          kernel_path =3D self.fetch_asset(kernel_url,
asset_hash=3Dkernel_hash)
> > -        self.do_test_mips_malta('le', kernel_path, 'mips64')
> > +        self.check_mips_malta('le', kernel_path, 'mips64')
> >
>
