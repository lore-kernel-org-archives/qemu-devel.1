Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDEEC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 14:03:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DEC3218FC
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 14:03:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DEC3218FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42209 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJIUt-0007qP-Od
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 10:03:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hJIMV-0000Pz-8i
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 09:55:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hJI7K-00064r-R4
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 09:39:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hJI7I-0005Wv-9U; Wed, 24 Apr 2019 09:39:16 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F29CD8830B;
	Wed, 24 Apr 2019 13:38:57 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C597F608C1;
	Wed, 24 Apr 2019 13:38:56 +0000 (UTC)
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20180713111424.23670-1-mreitz@redhat.com>
	<20180713111424.23670-2-mreitz@redhat.com>
	<a36f26f1-61b3-799f-5cee-281257cba123@redhat.com>
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
Message-ID: <3c983edf-047f-c463-90f2-f1b542d9f3dd@redhat.com>
Date: Wed, 24 Apr 2019 15:38:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <a36f26f1-61b3-799f-5cee-281257cba123@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LN3Ni5ZNrpgspsOQUB9OvNNpCFS8e9Rkw"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Wed, 24 Apr 2019 13:38:58 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 1/3] qemu-img: Allow rebase with no input
 base
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424133854.EMg4ko-5XfHB6_e9bOKKP3Vx3RCrZcrULDOY9c8TJT8@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LN3Ni5ZNrpgspsOQUB9OvNNpCFS8e9Rkw
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <3c983edf-047f-c463-90f2-f1b542d9f3dd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] qemu-img: Allow rebase with no input
 base
References: <20180713111424.23670-1-mreitz@redhat.com>
 <20180713111424.23670-2-mreitz@redhat.com>
 <a36f26f1-61b3-799f-5cee-281257cba123@redhat.com>
In-Reply-To: <a36f26f1-61b3-799f-5cee-281257cba123@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 18.04.19 20:55, Eric Blake wrote:
> On 7/13/18 6:14 AM, Max Reitz wrote:
>> Currently, you cannot add a backing file to an image when it currently=

>> has none.  It is really simple to allow this, though (effectively by
>> setting old_backing_size to 0), so this patch does just that.
>=20
> Can't you do that with 'rebase -u'? I guess the point of this patch is
> to make 'rebase' without -u also able to add a backing file?  A bit mor=
e
> clarity in the commit message, such as a sample command line (and
> possibly even the error it issued pre-patch) would help.

Yes, this is about normal rebase without -u.

There is an example in the cover letter, but I can add it to this patch
here, too, yes.

>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  qemu-img.c | 61 ++++++++++++++++++++++++++++++-----------------------=
-
>>  1 file changed, 34 insertions(+), 27 deletions(-)
>=20
> At any rate, the code looks fine, even if the diff is harder to read
> because of added indentation.
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!

Max


--LN3Ni5ZNrpgspsOQUB9OvNNpCFS8e9Rkw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzAZu4ACgkQ9AfbAGHV
z0Cruwf+Pd0xQD119UktAbODprzQYu4GvTGgKB2Hw7W+CME+fQ9sxR/zkERpHe6h
aUyXME4v+/2EI8eEMWPpxK6sP0nLCnMAJ3RmFVG2Ud8xloLOeXiXK/V5KF92VVDJ
aNHPfKlAMGZ8RE2GAMc0SQDFYMqAbVh36FFN6KfGtUuF16ZuGMTT40zxVhlnOwj/
IdvnemV11ovHCuUDy3v+9mGUdx1gb/5UcotNnhxQs+VUP3VPjqsjAfgbUDcggqjR
t9dPyBwap5omCyVcAmw5R+M42PHOKBgvh0xLZjrgBke/Rq6lEUybjACt0WL3WMbe
+ZGH1mMKIXLtjpwoWRFBrJpWH6xEHw==
=EpZE
-----END PGP SIGNATURE-----

--LN3Ni5ZNrpgspsOQUB9OvNNpCFS8e9Rkw--

