Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D6AC606C2
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 16:32:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31AEF21479
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 16:32:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31AEF21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adacore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkWZW-0006Fb-3D
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 12:32:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49370)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <chouteau@adacore.com>) id 1hkWYa-0005mZ-3Q
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 12:32:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chouteau@adacore.com>) id 1hkWYZ-0005kv-1u
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 12:32:00 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:46083
 helo=smtp.eu.adacore.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chouteau@adacore.com>)
 id 1hkWYY-0005bn-QM; Mon, 08 Jul 2019 12:31:58 -0400
Received: from localhost (localhost [127.0.0.1])
 by filtered-smtp.eu.adacore.com (Postfix) with ESMTP id 99B5881388;
 Mon,  8 Jul 2019 18:31:55 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at eu.adacore.com
Received: from smtp.eu.adacore.com ([127.0.0.1])
 by localhost (smtp.eu.adacore.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6L-nMUoHqIIY; Mon,  8 Jul 2019 18:31:55 +0200 (CEST)
Received: from [192.168.0.19] (89-157-139-225.rev.numericable.fr
 [89.157.139.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp.eu.adacore.com (Postfix) with ESMTPSA id 23C4581387;
 Mon,  8 Jul 2019 18:31:55 +0200 (CEST)
To: Bin Meng <bmeng.cn@gmail.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>
References: <1558108285-19571-1-git-send-email-bmeng.cn@gmail.com>
 <1558108285-19571-2-git-send-email-bmeng.cn@gmail.com>
From: Fabien Chouteau <chouteau@adacore.com>
Message-ID: <9338c7b4-6a05-2189-b93d-25cb2bd4dd54@adacore.com>
Date: Mon, 8 Jul 2019 18:31:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1558108285-19571-2-git-send-email-bmeng.cn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 194.98.77.210
Subject: Re: [Qemu-devel] [Qemu-riscv] [PATCH 2/2] riscv: sifive_u: Update
 the plic hart config to support multicore
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Bin,

Thanks for this patch.

I know I am very late to the game but I have a comment here.

On 17/05/2019 17:51, Bin Meng wrote:
> +    /* create PLIC hart topology configuration string */
> +    plic_hart_config_len = (strlen(SIFIVE_U_PLIC_HART_CONFIG) + 1) * smp_cpus;
> +    plic_hart_config = g_malloc0(plic_hart_config_len);
> +    for (i = 0; i < smp_cpus; i++) {
> +        if (i != 0) {
> +            strncat(plic_hart_config, ",", plic_hart_config_len);
> +        }
> +        strncat(plic_hart_config, SIFIVE_U_PLIC_HART_CONFIG,
> +                plic_hart_config_len);
> +        plic_hart_config_len -= (strlen(SIFIVE_U_PLIC_HART_CONFIG) + 1);
> +    }
> +

This will create up to 4 MS PLIC devices. However on the Unleashed FU540 the PLICs are M,MS,MS,MS,MS because of the monitor hart #0.

This means a different memory layout than the real hardware.

For instance address 0x0C00_2080 will be hart #0 S-Mode interrupt enables in QEMU, instead of #1 M-Mode interrupt enables for the real hardware.

To fix this I suggest to change this loop to:

    for (i = 0; i < smp_cpus; i++) {
        if (i != 0) {
            strncat(plic_hart_config, "," SIFIVE_U_PLIC_HART_CONFIG,
                    plic_hart_config_len);
        } else {
            strncat(plic_hart_config, "M", plic_hart_config_len);
        }
        plic_hart_config_len -= (strlen(SIFIVE_U_PLIC_HART_CONFIG) + 1);
    }

This will make hart #0 PLIC in M mode and the others in MS.

What do you think?

Best regards,

