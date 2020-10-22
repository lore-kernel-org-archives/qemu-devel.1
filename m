Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEAE8C388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 12:27:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 038FB221FB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 12:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="NijGXVru"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 038FB221FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVZgx-0003Ny-0j
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 08:27:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kVZXv-000374-QB
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 08:18:19 -0400
Received: from mail-eopbgr750054.outbound.protection.outlook.com
 ([40.107.75.54]:45546 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kVZXo-0001o8-5K
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 08:18:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EIRKYpw6z+dklTWFSXRze9oGiuHyPb+oN7ve3SXZHgfGkhmLB35W7WNOwkoVyNlg2haufBAVUe2gAhLuLTJHom4MHb/k5AhKsZR18oApUzVvfC2kHt1JVAzMt2inwpdkJXemIzNXTb+Mr7r1/8YfAdOk2OV9+fKKiAy11dqqtu6a7T5gsl2TkYBMfZXEnf9uAXfQ/Kfh6Gy4uB3fPdxFTiBzhyveH7r/GaSAh1JTl9PubrWGWIZ/CeJwoGm+tL92T70ERxqGNW6OmWtcW3W29zRk0FCdl/feNFiRW+MDDpQqsTJb9RjMoarOIzPuDFhucMNQ0J0D9pS4G+4o6Kz2ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPdcMCdPcDDiNETFAEJW9xlGWMuIgqaixTojgh4Ms+M=;
 b=g/UiDez2cX7pAeCnX1r8ZHtQ0TIVFKWDea+5dW6s+HKtc7rYrJ3rWQnaAVFOjfHIn9UfU/5H/0CtHwQV7+l3zr+cg91kFb1dG7Ej2rc0eR2dXB0sB62ivL7Z5ZRMLTOrf1/+3ORCPNcTF3g3zUo64gJYhr2/FnLGxORTf2FKApgZoCXwQMMgUo/OwT6gauux6Mfn4oppJGCZw0XrZsNV7VURAvhxGeNELHptVNiEL14KBEn6XX7QlzqJAw+DfyvnW5hFJaOqDOYMWUKmKnJcIcOTBFkR+kFf7CkIsqr+WrBeYomIjWXeLeWNk+QF98ZI9oVsXQ2w2xpRGlCUr7N7gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPdcMCdPcDDiNETFAEJW9xlGWMuIgqaixTojgh4Ms+M=;
 b=NijGXVruxGLkeVJpTrJDMzVd4wtj5vMLdbqoqVKw2RJ97KvrsbctZG2IhkUu+i3CmmdK6qsSsd2TeqFHjEaPeQuMps0VxSOWANMqRvdlqLHzEe1lEACQWPzq+2V/p4J8r+oLeViQscxRxB7ztd7zzo6IBWHcWZ1rz5ASTa06FtQ=
Received: from BY5PR02MB6772.namprd02.prod.outlook.com (2603:10b6:a03:206::11)
 by BYAPR02MB5414.namprd02.prod.outlook.com (2603:10b6:a03:95::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Thu, 22 Oct
 2020 12:03:01 +0000
Received: from BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::75ed:4271:263b:fd15]) by BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::75ed:4271:263b:fd15%3]) with mapi id 15.20.3499.018; Thu, 22 Oct 2020
 12:03:01 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: Edgar Iglesias <edgari@xilinx.com>
Subject: RE: [PATCH v11 2/3] usb: Add DWC3 model
Thread-Topic: [PATCH v11 2/3] usb: Add DWC3 model
Thread-Index: AQHWlk7KmB3D7ZVEc02OY+7swAuTmKl/rDqAgCP045A=
Date: Thu, 22 Oct 2020 12:03:01 +0000
Message-ID: <BY5PR02MB6772FC9C401690A822FB4390CA1D0@BY5PR02MB6772.namprd02.prod.outlook.com>
References: <1601376942-9648-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1601376942-9648-3-git-send-email-sai.pavan.boddu@xilinx.com>
 <20200929142547.GP17122@toto>
