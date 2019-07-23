Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90139C76186
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 18:57:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25B882084D
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 18:57:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25B882084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpzye-0007ph-2V
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 14:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47122)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <balaton@eik.bme.hu>) id 1hpzyS-0007On-Kj
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 14:57:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1hpzyR-0001Su-K9
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 14:57:20 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:61733)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1hpzyR-0001Pl-9s
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 14:57:19 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id E0F4C7456CF;
 Tue, 23 Jul 2019 20:57:00 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C32FD7456C8; Tue, 23 Jul 2019 20:57:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id BD17374569A;
 Tue, 23 Jul 2019 20:57:00 +0200 (CEST)
Date: Tue, 23 Jul 2019 20:57:00 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20190723170104.4327-2-mdroth@linux.vnet.ibm.com>
Message-ID: <alpine.BSF.2.21.9999.1907232053190.44636@zero.eik.bme.hu>
References: <20190723170104.4327-1-mdroth@linux.vnet.ibm.com>
 <20190723170104.4327-2-mdroth@linux.vnet.ibm.com>
User-Agent: Alpine 2.21.9999 (BSF 287 2018-06-16)
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:738:2001:2001::2001
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH 01/36] i2c: Move typedef of
 bitbang_i2c_interface to i2c.h
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 23 Jul 2019, Michael Roth wrote:
> From: BALATON Zoltan <balaton@eik.bme.hu>
>
> Clang 3.4 considers duplicate typedef in ppc4xx_i2c.h and
> bitbang_i2c.h an error even if they are identical. Move it to a common
> place to allow building with this clang version.
>
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> Acked-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> (cherry picked from commit 2b4c1125ac3db2734222ff43c25388a16aca4a99)

This was superseded by d718b7475 later so you may want to look at that=20
instead but for stable branch I'm not sure what are your preferences.

Regards,
BALATON Zoltan

> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> ---
> hw/i2c/bitbang_i2c.h        | 2 --
> include/hw/i2c/i2c.h        | 2 ++
> include/hw/i2c/ppc4xx_i2c.h | 3 ---
> 3 files changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/hw/i2c/bitbang_i2c.h b/hw/i2c/bitbang_i2c.h
> index 3a7126d5de..9443021710 100644
> --- a/hw/i2c/bitbang_i2c.h
> +++ b/hw/i2c/bitbang_i2c.h
> @@ -3,8 +3,6 @@
>
> #include "hw/i2c/i2c.h"
>
> -typedef struct bitbang_i2c_interface bitbang_i2c_interface;
> -
> #define BITBANG_I2C_SDA 0
> #define BITBANG_I2C_SCL 1
>
> diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
> index 5dc166158b..cf4c45a98f 100644
> --- a/include/hw/i2c/i2c.h
> +++ b/include/hw/i2c/i2c.h
> @@ -82,6 +82,8 @@ int i2c_recv(I2CBus *bus);
>
> DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t ad=
dr);
>
> +typedef struct bitbang_i2c_interface bitbang_i2c_interface;
> +
> /* lm832x.c */
> void lm832x_key_event(DeviceState *dev, int key, int state);
>
> diff --git a/include/hw/i2c/ppc4xx_i2c.h b/include/hw/i2c/ppc4xx_i2c.h
> index 0891a9c948..b3450bacf7 100644
> --- a/include/hw/i2c/ppc4xx_i2c.h
> +++ b/include/hw/i2c/ppc4xx_i2c.h
> @@ -31,9 +31,6 @@
> #include "hw/sysbus.h"
> #include "hw/i2c/i2c.h"
>
> -/* from hw/i2c/bitbang_i2c.h */
> -typedef struct bitbang_i2c_interface bitbang_i2c_interface;
> -
> #define TYPE_PPC4xx_I2C "ppc4xx-i2c"
> #define PPC4xx_I2C(obj) OBJECT_CHECK(PPC4xxI2CState, (obj), TYPE_PPC4xx=
_I2C)
>
>
