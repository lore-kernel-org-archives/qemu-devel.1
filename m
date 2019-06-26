Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URI_NOVOWEL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110FAC48BD9
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 17:52:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF1C721743
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 17:52:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF1C721743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgC5U-0000Sf-US
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 13:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33924)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hgC3C-0007ON-KG
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 13:49:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hgC36-00019Y-C5
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 13:49:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36976)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hgC2t-0000oH-U9; Wed, 26 Jun 2019 13:49:24 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BFBE1307D922;
 Wed, 26 Jun 2019 17:49:05 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.153])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 485EB1001B05;
 Wed, 26 Jun 2019 17:48:57 +0000 (UTC)
To: Anthony PERARD <anthony.perard@citrix.com>
References: <20190409164038.25484-1-paul.durrant@citrix.com>
 <c9c1360d-cebc-5c2a-a019-eca2f8f7f461@redhat.com>
 <20190626171947.GF13449@perard.uk.xensource.com>
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
Message-ID: <1518aab5-83d3-fb0e-cb33-7b9d2d996497@redhat.com>
Date: Wed, 26 Jun 2019 19:48:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190626171947.GF13449@perard.uk.xensource.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="PxkiPkpTf9HppIvddhgSOmWKke5pHdjzR"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Wed, 26 Jun 2019 17:49:11 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] xen-block: support
 feature-large-sector-size
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Paul Durrant <paul.durrant@citrix.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 xen-devel@lists.xenproject.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PxkiPkpTf9HppIvddhgSOmWKke5pHdjzR
Content-Type: multipart/mixed; boundary="LiTUtQe8dZ9voZ3bXKAItQQ4f5mf3jYce";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: Paul Durrant <paul.durrant@citrix.com>, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org, qemu-block@nongnu.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Message-ID: <1518aab5-83d3-fb0e-cb33-7b9d2d996497@redhat.com>
Subject: Re: [PATCH] xen-block: support feature-large-sector-size
References: <20190409164038.25484-1-paul.durrant@citrix.com>
 <c9c1360d-cebc-5c2a-a019-eca2f8f7f461@redhat.com>
 <20190626171947.GF13449@perard.uk.xensource.com>
In-Reply-To: <20190626171947.GF13449@perard.uk.xensource.com>

--LiTUtQe8dZ9voZ3bXKAItQQ4f5mf3jYce
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 26.06.19 19:19, Anthony PERARD wrote:
> On Wed, Jun 26, 2019 at 06:48:50PM +0200, Max Reitz wrote:
>> On 09.04.19 18:40, Paul Durrant wrote:
>>> A recent Xen commit [1] clarified the semantics of sector based quant=
ities
>>> used in the blkif protocol such that it is now safe to create a xen-b=
lock
>>> device with a logical_block_size !=3D 512, as long as the device only=

>>> connects to a frontend advertizing 'feature-large-block-size'.
>>>
>>> This patch modifies xen-block accordingly. It also uses a stack varia=
ble
>>> for the BlockBackend in xen_block_realize() to avoid repeated derefer=
encing
>>> of the BlockConf pointer, and changes the parameters of
>>> xen_block_dataplane_create() so that the BlockBackend pointer and sec=
tor
>>> size are passed expicitly rather than implicitly via the BlockConf.
>>>
>>> These modifications have been tested against a recent Windows PV XENV=
BD
>>> driver [2] using a xen-disk device with a 4kB logical block size.
>>>
>>> [1] http://xenbits.xen.org/gitweb/?p=3Dxen.git;a=3Dcommit;h=3D67e1c05=
0e36b2c9900cca83618e56189effbad98
>>> [2] https://winpvdrvbuild.xenproject.org:8080/job/XENVBD-master/126
>>>
>>> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
>>> ---
>>> Cc: Stefano Stabellini <sstabellini@kernel.org>
>>> Cc: Anthony Perard <anthony.perard@citrix.com>
>>> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>>> Cc: Kevin Wolf <kwolf@redhat.com>
>>> Cc: Max Reitz <mreitz@redhat.com>
>>> ---
>>>  hw/block/dataplane/xen-block.c | 25 ++++++++++++----------
>>>  hw/block/dataplane/xen-block.h |  3 ++-
>>>  hw/block/xen-block.c           | 38 +++++++++++++++++++++-----------=
--
>>>  3 files changed, 40 insertions(+), 26 deletions(-)
>>
>> Thanks, added =E2=80=9Cby frontend=E2=80=9D to the error message and a=
pplied to my block
>> branch:
>>
>> https://git.xanclic.moe/XanClic/qemu/commits/branch/block
>=20
> :(, I've just sent a pull request with that patch:
> https://patchew.org/QEMU/20190624153257.20163-1-anthony.perard@citrix.c=
om/20190624153257.20163-2-anthony.perard@citrix.com/

That=E2=80=99s just as well, then. :-)

> I guess I need to start sending an email every time I've added a patch
> to my queue.

Well, it certainly won=E2=80=99t hurt.  Although in this cases it=E2=80=99=
s just a bit
of an unfortunate coincidence that I looked at this patch now when Peter
seems to be away (otherwise I=E2=80=99d have seen it in master).

Max


--LiTUtQe8dZ9voZ3bXKAItQQ4f5mf3jYce--

--PxkiPkpTf9HppIvddhgSOmWKke5pHdjzR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0TsAcACgkQ9AfbAGHV
z0BcNwf/Ql4IZr5iOViyJxBWQxDKppLZ8rdF/Ht5i5JFJjmB3Ow4RHCqcxC6h60Q
fee6fEWqhbqMWnSvxAs+/HWS0aTZAm2epWLipp3TBDH1aKpT+Zlno1OdJs91qd0D
4rjkgwgk7fX1q0I+J7KoCqJFsgkAjS7sLCCAFXzUHEjybw9+2y66Ou9Nrlz8rcU+
dJNko8PvJEoqoHEYPCEhjIyv9ueBXNv4xTFYE2AbxWgBY3jTk1NC1RmdTe/IA23N
Ki10DEOB1RLQmua22+eT6H7Q4TgNT3BZo3Tr3qS6IEwbUjcsaysrd0zGuXNROtii
qsSAjOO8K8Z0Zil4MpDmuUuzT9oCeQ==
=HFZl
-----END PGP SIGNATURE-----

--PxkiPkpTf9HppIvddhgSOmWKke5pHdjzR--

