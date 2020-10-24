Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C43C2D0A3
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 21:42:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACB96208B3
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 21:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQItRiAU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACB96208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWRIV-0004FR-M4
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 17:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWRHa-0003jk-Mx
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 17:41:02 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:46150)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWRHV-0003RB-Nq
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 17:41:02 -0400
Received: by mail-wr1-x432.google.com with SMTP id n6so7216401wrm.13
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2020 14:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:cc:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=HkmKbVJYjp4DqsnsVNLE4OHrPDXjSoeWLNO4q0fJTxU=;
 b=mQItRiAU+p3Omxq34DEVCtOgyFPgjuEgx43m1kmONJOUZL32lF+N30Gxeh8o7aaHSH
 FpMPpe9HdEZaStljqp3VGKjjq69l4QXIqfprChcPPiZY0vtajIvhzOprwqAb+CU5IX8P
 FK5hthFh3QTF7B4LhJ3IBnYtobXBqRnDz/mlvU/lM26deO6mwUS5+V5PQi/ogOj6HPYf
 0ORFh4yAh6DhpDiHwEEq1dpWZXClzHV+cay4P49jedhlbeKtwXblnTL9gNZ/PKMEYpwL
 ew4AzZT/OshzDk9/V4uAh3S1yE13+CxtxsjjmX9/8qPSuOly0uFfD70xR7SQLupDOgv3
 D4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:cc:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HkmKbVJYjp4DqsnsVNLE4OHrPDXjSoeWLNO4q0fJTxU=;
 b=OHNi39C6WMNIg6HKEkYOvQPwiiclxy++neSZx1uIQXtizocfWoXeI3gLkFInqbAcjb
 RguUKZIm67wq4Kqs3wlNLQp6fl5yyMPFhjJuUGzUxPb4Co97DsPvRlqcEpvDYfKOrwHI
 g0pNCX0g1HZ/z9ykkbCknAUK+F9pxFrbXVaOG4ZbcGPwZ58IbKsa8JzC8KySWajbUFzc
 qTtFrONEs2/VWZE4Wl0n6ioYrIAfKGPEFALvFG9B5Igp3SDvMYZdnQe+vupgqumk0GKX
 6fNdWNochmxDeSW7nj61kVHy8cN/iuC0hiXi84eLXxCZaBwFP0INmNO+A6sLb+LR+ZD8
 o1sA==
X-Gm-Message-State: AOAM530V0siLY0sKH8R4zSR3x7J8uQto2wpdtLW1VeDWj3ofkqF5ZR8I
 vQFnOJIdAL/8Vt5XGBvFvHs=
X-Google-Smtp-Source: ABdhPJzBfenovwvDeWkAAUQh65jco8YpOM+8S/W01Ub45ieDym3aZbCEtrmXkvUgLm4muyvPUch33w==
X-Received: by 2002:a5d:43c6:: with SMTP id v6mr9444947wrr.20.1603575655802;
 Sat, 24 Oct 2020 14:40:55 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id c14sm12994121wrv.12.2020.10.24.14.40.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2020 14:40:55 -0700 (PDT)
Subject: Re: [PATCH 11/20] hw/char: Renesas SCI module.
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20200827123859.81793-1-ysato@users.sourceforge.jp>
 <20200827123859.81793-12-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <efd40890-10fb-27ec-cb9e-ee7e553e5bbc@amsat.org>
Date: Sat, 24 Oct 2020 23:40:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20200827123859.81793-12-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x432.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.107,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Marc-André, maintainer of character devices.

