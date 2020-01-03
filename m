Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A971C32767
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 11:32:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 082E521835
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 11:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FEg+Hbhb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 082E521835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inLBP-000723-1Y
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 06:32:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54837)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1inLAW-0006UP-9x
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 06:31:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1inLAV-0008E9-B1
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 06:31:04 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51910
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1inLAV-00089Z-3P
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 06:31:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578051062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rwWAmeUpWi3zyGM5v7Pl6g/3C3sKVwowwuXjboLewRM=;
 b=FEg+HbhbAyV3Irc892+3iPu7I0/WjVzaZ0rJKG396zxl2JrOuaYWsEQSk4Co6sqvOejC7F
 Lcio3STAwmPD3NWa6BvoAr5VbGtpbCIPeZ03EZyU7VRhSbWCA9OsNC8fjiogJJEQHtAsMh
 emFhN1E0CD7sBa7Fzd64qxVx2wcrCgs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-oFkXQMUUMuaqCmt5JTLkZA-1; Fri, 03 Jan 2020 06:30:50 -0500
X-MC-Unique: oFkXQMUUMuaqCmt5JTLkZA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C371D800D48;
 Fri,  3 Jan 2020 11:30:49 +0000 (UTC)
Received: from localhost (ovpn-116-102.ams2.redhat.com [10.36.116.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E7AF1272A3;
 Fri,  3 Jan 2020 11:30:45 +0000 (UTC)
Date: Fri, 3 Jan 2020 11:30:44 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v6 19/21] fuzz: add virtio-net fuzz target
Message-ID: <20200103113044.GN130240@stefanha-x1.localdomain>
References: <20191129213424.6290-1-alxndr@bu.edu>
 <20191129213424.6290-20-alxndr@bu.edu>
MIME-Version: 1.0
In-Reply-To: <20191129213424.6290-20-alxndr@bu.edu>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6o78gXsyQHm68LY/"
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--6o78gXsyQHm68LY/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2019 at 09:34:52PM +0000, Oleinik, Alexander wrote:
> The virtio-net fuzz target feeds inputs to all three virtio-net
> virtqueues, and uses forking to avoid leaking state between fuzz runs.
>=20
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>  tests/fuzz/Makefile.include  |   1 +
>  tests/fuzz/virtio_net_fuzz.c | 105 +++++++++++++++++++++++++++++++++++
>  2 files changed, 106 insertions(+)
>  create mode 100644 tests/fuzz/virtio_net_fuzz.c

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--6o78gXsyQHm68LY/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4PJeMACgkQnKSrs4Gr
c8gPjggAgcJyA0BHkzzSMWp37SZURNrMg4mMXPEi0uiFtbhLcGTnGXb279pOW2dy
5seYrLBQIU7F0ancfPr7lSQk9ejN+hofJfy05rgwRKfs1MvSxKeTx+4pJZmV90Yn
3UGgzTQswUXGb49Aj9+eIe3ptTzaqSxN3hWwxe4XabKCBW8kYCwRXZX1MAuP+2bR
x65rLRGe/k7KwI2IRzlx0DEQG5FmK7HmDRRyDggR5D6RZSXMtDhuVUM/DAbAtM79
HHp3cly09K4lXWb3iIX9iKgfIrgBkQJeZOwgY1dpSnd5OHSvOOhlOWDWXkPlPQwT
LKpl37EsryEIf63DFB5nzSdbeGWQpA==
=zFug
-----END PGP SIGNATURE-----

--6o78gXsyQHm68LY/--


