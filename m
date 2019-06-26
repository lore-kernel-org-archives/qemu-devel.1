Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031F1C48BD3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 18:43:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC16520659
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 18:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OiislaP5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC16520659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgCsr-000535-11
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 14:43:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44276)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hgCff-0001b3-Ei
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 14:29:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hgCfd-00085o-Lk
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 14:29:27 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42649)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hgCfc-00083K-Tu
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 14:29:25 -0400
Received: by mail-wr1-x441.google.com with SMTP id x17so3856344wrl.9
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2019 11:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=qNVygF9Rj5H50lQdbMbn70sxvvH5Ew9VLUG6FLuSh+k=;
 b=OiislaP5QuPVV+thxuZLXJliFIEzYK2y4smv23CGCDsBzEczQkzs67fEXlXx6W4Z1H
 hz4OTlTQqfAYoGMfUpzaU/UNWEJILT+K3VvLg0ohwPZ5UpI4O3XW/6XxfulpA0Fk3GrO
 bHWvNm7GJ9nkhOmpgZqZfsEQY2X1KP2VaY1LvUTxUhwXfoxtenKOsxV5r3UhlLbRoJ4V
 twJ0EEx4VyzU0XmDTz2DkjndAGY/ahR3LQHEEWo7pnUMSRY32TQZ8vEL4aDisokbO1qG
 Zlalr4nWMVEQm6J6MahvvDEV5BV6POYKiwgkeX0p2k89nMFtITiMyJbfsG1dSQPx05/p
 7vIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qNVygF9Rj5H50lQdbMbn70sxvvH5Ew9VLUG6FLuSh+k=;
 b=POrQSh+gWwDNdgthliAOp0BzHm6+eIWxgeM5nt8Jcfb21eko/edXI5xEgzlqyhrqVW
 RifjEXTlfrChuULEJ/OwFKweghfFc/RIKm6F9hz1dOMq4/wv1ezEX487fkGro04FhDzP
 bCato6Cc4pf5nk8gu8mPl0l5uIk+4Obs08GVzUZlG2Q12DKo0N9nsy0OFWb4LfC/OnlH
 UGZfP2g1Rs58UZGuW7NDqxapC5jkyGMbh/9p4TMPls1on7Otg1G6bJ8AkJaZ+fCOku2f
 O+GAX9MsQIuaXfj/VsnEsvggWRnOyRYiDzHptIJ88Vxxb75Pp5j22ubjTkMhdpqfHii3
 RMCQ==
X-Gm-Message-State: APjAAAVvLhJiJYGJ0sCOeY/HsV/HGq+b5Qina3SpX8nZet89RR7EWfJ0
 At+Ux51qQ1u00wvEOCscPCOypg==
X-Google-Smtp-Source: APXvYqxd05kKVsyDnCFkIF7IhB7pAE9BNPi+BTIf/grUjD/kEHipyUoOd8FeSYQuWVmE5CjgYrqr0g==
X-Received: by 2002:a5d:4941:: with SMTP id r1mr4537398wrs.225.1561573762545; 
 Wed, 26 Jun 2019 11:29:22 -0700 (PDT)
Received: from [192.168.2.137] (93-34-153-63.ip50.fastwebnet.it.
 [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id j7sm25686965wru.54.2019.06.26.11.29.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Jun 2019 11:29:22 -0700 (PDT)
To: Stefan Brankovic <stefan.brankovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1560942225-24728-1-git-send-email-stefan.brankovic@rt-rk.com>
 <1560942225-24728-3-git-send-email-stefan.brankovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <d33e4335-94c7-8bff-67c5-48848d48929e@linaro.org>
Date: Wed, 26 Jun 2019 17:34:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1560942225-24728-3-git-send-email-stefan.brankovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH 2/8] target/ppc: Optimize emulation of vsl
 and vsr instructions
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
Cc: david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/19/19 1:03 PM, Stefan Brankovic wrote:
> Optimization of altivec instructions vsl and vsr(Vector Shift Left/Rigt).
> Perform shift operation (left and right respectively) on 128 bit value of
> register vA by value specified in bits 125-127 of register vB. Lowest 3
> bits in each byte element of register vB must be identical or result is
> undefined.
> 
> For vsl instruction, the first step is bits 125-127 of register vB have
> to be saved in variable sh. Then, the highest sh bits of the lower
> doubleword element of register vA are saved in variable shifted,
> in order not to lose those bits when shift operation is performed on
> the lower doubleword element of register vA, which is the next
> step. After shifting the lower doubleword element shift operation
> is performed on higher doubleword element of vA, with replacement of
> the lowest sh bits(that are now 0) with bits saved in shifted.
> 
> For vsr instruction, firstly, the bits 125-127 of register vB have
> to be saved in variable sh. Then, the lowest sh bits of the higher
> doubleword element of register vA are saved in variable shifted,
> in odred not to lose those bits when the shift operation is
> performed on the higher doubleword element of register vA, which is
> the next step. After shifting higher doubleword element, shift operation
> is performed on lower doubleword element of vA, with replacement of
> highest sh bits(that are now 0) with bits saved in shifted.
> 
> Signed-off-by: Stefan Brankovic <stefan.brankovic@rt-rk.com>
> ---
>  target/ppc/helper.h                 |  2 -
>  target/ppc/int_helper.c             | 35 -------------
>  target/ppc/translate/vmx-impl.inc.c | 99 ++++++++++++++++++++++++++++++++++++-
>  3 files changed, 97 insertions(+), 39 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


