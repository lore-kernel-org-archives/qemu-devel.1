Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28690C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 14:33:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E682B22CE3
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 14:33:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E682B22CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1Acr-0007z5-FV
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 10:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49742)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i1AaV-000776-JV
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:30:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i1AaT-0007wL-Ki
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:30:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56404)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1i1AaP-0007tL-7v; Fri, 23 Aug 2019 10:30:41 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E1E003007C53;
 Fri, 23 Aug 2019 14:30:39 +0000 (UTC)
Received: from [10.3.116.234] (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6059D6CE77;
 Fri, 23 Aug 2019 14:30:37 +0000 (UTC)
To: QEMU <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, nbd@other.debian.org,
 libguestfs@redhat.com
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
Message-ID: <25ead363-4f37-5450-b985-1876374e314d@redhat.com>
Date: Fri, 23 Aug 2019 09:30:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KoNlDQdYXupYuaYo47M6gS1lgKsKGawn8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Fri, 23 Aug 2019 14:30:39 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] cross-project patches: Add NBD Fast Zero support
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KoNlDQdYXupYuaYo47M6gS1lgKsKGawn8
Content-Type: multipart/mixed; boundary="9Zhp6P2yeYw46OWfvoMffdRgBkDhdXNwZ";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: QEMU <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, nbd@other.debian.org,
 libguestfs@redhat.com
Message-ID: <25ead363-4f37-5450-b985-1876374e314d@redhat.com>
Subject: cross-project patches: Add NBD Fast Zero support

--9Zhp6P2yeYw46OWfvoMffdRgBkDhdXNwZ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

This is a cover letter to a series of patches being proposed in tandem
to four different projects:
- nbd: Document a new NBD_CMD_FLAG_FAST_ZERO command flag
- qemu: Implement the flag for both clients and server
- libnbd: Implement the flag for clients
- nbdkit: Implement the flag for servers, including the nbd passthrough
client

If you want to test the patches together, I've pushed a 'fast-zero'
branch to each of:
https://repo.or.cz/nbd/ericb.git/shortlog/refs/heads/fast-zero
https://repo.or.cz/qemu/ericb.git/shortlog/refs/heads/fast-zero
https://repo.or.cz/libnbd/ericb.git/shortlog/refs/heads/fast-zero
https://repo.or.cz/nbdkit/ericb.git/shortlog/refs/heads/fast-zero


I've run several tests to demonstrate why this is useful, as well as
prove that because I have multiple interoperable projects, it is worth
including in the NBD standard.  The original proposal was here:
https://lists.debian.org/nbd/2019/03/msg00004.html
where I stated:

> I will not push this without both:
> - a positive review (for example, we may decide that burning another
> NBD_FLAG_* is undesirable, and that we should instead have some sort
> of NBD_OPT_ handshake for determining when the server supports
> NBD_CMF_FLAG_FAST_ZERO)
> - a reference client and server implementation (probably both via qemu,=

> since it was qemu that raised the problem in the first place)

Consensus on that thread seemed to be that a new NBD_FLAG was okay; and
this thread solves the second bullet of having reference implementations.=


Here's what I did for testing full-path interoperability:

nbdkit memory -> qemu-nbd -> nbdkit nbd -> nbdsh

$ nbdkit -p 10810 --filter=3Dnozero --filter=3Ddelay memory 1m delay-writ=
e=3D3
zeromode=3Demulate
$ qemu-nbd -p 10811 -f raw nbd://localhost:10810
$ nbdkit -p 10812 nbd nbd://localhost:10811
$ time nbdsh --connect nbd://localhost:10812 -c 'buf =3D h.zero(512, 0)'
# takes more than 3 seconds, but succeeds
$ time nbdsh --connect nbd://localhost:10812 -c 'buf =3D h.zero(512, 0,
nbd.CMD_FLAG_FAST_ZERO)'
# takes less than 1 second to fail with ENOTSUP

And here's some demonstrations on why the feature matters, starting with
this qemu thread as justification:
https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg06389.html

