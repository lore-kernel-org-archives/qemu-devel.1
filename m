Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAFAC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 13:51:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB8EE20656
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 13:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xhl5b7DV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB8EE20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyy6V-0000w0-0X
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 09:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jyy5j-0000GJ-8Q
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 09:50:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44852
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jyy5h-0004d7-Qc
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 09:50:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595598624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hgeBXN2fbsDwpFwN64SYIikBZJ2iLwJmf2FbP8ZBfVA=;
 b=Xhl5b7DV4qnsWeFSvYU0MUnCpRx6gR0Zp0dxnh3ikK07dwuMWiYkObpKVFJleLG2bDfpxB
 AIxipg2WVW2B1LYE9nfN03d6jJ+Jx7+LkfukgXA3qVZkB122IKvWdmeODMDqhP/iWPXolW
 zVPVDwmfsDoPYeM92d75TETJr6XTm40=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-KeDQZhbhO7a_f8DBMjW9Lg-1; Fri, 24 Jul 2020 09:50:22 -0400
X-MC-Unique: KeDQZhbhO7a_f8DBMjW9Lg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46D451DE1;
 Fri, 24 Jul 2020 13:50:21 +0000 (UTC)
Received: from localhost (ovpn-114-111.ams2.redhat.com [10.36.114.111])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 34D75712C5;
 Fri, 24 Jul 2020 13:50:13 +0000 (UTC)
Date: Fri, 24 Jul 2020 14:50:09 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.1] libvhost-user: Report descriptor index on panic
Message-ID: <20200724135009.GA343825@stefanha-x1.localdomain>
References: <20200723171935.18535-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200723171935.18535-1-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 08:55:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>, qemu-devel@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2020 at 07:19:35PM +0200, Philippe Mathieu-Daud=E9 wrote:
> We want to report the index of the descriptor,
> not its pointer.
>=20
> Fixes: 7b2e5c65f4 ("contrib: add libvhost-user")
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  contrib/libvhost-user/libvhost-user.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8a5xAACgkQnKSrs4Gr
c8gkQwf+MBFWrr0VezHLzJUolZByCe3iU6BWtoGusZ5l4xAnelYjBrwghmdGqzXd
o31+CUjcV7kKG2xBiOIEjhC5QSFWXrfxN8wqCzAgeN6vBEXmhCBOd9cmNk244W4n
rzThulS5RTZ3mY2vCn8bFSHDpOeANIy3LImkfDgzQxv9UYzGkjXDgRB66U51CcQy
LwTB5M6miyRvBLZZCo/7oJhvopXqWeEctC3hcUk/ycJ7KjieHWb3xxLCyGt6K5DC
HQAN8tMxW7doyhOos/xpLlA0vRK0mMRMDpela/fPP+Saqr8jXXZkFE7xEanWZ9wt
TXhYucroP1+iIZuxvueTPYRqBKFKEw==
=dIZR
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--


