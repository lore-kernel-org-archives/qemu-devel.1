Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3B5C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 16:32:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 588B5206A2
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 16:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ATvWLL9l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 588B5206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57797 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itwSJ-0000Qg-8Y
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 11:32:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37539)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1itwRP-0008Aj-4N
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:31:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1itwRN-0005ZM-St
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:31:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58441
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1itwRN-0005Z6-OL
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:31:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579624305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Y7Bnfgf2oIwwBmTRaHU8lPp9hWeA1DkkEfM/cM6dmwQ=;
 b=ATvWLL9lJLOoGidNisu0SadFgYgKeXxN/Zy072zWeEkGf1jI+pWAts71OYMMxyRN5R+qsa
 VmsqNjdn/etUrh6cpcTF1SiBEoZGJJsu+jcp9x71jDqsQzCNwqab902v87zeRyzQHe8jIp
 z/RzX9HPBoPbbGmqxAWGyyXeYBMp+AU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-IowErDpZNASojEUlJUyizw-1; Tue, 21 Jan 2020 11:31:41 -0500
X-MC-Unique: IowErDpZNASojEUlJUyizw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EFBD3DB30;
 Tue, 21 Jan 2020 16:31:39 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-116.ams2.redhat.com
 [10.36.117.116])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5610728996;
 Tue, 21 Jan 2020 16:31:38 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] iotests: add test for backup-top failure on
 permission activation
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200121142802.21467-1-vsementsov@virtuozzo.com>
 <20200121142802.21467-3-vsementsov@virtuozzo.com>
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
Message-ID: <0913d27f-ce33-4f46-1b98-d6744a3336c0@redhat.com>
Date: Tue, 21 Jan 2020 17:31:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200121142802.21467-3-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="i8QqTccVgCjUBVoYvzshBkmgppDapRY4p"
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--i8QqTccVgCjUBVoYvzshBkmgppDapRY4p
Content-Type: multipart/mixed; boundary="74BLqvZXmHtBuv2idDMdYnChFP6stBcnm"

--74BLqvZXmHtBuv2idDMdYnChFP6stBcnm
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 21.01.20 15:28, Vladimir Sementsov-Ogievskiy wrote:
> This test checks that bug is really fixed by previous commit.
>=20
> Cc: qemu-stable@nongnu.org # v4.2.0
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  tests/qemu-iotests/283     | 92 ++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/283.out |  8 ++++
>  tests/qemu-iotests/group   |  1 +
>  3 files changed, 101 insertions(+)
>  create mode 100644 tests/qemu-iotests/283
>  create mode 100644 tests/qemu-iotests/283.out
>=20
> diff --git a/tests/qemu-iotests/283 b/tests/qemu-iotests/283
> new file mode 100644
> index 0000000000..293e557bd9
> --- /dev/null
> +++ b/tests/qemu-iotests/283
> @@ -0,0 +1,92 @@

[...]

> +""" Test description
> +
> +When performing a backup, all writes on the source subtree must go throu=
gh the
> +backup-top filter so it can copy all data to the target before it is cha=
nged.
> +backup-top filter is appended above source node, to achieve this thing, =
so all
> +parents of source node are handled. A configuration with side parents of=
 source
> +sub-tree with write permission is unsupported (we'd have append several
> +backup-top filter like nodes to handle such parents). The test create an
> +example of such configuration and checks that a backup is then not allow=
ed
> +(blockdev-backup command should fail).
> +
> +The configuration:
> +
> +    =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=90  target  =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=90
> +    =E2=94=82 target =E2=94=82 =E2=97=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80 =E2=94=82 backup_top  =E2=94=82
> +    =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=98          =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=98
> +                            =E2=94=82
> +                            =E2=94=82 backing
> +                            =E2=96=BC
> +                        =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=90
> +                        =E2=94=82   source    =E2=94=82
> +                        =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=98
> +                            =E2=94=82
> +                            =E2=94=82 file
> +                            =E2=96=BC
> +                        =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=90  write perm   =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=90
> +                        =E2=94=82    base     =E2=94=82 =E2=97=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80 =E2=94=82 other =E2=94=82
> +                        =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=98               =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=98
> +
> +On activation (see .active field of backup-top state in block/backup-top=
.c),
> +backup-top is going to unshare write permission on its source child. Wri=
te
> +unsharing will be propagated to the "source->base" link and will conflic=
t with
> +other node write permission. So permission update will fail and backup j=
ob will
> +not be started.
> +
> +Note, that the only thing which prevents backup of running on such
> +configuration is default permission propagation scheme. It may be altere=
d by
> +different block drivers, so backup will run in invalid configuration. Bu=
t
> +something is better than nothing. Also, before the previous commit (comm=
it
> +preceding this test creation), starting backup on such configuration led=
 to
> +crash, so current "something" is a lot better, and this test actual goal=
 is
> +to check that crash is fixed :)

Thanks a lot for bearing with me!

I was wondering whether this is the first smiley in our code, but it
isn=E2=80=99t.  (Not unfortunately, I think. :-))  It=E2=80=99s also not th=
e first
smiley in the iotests, but the second one!  (As far as I can tell.)

Max


--74BLqvZXmHtBuv2idDMdYnChFP6stBcnm--

--i8QqTccVgCjUBVoYvzshBkmgppDapRY4p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl4nJ2gACgkQ9AfbAGHV
z0ArSQf/SLvJ39PMx80uT70AXY7ettgeTFMqNW4TlV+274VDzN/7Lra1cBB7sVrX
Z/IitBzdcSeTI+wTBCYFuBavbkgDfDObcYIiIbn+1+++dICxM2CVlJW5FhNQ93qR
Vdclz7d7IJbnq2wCOP6inQ6BoloJsl46pNhj6kv++x87uvoiFXmZj9RERmt7K3Hf
d2EVfxqg9ABiWWbRlkKuMKM4Aj0iqgOK35b9Pt12cYF+E2BBYB43kw6s2cBm5JsF
HyaR9j8gSUl8VsAE/clU8iFZZXn9J65PbY6qoUO5m1mSlGzcPXX2LAhRDYca/FmQ
0fOme+n9xgWNJL1N0bRzi/a6YkDDoQ==
=MEfY
-----END PGP SIGNATURE-----

--i8QqTccVgCjUBVoYvzshBkmgppDapRY4p--


