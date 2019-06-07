Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CC2C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 23:02:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E004D206E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 23:02:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E004D206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54088 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZNs5-0006kN-Mm
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 19:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37619)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hZNpy-0006AK-4I
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 18:59:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hZNpv-00008g-3d
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 18:59:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52056)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hZNpu-0008SI-22
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 18:59:50 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9DF1E86676
 for <qemu-devel@nongnu.org>; Fri,  7 Jun 2019 22:59:40 +0000 (UTC)
Received: from [10.3.116.85] (ovpn-116-85.phx2.redhat.com [10.3.116.85])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3481B1001B01;
 Fri,  7 Jun 2019 22:59:39 +0000 (UTC)
To: qemu-devel@nongnu.org
References: <20190607221414.15962-1-eblake@redhat.com>
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
Message-ID: <ff7768b6-3e6c-6adf-f84b-9f6da3192ae3@redhat.com>
Date: Fri, 7 Jun 2019 17:59:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190607221414.15962-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="b2gQLiR6BrggbH72wFVwRQh1ujFLyDYcT"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Fri, 07 Jun 2019 22:59:45 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] RFC: qio: Improve corking of TLS sessions
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--b2gQLiR6BrggbH72wFVwRQh1ujFLyDYcT
Content-Type: multipart/mixed; boundary="RsrpkuD2yeRTnqXW25W70foPkFDeo3kdd";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Message-ID: <ff7768b6-3e6c-6adf-f84b-9f6da3192ae3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] RFC: qio: Improve corking of TLS sessions
References: <20190607221414.15962-1-eblake@redhat.com>
In-Reply-To: <20190607221414.15962-1-eblake@redhat.com>

--RsrpkuD2yeRTnqXW25W70foPkFDeo3kdd
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 6/7/19 5:14 PM, Eric Blake wrote:
> Our current implementation of qio_channel_set_cork() is pointless for
> TLS sessions: we block the underlying channel, but still hand things
> piecemeal to gnutls which then produces multiple encryption packets.
> Better is to directly use gnutls corking, which collects multiple
> inputs into a single encryption packet.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
>=20
> RFC because unfortunately, I'm not sure I like the results.  My test
> case (using latest nbdkit.git) involves sending 10G of random data
> over NBD using parallel writes (and doing nothing on the server end;
> this is all about timing the data transfer):
>=20
> $ dd if=3D/dev/urandom of=3Drand bs=3D1M count=3D10k
> $ time nbdkit -p 10810 --tls=3Drequire --tls-verify-peer \
>    --tls-psk=3D/tmp/keys.psk --filter=3Dstats null 10g statsfile=3D/dev=
/stderr \
>    --run '~/qemu/qemu-img convert -f raw -W -n --target-image-opts \
>      --object tls-creds-psk,id=3Dtls0,endpoint=3Dclient,dir=3D/tmp,user=
name=3Deblake \
>      rand driver=3Dnbd,server.type=3Dinet,server.host=3Dlocalhost,serve=
r.port=3D10810,tls-creds=3Dtls0'
>=20
> Pre-patch, I measured:
> real	0m34.536s
> user	0m29.264s
> sys	0m4.014s
>=20
> while post-patch, it changed to:
> real	0m36.055s
> user	0m27.685s
> sys	0m10.138s

For grins, I also tried compiling with channel-tls.c doing absolutely
nothing for cork requests (neither TCP_CORKing the underlying socket,
nor using gnutls_record_cork); the results were:

real	0m35.904s
user	0m27.480s
sys	0m10.373s

which is actually faster than using gnutls_record_cork, but slower than
using TCP_CORK.

>=20
> Less time spent in user space, but for this particular qemu-img
> behavior (writing 2M chunks at a time), gnutls is now uncorking huge
> packets and the kernel is doing enough extra work that the overall
> program actually takes longer. :(
>=20
> For smaller I/O patterns, the effects of corking are more likely to be
> beneficial, but I don't have a ready test case to produce that pattern
> (short of creating a guest running fio on a device backed by nbd).
>=20
> Ideas for improvements are welcome; see my recent thread on the
> libguestfs about how TCP_CORK is already a painful interface (it
> requires additional syscalls), and that we may be better off teaching
> qio_channel_writev about taking a flag similar to send(,MSG_MORE),
> which can achieve the same effect as setsockopt(TCP_CORK) but in fewer
> syscalls:
> https://www.redhat.com/archives/libguestfs/2019-June/msg00078.html
> https://www.redhat.com/archives/libguestfs/2019-June/msg00081.html

My thought process at the moment is that there is probably some ideal
size (whether 1500 bytes for traditional Ethernet frame size, or 9000
bytes for gigabit jumbo frame size, or even 64k as a nice round number).
 If we get a channel_write[v]() call with a new QIO_MORE flag set, which
adds less than our magic number of bytes to any already-queued data,
then add it to our queue. If we get a call without the QIO_MORE flag
set, or if the amount of data is larger than the magic size, then it's
time to pass on our buffered data and the rest of the request to the
real channel.  And within channel_writev, treat all but the last
vectored element as if they had the QIO_MORE flag set.

Or put another way, after staring a bit at the current gnutls code, the
implementation of gnutls_record_cork is not very smart - it really
blocks ALL traffic, and memcpy()s data into a holding buffer, then when
you finally gnutls_record_uncork, it tries to flush the entire holding
buffer at once.  The kernel's MSG_MORE algorithm is smarter - it will
only buffer data for up to 200ms or until it has a full packet, at which
point the buffering ends without further user input.  But even when
using TLS, we may be able to emulate some of the kernel's behaviors, by
ignoring QIO_MORE for large packets, while calling gnutls_record_cork
for small packets (no need to duplicate a buffer ourselves if gnutls
already has one) and then uncork it as soon as we've hit our magic
limit, rather than blindly waiting to uncork it after megabytes of data
when the user finally uncorks their channel.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--RsrpkuD2yeRTnqXW25W70foPkFDeo3kdd--

--b2gQLiR6BrggbH72wFVwRQh1ujFLyDYcT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlz67FkACgkQp6FrSiUn
Q2odhQf9GZFgvCBHuq7yKUah0wLJ22lVF3yT8QFwKSvB5HWtLLd4tUuJIcWlVsai
hbhq5Jm5aIWMplwy7oHrZxNESKIUFjvl9B7FpcQCgimuYp2i7KRfmAY68APlvxSq
Vcb1PlDl7XWcygllOyGA6Vx2Zko6kBnfvkUB1bvQgYRrJYqpZmjwkjmV+jZW8tV0
ocUQIqdNjxaEddhENLVlQIXkkkUA8l9BMr3cBrPwsV2Va6cqgQruVgYZDvgl4ItS
j+pAGTNPGXQNlXuxu789ZWvInAzUqD4EBvtYKOAq3McawonBD7A+YICm5UhxWorg
oQOvi7H67X+PtGA/ePQqpeajQ6wD5g==
=UScr
-----END PGP SIGNATURE-----

--b2gQLiR6BrggbH72wFVwRQh1ujFLyDYcT--

