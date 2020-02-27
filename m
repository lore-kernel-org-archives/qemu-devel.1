Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBD2C3F350
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 14:22:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E1FB24697
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 14:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aawlvpm6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E1FB24697
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7K3g-0005xN-Jq
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 09:22:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45631)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j7K2r-0005Sw-1E
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:21:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j7K2q-00037u-15
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:21:44 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27412
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j7K2p-00036D-SA
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:21:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582813303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/PbzdCbbsWWyfAQTsaW2xRaW+aSTLXV2mg5+IMW9IcU=;
 b=Aawlvpm6oFQU7OVhIvMacqkS3MA71VxNmpqljWhwmuK+/lLrRLpsoqwjH6p/h/xPr6awZj
 WDDOoqRvpHhnHBJToziOjoP8JO6UJA8WXvJDYODSrR3CYn1VRcRHG3UTNaz/r6wiYl2pUb
 6cu76np1roNQsurte16Pd5mYn5ucXws=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-M7jlV507MsiJHfjjP4148Q-1; Thu, 27 Feb 2020 09:21:41 -0500
X-MC-Unique: M7jlV507MsiJHfjjP4148Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2219107ACC4;
 Thu, 27 Feb 2020 14:21:39 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D07F084779;
 Thu, 27 Feb 2020 14:21:38 +0000 (UTC)
Subject: Re: [PATCH v6 6/9] iotests: use python logging for iotests.log()
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200227000639.9644-1-jsnow@redhat.com>
 <20200227000639.9644-7-jsnow@redhat.com>
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
Message-ID: <302f1aa1-c880-4c2d-4612-902eff6004a3@redhat.com>
Date: Thu, 27 Feb 2020 15:21:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200227000639.9644-7-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="C0vaKJfzmKXrEBu3owLK8I1oU6XhwHWh7"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--C0vaKJfzmKXrEBu3owLK8I1oU6XhwHWh7
Content-Type: multipart/mixed; boundary="l9OXT5i6zV0K1YSU1sjK6H3An070qTQvN"

--l9OXT5i6zV0K1YSU1sjK6H3An070qTQvN
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 27.02.20 01:06, John Snow wrote:
> We can turn logging on/off globally instead of per-function.
>=20
> Remove use_log from run_job, and use python logging to turn on
> diffable output when we run through a script entry point.
>=20
> iotest 245 changes output order due to buffering reasons.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  tests/qemu-iotests/030        |  4 +--
>  tests/qemu-iotests/245        |  1 +
>  tests/qemu-iotests/245.out    | 24 ++++++++---------
>  tests/qemu-iotests/iotests.py | 50 +++++++++++++++++++++--------------
>  4 files changed, 45 insertions(+), 34 deletions(-)

[...]

> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
> index b02d7932fa..60c4c7f736 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -35,6 +35,14 @@
> =20
>  assert sys.version_info >=3D (3, 6)
> =20
> +# Use this logger for logging messages directly from the iotests module
> +logger =3D logging.getLogger('qemu.iotests')
> +logger.addHandler(logging.NullHandler())

Hm, I never see another handler added to this, so how can these messages
actually be printed?  Will enabling debug mode somehow make all loggers
print everything?

> +# Use this logger for messages that ought to be used for diff output.
> +test_logger =3D logging.getLogger('qemu.iotests.diff_io')

Also, why does logger get a null handler and this by default does not?
I=E2=80=99m asking because test_logger makes it look like you don=E2=80=99t=
 necessarily
need a handler for output to be silently discarded.

Max

>  # This will not work if arguments contain spaces but is necessary if we
>  # want to support the override options that ./check supports.
>  qemu_img_args =3D [os.environ.get('QEMU_IMG_PROG', 'qemu-img')]


--l9OXT5i6zV0K1YSU1sjK6H3An070qTQvN--

--C0vaKJfzmKXrEBu3owLK8I1oU6XhwHWh7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl5X0HEACgkQ9AfbAGHV
z0AxBAf+MYJGJf15ftl+XBL2CSn1Wjqh8JIK9avgsKzypkB+eDJI/Otox4nFeYzX
lMe0WBtBS6CmOOiRjkENKNfg3XNU9eAyxv3WdBItVGk9qBFEk8vVsN6peCr2MTAX
AayniSGsIlJURVS5ynenZaO5EP4bEL8DciEEjqyLyE+ETKg6vtMuFw6tMLM2jFq2
72rMiSZWHgu2Gpo1dcbyjYxmOOdHQWt6bG282I9DNzEkPcsPsLrsF3dlOhgkvw+a
IVRI2dZ1Xflf8S9NzCngdRBfKNqyRsGQRSOumA8r8jhaKGC+24fABm8wd7mBsz/E
pOOV7UIYiMkLAawKhZcsfu8EaPfQJg==
=Jr8z
-----END PGP SIGNATURE-----

--C0vaKJfzmKXrEBu3owLK8I1oU6XhwHWh7--


