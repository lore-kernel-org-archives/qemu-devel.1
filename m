Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B32CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 14:41:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F0C921721
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 14:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X3o+LaRJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F0C921721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP6Ct-0006BB-9f
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 10:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41369)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iP6BA-0004E2-6M
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 10:39:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iP6B7-0002Cz-D0
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 10:39:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41648
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iP6B7-0002Bc-7J
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 10:39:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572273568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JOEaCZBWFlGnuKWmeO/5lq568I21ICDYRueR38soCuI=;
 b=X3o+LaRJ/sJgu23ZELQ/XI/4HgEcogH3lAvlJ7MaAex3bOE7SeYiSTVSN9tVd6H1SMDCTP
 JGKqVGlbZypjfuiB8tCXXnlJmDMUdCXAXlTliz04dFBKAR0zKSDpTgf3lznIrULubWw+kv
 yn9BbZ82bxGM4Oy5npoDvi+V6L4VeTk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-KR0kqCwFPM6ZujgJBiayTg-1; Mon, 28 Oct 2019 10:39:26 -0400
X-MC-Unique: KR0kqCwFPM6ZujgJBiayTg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA3285E4;
 Mon, 28 Oct 2019 14:39:25 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-83.ams2.redhat.com
 [10.36.117.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C6CFB10027A1;
 Mon, 28 Oct 2019 14:39:24 +0000 (UTC)
Subject: Re: [PATCH v2] qemu-img.texi: Describe data_file and data_file_raw
To: Han Han <hhan@redhat.com>, qemu-devel@nongnu.org
References: <20191021011421.24748-1-hhan@redhat.com>
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
Message-ID: <2beb5143-1ad6-14c4-d0d1-bd9f7aa429f5@redhat.com>
Date: Mon, 28 Oct 2019 15:39:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191021011421.24748-1-hhan@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="AxGdkiBMdLMUwB6HBqLr8D6ZQK2owcGWu"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AxGdkiBMdLMUwB6HBqLr8D6ZQK2owcGWu
Content-Type: multipart/mixed; boundary="2dFxeuxfgiQfCH56fbYdPPGnjk9cIajxO"

--2dFxeuxfgiQfCH56fbYdPPGnjk9cIajxO
Content-Type: text/plain; charset=WINDOWS-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 21.10.19 03:14, Han Han wrote:
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1763105
>=20
> Signed-off-by: Han Han <hhan@redhat.com>
> ---
>  qemu-img.texi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/qemu-img.texi b/qemu-img.texi
> index b5156d6316..983c6122f8 100644
> --- a/qemu-img.texi
> +++ b/qemu-img.texi
> @@ -763,6 +763,16 @@ file which is COW and has data blocks already, it co=
uldn't be changed to NOCOW
>  by setting @code{nocow=3Don}. One can issue @code{lsattr filename} to ch=
eck if
>  the NOCOW flag is set or not (Capital 'C' is NOCOW flag).

Usually, I try not to be pedantic about specific phrasing and the like,
but this is going in the man page, so I suppose I have to be.

> +@item data_file
> +File name of data file that is stored in the image and used as a default=
 for

This sounds a bit like the data file itself were stored in the image.

Also, I don=92t think the bit about this being a default is necessary
because several qcow2 creation options are in some way only defaults
than can be overridden at runtime (like lazy_refcounts or backing_file).
 So I don=92t think there is a need to make a mention of that here.

> +opening the image. If the option is used, qcow2 file only stores the met=
adata
> +for the image.

Maybe:

Path to a file in which to store all guest data.  If this option is
used, the qcow2 file will only contain the image's metadata.

> +
> +@item data_file_raw
> +This option requires @option{data_file}. If this option is set to @code{=
on},
> +qemu will always keep the external data file consistent as a standalone
> +read-only raw image. Default value is @code{off}.

For this paragraph OTOH I have absolutely no complaints. :-)

Max


--2dFxeuxfgiQfCH56fbYdPPGnjk9cIajxO--

--AxGdkiBMdLMUwB6HBqLr8D6ZQK2owcGWu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl22/ZsACgkQ9AfbAGHV
z0C8dgf8Dt5pcxszzUHuNXSTMK/2fFfM1ziAmr8+/C9swbTWdVHuhfFg9bKsgCI1
vj8BPReSqn6ttIrEsZfHdfRcWN3ugulYgVnwvIPRaL3+3neqwa7fadShWi4p29x8
x+mG4VWNMP2P27k/Xh+ZlKEmrZLOLbmbUgk06c1mqokj7K8730i42TgYyYsoI52S
cH3Y8J8HNWlPJbpiQddzXY/Fjpz59+BYzbKs+Py6JGCAsJncUQS6VmCBq+0t7MR4
/ll3e9xmQfm5ZnsXSmb9/W2Ktub79KoYsVj+YonZUOU1JbNFu69cXiqN/GhOlAJI
uPJ8627R4h23lyM97f1bl/4jOIYerw==
=nCiH
-----END PGP SIGNATURE-----

--AxGdkiBMdLMUwB6HBqLr8D6ZQK2owcGWu--


