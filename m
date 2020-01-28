Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A295C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 13:22:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C73FC206A2
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 13:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YrX+kknp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C73FC206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwQoi-00025F-Rp
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 08:22:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59539)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iwQnf-0000yj-JT
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 08:21:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iwQne-0004Zv-MN
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 08:21:03 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25818
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iwQnc-0004Xk-9v
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 08:21:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580217659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N/pp62cxTi7ZxdEf6ZRgQc1j5AqhKcz9jt0CqfCQeVs=;
 b=YrX+kknpjlUej35odk2lW8NlfkR7IlA27VLDEHjjXFd8ASIycfJPWp1cPWoddzlkE0cgiP
 2oPasJ7SSlEwxcbkt06sem5knFLE088m+ZRiOZfmTpIc2RfF4vT5xjw/SjwtWES5hKdE8p
 tqG+y8KkpZji6FahNvAuf40Bs8xg9i8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-Jm9OaukiNau0STwe-abs0w-1; Tue, 28 Jan 2020 08:20:55 -0500
X-MC-Unique: Jm9OaukiNau0STwe-abs0w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48C6313E1;
 Tue, 28 Jan 2020 13:20:54 +0000 (UTC)
Received: from localhost (unknown [10.33.36.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D365F80A5C;
 Tue, 28 Jan 2020 13:20:53 +0000 (UTC)
Date: Tue, 28 Jan 2020 14:20:52 +0100
From: Sergio Lopez <slp@redhat.com>
To: Kamil Rytarowski <n54@gmx.com>
Subject: Re: [PATCH v2 2/4] Add the NetBSD Virtual Machine Monitor accelerator.
Message-ID: <20200128132052.yjys6pdrghtjgv6c@dritchie>
References: <20200128085438.hhz3f55bow75zl35@dritchie>
 <20200128105133.2245-1-n54@gmx.com>
MIME-Version: 1.0
In-Reply-To: <20200128105133.2245-1-n54@gmx.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="26xvczhujf4t6cdn"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, max@m00nbsd.net,
 peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--26xvczhujf4t6cdn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2020 at 11:51:33AM +0100, Kamil Rytarowski wrote:
> From: Maxime Villard <max@m00nbsd.net>
>=20
> Introduces the configure support for the new NetBSD Virtual Machine Monit=
or that
> allows for hypervisor acceleration from usermode components on the NetBSD
> platform.
>=20
> Signed-off-by: Maxime Villard <max@m00nbsd.net>
> Signed-off-by: Kamil Rytarowski <n54@gmx.com>
> ---
>  configure       | 36 ++++++++++++++++++++++++++++++++++++
>  qemu-options.hx | 16 ++++++++--------
>  2 files changed, 44 insertions(+), 8 deletions(-)

Reviewed-by: Sergio Lopez <slp@redhat.com>

Thanks!

--26xvczhujf4t6cdn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl4wNS4ACgkQ9GknjS8M
AjV9DQ//WP+amuPQdNa7o5JzoV637J7PewfhxT0ekQW4Jt4XYeRyUH3EHN+zRz+Q
4PE8x/vdxqLiFe9zopKlmIiPLzkWRpyKjfC2ubdtQynNBVinXIEERTFRr+pDZ364
3v9NeZ+CECfi0wO+xVsIFtkapxMI0jQ09kJNpUbZCj94t+gj/aAjxE9ZdAtLK/DH
Sx1/JPSbYsKdOnDbiUKJfTHsKFeVfR40a+slTtRSpWKqqvx3fZbZlDazgHQPuF+3
29KheCfMIFuRoS9Mq5NrvgnxIEGdQfhUZZRzXJV8DOpUsOAup4TNz0xklcBCmbuO
UDKJHo3PdL8PVhylB8ybFFL8qHcGhYUzT8PXkC6yyMzLoFxvOoPDEEzocDBe33iR
WsnhG6q6d/X7yYRG+US3DD/HRAZdHidPLye7jAhZQUu9GAb3W+RfVCaJaY2ITnir
Dz0C7d3cfqle51NP5Mz4eyobXP2gO5ND+YxFWy1rOkGlWuZu7CrY00UqZ1BIP4Gp
UPwyqKKQOkWzVJ8Yq8akizM049PNtHupDCJwy+UaqPHWqhAE7RyCwDvRFCxdO4uu
1Iwp52BYGm6eiPoEGGp9R+SvoYyB2HZU+k9qYfYxduy2QqX2jatc+QnpspuiCSsu
9hIo0KdtTcpbTxcCMTXEObdAJ54ocpuOEXcsMpiGtAcc/E4WW9Q=
=sJNf
-----END PGP SIGNATURE-----

--26xvczhujf4t6cdn--


