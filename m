Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6EEC4649B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 12:10:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D79AE2082E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 12:10:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D79AE2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjN2l-0001iF-V8
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 08:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49429)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hjN1n-0000wn-GN
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 08:09:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hjN1l-0005Gs-Gy
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 08:09:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:64221)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hjN1j-00053V-AG; Fri, 05 Jul 2019 08:09:19 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A894D882F5;
 Fri,  5 Jul 2019 12:09:12 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-154.brq.redhat.com
 [10.40.204.154])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A4C851BC72;
 Fri,  5 Jul 2019 12:09:06 +0000 (UTC)
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20190703155944.9637-1-mlevitsk@redhat.com>
 <20190703155944.9637-5-mlevitsk@redhat.com>
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
Message-ID: <fdd3554a-c972-68eb-bac1-058c726df66e@redhat.com>
Date: Fri, 5 Jul 2019 14:09:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190703155944.9637-5-mlevitsk@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="RfStuQMXiJmP0Zo6HJLY2FvPet3Lfh4de"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Fri, 05 Jul 2019 12:09:12 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 4/6] block/nvme: add support for image
 creation
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RfStuQMXiJmP0Zo6HJLY2FvPet3Lfh4de
Content-Type: multipart/mixed; boundary="MumdVcJBy8GZDqd647gAxKRiEXZf1NpUQ";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org
Message-ID: <fdd3554a-c972-68eb-bac1-058c726df66e@redhat.com>
Subject: Re: [PATCH v3 4/6] block/nvme: add support for image creation
References: <20190703155944.9637-1-mlevitsk@redhat.com>
 <20190703155944.9637-5-mlevitsk@redhat.com>
In-Reply-To: <20190703155944.9637-5-mlevitsk@redhat.com>

--MumdVcJBy8GZDqd647gAxKRiEXZf1NpUQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03.07.19 17:59, Maxim Levitsky wrote:
> Tesed on a nvme device like that:
>=20
> # create preallocated qcow2 image
> $ qemu-img create -f qcow2 nvme://0000:06:00.0/1 10G -o preallocation=3D=
metadata
> Formatting 'nvme://0000:06:00.0/1', fmt=3Dqcow2 size=3D10737418240 clus=
ter_size=3D65536 preallocation=3Dmetadata lazy_refcounts=3Doff refcount_b=
its=3D16
>=20
> # create an empty qcow2 image
> $ qemu-img create -f qcow2 nvme://0000:06:00.0/1 10G -o preallocation=3D=
off
> Formatting 'nvme://0000:06:00.0/1', fmt=3Dqcow2 size=3D10737418240 clus=
ter_size=3D65536 preallocation=3Doff lazy_refcounts=3Doff refcount_bits=3D=
16
>=20
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  block/nvme.c | 108 +++++++++++++++++++++++++++++++++++++++++++++++++++=

>  1 file changed, 108 insertions(+)

Hm.  I=E2=80=99m not quite sure I like this, because this is not image cr=
eation.

What we need is a general interface for formatting existing files.  I
mean, we have that in QMP (blockdev-create), but the problem is that
this doesn=E2=80=99t really translate to qemu-img create.

I wonder whether it=E2=80=99s best to hack something up that makes
bdrv_create_file() a no-op, or whether we should expose blockdev-create
over qemu-img.  I=E2=80=99ll see how difficult the latter is, it sounds f=
un
(famous last words).

Max


--MumdVcJBy8GZDqd647gAxKRiEXZf1NpUQ--

--RfStuQMXiJmP0Zo6HJLY2FvPet3Lfh4de
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0fPeEACgkQ9AfbAGHV
z0AlsAgAtdpyLSWw1AoPS+H6zgA39BL19Q/JEgT0MtwJD+zpVvpnLCuMKTRAbi+6
hEt3oCD4RItfwzOh+a6OtR8zXu48k90skZsuohHtlrXxbPc7h+cPeLDRg+XS17xE
0xRbSR5DpfsSZs37Cv46rwwifZsNa7LWqidBLnPvJpKtQtAe0/n0vO9Xdtyt6Y4E
fT+FklDHHibsbUpAN4gb6rr5BiZe71BnULsxJY5yBKRP+F7r6qU+8WeQYSJSkEK7
KBFqrRpDy2Wq+sbSMWYr29jVCFZUCFgKYpzaUvL8iS6YhiLaxwAwUJ3XoetCWZb7
jU8Jzy1q0U3WlNbjlSzZwf2AZ64HpQ==
=UoZ8
-----END PGP SIGNATURE-----

--RfStuQMXiJmP0Zo6HJLY2FvPet3Lfh4de--

