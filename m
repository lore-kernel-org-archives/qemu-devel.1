Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410A8C4649B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 13:35:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1839321850
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 13:35:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1839321850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjOMv-0002CN-7B
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 09:35:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38642)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hjOLS-0001cu-Fu
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 09:33:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hjOLP-0000Od-9X
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 09:33:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59746)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hjOLL-0008Ib-Gn; Fri, 05 Jul 2019 09:33:39 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 712FD30C543D;
 Fri,  5 Jul 2019 13:33:36 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-154.brq.redhat.com
 [10.40.204.154])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A42817257;
 Fri,  5 Jul 2019 13:33:32 +0000 (UTC)
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20190703155944.9637-1-mlevitsk@redhat.com>
 <20190703155944.9637-6-mlevitsk@redhat.com>
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
Message-ID: <eb7d7240-ec4e-f0d8-2910-261ffe0a1092@redhat.com>
Date: Fri, 5 Jul 2019 15:33:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190703155944.9637-6-mlevitsk@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XUR1N0c8fsjDTCioCYy8kYoSGDwJrWwrd"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Fri, 05 Jul 2019 13:33:36 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 5/6] block/nvme: add support for write
 zeros
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
--XUR1N0c8fsjDTCioCYy8kYoSGDwJrWwrd
Content-Type: multipart/mixed; boundary="Pd7RxI7Qdwy5knpcb70yYR2CsTfiBeAMC";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org
Message-ID: <eb7d7240-ec4e-f0d8-2910-261ffe0a1092@redhat.com>
Subject: Re: [PATCH v3 5/6] block/nvme: add support for write zeros
References: <20190703155944.9637-1-mlevitsk@redhat.com>
 <20190703155944.9637-6-mlevitsk@redhat.com>
In-Reply-To: <20190703155944.9637-6-mlevitsk@redhat.com>

--Pd7RxI7Qdwy5knpcb70yYR2CsTfiBeAMC
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03.07.19 17:59, Maxim Levitsky wrote:
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  block/nvme.c         | 69 +++++++++++++++++++++++++++++++++++++++++++-=

>  block/trace-events   |  1 +
>  include/block/nvme.h | 19 +++++++++++-
>  3 files changed, 87 insertions(+), 2 deletions(-)
>=20
> diff --git a/block/nvme.c b/block/nvme.c
> index 152d27b07f..02e0846643 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c

[...]

> @@ -469,6 +473,11 @@ static void nvme_identify(BlockDriverState *bs, in=
t namespace, Error **errp)
>      s->nsze =3D le64_to_cpu(idns->nsze);
>      lbaf =3D &idns->lbaf[NVME_ID_NS_FLBAS_INDEX(idns->flbas)];
> =20
> +    if (NVME_ID_NS_DLFEAT_WRITE_ZEROS(idns->dlfeat) &&
> +            NVME_ID_NS_DLFEAT_READ_BEHAVIOR(idns->dlfeat) =3D=3D
> +                    NVME_ID_NS_DLFEAT_READ_BEHAVIOR_ZEROS)
> +        bs->supported_write_flags |=3D BDRV_REQ_MAY_UNMAP;
> +

This violates the coding style, there should be curly brackets here.

