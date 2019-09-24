Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3023FC432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 09:59:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EACDA20872
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 09:59:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EACDA20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iChb6-0000kG-3M
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 05:59:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58328)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iChXT-0006Gd-25
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 05:55:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iChXO-0006Qa-Tr
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 05:55:18 -0400
Received: from 11.mo6.mail-out.ovh.net ([188.165.38.119]:56499)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iChXO-0006L9-F9
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 05:55:14 -0400
Received: from player771.ha.ovh.net (unknown [10.108.54.94])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 5CF4E1E03D3
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 11:55:10 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player771.ha.ovh.net (Postfix) with ESMTPSA id 64263A2857AC;
 Tue, 24 Sep 2019 09:55:04 +0000 (UTC)
Subject: Re: [PATCH 0/4] xics: Eliminate unnecessary class
To: Greg Kurz <groug@kaod.org>
References: <20190924045952.11412-1-david@gibson.dropbear.id.au>
 <cb87c744-a618-0627-5c2f-8f8e18616f6d@kaod.org>
 <20190924095200.7f624278@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <98e7128c-e305-ab7a-b138-da1c56266805@kaod.org>
Date: Tue, 24 Sep 2019 11:55:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190924095200.7f624278@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 16716517391917615880
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfedtgddvudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.38.119
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

On 24/09/2019 09:52, Greg Kurz wrote:
> On Tue, 24 Sep 2019 07:22:51 +0200
> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>=20
>> On 24/09/2019 06:59, David Gibson wrote:
>>> The XICS interrupt controller device used to have separate subtypes
>>> for the KVM and non-KVM variant of the device.  That was a bad idea,
>>> because it leaked information that should be entirely host-side
>>> implementation specific to the kinda-sorta guest visible QOM class
>>> names.
>>>
>>> We eliminated the KVM specific class some time ago, but it's left
>>> behind a distinction between the TYPE_ICS_BASE abstract class and
>>> TYPE_ICS_SIMPLE subtype which no longer serves any purpose.
>>>
>>> This series collapses the two types back into one.
>>
>> OK. Is it migration compatible ? because this is why we have kept
>=20
> Yeah, the types themselves don't matter, only the format of the
> binary stream described in the VMStateDescription does.
>=20
>> this subclass. I am glad we can remove it finally.=20
>>
>=20
> I was thinking we were keeping that for pnv...


Yes, also. See the resend and reject handler in the code=20
below.


I have been maintaining this patch since QEMU 2.6. I think=20
it is time for me to declare defeat on getting it merged=20
and QEMU 4.2 will be the last rebase.=20


C.=20


/*
 * QEMU PowerPC PowerNV PHB3 model
 *
 * Copyright (c) 2014-2018, IBM Corporation.
 *
 * This code is licensed under the GPL version 2 or later. See the
 * COPYING file in the top-level directory.
 */
#include "qemu/osdep.h"
#include "qemu/log.h"
#include "qapi/error.h"
#include "qemu-common.h"
#include "hw/pci-host/pnv_phb3_regs.h"
#include "hw/pci-host/pnv_phb3.h"
#include "hw/ppc/pnv.h"
#include "hw/pci/msi.h"
#include "monitor/monitor.h"
#include "hw/irq.h"
#include "hw/qdev-properties.h"
#include "sysemu/reset.h"

