Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74261C32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 14:39:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45D7620665
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 14:39:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45D7620665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxXxM-0002Wq-Ee
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 10:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41156)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hxXwu-00021M-C9
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 10:38:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hxXwt-0003Hi-6I
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 10:38:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50890)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hxXwq-0003Gd-BF; Tue, 13 Aug 2019 10:38:52 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 62138C05AA63;
 Tue, 13 Aug 2019 14:38:51 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A4E9C60852;
 Tue, 13 Aug 2019 14:38:49 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>
References: <20190812181146.26121-1-vsementsov@virtuozzo.com>
 <35b23140-25d5-627e-7a86-4b50fbc5be52@redhat.com>
 <20190813093434.GB4663@localhost.localdomain>
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
Message-ID: <618091c8-0276-5581-bf7f-bfd119f617a6@redhat.com>
Date: Tue, 13 Aug 2019 16:38:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190813093434.GB4663@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="iikr0JkqJbKfacTjc1y7lVO4jEPf51nMq"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Tue, 13 Aug 2019 14:38:51 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/2] deal with BDRV_BLOCK_RAW
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
Cc: den@openvz.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iikr0JkqJbKfacTjc1y7lVO4jEPf51nMq
Content-Type: multipart/mixed; boundary="NqEMUugS5GCBbHjN1WyFaHrPo9Afz5KTQ";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, den@openvz.org
Message-ID: <618091c8-0276-5581-bf7f-bfd119f617a6@redhat.com>
Subject: Re: [PATCH 0/2] deal with BDRV_BLOCK_RAW
References: <20190812181146.26121-1-vsementsov@virtuozzo.com>
 <35b23140-25d5-627e-7a86-4b50fbc5be52@redhat.com>
 <20190813093434.GB4663@localhost.localdomain>
In-Reply-To: <20190813093434.GB4663@localhost.localdomain>

--NqEMUugS5GCBbHjN1WyFaHrPo9Afz5KTQ
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13.08.19 11:34, Kevin Wolf wrote:
> Am 12.08.2019 um 21:46 hat Max Reitz geschrieben:
>> On 12.08.19 20:11, Vladimir Sementsov-Ogievskiy wrote:
>>> Hi all!
>>>
>>> I'm not sure, is it a bug or a feature, but using qcow2 under raw is
>>> broken. It should be either fixed like I propose (by Max's suggestion=
)
>>> or somehow forbidden (just forbid backing-file supporting node to be
>>> file child of raw-format node).
>>
>> I agree, I think only filters should return BDRV_BLOCK_RAW.
>=20
> If BDRV_BLOCK_RAW isn't suitable for raw, something went wrong. :-)

Yes, its introduction.

> But anyway, raw is essentially a filter, at least if you don't use
> the offset option.

Which is precisely why it isn=92t a filter.

Another reason is that it generally appears as a replacement for a
format driver.  You never insert it into some graph because you want it
as a filter.  Which is why behaving like a format driver in block_status
makes sense, in my opinion.

>                    And BDRV_BLOCK_RAW shouldn't even depend on an
> unchanged offset because the .bdrv_co_block_status implementation
> returns the right offset.
>=20
> And indeed, you can replace raw with blkdebug and it still fails (the
> testcase from patch 2 fails, too, but it's obvious enough this way):
>=20
>     $ ./qemu-img map --output=3Djson --image-opts driver=3Dqcow2,file.d=
river=3Dfile,file.filename=3D/tmp/test.qcow2=20
>     [{ "start": 0, "length": 1048576, "depth": 1, "zero": true, "data":=
 false},
>     { "start": 1048576, "length": 1048576, "depth": 1, "zero": false, "=
data": true, "offset": 327680},
>     { "start": 2097152, "length": 65011712, "depth": 1, "zero": true, "=
data": false}]
>=20
>     $ ./qemu-img map --output=3Djson --image-opts driver=3Draw,file.dri=
ver=3Dqcow2,file.file.driver=3Dfile,file.file.filename=3D/tmp/test.qcow2 =

>     [{ "start": 0, "length": 67108864, "depth": 0, "zero": false, "data=
": false}]
>=20
>     $ ./qemu-img map --output=3Djson --image-opts driver=3Dblkdebug,ima=
ge.driver=3Dqcow2,image.file.driver=3Dfile,image.file.filename=3D/tmp/tes=
t.qcow2=20
>     [{ "start": 0, "length": 67108864, "depth": 0, "zero": false, "data=
": false}]
>=20
> After applying your "deal with filters" series, blkdebug actually print=
s
> the expected result and passes the iotests case, but raw still doesn't.=

> So you must have fixed something for filters that declare themselves
> filters,

I hope to have fixed many things for filters that declare themselves
filters. ;-)

I think the problem is that filters just break backing chains right now.
 My series fixes that.  (So even if you have a blkdebug node on top of
your qcow2 node, you should realize that the node you really care about
is the qcow2 node.  If you look at the filter, you won=92t see the backin=
g
file and will thus interpret unallocated areas the wrong way.)

(The most important problem is that bdrv_is_allocated_above() currently
only goes to the backing_bs().  That=92s fixed by patch 13, =93block: Use=

CAFs in block status functions=94.)

>          even though that semantics should probably be coupled to
> BDRV_BLOCK_RAW instead so that the raw format can benefit from it, too.=


I think BDRV_BLOCK_RAW should just be dropped.  I don=92t see its purpose=

for non-filters now that we have BDRV_BLOCK_RECURSE; and filters should
just be handled generically in bdrv_co_block_status().

Alternatively, we can decide that calling block_status on a filter node
is a bad idea, because the caller may not be prepared for the fact that
block_status will not return information for this node.  But that would
mean dropping BDRV_BLOCK_RAW, too.

Max


--NqEMUugS5GCBbHjN1WyFaHrPo9Afz5KTQ--

--iikr0JkqJbKfacTjc1y7lVO4jEPf51nMq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1Sy3cACgkQ9AfbAGHV
z0CrZQf9HhK4oLPDEqZc7XT0X5OzAQM3TF/AWJC37fQZDb9rdJIWr0rAAgwoOy9r
FgVMxuI7CrnLAvjaLzJzR2gHE18Z8wz+9FGAcHxKbDnsoDyueHoWd4GlAdqQyr+6
1MLhFSmRskwjhiWar9RMKpr6LrnHpsxbCs0Y+DcO4YrULr0iLXu8PI8Iw6ASSazj
sor/4PTUILZfbkOnlMj3KN/stXacikhKamrnTiqLbBqX4uATg5T55X1DlDC31bhY
Kvep4qGP7W3ae1GLcvipdLxOcQGbKjWHUDXO6bo1KWs8sNC7Q6McuUEDVUYML/el
obaRRf+6inm97tBryAAV2VYUUPRSgg==
=lxLY
-----END PGP SIGNATURE-----

--iikr0JkqJbKfacTjc1y7lVO4jEPf51nMq--

