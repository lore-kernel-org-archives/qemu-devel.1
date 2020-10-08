Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFEDC433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 20:03:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A85D22226
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 20:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UHtwE803"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A85D22226
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQc8V-0005lG-6X
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 16:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kQc7Q-0005JD-Hv
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 16:02:29 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:38867)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kQc7N-0002fh-HO
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 16:02:28 -0400
Received: by mail-ot1-x342.google.com with SMTP id i12so6772828ota.5
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 13:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=U5JEAx8BvuZvEjT1ZyxRloJ6Mu7LospypgbFlqaCJM8=;
 b=UHtwE803KKUgHlObI02DikFxORqZpFYpkTeu9rbS3En9zXr+Kgpy58Wyi4v/CdqVfZ
 LOIISL5sx+KdM2hCoBk4DkOMDapgdOUQLuUaNVrhCWV95L7hLWqVtMiNl+OSNIxgog1f
 6wq9DICGSVc/SGCaZAHjRIpi6uaydU2ITqaU6mRhwkGGzyM1XsNzvLqn24pczGd1Ub+2
 ICXjAj243/A1SfsrY5/YcfIuhNpn9t7/pprEHbJIrIl/ddsUn6PaiZB0pi3CaZMVzrcR
 KTEmzNAOQnOKPlws671IdO8h2avVQOaS9uBwG4xcWBJmHrDLJNo5IzGvSGDdN/tlZBc9
 gjkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=U5JEAx8BvuZvEjT1ZyxRloJ6Mu7LospypgbFlqaCJM8=;
 b=bS/PG+OF8TwWqStr368tCWeBlw5ubJnmKFJvIY3wWfW/r31aSJrqKyEO/kE8efe41b
 rAKgXNno+AoqovAHsQVQ4Hmw09cB+J4b6s9KOCg9YdZ5ezvt1usng+vkbOLWOseBqFwQ
 4f0j9h9iVyWiof4IFdyW5jnNe7PlJ2RaLGfgAGEkRstuswMYtOxaDj56KS7azFZl3RAO
 zMNdTSn3vmQO+3jP1x007j15X/XV2HQce5hns0LrbffJDTxK3XaBjot+DKu2HM2Xfmbu
 4eynmGs2wLAdLsmLY7vixNbkev7j/zCHyo6RckVnIg952+FlExImNxt7vY6pbH3K+gwB
 o7pA==
X-Gm-Message-State: AOAM5333/l0+Sq2xypRzpqHKXESBzW00PU+hK+gUiAt2MLqSFYaLc/a8
 tqzbNgRyEmHkVcdJkLKNYdnDjQ==
X-Google-Smtp-Source: ABdhPJy52yGRxtOrJkGz/NJsisUQIirru00J1da7AW5XfoxmH6VyrCF1NkiJagjPNagVg7MiIrbcOQ==
X-Received: by 2002:a9d:32a1:: with SMTP id u30mr6310406otb.55.1602187343436; 
 Thu, 08 Oct 2020 13:02:23 -0700 (PDT)
Received: from [172.24.51.127] (168.189-204-159.bestelclientes.com.mx.
 [189.204.159.168])
 by smtp.gmail.com with ESMTPSA id t5sm4569075otl.22.2020.10.08.13.02.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2020 13:02:22 -0700 (PDT)
Subject: Re: [RFC PATCH v3 26/34] Hexagon (target/hexagon) macros referenced
 in instruction semantics
To: Taylor Simpson <tsimpson@quicinc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-27-git-send-email-tsimpson@quicinc.com>
 <75d5275b-76e5-38a5-f9a3-f36d1ee08c74@linaro.org>
 <BYAPR02MB4886F48B7E22A43984D78A13DE0B0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <b77feb32-9170-0c19-8147-5a195a227cca@linaro.org>
 <BYAPR02MB488658CFC0440D56F13F68D0DE0B0@BYAPR02MB4886.namprd02.prod.outlook.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7f0ae43c-97a0-3337-eac7-938a2f244d3d@linaro.org>
Date: Thu, 8 Oct 2020 15:02:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BYAPR02MB488658CFC0440D56F13F68D0DE0B0@BYAPR02MB4886.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.214,
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
Cc: "ale@rev.ng" <ale@rev.ng>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "philmd@redhat.com" <philmd@redhat.com>,
 "laurent@vivier.eu" <laurent@vivier.eu>,
 "aleksandar.m.mail@gmail.com" <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/8/20 1:51 PM, Taylor Simpson wrote:
>> How can it have done without doing the merging by hand.  Which this operation ordering is intended to make unnecessary.
>>
>> I think you're missing the point.
> 
> Sorry I wasn't clear.  We have done the load from memory as it was at the beginning of the packet.  The result of the store is in mem_log_stores in CPUHexagonState.  This code updates the bytes that were loaded with any overlapping bytes from the store that hasn't been committed yet.

Right, so you *are* missing the point.

The point is to *not* do the load earlier, but only probe the memory for
readability so that any exception is recognized before the store commits.

Then, after the store, actually perform the load.  Thus any overlapping bytes
get the values that they should.

Voila, no by-hand merging.

>     67f8:       c0 40 21 1f     1f2140c0 {      v0.uh = vsat(v0.uw,v1.uw)
>     67fc:       00 45 02 a1     a1024500        memb(r2+#0) = r5
>     6800:       02 c0 04 91     9104c002        r2 = memb(r4+#0) }
> 
> The vsat instruction requires a vector context.  If the thread doesn't have a vector context, an exception will be raised.  The OS can provide a context and replay the packet.

Sure.

Is there any per-packet exception priority that would require a fault from the
store to be provided in preference to the fault for the vector context?

Anyway, I'm suggesting ordering the operations within the packet to be one
that's most convenient for us.

>>> store_val = le32_to_cpu(store_val);
>>> load_val = le32_to_cpu(load_val);
>>> <merge bytes>
>>> /* store_val is dead so no need to convert back */
>>> load_val = cpu_to_le32(load_val)
>>
>> There's some misuse of cpu_to_le32 vs le32_to_cpu there (I've never liked
>> those
>> names, but it helps to think about what form the data is already in).
> 
> So, what is the right sequence?

Well, <merge_bytes> wants to operate on a le ordering, so the final load_val
assignment should use le32_to_cpu.  Think about this in terms of units, like
Fahrenheit vs Celsius.

As for the other two, it depends on where the values come from.  Probably they
should be cpu_to_le32, but I can't tell without extra context.


r~

