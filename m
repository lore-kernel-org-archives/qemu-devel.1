Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9348AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 12:29:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69D9C2053B
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 12:29:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69D9C2053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg62N-0000uC-LM
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 08:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jg61i-0000RU-KK; Tue, 02 Jun 2020 08:28:18 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:53112)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jg61g-0006z8-2U; Tue, 02 Jun 2020 08:28:18 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.0520418|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.136455-0.000731891-0.862813;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03312; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=5; RT=5; SR=0; TI=SMTPD_---.Hh9klQY_1591100882; 
Received: from 30.225.208.46(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.Hh9klQY_1591100882)
 by smtp.aliyun-inc.com(10.147.42.197);
 Tue, 02 Jun 2020 20:28:02 +0800
Subject: Re: [PATCH v5 07/11] hw/char: Initial commit of Ibex UART
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: Alistair Francis <alistair.francis@wdc.com>
References: <cover.1590704015.git.alistair.francis@wdc.com>
 <73cce2d0edd0d41ba15df403a2096bfa70bf0565.1590704015.git.alistair.francis@wdc.com>
 <cc1a1671-b926-bb31-1ed2-d2920f0faf38@c-sky.com>
Message-ID: <c9f16143-4e9b-a3a8-ffd3-12d43fd2e343@c-sky.com>
Date: Tue, 2 Jun 2020 20:28:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <cc1a1671-b926-bb31-1ed2-d2920f0faf38@c-sky.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 07:22:06
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 UNPARSEABLE_RELAY=0.001 autolearn=_AUTOLEARN
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>, Bin Meng <bmeng.cn@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alistair,

There are still some questions I don't understand.

1. Is the baud rate  or fifo a necessary feature to simulate?
As you can see, qemu_chr_fe_write will send the byte as soon as possible.
When you want to transmit a byte through WDATA,  you can call 
qemu_chr_fe_write directly.

2.  The baud rate calculation method is not strictly right.
I think when a byte write to FIFO,  char_tx_time * 8 is the correct time 
to send the byte instead of
char_tx_time * 4.

3.  Why add a watch here?
> +        s->uart_status |= UART_STATUS_TXEMPTY;
> +        s->uart_intr_state |= INTR_STATE_TX_EMPTY;
> +        s->uart_intr_state &= ~INTR_STATE_TX_WATERMARK;
> +        ibex_uart_update_irqs(s);
> +        return FALSE;
> +    }
> +
> +    ret = qemu_chr_fe_write(&s->chr, s->tx_fifo, s->tx_level);
> +
> +    if (ret >= 0) {
> +        s->tx_level -= ret;
> +        memmove(s->tx_fifo, s->tx_fifo + ret, s->tx_level);
> +    }
> +
> +    if (s->tx_level) {
> +        guint r = qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_HUP,
> +                                        ibex_uart_xmit, s);
> +        if (!r) {
> +            s->tx_level = 0;
> +            return FALSE;
> +        }
> +    }
> + 

Zhiwei


