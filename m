Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A80CA9EB7
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 13:39:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75F9521928
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 13:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E2ogAuIV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75F9521928
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMXu0-0004Sf-JX
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 09:39:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39640)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iMXoF-0005uX-85
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:33:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iMXoD-0005uo-W9
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:33:19 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25361
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iMXoC-0005uN-9h
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:33:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571664795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2zOs54GWIpJ+9iiNt+YidpFvyAt/nvOeRB3QqH1ACPQ=;
 b=E2ogAuIVCgLj5L5VFk/g0KJfQ1vab7I/WwSPZvGJTd0QdN2uPqX0Su9gfJvMmuJlrju6jV
 Jfx1ojY5eOwQJBYf8oV+s9L4zszG9G+x7oye9l7M+AsZnHCWzHvM77G4ouPOvLBeePw4Jx
 ErzXPzT2SoZV+KjduyoqsYtfNFztmtc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-8DkFH3hXP8aIphCbxIFFsw-1; Mon, 21 Oct 2019 09:33:10 -0400
X-MC-Unique: 8DkFH3hXP8aIphCbxIFFsw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D7931005500;
 Mon, 21 Oct 2019 13:33:09 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-17.ams2.redhat.com
 [10.36.117.17])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C8EA55C207;
 Mon, 21 Oct 2019 13:33:07 +0000 (UTC)
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
Message-ID: <120ab7dc-17dd-2796-95a3-8492ca40339e@redhat.com>
Date: Mon, 21 Oct 2019 15:33:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <2e7d321c-89f4-f3fd-8331-6bc276880de2@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="etKYolLmOmDC1DMzJB9CpfzGcmqSKr0f7"
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
--etKYolLmOmDC1DMzJB9CpfzGcmqSKr0f7
Content-Type: multipart/mixed; boundary="mqYP4s28Zx8gFOTHykpWLjVXDRkUSsl8g"

--mqYP4s28Zx8gFOTHykpWLjVXDRkUSsl8g
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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

I now have a reproducer with CentOS, so it=E2=80=99s actually useful outsid=
e of
Red Hat:

$ cd $TEST_DIR

(Download CentOS-8-x86_64-1905-dvd1.iso here, e.g. from
http://mirror1.hs-esslingen.de/pub/Mirrors/centos/8.0.1905/isos/x86_64/Cent=
OS-8-x86_64-1905-dvd1.torrent
)

$ wget
http://mirror1.hs-esslingen.de/pub/Mirrors/centos/8.0.1905/BaseOS/x86_64/os=
/isolinux/vmlinuz
$ wget
http://mirror1.hs-esslingen.de/pub/Mirrors/centos/8.0.1905/BaseOS/x86_64/os=
/isolinux/initrd.img

$ mkdir ks
$ cat > ks/ks.cfg <<EOF
rootpw 123456
install
keyboard us
lang en_US.UTF-8
rootpw 123456
zerombr
autopart
clearpart --all --initlabel

%packages --default
@core
%end
EOF

$ $QEMU_BUILD_DIR/qemu-img create -f qcow2 disk.qcow2 30G
$ $QEMU_BUILD_DIR/x86_64-softmmu/qemu-system-x86_64 \
    -name 'centos' \
    -machine pc \
    -nodefaults \
    -vga std \
    -display gtk \
    -serial stdio \
    -device virtio-scsi-pci,id=3Dvirtio_scsi_pci0,bus=3Dpci.0 \
    -blockdev "{'node-name': 'target-disk',
                'driver': 'qcow2',
                'file': {
                    'driver': 'file',
                    'filename': 'disk.qcow2',
                    'cache': {
                        'direct': true
                    },
                    'aio': 'native'
                } }" \
    -device scsi-hd,id=3Dimage1,drive=3Dtarget-disk \
    -blockdev \
     file,node-name=3Dinstall-cd,filename=3DCentOS-8-x86_64-1905-dvd1.iso \
    -device scsi-cd,drive=3Dinstall-cd \
    -blockdev vvfat,node-name=3Dkscfg,dir=3Dks,label=3DOEMDRV,read-only=3Do=
n \
    -device scsi-hd,drive=3Dkscfg \
    -kernel vmlinuz \
    -append 'ks=3Dhd:LABEL=3DOEMDRV:/ks.cfg delay=3D60 console=3DttyS0' \
    -initrd initrd.img \
    -boot order=3Dcd,menu=3Doff,strict=3Doff \
    -m 2048 \
    -enable-kvm

This installation fails about 50/50 for me.  To retry, just run the last
two steps (qemu-img create and the installation itself).

Max


--mqYP4s28Zx8gFOTHykpWLjVXDRkUSsl8g--

--etKYolLmOmDC1DMzJB9CpfzGcmqSKr0f7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2ts5IACgkQ9AfbAGHV
z0CtvQf/ZzbbQ4V2CT02lssT2yTA5Owg3Xrx5du+l6Sa8/Nv9O/T61RcJ65bqIdQ
5E24fGGH4W0yM5wYlEsvGHQ08X/MuMtRm92LJkooAm6Tn2BwRtR+9PKCvb7V6lSY
XWHFKX4uK/o5x7NFq1UUyp2OKLX0xeKEb2ArkH1xOs6xaWqGp29bThCZH+0urYQL
iyuDJT5nkUA08prWUWf65IWWFvKbRhBaMjuE7uPzo/DXkoMrXdXs5K8aD3WoJq1A
fn9h7Qcw6GFYJ1Z5uixK7cnaUxG9HcANgM3yfDa2zrnvgTRrddZOJGDfV6XNL0YR
Elq2s70oOfCcg5A/jGtksnaexJ8Xlg==
=Y1X8
-----END PGP SIGNATURE-----

--etKYolLmOmDC1DMzJB9CpfzGcmqSKr0f7--


