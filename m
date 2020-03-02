Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF32C3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 10:30:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A7BE2146E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 10:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fVvvsAWp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A7BE2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8iL3-0007EI-S7
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 05:30:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54032)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jtomko@redhat.com>) id 1j8iK7-0006Ce-SH
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 05:29:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jtomko@redhat.com>) id 1j8iK7-000271-0J
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 05:29:19 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32492
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jtomko@redhat.com>) id 1j8iK6-00026l-TQ
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 05:29:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583144958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qfA43I0wPBTgAr1kymjSIKmCA8VdYQhVgHN7DXM1E8c=;
 b=fVvvsAWpx5P3wYIO+rmn6g0PeqjZ5XRbS+v9jEkivua7gG57yQI8KzIfMUR6BFfAC1+SnW
 0mbJbCEHsI0rQ2y2dxQxK60xMg2Mg1uotd0gXbQculfuylAntCRReQlXuq/IwK7uVDYgeu
 IX+4AilKfF+5mTgg2aR3dHkhOQ7GT+8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-yaMwrn2GNyCJhSmUtSROiw-1; Mon, 02 Mar 2020 05:29:14 -0500
X-MC-Unique: yaMwrn2GNyCJhSmUtSROiw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C6891005510;
 Mon,  2 Mar 2020 10:29:13 +0000 (UTC)
Received: from lpt (unknown [10.43.2.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4731A8D562;
 Mon,  2 Mar 2020 10:29:11 +0000 (UTC)
Date: Mon, 2 Mar 2020 11:29:09 +0100
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
To: Nick Erdmann <n@nirf.de>
Subject: Re: [PATCH] vhost-vsock: fix error message output
Message-ID: <20200302102909.GC2870380@lpt>
References: <04df3f47-c93b-1d02-d250-f9bda8dbc0fa@nirf.de>
MIME-Version: 1.0
In-Reply-To: <04df3f47-c93b-1d02-d250-f9bda8dbc0fa@nirf.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="oJ71EGRlYNjSvfq7"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--oJ71EGRlYNjSvfq7
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On a Sunday in 2020, Nick Erdmann wrote:
>error_setg_errno takes a positive error number, so we should not invert
>errno's sign.
>
>Signed-off-by: Nick Erdmann <n@nirf.de>
>---
> hw/virtio/vhost-vsock.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: J=E1n Tomko <jtomko@redhat.com>

Jano

--oJ71EGRlYNjSvfq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEQeJGMrnL0ADuclbP+YPwO/Mat50FAl5c3+kACgkQ+YPwO/Ma
t5294gf/Sp/gNtQGPubE8lFZDjEDik68jAS9kGISg2iWKeJvQAeaPFSWj3H5DicR
aT94HJ7VvKoIwPRodcYgSNDz+KXgx28whzUJFmIrQ0LYmnkVBSOvN8n1N+zmXJfm
wLUYBCk+PNF02MN7juApisMEfrQ2t68X65apq1ToqvQcfuwoQhQalJdJTPNpIGXX
tL7gaUoLombLZF7EzOFWKij4GMd+cwPci5+oCBwnz95KzFlNfs4wRRxHRZam0slO
3huFZ1bWYiv26kUJtGKRL2NUZmpxCVtoxX+Pax7MMPgPB567CsNCAzf81mKU/NUd
TLdAbDuBTHkM1EuTqfmsQuHtmeLSlg==
=dvpk
-----END PGP SIGNATURE-----

--oJ71EGRlYNjSvfq7--


