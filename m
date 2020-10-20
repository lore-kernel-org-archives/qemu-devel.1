Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EE4C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 13:58:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3085F22200
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 13:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="k0+6XsJN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3085F22200
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUs9k-0001Ld-5S
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 09:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kUs8d-0000Vg-IW
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 09:57:19 -0400
Received: from mail-dm6nam11on2042.outbound.protection.outlook.com
 ([40.107.223.42]:30941 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kUs8Y-0004ch-O3
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 09:57:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VM7oMCgwPMo9QcUFi1GWLqTtRW0P/4UwrDd4PJBgheyMbaQdZ3rh8R25jpGgrRTeQ9EpotoDoh2c0CtqgvJWkwAy8diwyYFfZ0c5r9QZ1C6u9+sJDoUJLjtITks+RTBhj7cYfme7VhfX48rzPPjt0EMznaHUdRRXHqxgaOrIl913oUwUUVB7Dm3YHFMxW5nWhhv9QF2zebvtZAkf29S/HVxEYRc/eU7bN45luYix/Z1b5+XPDHxK9crSNMU3tZqAlCisZ56PQGbTF+3rudHtkIuv+Ai4f8dkP1Se9sNAM3sajsEJIxhsQnAG99ycF8golDXoRQ2QS2TPC4tPEvFC6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zd84885hgLcjJDWsm4tVMRMOqpUV4CHli4CRNKPgGXE=;
 b=RqtUtVn80ooxXo1Iya3Bze6Y3FZL5OPKYo+2DQE/YkC9AyrHvQfXvGcejf05kRVzpd5z2AliJenYwOkWPGMHMfhaIclce6stsrkwvYjU7Nrl+V131Q6Ffwobustz3gOs4lnom6hv7p51XS15x1IQq3cE0022MjfEiI3Q3/xUaTyGdxr4YdBXjRo+4t3KY9Ds3W8C/DSv0iO9gCV/feZngf0ZCcWiIepvx0pOfCgjc6Z6L6/sKv9uP21uBc24h6CkMSCGGKRJ1p1/KJxv31BOwFDtEnau/BM0WPWzsVVb03fQe9eX2PrXPN84hc6OoHk3nP2W5NaAKM42qluUsTFrpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zd84885hgLcjJDWsm4tVMRMOqpUV4CHli4CRNKPgGXE=;
 b=k0+6XsJNL0Ib60MW0J956lWpMoFKAmiNGrreCTwDwfI9Qj8dtBZEV0k1cQiTfAgY+zAy8u7BoUCB326SEHnRoj35rzoKhdfly6bGrcrBsiWKsr4tgTRhfnRBBpwLR//30octvVyokSbEb4k85ypNF+w0TJOObV6Cjzo4ZnNN6CM=
Received: from BY5PR02MB6772.namprd02.prod.outlook.com (2603:10b6:a03:206::11)
 by BY5PR02MB7041.namprd02.prod.outlook.com (2603:10b6:a03:237::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.24; Tue, 20 Oct
 2020 13:42:11 +0000
Received: from BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::75ed:4271:263b:fd15]) by BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::75ed:4271:263b:fd15%3]) with mapi id 15.20.3499.018; Tue, 20 Oct 2020
 13:42:11 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: Gerd Hoffmann <kraxel@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH v3 02/10] usb/xhci: add include/hw/usb/xhci.h header file
Thread-Topic: [PATCH v3 02/10] usb/xhci: add include/hw/usb/xhci.h header file
Thread-Index: AQHWprV5cpj5ZyoAKU6tfgCxOSO3X6mgf9Uw
Date: Tue, 20 Oct 2020 13:42:11 +0000
Message-ID: <BY5PR02MB6772B8E614B51E297D68AA70CA1F0@BY5PR02MB6772.namprd02.prod.outlook.com>
References: <20201020074844.5304-1-kraxel@redhat.com>
 <20201020074844.5304-3-kraxel@redhat.com>
