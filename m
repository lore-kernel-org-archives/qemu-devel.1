Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA19C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 10:33:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 527902081A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 10:33:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 527902081A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jad5O-000488-Cl
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 06:33:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jad4P-0003NJ-AP; Mon, 18 May 2020 06:32:29 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:20995)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jad4O-0002Vs-DL; Mon, 18 May 2020 06:32:29 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 0A12D74633D;
 Mon, 18 May 2020 12:32:27 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id CB4D274632B; Mon, 18 May 2020 12:32:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C9C58746331;
 Mon, 18 May 2020 12:32:26 +0200 (CEST)
Date: Mon, 18 May 2020 12:32:26 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 18/24] display/sm501 display/ati: Fix to realize "i2c-ddc"
In-Reply-To: <20200518050408.4579-19-armbru@redhat.com>
Message-ID: <alpine.BSF.2.22.395.2005181228030.5961@zero.eik.bme.hu>
References: <20200518050408.4579-1-armbru@redhat.com>
 <20200518050408.4579-19-armbru@redhat.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-2031475873-1589797946=:5961"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: berrange@redhat.com, ehabkost@redhat.com,
 Magnus Damm <magnus.damm@gmail.com>, qemu-devel@nongnu.org,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-ppc@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-2031475873-1589797946=:5961
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 18 May 2020, Markus Armbruster wrote:
> sm501_init() and ati_vga_realize() create an "i2c-ddc" device, but
> neglect to realize it.  Affects machines sam460ex, shix, r2d, and
> fulong2e.
>
> I wonder how this ever worked.  If the "device becomes real only on
> realize" thing actually works, then we've always been missing the
> device, yet nobody noticed.

No idea why it worked but guests can read EDID info fine with or without 
this patch, so

Tested-by: BALATON Zoltan <balaton@eik.bme.hu>

Maybe device is created and working after init as it has nothing special 
to do at realize (it doesn't even have a realize method) so all realize 
would do is to link it in qtree?

Regards,
BALATON Zoltan

> Fix by realizing it right away.  Visible in "info qom-tree"; here's
> the change for sam460ex:
>
>     /machine (sam460ex-machine)
>       [...]
>       /unattached (container)
>         [...]
>    -    /device[14] (sii3112)
>    +    /device[14] (i2c-ddc)
>    +    /device[15] (sii3112)
>         [rest of device[*] renumbered...]
>
> Fixes: 4a1f253adb45ac6019971193d5077c4d5d55886a
> Fixes: 4a1f253adb45ac6019971193d5077c4d5d55886a
> Cc: BALATON Zoltan <balaton@eik.bme.hu>
> Cc: qemu-ppc@nongnu.org
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
> hw/display/ati.c   | 1 +
> hw/display/sm501.c | 1 +
> 2 files changed, 2 insertions(+)
>
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index 58ec8291d4..7c2177d7b3 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -929,6 +929,7 @@ static void ati_vga_realize(PCIDevice *dev, Error **errp)
>     bitbang_i2c_init(&s->bbi2c, i2cbus);
>     I2CSlave *i2cddc = I2C_SLAVE(qdev_create(BUS(i2cbus), TYPE_I2CDDC));
>     i2c_set_slave_address(i2cddc, 0x50);
> +    qdev_init_nofail(DEVICE(i2cddc));
>
>     /* mmio register space */
>     memory_region_init_io(&s->mm, OBJECT(s), &ati_mm_ops, s,
> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> index acc692531a..132e75b641 100644
> --- a/hw/display/sm501.c
> +++ b/hw/display/sm501.c
> @@ -1816,6 +1816,7 @@ static void sm501_init(SM501State *s, DeviceState *dev,
>     /* ddc */
>     I2CDDCState *ddc = I2CDDC(qdev_create(BUS(s->i2c_bus), TYPE_I2CDDC));
>     i2c_set_slave_address(I2C_SLAVE(ddc), 0x50);
> +    qdev_init_nofail(DEVICE(ddc));
>
>     /* mmio */
>     memory_region_init(&s->mmio_region, OBJECT(dev), "sm501.mmio", MMIO_SIZE);
>
--3866299591-2031475873-1589797946=:5961--

