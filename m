Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D78C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 14:02:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 149EE218FC
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 14:02:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 149EE218FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42207 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJIUB-0007GV-92
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 10:02:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hJIMB-0008ST-N7
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 09:54:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hJIAh-0005Dq-1U
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 09:42:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49624)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hJIAf-00057P-Ng; Wed, 24 Apr 2019 09:42:45 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BFF41307E047;
	Wed, 24 Apr 2019 13:42:44 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7FC78600C4;
	Wed, 24 Apr 2019 13:42:43 +0000 (UTC)
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20180713111424.23670-1-mreitz@redhat.com>
	<20180713111424.23670-3-mreitz@redhat.com>
	<cec09e49-6702-cb66-e668-42d728800a75@redhat.com>
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
Message-ID: <0bf6aa98-3792-40bd-6520-f8ba419455d7@redhat.com>
Date: Wed, 24 Apr 2019 15:42:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <cec09e49-6702-cb66-e668-42d728800a75@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UNxDxx9xL2ZSmtfEJSlAjub3m4iJPbTAn"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Wed, 24 Apr 2019 13:42:44 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 2/3] qemu-img: Use zero writes after source
 backing EOF
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
Message-ID: <20190424134241.qJyKYOGUeCaAfoKe8449rsFQSjgwgL4icTuD90vBwuA@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UNxDxx9xL2ZSmtfEJSlAjub3m4iJPbTAn
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <0bf6aa98-3792-40bd-6520-f8ba419455d7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] qemu-img: Use zero writes after source
 backing EOF
References: <20180713111424.23670-1-mreitz@redhat.com>
 <20180713111424.23670-3-mreitz@redhat.com>
 <cec09e49-6702-cb66-e668-42d728800a75@redhat.com>
In-Reply-To: <cec09e49-6702-cb66-e668-42d728800a75@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 18.04.19 20:59, Eric Blake wrote:
> On 7/13/18 6:14 AM, Max Reitz wrote:
>> Past the end of the source backing file, we memset() buf_old to zero, =
so
>> it is clearly easy to use blk_pwrite_zeroes() instead of blk_pwrite()
>> then.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  qemu-img.c | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>
>=20
>> @@ -3458,8 +3461,12 @@ static int img_rebase(int argc, char **argv)
>>                  if (compare_buffers(buf_old + written, buf_new + writ=
ten,
>>                                      n - written, &pnum))
>>                  {
>> -                    ret =3D blk_pwrite(blk, offset + written,
>> -                                     buf_old + written, pnum, 0);
>> +                    if (buf_old_is_zero) {
>> +                        ret =3D blk_pwrite_zeroes(blk, offset + writt=
en, pnum, 0);
>=20
> Should we allow BDRV_REQ_MAY_UNMAP here, either unconditionally, or
> based on a command line knob that told us whether the user is more
> interested in a sparse result (that still reads as zero) vs. a
> fully-allocated result?

I wouldn=E2=80=99t trust that.  We haven=E2=80=99t yet switched to the ne=
w backing file
at this point, so I think a driver would be correct in handling such
requests by punching a hole in the file -- which would lead to the new
backing file poking through once we=E2=80=99ve switched to it.

Max

> Reviewed-by: Eric Blake <eblake@redhat.com>



--UNxDxx9xL2ZSmtfEJSlAjub3m4iJPbTAn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzAZ9EACgkQ9AfbAGHV
z0ANUgf9HgjsPsrvGPUZvs/281P2a9XloQt6lnutxa1Q97wvlOf7F9sOqBhZpcMR
NOFtrTbN81CBVOHjuSpP7rZUuXkML7LX65+vuF4b4/sw8nsU9uRz0bBPmW7WtLOR
Zmnw4mIQSa6uKV13eeo5RPCtQ7uL1MlrZvpQzPZMsYKx+PAauYu5pQ7xrEJv+1Sh
qrpZrrOMNQxatNgelcNY6ghXroWX8PmnmVE1A/sWLUhr3kMJ2A7tsjsJE2YYLFEV
qKvVr3uhM4PDMXAmNeV1ZE4QvD/YABrQatVCAOKQ5ZUErohVmYef0AhDhCZFm5L4
gb78iAT6ogqin0mLKkpKwHjCvay9GQ==
=cU4U
-----END PGP SIGNATURE-----

--UNxDxx9xL2ZSmtfEJSlAjub3m4iJPbTAn--

