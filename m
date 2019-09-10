Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0153CC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 13:04:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C938520872
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 13:04:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C938520872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7fp1-0003Ay-EZ
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 09:04:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34736)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i7fjr-0000kN-8U
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 08:59:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i7fjp-0006Rw-U8
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 08:59:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49952)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i7fjk-0006OL-EL; Tue, 10 Sep 2019 08:59:13 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ABC1419B1143;
 Tue, 10 Sep 2019 12:59:11 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-90.ams2.redhat.com
 [10.36.117.90])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2112E6012C;
 Tue, 10 Sep 2019 12:59:09 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-5-mreitz@redhat.com>
 <20190904161658.GD21246@localhost.localdomain>
 <b1c56a8b-b4e4-c32a-f577-89a5e2da743e@redhat.com>
 <20190909093604.GB13841@localhost.localdomain>
 <38c0ff7e-dfd3-189e-6026-3642d78e5029@redhat.com>
 <20190909161314.GJ17606@localhost.localdomain>
 <89984d52-881f-a1e4-c14a-2bf05fc789d0@redhat.com>
 <20190910104748.GC4446@localhost.localdomain>
 <00aa6729-5fa0-31e0-8af5-1a91ae034f28@redhat.com>
 <20190910124805.GF4446@localhost.localdomain>
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
Message-ID: <fa2bf3a5-a440-bc89-1896-87f0802e974d@redhat.com>
Date: Tue, 10 Sep 2019 14:59:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190910124805.GF4446@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="dqvUwYoTb4xnDlrWNgsAEsh0c0EFYfkss"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Tue, 10 Sep 2019 12:59:11 +0000 (UTC)
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
--dqvUwYoTb4xnDlrWNgsAEsh0c0EFYfkss
Content-Type: multipart/mixed; boundary="JRLkyrclJRJLXYi0SetKIWiOeIIGMA3e3";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <fa2bf3a5-a440-bc89-1896-87f0802e974d@redhat.com>
Subject: Re: [PATCH v6 04/42] block: Add child access functions
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-5-mreitz@redhat.com>
 <20190904161658.GD21246@localhost.localdomain>
 <b1c56a8b-b4e4-c32a-f577-89a5e2da743e@redhat.com>
 <20190909093604.GB13841@localhost.localdomain>
 <38c0ff7e-dfd3-189e-6026-3642d78e5029@redhat.com>
 <20190909161314.GJ17606@localhost.localdomain>
 <89984d52-881f-a1e4-c14a-2bf05fc789d0@redhat.com>
 <20190910104748.GC4446@localhost.localdomain>
 <00aa6729-5fa0-31e0-8af5-1a91ae034f28@redhat.com>
 <20190910124805.GF4446@localhost.localdomain>
In-Reply-To: <20190910124805.GF4446@localhost.localdomain>

--JRLkyrclJRJLXYi0SetKIWiOeIIGMA3e3
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10.09.19 14:48, Kevin Wolf wrote:
> Am 10.09.2019 um 13:36 hat Max Reitz geschrieben:
>> On 10.09.19 12:47, Kevin Wolf wrote:
>>> Am 10.09.2019 um 11:14 hat Max Reitz geschrieben:
>>>> Maybe we should stop declaring Quorum a filter and then rename the
>>>> bdrv_recurse_is_first_non_filter() to, I don=E2=80=99t know,
>>>> bdrv_recurse_can_be_replaced_by_mirror()?
>>>
>>> Why not.
>>
>> It feels difficult to do in this series because this is a whole new ca=
n
>> of worms.
>>
>> In patch 35, I actually replace the mirror use case by
>> is_filtered_child().  So it looks to me as if that should not be done,=

>> because I should instead fix bdrv_recurse_is_first_non_filter() (and
>> rename it), because quorum does allow replacing its children by mirror=
,
>> even if it does not act as a filter for them.
>>
>> OTOH, there are other users of bdrv_is_first_non_filter().  Those are
>> qmp_block_resize() and external_snapshot_prepare(), who throw an error=

>> if that returns false.
>>
>> I think that=E2=80=99s just wrong.  First of all, I don=E2=80=99t even=
 know why we have
>> that restriction anymore (I can imagine why it used to make sense befo=
re
>> the permission system).  qmp_block_resize() should always work as long=

