Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C32C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 19:51:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB21D20578
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 19:51:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB21D20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52475 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO682-00007C-VB
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 15:51:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hO612-0002Dg-Dv
	for qemu-devel@nongnu.org; Tue, 07 May 2019 15:44:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hO60Z-0005pl-2c
	for qemu-devel@nongnu.org; Tue, 07 May 2019 15:44:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51504)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hO5vi-0000iC-Aq; Tue, 07 May 2019 15:39:10 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E371C300180F;
	Tue,  7 May 2019 19:39:07 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.217])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3EFE45D9D6;
	Tue,  7 May 2019 19:39:03 +0000 (UTC)
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20190507183610.9848-1-mreitz@redhat.com>
	<20190507183610.9848-2-mreitz@redhat.com>
	<81dd6702-1d51-ca2e-1445-e8cdcfb14711@redhat.com>
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
Message-ID: <f34fb38c-22dd-1ed3-821d-7c8a9ea8943a@redhat.com>
Date: Tue, 7 May 2019 21:39:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <81dd6702-1d51-ca2e-1445-e8cdcfb14711@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5NhqiHQUmHC4X5IHHNQ5enbOFtdBOr8H8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Tue, 07 May 2019 19:39:08 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 1/5] qemu-nbd: Add --pid-file option
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5NhqiHQUmHC4X5IHHNQ5enbOFtdBOr8H8
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>
Message-ID: <f34fb38c-22dd-1ed3-821d-7c8a9ea8943a@redhat.com>
Subject: Re: [PATCH 1/5] qemu-nbd: Add --pid-file option
References: <20190507183610.9848-1-mreitz@redhat.com>
 <20190507183610.9848-2-mreitz@redhat.com>
 <81dd6702-1d51-ca2e-1445-e8cdcfb14711@redhat.com>
In-Reply-To: <81dd6702-1d51-ca2e-1445-e8cdcfb14711@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07.05.19 21:30, Eric Blake wrote:
> On 5/7/19 1:36 PM, Max Reitz wrote:
>> --fork is a bit boring if there is no way to get the child's PID.  Thi=
s
>> option helps.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  qemu-nbd.c    | 29 +++++++++++++++++++++++++++++
>>  qemu-nbd.texi |  2 ++
>>  2 files changed, 31 insertions(+)
>>
>=20
>> @@ -111,6 +112,7 @@ static void usage(const char *name)
>>  "                            specify tracing options\n"
>>  "  --fork                    fork off the server process and exit the=
 parent\n"
>>  "                            once the server is running\n"
>> +"  --pid-file=3DPATH           store the server's process ID in the g=
iven file\n"
>=20
> Should --pid-file imply --fork, or be an error if --fork was not
> supplied? As coded, it writes a pid file regardless of --fork, even
> though it is less obvious that it is useful in that case. I don't have =
a
> strong preference (there doesn't seem to be a useful consensus on what
> forking daemons should do), but it would at least be worth documenting
> the intended action (even if that implies a tweak to the patch to match=

> the intent).

I think the documentation is pretty clear.  It stores the server's PID,
whether it has been forked or not.

I don't think we would gain anything from forbidding --pid-file without
--fork, would we?

>>  #if HAVE_NBD_DEVICE
>>  "\n"
>>  "Kernel NBD client support:\n"
>> @@ -651,6 +653,7 @@ int main(int argc, char **argv)
>>          { "image-opts", no_argument, NULL, QEMU_NBD_OPT_IMAGE_OPTS },=

>>          { "trace", required_argument, NULL, 'T' },
>>          { "fork", no_argument, NULL, QEMU_NBD_OPT_FORK },
>> +        { "pid-file", required_argument, NULL, QEMU_NBD_OPT_PID_FILE =
},
>>          { NULL, 0, NULL, 0 }
>>      };
>>      int ch;
>> @@ -677,6 +680,8 @@ int main(int argc, char **argv)
>>      bool list =3D false;
>>      int old_stderr =3D -1;
>>      unsigned socket_activation;
>> +    const char *pid_path =3D NULL;
>=20
> Bikeshedding: pid_name is nicer (path makes me think of $PATH and other=

> colon-separated lists, which this is not).

I'd prefer pid_filename myself, then, because pid_name sounds like a
weird way to say "process name". O:-)

> Otherwise, I agree that this is long overdue. Thanks! If you can justif=
y
> the behavior without --fork,

I just can=E2=80=99t think of a reason not to allow it without --fork.  M=
aybe a
user doesn=E2=80=99t need --fork because they just start the server in th=
e
background and that=E2=80=99s good enough, but they still want a PID file=
=2E  So
basically like common.rc=E2=80=99s _qemu_nbd_wrapper() before this series=
=2E

Max


--5NhqiHQUmHC4X5IHHNQ5enbOFtdBOr8H8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzR3tUACgkQ9AfbAGHV
z0BT9Af9GZfwEp3VBo8GG7HwQSozHb4Q2nGbly65ZBEbgzWtVpl0qbqge2wMcRAE
q2rzY+/MbUjMH7jFPU6UrFYhxi2XwIVvn9HueHc4gqELvVTtLZeBOYGSWMrcbVqe
elyw4KcOkZXuTVn67z2gcYIhfv8BXnqbDZI6lDiWhLyR3hRfu9ZCug0TUFOqUPVq
e3gySGIrf92R8XEDgskC/S8rLR1zMSEgG8Ac8FLcfqygCtu/rX86cNawqNUUn6U5
a7u8et413FIETEqsjafajTOsPqXjr2QmN0fc0ysksPzXRis7EsNn62FU+BM0Ch0U
CIUAYLO4xaZ6oXdMkOvAm/ksgcyCZw==
=ESjy
-----END PGP SIGNATURE-----

--5NhqiHQUmHC4X5IHHNQ5enbOFtdBOr8H8--

