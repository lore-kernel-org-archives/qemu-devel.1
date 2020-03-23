Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED6EC4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 11:48:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6BE22076A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 11:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wuwrk2BO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6BE22076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGLYl-0004OG-VI
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 07:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44972)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jGLX3-0002Tt-7g
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:46:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jGLX2-0004Ru-7O
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:46:13 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:20911)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jGLX2-0004RX-1V
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:46:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584963971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:autocrypt:autocrypt;
 bh=FHXkijsH6IiNuxJGRs8uip2KKcd+XkSt48kwypL5x4A=;
 b=Wuwrk2BOVoReu/Eyt1R+ja0f9V2ejR3flwIr4C8WNmf08F0tYGEu8R0MjPJGXZUuDE+c4f
 JUQ4OOYl1yeA1Um4kqefobz3/rmGZ+tgh0azbX51Lcf+IZo7AspTRDvTtGSQU2CrqEuqoU
 0GyItSlTD9nAG7tQxDy+qfd0Uy7ME3E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-Ptfizfq7Nu-o7Xiy1ElF4g-1; Mon, 23 Mar 2020 07:46:09 -0400
X-MC-Unique: Ptfizfq7Nu-o7Xiy1ElF4g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 171D8192D79C;
 Mon, 23 Mar 2020 11:46:08 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-242.ams2.redhat.com
 [10.36.114.242])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A98347E31D;
 Mon, 23 Mar 2020 11:46:06 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>
From: Max Reitz <mreitz@redhat.com>
Subject: Coverity CID 1421984
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
Message-ID: <d9b7d8d8-1640-7d69-cd16-66e6d9cef3d1@redhat.com>
Date: Mon, 23 Mar 2020 12:46:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DWHGrajVOBuzvqnOuzXG4INnaerB4rjFW"
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DWHGrajVOBuzvqnOuzXG4INnaerB4rjFW
Content-Type: multipart/mixed; boundary="b6HCzRU7VMyMekDQWAq1ffOvJf8aEg4zD"

--b6HCzRU7VMyMekDQWAq1ffOvJf8aEg4zD
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

I was triaging new Coverity block layer reports today, and one that
seemed like a real bug was CID 1421984:

It complains about a memleak in sii3112_pci_realize() in
hw/ide/sii3112.c, specifically about @irq being leaked (it=E2=80=99s alloca=
ted
by qemu_allocate_irqs(), but never put anywhere or freed).

I=E2=80=99m not really well-versed in anything under hw/ide, so I was wonde=
ring
whether you agree it=E2=80=99s a bug and whether you know the correct way t=
o fix
it.  (I assume it=E2=80=99s just a g_free(irqs), but maybe there=E2=80=99s =
a more
specific way that=E2=80=99s applicable here.)

Max


--b6HCzRU7VMyMekDQWAq1ffOvJf8aEg4zD--

--DWHGrajVOBuzvqnOuzXG4INnaerB4rjFW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl54oXwACgkQ9AfbAGHV
z0DvVAf/Rg+clRPiYrqKlA00xwA/CNS0tZxIV6gpwZaLfImVquzctCVWG+jhjCFl
kZu+euqHq0IUx03qDavwGyxsFJ3qOkCeSBJONvfHzA0XoOLoX6SfFwtSzRSiAeXr
ZIlPKmKMEfUM4R/3dzY2xQlY7GP7Hmi6s5oSv76Hxrxm/kLbLczCwIvadEr7wyIu
jcugALNbhH1rmFQBPcr0jx26Xur+WFJekpBXa+fa9ovI8kRlqG1A3vQeGRu1LhCg
vHqWtQUq4OaZovw1vNOl6o48XnVK+zT43A1JChbPQlKZfApNq+9cDjrEis1PZYcY
l8CtGU5miSh14A7tjtZJX0TBZF3fRg==
=dyVk
-----END PGP SIGNATURE-----

--DWHGrajVOBuzvqnOuzXG4INnaerB4rjFW--


