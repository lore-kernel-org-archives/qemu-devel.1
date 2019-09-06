Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F066C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 14:52:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6488E206A5
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 14:52:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6488E206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6FbV-0002Q4-Jn
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 10:52:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58846)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1i6Far-00021b-Ef
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 10:52:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1i6Fap-0007N5-1l
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 10:52:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53607)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1i6Fao-0007MO-Q0
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 10:52:07 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 525A711A1A;
 Fri,  6 Sep 2019 14:52:05 +0000 (UTC)
Received: from localhost.localdomain (ovpn-121-64.rdu2.redhat.com
 [10.10.121.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 871915D9CA;
 Fri,  6 Sep 2019 14:52:04 +0000 (UTC)
Date: Fri, 6 Sep 2019 10:52:02 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190906145202.GA21925@localhost.localdomain>
References: <20190829013125.GG16342@umbus.fritz.box>
 <20190830175648.GE3694@habkost.net>
 <20190831014834.GC12065@umbus.fritz.box>
 <20190904195717.GA2311@localhost.localdomain>
 <20190905020924.GB2120@umbus.fritz.box>
 <20190905133824.GA12364@localhost.localdomain>
 <20190906003416.GA12820@umbus.fritz.box>
 <20190906144358.GK4617@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190906144358.GK4617@habkost.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Fri, 06 Sep 2019 14:52:05 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Cryptic errors from PIP install if missing
 openssl-devel
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
Cc: ldoktor@redhat.com, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 06, 2019 at 11:43:58AM -0300, Eduardo Habkost wrote:
> On Fri, Sep 06, 2019 at 10:34:16AM +1000, David Gibson wrote:
> > On Thu, Sep 05, 2019 at 09:38:24AM -0400, Cleber Rosa wrote:
> > > On Thu, Sep 05, 2019 at 12:09:24PM +1000, David Gibson wrote:
> > > > On Wed, Sep 04, 2019 at 03:57:17PM -0400, Cleber Rosa wrote:
> > > > >=20
> > > > > Hi David,
> > > > >=20
> > > > > I've pushed a branch here (most of the commits have already bee=
n sent
> > > > > separately):
> > > > >=20
> > > > >    https://github.com/clebergnu/qemu/tree/ppc64
> > > > >=20
> > > > > I've tested on a RHEL 8 ppc64le Power 9, and it seems to work f=
or me.
> > > > > My steps for building QEMU:
> > > > >=20
> > > > >   - Configured with: '/home/cleber/src/qemu/configure' '--enabl=
e-slirp=3Dgit' '--python=3D/usr/bin/python3' '--target-list=3Dx86_64-soft=
mmu,ppc64-softmmu,arm-softmmu,aarch64-softmmu,mips-softmmu,mipsel-softmmu=
,mips64-softmmu,mips64el-softmmu,sh4-softmmu,s390x-softmmu,alpha-softmmu,=
m68k-softmmu,riscv64-softmmu'
> > > > >   - make
> > > > >   - make check-acceptance
> > > > >=20
> > > > > Would you be able to test if that branch works smoothly for you=
?
> > > >=20
> > > > So, with this tree I'm no longer getting problems if openssl-deve=
l is
> > > > not installed, so that much looks good.
> > > >=20
> > > > I am getting some different errors - I was seeing this before (wi=
th
> > > > openssl-devel installed) sometimes, but only sometimes.  I haven'=
t yet
> > > > worked out a pattern for when they appeared.  They also don't app=
ear
> > > > to be fatal, the rest of the tests seem to be running ok.  Any id=
eas?
> > > >=20
> > > >  VENV    /home/dwg/qemu/build/rhel8/tests/venv
> > > >   PIP     /home/dwg/qemu/tests/requirements.txt
> > > >   AVOCADO tests/acceptance
> > > > Error running method "run" of plugin "html": 'Namespace' object h=
as no attribute 'get'
> > > > Error running method "run" of plugin "varianter_cit": 'Namespace'=
 object has no attribute 'get'
> > >=20
> > > Hi David,
> > >=20
> > > Yes, those should not be fatal.  Anyway, they are caused by two thi=
ngs:
> > >=20
> > >  1) A second set of Avocado plugins installation with different ver=
sions
> > >     than the Avocado installation on QEMU's tests venv
> >=20
> > Ah!  That'll be from the Avocado setup that Luka=C5=A1 set up on ther=
e for
> > some different tests.
> >=20
> > >  2) The tests' venv, which is created with "--system-site-packages"=
,
> > >     option that is described as "Give the virtual environment acces=
s
> > >     to the system site-packages dir."
> > >=20
> > > The motivation to have "--system-site-packages" is that, if the use=
r
> > > had any of the "requirements.txt" depedencies installed system wide=
,
> > > the venv would simply use it and skip downloads.  Maybe we should m=
ake
> > > that an optional feature, disabled by default, so that the test's v=
env
> > > is better isolated and more predictable by default.
> >=20
> > If pip doesn't have good enough version tracking that it's verifying
> > the correct versions of the installed packages as well as the
> > presence, then yes I tend to agree that keeping it better isolated
> > would be preferable.
>=20
> pip ensures the right version of packages we request are
> installed, but Avocado plugins are separate packages and we don't
> tell pip anything about the plugins we are not using (but could be
> already installed in the system).

Right.

>=20
> Cleber, does Avocado have any kind of plugin API versioning, so
> it could detect incompatible plugins before using them?
>

It does not.  And while making an exact version match requirement
between plugins and core Avocado would be easy, it would put unfair
(IMO) requirements on plugin writers.  It's quite possible that
an external plugin would work for many different avocado versions,
and the author wouldn't feel like updating it just to satisfy the
version check.

I'm not quite sure we should be trying to solve this problem here, but
I'm open to suggestions.

- Cleber.

> --=20
> Eduardo