static uint64_t phb3_msi_ive_addr(PnvPHB3 *phb, int srcno)
{
    uint64_t ivtbar =3D phb->regs[PHB_IVT_BAR >> 3];
    uint64_t phbctl =3D phb->regs[PHB_CONTROL >> 3];

    if (!(ivtbar & PHB_IVT_BAR_ENABLE)) {
        qemu_log_mask(LOG_GUEST_ERROR, "Failed access to disable IVT BAR =
!");
        return 0;
    }

    if (srcno >=3D (ivtbar & PHB_IVT_LENGTH_MASK)) {
        qemu_log_mask(LOG_GUEST_ERROR, "MSI out of bounds (%d vs  0x%"PRI=
x64")",
                      srcno, (uint64_t) (ivtbar & PHB_IVT_LENGTH_MASK));
        return 0;
    }

    ivtbar &=3D PHB_IVT_BASE_ADDRESS_MASK;

    if (phbctl & PHB_CTRL_IVE_128_BYTES) {
        return ivtbar + 128 * srcno;
    } else {
        return ivtbar + 16 * srcno;
    }
}

static bool phb3_msi_read_ive(PnvPHB3 *phb, int srcno, uint64_t *out_ive)
{
    uint64_t ive_addr, ive;

    ive_addr =3D phb3_msi_ive_addr(phb, srcno);
    if (!ive_addr) {
        return false;
    }

    if (dma_memory_read(&address_space_memory, ive_addr, &ive, sizeof(ive=
))) {
        qemu_log_mask(LOG_GUEST_ERROR, "Failed to read IVE at 0x%" PRIx64=
,
                      ive_addr);
        return false;
    }
    *out_ive =3D be64_to_cpu(ive);

    return true;
}

static void phb3_msi_set_p(Phb3MsiState *msi, int srcno, uint8_t gen)
{
    uint64_t ive_addr;
    uint8_t p =3D 0x01 | (gen << 1);

    ive_addr =3D phb3_msi_ive_addr(msi->phb, srcno);
    if (!ive_addr) {
        return;
    }

    if (dma_memory_write(&address_space_memory, ive_addr + 4, &p, 1)) {
        qemu_log_mask(LOG_GUEST_ERROR,
                      "Failed to write IVE (set P) at 0x%" PRIx64, ive_ad=
dr);
    }
}

static void phb3_msi_set_q(Phb3MsiState *msi, int srcno)
{
    uint64_t ive_addr;
    uint8_t q =3D 0x01;

    ive_addr =3D phb3_msi_ive_addr(msi->phb, srcno);
    if (!ive_addr) {
        return;
    }

    if (dma_memory_write(&address_space_memory, ive_addr + 5, &q, 1)) {
        qemu_log_mask(LOG_GUEST_ERROR,
                      "Failed to write IVE (set Q) at 0x%" PRIx64, ive_ad=
dr);
    }
}

static void phb3_msi_try_send(Phb3MsiState *msi, int srcno, bool force)
{
    ICSState *ics =3D ICS_BASE(msi);
    uint64_t ive;
    uint64_t server, prio, pq, gen;

    if (!phb3_msi_read_ive(msi->phb, srcno, &ive)) {
        return;
    }

    server =3D GETFIELD(IODA2_IVT_SERVER, ive);
    prio =3D GETFIELD(IODA2_IVT_PRIORITY, ive);
    if (!force) {
        pq =3D GETFIELD(IODA2_IVT_Q, ive) | (GETFIELD(IODA2_IVT_P, ive) <=
< 1);
    } else {
        pq =3D 0;
    }
    gen =3D GETFIELD(IODA2_IVT_GEN, ive);

    /*
     * The low order 2 bits are the link pointer (Type II interrupts).
     * Shift back to get a valid IRQ server.
     */
    server >>=3D 2;

    switch (pq) {
    case 0: /* 00 */
        if (prio =3D=3D 0xff) {
            /* Masked, set Q */
            phb3_msi_set_q(msi, srcno);
        } else {
            /* Enabled, set P and send */
            phb3_msi_set_p(msi, srcno, gen);
            icp_irq(ics, server, srcno + ics->offset, prio);
        }
        break;
    case 2: /* 10 */
        /* Already pending, set Q */
        phb3_msi_set_q(msi, srcno);
        break;
    case 1: /* 01 */
    case 3: /* 11 */
    default:
        /* Just drop stuff if Q already set */
        break;
    }
}

static void phb3_msi_set_irq(void *opaque, int srcno, int val)
{
    Phb3MsiState *msi =3D PHB3_MSI(opaque);

    if (val) {
        phb3_msi_try_send(msi, srcno, false);
    }
}


void pnv_phb3_msi_send(Phb3MsiState *msi, uint64_t addr, uint16_t data,
                       int32_t dev_pe)
{
    ICSState *ics =3D ICS_BASE(msi);
    uint64_t ive;
    uint16_t pe;
    uint32_t src =3D ((addr >> 4) & 0xffff) | (data & 0x1f);

    if (src >=3D ics->nr_irqs) {
        qemu_log_mask(LOG_GUEST_ERROR, "MSI %d out of bounds", src);
        return;
    }
    if (dev_pe >=3D 0) {
        if (!phb3_msi_read_ive(msi->phb, src, &ive)) {
            return;
        }
        pe =3D GETFIELD(IODA2_IVT_PE, ive);
        if (pe !=3D dev_pe) {
            qemu_log_mask(LOG_GUEST_ERROR,
                          "MSI %d send by PE#%d but assigned to PE#%d",
                          src, dev_pe, pe);
            return;
        }
    }
    qemu_irq_pulse(msi->qirqs[src]);
}

void pnv_phb3_msi_ffi(Phb3MsiState *msi, uint64_t val)
{
    /* Emit interrupt */
    pnv_phb3_msi_send(msi, val, 0, -1);

    /* Clear FFI lock */
    msi->phb->regs[PHB_FFI_LOCK >> 3] =3D 0;
}

static void phb3_msi_reject(ICSState *ics, uint32_t nr)
{
    Phb3MsiState *msi =3D PHB3_MSI(ics);
    unsigned int srcno =3D nr - ics->offset;
    unsigned int idx =3D srcno >> 6;
    unsigned int bit =3D 1ull << (srcno & 0x3f);

    assert(srcno < PHB3_MAX_MSI);

    msi->rba[idx] |=3D bit;
    msi->rba_sum |=3D (1u << idx);
}

static void phb3_msi_resend(ICSState *ics)
{
    Phb3MsiState *msi =3D PHB3_MSI(ics);
    unsigned int i, j;

    if (msi->rba_sum =3D=3D 0) {
        return;
    }

    for (i =3D 0; i < 32; i++) {
        if ((msi->rba_sum & (1u << i)) =3D=3D 0) {
            continue;
        }
        msi->rba_sum &=3D ~(1u << i);
        for (j =3D 0; j < 64; j++) {
            if ((msi->rba[i] & (1ull << j)) =3D=3D 0) {
                continue;
            }
            msi->rba[i] &=3D ~(1u << j);
            phb3_msi_try_send(msi, i * 64 + j, true);
        }
    }
}

static void phb3_msi_print_info(ICSState *ics, Monitor *mon)
{
    Phb3MsiState *msi =3D PHB3_MSI(ics);
    int i;

    for (i =3D 0; i < ics->nr_irqs; i++) {
        uint64_t ive;

        if (!phb3_msi_read_ive(msi->phb, i, &ive)) {
            return;
        }

        if (GETFIELD(IODA2_IVT_PRIORITY, ive) =3D=3D 0xff) {
            continue;
        }

        monitor_printf(mon, "  %4x %c%c server=3D%04x prio=3D%02x gen=3D%=
d\n",
                       ics->offset + i,
                       GETFIELD(IODA2_IVT_P, ive) ? 'P' : '-',
                       GETFIELD(IODA2_IVT_Q, ive) ? 'Q' : '-',
                       (uint32_t) GETFIELD(IODA2_IVT_SERVER, ive) >> 2,
                       (uint32_t) GETFIELD(IODA2_IVT_PRIORITY, ive),
                       (uint32_t) GETFIELD(IODA2_IVT_GEN, ive));
    }
}

static void phb3_msi_reset(DeviceState *dev)
{
    Phb3MsiState *msi =3D PHB3_MSI(dev);
    ICSStateClass *icsc =3D ICS_BASE_GET_CLASS(dev);

    icsc->parent_reset(dev);

    memset(msi->rba, 0, sizeof(msi->rba));
    msi->rba_sum =3D 0;
}

static void phb3_msi_reset_handler(void *dev)
{
    phb3_msi_reset(dev);
}

void pnv_phb3_msi_update_config(Phb3MsiState *msi, uint32_t base,
                                uint32_t count)
{
    ICSState *ics =3D ICS_BASE(msi);

    if (count > PHB3_MAX_MSI) {
        count =3D PHB3_MAX_MSI;
    }
    ics->nr_irqs =3D count;
    ics->offset =3D base;
}

static void phb3_msi_realize(DeviceState *dev, Error **errp)
{
    Phb3MsiState *msi =3D PHB3_MSI(dev);
    ICSState *ics =3D ICS_BASE(msi);
    ICSStateClass *icsc =3D ICS_BASE_GET_CLASS(ics);
    Object *obj;
    Error *local_err =3D NULL;

    icsc->parent_realize(dev, &local_err);
    if (local_err) {
        error_propagate(errp, local_err);
        return;
    }

    obj =3D object_property_get_link(OBJECT(dev), "phb", &local_err);
    if (!obj) {
        error_propagate(errp, local_err);
        error_prepend(errp, "required link 'phb' not found: ");
        return;
    }
    msi->phb =3D PNV_PHB3(obj);

    msi->qirqs =3D qemu_allocate_irqs(phb3_msi_set_irq, msi, ics->nr_irqs=
);

    qemu_register_reset(phb3_msi_reset_handler, dev);
}

static void phb3_msi_instance_init(Object *obj)
{
    ICSState *ics =3D ICS_BASE(obj);

    /* Will be overriden later */
    ics->offset =3D 0;
}

static void phb3_msi_class_init(ObjectClass *klass, void *data)
{
    DeviceClass *dc =3D DEVICE_CLASS(klass);
    ICSStateClass *isc =3D ICS_BASE_CLASS(klass);

    device_class_set_parent_realize(dc, phb3_msi_realize,
                                    &isc->parent_realize);
    device_class_set_parent_reset(dc, phb3_msi_reset,
                                  &isc->parent_reset);

    isc->reject =3D phb3_msi_reject;
    isc->resend =3D phb3_msi_resend;
    isc->print_info =3D phb3_msi_print_info;
}

static const TypeInfo phb3_msi_info =3D {
    .name =3D TYPE_PHB3_MSI,
    .parent =3D TYPE_ICS_BASE,
    .instance_size =3D sizeof(Phb3MsiState),
    .class_init =3D phb3_msi_class_init,
    .class_size =3D sizeof(ICSStateClass),
    .instance_init =3D phb3_msi_instance_init,
};

static void pnv_phb3_msi_register_types(void)
{
    type_register_static(&phb3_msi_info);
}

type_init(pnv_phb3_msi_register_types)

