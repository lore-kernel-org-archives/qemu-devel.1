Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD19C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 16:08:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6025920840
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 16:08:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6025920840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxZLy-00089O-Im
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 12:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55584)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hxZL4-0007J9-7a
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 12:07:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hxZL3-00068V-16
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 12:07:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57450)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hxZL0-000676-8p; Tue, 13 Aug 2019 12:07:54 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0DA8D3C917;
 Tue, 13 Aug 2019 16:07:53 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C08880487;
 Tue, 13 Aug 2019 16:07:51 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>
References: <20190812181146.26121-1-vsementsov@virtuozzo.com>
 <20190812181146.26121-2-vsementsov@virtuozzo.com>
 <20190813110428.GE4663@localhost.localdomain>
 <fef7f4d1-b40e-6c84-3952-120a641a8061@redhat.com>
 <6af67f42-b5ee-1ca9-6fb1-500fd993616a@virtuozzo.com>
 <d0b0fc4e-eb2f-796d-3413-366a6bb5aeca@redhat.com>
 <8346455b-b250-bffd-c79b-ea8363e2116d@virtuozzo.com>
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
Message-ID: <cea7672c-e035-c3ee-29c7-a87648069481@redhat.com>
Date: Tue, 13 Aug 2019 18:07:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <8346455b-b250-bffd-c79b-ea8363e2116d@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="p7z5WB12qoLQyUwV0facexK51AJrK7iWQ"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Tue, 13 Aug 2019 16:07:53 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/2] block/raw-format: switch to
 BDRV_BLOCK_DATA with BDRV_BLOCK_RECURSE
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--p7z5WB12qoLQyUwV0facexK51AJrK7iWQ
Content-Type: multipart/mixed; boundary="uVMbGdE9g6IvWRbdijQa9NGR7Y5Ksct8I";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Message-ID: <cea7672c-e035-c3ee-29c7-a87648069481@redhat.com>
Subject: Re: [PATCH 1/2] block/raw-format: switch to BDRV_BLOCK_DATA with
 BDRV_BLOCK_RECURSE
References: <20190812181146.26121-1-vsementsov@virtuozzo.com>
 <20190812181146.26121-2-vsementsov@virtuozzo.com>
 <20190813110428.GE4663@localhost.localdomain>
 <fef7f4d1-b40e-6c84-3952-120a641a8061@redhat.com>
 <6af67f42-b5ee-1ca9-6fb1-500fd993616a@virtuozzo.com>
 <d0b0fc4e-eb2f-796d-3413-366a6bb5aeca@redhat.com>
 <8346455b-b250-bffd-c79b-ea8363e2116d@virtuozzo.com>
In-Reply-To: <8346455b-b250-bffd-c79b-ea8363e2116d@virtuozzo.com>

--uVMbGdE9g6IvWRbdijQa9NGR7Y5Ksct8I
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13.08.19 17:22, Vladimir Sementsov-Ogievskiy wrote:
> 13.08.2019 18:03, Max Reitz wrote:
>> On 13.08.19 16:56, Vladimir Sementsov-Ogievskiy wrote:
>>> 13.08.2019 17:43, Max Reitz wrote:
>>>> On 13.08.19 13:04, Kevin Wolf wrote:
>>>>> Am 12.08.2019 um 20:11 hat Vladimir Sementsov-Ogievskiy geschrieben=
:
>>>>>> BDRV_BLOCK_RAW makes generic bdrv_co_block_status to fallthrough t=
o
>>>>>> returned file. But is it correct behavior at all? If returned file=

>>>>>> itself has a backing file, we may report as totally unallocated an=
d
>>>>>> area which actually has data in bottom backing file.
>>>>>>
>>>>>> So, mirroring of qcow2 under raw-format is broken. Which is illust=
rated
>>>>>> by following commit with a test. Let's make raw-format behave more=

