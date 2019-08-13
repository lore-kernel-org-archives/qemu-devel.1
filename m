Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBBCC433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 15:19:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDE962067D
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 15:19:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDE962067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxYa2-00056D-S7
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 11:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47550)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hxYZF-00047t-M9
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 11:18:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hxYZD-0007eY-OM
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 11:18:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49880)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hxYZ9-0007Zx-Pc; Tue, 13 Aug 2019 11:18:27 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F0060C034E71;
 Tue, 13 Aug 2019 15:18:25 +0000 (UTC)
Received: from [10.3.117.22] (ovpn-117-22.phx2.redhat.com [10.3.117.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 59B2110013A1;
 Tue, 13 Aug 2019 15:18:17 +0000 (UTC)
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20190813093047.27948-1-thuth@redhat.com>
 <20190813093047.27948-2-thuth@redhat.com>
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
Message-ID: <04a21d67-7a8b-20bf-2d8c-56d714ebb07d@redhat.com>
Date: Tue, 13 Aug 2019 10:18:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190813093047.27948-2-thuth@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cQqwl0UnpkIGQ1udLXRHD2KQ6Z2x3l7yb"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Tue, 13 Aug 2019 15:18:26 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/6] tests/libqos: Make generic virtio code
 independent from global_qtest
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
Cc: Fam Zheng <fam@euphon.net>, Laurent Vivier <lvivier@redhat.com>,
 qemu-block@nongnu.org, Amit Shah <amit@kernel.org>,
 Jason Wang <jasowang@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Greg Kurz <groug@kaod.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cQqwl0UnpkIGQ1udLXRHD2KQ6Z2x3l7yb
Content-Type: multipart/mixed; boundary="7MnpAFX2nFGj8AZzltoL8zo5O24YuFyIu";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Amit Shah <amit@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Greg Kurz <groug@kaod.org>
Message-ID: <04a21d67-7a8b-20bf-2d8c-56d714ebb07d@redhat.com>
Subject: Re: [PATCH 1/6] tests/libqos: Make generic virtio code independent
 from global_qtest
References: <20190813093047.27948-1-thuth@redhat.com>
 <20190813093047.27948-2-thuth@redhat.com>
In-Reply-To: <20190813093047.27948-2-thuth@redhat.com>

--7MnpAFX2nFGj8AZzltoL8zo5O24YuFyIu
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/13/19 4:30 AM, Thomas Huth wrote:
> The libqos library functions should never depend on global_qtest,
> since these functions might be used in tests that track multiple
> test states. Pass around a pointer to the QTestState instead.

Thanks for picking up on my initial RFC along these lines a couple years
ago now; it's taking us a while, but these cleanups are worthwhile.

>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---

> @@ -193,7 +193,7 @@ void qvring_init(QTestState *qts, const QGuestAlloc=
ator *alloc, QVirtQueue *vq,
>                   0);
>  }
> =20
> -QVRingIndirectDesc *qvring_indirect_desc_setup(QVirtioDevice *d,
> +QVRingIndirectDesc *qvring_indirect_desc_setup(QTestState *qs, QVirtio=
Device *d,
>                                          QGuestAllocator *alloc, uint16=
_t elem)
>  {

Pre-existing, but indentation is off; maybe you want to fix that while he=
re.


> -void qvirtqueue_kick(QVirtioDevice *d, QVirtQueue *vq, uint32_t free_h=
ead)
> +void qvirtqueue_kick(QTestState *qts, QVirtioDevice *d, QVirtQueue *vq=
,
> +                     uint32_t free_head)
>  {
>      /* vq->avail->idx */
> -    uint16_t idx =3D readw(vq->avail + 2);
> +    uint16_t idx =3D qtest_readw(qts, vq->avail + 2);
>      /* vq->used->flags */
>      uint16_t flags;
>      /* vq->used->avail_event */
>      uint16_t avail_event;
> =20
>      /* vq->avail->ring[idx % vq->size] */
> -    writew(vq->avail + 4 + (2 * (idx % vq->size)), free_head);
> +    qtest_writew(qts, vq->avail + 4 + (2 * (idx % vq->size)), free_hea=
d);
>      /* vq->avail->idx */
> -    writew(vq->avail + 2, idx + 1);
> +    qtest_writew(qts, vq->avail + 2, idx + 1);
> =20
>      /* Must read after idx is updated */
> -    flags =3D readw(vq->avail);
> -    avail_event =3D readw(vq->used + 4 +
> +    flags =3D qtest_readw(qts, vq->avail);
> +    avail_event =3D qtest_readw(qts, vq->used + 4 +
>                                  sizeof(struct vring_used_elem) * vq->s=
ize);

Here as well.

> @@ -333,23 +337,25 @@ bool qvirtqueue_get_buf(QVirtQueue *vq, uint32_t =
*desc_idx, uint32_t *len)
>          sizeof(struct vring_used_elem);
> =20
>      if (desc_idx) {
> -        *desc_idx =3D readl(elem_addr + offsetof(struct vring_used_ele=
m, id));
> +        *desc_idx =3D qtest_readl(qts, elem_addr +
> +                                     offsetof(struct vring_used_elem, =
id));

This one works as-is, although it gives me a double-take when the
indentation is not right after a ( in the line above.  I probably would
have written either:

        *desc_idx =3D qtest_readl(qts,
                                elem_addr + offsetof(struct
vring_used_elem, id));

or

        *desc_idx =3D qtest_readl(qts, (elem_addr +
                                      offsetof(struct vring_used_elem,
id)));

or even introduce a temp variable to bring down the line length.


> @@ -131,17 +131,20 @@ void qvirtqueue_cleanup(const QVirtioBus *bus, QV=
irtQueue *vq,
> =20
>  void qvring_init(QTestState *qts, const QGuestAllocator *alloc, QVirtQ=
ueue *vq,
>                   uint64_t addr);
> -QVRingIndirectDesc *qvring_indirect_desc_setup(QVirtioDevice *d,
> +QVRingIndirectDesc *qvring_indirect_desc_setup(QTestState *qs, QVirtio=
Device *d,
>                                          QGuestAllocator *alloc, uint16=
_t elem);

Another pre-existing odd indentation (here, it looks like line length
was the reason).

Indentation is minor, so:

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--7MnpAFX2nFGj8AZzltoL8zo5O24YuFyIu--

--cQqwl0UnpkIGQ1udLXRHD2KQ6Z2x3l7yb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1S1LgACgkQp6FrSiUn
Q2pIiwf9G1QH1USeXKAiL+2sbSdY5dyWcFnE6ng++4MzFg+M4shKaeegqb4okOTj
BnSYm7cdjJfidfraaMKb7e3Mv317VQIVYfzH2qS3BrN3K4ukSzpaOUtzEKfWWAYo
lSH7TEZjLTApOnNkrH7beLzEArZYF7B50VoP/PQieePIKh/Lqz0YcBjPu2kSmhG6
+k9l6CcrlBXHfMY64/hOshqFj26VrfQcw3u9qWjMGiHYFXU1VS5MO02xoYS+NWxX
zheFGvg6xUw/0VPkmPqsCASmrkWqP8knhoWL/w02urEfQADOgjwTk23mGcduln39
C+XU8khjyy81disVndw5COM5xB6ADQ==
=AySs
-----END PGP SIGNATURE-----

--cQqwl0UnpkIGQ1udLXRHD2KQ6Z2x3l7yb--

