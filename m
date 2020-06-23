Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C34AC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 05:58:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ABEC20771
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 05:58:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ABEC20771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnbxI-0004al-FZ
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 01:58:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jnbwM-0003y6-13
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 01:57:50 -0400
Received: from 2.mo6.mail-out.ovh.net ([46.105.76.65]:38014)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jnbwK-00082w-1s
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 01:57:49 -0400
Received: from player726.ha.ovh.net (unknown [10.108.54.156])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 87C3121A0DB
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 07:57:45 +0200 (CEST)
Received: from kaod.org (lfbn-tou-1-921-245.w86-210.abo.wanadoo.fr
 [86.210.152.245]) (Authenticated sender: clg@kaod.org)
 by player726.ha.ovh.net (Postfix) with ESMTPSA id 7D190138F2664;
 Tue, 23 Jun 2020 05:57:35 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R002c265d183-5378-45d9-b641-288dacc27b36,EED1DA90FC9B795DFFB5AB62ED4F19E3D36D96F8)
 smtp.auth=clg@kaod.org
Subject: Re: [PATCH v5 2/9] hw/misc/pca9552: Rename 'nr_leds' as 'pin_count'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200622183428.12255-1-f4bug@amsat.org>
 <20200622183428.12255-3-f4bug@amsat.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <0462626d-11e4-3975-f54d-57fd86598687@kaod.org>
Date: Tue, 23 Jun 2020 07:57:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200622183428.12255-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11085891958002322352
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudekfedguddtvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepfeffvddtudegieefudeugffhjefgieegieegleettdehgfeiieevueeihfegfefgnecukfhppedtrddtrddtrddtpdekiedrvddutddrudehvddrvdegheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejvdeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=46.105.76.65; envelope-from=clg@kaod.org;
 helo=2.mo6.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 01:57:45
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
> The PCA9552 device does not expose LEDs, but simple pins
> to connnect LEDs to. To be clearer with the device model,
> rename 'nr_leds' as 'pin_count'.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Reviewed-by: Cédric Le Goater <clg@kaod.org>

> ---
>  include/hw/misc/pca9552.h |  2 +-
>  hw/misc/pca9552.c         | 10 +++++-----
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/hw/misc/pca9552.h b/include/hw/misc/pca9552.h
> index ebb43c63fe..bc5ed31087 100644
> --- a/include/hw/misc/pca9552.h
> +++ b/include/hw/misc/pca9552.h
> @@ -26,7 +26,7 @@ typedef struct PCA9552State {
>  
>      uint8_t regs[PCA9552_NR_REGS];
>      uint8_t max_reg;
> -    uint8_t nr_leds;
> +    uint8_t pin_count;
>  } PCA9552State;
>  
>  #endif
> diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
> index cac729e35a..81da757a7e 100644
> --- a/hw/misc/pca9552.c
> +++ b/hw/misc/pca9552.c
> @@ -37,7 +37,7 @@ static void pca9552_update_pin_input(PCA9552State *s)
>  {
>      int i;
>  
> -    for (i = 0; i < s->nr_leds; i++) {
> +    for (i = 0; i < s->pin_count; i++) {
>          uint8_t input_reg = PCA9552_INPUT0 + (i / 8);
>          uint8_t input_shift = (i % 8);
>          uint8_t config = pca9552_pin_get_config(s, i);
> @@ -185,7 +185,7 @@ static void pca9552_get_led(Object *obj, Visitor *v, const char *name,
>          error_setg(errp, "%s: error reading %s", __func__, name);
>          return;
>      }
> -    if (led < 0 || led > s->nr_leds) {
> +    if (led < 0 || led > s->pin_count) {
>          error_setg(errp, "%s invalid led %s", __func__, name);
>          return;
>      }
> @@ -228,7 +228,7 @@ static void pca9552_set_led(Object *obj, Visitor *v, const char *name,
>          error_setg(errp, "%s: error reading %s", __func__, name);
>          return;
>      }
> -    if (led < 0 || led > s->nr_leds) {
> +    if (led < 0 || led > s->pin_count) {
>          error_setg(errp, "%s invalid led %s", __func__, name);
>          return;
>      }
> @@ -291,9 +291,9 @@ static void pca9552_initfn(Object *obj)
>       * PCA955X device
>       */
>      s->max_reg = PCA9552_LS3;
> -    s->nr_leds = 16;
> +    s->pin_count = 16;
>  
> -    for (led = 0; led < s->nr_leds; led++) {
> +    for (led = 0; led < s->pin_count; led++) {
>          char *name;
>  
>          name = g_strdup_printf("led%d", led);
> 


