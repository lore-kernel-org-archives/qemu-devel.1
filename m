Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD8EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 19:59:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8122F2089D
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 19:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8122F2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jleDa-0006Mk-Pe
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 15:59:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1jleCw-0005po-IQ; Wed, 17 Jun 2020 15:58:50 -0400
Received: from mailout05.t-online.de ([194.25.134.82]:40226)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1jleCu-0005Uc-IE; Wed, 17 Jun 2020 15:58:50 -0400
Received: from fwd11.aul.t-online.de (fwd11.aul.t-online.de [172.20.27.152])
 by mailout05.t-online.de (Postfix) with SMTP id 98105426FDF3;
 Wed, 17 Jun 2020 21:58:44 +0200 (CEST)
Received: from [192.168.211.200]
 (GW0OeuZYYhVJX6APqGAH57Z6mFV5Y88xGIuzmj3YOPpydkzSB1AtvQxfsdlG93rgyL@[46.86.62.83])
 by fwd11.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1jleCp-32LOts0; Wed, 17 Jun 2020 21:58:43 +0200
From: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>
Subject: Re: [PATCH] hw/audio/gus: Fix registers 32-bit access
To: Allan Peramaki <aperamak@pp1.inet.fi>, kraxel@redhat.com
References: <20200615201757.16868-1-aperamak@pp1.inet.fi>
Message-ID: <a41528cf-1743-e580-8ec5-32614f4b655f@t-online.de>
Date: Wed, 17 Jun 2020 21:58:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200615201757.16868-1-aperamak@pp1.inet.fi>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ID: GW0OeuZYYhVJX6APqGAH57Z6mFV5Y88xGIuzmj3YOPpydkzSB1AtvQxfsdlG93rgyL
X-TOI-EXPURGATEID: 150726::1592423923-000007DF-BE142479/0/0 CLEAN NORMAL
X-TOI-MSGID: 62dc9bd8-9c10-4fe5-9751-44224bdfc2e2
Received-SPF: none client-ip=194.25.134.82; envelope-from=vr_qemu@t-online.de;
 helo=mailout05.t-online.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 15:58:44
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> Fix audio on software that accesses DRAM above 64k via register peek/poke
> and some cases when more than 16 voices are used.
>
> Fixes: 135f5ae1974c ("audio: GUSsample is int16_t")
> Signed-off-by: Allan Peramaki <aperamak@pp1.inet.fi>
> ---
>  hw/audio/gusemu_hal.c   | 6 +++---
>  hw/audio/gusemu_mixer.c | 8 ++++----
>  2 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/hw/audio/gusemu_hal.c b/hw/audio/gusemu_hal.c
> index ae40ca341c..e35e941926 100644
> --- a/hw/audio/gusemu_hal.c
> +++ b/hw/audio/gusemu_hal.c
> @@ -30,9 +30,9 @@
>  #include "gustate.h"
>  #include "gusemu.h"
>  
> -#define GUSregb(position) (*            (gusptr+(position)))
> -#define GUSregw(position) (*(uint16_t *) (gusptr+(position)))
> -#define GUSregd(position) (*(uint16_t *)(gusptr+(position)))
> +#define GUSregb(position) (*(gusptr + (position)))
> +#define GUSregw(position) (*(uint16_t *)(gusptr + (position)))
> +#define GUSregd(position) (*(uint32_t *)(gusptr + (position)))
>  
>  /* size given in bytes */
>  unsigned int gus_read(GUSEmuState * state, int port, int size)
> diff --git a/hw/audio/gusemu_mixer.c b/hw/audio/gusemu_mixer.c
> index 00b9861b92..3b39254518 100644
> --- a/hw/audio/gusemu_mixer.c
> +++ b/hw/audio/gusemu_mixer.c
> @@ -26,11 +26,11 @@
>  #include "gusemu.h"
>  #include "gustate.h"
>  
> -#define GUSregb(position)  (*            (gusptr+(position)))
> -#define GUSregw(position)  (*(uint16_t *) (gusptr+(position)))
> -#define GUSregd(position)  (*(uint16_t *)(gusptr+(position)))
> +#define GUSregb(position)  (*(gusptr + (position)))
> +#define GUSregw(position)  (*(uint16_t *)(gusptr + (position)))
> +#define GUSregd(position)  (*(uint32_t *)(gusptr + (position)))
>  
> -#define GUSvoice(position) (*(uint16_t *)(voiceptr+(position)))
> +#define GUSvoice(position) (*(uint16_t *)(voiceptr + (position)))
>  
>  /* samples are always 16bit stereo (4 bytes each, first right then left interleaved) */
>  void gus_mixvoices(GUSEmuState * state, unsigned int playback_freq, unsigned int numsamples,

With this patch I can hear the sound effects of DOOM Shareware in a FreeDOS 1.2 guest with a GUS audio device.

Reviewed-by: Volker Rümelin <vr_qemu@t-online.de>

