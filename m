Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBEEC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 05:59:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63B0920771
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 05:59:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63B0920771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnbyB-0005hg-ND
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 01:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jnbxA-0004cF-Ot
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 01:58:40 -0400
Received: from 2.mo2.mail-out.ovh.net ([188.165.53.149]:41750)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jnbx8-0008U5-I2
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 01:58:40 -0400
Received: from player799.ha.ovh.net (unknown [10.110.208.202])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 292301DFB1F
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 07:58:35 +0200 (CEST)
Received: from kaod.org (lfbn-tou-1-921-245.w86-210.abo.wanadoo.fr
 [86.210.152.245]) (Authenticated sender: clg@kaod.org)
 by player799.ha.ovh.net (Postfix) with ESMTPSA id 9B58313A43F92;
 Tue, 23 Jun 2020 05:58:28 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-95G0014e7dd84a-da91-4fde-8b60-5dc7076c7f8b,EED1DA90FC9B795DFFB5AB62ED4F19E3D36D96F8)
 smtp.auth=clg@kaod.org
Subject: Re: [PATCH v5 3/9] hw/misc/pca9552: Rename generic code as pca955x
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200622183428.12255-1-f4bug@amsat.org>
 <20200622183428.12255-4-f4bug@amsat.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <0b507b27-16ee-2e28-1838-7a06c30a1b87@kaod.org>
Date: Tue, 23 Jun 2020 07:58:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200622183428.12255-4-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11099965707912055728
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudekfedguddtvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepfeffvddtudegieefudeugffhjefgieegieegleettdehgfeiieevueeihfegfefgnecukfhppedtrddtrddtrddtpdekiedrvddutddrudehvddrvdegheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejleelrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=188.165.53.149; envelope-from=clg@kaod.org;
 helo=2.mo2.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 01:58:36
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Corey Minyard <cminyard@mvista.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/22/20 8:34 PM, Philippe Mathieu-Daudé wrote:
> Various code from the PCA9552 device model is generic to the
> PCA955X family. We'll split the generic code in a base class
> in the next commit. To ease review, first do a dumb renaming.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Reviewed-by: Cédric Le Goater <clg@kaod.org>