First, I had to create a scenario where falling back to writes is
noticeably slower than performing a zero operation, and where
pre-zeroing also shows an effect.  My choice: let's test 'qemu-img
convert' on an image that is half-sparse (every other megabyte is a
hole) to an in-memory nbd destination.  Then I use a series of nbdkit
filters to force the destination to behave in various manners:
 log logfile=3D>(sed ...|uniq -c) (track how many normal/fast zero
requests the client makes)
 nozero $params (fine-tune how zero requests behave - the parameters
zeromode and fastzeromode are the real drivers of my various tests)
 blocksize maxdata=3D256k (allows large zero requests, but forces large
writes into smaller chunks, to magnify the effects of write delays and
allow testing to provide obvious results with a smaller image)
 delay delay-write=3D20ms delay-zero=3D5ms (also to magnify the effects o=
n a
smaller image, with writes penalized more than zeroing)
 stats statsfile=3D/dev/stderr (to track overall time and a decent summar=
y
of how much I/O occurred).
 noextents (forces the entire image to report that it is allocated,
which eliminates any testing variability based on whether qemu-img uses
that to bypass a zeroing operation [1])

So here's my one-time setup, followed by repetitions of the nbdkit
command with different parameters to the nozero filter to explore
different behaviors.

$ qemu-img create -f qcow2 src 100m
$ for i in `seq 0 2 99`; do qemu-io -f qcow2 -c "w ${i}m 1m" src; done
$ nbdkit -U - --filter=3Dlog --filter=3Dnozero --filter=3Dblocksize \
  --filter=3Ddelay --filter=3Dstats --filter=3Dnoextents memory 100m \
  logfile=3D>(sed -n '/Zero.*\.\./ s/.*\(fast=3D.\).*/\1/p' |sort|uniq -c=
) \
  statsfile=3D/dev/stderr delay-write=3D20ms delay-zero=3D5s maxdata=3D25=
6k \
  --run 'qemu-img convert -n -f qcow2 -O raw src $nbd' $params

Establish a baseline: when qemu-img does not see write zero support at
all (such as when talking to /dev/nbd0, because the kernel NBD
implementation still does not support write zeroes), qemu is forced to
write the entire disk, including the holes, but doesn't waste any time
pre-zeroing or checking block status for whether the disk is zero (the
default of the nozero filter is to turn off write zero advertisement):

params=3D
elapsed time: 8.54488 s
write: 400 ops, 104857600 bytes, 9.81712e+07 bits/s

Next, let's emulate what qemu 3.1 was like, with a blind pre-zeroing
pass of the entire image without regards to whether that pass is fast or
slow.  For this test, it was easier to use modern qemu and merely ignore
the fast zero bit in nbdkit, but the numbers should be similar when
actually using older qemu.  If qemu guessed right that pre-zeroing is
fast, we see:

params=3D'zeromode=3Dplugin fastzeromode=3Dignore'
elapsed time: 4.30183 s
write: 200 ops, 52428800 bytes, 9.75005e+07 bits/s
zero: 4 ops, 104857600 bytes, 1.95001e+08 bits/s
      4 fast=3D1

which is definite win - instead of having to write the half of the image
that was zero on the source, the fast pre-zeroing pass already cleared
it (qemu-img currently breaks write zeroes into 32M chunks [1], and thus
requires 4 zero requests to pre-zero the image).  But if qemu guesses wro=
ng:

params=3D'zeromode=3Demulate fastzeromode=3Dignore'
elapsed time: 12.5065 s
write: 600 ops, 157286400 bytes, 1.00611e+08 bits/s
      4 fast=3D1

Ouch - that is actually slower than the case when zeroing is not used at
all, because the zeroes turned into writes result in performing double
the I/O over the data portions of the file (once during the pre-zero
pass, then again during the data).  The qemu 3.1 behavior is very
bi-polar in nature, and we don't like that.

So qemu 4.0 introduced BDRV_REQ_NO_FALLBACK, which qemu uses during the
pre-zero request to fail quickly if pre-zeroing is not viable. At the
time, NBD did not have a way to support fast zero requests, so qemu
blindly assumes that pre-zeroing is not viable over NBD:

params=3D'zeromode=3Demulate fastzeromode=3Dnone'
elapsed time: 8.32433 s
write: 400 ops, 104857600 bytes, 1.00772e+08 bits/s
     50 fast=3D0

