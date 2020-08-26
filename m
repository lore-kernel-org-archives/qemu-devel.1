Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49D7C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:26:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D6DD2075E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cIvn6H+i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D6DD2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAxJv-0002rd-GI
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 11:26:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAxJ1-0001zh-A7
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:25:43 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:37255)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAxIy-0005mg-0i
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:25:42 -0400
Received: by mail-pg1-x543.google.com with SMTP id g33so1195736pgb.4
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 08:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4waYJe0Kwi1rHhTedaW66MVROkWuRvspbUf+yEgvRnI=;
 b=cIvn6H+iaOG472awtu0j8bNGDc0FO4JW/66hR7IlJh1iNit1iou3Ydq2xu/A5dwjuP
 1QSZV2YJGpitY3nD8hoqAbs87V/sYfeBVs+Nq5gRraP6O5B2o3zww9QOQjYtt7O4dYLu
 QiyZFDiuvdE4X7VMPATtXpZfZJZdfPbjZTrI5feUR2UReIHYUT0dOKM6XEV3QmxWB9ID
 0CWjFltCnjkQFsFvEoqXGGYh9PbmWN8MyBKm5/5qIRrMrh4vWrmbLYmjh2F9W4hB5jcr
 2my96wFmzWZgsIvXp7x6sMLhT7iJIrwrJRRjAJzSEiHC5y2EeRgb8S5Q54kHWnO7aEGb
 s3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4waYJe0Kwi1rHhTedaW66MVROkWuRvspbUf+yEgvRnI=;
 b=KE4sr4MNAtc4zubVj7E+rvzOiXe7+1AgDmm2AUtpeYMp3qSThGLRblrBwmNtW4ckz7
 ZBCRFMesCTvkWFTwR/JaOeTSdyWo3Zy/wZWLtH9kclB+Vxa4kCGXWy/qQzjTmldaRlu1
 y4Ujv29LwcU3UaYiGHO+4NsLY++lzSofkMH6KQ6KY4ni12BQv5CARURR/y/kplAq5/tE
 txEScf1muVgTW6WUkELyselRfm0ctTeWYk+auHv/0qDvUM6uZSG7KjNpgrK9vlDIwHMa
 BUStH5Tckv5d//hCv8AukElj6UzH0kFFdrPPZaab7R3G0RkQ1ozY0hoBV/4dvXFYwWJY
 Z2qA==
X-Gm-Message-State: AOAM530DeZ5htnliBJNkvEgWY2pYF6dJhPnfPvYTOuwy967JW0GdRuwC
 o6tcmmfgx8na43JHTWECQHiFIQ==
X-Google-Smtp-Source: ABdhPJyC0Jc3hGA7m4kJQmJFiOec1bWU7JqTyNAli9AmTk5aaxxvcf9eDBNlT1xBorqrYbjj5DyUcA==
X-Received: by 2002:a65:588d:: with SMTP id d13mr10289031pgu.296.1598455538359; 
 Wed, 26 Aug 2020 08:25:38 -0700 (PDT)
Received: from [192.168.81.79]
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id y1sm3330426pfp.95.2020.08.26.08.25.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2020 08:25:37 -0700 (PDT)
Subject: Re: [RFC PATCH v3 24/34] Hexagon (target/hexagon) opcode data
 structures
To: Taylor Simpson <tsimpson@quicinc.com>, qemu-devel@nongnu.org
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-25-git-send-email-tsimpson@quicinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <290827a0-6f54-d75a-9576-de7c8e826cd1@linaro.org>
Date: Wed, 26 Aug 2020 08:25:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1597765847-16637-25-git-send-email-tsimpson@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.239,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: ale@rev.ng, riku.voipio@iki.fi, philmd@redhat.com, laurent@vivier.eu,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/18/20 8:50 AM, Taylor Simpson wrote:
> +extern const char *opcode_names[];
> +
> +extern const char *opcode_reginfo[];
> +extern const char *opcode_rregs[];
> +extern const char *opcode_wregs[];

const char * const


> +extern opcode_encoding_t opcode_encodings[XX_LAST_OPCODE];

const.

> +extern size4u_t
> +    opcode_attribs[XX_LAST_OPCODE][(A_ZZ_LASTATTRIB / ATTRIB_WIDTH) + 1];

const.

And using qemu/bitops.h if possible, as discussed earlier vs attribs.h.

> +const char *opcode_short_semantics[] = {
> +#define OPCODE(X)              NULL
> +#include "opcodes_def_generated.h"
> +#undef OPCODE
> +    NULL
> +};
...
> +#define DEF_SHORTCODE(TAG, SHORTCODE) \
> +    opcode_short_semantics[TAG] = #SHORTCODE;
> +#include "shortcode_generated.h"
> +#undef DEF_SHORTCODE

Just initialize opcode_short_semantics with shortcode_generated.h in the first
place.  Then you don't need to create a table of NULL and overwrite at startup.

And you can also make the table constant.

> +    if (p == NULL) {
> +        g_assert_not_reached();
> +        return 0;
> +    }

I prefer assert(p != NULL) to if (test) { abort(); }, where possible.  E.g.
this later one is fine:

> +    if (islower(*p)) {
> +        return 0;
> +    } else if (isupper(*p)) {
> +        return 1;
> +    } else {
> +        g_assert_not_reached();
> +    }


r~

