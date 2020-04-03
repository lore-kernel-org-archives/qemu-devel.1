Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F5EC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 08:57:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1C6E2080C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 08:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IYHCRdsN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1C6E2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKI9D-0005Yk-UG
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 04:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49786)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jKI8a-0004zC-5L
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:57:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jKI8Z-0006EC-CT
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:57:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33740
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jKI8Z-0006CS-8G
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:57:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585904234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fMMcSMTa7eu3IMeeA71RAUTrDD6goQQOH0s2aDiCETE=;
 b=IYHCRdsN+b3VtzmnFijeRi9Nvl8rYCJrKMqiKqLUgFdS49J6UPNRn8l3BcYBF63T6ObB77
 CxJ6QgYVB2SYvtr5qNNNtkxVNbRUYSy/TBef2uVkxpF4BVeKGXu1zLPXqib03aVXUxX0o1
 UvBZ9OAjXTXmFsP3KJRBi2+WG4R3wz4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-92jZRmM2OHS7BOaNT0Ok4A-1; Fri, 03 Apr 2020 04:57:12 -0400
X-MC-Unique: 92jZRmM2OHS7BOaNT0Ok4A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 939958024D2;
 Fri,  3 Apr 2020 08:57:11 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-97.ams2.redhat.com
 [10.36.113.97])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2839D5C296;
 Fri,  3 Apr 2020 08:57:08 +0000 (UTC)
Subject: Re: [PATCH v10 10/14] iotests: add hmp helper with logging
To: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>
References: <20200331000014.11581-1-jsnow@redhat.com>
 <20200331000014.11581-11-jsnow@redhat.com>
 <88146808-4acc-247e-d34b-5dd16baad0b4@redhat.com>
 <c0efeb62-b121-74a2-1929-b41a0e47c1b8@redhat.com>
 <20200331173945.GL7030@linux.fritz.box>
 <0c8ce9c5-d8b4-4b24-a6e3-4b9863c52fe0@redhat.com>
 <449f8a5e-d8a0-1993-c30c-97d67a89df1e@redhat.com>
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
Message-ID: <0cdd5431-4cfb-914f-d506-572313d9e45a@redhat.com>
Date: Fri, 3 Apr 2020 10:57:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <449f8a5e-d8a0-1993-c30c-97d67a89df1e@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="BraTEYOaml7RhydSMRHsMYa2ftKz5u4pr"
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
Cc: ehabkost@redhat.com, qemu-block@nongnu.org, philmd@redhat.com,
 qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BraTEYOaml7RhydSMRHsMYa2ftKz5u4pr
Content-Type: multipart/mixed; boundary="SqiUeREnQtwYYViLTQ4EPnQbqWZxKGIMx"

--SqiUeREnQtwYYViLTQ4EPnQbqWZxKGIMx
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 02.04.20 20:27, John Snow wrote:

[...]

> Are we squared up for this series? I am actually not sure.

As far as I=E2=80=99m concerned, yes.  I just had this question on how to u=
se mypy.

Max


--SqiUeREnQtwYYViLTQ4EPnQbqWZxKGIMx--

--BraTEYOaml7RhydSMRHsMYa2ftKz5u4pr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6G+mMACgkQ9AfbAGHV
z0BRZAgApNPkcwoLQ2/Q6OL9zfTK1mXQYgtU/dVQRXlicz/SHg2vX1LguFbst6nH
o5GKmcZAaAIfD1Hy00TQfa7CeQ0d8Mwl2J82JXbUEm4KmwxZhW+pgytUYOxUrM+M
d1RmiYfPEDpPYhiF7byRn4n0bzjEvZhPP9nWIePPoO3dXJjQ3PeL1XBqvunGgj+Q
f1enSu0M9L626YvDcuu03ibftqt507J1TQdtmc2GP4cCMleDOjrIZ5bNYnmvSTmI
T1aeLBwqYVEnzlmAmDeMEZeLWML4UUyrB11u2u+p4ejvHBsGPXoBDmDMXzIAdmzf
6itsMk1n3MfMJdawraM1piOLNhopcQ==
=88wv
-----END PGP SIGNATURE-----

--BraTEYOaml7RhydSMRHsMYa2ftKz5u4pr--


