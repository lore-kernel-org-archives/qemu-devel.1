Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21ACDC5ACD9
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 14:14:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB3F0207E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 14:14:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB3F0207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46954 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haL3g-00058Z-3r
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 10:14:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55413)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1haKtl-000673-73
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 10:03:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1haKtj-0003f0-Qc
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 10:03:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39986)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1haKtj-00031E-EJ
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 10:03:43 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 26F1146202
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2019 14:02:54 +0000 (UTC)
Received: from [10.3.116.85] (ovpn-116-85.phx2.redhat.com [10.3.116.85])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B57E160BF3;
 Mon, 10 Jun 2019 14:02:53 +0000 (UTC)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20190607221414.15962-1-eblake@redhat.com>
 <20190610090811.GC7809@redhat.com>
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
Message-ID: <fd11c04f-c02a-8565-9f3b-e7ff83262725@redhat.com>
Date: Mon, 10 Jun 2019 09:02:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190610090811.GC7809@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GNgjc5b1idjezKNb6qG9gbf8ER1Z0Q3Wd"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Mon, 10 Jun 2019 14:02:54 +0000 (UTC)
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GNgjc5b1idjezKNb6qG9gbf8ER1Z0Q3Wd
Content-Type: multipart/mixed; boundary="iEre6L0q8cXkjWnlLXCfbstk2i91XyNLd";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <fd11c04f-c02a-8565-9f3b-e7ff83262725@redhat.com>
Subject: Re: [PATCH] RFC: qio: Improve corking of TLS sessions
References: <20190607221414.15962-1-eblake@redhat.com>
 <20190610090811.GC7809@redhat.com>
In-Reply-To: <20190610090811.GC7809@redhat.com>