On 8/27/20 2:38 PM, Yoshinori Sato wrote:
> This module supported SCI / SCIa / SCIF.
> 
> Hardware manual.
> SCI / SCIF
> https://www.renesas.com/us/en/doc/products/mpumcu/001/r01uh0457ej0401_sh7751.pdf
> SCIa
> https://www.renesas.com/us/en/doc/products/mpumcu/doc/rx_family/r01uh0033ej0140_rx62n.pdf
> 
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>   include/hw/char/renesas_sci.h |  129 +++-
>   hw/char/renesas_sci.c         | 1040 +++++++++++++++++++++++++++------
>   2 files changed, 967 insertions(+), 202 deletions(-)
> 
> diff --git a/include/hw/char/renesas_sci.h b/include/hw/char/renesas_sci.h
> index efdebc620a..07140e8aad 100644
> --- a/include/hw/char/renesas_sci.h
> +++ b/include/hw/char/renesas_sci.h
> @@ -1,51 +1,138 @@
>   /*
>    * Renesas Serial Communication Interface
>    *
> - * Copyright (c) 2018 Yoshinori Sato
> + * Copyright (c) 2020 Yoshinori Sato
> + *
> + * This code is licensed under the GPL version 2 or later.
>    *
> - * SPDX-License-Identifier: GPL-2.0-or-later
>    */
>   
> -#ifndef HW_CHAR_RENESAS_SCI_H
> -#define HW_CHAR_RENESAS_SCI_H
> -
>   #include "chardev/char-fe.h"
> +#include "qemu/timer.h"
> +#include "qemu/fifo8.h"
>   #include "hw/sysbus.h"
> +#include "hw/clock.h"
>   
> +#define TYPE_RENESAS_SCI_COMMON "renesas-sci-common"
> +#define RSCICommon(obj) OBJECT_CHECK(RSCICommonState, (obj), \
> +                                     TYPE_RENESAS_SCI_COMMON)
>   #define TYPE_RENESAS_SCI "renesas-sci"
>   #define RSCI(obj) OBJECT_CHECK(RSCIState, (obj), TYPE_RENESAS_SCI)
> +#define TYPE_RENESAS_SCIA "renesas-scia"
> +#define RSCIA(obj) OBJECT_CHECK(RSCIAState, (obj), TYPE_RENESAS_SCIA)
> +#define TYPE_RENESAS_SCIF "renesas-scif"
> +#define RSCIF(obj) OBJECT_CHECK(RSCIFState, (obj), TYPE_RENESAS_SCIF)
> +
> +#define SCI_GET_CLASS(obj) \
> +    OBJECT_GET_CLASS(RenesasSCICommonClass, obj, TYPE_RENESAS_SCI_COMMON)
> +#define SCI_COMMON_CLASS(klass) \
> +    OBJECT_CLASS_CHECK(RenesasSCICommonClass, klass, TYPE_RENESAS_SCI_COMMON)
> +#define SCI_CLASS(klass) \
> +    OBJECT_CLASS_CHECK(RenesasSCIClass, klass, TYPE_RENESAS_SCI)
> +#define SCIA_CLASS(klass) \
> +    OBJECT_CLASS_CHECK(RenesasSCIAClass, klass, TYPE_RENESAS_SCIA)
> +#define SCIF_CLASS(klass) \
> +    OBJECT_CLASS_CHECK(RenesasSCIFClass, klass, TYPE_RENESAS_SCIF)
>   
>   enum {
>       ERI = 0,
>       RXI = 1,
>       TXI = 2,
> -    TEI = 3,
> -    SCI_NR_IRQ = 4
> +    BRI_TEI = 3,
> +    SCI_NR_IRQ = 4,
>   };
>   
> -typedef struct {
> -    /*< private >*/
> -    SysBusDevice parent_obj;
> -    /*< public >*/
> +enum {
> +    RXTOUT,
> +    RXNEXT,
> +    TXEMPTY,
> +    TXEND,
> +    NR_SCI_EVENT,
> +};
>   
> +typedef struct RSCICommonState {
> +    SysBusDevice parent_obj;
>       MemoryRegion memory;
> -    QEMUTimer timer;
> -    CharBackend chr;
> -    qemu_irq irq[SCI_NR_IRQ];
> +    MemoryRegion memory_p4;
> +    MemoryRegion memory_a7;
>   
> +    /* SCI register */
>       uint8_t smr;
>       uint8_t brr;
>       uint8_t scr;
>       uint8_t tdr;
> -    uint8_t ssr;
> -    uint8_t rdr;
> -    uint8_t scmr;
> -    uint8_t semr;
> +    uint16_t Xsr;
>   
> -    uint8_t read_ssr;
> +    /* internal use */
> +    uint16_t read_Xsr;
> +    int64_t etu;
>       int64_t trtime;
> -    int64_t rx_next;
> +    int64_t tx_start_time;
> +    struct {
> +        int64_t time;
> +        int64_t (*handler)(struct RSCICommonState *sci);
> +    } event[NR_SCI_EVENT];
> +    QEMUTimer *event_timer;
> +    CharBackend chr;
>       uint64_t input_freq;
> +    qemu_irq irq[SCI_NR_IRQ];
> +    Fifo8 rxfifo;
> +    int regshift;
> +    uint32_t unit;
> +    Clock *pck;
> +} RSCICommonState;
> +
> +typedef struct {
> +    RSCICommonState parent_obj;
> +
> +    /* SCI specific register */
> +    uint8_t sptr;
>   } RSCIState;
>   
> -#endif
> +typedef struct {
> +    RSCICommonState parent_obj;
> +
> +    /* SCIa specific register */
> +    uint8_t scmr;
> +    uint8_t semr;
> +} RSCIAState;
> +
> +typedef struct {
> +    RSCICommonState parent_obj;
> +
> +    /* SCIF specific register */
> +    uint16_t fcr;
> +    uint16_t sptr;
> +    uint16_t lsr;
> +
> +    /* internal use */
> +    uint16_t read_lsr;
> +    int tdcnt;
> +} RSCIFState;
> +
> +typedef struct RenesasSCICommonClass {
> +    SysBusDeviceClass parent;
> +
> +    const struct MemoryRegionOps *ops;
> +    void (*irq_fn)(RSCICommonState *sci, int request);
> +    int (*divrate)(RSCICommonState *sci);
> +} RenesasSCICommonClass;
> +
> +typedef struct RenesasSCIClass {
> +    RenesasSCICommonClass parent;
> +
> +    void (*p_irq_fn)(RSCICommonState *sci, int request);
> +} RenesasSCIClass;
> +
> +typedef struct RenesasSCIAClass {
> +    RenesasSCICommonClass parent;
> +
> +    void (*p_irq_fn)(RSCICommonState *sci, int request);
> +    int (*p_divrate)(RSCICommonState *sci);
> +} RenesasSCIAClass;
> +
> +typedef struct RenesasSCIFClass {
> +    RenesasSCICommonClass parent;
> +
> +    void (*p_irq_fn)(RSCICommonState *sci, int request);
> +} RenesasSCIFClass;
> diff --git a/hw/char/renesas_sci.c b/hw/char/renesas_sci.c
> index 5d7c6e6523..24c23709ee 100644
> --- a/hw/char/renesas_sci.c
> +++ b/hw/char/renesas_sci.c
> @@ -1,12 +1,12 @@
>   /*
> - * Renesas Serial Communication Interface
> + * Renesas Serial Communication Interface (SCI / SCIa / SCIF)
>    *
>    * Datasheet: RX62N Group, RX621 Group User's Manual: Hardware
> - *            (Rev.1.40 R01UH0033EJ0140)
> + * (Rev.1.40 R01UH0033EJ0140)
> + * And SH7751 Group, SH7751R Group User's Manual: Hardware
> + * (Rev.4.01 R01UH0457EJ0401)
>    *
> - * Copyright (c) 2019 Yoshinori Sato
> - *
> - * SPDX-License-Identifier: GPL-2.0-or-later
> + * Copyright (c) 2020 Yoshinori Sato
>    *
>    * This program is free software; you can redistribute it and/or modify it
>    * under the terms and conditions of the GNU General Public License,
> @@ -23,14 +23,25 @@
>   
>   #include "qemu/osdep.h"
>   #include "qemu/log.h"
> +#include "qapi/error.h"
> +#include "qemu-common.h"
> +#include "hw/hw.h"
>   #include "hw/irq.h"
> +#include "hw/sysbus.h"
>   #include "hw/registerfields.h"
>   #include "hw/qdev-properties.h"
> +#include "hw/qdev-clock.h"
>   #include "hw/char/renesas_sci.h"
>   #include "migration/vmstate.h"
> +#include "qemu/error-report.h"
>   
> -/* SCI register map */
> -REG8(SMR, 0)
> +/*
> + * SCI register map
> + * SCI(a) register size all 8bit.
> + * SCIF regsister size 8bit and 16bit.
> + * Allocate 16bit to match the larger one.
> + */
> +REG16(SMR, 0) /* 8bit */
>     FIELD(SMR, CKS,  0, 2)
>     FIELD(SMR, MP,   2, 1)
>     FIELD(SMR, STOP, 3, 1)
> @@ -38,263 +49,839 @@ REG8(SMR, 0)
>     FIELD(SMR, PE,   5, 1)
>     FIELD(SMR, CHR,  6, 1)
>     FIELD(SMR, CM,   7, 1)
> -REG8(BRR, 1)
> -REG8(SCR, 2)
> -  FIELD(SCR, CKE,  0, 2)
> +REG16(BRR, 2) /* 8bit */
> +REG16(SCR, 4)
> +  FIELD(SCR, CKE, 0, 2)
>     FIELD(SCR, TEIE, 2, 1)
>     FIELD(SCR, MPIE, 3, 1)
> +  FIELD(SCR, REIE, 3, 1)
>     FIELD(SCR, RE,   4, 1)
>     FIELD(SCR, TE,   5, 1)
>     FIELD(SCR, RIE,  6, 1)
>     FIELD(SCR, TIE,  7, 1)
> -REG8(TDR, 3)
> -REG8(SSR, 4)
> +REG16(TDR, 6) /* 8bit */
> +REG16(SSR, 8) /* 8bit */
>     FIELD(SSR, MPBT, 0, 1)
>     FIELD(SSR, MPB,  1, 1)
>     FIELD(SSR, TEND, 2, 1)
> -  FIELD(SSR, ERR,  3, 3)
> +  FIELD(SSR, ERR, 3, 3)
>       FIELD(SSR, PER,  3, 1)
>       FIELD(SSR, FER,  4, 1)
>       FIELD(SSR, ORER, 5, 1)
>     FIELD(SSR, RDRF, 6, 1)
>     FIELD(SSR, TDRE, 7, 1)
> -REG8(RDR, 5)
> -REG8(SCMR, 6)
> +REG16(FSR, 8)
> +  FIELD(FSR, DR, 0, 1)
> +  FIELD(FSR, RDF, 1, 1)
> +  FIELD(FSR, RDF_DR, 0, 2)
> +  FIELD(FSR, PER, 2, 1)
> +  FIELD(FSR, FER, 3, 1)
> +  FIELD(FSR, BRK, 4, 1)
> +  FIELD(FSR, TDFE, 5, 1)
> +  FIELD(FSR, TEND, 6, 1)
> +  FIELD(FSR, ER, 7, 1)
> +  FIELD(FSR, FERn, 8, 4)
> +  FIELD(FSR, PERn, 12, 4)
> +REG16(RDR, 10) /* 8bit */
> +REG16(SCMR, 12) /* 8bit */
>     FIELD(SCMR, SMIF, 0, 1)
>     FIELD(SCMR, SINV, 2, 1)
>     FIELD(SCMR, SDIR, 3, 1)
>     FIELD(SCMR, BCP2, 7, 1)
> -REG8(SEMR, 7)
> +REG16(FCR, 12)
> +  FIELD(FCR, LOOP, 0, 1)
> +  FIELD(FCR, RFRST, 1, 1)
> +  FIELD(FCR, TFRST, 2, 1)
> +  FIELD(FCR, MCE, 3, 1)
> +  FIELD(FCR, TTRG, 4, 2)
> +  FIELD(FCR, RTRG, 6, 2)
> +  FIELD(FCR, RSTRG, 8, 3)
> +REG16(SEMR, 14) /* 8bit */
>     FIELD(SEMR, ACS0, 0, 1)
>     FIELD(SEMR, ABCS, 4, 1)
> +REG16(FDR, 14)
> +  FIELD(FDR, Rn, 0, 4)
> +  FIELD(FDR, Tn, 8, 4)
> +REG16(SPTR, 16)
> +  FIELD(SPTR, SPB2DT, 0, 1)
> +  FIELD(SPTR, SPB2IO, 1, 1)
> +  FIELD(SPTR, SCKDT, 2, 1)
> +  FIELD(SPTR, SCKIO, 3, 1)
> +  FIELD(SPTR, CTSDT, 4, 1)
> +  FIELD(SPTR, CTSIO, 5, 1)
> +  FIELD(SPTR, RTSDT, 6, 1)
> +  FIELD(SPTR, RTSIO, 7, 1)
> +  FIELD(SPTR, EIO, 7, 1)
> +REG16(LSR, 18)
> +  FIELD(LSR, ORER, 0, 1)
> +
> +#define SCIF_FIFO_DEPTH 16
> +
> +static const int sci_rtrg[] = {1, 4, 8, 14};
>   
> -static int can_receive(void *opaque)
> +static void update_event_time(RSCICommonState *sci, int evt, int64_t t)
>   {
> -    RSCIState *sci = RSCI(opaque);
> -    if (sci->rx_next > qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)) {
> -        return 0;
> +    if (t > 0) {
> +        t +=  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +        sci->event[evt].time = t;
> +        if (timer_expire_time_ns(sci->event_timer) > t) {
> +            timer_mod(sci->event_timer, t);
> +        }
>       } else {
> -        return FIELD_EX8(sci->scr, SCR, RE);
> +        sci->event[evt].time = 0;
> +    }
> +}
> +
> +static void sci_irq(RSCICommonState *sci_common, int req)
> +{
> +    int irq = 0;
> +    int rie;
> +    int tie;
> +    RSCIState *sci = RSCI(sci_common);
> +
> +    rie = FIELD_EX16(sci_common->scr, SCR, RIE);
> +    tie = FIELD_EX16(sci_common->scr, SCR, TIE);
> +    switch (req) {
> +    case ERI:
> +        irq = rie && (FIELD_EX16(sci_common->Xsr, SSR, ERR) != 0);
> +        break;
> +    case RXI:
> +        irq = FIELD_EX16(sci_common->Xsr, SSR, RDRF) && rie  &&
> +            !FIELD_EX16(sci->sptr, SPTR, EIO);
> +        break;
> +    case TXI:
> +        irq = FIELD_EX16(sci_common->Xsr, SSR, TDRE) && tie;
> +        break;
> +    case BRI_TEI:
> +        irq = FIELD_EX16(sci_common->Xsr, SSR, TEND) &&
> +            FIELD_EX16(sci_common->scr, SCR, TEIE);
> +        break;
>       }
> +    qemu_set_irq(sci_common->irq[req], irq);
>   }
>   
> -static void receive(void *opaque, const uint8_t *buf, int size)
> +static void scia_irq(RSCICommonState *sci, int req)
>   {
> -    RSCIState *sci = RSCI(opaque);
> -    sci->rx_next = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + sci->trtime;
> -    if (FIELD_EX8(sci->ssr, SSR, RDRF) || size > 1) {
> -        sci->ssr = FIELD_DP8(sci->ssr, SSR, ORER, 1);
> -        if (FIELD_EX8(sci->scr, SCR, RIE)) {
> -            qemu_set_irq(sci->irq[ERI], 1);
> +    int irq = 0;
> +    int rie;
> +    int tie;
> +
> +    rie = FIELD_EX16(sci->scr, SCR, RIE);
> +    tie = FIELD_EX16(sci->scr, SCR, TIE);
> +    switch (req) {
> +    case ERI:
> +        irq = (FIELD_EX16(sci->Xsr, SSR, ERR) != 0) && rie;
> +        qemu_set_irq(sci->irq[req], irq);
> +        break;
> +    case RXI:
> +        if (FIELD_EX16(sci->Xsr, SSR, RDRF) && rie) {
> +            qemu_irq_pulse(sci->irq[req]);
>           }
> -    } else {
> -        sci->rdr = buf[0];
> -        sci->ssr = FIELD_DP8(sci->ssr, SSR, RDRF, 1);
> -        if (FIELD_EX8(sci->scr, SCR, RIE)) {
> -            qemu_irq_pulse(sci->irq[RXI]);
> +        break;
> +    case TXI:
> +        if (FIELD_EX16(sci->Xsr, SSR, TDRE) && tie) {
> +            qemu_irq_pulse(sci->irq[req]);
>           }
> +        break;
> +    case BRI_TEI:
> +        irq = FIELD_EX16(sci->Xsr, SSR, TEND) &&
> +            FIELD_EX16(sci->scr, SCR, TEIE);
> +        qemu_set_irq(sci->irq[req], irq);
> +        break;
> +    }
> +}
> +
> +static void scif_irq(RSCICommonState *sci, int req)
> +{
> +    int irq = 0;
> +    int rie;
> +    int reie;
> +    int tie;
> +
> +    rie = FIELD_EX16(sci->scr, SCR, RIE);
> +    reie = FIELD_EX16(sci->scr, SCR, REIE);
> +    tie = FIELD_EX16(sci->scr, SCR, TIE);
> +    switch (req) {
> +    case ERI:
> +        irq = (rie || reie) && FIELD_EX16(sci->Xsr, FSR, ER);
> +        break;
> +    case RXI:
> +        irq = (FIELD_EX16(sci->Xsr, FSR, RDF_DR) != 0) && rie;
> +        break;
> +    case TXI:
> +        irq = FIELD_EX16(sci->Xsr, FSR, TDFE) & tie;
> +        break;
> +    case BRI_TEI:
> +        irq = (rie || reie) && FIELD_EX16(sci->Xsr, FSR, BRK);
> +        break;
>       }
> +    qemu_set_irq(sci->irq[req], irq);
>   }
>   
> -static void send_byte(RSCIState *sci)
> +static int sci_can_receive(void *opaque)
> +{
> +    RSCICommonState *sci = RSCICommon(opaque);
> +    int fifo_free = 0;
> +    if (clock_is_enabled(sci->pck) && FIELD_EX16(sci->scr, SCR, RE)) {
> +        /* Receiver enabled */
> +        fifo_free = fifo8_num_free(&sci->rxfifo);
> +    }
> +    return fifo_free;
> +}
> +
> +static void sci_receive(void *opaque, const uint8_t *buf, int size)
> +{
> +    RSCICommonState *sci = RSCICommon(opaque);
> +    RenesasSCICommonClass *rc = SCI_GET_CLASS(sci);
> +    fifo8_push_all(&sci->rxfifo, buf, size);
> +    if (sci->event[RXNEXT].time == 0) {
> +        sci->Xsr = FIELD_DP16(sci->Xsr, SSR, RDRF, 1);
> +        update_event_time(sci, RXNEXT, sci->trtime);
> +        rc->irq_fn(sci, RXI);
> +    }
> +}
> +
> +static int scif_can_receive(void *opaque)
> +{
> +    RSCIFState *scif = RSCIF(opaque);
> +    RSCICommonState *sci = RSCICommon(opaque);
> +    int fifo_free = 0;
> +    if (clock_is_enabled(sci->pck) && FIELD_EX16(sci->scr, SCR, RE)) {
> +        /* Receiver enabled */
> +        fifo_free = fifo8_num_free(&sci->rxfifo);
> +        if (fifo_free == 0) {
> +            /* FIFO overrun */
> +            scif->lsr = FIELD_DP16(scif->lsr, LSR, ORER, 1);
> +            scif_irq(sci, ERI);
> +        }
> +    }
> +    return fifo_free;
> +}
> +
> +static void scif_receive(void *opaque, const uint8_t *buf, int size)
> +{
> +    RSCIFState *scif = RSCIF(opaque);
> +    RSCICommonState *sci = RSCICommon(opaque);
> +    int rtrg;
> +
> +    fifo8_push_all(&sci->rxfifo, buf, size);
> +    if (sci->event[RXNEXT].time == 0) {
> +        rtrg = sci_rtrg[FIELD_EX16(scif->fcr, FCR, RTRG)];
> +        if (fifo8_num_used(&sci->rxfifo) >= rtrg) {
> +            sci->Xsr = FIELD_DP16(sci->Xsr, FSR, RDF, 1);
> +        } else {
> +            update_event_time(sci, RXTOUT, 15 * sci->etu);
> +        }
> +        scif_irq(sci, RXI);
> +    }
> +}
> +
> +static void sci_send_byte(RSCICommonState *sci)
>   {
>       if (qemu_chr_fe_backend_connected(&sci->chr)) {
>           qemu_chr_fe_write_all(&sci->chr, &sci->tdr, 1);
>       }
> -    timer_mod(&sci->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + sci->trtime);
> -    sci->ssr = FIELD_DP8(sci->ssr, SSR, TEND, 0);
> -    sci->ssr = FIELD_DP8(sci->ssr, SSR, TDRE, 1);
> -    qemu_set_irq(sci->irq[TEI], 0);
> -    if (FIELD_EX8(sci->scr, SCR, TIE)) {
> -        qemu_irq_pulse(sci->irq[TXI]);
> +    sci->Xsr = FIELD_DP16(sci->Xsr, SSR, TEND, 0);
> +    sci->Xsr = FIELD_DP16(sci->Xsr, SSR, TDRE, 1);
> +}
> +
> +static int transmit_byte(RSCIFState *scif)
> +{
> +    RSCICommonState *sci = RSCICommon(scif);
> +    int64_t elapsed;
> +    int byte = 0;
> +    if (sci->tx_start_time > 0) {
> +        elapsed = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) - sci->tx_start_time;
> +        byte = elapsed / sci->trtime;
> +        if (byte > scif->tdcnt) {
> +            byte = scif->tdcnt;
> +        }
>       }
> +    return byte;
>   }
>   
> -static void txend(void *opaque)
> +static int64_t scif_rx_timeout(RSCICommonState *sci)
>   {
> -    RSCIState *sci = RSCI(opaque);
> -    if (!FIELD_EX8(sci->ssr, SSR, TDRE)) {
> -        send_byte(sci);
> +    sci->Xsr = FIELD_DP16(sci->Xsr, FSR, DR, 1);
> +    scif_irq(sci, RXI);
> +    return 0;
> +}
> +
> +static int64_t sci_rx_next(RSCICommonState *sci)
> +{
> +    int64_t next_event = 0;
> +    RenesasSCICommonClass *rc = SCI_GET_CLASS(sci);
> +    if (!fifo8_is_empty(&sci->rxfifo)) {
> +        if (FIELD_EX16(sci->Xsr, SSR, RDRF)) {
> +            /* Receiver overrun */
> +            sci->Xsr = FIELD_DP16(sci->Xsr, SSR, ORER, 1);
> +            rc->irq_fn(sci, ERI);
> +        } else {
> +            /* Trigger next event */
> +            sci->Xsr = FIELD_DP16(sci->Xsr, SSR, RDRF, 1);
> +            rc->irq_fn(sci, RXI);
> +            next_event = sci->trtime;
> +        }
> +    }
> +    return next_event;
> +}
> +
> +static int64_t sci_tx_empty(RSCICommonState *sci)
> +{
> +    int64_t ret = 0;
> +    RenesasSCICommonClass *rc = SCI_GET_CLASS(sci);
> +    if (!FIELD_EX16(sci->Xsr, SSR, TDRE)) {
> +        sci_send_byte(sci);
> +        ret = sci->trtime;
> +        rc->irq_fn(sci, TXI);
>       } else {
> -        sci->ssr = FIELD_DP8(sci->ssr, SSR, TEND, 1);
> -        if (FIELD_EX8(sci->scr, SCR, TEIE)) {
> -            qemu_set_irq(sci->irq[TEI], 1);
> +        sci->Xsr = FIELD_DP16(sci->Xsr, SSR, TEND, 1);
> +        rc->irq_fn(sci, BRI_TEI);
> +    }
> +    return ret;
> +}
> +
> +static int64_t scif_tx_empty(RSCICommonState *sci)
> +{
> +    RSCIFState *scif = RSCIF(sci);
> +    scif->tdcnt -= transmit_byte(scif);
> +    sci->Xsr = FIELD_DP16(sci->Xsr, FSR, TDFE, 1);
> +    scif_irq(sci, TXI);
> +    return 0;
> +}
> +
> +static int64_t scif_tx_end(RSCICommonState *sci)
> +{
> +    RSCIFState *scif = RSCIF(sci);
> +    scif->tdcnt = 0;
> +    sci->Xsr = FIELD_DP16(sci->Xsr, FSR, TEND, 1);
> +    return 0;
> +}
> +
> +static void sci_timer_event(void *opaque)
> +{
> +    RSCICommonState *sci = RSCICommon(opaque);
> +    int64_t now, next, t;
> +    int i;
> +
> +    now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +    next = INT64_MAX;
> +    for (i = 0; i < NR_SCI_EVENT; i++) {
> +        if (sci->event[i].time > 0 && sci->event[i].time <= now) {
> +            t = sci->event[i].handler(sci);
> +            sci->event[i].time = (t > 0) ? now + t : 0;
> +        }
> +        if (sci->event[i].time > 0) {
> +            next = MIN(next, sci->event[i].time);
>           }
>       }
> +    if (next < INT64_MAX) {
> +        timer_mod(sci->event_timer, next);
> +    } else {
> +        timer_del(sci->event_timer);
> +    }
>   }
>   
> -static void update_trtime(RSCIState *sci)
> +static int static_divrate(RSCICommonState *sci)
>   {
> -    /* char per bits */
> -    sci->trtime = 8 - FIELD_EX8(sci->smr, SMR, CHR);
> -    sci->trtime += FIELD_EX8(sci->smr, SMR, PE);
> -    sci->trtime += FIELD_EX8(sci->smr, SMR, STOP) + 1;
> -    /* x bit transmit time (32 * divrate * brr) / base freq */
> -    sci->trtime *= 32 * sci->brr;
> -    sci->trtime *= 1 << (2 * FIELD_EX8(sci->smr, SMR, CKS));
> -    sci->trtime *= NANOSECONDS_PER_SECOND;
> -    sci->trtime /= sci->input_freq;
> +    /* SCI / SCIF have static divide rate */
> +    return 32;
>   }
>   
> -static bool sci_is_tr_enabled(RSCIState *sci)
> +static int scia_divrate(RSCICommonState *sci)
>   {
> -    return FIELD_EX8(sci->scr, SCR, TE) || FIELD_EX8(sci->scr, SCR, RE);
> +    /*
> +     * SEMR.ABCS = 0 -> 32
> +     * SEMR.ABCS = 1 -> 16
> +     */
> +    RSCIAState *scia = RSCIA(sci);
> +    return 16 * (2 - FIELD_EX8(scia->semr, SEMR, ABCS));
>   }
>   
> -static void sci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
> +static void update_trtime(RSCICommonState *sci)
>   {
> -    RSCIState *sci = RSCI(opaque);
> +    RenesasSCICommonClass *rc = SCI_GET_CLASS(sci);
> +    int cks = 1 << (2 * FIELD_EX16(sci->smr, SMR, CKS));
> +    if (sci->input_freq > 0) {
> +        /* x bit transmit time (divrate * brr) / base freq */
> +        sci->etu = rc->divrate(sci) * cks;
> +        sci->etu *= sci->brr + 1;
> +        sci->etu *= NANOSECONDS_PER_SECOND;
> +        sci->etu /= sci->input_freq;
>   
> -    switch (offset) {
> -    case A_SMR:
> -        if (!sci_is_tr_enabled(sci)) {
> -            sci->smr = val;
> -            update_trtime(sci);
> +        /* char per bits */
> +        sci->trtime = 8 - FIELD_EX16(sci->smr, SMR, CHR);
> +        sci->trtime += FIELD_EX16(sci->smr, SMR, PE);
> +        sci->trtime += FIELD_EX16(sci->smr, SMR, STOP) + 1 + 1;
> +        sci->trtime *= sci->etu;
> +    }
> +}
> +
> +static void sci_pck_update(void *opaque)
> +{
> +    RSCICommonState *sci = RSCICommon(opaque);
> +
> +    sci->input_freq = clock_get_hz(sci->pck);
> +    update_trtime(sci);
> +}
> +
> +#define IS_TR_ENABLED(scr) \
> +    (FIELD_EX16(scr, SCR, TE) || FIELD_EX16(scr, SCR, RE))
> +
> +static hwaddr map_address(RSCICommonState *sci, hwaddr addr)
> +{
> +    return (addr << 1) >> sci->regshift;
> +}
> +
> +static void sci_common_write(void *opaque, hwaddr addr,
> +                             uint64_t val, unsigned size)
> +{
> +    RSCICommonState *sci = RSCICommon(opaque);
> +    RenesasSCICommonClass *rc = SCI_GET_CLASS(opaque);
> +    switch (addr) {
> +    case A_SCR:
> +        sci->scr = val;
> +        if (FIELD_EX16(sci->scr, SCR, TE)) {
> +            /* Transmitter enable */
> +            sci->Xsr = FIELD_DP16(sci->Xsr, SSR, TDRE, 1);
> +            sci->Xsr = FIELD_DP16(sci->Xsr, SSR, TEND, 1);
> +            rc->irq_fn(sci, TXI);
> +            rc->irq_fn(sci, BRI_TEI);
> +        } else {
> +            /* Transmitter disable  */
> +            update_event_time(sci, TXEND, 0);
> +            update_event_time(sci, TXEMPTY, 0);
>           }
>           break;
> +    case A_SMR:
> +        sci->smr = val;
> +        update_trtime(sci);
> +        break;
>       case A_BRR:
> -        if (!sci_is_tr_enabled(sci)) {
> -            sci->brr = val;
> -            update_trtime(sci);
> -        }
> +        sci->brr = val;
> +        update_trtime(sci);
>           break;
> -    case A_SCR:
> -        sci->scr = val;
> -        if (FIELD_EX8(sci->scr, SCR, TE)) {
> -            sci->ssr = FIELD_DP8(sci->ssr, SSR, TDRE, 1);
> -            sci->ssr = FIELD_DP8(sci->ssr, SSR, TEND, 1);
> -            if (FIELD_EX8(sci->scr, SCR, TIE)) {
> -                qemu_irq_pulse(sci->irq[TXI]);
> -            }
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "renesas_sci: Register 0x%" HWADDR_PRIX
> +                      " not implemented\n", addr);
> +    }
> +}
> +
> +static void sci_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
> +{
> +    RSCICommonState *sci = RSCICommon(opaque);
> +    RenesasSCICommonClass *rc = SCI_GET_CLASS(sci);
> +    bool tx_start;
> +
> +    if (!clock_is_enabled(sci->pck)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "renesas_sci: SCI %d is stopped.\n",
> +                      sci->unit);
> +        return ;
> +    }
> +    addr = map_address(sci, addr);
> +    switch (addr) {
> +    case A_TDR:
> +        sci->tdr = val;
> +        break;
> +    case A_SSR:
> +        /* Mask for read only bits */
> +        sci->Xsr = FIELD_DP16(RSCICommon(sci)->Xsr, SSR, MPBT,
> +                              FIELD_EX16(val, SSR, MPBT));
> +        sci->Xsr &= (val | 0x07);
> +        /* Clear ERI */
> +        rc->irq_fn(sci, ERI);
> +        tx_start = FIELD_EX16(sci->read_Xsr, SSR, TDRE) &&
> +            !FIELD_EX16(sci->Xsr, SSR, TDRE) &&
> +            (FIELD_EX16(sci->Xsr, SSR, ERR) == 0);
> +        if (tx_start) {
> +            sci_send_byte(sci);
> +            update_event_time(sci, TXEMPTY, sci->trtime);
> +            rc->irq_fn(sci, TXI);
>           }
> -        if (!FIELD_EX8(sci->scr, SCR, TEIE)) {
> -            qemu_set_irq(sci->irq[TEI], 0);
> +        break;
> +    case A_SPTR:
> +        RSCI(sci)->sptr = val;
> +        break;
> +    default:
> +        sci_common_write(sci, addr, val, size);
> +    }
> +}
> +
> +static void scia_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
> +{
> +    RSCICommonState *sci = RSCICommon(opaque);
> +    RSCIAState *scia = RSCIA(opaque);
> +
> +    if (!clock_is_enabled(sci->pck)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "renesas_sci: SCIa %d is stopped.\n",
> +                      sci->unit);
> +        return ;
> +    }
> +    addr = map_address(sci, addr);
> +    switch (addr) {
> +    case A_SMR:
> +        if (IS_TR_ENABLED(sci->scr)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "reneas_sci: SMR write protected.\n");
> +        } else {
> +            sci_common_write(sci, addr, val, size);
>           }
> -        if (!FIELD_EX8(sci->scr, SCR, RIE)) {
> -            qemu_set_irq(sci->irq[ERI], 0);
> +        break;
> +    case A_BRR:
> +        if (IS_TR_ENABLED(sci->scr)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "reneas_sci: BRR write protected.\n");
> +            break;
> +        } else {
> +            sci_common_write(sci, addr, val, size);
>           }
>           break;
>       case A_TDR:
>           sci->tdr = val;
> -        if (FIELD_EX8(sci->ssr, SSR, TEND)) {
> -            send_byte(sci);
> +        if (FIELD_EX16(sci->Xsr, SSR, TEND)) {
> +            update_event_time(sci, TXEMPTY, sci->trtime);
> +            sci_send_byte(sci);
>           } else {
> -            sci->ssr = FIELD_DP8(sci->ssr, SSR, TDRE, 0);
> +            sci->Xsr = FIELD_DP16(sci->Xsr, SSR, TDRE, 0);
>           }
> +        scia_irq(sci, TXI);
> +        scia_irq(sci, BRI_TEI);
>           break;
>       case A_SSR:
> -        sci->ssr = FIELD_DP8(sci->ssr, SSR, MPBT,
> -                             FIELD_EX8(val, SSR, MPBT));
> -        sci->ssr = FIELD_DP8(sci->ssr, SSR, ERR,
> -                             FIELD_EX8(val, SSR, ERR) & 0x07);
> -        if (FIELD_EX8(sci->read_ssr, SSR, ERR) &&
> -            FIELD_EX8(sci->ssr, SSR, ERR) == 0) {
> -            qemu_set_irq(sci->irq[ERI], 0);
> -        }
> -        break;
> -    case A_RDR:
> -        qemu_log_mask(LOG_GUEST_ERROR, "reneas_sci: RDR is read only.\n");
> +        /* Mask for read only bits */
> +        sci->Xsr = FIELD_DP16(sci->Xsr, SSR, MPBT,
> +                              FIELD_EX16(val, SSR, MPBT));
> +        sci->Xsr &= (val | 0xc7);
> +        /* Clear ERI */
> +        scia_irq(sci, ERI);
>           break;
>       case A_SCMR:
> -        sci->scmr = val; break;
> -    case A_SEMR: /* SEMR */
> -        sci->semr = val; break;
> +        scia->scmr = val;
> +        break;
> +    case A_SEMR:
> +        scia->semr = val;
> +        break;
>       default:
> -        qemu_log_mask(LOG_UNIMP, "renesas_sci: Register 0x%" HWADDR_PRIX " "
> -                                 "not implemented\n",
> -                      offset);
> +        sci_common_write(sci, addr, val, size);
> +        break;
>       }
>   }
>   
> -static uint64_t sci_read(void *opaque, hwaddr offset, unsigned size)
> +static void scif_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
>   {
> -    RSCIState *sci = RSCI(opaque);
> +    RSCICommonState *sci = RSCICommon(opaque);
> +    RSCIFState *scif = RSCIF(opaque);
> +    int txtrg;
> +    int rxtrg;
> +    uint16_t ssr_mask;
> +    uint8_t txd;
> +
> +    if (!clock_is_enabled(sci->pck)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "renesas_sci: SCIF %d is stopped.\n",
> +                      sci->unit);
> +        return ;
> +    }
> +    txtrg = 1 << (3 - FIELD_EX16(scif->fcr, FCR, TTRG));
> +    addr = map_address(sci, addr);
> +    switch (addr) {
> +    case A_SCR:
> +        sci->scr = val;
> +        if (FIELD_EX16(sci->scr, SCR, TE)) {
> +            /* Transmitter enable */
> +            sci->Xsr = FIELD_DP16(sci->Xsr, FSR, TEND, 1);
> +            sci->Xsr = FIELD_DP16(sci->Xsr, FSR, TDFE, 1);
> +            sci->tx_start_time = 0;
> +            scif_irq(sci, TXI);
> +        } else {
> +            /* Transmitter disable  */
> +            update_event_time(sci, TXEND, 0);
> +            update_event_time(sci, TXEMPTY, 0);
> +        }
> +        break;
> +    case A_TDR:
> +        if (sci->tx_start_time > 0) {
> +            scif->tdcnt -= transmit_byte(scif);
> +        } else {
> +            sci->tx_start_time = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +        }
> +        if (scif->tdcnt >= SCIF_FIFO_DEPTH) {
> +            break;
> +        }
> +        txd = val;
> +        if (qemu_chr_fe_backend_connected(&sci->chr)) {
> +            qemu_chr_fe_write_all(&sci->chr, &txd, 1);
> +        }
> +        if (FIELD_EX16(scif->fcr, FCR, LOOP) && scif_can_receive(sci) > 0) {
> +            /* Loopback mode */
> +            scif_receive(sci, &txd, 1);
> +        }
> +        scif->tdcnt++;
> +        sci->Xsr = FIELD_DP16(sci->Xsr, FSR, TEND, 0);
> +        update_event_time(sci, TXEND, scif->tdcnt);
> +        if (scif->tdcnt > txtrg) {
> +            sci->Xsr = FIELD_DP16(sci->Xsr, FSR, TDFE, 0);
> +            update_event_time(sci, TXEMPTY, scif->tdcnt - txtrg + 1);
> +            scif_irq(sci, TXI);
> +        }
> +        break;
> +    case A_FSR:
> +        rxtrg = sci_rtrg[FIELD_EX16(scif->fcr, FCR, RTRG)];
> +        ssr_mask = ~(sci->read_Xsr & 0xf3);
> +        scif->tdcnt -= transmit_byte(scif);
> +        if (scif->tdcnt < txtrg) {
> +            ssr_mask = FIELD_DP16(ssr_mask, FSR, TDFE, 1);
> +        }
> +        if (fifo8_num_used(&sci->rxfifo) >= rxtrg) {
> +            ssr_mask = FIELD_DP16(ssr_mask, FSR, RDF, 1);
> +        }
> +        sci->Xsr &= (val | ssr_mask);
> +        scif_irq(sci, ERI);
> +        scif_irq(sci, RXI);
> +        scif_irq(sci, TXI);
> +        break;
> +    case A_FCR:
> +        scif->fcr = val;
> +        if (FIELD_EX16(scif->fcr, FCR, RFRST)) {
> +            fifo8_reset(&sci->rxfifo);
> +            update_event_time(sci, RXTOUT, 0);
> +            update_event_time(sci, RXNEXT, 0);
> +        }
> +        if (FIELD_EX16(scif->fcr, FCR, TFRST)) {
> +            scif->tdcnt = 0;
> +        }
> +        break;
> +    case A_FDR:
> +        qemu_log_mask(LOG_GUEST_ERROR, "reneas_sci: FDR is read only.\n");
> +        break;
> +    case A_SPTR:
> +        scif->sptr = val;
> +        break;
> +    case A_LSR:
> +        if (FIELD_EX16(scif->read_lsr, LSR, ORER) != 1) {
> +            val = FIELD_DP16(val, LSR, ORER, 1);
> +        }
> +        scif->lsr &= val;
> +        scif_irq(sci, ERI);
> +        break;
> +    default:
> +        sci_common_write(sci, addr, val, size);
> +        break;
> +    }
> +}
>   
> -    switch (offset) {
> +static uint64_t sci_common_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    RSCICommonState *sci = RSCICommon(opaque);
> +    switch (addr) {
>       case A_SMR:
>           return sci->smr;
>       case A_BRR:
>           return sci->brr;
>       case A_SCR:
>           return sci->scr;
> -    case A_TDR:
> -        return sci->tdr;
> -    case A_SSR:
> -        sci->read_ssr = sci->ssr;
> -        return sci->ssr;
> +    case A_FSR: /* A_SSR */
> +        sci->read_Xsr = sci->Xsr;
> +        return sci->Xsr;
>       case A_RDR:
> -        sci->ssr = FIELD_DP8(sci->ssr, SSR, RDRF, 0);
> -        return sci->rdr;
> -    case A_SCMR:
> -        return sci->scmr;
> -    case A_SEMR:
> -        return sci->semr;
> +        return fifo8_pop(&sci->rxfifo);
>       default:
>           qemu_log_mask(LOG_UNIMP, "renesas_sci: Register 0x%" HWADDR_PRIX
> -                      " not implemented.\n", offset);
> +                      " not implemented.\n", addr);
>       }
>       return UINT64_MAX;
>   }
>   
> -static const MemoryRegionOps sci_ops = {
> -    .write = sci_write,
> -    .read  = sci_read,
> -    .endianness = DEVICE_NATIVE_ENDIAN,
> -    .impl.max_access_size = 1,
> -    .valid.max_access_size = 1,
> -};
> +static uint64_t sci_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    RSCICommonState *sci = RSCICommon(opaque);
> +    addr = map_address(sci, addr);
> +
> +    if (clock_is_enabled(sci->pck)) {
> +        switch (addr) {
> +        case A_TDR:
> +            return sci->tdr;
> +        case A_SPTR:
> +            return RSCI(sci)->sptr;
> +        default:
> +            return sci_common_read(sci, addr, size);
> +        }
> +    } else {
> +        qemu_log_mask(LOG_GUEST_ERROR, "renesas_sci: SCI %d is stopped.\n",
> +                      sci->unit);
> +    }
> +    return UINT64_MAX;
> +}
>   
> -static void rsci_reset(DeviceState *dev)
> +static uint64_t scia_read(void *opaque, hwaddr addr, unsigned size)
>   {
> -    RSCIState *sci = RSCI(dev);
> -    sci->smr = sci->scr = 0x00;
> -    sci->brr = 0xff;
> -    sci->tdr = 0xff;
> -    sci->rdr = 0x00;
> -    sci->ssr = 0x84;
> -    sci->scmr = 0x00;
> -    sci->semr = 0x00;
> -    sci->rx_next = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +    RSCICommonState *sci = RSCICommon(opaque);
> +    RSCIAState *scia = RSCIA(opaque);
> +    uint64_t ret;
> +
> +    if (clock_is_enabled(sci->pck)) {
> +        addr = map_address(sci, addr);
> +        switch (addr) {
> +        case A_TDR:
> +            return sci->tdr;
> +        case A_RDR:
> +            ret = fifo8_pop(&sci->rxfifo);
> +            sci->Xsr = FIELD_DP16(sci->Xsr, SSR, RDRF, 0);
> +            return ret;
> +        case A_SCMR:
> +            return scia->scmr;
> +        default:
> +            return sci_common_read(sci, addr, size);
> +        }
> +    } else {
> +        qemu_log_mask(LOG_GUEST_ERROR, "renesas_sci: SCIa %d is stopped.\n",
> +                      sci->unit);
> +    }
> +    return UINT64_MAX;
> +}
> +
> +static uint64_t scif_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    RSCIFState *scif = RSCIF(opaque);
> +    RSCICommonState *sci = RSCICommon(opaque);
> +    uint64_t ret;
> +
> +    if (clock_is_enabled(sci->pck)) {
> +        addr = map_address(sci, addr);
> +        switch (addr) {
> +        case A_FCR:
> +            return scif->fcr & 0x7ff;
> +        case A_FDR:
> +            ret = 0;
> +            ret = FIELD_DP16(ret, FDR, Rn, fifo8_num_used(&sci->rxfifo));
> +            ret = FIELD_DP16(ret, FDR, Tn, scif->tdcnt - transmit_byte(scif));
> +            return ret;
> +        case A_SPTR:
> +            return scif->sptr;
> +        case A_LSR:
> +            scif->read_lsr = scif->lsr;
> +            return scif->lsr;
> +        default:
> +            return sci_common_read(sci, addr, size);
> +        }
> +    } else {
> +        qemu_log_mask(LOG_GUEST_ERROR, "renesas_sci: SCIF %d is stopped.\n",
> +                      sci->unit);
> +    }
> +    return UINT64_MAX;
> +}
> +
> +static void rsci_common_init(Object *obj)
> +{
> +    RSCICommonState *sci = RSCICommon(obj);
> +    SysBusDevice *d = SYS_BUS_DEVICE(obj);
> +    int i;
> +
> +    for (i = 0; i < SCI_NR_IRQ; i++) {
> +        sysbus_init_irq(d, &sci->irq[i]);
> +    }
> +    fifo8_create(&sci->rxfifo, SCIF_FIFO_DEPTH);
> +    sci->event_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, sci_timer_event, sci);
> +    sci->pck = qdev_init_clock_in(DEVICE(d), "pck",
> +                                  sci_pck_update, sci);
>   }
>   
>   static void sci_event(void *opaque, QEMUChrEvent event)
>   {
> -    RSCIState *sci = RSCI(opaque);
> +    RSCICommonState *sci = RSCICommon(opaque);
> +    RenesasSCICommonClass *rc = SCI_GET_CLASS(sci);
> +    if (clock_is_enabled(sci->pck) && event == CHR_EVENT_BREAK) {
> +        sci->Xsr = FIELD_DP16(sci->Xsr, SSR, FER, 1);
> +        rc->irq_fn(sci, BRI_TEI);
> +    }
> +}
> +
> +static void scif_event(void *opaque, QEMUChrEvent event)
> +{
> +    RSCICommonState *sci = RSCICommon(opaque);
>       if (event == CHR_EVENT_BREAK) {
> -        sci->ssr = FIELD_DP8(sci->ssr, SSR, FER, 1);
> -        if (FIELD_EX8(sci->scr, SCR, RIE)) {
> -            qemu_set_irq(sci->irq[ERI], 1);
> -        }
> +        sci->Xsr = FIELD_DP16(sci->Xsr, FSR, BRK, 1);
> +        scif_irq(sci, BRI_TEI);
>       }
>   }
>   
> -static void rsci_realize(DeviceState *dev, Error **errp)
> +static void rsci_common_realize(DeviceState *dev, Error **errp)
>   {
> -    RSCIState *sci = RSCI(dev);
> +    RSCICommonState *sci = RSCICommon(dev);
>   
> -    if (sci->input_freq == 0) {
> +    if (sci->regshift != 8 && sci->regshift != 16 && sci->regshift != 32) {
>           qemu_log_mask(LOG_GUEST_ERROR,
> -                      "renesas_sci: input-freq property must be set.");
> +                      "renesas_sci: Invalid register size.");
>           return;
>       }
> -    qemu_chr_fe_set_handlers(&sci->chr, can_receive, receive,
> -                             sci_event, NULL, sci, NULL, true);
> +
> +    sci->regshift = sci->regshift / 8 - 1;
> +    sci->smr = sci->scr = 0x00;
> +    sci->brr = 0xff;
> +    sci->tdr = 0xff;
> +    sci->Xsr = 0x84;
> +    update_trtime(sci);
> +
>   }
>   
> -static void rsci_init(Object *obj)
> +static void register_mmio(RSCICommonState *sci, int size)
>   {
> -    SysBusDevice *d = SYS_BUS_DEVICE(obj);
> -    RSCIState *sci = RSCI(obj);
> -    int i;
> +    SysBusDevice *d = SYS_BUS_DEVICE(sci);
> +    RenesasSCICommonClass *rc = SCI_GET_CLASS(sci);
>   
> -    memory_region_init_io(&sci->memory, OBJECT(sci), &sci_ops,
> -                          sci, "renesas-sci", 0x8);
> +    memory_region_init_io(&sci->memory, OBJECT(sci), rc->ops,
> +                          sci, "renesas-sci", size);
>       sysbus_init_mmio(d, &sci->memory);
> +    memory_region_init_alias(&sci->memory_p4, NULL, "renesas-sci-p4",
> +                             &sci->memory, 0, size);
> +    sysbus_init_mmio(d, &sci->memory_p4);
> +    memory_region_init_alias(&sci->memory_a7, NULL, "renesas-sci-a7",
> +                             &sci->memory, 0, size);
> +    sysbus_init_mmio(d, &sci->memory_a7);
> +}
>   
> -    for (i = 0; i < SCI_NR_IRQ; i++) {
> -        sysbus_init_irq(d, &sci->irq[i]);
> -    }
> -    timer_init_ns(&sci->timer, QEMU_CLOCK_VIRTUAL, txend, sci);
> +static void rsci_realize(DeviceState *dev, Error **errp)
> +{
> +    RSCIState *sci = RSCI(dev);
> +    RSCICommonState *common = RSCICommon(dev);
> +
> +    rsci_common_realize(dev, errp);
> +
> +    register_mmio(common, 8 * (1 << common->regshift));
> +    qemu_chr_fe_set_handlers(&common->chr, sci_can_receive, sci_receive,
> +                             sci_event, NULL, sci, NULL, true);
> +
> +    sci->sptr = 0x00;
> +}
> +
> +static void rscia_realize(DeviceState *dev, Error **errp)
> +{
> +    RSCIAState *sci = RSCIA(dev);
> +    RSCICommonState *common = RSCICommon(dev);
> +
> +    rsci_common_realize(dev, errp);
> +
> +    register_mmio(common, 8 * (1 << common->regshift));
> +    qemu_chr_fe_set_handlers(&common->chr, sci_can_receive, sci_receive,
> +                             sci_event, NULL, sci, NULL, true);
> +
> +    sci->scmr = 0x00;
> +    sci->semr = 0x00;
> +}
> +
> +static void rscif_realize(DeviceState *dev, Error **errp)
> +{
> +    RSCIFState *sci = RSCIF(dev);
> +    RSCICommonState *common = RSCICommon(sci);
> +
> +    rsci_common_realize(dev, errp);
> +
> +    register_mmio(common, 10 * (1 << common->regshift));
> +    qemu_chr_fe_set_handlers(&common->chr, scif_can_receive, scif_receive,
> +                             scif_event, NULL, sci, NULL, true);
> +    common->Xsr = 0x0060;
> +    sci->fcr = 0x0000;
> +    sci->sptr = 0x0000;
> +    sci->lsr = 0x0000;
>   }
>   
>   static const VMStateDescription vmstate_rsci = {
> @@ -302,49 +889,140 @@ static const VMStateDescription vmstate_rsci = {
>       .version_id = 1,
>       .minimum_version_id = 1,
>       .fields = (VMStateField[]) {
> -        VMSTATE_INT64(trtime, RSCIState),
> -        VMSTATE_INT64(rx_next, RSCIState),
> -        VMSTATE_UINT8(smr, RSCIState),
> -        VMSTATE_UINT8(brr, RSCIState),
> -        VMSTATE_UINT8(scr, RSCIState),
> -        VMSTATE_UINT8(tdr, RSCIState),
> -        VMSTATE_UINT8(ssr, RSCIState),
> -        VMSTATE_UINT8(rdr, RSCIState),
> -        VMSTATE_UINT8(scmr, RSCIState),
> -        VMSTATE_UINT8(semr, RSCIState),
> -        VMSTATE_UINT8(read_ssr, RSCIState),
> -        VMSTATE_TIMER(timer, RSCIState),
>           VMSTATE_END_OF_LIST()
>       }
>   };
>   
>   static Property rsci_properties[] = {
> -    DEFINE_PROP_UINT64("input-freq", RSCIState, input_freq, 0),
> -    DEFINE_PROP_CHR("chardev", RSCIState, chr),
> +    DEFINE_PROP_INT32("register-size", RSCICommonState, regshift, 8),
> +    DEFINE_PROP_UINT32("unit", RSCICommonState, unit, 0),
> +    DEFINE_PROP_CHR("chardev", RSCICommonState, chr),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   
> -static void rsci_class_init(ObjectClass *klass, void *data)
> +static void rsci_init(Object *obj)
>   {
> +    RSCICommonState *sci = RSCICommon(obj);
> +    sci->event[RXNEXT].handler = sci_rx_next;
> +    sci->event[TXEMPTY].handler = sci_tx_empty;
> +}
> +
> +static void rscif_init(Object *obj)
> +{
> +    RSCICommonState *sci = RSCICommon(obj);
> +    sci->event[RXTOUT].handler = scif_rx_timeout;
> +    sci->event[TXEMPTY].handler = scif_tx_empty;
> +    sci->event[TXEND].handler = scif_tx_end;
> +}
> +
> +static void rsci_common_class_init(ObjectClass *klass, void *data)
> +{
> +    RenesasSCICommonClass *rc = SCI_COMMON_CLASS(klass);
>       DeviceClass *dc = DEVICE_CLASS(klass);
>   
> -    dc->realize = rsci_realize;
>       dc->vmsd = &vmstate_rsci;
> -    dc->reset = rsci_reset;
>       device_class_set_props(dc, rsci_properties);
> +    rc->divrate = static_divrate;
>   }
>   
> -static const TypeInfo rsci_info = {
> -    .name = TYPE_RENESAS_SCI,
> -    .parent = TYPE_SYS_BUS_DEVICE,
> -    .instance_size = sizeof(RSCIState),
> -    .instance_init = rsci_init,
> -    .class_init = rsci_class_init,
> +static const MemoryRegionOps sci_ops = {
> +    .read = sci_read,
> +    .write = sci_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 1,
> +        .max_access_size = 4,
> +    },
>   };
>   
> -static void rsci_register_types(void)
> +static void rsci_class_init(ObjectClass *klass, void *data)
>   {
> -    type_register_static(&rsci_info);
> +    RenesasSCICommonClass *comm_rc = SCI_COMMON_CLASS(klass);
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    comm_rc->ops = &sci_ops;
> +    comm_rc->irq_fn = sci_irq;
> +    dc->realize = rsci_realize;
>   }
>   
> -type_init(rsci_register_types)
> +static const MemoryRegionOps scia_ops = {
> +    .read = scia_read,
> +    .write = scia_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 1,
> +        .max_access_size = 4,
> +    },
> +};
> +
> +static void rscia_class_init(ObjectClass *klass, void *data)
> +{
> +    RenesasSCICommonClass *comm_rc = SCI_COMMON_CLASS(klass);
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    comm_rc->ops = &scia_ops;
> +    comm_rc->irq_fn = scia_irq;
> +    comm_rc->divrate = scia_divrate;
> +
> +    dc->realize = rscia_realize;
> +}
> +
> +static const MemoryRegionOps scif_ops = {
> +    .read = scif_read,
> +    .write = scif_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 1,
> +        .max_access_size = 4,
> +    },
> +};
> +
> +static void rscif_class_init(ObjectClass *klass, void *data)
> +{
> +    RenesasSCICommonClass *comm_rc = SCI_COMMON_CLASS(klass);
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    comm_rc->ops = &scif_ops;
> +    comm_rc->irq_fn = scif_irq;
> +
> +    dc->realize = rscif_realize;
> +}
> +
> +static const TypeInfo renesas_sci_info[] = {
> +    {
> +        .name       = TYPE_RENESAS_SCI_COMMON,
> +        .parent     = TYPE_SYS_BUS_DEVICE,
> +        .instance_size = sizeof(RSCICommonState),
> +        .instance_init = rsci_common_init,
> +        .class_init = rsci_common_class_init,
> +        .class_size = sizeof(RenesasSCICommonClass),
> +        .abstract = true,
> +    },
> +    {
> +        .name       = TYPE_RENESAS_SCI,
> +        .parent     = TYPE_RENESAS_SCI_COMMON,
> +        .instance_size = sizeof(RSCIState),
> +        .instance_init = rsci_init,
> +        .class_init = rsci_class_init,
> +        .class_size = sizeof(RenesasSCIClass),
> +    },
> +    {
> +        .name       = TYPE_RENESAS_SCIA,
> +        .parent     = TYPE_RENESAS_SCI_COMMON,
> +        .instance_size = sizeof(RSCIAState),
> +        /* Initializer same of SCI */
> +        .instance_init = rsci_init,
> +        .class_init = rscia_class_init,
> +        .class_size = sizeof(RenesasSCIAClass),
> +    },
> +    {
> +        .name       = TYPE_RENESAS_SCIF,
> +        .parent     = TYPE_RENESAS_SCI_COMMON,
> +        .instance_size = sizeof(RSCIFState),
> +        .instance_init = rscif_init,
> +        .class_init = rscif_class_init,
> +        .class_size = sizeof(RenesasSCIFClass),
> +    },
> +};
> +
> +DEFINE_TYPES(renesas_sci_info)
> 


