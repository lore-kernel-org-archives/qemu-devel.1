Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DADC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 09:32:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51C8520714
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 09:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P6mHB1Dh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51C8520714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSGfT-0001OG-7n
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 05:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kSGeN-0000wh-Jb
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 05:31:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34420)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kSGeI-00049o-Et
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 05:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602581473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Yh524C0ZhpVuh+IBMdGGVh5RO8cwo52m665gAU0Xbic=;
 b=P6mHB1DhtUEcOWKS+BkzMK7CzOoQiJKZHIt52t64vwFmNHj/NaxXBrpIztJxyU68EEH5PU
 eNAO8kZ08Pa96i2XLU9HPhegRNcWTjQR6+G8i91n6sxWAU+RsvpqD1Xr2VGSfY25ACa9lv
 KCbRqHuHo2pxCv4cvy4OhI5tocsfiRc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-30hGaTL8MiKWG_E2ahLh7w-1; Tue, 13 Oct 2020 05:31:10 -0400
X-MC-Unique: 30hGaTL8MiKWG_E2ahLh7w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0FA8187951B;
 Tue, 13 Oct 2020 09:31:08 +0000 (UTC)
Received: from localhost (ovpn-114-249.ams2.redhat.com [10.36.114.249])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 098496EF41;
 Tue, 13 Oct 2020 09:30:57 +0000 (UTC)
Date: Tue, 13 Oct 2020 10:30:56 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Felipe Franciosi <felipe@nutanix.com>
Subject: Re: [PATCH v4] introduce vfio-user protocol specification
Message-ID: <20201013093056.GA164611@stefanha-x1.localdomain>
References: <1594984851-59327-1-git-send-email-thanos.makatos@nutanix.com>
 <1600180157-74760-1-git-send-email-thanos.makatos@nutanix.com>
 <20200924082132.GJ62770@stefanha-x1.localdomain>
 <MW2PR02MB37232E78343B164C2405AC248B350@MW2PR02MB3723.namprd02.prod.outlook.com>
 <20200929103743.GB181609@stefanha-x1.localdomain>
 <2E6DF2C2-A3C3-404D-BB2E-B53B3555EB66@oracle.com>
 <20200930142408.GA320669@stefanha-x1.localdomain>
 <E0C4979F-157D-4ADC-9FCF-23A70FB6C931@nutanix.com>
MIME-Version: 1.0
In-Reply-To: <E0C4979F-157D-4ADC-9FCF-23A70FB6C931@nutanix.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 03:04:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: "benjamin.walker@intel.com" <benjamin.walker@intel.com>,
 John G Johnson <john.g.johnson@oracle.com>,
 "jag.raman@oracle.com" <jag.raman@oracle.com>,
 Swapnil Ingle <swapnil.ingle@nutanix.com>,
 "james.r.harris@intel.com" <james.r.harris@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "yuvalkashtan@gmail.com" <yuvalkashtan@gmail.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "elena.ufimtseva@oracle.com" <elena.ufimtseva@oracle.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "ismael@linux.com" <ismael@linux.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 "xiuchun.lu@intel.com" <xiuchun.lu@intel.com>,
 "tomassetti.andrea@gmail.com" <tomassetti.andrea@gmail.com>,
 "changpeng.liu@intel.com" <changpeng.liu@intel.com>,
 "tina.zhang@intel.com" <tina.zhang@intel.com>,
 "Kanth.Ghatraju@oracle.com" <Kanth.Ghatraju@oracle.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 02, 2020 at 10:14:23AM +0000, Felipe Franciosi wrote:
>=20
>=20
> > On Sep 30, 2020, at 3:24 PM, Stefan Hajnoczi <stefanha@redhat.com> wrot=
e:
> >=20
> > On Tue, Sep 29, 2020 at 09:21:54AM -0700, John G Johnson wrote:
> >>> On Sep 29, 2020, at 3:37 AM, Stefan Hajnoczi <stefanha@redhat.com> wr=
ote:
> >>>=20
> >>> On Mon, Sep 28, 2020 at 09:58:37AM +0000, Thanos Makatos wrote:
> >>>>> It should be accompanied by a test in tests/. PCI-level testing API=
S for
> >>>>> BARs, configuration space, interrupts, etc are available in
> >>>>> tests/qtest/libqos/pci.h. The test case needs to include a vfio-use=
r
> >>>>> device backend interact with QEMU's vfio-user-pci implementation.
> >>>>=20
> >>>> We plan to use a libmuser-based backend for testing. This, I suppose=
, will
> >>>> make libmuser a dependency of QEMU (either as a submodule or as a li=
brary),
> >>>> which for now can be disabled in the default configuration. Is this =
acceptable?
> >>>=20
> >>> If there are no other dependencies and libmuser supports all host
> >>> operating systems that QEMU's -device vfio-user supports, then I thin=
k
> >>> it's a good idea to use libmuser for at least one in-tree test in QEM=
U.
> >>>=20
> >>>>> Also please let us know who is working on what so additional people=
 can