--iEre6L0q8cXkjWnlLXCfbstk2i91XyNLd
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 6/10/19 4:08 AM, Daniel P. Berrang=C3=A9 wrote:
> On Fri, Jun 07, 2019 at 05:14:14PM -0500, Eric Blake wrote:
>> Our current implementation of qio_channel_set_cork() is pointless for
>> TLS sessions: we block the underlying channel, but still hand things
>> piecemeal to gnutls which then produces multiple encryption packets.
>> Better is to directly use gnutls corking, which collects multiple
>> inputs into a single encryption packet.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>
>> ---
>>
>> RFC because unfortunately, I'm not sure I like the results.  My test
>> case (using latest nbdkit.git) involves sending 10G of random data
>> over NBD using parallel writes (and doing nothing on the server end;
>> this is all about timing the data transfer):
>>
>> $ dd if=3D/dev/urandom of=3Drand bs=3D1M count=3D10k
>> $ time nbdkit -p 10810 --tls=3Drequire --tls-verify-peer \
>>    --tls-psk=3D/tmp/keys.psk --filter=3Dstats null 10g statsfile=3D/de=
v/stderr \
>>    --run '~/qemu/qemu-img convert -f raw -W -n --target-image-opts \
>>      --object tls-creds-psk,id=3Dtls0,endpoint=3Dclient,dir=3D/tmp,use=
rname=3Deblake \
>>      rand driver=3Dnbd,server.type=3Dinet,server.host=3Dlocalhost,serv=
er.port=3D10810,tls-creds=3Dtls0'
>>
>> Pre-patch, I measured:
>> real	0m34.536s
>> user	0m29.264s
>> sys	0m4.014s
>>
>> while post-patch, it changed to:
>> real	0m36.055s
>> user	0m27.685s
>> sys	0m10.138s
>>
>> Less time spent in user space, but for this particular qemu-img
>> behavior (writing 2M chunks at a time), gnutls is now uncorking huge
>> packets and the kernel is doing enough extra work that the overall
>> program actually takes longer. :(
>=20
> I wonder if the problem is that we're hitting a tradeoff between
> time spent in encryption vs time spent in network I/O.
>=20
> When we don't cork, the kernel has already sent the first packet
> during the time gnutls is burning CPU encrypting the second packet.
>=20
> When we do cork gnutls has to encrypt both packets before the kernel
> can send anything.

Exactly. That's why my gut feel is that having only a binary cork is too
course, and we instead want something more like MSG_MORE. If the flag is
set, AND the current size is small, then cork; then on the next message,
we see that we are still corked, and decide to either uncork immediately
(current message is large, corking buys us nothing useful as we're going
to split the current message anyway) or uncork after appending the
current message (current message is small enough that keeping things
corked may still be a win).  Visually,

cork
send()
send()
uncork

is too late - you can't tell whether the second send would have
benefitted from staying corked after the first.  But:

send(MSG_MORE)
send()

is ideal; under the hood, we can translate it to:

send(MSG_MORE)
  gnutls_record_cork()
  gnutls_record_send()
send()
  if (size > threshold) {
    gnutls_record_uncork()
    gnutls_record_send()
  } else {
    gnutls_record_send()
    gnutls_record_uncork()
  }

So we really need a way to plumb a MSG_MORE flag for senders to use,
when they KNOW they will be sending back-to-back pieces and where the
first piece is short, but it is not yet obvious whether the second piece
is short or long.

MSG_MORE was lon the next message to go through the stack, if the
previous message next paccork for

>=20
>> For smaller I/O patterns, the effects of corking are more likely to be=

>> beneficial, but I don't have a ready test case to produce that pattern=

>> (short of creating a guest running fio on a device backed by nbd).
>=20
> I think it would probably be useful to see guest kernels with fio
> and definitely see results for something closer to sector sized
> I/O.
>=20
> 2 MB chunks is pretty unrealistic for a guest workload where there
> will be lots of sector sized I/O. Sure QEMU / guest OS can merge
> sectors, but it still feels like most I/O is going to be much smaller
> than 2 MB.

I'll have to play with other benchmarking setups, and see if I can come
up with a reliable fio test.

>=20
>=20
>> diff --git a/io/channel.c b/io/channel.c
>> index 2a26c2a2c0b9..3510912465ac 100644
>> --- a/io/channel.c
>> +++ b/io/channel.c
>> @@ -379,7 +379,16 @@ void qio_channel_set_cork(QIOChannel *ioc,
>>      QIOChannelClass *klass =3D QIO_CHANNEL_GET_CLASS(ioc);
>>
>>      if (klass->io_set_cork) {
>> -        klass->io_set_cork(ioc, enabled);
>> +        int r =3D klass->io_set_cork(ioc, enabled);
>> +
>> +        while (r =3D=3D QIO_CHANNEL_ERR_BLOCK) {
>> +            if (qemu_in_coroutine()) {
>> +                qio_channel_yield(ioc, G_IO_OUT);
>> +            } else {
>> +                qio_channel_wait(ioc, G_IO_OUT);
>> +            }
>> +            r =3D klass->io_set_cork(ioc, enabled);
>> +        }
>>      }
>=20
> Interesting - did you actually hit this EAGAIN behaviour ? I wouldn't
> have expected anything to be pending in gnutls that needs retry.=20

Yes. When gnutls_record_cork() is called, NOTHING goes over the wire,
but instead everything gets appended to a realloc'd buffer; when you
finally gnutls_record_uncork() and are using a non-blocking socket, you
WILL hit EAGAIN if the amount of data being uncorked is larger than TCP
max segment size.

But again, I think that having qio_channel_set_cork() do the blocking
wait is too late, we really want a nicer interface where you can request
a per-message MSG_MORE, at which point crypto/tlssession.c handles the
cork/uncork logic as part of send()ing rather than making qio_uncork
have to block.  It's just that it's a lot more work (either all existing
callers need to adjust to a flags parameter, or we need new entry points
to expose a flag parameter to the few callers that care - right now, nbd
and sheepdog, although we may find others).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--iEre6L0q8cXkjWnlLXCfbstk2i91XyNLd--

--GNgjc5b1idjezKNb6qG9gbf8ER1Z0Q3Wd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlz+YwwACgkQp6FrSiUn
Q2rLuAgAmbRriKXLyzvDk5uPVcHM+Fb7e2+qsrFquUh5sg+WJsHIDW8wGx2OAZJK
tkuq/T2rIEZXIS1Pvi+/QrKm9Ou7YZQ9EeMPcFiGbA3UZ9BdRMbxVtmxzg43CFJq
xsFNjq5lhGFP/KWR59IIFlyeyaAuAILCoYOmfSEdKBC8/9A+YCYr6urAXlKBE2k3
4+Rgp8gdRY8IcBKkwKja8udwhB5Z1OqFaVYzYKZsDv/MwBLYArICbXO0eCaATDll
jH+y3JoYIgRXynaGsYQd2JUM0HSbOZkSKYxhN2xIQWIY7w8qI3UKR/hjl19mXOzb
WhRuH6WB76pJEIPqdEQdvwNDt133Kg==
=FB6v
-----END PGP SIGNATURE-----

--GNgjc5b1idjezKNb6qG9gbf8ER1Z0Q3Wd--

