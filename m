Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE345C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 15:15:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C953E20842
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 15:15:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C953E20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6FxX-0003TR-0h
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 11:15:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36346)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1i6FwK-0002nA-IN
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 11:14:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1i6FwJ-0000o5-44
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 11:14:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33500)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1i6FwI-0000ns-Rh
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 11:14:19 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2A6C68980E3;
 Fri,  6 Sep 2019 15:14:18 +0000 (UTC)
Received: from localhost (ovpn-116-55.gru2.redhat.com [10.97.116.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8B5C760BF1;
 Fri,  6 Sep 2019 15:14:17 +0000 (UTC)
Date: Fri, 6 Sep 2019 12:14:15 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Cleber Rosa <crosa@redhat.com>
Message-ID: <20190906151415.GM4617@habkost.net>
References: <20190829013125.GG16342@umbus.fritz.box>
 <20190830175648.GE3694@habkost.net>
 <20190831014834.GC12065@umbus.fritz.box>
 <20190904195717.GA2311@localhost.localdomain>
 <20190905020924.GB2120@umbus.fritz.box>
 <20190905133824.GA12364@localhost.localdomain>
 <20190906003416.GA12820@umbus.fritz.box>
 <20190906144358.GK4617@habkost.net>
 <20190906145202.GA21925@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190906145202.GA21925@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Fri, 06 Sep 2019 15:14:18 +0000 (UTC)
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

On Fri, Sep 06, 2019 at 10:52:02AM -0400, Cleber Rosa wrote:
> On Fri, Sep 06, 2019 at 11:43:58AM -0300, Eduardo Habkost wrote:
> > On Fri, Sep 06, 2019 at 10:34:16AM +1000, David Gibson wrote:
> > > On Thu, Sep 05, 2019 at 09:38:24AM -0400, Cleber Rosa wrote:
> > > > On Thu, Sep 05, 2019 at 12:09:24PM +1000, David Gibson wrote:
> > > > > On Wed, Sep 04, 2019 at 03:57:17PM -0400, Cleber Rosa wrote:
> > > > > >=20
> > > > > > Hi David,
> > > > > >=20
> > > > > > I've pushed a branch here (most of the commits have already b=
een sent
> > > > > > separately):
> > > > > >=20
> > > > > >    https://github.com/clebergnu/qemu/tree/ppc64
> > > > > >=20
> > > > > > I've tested on a RHEL 8 ppc64le Power 9, and it seems to work=
 for me.
> > > > > > My steps for building QEMU:
> > > > > >=20
> > > > > >   - Configured with: '/home/cleber/src/qemu/configure' '--ena=
ble-slirp=3Dgit' '--python=3D/usr/bin/python3' '--target-list=3Dx86_64-so=
ftmmu,ppc64-softmmu,arm-softmmu,aarch64-softmmu,mips-softmmu,mipsel-softm=
mu,mips64-softmmu,mips64el-softmmu,sh4-softmmu,s390x-softmmu,alpha-softmm=
u,m68k-softmmu,riscv64-softmmu'
> > > > > >   - make
> > > > > >   - make check-acceptance
> > > > > >=20
> > > > > > Would you be able to test if that branch works smoothly for y=
ou?
> > > > >=20
> > > > > So, with this tree I'm no longer getting problems if openssl-de=
vel is
> > > > > not installed, so that much looks good.
> > > > >=20
> > > > > I am getting some different errors - I was seeing this before (=
with
> > > > > openssl-devel installed) sometimes, but only sometimes.  I have=
n't yet
> > > > > worked out a pattern for when they appeared.  They also don't a=
ppear
> > > > > to be fatal, the rest of the tests seem to be running ok.  Any =
ideas?
> > > > >=20
> > > > >  VENV    /home/dwg/qemu/build/rhel8/tests/venv
> > > > >   PIP     /home/dwg/qemu/tests/requirements.txt
> > > > >   AVOCADO tests/acceptance
> > > > > Error running method "run" of plugin "html": 'Namespace' object=
 has no attribute 'get'
> > > > > Error running method "run" of plugin "varianter_cit": 'Namespac=
e' object has no attribute 'get'
> > > >=20
> > > > Hi David,
> > > >=20
> > > > Yes, those should not be fatal.  Anyway, they are caused by two t=
hings:
> > > >=20
> > > >  1) A second set of Avocado plugins installation with different v=
ersions
> > > >     than the Avocado installation on QEMU's tests venv
> > >=20
> > > Ah!  That'll be from the Avocado setup that Luka=C5=A1 set up on th=
ere for
> > > some different tests.
> > >=20
> > > >  2) The tests' venv, which is created with "--system-site-package=
s",
> > > >     option that is described as "Give the virtual environment acc=
ess
> > > >     to the system site-packages dir."
> > > >=20
> > > > The motivation to have "--system-site-packages" is that, if the u=
ser
> > > > had any of the "requirements.txt" depedencies installed system wi=
de,
> > > > the venv would simply use it and skip downloads.  Maybe we should=
 make
> > > > that an optional feature, disabled by default, so that the test's=
 venv
> > > > is better isolated and more predictable by default.
> > >=20
> > > If pip doesn't have good enough version tracking that it's verifyin=
g
> > > the correct versions of the installed packages as well as the
> > > presence, then yes I tend to agree that keeping it better isolated
> > > would be preferable.
> >=20
> > pip ensures the right version of packages we request are
> > installed, but Avocado plugins are separate packages and we don't
> > tell pip anything about the plugins we are not using (but could be
> > already installed in the system).
>=20
> Right.
>=20
> >=20
> > Cleber, does Avocado have any kind of plugin API versioning, so
> > it could detect incompatible plugins before using them?
> >
>=20
> It does not.  And while making an exact version match requirement
> between plugins and core Avocado would be easy, it would put unfair
> (IMO) requirements on plugin writers.  It's quite possible that
> an external plugin would work for many different avocado versions,
> and the author wouldn't feel like updating it just to satisfy the
> version check.

I agree that tying a plugin to a specific Avocado version seems
too strict.  Are there any rules about API stability that plugin
writers can expect Avocado to follow?

>=20
> I'm not quite sure we should be trying to solve this problem here, but
> I'm open to suggestions.

This will probably become a minor problem once we stop using
--system-site-packages by default.

--=20
Eduardo

