Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1830C432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 11:00:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C77A7207E0
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 11:00:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C77A7207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDRVL-0002ny-Sh
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 07:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48774)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iDRTz-00021T-Ek
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 06:58:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iDRTx-0004Gm-G6
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 06:58:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:26305)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iDRTq-00047w-JP; Thu, 26 Sep 2019 06:58:38 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7CF3B10CC1F1;
 Thu, 26 Sep 2019 10:58:36 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.151])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 570FD1001B20;
 Thu, 26 Sep 2019 10:58:35 +0000 (UTC)
Subject: Re: [PATCH 2/3] iotests: Disable 125 on broken XFS versions
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20190925183231.11196-1-mreitz@redhat.com>
 <20190925183231.11196-3-mreitz@redhat.com>
 <ed2e18dc-1217-7825-aebd-af48e440ef96@redhat.com>
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
Message-ID: <1e3bb4f4-f2a0-ce38-aa82-d87291ef9b3c@redhat.com>
Date: Thu, 26 Sep 2019 12:58:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <ed2e18dc-1217-7825-aebd-af48e440ef96@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qXvzepnHyO0CeojG2YD0l5jqFkfUPgZUO"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Thu, 26 Sep 2019 10:58:36 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qXvzepnHyO0CeojG2YD0l5jqFkfUPgZUO
Content-Type: multipart/mixed; boundary="YEkCJa7uHhQNOtd40bqrUnKfW3KGOa573"

--YEkCJa7uHhQNOtd40bqrUnKfW3KGOa573
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25.09.19 23:28, Eric Blake wrote:
> On 9/25/19 1:32 PM, Max Reitz wrote:
>> And by that I mean all XFS versions, as far as I can tell.=C2=A0 All d=
etails
>> are in the comment below.
>>
>> We never noticed this problem because we only read the first number fr=
om
>> qemu-img info's "disk size" output -- and that is effectively useless,=

>> because qemu-img prints a human-readable value (which generally includ=
es
>> a decimal point).=C2=A0 That will be fixed in the next patch.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> =C2=A0 tests/qemu-iotests/125 | 40 +++++++++++++++++++++++++++++++++++=
+++++
>> =C2=A0 1 file changed, 40 insertions(+)
>>
>> diff --git a/tests/qemu-iotests/125 b/tests/qemu-iotests/125
>> index df328a63a6..0ef51f1e21 100755
>> --- a/tests/qemu-iotests/125
>> +++ b/tests/qemu-iotests/125
>> @@ -49,6 +49,46 @@ if [ -z "$TEST_IMG_FILE" ]; then
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TEST_IMG_FILE=3D$TEST_IMG
>> =C2=A0 fi
>> =C2=A0 +# Test whether we are running on a broken XFS version.=C2=A0 T=
here is this
>> +# bug:
>> +
>> +# $ rm -f foo
>> +# $ touch foo
>> +# $ block_size=3D4096 # Your FS's block size
>> +# $ fallocate -o $((block_size / 2)) -l $block_size foo
>> +# $ LANG=3DC xfs_bmap foo | grep hole
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1: [8..15]: hole
>> +#
>> +# The problem is that the XFS driver rounds down the offset and
>> +# rounds up the length to the block size, but independently.
>=20
> Eww. I concur you uncovered a bug.=C2=A0 Have you reported this to xfs =
folks?

I have now.  Took a bit of kernel compiling to see whether what I think
would fix it works.

Max


--YEkCJa7uHhQNOtd40bqrUnKfW3KGOa573--

--qXvzepnHyO0CeojG2YD0l5jqFkfUPgZUO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2MmdkACgkQ9AfbAGHV
z0DBUwgAgNT4hYsOkStB7xxaeacBKmbpqBpHtjKEIvgj2rB7IxtZLEg+Ua0bwMd5
eUDADNR+DKEgIKTxvQF7dR6QurgxRe92D77A3ZBu01T9OW+DHoccoAAH05JxqIvL
FlGp2Q5B2bg50yvb4agimm0eM2m/ya4fXpx8FCyd4ibzRq3N0W4/hk7XJDKwsb7V
f7sZT/7idUmsP+AgwZg3NylCW94uF38IJnnQzSZMK54yFVfBYo66digP3nUf8kvB
znN9QbxuZdSMOvRZPPvwEPC5BIARf4ZKKeEdKAHcn/VHS29/bR1NGcW2epUchCJN
bo7jiMvX1V3+O80k4s+lZ75S98UqtA==
=GM4G
-----END PGP SIGNATURE-----

--qXvzepnHyO0CeojG2YD0l5jqFkfUPgZUO--

