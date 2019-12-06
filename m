Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59B8C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:35:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8270B24659
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ll5a6TyX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8270B24659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idFdf-0004dD-7n
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 10:35:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40449)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1idEpb-0005Hz-Au
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:43:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1idEpZ-0007hD-11
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:43:43 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55557
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1idEpY-0007da-RR
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:43:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575643417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V7Xt7M4/SoLWGM3tlwWOa4IUlDFv79PpfmyxobKXePE=;
 b=Ll5a6TyX1Jh5371sUEstePz8WKSKsbrUwqbPBHbGauzEP4LVl7RbWhzkoyLQZR5P7dWixr
 WOyMHBfPq8CFkjg4ZBnQYt7MTZBjq5JnPFAdWd71UZCsnP1BpKbbGYjEdq2xjDEYR9X1pB
 YCyZeHsQP0QOJJV6nBih5vdIPeW32DY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-3gRUHhLJOqSF9ND4lqe29Q-1; Fri, 06 Dec 2019 09:43:35 -0500
X-MC-Unique: 3gRUHhLJOqSF9ND4lqe29Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDF711005502;
 Fri,  6 Dec 2019 14:43:34 +0000 (UTC)
Received: from localhost (ovpn-117-102.ams2.redhat.com [10.36.117.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DB8F419C70;
 Fri,  6 Dec 2019 14:43:33 +0000 (UTC)
Date: Fri, 6 Dec 2019 14:43:29 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH] qapi: better document NVMe blockdev @device parameter
Message-ID: <20191206144329.GA778789@stefanha-x1.localdomain>
References: <20191206143811.3777524-1-berrange@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191206143811.3777524-1-berrange@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 06, 2019 at 02:38:11PM +0000, Daniel P. Berrang=E9 wrote:
> Mention that this is a PCI device address & give the format it is
> expected it. Also mention that it must be first unbound from any
> host kernel driver.
>=20
> Signed-off-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> ---
>  qapi/block-core.json | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3qaREACgkQnKSrs4Gr
c8hURAf/XTaXSde95QoMURRonl8VRTFXr87XP+CR1bxrRpwjTklhj5K0Lzn4EUFG
e2PnPc9kxfcxI+IFvjtO7SRW5g6MygeDD2bzlX0LEsmyrkpcUkBcu1UXGzdNld4P
pZsNALrqCppdEIuhH4IDReVZon48YCtKg5aDtC5TRu65WyQD4gg+C0cssw+e4MzL
BTa1DjdH7DwEDkNzzX1MX0uxk0TmWANacWIRB/hWTWYdIsWvOe3Jv1JI6guYrDcb
eO0fSggxNr7EcJqhpRcVtYq4NZAhROdCX9/RBhMGkYQZrfbtFaVgEBYY0P+99hKM
Xlo12NYibQr11aTtRrk9cpEY2LxzJQ==
=NpSN
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--