In-Reply-To: <20201020074844.5304-3-kraxel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b2e119aa-66e2-43c7-da4e-08d874fdf271
x-ms-traffictypediagnostic: BY5PR02MB7041:
x-microsoft-antispam-prvs: <BY5PR02MB704169ECCE9BBD75B1F064D8CA1F0@BY5PR02MB7041.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2PiSNKowsLExMZuUm/IoLF3VEZt/FxPuwj44/irs5u/S7ixoN1nQ25HFdxZpsckDxsTocuqp92oCFVIyUMK/xkEvGcWUtBifbOKkPVvqgGqmgD8Io/bakhEuopPeGFKafFovleQ9/21nWNCLhS19ZEKUUpdmRkFqqSjG9w16qrg04Oo8P6w0JSALzJqYbxUDJdDrTIEVHftJk0ZrN7Y4Ndqzk68sLIPv5OeLBSpv/JmGcrva5IVOuYq+OIzSFV9MxQugTgJO6BOK/mPZN0Hswx4lF3tAqkB0aibEg4eXp/HfkomPwH3z+Bum04LmohBbdJ0kXG50K66SsM0PUyxfCw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6772.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(376002)(136003)(366004)(39860400002)(346002)(396003)(66446008)(66476007)(86362001)(71200400001)(9686003)(55016002)(76116006)(52536014)(64756008)(5660300002)(316002)(66946007)(83380400001)(66556008)(26005)(8676002)(186003)(7696005)(6506007)(4326008)(54906003)(478600001)(53546011)(2906002)(110136005)(7416002)(33656002)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 6x0DRlk5RsOA0u9t/Soaqh9nBTrVpcb72fhFZwRcaO85+GH7Xtilv7zPggXGwGjVzr+hPmIQqR9Y2l5HYi8ylxxYAHOX2/SCVRuE25uxsvUMF4A15FOQavhDoUAtY2nM/BEwf8GF7CTmIIMw3wULUrRgQWQF+GOkMy/v9GoTn+8GGsZre3NXaTG/1adAQ6MxSAlwBf7GwIHO92lcHQuWIiiHSEP86/7YmxQFsT8L/7inSBA05pB+KHNHaAdBvebYkvb2FjbhW5rL36a5EVTcJ5o7UDdrjw8FeZ0DVvM2aDrePgqP3AHEuy1vI/xNctSj5vVp+GMMeKF37+0jjLeM05WdXB51tJeL1HDZV/yN0HSndEp9Enh1EyChgm2EFCvZPn6m902AvcHWGLag/aHQP67jIT9kbnB+9VIHgWJRnjWkuhsYLynlnS/y9IQitZkrZ40OaV43rawABDmtGo8UCEB4AIOOEgthRJp2l5rFJ/035We1+V9RSjIknXwjmmWgg6VJRzTYgCkdhEkFrX5b6Rp19aauDeosM6DWfAgQIHpyyaUJBl1zLv4wH/7i8gOOi53wjGP/ZxEF+yGCqLh8g7IWuoOhXCIR/lSno/QPe0f/Na9a5nJIOVRfTJvcIS/gBHd7tgnNO5Azookma+kDAg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6772.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2e119aa-66e2-43c7-da4e-08d874fdf271
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2020 13:42:11.5035 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: naCI6lHmZeuKihlI4TCBwgD6qiwx6fomMuRHCQYnX14tVizr8fVkie9xux5EgxrbQEkVUYnW+QNkrevia9a0tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB7041
Received-SPF: pass client-ip=40.107.223.42; envelope-from=saipava@xilinx.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 09:57:13
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,
> -----Original Message-----
> From: Gerd Hoffmann <kraxel@redhat.com>
> Sent: Tuesday, October 20, 2020 1:19 PM
> To: qemu-devel@nongnu.org
> Cc: Sergio Lopez <slp@redhat.com>; Sai Pavan Boddu <saipava@xilinx.com>;
> Igor Mammedov <imammedo@redhat.com>; Michael S. Tsirkin
> <mst@redhat.com>; Marcel Apfelbaum <marcel.apfelbaum@gmail.com>;
> Paolo Bonzini <pbonzini@redhat.com>; Thomas Huth <thuth@redhat.com>;
> Richard Henderson <rth@twiddle.net>; Gerd Hoffmann <kraxel@redhat.com>;
> Eduardo Habkost <ehabkost@redhat.com>; Laurent Vivier
> <lvivier@redhat.com>
> Subject: [PATCH v3 02/10] usb/xhci: add include/hw/usb/xhci.h header file
>=20
> Move a bunch of defines which might be needed outside core xhci code to t=
hat
> place.  Add XHCI_ prefixes to avoid name clashes.
> No functional change.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
[Sai Pavan Boddu] Looks good.

Reviewed-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>

Regards,
Sai Pavan


