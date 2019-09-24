Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDA9C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 10:06:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6585214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 10:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cMp+y/Hi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6585214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iChiQ-0004Zy-Mx
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 06:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59555)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iChgC-0003NR-JH
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 06:04:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iChgA-0003Rk-PN
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 06:04:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59727
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iChgA-0003RY-IE
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 06:04:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1569319457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=Ex1UTlHlabUaFJfa2zPyjkXwwqjhSTelAtuhk1oXWOA=;
 b=cMp+y/HiFb0+nM5SrwufBGjqYaqyguufkmh1Za38i4vilFpCM5XyaOCe/MG0smy7un1XoH
 mmKZ4IYz4Q3ue7HjSwmCJaMEO+tBBBx9fSuxGbm9PfPE/ydPgdFH9pIyyt6ip1Rk+8FBZ5
 YHO92oFuPdbB32Ig+sMLrSagDzD2li4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-lK_VLwVAOn2IG4Qzg2NkBw-1; Tue, 24 Sep 2019 06:04:15 -0400
Received: by mail-wm1-f70.google.com with SMTP id k9so717288wmb.0
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 03:04:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QRCo0sM0eeWtLW7LaeGQwbwOa1dxUlZdiPuMiAMLXCs=;
 b=hXvIwInV2V/j2n6Cub2BsgK+FKVUPLi/rh4CD5wepzXoIp9ms1cSgCOQTmS1N1pu34
 rgwvtNInjQGujGUsXOo3t/H11MiCXFrvHUhpjfAoghCq9dUpTywerd//J8NYaMOUykjM
 aWD/HVNdwPtwQkxj7n8byAjeDIda1xsBxedGvc7eR7hNdVeBbQGFpG32ZNKWFHC/pdae
 +aG3OiC+FLp7OgiSImIPUFi2vEEIWVhlkHGyJzdzPmYHCrtswAAsv/ipCnk82lG5Y9LT
 yihiAO69LFEXCWimDB5kaMuWMvF9/E0ZUWtI/3+AyOSeW/y37ctGnIB4Nv1oaMWrS13D
 aF3g==
X-Gm-Message-State: APjAAAX5zK+hcB8g6sAXrq0Alwr5d/zOLfNrLOTbnPCKWpOUpX1vWNc7
 AGCNBreAk6lXjsQNVSEU/yAzLyMp0uXIGNrWRCvGv9IrOWWrYRLXP4NJMD+Hrz+6qxahgdZaeFI
 OlEnc57rLsyHX56A=
X-Received: by 2002:a7b:c92b:: with SMTP id h11mr2041256wml.10.1569319454701; 
 Tue, 24 Sep 2019 03:04:14 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx5eH6yJVB6R7HQcCViZTedfFasbTIizGi0ErDqR7vhmchC4N2TyVjxnPeF7AI0FluNbyEsOA==
X-Received: by 2002:a7b:c92b:: with SMTP id h11mr2041231wml.10.1569319454458; 
 Tue, 24 Sep 2019 03:04:14 -0700 (PDT)
Received: from [192.168.1.115] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id z189sm2165291wmc.25.2019.09.24.03.04.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Sep 2019 03:04:13 -0700 (PDT)
Subject: Re: [PATCH 0/4] xics: Eliminate unnecessary class
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Greg Kurz <groug@kaod.org>
References: <20190924045952.11412-1-david@gibson.dropbear.id.au>
 <cb87c744-a618-0627-5c2f-8f8e18616f6d@kaod.org>
 <20190924095200.7f624278@bahia.lan>
 <98e7128c-e305-ab7a-b138-da1c56266805@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <7ae8863e-0718-b18f-5d52-3c41d813b026@redhat.com>
Date: Tue, 24 Sep 2019 12:04:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <98e7128c-e305-ab7a-b138-da1c56266805@kaod.org>
Content-Language: en-US
X-MC-Unique: lK_VLwVAOn2IG4Qzg2NkBw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: gkurz@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi C=C3=A9dric,

On 9/24/19 11:55 AM, C=C3=A9dric Le Goater wrote:
> On 24/09/2019 09:52, Greg Kurz wrote:
>> On Tue, 24 Sep 2019 07:22:51 +0200
>> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>>
>>> On 24/09/2019 06:59, David Gibson wrote:
>>>> The XICS interrupt controller device used to have separate subtypes
>>>> for the KVM and non-KVM variant of the device.  That was a bad idea,
>>>> because it leaked information that should be entirely host-side
>>>> implementation specific to the kinda-sorta guest visible QOM class
>>>> names.
>>>>
>>>> We eliminated the KVM specific class some time ago, but it's left
>>>> behind a distinction between the TYPE_ICS_BASE abstract class and
>>>> TYPE_ICS_SIMPLE subtype which no longer serves any purpose.
>>>>
>>>> This series collapses the two types back into one.
>>>
>>> OK. Is it migration compatible ? because this is why we have kept
>>
>> Yeah, the types themselves don't matter, only the format of the
>> binary stream described in the VMStateDescription does.
>>
>>> this subclass. I am glad we can remove it finally.=20
>>>
>>
>> I was thinking we were keeping that for pnv...
>=20
>=20
> Yes, also. See the resend and reject handler in the code=20
> below.
>=20
>=20
> I have been maintaining this patch since QEMU 2.6. I think=20
> it is time for me to declare defeat on getting it merged=20
> and QEMU 4.2 will be the last rebase.=20

