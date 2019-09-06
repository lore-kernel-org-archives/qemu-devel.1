Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838D8C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 15:33:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BB4820838
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 15:33:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BB4820838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6GEg-0001C8-H5
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 11:33:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41910)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1i6GBf-0007n1-AE
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 11:31:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1i6GBJ-0001qH-9r
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 11:30:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58206)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1i6GBI-0001go-5r
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 11:29:48 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 537AC883823;
 Fri,  6 Sep 2019 15:29:43 +0000 (UTC)
Received: from localhost.localdomain (ovpn-121-64.rdu2.redhat.com
 [10.10.121.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A2495C22C;
 Fri,  6 Sep 2019 15:29:42 +0000 (UTC)
Date: Fri, 6 Sep 2019 11:29:40 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190906152940.GA24347@localhost.localdomain>
References: <20190829013125.GG16342@umbus.fritz.box>
 <20190830175648.GE3694@habkost.net>
 <20190831014834.GC12065@umbus.fritz.box>
 <20190904195717.GA2311@localhost.localdomain>
 <20190905020924.GB2120@umbus.fritz.box>
 <20190905133824.GA12364@localhost.localdomain>
 <20190906003416.GA12820@umbus.fritz.box>
 <20190906144358.GK4617@habkost.net>
 <20190906145202.GA21925@localhost.localdomain>
 <20190906151415.GM4617@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190906151415.GM4617@habkost.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Fri, 06 Sep 2019 15:29:43 +0000 (UTC)
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

On Fri, Sep 06, 2019 at 12:14:15PM -0300, Eduardo Habkost wrote:
> On Fri, Sep 06, 2019 at 10:52:02AM -0400, Cleber Rosa wrote:
> > On Fri, Sep 06, 2019 at 11:43:58AM -0300, Eduardo Habkost wrote:
> > > On Fri, Sep 06, 2019 at 10:34:16AM +1000, David Gibson wrote:
> > > > On Thu, Sep 05, 2019 at 09:38:24AM -0400, Cleber Rosa wrote:
> > > > > On Thu, Sep 05, 2019 at 12:09:24PM +1000, David Gibson wrote:
> > > > > > On Wed, Sep 04, 2019 at 03:57:17PM -0400, Cleber Rosa wrote:
> > > > > > >=20
> > > > > > > Hi David,
> > > > > > >=20
> > > > > > > I've pushed a branch here (most of the commits have already=
 been sent
> > > > > > > separately):
> > > > > > >=20
> > > > > > >    https://github.com/clebergnu/qemu/tree/ppc64
> > > > > > >=20
> > > > > > > I've tested on a RHEL 8 ppc64le Power 9, and it seems to wo=
rk for me.
> > > > > > > My steps for building QEMU:
> > > > > > >=20
> > > > > > >   - Configured with: '/home/cleber/src/qemu/configure' '--e=
nable-slirp=3Dgit' '--python=3D/usr/bin/python3' '--target-list=3Dx86_64-=
softmmu,ppc64-softmmu,arm-softmmu,aarch64-softmmu,mips-softmmu,mipsel-sof=
tmmu,mips64-softmmu,mips64el-softmmu,sh4-softmmu,s390x-softmmu,alpha-soft=
mmu,m68k-softmmu,riscv64-softmmu'
> > > > > > >   - make
> > > > > > >   - make check-acceptance
> > > > > > >=20
> > > > > > > Would you be able to test if that branch works smoothly for=
 you?
> > > > > >=20
> > > > > > So, with this tree I'm no longer getting problems if openssl-=
devel is
> > > > > > not installed, so that much looks good.
> > > > > >=20
> > > > > > I am getting some different errors - I was seeing this before=
 (with
> > > > > > openssl-devel installed) sometimes, but only sometimes.  I ha=
ven't yet
> > > > > > worked out a pattern for when they appeared.  They also don't=
 appear
> > > > > > to be fatal, the rest of the tests seem to be running ok.  An=
y ideas?
> > > > > >=20
> > > > > >  VENV    /home/dwg/qemu/build/rhel8/tests/venv
> > > > > >   PIP     /home/dwg/qemu/tests/requirements.txt
> > > > > >   AVOCADO tests/acceptance
> > > > > > Error running method "run" of plugin "html": 'Namespace' obje=
ct has no attribute 'get'
> > > > > > Error running method "run" of plugin "varianter_cit": 'Namesp=
ace' object has no attribute 'get'
> > > > >=20
> > > > > Hi David,
> > > > >=20
> > > > > Yes, those should not be fatal.  Anyway, they are caused by two=
 things:
> > > > >=20
> > > > >  1) A second set of Avocado plugins installation with different=
 versions
> > > > >     than the Avocado installation on QEMU's tests venv
> > > >=20
> > > > Ah!  That'll be from the Avocado setup that Luka=C5=A1 set up on =
there for
> > > > some different tests.
> > > >=20
> > > > >  2) The tests' venv, which is created with "--system-site-packa=
ges",
> > > > >     option that is described as "Give the virtual environment a=
ccess
> > > > >     to the system site-packages dir."
> > > > >=20
> > > > > The motivation to have "--system-site-packages" is that, if the=
 user
> > > > > had any of the "requirements.txt" depedencies installed system =
wide,
> > > > > the venv would simply use it and skip downloads.  Maybe we shou=
ld make
> > > > > that an optional feature, disabled by default, so that the test=
's venv
> > > > > is better isolated and more predictable by default.
> > > >=20
> > > > If pip doesn't have good enough version tracking that it's verify=
ing
> > > > the correct versions of the installed packages as well as the
> > > > presence, then yes I tend to agree that keeping it better isolate=
d
> > > > would be preferable.
> > >=20
> > > pip ensures the right version of packages we request are
> > > installed, but Avocado plugins are separate packages and we don't
> > > tell pip anything about the plugins we are not using (but could be
> > > already installed in the system).
> >=20
> > Right.
> >=20
> > >=20
> > > Cleber, does Avocado have any kind of plugin API versioning, so
> > > it could detect incompatible plugins before using them?
> > >
> >=20
> > It does not.  And while making an exact version match requirement
> > between plugins and core Avocado would be easy, it would put unfair
> > (IMO) requirements on plugin writers.  It's quite possible that
> > an external plugin would work for many different avocado versions,
> > and the author wouldn't feel like updating it just to satisfy the
> > version check.
>=20
> I agree that tying a plugin to a specific Avocado version seems
> too strict.  Are there any rules about API stability that plugin
> writers can expect Avocado to follow?
>

TBH the plugin interfaces[1] are quite stable (have changed very
little), but:

 1) They're still part of the "avocado.core" namespace, which means
    the stability is a best effort, and not a promise/guarantee

 2) Most plugins make use of other "avocado.core" modules, which
    follow the same logic as #1

It's a known fact that it'd be good to have a supportable plugin
API[2], but we haven't had the resources to implement that.

> >=20
> > I'm not quite sure we should be trying to solve this problem here, bu=
t
> > I'm open to suggestions.
>=20
> This will probably become a minor problem once we stop using
> --system-site-packages by default.
>

Exactly, I think at this moment, this is the simple and best course of
action.

> --=20
> Eduardo


Thanks,
- Cleber.

[1] - https://github.com/avocado-framework/avocado/blob/master/avocado/co=
re/plugin_interfaces.py
[2] - https://trello.com/c/rKIfx7rY/1285-create-a-sufficient-and-supporta=
ble-plugin-api

