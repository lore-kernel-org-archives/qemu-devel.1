Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68513C11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 11:59:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3316020722
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 11:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O3QlPwSk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3316020722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4kUF-0004Ti-An
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 06:59:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45239)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j4kTZ-000448-L8
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 06:58:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j4kTY-0002fe-AT
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 06:58:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30591
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j4kTY-0002eu-2x
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 06:58:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582199919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=59N0uYw7ksrKTy5/i6KxwN4k79C857EbIIbAXRze2q0=;
 b=O3QlPwSk/gdYXD4CPf+HuFfbmLGxZpbD4Cw2QZ9pHM2LbxMLaEU5sxomGqk749z1kqd4ZD
 UfipBLhnTPwI9qiKU8tT1/kbBdXNZribEogOnTX5MLkKZE0NkIGYCswgwZMfYswtPeHnVu
 9Glg8Tllg9TuNbHdgUaI4/hVziEHjqM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-HYBq7B8CPFSLe9v04V2qOA-1; Thu, 20 Feb 2020 06:58:34 -0500
X-MC-Unique: HYBq7B8CPFSLe9v04V2qOA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09CDB1005512;
 Thu, 20 Feb 2020 11:58:33 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E74E35D9E2;
 Thu, 20 Feb 2020 11:58:27 +0000 (UTC)
Subject: Re: [PATCH v3 0/3] Dump QCOW2 metadata
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1578990137-308222-1-git-send-email-andrey.shinkevich@virtuozzo.com>
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
Message-ID: <fb4eb1a7-25f7-86ce-4c27-06bca430e97a@redhat.com>
Date: Thu, 20 Feb 2020 12:58:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1578990137-308222-1-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9EysurC9B5pWpCbWMWaR4h166y6RoDDv8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 armbru@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9EysurC9B5pWpCbWMWaR4h166y6RoDDv8
Content-Type: multipart/mixed; boundary="8F5qToAxYXG3xET90Qpc5Bat6sIfx7Fey"

--8F5qToAxYXG3xET90Qpc5Bat6sIfx7Fey
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14.01.20 09:22, Andrey Shinkevich wrote:
> The information about QCOW2 metadata allocations in an image ELF-file is
> helpful for finding issues with the image data integrity.

Sorry that I=92m replying only so late =96 but I don=92t know why we need t=
his
in qemu, and this cover letter doesn=92t provide a justification.  I mean,
it isn=92t too complex (from the diffstat), but wouldn=92t it be better to
just have a script for this?

I suppose one reason to put it in qemu/qemu-img is that a script
wouldn=92t be packaged by distributions.  So if a user has a corrupted
image, with this series we could tell them to run qemu-img check -M and
put the output somewhere.  With a script, we=92d first have to tell them
to download the script.  But then again, downloading a script (that
should be part of the qemu repository) doesn=92t seem too much trouble to
me either.

So I=92m curious as to whether you had a specific reason in mind when you
decided to implement this as part of qemu itself?

(I suppose the additional complexity is fully limited to the check
infrastructure, so it wouldn=92t interfere with the rest of the qcow2
driver.  Hm.  Fair enough.)

Max


--8F5qToAxYXG3xET90Qpc5Bat6sIfx7Fey--

--9EysurC9B5pWpCbWMWaR4h166y6RoDDv8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl5OdF4ACgkQ9AfbAGHV
z0AYjQf/YmiDwDBHZlVm2e1T/O1TlMtCG4RUULwR8kq+s2Rf0dGx97Qx2Y1vBdp0
OaVXp7/AOKM1FoBLERB07e66HqIdyFaZlC/FPzEXCFDqYhY9JYmXx5+SiqhW4CYc
RmLcpbqSBoebSZ/4Jr7J7gjYwdEG+vkEdLWRXtGxTMFfgAE/tgPFLJDTW219cFRz
KIqzaij/ipsHajPm6uyNCzl2KUXq3E+ZDRuUvQHG4+5+lvgif08a55Eikk5gT8in
2dHnT0HTCRDFdTZUV6lH/8U31KB4F49Z4eza5QAck6MqqfWV9mAzDWyXBe6ccz4g
Ngg4TuVnGJpNobWh4ObhrZSxzgXpOQ==
=oqgx
-----END PGP SIGNATURE-----

--9EysurC9B5pWpCbWMWaR4h166y6RoDDv8--


