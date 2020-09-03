Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656F0C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 15:51:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27A912072A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 15:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="dcjAI7nr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27A912072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDrWD-0002EN-Cd
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 11:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>)
 id 1kDrVY-0001bc-6z; Thu, 03 Sep 2020 11:50:41 -0400
Received: from mail-dm6nam11on2055.outbound.protection.outlook.com
 ([40.107.223.55]:16320 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>)
 id 1kDrVT-0004bl-Il; Thu, 03 Sep 2020 11:50:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HOKfWNkXJbaQy5Hq/nN4J73yx7Ya9frQGgpuh3lZ+cVI+iZLjoHcgKY0c3yi/rav9JKsTVpbAHCOmy2ICgkv9rPowauob9oinLpuyXSAZfuwMFGLTro+SdenB4Z5+gHMHC/kmW0PYIntpiu7Jcw50+8kXueSi3nnxggwXXYwDkgrKgSDkIgXILmYhO/r8EL0q9fxQ/BBtRe99/blbnUDRKQH3+ygFq28MrBlGZmU0ybBupPuxxAau945iHPnFhGnA0JrggzuhzXGveZpwAc70LO0wPa3rVbidXhYhYAO6Q9NColV0tNc2OB5ZMz6rKiQAKsk8AdX0m2o3HprqZ+HUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0GysmwiFc+F8qh01YfGx++gZSYla1/J78YxnQR9ZI8=;
 b=ClUTSYWz9KVuhgxE2AkYI6rJuWE2flDhQetB3Ooh9YGFXzwnCdKNfc0TsYD97MVunbLDiOU5860W6m5J1xQXecJAeBZknAl+57zxp45mc6UyF0qhJtkVOEZHrgLg7BgM1R2LlqWX5po60NBzGy1PeLyrVTL48ahHgmihZDukzQaSLtY0XAzSGlFxZeutjrUx3rBTWdTFYIRdunp6Rz7JH2rRhqM8pIPAJURl0cdBFcMP6Yuss58kXLoOHEkDL7Tmd2Wo7VvZ+U0U69ww1DMxrToaUatoQ5NH8I1+rxkXDaF2R9nQZfyj8A7dALjscRIAEGaB01fVN07huvML6b7l7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 149.199.60.83) smtp.rcpttodomain=twiddle.net
 smtp.mailfrom=xilinx.com; 
 dmarc=none action=none header.from=xilinx.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0GysmwiFc+F8qh01YfGx++gZSYla1/J78YxnQR9ZI8=;
 b=dcjAI7nrlJLF/6SZBv8IycyznZxcsx4yZN5L+AXvhyB/j6egGFsxLnHmgmqMHVvo/CRAjThV52cRHxbJ/T08706Ys+tI6TkxwjfWKT0MOpxXzYav2R9mhqCll6AaFsVmKJMsYHR7wllwSq97MMDC6eRpxNLnmvDQu2V6Gqj9ZjQ=
Received: from DM5PR18CA0053.namprd18.prod.outlook.com (2603:10b6:3:22::15) by
 BY5PR02MB6503.namprd02.prod.outlook.com (2603:10b6:a03:1dd::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15; Thu, 3 Sep 2020 15:50:31 +0000
Received: from CY1NAM02FT056.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:22:cafe::65) by DM5PR18CA0053.outlook.office365.com
 (2603:10b6:3:22::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend
 Transport; Thu, 3 Sep 2020 15:50:31 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 149.199.60.83) smtp.mailfrom=xilinx.com; twiddle.net; dkim=none (message not
 signed) header.d=none;twiddle.net; dmarc=none action=none
 header.from=xilinx.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of xilinx.com: DNS Timeout)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT056.mail.protection.outlook.com (10.152.74.160) with Microsoft SMTP
 Server id 15.20.3326.19 via Frontend Transport; Thu, 3 Sep 2020 15:50:30
 +0000
Received: from [149.199.38.66] (port=34215 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <edgar@xilinx.com>)
 id 1kDrVI-0006Vv-20; Thu, 03 Sep 2020 08:50:24 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
 by smtp.xilinx.com with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1kDrVO-0006dn-0K; Thu, 03 Sep 2020 08:50:30 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 083FoREF032586; 
 Thu, 3 Sep 2020 08:50:28 -0700
