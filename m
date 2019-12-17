Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A27BC2D0BF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 16:37:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C719321D7D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 16:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N8/dHy/o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C719321D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihFqS-0003mH-OT
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 11:37:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50584)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1ihFpo-0003IX-7l
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 11:36:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1ihFpk-0006XQ-CQ
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 11:36:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53892
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ihFpk-0006XG-8I
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 11:36:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576600587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RZPmXslyA6/t6wx+0oZrcUg/K8atKK0hsgl13s6tflk=;
 b=N8/dHy/oqV7sAQDVdo3bNKnVUy/Kv/W/W9I2ApswkDBGDFu0GxXBioYYq85Iczu1v2a6tz
 iE3S4BxtlxN9IOpaB0BaQmuGA9odfGCenS3mInpeL2XfMlIWst8UfXeakUcvzHE4Lc3z3l
 tWghSgrz9CIoxOYdQ07o18m2m3tQxPY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-a_Tz03LkM7yx-f-wkHbJtw-1; Tue, 17 Dec 2019 11:36:23 -0500
X-MC-Unique: a_Tz03LkM7yx-f-wkHbJtw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5D74800D48;
 Tue, 17 Dec 2019 16:36:22 +0000 (UTC)
Received: from localhost (ovpn-117-244.ams2.redhat.com [10.36.117.244])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 461E119C4F;
 Tue, 17 Dec 2019 16:36:22 +0000 (UTC)
Date: Tue, 17 Dec 2019 16:36:21 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH] docs: fix rst syntax errors in unbuilt docs
Message-ID: <20191217163621.GC1333385@stefanha-x1.localdomain>
References: <20191111094411.427174-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191111094411.427174-1-stefanha@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qjNfmADvan18RZcF"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Daniel Berrange <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--qjNfmADvan18RZcF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2019 at 09:44:11AM +0000, Stefan Hajnoczi wrote:
> The .rst files outside docs/{devel,interop,specs} aren't built yet and
> therefore a few syntax errors have slipped through.  Fix them.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> ---
> Sent as a separate patch.  This used to be part of "[PATCH 0/3] docs:
> build an index page for the HTML docs" but I'm changing the approach in
> that series and this is now an independent fix.
>=20
>  docs/arm-cpu-features.rst    |  6 +++---
>  docs/virtio-net-failover.rst |  4 ++--
>  docs/virtio-pmem.rst         | 19 ++++++++++---------
>  3 files changed, 15 insertions(+), 14 deletions(-)

Thanks, applied to my block tree since no one has picked this up:
https://github.com/stefanha/qemu/commits/block

Stefan

--qjNfmADvan18RZcF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl35BAUACgkQnKSrs4Gr
c8jeEQf+OM607Yj0yx6DjTYTM9t8CraLBlxoWGLr4P1D6EVql+ORWkwkcub6wmZO
IFE+gfXF5diix7NRm1WSJN3C7cgMq0GMZUxTspReUTMko2XZyS9JiC8gqE4u/FFH
ED5CCFXwzIYscQ+N0Tg0sloGXcwf/SRxbUDui/NOSQ+lpA3SEqH/u0Atd/+UT9/3
hel8bB9t3JCkU2lbgCJgFLTooy6riqpzsPegCLRzUEY6oeOPia++iThnJda7QgPi
in5cbFG5qgJtMS0rXtK1YomtyHOuW8MKiaG96mHwSLrRgYHni0o0TxvyWKbQ7Fjg
KOAX/pz73EWFMqxKWSVTbmJE4NXEqQ==
=OrMf
-----END PGP SIGNATURE-----

--qjNfmADvan18RZcF--


