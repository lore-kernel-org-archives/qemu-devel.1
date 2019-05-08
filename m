Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0595C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 12:44:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F45820644
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 12:44:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F45820644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36465 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOLvZ-0006Yw-Le
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 08:44:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hOLuS-00060X-90
	for qemu-devel@nongnu.org; Wed, 08 May 2019 08:42:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hOLuR-0007aI-2g
	for qemu-devel@nongnu.org; Wed, 08 May 2019 08:42:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hOLuK-0007Vj-Pe; Wed, 08 May 2019 08:42:49 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A3F8C2D7EF;
	Wed,  8 May 2019 12:42:47 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-94.brq.redhat.com
	[10.40.204.94])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 253B6600D4;
	Wed,  8 May 2019 12:42:45 +0000 (UTC)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20190507183610.9848-1-mreitz@redhat.com>
	<20190507183610.9848-2-mreitz@redhat.com>
	<20190508090131.GA32552@redhat.com>
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
Message-ID: <0f76927d-9e7d-1735-0ec4-a934c2a003f9@redhat.com>
Date: Wed, 8 May 2019 14:42:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508090131.GA32552@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TvwluoJ3RIhvanxkxSeHiabV2CdAvPVCT"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Wed, 08 May 2019 12:42:47 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TvwluoJ3RIhvanxkxSeHiabV2CdAvPVCT
From: Max Reitz <mreitz@redhat.com>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Message-ID: <0f76927d-9e7d-1735-0ec4-a934c2a003f9@redhat.com>
Subject: Re: [PATCH 1/5] qemu-nbd: Add --pid-file option
References: <20190507183610.9848-1-mreitz@redhat.com>
 <20190507183610.9848-2-mreitz@redhat.com> <20190508090131.GA32552@redhat.com>
In-Reply-To: <20190508090131.GA32552@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08.05.19 11:01, Daniel P. Berrang=C3=A9 wrote:
> On Tue, May 07, 2019 at 08:36:06PM +0200, Max Reitz wrote:
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
>> diff --git a/qemu-nbd.c b/qemu-nbd.c
>> index dca9e72cee..7e48154f44 100644
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
>> +    FILE *pid_file;
>> =20
>>      /* The client thread uses SIGTERM to interrupt the server.  A sig=
nal
>>       * handler ensures that "qemu-nbd -v -c" exits with a nice status=
 code.
>> @@ -876,6 +881,9 @@ int main(int argc, char **argv)
>>          case 'L':
>>              list =3D true;
>>              break;
>> +        case QEMU_NBD_OPT_PID_FILE:
>> +            pid_path =3D optarg;
>> +            break;
>>          }
>>      }
>> =20
>> @@ -1196,6 +1204,27 @@ int main(int argc, char **argv)
>> =20
>>      nbd_update_server_watch();
>> =20
>> +    if (pid_path) {
>> +        pid_file =3D fopen(pid_path, "w");
>> +        if (!pid_file) {
>> +            error_report("Failed to store PID in %s: %s",
>> +                         pid_path, strerror(errno));
>> +            exit(EXIT_FAILURE);
>> +        }
>> +
>> +        ret =3D fprintf(pid_file, "%ld", (long)getpid());
>> +        if (ret < 0) {
>> +            ret =3D -errno;
>> +        }
>> +        fclose(pid_file);
>> +
>> +        if (ret < 0) {
>> +            error_report("Failed to store PID in %s: %s",
>> +                         pid_path, strerror(-ret));
>> +            exit(EXIT_FAILURE);
>> +        }
>> +    }
>=20
> This is racy because multiple qemu-nbd's can be started pointing to
> the same pidfile and one will blindly overwrite the other.
>=20
> Please use  qemu_write_pidfile instead which acquires locks on the
> pidfile in a race free manner.

Ah, nice, that makes things better and easier. :-)

Max


--TvwluoJ3RIhvanxkxSeHiabV2CdAvPVCT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzSzsQACgkQ9AfbAGHV
z0AVwQgAmHMTpKAEL+s3s0pefrUeT5o0nQSPitbRAp7neriq7ZoU2ylOlz/KEv2p
l+gWzgUZHfmI4NvsRizkZ80jFLPUG2kU/x9p4cVQeqV01VoZ+5Qz6zxRLtrNzY9T
/KqOVxNgCS/ypmK5GGsm6/srP96kS99k2QcXKjnxWG2scbpOWoA8JxMRnbego4Fh
xtt17uBhtEO/T5Z6cwlDmBtm9niNVI00EQPjksa3jH5bf3KCKSELlfXMMxWtJKkR
NrmimXLEY8VspHKbO6zbH6DnP58IaRxZ9uM/79NNhh0PQOIJKMMCXJyQduCyIk10
hp8ago8g9QOXH8qq6TyHos41Dy+42g==
=clV5
-----END PGP SIGNATURE-----

--TvwluoJ3RIhvanxkxSeHiabV2CdAvPVCT--

