Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96763C83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 17:30:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F91F206C0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 17:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ff9TsrUl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F91F206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTqXa-0005uv-8v
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 13:30:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55524)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fnuv@xilinx.com>) id 1jTqVi-0004LK-5w
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 13:29:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <fnuv@xilinx.com>) id 1jTqUU-00044B-9r
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 13:28:37 -0400
Received: from mail-dm6nam11on2050.outbound.protection.outlook.com
 ([40.107.223.50]:28960 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>)
 id 1jTqUS-0003l3-HR; Wed, 29 Apr 2020 13:27:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GftDNDPft4swVzGpdx596E3PPVWkCE2/9oTbz9REKSSLispI3W81M5PNzr+9yTOtALrZQ38yi6uFDNXun8iqzNMOI6tmJZN9vcNejvi56GkwH0G5O5k242qUMF7OPR6qAlVa/H6bfX+xgPYYuAxLEXy/jwwRVQ/+PEBmS4azjxLW34PzodAD9FyOUW1Q5TH+iKVui5g5T5Fvpj2UyE3hV0TPoQEv/qy6RHwBKEdzUp1EgQnijH+7dxI1JOBnrrHs3ykwROMoR/CGJdxhTymn/RYMowtcuh87g6E3NRhRtQwc0yqyf+l4hFGhMpIecVTxO9L8rO0GSei8E48PNy2gtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SBRLwD9aTM20rJ6QOz6o7EgUluOky8iytprkPullBzI=;
 b=H6VTE3IucnctKQHxGEYy2q+0DzEdt7HCag966EEmPvvx2z83ohM9X9q2PdTAxclgsH4l58uTBBd9QNI91qyiiBBD6LxajD1Y9j5HwZrG7EKxFEU0VKbO7F06R0+mw0oU5xdDq+4wvhS9I7s2oETfbdFcVtlVoOh6NOS5IYjjybwj+GVP3UvXkubdsFrod8w0D4HB3SHr3rVl+3tAG1XWHfHC1C+N/ORGS4Gx86VYe3/mq5212P3/3kIUUfEA+i1vyWPryy3pD6D+Af9oPscdXlTV1fmjxhWKqAnXQfh7ix29UpkaBEVNbmdUVWUncUUeACQTyqaEb8SUpL9DegweZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SBRLwD9aTM20rJ6QOz6o7EgUluOky8iytprkPullBzI=;
 b=ff9TsrUlk8iOgVNtuPhGROSdgScp7JX/Bw8o5QpWxbBOBohwOI7/TzeQNP3Z1lntriZvJh2o3gVQTgwquiLAyRDJe6o8fy/iIXlpF7sOcd8h+O2qZtZU9pggQMB1SAM/TDk7EgS4l1xlqgYtVxh4k7WSRuyo78zl0nCaPw57ekg=
