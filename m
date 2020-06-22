Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C54BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 06:26:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1046420B80
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 06:26:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1046420B80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnFuM-0002EC-C8
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 02:26:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jnFtY-0001Io-RQ
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 02:25:30 -0400
Received: from 8.mo179.mail-out.ovh.net ([46.105.75.26]:36134)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jnFtW-0006Xk-Ap
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 02:25:28 -0400
Received: from player761.ha.ovh.net (unknown [10.108.35.240])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id 8FD8316BFCF
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 08:25:15 +0200 (CEST)
Received: from kaod.org (lfbn-tou-1-921-245.w86-210.abo.wanadoo.fr
 [86.210.152.245]) (Authenticated sender: clg@kaod.org)
 by player761.ha.ovh.net (Postfix) with ESMTPSA id 4B3AB13982B4B;
 Mon, 22 Jun 2020 06:25:07 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-95G00126b615f3-24cf-4752-9ec2-ae0a62459b26,D5B34DF2F1998B4AFDB97B5973F1BB92C24DD330)
 smtp.auth=clg@kaod.org
Subject: Re: [PATCH v4 3/8] hw/misc/pca9552: Use the PCA9552_PIN_COUNT
 definition
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200620225854.31160-1-f4bug@amsat.org>
 <20200620225854.31160-4-f4bug@amsat.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <4628bf30-9b56-a470-afc2-f140690cc002@kaod.org>
Date: Mon, 22 Jun 2020 08:25:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200620225854.31160-4-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 5677631757440289707
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudekuddguddttdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepfeffvddtudegieefudeugffhjefgieegieegleettdehgfeiieevueeihfegfefgnecukfhppedtrddtrddtrddtpdekiedrvddutddrudehvddrvdegheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejiedurdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=46.105.75.26; envelope-from=clg@kaod.org;
 helo=8.mo179.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 02:25:16
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Corey Minyard <cminyard@mvista.com>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/21/20 12:58 AM, Philippe Mathieu-Daudé wrote:
> The current code models the PCA9552, but there are comments
> saying the code could be easily adapted for the rest of the
> PCA955x family.
> Since we assume we have at most 16 pins (for the PCA9552),
> add a definition and check the instance doesn't use more than
> this number. This makes the code a bit safer in case other
> PCA955x devices are added.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

I would introduce a PCA9552Class and move nr_leds under the class. 

C. 


> ---
>  hw/misc/pca9552.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
> index cfefb8fce8..b97fc2893c 100644
> --- a/hw/misc/pca9552.c
> +++ b/hw/misc/pca9552.c
> @@ -303,6 +303,17 @@ static void pca9552_initfn(Object *obj)
>      }
>  }
>  
> +static void pca9552_realize(DeviceState *dev, Error **errp)
> +{
> +    PCA9552State *s = PCA9552(dev);
> +
> +    if (s->nr_leds > PCA9552_PIN_COUNT) {
> +        error_setg(errp, "%s invalid led count %u (max: %u)",
> +                   __func__, s->nr_leds, PCA9552_PIN_COUNT);
> +        return;
> +    }
> +}
> +
>  static void pca9552_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -311,6 +322,7 @@ static void pca9552_class_init(ObjectClass *klass, void *data)
>      k->event = pca9552_event;
>      k->recv = pca9552_recv;
>      k->send = pca9552_send;
> +    dc->realize = pca9552_realize;
>      dc->reset = pca9552_reset;
>      dc->vmsd = &pca9552_vmstate;
>  }
> 


