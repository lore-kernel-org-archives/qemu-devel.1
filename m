Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837B5C49ED6
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 12:31:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A76E208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 12:31:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A76E208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7fJB-00063S-07
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 08:31:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56918)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1i7fHA-0005SJ-6c
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 08:29:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1i7fH8-0006JI-81
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 08:29:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36324)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1i7fH7-0006In-WB
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 08:29:38 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 59A52C024AED;
 Tue, 10 Sep 2019 12:29:36 +0000 (UTC)
Received: from localhost.localdomain (ovpn-121-171.rdu2.redhat.com
 [10.10.121.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B1B35C224;
 Tue, 10 Sep 2019 12:29:26 +0000 (UTC)
Date: Tue, 10 Sep 2019 08:29:24 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Message-ID: <20190910122924.GA22968@localhost.localdomain>
References: <20190904005218.12536-1-crosa@redhat.com>
 <20190910084120.GA8583@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190910084120.GA8583@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Tue, 10 Sep 2019 12:29:36 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] Fedora images: use URLs from stable
 "archives.fedoraproject.org"
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
Cc: Yash Mankad <ymankad@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Fam Zheng <fam@euphon.net>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 10, 2019 at 09:41:20AM +0100, Daniel P. Berrang=E9 wrote:
> On Tue, Sep 03, 2019 at 08:52:18PM -0400, Cleber Rosa wrote:
> > The LinuxInitrd.test_with_2gib_file_should_work_with_linux_v4_16 test=
,
> > from tests/acceptance/linux_initrd.py, is currently failing to fetch
> > the "vmlinuz" file.  The reason for the failure is that the Fedora
> > project retires older versions from the "dl.fedoraproject.org" URL,
> > and keeps them in "archives.fedoraproject.org".  As an added note,
> > that test uses a Fedora 28 image, because of the specific Linux kerne=
l
> > version requirements of the test.
> >=20
> > For the sake of stability, let's use URLs from the archived and
> > supposedely ever stable URLs.  The good news is that the currently
> > supported versions are also hosted on the later.  This change limits
> > itself to change the URLs, while keeping the fetched files the same
> > (as can be evidenced by the unchanged hashes).
>=20
> The download.fedoraproject.org site we're (mostly) currently using
> is serviced by the Fedora mirrors which is very desirable as it
> spreads the load.
>=20
> The archive.fedoraproject.org site is the master Fedora hosting
> server(s). dl.fedoraproject.org is the same master hosting service
> that is intended for use by the mirror sites to sync their content
> from.  Projects really shouldn't use either of these URLs for getting
> any content which is available via the mirror service as it places
> uncessary load on the Fedora master servers.
>=20
> > Documentation and the "vm tests" fedora definition were also updated.
> >=20
> > Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > ---
> >  qemu-doc.texi                          |  6 +++---
> >  tests/acceptance/boot_linux_console.py | 25 +++++++++++++++---------=
-
> >  tests/acceptance/linux_initrd.py       |  5 +++--
> >  tests/vm/fedora                        |  2 +-
> >  4 files changed, 22 insertions(+), 16 deletions(-)
> >=20
> > diff --git a/qemu-doc.texi b/qemu-doc.texi
> > index 577d1e8376..37795f86fb 100644
> > --- a/qemu-doc.texi
> > +++ b/qemu-doc.texi
> > @@ -440,15 +440,15 @@ of <protocol>.
> > =20
> >  Example: boot from a remote Fedora 20 live ISO image
> >  @example
> > -qemu-system-x86_64 --drive media=3Dcdrom,file=3Dhttp://dl.fedoraproj=
ect.org/pub/fedora/linux/releases/20/Live/x86_64/Fedora-Live-Desktop-x86_=
64-20-1.iso,readonly
> > +qemu-system-x86_64 --drive media=3Dcdrom,file=3Dhttps://archives.fed=
oraproject.org/pub/archive/fedora/linux/releases/20/Live/x86_64/Fedora-Li=
ve-Desktop-x86_64-20-1.iso,readonly
> > =20
> > -qemu-system-x86_64 --drive media=3Dcdrom,file.driver=3Dhttp,file.url=
=3Dhttp://dl.fedoraproject.org/pub/fedora/linux/releases/20/Live/x86_64/F=
edora-Live-Desktop-x86_64-20-1.iso,readonly
> > +qemu-system-x86_64 --drive media=3Dcdrom,file.driver=3Dhttp,file.url=
=3Dhttp://archives.fedoraproject.org/pub/archive/fedora/linux/releases/20=
/Live/x86_64/Fedora-Live-Desktop-x86_64-20-1.iso,readonly
> >  @end example
> > =20
> >  Example: boot from a remote Fedora 20 cloud image using a local over=
lay for
> >  writes, copy-on-read, and a readahead of 64k
> >  @example
> > -qemu-img create -f qcow2 -o backing_file=3D'json:@{"file.driver":"ht=
tp",, "file.url":"https://dl.fedoraproject.org/pub/fedora/linux/releases/=
20/Images/x86_64/Fedora-x86_64-20-20131211.1-sda.qcow2",, "file.readahead=
":"64k"@}' /tmp/Fedora-x86_64-20-20131211.1-sda.qcow2
> > +qemu-img create -f qcow2 -o backing_file=3D'json:@{"file.driver":"ht=
tp",, "file.url":"http://archives.fedoraproject.org/pub/archive/fedora/li=
nux/releases/20/Images/x86_64/Fedora-x86_64-20-20131211.1-sda.qcow2",, "f=
ile.readahead":"64k"@}' /tmp/Fedora-x86_64-20-20131211.1-sda.qcow2
> > =20
> >  qemu-system-x86_64 -drive file=3D/tmp/Fedora-x86_64-20-20131211.1-sd=
a.qcow2,copy-on-read=3Don
> >  @end example
>=20
> Nothing quite says "cutting edge" like examples pointing to 5+ years ol=
d
> software. Or to put it another way, we should update this to point to a
> modern OS release. ie Fedora 30.
>

Hi Daniel,

You're right, we should, and that's an obvious next step.  I tried to
keep this patch within the context of fixing the test regressions, and
making the overall experience stable.

> These should also be changed to download instead of dl.
>

I disagree, specially here, and believe that we shouldn't use the
"archive" site.  Having documentation that is accurate and whose
examples can be reproduced without caveats is a nice usability
touch.

I understand your worries about the eventual load on the Fedora
server.  While I'm certainly not qualified to speak for the Fedora
project, it'd be natural that the project would eventually cope
with the additional load, if that's actually significant.

>=20
> > diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptanc=
e/boot_linux_console.py
> > index 2504ef0150..8a9a314ab4 100644
> > --- a/tests/acceptance/boot_linux_console.py
> > +++ b/tests/acceptance/boot_linux_console.py
> > @@ -76,8 +76,9 @@ class BootLinuxConsole(Test):
> >          :avocado: tags=3Darch:x86_64
> >          :avocado: tags=3Dmachine:pc
> >          """
> > -        kernel_url =3D ('https://download.fedoraproject.org/pub/fedo=
ra/linux/'
> > -                      'releases/29/Everything/x86_64/os/images/pxebo=
ot/vmlinuz')
> > +        kernel_url =3D ('https://archives.fedoraproject.org/pub/arch=
ive/fedora'
> > +                      '/linux/releases/29/Everything/x86_64/os/image=
s/pxeboot'
> > +                      '/vmlinuz')
> >          kernel_hash =3D '23bebd2680757891cf7adedb033532163a792495'
> >          kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dke=
rnel_hash)
> > =20
> > @@ -250,8 +251,9 @@ class BootLinuxConsole(Test):
> >          :avocado: tags=3Darch:aarch64
> >          :avocado: tags=3Dmachine:virt
> >          """
> > -        kernel_url =3D ('https://download.fedoraproject.org/pub/fedo=
ra/linux/'
> > -                      'releases/29/Everything/aarch64/os/images/pxeb=
oot/vmlinuz')
> > +        kernel_url =3D ('https://archives.fedoraproject.org/pub/arch=
ive/fedora'
> > +                      '/linux/releases/29/Everything/aarch64/os/imag=
es/pxeboot'
> > +                      '/vmlinuz')
> >          kernel_hash =3D '8c73e469fc6ea06a58dc83a628fc695b693b8493'
> >          kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dke=
rnel_hash)
> > =20
> > @@ -271,8 +273,9 @@ class BootLinuxConsole(Test):
> >          :avocado: tags=3Darch:arm
> >          :avocado: tags=3Dmachine:virt
> >          """
> > -        kernel_url =3D ('https://download.fedoraproject.org/pub/fedo=
ra/linux/'
> > -                      'releases/29/Everything/armhfp/os/images/pxebo=
ot/vmlinuz')
> > +        kernel_url =3D ('https://archives.fedoraproject.org/pub/arch=
ive/fedora'
> > +                      '/linux/releases/29/Everything/armhfp/os/image=
s/pxeboot'
> > +                      '/vmlinuz')
> >          kernel_hash =3D 'e9826d741b4fb04cadba8d4824d1ed3b7fb8b4d4'
> >          kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dke=
rnel_hash)
> > =20
> > @@ -318,8 +321,9 @@ class BootLinuxConsole(Test):
> >          :avocado: tags=3Darch:s390x
> >          :avocado: tags=3Dmachine:s390_ccw_virtio
> >          """
> > -        kernel_url =3D ('https://download.fedoraproject.org/pub/fedo=
ra-secondary/'
> > -                      'releases/29/Everything/s390x/os/images/kernel=
.img')
> > +        kernel_url =3D ('https://archives.fedoraproject.org/pub/arch=
ive'
> > +                      '/fedora-secondary/releases/29/Everything/s390=
x/os/images'
> > +                      '/kernel.img')
> >          kernel_hash =3D 'e8e8439103ef8053418ef062644ffd46a7919313'
> >          kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dke=
rnel_hash)
> > =20
> > @@ -360,8 +364,9 @@ class BootLinuxConsole(Test):
> >          :avocado: tags=3Darch:ppc64
> >          :avocado: tags=3Dmachine:pseries
> >          """
> > -        kernel_url =3D ('https://download.fedoraproject.org/pub/fedo=
ra-secondary/'
> > -                      'releases/29/Everything/ppc64le/os/ppc/ppc64/v=
mlinuz')
> > +        kernel_url =3D ('https://archives.fedoraproject.org/pub/arch=
ive'
> > +                      '/fedora-secondary/releases/29/Everything/ppc6=
4le/os'
> > +                      '/ppc/ppc64/vmlinuz')
> >          kernel_hash =3D '3fe04abfc852b66653b8c3c897a59a689270bc77'
> >          kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dke=
rnel_hash)
>=20
> Don't change these URLs. We can update to Fedora 30 though if you want
> to.
>=20

I believe your suggestion to not change the URLs is based solely on your
perspective on the load on the "archives" server, right?

You should know that there's a number of counter points.  One is that
these tests are used on environments, which are maintained for a much
longer time than the lifespan of the currently maintained Fedora
versions.  We really need to make it stable and reliable, and IMO it
should be done upstream, for the benefit of all.

Best,
- Cleber.

> > =20
> > diff --git a/tests/acceptance/linux_initrd.py b/tests/acceptance/linu=
x_initrd.py
> > index 23be5a63aa..c61d9826a4 100644
> > --- a/tests/acceptance/linux_initrd.py
> > +++ b/tests/acceptance/linux_initrd.py
> > @@ -54,8 +54,9 @@ class LinuxInitrd(Test):
> >          QEMU has supported up to 4 GiB initrd for recent kernel
> >          Expect guest can reach 'Unpacking initramfs...'
> >          """
> > -        kernel_url =3D ('https://mirrors.kernel.org/fedora/releases/=
28/'
> > -                      'Everything/x86_64/os/images/pxeboot/vmlinuz')
> > +        kernel_url =3D ('https://archives.fedoraproject.org/pub/arch=
ive/fedora'
> > +                      '/linux/releases/28/Everything/x86_64/os/image=
s/pxeboot/'
> > +                      'vmlinuz')
> >          kernel_hash =3D '238e083e114c48200f80d889f7e32eeb2793e02a'
> >          kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dke=
rnel_hash)
> >          max_size =3D 2 * (1024 ** 3) + 1
> > diff --git a/tests/vm/fedora b/tests/vm/fedora
> > index e8fa5bf0d2..7fec1479fb 100755
> > --- a/tests/vm/fedora
> > +++ b/tests/vm/fedora
> > @@ -23,7 +23,7 @@ class FedoraVM(basevm.BaseVM):
> >      name =3D "fedora"
> >      arch =3D "x86_64"
> > =20
> > -    base =3D "http://dl.fedoraproject.org/pub/fedora/linux/releases/=
30/"
> > +    base =3D "https://archives.fedoraproject.org/pub/archive/fedora/=
linux/releases/30/"
> >      link =3D base + "Server/x86_64/iso/Fedora-Server-netinst-x86_64-=
30-1.2.iso"
> >      repo =3D base + "Server/x86_64/os/"
> >      full =3D base + "Everything/x86_64/os/"
>=20
> This should be changed to download instead of dl.
>=20
> > --=20
> > 2.21.0
> >=20
> >=20
>=20
> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|

