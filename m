Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513DEC10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 13:21:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 042002084C
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 13:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGqDO/d/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 042002084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41756 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDqgz-0000Ux-8z
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 09:21:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hDqee-0007Yf-BY
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 09:19:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hDqec-00005E-MU
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 09:19:12 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35967)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>)
	id 1hDqeY-0008TG-OF; Tue, 09 Apr 2019 09:19:07 -0400
Received: by mail-wm1-x344.google.com with SMTP id h18so3325958wml.1;
	Tue, 09 Apr 2019 06:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=h3h3zcTGljsr0Vvr776HFcNQ78prGsulgaMMqSuS+tk=;
	b=YGqDO/d/okkGxmgfN2OVmHNamkZ5hhgAJ1DM9BL49NzrmWyDG7t6NT05aMFqeAyEt2
	+ifxzXE9MORcYIZ1d04vKQeJ7+mPqQqOGCxhF2NQ1irZAAKBbgxLuSXf54V4ZZc/TYuI
	gy2BGaMYuGXUhgT49W7XqScmPxwws8L0dQXs/gDFXGU3Qkjr4zsQbBV5G4DgXQLg35Rr
	mwDQSwkjnj5mFm3p0taNN1JRwaovr9NzFHztmGyioEtUYSLQ5tY1lkGUYuuUMs6md9x0
	1Z2lNtSfU6B/sCEQv8kI7Qh4SxfFCEub5Ltd3Ta4FP3qrs5j2ZDb4N6tRn0Y31noOnzi
	l9Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=h3h3zcTGljsr0Vvr776HFcNQ78prGsulgaMMqSuS+tk=;
	b=ArfSHIFFqxpTns6mfqPI223EyW7oqMjZUssGQD0NYjeyGMaSGZc4+3Iosqgg7fLLRT
	0jakRxSAuhLJXcNOmGU4DN8IHSfaWuqfbEWQgb6VsIoea3UoK86HKcts5mr+3aHmLNlg
	5vl6Qa1IoendHIfG5lIZpMDpXKaXbLZdZUs9QQLxd58xYvA89hs8HaL8PC4XZl5di0Ob
	1bjQXP8hTE8f24apcZvcZwUeefrW0yEiItavMloegGXzSlaCvxOJNvPgMJHDqEm5BKOB
	Idix29I+cgsVJ4hbubht3BtZdrXlsc0OSq/CgTZxGUorLpbRM8gVm6ysAGpvCMcz36Ow
	yU3w==
X-Gm-Message-State: APjAAAV7l1JrjlZOl1Va+b2U9HzG4A/7URUBQckgDlFZseTUxDUPTtJ7
	JJJY9g1fnky1vHke9mCnZMI=
X-Google-Smtp-Source: APXvYqw32wILOyBtin64feTnwLY3fc8KmZZ1w4THpj9mVNXdBFGR0mH8fk0sWPCbayDvfY3t6zdaiw==
X-Received: by 2002:a1c:a9d4:: with SMTP id
	s203mr12561024wme.117.1554815945483; 
	Tue, 09 Apr 2019 06:19:05 -0700 (PDT)
Received: from localhost ([51.15.41.238]) by smtp.gmail.com with ESMTPSA id
	s12sm12338308wmj.42.2019.04.09.06.19.04
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 09 Apr 2019 06:19:04 -0700 (PDT)
Date: Tue, 9 Apr 2019 14:19:03 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Kenneth Heitke <kenneth.heitke@intel.com>
Message-ID: <20190409131903.GF16944@stefanha-x1.localdomain>
References: <20190405214117.1850-1-kenneth.heitke@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ULyIDA2m8JTe+TiX"
Content-Disposition: inline
In-Reply-To: <20190405214117.1850-1-kenneth.heitke@intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] nvme: add Get/Set Feature
 Timestamp support
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
	mlevitsk@redhat.com, keith.busch@intel.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409131903.eIVYkBiB4jXuXS0YKBDB0yYNIzUc42PFUNeyph7fkZM@z>


