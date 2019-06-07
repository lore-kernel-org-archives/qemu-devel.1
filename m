Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACA4C28EBD
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 02:28:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2A9720825
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 02:28:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2A9720825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45530 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZ4ch-0005rk-1e
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 22:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45220)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hZ4bk-0005PE-EG
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 22:27:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hZ4bj-0004td-G5
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 22:27:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55340)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hZ4bh-0004qA-8A; Thu, 06 Jun 2019 22:27:53 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 877EAC045129;
 Fri,  7 Jun 2019 02:27:38 +0000 (UTC)
Received: from [10.3.116.85] (ovpn-116-85.phx2.redhat.com [10.3.116.85])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6435559471;
 Fri,  7 Jun 2019 02:27:32 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20190606184159.979-1-jsnow@redhat.com>
 <20190606184159.979-5-jsnow@redhat.com>
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
Message-ID: <0d0c47ea-20ce-ba00-0ffd-df35975b71ea@redhat.com>
Date: Thu, 6 Jun 2019 21:27:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190606184159.979-5-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jW1Rcezs4WRTWfMmWxZQ4eKSOjoOsVKq2"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Fri, 07 Jun 2019 02:27:43 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 4/5] block/qcow2-bitmap: Count queued
 bitmaps towards nb_bitmaps
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
 vsementsov@virtuozzo.com, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jW1Rcezs4WRTWfMmWxZQ4eKSOjoOsVKq2
Content-Type: multipart/mixed; boundary="r5NMZvXTj97187P2yCnWuaCXqnbw7sUQY";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Max Reitz <mreitz@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 vsementsov@virtuozzo.com
Message-ID: <0d0c47ea-20ce-ba00-0ffd-df35975b71ea@redhat.com>
Subject: Re: [PATCH 4/5] block/qcow2-bitmap: Count queued bitmaps towards
 nb_bitmaps
References: <20190606184159.979-1-jsnow@redhat.com>
 <20190606184159.979-5-jsnow@redhat.com>
In-Reply-To: <20190606184159.979-5-jsnow@redhat.com>

--r5NMZvXTj97187P2yCnWuaCXqnbw7sUQY
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 6/6/19 1:41 PM, John Snow wrote:
> When we check to see if we can store a bitmap, we don't check how many
> we've queued up. This can cause a problem saving bitmaps on close
> instead of when we request them to be added. With the stricter add
> interface, prohibit these bitmaps specifically.
>=20
> To match, make the remove interface more strict as well; now rejecting
> any requests to remove bitmaps that were never queued for storage.
>=20
> We don't need to "find" the bitmap when the interface has been given th=
e
> bitmap explicitly, but this is done to make sure that the bitmap given
> actually does belong to the bs we were passed as a paranoia check to
> enforce consistency.
>=20
> ---

Oops - that marker...

>=20
> "What about directory size?" Please see the following patch.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>

=2E..renders the S-o-b invisible.

> +++ b/block/qcow2-bitmap.c
> @@ -1402,6 +1402,23 @@ static Qcow2Bitmap *find_bitmap_by_name(Qcow2Bit=
mapList *bm_list,
>      return NULL;
>  }
> =20
> +static int qcow2_remove_queued_dirty_bitmap(
> +    BlockDriverState *bs, const char *name, Error **errp)
> +{
> +    BDRVQcow2State *s =3D bs->opaque;
> +    BdrvDirtyBitmap *bitmap =3D bdrv_find_dirty_bitmap(bs, name);
> +    if (!bitmap) {
> +        error_setg(errp, "Node '%s' has no stored or enqueued bitmap '=
%s'",
> +                   bdrv_get_node_name(bs), name);
> +        return -ENOENT;
> +    }
> +    assert(s->nb_queued_bitmaps > 0);
> +    assert(bdrv_dirty_bitmap_get_persistence(bitmap));
> +    s->nb_queued_bitmaps -=3D 1;

I tend to use -- over -=3D 1.

> @@ -1667,6 +1686,8 @@ int qcow2_add_persistent_dirty_bitmap(BlockDriver=
State *bs,
>          goto fail;
>      }
> =20
> +    s->nb_queued_bitmaps +=3D 1;

And again, for ++

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--r5NMZvXTj97187P2yCnWuaCXqnbw7sUQY--

--jW1Rcezs4WRTWfMmWxZQ4eKSOjoOsVKq2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlz5y5MACgkQp6FrSiUn
Q2owBAgAjzbKLSMOdhJi+x/t5Ko7t5UePMlENTDuZKoUifc9thIdA2SJYrcTYZkq
1jniPvi00K4S0GeLLi7aXumwp83q2eqB+cFMMs7wIap3CtXOrWz7Rw6B3HtRFmwt
vOYuBhvso4HQ/Z0xi2A35k0KueCQjs/8ZgtaR0BZN5nyt++uz89SGpfs34d9Bryl
6H9EGeg9+Y9b8+K0OeKq4CeL/Oj2AI+ZLz0MFgYMO/FoPrlSJAiD/H1VwqkNU9Md
G+GbkX5YrFOd8CwGmbPDxL4mVtUIy379eNdUgKBUFyxtOsVcvYacMOHTNZCjjPsQ
MXyNE75zF+tOwXiQrQqrQgWdR8rzFA==
=VYtn
-----END PGP SIGNATURE-----

--jW1Rcezs4WRTWfMmWxZQ4eKSOjoOsVKq2--

