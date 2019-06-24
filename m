Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565F0C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 20:11:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21D6C20645
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 20:11:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21D6C20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54414 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfVJ2-0003rB-8l
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 16:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56879)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hfVEB-0008Qn-Tt
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 16:06:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hfVEA-0007Ed-4a
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 16:06:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59022)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hfVE4-00074s-6w; Mon, 24 Jun 2019 16:06:04 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F07C73091851;
 Mon, 24 Jun 2019 20:06:02 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-152.brq.redhat.com
 [10.40.204.152])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C7EE45D9C5;
 Mon, 24 Jun 2019 20:06:01 +0000 (UTC)
To: qemu-devel@nongnu.org
References: <156140280770.24.15806136837308130555@c4a48874b076>
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
Message-ID: <0060dc58-695f-545a-311f-2a05fa2ad679@redhat.com>
Date: Mon, 24 Jun 2019 22:06:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <156140280770.24.15806136837308130555@c4a48874b076>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cTeaR8dx6LdM3GKJjcQqFAVn2eUWs29c8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Mon, 24 Jun 2019 20:06:03 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 00/14] block: Try to create well-typed
 json:{} filenames
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
Cc: kwolf@redhat.com, mdroth@linux.vnet.ibm.com, qemu-block@nongnu.org,
 armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cTeaR8dx6LdM3GKJjcQqFAVn2eUWs29c8
Content-Type: multipart/mixed; boundary="yVg888gpPBZiO4kVhdiFNGndoJsLn3xIS";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mdroth@linux.vnet.ibm.com,
 armbru@redhat.com
Message-ID: <0060dc58-695f-545a-311f-2a05fa2ad679@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 00/14] block: Try to create well-typed
 json:{} filenames
References: <156140280770.24.15806136837308130555@c4a48874b076>
In-Reply-To: <156140280770.24.15806136837308130555@c4a48874b076>

--yVg888gpPBZiO4kVhdiFNGndoJsLn3xIS
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 24.06.19 21:00, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20190624173935.25747-1-mreitz@red=
hat.com/
>=20
>=20
>=20
> Hi,
>=20
> This series failed the asan build test. Please find the testing command=
s and
> their output below. If you have Docker installed, you can probably repr=
oduce it
> locally.

Many ASan leaks of the form:

> Indirect leak of 4120 byte(s) in 1 object(s) allocated from:
>     #0 0x56245fee9d3e in calloc (/tmp/qemu-test/build/tests/test-bdrv-d=
rain+0x52fd3e)
>     #1 0x7f285054bcf0 in g_malloc0 (/lib64/libglib-2.0.so.0+0x55cf0)
>     #2 0x562460610cf3 in qdict_clone_shallow /tmp/qemu-test/src/qobject=
/qdict.c:367:12
>     #3 0x56245ff8487b in bdrv_type_blockdev_opts /tmp/qemu-test/src/blo=
ck.c:6305:22

Oops, I forgot to free string_options in bdrv_type_blockdev_opts().
Thanks, Patchew!

Max


--yVg888gpPBZiO4kVhdiFNGndoJsLn3xIS--

--cTeaR8dx6LdM3GKJjcQqFAVn2eUWs29c8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0RLSgACgkQ9AfbAGHV
z0DCSAf+N0XKjvQaUaMLBIA4xJnuTNL9dtQECaUTVTmmXToRvVQqjaYrF04nAnvx
02plrOIlqI371pBWnX0gG0LSshk8RMSAq6ldhZ3965uLaditPWCpZURX37hRwbwc
XJL8JXBODXcikw7MUz/Bkrzl7dB0XCRoNWxrSZ1nGplev9SFEEwnGO63co4STV1c
5W+hRgQG2vVQCZhhehRLMzjOU9sNkKe4v+APNI47x0znl8xug4Q/fG8NLVA1UZB7
DvpaY69gwXboX1eLh+VcCO7pt4ZRibWtQh5e6alJCBXZTq/M+mcxH1iSGT1NfOSN
8C6l6w8galMxXWHSLRUGp6cyJOTiNQ==
=FnSq
-----END PGP SIGNATURE-----

--cTeaR8dx6LdM3GKJjcQqFAVn2eUWs29c8--

