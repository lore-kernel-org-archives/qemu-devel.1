Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758B6C5ACAE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 15:42:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C1A62085B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 15:42:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C1A62085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i84l1-00034u-Ck
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 11:42:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54186)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i84Rs-0002aT-1d
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 11:22:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i84Rm-00072N-JJ
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 11:22:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46462)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1i84Rm-00071O-BQ
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 11:22:18 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 579381DB1;
 Wed, 11 Sep 2019 15:22:16 +0000 (UTC)
Received: from redhat.com (unknown [10.42.17.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 001FC60C57;
 Wed, 11 Sep 2019 15:22:06 +0000 (UTC)
Date: Wed, 11 Sep 2019 16:22:04 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Cleber Rosa <crosa@redhat.com>
Message-ID: <20190911152204.GF24295@redhat.com>
References: <20190904005218.12536-1-crosa@redhat.com>
 <20190910084120.GA8583@redhat.com>
 <20190910122924.GA22968@localhost.localdomain>
 <20190910194300.GD4617@habkost.net>
 <20190910201658.GB4659@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190910201658.GB4659@localhost.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Wed, 11 Sep 2019 15:22:16 +0000 (UTC)
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Yash Mankad <ymankad@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Fam Zheng <fam@euphon.net>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 10, 2019 at 04:16:58PM -0400, Cleber Rosa wrote:
> On Tue, Sep 10, 2019 at 04:43:00PM -0300, Eduardo Habkost wrote:
> > On Tue, Sep 10, 2019 at 08:29:24AM -0400, Cleber Rosa wrote:
> > > On Tue, Sep 10, 2019 at 09:41:20AM +0100, Daniel P. Berrang=C3=A9 w=
rote:
> > > > On Tue, Sep 03, 2019 at 08:52:18PM -0400, Cleber Rosa wrote:
> > > > > The LinuxInitrd.test_with_2gib_file_should_work_with_linux_v4_1=
6 test,
> > > > > from tests/acceptance/linux_initrd.py, is currently failing to =
fetch
> > > > > the "vmlinuz" file.  The reason for the failure is that the Fed=
ora
> > > > > project retires older versions from the "dl.fedoraproject.org" =
URL,
> > > > > and keeps them in "archives.fedoraproject.org".  As an added no=
te,
> > > > > that test uses a Fedora 28 image, because of the specific Linux=
 kernel
> > > > > version requirements of the test.
> > > > >=20
> > > > > For the sake of stability, let's use URLs from the archived and
> > > > > supposedely ever stable URLs.  The good news is that the curren=
tly
> > > > > supported versions are also hosted on the later.  This change l=
imits
> > > > > itself to change the URLs, while keeping the fetched files the =
same
> > > > > (as can be evidenced by the unchanged hashes).
> > > >=20
> > > > The download.fedoraproject.org site we're (mostly) currently usin=
g
> > > > is serviced by the Fedora mirrors which is very desirable as it
> > > > spreads the load.
> > > >=20
> > > > The archive.fedoraproject.org site is the master Fedora hosting
> > > > server(s). dl.fedoraproject.org is the same master hosting servic=
e
> > > > that is intended for use by the mirror sites to sync their conten=
t
> > > > from.  Projects really shouldn't use either of these URLs for get=
ting
> > > > any content which is available via the mirror service as it place=
s
> > > > uncessary load on the Fedora master servers.
> > > >=20
> > [...]
> > > > > @@ -360,8 +364,9 @@ class BootLinuxConsole(Test):
> > > > >          :avocado: tags=3Darch:ppc64
> > > > >          :avocado: tags=3Dmachine:pseries
> > > > >          """
> > > > > -        kernel_url =3D ('https://download.fedoraproject.org/pu=
b/fedora-secondary/'
> > > > > -                      'releases/29/Everything/ppc64le/os/ppc/p=
pc64/vmlinuz')
> > > > > +        kernel_url =3D ('https://archives.fedoraproject.org/pu=
b/archive'
> > > > > +                      '/fedora-secondary/releases/29/Everythin=
g/ppc64le/os'
> > > > > +                      '/ppc/ppc64/vmlinuz')
> > > > >          kernel_hash =3D '3fe04abfc852b66653b8c3c897a59a689270b=
c77'
> > > > >          kernel_path =3D self.fetch_asset(kernel_url, asset_has=
h=3Dkernel_hash)
> > > >=20
> > > > Don't change these URLs. We can update to Fedora 30 though if you=
 want
> > > > to.
> > > >=20
> > >=20
> > > I believe your suggestion to not change the URLs is based solely on=
 your
> > > perspective on the load on the "archives" server, right?
> > >=20
> > > You should know that there's a number of counter points.  One is th=
at
> > > these tests are used on environments, which are maintained for a mu=
ch
> > > longer time than the lifespan of the currently maintained Fedora
> > > versions.  We really need to make it stable and reliable, and IMO i=
t
> > > should be done upstream, for the benefit of all.
> >=20
> > We're trying to offload the costs of long term hosting for our
> > test cases to a third party (Fedora Project), but we need to know
> > if that's really acceptable usage of archives.fedoraproject.org.
> >=20
> > --=20
> > Eduardo
>=20
> I'd argue that we're boosting archives.fedoraproject.org morale.  As a
> public Internet service, it begs to better be used! :)

Not really, in general we want users to keep updated with latest
supported Fedora releases and not use EOL versions from archive.=20
The critical reason for archives.fp.org to exist is license,
beyond that its largely just a historical record, but we digress
off topic here...

> Now, more seriously, I agree that we should coordinate with them.  I
> have the feeling that it shouldn't be a problem of resources per se,
> given that we're redirecting traffic.  But, it may be a matter of
> letting them better allocate these resources.
>=20
> Daniel,
>=20
> You seem to have some much better than average knowledge about the
> mirror structure.  Does that mean you know who to contact about this?

I spoke with some folks I know who didn't have an answer on the impact
or policy around using archive.fp.org, but did point out that there's
a way to avoid breaking

The Fedora mirror manager software provides a URL to query what
sites currently host a given version

eg to find Fedora 16 for x86_64 fetch this

  https://mirrors.fedoraproject.org/mirrorlist?repo=3Dfedora-16&arch=3Dx8=
6_64

whereupon it reports something like this:

# repo =3D fedora-16 arch =3D x86_64 country =3D DK country =3D DE countr=
y =3D UA country =3D global=20
https://mirrors.dotsrc.org/fedora-buffet/archive/fedora/linux/releases/16=
/Everything/x86_64/os/
https://fedora-archive.ip-connect.info/fedora/linux/releases/16/Everythin=
g/x86_64/os/
https://ftp-stud.hs-esslingen.de/pub/Mirrors/archive.fedoraproject.org/fe=
dora/linux/releases/16/Everything/x86_64/os/
https://fedora-archive.ip-connect.vn.ua/fedora/linux/releases/16/Everythi=
ng/x86_64/os/
http://ftp.cuhk.edu.hk/pub/linux/fedora-archive/fedora/linux/releases/16/=
Everything/x86_64/os/
http://fedora-archive.mirror.liquidtelecom.com/archive/fedora/linux/relea=
ses/16/Everything/x86_64/os/
http://mirrors.kernel.org/fedora-buffet/archive/fedora/linux/releases/16/=
Everything/x86_64/os/
http://mirror.math.princeton.edu/pub/fedora-archive/fedora/linux/releases=
/16/Everything/x86_64/os/
https://pubmirror2.math.uh.edu/fedora-buffet/archive/fedora/linux/release=
s/16/Everything/x86_64/os/
https://pubmirror1.math.uh.edu/fedora-buffet/archive/fedora/linux/release=
s/16/Everything/x86_64/os/
https://dl.fedoraproject.org/pub/archive/fedora/linux/releases/16/Everyth=
ing/x86_64/os/

any one of those returned URLs should serve the content we want. It is
interesting to see that there's several mirrors still carrying ancient
software, despite 'download.fp.org' returning 404

Admittedly this extra redirection is a bit more tedious for the test
suite, but we could hide that behind a common helper function.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