In-Reply-To: <20200929142547.GP17122@toto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 947bc746-9290-4210-8542-08d876826ce5
x-ms-traffictypediagnostic: BYAPR02MB5414:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB54142EA221A3DFAE4986D712CA1D0@BYAPR02MB5414.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:335;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g99svNxqg1ksbjaFS+ggvJ1JlfQB4W+k/cId5IX9nI/4X8XTZv8lIFFe94IArC20yAQjnoISWt630qIrBTNzVnR5y6fm0o2N/1QJOeuzhtNaCkwSQ9wglXNKpugZkqTSmihL1CtbpB3qETUPjhbjr8XHNXAOFr7/w9+tLckxj959aQ0OcMwhFWLN/RZMaNy2V8aXMdq/VkN1W0wVDkcBvP8zMgMfE0S0yR5tCaqw7p4s4FLZxA7qxBmBXYsHfVKKYTzdnyoms+0JfmNjBEmRppgDEB9PQ4dqE32DJSfbKQ4bJfTykmhseMX6J+iB+h3TWw+kJDOjnqoYK9lr4PLXD8oXYR4RNIkGgDJmq+TLUdsgDpuX6wP/oDrcLQ0SI2ln
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6772.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(376002)(396003)(39860400002)(136003)(366004)(76116006)(64756008)(66556008)(5660300002)(66946007)(66476007)(54906003)(55016002)(30864003)(86362001)(52536014)(66446008)(316002)(4326008)(478600001)(6636002)(186003)(7416002)(6862004)(83380400001)(9686003)(7696005)(33656002)(6506007)(8936002)(2906002)(71200400001)(8676002)(26005)(53546011)(21314003)(579004)(559001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: Nby6jtCwr6Hi1Bn9MNBPX3keTmizI0v5uog678uJAmtNWhOOlWSOp3OfNwfFz2BMqCoHqd450ZDt6WwTXxXvJwaS/PWg+4hH4EhlQSgBbWJdvEDgO+dNsF84SNoosnwSPhSJnlQwM89rs8iYQPyYOHK7WXcI8+S7IT4/E5g5AH1OXn/+rtnVQz4d5FUK8HSrRQsQXkqM8OroTttTUmQsdxnXjZ4KZVbrWBIIDbxUoiSjO9oWK6enndZiIVkkU/MfQO7xN0Rg1mFrihNyW6nvpBMoWTs+CSc3wKMlpSQR75uxNeocXzeLXUg0IZhERu6Dk4RcToH2aQLp5tOYgEGpzF1lleuELSYeM9hfSQGOdHst3sfTlpAH1eNUu0xA63+bERgory3WwGqeImcWdL+6bmadgrniXnrF7v1QU0v9ddp5un/K7EyYeRfkMz5RQTDXk/5vesOFOSBt1xtb7TgN94Cv+wgRVrZwWTbbsyeGTaR8gQTDaXFAGMkyjCnfePeZlLWe3nH15xDKUikPSjYujnXh9cQ1IWQB6v4s0kMga4nb+4/fW06Ld0imjwZ+s2FtzaC+P6ZudFgUyRg/nT6Od9osb05dlfQun5rh/H+wL2kiXQrEtpSJeHYUEA3LCBXyoPB0nTv/lDmwODblcycn+A==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6772.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 947bc746-9290-4210-8542-08d876826ce5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2020 12:03:01.6079 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KJ23W0vQOGXZHR2trWh55Zjz93qshD/+siEpV0ilnRaK+1IH7yR6rHce0ySznsyCMYPwYuw4mA9tphog+eOtgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5414
Received-SPF: pass client-ip=40.107.75.54; envelope-from=saipava@xilinx.com;
 helo=NAM02-BL2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 08:18:06
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Francisco Eduardo Iglesias <figlesia@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Vikram Garhwal <fnuv@xilinx.com>,
 Markus Armbruster <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Edgar Iglesias <edgari@xilinx.com>,
 Alistair Francis <alistair.francis@wdc.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?iso-8859-1?Q?=27Marc-Andr=E9_Lureau=27?= <marcandre.lureau@redhat.com>,
 Ying Fang <fangying1@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 =?iso-8859-1?Q?=27Philippe_Mathieu-Daud=E9=27?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Edgar,

Sorry for late followup, few comment inline below.

> -----Original Message-----
> From: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> Sent: Tuesday, September 29, 2020 7:56 PM
> To: Sai Pavan Boddu <saipava@xilinx.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>; Markus Armbruster
> <armbru@redhat.com>; 'Marc-Andr=E9 Lureau'
> <marcandre.lureau@redhat.com>; Paolo Bonzini <pbonzini@redhat.com>;
> Gerd Hoffmann <kraxel@redhat.com>; Edgar Iglesias <edgari@xilinx.com>;
> Francisco Eduardo Iglesias <figlesia@xilinx.com>; qemu-devel@nongnu.org;
> Alistair Francis <alistair.francis@wdc.com>; Eduardo Habkost
> <ehabkost@redhat.com>; Ying Fang <fangying1@huawei.com>; 'Philippe
> Mathieu-Daud=E9' <philmd@redhat.com>; Vikram Garhwal <fnuv@xilinx.com>;
> Paul Zimmerman <pauldzim@gmail.com>; Sai Pavan Boddu
> <saipava@xilinx.com>
> Subject: Re: [PATCH v11 2/3] usb: Add DWC3 model
>=20
> On Tue, Sep 29, 2020 at 04:25:41PM +0530, Sai Pavan Boddu wrote:
> > From: Vikram Garhwal <fnu.vikram@xilinx.com>
> >
> > This patch adds skeleton model of dwc3 usb controller attached to
> > xhci-sysbus device. It defines global register space of DWC3
> > controller, global registers control the AXI/AHB interfaces
> > properties, external FIFO support and event count support. All of
> > which are unimplemented at present,we are only supporting core reset an=
d
> read of ID register.
> >
> > Signed-off-by: Vikram Garhwal <fnu.vikram@xilinx.com>
> > Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> > ---
> >  hw/usb/Kconfig            |   6 +
> >  hw/usb/hcd-dwc3.c         | 717
> ++++++++++++++++++++++++++++++++++++++++++++++
> >  hw/usb/meson.build        |   1 +
> >  include/hw/usb/hcd-dwc3.h |  55 ++++
> >  4 files changed, 779 insertions(+)
> >  create mode 100644 hw/usb/hcd-dwc3.c
> >  create mode 100644 include/hw/usb/hcd-dwc3.h
> >
> > diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig index 4dd2ba9..f5762f0
> > 100644
> > --- a/hw/usb/Kconfig
> > +++ b/hw/usb/Kconfig
> > @@ -116,3 +116,9 @@ config IMX_USBPHY
> >      bool
> >      default y
> >      depends on USB
> > +
> > +config USB_DWC3
> > +    bool
> > +    default y if USB_XHCI_SYSBUS
> > +    select USB
> > +    select REGISTER
> > diff --git a/hw/usb/hcd-dwc3.c b/hw/usb/hcd-dwc3.c new file mode
> > 100644 index 0000000..de8be7a
> > --- /dev/null
> > +++ b/hw/usb/hcd-dwc3.c
> > @@ -0,0 +1,717 @@
> > +/*
> > + * QEMU model of the USB DWC3 host controller emulation.
> > + *
> > + * This model defines global register space of DWC3 controller.
> > +Global
> > + * registers control the AXI/AHB interfaces properties, external FIFO
> > +support
> > + * and event count support. All of which are unimplemented at
> > +present. We are
> > + * only supporting core reset and read of ID register.
> > + *
> > + * Copyright (c) 2020 Xilinx Inc. Vikram
> > +Garhwal<fnu.vikram@xilinx.com>
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
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> > +EXPRESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> > +MERCHANTABILITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO
> EVENT
> > +SHALL
> > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
> DAMAGES
> > +OR OTHER
> > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> > +ARISING FROM,
> > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
> > +DEALINGS IN
> > + * THE SOFTWARE.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "hw/sysbus.h"
> > +#include "hw/register.h"
> > +#include "qemu/bitops.h"
> > +#include "qemu/log.h"
> > +#include "qom/object.h"
> > +#include "migration/vmstate.h"
> > +#include "hw/qdev-properties.h"
> > +#include "hw/usb/hcd-dwc3.h"
> > +#include "qapi/error.h"
> > +
> > +#ifndef USB_DWC3_ERR_DEBUG
> > +#define USB_DWC3_ERR_DEBUG 0
> > +#endif
> > +
> > +#define HOST_MODE           1
> > +#define FIFO_LEN         0x1000
> > +
> > +REG32(GSBUSCFG0, 0x00)
> > +    FIELD(GSBUSCFG0, DATRDREQINFO, 28, 4)
> > +    FIELD(GSBUSCFG0, DESRDREQINFO, 24, 4)
> > +    FIELD(GSBUSCFG0, DATWRREQINFO, 20, 4)
> > +    FIELD(GSBUSCFG0, DESWRREQINFO, 16, 4)
> > +    FIELD(GSBUSCFG0, RESERVED_15_12, 12, 4)
> > +    FIELD(GSBUSCFG0, DATBIGEND, 11, 1)
> > +    FIELD(GSBUSCFG0, DESBIGEND, 10, 1)
> > +    FIELD(GSBUSCFG0, RESERVED_9_8, 8, 2)
> > +    FIELD(GSBUSCFG0, INCR256BRSTENA, 7, 1)
> > +    FIELD(GSBUSCFG0, INCR128BRSTENA, 6, 1)
> > +    FIELD(GSBUSCFG0, INCR64BRSTENA, 5, 1)
> > +    FIELD(GSBUSCFG0, INCR32BRSTENA, 4, 1)
> > +    FIELD(GSBUSCFG0, INCR16BRSTENA, 3, 1)
> > +    FIELD(GSBUSCFG0, INCR8BRSTENA, 2, 1)
> > +    FIELD(GSBUSCFG0, INCR4BRSTENA, 1, 1)
> > +    FIELD(GSBUSCFG0, INCRBRSTENA, 0, 1) REG32(GSBUSCFG1, 0x04)
> > +    FIELD(GSBUSCFG1, RESERVED_31_13, 13, 19)
> > +    FIELD(GSBUSCFG1, EN1KPAGE, 12, 1)
> > +    FIELD(GSBUSCFG1, PIPETRANSLIMIT, 8, 4)
> > +    FIELD(GSBUSCFG1, RESERVED_7_0, 0, 8) REG32(GTXTHRCFG, 0x08)
> > +    FIELD(GTXTHRCFG, RESERVED_31, 31, 1)
> > +    FIELD(GTXTHRCFG, RESERVED_30, 30, 1)
> > +    FIELD(GTXTHRCFG, USBTXPKTCNTSEL, 29, 1)
> > +    FIELD(GTXTHRCFG, RESERVED_28, 28, 1)
> > +    FIELD(GTXTHRCFG, USBTXPKTCNT, 24, 4)
> > +    FIELD(GTXTHRCFG, USBMAXTXBURSTSIZE, 16, 8)
> > +    FIELD(GTXTHRCFG, RESERVED_15, 15, 1)
> > +    FIELD(GTXTHRCFG, RESERVED_14, 14, 1)
> > +    FIELD(GTXTHRCFG, RESERVED_13_11, 11, 3)
> > +    FIELD(GTXTHRCFG, RESERVED_10_0, 0, 11) REG32(GRXTHRCFG, 0x0c)
> > +    FIELD(GRXTHRCFG, RESERVED_31_30, 30, 2)
> > +    FIELD(GRXTHRCFG, USBRXPKTCNTSEL, 29, 1)
> > +    FIELD(GRXTHRCFG, RESERVED_28, 28, 1)
> > +    FIELD(GRXTHRCFG, USBRXPKTCNT, 24, 4)
> > +    FIELD(GRXTHRCFG, USBMAXRXBURSTSIZE, 19, 5)
> > +    FIELD(GRXTHRCFG, RESERVED_18_16, 16, 3)
> > +    FIELD(GRXTHRCFG, RESERVED_15, 15, 1)
> > +    FIELD(GRXTHRCFG, RESERVED_14_13, 13, 2)
> > +    FIELD(GRXTHRCFG, RESVISOCOUTSPC, 0, 13) REG32(GCTL, 0x10)
> > +    FIELD(GCTL, PWRDNSCALE, 19, 13)
> > +    FIELD(GCTL, MASTERFILTBYPASS, 18, 1)
> > +    FIELD(GCTL, BYPSSETADDR, 17, 1)
> > +    FIELD(GCTL, U2RSTECN, 16, 1)
> > +    FIELD(GCTL, FRMSCLDWN, 14, 2)
> > +    FIELD(GCTL, PRTCAPDIR, 12, 2)
> > +    FIELD(GCTL, CORESOFTRESET, 11, 1)
> > +    FIELD(GCTL, U1U2TIMERSCALE, 9, 1)
> > +    FIELD(GCTL, DEBUGATTACH, 8, 1)
> > +    FIELD(GCTL, RAMCLKSEL, 6, 2)
> > +    FIELD(GCTL, SCALEDOWN, 4, 2)
> > +    FIELD(GCTL, DISSCRAMBLE, 3, 1)
> > +    FIELD(GCTL, U2EXIT_LFPS, 2, 1)
> > +    FIELD(GCTL, GBLHIBERNATIONEN, 1, 1)
> > +    FIELD(GCTL, DSBLCLKGTNG, 0, 1)
> > +REG32(GPMSTS, 0x14)
> > +REG32(GSTS, 0x18)
> > +    FIELD(GSTS, CBELT, 20, 12)
> > +    FIELD(GSTS, RESERVED_19_12, 12, 8)
> > +    FIELD(GSTS, SSIC_IP, 11, 1)
> > +    FIELD(GSTS, OTG_IP, 10, 1)
> > +    FIELD(GSTS, BC_IP, 9, 1)
> > +    FIELD(GSTS, ADP_IP, 8, 1)
> > +    FIELD(GSTS, HOST_IP, 7, 1)
> > +    FIELD(GSTS, DEVICE_IP, 6, 1)
> > +    FIELD(GSTS, CSRTIMEOUT, 5, 1)
> > +    FIELD(GSTS, BUSERRADDRVLD, 4, 1)
> > +    FIELD(GSTS, RESERVED_3_2, 2, 2)
> > +    FIELD(GSTS, CURMOD, 0, 2)
> > +REG32(GUCTL1, 0x1c)
> > +    FIELD(GUCTL1, RESUME_OPMODE_HS_HOST, 10, 1) REG32(GSNPSID,
> 0x20)
> > +REG32(GGPIO, 0x24)
> > +    FIELD(GGPIO, GPO, 16, 16)
> > +    FIELD(GGPIO, GPI, 0, 16)
> > +REG32(GUID, 0x28)
> > +REG32(GUCTL, 0x2c)
> > +    FIELD(GUCTL, REFCLKPER, 22, 10)
> > +    FIELD(GUCTL, NOEXTRDL, 21, 1)
> > +    FIELD(GUCTL, RESERVED_20_18, 18, 3)
> > +    FIELD(GUCTL, SPRSCTRLTRANSEN, 17, 1)
> > +    FIELD(GUCTL, RESBWHSEPS, 16, 1)
> > +    FIELD(GUCTL, RESERVED_15, 15, 1)
> > +    FIELD(GUCTL, USBHSTINAUTORETRYEN, 14, 1)
> > +    FIELD(GUCTL, ENOVERLAPCHK, 13, 1)
> > +    FIELD(GUCTL, EXTCAPSUPPTEN, 12, 1)
> > +    FIELD(GUCTL, INSRTEXTRFSBODI, 11, 1)
> > +    FIELD(GUCTL, DTCT, 9, 2)
> > +    FIELD(GUCTL, DTFT, 0, 9)
> > +REG32(GBUSERRADDRLO, 0x30)
> > +REG32(GBUSERRADDRHI, 0x34)
> > +REG32(GHWPARAMS0, 0x40)
> > +    FIELD(GHWPARAMS0, GHWPARAMS0_31_24, 24, 8)
> > +    FIELD(GHWPARAMS0, GHWPARAMS0_23_16, 16, 8)
> > +    FIELD(GHWPARAMS0, GHWPARAMS0_15_8, 8, 8)
> > +    FIELD(GHWPARAMS0, GHWPARAMS0_7_6, 6, 2)
> > +    FIELD(GHWPARAMS0, GHWPARAMS0_5_3, 3, 3)
> > +    FIELD(GHWPARAMS0, GHWPARAMS0_2_0, 0, 3) REG32(GHWPARAMS1,
> 0x44)
> > +    FIELD(GHWPARAMS1, GHWPARAMS1_31, 31, 1)
> > +    FIELD(GHWPARAMS1, GHWPARAMS1_30, 30, 1)
> > +    FIELD(GHWPARAMS1, GHWPARAMS1_29, 29, 1)
> > +    FIELD(GHWPARAMS1, GHWPARAMS1_28, 28, 1)
> > +    FIELD(GHWPARAMS1, GHWPARAMS1_27, 27, 1)
> > +    FIELD(GHWPARAMS1, GHWPARAMS1_26, 26, 1)
> > +    FIELD(GHWPARAMS1, GHWPARAMS1_25_24, 24, 2)
> > +    FIELD(GHWPARAMS1, GHWPARAMS1_23, 23, 1)
> > +    FIELD(GHWPARAMS1, GHWPARAMS1_22_21, 21, 2)
> > +    FIELD(GHWPARAMS1, GHWPARAMS1_20_15, 15, 6)
> > +    FIELD(GHWPARAMS1, GHWPARAMS1_14_12, 12, 3)
> > +    FIELD(GHWPARAMS1, GHWPARAMS1_11_9, 9, 3)
> > +    FIELD(GHWPARAMS1, GHWPARAMS1_8_6, 6, 3)
> > +    FIELD(GHWPARAMS1, GHWPARAMS1_5_3, 3, 3)
> > +    FIELD(GHWPARAMS1, GHWPARAMS1_2_0, 0, 3) REG32(GHWPARAMS2,
> 0x48)
> > +REG32(GHWPARAMS3, 0x4c)
> > +    FIELD(GHWPARAMS3, GHWPARAMS3_31, 31, 1)
> > +    FIELD(GHWPARAMS3, GHWPARAMS3_30_23, 23, 8)
> > +    FIELD(GHWPARAMS3, GHWPARAMS3_22_18, 18, 5)
> > +    FIELD(GHWPARAMS3, GHWPARAMS3_17_12, 12, 6)
> > +    FIELD(GHWPARAMS3, GHWPARAMS3_11, 11, 1)
> > +    FIELD(GHWPARAMS3, GHWPARAMS3_10, 10, 1)
> > +    FIELD(GHWPARAMS3, GHWPARAMS3_9_8, 8, 2)
> > +    FIELD(GHWPARAMS3, GHWPARAMS3_7_6, 6, 2)
> > +    FIELD(GHWPARAMS3, GHWPARAMS3_5_4, 4, 2)
> > +    FIELD(GHWPARAMS3, GHWPARAMS3_3_2, 2, 2)
> > +    FIELD(GHWPARAMS3, GHWPARAMS3_1_0, 0, 2) REG32(GHWPARAMS4,
> 0x50)
> > +    FIELD(GHWPARAMS4, GHWPARAMS4_31_28, 28, 4)
> > +    FIELD(GHWPARAMS4, GHWPARAMS4_27_24, 24, 4)
> > +    FIELD(GHWPARAMS4, GHWPARAMS4_23, 23, 1)
> > +    FIELD(GHWPARAMS4, GHWPARAMS4_22, 22, 1)
> > +    FIELD(GHWPARAMS4, GHWPARAMS4_21, 21, 1)
> > +    FIELD(GHWPARAMS4, GHWPARAMS4_20_17, 17, 4)
> > +    FIELD(GHWPARAMS4, GHWPARAMS4_16_13, 13, 4)
> > +    FIELD(GHWPARAMS4, GHWPARAMS4_12, 12, 1)
> > +    FIELD(GHWPARAMS4, GHWPARAMS4_11, 11, 1)
> > +    FIELD(GHWPARAMS4, GHWPARAMS4_10_9, 9, 2)
> > +    FIELD(GHWPARAMS4, GHWPARAMS4_8_7, 7, 2)
> > +    FIELD(GHWPARAMS4, GHWPARAMS4_6, 6, 1)
> > +    FIELD(GHWPARAMS4, GHWPARAMS4_5_0, 0, 6) REG32(GHWPARAMS5,
> 0x54)
> > +    FIELD(GHWPARAMS5, GHWPARAMS5_31_28, 28, 4)
> > +    FIELD(GHWPARAMS5, GHWPARAMS5_27_22, 22, 6)
> > +    FIELD(GHWPARAMS5, GHWPARAMS5_21_16, 16, 6)
> > +    FIELD(GHWPARAMS5, GHWPARAMS5_15_10, 10, 6)
> > +    FIELD(GHWPARAMS5, GHWPARAMS5_9_4, 4, 6)
> > +    FIELD(GHWPARAMS5, GHWPARAMS5_3_0, 0, 4) REG32(GHWPARAMS6,
> 0x58)
> > +    FIELD(GHWPARAMS6, GHWPARAMS6_31_16, 16, 16)
> > +    FIELD(GHWPARAMS6, BUSFLTRSSUPPORT, 15, 1)
> > +    FIELD(GHWPARAMS6, BCSUPPORT, 14, 1)
> > +    FIELD(GHWPARAMS6, OTG_SS_SUPPORT, 13, 1)
> > +    FIELD(GHWPARAMS6, ADPSUPPORT, 12, 1)
> > +    FIELD(GHWPARAMS6, HNPSUPPORT, 11, 1)
> > +    FIELD(GHWPARAMS6, SRPSUPPORT, 10, 1)
> > +    FIELD(GHWPARAMS6, GHWPARAMS6_9_8, 8, 2)
> > +    FIELD(GHWPARAMS6, GHWPARAMS6_7, 7, 1)
> > +    FIELD(GHWPARAMS6, GHWPARAMS6_6, 6, 1)
> > +    FIELD(GHWPARAMS6, GHWPARAMS6_5_0, 0, 6) REG32(GHWPARAMS7,
> 0x5c)
> > +    FIELD(GHWPARAMS7, GHWPARAMS7_31_16, 16, 16)
> > +    FIELD(GHWPARAMS7, GHWPARAMS7_15_0, 0, 16)
> REG32(GDBGFIFOSPACE,
> > +0x60)
> > +    FIELD(GDBGFIFOSPACE, SPACE_AVAILABLE, 16, 16)
> > +    FIELD(GDBGFIFOSPACE, RESERVED_15_9, 9, 7)
> > +    FIELD(GDBGFIFOSPACE, FIFO_QUEUE_SELECT, 0, 9) REG32(GUCTL2, 0x9c)
> > +    FIELD(GUCTL2, RESERVED_31_26, 26, 6)
> > +    FIELD(GUCTL2, EN_HP_PM_TIMER, 19, 7)
> > +    FIELD(GUCTL2, NOLOWPWRDUR, 15, 4)
> > +    FIELD(GUCTL2, RST_ACTBITLATER, 14, 1)
> > +    FIELD(GUCTL2, RESERVED_13, 13, 1)
> > +    FIELD(GUCTL2, DISABLECFC, 11, 1)
> > +REG32(GUSB2PHYCFG, 0x100)
> > +    FIELD(GUSB2PHYCFG, U2_FREECLK_EXISTS, 30, 1)
> > +    FIELD(GUSB2PHYCFG, ULPI_LPM_WITH_OPMODE_CHK, 29, 1)
> > +    FIELD(GUSB2PHYCFG, RESERVED_25, 25, 1)
> > +    FIELD(GUSB2PHYCFG, LSTRD, 22, 3)
> > +    FIELD(GUSB2PHYCFG, LSIPD, 19, 3)
> > +    FIELD(GUSB2PHYCFG, ULPIEXTVBUSINDIACTOR, 18, 1)
> > +    FIELD(GUSB2PHYCFG, ULPIEXTVBUSDRV, 17, 1)
> > +    FIELD(GUSB2PHYCFG, RESERVED_16, 16, 1)
> > +    FIELD(GUSB2PHYCFG, ULPIAUTORES, 15, 1)
> > +    FIELD(GUSB2PHYCFG, RESERVED_14, 14, 1)
> > +    FIELD(GUSB2PHYCFG, USBTRDTIM, 10, 4)
> > +    FIELD(GUSB2PHYCFG, XCVRDLY, 9, 1)
> > +    FIELD(GUSB2PHYCFG, ENBLSLPM, 8, 1)
> > +    FIELD(GUSB2PHYCFG, PHYSEL, 7, 1)
> > +    FIELD(GUSB2PHYCFG, SUSPENDUSB20, 6, 1)
> > +    FIELD(GUSB2PHYCFG, FSINTF, 5, 1)
> > +    FIELD(GUSB2PHYCFG, ULPI_UTMI_SEL, 4, 1)
> > +    FIELD(GUSB2PHYCFG, PHYIF, 3, 1)
> > +    FIELD(GUSB2PHYCFG, TOUTCAL, 0, 3) REG32(GUSB2I2CCTL, 0x140)
> > +REG32(GUSB2PHYACC_ULPI, 0x180)
> > +    FIELD(GUSB2PHYACC_ULPI, RESERVED_31_27, 27, 5)
> > +    FIELD(GUSB2PHYACC_ULPI, DISUIPIDRVR, 26, 1)
> > +    FIELD(GUSB2PHYACC_ULPI, NEWREGREQ, 25, 1)
> > +    FIELD(GUSB2PHYACC_ULPI, VSTSDONE, 24, 1)
> > +    FIELD(GUSB2PHYACC_ULPI, VSTSBSY, 23, 1)
> > +    FIELD(GUSB2PHYACC_ULPI, REGWR, 22, 1)
> > +    FIELD(GUSB2PHYACC_ULPI, REGADDR, 16, 6)
> > +    FIELD(GUSB2PHYACC_ULPI, EXTREGADDR, 8, 8)
> > +    FIELD(GUSB2PHYACC_ULPI, REGDATA, 0, 8) REG32(GTXFIFOSIZ0, 0x200)
> > +    FIELD(GTXFIFOSIZ0, TXFSTADDR_N, 16, 16)
> > +    FIELD(GTXFIFOSIZ0, TXFDEP_N, 0, 16) REG32(GTXFIFOSIZ1, 0x204)
> > +    FIELD(GTXFIFOSIZ1, TXFSTADDR_N, 16, 16)
> > +    FIELD(GTXFIFOSIZ1, TXFDEP_N, 0, 16) REG32(GTXFIFOSIZ2, 0x208)
> > +    FIELD(GTXFIFOSIZ2, TXFSTADDR_N, 16, 16)
> > +    FIELD(GTXFIFOSIZ2, TXFDEP_N, 0, 16) REG32(GTXFIFOSIZ3, 0x20c)
> > +    FIELD(GTXFIFOSIZ3, TXFSTADDR_N, 16, 16)
> > +    FIELD(GTXFIFOSIZ3, TXFDEP_N, 0, 16) REG32(GTXFIFOSIZ4, 0x210)
> > +    FIELD(GTXFIFOSIZ4, TXFSTADDR_N, 16, 16)
> > +    FIELD(GTXFIFOSIZ4, TXFDEP_N, 0, 16) REG32(GTXFIFOSIZ5, 0x214)
> > +    FIELD(GTXFIFOSIZ5, TXFSTADDR_N, 16, 16)
> > +    FIELD(GTXFIFOSIZ5, TXFDEP_N, 0, 16) REG32(GRXFIFOSIZ0, 0x280)
> > +    FIELD(GRXFIFOSIZ0, RXFSTADDR_N, 16, 16)
> > +    FIELD(GRXFIFOSIZ0, RXFDEP_N, 0, 16) REG32(GRXFIFOSIZ1, 0x284)
> > +    FIELD(GRXFIFOSIZ1, RXFSTADDR_N, 16, 16)
> > +    FIELD(GRXFIFOSIZ1, RXFDEP_N, 0, 16) REG32(GRXFIFOSIZ2, 0x288)
> > +    FIELD(GRXFIFOSIZ2, RXFSTADDR_N, 16, 16)
> > +    FIELD(GRXFIFOSIZ2, RXFDEP_N, 0, 16) REG32(GEVNTADRLO_0, 0x300)
> > +REG32(GEVNTADRHI_0, 0x304) REG32(GEVNTSIZ_0, 0x308)
> > +    FIELD(GEVNTSIZ_0, EVNTINTRPTMASK, 31, 1)
> > +    FIELD(GEVNTSIZ_0, RESERVED_30_16, 16, 15)
> > +    FIELD(GEVNTSIZ_0, EVENTSIZ, 0, 16) REG32(GEVNTCOUNT_0, 0x30c)
> > +    FIELD(GEVNTCOUNT_0, EVNT_HANDLER_BUSY, 31, 1)
> > +    FIELD(GEVNTCOUNT_0, RESERVED_30_16, 16, 15)
> > +    FIELD(GEVNTCOUNT_0, EVNTCOUNT, 0, 16) REG32(GEVNTADRLO_1,
> 0x310)
> > +REG32(GEVNTADRHI_1, 0x314) REG32(GEVNTSIZ_1, 0x318)
> > +    FIELD(GEVNTSIZ_1, EVNTINTRPTMASK, 31, 1)
> > +    FIELD(GEVNTSIZ_1, RESERVED_30_16, 16, 15)
> > +    FIELD(GEVNTSIZ_1, EVENTSIZ, 0, 16) REG32(GEVNTCOUNT_1, 0x31c)
> > +    FIELD(GEVNTCOUNT_1, EVNT_HANDLER_BUSY, 31, 1)
> > +    FIELD(GEVNTCOUNT_1, RESERVED_30_16, 16, 15)
> > +    FIELD(GEVNTCOUNT_1, EVNTCOUNT, 0, 16) REG32(GEVNTADRLO_2,
> 0x320)
> > +REG32(GEVNTADRHI_2, 0x324) REG32(GEVNTSIZ_2, 0x328)
> > +    FIELD(GEVNTSIZ_2, EVNTINTRPTMASK, 31, 1)
> > +    FIELD(GEVNTSIZ_2, RESERVED_30_16, 16, 15)
> > +    FIELD(GEVNTSIZ_2, EVENTSIZ, 0, 16) REG32(GEVNTCOUNT_2, 0x32c)
> > +    FIELD(GEVNTCOUNT_2, EVNT_HANDLER_BUSY, 31, 1)
> > +    FIELD(GEVNTCOUNT_2, RESERVED_30_16, 16, 15)
> > +    FIELD(GEVNTCOUNT_2, EVNTCOUNT, 0, 16) REG32(GEVNTADRLO_3,
> 0x330)
> > +REG32(GEVNTADRHI_3, 0x334) REG32(GEVNTSIZ_3, 0x338)
> > +    FIELD(GEVNTSIZ_3, EVNTINTRPTMASK, 31, 1)
> > +    FIELD(GEVNTSIZ_3, RESERVED_30_16, 16, 15)
> > +    FIELD(GEVNTSIZ_3, EVENTSIZ, 0, 16) REG32(GEVNTCOUNT_3, 0x33c)
> > +    FIELD(GEVNTCOUNT_3, EVNT_HANDLER_BUSY, 31, 1)
> > +    FIELD(GEVNTCOUNT_3, RESERVED_30_16, 16, 15)
> > +    FIELD(GEVNTCOUNT_3, EVNTCOUNT, 0, 16) REG32(GHWPARAMS8,
> 0x500)
> > +REG32(GTXFIFOPRIDEV, 0x510)
> > +    FIELD(GTXFIFOPRIDEV, RESERVED_31_N, 6, 26)
> > +    FIELD(GTXFIFOPRIDEV, GTXFIFOPRIDEV, 0, 6) REG32(GTXFIFOPRIHST,
> > +0x518)
> > +    FIELD(GTXFIFOPRIHST, RESERVED_31_16, 3, 29)
> > +    FIELD(GTXFIFOPRIHST, GTXFIFOPRIHST, 0, 3) REG32(GRXFIFOPRIHST,
> > +0x51c)
> > +    FIELD(GRXFIFOPRIHST, RESERVED_31_16, 3, 29)
> > +    FIELD(GRXFIFOPRIHST, GRXFIFOPRIHST, 0, 3) REG32(GDMAHLRATIO,
> > +0x524)
> > +    FIELD(GDMAHLRATIO, RESERVED_31_13, 13, 19)
> > +    FIELD(GDMAHLRATIO, HSTRXFIFO, 8, 5)
> > +    FIELD(GDMAHLRATIO, RESERVED_7_5, 5, 3)
> > +    FIELD(GDMAHLRATIO, HSTTXFIFO, 0, 5) REG32(GFLADJ, 0x530)
> > +    FIELD(GFLADJ, GFLADJ_REFCLK_240MHZDECR_PLS1, 31, 1)
> > +    FIELD(GFLADJ, GFLADJ_REFCLK_240MHZ_DECR, 24, 7)
> > +    FIELD(GFLADJ, GFLADJ_REFCLK_LPM_SEL, 23, 1)
> > +    FIELD(GFLADJ, RESERVED_22, 22, 1)
> > +    FIELD(GFLADJ, GFLADJ_REFCLK_FLADJ, 8, 14)
> > +    FIELD(GFLADJ, GFLADJ_30MHZ_SDBND_SEL, 7, 1)
> > +    FIELD(GFLADJ, GFLADJ_30MHZ, 0, 6)
> > +
> > +static void reset_csr(USBDWC3 * s)
> > +{
> > +    int i =3D 0;
> > +    /*
> > +     * We reset all CSR regs except GCTL, GUCTL, GSTS, GSNPSID, GGPIO,
> GUID,
> > +     * GUSB2PHYCFGn registers and GUSB3PIPECTLn registers. We will ski=
p
> PHY
> > +     * register as we don't implement them.
> > +     */
> > +    for (i =3D 0; i < R_GCTL; i++) {
> > +        register_reset(&s->regs_info[i]);
> > +    }
> > +
> > +    for (i =3D R_GCTL; i < R_GBUSERRADDRLO; i++) {
> > +        if (i =3D=3D R_GUCTL1 || i =3D=3D R_GPMSTS) {
> > +            register_reset(&s->regs_info[i]);
> > +        } else {
> > +            continue;
> > +        }
> > +    }
> > +
> > +    for (i =3D R_GBUSERRADDRLO; i < USB_DWC3_R_MAX; i++) {
> > +        register_reset(&s->regs_info[i]);
> > +    }
>=20
> Can we instead iterate through them all and have a list with the ones tha=
t wont
> be reset? It'll be easier to understand the code and match it with the re=
gs that
> shouldn't reset.
> e.g:
>=20
> for (i =3D 0; i < USB_DWC3_R_MAX; i++) {
>     switch (i) {
>     case R_GCTL:
>     case XXX:
>         /* Should not reset.  */
>         break;
>     default:
>         register_reset(&s->regs_info[i]);
>         break;
>     }
> }
>=20
> > +
> > +    xhci_sysbus_reset(DEVICE(&s->sysbus_xhci));
> > +}
> > +
> > +static void usb_dwc3_gctl_postw(RegisterInfo *reg, uint64_t val64) {
> > +    USBDWC3 *s =3D USB_DWC3(reg->opaque);
> > +
> > +    if (ARRAY_FIELD_EX32(s->regs, GCTL, CORESOFTRESET)) {
> > +        reset_csr(s);
> > +    }
> > +}
> > +
> > +static void usb_dwc3_guid_postw(RegisterInfo *reg, uint64_t val64) {
> > +    USBDWC3 *s =3D USB_DWC3(reg->opaque);
> > +
> > +    s->regs[R_GUID] =3D s->cfg.dwc_usb3_user; }
>=20
> This looks strange. Is this register really writeable on real HW?
> Looks lite a read-only register that should get it's value from the prope=
rty...
[Sai Pavan Boddu]  this seems to a r/w register itself.

