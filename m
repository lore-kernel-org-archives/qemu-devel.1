Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD289C41604
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 17:49:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4EA32168B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 17:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="LmX8koci"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4EA32168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQDYf-0001xd-Lh
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 13:48:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1kQDXk-0001VU-V1
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 13:48:00 -0400
Received: from mail-mw2nam10on2067.outbound.protection.outlook.com
 ([40.107.94.67]:34945 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1kQDXh-0002io-F2
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 13:48:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+nmxc7w+EfhRF5BZrfkYdQPwvXn+Gl2pUYhEGnX7qgW77+M+2LosIBK/zhdIstq23/ZyTeDTWR0dMAKzYiTjpSyy2Gmj/YztkM3ZZ49TPaNatClbySPzUXZ0X4NPlxQqRlwMm9CFmal8XXsP+dMI2/FYM81+98eXB+mSE8y0F5bwgbQuB8GoYh+ZP8ka7hKg7Q3kcGzcG3d+XQBvin9W3EbRQzA+aiuQsOhItZBL3qZYETtyqawvFzQ84WyUdgQygxTEQ9AieoctEfvoiHvYCtNNG570nD9GUEam78lTECnYqxVJ/xDYOR8mtD14G7lidrw/i4QQNc44aE+RTWj6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOnq+WCjr/Kr63j7JjDaFkeo0CzMGTJ1lVCtKQfinbA=;
 b=d8PhwZvJnvy1H9yK475pCWUEw35Yk5aP8HaGyCgHhIFL8tYBaV6dDPifCVZsESbm9gAJiih5SeLx1dU9MaK/QE3HZVkNKarzKt+kG+GVg+Wt9DkU3OskgsWgsdaA57KvZeirradUkeUJshvL/pLAhhSkiWwVPMGNUBaeyJszItXY5bdqQt8ZYIaxiz9Su2hfCZ69wWtrl8VGPAOegGqSne2IhlFnZ3ykbxA3GaIejN217QNDnD6waOKwby6TpeXk2FsKLA4MOLiUN190PuBntr9rDrtk0Paa6i7kTujxJGLCv3qnpMlk5t2Td+L5Ow+xCxoe9QK51doIip1nBsG3+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=amsat.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOnq+WCjr/Kr63j7JjDaFkeo0CzMGTJ1lVCtKQfinbA=;
 b=LmX8kociJe8umFzBuKFlhbNmICrSZ99Io2f34euWSCOmtbUXZkuBDlrDikj6lNJewZ6xLAzydaE3qqhIzrG5Yh1Wre+J39EDgo5RFJ/b5ZxCBOvTacN4bzBjIutDX64pTH1+ZAMH38Ecn75lhrHiEgpjsdBOAZeiKlol9qbrTXo=
Received: from DM6PR06CA0060.namprd06.prod.outlook.com (2603:10b6:5:54::37) by
 BL0PR02MB4915.namprd02.prod.outlook.com (2603:10b6:208:5a::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.38; Wed, 7 Oct 2020 17:47:53 +0000
Received: from CY1NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::db) by DM6PR06CA0060.outlook.office365.com
 (2603:10b6:5:54::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23 via Frontend
 Transport; Wed, 7 Oct 2020 17:47:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; amsat.org; dkim=none (message not signed)
 header.d=none;amsat.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT060.mail.protection.outlook.com (10.152.74.252) with Microsoft SMTP
 Server id 15.20.3433.39 via Frontend Transport; Wed, 7 Oct 2020 17:47:52
 +0000
Received: from [149.199.38.66] (port=53773 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1kQDX2-0002NH-4w; Wed, 07 Oct 2020 10:47:16 -0700
Received: from [127.0.0.1] (helo=localhost)
 by smtp.xilinx.com with smtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1kQDXc-0001C4-Eo; Wed, 07 Oct 2020 10:47:52 -0700
Received: from [172.19.2.115] (helo=xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1kQDXU-0001BM-Sf; Wed, 07 Oct 2020 10:47:44 -0700
Date: Wed, 7 Oct 2020 10:47:44 -0700
From: Vikram Garhwal <fnu.vikram@xilinx.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH v10 3/4] tests/qtest: Introduce tests for Xilinx ZynqMP
 CAN controller
Message-ID: <20201007174744.GA398674@xilinx.com>
References: <1600121324-31337-1-git-send-email-fnu.vikram@xilinx.com>
 <1600121324-31337-4-git-send-email-fnu.vikram@xilinx.com>
 <45862419-9bb8-ab23-baef-29d4b2c41ffc@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45862419-9bb8-ab23-baef-29d4b2c41ffc@amsat.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9991da2-5236-4641-08b7-08d86ae91d7d
X-MS-TrafficTypeDiagnostic: BL0PR02MB4915:
X-Microsoft-Antispam-PRVS: <BL0PR02MB4915A38B3E25C2FE178D2E56BC0A0@BL0PR02MB4915.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QE5aQF7cFKDx+DLI5SRs9Css5+TgU97YBAHXOLVz0wroRcMwpmobBK+oQ+o8+ZTfbvyich/u5XTlL0KlTTB8vkZcy3o/zIkIWErBM1gD+xneGicYLLNm+/hE/FGtnVPZxfogzLYx/osN/2mT5uy4oW3MCOLnT8KR742ZjNHfRcQDzpgHecMsJmJemf7tBad9XloeVQ2x0jcFfYc/JXmscySpRchxx8Ds+S/YzjR7ptg6bwjAq2YupNbMcg2lfTGHDJeyYaL0XXft5CvAib4vb271+K90AlPPWsYw/7N2TAsxWW5GHLZJmZrwDpip/xFuKfGe37aCLlM4v+3XIyZIWzypjbt2iSLIbGJQbOqX2adYQq6x9ic0mdm7kzaR/4RjfDAAd9jjVAKoWkL2MusccZN8jbAZx484yR8w5gUK1Yc=
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(396003)(376002)(346002)(136003)(39850400004)(46966005)(4326008)(356005)(7696005)(426003)(478600001)(336012)(36756003)(2616005)(82740400003)(1076003)(26005)(186003)(53546011)(33656002)(8676002)(8936002)(316002)(47076004)(54906003)(5660300002)(6916009)(81166007)(2906002)(9786002)(82310400003)(70586007)(83380400001)(30864003)(70206006)(27376004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2020 17:47:52.7492 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9991da2-5236-4641-08b7-08d86ae91d7d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT060.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4915
Received-SPF: pass client-ip=40.107.94.67; envelope-from=fnuv@xilinx.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 13:47:54
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
Cc: Laurent Vivier <lvivier@redhat.com>, peter.maydell@linaro.org,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 francisco.iglesias@xilinx.com, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,
Thanks for reviewing this one. I will address the comments in next version and
add reviewed-by tags.
On Fri, Oct 02, 2020 at 03:49:31PM +0200, Philippe Mathieu-Daudé wrote:
> Hi Vikram,
>
> On 9/15/20 12:08 AM, Vikram Garhwal wrote:
> > The QTests perform five tests on the Xilinx ZynqMP CAN controller:
> >     Tests the CAN controller in loopback, sleep and snoop mode.
> >     Tests filtering of incoming CAN messages.
> >
> > Reviewed-by: Francisco Iglesias <francisco.iglesias@xilinx.com>
> > Signed-off-by: Vikram Garhwal <fnu.vikram@xilinx.com>
> > ---
> >  tests/qtest/meson.build     |   1 +
> >  tests/qtest/xlnx-can-test.c | 359 ++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 360 insertions(+)
> >  create mode 100644 tests/qtest/xlnx-can-test.c
> >
> > diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> > index 874b5be..945f86c 100644
> > --- a/tests/qtest/meson.build
> > +++ b/tests/qtest/meson.build
> > @@ -148,6 +148,7 @@ qtests_aarch64 = \
> >    (config_all_devices.has_key('CONFIG_TPM_TIS_SYSBUS') ? ['tpm-tis-device-swtpm-test'] : []) +  \
> >    ['numa-test',
> >     'boot-serial-test',
> > +   'xlnx-can-test',
> >     'migration-test']
> >
> >  qtests_s390x = \
> > diff --git a/tests/qtest/xlnx-can-test.c b/tests/qtest/xlnx-can-test.c
> > new file mode 100644
> > index 0000000..d04189f
> > --- /dev/null
> > +++ b/tests/qtest/xlnx-can-test.c
> > @@ -0,0 +1,359 @@
> > +/*
> > + * QTests for the Xilinx ZynqMP CAN controller.
> > + *
> > + * Copyright (c) 2020 Xilinx Inc.
> > + *
> > + * Written-by: Vikram Garhwal<fnu.vikram@xilinx.com>
> > + *
> > + * Permission is hereby granted, free of charge, to any person obtaining a copy
> > + * of this software and associated documentation files (the "Software"), to deal
> > + * in the Software without restriction, including without limitation the rights
> > + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> > + * copies of the Software, and to permit persons to whom the Software is
> > + * furnished to do so, subject to the following conditions:
> > + *
> > + * The above copyright notice and this permission notice shall be included in
> > + * all copies or substantial portions of the Software.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> > + * THE SOFTWARE.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "libqos/libqtest.h"
> > +
> > +/* Base address. */
> > +#define CAN0_BASE_ADDR          0xFF060000
> > +#define CAN1_BASE_ADDR          0xFF070000
> > +
> > +/* Register addresses. */
> > +#define R_SRR_OFFSET            0x00
> > +#define R_MSR_OFFSET            0x04
> > +#define R_SR_OFFSET             0x18
> > +#define R_ISR_OFFSET            0x1C
> > +#define R_ICR_OFFSET            0x24
> > +#define R_TXID_OFFSET           0x30
> > +#define R_TXDLC_OFFSET          0x34
> > +#define R_TXDATA1_OFFSET        0x38
> > +#define R_TXDATA2_OFFSET        0x3C
> > +#define R_RXID_OFFSET           0x50
> > +#define R_RXDLC_OFFSET          0x54
> > +#define R_RXDATA1_OFFSET        0x58
> > +#define R_RXDATA2_OFFSET        0x5C
> > +#define R_AFR                   0x60
> > +#define R_AFMR1                 0x64
> > +#define R_AFIR1                 0x68
> > +#define R_AFMR2                 0x6C
> > +#define R_AFIR2                 0x70
> > +#define R_AFMR3                 0x74
> > +#define R_AFIR3                 0x78
> > +#define R_AFMR4                 0x7C
> > +#define R_AFIR4                 0x80
> > +
> > +/* CAN modes. */
> > +#define CONFIG_MODE             0x00
> > +#define NORMAL_MODE             0x00
> > +#define LOOPBACK_MODE           0x02
> > +#define SNOOP_MODE              0x04
> > +#define SLEEP_MODE              0x01
> > +#define ENABLE_CAN              (1 << 1)
> > +#define STATUS_NORMAL_MODE      (1 << 3)
> > +#define STATUS_LOOPBACK_MODE    (1 << 1)
> > +#define STATUS_SNOOP_MODE       (1 << 12)
> > +#define STATUS_SLEEP_MODE       (1 << 2)
> > +#define ISR_TXOK                (1 << 1)
> > +#define ISR_RXOK                (1 << 4)
> > +
> > +static void match_rx_tx_data(uint32_t *buf_tx, uint32_t *buf_rx,
> > +                             uint8_t can_timestamp)
>
> Both buf_tx/buf_rx should be const.
>
> > +{
> > +    uint16_t size = 0;
> > +    uint8_t len = 4;
> > +
> > +    while (size < len) {
> > +        if (R_RXID_OFFSET + 4 * size == R_RXDLC_OFFSET)  {
> > +            g_assert_cmpint(buf_rx[size], ==, buf_tx[size] + can_timestamp);
> > +        } else {
> > +            g_assert_cmpint(buf_rx[size], ==, buf_tx[size]);
> > +        }
> > +
> > +        size++;
> > +    }
> > +}
> > +
> > +static void read_data(QTestState *qts, uint64_t can_base_addr, uint32_t *buf_rx)
> > +{
> > +    uint32_t int_status;
> > +
> > +    /* Read the interrupt on CAN rx. */
> > +    int_status = qtest_readl(qts, can_base_addr + R_ISR_OFFSET) & ISR_RXOK;
> > +
> > +    g_assert_cmpint(int_status, ==, ISR_RXOK);
> > +
> > +    /* Read the RX register data for CAN. */
> > +    buf_rx[0] = qtest_readl(qts, can_base_addr + R_RXID_OFFSET);
> > +    buf_rx[1] = qtest_readl(qts, can_base_addr + R_RXDLC_OFFSET);
> > +    buf_rx[2] = qtest_readl(qts, can_base_addr + R_RXDATA1_OFFSET);
> > +    buf_rx[3] = qtest_readl(qts, can_base_addr + R_RXDATA2_OFFSET);
> > +
> > +    /* Clear the RX interrupt. */
> > +    qtest_writel(qts, CAN1_BASE_ADDR + R_ICR_OFFSET, ISR_RXOK);
> > +}
> > +
> > +static void send_data(QTestState *qts, uint64_t can_base_addr, uint32_t *buf_tx)
> > +{
>
> buf_tx should be const.
>
> > +    uint32_t int_status;
> > +
> > +    /* Write the TX register data for CAN. */
> > +    qtest_writel(qts, can_base_addr + R_TXID_OFFSET, buf_tx[0]);
> > +    qtest_writel(qts, can_base_addr + R_TXDLC_OFFSET, buf_tx[1]);
> > +    qtest_writel(qts, can_base_addr + R_TXDATA1_OFFSET, buf_tx[2]);
> > +    qtest_writel(qts, can_base_addr + R_TXDATA2_OFFSET, buf_tx[3]);
> > +
> > +    /* Read the interrupt on CAN for tx. */
> > +    int_status = qtest_readl(qts, can_base_addr + R_ISR_OFFSET) & ISR_TXOK;
> > +
> > +    g_assert_cmpint(int_status, ==, ISR_TXOK);
> > +
> > +    /* Clear the interrupt for tx. */
> > +    qtest_writel(qts, CAN0_BASE_ADDR + R_ICR_OFFSET, ISR_TXOK);
> > +}
> > +
> > +/*
> > + * This test will be transferring data from CAN0 and CAN1 through canbus. CAN0
> > + * initiate the data transfer to can-bus, CAN1 receives the data. Test compares
> > + * the data sent from CAN0 with received on CAN1.
> > + */
> > +static void test_can_bus(void)
> > +{
> > +    uint32_t buf_tx[4] = { 0xFF, 0x80000000, 0x12345678, 0x87654321 };
>
> buf_tx should be const (similarly in the followng tests).
>
> Can probably be cleaned on top of this patch, so:
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>
> > +    uint32_t buf_rx[4] = { 0x00, 0x00, 0x00, 0x00 };
> > +    uint32_t status = 0;
> > +    uint8_t can_timestamp = 1;
> > +
> > +    QTestState *qts = qtest_init("-machine xlnx-zcu102"
> > +                " -object can-bus,id=canbus0"
> > +                " -machine xlnx-zcu102.canbus0=canbus0"
> > +                " -machine xlnx-zcu102.canbus1=canbus0"
> > +                );
> > +
> > +    /* Configure the CAN0 and CAN1. */
> > +    qtest_writel(qts, CAN0_BASE_ADDR + R_SRR_OFFSET, ENABLE_CAN);
> > +    qtest_writel(qts, CAN0_BASE_ADDR + R_MSR_OFFSET, NORMAL_MODE);
> > +    qtest_writel(qts, CAN1_BASE_ADDR + R_SRR_OFFSET, ENABLE_CAN);
> > +    qtest_writel(qts, CAN1_BASE_ADDR + R_MSR_OFFSET, NORMAL_MODE);
> > +
> > +    /* Check here if CAN0 and CAN1 are in normal mode. */
> > +    status = qtest_readl(qts, CAN0_BASE_ADDR + R_SR_OFFSET);
> > +    g_assert_cmpint(status, ==, STATUS_NORMAL_MODE);
> > +
> > +    status = qtest_readl(qts, CAN1_BASE_ADDR + R_SR_OFFSET);
> > +    g_assert_cmpint(status, ==, STATUS_NORMAL_MODE);
> > +
> > +    send_data(qts, CAN0_BASE_ADDR, buf_tx);
> > +
> > +    read_data(qts, CAN1_BASE_ADDR, buf_rx);
> > +    match_rx_tx_data(buf_tx, buf_rx, can_timestamp);
> > +
> > +    qtest_quit(qts);
> > +}
> > +
> > +/*
> > + * This test is performing loopback mode on CAN0 and CAN1. Data sent from TX of
> > + * each CAN0 and CAN1 are compared with RX register data for respective CAN.
> > + */
> > +static void test_can_loopback(void)
> > +{
> > +    uint32_t buf_tx[4] = { 0xFF, 0x80000000, 0x12345678, 0x87654321 };
> > +    uint32_t buf_rx[4] = { 0x00, 0x00, 0x00, 0x00 };
> > +    uint32_t status = 0;
> > +
> > +    QTestState *qts = qtest_init("-machine xlnx-zcu102"
> > +                " -object can-bus,id=canbus0"
> > +                " -machine xlnx-zcu102.canbus0=canbus0"
> > +                " -machine xlnx-zcu102.canbus1=canbus0"
> > +                );
> > +
> > +    /* Configure the CAN0 in loopback mode. */
> > +    qtest_writel(qts, CAN0_BASE_ADDR + R_SRR_OFFSET, CONFIG_MODE);
> > +    qtest_writel(qts, CAN0_BASE_ADDR + R_MSR_OFFSET, LOOPBACK_MODE);
> > +    qtest_writel(qts, CAN0_BASE_ADDR + R_SRR_OFFSET, ENABLE_CAN);
> > +
> > +    /* Check here if CAN0 is set in loopback mode. */
> > +    status = qtest_readl(qts, CAN0_BASE_ADDR + R_SR_OFFSET);
> > +
> > +    g_assert_cmpint(status, ==, STATUS_LOOPBACK_MODE);
> > +
> > +    send_data(qts, CAN0_BASE_ADDR, buf_tx);
> > +    read_data(qts, CAN0_BASE_ADDR, buf_rx);
> > +    match_rx_tx_data(buf_tx, buf_rx, 0);
> > +
> > +    /* Configure the CAN1 in loopback mode. */
> > +    qtest_writel(qts, CAN1_BASE_ADDR + R_SRR_OFFSET, CONFIG_MODE);
> > +    qtest_writel(qts, CAN1_BASE_ADDR + R_MSR_OFFSET, LOOPBACK_MODE);
> > +    qtest_writel(qts, CAN1_BASE_ADDR + R_SRR_OFFSET, ENABLE_CAN);
> > +
> > +    /* Check here if CAN1 is set in loopback mode. */
> > +    status = qtest_readl(qts, CAN1_BASE_ADDR + R_SR_OFFSET);
> > +
> > +    g_assert_cmpint(status, ==, STATUS_LOOPBACK_MODE);
> > +
> > +    send_data(qts, CAN1_BASE_ADDR, buf_tx);
> > +    read_data(qts, CAN1_BASE_ADDR, buf_rx);
> > +    match_rx_tx_data(buf_tx, buf_rx, 0);
> > +
> > +    qtest_quit(qts);
> > +}
> > +
> > +/*
> > + * Enable filters for CAN1. This will filter incoming messages with ID. In this
> > + * test message will pass through filter 2.
> > + */
> > +static void test_can_filter(void)
> > +{
> > +    uint32_t buf_tx[4] = { 0x14, 0x80000000, 0x12345678, 0x87654321 };
> > +    uint32_t buf_rx[4] = { 0x00, 0x00, 0x00, 0x00 };
> > +    uint32_t status = 0;
> > +    uint8_t can_timestamp = 1;
> > +
> > +    QTestState *qts = qtest_init("-machine xlnx-zcu102"
> > +                " -object can-bus,id=canbus0"
> > +                " -machine xlnx-zcu102.canbus0=canbus0"
> > +                " -machine xlnx-zcu102.canbus1=canbus0"
> > +                );
> > +
> > +    /* Configure the CAN0 and CAN1. */
> > +    qtest_writel(qts, CAN0_BASE_ADDR + R_SRR_OFFSET, ENABLE_CAN);
> > +    qtest_writel(qts, CAN0_BASE_ADDR + R_MSR_OFFSET, NORMAL_MODE);
> > +    qtest_writel(qts, CAN1_BASE_ADDR + R_SRR_OFFSET, ENABLE_CAN);
> > +    qtest_writel(qts, CAN1_BASE_ADDR + R_MSR_OFFSET, NORMAL_MODE);
> > +
> > +    /* Check here if CAN0 and CAN1 are in normal mode. */
> > +    status = qtest_readl(qts, CAN0_BASE_ADDR + R_SR_OFFSET);
> > +    g_assert_cmpint(status, ==, STATUS_NORMAL_MODE);
> > +
> > +    status = qtest_readl(qts, CAN1_BASE_ADDR + R_SR_OFFSET);
> > +    g_assert_cmpint(status, ==, STATUS_NORMAL_MODE);
> > +
> > +    /* Set filter for CAN1 for incoming messages. */
> > +    qtest_writel(qts, CAN1_BASE_ADDR + R_AFR, 0x0);
> > +    qtest_writel(qts, CAN1_BASE_ADDR + R_AFMR1, 0xF7);
> > +    qtest_writel(qts, CAN1_BASE_ADDR + R_AFIR1, 0x121F);
> > +    qtest_writel(qts, CAN1_BASE_ADDR + R_AFMR2, 0x5431);
> > +    qtest_writel(qts, CAN1_BASE_ADDR + R_AFIR2, 0x14);
> > +    qtest_writel(qts, CAN1_BASE_ADDR + R_AFMR3, 0x1234);
> > +    qtest_writel(qts, CAN1_BASE_ADDR + R_AFIR3, 0x5431);
> > +    qtest_writel(qts, CAN1_BASE_ADDR + R_AFMR4, 0xFFF);
> > +    qtest_writel(qts, CAN1_BASE_ADDR + R_AFIR4, 0x1234);
> > +
> > +    qtest_writel(qts, CAN1_BASE_ADDR + R_AFR, 0xF);
> > +
> > +    send_data(qts, CAN0_BASE_ADDR, buf_tx);
> > +
> > +    read_data(qts, CAN1_BASE_ADDR, buf_rx);
> > +    match_rx_tx_data(buf_tx, buf_rx, can_timestamp);
> > +
> > +    qtest_quit(qts);
> > +}
> > +
> > +/* Testing sleep mode on CAN0 while CAN1 is in normal mode. */
> > +static void test_can_sleepmode(void)
> > +{
> > +    uint32_t buf_tx[4] = { 0x14, 0x80000000, 0x12345678, 0x87654321 };
> > +    uint32_t buf_rx[4] = { 0x00, 0x00, 0x00, 0x00 };
> > +    uint32_t status = 0;
> > +    uint8_t can_timestamp = 1;
> > +
> > +    QTestState *qts = qtest_init("-machine xlnx-zcu102"
> > +                " -object can-bus,id=canbus0"
> > +                " -machine xlnx-zcu102.canbus0=canbus0"
> > +                " -machine xlnx-zcu102.canbus1=canbus0"
> > +                );
> > +
> > +    /* Configure the CAN0. */
> > +    qtest_writel(qts, CAN0_BASE_ADDR + R_SRR_OFFSET, CONFIG_MODE);
> > +    qtest_writel(qts, CAN0_BASE_ADDR + R_MSR_OFFSET, SLEEP_MODE);
> > +    qtest_writel(qts, CAN0_BASE_ADDR + R_SRR_OFFSET, ENABLE_CAN);
> > +
> > +    qtest_writel(qts, CAN1_BASE_ADDR + R_SRR_OFFSET, ENABLE_CAN);
> > +    qtest_writel(qts, CAN1_BASE_ADDR + R_MSR_OFFSET, NORMAL_MODE);
> > +
> > +    /* Check here if CAN0 is in SLEEP mode and CAN1 in normal mode. */
> > +    status = qtest_readl(qts, CAN0_BASE_ADDR + R_SR_OFFSET);
> > +    g_assert_cmpint(status, ==, STATUS_SLEEP_MODE);
> > +
> > +    status = qtest_readl(qts, CAN1_BASE_ADDR + R_SR_OFFSET);
> > +    g_assert_cmpint(status, ==, STATUS_NORMAL_MODE);
> > +
> > +    send_data(qts, CAN1_BASE_ADDR, buf_tx);
> > +
> > +    /*
> > +     * Once CAN1 sends data on can-bus. CAN0 should exit sleep mode.
> > +     * Check the CAN0 status now. It should exit the sleep mode and receive the
> > +     * incoming data.
> > +     */
> > +    status = qtest_readl(qts, CAN0_BASE_ADDR + R_SR_OFFSET);
> > +    g_assert_cmpint(status, ==, STATUS_NORMAL_MODE);
> > +
> > +    read_data(qts, CAN0_BASE_ADDR, buf_rx);
> > +
> > +    match_rx_tx_data(buf_tx, buf_rx, can_timestamp);
> > +
> > +    qtest_quit(qts);
> > +}
> > +
> > +/* Testing Snoop mode on CAN0 while CAN1 is in normal mode. */
> > +static void test_can_snoopmode(void)
> > +{
> > +    uint32_t buf_tx[4] = { 0x14, 0x80000000, 0x12345678, 0x87654321 };
> > +    uint32_t buf_rx[4] = { 0x00, 0x00, 0x00, 0x00 };
> > +    uint32_t status = 0;
> > +    uint8_t can_timestamp = 1;
> > +
> > +    QTestState *qts = qtest_init("-machine xlnx-zcu102"
> > +                " -object can-bus,id=canbus0"
> > +                " -machine xlnx-zcu102.canbus0=canbus0"
> > +                " -machine xlnx-zcu102.canbus1=canbus0"
> > +                );
> > +
> > +    /* Configure the CAN0. */
> > +    qtest_writel(qts, CAN0_BASE_ADDR + R_SRR_OFFSET, CONFIG_MODE);
> > +    qtest_writel(qts, CAN0_BASE_ADDR + R_MSR_OFFSET, SNOOP_MODE);
> > +    qtest_writel(qts, CAN0_BASE_ADDR + R_SRR_OFFSET, ENABLE_CAN);
> > +
> > +    qtest_writel(qts, CAN1_BASE_ADDR + R_SRR_OFFSET, ENABLE_CAN);
> > +    qtest_writel(qts, CAN1_BASE_ADDR + R_MSR_OFFSET, NORMAL_MODE);
> > +
> > +    /* Check here if CAN0 is in SNOOP mode and CAN1 in normal mode. */
> > +    status = qtest_readl(qts, CAN0_BASE_ADDR + R_SR_OFFSET);
> > +    g_assert_cmpint(status, ==, STATUS_SNOOP_MODE);
> > +
> > +    status = qtest_readl(qts, CAN1_BASE_ADDR + R_SR_OFFSET);
> > +    g_assert_cmpint(status, ==, STATUS_NORMAL_MODE);
> > +
> > +    send_data(qts, CAN1_BASE_ADDR, buf_tx);
> > +
> > +    read_data(qts, CAN0_BASE_ADDR, buf_rx);
> > +
> > +    match_rx_tx_data(buf_tx, buf_rx, can_timestamp);
> > +
> > +    qtest_quit(qts);
> > +}
> > +
> > +int main(int argc, char **argv)
> > +{
> > +    g_test_init(&argc, &argv, NULL);
> > +
> > +    qtest_add_func("/net/can/can_bus", test_can_bus);
> > +    qtest_add_func("/net/can/can_loopback", test_can_loopback);
> > +    qtest_add_func("/net/can/can_filter", test_can_filter);
> > +    qtest_add_func("/net/can/can_test_snoopmode", test_can_snoopmode);
> > +    qtest_add_func("/net/can/can_test_sleepmode", test_can_sleepmode);
> > +
> > +    return g_test_run();
> > +}
> >
>

