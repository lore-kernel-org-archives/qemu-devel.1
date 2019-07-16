Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD4DC76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 07:47:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23CD620880
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 07:47:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23CD620880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnIBe-0005tT-4f
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 03:47:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52255)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hnIBS-0005VE-1s
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 03:47:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hnIBR-0000S2-0q
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 03:47:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36214)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1hnIBQ-0000R4-OH
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 03:47:32 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 954D085376;
 Tue, 16 Jul 2019 07:47:31 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C6CD5C554;
 Tue, 16 Jul 2019 07:47:24 +0000 (UTC)
To: Paolo Bonzini <pbonzini@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org
References: <1562959033-223586-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <b270d0cc-2a28-8a60-ccac-45ac4de89f02@redhat.com>
 <a55d4518-734e-9dd1-296f-473600eacbf7@redhat.com>
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
Message-ID: <7064b3ea-d0a9-dbb9-aecd-d0dbca168c40@redhat.com>
Date: Tue, 16 Jul 2019 09:47:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <a55d4518-734e-9dd1-296f-473600eacbf7@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="MbGD1P2qzaC1HhgExJ0VG9tiXU1o2hkEk"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Tue, 16 Jul 2019 07:47:31 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] chardev: race condition with
 tcp_chr_disconnect
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
Cc: marcandre.lureau@redhat.com, vsementsov@virtuozzo.com, rkagan@virtuozzo.com,
 den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MbGD1P2qzaC1HhgExJ0VG9tiXU1o2hkEk
Content-Type: multipart/mixed; boundary="J7p7uDhYQRtexc9zqboe9LwzfHje16Df8";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org
Cc: vsementsov@virtuozzo.com, rkagan@virtuozzo.com,
 marcandre.lureau@redhat.com, den@openvz.org
Message-ID: <7064b3ea-d0a9-dbb9-aecd-d0dbca168c40@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] chardev: race condition with
 tcp_chr_disconnect
References: <1562959033-223586-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <b270d0cc-2a28-8a60-ccac-45ac4de89f02@redhat.com>
 <a55d4518-734e-9dd1-296f-473600eacbf7@redhat.com>
In-Reply-To: <a55d4518-734e-9dd1-296f-473600eacbf7@redhat.com>

--J7p7uDhYQRtexc9zqboe9LwzfHje16Df8
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 15.07.19 20:27, Paolo Bonzini wrote:
> On 15/07/19 19:23, Max Reitz wrote:
>> On 12.07.19 21:17, Andrey Shinkevich wrote:
>>> When tcp_chr_disconnect() is called, other thread may be still writin=
g
>>> to the channel. This patch protects only read operations that initiat=
e
>>> the disconnection.
>>>
>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>> ---
>>
>> Have you looked at
>> https://lists.nongnu.org/archive/html/qemu-devel/2019-02/msg06174.html=

>> already?  From a glance, it looks like that series supersedes this one=
=2E
>>
>> (No, I don=E2=80=99t know why the other series is delayed.
>=20
> Because it broke some testcases in tests/vhost-user-test.  They are
> disabled by default, because AFAIR they broke on some CI environment,
> but they are supposed to work.

Ah, OK.  Thanks!

Max


--J7p7uDhYQRtexc9zqboe9LwzfHje16Df8--

--MbGD1P2qzaC1HhgExJ0VG9tiXU1o2hkEk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0tgQgACgkQ9AfbAGHV
z0CUcAf/WV+AbSQKmIWzvQbKABBEaOC0hRB+vRlWK2sWoHwYKLKZGpAq/Q5tGvcm
20GHnzvktNFKntILrKy8awodTnOXkYjY3yLx5qXzJkfyFC0T6yNDn0+U+nR30suA
TgwvAKjPDwJ6AdbKr4FnG+wQyx5Ylp2IslZnGjQv183OHh8Z8w7u0SuOg55fS3oY
HyeDG4jz1+jlg7UI8PZuJ8Zj9u95ISnWkSPptKTkPjGBVtrkZ7NiV580TZZ3jnv9
wQKJtXBjddwKOfS0HQjAbr0p80ZbFPM4n4pNh+/DBuA0AgcPS23WafEKCvFk0WjZ
+evIq4YevKUo0Xv7NhLLqEVODSY2WQ==
=NldG
-----END PGP SIGNATURE-----

--MbGD1P2qzaC1HhgExJ0VG9tiXU1o2hkEk--

