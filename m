Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73589C49ED9
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 19:50:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4969D21479
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 19:50:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4969D21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7mAC-0002kn-Bt
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 15:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60965)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1i7m2i-0002lL-GL
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 15:43:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1i7m2f-0003W4-Rm
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 15:43:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48449)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1i7m2f-0003V5-KK
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 15:43:09 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 96C2A3172D87;
 Tue, 10 Sep 2019 19:43:07 +0000 (UTC)
Received: from localhost (ovpn-116-55.gru2.redhat.com [10.97.116.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E0F531001B07;
 Tue, 10 Sep 2019 19:43:01 +0000 (UTC)
Date: Tue, 10 Sep 2019 16:43:00 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Cleber Rosa <crosa@redhat.com>
Message-ID: <20190910194300.GD4617@habkost.net>
References: <20190904005218.12536-1-crosa@redhat.com>
 <20190910084120.GA8583@redhat.com>
 <20190910122924.GA22968@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190910122924.GA22968@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Tue, 10 Sep 2019 19:43:07 +0000 (UTC)
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

On Tue, Sep 10, 2019 at 08:29:24AM -0400, Cleber Rosa wrote:
> On Tue, Sep 10, 2019 at 09:41:20AM +0100, Daniel P. Berrang=E9 wrote:
> > On Tue, Sep 03, 2019 at 08:52:18PM -0400, Cleber Rosa wrote:
> > > The LinuxInitrd.test_with_2gib_file_should_work_with_linux_v4_16 te=
st,
> > > from tests/acceptance/linux_initrd.py, is currently failing to fetc=
h
> > > the "vmlinuz" file.  The reason for the failure is that the Fedora
> > > project retires older versions from the "dl.fedoraproject.org" URL,
> > > and keeps them in "archives.fedoraproject.org".  As an added note,
> > > that test uses a Fedora 28 image, because of the specific Linux ker=
nel
> > > version requirements of the test.
> > >=20
> > > For the sake of stability, let's use URLs from the archived and
> > > supposedely ever stable URLs.  The good news is that the currently
> > > supported versions are also hosted on the later.  This change limit=
s
> > > itself to change the URLs, while keeping the fetched files the same
> > > (as can be evidenced by the unchanged hashes).
> >=20
> > The download.fedoraproject.org site we're (mostly) currently using
> > is serviced by the Fedora mirrors which is very desirable as it
> > spreads the load.
> >=20
> > The archive.fedoraproject.org site is the master Fedora hosting
> > server(s). dl.fedoraproject.org is the same master hosting service
> > that is intended for use by the mirror sites to sync their content
> > from.  Projects really shouldn't use either of these URLs for getting
> > any content which is available via the mirror service as it places
> > uncessary load on the Fedora master servers.
> >=20
[...]
> > > @@ -360,8 +364,9 @@ class BootLinuxConsole(Test):
> > >          :avocado: tags=3Darch:ppc64
> > >          :avocado: tags=3Dmachine:pseries
> > >          """
> > > -        kernel_url =3D ('https://download.fedoraproject.org/pub/fe=
dora-secondary/'
> > > -                      'releases/29/Everything/ppc64le/os/ppc/ppc64=
/vmlinuz')
> > > +        kernel_url =3D ('https://archives.fedoraproject.org/pub/ar=
chive'
> > > +                      '/fedora-secondary/releases/29/Everything/pp=
c64le/os'
> > > +                      '/ppc/ppc64/vmlinuz')
> > >          kernel_hash =3D '3fe04abfc852b66653b8c3c897a59a689270bc77'
> > >          kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3D=
kernel_hash)
> >=20
> > Don't change these URLs. We can update to Fedora 30 though if you wan=
t
> > to.
> >=20
>=20
> I believe your suggestion to not change the URLs is based solely on you=
r
> perspective on the load on the "archives" server, right?
>=20
> You should know that there's a number of counter points.  One is that
> these tests are used on environments, which are maintained for a much
> longer time than the lifespan of the currently maintained Fedora
> versions.  We really need to make it stable and reliable, and IMO it
> should be done upstream, for the benefit of all.

We're trying to offload the costs of long term hosting for our
test cases to a third party (Fedora Project), but we need to know
if that's really acceptable usage of archives.fedoraproject.org.

--=20
Eduardo

