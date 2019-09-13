Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E93C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 11:56:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C030206BB
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 11:56:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C030206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8kBm-0005jn-9n
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 07:56:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49852)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i8kB3-0005DX-8t
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 07:55:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i8kB2-0000Jj-7k
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 07:55:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53984)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i8kAz-0000IX-V0; Fri, 13 Sep 2019 07:55:46 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 36F7A87521D;
 Fri, 13 Sep 2019 11:55:45 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-81.ams2.redhat.com
 [10.36.116.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C5B5710016EB;
 Fri, 13 Sep 2019 11:55:40 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>
References: <20190816153015.447957-1-vsementsov@virtuozzo.com>
 <20190816153015.447957-4-vsementsov@virtuozzo.com>
 <20190913100146.GC8312@dhcp-200-226.str.redhat.com>
 <d6ca4ea6-2939-4d0f-c6f6-ff32a337de01@virtuozzo.com>
 <40620e71-a5e0-b955-d310-eef14ad3871c@redhat.com>
 <20190913113459.GE8312@dhcp-200-226.str.redhat.com>
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
Message-ID: <294e305a-d93c-d833-ca2a-c18a829c0f90@redhat.com>
Date: Fri, 13 Sep 2019 13:55:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190913113459.GE8312@dhcp-200-226.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mOkbSxtNbAAOMjUMCE6qSdL5ad2WL4Y9c"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Fri, 13 Sep 2019 11:55:45 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 3/5] block/qcow2: refactor
 qcow2_co_preadv_part
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
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mOkbSxtNbAAOMjUMCE6qSdL5ad2WL4Y9c
Content-Type: multipart/mixed; boundary="3CAH99QvavgTMuSdw1z7jTWl4T9jpkaP3";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "eblake@redhat.com" <eblake@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Message-ID: <294e305a-d93c-d833-ca2a-c18a829c0f90@redhat.com>
Subject: Re: [PATCH v4 3/5] block/qcow2: refactor qcow2_co_preadv_part
References: <20190816153015.447957-1-vsementsov@virtuozzo.com>
 <20190816153015.447957-4-vsementsov@virtuozzo.com>
 <20190913100146.GC8312@dhcp-200-226.str.redhat.com>
 <d6ca4ea6-2939-4d0f-c6f6-ff32a337de01@virtuozzo.com>
 <40620e71-a5e0-b955-d310-eef14ad3871c@redhat.com>
 <20190913113459.GE8312@dhcp-200-226.str.redhat.com>
In-Reply-To: <20190913113459.GE8312@dhcp-200-226.str.redhat.com>

--3CAH99QvavgTMuSdw1z7jTWl4T9jpkaP3
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13.09.19 13:34, Kevin Wolf wrote:
> Am 13.09.2019 um 13:06 hat Max Reitz geschrieben:
>> On 13.09.19 12:53, Vladimir Sementsov-Ogievskiy wrote:
>>> 13.09.2019 13:01, Kevin Wolf wrote:
>>>> Am 16.08.2019 um 17:30 hat Vladimir Sementsov-Ogievskiy geschrieben:=

>>>>> Further patch will run partial requests of iterations of
>>>>> qcow2_co_preadv in parallel for performance reasons. To prepare for=

>>>>> this, separate part which may be parallelized into separate functio=
n
>>>>> (qcow2_co_preadv_task).
>>>>>
>>>>> While being here, also separate encrypted clusters reading to own
>>>>> function, like it is done for compressed reading.
>>>>>
>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.c=
om>
>>>>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>>>>> ---
>>>>>   qapi/block-core.json |   2 +-
>>>>>   block/qcow2.c        | 205 +++++++++++++++++++++++---------------=
-----
>>>>>   2 files changed, 111 insertions(+), 96 deletions(-)
>>>>>
>>>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>>>> index 0d43d4f37c..dd80aa11db 100644
>>>>> --- a/qapi/block-core.json
>>>>> +++ b/qapi/block-core.json
>>>>> @@ -3266,7 +3266,7 @@
>>>>>               'pwritev_rmw_tail', 'pwritev_rmw_after_tail', 'pwrite=
v',
>>>>>               'pwritev_zero', 'pwritev_done', 'empty_image_prepare'=
,
>>>>>               'l1_shrink_write_table', 'l1_shrink_free_l2_clusters'=
,
>>>>> -            'cor_write', 'cluster_alloc_space', 'none'] }
>>>>> +            'cor_write', 'cluster_alloc_space', 'none', 'read_encr=
ypted'] }
>>>>
>>>> What's the point of this new blkdebug event?
>>>>
>>>> Obviously, read_aio for an encrypted image must mean a read of encry=
pted
>>>> data. The same image can never trigger both read_aio and
>>>> read_encrypted, so why do we need to distinguish them as two differe=
nt
>>>> events?
>>>>
>>>
>>> Seems I just done it looking at qcow2_co_preadv_compressed..
>>>
>>> Anyway, I think you are right, so, I don't mind if Max drops this new=
 event
>>> and use read_aio in his branch, or I can resend the series or send a =
follow-up,
>>> whichever you prefer.
>>
>> Should I squash this in?
>=20
> Looks good to me.

OK, done.

Max


--3CAH99QvavgTMuSdw1z7jTWl4T9jpkaP3--

--mOkbSxtNbAAOMjUMCE6qSdL5ad2WL4Y9c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl17g7oACgkQ9AfbAGHV
z0C0wggAmoVtKhIN2GjJv/t4okehGKnqzfRRjZCvWzHbC44jVCI1GALZCeSGDRAs
P2db5yv/gQFDqCNn5VWh+52fUYx6xFyxbpNNwrSeopA9sEiQTd6qRK27kBnsDdbU
u1JMp3lRQEj0Bf8eV8OO0BSYvqYOG2EFtAVSYrc1WqCJYRdFCgjzHSDBxCr2xJ1X
hmAYky67m7xMAihQwSzs32+Csb7HPR5CfhWT6dzBL18hfq6jddg0Pw+Bd0Xia2wK
JlVUbrCHx+PAQPRoUM2AoDw9zlR58cWyfxAOSzBZLoj/E/gamI6WdnO9ZMRUHS57
o5ll0kqBaO1nYEpMmzjXfHADPZxh/A==
=2aJG
-----END PGP SIGNATURE-----

--mOkbSxtNbAAOMjUMCE6qSdL5ad2WL4Y9c--

