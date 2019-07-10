Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4916BC74A35
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 20:32:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F379208C4
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 20:32:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F379208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlJGH-0003lJ-DO
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 16:32:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60014)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hlJEY-0002Rb-GC
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 16:30:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hlJEX-0003BN-4B
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 16:30:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49024)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hlJEU-00033p-Ew; Wed, 10 Jul 2019 16:30:30 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BD9A8A3816;
 Wed, 10 Jul 2019 20:30:29 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.108])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C69F360BFB;
 Wed, 10 Jul 2019 20:30:24 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20190710010556.32365-1-jsnow@redhat.com>
 <20190710010556.32365-7-jsnow@redhat.com>
 <24cb63cb-e19c-c4cb-fb08-c8f1d086cabf@redhat.com>
 <5b3f6dad-c438-861f-b4cf-236b3f058322@redhat.com>
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
Message-ID: <4e9b8a92-c98d-0f19-3f8f-636dc64ca0b4@redhat.com>
Date: Wed, 10 Jul 2019 22:30:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <5b3f6dad-c438-861f-b4cf-236b3f058322@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="dBge6pH0Lzynq8ZY288Ww0a5tF6U9lLVr"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Wed, 10 Jul 2019 20:30:29 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 6/8] block/backup: issue progress updates
 for skipped regions
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
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dBge6pH0Lzynq8ZY288Ww0a5tF6U9lLVr
Content-Type: multipart/mixed; boundary="6dN0MiGsf4FCD4UPFDcwwVjU2MvvZdOuu";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>
Message-ID: <4e9b8a92-c98d-0f19-3f8f-636dc64ca0b4@redhat.com>
Subject: Re: [PATCH 6/8] block/backup: issue progress updates for skipped
 regions
References: <20190710010556.32365-1-jsnow@redhat.com>
 <20190710010556.32365-7-jsnow@redhat.com>
 <24cb63cb-e19c-c4cb-fb08-c8f1d086cabf@redhat.com>
 <5b3f6dad-c438-861f-b4cf-236b3f058322@redhat.com>
In-Reply-To: <5b3f6dad-c438-861f-b4cf-236b3f058322@redhat.com>

--6dN0MiGsf4FCD4UPFDcwwVjU2MvvZdOuu
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10.07.19 20:20, John Snow wrote:
>=20
>=20
> On 7/10/19 12:36 PM, Max Reitz wrote:
>> On 10.07.19 03:05, John Snow wrote:
>>> The way bitmap backups work is by starting at 75% if it needs
>>> to copy just 25% of the disk.
>>
>> Although there is this comment:
>>
>>> /* TODO job_progress_set_remaining() would make more sense */
>>
>> So...
>>
>>> The way sync=3Dtop currently works, however, is to start at 0% and th=
en
>>> never update the progress if it doesn't copy a region. If it needs to=

>>> copy 25% of the disk, we'll finish at 25%.
>>>
>>> Update the progress when we skip regions.
>>
>> Wouldn=E2=80=99t it be more correct to decrease the job length?
>>
>> Max
>>
>=20
> Admittedly I have precisely no idea. Maybe? As far as I understand it,
> we guarantee only:
>=20
> (1) Progress monotonically increases
> (2) Upon completion, progress will equal the total work estimate.
>     [Trying to fix that to be true here.]
>=20
> This means we can do stuff like:
>=20
> - Total work estimate can increase or decrease arbitrarily
> - Neither value has to mean anything in particular
>=20
>=20
> Bitmap sync works by artificially increasing progress for NOP regions,
> seen in init_copy_bitmap.

Yes, and it has a TODO comment that says it should be done differently.

> Full sync also tends to increase progress regardless of it actually did=

> a copy or not; offload support also counts as progress here. So if you
> full sync an empty image, you'll see it increasing the progress as it
> doesn't actually do anything.
>=20
> Top sync is the odd one out, which just omits progress for regions it s=
kips.
>=20
> My only motivation here was to make them consistent. Can I do it the
> other way? Yeah, probably. Is one way better than the other? I
> legitimately have no idea. I guess whoever wrote the last comment felt
> that it should all be the other way instead. Why'd they not do that?

If you look at the commit (05df8a6a2b4), I suppose it was because that
commit simply did not intend to change behavior.  It just touched that
piece of code and noted that maybe there should be a follow-up commit to
change it.

But yeah, whatever.

Reviewed-by: Max Reitz <mreitz@redhat.com>


--6dN0MiGsf4FCD4UPFDcwwVjU2MvvZdOuu--

--dBge6pH0Lzynq8ZY288Ww0a5tF6U9lLVr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0mSt8ACgkQ9AfbAGHV
z0ALigf+KKGS+aX0LyvoMjLPDms8jBuvWQCV/PFOw9C7zxaoVqZzVu1nIALmQbfc
vlP+hOBb5vBrvqA/8D3B6yW5TjwU9/fsxCgulgMMRYFvqbCgcRTaHgWQeqtcRVvm
T2MVZ+qGrbp78pz4Ht52kN0JZDsIAjgRC/gy9L2rjLpnuRIitrnpuKRqS73Wzo/F
ceNqBuqB/DjfYYoyD0iOEOeWYDxWquA3x5BD8kuhSBU0cnraxP/PHrY6ewMGo79a
z3Xh9UzNKu35meqqY7hreCrvJGk4KmP22vg4+VvCxO2YKX9LYghtI9VZmNyCwnDR
YOnEQsS6BV1PH8Y694iZZPSb8OtWIw==
=TJiF
-----END PGP SIGNATURE-----

--dBge6pH0Lzynq8ZY288Ww0a5tF6U9lLVr--

