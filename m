Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE226C00307
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 09:26:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82D7121920
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 09:26:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82D7121920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7Fwd-0003Ly-IK
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 05:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38493)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i7Fvs-0002tG-Qi
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 05:26:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i7Fvr-0008A5-V5
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 05:26:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49474)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i7Fvp-00088K-6p; Mon, 09 Sep 2019 05:25:57 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 301AE30A00FC;
 Mon,  9 Sep 2019 09:25:56 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-179.ams2.redhat.com
 [10.36.116.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DA6B4100197A;
 Mon,  9 Sep 2019 09:25:53 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 qemu-devel@nongnu.org
References: <20190825071541.10389-1-mlevitsk@redhat.com>
 <20190825071541.10389-3-mlevitsk@redhat.com>
 <0618bc5b-6c0b-d154-dc7c-77398a7eb031@redhat.com>
 <798ede8632285382a9d54dc9e3a75be046387b7d.camel@redhat.com>
 <58a0f856b958bcb90df6d5f778c8ca0eaefaf8f9.camel@redhat.com>
 <58a83617-9ffd-b775-976b-ccfbc87d65c1@redhat.com>
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
Message-ID: <3967d83b-2637-8020-a3b6-f1fa995ad34f@redhat.com>
Date: Mon, 9 Sep 2019 11:25:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <58a83617-9ffd-b775-976b-ccfbc87d65c1@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="iYzYfamJ5RTmvsER5pDOh7eMWzwpWu7nz"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Mon, 09 Sep 2019 09:25:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/2] block/nvme: add support for discard
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 John Ferlan <jferlan@redhat.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iYzYfamJ5RTmvsER5pDOh7eMWzwpWu7nz
Content-Type: multipart/mixed; boundary="mcjgrKdDlZdh6xYTSjdrJhcq7Ek1YOv8G";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 John Ferlan <jferlan@redhat.com>
Message-ID: <3967d83b-2637-8020-a3b6-f1fa995ad34f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] block/nvme: add support for discard
References: <20190825071541.10389-1-mlevitsk@redhat.com>
 <20190825071541.10389-3-mlevitsk@redhat.com>
 <0618bc5b-6c0b-d154-dc7c-77398a7eb031@redhat.com>
 <798ede8632285382a9d54dc9e3a75be046387b7d.camel@redhat.com>
 <58a0f856b958bcb90df6d5f778c8ca0eaefaf8f9.camel@redhat.com>
 <58a83617-9ffd-b775-976b-ccfbc87d65c1@redhat.com>
In-Reply-To: <58a83617-9ffd-b775-976b-ccfbc87d65c1@redhat.com>

--mcjgrKdDlZdh6xYTSjdrJhcq7Ek1YOv8G
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 05.09.19 19:27, John Snow wrote:

[...]

> You also probably require review (or at least an ACK) from Keith Busch
> who maintains this file.

Keith actually maintains the NVMe guest device; technically, Fam is the
NVMe block driver maintainer.

Max


--mcjgrKdDlZdh6xYTSjdrJhcq7Ek1YOv8G--

--iYzYfamJ5RTmvsER5pDOh7eMWzwpWu7nz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl12Gp8ACgkQ9AfbAGHV
z0CfuAgAk8VpaY1W59DpZRQEkxgT0pyY+7PgqZcVHggJF/OniwKi6pvDSL9hH9+c
F+mzTdV01UeTshRUa896td/VFpo0sstewIwDScjdWTdhON0+3aHNq79BvE7NzqiH
9nv5HlncHuBApJ/xQ3SJKHaV8RE2plmQHnqp70lV2XEoNU+t34Ja/+Rx7s2zO2t/
Gj8CN2KJO3b6ccl59/oJDPo14fQAxq8hIfOG0c5I8K7iGgrvTI/JNgH03erzzChW
3u8u/g6D08BErpmlijZ+cgAannkGyOLLyM6HNZsdy99IjPzdkkFJIBf0xmDF374Q
NiXrONwbeFSjoVm/2/d9Z+qxwYTsMA==
=y+O7
-----END PGP SIGNATURE-----

--iYzYfamJ5RTmvsER5pDOh7eMWzwpWu7nz--

