Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B68C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 09:00:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDA80206C2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 09:00:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDA80206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHlLy-0002YM-T2
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 05:00:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59838)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iHlJ4-0008RA-AD
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 04:57:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iHlJ3-0000mD-9L
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 04:57:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42394)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iHlJ0-0000gh-B5; Tue, 08 Oct 2019 04:57:18 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2D978308A9E0;
 Tue,  8 Oct 2019 08:57:17 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.207])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C7B25C1D4;
 Tue,  8 Oct 2019 08:57:15 +0000 (UTC)
Subject: Re: [PATCH] qemu-nbd: Document benefit of --pid-file
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20191007194840.29518-1-eblake@redhat.com>
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
Message-ID: <575a0bc2-a322-331e-a8ff-1ad360bb6613@redhat.com>
Date: Tue, 8 Oct 2019 10:57:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191007194840.29518-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="pLu8ifQhnhob9OKsU22wcXUhVMWHyDj5K"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Tue, 08 Oct 2019 08:57:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: vsementsov@virtuozzo.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pLu8ifQhnhob9OKsU22wcXUhVMWHyDj5K
Content-Type: multipart/mixed; boundary="16L7JWCl1C8zwUPbR8Agf7sDVfYuDdlqk"

--16L7JWCl1C8zwUPbR8Agf7sDVfYuDdlqk
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07.10.19 21:48, Eric Blake wrote:
> One benefit of --pid-file is that it is easier to probe the file
> system to see if a pid file has been created than it is to probe if a
> socket is available for connection. Document that this is an
> intentional feature.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  qemu-nbd.texi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/qemu-nbd.texi b/qemu-nbd.texi
> index 7f55657722bd..d495bbe8a0ed 100644
> --- a/qemu-nbd.texi
> +++ b/qemu-nbd.texi
> @@ -118,7 +118,8 @@ in list mode.
>  @item --fork
>  Fork off the server process and exit the parent once the server is run=
ning.
>  @item --pid-file=3DPATH
> -Store the server's process ID in the given file.
> +Store the server's process ID in the given file.  The pid file is not
> +created until after the server socket is open.
>  @item --tls-authz=3DID
>  Specify the ID of a qauthz object previously created with the
>  --object option. This will be used to authorize connecting users

Well, not wrong, but at least most iotests do this by --fork and seeing
when the parent exits.  But I suppose:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--16L7JWCl1C8zwUPbR8Agf7sDVfYuDdlqk--

--pLu8ifQhnhob9OKsU22wcXUhVMWHyDj5K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2cT2oACgkQ9AfbAGHV
z0A5IQf7BKWkHBpMqxqTMzg4iSwF+71KNADQRmzfJnGLctxZaOk7IygwrEZ4lDde
Pco6E1D4PSm0z1oEs+Z5yAdVIqvRW+5bK5pCtsSCbjyitDTJURLCSUhdP7/1rulY
zLm+h8ItzBR+9i8akCoyc+Cvpx/xi5swNMlxInF+Ukb2moiCguuvk/hPW8Hsy5I6
+SQf/R09ZrVm1djW3dy2q4E2QTCr7+lDJ6UFkxxidkeaY8DDjvGu5PnZ/dq8w9i5
0Fi9ANQRqnEU1cAtrF8OhfzHq4UjFSH6m1xqYTKkaKv9uIcq7U/0s1bxZGnYgo0T
DdYCeV2xfXTqG/U6TiMq9Wk3ptjJ9A==
=Mddu
-----END PGP SIGNATURE-----

--pLu8ifQhnhob9OKsU22wcXUhVMWHyDj5K--