>>>>>> correctly returning BDRV_BLOCK_DATA.
>>>>>>
>>>>>> Suggested-by: Max Reitz <mreitz@redhat.com>
>>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.=
com>
>>>>>
>>>>> After some reading, I think I came to the conclusion that RAW is th=
e
>>>>> correct thing to do. There is indeed a problem, but this patch is t=
rying
>>>>> to fix it in the wrong place.
>>>>>
>>>>> In the case where the backing file contains some data, and we have =
a
>>>>> 'raw' node above the qcow2 overlay node, the content of the respect=
ive
>>>>> block is not defined by the queried backing file layer, so it is
>>>>> completely correct that bdrv_is_allocated() returns false,like it w=
ould
>>>>> if you queried the qcow2 layer directly.
>>>>
>>>> I disagree.  The queried backing file layer is the raw node.  As I s=
aid,
>>>> in my opinion raw nodes are not filter nodes, neither in behavior (t=
hey
>>>> have an offset option), nor in how they are generally used (as a for=
mat).
>>>>
>>>> The raw format does not support backing files.  Therefore, everythin=
g on
>>>> a raw node is allocated.
>>>>
>>>
>>> Could you tell me at least, what means "allocated" ?
>>>
>>> It's a term that describing a region somehow.. But how? Allocated whe=
re?
>>> In raw node, in its child or both? Am I right that if region allocate=
d in
>>> one of non-cow children it is assumed to be allocated in parent too? =
Or what?
>>>
>>> And it's unrelated to real disk allocation which (IMHO) directly show=
s that
>>> this a bad term.
>>
>> It=E2=80=99s a term for COW backing chains.  If something is allocated=
 on a
>> given node in a COW backing chain, it means it is either present in
>> exactly that node or in one of its storage children (in case the node =
is
>> a format node).  If it is not allocated, it is not, and read accesses
>> will be forwarded to the COW backing child.
>>
>=20
> And this definition leads exactly to bug in these series:
>=20
>=20
> [raw]
>    |
>    |file
>    V       file
> [qcow2]--------->[file]
>    |
>    |backing
>    V
> [base]
>=20
>=20
> Assume something is actually allocated in [base] but not in [qcow2].
> So, [qcow2] node reports it as unallocated. So nobdy of [raw]'s storage=

> children contains this as allocated, so it's unallocated in [raw].

Well, I would say it is in raw=E2=80=99s storage child, because the defin=
ition
of backing chain allocation only recurses down the COW link.

If it is *anywhere* in the storage subtree, it is to be considered
allocated on this level.  If it is in the backing COW subtree, it is not.=


And if it is in neither, it doesn=E2=80=99t matter whether we say it=E2=80=
=99s allocated
or not:

For example (1), for sparse files, the raw driver may not have the data
in the storage subtree.  But it sure as hell won=E2=80=99t have it in its=

backing COW subtree, because it doesn=E2=80=99t have one.  So for simplic=
ity=E2=80=99s
sake, it may just return everything as allocated.

For example (2), for sparse qcow2 files, the qcow2 driver may report
some ranges as unallocated even when it doesn=E2=80=99t have a backing fi=
le.  We
don=E2=80=99t need to change it to report such cases as allocated.

Max


--uVMbGdE9g6IvWRbdijQa9NGR7Y5Ksct8I--

--p7z5WB12qoLQyUwV0facexK51AJrK7iWQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1S4FUACgkQ9AfbAGHV
z0CKDQf/bvqPYbH+ijyWxbQvCuRCaDJOGo+Foj/L4r58AGfCYqJWfE5DLBmpJYk/
3a330R2D2/sAnIGnryf6IdEgNf6/RG8VPUsZAuW/46dGitHizvLoPwC9N+nZaBfd
KRsAXyEmZA7hbWdikEsws3JGtcbeLPDb2LOsc6N4fzlbuCAI1Ji/ERNNUwpDgss5
lWuy/DR9f9TcwqiCEGnnEZ6Xlpl0xHVArpJRznomWj5jOwzJUUwDHFz5+U/ZNzwp
CloPfCeZk5YbPJRIJuXZyTEF8mpc3h9Hu+lq9/cc+Jf8mIDbnrQcMjVRVm62nFNa
tljpQsnP9zEpWkXBY6l9Jbpvy9Y+ww==
=PXDf
-----END PGP SIGNATURE-----

--p7z5WB12qoLQyUwV0facexK51AJrK7iWQ--

