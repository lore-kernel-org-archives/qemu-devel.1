Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C52AC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 14:49:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13F2A20774
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 14:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LYLRqyWQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13F2A20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGkrl-0001Ia-7T
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 10:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60962)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jGkqg-0000P1-Cl
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:48:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jGkqf-00077e-FL
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:48:10 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:53079)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jGkqf-00077D-Bl
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:48:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585061289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=uF8d/Bf7NlDz3rD2n4ZdQFSZcntZJY9AgYeEq2AMMo0=;
 b=LYLRqyWQlmUQF4+StVent8RHEaYhlor0l/oEjxIWjMzEwLbukCZMCZJXVa4Uf4oiySOgpn
 Dk+TYCuFj7gCbYPKUBLMWCh9gRdGD2oaVZVoz2+VEhY/QzqOD3S/q7YTxu8ppLY0HY7/OR
 eJ58ZDp0XLNOwLs7pomN8b5gfSK31Is=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-J7-JNoo-PrmzjhpRzRfHGg-1; Tue, 24 Mar 2020 10:48:04 -0400
X-MC-Unique: J7-JNoo-PrmzjhpRzRfHGg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E8391005510;
 Tue, 24 Mar 2020 14:48:03 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-213.ams2.redhat.com
 [10.36.114.213])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BBF2F9B934;
 Tue, 24 Mar 2020 14:48:00 +0000 (UTC)
Subject: Re: [PATCH v8 05/11] iotests: add pylintrc file
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200317004105.27059-1-jsnow@redhat.com>
 <20200317004105.27059-6-jsnow@redhat.com>
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
Message-ID: <2913909d-3411-04cf-9cc4-47ea1e7e6749@redhat.com>
Date: Tue, 24 Mar 2020 15:47:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200317004105.27059-6-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WYn3oj8ixq3GKCTfWKIL8H0ssAnFbx3or"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Kevin Wolf <kwolf@redhat.com>, ehabkost@redhat.com, qemu-block@nongnu.org,
 philmd@redhat.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WYn3oj8ixq3GKCTfWKIL8H0ssAnFbx3or
Content-Type: multipart/mixed; boundary="POMmOI39VqP96LeCKHjUOSqPlwhlgvRBr"

--POMmOI39VqP96LeCKHjUOSqPlwhlgvRBr
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 17.03.20 01:40, John Snow wrote:
> This allows others to get repeatable results with pylint. If you run
> `pylint iotests.py`, you should see a 100% pass.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  tests/qemu-iotests/pylintrc | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 tests/qemu-iotests/pylintrc

Reviewed-by: Max Reitz <mreitz@redhat.com>


--POMmOI39VqP96LeCKHjUOSqPlwhlgvRBr--

--WYn3oj8ixq3GKCTfWKIL8H0ssAnFbx3or
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl56HZ4ACgkQ9AfbAGHV
z0AAzQgAitk2GjB2K/hsHN+0e77uplBO/F9KfuVtLr9iQzUfueDCYwFPNckyVZcY
ZXYbS9hgGJU2D0KrM8UhtAin171DmZ6gQtiwo3bT6q7I9bYVRsKu5jRnD3prL42w
K9JUUdwa7S5RCGUaf0DNuttveh2R8YACBGyO6lup1HA6QjkX4INloSrarVQFHBic
IHB5i0WLxlWo7LTecraRr74po+vhd38HiQvnRgmCRtiApWMQnR+vi1sztKQxD2n2
SsjS31MbTX/VZEqTrCe74YS0oBbPKWwrkhPdK306ceCDX3hD4KbXyqawBQqweaIV
yE/n8A6vdj9Gz/t+tdkoCDvRJO8z3Q==
=YHMc
-----END PGP SIGNATURE-----

--WYn3oj8ixq3GKCTfWKIL8H0ssAnFbx3or--


