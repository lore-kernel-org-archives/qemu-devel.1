Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4BBC4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 07:22:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 603F921481
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 07:22:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 603F921481
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNsvQ-0006wr-GV
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 03:22:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1kNsud-0006P3-PG; Thu, 01 Oct 2020 03:21:59 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:59103)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1kNsub-0002xo-8X; Thu, 01 Oct 2020 03:21:59 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.20.2])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 020AC60CD283;
 Thu,  1 Oct 2020 09:21:52 +0200 (CEST)
Received: from kaod.org (37.59.142.103) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Thu, 1 Oct 2020
 09:21:52 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G005aef4187a-d417-48cf-8b9d-dffdaaa9e142,
 2FD1C644E9D11323632A639817FC6AC7C89AF497) smtp.auth=clg@kaod.org
Subject: Re: [PATCH] ssi: Display chip select polarity in monitor 'info qtree'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 <qemu-devel@nongnu.org>
References: <20200927091946.65491-1-f4bug@amsat.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <9b1175fa-9837-f3c9-0931-34965e6db14a@kaod.org>
Date: Thu, 1 Oct 2020 09:21:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200927091946.65491-1-f4bug@amsat.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.103]
X-ClientProxiedBy: DAG2EX2.mxp5.local (172.16.2.12) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: a482203b-b840-4422-a4de-6b8db3bebbbd
X-Ovh-Tracer-Id: 9480077218061781923
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrfeefgdduvdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfhisehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepjeekudeuudevleegudeugeekleffveeludejteffiedvledvgfekueefudehheefnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehfgegsuhhgsegrmhhsrghtrdhorhhg
Received-SPF: pass client-ip=178.32.125.2; envelope-from=clg@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 03:21:53
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.373, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, qemu-arm@nongnu.org,
 Alistair Francis <alistair@alistair23.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/27/20 11:19 AM, Philippe Mathieu-Daudé wrote:
> It is sometime useful to verify a device chip select polarity
> on a SPI bus. Since we have this information available, display
> it in the 'info qtree' monitor output:
> 
>   $ qemu-system-arm -M lm3s6965evb -monitor stdio -S
>   (qemu) info qtree
>   [...]
>   dev: pl022, id ""
>     gpio-out "sysbus-irq" 1
>     mmio 0000000040008000/0000000000001000
>     bus: ssi
>       type SSI
>       dev: ssd0323, id ""
>         gpio-in "" 1
>         gpio-in "ssi-gpio-cs" 1
>         chip select polarity: high           <---
>       dev: ssi-sd, id ""
>         gpio-in "ssi-gpio-cs" 1
>         chip select polarity: low            <---
>         bus: sd-bus
>           type sd-bus
>           dev: sd-card, id ""
>             spec_version = 2 (0x2)
>             drive = "sd0"
>             spi = true
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Tested-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.

  dev: aspeed.spi2-ast2600, id ""
    gpio-out "sysbus-irq" 2
    num-cs = 1 (0x1)
    inject-failure = false
    sdram-base = 0 (0x0)
    mmio 000000001e641000/0000000000000100
    mmio 0000000050000000/0000000010000000
    bus: spi
      type SSI
  dev: aspeed.spi1-ast2600, id ""
    gpio-out "sysbus-irq" 2
    num-cs = 1 (0x1)
    inject-failure = false
    sdram-base = 0 (0x0)
    mmio 000000001e630000/0000000000000100
    mmio 0000000030000000/0000000010000000
    bus: spi
      type SSI
      dev: mx66l1g45g, id ""
        gpio-in "ssi-gpio-cs" 1
        nonvolatile-cfg = 36863 (0x8fff)
        spansion-cr1nv = 0 (0x0)
        spansion-cr2nv = 8 (0x8)
        spansion-cr3nv = 2 (0x2)
        spansion-cr4nv = 16 (0x10)
        drive = "mtd2"
        chip select polarity: low
  dev: aspeed.fmc-ast2600, id ""
    gpio-out "sysbus-irq" 3
    num-cs = 2 (0x2)
    inject-failure = false
    sdram-base = 2147483648 (0x80000000)
    mmio 000000001e620000/0000000000000100
    mmio 0000000020000000/0000000010000000
    bus: spi
      type SSI
      dev: mx66l1g45g, id ""
        gpio-in "ssi-gpio-cs" 1
        nonvolatile-cfg = 36863 (0x8fff)
        spansion-cr1nv = 0 (0x0)
        spansion-cr2nv = 8 (0x8)
        spansion-cr3nv = 2 (0x2)
        spansion-cr4nv = 16 (0x10)
        drive = "mtd1"
        chip select polarity: low
      dev: mx66l1g45g, id ""
        gpio-in "ssi-gpio-cs" 1
        nonvolatile-cfg = 36863 (0x8fff)
        spansion-cr1nv = 0 (0x0)
        spansion-cr2nv = 8 (0x8)
        spansion-cr3nv = 2 (0x2)
        spansion-cr4nv = 16 (0x10)
        drive = "mtd0"
        chip select polarity: low


