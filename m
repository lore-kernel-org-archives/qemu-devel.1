Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EB3C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 15:03:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C988C20775
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 15:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D1qgT4ZL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C988C20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGl5J-0003cU-VO
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 11:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34932)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jGl4i-00039V-4R
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 11:02:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jGl4h-0005Wc-0m
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 11:02:40 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:32382)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jGl4f-0005V8-RN
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 11:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585062157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=uKsuUurToNJ36ShU+RKNDGNGp0Z9R4dsYDn9y/dNKWY=;
 b=D1qgT4ZLGWRoBW/KVmhwaYK3XfHW2EVWBysf4GQGCvD5DAKVwFke2CP3ZHqcNZI15om2Hf
 IBcKiQd7hfCrdcpNabbPCXkLCx5WI6pMPmPWFrgqlSGltxBcAg8ReS0/Cip/3vn1nS8qUS
 NzsnDzoxGEe2p+LNP4So4oe3P7p5NGc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-7DxlfQZqPFKxRrJz8MYGrg-1; Tue, 24 Mar 2020 11:02:26 -0400
X-MC-Unique: 7DxlfQZqPFKxRrJz8MYGrg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1FF99DB23;
 Tue, 24 Mar 2020 15:02:25 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-213.ams2.redhat.com
 [10.36.114.213])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C5B87BBBE1;
 Tue, 24 Mar 2020 15:02:22 +0000 (UTC)
Subject: Re: [PATCH v8 07/11] iotests: limit line length to 79 chars
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200317004105.27059-1-jsnow@redhat.com>
 <20200317004105.27059-8-jsnow@redhat.com>
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
Message-ID: <dcc1f8fa-2916-4241-b213-5ddf0ed62c34@redhat.com>
Date: Tue, 24 Mar 2020 16:02:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200317004105.27059-8-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="u5xl8ajkacvpluAKjlpTWuidNnjpX2f47"
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
--u5xl8ajkacvpluAKjlpTWuidNnjpX2f47
Content-Type: multipart/mixed; boundary="6sPEEom8VKuIFtSthv0rPEwaqQCKIiMas"

--6sPEEom8VKuIFtSthv0rPEwaqQCKIiMas
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 17.03.20 01:41, John Snow wrote:
> 79 is the PEP8 recommendation. This recommendation works well for
> reading patch diffs in TUI email clients.

Also for my very GUI-y diff program (kompare).

> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  tests/qemu-iotests/iotests.py | 64 +++++++++++++++++++++++------------
>  tests/qemu-iotests/pylintrc   |  6 +++-
>  2 files changed, 47 insertions(+), 23 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
> index 3d90fb157d..75fd697d77 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py

[...]

> @@ -529,11 +539,13 @@ def pause_drive(self, drive, event=3DNone):
>              self.pause_drive(drive, "write_aio")
>              return
>          self.qmp('human-monitor-command',
> -                 command_line=3D'qemu-io %s "break %s bp_%s"' % (drive, =
event, drive))
> +                 command_line=3D'qemu-io %s "break %s bp_%s"'
> +                 % (drive, event, drive))

Can we put this value in a variable instead?  I don=E2=80=99t like the %
aligning with the parameter name instead of the string value.  (I also
don=E2=80=99t like how there are no spaces around the assignment =3D, but a=
round
the %, even though the % binds more strongly.)

> =20
>      def resume_drive(self, drive):
>          self.qmp('human-monitor-command',
> -                 command_line=3D'qemu-io %s "remove_break bp_%s"' % (dri=
ve, drive))
> +                 command_line=3D'qemu-io %s "remove_break bp_%s"'
> +                 % (drive, drive))
> =20
>      def hmp_qemu_io(self, drive, cmd):
>          '''Write to a given drive using an HMP command'''
> @@ -793,16 +805,18 @@ def dictpath(self, d, path):
>                  idx =3D int(idx)
> =20
>              if not isinstance(d, dict) or component not in d:
> -                self.fail('failed path traversal for "%s" in "%s"' % (pa=
th, str(d)))
> +                self.fail(f'failed path traversal for "{path}" in "{d}"'=
)

Do we require 3.6 so that f-strings are guaranteed to work?  (I thought
we didn=E2=80=99t.  I=E2=80=99d be happy to use them.)

Max


--6sPEEom8VKuIFtSthv0rPEwaqQCKIiMas--

--u5xl8ajkacvpluAKjlpTWuidNnjpX2f47
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl56IPwACgkQ9AfbAGHV
z0ByiAf/YSQk2a+dHeOBvY7Q3DfO9M0E6PKp8hRh99Z3I5F2qNHME512UA9yNbYh
dlkEM99Tg+TmTedLV35Y1ZV4M8KXnlYZvKF4Shfhx27RM6rHkZJeO/NfQS+HxsAz
98fGTsvae71W36V0YmnyQabCac/YwX8TqlzShh28oyEoTny518SoOo0UZkNRZ7eH
TpngMm4K+jgrg3ZQMp/yeql04w3ld2Pq+xQTcGQDc4GyFxDmx5XHjTocXrU0ljE1
y3JPlaXB6OUAPFW9eNSUFAXUUaj8T9aOYqt2MMHnDaMufuOnx7f7+L54bmQHIter
1M3xgt+Ece5VaGGqSloEXl7DWhmkwQ==
=ulj2
-----END PGP SIGNATURE-----

--u5xl8ajkacvpluAKjlpTWuidNnjpX2f47--


