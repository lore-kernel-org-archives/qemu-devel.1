Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E129FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 06:03:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B873420738
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 06:03:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B873420738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnc23-0008Ga-Uw
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 02:03:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jnc0i-0007Tj-Ok
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 02:02:20 -0400
Received: from 10.mo177.mail-out.ovh.net ([46.105.73.133]:55209)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jnc0f-0002TY-S4
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 02:02:20 -0400
Received: from player718.ha.ovh.net (unknown [10.108.42.228])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 3E56E137F5D
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 08:02:14 +0200 (CEST)
Received: from kaod.org (lfbn-tou-1-921-245.w86-210.abo.wanadoo.fr
 [86.210.152.245]) (Authenticated sender: clg@kaod.org)
 by player718.ha.ovh.net (Postfix) with ESMTPSA id 7A239138AB2E7;
 Tue, 23 Jun 2020 06:02:06 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-100R0034486c632-3904-46b6-8c07-1d4202dfca1a,EED1DA90FC9B795DFFB5AB62ED4F19E3D36D96F8)
 smtp.auth=clg@kaod.org
Subject: Re: [PATCH v5 4/9] hw/misc/pca9552: Add generic PCA955xClass, parent
 of TYPE_PCA9552
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200622183428.12255-1-f4bug@amsat.org>
 <20200622183428.12255-5-f4bug@amsat.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <dec37e35-1e7c-3730-2bd0-7f2c433940e5@kaod.org>
Date: Tue, 23 Jun 2020 08:02:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200622183428.12255-5-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11161608728304847792
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudekfedguddtgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepveeitdekfeeuffelffeuudfgudejgfegtefgveejvdehffefgefhveelveehfefhnecuffhomhgrihhnpehngihprdgtohhmnecukfhppedtrddtrddtrddtpdekiedrvddutddrudehvddrvdegheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejudekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=46.105.73.133; envelope-from=clg@kaod.org;
 helo=10.mo177.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 02:02:15
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Corey Minyard <cminyard@mvista.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/22/20 8:34 PM, Philippe Mathieu-Daudé wrote:
> Extract the code common to the PCA955x family in PCA955xClass,
> keeping the PCA9552 specific parts into pca9552_class_init().
> Remove the 'TODO' comment added in commit 5141d4158cf.
> 
> Suggested-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

One comment below,


