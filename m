Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F2EC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 05:49:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD78220721
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 05:49:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD78220721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVTzE-0006hz-1B
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 01:49:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51968)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1jVTyX-0006Co-Cb; Mon, 04 May 2020 01:49:09 -0400
Received: from mailout11.t-online.de ([194.25.134.85]:41036)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1jVTyW-0001CP-4I; Mon, 04 May 2020 01:49:08 -0400
Received: from fwd05.aul.t-online.de (fwd05.aul.t-online.de [172.20.27.149])
 by mailout11.t-online.de (Postfix) with SMTP id C36D3421ECC8;
 Mon,  4 May 2020 07:49:03 +0200 (CEST)
Received: from [192.168.211.200]
 (XjjhFZZLghF-c9rmoHf2fx+EMefnVv6b86KKG8Y-E3s6pCFKLxp0oOLUMtoYc1JZ1W@[46.86.59.135])
 by fwd05.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1jVTyQ-0PAFV20; Mon, 4 May 2020 07:49:02 +0200
From: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>
Subject: Re: [RFC PATCH 1/2] audio/mixeng: Fix Clang 'int-conversion' warning
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200503113220.30808-1-f4bug@amsat.org>
 <20200503113220.30808-2-f4bug@amsat.org>
Message-ID: <06aef378-80cf-e24c-d271-58a7670d975d@t-online.de>
Date: Mon, 4 May 2020 07:49:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200503113220.30808-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ID: XjjhFZZLghF-c9rmoHf2fx+EMefnVv6b86KKG8Y-E3s6pCFKLxp0oOLUMtoYc1JZ1W
X-TOI-MSGID: 64880c6e-1779-49f8-8721-2106c0d29683
Received-SPF: none client-ip=194.25.134.85; envelope-from=vr_qemu@t-online.de;
 helo=mailout11.t-online.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 01:49:04
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> Fix by using a 64-bit float for the conversion, before casting
> back to 32-bit float.
>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  audio/mixeng.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/audio/mixeng.c b/audio/mixeng.c
> index 739a500449..9946bfeaec 100644
> --- a/audio/mixeng.c
> +++ b/audio/mixeng.c
> @@ -271,7 +271,7 @@ f_sample *mixeng_clip[2][2][2][3] = {
>  #define CONV_NATURAL_FLOAT(x) (x)
>  #define CLIP_NATURAL_FLOAT(x) (x)
>  #else
> -static const float float_scale = UINT_MAX / 2.f;
> +static const float float_scale = UINT_MAX / 2.;

I would prefer an explicit cast of UINT_MAX to float. This is what we already have in audio/mixeng_template.h in the conf_* and clip_* functions with FLOAT_MIXENG defined. I think similar functions should look similar.

>  #define CONV_NATURAL_FLOAT(x) ((x) * float_scale)
>  
>  #ifdef RECIPROCAL

Please don't forget to fix the RECIPROCAL case.


Btw. the problem was reported here:
https://lists.nongnu.org/archive/html/qemu-devel/2020-03/msg02270.html

With best regards,
Volker


