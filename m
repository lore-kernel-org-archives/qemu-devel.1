Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6556DC49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 22:32:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36D82214AF
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 22:32:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36D82214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9zXp-0000kO-QA
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 18:32:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43039)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i9zWX-0000Gk-KZ
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 18:31:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i9zWW-0000UG-Gg
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 18:31:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45724)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1i9zWS-0000R0-B9; Mon, 16 Sep 2019 18:31:04 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E25A018CB8E8;
 Mon, 16 Sep 2019 22:31:02 +0000 (UTC)
Received: from [10.3.116.234] (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 849B56012A;
 Mon, 16 Sep 2019 22:30:59 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>, Sergio Lopez <slp@redhat.com>
References: <20190911161521.59261-1-slp@redhat.com>
 <d47f7e67-2f6a-0dd6-3ab5-93626bfbb02d@redhat.com>
 <6755b34b-b412-9e63-8d25-b7662d0d3860@redhat.com>
 <20190912081414.GC5383@linux.fritz.box> <87y2ytx0wf.fsf@redhat.com>
 <20190912113111.GH5383@linux.fritz.box>
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
Message-ID: <13154181-ab02-3c81-f666-a3b995fe66b7@redhat.com>
Date: Mon, 16 Sep 2019 17:30:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190912113111.GH5383@linux.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="73K7uWr5fVV1Z5H5dNYMctAUVhPLTc5bV"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Mon, 16 Sep 2019 22:31:03 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] nbd/server: attach client channel to the
 export's AioContext
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--73K7uWr5fVV1Z5H5dNYMctAUVhPLTc5bV
Content-Type: multipart/mixed; boundary="seVuTYk5H1NS89XHKlEaji0lBimqKQgFV";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, Sergio Lopez <slp@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Message-ID: <13154181-ab02-3c81-f666-a3b995fe66b7@redhat.com>
Subject: Re: [PATCH] nbd/server: attach client channel to the export's
 AioContext
References: <20190911161521.59261-1-slp@redhat.com>
 <d47f7e67-2f6a-0dd6-3ab5-93626bfbb02d@redhat.com>
 <6755b34b-b412-9e63-8d25-b7662d0d3860@redhat.com>
 <20190912081414.GC5383@linux.fritz.box> <87y2ytx0wf.fsf@redhat.com>
 <20190912113111.GH5383@linux.fritz.box>
In-Reply-To: <20190912113111.GH5383@linux.fritz.box>

--seVuTYk5H1NS89XHKlEaji0lBimqKQgFV
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/12/19 6:31 AM, Kevin Wolf wrote:

>>
>> Yes, I think locking the context during the "if (exp->blk) {" block at=

>> nbd/server.c:1646 should do the trick.

That line number has moved over time; which function are you referring to=
?

>=20
> We need to be careful to avoid locking things twice, so maybe
> nbd_export_put() is already too deep inside the NBD server.
>=20
> Its callers are:
>=20
> * qmp_nbd_server_add(). Like all other QMP handlers in blockdev-nbd.c i=
t
>   neglects to lock the AioContext, but it should do so. The lock is not=

>   only needed for the nbd_export_put() call, but even before.
>=20
> * nbd_export_close(), which in turn is called from:
>     * nbd_eject_notifier(): run in the main thread, not locked
>     * nbd_export_remove():
>         * qmp_nbd_server_remove(): see above
>     * nbd_export_close_all():
>         * bdrv_close_all()
>         * qmp_nbd_server_stop()

Even weirder: nbd_export_put() calls nbd_export_close(), and
nbd_export_close() calls nbd_export_put().  The mutual recursion is
mind-numbing, and the fact that we use get/put instead of ref/unref like
most other qemu code is not making it any easier to reason about.

>=20
> There are also calls from qemu-nbd, but these can be ignored because we=

> don't have iothreads there.
>=20
> I think the cleanest would be to take the lock in the outermost callers=
,
> i.e. all QMP handlers that deal with a specific export, in the eject
> notifier and in nbd_export_close_all().

Okay, I'm trying that (I already tried grabbing the aio_context in
nbd_export_close(), but as you predicted, that deadlocked when a nested
call already encountered the lock taken from an outer call).

>=20
>> On the other hand, I wonder if there is any situation in which calling=

>> to blk_unref() without locking the context could be safe. If there isn=
't
>> any, perhaps we should assert that the lock is held if blk->ctx !=3D N=
ULL
>> to catch this kind of bugs earlier?
>=20
> blk_unref() must be called from the main thread, and if the BlockBacken=
d
> to be unreferenced is not in the main AioContext, the lock must be held=
=2E
>=20
> I'm not sure how to assert that locks are held, though. I once looked
> for a way to do this, but it involved either looking at the internal
> state of pthreads mutexes or hacking up QemuMutex with debug state.

Even if we can only test that in a debug build but not during normal
builds, could any of our CI builds set up that configuration?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--seVuTYk5H1NS89XHKlEaji0lBimqKQgFV--

--73K7uWr5fVV1Z5H5dNYMctAUVhPLTc5bV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl2ADSIACgkQp6FrSiUn
Q2pr8Qf8Cpyhum6yHuRIQ0aO7P6KjIblnXaet+DfQ/c1yUq1itjHYiWycwn+iwo9
niuFMtnNwHMMuRZ9jbgLdMYw9fQ4hxYv86Ww/0r+1a+0elMI3X3DKa8YGoucZsu2
TpLlUQlxdwVs+NVKDNsrgZOz5HnvYqkRDkbBciQFIuK+MltyFU0abZA/FtFBcm/1
0OXq47UABFTFl7pBvQPzONLkywjCYyd8mFpVlIqVGbYx50HhbA1nmFcpfgateku5
kPdYptVVoaSAQMS1XIGfpFsyemZTaJoTYJDWtlE1TOtBWB1k9v2mTz7ZY/WpB9q+
OxasygWTyFFeE23F4jQXOV00OwTZ2A==
=lEJD
-----END PGP SIGNATURE-----

--73K7uWr5fVV1Z5H5dNYMctAUVhPLTc5bV--

