Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D3EC47404
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 15:29:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1D7820873
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 15:29:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1D7820873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGPWK-0004Wy-UQ
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 11:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38298)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iGPUq-0003zp-8G
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 11:27:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iGPUn-0004bZ-GK
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 11:27:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60678)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iGPUh-0004Y4-0M; Fri, 04 Oct 2019 11:27:47 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EA04630ADBA0;
 Fri,  4 Oct 2019 15:27:45 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-31.brq.redhat.com
 [10.40.204.31])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 15F201001B22;
 Fri,  4 Oct 2019 15:27:41 +0000 (UTC)
Subject: Re: [PATCH 3/4] block/mirror: support unaligned write in active mirror
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190912151338.21225-1-vsementsov@virtuozzo.com>
 <20190912151338.21225-4-vsementsov@virtuozzo.com>
 <7dec596f-0175-951e-ba3f-2eb8b2a3d8ed@redhat.com>
 <9a857f23-73b0-44c1-dde2-ac68d45dcf93@virtuozzo.com>
 <62e03b60-b9cb-9e59-f876-df40bba96ca0@virtuozzo.com>
 <3dc81329-443a-288c-0ea1-4190dfc33f5e@redhat.com>
 <5b267415-519f-f4ca-29d0-1bc9753b29f3@virtuozzo.com>
 <292e7686-5440-fdf3-cda3-a0e1f1968089@redhat.com>
 <3193c71d-cd5e-fa94-4dc1-dc8ebbe9ce22@virtuozzo.com>
 <65b4fd06-4d66-ebc3-4e0e-1e8c2d983ef6@redhat.com>
 <76736494-f3f6-6b42-e3cc-260250a8d862@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
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
Message-ID: <28b2674b-f720-e850-ae00-f5f85574e522@redhat.com>
Date: Fri, 4 Oct 2019 17:27:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <76736494-f3f6-6b42-e3cc-260250a8d862@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="HMywQVG7sUnGwZD4XlIYwxDtlgol8gxZX"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Fri, 04 Oct 2019 15:27:46 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HMywQVG7sUnGwZD4XlIYwxDtlgol8gxZX
Content-Type: multipart/mixed; boundary="00MnKKKZ2vFZNqZMDFqATZdt3qAFhn21q"

--00MnKKKZ2vFZNqZMDFqATZdt3qAFhn21q
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 04.10.19 17:04, Vladimir Sementsov-Ogievskiy wrote:
> 04.10.2019 17:48, Max Reitz wrote:
>> On 04.10.19 15:22, Vladimir Sementsov-Ogievskiy wrote:
>>> 04.10.2019 15:59, Max Reitz wrote:
>>>> On 03.10.19 11:34, Vladimir Sementsov-Ogievskiy wrote:
>>>>> 02.10.2019 18:52, Max Reitz wrote:
>>>>>> On 02.10.19 17:06, Vladimir Sementsov-Ogievskiy wrote:
>>>>>>> 02.10.2019 18:03, Vladimir Sementsov-Ogievskiy wrote:
>>>>>>>> 02.10.2019 17:57, Max Reitz wrote:
>>>>>>>>> On 12.09.19 17:13, Vladimir Sementsov-Ogievskiy wrote:
>>>>>>>>>> Prior 9adc1cb49af8d do_sync_target_write had a bug: it reset a=
ligned-up
>>>>>>>>>> region in the dirty bitmap, which means that we may not copy s=
ome bytes
>>>>>>>>>> and assume them copied, which actually leads to producing corr=
upted
>>>>>>>>>> target.
>>>>>>>>>>
>>>>>>>>>> So 9adc1cb49af8d forced dirty bitmap granularity to be
>>>>>>>>>> request_alignment for mirror-top filter, so we are not working=
 with
>>>>>>>>>> unaligned requests. However forcing large alignment obviously =
decreases
>>>>>>>>>> performance of unaligned requests.
>>>>>>>>>>
>>>>>>>>>> This commit provides another solution for the problem: if unal=
igned
>>>>>>>>>> padding is already dirty, we can safely ignore it, as
>>>>>>>>>> 1. It's dirty, it will be copied by mirror_iteration anyway
>>>>>>>>>> 2. It's dirty, so skipping it now we don't increase dirtiness =
of the
>>>>>>>>>>    =C2=A0=C2=A0=C2=A0 bitmap and therefore don't damage "synch=
ronicity" of the
>>>>>>>>>>    =C2=A0=C2=A0=C2=A0 write-blocking mirror.
>>>>>>>>>
>>>>>>>>> But that=E2=80=99s not what active mirror is for.=C2=A0 The poi=
nt of active mirror is
>>>>>>>>> that it must converge because every guest write will contribute=
 towards
