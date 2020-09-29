Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7A4C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 12:38:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DDE82075F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 12:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzuP1NiX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DDE82075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNEtQ-0003Sv-2V
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 08:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kNEpv-0007oa-Vk
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 08:34:28 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44896)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kNEpu-00088S-9K
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 08:34:27 -0400
Received: by mail-wr1-x442.google.com with SMTP id s12so5160291wrw.11
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 05:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=yngDcTBzkCuQ1f+ETCd/m8NKY53h5+um/hQYqBM3GHI=;
 b=UzuP1NiX7sPiE3DV8Fe8PeD22iUVSq1gNdWsI/PUJqYr5StpszaptVLPMa1RurplNt
 rmGgpgGHTL4xby//AuU3fHXyg26s3yScx5cMexelE9kEhwD14TSaOGLUGM4KfTtucpco
 2Wj2NSBL+QjlOB22ZbmSlw13wUqJGzyAxa9EtWyiyojlzU0aY7SpGAoxCMfT0BMmkhg/
 iuNS1BEgL06iqlMJrwusU7ZtIBWWsTLNnvbYuXB71nDjzo1R7vj+qqsx6byb13Mht4ZG
 TkWF/85bpQQCbqDw/cOyTCtkrm50ngfPARUMw6oU27TKLx3mHpxRB/MUBdYN6qjJubzp
 RnpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yngDcTBzkCuQ1f+ETCd/m8NKY53h5+um/hQYqBM3GHI=;
 b=FH0b2APyJgma/4c8m2F0hm59xiUhzfTkkJjeUnAWikIICcy+AcUqDWZqQzcaN1uFzU
 inpgeUqel/pCauYAeVGwfx+ICOprTOynr1B1cykiINR3ftpiAvNcWB21R4L05pwKTUg2
 O8FMYh0Mvb4LUEU0ZdiiVltev58k8va5SKntCEyiQIkPAntv3QMspQJOnh4k7Epn2c9C
 HlG38zEjZb2u4OFvlAUhF38xOhIt/vl3Tm8NPlTy6/k7U2rDHV2LOMkCXKZd1tgfjGDL
 ci0ZAKgsPrOlgUv2wCsETTc2VU21Vf9INxfWjfImbztPkQBNCyp9K1JjriAMetGhquxK
 qIHA==
X-Gm-Message-State: AOAM532pWyKWMMlCX5Rvb1fzJSm+MGgI8Wfb6d7T4+sH6yWdOPATagqO
 VXsYh5GF8ruoj3484OR5qaY=
X-Google-Smtp-Source: ABdhPJy63Jh+1rqSC6YesyTUKP4troJM6PDYKd0AbUGg4pRbBN5jEzLKP86WBMklIUznrqq/H40lQg==
X-Received: by 2002:adf:aadb:: with SMTP id i27mr4039912wrc.258.1601382864729; 
 Tue, 29 Sep 2020 05:34:24 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id n3sm5425912wmn.28.2020.09.29.05.34.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2020 05:34:24 -0700 (PDT)
Subject: Re: [RFC PATCH v4 22/29] Hexagon (target/hexagon) macros
To: Taylor Simpson <tsimpson@quicinc.com>, qemu-devel@nongnu.org
References: <1601314138-9930-1-git-send-email-tsimpson@quicinc.com>
 <1601314138-9930-23-git-send-email-tsimpson@quicinc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <36baca58-2129-7875-7a58-52454d8f2d0b@amsat.org>
Date: Tue, 29 Sep 2020 14:34:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1601314138-9930-23-git-send-email-tsimpson@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.199, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: ale@rev.ng, riku.voipio@iki.fi, richard.henderson@linaro.org,
 laurent@vivier.eu, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/28/20 7:28 PM, Taylor Simpson wrote:
> macros to interface with the generator
> macros referenced in instruction semantics
> 
> Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>
> ---
>  target/hexagon/macros.h | 654 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 654 insertions(+)
>  create mode 100644 target/hexagon/macros.h
> 
> diff --git a/target/hexagon/macros.h b/target/hexagon/macros.h
> new file mode 100644
> index 0000000..34831d4
> --- /dev/null
> +++ b/target/hexagon/macros.h
> @@ -0,0 +1,654 @@
> +/*
> + *  Copyright(c) 2019-2020 Qualcomm Innovation Center, Inc. All Rights Reserved.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef HEXAGON_MACROS_H
> +#define HEXAGON_MACROS_H
> +
> +#include "qemu/osdep.h"

Please do not include "qemu/osdep.h" in header.

> +#include "qemu/host-utils.h"

"qemu/host-utils.h" doesn't seem used.

> +#include "cpu.h"
> +#include "hex_regs.h"
> +#include "reg_fields.h"
> +
[...]

