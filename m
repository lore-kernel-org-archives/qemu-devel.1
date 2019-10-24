Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31203CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:09:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEAF620856
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VpEledSv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEAF620856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNZ7k-0004JR-4x
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 05:09:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43336)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iNZ6j-0003fv-BV
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:08:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iNZ6h-0002rk-Ek
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:08:36 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48074
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iNZ6h-0002qH-0k
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:08:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571908113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bBrFi/m87HFKhBVhYXIbTH9Rb/OXKOjCJ8aBaroSV10=;
 b=VpEledSvtyFVsPUpr6+sL9bmawu4TghfHlj6tNqzqFBn31SJInBelQh+yG+Uwu7liHmTOL
 CmEfrEZ0uWJveimhEYva2C2hD3FeuxydCTdshJaVTZPKf394p9kt0pKbf1m4CUtHBYycp9
 3f7mol1os0f8VK2oX0szewtiEl93hKg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-cvBRWEMDOpaXbs9Yd76uAw-1; Thu, 24 Oct 2019 05:08:29 -0400
X-MC-Unique: cvBRWEMDOpaXbs9Yd76uAw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5214A107AD31;
 Thu, 24 Oct 2019 09:08:27 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-205.ams2.redhat.com
 [10.36.117.205])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D0FD75C1B5;
 Thu, 24 Oct 2019 09:08:24 +0000 (UTC)
Subject: Re: Problems with c8bb23cbdbe3 on ppc64le
From: Max Reitz <mreitz@redhat.com>
To: Qemu-block <qemu-block@nongnu.org>
References: <2e7d321c-89f4-f3fd-8331-6bc276880de2@redhat.com>
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
Message-ID: <4dd781ed-b695-1610-438c-b459fe9027c4@redhat.com>
Date: Thu, 24 Oct 2019 11:08:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <2e7d321c-89f4-f3fd-8331-6bc276880de2@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2yOPKwW1LyLUmaLyAIshZLTdF7HxXiDpO"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Alberto Garcia <berto@igalia.com>,
 Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2yOPKwW1LyLUmaLyAIshZLTdF7HxXiDpO
Content-Type: multipart/mixed; boundary="f1EfCW0VdlNbtU6j0gtz2Fcp0Mae8EQps"

--f1EfCW0VdlNbtU6j0gtz2Fcp0Mae8EQps
Content-Type: multipart/mixed;
 boundary="------------3E2AB0E555DF66607B18E7A0"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------3E2AB0E555DF66607B18E7A0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10.10.19 17:17, Max Reitz wrote:
> Hi everyone,
>=20
> (CCs just based on tags in the commit in question)
>=20
> I have two bug reports which claim problems of qcow2 on XFS on ppc64le
> machines since qemu 4.1.0.  One of those is about bad performance
> (sorry, is isn=E2=80=99t public :-/), the other about data corruption
> (https://bugzilla.redhat.com/show_bug.cgi?id=3D1751934).
>=20
> It looks like in both cases reverting c8bb23cbdbe3 solves the problem
> (which optimized COW of unallocated areas).
>=20
> I think I=E2=80=99ve looked at every angle but can=E2=80=98t find what co=
uld be wrong
> with it.  Do any of you have any idea? :-/

It looks to me like an XFS bug.

On XFS, if you do FALLOC_FL_ZERO_RANGE past the EOF and an AIO pwrite
even further after that range, the pwrite will be discarded if the
fallocate settles after the pwrite (and both have been started before
either as finished).  That is, the file length will be increased as if
only the fallocate had been executed, but not the pwrite, so the
pwrite=E2=80=99s data is lost.

(Interestingly, this is pretty similar to the bug I introduced in qemu
in 50ba5b2d994853b38fed10e0841b119da0f8b8e5, where the ftruncate() would
not consider parallel in-flight writes.)

I=E2=80=99ve attached a C program to show the problem.  It creates an empty
file, issues FALLOC_FL_ZERO_RANGE on the first 4 kB in a thread, and an
AIO pwrite in parallel on the second 4 kB.  It then runs hexdump -C on
the file.

On XFS, the hexdump shows only 4 kB of 0s.  On ext4 and btrfs, it shows
4 kB of 0s and 4 kB of 42s.

(You can uncomment the IN_ORDER to execute the fallocate and pwrite
sequentially, then XFS will show the same output.)

(Note that it is possible that pwrite and fallocate are not issued
before the other is finished, or that fallocate settles before pwrite.
In such cases, the file will probably be written correctly.  However, I
see the wrong result pretty much 100 % of the time.  (So on my machine,
pwrite and fallocate pretty much always run in parallel and fallocate
finishes after pwrite.))

Compile the program like so:

$ gcc parallel-falloc-and-pwrite.c -pthread -laio -Wall -Wextra
-pedantic -std=3Dc11

And run it like so:

$ ./a.out tmp-file

Max

--------------3E2AB0E555DF66607B18E7A0
Content-Type: text/x-csrc; charset=UTF-8;
 name="parallel-falloc-and-pwrite.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="parallel-falloc-and-pwrite.c"

#define _GNU_SOURCE

#include <assert.h>
#include <fcntl.h>
#include <libaio.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

// Define this to perform the fallocate and the pwrite sequentially
// instead of in parallel

// #define IN_ORDER


int fd;

void *falloc_thread(void *arg)
{
    int ret;

    (void)arg;

    puts("starting fallocate");

    ret =3D fallocate(fd, FALLOC_FL_ZERO_RANGE, 0, 4096);
    assert(ret =3D=3D 0);

    puts("fallocate done");

    return NULL;
}

int main(int argc, char *argv[])
{
    pthread_t falloc_thr;
    int ret;

    if (argc !=3D 2) {
        fprintf(stderr, "Usage: %s <scratch file>\n", argv[0]);
        return 1;
    }

    fd =3D open(argv[1], O_CREAT | O_RDWR | O_TRUNC | O_DIRECT, 0666);
    assert(fd >=3D 0);

    void *buf =3D aligned_alloc(4096, 4096);
    memset(buf, 42, 4096);

    io_context_t ctx =3D 0;
    ret =3D io_setup(1, &ctx);
    assert(ret =3D=3D 0);

    ret =3D pthread_create(&falloc_thr, NULL, &falloc_thread, NULL);
    assert(ret =3D=3D 0);

#ifdef IN_ORDER
    ret =3D pthread_join(falloc_thr, NULL);
    assert(ret =3D=3D 0);
#endif

    struct iocb ior;
    io_prep_pwrite(&ior, fd, buf, 4096, 4096);

    puts("submitting pwrite");

    struct iocb *ios[] =3D { &ior };
    ret =3D io_submit(ctx, 1, ios);
    assert(ret =3D=3D 1);

    struct io_event evs[1];
    ret =3D io_getevents(ctx, 1, 1, evs, NULL);
    assert(ret =3D=3D 1);

    puts("pwrite done");

#ifndef IN_ORDER
    ret =3D pthread_join(falloc_thr, NULL);
    assert(ret =3D=3D 0);
#endif

    close(fd);
    free(buf);

    puts("\nHexdump should show 4k of 0s and 4k of 42s:\n");

    execlp("hexdump", "hexdump", "-C", argv[1], NULL);
    return 1;
}

--------------3E2AB0E555DF66607B18E7A0--

--f1EfCW0VdlNbtU6j0gtz2Fcp0Mae8EQps--

--2yOPKwW1LyLUmaLyAIshZLTdF7HxXiDpO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2xagcACgkQ9AfbAGHV
z0Bqawf+LoV3M6upbQCAxF2ZGjl5MGDeHIgfdeFdYdpuJqe6SDI55R+Cz3yyJdYi
KquFXNiRHC9SjmroOcC2mFIGUC+v28Pie5t6fPD/aSMIJN0lzxZI5dZGUEWVxoLN
m6xgOmV8u7C+8phDumRFTU9/tKdNEoFXwTiGn/yaoU7COHIf1KVYKP1tW9QiF7Dg
AaKEM7sE5HlGIVYbfjuof/IXfSh5ViWNQNlILuxBjqs5Hk07JaYRy4wm6WbZ3d2v
Pwu3KahxVKCYTSAEZK7nkJgGEfTVMsCfvRdX9JaBuM6v947DAGT50IwPUpNQEwj4
wezJh/hHzS2b732WoNirD2J9uIi90w==
=2DwS
-----END PGP SIGNATURE-----

--2yOPKwW1LyLUmaLyAIshZLTdF7HxXiDpO--