>> as it can get BLK_PERM_RESIZE; and I don=E2=80=99t know why the parent=
s of some
>> node would care if you take a snapshot of their child.
>=20
> Hm, doesn't it make sense in a way for qmp_block_resize() at least? It
> means that you can't resize just a filter, but you need to resize the
> image that actually provides the data for the filter.

Filters generally implement .bdrv_truncate() by passing it through, so
it should be fine.

> Of course, there is no reason for it to be the _first_ non-filter as
> long as BLK_PERM_RESIZE is shared, but just some non-filter node.
>=20
> Two more random observations:
>=20
> * quorum uses bdrv_filter_default_perms(), which allows BLK_PERM_RESIZE=
=2E
>   I think this is wrong and quorum should make sure that all children a=
re
>   always the same size because otherwise it can't tell what its own siz=
e
>   is. (Or vote on size...? :-/) Probably not a problem in practice as
>   long as we check bdrv_is_first_non_filter().

(=E2=80=9CQuorum is broken=E2=80=9D seems to be a recurring observation.)=


I agree, it shouldn=E2=80=99t share that permission.

> * child_file and child_backing don't implement .resize. So if you resiz=
e
>   a non-top-level image, parents (in particular filters) don't get thei=
r
>   size adjusted. This is probably a bug, too, but one that isn't
>   prevented by bdrv_is_first_non_filter() and should be visible today.

Hm. :-/

The good news is that I can try to fix this independently of this series.=


[...]

>> We have come to two results, as far as I can see:
>>
>> First, naming COW backing nodes =E2=80=9CCOW filtered children=E2=80=9D=
 clashes with our
>> existing use of =E2=80=9Dfilter=E2=80=9D.  There is no point in forcin=
g the =E2=80=9Dfilter=E2=80=9D
>> label on everything.  We can just keep calling (R/W) filters filters a=
nd
>> COW backing children COW children.  The names are succinct enough.
>>
>> In some cases, we don=E2=80=99t care whether something is a COW or fil=
tered
>> child, in such a case a caller can be bothered to use the slightly
>> longer bdrv_cow_or_filtered_child().
>=20
> Aye.
>=20
>> Second, most of the time we want a filter node to have a clear and
>> unique path to go down.  This is the important property of filters: Th=
at
>> you can skip them and go to the node that actually has the data.
>>
>> Quorum breaks this by having multiple children, and nobody knows which=

>> of them has the data we will see on the next read operation.
>>
>> All =E2=80=9Cfilters=E2=80=9D who could have multiple children would h=
ave this problem.
>>  Hence a filter must always have a single unique data child.  I think.=

>=20
> I agree, and this is the condition that I mentioned somewhere above, bu=
t
> failed to actually find guaranteed somewhere. We should probably make
> this explicit.
>=20
> Of course, quorum and similar things intend all their children to
> provide the same data, but the whole point of the driver is that this i=
s
> not always guaranteed, so they aren't actually filters.

OK, great, I=E2=80=99ll get cracking then.

Max


--JRLkyrclJRJLXYi0SetKIWiOeIIGMA3e3--

--dqvUwYoTb4xnDlrWNgsAEsh0c0EFYfkss
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl13nhwACgkQ9AfbAGHV
z0AMHgf+JaaRsV6tsDqQMQH2WbQsaXuAykrfdPPdxSfjq+Jdg9PVIoDgx2ZGdLHr
2GPSCBjrIqAK94gtT1mWQhH8fbeCHwpG4NdefJ/qlkp1L2gX3c7gBfjV4mNNy+7q
Igz7QeAeHgHQvBfWg6rTKREmm+F9UBbr8D81hfuoKzkdfTqAJRgfcf5z0EIjxcZr
7MpZ5PKkFFFdHbkG/Rm6o1Cw8VM2Zggdz+EAeijb3Sv0wzEf1NUrYrVD98Go0bYP
E/+d1Gn5qcnOoncbeWgT1SjnOzCQYa6XVuOyGUwUrGS/7Xuj4iNO2vqkjSyRTMc4
8SSj4/Ph+rfPvwyYG/Vgguq47y+QYQ==
=MbFk
-----END PGP SIGNATURE-----

--dqvUwYoTb4xnDlrWNgsAEsh0c0EFYfkss--