Received: from [10.71.116.235] (helo=localhost)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1kDrVL-0006bv-KL; Thu, 03 Sep 2020 08:50:27 -0700
Date: Thu, 3 Sep 2020 17:50:23 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH 00/12] hw: Forbid DMA write accesses to MMIO regions
Message-ID: <20200903155023.GC14249@toto>
References: <20200903110831.353476-1-philmd@redhat.com>
 <658fdd16-33da-af3a-6d8d-f7ea1253f061@redhat.com>
 <CAFEAcA8aOzq8UQwKiyuvJokBT9ui6JWxzf=T8=r13Vuu6+_kkQ@mail.gmail.com>
 <20200903142410.GX2954729@toto>
 <d030f14b-5b1d-6028-8fdd-5dbc25abdf74@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d030f14b-5b1d-6028-8fdd-5dbc25abdf74@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cee8ee7a-7797-4a44-1082-08d8502115dd
X-MS-TrafficTypeDiagnostic: BY5PR02MB6503:
X-Microsoft-Antispam-PRVS: <BY5PR02MB65031300D10D50E9D131594EC22C0@BY5PR02MB6503.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RFEB0rFP1Qni2VRwuwdLZVM+AQKlfkUYgB+08PjheH+kofmqF5ZwUkIvKYgPJUX8ahLp5dKg/ewPOfgCNsexTS+mqKdPRctWFH2o+tmDT1vgesNS7kAddba08yYSD96Je5BdeDHINYy32fW1315u5yqlp2M3C05b9lYLiEC4pf+hp3Y92TqjCFBi3CXC4wxAgrOPoiPwtpuKEH8kiKyVA+ADpJdROZXE/9u45T1UkNmv/im6A1FCsiw5sf7aVJhIMNZjjPhKo6w95hp/+gVoUamBaUYcozbtqwO5FGIH67TzYnlkzKgzJcD4mBLPk+9rwDtH05VLORP41XkK0eo7dwjJvvE/XwQOMFbb3/bZYAwPRRBZPPXSGm//wPF/DHeHiomT0rXNl6HkulIF+W6T0g==
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(7916004)(136003)(376002)(396003)(39860400002)(346002)(46966005)(5660300002)(336012)(63350400001)(426003)(316002)(8676002)(2906002)(4326008)(6916009)(4744005)(6666004)(82310400003)(478600001)(8936002)(26005)(9786002)(33716001)(82740400003)(186003)(33656002)(53546011)(1076003)(9686003)(47076004)(356005)(7406005)(70586007)(70206006)(7416002)(54906003)(81166007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 15:50:30.3417 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cee8ee7a-7797-4a44-1082-08d8502115dd
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT056.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6503
Received-SPF: pass client-ip=40.107.223.55; envelope-from=edgar@xilinx.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 11:50:33
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 Li Qiang <liq3ea@163.com>, "Emilio G . Cota" <cota@braap.org>,
 Joel Stanley <joel@jms.id.au>, Richard Henderson <rth@twiddle.net>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Robert Foley <robert.foley@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Jan Kiszka <jan.kiszka@web.de>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Tony Nguyen <tony.nguyen@bt.com>,
 Prasad J Pandit <pjp@fedoraproject.org>, Alexander Bulekov <alxndr@bu.edu>,
 Andrew Jeffery <andrew@aj.id.au>, Laszlo Ersek <lersek@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Klaus Jensen <k.jensen@samsung.com>, Peter Chubb <peter.chubb@nicta.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 03, 2020 at 05:46:39PM +0200, Paolo Bonzini wrote:
> On 03/09/20 16:24, Edgar E. Iglesias wrote:
> >> [*] I do wonder about hardware-device-passthrough setups; I
> >> don't think I would care to pass through an arbitrary device
> >> to an untrusted guest...
> > Hmm, I guess it would make sense to have a configurable option in KVM
> > to isolate passthrough devices so they only can DMA to guest RAM...
> 
> Passthrough devices are always protected by the IOMMU, anything else
> would be obviously insane^H^H^Hecure. :)


Really? To always do that blindly seems wrong.

I'm refering to the passthrough device not being able to reach registers
of other passthrough devices within the same guest.

Obviously the IOMMU should be setup so that passthrough devices don't reach\
other guests or the host.

Cheers,
Edgar

