Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35969C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 16:41:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EDF8214DA
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 16:41:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EDF8214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38423 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSlMC-0004nQ-8m
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 12:41:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hSlB1-0004nY-Od
	for qemu-devel@nongnu.org; Mon, 20 May 2019 12:30:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hSlB0-00026j-Qv
	for qemu-devel@nongnu.org; Mon, 20 May 2019 12:30:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hSlB0-00025F-Hi
	for qemu-devel@nongnu.org; Mon, 20 May 2019 12:30:14 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C6FAF59442
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 16:30:08 +0000 (UTC)
Received: from [10.3.116.56] (ovpn-116-56.phx2.redhat.com [10.3.116.56])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 70DA61017E33;
	Mon, 20 May 2019 16:30:02 +0000 (UTC)
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
References: <20190520030839.6795-1-peterx@redhat.com>
	<20190520030839.6795-14-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=eblake@redhat.com; keydata=
	xsBNBEvHyWwBCACw7DwsQIh0kAbUXyqhfiKAKOTVu6OiMGffw2w90Ggrp4bdVKmCaEXlrVLU
	xphBM8mb+wsFkU+pq9YR621WXo9REYVIl0FxKeQo9dyQBZ/XvmUMka4NOmHtFg74nvkpJFCD
	TUNzmqfcjdKhfFV0d7P/ixKQeZr2WP1xMcjmAQY5YvQ2lUoHP43m8TtpB1LkjyYBCodd+LkV
	GmCx2Bop1LSblbvbrOm2bKpZdBPjncRNob73eTpIXEutvEaHH72LzpzksfcKM+M18cyRH+nP
	sAd98xIbVjm3Jm4k4d5oQyE2HwOur+trk2EcxTgdp17QapuWPwMfhaNq3runaX7x34zhABEB
	AAHNHkVyaWMgQmxha2UgPGVibGFrZUByZWRoYXQuY29tPsLAegQTAQgAJAIbAwULCQgHAwUV
	CgkICwUWAgMBAAIeAQIXgAUCS8fL9QIZAQAKCRCnoWtKJSdDahBHCACbl/5FGkUqJ89GAjeX
	RjpAeJtdKhujir0iS4CMSIng7fCiGZ0fNJCpL5RpViSo03Q7l37ss+No+dJI8KtAp6ID+PMz
	wTJe5Egtv/KGUKSDvOLYJ9WIIbftEObekP+GBpWP2+KbpADsc7EsNd70sYxExD3liwVJYqLc
	Rw7so1PEIFp+Ni9A1DrBR5NaJBnno2PHzHPTS9nmZVYm/4I32qkLXOcdX0XElO8VPDoVobG6
	gELf4v/vIImdmxLh/w5WctUpBhWWIfQDvSOW2VZDOihm7pzhQodr3QP/GDLfpK6wI7exeu3P
	pfPtqwa06s1pae3ad13mZGzkBdNKs1HEm8x6zsBNBEvHyWwBCADGkMFzFjmmyqAEn5D+Mt4P
	zPdO8NatsDw8Qit3Rmzu+kUygxyYbz52ZO40WUu7EgQ5kDTOeRPnTOd7awWDQcl1gGBXgrkR
	pAlQ0l0ReO57Q0eglFydLMi5bkwYhfY+TwDPMh3aOP5qBXkm4qIYSsxb8A+i00P72AqFb9Q7
	3weG/flxSPApLYQE5qWGSXjOkXJv42NGS6o6gd4RmD6Ap5e8ACo1lSMPfTpGzXlt4aRkBfvb
	NCfNsQikLZzFYDLbQgKBA33BDeV6vNJ9Cj0SgEGOkYyed4I6AbU0kIy1hHAm1r6+sAnEdIKj
	cHi3xWH/UPrZW5flM8Kqo14OTDkI9EtlABEBAAHCwF8EGAEIAAkFAkvHyWwCGwwACgkQp6Fr
	SiUnQ2q03wgAmRFGDeXzc58NX0NrDijUu0zx3Lns/qZ9VrkSWbNZBFjpWKaeL1fdVeE4TDGm
	I5mRRIsStjQzc2R9b+2VBUhlAqY1nAiBDv0Qnt+9cLiuEICeUwlyl42YdwpmY0ELcy5+u6wz
	mK/jxrYOpzXKDwLq5k4X+hmGuSNWWAN3gHiJqmJZPkhFPUIozZUCeEc76pS/IUN72NfprZmF
	Dp6/QDjDFtfS39bHSWXKVZUbqaMPqlj/z6Ugk027/3GUjHHr8WkeL1ezWepYDY7WSoXwfoAL
	2UXYsMAr/uUncSKlfjvArhsej0S4zbqim2ZY6S8aRWw94J3bSvJR+Nwbs34GPTD4Pg==
