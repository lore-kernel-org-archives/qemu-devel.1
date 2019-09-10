Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C15C49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 20:18:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E878E2084D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 20:18:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E878E2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7mae-0006lH-Vo
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 16:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38283)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1i7mZa-000692-7c
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 16:17:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1i7mZX-0001vl-OU
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 16:17:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47542)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1i7mZX-0001vZ-HD
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 16:17:07 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 962011918642;
 Tue, 10 Sep 2019 20:17:06 +0000 (UTC)
Received: from localhost.localdomain (ovpn-121-171.rdu2.redhat.com
 [10.10.121.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8EA126012A;
 Tue, 10 Sep 2019 20:17:00 +0000 (UTC)
Date: Tue, 10 Sep 2019 16:16:58 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190910201658.GB4659@localhost.localdomain>
References: <20190904005218.12536-1-crosa@redhat.com>
 <20190910084120.GA8583@redhat.com>
 <20190910122924.GA22968@localhost.localdomain>
 <20190910194300.GD4617@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190910194300.GD4617@habkost.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Tue, 10 Sep 2019 20:17:06 +0000 (UTC)
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
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Fam Zheng <fam@euphon.net>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 10, 2019 at 04:43:00PM -0300, Eduardo Habkost wrote:
> On Tue, Sep 10, 2019 at 08:29:24AM -0400, Cleber Rosa wrote:
> > On Tue, Sep 10, 2019 at 09:41:20AM +0100, Daniel P. Berrang=E9 wrote:
> > > On Tue, Sep 03, 2019 at 08:52:18PM -0400, Cleber Rosa wrote:
> > > > The LinuxInitrd.test_with_2gib_file_should_work_with_linux_v4_16 =
test,
> > > > from tests/acceptance/linux_initrd.py, is currently failing to fe=
tch
> > > > the "vmlinuz" file.  The reason for the failure is that the Fedor=
a
> > > > project retires older versions from the "dl.fedoraproject.org" UR=
L,
> > > > and keeps them in "archives.fedoraproject.org".  As an added note=
,
> > > > that test uses a Fedora 28 image, because of the specific Linux k=
ernel
> > > > version requirements of the test.
> > > >=20
> > > > For the sake of stability, let's use URLs from the archived and
> > > > supposedely ever stable URLs.  The good news is that the currentl=
y
> > > > supported versions are also hosted on the later.  This change lim=
its
> > > > itself to change the URLs, while keeping the fetched files the sa=
me
> > > > (as can be evidenced by the unchanged hashes).
> > >=20
> > > The download.fedoraproject.org site we're (mostly) currently using
> > > is serviced by the Fedora mirrors which is very desirable as it
> > > spreads the load.
> > >=20
> > > The archive.fedoraproject.org site is the master Fedora hosting
> > > server(s). dl.fedoraproject.org is the same master hosting service
> > > that is intended for use by the mirror sites to sync their content
> > > from.  Projects really shouldn't use either of these URLs for getti=
ng
> > > any content which is available via the mirror service as it places
> > > uncessary load on the Fedora master servers.
> > >=20
> [...]
> > > > @@ -360,8 +364,9 @@ class BootLinuxConsole(Test):
> > > >          :avocado: tags=3Darch:ppc64
> > > >          :avocado: tags=3Dmachine:pseries
> > > >          """
> > > > -        kernel_url =3D ('https://download.fedoraproject.org/pub/=
fedora-secondary/'
> > > > -                      'releases/29/Everything/ppc64le/os/ppc/ppc=
64/vmlinuz')
> > > > +        kernel_url =3D ('https://archives.fedoraproject.org/pub/=
archive'
> > > > +                      '/fedora-secondary/releases/29/Everything/=
ppc64le/os'
> > > > +                      '/ppc/ppc64/vmlinuz')
> > > >          kernel_hash =3D '3fe04abfc852b66653b8c3c897a59a689270bc7=
7'
> > > >          kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3D=
kernel_hash)
> > >=20
> > > Don't change these URLs. We can update to Fedora 30 though if you w=
ant
> > > to.
> > >=20
> >=20
> > I believe your suggestion to not change the URLs is based solely on y=
our
> > perspective on the load on the "archives" server, right?
> >=20
> > You should know that there's a number of counter points.  One is that
> > these tests are used on environments, which are maintained for a much
> > longer time than the lifespan of the currently maintained Fedora
> > versions.  We really need to make it stable and reliable, and IMO it
> > should be done upstream, for the benefit of all.
>=20
> We're trying to offload the costs of long term hosting for our
> test cases to a third party (Fedora Project), but we need to know
> if that's really acceptable usage of archives.fedoraproject.org.
>=20
> --=20
> Eduardo

I'd argue that we're boosting archives.fedoraproject.org morale.  As a
public Internet service, it begs to better be used! :)

Now, more seriously, I agree that we should coordinate with them.  I
have the feeling that it shouldn't be a problem of resources per se,
given that we're redirecting traffic.  But, it may be a matter of
letting them better allocate these resources.

Daniel,

You seem to have some much better than average knowledge about the
mirror structure.  Does that mean you know who to contact about this?

Thanks,
- Cleber.

