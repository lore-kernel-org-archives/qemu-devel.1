Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EE8C10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 15:10:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1D3221473
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 15:10:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1D3221473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54512 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDVuN-0006P9-29
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 11:10:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hDVsp-0005Wq-8Q
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:08:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hDVsn-0000Ft-9D
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:08:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hDVsd-0008Pf-AK; Mon, 08 Apr 2019 11:08:17 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 77FCE306D355;
	Mon,  8 Apr 2019 15:08:12 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-100.brq.redhat.com
	[10.40.204.100])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4156A5D964;
	Mon,  8 Apr 2019 15:08:08 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	Qemu-block <qemu-block@nongnu.org>
References: <3da8da19-72dc-8f5e-f2e1-820999994cb2@redhat.com>
	<471e5ea1-cafb-c9b6-129e-07e9007122d6@virtuozzo.com>
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
Message-ID: <19944be5-e9db-3428-5744-79e8301a265f@redhat.com>
Date: Mon, 8 Apr 2019 17:08:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <471e5ea1-cafb-c9b6-129e-07e9007122d6@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="h2YikPECzZM9p9XUv3bXuNRhtiLpqOo9l"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Mon, 08 Apr 2019 15:08:12 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] Aborts in iotest 169
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Luiz Capitulino <lcapitulino@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408150807.Q7FwAtMyxoBkWm31P_CvvX7K6a8jiIfTxdjkiEP2bRk@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--h2YikPECzZM9p9XUv3bXuNRhtiLpqOo9l
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Qemu-block <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Luiz Capitulino <lcapitulino@redhat.com>
Message-ID: <19944be5-e9db-3428-5744-79e8301a265f@redhat.com>
Subject: Re: Aborts in iotest 169
References: <3da8da19-72dc-8f5e-f2e1-820999994cb2@redhat.com>
 <471e5ea1-cafb-c9b6-129e-07e9007122d6@virtuozzo.com>
In-Reply-To: <471e5ea1-cafb-c9b6-129e-07e9007122d6@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08.04.19 16:57, Vladimir Sementsov-Ogievskiy wrote:
> 23.01.2019 18:48, Max Reitz wrote:
>> Hi,
>>
>> When running 169 in parallel (e.g. like so:
>>
>> $ while TEST_DIR=3D/tmp/t0 ./check -T -qcow2 169; do; done
>> $ while TEST_DIR=3D/tmp/t1 ./check -T -qcow2 169; do; done
>> $ while TEST_DIR=3D/tmp/t2 ./check -T -qcow2 169; do; done
>> $ while TEST_DIR=3D/tmp/t3 ./check -T -qcow2 169; do; done
>>
>> in four different shells), I get aborts:
>>
>> (Often I get segfaults, but that's because of
>> http://lists.nongnu.org/archive/html/qemu-devel/2018-12/msg05579.html =
--
>> feel free to apply the attached patch to make them go away)
>=20
> Hi,
>=20
> Didn't you send it in separate? iotests still fails sometimes with segf=
ault
> in chardev code...

I didn=E2=80=99t, because I don=E2=80=99t believe that patch is entirely =
correct.
That=E2=80=99s why its commit title starts with =E2=80=9CHack=E2=80=9D.

Max


--h2YikPECzZM9p9XUv3bXuNRhtiLpqOo9l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlyrY9cACgkQ9AfbAGHV
z0BJqAf/VefmNCznndrHt97Th6yDgQekVyVPOP83tJzuBQxqElhrR3ghn7ubejJP
X/QP/uFlUaBYq5/fM9w+bFXOSOEuS22JtCSuLgiD9eGGJWuw+eLEgZU/tGE+zuBe
HuCJ4Jaotk0xcfts7KRB0JbpIuHYc/aC9CvI/+9qJaqV+QYtktlkvQMBkAcPVxpe
TmhTOsfHwkcWhX+lX86W0VzG1frDZIVzd5QwR9GOrhZkQgtL9LO/dlnnVkgF13CE
dX1n9bd3EtQXDsxucXFFkxZ3D0HqPckd9ypXu0zJ14yvPSh0yxrW/3FTomp3vJfy
QlSxfVyKza0GRLnDk+9gU7EkSRsoaQ==
=pOLE
-----END PGP SIGNATURE-----

--h2YikPECzZM9p9XUv3bXuNRhtiLpqOo9l--

