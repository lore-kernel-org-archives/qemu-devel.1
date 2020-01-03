Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6401C2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 10:54:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FFE2206DB
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 10:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LakAb7T0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FFE2206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inKbV-0005Sc-ON
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 05:54:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60641)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1inKZq-0003bf-3M
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 05:53:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1inKZp-0001gm-1a
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 05:53:09 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27898
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1inKZo-0001aj-J3
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 05:53:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578048787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q79Y8+R7VFNxh3KqkQ023ubRM7wdmgDtMHw+nbifVtE=;
 b=LakAb7T0Z45ewd0UbcHNSgUe3+wAb2AZdttcctjlFmsCFbBXR3OdsvsDi4VOz3zzkWzBoS
 tpQW3kedVJ/AE31A7DuoVwtFYqJsi0ds+xpkLSBHZdguFyxf8lAwUFnZDBWUKVglLQWb5a
 5Y4JyqvE898spP8lxk7cSDOe0i3DvNg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-nawKQYwkMOy6rk0-D8OYUQ-1; Fri, 03 Jan 2020 05:53:04 -0500
X-MC-Unique: nawKQYwkMOy6rk0-D8OYUQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40B8F8024DB;
 Fri,  3 Jan 2020 10:53:02 +0000 (UTC)
Received: from localhost (ovpn-116-102.ams2.redhat.com [10.36.116.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 234E27D545;
 Fri,  3 Jan 2020 10:52:58 +0000 (UTC)
Date: Fri, 3 Jan 2020 10:52:57 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v6 09/21] libqos: split qos-test and libqos makefile vars
Message-ID: <20200103105257.GE130240@stefanha-x1.localdomain>
References: <20191129213424.6290-1-alxndr@bu.edu>
 <20191129213424.6290-10-alxndr@bu.edu>
MIME-Version: 1.0
In-Reply-To: <20191129213424.6290-10-alxndr@bu.edu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="N1GIdlSm9i+YlY4t"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Darren Kenny <darren.kenny@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--N1GIdlSm9i+YlY4t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2019 at 09:34:44PM +0000, Oleinik, Alexander wrote:
> Most qos-related objects were specified in the qos-test-obj-y variable.
> qos-test-obj-y also included qos-test.o which defines a main().
> This made it difficult to repurpose qos-test-obj-y to link anything
> beside tests/qos-test against libqos. This change separates objects that
> are libqos-specific and ones that are qos-test specific into different
> variables.
>=20
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
> ---
>  tests/Makefile.include | 71 +++++++++++++++++++++---------------------
>  1 file changed, 36 insertions(+), 35 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--N1GIdlSm9i+YlY4t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4PHQkACgkQnKSrs4Gr
c8hp0ggAmkwEKjZ9Vawt/1qlYbJtjzBQl5e1pebapis5cHhgzz1BUqRfEzSsbt4M
2HDl0gwMfYY9NmDcfvxNt0REm6Fkk9oTNvTrb58+BfVM+UdQAmVqspJSx8+YNCW1
8CNyohjLc56SjvH6bJ5OvyaE8i1xwU9eANR4iMjr6tEkiqrTlmKSFgwwGGeoPUY4
ovjbqTgpPwVb2UEmrpUt0JjBVl1Lgvx+AxQfsrP5kPSdyUhqxcmnbZNcJc++v9FC
wWR59Thong2rUBGIFWhmTMaoSkU5GyWArvb+l6JAsehAcdLa9tXRLLumHj2ogs9S
uLko9p/R8abFpkSyRMSzs3ddua49Vg==
=lsKr
-----END PGP SIGNATURE-----

--N1GIdlSm9i+YlY4t--


