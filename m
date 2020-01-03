Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8390BC2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 11:20:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FC502085B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 11:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ej8aRa3m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FC502085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inL0e-0000za-8E
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 06:20:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59760)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1inKz6-0007up-V2
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 06:19:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1inKz5-00052V-TA
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 06:19:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32652
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1inKz5-0004zn-Lm
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 06:19:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578050355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wnakEQsXvXJs5zMIJiLqQN6n0op/uHLFgYSBqIG0arQ=;
 b=ej8aRa3mWaavu699q3IAzfkiSRMLW1ANp0aTR4axLxdwp00hcra9e9s7WPgQxt7vfqpEoC
 0nTjpHgeGGu5aDiA0z8c1IRAcLtt2HR/AaLXxgNfuLiD+Ii7eg/DuGtuCHWtnR65zbzJgT
 UedNjwvGhJvRrtFK9nrEyDnaWyFRwAM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-4UIGVFE3OhCkpJC6MANSeA-1; Fri, 03 Jan 2020 06:19:12 -0500
X-MC-Unique: 4UIGVFE3OhCkpJC6MANSeA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04D0B2EDA;
 Fri,  3 Jan 2020 11:19:11 +0000 (UTC)
Received: from localhost (ovpn-116-102.ams2.redhat.com [10.36.116.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DF5157BA26;
 Fri,  3 Jan 2020 11:19:07 +0000 (UTC)
Date: Fri, 3 Jan 2020 11:19:04 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v6 07/21] qtest: add in-process incoming command handler
Message-ID: <20200103111904.GJ130240@stefanha-x1.localdomain>
References: <20191129213424.6290-1-alxndr@bu.edu>
 <20191129213424.6290-8-alxndr@bu.edu>
MIME-Version: 1.0
In-Reply-To: <20191129213424.6290-8-alxndr@bu.edu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="XigHxYirkHk2Kxsx"
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
Cc: Thomas Huth <thuth@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laurent Vivier <lvivier@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--XigHxYirkHk2Kxsx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2019 at 09:34:43PM +0000, Oleinik, Alexander wrote:
> The handler allows a qtest client to send commands to the server by
> directly calling a function, rather than using a file/CharBackend
>=20
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>  include/sysemu/qtest.h |  1 +
>  qtest.c                | 13 +++++++++++++
>  2 files changed, 14 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--XigHxYirkHk2Kxsx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4PIygACgkQnKSrs4Gr
c8jozAf+JMrt84+YUNG3poPd6UgQyderZ3UE+3xUQdZSwPfJH489vUznEDeq4u69
gWHeBhjc7LoJXh49L7VZp4/Q+dqigZ+196PwOLpL+j37DiY7uoAFYyGEl4nN3RHn
UqPsq3ROHEZWFZ5jPKDipi8fD+NrMnn8+pvdFwGq/A0pcjpBJ+gkqjr0urq3SSdq
hJEDixuQNjEmb+1ve/T53Jv/rdcG4JJ1Zlv5xDulHdswE52vUvmAqaELb1ttlYih
AJtKxnRMBiKx472Y6u8PwNWXu9d8QiFUFl7JE0KrRw0gTZgRW5xW9uZhBynZyogt
Idb86N70mu3sYt0qSie6rSgu9GwtkA==
=a1i0
-----END PGP SIGNATURE-----

--XigHxYirkHk2Kxsx--


