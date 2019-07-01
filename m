Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A0DC5B578
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 01:57:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0779620881
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 01:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjEKlP+o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0779620881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi83K-0004DI-7Y
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 21:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54942)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hi4Kl-0003cy-E8
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:59:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hi4Ki-0007v5-Rs
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:59:34 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36153)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hi4Kf-0007u5-Dx; Mon, 01 Jul 2019 17:59:29 -0400
Received: by mail-oi1-f194.google.com with SMTP id w7so11269999oic.3;
 Mon, 01 Jul 2019 14:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=giwH7CgD6/A63HEnNwr1sQ4JxuR6Deb9LpUuZLXIuxc=;
 b=cjEKlP+oD5jhjwdPimkYk7w0HhfZPp9uQaxhWuIv7hFDxDhRljecYXAv5z0D1sVZa+
 suG29Sfi7h4CB8y6emXvcSvlRNhpzDR2GJgYUJxNwFCHDUf5Q4WgfF0Y3JXkXXjjD5bT
 YmpvFb3/91vLzZNhyTGOisqivW3Fpe0DFRelSakugMHksHWsDshZnC71GUgVEBGjbeJk
 IZv8wK/f3P+/xssqgB2XpcfCKEAbaQ1YppdVrLfIhtDgARGtwbfM0T1BUYSoD7LetT+x
 0FrCCh++MEGViXzwo7AAGvAOBdC6BWSf2zkuHJYY7ScaIphskdSPCBOjg6zrosbzRY/4
 8fXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=giwH7CgD6/A63HEnNwr1sQ4JxuR6Deb9LpUuZLXIuxc=;
 b=ZMu72GuIuNNAqUkRjsmOSbdVw8tEnPPY080/2hEyKmVpfaWjTEaObU8PsZgow57wMK
 WVkE/IPN2zuky81em9EDjJVyocYB61PfgrD/eMCn47Hu86A91LSDvQmogods/N8R9smF
 wQv52Ex/28O0O/hir6B1KJhtjrOI2aIZ3lKXL0A8gi5zvuszRhXxnzICwIbCPpEZpIAz
 DDqW44vEr1Qeop1XnpUyPBazCXbGAcJ75rsv7I5yRJe3lCcKnEyD2k/bE7rfpriLZjc3
 tok432kwyE/8hEl3LiQTS8iXvu/eaJg2ERfDhTWn1uY7PKnsHiKvwxIx0Dh0ysY9KNhl
 ujiQ==
X-Gm-Message-State: APjAAAV5gxwcj1KD4kAJF8dGHv+39oPjdP9G/A+KM8YDrO0s4dFSCMAl
 puKW/yCzgnNF7XJ1h438DwcPHpBoKp7ONAh6t7wEOg==
X-Google-Smtp-Source: APXvYqwKs/levlATGmDoZjTsqCGH5vrd0vmMo/14DURow/y9KCgErPJG34cQGcMZ7q/LvXLjEjPVoRhBlt88yFn8Ml8=
X-Received: by 2002:aca:310a:: with SMTP id x10mr271485oix.62.1562001901761;
 Mon, 01 Jul 2019 10:25:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4798:0:0:0:0:0 with HTTP;
 Mon, 1 Jul 2019 10:25:01 -0700 (PDT)
Received: by 2002:a9d:4798:0:0:0:0:0 with HTTP;
 Mon, 1 Jul 2019 10:25:01 -0700 (PDT)
In-Reply-To: <20190701152332.GA30640@localhost.localdomain>
References: <20190607174953.22342-1-philmd@redhat.com>
 <a09936fe-4fdc-1623-6300-43f4891ff389@redhat.com>
 <CAL1e-=hoWQpmttzUGGbW7x8gGme7VMfEKhw=cFpL5Pg9A9sHDQ@mail.gmail.com>
 <20190701152332.GA30640@localhost.localdomain>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 1 Jul 2019 19:25:01 +0200