> ---
>  hw/usb/hcd-xhci-sysbus.h |  1 -
>  hw/usb/hcd-xhci.h        | 22 ++++++----------------
>  include/hw/usb/xhci.h    | 19 +++++++++++++++++++
>  hw/usb/hcd-xhci-nec.c    |  4 ++--
>  hw/usb/hcd-xhci-pci.c    |  4 ++--
>  hw/usb/hcd-xhci-sysbus.c |  4 ++--
>  hw/usb/hcd-xhci.c        | 34 ++++++++++++++++------------------
>  7 files changed, 47 insertions(+), 41 deletions(-)  create mode 100644
> include/hw/usb/xhci.h
>=20
> diff --git a/hw/usb/hcd-xhci-sysbus.h b/hw/usb/hcd-xhci-sysbus.h index
> a308753ceb9b..fdfcbbee3bf4 100644
> --- a/hw/usb/hcd-xhci-sysbus.h
> +++ b/hw/usb/hcd-xhci-sysbus.h
> @@ -15,7 +15,6 @@
>  #include "hcd-xhci.h"
>  #include "hw/sysbus.h"
>=20
> -#define TYPE_XHCI_SYSBUS "sysbus-xhci"
>  #define XHCI_SYSBUS(obj) \
>      OBJECT_CHECK(XHCISysbusState, (obj), TYPE_XHCI_SYSBUS)
>=20
> diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h index
> f859a17e73ee..ccf50ae28bed 100644
> --- a/hw/usb/hcd-xhci.h
> +++ b/hw/usb/hcd-xhci.h
> @@ -24,23 +24,13 @@
>  #include "qom/object.h"
>=20
>  #include "hw/usb.h"
> +#include "hw/usb/xhci.h"
>  #include "sysemu/dma.h"
>=20
> -#define TYPE_XHCI "base-xhci"
> -#define TYPE_NEC_XHCI "nec-usb-xhci"
> -#define TYPE_QEMU_XHCI "qemu-xhci"
> -
>  OBJECT_DECLARE_SIMPLE_TYPE(XHCIState, XHCI)
>=20
> -#define MAXPORTS_2 15
> -#define MAXPORTS_3 15
> -
> -#define MAXPORTS (MAXPORTS_2 + MAXPORTS_3) -#define MAXSLOTS 64 -
> #define MAXINTRS 16
> -
>  /* Very pessimistic, let's hope it's enough for all cases */ -#define EV=
_QUEUE
> (((3 * 24) + 16) * MAXSLOTS)
> +#define EV_QUEUE (((3 * 24) + 16) * XHCI_MAXSLOTS)
>=20
>  typedef struct XHCIStreamContext XHCIStreamContext;  typedef struct
> XHCIEPContext XHCIEPContext; @@ -217,15 +207,15 @@ typedef struct
> XHCIState {
>      uint32_t dcbaap_high;
>      uint32_t config;
>=20
> -    USBPort  uports[MAX_CONST(MAXPORTS_2, MAXPORTS_3)];
> -    XHCIPort ports[MAXPORTS];
> -    XHCISlot slots[MAXSLOTS];
> +    USBPort  uports[MAX_CONST(XHCI_MAXPORTS_2, XHCI_MAXPORTS_3)];
> +    XHCIPort ports[XHCI_MAXPORTS];
> +    XHCISlot slots[XHCI_MAXSLOTS];
>      uint32_t numports;
>=20
>      /* Runtime Registers */
>      int64_t mfindex_start;
>      QEMUTimer *mfwrap_timer;
> -    XHCIInterrupter intr[MAXINTRS];
> +    XHCIInterrupter intr[XHCI_MAXINTRS];
>=20
>      XHCIRing cmd_ring;
>=20
> diff --git a/include/hw/usb/xhci.h b/include/hw/usb/xhci.h new file mode
> 100644 index 000000000000..dc0c29930dcc
> --- /dev/null
> +++ b/include/hw/usb/xhci.h
> @@ -0,0 +1,19 @@
> +#ifndef HW_USB_XHCI_H
> +#define HW_USB_XHCI_H
> +
> +#define TYPE_XHCI "base-xhci"
> +#define TYPE_NEC_XHCI "nec-usb-xhci"
> +#define TYPE_QEMU_XHCI "qemu-xhci"
> +#define TYPE_XHCI_SYSBUS "sysbus-xhci"
> +
> +#define XHCI_MAXPORTS_2 15
> +#define XHCI_MAXPORTS_3 15
> +
> +#define XHCI_MAXPORTS (XHCI_MAXPORTS_2 + XHCI_MAXPORTS_3) #define
> +XHCI_MAXSLOTS 64 #define XHCI_MAXINTRS 16
> +
> +/* must be power of 2 */
> +#define XHCI_LEN_REGS 0x4000
> +
> +#endif
> diff --git a/hw/usb/hcd-xhci-nec.c b/hw/usb/hcd-xhci-nec.c index
> 2efa6fa0f8af..5707b2cabd16 100644
> --- a/hw/usb/hcd-xhci-nec.c
> +++ b/hw/usb/hcd-xhci-nec.c
> @@ -34,8 +34,8 @@ static Property nec_xhci_properties[] =3D {
>                      xhci.flags, XHCI_FLAG_SS_FIRST, true),
>      DEFINE_PROP_BIT("force-pcie-endcap", XHCIPciState, xhci.flags,
>                      XHCI_FLAG_FORCE_PCIE_ENDCAP, false),
> -    DEFINE_PROP_UINT32("intrs", XHCIPciState, xhci.numintrs, MAXINTRS),
> -    DEFINE_PROP_UINT32("slots", XHCIPciState, xhci.numslots, MAXSLOTS),
> +    DEFINE_PROP_UINT32("intrs", XHCIPciState, xhci.numintrs,
> XHCI_MAXINTRS),
> +    DEFINE_PROP_UINT32("slots", XHCIPciState, xhci.numslots,
> + XHCI_MAXSLOTS),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>=20
> diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c index
> a6d746e1da38..b78fcd2bb2d5 100644
> --- a/hw/usb/hcd-xhci-pci.c
> +++ b/hw/usb/hcd-xhci-pci.c
> @@ -240,8 +240,8 @@ static void qemu_xhci_instance_init(Object *obj)
>=20
>      s->msi      =3D ON_OFF_AUTO_OFF;
>      s->msix     =3D ON_OFF_AUTO_AUTO;
> -    xhci->numintrs =3D MAXINTRS;
> -    xhci->numslots =3D MAXSLOTS;
> +    xhci->numintrs =3D XHCI_MAXINTRS;
> +    xhci->numslots =3D XHCI_MAXSLOTS;
>      xhci_set_flag(xhci, XHCI_FLAG_SS_FIRST);  }
>=20
> diff --git a/hw/usb/hcd-xhci-sysbus.c b/hw/usb/hcd-xhci-sysbus.c index
> 852ca5103b4d..570618467356 100644
> --- a/hw/usb/hcd-xhci-sysbus.c
> +++ b/hw/usb/hcd-xhci-sysbus.c
> @@ -69,8 +69,8 @@ static void xhci_sysbus_instance_init(Object *obj)  }
>=20
>  static Property xhci_sysbus_props[] =3D {
> -    DEFINE_PROP_UINT32("intrs", XHCISysbusState, xhci.numintrs, MAXINTRS=
),
> -    DEFINE_PROP_UINT32("slots", XHCISysbusState, xhci.numslots, MAXSLOTS=
),
> +    DEFINE_PROP_UINT32("intrs", XHCISysbusState, xhci.numintrs,
> XHCI_MAXINTRS),
> +    DEFINE_PROP_UINT32("slots", XHCISysbusState, xhci.numslots,
> + XHCI_MAXSLOTS),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>=20
> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c index
> 5e8bed9ef90c..79ce5c4be6c4 100644
> --- a/hw/usb/hcd-xhci.c
> +++ b/hw/usb/hcd-xhci.c
> @@ -46,15 +46,13 @@
>  #define TRANSFER_LIMIT  256
>=20
>  #define LEN_CAP         0x40
> -#define LEN_OPER        (0x400 + 0x10 * MAXPORTS)
> -#define LEN_RUNTIME     ((MAXINTRS + 1) * 0x20)
> -#define LEN_DOORBELL    ((MAXSLOTS + 1) * 0x20)
> +#define LEN_OPER        (0x400 + 0x10 * XHCI_MAXPORTS)
> +#define LEN_RUNTIME     ((XHCI_MAXINTRS + 1) * 0x20)
> +#define LEN_DOORBELL    ((XHCI_MAXSLOTS + 1) * 0x20)
>=20
>  #define OFF_OPER        LEN_CAP
>  #define OFF_RUNTIME     0x1000
>  #define OFF_DOORBELL    0x2000
> -/* must be power of 2 */
> -#define LEN_REGS        0x4000
>=20
>  #if (OFF_OPER + LEN_OPER) > OFF_RUNTIME  #error Increase OFF_RUNTIME
> @@ -62,8 +60,8 @@  #if (OFF_RUNTIME + LEN_RUNTIME) > OFF_DOORBELL
> #error Increase OFF_DOORBELL  #endif -#if (OFF_DOORBELL + LEN_DOORBELL)
> > LEN_REGS -# error Increase LEN_REGS
> +#if (OFF_DOORBELL + LEN_DOORBELL) > XHCI_LEN_REGS # error Increase
> +XHCI_LEN_REGS
>  #endif
>=20
>  /* bit definitions */
> @@ -3276,11 +3274,11 @@ static void usb_xhci_init(XHCIState *xhci)
>=20
>      xhci->usbsts =3D USBSTS_HCH;
>=20
> -    if (xhci->numports_2 > MAXPORTS_2) {
> -        xhci->numports_2 =3D MAXPORTS_2;
> +    if (xhci->numports_2 > XHCI_MAXPORTS_2) {
> +        xhci->numports_2 =3D XHCI_MAXPORTS_2;
>      }
> -    if (xhci->numports_3 > MAXPORTS_3) {
> -        xhci->numports_3 =3D MAXPORTS_3;
> +    if (xhci->numports_3 > XHCI_MAXPORTS_3) {
> +        xhci->numports_3 =3D XHCI_MAXPORTS_3;
>      }
>      usbports =3D MAX(xhci->numports_2, xhci->numports_3);
>      xhci->numports =3D xhci->numports_2 + xhci->numports_3; @@ -3302,7
> +3300,7 @@ static void usb_xhci_init(XHCIState *xhci)
>                  USB_SPEED_MASK_LOW  |
>                  USB_SPEED_MASK_FULL |
>                  USB_SPEED_MASK_HIGH;
> -            assert(i < MAXPORTS);
> +            assert(i < XHCI_MAXPORTS);
>              snprintf(port->name, sizeof(port->name), "usb2 port #%d", i+=
1);
>              speedmask |=3D port->speedmask;
>          }
> @@ -3316,7 +3314,7 @@ static void usb_xhci_init(XHCIState *xhci)
>              }
>              port->uport =3D &xhci->uports[i];
>              port->speedmask =3D USB_SPEED_MASK_SUPER;
> -            assert(i < MAXPORTS);
> +            assert(i < XHCI_MAXPORTS);
>              snprintf(port->name, sizeof(port->name), "usb3 port #%d", i+=
1);
>              speedmask |=3D port->speedmask;
>          }
> @@ -3331,8 +3329,8 @@ static void usb_xhci_realize(DeviceState *dev, Erro=
r
> **errp)
>=20
>      XHCIState *xhci =3D XHCI(dev);
>=20
> -    if (xhci->numintrs > MAXINTRS) {
> -        xhci->numintrs =3D MAXINTRS;
> +    if (xhci->numintrs > XHCI_MAXINTRS) {
> +        xhci->numintrs =3D XHCI_MAXINTRS;
>      }
>      while (xhci->numintrs & (xhci->numintrs - 1)) {   /* ! power of 2 */
>          xhci->numintrs++;
> @@ -3340,8 +3338,8 @@ static void usb_xhci_realize(DeviceState *dev, Erro=
r
> **errp)
>      if (xhci->numintrs < 1) {
>          xhci->numintrs =3D 1;
>      }
> -    if (xhci->numslots > MAXSLOTS) {
> -        xhci->numslots =3D MAXSLOTS;
> +    if (xhci->numslots > XHCI_MAXSLOTS) {
> +        xhci->numslots =3D XHCI_MAXSLOTS;
>      }
>      if (xhci->numslots < 1) {
>          xhci->numslots =3D 1;
> @@ -3355,7 +3353,7 @@ static void usb_xhci_realize(DeviceState *dev, Erro=
r
> **errp)
>      usb_xhci_init(xhci);
>      xhci->mfwrap_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> xhci_mfwrap_timer, xhci);
>=20
> -    memory_region_init(&xhci->mem, OBJECT(dev), "xhci", LEN_REGS);
> +    memory_region_init(&xhci->mem, OBJECT(dev), "xhci", XHCI_LEN_REGS);
>      memory_region_init_io(&xhci->mem_cap, OBJECT(dev), &xhci_cap_ops,
> xhci,
>                            "capabilities", LEN_CAP);
>      memory_region_init_io(&xhci->mem_oper, OBJECT(dev), &xhci_oper_ops,
> xhci,
> --
> 2.27.0


