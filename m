Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C873ECDE20
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 07:49:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D09B20CC7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 07:49:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D09B20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7xNe-0000D1-K0
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 03:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50377)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i7xMz-0007wl-TL
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 03:48:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i7xMy-0007bI-SR
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 03:48:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53916)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i7xMw-0007ZP-1a; Wed, 11 Sep 2019 03:48:50 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 996B510CC20E;
 Wed, 11 Sep 2019 07:48:48 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-94.ams2.redhat.com
 [10.36.116.94])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B8C1519C6A;
 Wed, 11 Sep 2019 07:48:46 +0000 (UTC)
To: Peter Lieven <pl@kamp.de>, qemu-block@nongnu.org
References: <20190910154110.6905-1-pl@kamp.de>
 <20190910154110.6905-3-pl@kamp.de>
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
Message-ID: <e2b37e13-ef22-4a16-38e5-3866e7d5409a@redhat.com>
Date: Wed, 11 Sep 2019 09:48:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190910154110.6905-3-pl@kamp.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="bYdyGRT1wEJQsJVA92iLlEMT6MGwTUJBl"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Wed, 11 Sep 2019 07:48:48 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH V2 2/2] block/nfs: add support for
 nfs_umount
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, ronniesahlberg@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bYdyGRT1wEJQsJVA92iLlEMT6MGwTUJBl
Content-Type: multipart/mixed; boundary="87V64ZhkR1UoYkAjlXrzAYfSfcufOVQZ6";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Peter Lieven <pl@kamp.de>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, ronniesahlberg@gmail.com
Message-ID: <e2b37e13-ef22-4a16-38e5-3866e7d5409a@redhat.com>
Subject: Re: [PATCH V2 2/2] block/nfs: add support for nfs_umount
References: <20190910154110.6905-1-pl@kamp.de>
 <20190910154110.6905-3-pl@kamp.de>
In-Reply-To: <20190910154110.6905-3-pl@kamp.de>

--87V64ZhkR1UoYkAjlXrzAYfSfcufOVQZ6
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10.09.19 17:41, Peter Lieven wrote:
> libnfs recently added support for unmounting. Add support
> in Qemu too.
>=20
> Signed-off-by: Peter Lieven <pl@kamp.de>
> ---
>  block/nfs.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/block/nfs.c b/block/nfs.c
> index 2c98508275..f39acfdb28 100644
> --- a/block/nfs.c
> +++ b/block/nfs.c
> @@ -398,6 +398,9 @@ static void nfs_client_close(NFSClient *client)
>              nfs_close(client->context, client->fh);
>              client->fh =3D NULL;
>          }
> +#ifdef LIBNFS_FEATURE_UMOUNT
> +        nfs_umount(client->context);
> +#endif
>          nfs_destroy_context(client->context);
>          client->context =3D NULL;
>      }

I don=E2=80=99t understand what unmounting means in this context.  Is it =
just
generic clean-up for NFSv3 (it appears that it=E2=80=99s a no-op for NFSv=
4)?
Why isn=E2=80=99t that done by nfs_destroy_context()?

Max


--87V64ZhkR1UoYkAjlXrzAYfSfcufOVQZ6--

--bYdyGRT1wEJQsJVA92iLlEMT6MGwTUJBl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl14ptwACgkQ9AfbAGHV
z0As5AgAum/FuD6XdSWI2RJCP4PBbds5VzjZNeoekwHdUc9Q3fVeIo2ptcFbrHSF
be0j05i1gxV1AoeeE8O4vRZHiG6ks04G0bAX74cVZockIhq1KRpc3O46POIt0/xZ
E6aC8uyUn4BFR4Tvosz/f8OqzI0/wEiN2ZeLr4Fa9U578bgW6jn1ZGdDeZeiMZrg
d4C51ZuY5Uut0MiOYW70UQ82pqGtKYxhXZtHJHdD6vkUlyQSxl85aFdwB0buYcCC
+jxYuSzxVpFAkwJCS8BZGl1KX7Y5194hYAYNyVrkl0/PFhrgxci1+0dFx8JiThc2
dKV1v2ox8lA+XHhDtIA95QqeeMlqxQ==
=EmJP
-----END PGP SIGNATURE-----

--bYdyGRT1wEJQsJVA92iLlEMT6MGwTUJBl--

