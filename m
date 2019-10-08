Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39087C10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 21:50:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 096E220679
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 21:50:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 096E220679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHxN4-00019p-4h
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 17:50:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50673)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iHxMF-0000Xr-63
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 17:49:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iHxMD-0006gQ-J5
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 17:49:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34850)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>)
 id 1iHxM3-0006bD-Mi; Tue, 08 Oct 2019 17:49:15 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BCD8710C0946;
 Tue,  8 Oct 2019 21:49:14 +0000 (UTC)
Received: from localhost.localdomain (ovpn-122-151.rdu2.redhat.com
 [10.10.122.151])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BAF366012A;
 Tue,  8 Oct 2019 21:49:09 +0000 (UTC)
Date: Tue, 8 Oct 2019 17:49:07 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/5] tests/boot_linux_console: Add initrd test for the
 Exynos4210
Message-ID: <20191008214907.GA28137@localhost.localdomain>
References: <20191005154748.21718-1-f4bug@amsat.org>
 <20191005154748.21718-2-f4bug@amsat.org>
 <CAFEAcA8ME5U5=rNLRSvNx7LmanqHhn_KWj6qtgym_=W1M9WDoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAFEAcA8ME5U5=rNLRSvNx7LmanqHhn_KWj6qtgym_=W1M9WDoA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Tue, 08 Oct 2019 21:49:14 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: =?iso-8859-1?Q?Fr=E9d=E9ric?= Basse <contact@fredericb.info>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Evgeny Voevodin <e.voevodin@samsung.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Dmitry Solodkiy <d.solodkiy@samsung.com>, Maksim Kozlov <m.kozlov@samsung.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 07, 2019 at 05:28:49PM +0100, Peter Maydell wrote:
> On Sat, 5 Oct 2019 at 16:47, Philippe Mathieu-Daud=E9 <f4bug@amsat.org>=
 wrote:
> >
> > This test boots a Linux kernel on a smdkc210 board and verify
> > the serial output is working.
> >
> > The cpio image used comes from the linux-build-test project:
> > https://github.com/groeck/linux-build-test
>=20
> Thanks for putting this test case together, very helpful.
>=20
> > +        initrd_url =3D ('https://github.com/groeck/linux-build-test/=
raw/'
> > +                      '2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/root=
fs/'
> > +                      'arm/rootfs-armv5.cpio.gz')
>=20
> Do our other acceptance tests download random third-party
> (ie "not a well-known distro") binaries for the tests ?
> It seems a bit hazardous for reproducability and trustability
> reasons...
>=20
> thanks
> -- PMM

A quick and dirty grep shows (excluding comments and docs):

   boot_linux_console.py:        kernel_url =3D ('https://archives.fedora=
project.org/pub/archive/fedora'
   boot_linux_console.py:        deb_url =3D ('http://snapshot.debian.org=
/archive/debian/'
   boot_linux_console.py:        deb_url =3D ('http://snapshot.debian.org=
/archive/debian/'
   boot_linux_console.py:        deb_url =3D ('http://snapshot.debian.org=
/archive/debian/'
   boot_linux_console.py:        initrd_url =3D ('https://github.com/groe=
ck/linux-build-test/raw/'
   boot_linux_console.py:        kernel_url =3D ('https://mipsdistros.mip=
s.com/LinuxDistro/nanomips/'
   boot_linux_console.py:        kernel_url =3D ('https://mipsdistros.mip=
s.com/LinuxDistro/nanomips/'
   boot_linux_console.py:        kernel_url =3D ('https://mipsdistros.mip=
s.com/LinuxDistro/nanomips/'
   boot_linux_console.py:        kernel_url =3D ('https://archives.fedora=
project.org/pub/archive/fedora'
   boot_linux_console.py:        kernel_url =3D ('https://archives.fedora=
project.org/pub/archive/fedora'
   boot_linux_console.py:        uboot_url =3D ('https://raw.githubuserco=
ntent.com/'
   boot_linux_console.py:        spi_url =3D ('https://raw.githubusercont=
ent.com/'
   boot_linux_console.py:        kernel_url =3D ('https://archives.fedora=
project.org/pub/archive'
   boot_linux_console.py:        kernel_url =3D ('http://archive.debian.o=
rg/debian/dists/lenny/main/'
   boot_linux_console.py:        kernel_url =3D ('https://archives.fedora=
project.org/pub/archive'
   linux_initrd.py:        kernel_url =3D ('https://archives.fedoraprojec=
t.org/pub/archive/fedora/li'
   linux_initrd.py:        kernel_url =3D ('https://archives.fedoraprojec=
t.org/pub/archive/fedora'
   linux_ssh_mips_malta.py:        'be': {'image_url': ('https://people.d=
ebian.org/~aurel32/qemu/mips/'
   linux_ssh_mips_malta.py:        'le': {'image_url': ('https://people.d=
ebian.org/~aurel32/qemu/mipsel/'
   linux_ssh_mips_malta.py:        kernel_url =3D ('https://people.debian=
.org/~aurel32/qemu/mips/'
   linux_ssh_mips_malta.py:        kernel_url =3D ('https://people.debian=
.org/~aurel32/qemu/mipsel/'
   linux_ssh_mips_malta.py:        kernel_url =3D ('https://people.debian=
.org/~aurel32/qemu/mips/'
   linux_ssh_mips_malta.py:        kernel_url =3D ('https://people.debian=
.org/~aurel32/qemu/mipsel/'
   machine_m68k_nextcube.py:        rom_url =3D ('http://www.nextcomputer=
s.org/NeXTfiles/Software/ROM_Files/'

I find it hard to judge precisely how much of a third-party some of
these are.  I remember Philippe mentioning that one of them, I guess
the images used on linux_ssh_mips_malta.py, were "as official as it
gets" (my words, from my often misleading memory).

Reproducibility is definitely an issue, in the sense given that some
of these can indeed go away, but as long as they're available the hash
recorded in the test should guarantee that we're running the same
images.

Do you think we should do something different here?

Thanks!
- Cleber.

