Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4D7C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 09:49:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20C66222FC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 09:49:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20C66222FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvIZr-0002wq-DR
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 05:49:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32867)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hvIZS-0002Ks-UC
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 05:49:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hvIZS-0004DB-09
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 05:49:26 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40955)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hvIZR-0004Cf-QZ
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 05:49:25 -0400
Received: by mail-wm1-f67.google.com with SMTP id v19so79338626wmj.5
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 02:49:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gF3DHJ1sbWzML5R6HdwygtRSfxf0TcJep6XqcK+x8wE=;
 b=Zq+F+gmCO11M9Rcu/rYCBeY3W+GbqyWoZfnOjvu6TicwToz0g5lhP2oR0++yhilbt3
 oobdJuTOujrthXYo/2ekxiZQFv76pjBaXoVf5Ho49Sluf5KFbAHp5gSzNUMUtvJ9BEmw
 c2HzLCRVn3KmreTP6GzFkbSOE1DXgZzGZaOLE7ALJH8y6eWIiTIDaxYNoOhMAYqUjjt0
 +1MHxLnylrK0L4X3o47WjavRlDnmP93BMO/PBJTOfPTJ77gMruOojIaxRgCd7TcEX2rX
 1G7qAuLF6w6WhzsY9Vw43ynweOPotZUt0SFXIs12IrAfcM4Wt6bPrySv3QfJmDsM9FrP
 tbMA==
X-Gm-Message-State: APjAAAX2vDxYVH3C0wPrB8mmYx8Q43TAUEmN9oPaY7IqgWrq2PGh9ASj
 nqmBXKeIc+1WQuvEe+CsYaiy/Q==
X-Google-Smtp-Source: APXvYqxkc2B3zS1/Pd0zbkaFzDajMz1ts3IUO58NxbIguF9M/XZ6alecMBSQ+Wipqf6ypyy9ZgT6xw==
X-Received: by 2002:a7b:cd94:: with SMTP id y20mr10222505wmj.94.1565171364869; 
 Wed, 07 Aug 2019 02:49:24 -0700 (PDT)
Received: from [192.168.1.39] (214.red-83-51-160.dynamicip.rima-tde.net.
 [83.51.160.214])
 by smtp.gmail.com with ESMTPSA id k63sm111301671wmb.2.2019.08.07.02.49.23
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Aug 2019 02:49:24 -0700 (PDT)
To: Bin Meng <bmeng.cn@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <1565163924-18621-1-git-send-email-bmeng.cn@gmail.com>
 <1565163924-18621-13-git-send-email-bmeng.cn@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <a55c5de5-abdf-488b-00c4-68aa6deae222@redhat.com>
Date: Wed, 7 Aug 2019 11:49:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1565163924-18621-13-git-send-email-bmeng.cn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH v2 12/28] riscv: sifive_e: prci: Fix a typo
 of hfxosccfg register programming
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

On 8/7/19 9:45 AM, Bin Meng wrote:
> It should use SIFIVE_PRCI_HFXOSCCFG_RDY and SIFIVE_PRCI_HFXOSCCFG_EN
> for hfxosccfg register programming.
> 
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
> 
> Changes in v2: None
> 
>  hw/riscv/sifive_e_prci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/riscv/sifive_e_prci.c b/hw/riscv/sifive_e_prci.c
> index acb914d..c906f11 100644
> --- a/hw/riscv/sifive_e_prci.c
> +++ b/hw/riscv/sifive_e_prci.c
> @@ -89,7 +89,7 @@ static void sifive_prci_init(Object *obj)
>      sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
>  
>      s->hfrosccfg = (SIFIVE_PRCI_HFROSCCFG_RDY | SIFIVE_PRCI_HFROSCCFG_EN);
> -    s->hfxosccfg = (SIFIVE_PRCI_HFROSCCFG_RDY | SIFIVE_PRCI_HFROSCCFG_EN);
> +    s->hfxosccfg = (SIFIVE_PRCI_HFXOSCCFG_RDY | SIFIVE_PRCI_HFXOSCCFG_EN);
>      s->pllcfg = (SIFIVE_PRCI_PLLCFG_REFSEL | SIFIVE_PRCI_PLLCFG_BYPASS |
>                  SIFIVE_PRCI_PLLCFG_LOCK);
>      s->plloutdiv = SIFIVE_PRCI_PLLOUTDIV_DIV1;
> 

