Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016A8C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 14:49:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89FF720651
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 14:49:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89FF720651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxY6v-0002KE-NX
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 10:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42768)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hxY6U-0001ay-2s
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 10:48:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hxY6S-0007Lc-UO
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 10:48:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53274)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hxY6Q-0007K6-AW; Tue, 13 Aug 2019 10:48:46 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A1BE77BDA5;
 Tue, 13 Aug 2019 14:48:45 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 518243468D;
 Tue, 13 Aug 2019 14:48:38 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
References: <20190725155512.9827-1-mreitz@redhat.com>
 <125926bf-4c5a-939a-2cc7-01e11a1a2511@redhat.com>
 <e6bc8a2d-4541-60a3-64a7-294c4dee0c32@redhat.com>
 <62114b6e-803d-5eec-df7e-e77708f065c6@redhat.com>
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
Message-ID: <cb8a761c-48bb-52b8-8079-b8220a32bc63@redhat.com>
Date: Tue, 13 Aug 2019 16:48:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <62114b6e-803d-5eec-df7e-e77708f065c6@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Pyb5g1nu7qW8i35c5uEIq2NYm1ZI0WI4E"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Tue, 13 Aug 2019 14:48:45 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/3] block: Make various
 formats' block_status recurse again
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Pyb5g1nu7qW8i35c5uEIq2NYm1ZI0WI4E
Content-Type: multipart/mixed; boundary="pEmicKXCEGBQ1GENELn2WWyzoAD5DZrpN";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Message-ID: <cb8a761c-48bb-52b8-8079-b8220a32bc63@redhat.com>
Subject: Re: [Qemu-block] [PATCH 0/3] block: Make various formats'
 block_status recurse again
References: <20190725155512.9827-1-mreitz@redhat.com>
 <125926bf-4c5a-939a-2cc7-01e11a1a2511@redhat.com>
 <e6bc8a2d-4541-60a3-64a7-294c4dee0c32@redhat.com>
 <62114b6e-803d-5eec-df7e-e77708f065c6@redhat.com>
In-Reply-To: <62114b6e-803d-5eec-df7e-e77708f065c6@redhat.com>

--pEmicKXCEGBQ1GENELn2WWyzoAD5DZrpN
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12.08.19 23:45, John Snow wrote:
>=20
>=20
> On 8/12/19 3:11 PM, Max Reitz wrote:
>> On 12.08.19 20:39, John Snow wrote:
>>>
>>>
>>> On 7/25/19 11:55 AM, Max Reitz wrote:
>>>> Hi,
>>>>
>>>> 69f47505ee66afaa513305de0c1895a224e52c45 changed block_status so tha=
t it
>>>> would only go down to the protocol layer if the format layer returne=
d
>>>> BDRV_BLOCK_RECURSE, thus indicating that it has no sufficient
>>>> information whether a given range in the image is zero or not.
>>>> Generally, this is because the image is preallocated and thus all ra=
nges
>>>> appear as zeroes.
>>>>
>>>> However, it only implemented this preallocation detection for qcow2.=

>>>> There are more formats that support preallocation, though: vdi, vhdx=
,
>>>> vmdk, vpc.  (Funny how they all start with =E2=80=9Cv=E2=80=9D.)
>>>>
>>>> For vdi, vmdk, and vpc, the fix is rather simple, because they reall=
y
>>>> have different subformats depending on whether an image is prealloca=
ted
>>>> or not.  This makes the check very simple.
>>>>
>>>> vhdx is more like qcow2, where after the image has been created, it
>>>> isn=E2=80=99t clear whether it=E2=80=99s been preallocated or everyt=
hing is allocated
>>>> because everything was already written to.  69f47505ee added a heuri=
stic
>>>> to qcow2 to get around this, but I think that=E2=80=99s too much for=
 vhdx.  I
>>>> just left it unfixed, because I don=E2=80=99t care that much, honest=
ly (and I
>>>> don=E2=80=99t think anyone else does).
>>>>
>>>
>>> What's the practical outcome of that, and is the limitation documente=
d
>>> somewhere?
>>
>> The outcome is that it if you preallocate a vhdx image
>> (subformat=3Dfixed), you=E2=80=99ll see that all sectors contain data,=
 even if
>> they may be zero sectors on the filesystem level.
>>
>> I don=E2=80=99t think it=E2=80=99s user-visible whatsoever.
>>
>=20
> But it might mean that doing things with sync=3Dtop might over-allocate=

> data depending on the destination, wouldn't it?
>=20
> That's not crucial, but it's possibly visible, no?

I don=E2=80=99t think it has anything to do with sync=3Dtop because wheth=
er a
block is zero on the protocol level has nothing to do with whether it is
allocated on the format level.

It may make a difference for convert which uses block_status to inquire
the zero status.  However, it also does zero-detection, so...

>>> (I'm fine with not fixing it, I just want it documented somehow.)
>>
>> I am really not inclined to start any documentation on the
>> particularities with which qemu handles vhdx images.
>>
>> (Especially so considering we don=E2=80=99t even have any documentatio=
n on the
>> qcow2 case.  The stress in my paragraph was =E2=80=9Cheuristic=E2=80=9D=
=2E  If you
>> preallocate a qcow2 image, but then discard enough sectors that the
>> heuristic thinks you didn=E2=80=99t, you=E2=80=99ll have the same effe=
ct.  Or if you
>> grow a preallocated image without preallocating the new area.)
>>
>> Max
>>
>=20
> "But our qcow2 docs are also bad" is the kind of argument I can't
> *really* disagree with, but...

My main argument is that nobody would read the vhdx docs anyway.

Max

> (I wish we did have a documentation manual per-format that mentioned
> some gotchas and general info about each format, but I can't really ask=

> you to do that now: I just worry when I see patches like this that the
> knowledge or memory that there ever was a quirk will vanish immediately=
=2E)
>=20
> --js
>=20



--pEmicKXCEGBQ1GENELn2WWyzoAD5DZrpN--

--Pyb5g1nu7qW8i35c5uEIq2NYm1ZI0WI4E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1SzcQACgkQ9AfbAGHV
z0D0xwf/agyxksAcp0J5I73Zzh1LfIxJMg/AlcimBdosn6U87Y1oftu5K3erBvjr
c9kWHdJD0dudIaFsjgPQDTNI/0iNpUh59aOQZaNCuuzliAk750LrrLwTKAEsIcBE
5jHegGKr2a/j4cT4j50M8vN4+3tpMIvx1mOFfKuvZGcaO83FnKiWWq3I7stt6m/Q
Z0qGhOfNDKZyZvY3wPJKCq/xWjv2X/2JVCNjDHdy9RshCzYO2GMEDJmusf34YXZp
73zCM/m0m7YSREy5is2pxOO7ForuyANd+DENWeQ1NdVE4rfL6VSqrjigsTWrZjlA
iE8o5GaFXGgXV1L+dRlsgrfoNhgYAQ==
=cNuT
-----END PGP SIGNATURE-----

--Pyb5g1nu7qW8i35c5uEIq2NYm1ZI0WI4E--

