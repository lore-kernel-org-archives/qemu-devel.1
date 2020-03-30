Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565C9C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 12:32:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EDCC206E6
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 12:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UxbRxNmB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EDCC206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jItb4-0007wD-9u
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 08:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39204)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jItaK-0007HY-LT
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 08:32:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jItaJ-00043N-Ib
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 08:32:08 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:56867)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jItaJ-000437-Cz
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 08:32:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585571526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fbhUKfDtn/xW1A0wRpgFqArFD13cMBWxSU+BHFh4EcI=;
 b=UxbRxNmBQRhGvjVAewQQZHdbn6xiHTZX5ojJdUpXgD0uFB2i9Fc3L+dNl6r8atVZrQR3/c
 zVKm+3HrTRgVLwb2gA5/XKHscv7RLV8vJanrnnCyFzyUJrBuwC2mvrmSUPdodEDZU+zI6d
 rlI6OemyzuSRwTuTEWX7CQrD1x8wjgU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-WhJZTgZWNvuKq6Eq1x1DVw-1; Mon, 30 Mar 2020 08:32:04 -0400
X-MC-Unique: WhJZTgZWNvuKq6Eq1x1DVw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8795B107B765;
 Mon, 30 Mar 2020 12:32:03 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-93.ams2.redhat.com
 [10.36.113.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 03A0F60BEC;
 Mon, 30 Mar 2020 12:32:00 +0000 (UTC)
Subject: Re: [PATCH v9 09/14] iotests: limit line length to 79 chars
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200324232103.4195-1-jsnow@redhat.com>
 <20200324232103.4195-10-jsnow@redhat.com>
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
Message-ID: <9cbad981-3c63-c0d7-48e6-a0785d25be30@redhat.com>
Date: Mon, 30 Mar 2020 14:31:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200324232103.4195-10-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="apu1QjWhIHyQ8jWMyDyvQBVno0Qy7psow"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
 armbru@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--apu1QjWhIHyQ8jWMyDyvQBVno0Qy7psow
Content-Type: multipart/mixed; boundary="0eQ56fLSj8vvgWomCknLcMv9zk71PW9Ga"

--0eQ56fLSj8vvgWomCknLcMv9zk71PW9Ga
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25.03.20 00:20, John Snow wrote:
> 79 is the PEP8 recommendation. This recommendation works well for
> reading patch diffs in TUI email clients.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  tests/qemu-iotests/iotests.py | 64 +++++++++++++++++++++++------------
>  tests/qemu-iotests/pylintrc   |  6 +++-
>  2 files changed, 47 insertions(+), 23 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
> index 3a049ece5b..e12d6e533e 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py

[...]

> @@ -537,11 +547,13 @@ def pause_drive(self, drive, event=3DNone):
>              self.pause_drive(drive, "write_aio")
>              return
>          self.qmp('human-monitor-command',
> -                 command_line=3D'qemu-io %s "break %s bp_%s"' % (drive, =
event, drive))
> +                 command_line=3D'qemu-io %s "break %s bp_%s"'
> +                 % (drive, event, drive))
> =20
>      def resume_drive(self, drive):
>          self.qmp('human-monitor-command',
> -                 command_line=3D'qemu-io %s "remove_break bp_%s"' % (dri=
ve, drive))
> +                 command_line=3D'qemu-io %s "remove_break bp_%s"'
> +                 % (drive, drive))

Hm.  You didn=E2=80=99t reply on my (second, insisting) question on what st=
ops
us from introducing a variable here (hmp_cmd =3D 'qemu-io %s ...' % ...;
self.qmp('human-monitor-command', command_line=3Dhmp_cmd)).

:c

Max


--0eQ56fLSj8vvgWomCknLcMv9zk71PW9Ga--

--apu1QjWhIHyQ8jWMyDyvQBVno0Qy7psow
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6B5r8ACgkQ9AfbAGHV
z0BoWAf9EhOi3hA7+huhobdylDovY87usl/V676fNWwPd47/Z+cBWFb3f3437yag
yhJFHPVVohIB54BMpdRySUwpwu1fEBt/4tAoFA7ghfbFd2LzZ3z3gCeN0y1Z6Y1L
+h7Whi4yoR75v3Y5/dF8ZlnRQRLsYgeLEQO3BR8llVdS6JPPeLPNa9iog27Npx5N
hxfBS3sTQSiVPXFhuFo2wnCOmV/o1NeyHcMdNn+I5xjJY2Mn/T+X2Da77tAf0vkJ
+SIjgb8oCq99p41fvyBplZGqXegZek1b/7flNZ+hpoZKJQsovqN39ghkopkz3sFM
12qZKko2IQ7TMIeEDV/redg3QwtP4Q==
=m5wa
-----END PGP SIGNATURE-----

--apu1QjWhIHyQ8jWMyDyvQBVno0Qy7psow--