> >>>>> get involved in areas that need work!
> >>>>=20
> >>>> Swapnil and I will be working on libmuser and the test in QEMU, John=
 and
> >>>> the mp-qemu folks will be working on the patches for implementing
> >>>> --device vfio-user-pci.
> >>>=20
> >>> Great!
> >>>=20
> >>> John: Will mpqemu use libmuser to implement the remote PCI host
> >>> controller?
> >>>=20
> >>=20
> >>=20
> >> =09The vfio-user-pci plan is to use libmuser on the server side.
> >=20
> > Okay. Using libmuser in tests seems like a good choice in that case.
> >=20
> > We'll need to figure out the details of how to do it because the
> > traditional shared library dependency approach is not well-suited to
> > in-development code. It would involve shipping libmuser distro packages
> > so QEMU's build system can declare a library dependency (with details
> > provided in a pkg-config file).
> >=20
> > Here are approaches that are better for in-development libraries:
> > 1. Keep the libmuser code in qemu.git.
> > 2. A copy of libmuser in qemu.git with changes being sent upstream
> >   (allows more flexibility in case QEMU-specific issues require
> >   experimentation).
> > 3. Git submodules.
> >=20
> > #1 if you're happy to use the QEMU development process for merging
> > libmuser code then it's easiest to officially host the code in qemu.git=
.
> > libmuser gets a subdirectory in the qemu.git tree and you (the
> > maintainers) send pull requests. A libmuser library build target
> > provides installable static and shared libraries so external
> > applications can link against libmuser too. The big advantage here is
> > that QEMU can instantly use the latest libmuser code changes.
>=20
> I think there's a couple of limitations here which we should keep in mind=
.
>=20
> 1. Does putting it in qemu.git precludes it being BSD-3?
> There's been evidence of people using (or at least trying out) muser
> from where it currently lives. That doesn't mean we can't move it, but
> I'm wondering if it means we have to make it GPL.

The 3-clause BSD license is compatible with the GPL according to
Wikipedia:
https://en.wikipedia.org/wiki/BSD_licenses

> 2. What about other projects that need libmuser code?
> What worries me more is projects like SPDK/DPDK wanting to link
> against the library and having to clone the entire QEMU repo as a
> submodule. That sounds a lot more expensive than option 3 and probably
> have further complications if they aren't GPL.

In the early stages where the vfio-user protocol and library interfaces
might need changes it will be hard to use it from multiple applications
without compatibility issues. If SPDK/DPDK are communicating with QEMU
using a cutting-edge library then they probably need to build QEMU from
source anyway. ISTR they also maintain a QEMU fork? So maybe it's not a
big issue for them.

> >=20
> > #2 works best if the library is a small (just a few source files) with
> > no fancy build system requirements.
>=20
> The risk here is that they go out of sync. There's the same (or even
> more) maintenance burden as point 3 below, with the added risk that
> someone could patch the files and make cherry-picks non-trivial.
>=20
> >=20
> > #3 is used in QEMU for several other components. Submodules are a pain
> > to sync (requires sending a qemu.git patch to move to a new commit ID),
> > so this isn't good for a dependency that moves quickly.
>=20
> I argue this is no worse than option 2. It's what I think aligns best,
> but let's keep weighing pros/cons and come to a conclusion together.
> The list of maintainers for muser.git should be extended to include
> more QEMU stakeholders and probably other projects that will use it
> (as) heavily. The topic has been raised in SPDK's Slack team on
> whether the client library should live in a repo of its own (eg.
> libvfio-user.git). Given the reference implementation is in libmuser,
> I still think muser.git is accurate (but can easily be persuaded
> otherwise).

Me too, no solution is perfect. My thoughts about developing it within
qemu.git for now is that this will make protocol and library interface
changes easy. It will also encourage applications (DPDK/SPDK) to build
against a matching QEMU so that there are no compatibility problems at
the protocol or library level while the code is still heavily under
development.

Stefan

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+Fc9AACgkQnKSrs4Gr
c8igrAgAxUWsy7wsd7Jw0N7MwRJWqRuyqHizqYW5IRuXmQ+mCssg9iTmo01hgsGM
/zpM11GCz2D17nWmQVH7QGNbIecm0ZZ2C6cxNXcRZUCBoQUWUt/iziYLJNS2IGqY
A24RaFaaNrgciMBrUjhKLSLW4CIt47yMxbGQdqzfVEn4cq+NOFu5yl1K4vsVIKtI
D+upgIBS30kVpM32GgaStVArf9PEs98k9rZJTbbbGQyzR8AnbIQeH+efqX+EGDY+
kXO9zRQ6AF1IZ4fKrMrbj0ELKzlWTptNwDSNXOvg21ecAKtSLjtLdFDATOoxmV2M
gZwmtTAvk7g/eiVk8ta7dop0inSXVg==
=+Nsv
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--


