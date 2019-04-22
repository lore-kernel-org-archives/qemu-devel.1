Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593C3C10F11
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 14:00:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E59720656
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 14:00:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E59720656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37824 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIZUY-0002D1-Cb
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 10:00:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hIZTi-0001WU-88
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 09:59:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hIZTg-0007PX-To
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 09:59:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hIZTb-0007Kt-Pe; Mon, 22 Apr 2019 09:59:20 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6B81D307D914;
	Mon, 22 Apr 2019 13:59:18 +0000 (UTC)
Received: from [10.3.116.149] (ovpn-116-149.phx2.redhat.com [10.3.116.149])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2BB1019C5A;
	Mon, 22 Apr 2019 13:59:15 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20190419140557.102725-1-vsementsov@virtuozzo.com>
	<20190419140557.102725-4-vsementsov@virtuozzo.com>
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
Message-ID: <f8e6bdca-cc46-c721-4534-1741530a1215@redhat.com>
Date: Mon, 22 Apr 2019 08:59:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190419140557.102725-4-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="afvh5vPvc2i8957LEVODJ7F9CBzEL21RY"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Mon, 22 Apr 2019 13:59:18 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v3 3/3] iotests: test big qcow2 shrink
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
Cc: kwolf@redhat.com, fam@euphon.net, den@virtuozzo.com, stefanha@redhat.com,
	mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190422135914.lSlFuh1nREhkcIiVOojo0VFvLBfPXC6aE2FeF18OfC8@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--afvh5vPvc2i8957LEVODJ7F9CBzEL21RY
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, fam@euphon.net, stefanha@redhat.com,
 den@virtuozzo.com
Message-ID: <f8e6bdca-cc46-c721-4534-1741530a1215@redhat.com>
Subject: Re: [PATCH v3 3/3] iotests: test big qcow2 shrink
References: <20190419140557.102725-1-vsementsov@virtuozzo.com>
 <20190419140557.102725-4-vsementsov@virtuozzo.com>
In-Reply-To: <20190419140557.102725-4-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/19/19 9:05 AM, Vladimir Sementsov-Ogievskiy wrote:
> This test checks bug in qcow2_process_discards, fixed by previous
> commit.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---

> +# This test checks that qcow2_process_discards does not truncate a dis=
card
> +# request > 2G.
> +# To reproduce bug we need to overflow int by one sequential discard, =
so we
> +# need size > 2G, bigger cluster size (as with default 64k we may have=
 maximum
> +# of 512M sequential data, corresponding to one L1 entry), and we need=
 some
> +# data of the beginning of the disk mapped to the end of file to preve=
nt
> +# bdrv_co_truncate(bs->file) call in qcow2_co_truncate(), which may su=
ccess

s/may success/might succeed/

> +# anyway.
> +
> +size=3D2100M
> +IMGOPTS=3D"cluster_size=3D1M,preallocation=3Dmetadata"
> +
> +_make_test_img $size
> +$QEMU_IO -c 'discard 0 10M' -c 'discard 2090M 10M' \
> +         -c 'write 2090M 10M' -c 'write 0 10M' "$TEST_IMG" | _filter_q=
emu_io
> +
> +# Check that our trick with swapping first and last 10M chunks succeed=
ed.
> +# Otherwise test will may pass even if bdrv_pdiscard() fails in
> +# qcow2_process_discards()
> +$QEMU_IMG map "$TEST_IMG" | _filter_testdir
> +$QEMU_IMG info "$TEST_IMG" | grep size |  _filter_testdir

Nice - that's a lot faster than v1! And makes the test fit in the quick
group after all.

> +
> +$QEMU_IMG -T 'qcow2_process_discards_failed*' resize --shrink "$TEST_I=
MG" 5M

However, I'm quite certain that trace output is not reliable in iotests.
Depending on configure options, traces might not be enabled at all, or
might not go to stderr. Drop the -T '...'.  Even without the trace line,

> +
> +$QEMU_IMG info "$TEST_IMG" | grep size | _filter_testdir

this second image info is sufficient to prove whether the resize had an
effect (post-patch) or exposes the bug (without patch 2/3). That is,
applying this patch but not 2/3, I see this (with my cleanups to
qemu-img info in place, from Kevin's block-next branch):

+++ /home/eblake/qemu/tests/qemu-iotests/250.out.bad	2019-04-22
08:52:26.072968731 -0500
@@ -14,8 +14,9 @@
 virtual size: 2.05 GiB (2202009600 bytes)
 disk size: 24 MiB
 cluster_size: 1048576
+18274@1555941145.999195:qcow2_process_discards_failed_region offset
0x500000 bytes 0x82a00000 ret -5
 Image resized.
 virtual size: 5 MiB (5242880 bytes)
-disk size: 9.01 MiB
+disk size: 19 MiB

where the trace did indeed show show that we had a bug, but where even
without the trace, the difference in size between 19M with incomplete
discards vs. 9M with patch 2/3 is enough to show that patch 2/3 fixes a b=
ug.

> +virtual size: 2.1G (2202009600 bytes)
> +disk size: 24M
> +cluster_size: 1048576
> +Image resized.
> +virtual size: 5.0M (5242880 bytes)
> +disk size: 9.0M
> +cluster_size: 1048576

When Kevin's block-next branch is applied, you'll need this squashed in:

diff --git a/tests/qemu-iotests/250.out b/tests/qemu-iotests/250.out
index 37e37f0c9e7..d1c1c7180b5 100644
--- a/tests/qemu-iotests/250.out
+++ b/tests/qemu-iotests/250.out
@@ -11,11 +11,11 @@ wrote 10485760/10485760 bytes at offset 0
 Offset          Length          Mapped to       File
 0               0xa00000        0x82f00000      TEST_DIR/t.qcow2
 0x82a00000      0xa00000        0x500000        TEST_DIR/t.qcow2
-virtual size: 2.1G (2202009600 bytes)
-disk size: 24M
+virtual size: 2.05 GiB (2202009600 bytes)
+disk size: 24 MiB
 cluster_size: 1048576
 Image resized.
-virtual size: 5.0M (5242880 bytes)
-disk size: 9.0M
+virtual size: 5 MiB (5242880 bytes)
+disk size: 9.01 MiB
 cluster_size: 1048576
 *** done

With the updated output to match changes to qemu-img output, the grammar
fixes, and with the -T option removed,

Reviewed-by: Eric Blake <eblake@redhat.com>
Tested-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--afvh5vPvc2i8957LEVODJ7F9CBzEL21RY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAly9yLIACgkQp6FrSiUn
Q2oT/ggAiT1Ffr2JER7sPiQVlKTZjdtZ3d8VV5VdX7jSsGXUdx4PP+aHhvJz/MFM
n6FyEJ2n2KudCt66/OJbYiqHdwomBThyZxXrpN6BdZfsiobhebQyIzpWQbNErUpP
G1vwsKvcVYv6rTMHzIIn0GYd9hWxMmNCzHk4tnnkfF8D3h6PTjxpYOk1Nk+imkq7
Iq0JO+uF3E+0XXn+0BrmE4eRjAEv8dKGBUswi6zq0ReOS0gI4wNGjEo/ASMGsAhN
ayIkU/2WzNIIXFWRFeK1H0gUDvXAgBiU/6yKQjjPZ8HtnBKd550plXS/dklGZ2kG
2Pah4FdnDtXnDTTYXDDZ6wK+w2uDlQ==
=aKWY
-----END PGP SIGNATURE-----

--afvh5vPvc2i8957LEVODJ7F9CBzEL21RY--

