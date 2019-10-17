Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFEDECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 11:54:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 226F22089C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 11:54:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 226F22089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL4ML-0007qw-AR
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 07:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49933)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iL4Kq-0006rX-Dm
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 07:52:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iL4Ko-00054D-Az
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 07:52:52 -0400
Received: from 7.mo2.mail-out.ovh.net ([188.165.48.182]:48315)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iL4Ko-00053h-1k
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 07:52:50 -0400
Received: from player735.ha.ovh.net (unknown [10.108.54.52])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 9E81B1B0585
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 13:52:47 +0200 (CEST)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: clg@kaod.org)
 by player735.ha.ovh.net (Postfix) with ESMTPSA id 5801BB17DA5A;
 Thu, 17 Oct 2019 11:52:35 +0000 (UTC)
Subject: Re: [PATCH 5/5] aspeed/i2c: Add trace events
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20191016085035.12136-1-clg@kaod.org>
 <20191016085035.12136-6-clg@kaod.org>
 <1e79a3e1-1531-11f8-9306-edfecad9896e@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <ed9652d8-a72b-e2ff-37d7-1e004fa2b3ce@kaod.org>
Date: Thu, 17 Oct 2019 13:52:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <1e79a3e1-1531-11f8-9306-edfecad9896e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 6201175212401920979
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrjeejgdegiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 188.165.48.182
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
Cc: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
 Andrew Jeffery <andrew@aj.id.au>, Eddie James <eajames@linux.vnet.ibm.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello Philippe,

On 17/10/2019 12:22, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi C=C3=A9dric,
>=20
> On 10/16/19 10:50 AM, C=C3=A9dric Le Goater wrote:
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>> =C2=A0 hw/i2c/aspeed_i2c.c | 93 ++++++++++++++++++++++++++++++++++++++=
-------
>> =C2=A0 hw/i2c/trace-events |=C2=A0 9 +++++
>> =C2=A0 2 files changed, 89 insertions(+), 13 deletions(-)
>>
>> diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
>> index 030d9c56be65..2da04a4bff30 100644
>> --- a/hw/i2c/aspeed_i2c.c
>> +++ b/hw/i2c/aspeed_i2c.c
>> @@ -28,6 +28,7 @@
>> =C2=A0 #include "hw/i2c/aspeed_i2c.h"
>> =C2=A0 #include "hw/irq.h"
>> =C2=A0 #include "hw/qdev-properties.h"
>> +#include "trace.h"
>> =C2=A0 =C2=A0 /* I2C Global Register */
>> =C2=A0 @@ -158,6 +159,13 @@ static inline void aspeed_i2c_bus_raise_in=
terrupt(AspeedI2CBus *bus)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AspeedI2CClass *aic =3D ASPEED_I2C_GET_=
CLASS(bus->controller);
>> =C2=A0 +=C2=A0=C2=A0=C2=A0 trace_aspeed_i2c_bus_raise_interrupt(bus->i=
ntr_status,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bus->intr_stat=
us & I2CD_INTR_TX_NAK ? "nak|" : "",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bus->intr_stat=
us & I2CD_INTR_TX_ACK ? "ack|" : "",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bus->intr_stat=
us & I2CD_INTR_RX_DONE ? "done|" : "",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bus->intr_stat=
us & I2CD_INTR_NORMAL_STOP ? "normal|" : "",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bus->intr_stat=
us & I2CD_INTR_ABNORMAL ? "abnormal" : "");
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bus->intr_status &=3D bus->intr_ctrl;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bus->intr_status) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bus->controller=
->intr_status |=3D 1 << bus->id;
>> @@ -170,41 +178,57 @@ static uint64_t aspeed_i2c_bus_read(void *opaque=
, hwaddr offset,
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AspeedI2CBus *bus =3D opaque;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AspeedI2CClass *aic =3D ASPEED_I2C_GET_=
CLASS(bus->controller);
>> +=C2=A0=C2=A0=C2=A0 uint64_t value =3D -1;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (offset) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case I2CD_FUN_CTRL_REG:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return bus->ctrl;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value =3D bus->ctrl;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case I2CD_AC_TIMING_REG1:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return bus->timing[0];
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value =3D bus->timing[0];
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case I2CD_AC_TIMING_REG2:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return bus->timing[1];
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value =3D bus->timing[1];
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case I2CD_INTR_CTRL_REG:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return bus->intr_ctrl;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value =3D bus->intr_ctrl;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case I2CD_INTR_STS_REG:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return bus->intr_status;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value =3D bus->intr_status=
;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case I2CD_POOL_CTRL_REG:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return bus->pool_ctrl;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value =3D bus->pool_ctrl;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case I2CD_BYTE_BUF_REG:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return bus->buf;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value =3D bus->buf;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case I2CD_CMD_REG:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return bus->cmd | (i2c_bus=
_busy(bus->bus) << 16);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value =3D bus->cmd | (i2c_=
bus_busy(bus->bus) << 16);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case I2CD_DMA_ADDR:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!aic->has_d=
ma) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 qemu_log_mask(LOG_GUEST_ERROR, "%s: No DMA support\n",=C2=A0 __fun=
c__);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn -1;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return bus->dma_addr;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value =3D bus->dma_addr;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case I2CD_DMA_LEN:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!aic->has_d=
ma) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 qemu_log_mask(LOG_GUEST_ERROR, "%s: No DMA support\n",=C2=A0 __fun=
c__);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn -1;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return bus->dma_len;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value =3D bus->dma_len;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_log_mask(L=
OG_GUEST_ERROR,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "%s: B=
ad offset 0x%" HWADDR_PRIx "\n", __func__, offset);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value =3D -1;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 trace_aspeed_i2c_bus_read(bus->id, offset, size, v=
alue);
>> +=C2=A0=C2=A0=C2=A0 return value;
>> =C2=A0 }
>> =C2=A0 =C2=A0 static void aspeed_i2c_set_state(AspeedI2CBus *bus, uint=
8_t state)
>> @@ -246,6 +270,9 @@ static int aspeed_i2c_bus_send(AspeedI2CBus *bus, =
uint8_t pool_start)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D pool=
_start; i < I2CD_POOL_TX_COUNT(bus->pool_ctrl); i++) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 uint8_t *pool_base =3D aic->bus_pool_base(bus);
>> =C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 trace_aspeed_i2c_bus_send("BUF", i + 1,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 I2CD_POOL_TX_COUNT(bus->pool_ctrl),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 pool_base[i]);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ret =3D i2c_send(bus->bus, pool_base[i]);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (ret) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> @@ -256,6 +283,7 @@ static int aspeed_i2c_bus_send(AspeedI2CBus *bus, =
uint8_t pool_start)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (bus->dma=
_len) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 uint8_t data;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 aspeed_i2c_dma_read(bus, &data);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tr=
ace_aspeed_i2c_bus_send("DMA", bus->dma_len, bus->dma_len, data);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ret =3D i2c_send(bus->bus, data);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (ret) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> @@ -263,6 +291,7 @@ static int aspeed_i2c_bus_send(AspeedI2CBus *bus, =
uint8_t pool_start)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bus->cmd &=3D ~=
I2CD_TX_DMA_ENABLE;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_aspeed_i2c_bus_send(=
"BYTE", pool_start, 1, bus->buf);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D i2c_sen=
d(bus->bus, bus->buf);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 @@ -281,6 +310,9 @@ static void aspeed_i2c_bus_recv(AspeedI2CBu=
s *bus)
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D=
 0; i < I2CD_POOL_RX_SIZE(bus->pool_ctrl); i++) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 pool_base[i] =3D i2c_recv(bus->bus);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tr=
