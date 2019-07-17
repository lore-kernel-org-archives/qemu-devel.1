Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5F4C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 07:48:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 494D921743
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 07:48:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 494D921743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnefR-0003RD-Dm
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 03:48:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32903)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hnefE-0002yR-Qg
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 03:47:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hnefD-000419-Ns
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 03:47:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50067)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hnefB-0003yo-Aa; Wed, 17 Jul 2019 03:47:45 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 663BD756;
 Wed, 17 Jul 2019 07:47:43 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F0D175C21A;
 Wed, 17 Jul 2019 07:47:41 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>
References: <20190703172813.6868-1-mreitz@redhat.com>
 <20190703172813.6868-7-mreitz@redhat.com>
 <20190716170156.GJ7297@linux.fritz.box>
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
Message-ID: <22745e99-6b6e-53d5-91b7-e1156782e55e@redhat.com>
Date: Wed, 17 Jul 2019 09:47:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190716170156.GJ7297@linux.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Ca9n3kqhwZInyDlDFcIBH7ejIohUqwoA1"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Wed, 17 Jul 2019 07:47:43 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 06/12] block: Deep-clear inherits_from
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ca9n3kqhwZInyDlDFcIBH7ejIohUqwoA1
Content-Type: multipart/mixed; boundary="6mMh1hJ05O5ZEisht4c2n3Apmym1xaOtE";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Message-ID: <22745e99-6b6e-53d5-91b7-e1156782e55e@redhat.com>
Subject: Re: [PATCH v2 06/12] block: Deep-clear inherits_from
References: <20190703172813.6868-1-mreitz@redhat.com>
 <20190703172813.6868-7-mreitz@redhat.com>
 <20190716170156.GJ7297@linux.fritz.box>
In-Reply-To: <20190716170156.GJ7297@linux.fritz.box>

--6mMh1hJ05O5ZEisht4c2n3Apmym1xaOtE
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 16.07.19 19:01, Kevin Wolf wrote:
> Am 03.07.2019 um 19:28 hat Max Reitz geschrieben:
>> BDS.inherits_from does not always point to an immediate parent node.
>> When launching a block job with a filter node, for example, the node
>> directly below the filter will not point to the filter, but keep its o=
ld
>> pointee (above the filter).
>>
>> If that pointee goes away while the job is still running, the node's
>> inherits_from will not be updated and thus point to garbage.  To fix
>> this, bdrv_unref_child() has to check not only the parent node's
>> immediate children for nodes whose inherits_from needs to be cleared,
>> but its whole subtree.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>=20
> Isn't the real bug that we keep pointing to a node that isn't a parent
> of the node any more? I think this will effectively disable option
> inheritance in bdrv_reopen() as long as the filter node is present,
> which is certainly not what we intended.

Well, it breaks it while a block job is running.  I don=E2=80=99t know wh=
ether I
would advise doing a reopen across a block job filter.  It=E2=80=99s a ca=
se of
=E2=80=9CWhy wouldn=E2=80=99t it work?=E2=80=9D, but I=E2=80=99m sure the=
re=E2=80=99s something that doesn=E2=80=99t.
(Like this here, for example, but it at least has the decency of just
letting the reopen fail.)

> The intuitive thing would be that after inserting a filter, the image
> now inherits from the filter node, and when the filter is removed, it
> inherits from the filter's bs->inherit_from if that becomes a parent of=

> the node. (Though I'm not necessarily saying that my intuition is to be=

> trusted here.)

I tried that first, but I couldn=E2=80=99t get it to work.  I don=E2=80=99=
t remember
why, though.  I suppose my problem was that removing the filter node
make inherits_from NULL.  I guess I stopped at that point and went this
route instead.

I suppose we could add a flag to the BDS that says whether an heir
node=E2=80=99s inherits_from should be cleared or set to the bequeather=E2=
=80=99s
inherits_from, like so:

    if (parent->inherit_inherits_from) {
        child->bs->inherits_from =3D parent->inherits_from;
    } else {
        child->bs->inherits_from =3D NULL;
    }

And then, if you insert a node between a child and its inherits_from
parent, that node copies inherits_from from the child and gets its
inherit_inherits_from set to true.

The problem I see is that it doesn=E2=80=99t always appear clear to me th=
at this
intermediate node should actually copy its inherits_from from the child.

So the same question applies here, too, I guess; should the filter node
even inherit its options from the parent?

Max


--6mMh1hJ05O5ZEisht4c2n3Apmym1xaOtE--

--Ca9n3kqhwZInyDlDFcIBH7ejIohUqwoA1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0u0psACgkQ9AfbAGHV
z0DKUgf/U9L1FCJx+Y0MhXKCm+vKNy/HBLSZ+vudMG1Wmcnlt/AeWyoQdklFezo0
+H3P+D/KKMg5rIIDRrrYcgqFuAWtep2f2bH/RI56RIVlENPXCOUNx3IW7nrVhaUy
ivbHxt6omLk76XcuxDcJwjImomc5KZkGBs7gTNl3Y9ToR1VcOQQsgRBzOWr1n9u+
1ktzp6IpUuaJHJhaCahqKu7UGnVIjGzv3dwaXVfUH1kw7B22GYaeo9Yj+PeCjWka
gY1HpEQIoNLOryoJoitVaqzYxA10BkrSHOsxgN89sybjiWXJFKC4It/sw7iBVvGp
oMv3Aj0+yn9MGdZaOJXzK0r6Sgfmqw==
=QvWm
-----END PGP SIGNATURE-----

--Ca9n3kqhwZInyDlDFcIBH7ejIohUqwoA1--

