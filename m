Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660A7C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 16:47:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3171C206C2
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 16:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3171C206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAzaO-0002Fd-4x
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 12:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45573)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iAzYe-0000s8-SK
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 12:45:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iAzYd-0006yB-7P
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 12:45:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47264)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iAzYZ-0006sT-7C; Thu, 19 Sep 2019 12:45:23 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 72C393C92D;
 Thu, 19 Sep 2019 16:45:22 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.61])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 518485D6B0;
 Thu, 19 Sep 2019 16:45:15 +0000 (UTC)
Subject: Re: [Qemu-devel] [PATCH 0/4] mirror: Do not dereference invalid
 pointers
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190912135632.13925-1-mreitz@redhat.com>
 <0af49571-c3a1-2887-8873-bfa94bb42cb4@virtuozzo.com>
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
Message-ID: <00893c8e-f67b-db95-cfb9-bc1059470091@redhat.com>
Date: Thu, 19 Sep 2019 18:45:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0af49571-c3a1-2887-8873-bfa94bb42cb4@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gigU1OoP51b5w1xkDKI5YMIHHGu567HWC"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Thu, 19 Sep 2019 16:45:22 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gigU1OoP51b5w1xkDKI5YMIHHGu567HWC
Content-Type: multipart/mixed; boundary="vLdWoxBYEU5KCU7cazgyUQsDQnXxwMSR9";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <00893c8e-f67b-db95-cfb9-bc1059470091@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/4] mirror: Do not dereference invalid
 pointers
References: <20190912135632.13925-1-mreitz@redhat.com>
 <0af49571-c3a1-2887-8873-bfa94bb42cb4@virtuozzo.com>
In-Reply-To: <0af49571-c3a1-2887-8873-bfa94bb42cb4@virtuozzo.com>

--vLdWoxBYEU5KCU7cazgyUQsDQnXxwMSR9
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 18.09.19 17:38, Vladimir Sementsov-Ogievskiy wrote:
> 12.09.2019 16:56, Max Reitz wrote:
>> Hi,
>>
>> The fix (patch 1) is pretty straightforward; patch 2 (which I need for=

>> the test) may not be.
>>
>> The biggest problem with patch 2 is that you can use it to uncover whe=
re
>> our permission handling is broken.  For example, devising the test cas=
e
>> (patch 4) was very difficult because I kept running into the
>> &error_abort that mirror_exit_common() passes when dropping the
>> mirror_top_bs.
>>
>> The problem is that mirror_top_bs does not take the same permissions
>> that its parent takes.  Ergo using &error_abort when dropping it is
>> wrong: The parent may require more permissions that mirror_top_bs did,=

>> and so dropping mirror_top_bs may fail.
>>
>> Now what=E2=80=99s really bad is that this cannot be fixed with our cu=
rrent
>> permission system.  mirror_top_bs was introduced precisely so it does
>> not take CONSISTENT_READ, but can still allow parents to take it (for
>> active commits).  But what if there is actually something besides the
>> mirror job that unshares CONSISTENT_READ?
>>
>>
>> Imagine this:
>>
>>        mirror target BB       mirror source BB
>>                    |             |
>>                    v             v
>> mirror_top_bs -> top -> mid -> base
>>                    ^
>>                    |
>>               other_parent
>>
>> The source BB unshares CONSISTENT_READ on the base.  mirror_top_bs
>> ensures that its parents can read from top even though top itself cann=
ot
>> allow CONSISTENT_READ to be taken.  So far so good.
>>
>> But what if other_parent also unshares CONSISTENT_READ?  Then,
>> mirror_top_bs has no business allowing its parents to take it.
>>
>> No idea how to fix that.  (I suppose mirror_top_bs would need some way=

>> to verify that there is no other party that has unshared CONSISTENT_RE=
AD
>> but its associated source BB.
>=20
> May be we need grouped permissions?
>=20
> Some way to define group of children, which may unshare read permission=

> for other children (out of the group), but still children in group may
> have read permission?

Hm, is that different from my idea below where one of mirror_top's
children unshares the read permission, and another is allowed to take it
still?

(The problem is always that if some BDS has a parent that unshares this
permission, this condition propagates upwards through its other parents,
and we need to keep track of who unshared it in the first place.)

> But it don't work here as we are saying about children on different
> nodes.. And propagated through backing chain permissions..

Yep.

>>  In the future, we want the source BB to
>> go away and instead have the source be an immediate BdrvChild of
>> mirror_top_bs.  Maybe we can then build something into the block layer=

>> so that a node can only restore CONSISTENT_READ when it was that node
>> that broke it?)
>>
>>
>> Anyway.  You can see something arising from this problem simply by
>> unsharing CONSISTENT_READ on the target node.  (Just drop the src-perm=

>> node from the test I add in patch 4.)  Replacing the source with the
>> target will then work fine (because mirror_top_bs doesn=E2=80=99t care=
 about
>> CONSISTENT_READ being removed), but then you cannot drop mirror_top_bs=
 =E2=80=93
>> because its parent does want CONSISTENT_READ.  Thus, the &error_abort
>> aborts.
>>
>>
>> While this is a more special case, I have no idea how to fix this one
>> either.
>>
>>
>> Soo...  This series just fixes one thing, and leaves another unfixed
>> because I have no idea how to fix it.  Worse, it adds parameters to
>> blkdebug to actually see the problem.  Do we want to let blkdebug be
>> able to crash qemu (because of a bug in qemu)?
>>
>=20
> blkdebug is for debugging and not used by end users like libvirt, yes?

Correct.

Max

>>
>> Max Reitz (4):
>>    mirror: Do not dereference invalid pointers
>>    blkdebug: Allow taking/unsharing permissions
>>    iotests: Add @error to wait_until_completed
>>    iotests: Add test for failing mirror complete
>>
>>   qapi/block-core.json          |  29 +++++++++-
>>   block/blkdebug.c              | 106 ++++++++++++++++++++++++++++++++=
+-
>>   block/mirror.c                |  13 +++--
>>   tests/qemu-iotests/041        |  44 ++++++++++++++
>>   tests/qemu-iotests/041.out    |   4 +-
>>   tests/qemu-iotests/iotests.py |  18 ++++--
>>   6 files changed, 200 insertions(+), 14 deletions(-)
>>
>=20
>=20



--vLdWoxBYEU5KCU7cazgyUQsDQnXxwMSR9--

--gigU1OoP51b5w1xkDKI5YMIHHGu567HWC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2DsJkACgkQ9AfbAGHV
z0AVwgf/bq+7mVg7paLlN4me7pUfDxHtKqnyCxZIZYFPHX6lgUcxwZE/NWI6RP9Y
8mRhekQ7yeAvUp3RzX24NgmHOF2fG4FTLbrcyTlsXGJXNBTKiIdjJ99pOaGPrE2w
EyqujaRuKhC7WPIaQdiAsLFBYxibTLNstrCOYpAK6m1sMtMXLR0+KVTRH50UBhmb
31mjiHImpY6Dt9JwdDgJBgWWDBUGRU2H/oXaESDJwcCAKppsvHsEhQMKRK3DFICU
EhAmHXjoo1bAk08S1ZgJKXSGS/V7hYqzCh2z+Nu+gIYzSq5OYpk4tKMq4I0BLGaS
Kc7RsmSOEUIDUg43zen9SizXNv089g==
=c+b0
-----END PGP SIGNATURE-----

--gigU1OoP51b5w1xkDKI5YMIHHGu567HWC--

