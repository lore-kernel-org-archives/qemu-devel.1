Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D6AC32750
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 21:20:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D70E20665
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 21:20:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D70E20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hteyR-0002RH-IW
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 17:20:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45210)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1htexw-0001ty-9A
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 17:19:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1htexv-0001Qw-2i
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 17:19:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57596)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1htexs-00010J-CH; Fri, 02 Aug 2019 17:19:52 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B49F34E927;
 Fri,  2 Aug 2019 21:19:49 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E440C1972A;
 Fri,  2 Aug 2019 21:19:42 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20190802185830.74648-1-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
 /PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
 U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
 mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
 awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
 AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
 B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
 2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
 AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
 8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
 4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
 BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
 xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
 W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
 DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
 64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
 ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
 sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
 alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
 /ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
 bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
 R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <815da22c-e88e-e813-d342-9ad14191d052@redhat.com>
Date: Fri, 2 Aug 2019 23:19:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190802185830.74648-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="yLpMtNDKlsuVgOWytRNPgj12poRMXJlMg"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Fri, 02 Aug 2019 21:19:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] util/hbitmap: fix unaligned reset
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
Cc: fam@euphon.net, kwolf@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org,
 den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yLpMtNDKlsuVgOWytRNPgj12poRMXJlMg
Content-Type: multipart/mixed; boundary="5XdVgH3rydlA5lppYhz9iRvUQzrfdQ5yz";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, fam@euphon.net,
 kwolf@redhat.com, den@openvz.org
Message-ID: <815da22c-e88e-e813-d342-9ad14191d052@redhat.com>
Subject: Re: [PATCH] util/hbitmap: fix unaligned reset
References: <20190802185830.74648-1-vsementsov@virtuozzo.com>
In-Reply-To: <20190802185830.74648-1-vsementsov@virtuozzo.com>

--5XdVgH3rydlA5lppYhz9iRvUQzrfdQ5yz
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 02.08.19 20:58, Vladimir Sementsov-Ogievskiy wrote:
> hbitmap_reset is broken: it rounds up the requested region. It leads to=

> the following bug, which is shown by fixed test:
>=20
> assume granularity =3D 2
> set(0, 3) # count becomes 4
> reset(0, 1) # count becomes 2
>=20
> But user of the interface assume that virtual bit 1 should be still
> dirty, so hbitmap should report count to be 4!
>=20
> In other words, because of granularity, when we set one "virtual" bit,
> yes, we make all "virtual" bits in same chunk to be dirty. But this
> should not be so for reset.
>=20
> Fix this, aligning bound correctly.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>=20
> Hi all!
>=20
> Hmm, is it a bug or feature? :)
> I don't have a test for mirror yet, but I think that sync mirror may be=
 broken
> because of this, as do_sync_target_write() seems to be using unaligned =
reset.

Crap.


Yes, you=E2=80=99re right.  This would fix it, and it wouldn=E2=80=99t fi=
x it in the
worst way.

But I don=E2=80=99t know whether this patch is the best way forward still=
=2E  I
think call hbitmap_reset() with unaligned boundaries generally calls for
trouble, as John has laid out.  If mirror=E2=80=99s do_sync_target_write(=
) is
the only offender right now, I=E2=80=99d prefer for hbitmap_reset() to as=
sert
that the boundaries are aligned (for 4.2), and for
do_sync_target_write() to be fixed (for 4.1? :-/).

(A practical problem with this patch is that do_sync_target_write() will
still do the write, but it won=E2=80=99t change anything in the bitmap, s=
o the
copy operation was effectively useless.)

I don=E2=80=99t know how to fix mirror exactly, though.  I have four idea=
s:

(A) Quick fix 1: do_sync_target_write() should shrink [offset, offset +
bytes) such that it is aligned.  This would make it skip writes that
don=E2=80=99t fill one whole chunk.

+: Simple fix.  Could go into 4.1.
-: Makes copy-mode=3Dwrite-blocking equal to copy-mode=3Dbackground unles=
s
   you set the granularity to like 512. (Still beats just being
   completely broken.)

(B) Quick fix 2: Setting the request_alignment block limit to the job=E2=80=
=99s
granularity when in write-blocking mode.

+: Very simple fix.  Could go into 4.1.
+: Every write will trigger a RMW cycle, which copies the whole chunk to
   the target, so write-blocking will do what it=E2=80=99s supposed to do=
=2E
-: request_alignment forces everything to have the same granularity, so
   this slows down reads needlessly.  (But only for write-blocking.)

(C) Maybe the right fix 1: Let do_sync_target_write() expand [offset,
offset + bytes) such that it is aligned and read head and tail from the
source node.  (So it would do the RMW itself.)

+ Doesn=E2=80=99t slow reads down.
+ Writes to dirty areas will make them clean =E2=80=93 which is what
  write-blocking is for.
- Probably more complicated.  Nothing for 4.1.

(D) Maybe the right fix 2: Split BlockLimits.request_alignment into
read_alignment and write_alignment.  Then do (B).

In effect, this is more or less the same as (C), but probably in a
simpler way.  Still not simple enough for 4.1, though.


So...  I tend to do either (A) or (B) now, and then probably (D) for
4.2?  (And because (D) is an extension to (B), it would make sense to do
(B) now, unless you=E2=80=99d prefer (A).)

Max


--5XdVgH3rydlA5lppYhz9iRvUQzrfdQ5yz--

--yLpMtNDKlsuVgOWytRNPgj12poRMXJlMg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1EqOwACgkQ9AfbAGHV
z0D2SQf/WNND81YIa8HZksyoemxsuEdgFGG1JU6vVKC7B9SLCKSBLV/c9eyG8d02
6GqFrz5U5a8duOe9r0At9ebePMs8Xy5RaqSgZSjXazZl+emqUivxpeMxPWwe4VRO
z0kUTH7hDvzI0nrI4a6+lL0t3ErcEimADPA77zCxwKGFQWA6Eu0j34UiGban/NHo
QZstI3JO/Hk01ANHr+sTIGXg4kJEKEZVZeOEgLM6iUV33DeFR4UNuAy9W2FXqcPO
4lEIhwvo5mMhXXvjSkJJuqu5XaIH3Ca6QQ4ciG4ucR9LKRRfKnDCyCv/YN4U8fLb
G5DnQRbOF3cueMbt6Caxe3lUzlukfQ==
=Lxig
-----END PGP SIGNATURE-----

--yLpMtNDKlsuVgOWytRNPgj12poRMXJlMg--