--ULyIDA2m8JTe+TiX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2019 at 03:41:17PM -0600, Kenneth Heitke wrote:
> Signed-off-by: Kenneth Heitke <kenneth.heitke@intel.com>
> ---
>  hw/block/nvme.c       | 120 +++++++++++++++++++++++++++++++++++++++++-
>  hw/block/nvme.h       |   3 ++
>  hw/block/trace-events |   2 +
>  include/block/nvme.h  |   2 +
>  4 files changed, 125 insertions(+), 2 deletions(-)

CCing Maxim Levitsky <mlevitsk@redhat.com>, who is also working on NVMe
emulation at the moment.

>=20
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 7caf92532a..e775e89299 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -219,6 +219,30 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIO=
Vector *iov, uint64_t prp1,
>      return NVME_INVALID_FIELD | NVME_DNR;
>  }
> =20
> +static uint16_t nvme_dma_write_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t l=
en,
> +                                   uint64_t prp1, uint64_t prp2)
> +{
> +    QEMUSGList qsg;
> +    QEMUIOVector iov;
> +    uint16_t status =3D NVME_SUCCESS;
> +
> +    if (nvme_map_prp(&qsg, &iov, prp1, prp2, len, n)) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +    if (qsg.nsg > 0) {
> +        if (dma_buf_write(ptr, len, &qsg)) {
> +            status =3D NVME_INVALID_FIELD | NVME_DNR;
> +        }
> +        qemu_sglist_destroy(&qsg);
> +    } else {
> +        if (qemu_iovec_from_buf(&iov, 0, ptr, len) !=3D len) {
> +            status =3D NVME_INVALID_FIELD | NVME_DNR;
> +        }
> +        qemu_iovec_destroy(&iov);
> +    }
> +    return status;
> +}
> +
>  static uint16_t nvme_dma_read_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t le=
n,
>      uint64_t prp1, uint64_t prp2)
>  {
> @@ -678,7 +702,6 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, Nvm=
eIdentify *c)
>      return ret;
>  }
> =20
> -
>  static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd)
>  {
>      NvmeIdentify *c =3D (NvmeIdentify *)cmd;
> @@ -696,6 +719,63 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *=
cmd)
>      }
>  }
> =20
> +static inline void nvme_set_timestamp(NvmeCtrl *n, uint64_t ts)
> +{
> +    n->host_timestamp =3D ts;
> +    n->timestamp_set_qemu_clock_ms =3D qemu_clock_get_ms(QEMU_CLOCK_REAL=
TIME);
> +}
> +
> +static inline uint64_t nvme_get_timestamp(const NvmeCtrl *n)
> +{
> +    uint64_t current_time =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> +    uint64_t elapsed_time =3D current_time - n->timestamp_set_qemu_clock=
_ms;
> +
> +    union nvme_timestamp {
> +        struct {
> +            uint64_t timestamp:48;
> +            uint64_t sync:1;
> +            uint64_t origin:3;
> +            uint64_t rsvd1:12;
> +        };
> +        uint64_t all;
> +    };
> +
> +    union nvme_timestamp ts;
> +    ts.all =3D 0;
> +
> +    /*
> +     * If the sum of the Timestamp value set by the host and the elapsed
> +     * time exceeds 2^48, the value returned should be reduced modulo 2^=
48.
> +     */
> +    ts.timestamp =3D (n->host_timestamp + elapsed_time) & 0xffffffffffff;
> +
> +    /* If the host timestamp is non-zero, set the timestamp origin */
> +    ts.origin =3D n->host_timestamp ? 0x01 : 0x00;
> +
> +    return ts.all;
> +}
> +
> +static uint16_t nvme_get_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd)
> +{
> +    uint32_t dw10 =3D le32_to_cpu(cmd->cdw10);
> +    uint64_t prp1 =3D le64_to_cpu(cmd->prp1);
> +    uint64_t prp2 =3D le64_to_cpu(cmd->prp2);
> +
> +    uint64_t timestamp =3D nvme_get_timestamp(n);
> +
> +    if (!(n->oncs & NVME_ONCS_TIMESTAMP)) {
> +        trace_nvme_err_invalid_getfeat(dw10);
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
> +    trace_nvme_getfeat_timestamp(timestamp);
> +
> +    timestamp =3D cpu_to_le64(timestamp);
> +
> +    return nvme_dma_read_prp(n, (uint8_t *)&timestamp,
> +                                 sizeof(timestamp), prp1, prp2);
> +}
> +
>  static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest =
*req)
>  {
>      uint32_t dw10 =3D le32_to_cpu(cmd->cdw10);
> @@ -710,6 +790,9 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd=
 *cmd, NvmeRequest *req)
