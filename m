Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECEAC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 12:21:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 076EC2074F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 12:21:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 076EC2074F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRwpn-0000rU-27
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 08:21:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kRwnX-000771-Ao; Mon, 12 Oct 2020 08:19:28 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:50915)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kRwnT-0004sy-CL; Mon, 12 Oct 2020 08:19:27 -0400
Received: from [192.168.100.1] ([82.252.141.186]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MT7ip-1kuEUm3xlv-00UXNv; Mon, 12 Oct 2020 14:19:16 +0200
Subject: Re: [PATCH] hw/rtc/twl92230: Silence warnings about missing
 fallthrough statements
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20201001182121.187122-1-thuth@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <7cf3a5f8-f5fe-d299-ea77-e66c91a30c38@vivier.eu>
Date: Mon, 12 Oct 2020 14:19:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201001182121.187122-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:v5lT4ks4I2ehu8tQEI5Rz8VtPZNhg390lvqrZMKvUtdZVdu8ZYQ
 Kb0D+JqqCJrl84kXqNUOjhF+5PrTsrbAmRAH9xoZzT4E1+W2WIFWPbFsVgubVki6tjMMYNL
 z6fEcxF81gC9RzstC/pGfm8vD1q2sW6ILK52Jt6Ow9IojXuV1yK2lyDK9+utlZHnuGRJS9A
 CTDGJS9CF0XvLmiwPjhMA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:v/PJnEeiD1k=:V1kivcpViqlboctEBSQsWK
 aFuCmFpRR8qd94nVq6EANn+lUXf1OQkhWh2mIns7weU3+FZqvyJswaDIlfBu+4nqu/3h6X7NJ
 L/i9uDaKpmX943ZRFskG7+SNqlh8a/G+wxXYYB6dYknzc1zjJJBUH6vAk2YU5bn3Oh1EmZL+V
 l+IzKvyUAd7z7gZct/ed8UMG4+Uuv2e2Q8RVX7cj59EJVpL7blTDmCkeTWbF5KXhUi1P8L39R
 JbLgJwcbIB6aAAdIEWaLKnUSOtBDKKyPzxUybuv8qAwzwpNi/n69MWDS0teDienzxmdzIC9KD
 ANagQDTbgKpwt8nJJZRZJDiCyR9UGQiMGKWfJwvJiM/uOAf6CujuOFrmJB7/W9oKuoMA8vQRR
 +mXlrWOYiIjNEA/SctoLggPgDfpTkifUUH3sDvK4THya6+1rk3Qp93uBhO8p+JgXF39xt254c
 jicU9dmHu5odiI7Sh57MLlO8tpaYpycFRFFhEoEy6W1L/YfZlZiHhDvD7QEHXZo28FVUte6ct
 PWV47cAoOj42UGzoJ6MsoTP8NlN5m3UmmYERdH88A1SPVTx8D6+i+EhPc2z9jQ5VfD5/nEjR8
 iKE6JAEEoJD3qllU2j3aZ3rd5Da9fIPKpj48A2WQ/+4pJcgMlZmkjc6hgJx1bU7/lUdpx6xR+
 FIFH71sCu0GEkGhmx289stkp0KcTRrmE5+u/9YakzGXxVKgyaMPOR9xPTZq0tCsRsxX37DB7y
 9SF2LNxqiVuBYmQfG4qYYd2KWeisYh2CMLplCDUvJCFpdiJz50+aP8n8QUWhg9O12FsyZfmrn
 M6hCMT6tC0L2wLJrkrUzl5TTd1N/8adMm79XdiWMenaEMaoTwBzgobIj9QDC1/L7DmbMvPc
Received-SPF: none client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 08:19:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 01/10/2020 à 20:21, Thomas Huth a écrit :
> When compiling with -Werror=implicit-fallthrough, gcc complains about
> missing fallthrough annotations in this file. Looking at the code,
> the fallthrough is indeed wanted here, but instead of adding the
> annotations, it can be done more efficiently by simply calculating
> the offset with a subtraction instead of increasing a local variable
> one by one.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/rtc/twl92230.c | 50 +++++++++++++++++++++++------------------------
>  1 file changed, 24 insertions(+), 26 deletions(-)
> 
> diff --git a/hw/rtc/twl92230.c b/hw/rtc/twl92230.c
> index f838913b37..499f421932 100644
> --- a/hw/rtc/twl92230.c
> +++ b/hw/rtc/twl92230.c
> @@ -271,37 +271,36 @@ static void menelaus_gpio_set(void *opaque, int line, int level)
>  static uint8_t menelaus_read(void *opaque, uint8_t addr)
>  {
>      MenelausState *s = (MenelausState *) opaque;
> -    int reg = 0;
>  
>      switch (addr) {
>      case MENELAUS_REV:
>          return 0x22;
>  
> -    case MENELAUS_VCORE_CTRL5: reg ++;
> -    case MENELAUS_VCORE_CTRL4: reg ++;
> -    case MENELAUS_VCORE_CTRL3: reg ++;
> -    case MENELAUS_VCORE_CTRL2: reg ++;
> +    case MENELAUS_VCORE_CTRL5:
> +    case MENELAUS_VCORE_CTRL4:
> +    case MENELAUS_VCORE_CTRL3:
> +    case MENELAUS_VCORE_CTRL2:
>      case MENELAUS_VCORE_CTRL1:
> -        return s->vcore[reg];
> +        return s->vcore[addr - MENELAUS_VCORE_CTRL1];
>  
> -    case MENELAUS_DCDC_CTRL3: reg ++;
> -    case MENELAUS_DCDC_CTRL2: reg ++;
> +    case MENELAUS_DCDC_CTRL3:
> +    case MENELAUS_DCDC_CTRL2:
>      case MENELAUS_DCDC_CTRL1:
> -        return s->dcdc[reg];
> -
> -    case MENELAUS_LDO_CTRL8: reg ++;
> -    case MENELAUS_LDO_CTRL7: reg ++;
> -    case MENELAUS_LDO_CTRL6: reg ++;
> -    case MENELAUS_LDO_CTRL5: reg ++;
> -    case MENELAUS_LDO_CTRL4: reg ++;
> -    case MENELAUS_LDO_CTRL3: reg ++;
> -    case MENELAUS_LDO_CTRL2: reg ++;
> +        return s->dcdc[addr - MENELAUS_VCORE_CTRL1];
> +
> +    case MENELAUS_LDO_CTRL8:
> +    case MENELAUS_LDO_CTRL7:
> +    case MENELAUS_LDO_CTRL6:
> +    case MENELAUS_LDO_CTRL5:
> +    case MENELAUS_LDO_CTRL4:
> +    case MENELAUS_LDO_CTRL3:
> +    case MENELAUS_LDO_CTRL2:
>      case MENELAUS_LDO_CTRL1:
> -        return s->ldo[reg];
> +        return s->ldo[addr - MENELAUS_LDO_CTRL1];
>  
> -    case MENELAUS_SLEEP_CTRL2: reg ++;
> +    case MENELAUS_SLEEP_CTRL2:
>      case MENELAUS_SLEEP_CTRL1:
> -        return s->sleep[reg];
> +        return s->sleep[addr - MENELAUS_SLEEP_CTRL1];
>  
>      case MENELAUS_DEVICE_OFF:
>          return 0;
> @@ -395,10 +394,10 @@ static uint8_t menelaus_read(void *opaque, uint8_t addr)
>      case MENELAUS_S2_PULL_DIR:
>          return s->pull[3];
>  
> -    case MENELAUS_MCT_CTRL3: reg ++;
> -    case MENELAUS_MCT_CTRL2: reg ++;
> +    case MENELAUS_MCT_CTRL3:
> +    case MENELAUS_MCT_CTRL2:
>      case MENELAUS_MCT_CTRL1:
> -        return s->mmc_ctrl[reg];
> +        return s->mmc_ctrl[addr - MENELAUS_MCT_CTRL1];
>      case MENELAUS_MCT_PIN_ST:
>          /* TODO: return the real Card Detect */
>          return 0;
> @@ -418,7 +417,6 @@ static void menelaus_write(void *opaque, uint8_t addr, uint8_t value)
>  {
>      MenelausState *s = (MenelausState *) opaque;
>      int line;
> -    int reg = 0;
>      struct tm tm;
>  
>      switch (addr) {
> @@ -496,9 +494,9 @@ static void menelaus_write(void *opaque, uint8_t addr, uint8_t value)
>          s->ldo[7] = value & 3;
>          break;
>  
> -    case MENELAUS_SLEEP_CTRL2: reg ++;
> +    case MENELAUS_SLEEP_CTRL2:
>      case MENELAUS_SLEEP_CTRL1:
> -        s->sleep[reg] = value;
> +        s->sleep[addr - MENELAUS_SLEEP_CTRL1] = value;
>          break;
>  
>      case MENELAUS_DEVICE_OFF:
> 

pplied to my trivial-patches branch.

Thanks,
Laurent