When zeroing is slow, our time actually beats the baseline by about 0.2
seconds (although zeroing still turned into writes, the use of zero
requests results in less network traffic; you also see that there are 50
zero requests, one per hole, rather than 4 requests for pre-zeroing the
image).  So we've avoided the pre-zeroing penalty.  However:

params=3D'zeromode=3Dplugin fastzeromode=3Dnone'
elapsed time: 4.53951 s
write: 200 ops, 52428800 bytes, 9.23955e+07 bits/s
zero: 50 ops, 52428800 bytes, 9.23955e+07 bits/s
     50 fast=3D0

when zeroing is fast, we're still 0.2 seconds slower than the
pre-zeroing behavior (zeroing runs fast, but one request per hole is
still more transactions than pre-zeroing used to use).  The qemu 4.0
decision thus regained the worst degradation seen in 3.1 when zeroing is
slow, but at a penalty to the case when zeroing is fast.

Since guessing is never as nice as knowing, let's repeat the test, but
now exploiting the new NBD fast zero:

params=3D'zeromode=3Demulate'
elapsed time: 8.41174 s
write: 400 ops, 104857600 bytes, 9.9725e+07 bits/s
     50 fast=3D0
      1 fast=3D1

Good: when zeroes are not fast, qemu-img's initial fast-zero request
immediately fails, and then it switches back to writing the entire image
using regular zeroing for the holes; performance is comparable to the
baseline and to the qemu 4.0 behavior.

params=3D'zeromode=3Dplugin'
elapsed time: 4.31356 s
write: 200 ops, 52428800 bytes, 9.72354e+07 bits/s
zero: 4 ops, 104857600 bytes, 1.94471e+08 bits/s
      4 fast=3D1

Good: when zeroes are fast, qemu-img is able to use pre-zeroing on the
entire image, resulting in fewer zero transactions overall, getting us
back to the qemu 3.1 maximum performance (and better than the 4.0 behavio=
r).

I hope you enjoyed reading this far, and agree with my interpretation of
the numbers about why this feature is useful!



[1] Orthogonal to these patches are other ideas I have for improving the
NBD protocol in its effects to qemu-img convert, which will result in
later cross-project patches:
- NBD should have a way to advertise (probably via NBD_INFO_ during
NBD_OPT_GO) if the initial image is known to begin life with all zeroes
(if that is the case, qemu-img can skip the extents calls and
pre-zeroing pass altogether)
- improving support to allow NBD to pass larger zero requests (qemu is
currently capping zero requests at 32m based on NBD_INFO_BLOCK_SIZE, but
could easily go up to ~4G with proper info advertisement of maximum zero
request sizing, or if we introduce 64-bit commands to the NBD protocol)

Given that NBD extensions need not be present in every server, each
orthogonal improvement should be tested in isolation to show that it
helps, even though qemu-img will probably use all of the extensions at
once when the server supports all of them.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--9Zhp6P2yeYw46OWfvoMffdRgBkDhdXNwZ--

--KoNlDQdYXupYuaYo47M6gS1lgKsKGawn8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1f+IwACgkQp6FrSiUn
Q2rltwf/X0iV41HBok9+Z5w3Fj7k5GVT0VpEHZzoFOlgF9vW0NLOmdcjZAAlPxMs
v03MBrmkqNCpp1U+aXInhfA+/GXZ0G7ETJ5RRAj39rwSZOOLLYtwIZiyi04nSSvE
c0y8JqDU/Wylnb4BPf/Fhd2PFKeR8pgLS0O+ZLth0ycftV0NEH/tB4Ytmar/hXKD
EQn93kwyuofx/0NBPiJnlwMHlFLBQVMRtvsOCrt7EXWMRd/6F1tm6F1MY+tlkzrK
+PyMgsMSbiDvrx23IFZhdFoP1daKCmN5S/Rbw44ohrbyJ9P0B18Ov4KWp9/WYguq
RLG6+Q9tnU0KANaIlvI6PYmKZT2c0A==
=cgaX
-----END PGP SIGNATURE-----

--KoNlDQdYXupYuaYo47M6gS1lgKsKGawn8--

