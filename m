Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22E2C432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 11:27:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3BE8222BE
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 11:27:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3BE8222BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDRvk-0003u7-Ud
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 07:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53548)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iDRud-00032l-9I
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 07:26:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iDRub-0001Fx-8E
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 07:26:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48173)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iDRuX-0001BX-Pw; Thu, 26 Sep 2019 07:26:14 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B10A53175296;
 Thu, 26 Sep 2019 11:26:11 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.151])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 69D7B1001B12;
 Thu, 26 Sep 2019 11:26:04 +0000 (UTC)
Subject: Re: [PATCH v13 00/15] backup-top filter driver for backup
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190920142056.12778-1-vsementsov@virtuozzo.com>
 <9a0c66fe-f786-3f49-6fad-ffca04888659@virtuozzo.com>
 <16dc6262-06d7-29cf-a712-904f5a3c9627@virtuozzo.com>
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
Message-ID: <a75f1bd6-ecfc-852d-0a7d-1b0cb63753be@redhat.com>
Date: Thu, 26 Sep 2019 13:26:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <16dc6262-06d7-29cf-a712-904f5a3c9627@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="yFCEA11GXryeRUpjTNUVp1gY4iuBn2OoF"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 26 Sep 2019 11:26:11 +0000 (UTC)
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 Denis Lunev <den@virtuozzo.com>,
 "wencongyang2@huawei.com" <wencongyang2@huawei.com>,
 "xiechanglong.d@gmail.com" <xiechanglong.d@gmail.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yFCEA11GXryeRUpjTNUVp1gY4iuBn2OoF
Content-Type: multipart/mixed; boundary="ZxsqMlpKxoSn3YdCStn961okVzh1Cl1Bd"

--ZxsqMlpKxoSn3YdCStn961okVzh1Cl1Bd
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25.09.19 21:28, Vladimir Sementsov-Ogievskiy wrote:
> ops, I've sent unfinished message
>=20
> On 25.09.2019 22:19, Vladimir Sementsov-Ogievskiy wrote:
>> Ogh :(
>>
>> And I realized that there is bigger problem with design:
>>
>> Assume failed copy in filter request: we want to mark bits dirty again=

>> and release range lock on source.. But if we have some write reguests
>> in parallel, they may already passed backup-top filter, and they are
>> only waiting for range lock. When lock is free the will go on and will=

>> not see bitmap changes..
>>
>> That means that we can't use range lock: waiting request must wait on
>> backup-top level, but range lock will not work on it, as they will
>> interfer with original write request.
>=20
> With such design we can't mark bits dirty again. We can switch to other=
=20
> behavior: on failed block-copy in filter just cancel the whole=20
> block-job.. But actually I think both behaviors should be available for=
=20
> user:
> 1. if backup is important, better to fail guest writes if needed
> 2. if guest is important, better to fail backup job if failed to do=20
> copy-before-write
>=20
>>
>> I have to rething it somehow, a kind of "intersecting requests" possib=
ly
>> will be kept. I still don't like that current backup write-notifier
>> locks the whole region, even non-dirty bits, instead we should lock on=
ly
>> the region which we are handling at the moment.
>>
>> Patches 01-11 are still good themselves, as a preparation, let's keep =
them
>>
>> Patches 12-13 are good, but range lock is not appropriate for backup..=

>> May be they will be used for rewriting copy-on-read filter to copy in
>> filter code.. Still I'm not sure, as COR should work through block-cop=
y
>> finally, and may possibly reuse same locking.
>=20
> better drop 12-13 for now
>=20
> Patch 14 is good, let's keep it. It has correct abort() in=20
> backup_top_cbw(), it's not dependent on 12-13, and it's waiting for=20
> corrected combining of backup-top, backup and block-copy.
>=20
> And patch 15 is bad, I'll rewrite it. So, 16 is not needed too.
I=E2=80=99ll drop 12 =E2=80=93 15.  14 is dead code without 15, so I=E2=80=
=99d rather not keep
it, actually.

Mxa


--ZxsqMlpKxoSn3YdCStn961okVzh1Cl1Bd--

--yFCEA11GXryeRUpjTNUVp1gY4iuBn2OoF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2MoEoACgkQ9AfbAGHV
z0B8xAgAoJsxa/1yXn0cRrwEU5GhSZ47DhJILesA3Bh/CM2vr0X0ynsGapN2X1hM
wdz89BHeMQHlKkuPtj6zT3rCy7rQlSBbGFvkWG7nw6S8bgc5uQ4XjqDL+/faF4qQ
HUadwFZHjwzJQNmHeZpr1aQVIdBx51uu/hsDO6zrWpp8gf5lCc+BxSYjn63dZpbw
wF/abLniM9eS0kbN4g9MsnojoTkmeFY/O9WIHmhOw8ayf3TL0ph4USMJoQAeukYL
Y1snOnvEow5c7FoWZgQ36IrTyoEz9uGM6LC43MdfOlftSAPg8Q6+sWBQBFdcvXj9
cfDu2cR9nS/750ZbkjZQSz/g9EgQ0Q==
=8xz5
-----END PGP SIGNATURE-----

--yFCEA11GXryeRUpjTNUVp1gY4iuBn2OoF--

