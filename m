Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AEBC433EF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 07:58:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67B7E218AC
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 07:58:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67B7E218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7EYm-0004Im-Ib
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 03:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46982)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i7EXM-0003Y5-JI
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 03:56:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i7EXK-0007KM-Jp
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 03:56:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45434)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i7EXG-0007IB-M0; Mon, 09 Sep 2019 03:56:30 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EBBD8A46C27;
 Mon,  9 Sep 2019 07:56:29 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-179.ams2.redhat.com
 [10.36.116.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 80CE55D9D6;
 Mon,  9 Sep 2019 07:56:28 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-5-mreitz@redhat.com>
 <20190904161658.GD21246@localhost.localdomain>
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
Message-ID: <b1c56a8b-b4e4-c32a-f577-89a5e2da743e@redhat.com>
Date: Mon, 9 Sep 2019 09:56:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904161658.GD21246@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="sE7iPZw0kF0n1SCCRXym4PeU3sht7VFzF"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Mon, 09 Sep 2019 07:56:30 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 04/42] block: Add child access functions
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sE7iPZw0kF0n1SCCRXym4PeU3sht7VFzF
Content-Type: multipart/mixed; boundary="gBVW5bPxu6W6C05cuN1Y9FI54tCjAX18c";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <b1c56a8b-b4e4-c32a-f577-89a5e2da743e@redhat.com>
Subject: Re: [PATCH v6 04/42] block: Add child access functions
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-5-mreitz@redhat.com>
 <20190904161658.GD21246@localhost.localdomain>
In-Reply-To: <20190904161658.GD21246@localhost.localdomain>

--gBVW5bPxu6W6C05cuN1Y9FI54tCjAX18c
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 04.09.19 18:16, Kevin Wolf wrote:
> Am 09.08.2019 um 18:13 hat Max Reitz geschrieben:
>> There are BDS children that the general block layer code can access,
>> namely bs->file and bs->backing.  Since the introduction of filters an=
d
>> external data files, their meaning is not quite clear.  bs->backing ca=
n
>> be a COW source, or it can be an R/W-filtered child; bs->file can be a=
n
>> R/W-filtered child, it can be data and metadata storage, or it can be
>> just metadata storage.
>>
>> This overloading really is not helpful.  This patch adds function that=

>> retrieve the correct child for each exact purpose.  Later patches in
>> this series will make use of them.  Doing so will allow us to handle
>> filter nodes and external data files in a meaningful way.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20
> Each time I look at this patch, I'm confused by the function names.
> Maybe I should just ask what the idea there was, or more specifically:
> What does the "filtered" in "filtered child" really mean?
>=20
> Apparently any child of a filter node is "filtered" (which makes sense)=
,

It isn=E2=80=99t, filters can have non-filter children.  For example, bac=
kup-top
could have the source as a filtered child and the target as a non-filter
child.

> but also bs->backing of a qcow2 image, while bs->file of qcow2 isn't.
> raw doesn't have any "filtered" child. What's the system behind this?

=E2=80=9Cfiltered=E2=80=9D means: If the parent node returns data from th=
is child, it
won=E2=80=99t modify it, neither its content nor its position.  COW and R=
/W
filters differ in how they handle writes; R/W filters pass them through
to the filtered child, COW filters copy them off to some other child
node (and then the filtered child=E2=80=99s data will no longer be visibl=
e at
that location).

The main reason behind the common =E2=80=9Cfiltered=E2=80=9D name is for =
the generic
functions that work on both COW and true filter (R/W filters) chains.
We need such functionality sometimes.  I personally felt like the
concept of true (R/W) filters and COW children was similar enough to
share a common name base.

qcow2 has a COW child.  As such, it acts as a COW filter in the sense of
the function names.

raw has neither a COW child nor acts as an R/W filter.  As such, it has
no filtered child.  My opinion on this hasn=E2=80=99t changed.

(To reiterate, in practice I see no way anyone would ever use raw as an
R/W filter.
Either you use it without offset/size, in which case you simply use it
in lieu of a format node, so you precisely don=E2=80=99t want it to act a=
s a
filter when it comes to allocation information and so on (even though it
can be classified a filter here).
Or you use it as kind of a filter with offset/size, but then it no
longer is a filter.

Filters are defined by =E2=80=9CEvery filter must fulfill these condition=
s: ...=E2=80=9D
=E2=80=93 not by =E2=80=9CEverything that fulfills these conditions is a =
filter=E2=80=9D.
Marking a driver as a filter has consequences, and I don=E2=80=99t see wh=
y we
would want those consequences for raw.)

> It looks like bdrv_filtered_child() is the right function to iterate
> along a backing file chain, but I just still fail to connect that and
> the name of the function in a meaningful way.

It=E2=80=98s the right function to iterate along a filter chain.  This in=
cludes
COW backing children and R/W filtered children.

>> +/*
>> + * Return the child that @bs acts as an overlay for, and from which d=
ata may be
>> + * copied in COW or COR operations.  Usually this is the backing file=
=2E
>> + */
>=20
> Or NULL, if no such child exists.
>=20
> It's relatively obvious here, but for some of the functions further dow=
n
> it would be really good to describe in which cases NULL is expected (or=

> that NULL is even a possible return value).

I=E2=80=99ll look into it.

Max


--gBVW5bPxu6W6C05cuN1Y9FI54tCjAX18c--

--sE7iPZw0kF0n1SCCRXym4PeU3sht7VFzF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl12BaoACgkQ9AfbAGHV
z0AF1wgAguyaf2SC8PxeMpzE5YTKXKTpJe6/H5fw/3fWR+m7iPedOhW1nraNMtPe
KSel2exgatuZ8A5FCqTqGBUBsc0riTYyYgDhzQL4OluUr6L5ziAmuTySyEFGU7Su
ec0EHLHxkKDjjVPKzU9Vxg7e+zazCmiiHpQLcLMq3avMWH6CQ1Pr7p9JLqQvMt2p
E7dH53hlKPZrwzJ/wbCveMVDfL4iSrF1OL2ub+TuZuuAC/sMDSM4ZN+dTIXyvUGS
VWDaT5/cjht2MQYVfRRXvRsKmSdMxO7E4+VLwRQFu4D7BcwIwpL8d4YnI4xFw4Bd
9Xteh2cYCFwskTWV+F0CzxpoJ3JhYQ==
=kH1W
-----END PGP SIGNATURE-----

--sE7iPZw0kF0n1SCCRXym4PeU3sht7VFzF--

