Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE92C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 19:07:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F9B62075B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 19:07:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F9B62075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxFfY-0008NQ-UE
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 15:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49217)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hxFfA-0007ub-2C
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 15:07:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hxFf9-0001rW-2G
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 15:07:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56160)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hxFf6-0001qY-Tf; Mon, 12 Aug 2019 15:07:21 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 432C281DE7;
 Mon, 12 Aug 2019 19:07:20 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-161.brq.redhat.com
 [10.40.204.161])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 180EB19C4F;
 Mon, 12 Aug 2019 19:07:18 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190725155512.9827-1-mreitz@redhat.com>
 <20190725155512.9827-4-mreitz@redhat.com>
 <627fbb64-5ffe-aca7-6198-9d991d4219e3@virtuozzo.com>
 <f50d585c-ac91-5dfa-365b-efda321aeffa@redhat.com>
 <eaf85ded-c537-ceb3-9277-6765bb672daa@virtuozzo.com>
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
Message-ID: <fa7313b1-2f21-39dd-b1fd-8372c6100cef@redhat.com>
Date: Mon, 12 Aug 2019 21:07:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <eaf85ded-c537-ceb3-9277-6765bb672daa@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="N4UvEtEy1niSNF0yWAKVEC2p65o8ZsnA9"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Mon, 12 Aug 2019 19:07:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/3] vpc: Do not return RAW from
 block_status
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--N4UvEtEy1niSNF0yWAKVEC2p65o8ZsnA9
Content-Type: multipart/mixed; boundary="liNzYjQmliiZ6oztyIQnPlZ0W1Ex1B02S";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <fa7313b1-2f21-39dd-b1fd-8372c6100cef@redhat.com>
Subject: Re: [PATCH 3/3] vpc: Do not return RAW from block_status
References: <20190725155512.9827-1-mreitz@redhat.com>
 <20190725155512.9827-4-mreitz@redhat.com>
 <627fbb64-5ffe-aca7-6198-9d991d4219e3@virtuozzo.com>
 <f50d585c-ac91-5dfa-365b-efda321aeffa@redhat.com>
 <eaf85ded-c537-ceb3-9277-6765bb672daa@virtuozzo.com>
In-Reply-To: <eaf85ded-c537-ceb3-9277-6765bb672daa@virtuozzo.com>

--liNzYjQmliiZ6oztyIQnPlZ0W1Ex1B02S
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12.08.19 18:50, Vladimir Sementsov-Ogievskiy wrote:
> 12.08.2019 18:56, Max Reitz wrote:
>> On 12.08.19 17:33, Vladimir Sementsov-Ogievskiy wrote:
>>> 25.07.2019 18:55, Max Reitz wrote:
>>>> vpc is not really a passthrough driver, even when using the fixed
>>>> subformat (where host and guest offsets are equal).  It should handl=
e
>>>> preallocation like all other drivers do, namely by returning
>>>> DATA | RECURSE instead of RAW.
>>>>
>>>> There is no tangible difference but the fact that bdrv_is_allocated(=
) no
>>>> longer falls through to the protocol layer.
>>>
>>> Hmm. Isn't a real bug (fixed by this patch) ?
>>>
>>> Assume vpc->file is qcow2 with backing, which have "unallocated" regi=
on, which is
>>> backed by actual data in backing file.
>>
>> Come on now.
>>
>>> So, this region will be reported as not allocated and will be skipped=
 by any copying
>>> loop using block-status? Is it a bug of BDRV_BLOCK_RAW itself? Or I d=
on't understand
>>> something..
>>
>> I think what you don=E2=80=99t understand is that if you have a vpc fi=
le inside
>> of a qcow2 file, you=E2=80=99re doing basically everything wrong. ;-)
>>
>> But maybe we should drop BDRV_BLOCK_RAW...  Does it do anything good f=
or
>> us in the raw driver?  Shouldn=E2=80=99t it too just return DATA | REC=
URSE?
>>
>=20
> And if I have raw driver above qcow2, it will not work, like I've descr=
ibed above..

Yep.  That=E2=80=99s why I was wondering.  (This is a more likely case, b=
ecause
maybe you really want to use raw=E2=80=99s offset capability on top of qc=
ow2.)

Max


--liNzYjQmliiZ6oztyIQnPlZ0W1Ex1B02S--

--N4UvEtEy1niSNF0yWAKVEC2p65o8ZsnA9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1RuOUACgkQ9AfbAGHV
z0ANHAgAkmkPKd0A8vhtEJ1Xeit7caluFajsIb25oaZ2NMWW03S0KZ/XW2sReSUw
ue1Rwv9Zk2Q/zqjekckO4Qb8d32VD2kWCNs3+9vb6mtp/kVLhcl3zv/3fUKCgbZe
ixgFYujgcMFx/Pm7Yt91+GG8fiH/aZX+Q5EsSk+CPnSiVi72fbIsaNfYIgn2R2Pk
Cn4zeXLUW25zGMKBXniZWn7LRmlzSHEoCT1MxzJAcCmH8wnIdPjqd/xoaJmiyrVn
y7l2J1CLMOs579VeuXAIRpCrl0Fr2IxOo7nfdEaqVllv8rlG2wnpyZvgYMm9bmib
8l97i1O0iuN0bD2SPr82VMd2GyX1OQ==
=5RCB
-----END PGP SIGNATURE-----

--N4UvEtEy1niSNF0yWAKVEC2p65o8ZsnA9--