> ---
>  include/hw/misc/pca9552.h | 10 ++---
>  hw/misc/pca9552.c         | 80 +++++++++++++++++++--------------------
>  2 files changed, 45 insertions(+), 45 deletions(-)
> 
> diff --git a/include/hw/misc/pca9552.h b/include/hw/misc/pca9552.h
> index bc5ed31087..db527595a3 100644
> --- a/include/hw/misc/pca9552.h
> +++ b/include/hw/misc/pca9552.h
> @@ -12,11 +12,11 @@
>  #include "hw/i2c/i2c.h"
>  
>  #define TYPE_PCA9552 "pca9552"
> -#define PCA9552(obj) OBJECT_CHECK(PCA9552State, (obj), TYPE_PCA9552)
> +#define PCA955X(obj) OBJECT_CHECK(PCA955xState, (obj), TYPE_PCA9552)
>  
> -#define PCA9552_NR_REGS 10
> +#define PCA955X_NR_REGS 10
>  
> -typedef struct PCA9552State {
> +typedef struct PCA955xState {
>      /*< private >*/
>      I2CSlave i2c;
>      /*< public >*/
> @@ -24,9 +24,9 @@ typedef struct PCA9552State {
>      uint8_t len;
>      uint8_t pointer;
>  
> -    uint8_t regs[PCA9552_NR_REGS];
> +    uint8_t regs[PCA955X_NR_REGS];
>      uint8_t max_reg;
>      uint8_t pin_count;
> -} PCA9552State;
> +} PCA955xState;
>  
>  #endif
> diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
> index 81da757a7e..5681ff3b22 100644
> --- a/hw/misc/pca9552.c
> +++ b/hw/misc/pca9552.c
> @@ -25,7 +25,7 @@
>  
>  static const char *led_state[] = {"on", "off", "pwm0", "pwm1"};
>  
> -static uint8_t pca9552_pin_get_config(PCA9552State *s, int pin)
> +static uint8_t pca955x_pin_get_config(PCA955xState *s, int pin)
>  {
>      uint8_t reg   = PCA9552_LS0 + (pin / 4);
>      uint8_t shift = (pin % 4) << 1;
> @@ -33,14 +33,14 @@ static uint8_t pca9552_pin_get_config(PCA9552State *s, int pin)
>      return extract32(s->regs[reg], shift, 2);
>  }
>  
> -static void pca9552_update_pin_input(PCA9552State *s)
> +static void pca955x_update_pin_input(PCA955xState *s)
>  {
>      int i;
>  
>      for (i = 0; i < s->pin_count; i++) {
>          uint8_t input_reg = PCA9552_INPUT0 + (i / 8);
>          uint8_t input_shift = (i % 8);
> -        uint8_t config = pca9552_pin_get_config(s, i);
> +        uint8_t config = pca955x_pin_get_config(s, i);
>  
>          switch (config) {
>          case PCA9552_LED_ON:
> @@ -58,7 +58,7 @@ static void pca9552_update_pin_input(PCA9552State *s)
>      }
>  }
>  
> -static uint8_t pca9552_read(PCA9552State *s, uint8_t reg)
> +static uint8_t pca955x_read(PCA955xState *s, uint8_t reg)
>  {
>      switch (reg) {
>      case PCA9552_INPUT0:
> @@ -79,7 +79,7 @@ static uint8_t pca9552_read(PCA9552State *s, uint8_t reg)
>      }
>  }
>  
> -static void pca9552_write(PCA9552State *s, uint8_t reg, uint8_t data)
> +static void pca955x_write(PCA955xState *s, uint8_t reg, uint8_t data)
>  {
>      switch (reg) {
>      case PCA9552_PSC0:
> @@ -94,7 +94,7 @@ static void pca9552_write(PCA9552State *s, uint8_t reg, uint8_t data)
>      case PCA9552_LS2:
>      case PCA9552_LS3:
>          s->regs[reg] = data;
> -        pca9552_update_pin_input(s);
> +        pca955x_update_pin_input(s);
>          break;
>  
>      case PCA9552_INPUT0:
> @@ -110,7 +110,7 @@ static void pca9552_write(PCA9552State *s, uint8_t reg, uint8_t data)
>   * after each byte is sent to or received by the device. The index
>   * rollovers to 0 when the maximum register address is reached.
>   */
> -static void pca9552_autoinc(PCA9552State *s)
> +static void pca955x_autoinc(PCA955xState *s)
>  {
>      if (s->pointer != 0xFF && s->pointer & PCA9552_AUTOINC) {
>          uint8_t reg = s->pointer & 0xf;
> @@ -120,12 +120,12 @@ static void pca9552_autoinc(PCA9552State *s)
>      }
>  }
>  
> -static uint8_t pca9552_recv(I2CSlave *i2c)
> +static uint8_t pca955x_recv(I2CSlave *i2c)
>  {
> -    PCA9552State *s = PCA9552(i2c);
> +    PCA955xState *s = PCA955X(i2c);
>      uint8_t ret;
>  
> -    ret = pca9552_read(s, s->pointer & 0xf);
> +    ret = pca955x_read(s, s->pointer & 0xf);
>  
>      /*
>       * From the Specs:
> @@ -143,40 +143,40 @@ static uint8_t pca9552_recv(I2CSlave *i2c)
>                        __func__);
>      }
>  
> -    pca9552_autoinc(s);
> +    pca955x_autoinc(s);
>  
>      return ret;
>  }
>  
> -static int pca9552_send(I2CSlave *i2c, uint8_t data)
> +static int pca955x_send(I2CSlave *i2c, uint8_t data)
>  {
> -    PCA9552State *s = PCA9552(i2c);
> +    PCA955xState *s = PCA955X(i2c);
>  
>      /* First byte sent by is the register address */
>      if (s->len == 0) {
>          s->pointer = data;
>          s->len++;
>      } else {
> -        pca9552_write(s, s->pointer & 0xf, data);
> +        pca955x_write(s, s->pointer & 0xf, data);
>  
> -        pca9552_autoinc(s);
> +        pca955x_autoinc(s);
>      }
>  
>      return 0;
>  }
>  
> -static int pca9552_event(I2CSlave *i2c, enum i2c_event event)
> +static int pca955x_event(I2CSlave *i2c, enum i2c_event event)
>  {
> -    PCA9552State *s = PCA9552(i2c);
> +    PCA955xState *s = PCA955X(i2c);
>  
>      s->len = 0;
>      return 0;
>  }
>  
> -static void pca9552_get_led(Object *obj, Visitor *v, const char *name,
> +static void pca955x_get_led(Object *obj, Visitor *v, const char *name,
>                              void *opaque, Error **errp)
>  {
> -    PCA9552State *s = PCA9552(obj);
> +    PCA955xState *s = PCA955X(obj);
>      int led, rc, reg;
>      uint8_t state;
>  
> @@ -195,7 +195,7 @@ static void pca9552_get_led(Object *obj, Visitor *v, const char *name,
>       * reading the INPUTx reg
>       */
>      reg = PCA9552_LS0 + led / 4;
> -    state = (pca9552_read(s, reg) >> (led % 8)) & 0x3;
> +    state = (pca955x_read(s, reg) >> (led % 8)) & 0x3;
>      visit_type_str(v, name, (char **)&led_state[state], errp);
>  }
>  
> @@ -209,10 +209,10 @@ static inline uint8_t pca955x_ledsel(uint8_t oldval, int led_num, int state)
>                  ((state & 0x3) << (led_num << 1));
>  }
>  
> -static void pca9552_set_led(Object *obj, Visitor *v, const char *name,
> +static void pca955x_set_led(Object *obj, Visitor *v, const char *name,
>                              void *opaque, Error **errp)
>  {
> -    PCA9552State *s = PCA9552(obj);
> +    PCA955xState *s = PCA955X(obj);
>      Error *local_err = NULL;
>      int led, rc, reg, val;
>      uint8_t state;
> @@ -244,9 +244,9 @@ static void pca9552_set_led(Object *obj, Visitor *v, const char *name,
>      }
>  
>      reg = PCA9552_LS0 + led / 4;
> -    val = pca9552_read(s, reg);
> +    val = pca955x_read(s, reg);
>      val = pca955x_ledsel(val, led % 4, state);
> -    pca9552_write(s, reg, val);
> +    pca955x_write(s, reg, val);
>  }
>  
>  static const VMStateDescription pca9552_vmstate = {
> @@ -254,17 +254,17 @@ static const VMStateDescription pca9552_vmstate = {
>      .version_id = 0,
>      .minimum_version_id = 0,
>      .fields = (VMStateField[]) {
> -        VMSTATE_UINT8(len, PCA9552State),
> -        VMSTATE_UINT8(pointer, PCA9552State),
> -        VMSTATE_UINT8_ARRAY(regs, PCA9552State, PCA9552_NR_REGS),
> -        VMSTATE_I2C_SLAVE(i2c, PCA9552State),
> +        VMSTATE_UINT8(len, PCA955xState),
> +        VMSTATE_UINT8(pointer, PCA955xState),
> +        VMSTATE_UINT8_ARRAY(regs, PCA955xState, PCA955X_NR_REGS),
> +        VMSTATE_I2C_SLAVE(i2c, PCA955xState),
>          VMSTATE_END_OF_LIST()
>      }
>  };
>  
>  static void pca9552_reset(DeviceState *dev)
>  {
> -    PCA9552State *s = PCA9552(dev);
> +    PCA955xState *s = PCA955X(dev);
>  
>      s->regs[PCA9552_PSC0] = 0xFF;
>      s->regs[PCA9552_PWM0] = 0x80;
> @@ -275,15 +275,15 @@ static void pca9552_reset(DeviceState *dev)
>      s->regs[PCA9552_LS2] = 0x55;
>      s->regs[PCA9552_LS3] = 0x55;
>  
> -    pca9552_update_pin_input(s);
> +    pca955x_update_pin_input(s);
>  
>      s->pointer = 0xFF;
>      s->len = 0;
>  }
>  
> -static void pca9552_initfn(Object *obj)
> +static void pca955x_initfn(Object *obj)
>  {
> -    PCA9552State *s = PCA9552(obj);
> +    PCA955xState *s = PCA955X(obj);
>      int led;
>  
>      /* If support for the other PCA955X devices are implemented, these
> @@ -297,7 +297,7 @@ static void pca9552_initfn(Object *obj)
>          char *name;
>  
>          name = g_strdup_printf("led%d", led);
> -        object_property_add(obj, name, "bool", pca9552_get_led, pca9552_set_led,
> +        object_property_add(obj, name, "bool", pca955x_get_led, pca955x_set_led,
>                              NULL, NULL);
>          g_free(name);
>      }
> @@ -308,9 +308,9 @@ static void pca9552_class_init(ObjectClass *klass, void *data)
>      DeviceClass *dc = DEVICE_CLASS(klass);
>      I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
>  
> -    k->event = pca9552_event;
> -    k->recv = pca9552_recv;
> -    k->send = pca9552_send;
> +    k->event = pca955x_event;
> +    k->recv = pca955x_recv;
> +    k->send = pca955x_send;
>      dc->reset = pca9552_reset;
>      dc->vmsd = &pca9552_vmstate;
>  }
> @@ -318,14 +318,14 @@ static void pca9552_class_init(ObjectClass *klass, void *data)
>  static const TypeInfo pca9552_info = {
>      .name          = TYPE_PCA9552,
>      .parent        = TYPE_I2C_SLAVE,
> -    .instance_init = pca9552_initfn,
> -    .instance_size = sizeof(PCA9552State),
> +    .instance_init = pca955x_initfn,
> +    .instance_size = sizeof(PCA955xState),
>      .class_init    = pca9552_class_init,
>  };
>  
> -static void pca9552_register_types(void)
> +static void pca955x_register_types(void)
>  {
>      type_register_static(&pca9552_info);
>  }
>  
> -type_init(pca9552_register_types)
> +type_init(pca955x_register_types)
> 


