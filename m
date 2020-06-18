Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E73EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 15:19:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47A40206F7
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 15:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bCr2fNI8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47A40206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlwJx-0003qy-Eg
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 11:19:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jlwIm-0003Hn-Up
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 11:18:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30581
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jlwIi-0003VR-1L
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 11:18:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592493478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JPO3qS+/og5kLrVA2H4Tl/XJ4llfK4U+EDV83lE46rw=;
 b=bCr2fNI8up9CDHkRIRGE6Q8Hzu+YVEvWpyh6ZWCpDh9lT06zbeUyxdQ64LAtOExevc+OQa
 H9CDISEovKUjzvPjDE+8PteqSA2ogmwh5JjMQGUvIH3xcaOSVhoJdmQebAECtvogyotxVb
 SPLgP/K83jWh4UzMq/Cpvn08yyWnVeM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-PBzEepRrNgmTyPm6NjaQSA-1; Thu, 18 Jun 2020 11:17:54 -0400
X-MC-Unique: PBzEepRrNgmTyPm6NjaQSA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F10BC1030981;
 Thu, 18 Jun 2020 15:17:52 +0000 (UTC)
Received: from localhost (ovpn-113-212.ams2.redhat.com [10.36.113.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 54C855BAC1;
 Thu, 18 Jun 2020 15:17:52 +0000 (UTC)
Date: Thu, 18 Jun 2020 16:17:51 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Coiby Xu <coiby.xu@gmail.com>
Subject: Re: [PATCH v9 5/5] new qTest case to test the vhost-user-blk-server
Message-ID: <20200618151751.GD1956319@stefanha-x1.localdomain>
References: <20200614183907.514282-1-coiby.xu@gmail.com>
 <20200614183907.514282-6-coiby.xu@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200614183907.514282-6-coiby.xu@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="at6+YcpfzWZg/htY"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 01:21:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

--at6+YcpfzWZg/htY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2020 at 02:39:07AM +0800, Coiby Xu wrote:
> This test case has the same tests as tests/virtio-blk-test.c except for
> tests have block_resize. Since vhost-user server can only server one
> client one time, two instances of qemu-storage-daemon are launched
> for the hotplug test.
>=20
> In order to not block scripts/tap-driver.pl, vhost-user-blk-server will
> send "quit" command to qemu-storage-daemon's QMP monitor. So a function
> is added to libqtest.c to establish socket connection with socket
> server.
>=20
> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
> ---
>  tests/Makefile.include              |   3 +-
>  tests/qtest/Makefile.include        |   2 +
>  tests/qtest/libqos/vhost-user-blk.c | 130 +++++
>  tests/qtest/libqos/vhost-user-blk.h |  48 ++
>  tests/qtest/libqtest.c              |  35 +-
>  tests/qtest/libqtest.h              |  17 +
>  tests/qtest/vhost-user-blk-test.c   | 739 ++++++++++++++++++++++++++++
>  7 files changed, 971 insertions(+), 3 deletions(-)
>  create mode 100644 tests/qtest/libqos/vhost-user-blk.c
>  create mode 100644 tests/qtest/libqos/vhost-user-blk.h
>  create mode 100644 tests/qtest/vhost-user-blk-test.c

This test case fails for me:

qemu-system-x86_64: Failed to read from slave.
qemu-system-x86_64: Failed to set msg fds.
qemu-system-x86_64: vhost VQ 0 ring restore failed: -1: Success (0)
qemu-system-x86_64: Failed to read from slave.
qemu-system-x86_64: Failed to read from slave.
qemu-system-x86_64: Failed to read from slave.
qemu-system-x86_64: Failed to set msg fds.
qemu-system-x86_64: vhost VQ 0 ring restore failed: -1: Success (0)
qemu-system-x86_64: Failed to read msg header. Read -1 instead of 12. Origi=
nal request 11.
qemu-system-x86_64: vhost VQ 0 ring restore failed: -1: Input/output error =
(5)

Does "make -j4 check" pass for you?

Stefan

--at6+YcpfzWZg/htY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7rhZ8ACgkQnKSrs4Gr
c8j9swf/QqzGVZhlltmiW9ZBYsky9eSRIeq+TDTfAVwYwDSBmcwY+UrNnvHADlHq
i3iWg1D6uVNNyl8BKHrcOdeiIv+Anmq2TzvyfAG1AS7FYt3FKdTljhEIJzCt14zT
IST8lMZ1fjpcOv9xbI7dmdXCtzeIK7ITCjbvnDS+81gkjjdZG29WZ/jgx5qWwmlL
Cqx9iRnYUsGFQP3qqaQnn+0zDNQ2QfvNOiTRv0wDNbCn4bcSVUKzlnRqEfhmbkU3
qCSJ/DR/JRiXFH3QhjO1e2xKHNwsASrEjKT4CMP9QG9sgzHO430eGYuVXY/ky4jR
DFylsjZJ+4eGl9iI0YzFaFmNANy6rQ==
=stx9
-----END PGP SIGNATURE-----

--at6+YcpfzWZg/htY--