Do you remember what is missing for being merged upstream?

> /*
>  * QEMU PowerPC PowerNV PHB3 model
>  *
>  * Copyright (c) 2014-2018, IBM Corporation.
>  *
>  * This code is licensed under the GPL version 2 or later. See the
>  * COPYING file in the top-level directory.
>  */
> #include "qemu/osdep.h"
> #include "qemu/log.h"
> #include "qapi/error.h"
> #include "qemu-common.h"
> #include "hw/pci-host/pnv_phb3_regs.h"
> #include "hw/pci-host/pnv_phb3.h"
> #include "hw/ppc/pnv.h"
> #include "hw/pci/msi.h"
> #include "monitor/monitor.h"
> #include "hw/irq.h"
> #include "hw/qdev-properties.h"
> #include "sysemu/reset.h"
>=20
> static uint64_t phb3_msi_ive_addr(PnvPHB3 *phb, int srcno)
> {
>     uint64_t ivtbar =3D phb->regs[PHB_IVT_BAR >> 3];
>     uint64_t phbctl =3D phb->regs[PHB_CONTROL >> 3];
>=20
>     if (!(ivtbar & PHB_IVT_BAR_ENABLE)) {
>         qemu_log_mask(LOG_GUEST_ERROR, "Failed access to disable IVT BAR =
!");
>         return 0;
>     }
>=20
>     if (srcno >=3D (ivtbar & PHB_IVT_LENGTH_MASK)) {
>         qemu_log_mask(LOG_GUEST_ERROR, "MSI out of bounds (%d vs  0x%"PRI=
x64")",
>                       srcno, (uint64_t) (ivtbar & PHB_IVT_LENGTH_MASK));
>         return 0;
>     }
>=20
>     ivtbar &=3D PHB_IVT_BASE_ADDRESS_MASK;
>=20
>     if (phbctl & PHB_CTRL_IVE_128_BYTES) {
>         return ivtbar + 128 * srcno;
>     } else {
>         return ivtbar + 16 * srcno;
>     }
> }
>=20
> static bool phb3_msi_read_ive(PnvPHB3 *phb, int srcno, uint64_t *out_ive)
> {
>     uint64_t ive_addr, ive;
>=20
>     ive_addr =3D phb3_msi_ive_addr(phb, srcno);
>     if (!ive_addr) {
>         return false;
>     }
>=20
>     if (dma_memory_read(&address_space_memory, ive_addr, &ive, sizeof(ive=
))) {
>         qemu_log_mask(LOG_GUEST_ERROR, "Failed to read IVE at 0x%" PRIx64=
,
>                       ive_addr);
>         return false;
>     }
>     *out_ive =3D be64_to_cpu(ive);
>=20
>     return true;
> }
>=20
> static void phb3_msi_set_p(Phb3MsiState *msi, int srcno, uint8_t gen)
> {
>     uint64_t ive_addr;
>     uint8_t p =3D 0x01 | (gen << 1);
>=20
>     ive_addr =3D phb3_msi_ive_addr(msi->phb, srcno);
>     if (!ive_addr) {
>         return;
>     }
>=20
>     if (dma_memory_write(&address_space_memory, ive_addr + 4, &p, 1)) {
>         qemu_log_mask(LOG_GUEST_ERROR,
>                       "Failed to write IVE (set P) at 0x%" PRIx64, ive_ad=
dr);
>     }
> }
>=20
> static void phb3_msi_set_q(Phb3MsiState *msi, int srcno)
> {
>     uint64_t ive_addr;
>     uint8_t q =3D 0x01;
>=20
>     ive_addr =3D phb3_msi_ive_addr(msi->phb, srcno);
>     if (!ive_addr) {
>         return;
>     }
>=20
>     if (dma_memory_write(&address_space_memory, ive_addr + 5, &q, 1)) {
>         qemu_log_mask(LOG_GUEST_ERROR,
>                       "Failed to write IVE (set Q) at 0x%" PRIx64, ive_ad=
dr);
>     }
> }
>=20
> static void phb3_msi_try_send(Phb3MsiState *msi, int srcno, bool force)
> {
>     ICSState *ics =3D ICS_BASE(msi);
>     uint64_t ive;
>     uint64_t server, prio, pq, gen;
>=20
>     if (!phb3_msi_read_ive(msi->phb, srcno, &ive)) {
>         return;
>     }
>=20
>     server =3D GETFIELD(IODA2_IVT_SERVER, ive);
>     prio =3D GETFIELD(IODA2_IVT_PRIORITY, ive);
>     if (!force) {
>         pq =3D GETFIELD(IODA2_IVT_Q, ive) | (GETFIELD(IODA2_IVT_P, ive) <=
< 1);
>     } else {
>         pq =3D 0;
>     }
>     gen =3D GETFIELD(IODA2_IVT_GEN, ive);
>=20
>     /*
>      * The low order 2 bits are the link pointer (Type II interrupts).
>      * Shift back to get a valid IRQ server.
>      */
>     server >>=3D 2;
>=20
>     switch (pq) {
>     case 0: /* 00 */
>         if (prio =3D=3D 0xff) {
>             /* Masked, set Q */
>             phb3_msi_set_q(msi, srcno);
>         } else {
>             /* Enabled, set P and send */
>             phb3_msi_set_p(msi, srcno, gen);
>             icp_irq(ics, server, srcno + ics->offset, prio);
>         }
>         break;
>     case 2: /* 10 */
>         /* Already pending, set Q */
>         phb3_msi_set_q(msi, srcno);
>         break;
>     case 1: /* 01 */
>     case 3: /* 11 */
>     default:
>         /* Just drop stuff if Q already set */
>         break;
>     }
> }
>=20
> static void phb3_msi_set_irq(void *opaque, int srcno, int val)
> {
>     Phb3MsiState *msi =3D PHB3_MSI(opaque);
>=20
>     if (val) {
>         phb3_msi_try_send(msi, srcno, false);
>     }
> }
>=20
>=20
> void pnv_phb3_msi_send(Phb3MsiState *msi, uint64_t addr, uint16_t data,
>                        int32_t dev_pe)
> {
>     ICSState *ics =3D ICS_BASE(msi);
>     uint64_t ive;
>     uint16_t pe;
>     uint32_t src =3D ((addr >> 4) & 0xffff) | (data & 0x1f);
>=20
>     if (src >=3D ics->nr_irqs) {
>         qemu_log_mask(LOG_GUEST_ERROR, "MSI %d out of bounds", src);
>         return;
>     }
>     if (dev_pe >=3D 0) {
>         if (!phb3_msi_read_ive(msi->phb, src, &ive)) {
>             return;
>         }
>         pe =3D GETFIELD(IODA2_IVT_PE, ive);
>         if (pe !=3D dev_pe) {
>             qemu_log_mask(LOG_GUEST_ERROR,
>                           "MSI %d send by PE#%d but assigned to PE#%d",
>                           src, dev_pe, pe);
>             return;
>         }
>     }
>     qemu_irq_pulse(msi->qirqs[src]);
> }
>=20
> void pnv_phb3_msi_ffi(Phb3MsiState *msi, uint64_t val)
> {
>     /* Emit interrupt */
>     pnv_phb3_msi_send(msi, val, 0, -1);
>=20
>     /* Clear FFI lock */
>     msi->phb->regs[PHB_FFI_LOCK >> 3] =3D 0;
> }
>=20
> static void phb3_msi_reject(ICSState *ics, uint32_t nr)
> {
>     Phb3MsiState *msi =3D PHB3_MSI(ics);
>     unsigned int srcno =3D nr - ics->offset;
>     unsigned int idx =3D srcno >> 6;
>     unsigned int bit =3D 1ull << (srcno & 0x3f);
>=20
>     assert(srcno < PHB3_MAX_MSI);
>=20
>     msi->rba[idx] |=3D bit;
>     msi->rba_sum |=3D (1u << idx);
> }
>=20
> static void phb3_msi_resend(ICSState *ics)
> {
>     Phb3MsiState *msi =3D PHB3_MSI(ics);
>     unsigned int i, j;
>=20
>     if (msi->rba_sum =3D=3D 0) {
>         return;
>     }
>=20
>     for (i =3D 0; i < 32; i++) {
>         if ((msi->rba_sum & (1u << i)) =3D=3D 0) {
>             continue;
>         }
>         msi->rba_sum &=3D ~(1u << i);
>         for (j =3D 0; j < 64; j++) {
>             if ((msi->rba[i] & (1ull << j)) =3D=3D 0) {
>                 continue;
>             }
>             msi->rba[i] &=3D ~(1u << j);
>             phb3_msi_try_send(msi, i * 64 + j, true);
>         }
>     }
> }
>=20
> static void phb3_msi_print_info(ICSState *ics, Monitor *mon)
> {
>     Phb3MsiState *msi =3D PHB3_MSI(ics);
>     int i;
>=20
>     for (i =3D 0; i < ics->nr_irqs; i++) {
>         uint64_t ive;
>=20
>         if (!phb3_msi_read_ive(msi->phb, i, &ive)) {
>             return;
>         }
>=20
>         if (GETFIELD(IODA2_IVT_PRIORITY, ive) =3D=3D 0xff) {
>             continue;
>         }
>=20
>         monitor_printf(mon, "  %4x %c%c server=3D%04x prio=3D%02x gen=3D%=
d\n",
>                        ics->offset + i,
>                        GETFIELD(IODA2_IVT_P, ive) ? 'P' : '-',
>                        GETFIELD(IODA2_IVT_Q, ive) ? 'Q' : '-',
>                        (uint32_t) GETFIELD(IODA2_IVT_SERVER, ive) >> 2,
>                        (uint32_t) GETFIELD(IODA2_IVT_PRIORITY, ive),
>                        (uint32_t) GETFIELD(IODA2_IVT_GEN, ive));
>     }
> }
>=20
> static void phb3_msi_reset(DeviceState *dev)
> {
>     Phb3MsiState *msi =3D PHB3_MSI(dev);
>     ICSStateClass *icsc =3D ICS_BASE_GET_CLASS(dev);
>=20
>     icsc->parent_reset(dev);
>=20
>     memset(msi->rba, 0, sizeof(msi->rba));
>     msi->rba_sum =3D 0;
> }
>=20
> static void phb3_msi_reset_handler(void *dev)
> {
>     phb3_msi_reset(dev);
> }
>=20
> void pnv_phb3_msi_update_config(Phb3MsiState *msi, uint32_t base,
>                                 uint32_t count)
> {
>     ICSState *ics =3D ICS_BASE(msi);
>=20
>     if (count > PHB3_MAX_MSI) {
>         count =3D PHB3_MAX_MSI;
>     }
>     ics->nr_irqs =3D count;
>     ics->offset =3D base;
> }
>=20
> static void phb3_msi_realize(DeviceState *dev, Error **errp)
> {
>     Phb3MsiState *msi =3D PHB3_MSI(dev);
>     ICSState *ics =3D ICS_BASE(msi);
>     ICSStateClass *icsc =3D ICS_BASE_GET_CLASS(ics);
>     Object *obj;
>     Error *local_err =3D NULL;
>=20
>     icsc->parent_realize(dev, &local_err);
>     if (local_err) {
>         error_propagate(errp, local_err);
>         return;
>     }
>=20
>     obj =3D object_property_get_link(OBJECT(dev), "phb", &local_err);
>     if (!obj) {
>         error_propagate(errp, local_err);
>         error_prepend(errp, "required link 'phb' not found: ");
>         return;
>     }
>     msi->phb =3D PNV_PHB3(obj);
>=20
>     msi->qirqs =3D qemu_allocate_irqs(phb3_msi_set_irq, msi, ics->nr_irqs=
);
>=20
>     qemu_register_reset(phb3_msi_reset_handler, dev);
> }
>=20
> static void phb3_msi_instance_init(Object *obj)
> {
>     ICSState *ics =3D ICS_BASE(obj);
>=20
>     /* Will be overriden later */
>     ics->offset =3D 0;
> }
>=20
> static void phb3_msi_class_init(ObjectClass *klass, void *data)
> {
>     DeviceClass *dc =3D DEVICE_CLASS(klass);
>     ICSStateClass *isc =3D ICS_BASE_CLASS(klass);
>=20
>     device_class_set_parent_realize(dc, phb3_msi_realize,
>                                     &isc->parent_realize);
>     device_class_set_parent_reset(dc, phb3_msi_reset,
>                                   &isc->parent_reset);
>=20
>     isc->reject =3D phb3_msi_reject;
>     isc->resend =3D phb3_msi_resend;
>     isc->print_info =3D phb3_msi_print_info;
> }
>=20
> static const TypeInfo phb3_msi_info =3D {
>     .name =3D TYPE_PHB3_MSI,
>     .parent =3D TYPE_ICS_BASE,
>     .instance_size =3D sizeof(Phb3MsiState),
>     .class_init =3D phb3_msi_class_init,
>     .class_size =3D sizeof(ICSStateClass),
>     .instance_init =3D phb3_msi_instance_init,
> };
>=20
> static void pnv_phb3_msi_register_types(void)
> {
>     type_register_static(&phb3_msi_info);
> }
>=20
> type_init(pnv_phb3_msi_register_types)
>=20


