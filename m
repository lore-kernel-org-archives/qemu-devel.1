Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CC2C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 08:45:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F153D20724
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 08:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ExYzLc0s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F153D20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jneYQ-0005Bb-8F
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 04:45:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jneXY-0004Uo-5f
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 04:44:24 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27662
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jneXV-0004ln-SS
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 04:44:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592901860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1qangzRjxc4Knr6YO5W7unl3KWdvNnbJ4w7pQM532Yc=;
 b=ExYzLc0sy5fXfdzBkcriFUUD8NC8awF/bKMcE/G2JTe6CwPbAMxdXPzg9hR3/WnPYCF68Y
 A5h8+t5y18CqEDFCPrxiwK3pZOU6cRGK4nmQp9txz3doOjczyVfxKL4HGC9+Vu2iwYeFpj
 7apnZrqpPjP32p31ZZAW78K7f01IhzE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-y6b-M9NfNbKUL6PsHkSs_g-1; Tue, 23 Jun 2020 04:44:16 -0400
X-MC-Unique: y6b-M9NfNbKUL6PsHkSs_g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D46B804001;
 Tue, 23 Jun 2020 08:44:15 +0000 (UTC)
Received: from localhost (ovpn-112-109.ams2.redhat.com [10.36.112.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F09DB19D61;
 Tue, 23 Jun 2020 08:44:11 +0000 (UTC)
Date: Tue, 23 Jun 2020 09:44:10 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alexander Bulekov <alxndr@bu.edu>
Subject: Re: [PATCH] fuzz: do not use POSIX shm for coverage bitmap
Message-ID: <20200623084410.GD32718@stefanha-x1.localdomain>
References: <20200622165040.15121-1-alxndr@bu.edu>
MIME-Version: 1.0
In-Reply-To: <20200622165040.15121-1-alxndr@bu.edu>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5gxpn/Q6ypwruk0T"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 01:55:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, f4bug@amsat.org, Bandan Das <bsd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--5gxpn/Q6ypwruk0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2020 at 12:50:40PM -0400, Alexander Bulekov wrote:
> We used shm_open with mmap to share libfuzzer's coverage bitmap with
> child (runner) processes. The same functionality can be achieved with
> MAP_SHARED | MAP_ANONYMOUS, since we do not care about naming or
> permissioning the shared memory object.
>=20
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
> This might fix:
> qemu-fuzz-i386-target-virtio-net-socket: Unexpected-exit in
> counter_shm_init=20
> https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=3D23636 (private li=
nk)
>=20
> oss-fuzz does not provide access to /dev/, so it is likely that shm_open
> breaks, when it tries to access /dev/shm. This seems likely, based on
> the oss-fuzz minijail setup:
> https://github.com/google/oss-fuzz/blob/3740c751fd9edea138c17783995d370d6=
b1b89bc/infra/base-images/base-runner/run_minijail
>=20
>  tests/qtest/fuzz/fork_fuzz.c | 40 ++++++++++++------------------------
>  1 file changed, 13 insertions(+), 27 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--5gxpn/Q6ypwruk0T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7xwNoACgkQnKSrs4Gr
c8iBiAf8DDkCCZvjut69wSzJimJszpKFpU4dbXlJ68ySrbqIHAW++ZWmpYwNnVd8
xFW9NDxz+U9hkHA9EBeDbtJMsR/VgUoQJwhDnERb9S4CrMyMdbehAbuxneupPdn6
Y5dg1j0QWIj1n4VB6uA+PIXJne8MHKbP46tiNm0mU7kxxmLH8LZQwKgg0PxJ8pCk
WBwtsjszNJmkPlv+upxl7v9TGDi1zE2a37/6w5igE3lOqiBmk7TS+XcpEeycdRZb
OK39zDS732GMqo+7HHFt1MofDq+i7V9+R4LXd7+1moU7teivE7QjfKWtHPUKNPZF
Py996tEAydMzAVLRQW+EzkuRZhBdUQ==
=5gLH
-----END PGP SIGNATURE-----

--5gxpn/Q6ypwruk0T--


