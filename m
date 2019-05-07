Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B364C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 20:51:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1023620656
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 20:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1023620656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54722 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO73U-0002Ks-CT
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 16:51:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hO725-0001ab-DS
	for qemu-devel@nongnu.org; Tue, 07 May 2019 16:49:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hO721-0006TH-Kj
	for qemu-devel@nongnu.org; Tue, 07 May 2019 16:49:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35882)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hO71u-0006CK-KA; Tue, 07 May 2019 16:49:39 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E4A663082E57;
	Tue,  7 May 2019 20:49:35 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.217])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B3A31001DDC;
	Tue,  7 May 2019 20:49:32 +0000 (UTC)
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20190507183610.9848-1-mreitz@redhat.com>
	<20190507183610.9848-6-mreitz@redhat.com>
	<bb490ce7-7943-6607-6a74-cfb5c2f9b95a@redhat.com>
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
Message-ID: <a1cbbc56-2d4d-2000-4da4-f7c30561a5e2@redhat.com>
Date: Tue, 7 May 2019 22:49:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <bb490ce7-7943-6607-6a74-cfb5c2f9b95a@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="R2wGXK6WHw75AeOsH42A5NKy1p7q4e85M"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Tue, 07 May 2019 20:49:35 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 5/5] iotests: Let 233 run concurrently
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
--R2wGXK6WHw75AeOsH42A5NKy1p7q4e85M
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>
Message-ID: <a1cbbc56-2d4d-2000-4da4-f7c30561a5e2@redhat.com>
Subject: Re: [PATCH 5/5] iotests: Let 233 run concurrently
References: <20190507183610.9848-1-mreitz@redhat.com>
 <20190507183610.9848-6-mreitz@redhat.com>
 <bb490ce7-7943-6607-6a74-cfb5c2f9b95a@redhat.com>
In-Reply-To: <bb490ce7-7943-6607-6a74-cfb5c2f9b95a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07.05.19 22:38, Eric Blake wrote:
> On 5/7/19 1:36 PM, Max Reitz wrote:
>> common.nbd's nbd_server_set_tcp_port() tries to find a free port, and
>> then uses it for the whole test run.  However, this is racey because
>=20
> racy
>=20
>> even if the port was free at the beginning, there is no guarantee it
>> will continue to be available.  Therefore, 233 currently cannot reliab=
ly
>> be run concurrently with other NBD TCP tests.
>>
>> This patch addresses the problem by dropping nbd_server_set_tcp_port()=
,
>> and instead finding a new port every time nbd_server_start_tcp_socket(=
)
>> is invoked.  For this, we run qemu-nbd with --fork and on error evalua=
te
>> the output to see whether it contains "Address already in use".  If so=
,
>> we try the next port.
>>
>> On success, we still want to continually redirect the output from
>> qemu-nbd to stderr.  To achieve both, we redirect qemu-nbd's stderr to=
 a
>> FIFO that we then open in bash.  If the parent process exits with stat=
us
>> 0 (which means that the server has started successfully), we launch a
>> background cat process that copies the FIFO to stderr.  On failure, we=

>> read the whole content into a variable and then evaluate it.
>>
>> While at it, use --fork in nbd_server_start_unix_socket(), too.  Doing=

>> so allows us to drop nbd_server_wait_for_*_socket().
>>
>> Note that the reason common.nbd did not use --fork before is that
>> qemu-nbd did not have --pid-file.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  tests/qemu-iotests/233        |  1 -
>>  tests/qemu-iotests/common.nbd | 93 ++++++++++++++++------------------=
-
>>  2 files changed, 42 insertions(+), 52 deletions(-)
>>
>=20
>> @@ -34,76 +39,62 @@ nbd_server_stop()
>>          fi
>>      fi
>>      rm -f "$nbd_unix_socket"
>> -}
>> -
>> -nbd_server_wait_for_unix_socket()
>> -{
> ...
>> -    echo "Failed in check of unix socket created by qemu-nbd"
>> -    exit 1
>> +    rm -f "$nbd_stderr_fifo"
>=20
> You could use a single 'rm -f "$nbd_unix_socket" "$nbd_stderr_fifo"'.
> That's cosmetic, though.
>=20
> Are we sure that even on failure, our fifo will not fill up and cause
> deadlock? If the failing qemu-nbd has so much output as to be non-atomi=
c
> so that it blocks waiting for a reader, but we don't read anything unti=
l
> after qemu-nbd exits after forking the daemon, then we have deadlock.

Hm, right.  I don=E2=80=99t think it will happen, but if it does, it won=E2=
=80=99t be
because of an =E2=80=9CAddress already in use=E2=80=9D.  So if it did hap=
pen, the test
should fail anyway.

Of course, a hang is not the nicest way to fail a test, but I think as
long as we don=E2=80=99t think it will be a problem, it should be fine.

(The alternative I can think of would be to start a background cat that
copies data over to a log file, and then kill it after the qemu-nbd
parent process has exited.  On error, we read the log; on success, we
print it to stderr and then start the cat from nbd_stderr_fifo to stderr.=
)

> But in the common case, I don't think qemu-nbd ever spits out that much=

> in errors, even when it fails to start whether due to a socket in use o=
r
> for other reasons.  And even if it does hang, it is our testsuite (and
> our CI tools will probably notice it), rather than our main code.
>=20
> Otherwise, it's a lot of shell code with quite a few bash-isms, but we
> already require bash, and I didn't spot anything blatantly wrong.
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks again!

I=E2=80=99ll prepare the v2.

Max


--R2wGXK6WHw75AeOsH42A5NKy1p7q4e85M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzR71oACgkQ9AfbAGHV
z0BO1Af+JKMXPPoquNzaffvoccwJJ5VTe/448MojetaEAUb51oLAldJD+avUW8Kx
DjFkMqlSqjqfVQHoaoW4ZlD1cPg73UK2rTiYB+TP0eYawephjEYwjGivjqiiPbDn
k3sMWpJ8qHezHwA/yJZYpKBtSAfCcUrfKyx2yh58VQ4hWPjp9+gfyv3XF4m4CWxx
B0YPXfHm0QAdTPfOKZlEP76JL7Z/meC1splCMi8UnXsfI1nNQloNmYlLMR1ZgEb8
u55zywBYPIirthVniKjMIJhnle5Vqrvz+Em2onuZMEqLIOxdVjv3RITT9/kPoRFU
zU+88QB+jqE6SG+AqoBK0Gd40LCuhg==
=C7p3
-----END PGP SIGNATURE-----

--R2wGXK6WHw75AeOsH42A5NKy1p7q4e85M--

