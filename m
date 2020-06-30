Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807B4C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 22:22:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA9982072D
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 22:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFHHSt5I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA9982072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqOe1-00088B-KM
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 18:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jqOdP-0007cr-Eb; Tue, 30 Jun 2020 18:21:47 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:36530)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jqOdN-0002le-7f; Tue, 30 Jun 2020 18:21:47 -0400
Received: by mail-io1-xd44.google.com with SMTP id y2so22827171ioy.3;
 Tue, 30 Jun 2020 15:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=D3Mf0ZtuHRnnvn+6X+zmzY8hAsM8K5ntF295CpomEeU=;
 b=YFHHSt5I+hZryG36sQu8tnk4dsczVRn03GxD0O2e5cIgY9iBRFKyE4oHQGxcYGzX2x
 rk6k8oqIKuTdAFS2J5f650GkhHxob5assEuaIZ1GUWOge/Pxa8rA9CDOQXxXjySYh9Hw
 XP+t8hI35QHopCgNiUwj338NrB4UlHKK6xScanb6g7Yw6N/VvppgzbQjLwK3nxKZNuI3
 3k81jnHnDSGdeIusgjS8yMuIxRZkruvdqcQ8Bky5SQ+P4R99/1z/qgAc5VXSDRutFjwj
 1hraksvXVX3gTDCcLMZq8ioGkEXuinbEiIRG3lWxvFa0NWVIT2P7oneTlDwvZBAOKXcH
 qeZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=D3Mf0ZtuHRnnvn+6X+zmzY8hAsM8K5ntF295CpomEeU=;
 b=BUIrMkBic16oDg9E8BSeigxqj3R5FF3at5PWitfMKHcVfkWkoHVBaMR0L/QEzwbvUW
 7ynlNuPJINfd3ayjDFB6N9/MherFgNWa/AQIdMw9qgbstjsCIYol/PbwGXtt8sBJXjoZ
 ie1PVe5l5k8cJd7D4gs3HKq9EFZ3MC1jMMeoz4IdThjGZPr1Nw2acXPBN7O97D+qKndK
 kHXmGkRmrdGn47Wu+ePXY8N0meyuxU9f7XWWQemkS7nR9yuerBvF84Qde9UfgfMX8IGx
 cWC+fjbWyamMwV6Jf5WD9+W25vKKSJmqQl0QGzyGY11a1xmW4ZQ7vsg6LY6ppaDvh/LG
 ih1w==
X-Gm-Message-State: AOAM530rnZ9m9NP056/DLlaxb/QtRAaDaH2edAgREBx3x2KA7EfVKxzo
 2bW1MUcSfB0LUW8qLrF4huTYcVFANgMwJ12VLkY=
X-Google-Smtp-Source: ABdhPJytv5vUDk8BZtyXiMagZHBG5uJTIXncPBVUNgTvv63mq17IlndzEedk8zbfm4zjQco8iF93Nu2+vSegi9zRntw=
X-Received: by 2002:a5d:9ed0:: with SMTP id a16mr16349959ioe.176.1593555703444; 
 Tue, 30 Jun 2020 15:21:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200617213415.22417-1-dmitry.fomichev@wdc.com>
 <20200617213415.22417-9-dmitry.fomichev@wdc.com>
In-Reply-To: <20200617213415.22417-9-dmitry.fomichev@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 30 Jun 2020 15:11:59 -0700
Message-ID: <CAKmqyKMy6J+yYxmpi-Zjzvc3OQ2e5V-cD6o4o8mcj1EoiE_GUA@mail.gmail.com>
Subject: Re: [PATCH v2 08/18] hw/block/nvme: Make Zoned NS Command Set
 definitions
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Niklas Cassel <niklas.cassel@wdc.com>,
 Damien Le Moal <damien.lemoal@wdc.com>, Qemu-block <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Keith Busch <kbusch@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsky@redhat.com>,
 Matias Bjorling <matias.bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 17, 2020 at 2:51 PM Dmitry Fomichev <dmitry.fomichev@wdc.com> wrote:
>
> Define values and structures that are needed to support Zoned
> Namespace Command Set (NVMe TP 4053) in PCI NVMe controller emulator.
>
> All new protocol definitions are located in include/block/nvme.h
> and everything added that is specific to this implementation is kept
> in hw/block/nvme.h.
>
> In order to improve scalability, all open, closed and full zones
> are organized in separate linked lists. Consequently, almost all
> zone operations don't require scanning of the entire zone array
> (which potentially can be quite large) - it is only necessary to
> enumerate one or more zone lists. Zone lists are designed to be
> position-independent as they can be persisted to the backing file
> as a part of zone metadata. NvmeZoneList struct defined in this patch
> serves as a head of every zone list.
>
> NvmeZone structure encapsulates NvmeZoneDescriptor defined in Zoned
> Command Set specification and adds a few more fields that are
> internal to this implementation.
>
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
> Signed-off-by: Ajay Joshi <ajay.joshi@wdc.com>
> Signed-off-by: Matias Bjorling <matias.bjorling@wdc.com>
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Signed-off-by: Alexey Bogoslavsky <alexey.bogoslavsky@wdc.com>
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> ---
>  hw/block/nvme.h      | 130 +++++++++++++++++++++++++++++++++++++++++++
>  include/block/nvme.h | 119 ++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 248 insertions(+), 1 deletion(-)
>
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index 0d29f75475..2c932b5e29 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -3,12 +3,22 @@
>
>  #include "block/nvme.h"
>
> +#define NVME_DEFAULT_ZONE_SIZE   128 /* MiB */
> +#define NVME_DEFAULT_MAX_ZA_SIZE 128 /* KiB */
> +
>  typedef struct NvmeParams {
>      char     *serial;
>      uint32_t num_queues; /* deprecated since 5.1 */
>      uint32_t max_ioqpairs;
>      uint16_t msix_qsize;
>      uint32_t cmb_size_mb;
> +
> +    bool        zoned;
> +    bool        cross_zone_read;
> +    uint8_t     fill_pattern;
> +    uint32_t    zamds_bs;
> +    uint64_t    zone_size;
> +    uint64_t    zone_capacity;
>  } NvmeParams;
>
>  typedef struct NvmeAsyncEvent {
> @@ -17,6 +27,8 @@ typedef struct NvmeAsyncEvent {
>
>  enum NvmeRequestFlags {
>      NVME_REQ_FLG_HAS_SG   = 1 << 0,
> +    NVME_REQ_FLG_FILL     = 1 << 1,
> +    NVME_REQ_FLG_APPEND   = 1 << 2,
>  };
>
>  typedef struct NvmeRequest {
> @@ -24,6 +36,7 @@ typedef struct NvmeRequest {
>      BlockAIOCB              *aiocb;
>      uint16_t                status;
>      uint16_t                flags;
> +    uint64_t                fill_ofs;
>      NvmeCqe                 cqe;
>      BlockAcctCookie         acct;
>      QEMUSGList              qsg;
> @@ -61,11 +74,35 @@ typedef struct NvmeCQueue {
>      QTAILQ_HEAD(, NvmeRequest) req_list;
>  } NvmeCQueue;
>
> +typedef struct NvmeZone {
> +    NvmeZoneDescr   d;
> +    uint64_t        tstamp;
> +    uint32_t        next;
> +    uint32_t        prev;
> +    uint8_t         rsvd80[8];
> +} NvmeZone;
> +
> +#define NVME_ZONE_LIST_NIL    UINT_MAX
> +
> +typedef struct NvmeZoneList {
> +    uint32_t        head;
> +    uint32_t        tail;
> +    uint32_t        size;
> +    uint8_t         rsvd12[4];
> +} NvmeZoneList;
> +
>  typedef struct NvmeNamespace {
>      NvmeIdNs        id_ns;
>      uint32_t        nsid;
>      uint8_t         csi;
>      QemuUUID        uuid;
> +
> +    NvmeIdNsZoned   *id_ns_zoned;
> +    NvmeZone        *zone_array;
> +    NvmeZoneList    *exp_open_zones;
> +    NvmeZoneList    *imp_open_zones;
> +    NvmeZoneList    *closed_zones;
> +    NvmeZoneList    *full_zones;
>  } NvmeNamespace;
>
>  static inline NvmeLBAF *nvme_ns_lbaf(NvmeNamespace *ns)
> @@ -100,6 +137,7 @@ typedef struct NvmeCtrl {
>      uint32_t    num_namespaces;
>      uint32_t    max_q_ents;
>      uint64_t    ns_size;
> +
>      uint8_t     *cmbuf;
>      uint32_t    irq_status;
>      uint64_t    host_timestamp;                 /* Timestamp sent by the host */
> @@ -107,6 +145,12 @@ typedef struct NvmeCtrl {
>
>      HostMemoryBackend *pmrdev;
>
> +    int             zone_file_fd;
> +    uint32_t        num_zones;
> +    uint64_t        zone_size_bs;
> +    uint64_t        zone_array_size;
> +    uint8_t         zamds;
> +
>      NvmeNamespace   *namespaces;
>      NvmeSQueue      **sq;
>      NvmeCQueue      **cq;
> @@ -121,6 +165,86 @@ static inline uint64_t nvme_ns_nlbas(NvmeCtrl *n, NvmeNamespace *ns)
>      return n->ns_size >> nvme_ns_lbads(ns);
>  }
>
> +static inline uint8_t nvme_get_zone_state(NvmeZone *zone)
> +{
> +    return zone->d.zs >> 4;
> +}
> +
> +static inline void nvme_set_zone_state(NvmeZone *zone, enum NvmeZoneState state)
> +{
> +    zone->d.zs = state << 4;
> +}
> +
> +static inline uint64_t nvme_zone_rd_boundary(NvmeCtrl *n, NvmeZone *zone)
> +{
> +    return zone->d.zslba + n->params.zone_size;
> +}
> +
> +static inline uint64_t nvme_zone_wr_boundary(NvmeZone *zone)
> +{
> +    return zone->d.zslba + zone->d.zcap;
> +}
> +
> +static inline bool nvme_wp_is_valid(NvmeZone *zone)
> +{
> +    uint8_t st = nvme_get_zone_state(zone);
> +
> +    return st != NVME_ZONE_STATE_FULL &&
> +           st != NVME_ZONE_STATE_READ_ONLY &&
> +           st != NVME_ZONE_STATE_OFFLINE;
> +}
> +
> +/*
> + * Initialize a zone list head.
> + */
> +static inline void nvme_init_zone_list(NvmeZoneList *zl)
> +{
> +    zl->head = NVME_ZONE_LIST_NIL;
> +    zl->tail = NVME_ZONE_LIST_NIL;
> +    zl->size = 0;
> +}
> +
> +/*
> + * Initialize the number of entries contained in a zone list.
> + */

This should be retrieve (or something similar) instead of initialise.

> +static inline uint32_t nvme_zone_list_size(NvmeZoneList *zl)
> +{
> +    return zl->size;
> +}
> +
> +/*
> + * Check if the zone is not currently included into any zone list.
> + */
> +static inline bool nvme_zone_not_in_list(NvmeZone *zone)
> +{
> +    return (bool)(zone->prev == 0 && zone->next == 0);

You don't need the cast to bool.

Besides that it looks good. I didn't check every value against the spec though.

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> +}
> +
> +/*
> + * Return the zone at the head of zone list or NULL if the list is empty.
> + */
> +static inline NvmeZone *nvme_peek_zone_head(NvmeNamespace *ns, NvmeZoneList *zl)
> +{
> +    if (zl->head == NVME_ZONE_LIST_NIL) {
> +        return NULL;
> +    }
> +    return &ns->zone_array[zl->head];
> +}
> +
> +/*
> + * Return the next zone in the list.
> + */
> +static inline NvmeZone *nvme_next_zone_in_list(NvmeNamespace *ns, NvmeZone *z,
> +    NvmeZoneList *zl)
> +{
> +    assert(!nvme_zone_not_in_list(z));
> +
> +    if (z->next == NVME_ZONE_LIST_NIL) {
> +        return NULL;
> +    }
> +    return &ns->zone_array[z->next];
> +}
> +
>  static inline int nvme_ilog2(uint64_t i)
>  {
>      int log = -1;
> @@ -132,4 +256,10 @@ static inline int nvme_ilog2(uint64_t i)
>      return log;
>  }
>
> +static inline void _hw_nvme_check_size(void)
> +{
> +    QEMU_BUILD_BUG_ON(sizeof(NvmeZoneList) != 16);
> +    QEMU_BUILD_BUG_ON(sizeof(NvmeZone) != 88);
> +}
> +
>  #endif /* HW_NVME_H */
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index 5a1e5e137c..596c39162b 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -446,6 +446,9 @@ enum NvmeIoCommands {
>      NVME_CMD_COMPARE            = 0x05,
>      NVME_CMD_WRITE_ZEROS        = 0x08,
>      NVME_CMD_DSM                = 0x09,
> +    NVME_CMD_ZONE_MGMT_SEND     = 0x79,
> +    NVME_CMD_ZONE_MGMT_RECV     = 0x7a,
> +    NVME_CMD_ZONE_APND          = 0x7d,
>  };
>
>  typedef struct NvmeDeleteQ {
> @@ -539,6 +542,7 @@ enum NvmeNidLength {
>
>  enum NvmeCsi {
>      NVME_CSI_NVM                = 0x00,
> +    NVME_CSI_ZONED              = 0x02,
>  };
>
>  #define NVME_SET_CSI(vec, csi) (vec |= (uint8_t)(1 << (csi)))
> @@ -661,6 +665,7 @@ enum NvmeStatusCodes {
>      NVME_INVALID_NSID           = 0x000b,
>      NVME_CMD_SEQ_ERROR          = 0x000c,
>      NVME_CMD_SET_CMB_REJECTED   = 0x002b,
> +    NVME_INVALID_CMD_SET        = 0x002c,
>      NVME_LBA_RANGE              = 0x0080,
>      NVME_CAP_EXCEEDED           = 0x0081,
>      NVME_NS_NOT_READY           = 0x0082,
> @@ -684,6 +689,14 @@ enum NvmeStatusCodes {
>      NVME_CONFLICTING_ATTRS      = 0x0180,
>      NVME_INVALID_PROT_INFO      = 0x0181,
>      NVME_WRITE_TO_RO            = 0x0182,
> +    NVME_ZONE_BOUNDARY_ERROR    = 0x01b8,
> +    NVME_ZONE_FULL              = 0x01b9,
> +    NVME_ZONE_READ_ONLY         = 0x01ba,
> +    NVME_ZONE_OFFLINE           = 0x01bb,
> +    NVME_ZONE_INVALID_WRITE     = 0x01bc,
> +    NVME_ZONE_TOO_MANY_ACTIVE   = 0x01bd,
> +    NVME_ZONE_TOO_MANY_OPEN     = 0x01be,
> +    NVME_ZONE_INVAL_TRANSITION  = 0x01bf,
>      NVME_WRITE_FAULT            = 0x0280,
>      NVME_UNRECOVERED_READ       = 0x0281,
>      NVME_E2E_GUARD_ERROR        = 0x0282,
> @@ -807,7 +820,17 @@ typedef struct NvmeIdCtrl {
>      uint8_t     ieee[3];
>      uint8_t     cmic;
>      uint8_t     mdts;
> -    uint8_t     rsvd255[178];
> +    uint16_t    cntlid;
> +    uint32_t    ver;
> +    uint32_t    rtd3r;
> +    uint32_t    rtd3e;
> +    uint32_t    oaes;
> +    uint32_t    ctratt;
> +    uint8_t     rsvd100[28];
> +    uint16_t    crdt1;
> +    uint16_t    crdt2;
> +    uint16_t    crdt3;
> +    uint8_t     rsvd134[122];
>      uint16_t    oacs;
>      uint8_t     acl;
>      uint8_t     aerl;
> @@ -832,6 +855,11 @@ typedef struct NvmeIdCtrl {
>      uint8_t     vs[1024];
>  } NvmeIdCtrl;
>
> +typedef struct NvmeIdCtrlZoned {
> +    uint8_t     zamds;
> +    uint8_t     rsvd1[4095];
> +} NvmeIdCtrlZoned;
> +
>  enum NvmeIdCtrlOacs {
>      NVME_OACS_SECURITY  = 1 << 0,
>      NVME_OACS_FORMAT    = 1 << 1,
> @@ -908,6 +936,12 @@ typedef struct NvmeLBAF {
>      uint8_t     rp;
>  } NvmeLBAF;
>
> +typedef struct NvmeLBAFE {
> +    uint64_t    zsze;
> +    uint8_t     zdes;
> +    uint8_t     rsvd9[7];
> +} NvmeLBAFE;
> +
>  typedef struct NvmeIdNs {
>      uint64_t    nsze;
>      uint64_t    ncap;
> @@ -930,6 +964,19 @@ typedef struct NvmeIdNs {
>      uint8_t     vs[3712];
>  } NvmeIdNs;
>
> +typedef struct NvmeIdNsZoned {
> +    uint16_t    zoc;
> +    uint16_t    ozcs;
> +    uint32_t    mar;
> +    uint32_t    mor;
> +    uint32_t    rrl;
> +    uint32_t    frl;
> +    uint8_t     rsvd20[2796];
> +    NvmeLBAFE   lbafe[16];
> +    uint8_t     rsvd3072[768];
> +    uint8_t     vs[256];
> +} NvmeIdNsZoned;
> +
>
>  /*Deallocate Logical Block Features*/
>  #define NVME_ID_NS_DLFEAT_GUARD_CRC(dlfeat)       ((dlfeat) & 0x10)
> @@ -962,6 +1009,71 @@ enum NvmeIdNsDps {
>      DPS_FIRST_EIGHT = 8,
>  };
>
> +enum NvmeZoneAttr {
> +    NVME_ZA_FINISHED_BY_CTLR         = 1 << 0,
> +    NVME_ZA_FINISH_RECOMMENDED       = 1 << 1,
> +    NVME_ZA_RESET_RECOMMENDED        = 1 << 2,
> +    NVME_ZA_ZD_EXT_VALID             = 1 << 7,
> +};
> +
> +typedef struct NvmeZoneReportHeader {
> +    uint64_t    nr_zones;
> +    uint8_t     rsvd[56];
> +} NvmeZoneReportHeader;
> +
> +enum NvmeZoneReceiveAction {
> +    NVME_ZONE_REPORT                 = 0,
> +    NVME_ZONE_REPORT_EXTENDED        = 1,
> +};
> +
> +enum NvmeZoneReportType {
> +    NVME_ZONE_REPORT_ALL             = 0,
> +    NVME_ZONE_REPORT_EMPTY           = 1,
> +    NVME_ZONE_REPORT_IMPLICITLY_OPEN = 2,
> +    NVME_ZONE_REPORT_EXPLICITLY_OPEN = 3,
> +    NVME_ZONE_REPORT_CLOSED          = 4,
> +    NVME_ZONE_REPORT_FULL            = 5,
> +    NVME_ZONE_REPORT_READ_ONLY       = 6,
> +    NVME_ZONE_REPORT_OFFLINE         = 7,
> +};
> +
> +typedef struct NvmeZoneDescr {
> +    uint8_t     zt;
> +    uint8_t     zs;
> +    uint8_t     za;
> +    uint8_t     rsvd3[5];
> +    uint64_t    zcap;
> +    uint64_t    zslba;
> +    uint64_t    wp;
> +    uint8_t     rsvd32[32];
> +} NvmeZoneDescr;
> +
> +enum NvmeZoneState {
> +    NVME_ZONE_STATE_RESERVED         = 0x00,
> +    NVME_ZONE_STATE_EMPTY            = 0x01,
> +    NVME_ZONE_STATE_IMPLICITLY_OPEN  = 0x02,
> +    NVME_ZONE_STATE_EXPLICITLY_OPEN  = 0x03,
> +    NVME_ZONE_STATE_CLOSED           = 0x04,
> +    NVME_ZONE_STATE_READ_ONLY        = 0x0D,
> +    NVME_ZONE_STATE_FULL             = 0x0E,
> +    NVME_ZONE_STATE_OFFLINE          = 0x0F,
> +};
> +
> +enum NvmeZoneType {
> +    NVME_ZONE_TYPE_RESERVED          = 0x00,
> +    NVME_ZONE_TYPE_SEQ_WRITE         = 0x02,
> +};
> +
> +enum NvmeZoneSendAction {
> +    NVME_ZONE_ACTION_RSD             = 0x00,
> +    NVME_ZONE_ACTION_CLOSE           = 0x01,
> +    NVME_ZONE_ACTION_FINISH          = 0x02,
> +    NVME_ZONE_ACTION_OPEN            = 0x03,
> +    NVME_ZONE_ACTION_RESET           = 0x04,
> +    NVME_ZONE_ACTION_OFFLINE         = 0x05,
> +    NVME_ZONE_ACTION_SET_ZD_EXT      = 0x10,
> +};
> +
>  static inline void _nvme_check_size(void)
>  {
>      QEMU_BUILD_BUG_ON(sizeof(NvmeCqe) != 16);
> @@ -978,8 +1090,13 @@ static inline void _nvme_check_size(void)
>      QEMU_BUILD_BUG_ON(sizeof(NvmeFwSlotInfoLog) != 512);
>      QEMU_BUILD_BUG_ON(sizeof(NvmeSmartLog) != 512);
>      QEMU_BUILD_BUG_ON(sizeof(NvmeIdCtrl) != 4096);
> +    QEMU_BUILD_BUG_ON(sizeof(NvmeIdCtrlZoned) != 4096);
>      QEMU_BUILD_BUG_ON(sizeof(NvmeNsIdDesc) != 4);
> +    QEMU_BUILD_BUG_ON(sizeof(NvmeLBAF) != 4);
> +    QEMU_BUILD_BUG_ON(sizeof(NvmeLBAFE) != 16);
>      QEMU_BUILD_BUG_ON(sizeof(NvmeIdNs) != 4096);
> +    QEMU_BUILD_BUG_ON(sizeof(NvmeIdNsZoned) != 4096);
>      QEMU_BUILD_BUG_ON(sizeof(NvmeEffectsLog) != 4096);
> +    QEMU_BUILD_BUG_ON(sizeof(NvmeZoneDescr) != 64);
>  }
>  #endif
> --
> 2.21.0
>
>