>>>>>>>>> that goal.
>>>>>>>>>
>>>>>>>>> If you skip active mirroring for unaligned guest writes, they w=
ill not
>>>>>>>>> contribute towards converging, but in fact lead to the opposite=
=2E
>>>>>>>>>
>>>>>>>>
>>>>>>>> The will not contribute only if region is already dirty. Actuall=
y, after
>>>>>>>> first iteration of mirroring (copying the whole disk), all follo=
wing writes
>>>>>>>> will contribute, so the whole process must converge. It is a bit=
 similar with
>>>>>>>> running one mirror loop in normal mode, and then enable write-bl=
ocking.
>>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> In other words, we don't need "all guest writes contribute" to co=
nverge,
>>>>>>> "all guest writes don't create new dirty bits" is enough, as we h=
ave parallel
>>>>>>> mirror iteration which contiguously handles dirty bits.
>>>>>>
>>>>>> Hm, in a sense.  But it does mean that guest writes will not contr=
ibute
>>>>>> to convergence.
>>>>>>
>>>>>> And that=E2=80=99s against the current definition of write-blockin=
g, which does
>>>>>> state that =E2=80=9Cwhen data is written to the source, write it (=
synchronously)
>>>>>> to the target as well=E2=80=9D.
>>>>>>
>>>>>
>>>>> Hmm, understand. But IMHO our proposed behavior is better in genera=
l.
>>>>> Do you think it's a problem to change spec now?
>>>>> If yes, I'll resend with an option
>>>>
>>>> Well, the thing is that I=E2=80=99d find it weird if write-blocking =
wasn=E2=80=99t
>>>> blocking in all cases.  And in my opinion, it makes more sense for
>>>> active mirror if all writes actively contributed to convergence.
>>>>
>>>
>>> Why? What is the benefit in it?
>>> What is "all writes actively contributed to convergence" for user?
>>
>> One thing I wonder about is whether it=E2=80=99s really guaranteed tha=
t the
>> background job will run under full I/O load, and how often it runs.
>>
>> I fear that with your model, the background job might starve and the
>> mirror may take a very long time.
>=20
> Hmmm. I think mirror job is in same context as guest writes, and goes
> through same IO api.. Why it will starve? (I understand that my words
> are not an evidence...).

I thought that maybe if the disk is read to write and write all the
time, there=E2=80=99d be no time for the mirror coroutine.

>>  It won=E2=80=99t diverge, but it also won=E2=80=99t
>> really converge.
>=20
> But same will be with current behavior: guest is not guaranteed to writ=
e
> to all parts of disk. And in most scenarios it doesn't. So, if mirror j=
ob
> starve because of huge guest IO load, we will not converge anyway.
>=20
> So, background process is necessary thing for converge anyway.

Good point.  That convinces me.

>> The advantage of letting all writes block is that even under full I/O
>> load, the mirror job will progress at a steady pace.
>>
>>> I think for user there may be the following criteria:
>>>
>>> 1. guaranteed converge, with any guest write load.
>>> Both current and my proposed variants are OK.
>>>
>>> 2. Less impact on guest.
>>> Obviously my proposed variant is better
>>>
>>> 3. Total time of mirroring
>>> Seems, current may be a bit better, but I don't think that unaligned
>>> tails gives significant impact.
>>>
>>> =3D=3D=3D
>>>
>>> So, assume I want [1]+[2]. And possibly
>>> 2.2: Even less impact on guest: ignore not only unaligned tails if th=
ey are
>>> already dirty, but full synchronous mirror operation if area is alrea=
dy dirty.
>>>
>>> How should I call this? Should it be separate mode, or option for wri=
te-blocking?
>>
>> I don=E2=80=99t know whether it makes sense to add a separate mode or =
a separate
>> option just for this difference.  I don=E2=80=99t think anyone would c=
hoose the
>> non-default option.
>=20
> At least Virtuozzo will choose :)

But if Virtuozzo knows exactly what to choose, then we can just
implement only that behavior.

Max


--00MnKKKZ2vFZNqZMDFqATZdt3qAFhn21q--

--HMywQVG7sUnGwZD4XlIYwxDtlgol8gxZX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2XZOwACgkQ9AfbAGHV
z0AjZAf9F1ioVND3fqEwgMzpv6AmDiqvo7hHdaSYVhHC10jWFWUblWseNaztgD/a
FL0030ItLSKdGwIp/tQDnm7XvkCJwV/+OBSN0035hB44XWoAGgDbqo6W/qyPQmnl
epdktyMg84OQuPLZm27MjguhkCrCSIbpcgbdhOR96PZixCH7M9lmp99mZK0vwNmQ
0dAHGcEnRjPYg7qXM64FWw7zEwb7uC0M6HKagr+hYTEp3dP7LMVlL8zxxChEQ5vh
QPx4uJGaVM+58A93EcowC0yCDVnLTj7N0hPwXChHMmBqf33NqvxerLm2qi2EinS8
sLGRZThbNIr6kZgNZwEXhU8c0OYygw==
=D5NR
-----END PGP SIGNATURE-----

--HMywQVG7sUnGwZD4XlIYwxDtlgol8gxZX--

