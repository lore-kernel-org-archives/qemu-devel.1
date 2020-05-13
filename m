Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F52CA90AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 09:22:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DE5E20661
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 09:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YVDDkI0P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DE5E20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYnb1-0005wx-8C
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 05:22:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jYnaF-0004vS-5w
 for qemu-devel@nongnu.org; Wed, 13 May 2020 05:21:47 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32420
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jYnaD-0005BR-EG
 for qemu-devel@nongnu.org; Wed, 13 May 2020 05:21:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589361704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=Tpu4pyfS2otHXoGzkXUEiNY/fXbKSB/kPLARDthM2o8=;
 b=YVDDkI0PPXd4lZlsfrCxNgbSHhkUjzNMvZTCZoQHgT9uKamCOIQ5T48I53C5Chwl99EKZt
 IQmZ13x+Ge43wmHcL2ibRWZ6aN2Gu7hRSs95xNFY5ArqEobUteVTDwWwhRSOxxoQUdCDoJ
 vzsrmIGG06dHeNJasorK1UnjYy6/1VA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-n2_5bZiFNr6WWwrrz-QjFg-1; Wed, 13 May 2020 05:21:42 -0400
X-MC-Unique: n2_5bZiFNr6WWwrrz-QjFg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8429100A8E9;
 Wed, 13 May 2020 09:21:40 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-114-100.ams2.redhat.com [10.36.114.100])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 049105C1BB;
 Wed, 13 May 2020 09:21:38 +0000 (UTC)
Subject: Re: [PATCH v4 3/4] tests/qtest: Introduce tests for Xilinx ZynqMP CAN
 controller
To: Vikram Garhwal <fnu.vikram@xilinx.com>, qemu-devel@nongnu.org
References: <1589314552-1375-1-git-send-email-fnu.vikram@xilinx.com>
 <1589314552-1375-4-git-send-email-fnu.vikram@xilinx.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <a5a8de0b-a718-cac6-239f-9d74fc6f5628@redhat.com>