>          result =3D cpu_to_le32((n->num_queues - 2) | ((n->num_queues - 2=
) << 16));
>          trace_nvme_getfeat_numq(result);
>          break;
> +    case NVME_TIMESTAMP:
> +        return nvme_get_feature_timestamp(n, cmd);
> +        break;
>      default:
>          trace_nvme_err_invalid_getfeat(dw10);
>          return NVME_INVALID_FIELD | NVME_DNR;
> @@ -719,6 +802,31 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCm=
d *cmd, NvmeRequest *req)
>      return NVME_SUCCESS;
>  }
> =20
> +static uint16_t nvme_set_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd)
> +{
> +    uint16_t ret;
> +    uint64_t timestamp;
> +    uint32_t dw10 =3D le32_to_cpu(cmd->cdw10);
> +    uint64_t prp1 =3D le64_to_cpu(cmd->prp1);
> +    uint64_t prp2 =3D le64_to_cpu(cmd->prp2);
> +
> +    if (!(n->oncs & NVME_ONCS_TIMESTAMP)) {
> +        trace_nvme_err_invalid_setfeat(dw10);
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
> +    ret =3D nvme_dma_write_prp(n, (uint8_t *)&timestamp,
> +                                sizeof(timestamp), prp1, prp2);
> +    if (ret !=3D NVME_SUCCESS) {
> +        return ret;
> +    }
> +
> +    nvme_set_timestamp(n, le64_to_cpu(timestamp));
> +    trace_nvme_setfeat_timestamp(timestamp);
> +
> +    return NVME_SUCCESS;
> +}
> +
>  static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest =
*req)
>  {
>      uint32_t dw10 =3D le32_to_cpu(cmd->cdw10);
> @@ -735,6 +843,11 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCm=
d *cmd, NvmeRequest *req)
>          req->cqe.result =3D
>              cpu_to_le32((n->num_queues - 2) | ((n->num_queues - 2) << 16=
));
>          break;
> +
> +    case NVME_TIMESTAMP:
> +        return nvme_set_feature_timestamp(n, cmd);
> +        break;
> +
>      default:
>          trace_nvme_err_invalid_setfeat(dw10);
>          return NVME_INVALID_FIELD | NVME_DNR;
> @@ -907,6 +1020,8 @@ static int nvme_start_ctrl(NvmeCtrl *n)
>      nvme_init_sq(&n->admin_sq, n, n->bar.asq, 0, 0,
>          NVME_AQA_ASQS(n->bar.aqa) + 1);
> =20
> +    nvme_set_timestamp(n, 0ULL);
> +
>      return 0;
>  }
> =20
> @@ -1270,7 +1385,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error =
**errp)
>      id->sqes =3D (0x6 << 4) | 0x6;
>      id->cqes =3D (0x4 << 4) | 0x4;
>      id->nn =3D cpu_to_le32(n->num_namespaces);
> -    id->oncs =3D cpu_to_le16(NVME_ONCS_WRITE_ZEROS);
> +    id->oncs =3D cpu_to_le16(n->oncs);
>      id->psd[0].mp =3D cpu_to_le16(0x9c4);
>      id->psd[0].enlat =3D cpu_to_le32(0x10);
>      id->psd[0].exlat =3D cpu_to_le32(0x4);
> @@ -1350,6 +1465,7 @@ static Property nvme_props[] =3D {
>      DEFINE_PROP_STRING("serial", NvmeCtrl, serial),
>      DEFINE_PROP_UINT32("cmb_size_mb", NvmeCtrl, cmb_size_mb, 0),
>      DEFINE_PROP_UINT32("num_queues", NvmeCtrl, num_queues, 64),
> +    DEFINE_PROP_UINT16("oncs", NvmeCtrl, oncs, NVME_ONCS_WRITE_ZEROS),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index 56c9d4b4b1..d7277e72b7 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -69,6 +69,7 @@ typedef struct NvmeCtrl {
>      uint16_t    max_prp_ents;
>      uint16_t    cqe_size;
>      uint16_t    sqe_size;
> +    uint16_t    oncs;
>      uint32_t    reg_size;
>      uint32_t    num_namespaces;
>      uint32_t    num_queues;
> @@ -79,6 +80,8 @@ typedef struct NvmeCtrl {
>      uint32_t    cmbloc;
>      uint8_t     *cmbuf;
>      uint64_t    irq_status;
> +    uint64_t    host_timestamp;                 /* Timestamp sent by the=
 host */
> +    uint64_t    timestamp_set_qemu_clock_ms;    /* QEMU clock time */
> =20
>      char            *serial;
>      NvmeNamespace   *namespaces;
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index b92039a573..97a17838ed 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -46,6 +46,8 @@ nvme_identify_nslist(uint16_t ns) "identify namespace l=
ist, nsid=3D%"PRIu16""
>  nvme_getfeat_vwcache(const char* result) "get feature volatile write cac=
he, result=3D%s"
>  nvme_getfeat_numq(int result) "get feature number of queues, result=3D%d"
>  nvme_setfeat_numq(int reqcq, int reqsq, int gotcq, int gotsq) "requested=
 cq_count=3D%d sq_count=3D%d, responding with cq_count=3D%d sq_count=3D%d"
> +nvme_setfeat_timestamp(uint64_t ts) "set feature timestamp =3D 0x%"PRIx6=
4""
> +nvme_getfeat_timestamp(uint64_t ts) "get feature timestamp =3D 0x%"PRIx6=
4""
>  nvme_mmio_intm_set(uint64_t data, uint64_t new_mask) "wrote MMIO, interr=
upt mask set, data=3D0x%"PRIx64", new_mask=3D0x%"PRIx64""
>  nvme_mmio_intm_clr(uint64_t data, uint64_t new_mask) "wrote MMIO, interr=
upt mask clr, data=3D0x%"PRIx64", new_mask=3D0x%"PRIx64""
>  nvme_mmio_cfg(uint64_t data) "wrote MMIO, config controller config=3D0x%=
"PRIx64""
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index 849a6f3fa3..3ec8efcc43 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -581,6 +581,7 @@ enum NvmeIdCtrlOncs {
>      NVME_ONCS_WRITE_ZEROS   =3D 1 << 3,
>      NVME_ONCS_FEATURES      =3D 1 << 4,
>      NVME_ONCS_RESRVATIONS   =3D 1 << 5,
> +    NVME_ONCS_TIMESTAMP     =3D 1 << 6,
>  };
> =20
>  #define NVME_CTRL_SQES_MIN(sqes) ((sqes) & 0xf)
> @@ -622,6 +623,7 @@ enum NvmeFeatureIds {
>      NVME_INTERRUPT_VECTOR_CONF      =3D 0x9,
>      NVME_WRITE_ATOMICITY            =3D 0xa,
>      NVME_ASYNCHRONOUS_EVENT_CONF    =3D 0xb,
> +    NVME_TIMESTAMP                  =3D 0xe,
>      NVME_SOFTWARE_PROGRESS_MARKER   =3D 0x80
>  };
> =20
> --=20
> 2.17.1
>=20
>=20

--ULyIDA2m8JTe+TiX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcrJvHAAoJEJykq7OBq3PICUEIAIp+Am370RDa+6eQhvHYfOWO
wbR5m0yrZdogyiJCJN/kUBrOJGvi2ZeKe1XaMz2+/JzF7JVhgrW6IpsazZRkf6YA
szwToxJ7eaiBqsOIi5ElvuiH4tNrYCphLVuc+0LENr3AwEwC7vE+CQLfOKcZlWX6
SRLXB1iAmpHytK9sYVitw9n2buZ5yeto+pi1GNx0pA9M2abRmIgR8YFq5ks/4xUA
j1uc/6CJ+tJzHaYFJQ8UBj2/foQj/xCF+LoFsjdWZCGhhp+xb6ZDiYAJ0zOEZGDh
/+OGDv2b3KLhwiQ4YZ1Q7GQiRbNEF/HKDJ+rOEdd6WsFOFlKZ/aylTFbO7taW04=
=ESYZ
-----END PGP SIGNATURE-----

--ULyIDA2m8JTe+TiX--

