Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B87C4649B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 11:59:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06E3A218CA
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 11:59:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06E3A218CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjMsR-0006KU-CZ
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 07:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46521)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hjMrB-00053A-JP
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 07:58:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hjMr9-0007jU-Fz
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 07:58:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32928)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hjMr5-0007RG-E2; Fri, 05 Jul 2019 07:58:19 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 872933082DD3;
 Fri,  5 Jul 2019 11:58:18 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-154.brq.redhat.com
 [10.40.204.154])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C1B511001B23;
 Fri,  5 Jul 2019 11:58:11 +0000 (UTC)
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20190703155944.9637-1-mlevitsk@redhat.com>
 <20190703155944.9637-4-mlevitsk@redhat.com>
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
Message-ID: <e405b915-b333-936d-7c4a-8b6024c1e189@redhat.com>
Date: Fri, 5 Jul 2019 13:58:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190703155944.9637-4-mlevitsk@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WoQhDNCKs2zBkXps3xNzYYL24VSrqNcQg"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Fri, 05 Jul 2019 11:58:18 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 3/6] block/nvme: support larger that 512
 bytes sector devices
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WoQhDNCKs2zBkXps3xNzYYL24VSrqNcQg
Content-Type: multipart/mixed; boundary="nRsFRlaRDZEDP62tuGl0f59cXNS6StqtB";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org
Message-ID: <e405b915-b333-936d-7c4a-8b6024c1e189@redhat.com>
Subject: Re: [PATCH v3 3/6] block/nvme: support larger that 512 bytes sector
 devices
References: <20190703155944.9637-1-mlevitsk@redhat.com>
 <20190703155944.9637-4-mlevitsk@redhat.com>
In-Reply-To: <20190703155944.9637-4-mlevitsk@redhat.com>

--nRsFRlaRDZEDP62tuGl0f59cXNS6StqtB
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03.07.19 17:59, Maxim Levitsky wrote:
> Currently the driver hardcodes the sector size to 512,
> and doesn't check the underlying device. Fix that.
>=20
> Also fail if underlying nvme device is formatted with metadata
> as this needs special support.
>=20
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  block/nvme.c | 45 ++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 40 insertions(+), 5 deletions(-)
>=20
> diff --git a/block/nvme.c b/block/nvme.c
> index 52798081b2..1f0d09349f 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c

[...]

> @@ -463,7 +467,22 @@ static void nvme_identify(BlockDriverState *bs, in=
t namespace, Error **errp)
>      }
> =20
>      s->nsze =3D le64_to_cpu(idns->nsze);
> +    lbaf =3D &idns->lbaf[NVME_ID_NS_FLBAS_INDEX(idns->flbas)];
> +
> +    if (lbaf->ms) {
> +        error_setg(errp, "Namespaces with metadata are not yet support=
ed");
> +        goto out;
> +    }
> +
> +    hwsect_size =3D 1 << lbaf->ds;
> +
> +    if (hwsect_size < BDRV_SECTOR_BITS || hwsect_size > s->page_size) =
{

s/BDRV_SECTOR_BITS/BDRV_SECTOR_SIZE/

> +        error_setg(errp, "Namespace has unsupported block size (%d)",
> +                hwsect_size);
> +        goto out;
> +    }
> =20
> +    s->blkshift =3D lbaf->ds;
>  out:
>      qemu_vfio_dma_unmap(s->vfio, resp);
>      qemu_vfree(resp);
> @@ -782,8 +801,22 @@ fail:
>  static int64_t nvme_getlength(BlockDriverState *bs)
>  {
>      BDRVNVMeState *s =3D bs->opaque;
> +    return s->nsze << s->blkshift;
> +}
> =20
> -    return s->nsze << BDRV_SECTOR_BITS;
> +static int64_t nvme_get_blocksize(BlockDriverState *bs)
> +{
> +    BDRVNVMeState *s =3D bs->opaque;
> +    assert(s->blkshift >=3D 9);

I think BDRV_SECTOR_BITS is more correct here (this is about what the
general block layer code expects).  Also, there=E2=80=99s no pain in doin=
g so,
as you did check against BDRV_SECTOR_SIZE in nvme_identify().

Max

> +    return 1 << s->blkshift;
> +}
> +
> +static int nvme_probe_blocksizes(BlockDriverState *bs, BlockSizes *bsz=
)
> +{
> +    int64_t blocksize =3D nvme_get_blocksize(bs);
> +    bsz->phys =3D blocksize;
> +    bsz->log =3D blocksize;
> +    return 0;
>  }
> =20
>  /* Called with s->dma_map_lock */


--nRsFRlaRDZEDP62tuGl0f59cXNS6StqtB--

--WoQhDNCKs2zBkXps3xNzYYL24VSrqNcQg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0fO08ACgkQ9AfbAGHV
z0BmhQf6A7NMzNXbjEIDa99n46D9xluyh2jYRdGIXEkbBgRDknqnsZLbAzz0sNO1
NwBreDCp/cqi0elo8+Ob3dnApoC6YFtoWIpOBhEB7CwvRo3kmrvMs7xN3EsOr+TX
fi18v7gY3U8jdpIhwc4X213GK03SgX5iupsneHW1YCeYy0eZep63FUz4MUrkHJWE
/upTz5TjDQO8U/9iBLJbQ99qQWHTbPvrc6uUzBg22JVnsnbkqZAvKof/LFnIESnc
LDpfBWgqOj3nIKU4vlwPpR20a4ROHVx+cxcGbC4WZFH9SSn+S6niGW9OGCbdt2xu
Brg0EUhgNQyMe+aro9LTxHh6+hyYkQ==
=zO7c
-----END PGP SIGNATURE-----

--WoQhDNCKs2zBkXps3xNzYYL24VSrqNcQg--