ace_aspeed_i2c_bus_recv("BUF", i + 1,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 I2CD_POOL_RX_SIZE(bus->pool_ctrl),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 pool_base[i]);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Updat=
e RX count */
>> @@ -294,6 +326,7 @@ static void aspeed_i2c_bus_recv(AspeedI2CBus *bus)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 MemTxResult result;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 data =3D i2c_recv(bus->bus);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tr=
ace_aspeed_i2c_bus_recv("DMA", bus->dma_len, bus->dma_len, data);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 result =3D address_space_write(&s->dram_as, bus->dma_addr,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MEMTXATTRS_UNSPECIFIED, &data, 1);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (result !=3D MEMTX_OK) {
>> @@ -307,6 +340,7 @@ static void aspeed_i2c_bus_recv(AspeedI2CBus *bus)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bus->cmd &=3D ~=
I2CD_RX_DMA_ENABLE;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data =3D i2c_re=
cv(bus->bus);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_aspeed_i2c_bus_recv(=
"BYTE", 1, 1, bus->buf);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bus->buf =3D (d=
ata & I2CD_BYTE_BUF_RX_MASK) << I2CD_BYTE_BUF_RX_SHIFT;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 }
>> @@ -364,6 +398,33 @@ static bool aspeed_i2c_check_sram(AspeedI2CBus *b=
us)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
>> =C2=A0 }
>> =C2=A0 +static void aspeed_i2c_bus_cmd_dump(AspeedI2CBus *bus)
>> +{
>> +=C2=A0=C2=A0=C2=A0 g_autofree char *cmd_flags;
>> +=C2=A0=C2=A0=C2=A0 uint32_t count;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (bus->cmd & (I2CD_RX_BUFF_ENABLE | I2CD_RX_BUFF=
_ENABLE)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 count =3D I2CD_POOL_TX_COU=
NT(bus->pool_ctrl);
>> +=C2=A0=C2=A0=C2=A0 } else if (bus->cmd & (I2CD_RX_DMA_ENABLE | I2CD_R=
X_DMA_ENABLE)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 count =3D bus->dma_len;
>> +=C2=A0=C2=A0=C2=A0 } else { /* BYTE mode */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 count =3D 1;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 cmd_flags =3D g_strdup_printf("%s%s%s%s%s%s%s%s%s"=
,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bus->cmd & I2CD_M_START_CMD ? =
"start|" : "",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bus->cmd & I2CD_RX_DMA_ENABLE =
? "rxdma|" : "",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bus->cmd & I2CD_TX_DMA_ENABLE =
? "txdma|" : "",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bus->cmd & I2CD_RX_BUFF_ENABLE=
 ? "rxbuf|" : "",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bus->cmd & I2CD_TX_BUFF_ENABLE=
 ? "txbuf|" : "",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bus->cmd & I2CD_M_TX_CMD ? "tx=
|" : "",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bus->cmd & I2CD_M_RX_CMD ? "rx=
|" : "",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bus->cmd & I2CD_M_S_RX_CMD_LAS=
T ? "last|" : "",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bus->cmd & I2CD_M_STOP_CMD ? "=
stop" : "");
>> +
>> +=C2=A0=C2=A0=C2=A0 trace_aspeed_i2c_bus_cmd(bus->cmd, cmd_flags, coun=
t, bus->intr_status);
>> +}
>> +
>> =C2=A0 /*
>> =C2=A0=C2=A0 * The state machine needs some refinement. It is only use=
d to track
>> =C2=A0=C2=A0 * invalid STOP commands for the moment.
>> @@ -379,6 +440,10 @@ static void aspeed_i2c_bus_handle_cmd(AspeedI2CBu=
s *bus, uint64_t value)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 +=C2=A0=C2=A0=C2=A0 if (trace_event_get_state_backends(TRACE_AS=
PEED_I2C_BUS_CMD)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aspeed_i2c_bus_cmd_dump(bu=
s);
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bus->cmd & I2CD_M_START_CMD) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint8_t state =3D=
 aspeed_i2c_get_state(bus) & I2CD_MACTIVE ?
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 I2CD_MSTARTR : I2CD_MSTART;
>> @@ -465,6 +530,8 @@ static void aspeed_i2c_bus_write(void *opaque, hwa=
ddr offset,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AspeedI2CClass *aic =3D ASPEED_I2C_GET_=
CLASS(bus->controller);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool handle_rx;
>> =C2=A0 +=C2=A0=C2=A0=C2=A0 trace_aspeed_i2c_bus_write(bus->id, offset,=
 size, value);
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (offset) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case I2CD_FUN_CTRL_REG:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (value & I2C=
D_SLAVE_EN) {
>> diff --git a/hw/i2c/trace-events b/hw/i2c/trace-events
>> index e1c810d5bd08..08db8fa68924 100644
>> --- a/hw/i2c/trace-events
>> +++ b/hw/i2c/trace-events
>> @@ -5,3 +5,12 @@
>> =C2=A0 i2c_event(const char *event, uint8_t address) "%s(addr:0x%02x)"
>> =C2=A0 i2c_send(uint8_t address, uint8_t data) "send(addr:0x%02x) data=
:0x%02x"
>> =C2=A0 i2c_recv(uint8_t address, uint8_t data) "recv(addr:0x%02x) data=
:0x%02x"
>> +
>> +# aspeed_i2c.c
>> +
>> +aspeed_i2c_bus_cmd(uint32_t cmd, const char *cmd_flags, uint32_t coun=
t, uint32_t intr_status) "handling cmd=3D0x%x %s count=3D%d intr=3D0x%x"
>> +aspeed_i2c_bus_raise_interrupt(uint32_t intr_status, const char *str1=
, const char *str2, const char *str3, const char *str4, const char *str5)=
 "handled intr=3D0x%x %s%s%s%s%s"
>=20
> There are various trace backends, your output seems designed only for t=
he "log" backend.
>=20
> Using 'unsigned is_nak, unsigned is_ack, ...' "nak:%u ack:%u ..." would=
 make your event compatible with the other backends (and ease their parsi=
ng).

I am not sure to understand where the incompatibility is.=20
Could you explain more please ?=20

Thanks,

C.=20

>> +aspeed_i2c_bus_read(uint32_t busid, uint64_t offset, unsigned size, u=
int64_t value) "bus[%d]: To 0x%" PRIx64 " of size %u: 0x%" PRIx64
>> +aspeed_i2c_bus_write(uint32_t busid, uint64_t offset, unsigned size, =
uint64_t value) "bus[%d]: To 0x%" PRIx64 " of size %u: 0x%" PRIx64
>> +aspeed_i2c_bus_send(const char *mode, int i, int count, uint8_t byte)=
 "%s send %d/%d 0x%02x"
>> +aspeed_i2c_bus_recv(const char *mode, int i, int count, uint8_t byte)=
 "%s recv %d/%d 0x%02x"
>>


