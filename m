Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_RHS_DOB,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42B2C33CAA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 09:43:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8183524679
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 09:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OGYO+AED"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8183524679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itq3n-0004rp-JA
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 04:42:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59544)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1itq33-0004CR-Di
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 04:42:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1itq2z-0007z5-Nt
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 04:42:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46026
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1itq2z-0007ya-KL
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 04:42:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579599729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jgk4io4PkW8I3lfAed/5lWEHZ4SCcIy/FcY323HyQH8=;
 b=OGYO+AED3UODe4A9ynGegeIayo2KDf5iEe+M4wJvTvkapIRIVUvg4AuKnL2g7d2K9d3sSx
 jIng0A2Ev04lAaWVA1ocFPx9wCeN6M8yyu/Go3j4f1WIqNbdWgJ10BpgjpKDd8IU8Ecdyo
 NPq1z+WcMNq1fpZvQiNInVQQo8Lvr0c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-Etc1YKjiNPGzrqcwwe8w2g-1; Tue, 21 Jan 2020 04:42:04 -0500
X-MC-Unique: Etc1YKjiNPGzrqcwwe8w2g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68CF518C43FD;
 Tue, 21 Jan 2020 09:42:03 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AB03C860FE;
 Tue, 21 Jan 2020 09:42:01 +0000 (UTC)
Subject: Re: [PATCH 2/2] iotests: add test for backup-top failure on
 permission activation
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20200116155452.30972-1-vsementsov@virtuozzo.com>
 <20200116155452.30972-3-vsementsov@virtuozzo.com>
 <eedd42b6-bf4e-f6de-13a4-412d389fdb09@redhat.com>
 <ea9219cd-8cc1-8cc0-d568-a51013ba74a4@virtuozzo.com>
 <f52b6ff5-e993-d567-cbbe-1d6d158908da@redhat.com>
 <0e865df2-7d21-b18f-b73c-2948577b9dcb@virtuozzo.com>
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
Message-ID: <1313e55e-0eb1-890a-4e8e-2517f1e80d38@redhat.com>
Date: Tue, 21 Jan 2020 10:41:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <0e865df2-7d21-b18f-b73c-2948577b9dcb@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="PtDoMgSrLQJMwbDDSjkO8lBaupxbFY6XP"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PtDoMgSrLQJMwbDDSjkO8lBaupxbFY6XP
Content-Type: multipart/mixed; boundary="kxHMJBwdgrsl6kLNfn5b1Q0j5epMRXA7C"