Date: Wed, 13 May 2020 11:21:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1589314552-1375-4-git-send-email-fnu.vikram@xilinx.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 01:56:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, francisco.iglesias@xilinx.com,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/05/2020 22.15, Vikram Garhwal wrote:
> The QTests perform five tests on the Xilinx ZynqMP CAN controller:
>     Tests the CAN controller in loopback, sleep and snoop mode.
>     Tests filtering of incoming CAN messages.
> 
> Signed-off-by: Vikram Garhwal <fnu.vikram@xilinx.com>
> ---
>  tests/qtest/Makefile.include |   2 +
>  tests/qtest/xlnx-can-test.c  | 367 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 369 insertions(+)
>  create mode 100644 tests/qtest/xlnx-can-test.c
> 
> diff --git a/tests/qtest/Makefile.include b/tests/qtest/Makefile.include
> index 9e5a51d..0996075 100644
> --- a/tests/qtest/Makefile.include
> +++ b/tests/qtest/Makefile.include
> @@ -136,6 +136,7 @@ check-qtest-aarch64-$(CONFIG_TPM_TIS_SYSBUS) += tpm-tis-device-swtpm-test
>  check-qtest-aarch64-y += numa-test
>  check-qtest-aarch64-y += boot-serial-test
>  check-qtest-aarch64-y += migration-test
> +check-qtest-aarch64-y += xlnx-can-test
>  
>  # TODO: once aarch64 TCG is fixed on ARM 32 bit host, make test unconditional
>  ifneq ($(ARCH),arm)
> @@ -265,6 +266,7 @@ tests/qtest/bios-tables-test$(EXESUF): tests/qtest/bios-tables-test.o \
>  	tests/qtest/boot-sector.o tests/qtest/acpi-utils.o $(libqos-obj-y)
>  tests/qtest/pxe-test$(EXESUF): tests/qtest/pxe-test.o tests/qtest/boot-sector.o $(libqos-obj-y)
>  tests/qtest/microbit-test$(EXESUF): tests/qtest/microbit-test.o
> +tests/qtest/xlnx-can-test$(EXESUF): tests/qtest/xlnx-can-test.o
>  tests/qtest/m25p80-test$(EXESUF): tests/qtest/m25p80-test.o
>  tests/qtest/i440fx-test$(EXESUF): tests/qtest/i440fx-test.o $(libqos-pc-obj-y)
>  tests/qtest/q35-test$(EXESUF): tests/qtest/q35-test.o $(libqos-pc-obj-y)
> diff --git a/tests/qtest/xlnx-can-test.c b/tests/qtest/xlnx-can-test.c
> new file mode 100644
> index 0000000..1307a2b
> --- /dev/null
> +++ b/tests/qtest/xlnx-can-test.c
> @@ -0,0 +1,367 @@
> +/*
> + * QTests for the Xilinx ZynqMP CAN controller.
> + *
> + * Copyright (c) 2020 Xilinx Inc.
> + *
> + * Written-by: Vikram Garhwal<fnu.vikram@xilinx.com>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "libqtest.h"
> +
> +/* Xlnx-CAN base address. */
> +#define CAN0_BASE_ADDR          0xFF060000
> +#define CAN1_BASE_ADDR          0xFF070000
> +
> +/* Register address in Xlnx-CAN. */
> +#define R_SRR_OFFSET            0x00
> +#define R_MSR_OFFSET            0x04
> +#define R_SR_OFFSET             0x18
> +#define R_ISR_OFFSET            0x1C
> +#define R_ICR_OFFSET            0x24
> +#define R_TXID_OFFSET           0x30
> +#define R_TXDLC_OFFSET          0x34
> +#define R_TXDATA1_OFFSET        0x38
> +#define R_TXDATA2_OFFSET        0x3C
> +#define R_RXID_OFFSET           0x50
> +#define R_RXDLC_OFFSET          0x54
> +#define R_RXDATA1_OFFSET        0x58
> +#define R_RXDATA2_OFFSET        0x5C
> +#define R_AFR                   0x60
> +#define R_AFMR1                 0x64
> +#define R_AFIR1                 0x68
> +#define R_AFMR2                 0x6C
> +#define R_AFIR2                 0x70
> +#define R_AFMR3                 0x74
> +#define R_AFIR3                 0x78
> +#define R_AFMR4                 0x7C
> +#define R_AFIR4                 0x80
> +
> +/* CAN modes. */
> +#define CONFIG_MODE             0x00
> +#define NORMAL_MODE             0x00
> +#define LOOPBACK_MODE           0x02
> +#define SNOOP_MODE              0x04
> +#define SLEEP_MODE              0x01
> +#define ENABLE_CAN              (1 << 1)
> +#define STATUS_NORMAL_MODE      (1 << 3)
> +#define STATUS_LOOPBACK_MODE    (1 << 1)
> +#define STATUS_SNOOP_MODE       (1 << 12)
> +#define STATUS_SLEEP_MODE       (1 << 2)
> +#define ISR_TXOK                (1 << 1)
> +#define ISR_RXOK                (1 << 4)
> +
> +static void match_rx_tx_data(uint32_t *buf_tx, uint32_t *buf_rx,
> +                             uint8_t can_timestamp)
> +{
> +    uint16_t size = 0;
> +    uint8_t len = 4;
> +
> +    while (size < len) {
> +        if (R_RXID_OFFSET + 4 * size == R_RXDLC_OFFSET)  {
> +            g_assert_cmpint(buf_rx[size], ==, buf_tx[size] + can_timestamp);
> +        } else {
> +            g_assert_cmpint(buf_rx[size], ==, buf_tx[size]);
> +        }
> +
> +        size++;
> +    }
> +}
> +
> +static void read_data(QTestState *qts, uint64_t can_base_addr, uint32_t *buf_rx)
> +{
> +    uint32_t int_status;
> +
> +    /* Read the interrupt on CAN rx. */
> +    int_status = qtest_readl(qts, can_base_addr + R_ISR_OFFSET) & ISR_RXOK;
> +
> +    g_assert_cmpint(int_status, ==, ISR_RXOK);
> +
> +    /* Read the RX register data for CAN. */
> +    buf_rx[0] = qtest_readl(qts, can_base_addr + R_RXID_OFFSET);
> +    buf_rx[1] = qtest_readl(qts, can_base_addr + R_RXDLC_OFFSET);
> +    buf_rx[2] = qtest_readl(qts, can_base_addr + R_RXDATA1_OFFSET);
> +    buf_rx[3] = qtest_readl(qts, can_base_addr + R_RXDATA2_OFFSET);
> +
> +    /* Clear the RX interrupt. */
> +    qtest_writel(qts, CAN1_BASE_ADDR + R_ICR_OFFSET, ISR_RXOK);
> +}
> +
> +static void send_data(QTestState *qts, uint64_t can_base_addr, uint32_t *buf_tx)
> +{
> +    uint32_t int_status;
> +
> +    /* Write the TX register data for CAN. */
> +    qtest_writel(qts, can_base_addr + R_TXID_OFFSET, buf_tx[0]);
> +    qtest_writel(qts, can_base_addr + R_TXDLC_OFFSET, buf_tx[1]);
> +    qtest_writel(qts, can_base_addr + R_TXDATA1_OFFSET, buf_tx[2]);
> +    qtest_writel(qts, can_base_addr + R_TXDATA2_OFFSET, buf_tx[3]);
> +
> +    /* Read the interrupt on CAN for tx. */
> +    int_status = qtest_readl(qts, can_base_addr + R_ISR_OFFSET) & ISR_TXOK;
> +
> +    g_assert_cmpint(int_status, ==, ISR_TXOK);
> +
> +    /* Clear the interrupt for tx. */
> +    qtest_writel(qts, CAN0_BASE_ADDR + R_ICR_OFFSET, ISR_TXOK);
> +}
> +
> +/*
> + * This test will be transferring data from CAN0 and CAN1 through canbus. CAN0
> + * initiate the data transfer to can-bus, CAN1 receives the data. Test compares
> + * the data sent from CAN0 with received on CAN1.
> + */
> +static void test_can_bus(void)
> +{
> +    uint32_t buf_tx[4] = {0xFF, 0x80000000, 0x12345678, 0x87654321};
> +    uint32_t buf_rx[4] = {0x00, 0x00, 0x00, 0x00};

Just a matter of taste, but I'd add a space between the numbers and the
curly braces. Anyway:

Acked-by: Thomas Huth <thuth@redhat.com>


