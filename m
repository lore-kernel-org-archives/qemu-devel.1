Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A3EC4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 14:25:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA7AF20709
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 14:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CDZ5/TTX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA7AF20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNd2k-0000aT-Ll
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 10:25:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kNd25-0008EI-JT
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 10:24:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27740)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kNd23-0001NQ-8j
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 10:24:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601475874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NFV9VByxc4HJlDPbl6xpJg2XZPhWcjHEQGDNkCLLICQ=;
 b=CDZ5/TTXcRjJlZdrtwM+k7YgmRN2e18hE7Rp7D5GeEpJfcPK04saQ+/FHOz0tX15LOAzJX
 Zrwccd/bQbSkSptjJmJ3PKoqRAJ6iBlTRMuSwJqUlTDakzCvoY7TT7TqdXHMxC/zmhYneE
 w5lvdZanMg4uEqqJ1fJVLh8d4kyQM+A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-IvE3LDANMsmArR3ec6yOFg-1; Wed, 30 Sep 2020 10:24:22 -0400
X-MC-Unique: IvE3LDANMsmArR3ec6yOFg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 892B31DE08;
 Wed, 30 Sep 2020 14:24:18 +0000 (UTC)
Received: from localhost (ovpn-115-76.ams2.redhat.com [10.36.115.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6F7CE5D9D3;
 Wed, 30 Sep 2020 14:24:09 +0000 (UTC)
Date: Wed, 30 Sep 2020 15:24:08 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: John G Johnson <john.g.johnson@oracle.com>
Subject: Re: [PATCH v4] introduce vfio-user protocol specification
Message-ID: <20200930142408.GA320669@stefanha-x1.localdomain>
References: <1594984851-59327-1-git-send-email-thanos.makatos@nutanix.com>
 <1600180157-74760-1-git-send-email-thanos.makatos@nutanix.com>
 <20200924082132.GJ62770@stefanha-x1.localdomain>
 <MW2PR02MB37232E78343B164C2405AC248B350@MW2PR02MB3723.namprd02.prod.outlook.com>
 <20200929103743.GB181609@stefanha-x1.localdomain>
 <2E6DF2C2-A3C3-404D-BB2E-B53B3555EB66@oracle.com>
MIME-Version: 1.0
In-Reply-To: <2E6DF2C2-A3C3-404D-BB2E-B53B3555EB66@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
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
 "tomassetti.andrea@gmail.com" <tomassetti.andrea@gmail.com>,
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
 Felipe Franciosi <felipe@nutanix.com>,
 "xiuchun.lu@intel.com" <xiuchun.lu@intel.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 "changpeng.liu@intel.com" <changpeng.liu@intel.com>,
 "tina.zhang@intel.com" <tina.zhang@intel.com>,
 "Kanth.Ghatraju@oracle.com" <Kanth.Ghatraju@oracle.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2020 at 09:21:54AM -0700, John G Johnson wrote:
> > On Sep 29, 2020, at 3:37 AM, Stefan Hajnoczi <stefanha@redhat.com> wrot=
e:
> >=20
> > On Mon, Sep 28, 2020 at 09:58:37AM +0000, Thanos Makatos wrote:
> >>> It should be accompanied by a test in tests/. PCI-level testing APIS =
for
> >>> BARs, configuration space, interrupts, etc are available in
> >>> tests/qtest/libqos/pci.h. The test case needs to include a vfio-user
> >>> device backend interact with QEMU's vfio-user-pci implementation.
> >>=20
> >> We plan to use a libmuser-based backend for testing. This, I suppose, =
will
> >> make libmuser a dependency of QEMU (either as a submodule or as a libr=
ary),
> >> which for now can be disabled in the default configuration. Is this ac=
ceptable?
> >=20
> > If there are no other dependencies and libmuser supports all host
> > operating systems that QEMU's -device vfio-user supports, then I think
> > it's a good idea to use libmuser for at least one in-tree test in QEMU.
> >=20
> >>> Also please let us know who is working on what so additional people c=
an
> >>> get involved in areas that need work!
> >>=20
> >> Swapnil and I will be working on libmuser and the test in QEMU, John a=
nd
> >> the mp-qemu folks will be working on the patches for implementing
> >> --device vfio-user-pci.
> >=20
> > Great!
> >=20
> > John: Will mpqemu use libmuser to implement the remote PCI host
> > controller?
> >=20
>=20
>=20
> =09The vfio-user-pci plan is to use libmuser on the server side.

Okay. Using libmuser in tests seems like a good choice in that case.

We'll need to figure out the details of how to do it because the
traditional shared library dependency approach is not well-suited to
in-development code. It would involve shipping libmuser distro packages
so QEMU's build system can declare a library dependency (with details
provided in a pkg-config file).

Here are approaches that are better for in-development libraries:
1. Keep the libmuser code in qemu.git.
2. A copy of libmuser in qemu.git with changes being sent upstream
   (allows more flexibility in case QEMU-specific issues require
   experimentation).
3. Git submodules.

#1 if you're happy to use the QEMU development process for merging
libmuser code then it's easiest to officially host the code in qemu.git.
libmuser gets a subdirectory in the qemu.git tree and you (the
maintainers) send pull requests. A libmuser library build target
provides installable static and shared libraries so external
applications can link against libmuser too. The big advantage here is
that QEMU can instantly use the latest libmuser code changes.

#2 works best if the library is a small (just a few source files) with
no fancy build system requirements.

#3 is used in QEMU for several other components. Submodules are a pain
to sync (requires sending a qemu.git patch to move to a new commit ID),
so this isn't good for a dependency that moves quickly.

Stefan

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl90lQgACgkQnKSrs4Gr
c8gv5ggAjr/t3xoxhjL+rjZfoEzy4P0lfN3p5spstwdNYeh5WWpSLY7aRB0WDXxo
k3Xt2bu2OaVgtuqJBB0oCqVoMu9p7iUVYC1n+YV+5PZBH1qhszialLkrN7hL8r56
9HWbfSnvsWl1F/lK5rxrR5rx/D6umK+b6EIUUZv2PA/w6UcMtqrs5xDarY8h31DP
WM+ullE1T2Tf4y6uJSMrva05azIslsk2RIz+HAovBwyR6jscvUz6BAbenf55QoUL
5dwudCuxuME2kFW5KJlDOGaLLD7AzYA1bgBK7Zy/67EPOO1gkOq06Ff+2Fs9VjhT
SsN/1TV2FvqI9pQmXxa6K5w/vTfxbg==
=dEF2
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--


