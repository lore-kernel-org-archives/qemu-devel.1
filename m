Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84224C35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 16:38:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52FF32072D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 16:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fuOcR2YS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52FF32072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6dEE-00060D-G4
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 11:38:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42649)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j6dCs-0004bC-Mj
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 11:37:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j6dCp-00041X-3f
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 11:37:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57525
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j6dCn-00040p-RX
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 11:37:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582648629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZGX7ZN84XuXzWkU+lJuPw75LH8Kos62AO/JYcGoEofU=;
 b=fuOcR2YSVN2AR1B6LsX/4FlpN/MNTB1O1DMgwKgRHQ60K4+sBne3o78qCCmyjcNEzWF6FM
 qESzELhhppwPFt1L2jQSxdreroDFTuP1FGBRhhVzTBHzhwaBxsJWR7Af9m7rsnVGqg06vA
 xNL59XpdaoTkxpeU17+XkrgkaVawsxY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-D98z1iIKPpmZS9Drkafofg-1; Tue, 25 Feb 2020 11:37:01 -0500
X-MC-Unique: D98z1iIKPpmZS9Drkafofg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCD0F18C43C0;
 Tue, 25 Feb 2020 16:36:57 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-215.ams2.redhat.com
 [10.36.117.215])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 071A86031E;
 Tue, 25 Feb 2020 16:36:53 +0000 (UTC)
Subject: Re: [PATCH v4 0/4] luks: add qemu-img measure support
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200221112522.1497712-1-stefanha@redhat.com>
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
Message-ID: <e435f6d8-a67c-09fd-819d-c5236a32cb70@redhat.com>
Date: Tue, 25 Feb 2020 17:36:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200221112522.1497712-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8tvf8inkZv2LYmvUrMzS31kg9WKdGT4wU"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8tvf8inkZv2LYmvUrMzS31kg9WKdGT4wU
Content-Type: multipart/mixed; boundary="FQ4oKu6Q4lRTrTitW0FKeOzmRfiSJKktQ"

--FQ4oKu6Q4lRTrTitW0FKeOzmRfiSJKktQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 21.02.20 12:25, Stefan Hajnoczi wrote:
> v4:
>  * This revision is what German speakers call "das T=C3=BCpfelchen auf de=
m I".  "The
>    icing on the cake" is the English equivalent.  Since I like cake and d=
on't
>    want it to be half-baked, and because I like my metaphors shaken, not
>    stirred, I went ahead with the extra revision so I could write this me=
ssage.

:)

>  * Use g_autoptr(QCryptoBlock) to make the code more concise [Max]
>  * Use local_err consistently [Max]
>  * Folded in Max's Reviewed-by tags
> v3:
>  * Move payload offset calculation function to crypto/block.c [Max]
>  * Zero/unallocated blocks always require disk space on encrypted files [=
Max]
>  * Update qemu-iotests 178 output when changing qemu-img measure command-=
line
>    options
>=20
> v2:
>  * Fix uint64_t <-> size_t type mismatch in block_crypto_measure() so tha=
t
>    32-bit builds pass
>=20
> This patch series adds qemu-img measure support to the "luks" block drive=
r.  We
> just need to take into account the LUKS header when sizing the image.

Thanks, applied to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


--FQ4oKu6Q4lRTrTitW0FKeOzmRfiSJKktQ--

--8tvf8inkZv2LYmvUrMzS31kg9WKdGT4wU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl5VTSQACgkQ9AfbAGHV
z0CC4wf/cCtK93FTQt7ZNArjsjghSuwBUKLvXn32e6q430rIjVcjBeF+UdJEnFwQ
iReo3PVM6S7IX5nARjgPqOSxFWR9DcXE/tZzLjNo5R3VmLAP69dTn0t9VN3R4p68
Ge/YevgjRfMngCHUoOOJWKbfJmeVBZkYMuBh52xDTLsdhuFJpdRezWN8ZkObLY+X
gdfvsWEBS/rRO3neRf/oTCDIeqE8KijQdO+4qDirjAMVhEx0VmDtbGJOISGhG8gc
fPTn20RiD5Ve59a5AneVumQjrizIcaivq9iM5+Kf2vgt/1Unv3VgJnACWATIJWjw
8O63t4I/qzBtlq5OEp9H0yJSHzWxfw==
=5qig
-----END PGP SIGNATURE-----

--8tvf8inkZv2LYmvUrMzS31kg9WKdGT4wU--


