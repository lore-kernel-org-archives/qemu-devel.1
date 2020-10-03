Return-Path: <SRS0=be0Y=DK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646D3C41604
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 16:44:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3C2A206DD
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 16:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XX7oKf67"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3C2A206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOkeV-0005Wj-Ou
	for qemu-devel@archiver.kernel.org; Sat, 03 Oct 2020 12:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kOkce-0004G9-Ml
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 12:43:01 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:46486)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kOkcc-0005Gv-9L
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 12:43:00 -0400
Received: by mail-oi1-x241.google.com with SMTP id u126so4415275oif.13
 for <qemu-devel@nongnu.org>; Sat, 03 Oct 2020 09:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Ni8ee3wtztSFtc2ljg2vGC6NqGqqRASoEoVa4fKfims=;
 b=XX7oKf67HyYC6ledhKKzLNUsoz77PzyzZhdKW08hAeucV2Sqy2h4xfbHIEfWQrsQIz
 qMsfuRWrUQIyOIjh/QTVhak2M4g9RnSOiRUy4bR58G6CcfZqLpAyd9azspud4RfCXtDW
 Ge6OCXC7jF5Ld1D557RdOsWob1pUvqH43jCe4rNK3LRmB1ZEN0dgVTB2mP7mMrqBbIQg
 iFMBeB2g6AIhQg16JYESurAq7hjLwOWUAewWcevHnS9X0tN09CAEdqQaxwyzJT/NCrAR
 LNnrBNOvlMkiv4ljALAD7s4MaLfZSpNr/PaO6+PzRW83sEVyq9LLZhePRSnQtDx66a1V
 dCQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ni8ee3wtztSFtc2ljg2vGC6NqGqqRASoEoVa4fKfims=;
 b=enULPPTISLTiEK6X9epb5J9PI9dRk6DYBVcXsFHfp9D7EObQcrBH5N9e+IaYmNJow4
 fpoLsScp6zh9bmNy5Mg7Mcl/1JO2W8emR0fxb4k2KEi1bcA1lfdaqHn5zsWCURH8WDR6
 fLg1+Hq0n8YT59Py6YdnlrRKP8zLwIBp5pB+DK7qHxLv19OHIx6fO6LB5OHsRZSV1faK
 bO8VKaPFRqRialeyxxZZBNbB7IddHjRJONpKtbdGF7q8vWB9ZJT+m3OW2kyza3gWalJa
 G3FG6fWTTLAq9tLXfWQkJBIoBuXIaFXdqKqglgjXKm5WEuqo/pC5yF67YeP/G0bV1vJb
 omTg==
X-Gm-Message-State: AOAM532PZv3qagMQZFzdA8Jb/c1fFhrl0lESXfhNdu7hw7S8GDgAtC2G
 pBTH27R7I0aOTTHy3sPLa2GSAw==
X-Google-Smtp-Source: ABdhPJwwgK4KU1QJeuW2h6Qg9XuafTGBHnuH3omTX7hX+jotaVBOag2AuxIDxKf8nNsmsk2J9KlUnQ==
X-Received: by 2002:aca:31d4:: with SMTP id x203mr1060803oix.168.1601743377203; 
 Sat, 03 Oct 2020 09:42:57 -0700 (PDT)
Received: from [10.10.73.179] (fixed-187-189-51-144.totalplay.net.
 [187.189.51.144])
 by smtp.gmail.com with ESMTPSA id l3sm1377682oth.36.2020.10.03.09.42.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Oct 2020 09:42:56 -0700 (PDT)
Subject: Re: [PATCH v3 2/4] hw/timer/bcm2835: Rename variable holding
 CTRL_STATUS register
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20201002164216.1741110-1-f4bug@amsat.org>
 <20201002164216.1741110-3-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ed65d118-7bd8-4044-ed90-9486d9c4e9eb@linaro.org>
Date: Sat, 3 Oct 2020 11:42:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201002164216.1741110-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.252,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc@lmichel.fr>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/2/20 11:42 AM, Philippe Mathieu-Daudé wrote:
> The variable holding the CTRL_STATUS register is misnamed
> 'status'. Rename it 'ctrl_status' to make it more obvious
> this register is also used to control the peripheral.
> 
> Reviewed-by: Luc Michel <luc.michel@greensocs.com>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  include/hw/timer/bcm2835_systmr.h | 2 +-
>  hw/timer/bcm2835_systmr.c         | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


