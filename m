Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2335BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 10:34:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C38F020679
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 10:34:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C38F020679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgQj4-0001Ly-03
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 06:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jgQi2-0000IT-NJ; Wed, 03 Jun 2020 06:33:22 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:50960)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jgQi0-0003vr-G2; Wed, 03 Jun 2020 06:33:22 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.04440919|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.376305-0.000289744-0.623405;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03297; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=6; RT=6; SR=0; TI=SMTPD_---.Hhaq5-7_1591180388; 
Received: from 30.225.208.46(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.Hhaq5-7_1591180388)
 by smtp.aliyun-inc.com(10.147.41.231);
 Wed, 03 Jun 2020 18:33:08 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Subject: Re: [PATCH v5 07/11] hw/char: Initial commit of Ibex UART
To: Alistair Francis <alistair23@gmail.com>
References: <cover.1590704015.git.alistair.francis@wdc.com>
 <73cce2d0edd0d41ba15df403a2096bfa70bf0565.1590704015.git.alistair.francis@wdc.com>
 <cc1a1671-b926-bb31-1ed2-d2920f0faf38@c-sky.com>
 <c9f16143-4e9b-a3a8-ffd3-12d43fd2e343@c-sky.com>
 <CAKmqyKM6rigjbDoFh0bfq8gJXJ=+H+onh=DXjCzhAijMCvR16Q@mail.gmail.com>
Message-ID: <ec0a7545-1793-d1a9-fccf-068496cf1f0a@c-sky.com>
Date: Wed, 3 Jun 2020 18:33:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CAKmqyKM6rigjbDoFh0bfq8gJXJ=+H+onh=DXjCzhAijMCvR16Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 06:33:11
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, UNPARSEABLE_RELAY=0.001,
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>, Bin Meng <bmeng.cn@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020/6/3 1:54, Alistair Francis wrote:
> On Tue, Jun 2, 2020 at 5:28 AM LIU Zhiwei<zhiwei_liu@c-sky.com>  wrote:
>> Hi Alistair,
>>
>> There are still some questions I don't understand.
>>
>> 1. Is the baud rate  or fifo a necessary feature to simulate?
>> As you can see, qemu_chr_fe_write will send the byte as soon as possible.
>> When you want to transmit a byte through WDATA,  you can call
>> qemu_chr_fe_write directly.
> So qemu_chr_fe_write() will send the data straight away. This doesn't
> match what teh hardware does though. So by modelling a FIFO and a
> delay in sending we can better match the hardware.
I see many UARTs have similar features. Does the software really care about
these features? Usually I just want to print something to the terminal 
through UART.
Most simulation in QEMU is for running software, not exactly the details 
of hardware.
For example, we will not simulate the 16x oversamples in this UART.

There is no error here. Personally I  think it is necessary to simulate 
the FIFO and baud rate,
maybe for supporting some backends.

Can someone give a reasonable answer for this question?
>> 2.  The baud rate calculation method is not strictly right.
>> I think when a byte write to FIFO,  char_tx_time * 8 is the correct time
>> to send the byte instead of
>> char_tx_time * 4.
> Do you mind explaining why 8 is correct instead of 4?
Usually write a byte to WDATA will trigger a uart_write_tx_fifo. 
Translate a bit will take
char_tx_time. So it will take char_tx_time * 8 to transmit a byte.
>> 3.  Why add a watch here?
> This is based on the Cadence UART implementation in QEMU (which does
> the same thing). This will trigger a callback when we can write more
> data or when the backend has hung up.
Many other serials do the same thing, like virtio-console and serial. So 
it may be a common
interface here. I will try to understand it(Not yet).

Zhiwei
> Alistair
>
>>> +        s->uart_status |= UART_STATUS_TXEMPTY;
>>> +        s->uart_intr_state |= INTR_STATE_TX_EMPTY;
>>> +        s->uart_intr_state &= ~INTR_STATE_TX_WATERMARK;
>>> +        ibex_uart_update_irqs(s);
>>> +        return FALSE;
>>> +    }
>>> +
>>> +    ret = qemu_chr_fe_write(&s->chr, s->tx_fifo, s->tx_level);
>>> +
>>> +    if (ret >= 0) {
>>> +        s->tx_level -= ret;
>>> +        memmove(s->tx_fifo, s->tx_fifo + ret, s->tx_level);
>>> +    }
>>> +
>>> +    if (s->tx_level) {
>>> +        guint r = qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_HUP,
>>> +                                        ibex_uart_xmit, s);
>>> +        if (!r) {
>>> +            s->tx_level = 0;
>>> +            return FALSE;
>>> +        }
>>> +    }
>>> +
>> Zhiwei
>>
>>


