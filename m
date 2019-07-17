Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5CBC76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 08:37:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B48962173E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 08:37:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B48962173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnfRn-00062P-0r
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 04:37:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48097)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hnfRY-0005JD-Sw
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 04:37:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hnfRX-0001MA-SD
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 04:37:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40684)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hnfRV-0001HT-DL; Wed, 17 Jul 2019 04:37:41 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AB9ACC057EC0;
 Wed, 17 Jul 2019 08:37:40 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 99EA25D968;
 Wed, 17 Jul 2019 08:37:38 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>
References: <20190715104508.7568-1-mreitz@redhat.com>
 <20190715104508.7568-2-mreitz@redhat.com>
 <20190716165459.GI7297@linux.fritz.box>
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
Message-ID: <f6b8b0c9-ff85-9d99-2ca9-06edde6bf62e@redhat.com>
Date: Wed, 17 Jul 2019 10:37:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190716165459.GI7297@linux.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="fJss0t3B5iJRoP98X6yzdQ3y9RWMOHTgH"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Wed, 17 Jul 2019 08:37:40 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.1? 1/4] qcow2: Fix
 .bdrv_has_zero_init()
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
Cc: Jeff Cody <codyprime@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fJss0t3B5iJRoP98X6yzdQ3y9RWMOHTgH
Content-Type: multipart/mixed; boundary="u3GSwk9gZjxsdxtvjnho51fP3KSQy9cBN";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Jeff Cody <codyprime@gmail.com>
Message-ID: <f6b8b0c9-ff85-9d99-2ca9-06edde6bf62e@redhat.com>
Subject: Re: [PATCH for-4.1? 1/4] qcow2: Fix .bdrv_has_zero_init()
References: <20190715104508.7568-1-mreitz@redhat.com>
 <20190715104508.7568-2-mreitz@redhat.com>
 <20190716165459.GI7297@linux.fritz.box>
In-Reply-To: <20190716165459.GI7297@linux.fritz.box>

--u3GSwk9gZjxsdxtvjnho51fP3KSQy9cBN
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 16.07.19 18:54, Kevin Wolf wrote:
> Am 15.07.2019 um 12:45 hat Max Reitz geschrieben:
>> If a qcow2 file is preallocated, it can no longer guarantee that it
>> initially appears as filled with zeroes.
>>
>> So implement .bdrv_has_zero_init() by checking whether the file is
>> preallocated; if so, forward the call to the underlying storage node,
>> except for when it is encrypted: Encrypted preallocated images always
>> return effectively random data, so .bdrv_has_zero_init() must always
>> return 0 for them.
>>
>> Reported-by: Stefano Garzarella <sgarzare@redhat.com>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>=20
> Hm... This patch only really works directly after image creation (which=

> is indeed where .bdrv_has_zero_init is used). Why do we have to have a
> full qcow2_is_zero() that loops over the whole image just to find out
> whether it's preallocated? Wouldn't looking at a single data cluster be=

> enough?

Hm.  I would like to agree (because you=E2=80=99re right), but now I see =
that
the callers of bdrv_has_zero_init() don=E2=80=99t necessarily hold to tha=
t
convention.

For example, qemu-img convert has the -n flag, but that doesn=E2=80=99t s=
top it
from invoking bdrv_has_zero_init().

Which is a bug, of course.

$ ./qemu-img create -f qcow2 src.qcow2 64M
$ ./qemu-img create -f qcow2 dest.qcow2 64M
$ ./qemu-io -c 'write -P 42 0 64M' dest.qcow2
$ ./qemu-img convert -n src.qcow2 dest.qcow2
$ ./qemu-img compare src.qcow2 dest.qcow2
Content mismatch at offset 0!

Aw, man, why does this keep happening... :-/

OK, so qemu-img convert -n is easy to fix.

But there are more callers:

mirror: Uses this function to inquire whether it needs to zero the
target before actually doing something useful.  There is no guarantee
that the target is a new image.  Well, it just isn=E2=80=99t with mode=3D=
existing
or blockdev-mirror.

parallels: Whether to write zeroes to newly added image areas.  That
actually sounds correct, because those new areas cannot point to any
data yet.
Well, maybe not correct, because bdrv_has_zero_init() is not the same as
=E2=80=9Cwhen this image grows, new areas will be zero=E2=80=9D, but at l=
east
bdrv_hsa_zero_init() will return false if the the latter is false.

vhdx: Similarly to parallels, it uses this information to check whether
it needs to zero new areas when growing an image file.

raw/vmdk/vpc: Just passing through info from their storage child.


Hm, OK.  So mirror and qemu-img need fixing.  That sounds possible.

Max


--u3GSwk9gZjxsdxtvjnho51fP3KSQy9cBN--

--fJss0t3B5iJRoP98X6yzdQ3y9RWMOHTgH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0u3lAACgkQ9AfbAGHV
z0Bi9wf/em74qJbEvq8QX5SBt+7OL2IE0wnzNtKu0a44UuIpAdhewj9XsakBKm8S
Rkn2j4/qO/xn5UGSNxooGSSxaPDoM78cUhGLVFyj3qD/WLv4dth6XpTHF7yNVv+b
y0r8UBlWG6BEOSYuydvfrjN1rYV46b8oNUzpVO9iLoq8pCPCBcCfRwQlxmijoZi7
1Wt/YnkBrbcn7L3hirjFXrPtMLkbSYE7c2iXPmb0UnfJp41JqZQprh3hT5frUkar
TawAKvfREx1Z297fPiAhM+mOF7tQJtXHFE72mLMVEwYPqFh9OHEoHR7CGKiHq1cy
fhQVrym8cTnDZPGn/M27ppW5GDNfzw==
=Lxv7
-----END PGP SIGNATURE-----

--fJss0t3B5iJRoP98X6yzdQ3y9RWMOHTgH--