>=20
>=20
> > +
> > +static void usb_dwc3_unimpl_postw(RegisterInfo *reg, uint64_t val64)
> > +{
> > +    qemu_log_mask(LOG_UNIMP, "%s not supported\n",
> > +reg->access->name); }
> > +
> > +static uint64_t usb_dwc3_unimpl_postr(RegisterInfo *reg, uint64_t
> > +val64) {
> > +    qemu_log_mask(LOG_UNIMP, "%s not supported\n", reg->access-
> >name);
> > +    return val64;
> > +}
>=20
> We should probably use the regapi .unimp instead of these functions.
>=20
> > +
> > +static const RegisterAccessInfo usb_dwc3_regs_info[] =3D {
> > +    {   .name =3D "GSBUSCFG0",  .addr =3D A_GSBUSCFG0,
> > +        .ro =3D 0xf300,
> > +        .post_read =3D usb_dwc3_unimpl_postr,
> > +        .post_write =3D usb_dwc3_unimpl_postw,
> > +    },{ .name =3D "GSBUSCFG1",  .addr =3D A_GSBUSCFG1,
> > +        .reset =3D 0x300,
> > +        .ro =3D 0xffffe0ff,
> > +        .post_read =3D usb_dwc3_unimpl_postr,
> > +        .post_write =3D usb_dwc3_unimpl_postw,
> > +    },{ .name =3D "GTXTHRCFG",  .addr =3D A_GTXTHRCFG,
> > +        .ro =3D 0xd000ffff,
> > +        .post_read =3D usb_dwc3_unimpl_postr,
> > +        .post_write =3D usb_dwc3_unimpl_postw,
> > +    },{ .name =3D "GRXTHRCFG",  .addr =3D A_GRXTHRCFG,
> > +        .ro =3D 0xd007e000,
> > +        .post_read =3D usb_dwc3_unimpl_postr,
> > +        .post_write =3D usb_dwc3_unimpl_postw,
> > +    },{ .name =3D "GCTL",  .addr =3D A_GCTL,
> > +        .reset =3D 0x30c13004, .post_write =3D usb_dwc3_gctl_postw,
> > +    },{ .name =3D "GPMSTS",  .addr =3D A_GPMSTS,
> > +        .ro =3D 0xfffffff,
> > +        .post_read =3D usb_dwc3_unimpl_postr,
> > +        .post_write =3D usb_dwc3_unimpl_postw,
> > +    },{ .name =3D "GSTS",  .addr =3D A_GSTS,
> > +        .reset =3D 0x7e800000,
> > +        .ro =3D 0xffffffcf,
> > +        .w1c =3D 0x30,
> > +        .post_read =3D usb_dwc3_unimpl_postr,
> > +        .post_write =3D usb_dwc3_unimpl_postw,
> > +    },{ .name =3D "GUCTL1",  .addr =3D A_GUCTL1,
> > +        .reset =3D 0x198a,
> > +        .ro =3D 0x7800,
> > +        .post_read =3D usb_dwc3_unimpl_postr,
> > +        .post_write =3D usb_dwc3_unimpl_postw,
> > +    },{ .name =3D "GSNPSID",  .addr =3D A_GSNPSID,
> > +        .reset =3D 0x5533330a,
> > +        .ro =3D 0xffffffff,
> > +    },{ .name =3D "GGPIO",  .addr =3D A_GGPIO,
> > +        .ro =3D 0xffff,
> > +        .post_read =3D usb_dwc3_unimpl_postr,
> > +        .post_write =3D usb_dwc3_unimpl_postw,
> > +    },{ .name =3D "GUID",  .addr =3D A_GUID,
> > +        .reset =3D 0x12345678, .post_write =3D usb_dwc3_guid_postw,
> > +    },{ .name =3D "GUCTL",  .addr =3D A_GUCTL,
> > +        .reset =3D 0x0c808010,
> > +        .ro =3D 0x1c8000,
> > +        .post_read =3D usb_dwc3_unimpl_postr,
> > +        .post_write =3D usb_dwc3_unimpl_postw,
> > +    },{ .name =3D "GBUSERRADDRLO",  .addr =3D A_GBUSERRADDRLO,
> > +        .ro =3D 0xffffffff,
> > +        .post_read =3D usb_dwc3_unimpl_postr,
> > +    },{ .name =3D "GBUSERRADDRHI",  .addr =3D A_GBUSERRADDRHI,
> > +        .ro =3D 0xffffffff,
> > +        .post_read =3D usb_dwc3_unimpl_postr,
> > +    },{ .name =3D "GHWPARAMS0",  .addr =3D A_GHWPARAMS0,
> > +        .ro =3D 0xffffffff,
> > +    },{ .name =3D "GHWPARAMS1",  .addr =3D A_GHWPARAMS1,
> > +        .ro =3D 0xffffffff,
> > +    },{ .name =3D "GHWPARAMS2",  .addr =3D A_GHWPARAMS2,
> > +        .ro =3D 0xffffffff,
> > +    },{ .name =3D "GHWPARAMS3",  .addr =3D A_GHWPARAMS3,
> > +        .ro =3D 0xffffffff,
> > +    },{ .name =3D "GHWPARAMS4",  .addr =3D A_GHWPARAMS4,
> > +        .ro =3D 0xffffffff,
> > +    },{ .name =3D "GHWPARAMS5",  .addr =3D A_GHWPARAMS5,
> > +        .ro =3D 0xffffffff,
> > +    },{ .name =3D "GHWPARAMS6",  .addr =3D A_GHWPARAMS6,
> > +        .ro =3D 0xffffffff,
> > +    },{ .name =3D "GHWPARAMS7",  .addr =3D A_GHWPARAMS7,
> > +        .ro =3D 0xffffffff,
> > +    },{ .name =3D "GDBGFIFOSPACE",  .addr =3D A_GDBGFIFOSPACE,
> > +        .reset =3D 0xa0000,
> > +        .ro =3D 0xfffffe00,
> > +        .post_read =3D usb_dwc3_unimpl_postr,
> > +        .post_write =3D usb_dwc3_unimpl_postw,
> > +    },{ .name =3D "GUCTL2",  .addr =3D A_GUCTL2,
> > +        .reset =3D 0x40d,
> > +        .ro =3D 0x2000,
> > +        .post_read =3D usb_dwc3_unimpl_postr,
> > +        .post_write =3D usb_dwc3_unimpl_postw,
> > +    },{ .name =3D "GUSB2PHYCFG",  .addr =3D A_GUSB2PHYCFG,
> > +        .reset =3D 0x40102410,
> > +        .ro =3D 0x1e014030,
> > +        .post_read =3D usb_dwc3_unimpl_postr,
> > +        .post_write =3D usb_dwc3_unimpl_postw,
> > +    },{ .name =3D "GUSB2I2CCTL",  .addr =3D A_GUSB2I2CCTL,
> > +        .ro =3D 0xffffffff,
> > +        .post_read =3D usb_dwc3_unimpl_postr,
> > +        .post_write =3D usb_dwc3_unimpl_postw,
> > +    },{ .name =3D "GUSB2PHYACC_ULPI",  .addr =3D A_GUSB2PHYACC_ULPI,
> > +        .ro =3D 0xfd000000,
> > +        .post_read =3D usb_dwc3_unimpl_postr,
> > +        .post_write =3D usb_dwc3_unimpl_postw,
> > +    },{ .name =3D "GTXFIFOSIZ0",  .addr =3D A_GTXFIFOSIZ0,
> > +        .reset =3D 0x2c7000a,
> > +        .post_read =3D usb_dwc3_unimpl_postr,
> > +        .post_write =3D usb_dwc3_unimpl_postw,
> > +    },{ .name =3D "GTXFIFOSIZ1",  .addr =3D A_GTXFIFOSIZ1,
> > +        .reset =3D 0x2d10103,
> > +        .post_read =3D usb_dwc3_unimpl_postr,
> > +        .post_write =3D usb_dwc3_unimpl_postw,
> > +    },{ .name =3D "GTXFIFOSIZ2",  .addr =3D A_GTXFIFOSIZ2,
> > +        .reset =3D 0x3d40103,
> > +        .post_read =3D usb_dwc3_unimpl_postr,
> > +        .post_write =3D usb_dwc3_unimpl_postw,
> > +    },{ .name =3D "GTXFIFOSIZ3",  .addr =3D A_GTXFIFOSIZ3,
> > +        .reset =3D 0x4d70083,
> > +        .post_read =3D usb_dwc3_unimpl_postr,
> > +        .post_write =3D usb_dwc3_unimpl_postw,
> > +    },{ .name =3D "GTXFIFOSIZ4",  .addr =3D A_GTXFIFOSIZ4,
> > +        .reset =3D 0x55a0083,
> > +        .post_read =3D usb_dwc3_unimpl_postr,
> > +        .post_write =3D usb_dwc3_unimpl_postw,
> > +    },{ .name =3D "GTXFIFOSIZ5",  .addr =3D A_GTXFIFOSIZ5,
> > +        .reset =3D 0x5dd0083,
> > +        .post_read =3D usb_dwc3_unimpl_postr,
> > +        .post_write =3D usb_dwc3_unimpl_postw,
> > +    },{ .name =3D "GRXFIFOSIZ0",  .addr =3D A_GRXFIFOSIZ0,
> > +        .reset =3D 0x1c20105,
> > +        .post_read =3D usb_dwc3_unimpl_postr,
> > +        .post_write =3D usb_dwc3_unimpl_postw,
> > +    },{ .name =3D "GRXFIFOSIZ1",  .addr =3D A_GRXFIFOSIZ1,
> > +        .reset =3D 0x2c70000,
> > +        .post_read =3D usb_dwc3_unimpl_postr,
> > +        .post_write =3D usb_dwc3_unimpl_postw,
> > +    },{ .name =3D "GRXFIFOSIZ2",  .addr =3D A_GRXFIFOSIZ2,
> > +        .reset =3D 0x2c70000,
> > +        .post_read =3D usb_dwc3_unimpl_postr,
> > +        .post_write =3D usb_dwc3_unimpl_postw,
> > +    },{ .name =3D "GEVNTADRLO_0",  .addr =3D A_GEVNTADRLO_0,
> > +        .post_read =3D usb_dwc3_unimpl_postr,
> > +        .post_write =3D usb_dwc3_unimpl_postw,
> > +    },{ .name =3D "GEVNTADRHI_0",  .addr =3D A_GEVNTADRHI_0,
> > +        .post_read =3D usb_dwc3_unimpl_postr,
> > +        .post_write =3D usb_dwc3_unimpl_postw,
> > +    },{ .name =3D "GEVNTSIZ_0",  .addr =3D A_GEVNTSIZ_0,
> > +        .ro =3D 0x7fff0000,
> > +        .post_read =3D usb_dwc3_unimpl_postr,
> > +        .post_write =3D usb_dwc3_unimpl_postw,
> > +    },{ .name =3D "GEVNTCOUNT_0",  .addr =3D A_GEVNTCOUNT_0,
> > +        .ro =3D 0x7fff0000,
> > +        .post_read =3D usb_dwc3_unimpl_postr,
> > +        .post_write =3D usb_dwc3_unimpl_postw,
> > +    },{ .name =3D "GEVNTADRLO_1",  .addr =3D A_GEVNTADRLO_1,
> > +        .post_read =3D usb_dwc3_unimpl_postr,
> > +        .post_write =3D usb_dwc3_unimpl_postw,
> > +    },{ .name =3D "GEVNTADRHI_1",  .addr =3D A_GEVNTADRHI_1,
> > +        .post_read =3D usb_dwc3_unimpl_postr,
> > +        .post_write =3D usb_dwc3_unimpl_postw,
> > +    },{ .name =3D "GEVNTSIZ_1",  .addr =3D A_GEVNTSIZ_1,
> > +        .ro =3D 0x7fff0000,
> > +        .post_read =3D usb_dwc3_unimpl_postr,
> > +        .post_write =3D usb_dwc3_unimpl_postw,
> > +    },{ .name =3D "GEVNTCOUNT_1",  .addr =3D A_GEVNTCOUNT_1,
> > +        .ro =3D 0x7fff0000,
> > +        .post_read =3D usb_dwc3_unimpl_postr,
> > +        .post_write =3D usb_dwc3_unimpl_postw,
> > +    },{ .name =3D "GEVNTADRLO_2",  .addr =3D A_GEVNTADRLO_2,
> > +        .post_read =3D usb_dwc3_unimpl_postr,
> > +        .post_write =3D usb_dwc3_unimpl_postw,
> > +    },{ .name =3D "GEVNTADRHI_2",  .addr =3D A_GEVNTADRHI_2,
> > +        .post_read =3D usb_dwc3_unimpl_postr,
> > +        .post_write =3D usb_dwc3_unimpl_postw,
> > +    },{ .name =3D "GEVNTSIZ_2",  .addr =3D A_GEVNTSIZ_2,
> > +        .ro =3D 0x7fff0000,
> > +        .post_read =3D usb_dwc3_unimpl_postr,
> > +        .post_write =3D usb_dwc3_unimpl_postw,
> > +    },{ .name =3D "GEVNTCOUNT_2",  .addr =3D A_GEVNTCOUNT_2,
> > +        .ro =3D 0x7fff0000,
> > +        .post_read =3D usb_dwc3_unimpl_postr,
> > +        .post_write =3D usb_dwc3_unimpl_postw,
> > +    },{ .name =3D "GEVNTADRLO_3",  .addr =3D A_GEVNTADRLO_3,
> > +        .post_read =3D usb_dwc3_unimpl_postr,
> > +        .post_write =3D usb_dwc3_unimpl_postw,
> > +    },{ .name =3D "GEVNTADRHI_3",  .addr =3D A_GEVNTADRHI_3,
> > +        .post_read =3D usb_dwc3_unimpl_postr,
> > +        .post_write =3D usb_dwc3_unimpl_postw,
> > +    },{ .name =3D "GEVNTSIZ_3",  .addr =3D A_GEVNTSIZ_3,
> > +        .ro =3D 0x7fff0000,
> > +        .post_read =3D usb_dwc3_unimpl_postr,
> > +        .post_write =3D usb_dwc3_unimpl_postw,
> > +    },{ .name =3D "GEVNTCOUNT_3",  .addr =3D A_GEVNTCOUNT_3,
> > +        .ro =3D 0x7fff0000,
> > +        .post_read =3D usb_dwc3_unimpl_postr,
> > +        .post_write =3D usb_dwc3_unimpl_postw,
> > +    },{ .name =3D "GHWPARAMS8",  .addr =3D A_GHWPARAMS8,
> > +        .ro =3D 0xffffffff,
> > +        .post_read =3D usb_dwc3_unimpl_postr,
> > +        .post_write =3D usb_dwc3_unimpl_postw,
> > +    },{ .name =3D "GTXFIFOPRIDEV",  .addr =3D A_GTXFIFOPRIDEV,
> > +        .ro =3D 0xffffffc0,
> > +        .post_read =3D usb_dwc3_unimpl_postr,
> > +        .post_write =3D usb_dwc3_unimpl_postw,
> > +    },{ .name =3D "GTXFIFOPRIHST",  .addr =3D A_GTXFIFOPRIHST,
> > +        .ro =3D 0xfffffff8,
> > +        .post_read =3D usb_dwc3_unimpl_postr,
> > +        .post_write =3D usb_dwc3_unimpl_postw,
> > +    },{ .name =3D "GRXFIFOPRIHST",  .addr =3D A_GRXFIFOPRIHST,
> > +        .ro =3D 0xfffffff8,
> > +        .post_read =3D usb_dwc3_unimpl_postr,
> > +        .post_write =3D usb_dwc3_unimpl_postw,
> > +    },{ .name =3D "GDMAHLRATIO",  .addr =3D A_GDMAHLRATIO,
> > +        .ro =3D 0xffffe0e0,
> > +        .post_read =3D usb_dwc3_unimpl_postr,
> > +        .post_write =3D usb_dwc3_unimpl_postw,
> > +    },{ .name =3D "GFLADJ",  .addr =3D A_GFLADJ,
> > +        .reset =3D 0xc83f020,
> > +        .rsvd =3D 0x40,
> > +        .ro =3D 0x400040,
> > +        .post_read =3D usb_dwc3_unimpl_postr,
> > +        .post_write =3D usb_dwc3_unimpl_postw,
> > +    }
> > +};
> > +
> > +static void usb_dwc3_reset(DeviceState *dev) {
> > +    USBDWC3 *s =3D USB_DWC3(dev);
> > +    unsigned int i;
> > +
> > +    for (i =3D 0; i < ARRAY_SIZE(s->regs_info); ++i) {
> > +        register_reset(&s->regs_info[i]);
> > +    }
> > +
> > +    /*
> > +     * Device Configuration
> > +     */
> > +    s->regs[R_GHWPARAMS0] =3D 0x40204048 | s->cfg.mode;
> > +    s->regs[R_GHWPARAMS1] =3D 0x222493b;
> > +    s->regs[R_GHWPARAMS2] =3D 0x12345678;
> > +    s->regs[R_GHWPARAMS3] =3D 0x618c088;
> > +    s->regs[R_GHWPARAMS4] =3D 0x47822004;
> > +    s->regs[R_GHWPARAMS5] =3D 0x4202088;
> > +    s->regs[R_GHWPARAMS6] =3D 0x7850c20;
> > +    s->regs[R_GHWPARAMS7] =3D 0x0;
> > +    s->regs[R_GHWPARAMS8] =3D 0x478;
>=20
> Shouldn't these be setup in realize()?
[Sai Pavan Boddu] Yes, in that case these also needs to be skipped from res=
et.
I would send V12 addressing all comments above.

Regard,
Sai Pavan
>=20
> > +
> > +    xhci_sysbus_reset(DEVICE(&s->sysbus_xhci));
> > +}
> > +
> > +static const MemoryRegionOps usb_dwc3_ops =3D {
> > +    .read =3D register_read_memory,
> > +    .write =3D register_write_memory,
> > +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> > +    .valid =3D {
> > +        .min_access_size =3D 4,
> > +        .max_access_size =3D 4,
> > +    },
> > +};
> > +
> > +static void usb_dwc3_realize(DeviceState *dev, Error **errp) {
> > +    USBDWC3 *s =3D USB_DWC3(dev);
> > +    Error *err =3D NULL;
> > +
> > +    sysbus_realize(SYS_BUS_DEVICE(&s->sysbus_xhci), &err);
> > +    if (err) {
> > +        error_propagate(errp, err);
> > +        return;
> > +    }
> > +}
> > +
> > +static void usb_dwc3_init(Object *obj) {
> > +    USBDWC3 *s =3D USB_DWC3(obj);
> > +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> > +    RegisterInfoArray *reg_array;
> > +
> > +    memory_region_init(&s->iomem, obj, TYPE_USB_DWC3,
> USB_DWC3_R_MAX * 4);
> > +    reg_array =3D
> > +        register_init_block32(DEVICE(obj), usb_dwc3_regs_info,
> > +                              ARRAY_SIZE(usb_dwc3_regs_info),
> > +                              s->regs_info, s->regs,
> > +                              &usb_dwc3_ops,
> > +                              USB_DWC3_ERR_DEBUG,
> > +                              USB_DWC3_R_MAX * 4);
> > +    memory_region_add_subregion(&s->iomem,
> > +                                0x0,
> > +                                &reg_array->mem);
> > +    sysbus_init_mmio(sbd, &s->iomem);
> > +    object_initialize_child(obj, "dwc3-xhci", &s->sysbus_xhci,
> > +                            TYPE_XHCI_SYSBUS);
> > +    qdev_alias_all_properties(DEVICE(&s->sysbus_xhci), obj);
> > +
> > +    s->cfg.mode =3D HOST_MODE;
> > +}
> > +
> > +static Property usb_dwc3_properties[] =3D {
> > +    DEFINE_PROP_UINT32("DWC_USB3_USERID", USBDWC3,
> cfg.dwc_usb3_user,
> > +                       0x12345678),
> > +    DEFINE_PROP_END_OF_LIST(),
> > +};
> > +
> > +static void usb_dwc3_class_init(ObjectClass *klass, void *data) {
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +
> > +    dc->reset =3D usb_dwc3_reset;
> > +    dc->realize =3D usb_dwc3_realize;
> > +    device_class_set_props(dc, usb_dwc3_properties); }
> > +
> > +static const TypeInfo usb_dwc3_info =3D {
> > +    .name          =3D TYPE_USB_DWC3,
> > +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> > +    .instance_size =3D sizeof(USBDWC3),
> > +    .class_init    =3D usb_dwc3_class_init,
> > +    .instance_init =3D usb_dwc3_init,
> > +};
> > +
> > +static void usb_dwc3_register_types(void) {
> > +    type_register_static(&usb_dwc3_info);
> > +}
> > +
> > +type_init(usb_dwc3_register_types)
> > diff --git a/hw/usb/meson.build b/hw/usb/meson.build index
> > 934e4fa..962fbc0 100644
> > --- a/hw/usb/meson.build
> > +++ b/hw/usb/meson.build
> > @@ -26,6 +26,7 @@ softmmu_ss.add(when: 'CONFIG_USB_XHCI_SYSBUS',
> > if_true: files('hcd-xhci-sysbus.c
> >  softmmu_ss.add(when: 'CONFIG_USB_XHCI_NEC', if_true:
> > files('hcd-xhci-nec.c'))
> >  softmmu_ss.add(when: 'CONFIG_USB_MUSB', if_true: files('hcd-musb.c'))
> >  softmmu_ss.add(when: 'CONFIG_USB_DWC2', if_true: files('hcd-dwc2.c'))
> > +softmmu_ss.add(when: 'CONFIG_USB_DWC3', if_true: files('hcd-dwc3.c'))
> >
> >  softmmu_ss.add(when: 'CONFIG_TUSB6010', if_true: files('tusb6010.c'))
> >  softmmu_ss.add(when: 'CONFIG_IMX', if_true: files('chipidea.c')) diff
> > --git a/include/hw/usb/hcd-dwc3.h b/include/hw/usb/hcd-dwc3.h new file
> > mode 100644 index 0000000..586968d
> > --- /dev/null
> > +++ b/include/hw/usb/hcd-dwc3.h
> > @@ -0,0 +1,55 @@
> > +/*
> > + * QEMU model of the USB DWC3 host controller emulation.
> > + *
> > + * Copyright (c) 2020 Xilinx Inc.
> > + *
> > + * Written by Vikram Garhwal<fnu.vikram@xilinx.com>
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
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> > +EXPRESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> > +MERCHANTABILITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO
> EVENT
> > +SHALL
> > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
> DAMAGES
> > +OR OTHER
> > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> > +ARISING FROM,
> > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
> > +DEALINGS IN
> > + * THE SOFTWARE.
> > + */
> > +#ifndef HCD_DWC3_H
> > +#define HCD_DWC3_H
> > +
> > +#include "hw/usb/hcd-xhci.h"
> > +#include "hw/usb/hcd-xhci-sysbus.h"
> > +
> > +#define TYPE_USB_DWC3 "usb_dwc3"
> > +
> > +#define USB_DWC3(obj) \
> > +     OBJECT_CHECK(USBDWC3, (obj), TYPE_USB_DWC3)
> > +
> > +#define USB_DWC3_R_MAX ((0x530 / 4) + 1)
> > +
> > +typedef struct USBDWC3 {
> > +    SysBusDevice parent_obj;
> > +    MemoryRegion iomem;
> > +    MemoryRegion fifos;
> > +    XHCISysbusState sysbus_xhci;
> > +
> > +    uint32_t regs[USB_DWC3_R_MAX];
> > +    RegisterInfo regs_info[USB_DWC3_R_MAX];
> > +
> > +    struct {
> > +        uint8_t     mode;
> > +        uint32_t    dwc_usb3_user;
> > +    } cfg;
> > +
> > +} USBDWC3;
> > +
> > +#endif
> > --
> > 2.7.4
> >