Organization: Red Hat, Inc.
Message-ID: <a9ca7154-d63d-c454-0474-d61c68d9e3ed@redhat.com>
Date: Mon, 20 May 2019 11:30:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190520030839.6795-14-peterx@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2ic0y8M0XwjDf5CiwPOpv5XqcLCksopA9"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Mon, 20 May 2019 16:30:08 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v2 13/15] qmp: Expose
 manual_dirty_log_protect via "query-kvm"
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	"Dr . David Alan Gilbert" <dgilbert@redhat.com>,
	Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2ic0y8M0XwjDf5CiwPOpv5XqcLCksopA9
From: Eric Blake <eblake@redhat.com>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Message-ID: <a9ca7154-d63d-c454-0474-d61c68d9e3ed@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 13/15] qmp: Expose
 manual_dirty_log_protect via "query-kvm"
References: <20190520030839.6795-1-peterx@redhat.com>
 <20190520030839.6795-14-peterx@redhat.com>
In-Reply-To: <20190520030839.6795-14-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 5/19/19 10:08 PM, Peter Xu wrote:
> Expose the new capability via "query-kvm" QMP command too so we know
> whether that's turned on on the source VM when we want.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  accel/kvm/kvm-all.c  | 5 +++++
>  include/sysemu/kvm.h | 2 ++
>  qapi/misc.json       | 6 +++++-
>  qmp.c                | 1 +
>  4 files changed, 13 insertions(+), 1 deletion(-)
>=20

> +++ b/qapi/misc.json
> @@ -253,9 +253,13 @@
>  #
>  # @present: true if KVM acceleration is built into this executable
>  #
> +# @manual-dirty-log-protect: true if manual dirty log protect is enabl=
ed
> +#

If we want this exposed (and Paolo is right that we might not), it needs
'(since 4.1)' designation.

>  # Since: 0.14.0
>  ##
> -{ 'struct': 'KvmInfo', 'data': {'enabled': 'bool', 'present': 'bool'} =
}
> +{ 'struct': 'KvmInfo', 'data':
> +  {'enabled': 'bool', 'present': 'bool',
> +   'manual-dirty-log-protect': 'bool' } }
> =20
>  ##
>  # @query-kvm:
> diff --git a/qmp.c b/qmp.c
> index b92d62cd5f..047bef032e 100644
> --- a/qmp.c
> +++ b/qmp.c
> @@ -73,6 +73,7 @@ KvmInfo *qmp_query_kvm(Error **errp)
> =20
>      info->enabled =3D kvm_enabled();
>      info->present =3D kvm_available();
> +    info->manual_dirty_log_protect =3D kvm_manual_dirty_log_protect_en=
abled();
> =20
>      return info;
>  }
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--2ic0y8M0XwjDf5CiwPOpv5XqcLCksopA9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzi1gkACgkQp6FrSiUn
Q2oQsAf9G0YS7R4kPsGquKG22jitDKwR57IPq6wllSSBLM4R1CGOEK/3x7PVq7wO
SKGOZHk57YMJx9F51NI9GVlkZZRGsfI1fz0sigUTSQI1Ay0wndV45LbUtTWXVFkc
LjS4gvTt1QB+x5kIwa2OmWx4aFwl8TEc84ubPI4sVUmQr2oLww7F2kGbUW74L3d8
Xrs1kk8vgp3Z8zrDnLsES5voRRZLO1aNLfnDUilffpwFKmDgH4Nhc1s6MoSmifgx
Gq0qSOcddiAnXqI9qon2rQjCgs74Vy9/ZH9pbtHTIT9IsVtaT2/E5cI5SOwwFu9W
kHDqixVYBjuKZLX654ceXQ2bRnxbeg==
=KLWR
-----END PGP SIGNATURE-----

--2ic0y8M0XwjDf5CiwPOpv5XqcLCksopA9--

