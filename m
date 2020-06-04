Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5F2C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 03:22:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C408920657
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 03:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HUs3vwLv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C408920657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jggSo-0006rH-WF
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 23:22:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jggSF-0006Rw-Tj
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 23:22:07 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:51937)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jggSE-00086e-KD
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 23:22:07 -0400
Received: by mail-pj1-x1041.google.com with SMTP id ga6so463473pjb.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2020 20:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VXxSav5cOpqzEI+KwX8Pv+0PIsEcC7iEkwgJsnuVLpg=;
 b=HUs3vwLvj1s8QTdldqejJ5sPaq4JyYdSbYMtbE7LBndNgMMfArh+U6YZA6N8+RMs3Z
 /bnFwhHr/wc2I0MWEfPYs2ro9eN1v42IUXi5+VMSHPOpQKa5/vycjkFLsCqiF5YR3GGH
 X+XxyHu1/Skv2n0C1/Aq5OdLedbVZrbq7ShCQKFBdRXEUanZYyrnBZDrhsruBr7ii5JF
 ZAIAPD8UIe72GrKeDew9xbxuEnjwUgACUy/BiAYTOU46T8zlfZv+SV0sgILbhRafPItA
 LzAj6O7cFUgmorG6LTJ5LN3eAeIgOTedmrB//rP/OIbHgJKQMikIdzYKHaNO0T/ksgUn
 DzJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VXxSav5cOpqzEI+KwX8Pv+0PIsEcC7iEkwgJsnuVLpg=;
 b=CqSxL+vll1eiVlu8SAPJcgd+K9IbwWAeauCzRd95mXLhzHtC9wDxqvlUSb/lw3m4v+
 rmm2Wmo/tFVuzopOLfP2Pp1zs76SKS7QxJjW7qAWuNJyxex3qlyUlXGWXJ9Yf3++OnTK
 TBJuYp7UNS+egoY8hlzVzI6Zn+L3kj5IYMn7/6TURTirwKx8+nTblpq+5O+S0NIFpMpc
 e0Mq2tRuZqfkyKJNGK5sypVvFiU+ykVja4YPgMd2ui4pIDWxnYzCi0YSR5ppnwqatZAq
 6i20a1FlhyqKwUoMaLcvGVbJG9A1Id/KtLY7m0i/aEPWQENfH++bCBb8UopxaVg2VF5K
 rbUQ==
X-Gm-Message-State: AOAM532ev5hqJa0g4g0V5ZocvDI6LUyzlyhq5GX/nmdHHTTfUb2Hni12
 +x5l/43qvMZhK3QTGjNZz4BFag==
X-Google-Smtp-Source: ABdhPJxVPIlMxhgyx6eNR/GyphS+z3uvGoApvnmA3Oy6aBZ+dTnFB5q7nQkjvkV6AbOVyf+yEyD+Qw==
X-Received: by 2002:a17:902:6b49:: with SMTP id
 g9mr2813131plt.66.1591240924772; 
 Wed, 03 Jun 2020 20:22:04 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id m15sm2594356pgv.45.2020.06.03.20.22.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2020 20:22:03 -0700 (PDT)
Subject: Re: [PATCH v3] migration/xbzrle: add encoding rate
To: Wei Wang <wei.w.wang@intel.com>
References: <1588208375-19556-1-git-send-email-wei.w.wang@intel.com>
 <CAFXwXrm4R5nxk6ruTJ2kP5dUnF7Qm3TfRRiKVAUDNA1uwYf65w@mail.gmail.com>
 <5ED86344.4020505@intel.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4b9cd244-0d96-d1c8-11ec-b61a6bc2bfaa@linaro.org>
Date: Wed, 3 Jun 2020 20:22:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <5ED86344.4020505@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kevin.tian@intel.com, Juan Quintela <quintela@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 gloryxiao@tencent.com, yi.y.sun@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/3/20 7:58 PM, Wei Wang wrote:
> It is possible that encoded_size==0, but unencoded_size !=0. For example,
> a page is written with the same data that it already has.

That really contains 0 bytes?
Not even the ones that say "same data"?

You certainly have a magical compression algorithm there.
Or bad accounting.

> The encoding_rate is expected to reflect if the page is xbzrle encoding friendly.
> The larger, the more friendly, so 0 might not be a good representation here.
> 
> Maybe, we could change UINT64_MAX above to "~0ULL" to avoid the issue?

~0ull is no different than UINT64_MAX -- indeed, they are *exactly* the same
value -- and is not an exactly representible floating-point value.

If unencoded_size != 0, and (somehow) encoded_size == 0, then

  unencoded_size / encoded_size = Inf

which is indeed the limit of x -> 0, n / x.

Which is *also* printable by %0.2f.

I still contend that the middle if should be removed, and you should print out
whatever's left.  Either NaN or Inf is instructive.  Certainly nothing in the
middle cares about the actual value.


r~