> ---
>  include/hw/misc/pca9552.h |  6 ++--
>  hw/misc/pca9552.c         | 72 ++++++++++++++++++++++++++++++---------
>  2 files changed, 58 insertions(+), 20 deletions(-)
> 
> diff --git a/include/hw/misc/pca9552.h b/include/hw/misc/pca9552.h
> index db527595a3..90843b03b8 100644
> --- a/include/hw/misc/pca9552.h
> +++ b/include/hw/misc/pca9552.h
> @@ -12,9 +12,11 @@
>  #include "hw/i2c/i2c.h"
>  
>  #define TYPE_PCA9552 "pca9552"
> -#define PCA955X(obj) OBJECT_CHECK(PCA955xState, (obj), TYPE_PCA9552)
> +#define TYPE_PCA955X "pca955x"
> +#define PCA955X(obj) OBJECT_CHECK(PCA955xState, (obj), TYPE_PCA955X)
>  
>  #define PCA955X_NR_REGS 10
> +#define PCA955X_PIN_COUNT_MAX 16
>  
>  typedef struct PCA955xState {
>      /*< private >*/
> @@ -25,8 +27,6 @@ typedef struct PCA955xState {
>      uint8_t pointer;
>  
>      uint8_t regs[PCA955X_NR_REGS];
> -    uint8_t max_reg;
> -    uint8_t pin_count;
>  } PCA955xState;
>  
>  #endif
> diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
> index 5681ff3b22..34062dbb69 100644
> --- a/hw/misc/pca9552.c
> +++ b/hw/misc/pca9552.c
> @@ -4,6 +4,7 @@
>   *     https://www.nxp.com/docs/en/application-note/AN264.pdf
>   *
>   * Copyright (c) 2017-2018, IBM Corporation.
> + * Copyright (c) 2020 Philippe Mathieu-Daudé
>   *
>   * This work is licensed under the terms of the GNU GPL, version 2 or
>   * later. See the COPYING file in the top-level directory.
> @@ -18,6 +19,20 @@
>  #include "qapi/error.h"
>  #include "qapi/visitor.h"
>  
> +typedef struct PCA955xClass {
> +    /*< private >*/
> +    I2CSlaveClass parent_class;
> +    /*< public >*/
> +
> +    uint8_t pin_count;
> +    uint8_t max_reg;
> +} PCA955xClass;
> +
> +#define PCA955X_CLASS(klass) \
> +    OBJECT_CLASS_CHECK(PCA955xClass, (klass), TYPE_PCA955X)
> +#define PCA955X_GET_CLASS(obj) \
> +    OBJECT_GET_CLASS(PCA955xClass, (obj), TYPE_PCA955X)
> +
>  #define PCA9552_LED_ON   0x0
>  #define PCA9552_LED_OFF  0x1
>  #define PCA9552_LED_PWM0 0x2
> @@ -35,9 +50,10 @@ static uint8_t pca955x_pin_get_config(PCA955xState *s, int pin)
>  
>  static void pca955x_update_pin_input(PCA955xState *s)
>  {
> +    PCA955xClass *k = PCA955X_GET_CLASS(s);
>      int i;
>  
> -    for (i = 0; i < s->pin_count; i++) {
> +    for (i = 0; i < k->pin_count; i++) {
>          uint8_t input_reg = PCA9552_INPUT0 + (i / 8);
>          uint8_t input_shift = (i % 8);
>          uint8_t config = pca955x_pin_get_config(s, i);
> @@ -112,10 +128,12 @@ static void pca955x_write(PCA955xState *s, uint8_t reg, uint8_t data)
>   */
>  static void pca955x_autoinc(PCA955xState *s)
>  {
> +    PCA955xClass *k = PCA955X_GET_CLASS(s);
> +
>      if (s->pointer != 0xFF && s->pointer & PCA9552_AUTOINC) {
>          uint8_t reg = s->pointer & 0xf;
>  
> -        reg = (reg + 1) % (s->max_reg + 1);
> +        reg = (reg + 1) % (k->max_reg + 1);
>          s->pointer = reg | PCA9552_AUTOINC;
>      }
>  }
> @@ -176,6 +194,7 @@ static int pca955x_event(I2CSlave *i2c, enum i2c_event event)
>  static void pca955x_get_led(Object *obj, Visitor *v, const char *name,
>                              void *opaque, Error **errp)
>  {
> +    PCA955xClass *k = PCA955X_GET_CLASS(obj);
>      PCA955xState *s = PCA955X(obj);
>      int led, rc, reg;
>      uint8_t state;
> @@ -185,7 +204,7 @@ static void pca955x_get_led(Object *obj, Visitor *v, const char *name,
>          error_setg(errp, "%s: error reading %s", __func__, name);
>          return;
>      }
> -    if (led < 0 || led > s->pin_count) {
> +    if (led < 0 || led > k->pin_count) {
>          error_setg(errp, "%s invalid led %s", __func__, name);
>          return;
>      }
> @@ -212,6 +231,7 @@ static inline uint8_t pca955x_ledsel(uint8_t oldval, int led_num, int state)
>  static void pca955x_set_led(Object *obj, Visitor *v, const char *name,
>                              void *opaque, Error **errp)
>  {
> +    PCA955xClass *k = PCA955X_GET_CLASS(obj);
>      PCA955xState *s = PCA955X(obj);
>      Error *local_err = NULL;
>      int led, rc, reg, val;
> @@ -228,7 +248,7 @@ static void pca955x_set_led(Object *obj, Visitor *v, const char *name,
>          error_setg(errp, "%s: error reading %s", __func__, name);
>          return;
>      }
> -    if (led < 0 || led > s->pin_count) {
> +    if (led < 0 || led > k->pin_count) {
>          error_setg(errp, "%s invalid led %s", __func__, name);
>          return;
>      }
> @@ -283,17 +303,10 @@ static void pca9552_reset(DeviceState *dev)
>  
>  static void pca955x_initfn(Object *obj)
>  {
> -    PCA955xState *s = PCA955X(obj);
> +    PCA955xClass *k = PCA955X_GET_CLASS(obj);
>      int led;
>  
> -    /* If support for the other PCA955X devices are implemented, these
> -     * constant values might be part of class structure describing the
> -     * PCA955X device
> -     */
> -    s->max_reg = PCA9552_LS3;
> -    s->pin_count = 16;
> -
> -    for (led = 0; led < s->pin_count; led++) {
> +    for (led = 0; led < k->pin_count; led++) {
>          char *name;
>  
>          name = g_strdup_printf("led%d", led);
> @@ -303,7 +316,14 @@ static void pca955x_initfn(Object *obj)
>      }
>  }
>  
> -static void pca9552_class_init(ObjectClass *klass, void *data)
> +static void pca955x_realize(DeviceState *dev, Error **errp)
> +{
> +    PCA955xClass *k = PCA955X_GET_CLASS(dev);
> +
> +    assert(k->pin_count <= PCA955X_PIN_COUNT_MAX);

This test could be done in the instance_init handler.

Thanks,

C.

> +}
> +
> +static void pca955x_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
>      I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
> @@ -311,20 +331,38 @@ static void pca9552_class_init(ObjectClass *klass, void *data)
>      k->event = pca955x_event;
>      k->recv = pca955x_recv;
>      k->send = pca955x_send;
> +    dc->realize = pca955x_realize;
> +}
> +
> +static const TypeInfo pca955x_info = {
> +    .name          = TYPE_PCA955X,
> +    .parent        = TYPE_I2C_SLAVE,
> +    .instance_init = pca955x_initfn,
> +    .instance_size = sizeof(PCA955xState),
> +    .class_init    = pca955x_class_init,
> +    .abstract      = true,
> +};
> +
> +static void pca9552_class_init(ObjectClass *oc, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +    PCA955xClass *pc = PCA955X_CLASS(oc);
> +
>      dc->reset = pca9552_reset;
>      dc->vmsd = &pca9552_vmstate;
> +    pc->max_reg = PCA9552_LS3;
> +    pc->pin_count = 16;
>  }
>  
>  static const TypeInfo pca9552_info = {
>      .name          = TYPE_PCA9552,
> -    .parent        = TYPE_I2C_SLAVE,
> -    .instance_init = pca955x_initfn,
> -    .instance_size = sizeof(PCA955xState),
> +    .parent        = TYPE_PCA955X,
>      .class_init    = pca9552_class_init,
>  };
>  
>  static void pca955x_register_types(void)
>  {
> +    type_register_static(&pca955x_info);
>      type_register_static(&pca9552_info);
>  }
>  
> 


