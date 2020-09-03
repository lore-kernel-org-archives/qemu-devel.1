Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE98C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 19:47:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3155D20767
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 19:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="faX/qhry"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3155D20767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDvCd-0000bK-DB
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 15:47:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>)
 id 1kDvC0-0008Qt-Rm; Thu, 03 Sep 2020 15:46:44 -0400
Received: from mail-bn7nam10on2055.outbound.protection.outlook.com
 ([40.107.92.55]:57680 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>)
 id 1kDvBy-0003db-8E; Thu, 03 Sep 2020 15:46:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVoOObFd3xn7dlUcDQheRTfj+kTby8xXg0jQLbzVBMoxqpoFJblt/qhjeymVaQwmCoc4gFh8tMg5GGkdAInYNIFCRlV2lnALbRDUkVzVAph2HXSa3g/BkxfYXqPs1kYEjcQE5o8AdBFx48KVezs0ODWraUYs03sAPr9l14VpxwceOb0NSq/hcqzAgfKyV5pxJri4L8JMeg9yip5u+VToDqLHW7ba/WC9mTDVLEXP7UbTfU+VsHgAPl0vpyrKfyWSIgxDiIGZ6mEvEbzeprE7UEQAWGYX934rDDV9opukP/B8M1615jk3CPCjVS8jIvzJglp2kDgi21p9gK1FQM/7Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nI+4pNLAIOlb9AHbHxv15EWBM4H1fJKDHI9gck2x/CE=;
 b=m+PxlgP+AOHXCCegJviM6Wa1e8pi9+si2UBwi+ua8hqy8PLIE/X3wP7gPyAjJIkyuL2lbs4GEouhQV42fkmQ0T/b45B+WsQuH2ZOvQ+pQv7SIo2GXoxjLB85ipyXqlvfBiMIEzWljoHF2miCwxm8MX42Ljaze+Q2LPzIb0FgmzAZtF8tTAbTETv9CeT/9XPKnbFEjpxW0IQ/PypfPop4C+iT3zytqdoH9WyvG0gjeX+vIS9RMkWfUDBkdJWcUJ/Uz24gCsQkvcLSoAtYrbQ9aDwXb+fKb7WGO4R8dC3hqdtdxsK4YuNnYf0L9DHBTIlV6+vnWdAVQwC2kdPR76ntdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=twiddle.net smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nI+4pNLAIOlb9AHbHxv15EWBM4H1fJKDHI9gck2x/CE=;
 b=faX/qhryhnOQXns/ifek+4farfGvrIcUpwrOkFpcRmMiPpKNTXJxXNLDxzHzu47U/kkz0vQ0E5huTsX+LWEMowfZKi0i7BhBKvXiuwUh1ubCUXCU7QFjFC/6/FYMEcZx3nLG5CJOU02yr9zysJoNlnhtvkLa5jOXSp94ASIWF9c=
Received: from MN2PR11CA0005.namprd11.prod.outlook.com (2603:10b6:208:23b::10)
 by BYAPR02MB5656.namprd02.prod.outlook.com (2603:10b6:a03:96::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 3 Sep
 2020 19:46:37 +0000
Received: from BL2NAM02FT055.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:23b:cafe::5a) by MN2PR11CA0005.outlook.office365.com
 (2603:10b6:208:23b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend
 Transport; Thu, 3 Sep 2020 19:46:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; twiddle.net; dkim=none (message not signed)
 header.d=none;twiddle.net; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT055.mail.protection.outlook.com (10.152.77.126) with Microsoft SMTP
 Server id 15.20.3326.19 via Frontend Transport; Thu, 3 Sep 2020 19:46:36
 +0000
Received: from [149.199.38.66] (port=50797 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <edgar@xilinx.com>)
 id 1kDvBl-0004OS-Hs; Thu, 03 Sep 2020 12:46:29 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
 by smtp.xilinx.com with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1kDvBr-0005Up-9f; Thu, 03 Sep 2020 12:46:35 -0700
Received: from xsj-pvapsmtp01 (smtp-fallback.xilinx.com [149.199.38.66] (may
 be forged))
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 083JkXB5027745; 
 Thu, 3 Sep 2020 12:46:33 -0700
Received: from [10.71.116.235] (helo=localhost)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1kDvBp-0005Uj-18; Thu, 03 Sep 2020 12:46:33 -0700
Date: Thu, 3 Sep 2020 21:46:29 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH 00/12] hw: Forbid DMA write accesses to MMIO regions
Message-ID: <20200903194629.GH14249@toto>
References: <20200903110831.353476-1-philmd@redhat.com>
 <658fdd16-33da-af3a-6d8d-f7ea1253f061@redhat.com>
 <CAFEAcA8aOzq8UQwKiyuvJokBT9ui6JWxzf=T8=r13Vuu6+_kkQ@mail.gmail.com>
 <20200903142410.GX2954729@toto>
 <d030f14b-5b1d-6028-8fdd-5dbc25abdf74@redhat.com>
 <20200903155023.GC14249@toto>
 <9105d1fb-8064-076f-9408-ba94c889b765@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9105d1fb-8064-076f-9408-ba94c889b765@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aafa8737-169e-4c84-945f-08d85042115f
