Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E916CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 15:47:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 494E021D7B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 15:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BtL7dz1d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 494E021D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO1oR-0004Ry-CF
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 11:47:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46261)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iO0dS-0001fl-P3
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:32:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iO0dJ-0006d6-Tn
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:32:11 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21695
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iO0dJ-0006cu-PE
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:32:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572013924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=01ydqPz74PUrLn5jDH5RwSZa4rAxHFA2SBT0L/xShV4=;
 b=BtL7dz1dI7o+8KZKftEOCgoZld06AmFAwstUvkA3FODvWzhTDqNmbXUuIL+a43RfmxZK22
 aHGUBDZdgmGcmeGq9CKr69G+cbHQcJjIELe+OMRkbTKDnT849s185VH28Wawu4UxZK0O18
 CumBVwwYTzG47iPeUCC3yBB95x6eHng=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-K492A7EMP4ax4UwuzLCJFg-1; Fri, 25 Oct 2019 10:32:03 -0400
X-MC-Unique: K492A7EMP4ax4UwuzLCJFg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF3501005509;
 Fri, 25 Oct 2019 14:32:01 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-230.ams2.redhat.com
 [10.36.117.230])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B684D5D9CA;
 Fri, 25 Oct 2019 14:32:00 +0000 (UTC)
Subject: Re: Early 4.1.1 release for image corruption fixes?
To: Kevin Wolf <kwolf@redhat.com>, mdroth@linux.vnet.ibm.com
References: <20191025142915.GG7275@localhost.localdomain>
From: Max Reitz <mreitz@redhat.com>
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
Message-ID: <59c32499-04b8-87ba-1740-081fe0b2f21c@redhat.com>
Date: Fri, 25 Oct 2019 16:31:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191025142915.GG7275@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="6bPpYFg25KYD9iqJ4mYkPxlvZbsauYFcm"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6bPpYFg25KYD9iqJ4mYkPxlvZbsauYFcm
Content-Type: multipart/mixed; boundary="bw7fLMo3u3HfH57gKi6MLqSltOTAFc1Iw"

--bw7fLMo3u3HfH57gKi6MLqSltOTAFc1Iw
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25.10.19 16:29, Kevin Wolf wrote:
> Hi,
>=20
> the QEMU 4.1.0 release has two problems that can easily cause image
> corruption with any qcow2 images (no special configuration needed to
> trigger the bugs):

Three, actually.  There=E2=80=99s also b2c6f23f4a9f6d8f1b648705cd46d3713b78=
d6a2
which fixed 50ba5b2d994853b38fed10e0841b119da0f8b8e5 that was part of
4.1.0, too.

> 1. A locking bug in the qcow2 code. I just sent a pull request that
>    includes the fix for this. The important patch there is:
>=20
>    'qcow2: Fix corruption bug in qcow2_detect_metadata_preallocation()'
>=20
> 2. A kernel bug in the XFS driver that became visible by new I/O
>    patterns the qcow2 implementation started to use in 4.1. Max is
>    currently working on a workaround for this.

You most likely won=E2=80=99t see the kernel bug on 4.1.0, because 50ba5b2d=
99 is
basically the same bug, but in qemu...

(I don=E2=80=99t know if it has the same technical reason, but it causes th=
e
same symptoms.)

Max

> The Planning/4.1 wiki page tells me that a 4.1.1 release is planned for
> end of November, which isn't too far, but I was wondering if want to
> have a stable release even earlier, right after the fixes for both
> problems are in.
>=20
> Peter, if we haven't made a decision until then, maybe discussing this
> is an agenda item for QEMU Summit, too.
>=20
> Kevin
>=20



--bw7fLMo3u3HfH57gKi6MLqSltOTAFc1Iw--

--6bPpYFg25KYD9iqJ4mYkPxlvZbsauYFcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2zB18ACgkQ9AfbAGHV
z0BxSAf/WttKdJOFgDdRfMAM4clgY07gFSXhWclnQvvomFStGeTMgCar91NgyLGd
P9piR+b5rlhRJsUAW8fKnuB9F8cLxAaOZnqqLv47C9Vd43mNguP5gO2Vq8EXM6xO
0YSaWeHjCIFA70U6Xb85rle8GpBOMH/fRTL0X9dWN2c3cKDj7HXv9ON/LtPJ10Fu
GmXP/HgI2Q+sTNuMP2N04ta5E0PG/RSX+ZCF9rqlUDqa3a7s0tj/BjcxIRjReQz5
veblwJiL7yeFKIEjp2ixiukdlukXhPljq/LcnUN1nOnZFMl81LNXInjKdblTn0ed
382gcMKP1DaPfDKE16qPnzQcFtTx+A==
=U13L
-----END PGP SIGNATURE-----

--6bPpYFg25KYD9iqJ4mYkPxlvZbsauYFcm--


