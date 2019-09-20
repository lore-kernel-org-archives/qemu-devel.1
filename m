Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07373C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 13:12:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFE1E205F4
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 13:12:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFE1E205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBIiM-0000hE-LO
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 09:12:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52137)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iBIg2-0007ye-P9
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 09:10:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iBIg1-0004Va-Dc
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 09:10:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46008)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iBIfw-0004Mx-FJ; Fri, 20 Sep 2019 09:10:16 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 094EF306085E;
 Fri, 20 Sep 2019 13:10:15 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 977D21017E3B;
 Fri, 20 Sep 2019 13:10:13 +0000 (UTC)
Subject: Re: [PATCH v5 0/5] qcow2: async handling of fragmented io
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190916175324.18478-1-vsementsov@virtuozzo.com>
 <d4d62196-84c2-0a90-312d-391493eae158@redhat.com>
 <93e72727-c46c-d30a-1f38-634237186126@virtuozzo.com>
 <d392d630-23e5-cc21-c8f5-8c2ec3d4f70b@redhat.com>
 <ea14f4bc-9a0c-0147-e963-9019fc9f4f2b@virtuozzo.com>
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
Message-ID: <9b56ef11-8c1e-fa48-d838-4fe3ee043474@redhat.com>
Date: Fri, 20 Sep 2019 15:10:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ea14f4bc-9a0c-0147-e963-9019fc9f4f2b@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="knFQhWzVNIqmVgQg7gDKwGRzfVKywhbBg"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Fri, 20 Sep 2019 13:10:15 +0000 (UTC)
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--knFQhWzVNIqmVgQg7gDKwGRzfVKywhbBg
Content-Type: multipart/mixed; boundary="gFZ54LzdFNr9qWdYyITK6tci7heQU3ZWx";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>
Message-ID: <9b56ef11-8c1e-fa48-d838-4fe3ee043474@redhat.com>
Subject: Re: [PATCH v5 0/5] qcow2: async handling of fragmented io
References: <20190916175324.18478-1-vsementsov@virtuozzo.com>
 <d4d62196-84c2-0a90-312d-391493eae158@redhat.com>
 <93e72727-c46c-d30a-1f38-634237186126@virtuozzo.com>
 <d392d630-23e5-cc21-c8f5-8c2ec3d4f70b@redhat.com>
 <ea14f4bc-9a0c-0147-e963-9019fc9f4f2b@virtuozzo.com>
In-Reply-To: <ea14f4bc-9a0c-0147-e963-9019fc9f4f2b@virtuozzo.com>

--gFZ54LzdFNr9qWdYyITK6tci7heQU3ZWx
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 20.09.19 14:53, Vladimir Sementsov-Ogievskiy wrote:
> 20.09.2019 15:40, Max Reitz wrote:
>> On 20.09.19 13:53, Vladimir Sementsov-Ogievskiy wrote:
>>> 20.09.2019 14:10, Max Reitz wrote:
>>>> On 16.09.19 19:53, Vladimir Sementsov-Ogievskiy wrote:
>>>>> Hi all!
>>>>>
>>>>> Here is an asynchronous scheme for handling fragmented qcow2
>>>>> reads and writes. Both qcow2 read and write functions loops through=

>>>>> sequential portions of data. The series aim it to parallelize these=

>>>>> loops iterations.
>>>>> It improves performance for fragmented qcow2 images, I've tested it=

>>>>> as described below.
>>>>
>>>> Thanks again, applied to my block branch:
>>>>
>>>> https://git.xanclic.moe/XanClic/qemu/commits/branch/block
>>>
>>> Thanks a lot!
>>>
>>>>
>>>>> v5: fix 026 and rebase on Max's block branch [perf results not upda=
ted]:
>>>>>
>>>>> 01: new, prepare 026 to not fail
>>>>> 03: - drop read_encrypted blkdbg event [Kevin]
>>>>>       - assert((x & (BDRV_SECTOR_SIZE - 1)) =3D=3D 0) -> assert(QEM=
U_IS_ALIGNED(x, BDRV_SECTOR_SIZE)) [rebase]
>>>>>       - full host offset in argument of qcow2_co_decrypt [rebase]
>>>>> 04: - substitute remaining qcow2_co_do_pwritev by qcow2_co_pwritev_=
task in comment [Max]
>>>>>       - full host offset in argument of qcow2_co_encrypt [rebase]
>>>>> 05: - Now patch don't affect 026 iotest, so its output is not chang=
ed
>>>>>
>>>>> Rebase changes seems trivial, so, I've kept r-b marks.
>>>>
>>>> (For the record, I didn=E2=80=99t consider them trivial, or I=E2=80=99=
d=E2=80=99ve applied
>>>> Maxim=E2=80=99s series on top of yours.  I consider a conflict to be=
 trivially
>>>> resolvable only if there is only one way of doing it; but when I
>>>> resolved the conflicts myself, I resolved the one in patch 3 differe=
ntly
>>>> from you =E2=80=93 I added an offset_in_cluster variable to
>>>> qcow2_co_preadv_encrypted().  Sure, it=E2=80=99s still simple and th=
e difference
>>>> is minor, but that was exactly where I thought that I can=E2=80=99t =
consider
>>>> this trivial.)
>>>>
>>>
>>> Hmm. May be it's trivial enough to keep r-b (as my change is trivial =
itself), but not
>>> trivial enough to change alien patch on queuing? If you disagree, I'l=
l be more
>>> careful on keeping r-b in changed patches, sorry.
>>
>> It doesn=E2=80=99t matter much to me, I diff all patches anyway. :-)
>>
>=20
> then a bit offtopic:
>=20
> Which tools are you use?
>=20
> I've some scripts to compare different versions of one serie (or to che=
ck, what
> was changed in patches during some porting process..).. The core thing =
is to filter
> some not interesting numbers and hashes, which makes diffs dirty, and t=
hen call vimdiff.
> But maybe I've reinvented the wheel.

Just kompare as a graphical diff tool; I just scroll past the hash diffs.=


But now that you gave me the idea, maybe I should write a script to
filter them...  (So, no, I don=E2=80=99t know of a tool that would do tha=
t
already :-/)

Max


--gFZ54LzdFNr9qWdYyITK6tci7heQU3ZWx--

--knFQhWzVNIqmVgQg7gDKwGRzfVKywhbBg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2Ez7QACgkQ9AfbAGHV
z0DGMAf8DQy7y+6gBfjL1H/FkDUOLhdJC2/k1poaP9EKXPEa3a72hi3zxi3SdpHr
L87r4FpQYD/KBZZxWV1W+WZFNRwMO+AHioLWMf+ctIFSN4Jrr5AGQUseDznK4Uhd
8BfvlpbTymEd5ibgvX4PXS5bzPKiH9gN+dx11Bi3497ehjeHpaS1WCt/I1hHZjNU
B8++3/6OgzJf/Z3JgqGewaqAR7H+7SxjDJ95v/NivFqBvdKaV8xiAwhQiHTMLIFw
BVubtRYsP2r2/sQkemI5CU+n03+lmZfR6dfgEmJW7F1wGf2PN2X48HgPW6RtNGvo
3A8uyKPP9sfn0S+PI7j4uhzuAdwM4A==
=KEYh
-----END PGP SIGNATURE-----

--knFQhWzVNIqmVgQg7gDKwGRzfVKywhbBg--

