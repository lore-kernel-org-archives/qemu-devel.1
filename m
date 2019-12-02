Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE29EC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 15:02:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8E8E20748
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 15:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VhvCsCCY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8E8E20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibnD6-0000wJ-Oa
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 10:02:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42270)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1ibnBR-0000In-9E
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 10:00:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1ibnBO-00027c-M3
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 10:00:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48667
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ibnBO-000265-CB
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 10:00:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575298813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A91UMVp3/1aJ0LL0/TxsUz0nnQZ4pjDazmqrhQuwvXI=;
 b=VhvCsCCYldNAwhzWpyRvAwnn28fspMfzweNZts71FCkVyEeaHSgI6KeQzotnyR6lajBhkX
 tZ6UYxbgnlG6jgg52vwRezopnd3tlckrzSz9PgvuyaGk0JSFYX3MlVv/aM5i52jBWlZQKf
 15W4gnbZ4zNV7ard8RStotB7cYmneYQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-i10-BBdmMD-j0rMw-JBQiw-1; Mon, 02 Dec 2019 10:00:09 -0500
X-MC-Unique: i10-BBdmMD-j0rMw-JBQiw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 678C9593CF;
 Mon,  2 Dec 2019 15:00:07 +0000 (UTC)
Received: from localhost (unknown [10.36.118.180])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B34A9A4B83;
 Mon,  2 Dec 2019 15:00:02 +0000 (UTC)
Date: Mon, 2 Dec 2019 15:00:01 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Felipe Franciosi <felipe@nutanix.com>
Subject: Re: [PATCH v3 0/4] Improve default object property_add uint helpers
Message-ID: <20191202150001.GD131786@stefanha-x1.localdomain>
References: <20191129174630.6922-1-felipe@nutanix.com>
MIME-Version: 1.0
In-Reply-To: <20191129174630.6922-1-felipe@nutanix.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="GpGaEY17fSl8rd50"
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@gmail.com>,
 Philippe Mathieu-Daude <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--GpGaEY17fSl8rd50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2019 at 05:46:47PM +0000, Felipe Franciosi wrote:
> This improves the family of object_property_add_uintXX_ptr helpers by ena=
bling
> a default getter/setter only when desired. To prevent an API behavioural =
change
> (from clients that already used these helpers and did not want a setter),=
 we
> add a OBJ_PROP_FLAG_READ flag that allow clients to only have a getter. P=
atch 1
> enhances the API and modify current users.
>=20
> While modifying the clients of the API, a couple of improvement opportuni=
ties
> were observed in ich9. These were added in separate patches (2 and 3).
>=20
> Patch 3 cleans up a lot of existing code by moving various objects to the
> enhanced API. Previously, those objects had their own getters/setters tha=
t only
> updated the values without further checks. Some of them actually lacked a=
 check
> for setting overflows, which could have resulted in undesired values bein=
g set.
> The new default setters include a check for that, not updating the values=
 in
> case of errors (and propagating them). If they did not provide an error
> pointer, then that behaviour was maintained.
>=20
>=20
> Felipe Franciosi (4):
>   qom/object: enable setter for uint types
>   ich9: fix getter type for sci_int property
>   ich9: Simplify ich9_lpc_initfn
>   qom/object: Use common get/set uint helpers
>=20
>  hw/acpi/ich9.c       |  99 ++------------------
>  hw/acpi/pcihp.c      |   7 +-
>  hw/acpi/piix4.c      |  12 +--
>  hw/isa/lpc_ich9.c    |  27 ++----
>  hw/misc/edu.c        |  13 +--
>  hw/pci-host/q35.c    |  14 +--
>  hw/ppc/spapr.c       |  18 +---
>  hw/ppc/spapr_drc.c   |   3 +-
>  hw/vfio/pci-quirks.c |  20 ++--
>  include/qom/object.h |  44 +++++++--
>  memory.c             |  15 +--
>  qom/object.c         | 216 ++++++++++++++++++++++++++++++++++++++-----
>  target/arm/cpu.c     |  22 +----
>  target/i386/sev.c    | 106 ++-------------------
>  ui/console.c         |   4 +-
>  15 files changed, 288 insertions(+), 332 deletions(-)
>=20
> --=20
> 2.20.1
>=20
> Changelog:
> v1->v2:
> - Update sci_int directly instead of using stack variable
> - Defining an enhanced ObjectPropertyFlags instead of just 'readonly'
> - Erroring out directly (instead of using gotos) on default setters
> - Retaining lack of errp passing when it wasn't there
> v2->v3:
> - Rename flags _RD to _READ and _WR to _WRITE
> - Add a convenience _READWRITE flag
> - Drop the usage of UL in the bit flag definitions

Modulo the review comments that have already been raised:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--GpGaEY17fSl8rd50
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3lJvEACgkQnKSrs4Gr
c8i0rAf+PSU3PAEPQ4K+1qmGrc+he9g7nzwdnic/rashpCRF8HBbiquSvRK+dUF8
Mq59L/AtRwVJN9aOoUKNMRjZ6clGEs6f8uw8Jhed+/6qFlpx9Y9WoK+9zORhoGT7
T2Qir0f64gEs8ihgjaW/q57d65+T2MiKffzMwXEp0ZP3p6EJcE9h5te9n5i5dei5
YljngHu5QpPm/QQMORVO49GgIo+hZsMgNkD7CZtDwRVb/uzcvvkPrapDuWd1Wx44
VbOvjKpH4iEWkpGOVIYUEWAUjbtBs2C9wIOe6KfCkKhVc8n4Pxu+2/WEU0rvFBEk
IU5YwBds6LW15tBcPW5Y6dbmjDvS2Q==
=dbll
-----END PGP SIGNATURE-----

--GpGaEY17fSl8rd50--


