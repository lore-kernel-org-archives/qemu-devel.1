Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7371C282CE
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 20:12:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B73B2146F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 20:12:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B73B2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46321 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCVCB-0005GL-5S
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 16:12:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hCVBK-0004ic-Ou
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 16:11:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hCVBI-0001el-RC
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 16:11:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56908)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hCVA3-0000HK-3f; Fri, 05 Apr 2019 16:11:06 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D4B4FC049E20;
	Fri,  5 Apr 2019 20:04:06 +0000 (UTC)
Received: from [10.3.116.67] (ovpn-116-67.phx2.redhat.com [10.3.116.67])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 370E9648A3;
	Fri,  5 Apr 2019 20:04:04 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20190403030526.12258-1-eblake@redhat.com>
	<20190403030526.12258-3-eblake@redhat.com>
	<ae484c62-04f9-5b4e-03d0-bf368ed7714a@virtuozzo.com>
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
Message-ID: <d974e0e2-ced3-bff3-d75c-84a41013bffa@redhat.com>
Date: Fri, 5 Apr 2019 15:04:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ae484c62-04f9-5b4e-03d0-bf368ed7714a@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="m5xL2oQ3pBQKAV2l2OAC21m1HC1MKDGl5"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Fri, 05 Apr 2019 20:04:06 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 2/7] nbd/server: Trace server noncompliance
 on unaligned requests
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
Cc: "jsnow@redhat.com" <jsnow@redhat.com>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405200403.NvjmZdsBig5Kbhbv0jEyTmNBJqmcX3De817ZkbPsk2w@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--m5xL2oQ3pBQKAV2l2OAC21m1HC1MKDGl5
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Message-ID: <d974e0e2-ced3-bff3-d75c-84a41013bffa@redhat.com>
Subject: Re: [PATCH 2/7] nbd/server: Trace server noncompliance on unaligned
 requests
References: <20190403030526.12258-1-eblake@redhat.com>
 <20190403030526.12258-3-eblake@redhat.com>
 <ae484c62-04f9-5b4e-03d0-bf368ed7714a@virtuozzo.com>
In-Reply-To: <ae484c62-04f9-5b4e-03d0-bf368ed7714a@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/5/19 9:39 AM, Vladimir Sementsov-Ogievskiy wrote:
> 03.04.2019 6:05, Eric Blake wrote:
>> We've recently added traces for clients to flag server non-compliance;=

>> let's do the same for servers to flag client non-compliance. According=


Thus, s/Trace server/Trace client/ in the subject line.

>>
>> Qemu as client used to have one spot where it sent non-compliant
>> requests: if the server sends an unaligned reply to
>> NBD_CMD_BLOCK_STATUS, and the client was iterating over the entire
>> disk, the next request would start at that unaligned point; this was
>> fixed in commit a39286dd when the client was taught to work around
>> server non-compliance; but is equally fixed if the server is patched
>> to not send unaligned replies in the first place (the next few patches=

>> will address that).

I'll have to reword this now that we know 4.0 will still have some of
those server bugs in place (as the tail of this series is deferred to 4.1=
).