Received: from BYAPR02MB4823.namprd02.prod.outlook.com (2603:10b6:a03:4e::18)
 by BYAPR02MB5877.namprd02.prod.outlook.com (2603:10b6:a03:118::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Wed, 29 Apr
 2020 17:27:15 +0000
Received: from BYAPR02MB4823.namprd02.prod.outlook.com
 ([fe80::85e1:c586:9f74:d053]) by BYAPR02MB4823.namprd02.prod.outlook.com
 ([fe80::85e1:c586:9f74:d053%4]) with mapi id 15.20.2937.028; Wed, 29 Apr 2020
 17:27:15 +0000
From: Vikram Garhwal <fnuv@xilinx.com>
To: Francisco Iglesias <frasse.iglesias@gmail.com>
Subject: RE: [PATCH v3 1/4] hw/net/can: Introduce Xilinx ZynqMP CAN controller
Thread-Topic: [PATCH v3 1/4] hw/net/can: Introduce Xilinx ZynqMP CAN controller
Thread-Index: AQHWGQobozpIzcpgtE+UpWbH9JaP3aiO8fKAgAFxCEA=
Date: Wed, 29 Apr 2020 17:27:15 +0000
Message-ID: <BYAPR02MB482343719B69EC496803B2A2BCAD0@BYAPR02MB4823.namprd02.prod.outlook.com>
References: <1587603369-14644-1-git-send-email-fnu.vikram@xilinx.com>
 <1587603369-14644-2-git-send-email-fnu.vikram@xilinx.com>
 <20200428191959.gcazma62xnygshd7@fralle-msi>
In-Reply-To: <20200428191959.gcazma62xnygshd7@fralle-msi>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [73.202.69.7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dbbd2801-69ac-4713-a54d-08d7ec628f63
x-ms-traffictypediagnostic: BYAPR02MB5877:
x-microsoft-antispam-prvs: <BYAPR02MB58777D691CA51BCDD468A388BCAD0@BYAPR02MB5877.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 03883BD916
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4823.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39850400004)(346002)(136003)(396003)(376002)(366004)(76116006)(6916009)(30864003)(66946007)(66556008)(64756008)(4326008)(66476007)(478600001)(52536014)(66446008)(316002)(54906003)(2906002)(33656002)(8936002)(26005)(5660300002)(8676002)(186003)(9686003)(6506007)(53546011)(71200400001)(86362001)(55016002)(7696005)(579004)(559001)(6606295002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zvSNTAMhuPTCY77gE67OIMQsBnYnWTb5l3ff46k/WhW8Vm7X4FCf0DfuFimsHfhVFXNq/GDzKx5vkiJbb1OHDSXtSnAbZhVwU3U3cl7s5CqVuf3YJDNbcycDmZz7beVI4gmBHPwnKF8LdxZNy98UWoVZQMjDX+x7XNQgGeQg85wNpJ+IuJmHHY3BARyZFXDWxcKbX7jrcpacH4nAUkAqoFZ73OIcqdF1hbsvZ3FJVafzuN6cys6HKkCmzJLk18LgDNLwoqq0DhtUQjPjeZJUP0EkdWvedQ3DTGXlZcYsE+8fT2tNUd85+FykWKsnV/IJ4q+RFHtDsH7CaIJp5ZcNjT4tKDdqFRLvqHHDAY5HSvBk2HjpwIW+74aCWZi3461MV42lMaDr8Lugmqh5xlYrjtK1dDDRf/YVGSzIZINue6pCzHIE8tPeeEqEV5gSpaqvDRoaBrPaMyBeuOQVmKfNV0VoQzJY/S45LGuu1i4HXH8ED9YyfZJBvIpluJzgu0b0
x-ms-exchange-antispam-messagedata: xlFMFu0N/0jVzsXZowq8WEOiHvI7WklSzo9Ubz+KKERkRp8uCe9zAG9brQZmUS1jUHM/k5gGuLjw+t6cLChIvmytjrYIZQlWVr0ttxRavJjP4FFHtjNlqvSAixlpGn8nl15mGi4VuaIbchruAjKHSupeEPZV8Wk64uD7+HuyvwhHdcvZMPITACUSgj7DTZMkyjZJ6RFb2DkNihD+b0/fAgxnqViKJq/cw6nl2CEDikL5mWlYT7+MwGgt7lVjE68BT2FdA+pJEHjNa/Hg/ICl26B2mf7XbwLbTgR48tCfqER4W7hAdK/cI0dY5qYuNMLRl0Bf/hcI26zL9MFoOGcr2HNnysC0w7qn69HF7HwHNqIdMLfU+xuwRP2QIk70zv6sMj5sjYTNL/XKnKIuCH7AQhDG+xmXhaDOZ0n8oNWK1orBlZNor1JVHsPajPMttrN0vvVjqo8l5wy42LTc1NeTTSu0+2D6dsQFzNEwkSrLgz7OaXhIMZT6RnuZ8/iqC4OeCG8Z1Xt3Sd+qOU/C10S4ZZA5gqBS8PdZQKsyiDNHXdZmmbNUnCiA6Aa4tvAIIYv7Vkv0uTPxX07b4zSBtAUON2M9ianSXJtAlkJTAsBpXsdsuOeAfaTJhG9lENO+UOXFVwaL5nZtvnU8fLrbiMZVIttHv88DLNKZ+MvENLM8KlYJdMYc2g4VtBVEBL4kOWC24ofXfdFMQFw4/hVhrJ16pJTLhFwjLhKwqKN8WsVCFW5ngpurPpKj+Unmzs4F7kamsjOP0g/7rkirIMm3/wmfp3vUQst3S2uVu/gEzHK8aqg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbbd2801-69ac-4713-a54d-08d7ec628f63
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2020 17:27:15.0928 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wHnel+r+T4HHdyXpuopS4/Mz8M2OhAGhfCKd0pF8y7HBVakxYgEV5tqoTHzdOxcH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5877
Received-SPF: pass client-ip=40.107.223.50; envelope-from=fnuv@xilinx.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 13:27:18
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.223.50
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "open list:Xilinx ZynqMP" <qemu-arm@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Francisco,
Thanks for the review. Comments inline.

Regards,
Vikram

> -----Original Message-----
> From: Francisco Iglesias <frasse.iglesias@gmail.com>
> Sent: Tuesday, April 28, 2020 12:20 PM
> To: Vikram Garhwal <fnuv@xilinx.com>
> Cc: qemu-devel@nongnu.org; Peter Maydell <peter.maydell@linaro.org>;
> Jason Wang <jasowang@redhat.com>; Alistair Francis
> <alistair@alistair23.me>; open list:Xilinx ZynqMP <qemu-
> arm@nongnu.org>; Edgar E. Iglesias <edgar.iglesias@gmail.com>
> Subject: Re: [PATCH v3 1/4] hw/net/can: Introduce Xilinx ZynqMP CAN
> controller
>=20
> Hi Vikram,
>=20
> A couple of more comments here also.
>=20
> On [2020 Apr 22] Wed 17:56:06, Vikram Garhwal wrote:
> > XlnxCAN is developed based on SocketCAN, QEMU CAN bus
> implementation.
> > Bus connection and socketCAN connection for each CAN module can be
> set
> > through command lines.
> >
> > Signed-off-by: Vikram Garhwal <fnu.vikram@xilinx.com>
> > ---
> >  hw/net/can/Makefile.objs         |    1 +
> >  hw/net/can/xlnx-zynqmp-can.c     | 1113
> ++++++++++++++++++++++++++++++++++++++
> >  include/hw/net/xlnx-zynqmp-can.h |   76 +++
> >  3 files changed, 1190 insertions(+)
> >  create mode 100644 hw/net/can/xlnx-zynqmp-can.c  create mode
> 100644
> > include/hw/net/xlnx-zynqmp-can.h
> >
> > diff --git a/hw/net/can/Makefile.objs b/hw/net/can/Makefile.objs index
> > 9f0c4ee..0fe87dd 100644
> > --- a/hw/net/can/Makefile.objs
> > +++ b/hw/net/can/Makefile.objs
> > @@ -2,3 +2,4 @@ common-obj-$(CONFIG_CAN_SJA1000) +=3D
> can_sja1000.o
> >  common-obj-$(CONFIG_CAN_PCI) +=3D can_kvaser_pci.o
> >  common-obj-$(CONFIG_CAN_PCI) +=3D can_pcm3680_pci.o
> >  common-obj-$(CONFIG_CAN_PCI) +=3D can_mioe3680_pci.o
> > +common-obj-$(CONFIG_XLNX_ZYNQMP) +=3D xlnx-zynqmp-can.o
> > diff --git a/hw/net/can/xlnx-zynqmp-can.c
> > b/hw/net/can/xlnx-zynqmp-can.c new file mode 100644 index
> > 0000000..31799c0
> > --- /dev/null
> > +++ b/hw/net/can/xlnx-zynqmp-can.c
> > @@ -0,0 +1,1113 @@
> > +/*
> > + * QEMU model of the Xilinx CAN device.
> > + *
> > + * Copyright (c) 2020 Xilinx Inc.
> > + *
> > + * Written-by: Vikram Garhwal<fnu.vikram@xilinx.com>
> > + *
> > + * Based on QEMU CAN Device emulation implemented by Jin Yang,
> Deniz
> > +Eren and
> > + * Pavel Pisa
> > + *
> > + * Permission is hereby granted, free of charge, to any person
> > +obtaining a copy
> > + * of this software and associated documentation files (the
> > +"Software"), to deal
> > + * in the Software without restriction, including without limitation
> > +the rights
> > + * to use, copy, modify, merge, publish, distribute, sublicense,
> > +and/or sell
> > + * copies of the Software, and to permit persons to whom the Software
> > +is
> > + * furnished to do so, subject to the following conditions:
> > + *
> > + * The above copyright notice and this permission notice shall be
> > +included in
> > + * all copies or substantial portions of the Software.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
> KIND,
> > +EXPRESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> > +MERCHANTABILITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO
> EVENT
> > +SHALL
> > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
> DAMAGES
> > +OR OTHER
> > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> OTHERWISE,
> > +ARISING FROM,
> > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> OTHER
> > +DEALINGS IN
> > + * THE SOFTWARE.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "hw/sysbus.h"
> > +#include "hw/register.h"
> > +#include "hw/irq.h"
> > +#include "qapi/error.h"
> > +#include "qemu/bitops.h"
> > +#include "qemu/log.h"
> > +#include "qemu/cutils.h"
> > +#include "sysemu/sysemu.h"
> > +#include "migration/vmstate.h"
> > +#include "hw/qdev-properties.h"
> > +#include "net/can_emu.h"
> > +#include "net/can_host.h"
> > +#include "qemu/event_notifier.h"
> > +#include "qom/object_interfaces.h"
> > +#include "hw/net/xlnx-zynqmp-can.h"
> > +
> > +#ifndef XLNX_ZYNQMP_CAN_ERR_DEBUG
> > +#define XLNX_ZYNQMP_CAN_ERR_DEBUG 0
> > +#endif
> > +
> > +#define DB_PRINT(...) do { \
> > +    if (XLNX_ZYNQMP_CAN_ERR_DEBUG) { \
> > +        qemu_log(__VA_ARGS__); \
> > +    } \
> > +} while (0)
> > +
> > +#define MAX_DLC            8
> > +#undef ERROR
> > +
> > +REG32(SOFTWARE_RESET_REGISTER, 0x0)
> > +    FIELD(SOFTWARE_RESET_REGISTER, CEN, 1, 1)
> > +    FIELD(SOFTWARE_RESET_REGISTER, SRST, 0, 1)
> > +REG32(MODE_SELECT_REGISTER, 0x4)
> > +    FIELD(MODE_SELECT_REGISTER, SNOOP, 2, 1)
> > +    FIELD(MODE_SELECT_REGISTER, LBACK, 1, 1)
> > +    FIELD(MODE_SELECT_REGISTER, SLEEP, 0, 1)
> > +REG32(ARBITRATION_PHASE_BAUD_RATE_PRESCALER_REGISTER, 0x8)
> > +    FIELD(ARBITRATION_PHASE_BAUD_RATE_PRESCALER_REGISTER, BRP,
> 0, 8)
> > +REG32(ARBITRATION_PHASE_BIT_TIMING_REGISTER, 0xc)
> > +    FIELD(ARBITRATION_PHASE_BIT_TIMING_REGISTER, SJW, 7, 2)
> > +    FIELD(ARBITRATION_PHASE_BIT_TIMING_REGISTER, TS2, 4, 3)
> > +    FIELD(ARBITRATION_PHASE_BIT_TIMING_REGISTER, TS1, 0, 4)
> > +REG32(ERROR_COUNTER_REGISTER, 0x10)
> > +    FIELD(ERROR_COUNTER_REGISTER, REC, 8, 8)
> > +    FIELD(ERROR_COUNTER_REGISTER, TEC, 0, 8)
> > +REG32(ERROR_STATUS_REGISTER, 0x14)
> > +    FIELD(ERROR_STATUS_REGISTER, ACKER, 4, 1)
> > +    FIELD(ERROR_STATUS_REGISTER, BERR, 3, 1)
> > +    FIELD(ERROR_STATUS_REGISTER, STER, 2, 1)
> > +    FIELD(ERROR_STATUS_REGISTER, FMER, 1, 1)
> > +    FIELD(ERROR_STATUS_REGISTER, CRCER, 0, 1)
> REG32(STATUS_REGISTER,
> > +0x18)
> > +    FIELD(STATUS_REGISTER, SNOOP, 12, 1)
> > +    FIELD(STATUS_REGISTER, ACFBSY, 11, 1)
> > +    FIELD(STATUS_REGISTER, TXFLL, 10, 1)
> > +    FIELD(STATUS_REGISTER, TXBFLL, 9, 1)
> > +    FIELD(STATUS_REGISTER, ESTAT, 7, 2)
> > +    FIELD(STATUS_REGISTER, ERRWRN, 6, 1)
> > +    FIELD(STATUS_REGISTER, BBSY, 5, 1)
> > +    FIELD(STATUS_REGISTER, BIDLE, 4, 1)
> > +    FIELD(STATUS_REGISTER, NORMAL, 3, 1)
> > +    FIELD(STATUS_REGISTER, SLEEP, 2, 1)
> > +    FIELD(STATUS_REGISTER, LBACK, 1, 1)
> > +    FIELD(STATUS_REGISTER, CONFIG, 0, 1)
> > +REG32(INTERRUPT_STATUS_REGISTER, 0x1c)
> > +    FIELD(INTERRUPT_STATUS_REGISTER, TXFEMP, 14, 1)
> > +    FIELD(INTERRUPT_STATUS_REGISTER, TXFWMEMP, 13, 1)
> > +    FIELD(INTERRUPT_STATUS_REGISTER, RXFWMFLL, 12, 1)
> > +    FIELD(INTERRUPT_STATUS_REGISTER, WKUP, 11, 1)
> > +    FIELD(INTERRUPT_STATUS_REGISTER, SLP, 10, 1)
> > +    FIELD(INTERRUPT_STATUS_REGISTER, BSOFF, 9, 1)
> > +    FIELD(INTERRUPT_STATUS_REGISTER, ERROR, 8, 1)
> > +    FIELD(INTERRUPT_STATUS_REGISTER, RXNEMP, 7, 1)
> > +    FIELD(INTERRUPT_STATUS_REGISTER, RXOFLW, 6, 1)
> > +    FIELD(INTERRUPT_STATUS_REGISTER, RXUFLW, 5, 1)
> > +    FIELD(INTERRUPT_STATUS_REGISTER, RXOK, 4, 1)
> > +    FIELD(INTERRUPT_STATUS_REGISTER, TXBFLL, 3, 1)
> > +    FIELD(INTERRUPT_STATUS_REGISTER, TXFLL, 2, 1)
> > +    FIELD(INTERRUPT_STATUS_REGISTER, TXOK, 1, 1)
> > +    FIELD(INTERRUPT_STATUS_REGISTER, ARBLST, 0, 1)
> > +REG32(INTERRUPT_ENABLE_REGISTER, 0x20)
> > +    FIELD(INTERRUPT_ENABLE_REGISTER, ETXFEMP, 14, 1)
> > +    FIELD(INTERRUPT_ENABLE_REGISTER, ETXFWMEMP, 13, 1)
> > +    FIELD(INTERRUPT_ENABLE_REGISTER, ERXFWMFLL, 12, 1)
> > +    FIELD(INTERRUPT_ENABLE_REGISTER, EWKUP, 11, 1)
> > +    FIELD(INTERRUPT_ENABLE_REGISTER, ESLP, 10, 1)
> > +    FIELD(INTERRUPT_ENABLE_REGISTER, EBSOFF, 9, 1)
> > +    FIELD(INTERRUPT_ENABLE_REGISTER, EERROR, 8, 1)
> > +    FIELD(INTERRUPT_ENABLE_REGISTER, ERXNEMP, 7, 1)
> > +    FIELD(INTERRUPT_ENABLE_REGISTER, ERXOFLW, 6, 1)
> > +    FIELD(INTERRUPT_ENABLE_REGISTER, ERXUFLW, 5, 1)
> > +    FIELD(INTERRUPT_ENABLE_REGISTER, ERXOK, 4, 1)
> > +    FIELD(INTERRUPT_ENABLE_REGISTER, ETXBFLL, 3, 1)
> > +    FIELD(INTERRUPT_ENABLE_REGISTER, ETXFLL, 2, 1)
> > +    FIELD(INTERRUPT_ENABLE_REGISTER, ETXOK, 1, 1)
> > +    FIELD(INTERRUPT_ENABLE_REGISTER, EARBLST, 0, 1)
> > +REG32(INTERRUPT_CLEAR_REGISTER, 0x24)
> > +    FIELD(INTERRUPT_CLEAR_REGISTER, CTXFEMP, 14, 1)
> > +    FIELD(INTERRUPT_CLEAR_REGISTER, CTXFWMEMP, 13, 1)
> > +    FIELD(INTERRUPT_CLEAR_REGISTER, CRXFWMFLL, 12, 1)
> > +    FIELD(INTERRUPT_CLEAR_REGISTER, CWKUP, 11, 1)
> > +    FIELD(INTERRUPT_CLEAR_REGISTER, CSLP, 10, 1)
> > +    FIELD(INTERRUPT_CLEAR_REGISTER, CBSOFF, 9, 1)
> > +    FIELD(INTERRUPT_CLEAR_REGISTER, CERROR, 8, 1)
> > +    FIELD(INTERRUPT_CLEAR_REGISTER, CRXNEMP, 7, 1)
> > +    FIELD(INTERRUPT_CLEAR_REGISTER, CRXOFLW, 6, 1)
> > +    FIELD(INTERRUPT_CLEAR_REGISTER, CRXUFLW, 5, 1)
> > +    FIELD(INTERRUPT_CLEAR_REGISTER, CRXOK, 4, 1)
> > +    FIELD(INTERRUPT_CLEAR_REGISTER, CTXBFLL, 3, 1)
> > +    FIELD(INTERRUPT_CLEAR_REGISTER, CTXFLL, 2, 1)
> > +    FIELD(INTERRUPT_CLEAR_REGISTER, CTXOK, 1, 1)
> > +    FIELD(INTERRUPT_CLEAR_REGISTER, CARBLST, 0, 1)
> > +REG32(TIMESTAMP_REGISTER, 0x28)
> > +    FIELD(TIMESTAMP_REGISTER, CTS, 0, 1) REG32(WIR, 0x2c)
> > +    FIELD(WIR, EW, 8, 8)
> > +    FIELD(WIR, FW, 0, 8)
> > +REG32(TXFIFO_ID, 0x30)
> > +    FIELD(TXFIFO_ID, IDH, 21, 11)
> > +    FIELD(TXFIFO_ID, SRRRTR, 20, 1)
> > +    FIELD(TXFIFO_ID, IDE, 19, 1)
> > +    FIELD(TXFIFO_ID, IDL, 1, 18)
> > +    FIELD(TXFIFO_ID, RTR, 0, 1)
> > +REG32(TXFIFO_DLC, 0x34)
> > +    FIELD(TXFIFO_DLC, DLC, 28, 4)
> > +REG32(TXFIFO_DATA1, 0x38)
> > +    FIELD(TXFIFO_DATA1, DB0, 24, 8)
> > +    FIELD(TXFIFO_DATA1, DB1, 16, 8)
> > +    FIELD(TXFIFO_DATA1, DB2, 8, 8)
> > +    FIELD(TXFIFO_DATA1, DB3, 0, 8)
> > +REG32(TXFIFO_DATA2, 0x3c)
> > +    FIELD(TXFIFO_DATA2, DB4, 24, 8)
> > +    FIELD(TXFIFO_DATA2, DB5, 16, 8)
> > +    FIELD(TXFIFO_DATA2, DB6, 8, 8)
> > +    FIELD(TXFIFO_DATA2, DB7, 0, 8)
> > +REG32(TXHPB_ID, 0x40)
> > +    FIELD(TXHPB_ID, IDH, 21, 11)
> > +    FIELD(TXHPB_ID, SRRRTR, 20, 1)
> > +    FIELD(TXHPB_ID, IDE, 19, 1)
> > +    FIELD(TXHPB_ID, IDL, 1, 18)
> > +    FIELD(TXHPB_ID, RTR, 0, 1)
> > +REG32(TXHPB_DLC, 0x44)
> > +    FIELD(TXHPB_DLC, DLC, 28, 4)
> > +REG32(TXHPB_DATA1, 0x48)
> > +    FIELD(TXHPB_DATA1, DB0, 24, 8)
> > +    FIELD(TXHPB_DATA1, DB1, 16, 8)
> > +    FIELD(TXHPB_DATA1, DB2, 8, 8)
> > +    FIELD(TXHPB_DATA1, DB3, 0, 8)
> > +REG32(TXHPB_DATA2, 0x4c)
> > +    FIELD(TXHPB_DATA2, DB4, 24, 8)
> > +    FIELD(TXHPB_DATA2, DB5, 16, 8)
> > +    FIELD(TXHPB_DATA2, DB6, 8, 8)
> > +    FIELD(TXHPB_DATA2, DB7, 0, 8)
> > +REG32(RXFIFO_ID, 0x50)
> > +    FIELD(RXFIFO_ID, IDH, 21, 11)
> > +    FIELD(RXFIFO_ID, SRRRTR, 20, 1)
> > +    FIELD(RXFIFO_ID, IDE, 19, 1)
> > +    FIELD(RXFIFO_ID, IDL, 1, 18)
> > +    FIELD(RXFIFO_ID, RTR, 0, 1)
> > +REG32(RXFIFO_DLC, 0x54)
> > +    FIELD(RXFIFO_DLC, DLC, 28, 4)
> > +    FIELD(RXFIFO_DLC, RXT, 0, 16)
> > +REG32(RXFIFO_DATA1, 0x58)
> > +    FIELD(RXFIFO_DATA1, DB0, 24, 8)
> > +    FIELD(RXFIFO_DATA1, DB1, 16, 8)
> > +    FIELD(RXFIFO_DATA1, DB2, 8, 8)
> > +    FIELD(RXFIFO_DATA1, DB3, 0, 8)
> > +REG32(RXFIFO_DATA2, 0x5c)
> > +    FIELD(RXFIFO_DATA2, DB4, 24, 8)
> > +    FIELD(RXFIFO_DATA2, DB5, 16, 8)
> > +    FIELD(RXFIFO_DATA2, DB6, 8, 8)
> > +    FIELD(RXFIFO_DATA2, DB7, 0, 8)
> > +REG32(AFR, 0x60)
> > +    FIELD(AFR, UAF4, 3, 1)
> > +    FIELD(AFR, UAF3, 2, 1)
> > +    FIELD(AFR, UAF2, 1, 1)
> > +    FIELD(AFR, UAF1, 0, 1)
> > +REG32(AFMR1, 0x64)
> > +    FIELD(AFMR1, AMIDH, 21, 11)
> > +    FIELD(AFMR1, AMSRR, 20, 1)
> > +    FIELD(AFMR1, AMIDE, 19, 1)
> > +    FIELD(AFMR1, AMIDL, 1, 18)
> > +    FIELD(AFMR1, AMRTR, 0, 1)
> > +REG32(AFIR1, 0x68)
> > +    FIELD(AFIR1, AIIDH, 21, 11)
> > +    FIELD(AFIR1, AISRR, 20, 1)
> > +    FIELD(AFIR1, AIIDE, 19, 1)
> > +    FIELD(AFIR1, AIIDL, 1, 18)
> > +    FIELD(AFIR1, AIRTR, 0, 1)
> > +REG32(AFMR2, 0x6c)
> > +    FIELD(AFMR2, AMIDH, 21, 11)
> > +    FIELD(AFMR2, AMSRR, 20, 1)
> > +    FIELD(AFMR2, AMIDE, 19, 1)
> > +    FIELD(AFMR2, AMIDL, 1, 18)
> > +    FIELD(AFMR2, AMRTR, 0, 1)
> > +REG32(AFIR2, 0x70)
> > +    FIELD(AFIR2, AIIDH, 21, 11)
> > +    FIELD(AFIR2, AISRR, 20, 1)
> > +    FIELD(AFIR2, AIIDE, 19, 1)
> > +    FIELD(AFIR2, AIIDL, 1, 18)
> > +    FIELD(AFIR2, AIRTR, 0, 1)
> > +REG32(AFMR3, 0x74)
> > +    FIELD(AFMR3, AMIDH, 21, 11)
> > +    FIELD(AFMR3, AMSRR, 20, 1)
> > +    FIELD(AFMR3, AMIDE, 19, 1)
> > +    FIELD(AFMR3, AMIDL, 1, 18)
> > +    FIELD(AFMR3, AMRTR, 0, 1)
> > +REG32(AFIR3, 0x78)
> > +    FIELD(AFIR3, AIIDH, 21, 11)
> > +    FIELD(AFIR3, AISRR, 20, 1)
> > +    FIELD(AFIR3, AIIDE, 19, 1)
> > +    FIELD(AFIR3, AIIDL, 1, 18)
> > +    FIELD(AFIR3, AIRTR, 0, 1)
> > +REG32(AFMR4, 0x7c)
> > +    FIELD(AFMR4, AMIDH, 21, 11)
> > +    FIELD(AFMR4, AMSRR, 20, 1)
> > +    FIELD(AFMR4, AMIDE, 19, 1)
> > +    FIELD(AFMR4, AMIDL, 1, 18)
> > +    FIELD(AFMR4, AMRTR, 0, 1)
> > +REG32(AFIR4, 0x80)
> > +    FIELD(AFIR4, AIIDH, 21, 11)
> > +    FIELD(AFIR4, AISRR, 20, 1)
> > +    FIELD(AFIR4, AIIDE, 19, 1)
> > +    FIELD(AFIR4, AIIDL, 1, 18)
> > +    FIELD(AFIR4, AIRTR, 0, 1)
> > +
> > +static void can_update_irq(XlnxZynqMPCANState *s) {
> > +    unsigned int irq;
> > +
> > +    /* Watermark register interrupts. */
> > +    if ((fifo32_num_free(&s->tx_fifo) / CAN_FRAME_SIZE) >
> > +            ARRAY_FIELD_EX32(s->regs, WIR, EW)) {
> > +        ARRAY_FIELD_DP32(s->regs, INTERRUPT_STATUS_REGISTER,
> TXFWMEMP, 1);
> > +    }
> > +
> > +    if ((fifo32_num_used(&s->rx_fifo) / CAN_FRAME_SIZE) >
> > +            ARRAY_FIELD_EX32(s->regs, WIR, FW)) {
> > +        ARRAY_FIELD_DP32(s->regs, INTERRUPT_STATUS_REGISTER,
> RXFWMFLL, 1);
> > +    }
> > +
> > +    /* RX Interrupts. */
> > +    if (fifo32_num_used(&s->rx_fifo) >=3D CAN_FRAME_SIZE) {
> > +        ARRAY_FIELD_DP32(s->regs, INTERRUPT_STATUS_REGISTER,
> RXNEMP, 1);
> > +    }
> > +
> > +    /* TX interrupts. */
> > +    if (fifo32_is_empty(&s->tx_fifo)) {
> > +        ARRAY_FIELD_DP32(s->regs, INTERRUPT_STATUS_REGISTER,
> TXFEMP, 1);
> > +    }
> > +
> > +    if (fifo32_is_full(&s->tx_fifo)) {
> > +        ARRAY_FIELD_DP32(s->regs, INTERRUPT_STATUS_REGISTER, TXFLL,
> 1);
> > +    }
> > +
> > +    if (fifo32_is_full(&s->txhpb_fifo)) {
> > +        ARRAY_FIELD_DP32(s->regs, INTERRUPT_STATUS_REGISTER, TXBFLL,
> 1);
> > +    }
> > +
> > +    irq =3D s->regs[R_INTERRUPT_STATUS_REGISTER];
> > +    irq &=3D s->regs[R_INTERRUPT_ENABLE_REGISTER];
> > +
> > +    qemu_set_irq(s->irq, irq);
> > +}
> > +
> > +static void can_ier_post_write(RegisterInfo *reg, uint64_t val64) {
> > +    XlnxZynqMPCANState *s =3D XLNX_ZYNQMP_CAN(reg->opaque);
> > +
> > +    can_update_irq(s);
> > +}
> > +
> > +static uint64_t can_icr_pre_write(RegisterInfo *reg, uint64_t val64)
> > +{
> > +    XlnxZynqMPCANState *s =3D XLNX_ZYNQMP_CAN(reg->opaque);
> > +    uint32_t val =3D val64;
> > +
> > +    s->regs[R_INTERRUPT_STATUS_REGISTER] &=3D ~val;
> > +    can_update_irq(s);
> > +
> > +    return 0;
> > +}
> > +
> > +static void can_config_reset(XlnxZynqMPCANState *s) {
> > +    /* Reset all the configuration registers. */
> > +    register_reset(&s->reg_info[R_SOFTWARE_RESET_REGISTER]);
> > +    register_reset(&s->reg_info[R_MODE_SELECT_REGISTER]);
> > +    register_reset(
> > +              &s-
> >reg_info[R_ARBITRATION_PHASE_BAUD_RATE_PRESCALER_REGISTER]);
> > +    register_reset(&s-
> >reg_info[R_ARBITRATION_PHASE_BIT_TIMING_REGISTER]);
> > +    register_reset(&s->reg_info[R_STATUS_REGISTER]);
> > +    register_reset(&s->reg_info[R_INTERRUPT_STATUS_REGISTER]);
> > +    register_reset(&s->reg_info[R_INTERRUPT_ENABLE_REGISTER]);
> > +    register_reset(&s->reg_info[R_INTERRUPT_CLEAR_REGISTER]);
> > +    register_reset(&s->reg_info[R_WIR]);
> > +}
> > +
> > +static void can_config_mode(XlnxZynqMPCANState *s) {
> > +    register_reset(&s->reg_info[R_ERROR_COUNTER_REGISTER]);
> > +    register_reset(&s->reg_info[R_ERROR_STATUS_REGISTER]);
> > +
> > +    /* Put XlnxZynqMPCANState in configuration mode. */
> > +    ARRAY_FIELD_DP32(s->regs, STATUS_REGISTER, CONFIG, 1);
> > +    ARRAY_FIELD_DP32(s->regs, INTERRUPT_STATUS_REGISTER, WKUP,
> 0);
> > +    ARRAY_FIELD_DP32(s->regs, INTERRUPT_STATUS_REGISTER, SLP, 0);
> > +    ARRAY_FIELD_DP32(s->regs, INTERRUPT_STATUS_REGISTER, BSOFF,
> 0);
> > +    ARRAY_FIELD_DP32(s->regs, INTERRUPT_STATUS_REGISTER, ERROR,
> 0);
> > +    ARRAY_FIELD_DP32(s->regs, INTERRUPT_STATUS_REGISTER, RXOFLW,
> 0);
> > +    ARRAY_FIELD_DP32(s->regs, INTERRUPT_STATUS_REGISTER, RXOK, 0);
> > +    ARRAY_FIELD_DP32(s->regs, INTERRUPT_STATUS_REGISTER, TXOK, 0);
> > +    ARRAY_FIELD_DP32(s->regs, INTERRUPT_STATUS_REGISTER, ARBLST,
> 0);
> > +
> > +    can_update_irq(s);
> > +}
> > +
> > +static void update_status_register_mode_bits(XlnxZynqMPCANState *s)
> {
> > +    /* Wake up interrupt bit. */
> > +    bool wakeup_irq_val =3D (ARRAY_FIELD_EX32(s->regs,
> MODE_SELECT_REGISTER,
> > +                            SLEEP) =3D=3D 0) && ARRAY_FIELD_EX32(s->re=
gs,
> > +                            STATUS_REGISTER, SLEEP);
> > +
> > +    /* Sleep interrupt bit. */
> > +    bool sleep_irq_val =3D (ARRAY_FIELD_EX32(s->regs,
> MODE_SELECT_REGISTER,
> > +                            SLEEP) && (ARRAY_FIELD_EX32(s->regs,
> > +                            STATUS_REGISTER, SLEEP) =3D=3D 0));
> > +
> > +    /* Clear previous core mode status bits. */
> > +    ARRAY_FIELD_DP32(s->regs, STATUS_REGISTER, LBACK, 0);
> > +    ARRAY_FIELD_DP32(s->regs, STATUS_REGISTER, SLEEP, 0);
> > +    ARRAY_FIELD_DP32(s->regs, STATUS_REGISTER, SNOOP, 0);
> > +    ARRAY_FIELD_DP32(s->regs, STATUS_REGISTER, NORMAL, 0);
> > +
> > +    /* set current mode bit and generate irqs accordingly. */
> > +    if (ARRAY_FIELD_EX32(s->regs, MODE_SELECT_REGISTER, LBACK)) {
> > +        ARRAY_FIELD_DP32(s->regs, STATUS_REGISTER, LBACK, 1);
> > +    } else if (ARRAY_FIELD_EX32(s->regs, MODE_SELECT_REGISTER, SLEEP))
> {
> > +        ARRAY_FIELD_DP32(s->regs, STATUS_REGISTER, SLEEP, 1);
> > +        ARRAY_FIELD_DP32(s->regs, INTERRUPT_STATUS_REGISTER, SLP,
> > +                            sleep_irq_val);
> > +    } else if (ARRAY_FIELD_EX32(s->regs, MODE_SELECT_REGISTER,
> SNOOP)) {
> > +        ARRAY_FIELD_DP32(s->regs, STATUS_REGISTER, SNOOP, 1);
> > +    } else {
> > +        /*
> > +         * If all bits are zero then XlnxZynqMPCANState is set in norm=
al
> mode.
> > +         */
> > +        ARRAY_FIELD_DP32(s->regs, STATUS_REGISTER, NORMAL, 1);
> > +        /* Set wakeup interrupt bit. */
> > +        ARRAY_FIELD_DP32(s->regs, INTERRUPT_STATUS_REGISTER, WKUP,
> > +                            wakeup_irq_val);
> > +    }
> > +
> > +    can_update_irq(s);
> > +}
> > +
> > +static void can_exit_sleep_mode(XlnxZynqMPCANState *s) {
> > +    ARRAY_FIELD_DP32(s->regs, MODE_SELECT_REGISTER, SLEEP, 0);
> > +    update_status_register_mode_bits(s);
> > +}
> > +
> > +static void generate_frame(qemu_can_frame *frame, uint32_t *data) {
> > +    frame->can_id =3D data[0];
> > +    frame->can_dlc =3D FIELD_EX32(data[1], TXFIFO_DLC, DLC);
> > +
> > +    frame->data[0] =3D FIELD_EX32(data[2], TXFIFO_DATA1, DB3);
> > +    frame->data[1] =3D FIELD_EX32(data[2], TXFIFO_DATA1, DB2);
> > +    frame->data[2] =3D FIELD_EX32(data[2], TXFIFO_DATA1, DB1);
> > +    frame->data[3] =3D FIELD_EX32(data[2], TXFIFO_DATA1, DB0);
> > +
> > +    frame->data[4] =3D FIELD_EX32(data[3], TXFIFO_DATA2, DB7);
> > +    frame->data[5] =3D FIELD_EX32(data[3], TXFIFO_DATA2, DB6);
> > +    frame->data[6] =3D FIELD_EX32(data[3], TXFIFO_DATA2, DB5);
> > +    frame->data[7] =3D FIELD_EX32(data[3], TXFIFO_DATA2, DB4); }
> > +
> > +static bool tx_ready_check(XlnxZynqMPCANState *s) {
> > +    if (ARRAY_FIELD_EX32(s->regs, SOFTWARE_RESET_REGISTER, SRST)) {
> > +        qemu_log_mask(LOG_GUEST_ERROR, "Attempting to transfer data
> while"
> > +                      " XlnxZynqMPCANState%d is in reset mode\n",
> > +                      s->cfg.ctrl_idx);
> > +        return false;
> > +    }
> > +
> > +    if (ARRAY_FIELD_EX32(s->regs, SOFTWARE_RESET_REGISTER, CEN) =3D=3D
> 0) {
> > +        qemu_log_mask(LOG_GUEST_ERROR, "Attempting to transfer data
> while"
> > +                      " XlnxZynqMPCANState%d is in configuration mode.=
Reset
> the"
> > +                      " core so operations can start fresh\n",
> > +                      s->cfg.ctrl_idx);
> > +        return false;
> > +    }
> > +
> > +    if (ARRAY_FIELD_EX32(s->regs, STATUS_REGISTER, SNOOP)) {
> > +        qemu_log_mask(LOG_GUEST_ERROR, "Attempting to transfer data
> while"
> > +                        " XlnxZynqMPCANState%d is in SNOOP MODE\n",
> > +                         s->cfg.ctrl_idx);
> > +        return false;
> > +    }
> > +
> > +    return true;
> > +}
> > +
> > +static void transfer_fifo(XlnxZynqMPCANState *s, Fifo32 *fifo) {
> > +    qemu_can_frame frame;
> > +    uint32_t data[CAN_FRAME_SIZE];
> > +    int i;
> > +    bool can_tx =3D tx_ready_check(s);
> > +
> > +    if (can_tx) {
> > +        while (!fifo32_is_empty(fifo)) {
> > +            for (i =3D 0; i < CAN_FRAME_SIZE; i++) {
> > +                data[i] =3D fifo32_pop(fifo);
> > +            }
> > +
> > +            if (ARRAY_FIELD_EX32(s->regs, STATUS_REGISTER, LBACK)) {
> > +                /*
> > +                 * Controller is in loopback. In Loopback mode, the CA=
N core
> > +                 * transmits a recessive bitstream on to the
> XlnxZynqMPCANState
> > +                 * Bus. Any message transmitted is looped back to the =
RX line
> > +                 * and acknowledged. The XlnxZynqMPCANState core recei=
ves
> any
> > +                 * message that it transmits.
> > +                 */
> > +                if (fifo32_is_full(&s->rx_fifo)) {
> > +                    DB_PRINT("Loopback: RX FIFO is full."
> > +                             "TX FIFO will be flushed.\n");
> > +
> > +                    ARRAY_FIELD_DP32(s->regs, INTERRUPT_STATUS_REGISTE=
R,
> > +                                      RXOFLW, 1);
> > +                } else {
> > +                    for (i =3D 0; i < CAN_FRAME_SIZE; i++) {
> > +                        fifo32_push(&s->rx_fifo, data[i]);
> > +                    }
> > +
> > +                    ARRAY_FIELD_DP32(s->regs, INTERRUPT_STATUS_REGISTE=
R,
> > +                                      RXOK, 1);
> > +                }
> > +            } else {
> > +                /* Normal mode Tx. */
> > +                generate_frame(&frame, data);
> > +
> > +                can_bus_client_send(&s->bus_client, &frame, 1);
> > +            }
> > +        }
> > +
> > +        ARRAY_FIELD_DP32(s->regs, INTERRUPT_STATUS_REGISTER, TXOK,
> 1);
> > +        ARRAY_FIELD_DP32(s->regs, STATUS_REGISTER, TXBFLL, 0);
> > +
> > +        if (ARRAY_FIELD_EX32(s->regs, STATUS_REGISTER, SLEEP)) {
> > +            can_exit_sleep_mode(s);
> > +        }
> > +    } else {
> > +        DB_PRINT("CAN is not enabled for data transfer.\n");
> > +    }
> > +
> > +    can_update_irq(s);
> > +}
> > +
> > +static uint64_t can_srr_pre_write(RegisterInfo *reg, uint64_t val64)
> > +{
> > +    XlnxZynqMPCANState *s =3D XLNX_ZYNQMP_CAN(reg->opaque);
> > +    uint32_t val =3D val64;
> > +
> > +    ARRAY_FIELD_DP32(s->regs, SOFTWARE_RESET_REGISTER, CEN,
> > +                        FIELD_EX32(val, SOFTWARE_RESET_REGISTER,
> > + CEN));
> > +
> > +    if (FIELD_EX32(val, SOFTWARE_RESET_REGISTER, SRST)) {
> > +        DB_PRINT("Resetting XlnxZynqMPCANState%d\n",
> > + s->cfg.ctrl_idx);
> > +
> > +        /* First, core will do software reset then will enter in confi=
g mode.
> */
> > +        can_config_reset(s);
> > +    }
> > +
> > +    if (ARRAY_FIELD_EX32(s->regs, SOFTWARE_RESET_REGISTER, CEN) =3D=3D
> 0) {
> > +        can_config_mode(s);
> > +
> > +    } else {
> > +        /*
> > +         * Leave config mode. Now XlnxZynqMPCANState core will enter
> Normal,
> > +         * Sleep, snoop or Loopback mode depending upon LBACK, SLEEP,
> SNOOP
> > +         * register states.
> > +         */
> > +        ARRAY_FIELD_DP32(s->regs, STATUS_REGISTER, CONFIG, 0);
> > +
> > +        /* XlnxZynqMP CAN is out of config mode. it will send pending =
data.
> */
> > +        transfer_fifo(s, &s->txhpb_fifo);
> > +        transfer_fifo(s, &s->tx_fifo);
> > +    }
> > +
> > +    update_status_register_mode_bits(s);
> > +
> > +    return s->regs[R_SOFTWARE_RESET_REGISTER];
> > +}
> > +
> > +static uint64_t can_msr_pre_write(RegisterInfo *reg, uint64_t val64)
> > +{
> > +    XlnxZynqMPCANState *s =3D XLNX_ZYNQMP_CAN(reg->opaque);
> > +    uint32_t val =3D val64;
> > +    uint8_t multi_mode =3D 0;
>=20
> The 0 init can be removed (since the variable is always set below):
>=20
> uint8_t multi_mode;
>=20
[Vikram Garhwal] init to 0 will be removed in v4.
>=20
> > +
> > +    /*
> > +     * Multiple mode set check. This is done to make sure user doesn't=
 set
> > +     * multiple modes.
> > +     */
> > +    multi_mode =3D FIELD_EX32(val, MODE_SELECT_REGISTER, LBACK) +
> > +                 FIELD_EX32(val, MODE_SELECT_REGISTER, SLEEP) +
> > +                 FIELD_EX32(val, MODE_SELECT_REGISTER, SNOOP);
> > +
> > +    if (multi_mode > 1) {
> > +        qemu_log_mask(LOG_GUEST_ERROR, "Attempting to configure
> several modes "
> > +                     "simultaneously. One mode will be selected accord=
ing to "
> > +                     "their priority: LBACK > SLEEP > SNOOP.\n ");
> > +    }
> > +
> > +    if (ARRAY_FIELD_EX32(s->regs, SOFTWARE_RESET_REGISTER, CEN) =3D=3D
> 0) {
> > +        /* We are in configuration mode, any mode can be selected. */
> > +        s->regs[R_MODE_SELECT_REGISTER] =3D val;
> > +    } else {
> > +        bool sleep_mode_bit =3D FIELD_EX32(val, MODE_SELECT_REGISTER,
> > + SLEEP);
> > +
> > +        ARRAY_FIELD_DP32(s->regs, MODE_SELECT_REGISTER, SLEEP,
> > + sleep_mode_bit);
> > +
> > +        if (FIELD_EX32(val, MODE_SELECT_REGISTER, LBACK)) {
> > +            qemu_log_mask(LOG_GUEST_ERROR, "Attempting to set LBACK
> mode "
> > +                          "without setting CEN bit as 0\n");
> > +        } else if (FIELD_EX32(val, MODE_SELECT_REGISTER, SNOOP)) {
> > +            qemu_log_mask(LOG_GUEST_ERROR, "Attempting to set SNOOP
> mode "
> > +                              "without setting CEN bit as 0\n");
> > +        }
> > +
> > +        update_status_register_mode_bits(s);
> > +    }
> > +    return s->regs[R_MODE_SELECT_REGISTER]; }
> > +
> > +static uint64_t can_brpr_pre_write(RegisterInfo  *reg, uint64_t
> > +val64) {
> > +    XlnxZynqMPCANState *s =3D XLNX_ZYNQMP_CAN(reg->opaque);
> > +    uint32_t val =3D val64;
> > +
> > +    /* Only allow writes when in config mode. */
> > +    if (ARRAY_FIELD_EX32(s->regs, SOFTWARE_RESET_REGISTER, CEN)) {
> > +        val =3D s-
> >regs[R_ARBITRATION_PHASE_BAUD_RATE_PRESCALER_REGISTER];
> > +    }
> > +
> > +    return val;
> > +}
> > +
> > +static uint64_t can_btr_pre_write(RegisterInfo  *reg, uint64_t val64)
> > +{
> > +    XlnxZynqMPCANState *s =3D XLNX_ZYNQMP_CAN(reg->opaque);
> > +    uint32_t val =3D val64;
> > +
> > +    /* Only allow writes when in config mode. */
> > +    if (ARRAY_FIELD_EX32(s->regs, SOFTWARE_RESET_REGISTER, CEN)) {
> > +        val =3D s->regs[R_ARBITRATION_PHASE_BIT_TIMING_REGISTER];
> > +    }
> > +
> > +    return val;
> > +}
> > +
> > +static uint64_t can_tcr_pre_write(RegisterInfo  *reg, uint64_t val64)
> > +{
> > +    XlnxZynqMPCANState *s =3D XLNX_ZYNQMP_CAN(reg->opaque);
> > +    uint32_t val =3D val64;
> > +
> > +    if (FIELD_EX32(val, TIMESTAMP_REGISTER, CTS)) {
> > +        s->rx_time_stamp =3D 0;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +static void update_rx_fifo(XlnxZynqMPCANState *s, const
> > +qemu_can_frame *frame) {
> > +    uint32_t filter_pass =3D 0;
>=20
> We could consider a bool here (but above is ok for me also).
>=20
> bool filter_pass =3D false;
[Vikram Garhwal] Yeah, bool is better fit for the filter_pass.=20
>=20
>=20
> > +
> > +    /* If no filter is enabled. Message will be stored in FIFO. */
> > +    if (!((ARRAY_FIELD_EX32(s->regs, AFR, UAF1)) |
> > +       (ARRAY_FIELD_EX32(s->regs, AFR, UAF2)) |
> > +       (ARRAY_FIELD_EX32(s->regs, AFR, UAF3)) |
> > +       (ARRAY_FIELD_EX32(s->regs, AFR, UAF4)))) {
> > +        filter_pass =3D 1;
> > +    }
> > +
> > +    /*
> > +     * Messages that pass any of the acceptance filters will be stored=
 in
> > +     * the RX FIFO.
> > +     */
> > +    if (ARRAY_FIELD_EX32(s->regs, AFR, UAF1)) {
> > +        uint32_t id_masked =3D s->regs[R_AFMR1] & frame->can_id;
> > +        uint32_t filter_id_masked =3D s->regs[R_AFMR1] &
> > + s->regs[R_AFIR1];
> > +
> > +        if (filter_id_masked =3D=3D id_masked) {
> > +            filter_pass =3D 1;
> > +        }
> > +    }
> > +
> > +    if (ARRAY_FIELD_EX32(s->regs, AFR, UAF2)) {
> > +        uint32_t id_masked =3D s->regs[R_AFMR2] & frame->can_id;
> > +        uint32_t filter_id_masked =3D s->regs[R_AFMR2] &
> > + s->regs[R_AFIR2];
> > +
> > +        if (filter_id_masked =3D=3D id_masked) {
> > +            filter_pass =3D 1;
> > +        }
> > +    }
> > +
> > +    if (ARRAY_FIELD_EX32(s->regs, AFR, UAF3)) {
> > +        uint32_t id_masked =3D s->regs[R_AFMR3] & frame->can_id;
> > +        uint32_t filter_id_masked =3D s->regs[R_AFMR3] &
> > + s->regs[R_AFIR3];
> > +
> > +        if (filter_id_masked =3D=3D id_masked) {
> > +            filter_pass =3D 1;
> > +        }
> > +    }
> > +
> > +    if (ARRAY_FIELD_EX32(s->regs, AFR, UAF4)) {
> > +        uint32_t id_masked =3D s->regs[R_AFMR4] & frame->can_id;
> > +        uint32_t filter_id_masked =3D s->regs[R_AFMR4] &
> > + s->regs[R_AFIR4];
> > +
> > +        if (filter_id_masked =3D=3D id_masked) {
> > +            filter_pass =3D 1;
> > +        }
> > +    }
> > +
> > +    /* Store the message in fifo if it passed through any of the filte=
rs. */
> > +    if (filter_pass && frame->can_dlc <=3D MAX_DLC) {
> > +
> > +        if (fifo32_is_full(&s->rx_fifo)) {
> > +            DB_PRINT("RX FIFO is full.\n");
> > +
> > +            ARRAY_FIELD_DP32(s->regs, INTERRUPT_STATUS_REGISTER,
> RXOFLW, 1);
> > +        } else {
> > +            s->rx_time_stamp +=3D 1;
> > +
> > +            fifo32_push(&s->rx_fifo, frame->can_id);
> > +
> > +            fifo32_push(&s->rx_fifo, (deposit32(0,
> R_RXFIFO_DLC_DLC_SHIFT,
> > +                                                R_RXFIFO_DLC_DLC_LENGT=
H,
> > +                                                frame->can_dlc) |
> > +                                      deposit32(0, R_RXFIFO_DLC_RXT_SH=
IFT,
> > +                                                R_RXFIFO_DLC_RXT_LENGT=
H,
> > +                                                s->rx_time_stamp)));
> > +
> > +            /* First 32 bit of the data. */
> > +            fifo32_push(&s->rx_fifo, (deposit32(0,
> R_TXFIFO_DATA1_DB3_SHIFT,
> > +                                        R_TXFIFO_DATA1_DB3_LENGTH,
> > +                                        frame->data[0]) |
> > +                                      deposit32(0, R_TXFIFO_DATA1_DB2_=
SHIFT,
> > +                                        R_TXFIFO_DATA1_DB2_LENGTH,
> > +                                        frame->data[1]) |
> > +                                      deposit32(0, R_TXFIFO_DATA1_DB1_=
SHIFT,
> > +                                        R_TXFIFO_DATA1_DB1_LENGTH,
> > +                                        frame->data[2]) |
> > +                                      deposit32(0, R_TXFIFO_DATA1_DB0_=
SHIFT,
> > +                                        R_TXFIFO_DATA1_DB0_LENGTH,
> > +                                        frame->data[3])));
> > +            /* Last 32 bit of the data. */
> > +            fifo32_push(&s->rx_fifo, (deposit32(0,
> R_TXFIFO_DATA2_DB7_SHIFT,
> > +                                         R_TXFIFO_DATA2_DB7_LENGTH,
> > +                                         frame->data[4]) |
> > +                                      deposit32(0, R_TXFIFO_DATA2_DB6_=
SHIFT,
> > +                                         R_TXFIFO_DATA2_DB6_LENGTH,
> > +                                         frame->data[5]) |
> > +                                      deposit32(0, R_TXFIFO_DATA2_DB5_=
SHIFT,
> > +                                         R_TXFIFO_DATA2_DB5_LENGTH,
> > +                                         frame->data[6]) |
> > +                                      deposit32(0, R_TXFIFO_DATA2_DB4_=
SHIFT,
> > +                                          R_TXFIFO_DATA2_DB4_LENGTH,
> > +                                          frame->data[7])));
> > +
> > +            ARRAY_FIELD_DP32(s->regs, INTERRUPT_STATUS_REGISTER,
> RXOK, 1);
> > +        }
> > +
> > +        can_update_irq(s);
> > +
> > +    } else {
> > +        DB_PRINT("Message didn't pass through any filter"
> > +                  "or dlc is not in range\n");
> > +    }
> > +}
> > +
> > +static uint64_t can_rxfifo_pre_read(RegisterInfo *reg, uint64_t
> > +val64) {
> > +    XlnxZynqMPCANState *s =3D XLNX_ZYNQMP_CAN(reg->opaque);
> > +    uint32_t r =3D 0;
> > +
> > +    if (!fifo32_is_empty(&s->rx_fifo)) {
> > +        r =3D fifo32_pop(&s->rx_fifo);
> > +    } else {
> > +        DB_PRINT("No message in RXFIFO\n");
> > +
> > +        ARRAY_FIELD_DP32(s->regs, INTERRUPT_STATUS_REGISTER,
> RXUFLW, 1);
> > +    }
> > +
> > +    can_update_irq(s);
> > +    return r;
> > +}
> > +
> > +static void can_filter_enable_post_write(RegisterInfo *reg, uint64_t
> > +val64) {
> > +    XlnxZynqMPCANState *s =3D XLNX_ZYNQMP_CAN(reg->opaque);
> > +
> > +    if (ARRAY_FIELD_EX32(s->regs, AFR, UAF1) &&
> > +        ARRAY_FIELD_EX32(s->regs, AFR, UAF2) &&
> > +        ARRAY_FIELD_EX32(s->regs, AFR, UAF3) &&
> > +        ARRAY_FIELD_EX32(s->regs, AFR, UAF4)) {
> > +
> > +        ARRAY_FIELD_DP32(s->regs, STATUS_REGISTER, ACFBSY, 1);
> > +
> > +    } else {
> > +        ARRAY_FIELD_DP32(s->regs, STATUS_REGISTER, ACFBSY, 0);
> > +    }
> > +}
> > +
> > +static uint64_t can_filter_mask_pre_write(RegisterInfo *reg, uint64_t
> > +val64) {
> > +    XlnxZynqMPCANState *s =3D XLNX_ZYNQMP_CAN(reg->opaque);
> > +    uint32_t reg_idx =3D (reg->access->addr) / 4;
> > +    uint32_t val =3D val64;
> > +    uint32_t filter_number =3D (reg_idx - R_AFMR1) / 2;
> > +
> > +    /* modify an acceptance filter, the corresponding UAF bit should b=
e
> '0.' */
> > +    if (!(s->regs[R_AFR] & (1 << filter_number))) {
> > +        s->regs[reg_idx] =3D val;
> > +    } else {
> > +        DB_PRINT("Acceptance filter %d mask is not set as it's
> corresponding "
> > +                 "UAF bit is not set to 0\n", filter_number + 1);
> > +    }
> > +
> > +    return s->regs[reg_idx];
> > +}
> > +
> > +static uint64_t can_filter_id_pre_write(RegisterInfo *reg, uint64_t
> > +val64) {
> > +    XlnxZynqMPCANState *s =3D XLNX_ZYNQMP_CAN(reg->opaque);
> > +    uint32_t reg_idx =3D (reg->access->addr) / 4;
> > +    uint32_t val =3D val64;
> > +    uint32_t filter_number =3D (reg_idx - R_AFIR1) / 2;
> > +
> > +    if (!(s->regs[R_AFR] & (1 << filter_number))) {
> > +        s->regs[reg_idx] =3D val;
> > +    } else {
> > +        DB_PRINT("Acceptance filter %d id is not set as it's correspon=
ding "
> > +                 "UAF bit is not set to 0\n", filter_number + 1);
> > +    }
> > +
> > +    return s->regs[reg_idx];
> > +}
> > +
> > +static void can_tx_post_write(RegisterInfo *reg, uint64_t val64) {
> > +    XlnxZynqMPCANState *s =3D XLNX_ZYNQMP_CAN(reg->opaque);
> > +    uint32_t val =3D val64;
> > +
> > +    bool is_txhpb =3D reg->access->addr > A_TXFIFO_DATA2;
> > +
> > +    bool initiate_transfer =3D (reg->access->addr =3D=3D A_TXFIFO_DATA=
2) ||
> > +                             (reg->access->addr =3D=3D A_TXHPB_DATA2);
> > +
> > +    Fifo32 *f =3D is_txhpb ? &s->txhpb_fifo : &s->tx_fifo;
> > +
> > +    DB_PRINT("TX FIFO write for CAN%d\n", s->cfg.ctrl_idx);
> > +
> > +    if (!fifo32_is_full(f)) {
> > +        fifo32_push(f, val);
> > +    } else {
> > +        DB_PRINT("TX FIFO is full.\n");
> > +    }
> > +
> > +    /* Initiate the message send if TX register is written. */
> > +    if (initiate_transfer &&
> > +            ARRAY_FIELD_EX32(s->regs, SOFTWARE_RESET_REGISTER, CEN)) {
> > +        transfer_fifo(s, f);
> > +    }
> > +
> > +    can_update_irq(s);
> > +}
> > +
> > +static const RegisterAccessInfo can_regs_info[] =3D {
> > +    {   .name =3D "SOFTWARE_RESET_REGISTER",
> > +        .addr =3D A_SOFTWARE_RESET_REGISTER,
> > +        .rsvd =3D 0xfffffffc,
> > +        .pre_write =3D can_srr_pre_write,
> > +    },{ .name =3D "MODE_SELECT_REGISTER",
> > +        .addr =3D A_MODE_SELECT_REGISTER,
> > +        .rsvd =3D 0xfffffff8,
> > +        .pre_write =3D can_msr_pre_write,
> > +    },{ .name =3D
> "ARBITRATION_PHASE_BAUD_RATE_PRESCALER_REGISTER",
> > +        .addr =3D
> A_ARBITRATION_PHASE_BAUD_RATE_PRESCALER_REGISTER,
> > +        .rsvd =3D 0xffffff00,
> > +        .pre_write =3D can_brpr_pre_write,
> > +    },{ .name =3D "ARBITRATION_PHASE_BIT_TIMING_REGISTER",
> > +        .addr =3D A_ARBITRATION_PHASE_BIT_TIMING_REGISTER,
> > +        .rsvd =3D 0xfffffe00,
> > +        .pre_write =3D can_btr_pre_write,
> > +    },{ .name =3D "ERROR_COUNTER_REGISTER",
> > +        .addr =3D A_ERROR_COUNTER_REGISTER,
> > +        .rsvd =3D 0xffff0000,
> > +        .ro =3D 0xffffffff,
> > +    },{ .name =3D "ERROR_STATUS_REGISTER",
> > +        .addr =3D A_ERROR_STATUS_REGISTER,
> > +        .rsvd =3D 0xffffffe0,
> > +        .w1c =3D 0x1f,
> > +    },{ .name =3D "STATUS_REGISTER",  .addr =3D A_STATUS_REGISTER,
> > +        .reset =3D 0x1,
> > +        .rsvd =3D 0xffffe000,
> > +        .ro =3D 0x1fff,
> > +    },{ .name =3D "INTERRUPT_STATUS_REGISTER",
> > +        .addr =3D A_INTERRUPT_STATUS_REGISTER,
> > +        .reset =3D 0x6000,
> > +        .rsvd =3D 0xffff8000,
> > +        .ro =3D 0x7fff,
> > +    },{ .name =3D "INTERRUPT_ENABLE_REGISTER",
> > +        .addr =3D A_INTERRUPT_ENABLE_REGISTER,
> > +        .rsvd =3D 0xffff8000,
> > +        .post_write =3D can_ier_post_write,
> > +    },{ .name =3D "INTERRUPT_CLEAR_REGISTER",
> > +        .addr =3D A_INTERRUPT_CLEAR_REGISTER,
> > +        .rsvd =3D 0xffff8000,
> > +        .pre_write =3D can_icr_pre_write,
> > +    },{ .name =3D "TIMESTAMP_REGISTER",
> > +        .addr =3D A_TIMESTAMP_REGISTER,
> > +        .rsvd =3D 0xfffffffe,
> > +        .pre_write =3D can_tcr_pre_write,
> > +    },{ .name =3D "WIR",  .addr =3D A_WIR,
> > +        .reset =3D 0x3f3f,
> > +        .rsvd =3D 0xffff0000,
> > +    },{ .name =3D "TXFIFO_ID",  .addr =3D A_TXFIFO_ID,
> > +        .post_write =3D can_tx_post_write,
> > +    },{ .name =3D "TXFIFO_DLC",  .addr =3D A_TXFIFO_DLC,
> > +        .rsvd =3D 0xfffffff,
> > +        .post_write =3D can_tx_post_write,
> > +    },{ .name =3D "TXFIFO_DATA1",  .addr =3D A_TXFIFO_DATA1,
> > +        .post_write =3D can_tx_post_write,
> > +    },{ .name =3D "TXFIFO_DATA2",  .addr =3D A_TXFIFO_DATA2,
> > +        .post_write =3D can_tx_post_write,
> > +    },{ .name =3D "TXHPB_ID",  .addr =3D A_TXHPB_ID,
> > +        .post_write =3D can_tx_post_write,
> > +    },{ .name =3D "TXHPB_DLC",  .addr =3D A_TXHPB_DLC,
> > +        .rsvd =3D 0xfffffff,
> > +        .post_write =3D can_tx_post_write,
> > +    },{ .name =3D "TXHPB_DATA1",  .addr =3D A_TXHPB_DATA1,
> > +        .post_write =3D can_tx_post_write,
> > +    },{ .name =3D "TXHPB_DATA2",  .addr =3D A_TXHPB_DATA2,
> > +        .post_write =3D can_tx_post_write,
> > +    },{ .name =3D "RXFIFO_ID",  .addr =3D A_RXFIFO_ID,
> > +        .ro =3D 0xffffffff,
> > +        .post_read =3D can_rxfifo_pre_read,
> > +    },{ .name =3D "RXFIFO_DLC",  .addr =3D A_RXFIFO_DLC,
> > +        .rsvd =3D 0xfff0000,
> > +        .post_read =3D can_rxfifo_pre_read,
> > +    },{ .name =3D "RXFIFO_DATA1",  .addr =3D A_RXFIFO_DATA1,
> > +        .post_read =3D can_rxfifo_pre_read,
> > +    },{ .name =3D "RXFIFO_DATA2",  .addr =3D A_RXFIFO_DATA2,
> > +        .post_read =3D can_rxfifo_pre_read,
> > +    },{ .name =3D "AFR",  .addr =3D A_AFR,
> > +        .rsvd =3D 0xfffffff0,
> > +        .post_write =3D can_filter_enable_post_write,
> > +    },{ .name =3D "AFMR1",  .addr =3D A_AFMR1,
> > +        .pre_write =3D can_filter_mask_pre_write,
> > +    },{ .name =3D "AFIR1",  .addr =3D A_AFIR1,
> > +        .pre_write =3D can_filter_id_pre_write,
> > +    },{ .name =3D "AFMR2",  .addr =3D A_AFMR2,
> > +        .pre_write =3D can_filter_mask_pre_write,
> > +    },{ .name =3D "AFIR2",  .addr =3D A_AFIR2,
> > +        .pre_write =3D can_filter_id_pre_write,
> > +    },{ .name =3D "AFMR3",  .addr =3D A_AFMR3,
> > +        .pre_write =3D can_filter_mask_pre_write,
> > +    },{ .name =3D "AFIR3",  .addr =3D A_AFIR3,
> > +        .pre_write =3D can_filter_id_pre_write,
> > +    },{ .name =3D "AFMR4",  .addr =3D A_AFMR4,
> > +        .pre_write =3D can_filter_mask_pre_write,
> > +    },{ .name =3D "AFIR4",  .addr =3D A_AFIR4,
> > +        .pre_write =3D can_filter_id_pre_write,
> > +    }
> > +};
> > +
> > +static const MemoryRegionOps can_ops =3D {
> > +    .read =3D register_read_memory,
> > +    .write =3D register_write_memory,
> > +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> > +    .valid =3D {
> > +        .min_access_size =3D 4,
> > +        .max_access_size =3D 4,
> > +    },
> > +};
> > +
> > +static void xlnx_zynqmp_can_reset(DeviceState *dev) {
> > +    XlnxZynqMPCANState *s =3D XLNX_ZYNQMP_CAN(dev);
> > +    unsigned int i;
> > +
> > +    for (i =3D 0; i < ARRAY_SIZE(s->reg_info); ++i) {
> > +        register_reset(&s->reg_info[i]);
> > +    }
> > +
> > +    /*
> > +     * Reset FIFOs when CAN model is reset. This will clear the fifo w=
rites
> > +     * done by post_write which gets called from register_reset functi=
on,
> > +     * post_write handle will not be able to trigger tx because CAN wi=
ll be
> > +     * disabled when software_reset_register is cleared first.
> > +     */
> > +    fifo32_reset(&s->rx_fifo);
> > +    fifo32_reset(&s->tx_fifo);
> > +    fifo32_reset(&s->txhpb_fifo);
> > +}
> > +
> > +static bool xlnx_zynqmp_can_can_receive(CanBusClientState *client) {
> > +    XlnxZynqMPCANState *s =3D container_of(client, XlnxZynqMPCANState,
> > +                                         bus_client);
> > +
> > +    if (ARRAY_FIELD_EX32(s->regs, SOFTWARE_RESET_REGISTER, SRST)) {
> > +        DB_PRINT("XlnxZynqMPCANState%d Controller is reset\n", s-
> >cfg.ctrl_idx);
> > +        return false;
> > +    } else if ((ARRAY_FIELD_EX32(s->regs, SOFTWARE_RESET_REGISTER,
> CEN)) =3D=3D 0) {
> > +        DB_PRINT("XlnxZynqMPCANState%d is disabled. Incoming messages
> will be"
> > +                 "discarded\n", s->cfg.ctrl_idx);
> > +        return false;
> > +    } else {
> > +        return true;
> > +    }
> > +}
> > +
> > +static ssize_t xlnx_zynqmp_can_receive(CanBusClientState *client,
> > +                               const qemu_can_frame *buf, size_t buf_s=
ize) {
> > +    XlnxZynqMPCANState *s =3D container_of(client, XlnxZynqMPCANState,
> > +                                        bus_client);
> > +    const qemu_can_frame *frame =3D buf;
> > +
> > +    DB_PRINT("Incoming data for CAN%d\n", s->cfg.ctrl_idx);
> > +
> > +    if (buf_size <=3D 0) {
> > +        DB_PRINT("junk data received on XlnxZynqMPCANState bus\n");
> > +        return 0;
> > +    }
> > +    if (ARRAY_FIELD_EX32(s->regs, STATUS_REGISTER, LBACK)) {
> > +        /*
> > +         * XlnxZynqMPCANState will not participate in normal bus
> communication
> > +         *  and does not receive any messages transmitted by other CAN
> nodes.
> > +         */
> > +        DB_PRINT("XlnxZynqMPCANState is in loopback mode."
> > +                 " It will not receive data.\n");
> > +
> > +    } else if (ARRAY_FIELD_EX32(s->regs, STATUS_REGISTER, SNOOP)) {
> > +        /* Snoop Mode: Just keep the data. no response back. */
> > +        update_rx_fifo(s, frame);
> > +    } else if ((ARRAY_FIELD_EX32(s->regs, STATUS_REGISTER, SLEEP))) {
> > +        /*
> > +         * XlnxZynqMPCANState is in sleep mode. Any data on bus will b=
ring
> it
> > +         * to wake up state.
> > +         */
> > +        can_exit_sleep_mode(s);
> > +        update_rx_fifo(s, frame);
> > +    } else if ((ARRAY_FIELD_EX32(s->regs, STATUS_REGISTER, SLEEP)) =3D=
=3D 0)
> {
> > +        update_rx_fifo(s, frame);
> > +    } else {
> > +        DB_PRINT("Can't receive data as XlnxZynqMPCANState is not
> configured"
> > +                  " correctly.\n");
> > +    }
> > +
> > +    return 1;
> > +}
> > +
> > +static CanBusClientInfo can_xilinx_bus_client_info =3D {
> > +    .can_receive =3D xlnx_zynqmp_can_can_receive,
> > +    .receive =3D xlnx_zynqmp_can_receive, };
> > +
> > +static int xlnx_zynqmp_can_connect_to_bus(XlnxZynqMPCANState *s,
> > +                                          CanBusState *bus) {
> > +    s->bus_client.info =3D &can_xilinx_bus_client_info;
> > +
> > +    if (can_bus_insert_client(bus, &s->bus_client) < 0) {
> > +        return -1;
> > +    }
> > +    return 0;
> > +}
> > +
> > +static void xlnx_zynqmp_can_realize(DeviceState *dev, Error **errp) {
> > +    XlnxZynqMPCANState *s =3D XLNX_ZYNQMP_CAN(dev);
> > +
> > +    if (s->cfg.ctrl_idx > MAX_CAN_CTRLS) {
> > +        error_setg(errp, "ctrl-idx: %d exceeds max XlnxZynqMPCANState"
> > +                   " controller index", s->cfg.ctrl_idx);
> > +        return;
> > +    }
> > +
> > +    if (s->canbus[s->cfg.ctrl_idx]) {
> > +        if (xlnx_zynqmp_can_connect_to_bus(s, s->canbus[s->cfg.ctrl_id=
x])
> < 0) {
> > +            error_setg(errp, "xlnx_zynqmp_can_connect_to_bus
> > + failed");
>=20
> Add a 'return' here (as above).
[Vikram Garhwal] Good catch! This one should return as it will be throwing =
error. Addressing this in v4.
>=20
> Best regards,
> Francisco Iglesias
>=20
> > +        }
> > +
> > +    } else {
> > +        /* If no bus is set. */
> > +        DB_PRINT("Canbus%d property is not set for xlnxCAN%d\n",
> > +                 s->cfg.ctrl_idx, s->cfg.ctrl_idx);
> > +    }
> > +
> > +    /* Create RX FIFO, TXFIFO, TXHPB storage. */
> > +    fifo32_create(&s->rx_fifo, RXFIFO_SIZE);
> > +    fifo32_create(&s->tx_fifo, RXFIFO_SIZE);
> > +    fifo32_create(&s->txhpb_fifo, CAN_FRAME_SIZE); }
> > +
> > +static void xlnx_zynqmp_can_init(Object *obj) {
> > +    XlnxZynqMPCANState *s =3D XLNX_ZYNQMP_CAN(obj);
> > +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> > +
> > +    RegisterInfoArray *reg_array;
> > +
> > +    memory_region_init(&s->iomem, obj, TYPE_XLNX_ZYNQMP_CAN,
> > +                        XLNX_ZYNQMP_CAN_R_MAX * 4);
> > +    reg_array =3D register_init_block32(DEVICE(obj), can_regs_info,
> > +                               ARRAY_SIZE(can_regs_info),
> > +                               s->reg_info, s->regs,
> > +                               &can_ops,
> > +                               XLNX_ZYNQMP_CAN_ERR_DEBUG,
> > +                               XLNX_ZYNQMP_CAN_R_MAX * 4);
> > +
> > +    memory_region_add_subregion(&s->iomem, 0x00, &reg_array-
> >mem);
> > +    sysbus_init_mmio(sbd, &s->iomem);
> > +    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
> > +
> > +    object_property_add_link(obj, "canbus0", TYPE_CAN_BUS,
> > +                             (Object **)&s->canbus[0],
> > +                             qdev_prop_allow_set_link_before_realize,
> > +                             0, &error_abort);
> > +
> > +    object_property_add_link(obj, "canbus1", TYPE_CAN_BUS,
> > +                             (Object **)&s->canbus[1],
> > +                             qdev_prop_allow_set_link_before_realize,
> > +                             0, &error_abort); }
> > +
> > +static const VMStateDescription vmstate_can =3D {
> > +    .name =3D TYPE_XLNX_ZYNQMP_CAN,
> > +    .version_id =3D 1,
> > +    .minimum_version_id =3D 1,
> > +    .fields =3D (VMStateField[]) {
> > +        VMSTATE_FIFO32(rx_fifo, XlnxZynqMPCANState),
> > +        VMSTATE_UINT32_ARRAY(regs, XlnxZynqMPCANState,
> XLNX_ZYNQMP_CAN_R_MAX),
> > +        VMSTATE_UINT8(cfg.ctrl_idx, XlnxZynqMPCANState),
> > +        VMSTATE_END_OF_LIST(),
> > +    }
> > +};
> > +
> > +static Property xlnx_zynqmp_can_properties[] =3D {
> > +    DEFINE_PROP_UINT8("ctrl-idx", XlnxZynqMPCANState, cfg.ctrl_idx, 0)=
,
> > +    DEFINE_PROP_END_OF_LIST(),
> > +};
> > +
> > +static void xlnx_zynqmp_can_class_init(ObjectClass *klass, void
> > +*data) {
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +    dc->reset =3D xlnx_zynqmp_can_reset;
> > +    dc->realize =3D xlnx_zynqmp_can_realize;
> > +    device_class_set_props(dc, xlnx_zynqmp_can_properties);
> > +    dc->vmsd =3D &vmstate_can;
> > +}
> > +
> > +static const TypeInfo can_info =3D {
> > +    .name          =3D TYPE_XLNX_ZYNQMP_CAN,
> > +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> > +    .instance_size =3D sizeof(XlnxZynqMPCANState),
> > +    .class_init    =3D xlnx_zynqmp_can_class_init,
> > +    .instance_init =3D xlnx_zynqmp_can_init, };
> > +
> > +static void can_register_types(void)
> > +{
> > +    type_register_static(&can_info);
> > +}
> > +
> > +type_init(can_register_types)
> > diff --git a/include/hw/net/xlnx-zynqmp-can.h
> > b/include/hw/net/xlnx-zynqmp-can.h
> > new file mode 100644
> > index 0000000..3038542
> > --- /dev/null
> > +++ b/include/hw/net/xlnx-zynqmp-can.h
> > @@ -0,0 +1,76 @@
> > +/*
> > + * QEMU model of the Xilinx CAN device.
> > + *
> > + * Copyright (c) 2020 Xilinx Inc.
> > + *
> > + * Written-by: Vikram Garhwal<fnu.vikram@xilinx.com>
> > + *
> > + * Based on QEMU CAN Device emulation implemented by Jin Yang,
> Deniz
> > +Eren and
> > + * Pavel Pisa.
> > + *
> > + * Permission is hereby granted, free of charge, to any person
> > +obtaining a copy
> > + * of this software and associated documentation files (the
> > +"Software"), to deal
> > + * in the Software without restriction, including without limitation
> > +the rights
> > + * to use, copy, modify, merge, publish, distribute, sublicense,
> > +and/or sell
> > + * copies of the Software, and to permit persons to whom the Software
> > +is
> > + * furnished to do so, subject to the following conditions:
> > + *
> > + * The above copyright notice and this permission notice shall be
> > +included in
> > + * all copies or substantial portions of the Software.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
> KIND,
> > +EXPRESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> > +MERCHANTABILITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO
> EVENT
> > +SHALL
> > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
> DAMAGES
> > +OR OTHER
> > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> OTHERWISE,
> > +ARISING FROM,
> > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> OTHER
> > +DEALINGS IN
> > + * THE SOFTWARE.
> > + */
> > +
> > +#ifndef HW_CAN_XILINX_H
> > +#define HW_CAN_XILINX_H
> > +
> > +#include "hw/register.h"
> > +#include "net/can_emu.h"
> > +#include "net/can_host.h"
> > +#include "qemu/fifo32.h"
> > +
> > +#define TYPE_XLNX_ZYNQMP_CAN "xlnx.zynqmp-can"
> > +
> > +#define XLNX_ZYNQMP_CAN(obj) \
> > +     OBJECT_CHECK(XlnxZynqMPCANState, (obj),
> TYPE_XLNX_ZYNQMP_CAN)
> > +
> > +#define MAX_CAN_CTRLS      2
> > +#define XLNX_ZYNQMP_CAN_R_MAX     (0x84 / 4)
> > +#define MAILBOX_CAPACITY   64
> > +
> > +/* Each CAN_FRAME will have 4 * 32bit size. */
> > +#define CAN_FRAME_SIZE     4
> > +#define RXFIFO_SIZE        (MAILBOX_CAPACITY * CAN_FRAME_SIZE)
> > +
> > +
> > +typedef struct XlnxZynqMPCANState {
> > +    SysBusDevice        parent_obj;
> > +    MemoryRegion        iomem;
> > +
> > +    qemu_irq            irq;
> > +
> > +    CanBusClientState   bus_client;
> > +    CanBusState         *canbus[MAX_CAN_CTRLS];
> > +
> > +    struct {
> > +        uint8_t         ctrl_idx;
> > +   } cfg;
> > +
> > +    RegisterInfo        reg_info[XLNX_ZYNQMP_CAN_R_MAX];
> > +    uint32_t            regs[XLNX_ZYNQMP_CAN_R_MAX];
> > +
> > +    uint16_t            rx_time_stamp;
> > +
> > +    Fifo32                rx_fifo;
> > +    Fifo32                tx_fifo;
> > +    Fifo32                txhpb_fifo;
> > +
> > +} XlnxZynqMPCANState;
> > +
> > +#endif
> > --
> > 2.7.4
> >
> >

