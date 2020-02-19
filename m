Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17461C3405F
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 18:03:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA865206DB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 18:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="StKvTxiw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA865206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4Tgl-0003ip-4K
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 13:03:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54267)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j4TcK-00061B-8B
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 12:58:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j4TcJ-0001AH-Cw
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 12:58:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24762
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j4TcJ-00019M-9E
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 12:58:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582135113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GCCfExW5vA3mzQmf5cxNCz1O6V/ySla8qQznowgC7F4=;
 b=StKvTxiwwJQFDPDXg/Mz2l7MnC2wC/CsjVrkkPdu9kkEWRJmUa/TaXI6HCcclSlj7uSkvO
 h1Dhq6eTSzfHxhwz2yp488gVwAuVeYp3uMuO2cMilVO1k/MZqq6ghpPtGwBeL3gZSXv0uC
 sV21Bwbhll5H0JzYZAxoMA3/lrjT8QI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-8plim--gMgewL1noBBf87w-1; Wed, 19 Feb 2020 12:58:12 -0500
X-MC-Unique: 8plim--gMgewL1noBBf87w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C77908010E5;
 Wed, 19 Feb 2020 17:58:11 +0000 (UTC)
Received: from localhost (unknown [10.36.118.184])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A8C6648;
 Wed, 19 Feb 2020 17:58:08 +0000 (UTC)
Date: Wed, 19 Feb 2020 16:38:15 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Coiby Xu <coiby.xu@gmail.com>
Subject: Re: [PATCH v4 0/5] vhost-user block device backend implementation
Message-ID: <20200219163815.GD1085125@stefanha-x1.localdomain>
References: <20200218050711.8133-1-coiby.xu@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200218050711.8133-1-coiby.xu@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="M38YqGLZlgb6RLPS"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com, qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--M38YqGLZlgb6RLPS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2020 at 01:07:06PM +0800, Coiby Xu wrote:
> v4:
>  * add object properties in class_init
>  * relocate vhost-user-blk-test
>  * other changes including using SocketAddress, coding style, etc.

Thanks!  I think the vhost-user server code can be simplified if
libvhost-user uses the event loop for asynchronous socket I/O.  Then
it's no longer necessary to duplicate vu_message_read() and
vu_kick_cb().  I've replied to Patch 1 and we can discuss on IRC if you
want to chat about it.

I've also CCed Marc-Andr=E9 to see what he thinks about removing the
blocking recv from libvhost-user and instead using the event loop (just
like for eventfds).

Stefan

--M38YqGLZlgb6RLPS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5NZHcACgkQnKSrs4Gr
c8jIdwgAgrlaFc6YR+0V+Y7CzUjMqQ58w0IQHtxP/OdA3RdBKfjyR2EGoWV7RxaD
FDwtDtTcWtOOMMdmZH/M4NLRenT5inNe6YgRPZ2PB7Ao1wtZoH1SlFv9djjsuat5
MtJZLGOU+pzbwBXiVH/9OF4PjmnRLWrS5SLHWZPq/Gezsr4UI4v8ZES3ZufjTWUI
6KkqVHmE7ut1SpuYDI7nUny6DYqhJiwU4BjrS8FjMLClxdYd61QLDxgG+5p6/wv/
S+a+T+0yoT1gTCnp+FmruMUFhsdtJDenI4a+bznjrNPf7NMeXQrdiPtHKAyqsBm3
nBZwkHw1cxBmfJQbWQ7vb/zNNS5cdw==
=6RKn
-----END PGP SIGNATURE-----

--M38YqGLZlgb6RLPS--


