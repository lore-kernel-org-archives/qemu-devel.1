Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4C2C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 15:14:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 250422075D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 15:14:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 250422075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56086 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUBtR-0001U0-CH
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 11:14:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hUBp3-0006U1-2a
	for qemu-devel@nongnu.org; Fri, 24 May 2019 11:09:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hUBot-0000qg-Re
	for qemu-devel@nongnu.org; Fri, 24 May 2019 11:09:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hUBoV-0000TN-Ik; Fri, 24 May 2019 11:08:55 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BC75C3006370;
	Fri, 24 May 2019 15:08:40 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-150.brq.redhat.com
	[10.40.204.150])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AF0415F7C2;
	Fri, 24 May 2019 15:08:36 +0000 (UTC)
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20190508211820.17851-1-mreitz@redhat.com>
	<20190508211820.17851-2-mreitz@redhat.com>
	<1ed0b731-cbbd-0cdd-32f6-913d2b57edfa@redhat.com>
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
Message-ID: <5f4cea24-87e1-0fb7-d47a-017bbe036bfe@redhat.com>
Date: Fri, 24 May 2019 17:08:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1ed0b731-cbbd-0cdd-32f6-913d2b57edfa@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="q383EWNzgURbU3ozrzRXJ5PxB5aJmEvfT"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Fri, 24 May 2019 15:08:45 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v3 1/5] qemu-nbd: Add --pid-file option
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
Cc: Kevin Wolf <kwolf@redhat.com>,
	=?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--q383EWNzgURbU3ozrzRXJ5PxB5aJmEvfT
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Message-ID: <5f4cea24-87e1-0fb7-d47a-017bbe036bfe@redhat.com>
Subject: Re: [PATCH v3 1/5] qemu-nbd: Add --pid-file option
References: <20190508211820.17851-1-mreitz@redhat.com>
 <20190508211820.17851-2-mreitz@redhat.com>
 <1ed0b731-cbbd-0cdd-32f6-913d2b57edfa@redhat.com>
In-Reply-To: <1ed0b731-cbbd-0cdd-32f6-913d2b57edfa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 24.05.19 17:07, Eric Blake wrote:
> On 5/8/19 4:18 PM, Max Reitz wrote:
>> --fork is a bit boring if there is no way to get the child's PID.  Thi=
s
>> option helps.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  qemu-nbd.c    | 11 +++++++++++
>>  qemu-nbd.texi |  2 ++
>>  2 files changed, 13 insertions(+)
>>
>> diff --git a/qemu-nbd.c b/qemu-nbd.c
>> index dca9e72cee..edb5195208 100644
>> --- a/qemu-nbd.c
>> +++ b/qemu-nbd.c
>> @@ -59,6 +59,7 @@
>>  #define QEMU_NBD_OPT_IMAGE_OPTS    262
>>  #define QEMU_NBD_OPT_FORK          263
>>  #define QEMU_NBD_OPT_TLSAUTHZ      264
>> +#define QEMU_NBD_OPT_PID_FILE      265
>> =20
>>  #define MBR_SIZE 512
>> =20
>> @@ -111,6 +112,7 @@ static void usage(const char *name)
>>  "                            specify tracing options\n"
>>  "  --fork                    fork off the server process and exit the=
 parent\n"
>>  "                            once the server is running\n"
>> +"  --pid-file=3DPATH           store the server's process ID in the g=
iven file\n"
>=20
> Are we guaranteed that the pid file does not appear until after the
> socket has been created?
>=20
> /me rereads full file...
>=20
>> @@ -876,6 +880,9 @@ int main(int argc, char **argv)
>>          case 'L':
>>              list =3D true;
>>              break;
>> +        case QEMU_NBD_OPT_PID_FILE:
>> +            pid_file_name =3D optarg;
>> +            break;
>>          }
>>      }
>> =20
> ...
>     socket_activation =3D check_socket_activation();
>     if (socket_activation =3D=3D 0) {
>         setup_address_and_port(&bindto, &port);
>     } else {
>         /* Using socket activation - check user didn't use -p etc. */
> ...
>=20
>> @@ -1196,6 +1203,10 @@ int main(int argc, char **argv)
>> =20
>>      nbd_update_server_watch();
>> =20
>> +    if (pid_file_name) {
>> +        qemu_write_pidfile(pid_file_name, &error_fatal);
>> +    }
>=20
> Yes, we are.  So,
>=20
>> +
>>      /* now when the initialization is (almost) complete, chdir("/")
>>       * to free any busy filesystems */
>>      if (chdir("/") < 0) {
>> diff --git a/qemu-nbd.texi b/qemu-nbd.texi
>> index de342c76b8..7f55657722 100644
>> --- a/qemu-nbd.texi
>> +++ b/qemu-nbd.texi
>> @@ -117,6 +117,8 @@ option; or provide the credentials needed for conn=
ecting as a client
>>  in list mode.
>>  @item --fork
>>  Fork off the server process and exit the parent once the server is ru=
nning.
>> +@item --pid-file=3DPATH
>> +Store the server's process ID in the given file.
>=20
> since that is a useful trick to know (the pid file intentionally does
> NOT appear until after the socket is ready to go), we should mention it=

> in the documentation.
>=20
> I can make that tweak while queueing, if you'd like.

I don=E2=80=99t mind, but I personally find it more useful to just use --=
fork
and wait for the main process to exit.

Max


--q383EWNzgURbU3ozrzRXJ5PxB5aJmEvfT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzoCPMACgkQ9AfbAGHV
z0DVeAf/X4mDMceJcjHJQ9LxnT1ubfk+0Szqs+eOVUq0nHoJddwKe8GSAN5QX8xQ
qmeR6bP5bwKcKvd2z31JJ7kNDCG2a5yBC/VIM2OcSsPYnPsKN2sqe35ZaAUnOxgr
3Ipszb2eDGkY7b9KMKdZh/pPnwNZM37GZh3GqFKLp+xwsVG7XI+5IOT7MiFJfVxj
zRoIx+Ru31FpAyg7+zjopicHZPnEr9aOd7SOAed6dSK38ge4v/i16WzPgn4qN1Pw
JnrCBlAZ+9WHwFPuMqldBFqechOdVLg6ugQKcPcNVo7wRxR8ZFwwnGFEV2GhjjHS
wgaabShdhkTrdjVV6iYXGEzsnpPN7Q==
=Z4TV
-----END PGP SIGNATURE-----

--q383EWNzgURbU3ozrzRXJ5PxB5aJmEvfT--

