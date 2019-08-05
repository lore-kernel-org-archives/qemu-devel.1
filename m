Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2A5C0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 11:31:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9745120679
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 11:31:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9745120679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hubDO-0006LJ-Sy
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 07:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56026)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hubCI-0005ph-9N
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 07:30:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hubCH-0002OW-5D
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 07:30:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42824)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hubCE-0002LW-EX; Mon, 05 Aug 2019 07:30:34 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B4A24E8CB3;
 Mon,  5 Aug 2019 11:30:31 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.217])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 254C0194B9;
 Mon,  5 Aug 2019 11:30:10 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>
References: <20190802185830.74648-1-vsementsov@virtuozzo.com>
 <815da22c-e88e-e813-d342-9ad14191d052@redhat.com>
 <20190805095610.GA6889@localhost.localdomain>
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
Message-ID: <4a47573c-43e8-6117-42f2-7f8e2e57d1d2@redhat.com>
Date: Mon, 5 Aug 2019 13:30:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190805095610.GA6889@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="azPHDTGgSxMjY51cDkaGKxiRumCosrhYv"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Mon, 05 Aug 2019 11:30:31 +0000 (UTC)
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
Cc: fam@euphon.net, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--azPHDTGgSxMjY51cDkaGKxiRumCosrhYv
Content-Type: multipart/mixed; boundary="OwvpcDXmnVHhde2noJ8yIbvik14UrHlmz";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, jsnow@redhat.com,
 fam@euphon.net, den@openvz.org
Message-ID: <4a47573c-43e8-6117-42f2-7f8e2e57d1d2@redhat.com>
Subject: Re: [PATCH] util/hbitmap: fix unaligned reset
References: <20190802185830.74648-1-vsementsov@virtuozzo.com>
 <815da22c-e88e-e813-d342-9ad14191d052@redhat.com>
 <20190805095610.GA6889@localhost.localdomain>
In-Reply-To: <20190805095610.GA6889@localhost.localdomain>

--OwvpcDXmnVHhde2noJ8yIbvik14UrHlmz
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 05.08.19 11:56, Kevin Wolf wrote:
> Am 02.08.2019 um 23:19 hat Max Reitz geschrieben:
>> On 02.08.19 20:58, Vladimir Sementsov-Ogievskiy wrote:
>>> hbitmap_reset is broken: it rounds up the requested region. It leads =
to
>>> the following bug, which is shown by fixed test:
>>>
>>> assume granularity =3D 2
>>> set(0, 3) # count becomes 4
>>> reset(0, 1) # count becomes 2
>>>
>>> But user of the interface assume that virtual bit 1 should be still
>>> dirty, so hbitmap should report count to be 4!
>>>
>>> In other words, because of granularity, when we set one "virtual" bit=
,
>>> yes, we make all "virtual" bits in same chunk to be dirty. But this
>>> should not be so for reset.
>>>
>>> Fix this, aligning bound correctly.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>> ---
>>>
>>> Hi all!
>>>
>>> Hmm, is it a bug or feature? :)
>>> I don't have a test for mirror yet, but I think that sync mirror may =
be broken
>>> because of this, as do_sync_target_write() seems to be using unaligne=
d reset.
>>
>> Crap.
>>
>>
>> Yes, you=E2=80=99re right.  This would fix it, and it wouldn=E2=80=99t=
 fix it in the
>> worst way.
>>
>> But I don=E2=80=99t know whether this patch is the best way forward st=
ill.  I
>> think call hbitmap_reset() with unaligned boundaries generally calls f=
or
>> trouble, as John has laid out.  If mirror=E2=80=99s do_sync_target_wri=
te() is
>> the only offender right now, I=E2=80=99d prefer for hbitmap_reset() to=
 assert
>> that the boundaries are aligned (for 4.2), and for
>> do_sync_target_write() to be fixed (for 4.1? :-/).
>>
>> (A practical problem with this patch is that do_sync_target_write() wi=
ll
>> still do the write, but it won=E2=80=99t change anything in the bitmap=
, so the
>> copy operation was effectively useless.)
>>
>> I don=E2=80=99t know how to fix mirror exactly, though.  I have four i=
deas:
>>
>> (A) Quick fix 1: do_sync_target_write() should shrink [offset, offset =
+
>> bytes) such that it is aligned.  This would make it skip writes that
>> don=E2=80=99t fill one whole chunk.
>>
>> +: Simple fix.  Could go into 4.1.
>> -: Makes copy-mode=3Dwrite-blocking equal to copy-mode=3Dbackground un=
less
>>    you set the granularity to like 512. (Still beats just being
>>    completely broken.)
>=20
> write-blocking promises that the guest receives request completion only=

> when the request has also been written to the target. If you completely=

> skip the write, this promise is broken.
>=20
> So I think you'd have to keep the write and only align the range for th=
e
> purpose of clearing bits in the dirty bitmap. This would result in some=

> duplicated I/O, which is an efficiency problem, but at least it
> shouldn't come with a correctness problem.

Hm.  I was thinking that the use case we were mostly thinking about is
people wanting their mirror job to definitely converge.  Doing that
wouldn=E2=80=99t guarantee that.

You=E2=80=99re right that I shouldn=E2=80=99t constrict people in what th=
ey might use
write-blocking for; maybe they mostly want to be sure the data is in the
target and don=E2=80=99t care too much about convergence.

In any case, what you describe is fulfilled by this patch here.  So we
may as well just take it, then.

(Unless we decide that we=E2=80=99d rather make write-blocking fully do w=
hat
it=E2=80=99s supposed to do, even at the cost of being slow, by announcin=
g a
request_alignment, as described in (B).)

Max


--OwvpcDXmnVHhde2noJ8yIbvik14UrHlmz--

--azPHDTGgSxMjY51cDkaGKxiRumCosrhYv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1IE0EACgkQ9AfbAGHV
z0A9BAf/Xp1Kup31SvSzPKnE+wrR43ZSFpvLOTCSTv00/gPrSxPtJngsxoWEpbkq
m8qpHGxgrZ4ewpBvZaowGs9MipiCvozi2P0YLnMsDOHZc9p1AWCBcCUuvXVKPYSp
8/6mtHrtZHZJJq2ngy/wwq4NVoNIPiMPRWjN5qPfnzJ8LsL/Xmk5acgTwjboNFZL
08z1gMtkjQNuwSWcvcoRN/kaycszqImPQyKo6vi0vDwY5J9F/6q6mRtC8vqwScHg
K0APh14qCqOAp/qAUxm9ujiStF7LRKY9huOyScGov+Tfc/rpO74Y6tyAGry/vOYX
Xg0KNM22IVcN86N7Ju7+ABGg3otgbg==
=cqy7
-----END PGP SIGNATURE-----

--azPHDTGgSxMjY51cDkaGKxiRumCosrhYv--

