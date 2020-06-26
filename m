Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF73C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 11:01:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6D8420781
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 11:01:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6D8420781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jom6i-0007JU-1Y
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 07:01:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jom5V-0006H9-Vj; Fri, 26 Jun 2020 07:00:05 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:41047)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jom5T-00068T-G8; Fri, 26 Jun 2020 07:00:05 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 78BA97482D3;
 Fri, 26 Jun 2020 13:00:00 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 580627482CD; Fri, 26 Jun 2020 13:00:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 55AF07475FA;
 Fri, 26 Jun 2020 13:00:00 +0200 (CEST)
Date: Fri, 26 Jun 2020 13:00:00 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [RFC PATCH 2/3] hw/i2c/smbus_eeprom: Add description based on
 child name
In-Reply-To: <20200626102744.15053-3-f4bug@amsat.org>
Message-ID: <alpine.BSF.2.22.395.2006261255120.94870@zero.eik.bme.hu>
References: <20200626102744.15053-1-f4bug@amsat.org>
 <20200626102744.15053-3-f4bug@amsat.org>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-726482454-1593169200=:94870"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 06:21:50
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Corey Minyard <cminyard@mvista.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Markus Armbruster <armbru@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org, Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 qemu-ppc@nongnu.org, =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Huacai Chen <chenhc@lemote.com>,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-726482454-1593169200=:94870
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 26 Jun 2020, Philippe Mathieu-Daudé wrote:
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> hw/i2c/smbus_eeprom.c | 3 +++
> 1 file changed, 3 insertions(+)
>
> diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
> index 879fd7c416..22ba7b20d4 100644
> --- a/hw/i2c/smbus_eeprom.c
> +++ b/hw/i2c/smbus_eeprom.c
> @@ -47,6 +47,7 @@ typedef struct SMBusEEPROMDevice {
>     uint8_t *init_data;
>     uint8_t offset;
>     bool accessed;
> +    char *description;
> } SMBusEEPROMDevice;
>
> static uint8_t eeprom_receive_byte(SMBusDevice *dev)
> @@ -134,7 +135,9 @@ static void smbus_eeprom_realize(DeviceState *dev, Error **errp)
>     smbus_eeprom_reset(dev);
>     if (eeprom->init_data == NULL) {
>         error_setg(errp, "init_data cannot be NULL");
> +        return;
>     }
> +    eeprom->description = object_get_canonical_path_component(OBJECT(dev));
> }
>
> static void smbus_eeprom_class_initfn(ObjectClass *klass, void *data)

What is this for? Shouldn't this description field be in some parent 
object and whatever wants to print it could use the 
object_get_canonical_path_component() as default value if it's not set 
instead of adding more boiler plate to every object?

Regards,
BALATON Zoltan
--3866299591-726482454-1593169200=:94870--

