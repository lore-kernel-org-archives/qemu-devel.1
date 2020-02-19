Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F251C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 10:32:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BE00208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 10:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h47VUvSX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BE00208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4MeX-00041K-Dv
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 05:32:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56725)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1j4MdD-00036M-VT
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 05:31:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1j4MdD-0007G8-2w
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 05:31:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49604
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1j4MdC-0007FV-TQ
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 05:31:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582108262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/aVEMm2Y3i5RYg+9XbTigRp/TfUMNCbN9z9a77ExvpM=;
 b=h47VUvSXGzctyc0Z0muOEpZzk52SxeB31mHtXuxMVhSTtEJBVB87E5+4ikUJdoPWVTmd71
 ya8r2aFzQf9smYsrvQqEGq9rBEIFvuxoY00Vf+ooqJGqbBYRcZ85625wb/QmhGxsdZOeGu
 ke+Uc5oIdzhBr6uo8Ub9fwAVf7So5s8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-andU1Wo3O-yayPpQAJBt0w-1; Wed, 19 Feb 2020 05:30:57 -0500
X-MC-Unique: andU1Wo3O-yayPpQAJBt0w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49CC58018A3;
 Wed, 19 Feb 2020 10:30:56 +0000 (UTC)
Received: from localhost (unknown [10.33.36.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3DC245DA76;
 Wed, 19 Feb 2020 10:30:50 +0000 (UTC)
Date: Wed, 19 Feb 2020 11:30:49 +0100
From: Sergio Lopez <slp@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 3/5] qemu/queue.h: add QLIST_SAFE_REMOVE()
Message-ID: <20200219103049.ik6aje5uvb64cret@dritchie>
References: <20200214171712.541358-1-stefanha@redhat.com>
 <20200214171712.541358-4-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200214171712.541358-4-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="uklq2jv2jhszyl52"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--uklq2jv2jhszyl52
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2020 at 05:17:10PM +0000, Stefan Hajnoczi wrote:
> QLIST_REMOVE() assumes the element is in a list.  It also leaves the
> element's linked list pointers dangling.
>=20
> Introduce a safe version of QLIST_REMOVE() and convert open-coded
> instances of this pattern.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block.c              |  5 +----
>  chardev/spice.c      |  4 +---
>  include/qemu/queue.h | 14 ++++++++++++++
>  3 files changed, 16 insertions(+), 7 deletions(-)

Reviewed-by: Sergio Lopez <slp@redhat.com>

--uklq2jv2jhszyl52
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl5NDlgACgkQ9GknjS8M
AjW4SA/+O6GMX2i3IG0GIcjvPL0qOOmKYT9Zuukvf2FE5UP44Tk5QjdN6Q8QmV2n
KcEXJNK0YKnX3kOUZPNt47hB1WcFFPqw1x2gpG8J9tGjijD1x144PY6Zx+zNc10u
+fMzOEendLu1QYElKuvygkK50Qyh2wBCLoFmdUU5J9aXLJk6DzjjnbT5tNsWUfRU
RY5SbxHiP7wzxKLwF8ck1YWL7jY2CsDuye2om2KfaCRGjViT9ZleBqSZKrJTqtic
F24iS4wZ+gA3mfftCLjx44OtLnuWNCQHiPhnopVei0MC9tqG2gNkVd7DLVWGDmR1
Jr6rZVur9L4pdF2nIDUuh5xdrKOLLfPGr4xH6TqCZhc+sQoJ3dXYp8/F11nXqPKk
6NpGH2JS1v3v2JdjBx1pjxP18aAXChOAiTQvWKfIQEYK50vQY/ytc/5Bmyd/PN/R
H7f5QW6bgzI3Mnn967vhcz2PMJqOTS7zaLN1RDd4aXc1r5UT8snJmGRfO3yNzhzz
+x+EvULOzrlDuGNSJa8FbCdWAViBK4msMib2MuE0L2ptDLPXUQlNQo7FHNFkE0Kg
veruo6Wgk2ZuPcYt7jsojmNyjv7RVOoPnJqitZAh4T0lpAiOx4RNNQpw4GFoK96i
XhmFQ2yvVJz2c7/iBAiqySANPhCUR55KvDlkFJeySWXSU4hPOP0=
=YlQ7
-----END PGP SIGNATURE-----

--uklq2jv2jhszyl52--