X-MS-TrafficTypeDiagnostic: BYAPR02MB5656:
X-Microsoft-Antispam-PRVS: <BYAPR02MB56564E4E66DB14608167AAABC22C0@BYAPR02MB5656.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aXp8lrAWeaY+evJnQsjxbcM79iR9BDPTFfn9pu219Lf8z/fWUdPkF0ZLobM9MsgeXfPa0ckoG4JPS5fGtXMtwt8n2ifO1zGBjzRO0qRgMeeaxSGGxlX/eDYDLFOlkjRrg3xXOlCMSCux1R4RiWegMF0ftUmEhvlVLeDue3Abl5faaKlza+Ol2OFEXf81Gm8nD/7nG3Zr8s3bFYFnr2EmBXWFuFNSP+8pYxZMFsr0/ZqcHiHiR9fU/joZTRwA5B5ntcvApNmfnxUe2aYs8bwcjCFE8Q2xXhDe5N801kEV1Nv0KuY0QRN57ltfCWI+45CwJNXSDBiX2oGjrCe4qrO3AHb7n3GLNxc7p4VqkO+fFaDnzozb9NLgVrBsgW0Oe112omIfsqzuCVtaU2/9HHMOGnM4j88PoRMPtwDWlvEL1u8=
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(7916004)(39860400002)(136003)(376002)(346002)(396003)(46966005)(426003)(82310400003)(8936002)(7416002)(478600001)(336012)(6666004)(9686003)(7406005)(33656002)(54906003)(5660300002)(186003)(47076004)(53546011)(70586007)(70206006)(83380400001)(1076003)(316002)(81166007)(82740400003)(8676002)(2906002)(9786002)(33716001)(356005)(6916009)(4326008)(26005)(42866002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 19:46:36.2015 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aafa8737-169e-4c84-945f-08d85042115f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT055.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5656
Received-SPF: pass client-ip=40.107.92.55; envelope-from=edgar@xilinx.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 15:46:39
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

On Thu, Sep 03, 2020 at 07:53:33PM +0200, Paolo Bonzini wrote:
> On 03/09/20 17:50, Edgar E. Iglesias wrote:
> >>> Hmm, I guess it would make sense to have a configurable option in KVM
> >>> to isolate passthrough devices so they only can DMA to guest RAM...
> >>
> >> Passthrough devices are always protected by the IOMMU, anything else
> >> would be obviously insane^H^H^Hecure. :)
> > 
> > Really? To always do that blindly seems wrong.
> > 
> > I'm refering to the passthrough device not being able to reach registers
> > of other passthrough devices within the same guest.
> 
> Ah okay; sorry, I misunderstood.  That makes more sense now!
> 
> Multiple devices are put in the same IOMMU "container" (page table
> basically), and that takes care of reaching registers of other
> passthrough devices.

Thanks, yes, that's a sane default. What I was trying to say before is that
it may make sense to allow the user to "harden" the setup by selectivly
putting certain passthrough devs on a separate group that can *only*
DMA access guest RAM (not other device regs).

Some devs need access to other device's regs but many passthrough devs don't
need DMA access to anything else but RAM (e.g an Ethernet MAC).

That could mitigate the damage caused by wild DMA pointers...

Cheers,
Edgar

