Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985B4C352A5
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 17:07:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6335E208C4
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 17:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vu6GJQtt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6335E208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1CX0-0005yw-I2
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 12:07:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47294)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j1CSC-00015c-1F
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 12:02:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j1CSA-0001uK-FG
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 12:02:35 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39965
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j1CSA-0001tE-7i
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 12:02:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581354153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aWHWaqf1yZGeBYxNjr5jxMy3R8OlxHw+TcblnHpuKqs=;
 b=Vu6GJQttN2SYd1Khe7kZgn/B7WxS61wSUFG9JyceCuIY5fo0MYlFaIxGIlQk08HarPyHQQ
 4P3D8CpiWFLVkEFKQTgzcoqP9MIj2eDgiRm18nJFeg2qJrDES26GGn+ZsE7+ym4y2ECk5s
 d4B0b+9Ta+lLwD8Ddem42TnLlEIQasM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-O924298SPLSJiGdwVoTBVQ-1; Mon, 10 Feb 2020 12:02:23 -0500
X-MC-Unique: O924298SPLSJiGdwVoTBVQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD2BB1005514
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 17:02:22 +0000 (UTC)
Received: from localhost (unknown [10.36.118.86])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6716D26FAA;
 Mon, 10 Feb 2020 17:02:17 +0000 (UTC)
Date: Mon, 10 Feb 2020 17:02:07 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v2 2/2] virtiofsd: add it to the tools list
Message-ID: <20200210170207.GI411895@stefanha-x1.localdomain>
References: <20200207095412.794912-1-lvivier@redhat.com>
 <20200207095412.794912-2-lvivier@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200207095412.794912-2-lvivier@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UthUFkbMtH2ceUK2"
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
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--UthUFkbMtH2ceUK2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 07, 2020 at 10:54:12AM +0100, Laurent Vivier wrote:
> it will be built only when tools are enabled (always enabled by default)
>=20
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--UthUFkbMtH2ceUK2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5BjI8ACgkQnKSrs4Gr
c8jcVAgAvQWJaT3jZTYB1LJckac+SqSeBY+rthmIR6xATBxWvkNf063vs6IiPRAD
LsC6g0wEbgUusmCNIjNvk+ok5iXZVaE9L/DZHpEdEDCg3l4QPLck8U1Jh0QK8DgO
HaVdxhp6wWUgZyvZzOqTVsp+JIz3RfsWwX1jSjq7zGE0xF/X9sHaCoDrhYi5Z7WW
cp4eN4M5zDRjuoH3FbOC4RjaSxu1P68AzFLflrnqdse183lAuumxk9PxdLrt4Ayw
smd+KHwZ99Np9uao72cCa8/2ejnSBB9LPemZPjx7K9tlvPQpihTicXsQPd01fpc0
+pwDdgc/BXWLZxcPQvL7oWlUK5RY6A==
=u9O8
-----END PGP SIGNATURE-----

--UthUFkbMtH2ceUK2--