Message-ID: <CAL1e-=gukWv2ZTDFSmnTLA-pMpgxYDTUghvXk88ur6Fc-8RP1w@mail.gmail.com>
To: Cleber Rosa <crosa@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.167.194
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
Cc: ehabkost@redhat.com, qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jul 1, 2019 5:23 PM, "Cleber Rosa" <crosa@redhat.com> wrote:
>
> On Mon, Jul 01, 2019 at 05:03:33PM +0200, Aleksandar Markovic wrote:
> > On Jul 1, 2019 4:22 PM, "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.co=
m>
wrote:
> > >
> > > ping?
> > >
> > > On 6/7/19 7:49 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> > > > In commit f6e501a28ef9, Eduardo started to use "check_" as a
> > > > prefix for methods of similar purpose. Follow this prior art,
> > > > since it might become the conventions when writting Avocado
> > > > tests.
> > > >
> > > > Suggested-by: Cleber Rosa <crosa@redhat.com>
> > > > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > > > ---
> >
> > Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> Reviewed-by: Cleber Rosa <crosa@redhat.com>
>
> And queued on my python-next branch.
>

Beautiful, thanks!

> >
> > > >  tests/acceptance/linux_ssh_mips_malta.py | 10 +++++-----
> > > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/tests/acceptance/linux_ssh_mips_malta.py
> > b/tests/acceptance/linux_ssh_mips_malta.py
> > > > index aafb0c39f6..134f10cac3 100644
> > > > --- a/tests/acceptance/linux_ssh_mips_malta.py
> > > > +++ b/tests/acceptance/linux_ssh_mips_malta.py
> > > > @@ -162,7 +162,7 @@ class LinuxSSH(Test):
> > > >          self.assertIn(True, ["0dfbe8aa4c20b52e1b8bf3cb6cbdf193" in
line
> > > >                               for line in stdout])
> > > >
> > > > -    def do_test_mips_malta(self, endianess, kernel_path, uname_m):
> > > > +    def check_mips_malta(self, endianess, kernel_path, uname_m):
> > > >          self.boot_debian_wheezy_image_and_ssh_login(endianess,
> > kernel_path)
> > > >
> > > >          stdout, stderr =3D self.ssh_command('uname -a')
> > > > @@ -184,7 +184,7 @@ class LinuxSSH(Test):
> > > >          kernel_hash =3D '592e384a4edc16dade52a6cd5c785c637bcbc9ad'
> > > >          kernel_path =3D self.fetch_asset(kernel_url,
> > asset_hash=3Dkernel_hash)
> > > >
> > > > -        self.do_test_mips_malta('be', kernel_path, 'mips')
> > > > +        self.check_mips_malta('be', kernel_path, 'mips')
> > > >
> > > >      @skipIf(os.getenv('CONTINUOUS_INTEGRATION'), 'Running on
> > Travis-CI')
> > > >      def test_mips_malta32el_kernel3_2_0(self):
> > > > @@ -199,7 +199,7 @@ class LinuxSSH(Test):
> > > >          kernel_hash =3D 'a66bea5a8adaa2cb3d36a1d4e0ccdb01be8f6c2a'
> > > >          kernel_path =3D self.fetch_asset(kernel_url,
> > asset_hash=3Dkernel_hash)
> > > >
> > > > -        self.do_test_mips_malta('le', kernel_path, 'mips')
> > > > +        self.check_mips_malta('le', kernel_path, 'mips')
> > > >
> > > >      @skipIf(os.getenv('CONTINUOUS_INTEGRATION'), 'Running on
> > Travis-CI')
> > > >      def test_mips_malta64eb_kernel3_2_0(self):
> > > > @@ -213,7 +213,7 @@ class LinuxSSH(Test):
> > > >                        'vmlinux-3.2.0-4-5kc-malta')
> > > >          kernel_hash =3D 'db6eea7de35d36c77d8c165b6bcb222e16eb91db'
> > > >          kernel_path =3D self.fetch_asset(kernel_url,
> > asset_hash=3Dkernel_hash)
> > > > -        self.do_test_mips_malta('be', kernel_path, 'mips64')
> > > > +        self.check_mips_malta('be', kernel_path, 'mips64')
> > > >
> > > >      @skipIf(os.getenv('CONTINUOUS_INTEGRATION'), 'Running on
> > Travis-CI')
> > > >      def test_mips_malta64el_kernel3_2_0(self):
> > > > @@ -227,4 +227,4 @@ class LinuxSSH(Test):
> > > >                        'vmlinux-3.2.0-4-5kc-malta')
> > > >          kernel_hash =3D '6a7f77245acf231415a0e8b725d91ed2f3487794'
> > > >          kernel_path =3D self.fetch_asset(kernel_url,
> > asset_hash=3Dkernel_hash)
> > > > -        self.do_test_mips_malta('le', kernel_path, 'mips64')
> > > > +        self.check_mips_malta('le', kernel_path, 'mips64')
> > > >
> > >
