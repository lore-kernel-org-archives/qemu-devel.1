Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D29C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 10:07:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21703222B3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 10:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gm3lfbd+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21703222B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX0PZ-0003sL-9g
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 05:07:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36329)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iX0Ow-0003Ta-FG
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 05:06:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iX0Ov-00043i-1P
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 05:06:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20363
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iX0Ou-00043L-TH
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 05:06:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574157984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SKfe53aJ9jSK/J3TlixoT7yIM+sKGppdOe6+Tab8fSE=;
 b=Gm3lfbd+Sh02tFnyzQUuiodr7t7sigjyGg6baLNIA87RzcM1WJUTx6CYGrROneOUujDCjC
 0RALUDGv4usqXqrM5t6ah+P1XukkoDD5Ud9k+07HudKdYIvt2jcSoW7EhZCeNa8gnIq3ap
 OFpfrl9W5nDeHWdWndcpcUGTHimu2KM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-PNTIcx7kP0aA2xDfXLFj0w-1; Tue, 19 Nov 2019 05:06:21 -0500
X-MC-Unique: PNTIcx7kP0aA2xDfXLFj0w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E6F2802689;
 Tue, 19 Nov 2019 10:06:20 +0000 (UTC)
Received: from localhost (ovpn-117-47.ams2.redhat.com [10.36.117.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 60FAA62671;
 Tue, 19 Nov 2019 10:06:19 +0000 (UTC)
Date: Tue, 19 Nov 2019 10:06:18 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Felipe Franciosi <felipe@nutanix.com>
Subject: Re: [PATCH] qom/object: enable setter for uint types
Message-ID: <20191119100618.GB82138@stefanha-x1.localdomain>
References: <20191117072839.34390-1-felipe@nutanix.com>
MIME-Version: 1.0
In-Reply-To: <20191117072839.34390-1-felipe@nutanix.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="f2QGlHpHGjS2mn6Y"
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Daniel Berrange <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 17, 2019 at 03:50:32PM +0000, Felipe Franciosi wrote:
> Traditionally, the uint-specific property helpers only offer getters.
> When adding object (or class) uint types, one must therefore use the
> generic property helper if a setter is needed.
>=20
> This enhances the uint-specific property helper APIs by adding a
> 'readonly' field and modifying all users of that API to set this
> parameter to true. If 'readonly' is false, though, the helper will add
> an automatic setter for the value.
>=20
> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
> ---
>  hw/acpi/ich9.c       |   4 +-
>  hw/acpi/pcihp.c      |   6 +--
>  hw/acpi/piix4.c      |  12 +++---
>  hw/isa/lpc_ich9.c    |   4 +-
>  hw/ppc/spapr_drc.c   |   2 +-
>  include/qom/object.h |  28 ++++++++----
>  qom/object.c         | 100 ++++++++++++++++++++++++++++++++-----------
>  ui/console.c         |   3 +-
>  8 files changed, 111 insertions(+), 48 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--f2QGlHpHGjS2mn6Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3TvpoACgkQnKSrs4Gr
c8gSEwgAoY88kfqD3xFEF05kS++LySEPaUuxZLKFnf9S4iAcuPRVv3R1GAdy1xqf
SGbOV85ZQT75d1rVmb6LUecgKkxvsk+41YAW3+YalQD+1QfEz5psEUF1zfOf13NW
HCC2jWiVcXWCQPNonEtGRe5Yh6x25OiNd1dU9puOX4bBPmKle5KGSmGbv8sWx9l9
Y2IebLpovzWxn0KjorctUzQh0lEAjXkPPjtao5M6j186HhcoDuEtvxFFmoqsLrn8
KVVDWBZbzaoTvYrRtu6cS28htp8736s+wBHyLM3nte9wcOxbLBOjUn0erI0omph/
uExRNBJsn/wsnoPDuiuuYQ7KgiKplQ==
=yOTX
-----END PGP SIGNATURE-----

--f2QGlHpHGjS2mn6Y--


