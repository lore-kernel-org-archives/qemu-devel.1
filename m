Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C33C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 14:13:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3846F20B1F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 14:13:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3846F20B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQXBD-0006O0-CL
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 10:13:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43784 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jQXAT-0005Z6-SJ
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 10:13:02 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jQXAS-0000To-7l
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 10:13:01 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:36962)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jQXAR-0000FY-PZ; Mon, 20 Apr 2020 10:12:59 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id B2ACA74637F;
 Mon, 20 Apr 2020 16:12:46 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 8FF1174637E; Mon, 20 Apr 2020 16:12:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8E6B9745953;
 Mon, 20 Apr 2020 16:12:46 +0200 (CEST)
Date: Mon, 20 Apr 2020 16:12:46 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 1/4] sam460ex: Revert change to SPD memory type for <=
 128 MiB
In-Reply-To: <20200420132826.8879-2-armbru@redhat.com>
Message-ID: <alpine.BSF.2.22.395.2004201604130.29873@zero.eik.bme.hu>
References: <20200420132826.8879-1-armbru@redhat.com>
 <20200420132826.8879-2-armbru@redhat.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-detected-operating-system: by eggs1p.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2001:738:2001:2001::2001
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 20 Apr 2020, Markus Armbruster wrote:
> Requesting 32 or 64 MiB of RAM with the sam460ex machine type produces
> a useless warning:
>
>    qemu-system-ppc: warning: Memory size is too small for SDRAM type, adjusting type

Why is it useless? It lets user know there was a change so it could help 
debugging for example.

> This is because sam460ex_init() asks spd_data_generate() for DDR2,
> which is impossible, so spd_data_generate() corrects it to DDR.

This is correct and intended. The idea is that the board code should not 
need to know about SPD data, all knowledge about that should be in 
spd_data_genereate().

> The warning goes back to commit 08fd99179a "sam460ex: Clean up SPD
> EEPROM creation".  Turns out that commit changed memory type and
> number of banks to
>
>    RAM size    #banks  type    bank size
>     128 MiB         1   DDR2     128 MiB
>      64 MiB         2   DDR       32 MiB
>      32 MiB         1   DDR       32 MiB
>
> from
>
>    RAM size    #banks  type    bank size
>     128 MiB         2   SDR       64 MiB
>      64 MiB         2   SDR       32 MiB
>      32 MiB         2   SDR       16 MiB
>
> Reverting that change also gets rid of the warning.
>
> I doubt physical Sam460ex boards can take SDR or DDR modules, though.

It can't but it can use both DDR and DDR2 (the board can't but the SoC can 
and the firmware is OK with that too). This is what the commit fixed, 
please don't break it. The firmware may be confused if presented with 
different type of SDRAM than DDR or DDR2. Does it still boot and finds 
correct mem size after your change? (I think bdinfo U-Boot command tells 
what it detects.)

Regards,
BALATON Zoltan

> The commit changed SPD contents in other places, too.  So does commit
> fb1b0fcc03 "target/mips: fulong2e: Dynamically generate SPD EEPROM
> data" for machine type fulong2e.  I'm not reverting these changes.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
> hw/ppc/sam460ex.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
> index 898453cf30..856bc0b5a3 100644
> --- a/hw/ppc/sam460ex.c
> +++ b/hw/ppc/sam460ex.c
> @@ -335,7 +335,8 @@ static void sam460ex_init(MachineState *machine)
>     dev = sysbus_create_simple(TYPE_PPC4xx_I2C, 0x4ef600700, uic[0][2]);
>     i2c = PPC4xx_I2C(dev)->bus;
>     /* SPD EEPROM on RAM module */
> -    spd_data = spd_data_generate(DDR2, ram_sizes[0], &err);
> +    spd_data = spd_data_generate(ram_sizes[0] < 256 * MiB ? SDR : DDR2,
> +                                 ram_sizes[0], &err);
>     if (err) {
>         warn_report_err(err);
>     }
>

