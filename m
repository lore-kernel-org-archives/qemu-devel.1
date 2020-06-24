Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D0BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 10:52:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4140C2084D
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 10:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eqdHKw+B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4140C2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo30r-0002Yz-GB
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 06:52:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jo2xz-0006dF-QB
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:49:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43961
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jo2xn-0000Zp-RF
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:49:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592995746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jvqJPzu/LjlOyN+4aotLP3YokzViKa9HTg5lA4uRfWQ=;
 b=eqdHKw+BgnfZe2SFapVYayLZzE6sMKuNKhbW1oraPUyh3RVb4xz09LO0uZh1c9We4VL1DG
 gwYl0VggGQhWTgWONhmuNk9XDmTWu5rsc75pTr+oeOcrQR6ENMk3k9G41ubgAmMEir98LT
 zhMyUH0kxmpLMuOz0iddqxKIFi/kYKU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-eczIvCruPPi2ECVUidIOVw-1; Wed, 24 Jun 2020 06:49:04 -0400
X-MC-Unique: eczIvCruPPi2ECVUidIOVw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2AB710059A8;
 Wed, 24 Jun 2020 10:49:03 +0000 (UTC)
Received: from localhost (ovpn-114-150.ams2.redhat.com [10.36.114.150])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 78B1E3829;
 Wed, 24 Jun 2020 10:49:03 +0000 (UTC)
Date: Wed, 24 Jun 2020 11:49:02 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Coiby Xu <coiby.xu@gmail.com>
Subject: Re: [PATCH v9 5/5] new qTest case to test the vhost-user-blk-server
Message-ID: <20200624104902.GD59015@stefanha-x1.localdomain>
References: <20200614183907.514282-1-coiby.xu@gmail.com>
 <20200614183907.514282-6-coiby.xu@gmail.com>
 <20200618151751.GD1956319@stefanha-x1.localdomain>
 <20200624043510.ydzwuyr325ncgnxr@Rk>
MIME-Version: 1.0
In-Reply-To: <20200624043510.ydzwuyr325ncgnxr@Rk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="F8dlzb82+Fcn6AgP"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 03:27:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, bharatlkmlkvm@gmail.com,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--F8dlzb82+Fcn6AgP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2020 at 12:35:10PM +0800, Coiby Xu wrote:
> On Thu, Jun 18, 2020 at 04:17:51PM +0100, Stefan Hajnoczi wrote:
> > On Mon, Jun 15, 2020 at 02:39:07AM +0800, Coiby Xu wrote:
> > > This test case has the same tests as tests/virtio-blk-test.c except f=
or
> > > tests have block_resize. Since vhost-user server can only server one
> > > client one time, two instances of qemu-storage-daemon are launched
> > > for the hotplug test.
> > >=20
> > > In order to not block scripts/tap-driver.pl, vhost-user-blk-server wi=
ll
> > > send "quit" command to qemu-storage-daemon's QMP monitor. So a functi=
on
> > > is added to libqtest.c to establish socket connection with socket
> > > server.
> > >=20
> > > Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
> > > ---
> > >  tests/Makefile.include              |   3 +-
> > >  tests/qtest/Makefile.include        |   2 +
> > >  tests/qtest/libqos/vhost-user-blk.c | 130 +++++
> > >  tests/qtest/libqos/vhost-user-blk.h |  48 ++
> > >  tests/qtest/libqtest.c              |  35 +-
> > >  tests/qtest/libqtest.h              |  17 +
> > >  tests/qtest/vhost-user-blk-test.c   | 739 ++++++++++++++++++++++++++=
++
> > >  7 files changed, 971 insertions(+), 3 deletions(-)
> > >  create mode 100644 tests/qtest/libqos/vhost-user-blk.c
> > >  create mode 100644 tests/qtest/libqos/vhost-user-blk.h
> > >  create mode 100644 tests/qtest/vhost-user-blk-test.c
> >=20
> > This test case fails for me:
> >=20
> > qemu-system-x86_64: Failed to read from slave.
> > qemu-system-x86_64: Failed to set msg fds.
> > qemu-system-x86_64: vhost VQ 0 ring restore failed: -1: Success (0)
> > qemu-system-x86_64: Failed to read from slave.
> > qemu-system-x86_64: Failed to read from slave.
> > qemu-system-x86_64: Failed to read from slave.
> > qemu-system-x86_64: Failed to set msg fds.
> > qemu-system-x86_64: vhost VQ 0 ring restore failed: -1: Success (0)
> > qemu-system-x86_64: Failed to read msg header. Read -1 instead of 12. O=
riginal request 11.
> > qemu-system-x86_64: vhost VQ 0 ring restore failed: -1: Input/output er=
ror (5)
> >=20
> > Does "make -j4 check" pass for you?
>=20
> Actually it's a success since it won't fail CI. The reason for the
> occurrence of these dubious messages is after finishing the tests,
> vhost-user-blk-server is stopped before qemu-system-x86_64 is destroyed.
> I'll see if I can find a way to kill qemu-system-x86_64 first.

Maybe I didn't even notice whether it was passing or failing and just
got scared by these messages! :)

Thanks for explaining. It would be good to terminate cleanly to avoid
confusing users.

Stefan

--F8dlzb82+Fcn6AgP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7zL54ACgkQnKSrs4Gr
c8ht8wf+Mnrt/CIO7g98P1uPo3JQHc7wisLIH9FuO4u5Vwgy05lAvXVw+Lwa0Bld
74l9dApAVGUV3O+Ki/4VphYw1vQaOI1sI3FLFfEgFe9U/eV+/srdt47SlC+8nd0I
/l+7LHhGfjvQmQ1dorrY9feC+arIPlvYS6XGqEHH/lkGt8pmZJ5fDt382GZHb9Ku
x5z/3YHC4N9sKGrCB+nskMOsaTfuJ0LReRsicadq1kJO6GThVB1eojH7QDpSLBn5
Vow5r41fxJw27EQ4dlGUhVQGsbCBQJmGbx7NZZ68GEUTN0bTvD0B+RQTDRZSq1hs
IA4gWDPEp0qYjeAb5cA/kbBi3Uw0ZA==
=RTqz
-----END PGP SIGNATURE-----

--F8dlzb82+Fcn6AgP--


