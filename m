Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C237C7618F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 17:02:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEB0821848
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 17:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CTGEDdYq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEB0821848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnnJm-0007Tp-70
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 13:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32776)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hnnJa-0006vb-6g
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 13:02:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hnnJY-0002AT-96
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 13:02:02 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:37371)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hnnJY-0002A9-1l
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 13:02:00 -0400
Received: by mail-pf1-x444.google.com with SMTP id 19so11137501pfa.4
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 10:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=pnu460xQxAiYIERzAMiFKv681WeDb35ruEkNbm3N/hc=;
 b=CTGEDdYqRVRCwhCRG3noexccy6vZfAW9L7ibJxl+LzFq7OhL+mjfkpEymQq7e5Z+qF
 Q8hu8KK9Hz7sImuY4pxeUoKpeFOcHXop6xnUndla4Qt8zwyCvaLid0W+dd80twvAMY1p
 C3vaM0MmJ503lFM7adP6bHS8DjHCfkQLhQa0PEJYUmHOgpR3ion5bGxw/62mC57LoOw5
 N75Kqcj6V2wyag8dbIC6s82Me55Cb8LcsVn22z3EGBRTRd/8V4pb7Qw5p9kZI6ov+gsr
 JXgafz5z0FD86m3y3sbOf3UqlwinMtFzKF1662NhpwwEoWCTBciMDs+RUE96bxtDwJiJ
 j1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pnu460xQxAiYIERzAMiFKv681WeDb35ruEkNbm3N/hc=;
 b=inqh0vea6ubj8czCWemluzkZaSo40bM5+uBLt2aitt/CvErkJW650fZ3QLsEm+XiHJ
 SB5lgIOAgqoTf349ikJZcYvW5LjClv8DlzeiWxLZAStmiETPHxUun2ybXKc0R+nYWKEQ
 US2YMX04XHIbe4zoGQF+6Slt6D6eLtct6wJ6UKaMINEyfrorZU8HYQC0Ws1ZQS6ptdZz
 GIIRcoH7BLuTxxB6FLFmbSV9SJEQy7P3zOx4Babu8MBd3shM+VRPD4aART5vjqzVGdrm
 bCbOR5BQZfMEQqBKnPrmKQSufAQTHCRBFElu3JI5IZw1OUodZgSALEU5mYO1h2Jzf9Pq
 9rCw==
X-Gm-Message-State: APjAAAWJJlScVTYk6snZJqKz3gZ0bPjEeH+I0JlzpVaDlYG1K8HFM4YW
 KWlKKn44WPFiE4LdBQRtltp17A==
X-Google-Smtp-Source: APXvYqyuiZkWHiZ1ICbovNSuf7OJ+WYu15T4HtSUtogd+dtAn7yKI5MvBiNl4Sl+AplMsbt9zllJVg==
X-Received: by 2002:a17:90a:8591:: with SMTP id
 m17mr46116523pjn.100.1563382918530; 
 Wed, 17 Jul 2019 10:01:58 -0700 (PDT)
Received: from [192.168.1.11] (97-113-176-6.tukw.qwest.net. [97.113.176.6])
 by smtp.gmail.com with ESMTPSA id a6sm22653413pjs.31.2019.07.17.10.01.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 17 Jul 2019 10:01:57 -0700 (PDT)
To: Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org
References: <20190711223300.6061-1-jan.bobek@gmail.com>
 <20190711223300.6061-10-jan.bobek@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <a4811aac-7da1-7309-80f3-39b9c2803ebd@linaro.org>
Date: Wed, 17 Jul 2019 10:01:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190711223300.6061-10-jan.bobek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: Re: [Qemu-devel] [RISU PATCH v3 09/18] risugen: add --xfeatures
 option for x86
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/11/19 3:32 PM, Jan Bobek wrote:
> The --xfeatures option is modelled after identically-named option to
> RISU itself; it allows the user to specify which vector registers
> should be initialized, so that the test image doesn't try to access
> registers which may not be present at runtime. Note that it is still
> the user's responsibility to filter out the test instructions using
> these registers.
> 
> Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
> ---
>  risugen | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


