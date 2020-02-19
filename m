Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19412C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 10:53:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCF382464E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 10:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ECovvOos"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCF382464E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4MzD-0005my-4S
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 05:53:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33254)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j4Myd-0005D0-GQ
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 05:53:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j4Myc-0006dU-Ig
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 05:53:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34485
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j4Myc-0006co-E6
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 05:53:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582109589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BkwGLSiTOclAbuU2mDx6b4OdEb/5R03iOdT+9Ccon1s=;
 b=ECovvOosSCj5hOS+1PoAEcZgT5cBErjvXmogqsdnlf0XMC+H1WspakN5pjSaFbeFaY08Tv
 fUQuWAtXty9dEecTai8Klajnj1fba+f1ZJIQcV4FO7nFxWoMMVovWhXZR8gKtevD3+9Ms6
 jxuN9YRCDCuOpWROBpGFdJKn+YWxc/0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-048a-YxrP-eZUeHZ6bQPYQ-1; Wed, 19 Feb 2020 05:53:07 -0500
X-MC-Unique: 048a-YxrP-eZUeHZ6bQPYQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63D5F107ACCD;
 Wed, 19 Feb 2020 10:53:06 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-152.ams2.redhat.com
 [10.36.116.152])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0024C60FC1;
 Wed, 19 Feb 2020 10:53:01 +0000 (UTC)
Subject: Re: [PATCH v2 0/2] finish qemu-nbd --partition deprecation
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200123164650.1741798-1-eblake@redhat.com>
 <b3fe3a5b-0692-fb35-55ec-281fc2699e98@redhat.com>
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
Message-ID: <2bc36642-3ba6-b44b-c89d-959e04795d20@redhat.com>
Date: Wed, 19 Feb 2020 11:53:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <b3fe3a5b-0692-fb35-55ec-281fc2699e98@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="W4Bn9rYnxC9BGyxkypnkqaDH3O1hmPQu9"
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
Cc: peter.maydell@linaro.org,
 "libvirt-list@redhat.com" <libvirt-list@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--W4Bn9rYnxC9BGyxkypnkqaDH3O1hmPQu9
Content-Type: multipart/mixed; boundary="0bWg7y8kDiUiuQilhHeDNF9Zl1NkyeiLJ"

--0bWg7y8kDiUiuQilhHeDNF9Zl1NkyeiLJ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 31.01.20 18:11, Eric Blake wrote:
> ping

Do you want further review or is J=C3=A1n=E2=80=99s sufficient for you?

Also, I wonder whether it would make a good GSoC/Outreachy/... project
to add partition reading support to the raw block driver, or whether
that=E2=80=99s a bad idea. O:-)

Max


--0bWg7y8kDiUiuQilhHeDNF9Zl1NkyeiLJ--

--W4Bn9rYnxC9BGyxkypnkqaDH3O1hmPQu9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl5NE4wACgkQ9AfbAGHV
z0BWoQf/SVmpGGdNh3ba/07KrdlO6kIU83EOcysC8oZgnZloA8tp/KsNJAw99cGs
AJ6m9LxUBCHpMgryPN8jNJ3QM9wtYyvLxCn/kyvFmAdHF/L+K1rXQNCBt5hzdROA
Cz7ky9FQXY5Vh20PNHulVC7q1HnopjiQXXSD/B6LaDMxdkGvqe9yyfugw2Ro6v6y
fEjl/YOw7ZCdsLYyiuCcu/2DuGuxCz46I+SeLdl6IYfVSh5+ss/zytKX2Nlm18Rr
F83hm4qniHTJ4HzNwSoTH0UH7NGuAQw9iw8dfKJ/hvOsyH1EF2YIdXo0GRbF9cBe
y0qS1mCNUTkuSuhpL70ewqC5N3gDQw==
=3gtS
-----END PGP SIGNATURE-----

--W4Bn9rYnxC9BGyxkypnkqaDH3O1hmPQu9--


