Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40A4C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 16:13:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97C1A208C0
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 16:13:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97C1A208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBLXK-0007q2-3b
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 12:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49991)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iBLMy-0005L6-EZ
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 12:02:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iBLMx-0001kd-95
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 12:02:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60910)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iBLMu-0001jf-2b; Fri, 20 Sep 2019 12:02:48 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3105B317528B;
 Fri, 20 Sep 2019 16:02:47 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EBE0B19C68;
 Fri, 20 Sep 2019 16:02:45 +0000 (UTC)
Subject: Re: [PATCH 1/2] block/snapshot: Restrict set of snapshot nodes
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20190917110443.2029-1-kwolf@redhat.com>
 <20190917110443.2029-2-kwolf@redhat.com>
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
Message-ID: <9c129131-8617-ce52-67c7-5109c3d07d43@redhat.com>
Date: Fri, 20 Sep 2019 18:02:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190917110443.2029-2-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="h7w45LYcXU1EuiUfiVreJ6Uo3cQMQziGz"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Fri, 20 Sep 2019 16:02:47 +0000 (UTC)
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
Cc: pkrempa@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--h7w45LYcXU1EuiUfiVreJ6Uo3cQMQziGz
Content-Type: multipart/mixed; boundary="6Exkiay8oUICvUdif09W0Fnw0JuWP7Aid";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, qemu-devel@nongnu.org
Message-ID: <9c129131-8617-ce52-67c7-5109c3d07d43@redhat.com>
Subject: Re: [PATCH 1/2] block/snapshot: Restrict set of snapshot nodes
References: <20190917110443.2029-1-kwolf@redhat.com>
 <20190917110443.2029-2-kwolf@redhat.com>
In-Reply-To: <20190917110443.2029-2-kwolf@redhat.com>

--6Exkiay8oUICvUdif09W0Fnw0JuWP7Aid
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 17.09.19 13:04, Kevin Wolf wrote:
> Nodes involved in internal snapshots were those that were returned by
> bdrv_next(), inserted and not read-only. bdrv_next() in turn returns al=
l
> nodes that are either the root node of a BlockBackend or monitor-owned
> nodes.
>=20
> With the typical -drive use, this worked well enough. However, in the
> typical -blockdev case, the user defines one node per option, making al=
l
> nodes monitor-owned nodes. This includes protocol nodes etc. which ofte=
n
> are not snapshottable, so "savevm" only returns an error.
>=20
> Change the conditions so that internal snapshot still include all nodes=

> that have a BlockBackend attached (we definitely want to snapshot
> anything attached to a guest device and probably also the built-in NBD
> server; snapshotting block job BlockBackends is more of an accident, bu=
t
> a preexisting one), but other monitor-owned nodes are only included if
> they have no parents.
>=20
> This makes internal snapshots usable again with typical -blockdev
> configurations.
>=20
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/snapshot.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--6Exkiay8oUICvUdif09W0Fnw0JuWP7Aid--

--h7w45LYcXU1EuiUfiVreJ6Uo3cQMQziGz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2E+CQACgkQ9AfbAGHV
z0A9sgf7BBeDfbDKakazvNJxY16S4gzHxJs0mRQ80IhEUVsczDE7yjEsqMEoehrH
wT4kxpszxzaiI6qB0KMTh+jPK1aPHfpuwdsttpkVSVSWPTSPru3vxHJGpx3i0ePq
2lkBFr2jNnjbRKlCucziy5mgX9dHnJhdmvBSEiZF7RrIZrt9HgRSQIqCtm1vB5lj
o1FH/iLWSGH6tm4FKUROUTU38fgxxyx2L8mhhMr7RHV0J5JKgE0fWL+MRZrVjLBL
L61/8c8vTh+5M9tmRPGozmRyvb+ElcU1EJiuYeCdyANPoT3WF6kHULFImMcfsuF0
RBJhod20EgJaGSVWTkEQui0hMDqZGg==
=WcJw
-----END PGP SIGNATURE-----

--h7w45LYcXU1EuiUfiVreJ6Uo3cQMQziGz--

