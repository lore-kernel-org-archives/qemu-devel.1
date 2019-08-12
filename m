Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18CAC31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 18:17:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 731BC2067D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 18:17:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 731BC2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxEsV-0003Fj-T6
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 14:17:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41775)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hxEs1-0002lY-7v
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 14:16:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hxErz-00068E-Ai
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 14:16:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54052)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hxErw-00066p-OT; Mon, 12 Aug 2019 14:16:32 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 025F930622EB;
 Mon, 12 Aug 2019 18:16:32 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-161.brq.redhat.com
 [10.40.204.161])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6CA3526DD8;
 Mon, 12 Aug 2019 18:16:27 +0000 (UTC)
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-block@nongnu.org
References: <20190516143314.81302-1-anton.nefedov@virtuozzo.com>
 <20190516143314.81302-5-anton.nefedov@virtuozzo.com>
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
Message-ID: <b992ab09-af44-1be7-aab3-18ff1267f853@redhat.com>
Date: Mon, 12 Aug 2019 20:16:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190516143314.81302-5-anton.nefedov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8qzyd2oCAE05cIcwwcKpAD4qERxeo98wr"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Mon, 12 Aug 2019 18:16:32 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v8 4/9] ide: account UNMAP (TRIM) operations
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
 den@virtuozzo.com, qemu-devel@nongnu.org, pbonzini@redhat.com,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8qzyd2oCAE05cIcwwcKpAD4qERxeo98wr
Content-Type: multipart/mixed; boundary="5LbhVoPCyjbiNhMZFZcfJsh78f6ph8wlg";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jsnow@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, den@virtuozzo.com, berto@igalia.com,
 vsementsov@virtuozzo.com
Message-ID: <b992ab09-af44-1be7-aab3-18ff1267f853@redhat.com>
Subject: Re: [PATCH v8 4/9] ide: account UNMAP (TRIM) operations
References: <20190516143314.81302-1-anton.nefedov@virtuozzo.com>
 <20190516143314.81302-5-anton.nefedov@virtuozzo.com>
In-Reply-To: <20190516143314.81302-5-anton.nefedov@virtuozzo.com>

--5LbhVoPCyjbiNhMZFZcfJsh78f6ph8wlg
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 16.05.19 16:33, Anton Nefedov wrote:
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  hw/ide/core.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/hw/ide/core.c b/hw/ide/core.c
> index 6afadf894f..3a7ac93777 100644
> --- a/hw/ide/core.c
> +++ b/hw/ide/core.c
> @@ -441,6 +441,14 @@ static void ide_issue_trim_cb(void *opaque, int re=
t)
>      TrimAIOCB *iocb =3D opaque;
>      IDEState *s =3D iocb->s;
> =20
> +    if (iocb->i >=3D 0) {
> +        if (ret >=3D 0) {
> +            block_acct_done(blk_get_stats(s->blk), &s->acct);
> +        } else {
> +            block_acct_failed(blk_get_stats(s->blk), &s->acct);

Hmm, in other places (ide_handle_rw_error() here or
scsi_handle_rw_error() in scsi-disk) only report this with
BLOCK_ERROR_ACTION_REPORT.

So I=E2=80=99m wondering whether the same should be done here.

Max

> +        }
> +    }
> +
>      if (ret >=3D 0) {
>          while (iocb->j < iocb->qiov->niov) {
>              int j =3D iocb->j;
> @@ -458,10 +466,14 @@ static void ide_issue_trim_cb(void *opaque, int r=
et)
>                  }
> =20
>                  if (!ide_sect_range_ok(s, sector, count)) {
> +                    block_acct_invalid(blk_get_stats(s->blk), BLOCK_AC=
CT_UNMAP);
>                      iocb->ret =3D -EINVAL;
>                      goto done;
>                  }
> =20
> +                block_acct_start(blk_get_stats(s->blk), &s->acct,
> +                                 count << BDRV_SECTOR_BITS, BLOCK_ACCT=
_UNMAP);
> +
>                  /* Got an entry! Submit and exit.  */
>                  iocb->aiocb =3D blk_aio_pdiscard(s->blk,
>                                                 sector << BDRV_SECTOR_B=
ITS,
>=20



--5LbhVoPCyjbiNhMZFZcfJsh78f6ph8wlg--

--8qzyd2oCAE05cIcwwcKpAD4qERxeo98wr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1RrPkACgkQ9AfbAGHV
z0AfEAf6A/gyabEdCyoAuyTSiahz6vTYGOXi1djJOY0cBL5CCBEeTl4cDeToXkdV
xCfLdsfgJNDf3/TC0U0inSwf+tIwuWapxo97YzvBh0LHCtWBKE7qDi6KypI/E+ZH
ttHTs6hqRbCjBO/x8BhIqkid8/UC/1JIE/Rt7WfZW3ojpMGnORsftewCxeovftk2
AcFdUVwXHujMg4oBIqOo+o7cOd/iVyeRPccwgF6lrtuUHF+Vw7kUftcCKc2PZ+m0
V9JAz8txL7Ih1fE5Fg53sbjWR8MxvlLAZDzADv9A6hoVho/JR8zX4gPefBCnU6l0
3qEakr8Pog4sGweeDUuuj2dys+iLIQ==
=NDgq
-----END PGP SIGNATURE-----

--8qzyd2oCAE05cIcwwcKpAD4qERxeo98wr--