>      if (lbaf->ms) {
>          error_setg(errp, "Namespaces with metadata are not yet support=
ed");
>          goto out;
> @@ -763,6 +772,8 @@ static int nvme_file_open(BlockDriverState *bs, QDi=
ct *options, int flags,
>      int ret;
>      BDRVNVMeState *s =3D bs->opaque;
> =20
> +    bs->supported_write_flags =3D BDRV_REQ_FUA;
> +
>      opts =3D qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
>      qemu_opts_absorb_qdict(opts, options, &error_abort);
>      device =3D qemu_opt_get(opts, NVME_BLOCK_OPT_DEVICE);
> @@ -791,7 +802,6 @@ static int nvme_file_open(BlockDriverState *bs, QDi=
ct *options, int flags,
>              goto fail;
>          }
>      }
> -    bs->supported_write_flags =3D BDRV_REQ_FUA;

Any reason for this movement?

>      return 0;
>  fail:
>      nvme_close(bs);
> @@ -1085,6 +1095,60 @@ static coroutine_fn int nvme_co_flush(BlockDrive=
rState *bs)
>  }
> =20
> =20
> +static coroutine_fn int nvme_co_pwrite_zeroes(BlockDriverState *bs,
> +                                              int64_t offset,
> +                                              int bytes,
> +                                              BdrvRequestFlags flags)
> +{
> +    BDRVNVMeState *s =3D bs->opaque;
> +    NVMeQueuePair *ioq =3D s->queues[1];
> +    NVMeRequest *req;
> +
> +    if (!s->supports_write_zeros) {
> +        return -ENOTSUP;
> +    }
> +
> +    uint32_t cdw12 =3D ((bytes >> s->blkshift) - 1) & 0xFFFF;

Another coding style violation: Variable declarations and other code may
not be mixed.

> +
> +    NvmeCmd cmd =3D {
> +        .opcode =3D NVME_CMD_WRITE_ZEROS,
> +        .nsid =3D cpu_to_le32(s->nsid),
> +        .cdw10 =3D cpu_to_le32((offset >> s->blkshift) & 0xFFFFFFFF),
> +        .cdw11 =3D cpu_to_le32(((offset >> s->blkshift) >> 32) & 0xFFF=
FFFFF),
> +    };
> +
> +    NVMeCoData data =3D {
> +        .ctx =3D bdrv_get_aio_context(bs),
> +        .ret =3D -EINPROGRESS,
> +    };

[...]

> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index 3ec8efcc43..65eb65c740 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -653,12 +653,29 @@ typedef struct NvmeIdNs {
>      uint8_t     mc;
>      uint8_t     dpc;
>      uint8_t     dps;
> -    uint8_t     res30[98];
> +
> +    uint8_t     nmic;
> +    uint8_t     rescap;
> +    uint8_t     fpi;
> +    uint8_t     dlfeat;
> +
> +    uint8_t     res30[94];
>      NvmeLBAF    lbaf[16];
>      uint8_t     res192[192];
>      uint8_t     vs[3712];
>  } NvmeIdNs;
> =20
> +
> +/*Deallocate Logical Block Features*/
> +#define NVME_ID_NS_DLFEAT_GUARD_CRC(dlfeat)       ((dlfeat) & 0x10)
> +#define NVME_ID_NS_DLFEAT_WRITE_ZEROS(dlfeat)     ((dlfeat) & 0x04)

Isn=E2=80=99t it bit 3, i.e. 0x08?

Max

> +
> +#define NVME_ID_NS_DLFEAT_READ_BEHAVIOR(dlfeat)     ((dlfeat) & 0x3)
> +#define NVME_ID_NS_DLFEAT_READ_BEHAVIOR_UNDEFINED   0
> +#define NVME_ID_NS_DLFEAT_READ_BEHAVIOR_ZEROS       1
> +#define NVME_ID_NS_DLFEAT_READ_BEHAVIOR_ONES        2
> +
> +
>  #define NVME_ID_NS_NSFEAT_THIN(nsfeat)      ((nsfeat & 0x1))
>  #define NVME_ID_NS_FLBAS_EXTENDED(flbas)    ((flbas >> 4) & 0x1)
>  #define NVME_ID_NS_FLBAS_INDEX(flbas)       ((flbas & 0xf))
>=20



--Pd7RxI7Qdwy5knpcb70yYR2CsTfiBeAMC--

--XUR1N0c8fsjDTCioCYy8kYoSGDwJrWwrd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0fUaoACgkQ9AfbAGHV
z0Akpwf+KXvIlgLRpFaq2gCwbJfrfl3IU+GMrf7vUm3S/Z1WT2JW4F4A0y8mYHhV
cER5hwXmagLgIc2Q93rjtqdSkiI2z2ZlvZs2oslT3JkMet8EEdiYzBazswj1vy7K
MlX0Z0Xt/gNmwIBzm0R3kqJPkdbEZe9wNJw8Y5gTjWgx/b6N2bA9d9QlXpf/alt0
Tfv0SwF+gDrZ36VcVMxgmVY+oI6nBalXHwB3AVecXCGqoOjVafJA8ITT54oOX/JB
aHessHbtAICTneeytJi/Apd50MffK97VK5ZFdo/ju+8CifVCQuOxMxToRuKz7svy
Y1o4aDo617NpX7CS4e0mCbNb9RmbEw==
=NRRO
-----END PGP SIGNATURE-----

--XUR1N0c8fsjDTCioCYy8kYoSGDwJrWwrd--

