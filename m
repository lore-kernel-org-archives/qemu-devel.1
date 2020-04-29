Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBD8C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 10:49:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04C722072A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 10:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T0can07m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04C722072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTkH8-0004OZ-2v
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 06:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jTkG0-0003ex-1h
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 06:48:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jTkFb-0005ld-71
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 06:47:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32446
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jTkFa-0005lU-Ll
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 06:47:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588157253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JmaF49+2XkE5jx1mNGs4ziIPkaQ6pCQJJJHqX+MBvkM=;
 b=T0can07mm7zOe2xVxU6nfP655jv/bxe0NphQtXQI6jVERPMnRuke/MbWc6V4KnXEwZQ+lQ
 AkW/WzzaMArVXYw921Hial4ajjrMO5tARhT93+klFIf0tiA/jKWtkk5iFeOsgFB8bBzEoz
 0RDCT/nWtYy2pOKfbw5nss8AcYYSZfc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-FhORc6geORew8tQJvP4ALw-1; Wed, 29 Apr 2020 06:47:26 -0400
X-MC-Unique: FhORc6geORew8tQJvP4ALw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F5BA835B40;
 Wed, 29 Apr 2020 10:47:25 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-19.ams2.redhat.com
 [10.36.113.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A8EEC60C18;
 Wed, 29 Apr 2020 10:47:17 +0000 (UTC)
Subject: Re: [PATCH] block: Comment cleanups
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200428213807.776655-1-eblake@redhat.com>
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
Message-ID: <e91db87c-0bf3-1679-1a42-05bde67b4ad1@redhat.com>
Date: Wed, 29 Apr 2020 12:47:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428213807.776655-1-eblake@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="10BNzb9KnCxZwUiSOKDwDsFiYFGdI8xHA"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:42:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, berto@igalia.com,
 "open list:Block I/O path" <qemu-block@nongnu.org>, qemu-trivial@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--10BNzb9KnCxZwUiSOKDwDsFiYFGdI8xHA
Content-Type: multipart/mixed; boundary="wegqop5tLcPw4Jg6CkYGC1Brf3n6MJb18"

--wegqop5tLcPw4Jg6CkYGC1Brf3n6MJb18
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 28.04.20 23:38, Eric Blake wrote:
> It's been a while since we got rid of the sector-based bdrv_read and
> bdrv_write (commit 2e11d756); let's finish the job on a few remaining
> comments.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>=20
> Hmm - I started this in Nov 2018, and just barely noticed that it has
> been sitting in a stale tree on my disk for a while now...
>=20
>  block/io.c             |  3 ++-
>  block/qcow2-refcount.c |  2 +-
>  block/vvfat.c          | 10 +++++-----
>  tests/qemu-iotests/001 |  2 +-
>  tests/qemu-iotests/052 |  2 +-
>  tests/qemu-iotests/134 |  2 +-
>  tests/qemu-iotests/188 |  2 +-
>  7 files changed, 12 insertions(+), 11 deletions(-)

Thanks, applied to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block-next

Max


--wegqop5tLcPw4Jg6CkYGC1Brf3n6MJb18--

--10BNzb9KnCxZwUiSOKDwDsFiYFGdI8xHA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6pWzQACgkQ9AfbAGHV
z0DbBgf/fRz54etkkpBEi2aK9d1g13PkSCq+pN0nb/2CWYWRuw4f+2iaRe2x7QIL
ggYiagRBaiLly/BRfKHDnnrrguHlGQLsSqYmoAMI3VR62JrkNRFjri8v3UO3Udfa
ez244+d/g15OZolhhrSgaUhMXo8EusQQnvFWnazcOP0zY7X7Umqc5zYK0KRAVQRq
h+g4g8FwFY+LMZjnShWteYrksusiwnwUWjUGu/j0vJqOO45lhNlRGlWEt2ZyCid1
UTQk3lcJlFE5B5D2Z3lPJVO/1Yk6z37qSR9IXiBMDLcbN/8PuYc+QvLbpGbTLr0d
U5hslVqgaKaX/MTjsHqNFdR5mSdRlg==
=khkp
-----END PGP SIGNATURE-----

--10BNzb9KnCxZwUiSOKDwDsFiYFGdI8xHA--