--kxHMJBwdgrsl6kLNfn5b1Q0j5epMRXA7C
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 21.01.20 10:23, Vladimir Sementsov-Ogievskiy wrote:
> 21.01.2020 12:14, Max Reitz wrote:
>> On 20.01.20 18:20, Vladimir Sementsov-Ogievskiy wrote:
>>> 20.01.2020 20:04, Max Reitz wrote:
>>>> On 16.01.20 16:54, Vladimir Sementsov-Ogievskiy wrote:
>>>>> This test checks that bug is really fixed by previous commit.
>>>>>
>>>>> Cc: qemu-stable@nongnu.org # v4.2.0
>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>>>> ---
>>>>>    tests/qemu-iotests/283     | 75 ++++++++++++++++++++++++++++++++++=
++++
>>>>>    tests/qemu-iotests/283.out |  8 ++++
>>>>>    tests/qemu-iotests/group   |  1 +
>>>>>    3 files changed, 84 insertions(+)
>>>>>    create mode 100644 tests/qemu-iotests/283
>>>>>    create mode 100644 tests/qemu-iotests/283.out
>>>>
>>>> The test looks good to me, I just have a comment nit and a note on the
>>>> fact that this should probably be queued only after Thomas=E2=80=99s =
=E2=80=9CEnable
>>>> more iotests during "make check-block"=E2=80=9D series.
>>>>
>>>>> diff --git a/tests/qemu-iotests/283 b/tests/qemu-iotests/283
>>>>> new file mode 100644
>>>>> index 0000000000..f0f216d109
>>>>> --- /dev/null
>>>>> +++ b/tests/qemu-iotests/283
>>>>> @@ -0,0 +1,75 @@
>>>>> +#!/usr/bin/env python
>>>>> +#
>>>>> +# Test for backup-top filter permission activation failure
>>>>> +#
>>>>> +# Copyright (c) 2019 Virtuozzo International GmbH.
>>>>> +#
>>>>> +# This program is free software; you can redistribute it and/or modi=
fy
>>>>> +# it under the terms of the GNU General Public License as published =
by
>>>>> +# the Free Software Foundation; either version 2 of the License, or
>>>>> +# (at your option) any later version.
>>>>> +#
>>>>> +# This program is distributed in the hope that it will be useful,
>>>>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>>>> +# GNU General Public License for more details.
>>>>> +#
>>>>> +# You should have received a copy of the GNU General Public License
>>>>> +# along with this program.  If not, see <http://www.gnu.org/licenses=
/>.
>>>>> +#
>>>>> +
>>>>> +import iotests
>>>>> +
>>>>> +# The test is unrelated to formats, restrict it to qcow2 to avoid ex=
tra runs
>>>>> +iotests.verify_image_format(supported_fmts=3D['qcow2'])
>>>>> +
>>>>> +size =3D 1024 * 1024
>>>>> +
>>>>> +"""
>>>>> +On activation, backup-top is going to unshare write permission on it=
s
>>>>> +source child. It will be impossible for the following configuration:
>>>>
>>>> =E2=80=9CThe following configuration will become impossible=E2=80=9D?
>>>
>>> Hmm, no, the configuration is possible. But "it", i.e. "unshare write p=
ermission",
>>> is impossible with such configuration..
>>
>> But backup_top always unshares the write permission on the source.
>=20
> Yes, and I just try to say, that this action will fail. And the test chec=
ks that it
> fails (and it crashes with current master instead of fail).

OK.  So what I was trying to say is that the comment currently only
states that this will fail.  I=E2=80=99d prefer it to also reassure me that=
 it=E2=80=99s
correct that this fails (because all writes on the backup source must go
through backup_top), and that this is exactly what we want to test here.

On first reading, I was wondering why exactly this comment would tell me
all these things, because I didn=E2=80=99t know what the test wants to test=
 in
the first place.

Max

>>>> I think there should be some note that this is exactly what we want to
>>>> test, i.e. what happens when this impossible configuration is attempte=
d
>>>> by starting a backup.  (And maybe why this isn=E2=80=99t allowed; name=
ly because
>>>> we couldn=E2=80=99t do CBW for such write accesses.)
>>>>
>>>>> +
>>>>> +    =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=90  target  =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=90
>>>>> +    =E2=94=82 target =E2=94=82 =E2=97=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80 =E2=94=82 backup_top  =E2=94=82
>>>>> +    =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=98          =E2=94=94=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=98
>>>>> +                            =E2=94=82
>>>>> +                            =E2=94=82 backing
>>>>> +                            =E2=96=BC
>>>>> +                        =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=90
>>>>> +                        =E2=94=82   source    =E2=94=82
>>>>> +                        =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=98
>>>>> +                            =E2=94=82
>>>>> +                            =E2=94=82 file
>>>>> +                            =E2=96=BC
>>>>> +                        =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=90  write perm   =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
>>>>> +                        =E2=94=82    base     =E2=94=82 =E2=97=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80 =E2=94=82 other =E2=94=82
>>>>> +                        =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=98               =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
>>>>
>>>> Cool Unicode art. :-)
>>>
>>> I found the great tool: https://dot-to-ascii.ggerganov.com/
>>
>> Thanks!
>>
>> Max
>>
>>>>> +
>>>>> +Write unsharing will be propagated to the "source->base"link and wil=
l
>>>>> +conflict with other node write permission.
>>>>> +
>>>>> +(Note, that we can't just consider source to be direct child of othe=
r,
>>>>> +as in this case this link will be broken, when backup_top is appende=
d)
>>>>> +"""
>>>>> +
>>>>> +vm =3D iotests.VM()
>>>>> +vm.launch()
>>>>> +
>>>>> +vm.qmp_log('blockdev-add', **{'node-name': 'target', 'driver': 'null=
-co'})
>>>>> +
>>>>> +vm.qmp_log('blockdev-add', **{
>>>>> +    'node-name': 'source',
>>>>> +    'driver': 'blkdebug',
>>>>> +    'image': {'node-name': 'base', 'driver': 'null-co', 'size': size=
}
>>>>> +})
>>>>> +
>>>>> +vm.qmp_log('blockdev-add', **{
>>>>> +    'node-name': 'other',
>>>>> +    'driver': 'blkdebug',
>>>>> +    'image': 'base',
>>>>> +    'take-child-perms': ['write']
>>>>> +})
>>>>> +
>>>>> +vm.qmp_log('blockdev-backup', sync=3D'full', device=3D'source', targ=
et=3D'target')
>>>>> +
>>>>> +vm.shutdown()
>>>>
>>>> [...]
>>>>
>>>>> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
>>>>> index cb2b789e44..d827e8c821 100644
>>>>> --- a/tests/qemu-iotests/group
>>>>> +++ b/tests/qemu-iotests/group
>>>>> @@ -288,3 +288,4 @@
>>>>>    277 rw quick
>>>>>    279 rw backing quick
>>>>>    280 rw migration quick
>>>>> +283 auto quick
>>>>
>>>> Hm.  This would be the first Python test in auto.
>>>
>>> Missed that. It's OK to define it just "quick" and update later.
>>>
>>>>   Thomas=E2=80=99s series has
>>>> at least one patch that seems useful to come before we do this, namely
>>>> =E2=80=9CSkip Python-based tests if QEMU does not support virtio-blk=
=E2=80=9D.  So I
>>>> suppose his series should come before this, then.
>>>>
>>>> Max
>>>>
>>>
>>>
>>
>>
>=20
>=20



--kxHMJBwdgrsl6kLNfn5b1Q0j5epMRXA7C--

--PtDoMgSrLQJMwbDDSjkO8lBaupxbFY6XP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl4mx2cACgkQ9AfbAGHV
z0Cqvwf/Vv4nnO/5e4/jABuSnXBuoIrGPxSMKBCHvqm5F6yE+v9ziUAXgnF00IJs
tHq3RPRc8fRn2pmyWJSvlxX5EzSIDsWG3DlCxrg5ijSGsHxyahmlQ5ZO9+qRxnVG
AmlSf6y0H2vwcnwlCAc1OSrGNmmkFcS3MNyCHynowVsFI5NaB4Vnr8zScNojxJl7
t5YwVMj42eHj2+xubWhSc3w7HVmBZUjsmZH6/q8MXUltoDUaTMrtLknk3PjUbMXE
UjO6eL4i7tY03JVmHTajO4stVTsEyVSbptZOc2xx1LkmciCc1NwCRCK7YjMz6C9U
ejPFIKDCkmpSWKnG1TxzThG2kRwZyg==
=5Hti
-----END PGP SIGNATURE-----

--PtDoMgSrLQJMwbDDSjkO8lBaupxbFY6XP--