>> @@ -660,6 +662,8 @@ static int nbd_negotiate_handle_info(NBDClient *cl=
ient, uint16_t myflags,
>>
>>       if (client->opt =3D=3D NBD_OPT_GO) {
>>           client->exp =3D exp;
>> +        client->check_align =3D blocksize ?
>> +            blk_get_request_alignment(exp->blk) : 0;
>=20
> I think better set in same place, where sizes[0] set, or use sizes[0] h=
ere or add separate local
> varibale for it, so that, if "sizes[0] =3D" changes somehow, we will no=
t forget to fix this place too.

I don't want to set client->check_align for NBD_OPT_INFO; but I can
indeed use a temporary variable or hoist the computation so that it is
all in one spot.


>> +++ b/nbd/trace-events
>> @@ -71,4 +71,5 @@ nbd_co_send_extents(uint64_t handle, unsigned int ex=
tents, uint32_t id, uint64_t
>>   nbd_co_send_structured_error(uint64_t handle, int err, const char *e=
rrname, const char *msg) "Send structured error reply: handle =3D %" PRIu=
64 ", error =3D %d (%s), msg =3D '%s'"
>>   nbd_co_receive_request_decode_type(uint64_t handle, uint16_t type, c=
onst char *name) "Decoding type: handle =3D %" PRIu64 ", type =3D %" PRIu=
16 " (%s)"
>>   nbd_co_receive_request_payload_received(uint64_t handle, uint32_t le=
n) "Payload received: handle =3D %" PRIu64 ", len =3D %" PRIu32
>> +nbd_co_receive_align_compliance(const char *op) "client sent non-comp=
liant unaligned %s request"
>=20
> Don't you want print request->from, request->len and client->check_alig=
n as well?

Wouldn't hurt.

>=20
>>   nbd_trip(void) "Reading request"
>>
>=20
> Patch seems correct anyway, so if you are in a hurry, it's OK as is:
>=20
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20

Here's what I'll squash in; I think it is obvious enough to still keep
your R-b, if I send the pull request before you reply back.

diff --git i/nbd/server.c w/nbd/server.c
index 3040ceb5606..cb38dfe6902 100644
--- i/nbd/server.c
+++ w/nbd/server.c
@@ -535,6 +535,7 @@ static int nbd_negotiate_handle_info(NBDClient
*client, uint16_t myflags,
     bool blocksize =3D false;
     uint32_t sizes[3];
     char buf[sizeof(uint64_t) + sizeof(uint16_t)];
+    uint32_t check_align =3D 0;

     /* Client sends:
         4 bytes: L, name length (can be 0)
@@ -611,7 +612,7 @@ static int nbd_negotiate_handle_info(NBDClient
*client, uint16_t myflags,
      * whether this is OPT_INFO or OPT_GO. */
     /* minimum - 1 for back-compat, or actual if client will obey it. */=

     if (client->opt =3D=3D NBD_OPT_INFO || blocksize) {
-        sizes[0] =3D blk_get_request_alignment(exp->blk);
+        check_align =3D sizes[0] =3D blk_get_request_alignment(exp->blk)=
;
     } else {
         sizes[0] =3D 1;
     }
@@ -662,8 +663,7 @@ static int nbd_negotiate_handle_info(NBDClient
*client, uint16_t myflags,

     if (client->opt =3D=3D NBD_OPT_GO) {
         client->exp =3D exp;
-        client->check_align =3D blocksize ?
-            blk_get_request_alignment(exp->blk) : 0;
+        client->check_align =3D check_align;
         QTAILQ_INSERT_TAIL(&client->exp->clients, client, next);
         nbd_export_get(client->exp);
         nbd_check_meta_export(client);
@@ -2136,7 +2136,10 @@ static int nbd_co_receive_request(NBDRequestData
*req, NBDRequest *request,
          * The block layer gracefully handles unaligned requests, but
          * it's still worth tracing client non-compliance
          */
-
trace_nbd_co_receive_align_compliance(nbd_cmd_lookup(request->type));
+        trace_nbd_co_receive_align_compliance(nbd_cmd_lookup(request->ty=
pe,
+                                                             request->fr=
om,
+                                                             request->le=
n,
+
client->check_align));
     }
     valid_flags =3D NBD_CMD_FLAG_FUA;
     if (request->type =3D=3D NBD_CMD_READ && client->structured_reply) {=

diff --git i/nbd/trace-events w/nbd/trace-events
index 87a2b896c35..ec2d46c9247 100644
--- i/nbd/trace-events
+++ w/nbd/trace-events
@@ -71,5 +71,5 @@ nbd_co_send_extents(uint64_t handle, unsigned int
extents, uint32_t id, uint64_t
 nbd_co_send_structured_error(uint64_t handle, int err, const char
*errname, const char *msg) "Send structured error reply: handle =3D %"
PRIu64 ", error =3D %d (%s), msg =3D '%s'"
 nbd_co_receive_request_decode_type(uint64_t handle, uint16_t type,
const char *name) "Decoding type: handle =3D %" PRIu64 ", type =3D %" PRI=
u16
" (%s)"
 nbd_co_receive_request_payload_received(uint64_t handle, uint32_t len)
"Payload received: handle =3D %" PRIu64 ", len =3D %" PRIu32
-nbd_co_receive_align_compliance(const char *op) "client sent
non-compliant unaligned %s request"
+nbd_co_receive_align_compliance(const char *op, uint64_t from, uint32_t
len, uint32_t align) "client sent non-compliant unaligned %s request:
from=3D0x%" PRIx64 ", len=3D0x%x, align=3D0x%x"
 nbd_trip(void) "Reading request"



--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--m5xL2oQ3pBQKAV2l2OAC21m1HC1MKDGl5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyntLMACgkQp6FrSiUn
Q2qT3gf/ROXInjjyOjN95PZ+8hlIzMItyPQWhriDyjrCBnm9P84ESo7Y16lrzT76
hlB9lXe/XHvGNExAtUuIuoF45O1zJKZzfez+8muowIj6OWRAjL34v+kbuk4VT6/G
uN/kseP0ui/6TJErUNAzLbBQ8HCrbkjIAOBBC6Cr9+fWLtGueQJV7TCVwVzLJzEu
3kgP0238FPPM/OfmhTMpsorrwoEBg+wvfwQSBxv56IjfMqfBu7AgNTPHq6TorJVI
/gZ2Tg/MwG3z+7Bv2sRUuOcHezjhZxieMCXDewghOZ4Pks6g4VeLnadr4lLURyOM
B/e/gmO4IgYo5fKG4uudDVeXVOy/9A==
=dtLP
-----END PGP SIGNATURE-----

--m5xL2oQ3pBQKAV2l2OAC21m1HC1MKDGl5--

