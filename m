Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B422DC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 13:53:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8463022B47
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 13:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AS4tdv/o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8463022B47
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAvsC-0004PC-Sj
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 09:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAvqk-0002lV-J2
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 09:52:26 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:40077)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAvqi-0000ES-S3
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 09:52:26 -0400
Received: by mail-pg1-x543.google.com with SMTP id h12so1056500pgm.7
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 06:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=j2MdWTXrVhnhQ+ibtc2fhVrnWv0Vkniz9grEFn+s5Is=;
 b=AS4tdv/oiEjRoRkw2e2S3zfIQjlIEgExdC0f8aXf+ZjT+LzYBSmM38XKIPS0h4ylvG
 8JM7RLV8lrIMXKlCp02UIU0CvLJ88AU+A5XWnOTVGRZ/O2lDxI9WFX/YInrZpHpYUak4
 /8k9nMVCeLADU4zOlwzzBvvGtMOJQvVkJvEoBb9MTEWL/9NKl4vCrmhTNutiyhhxbtoR
 9h3kfX06WracCj8lErQznO9WSLv5eIfaqHOjtB9fKUwEdhSQdYijU9kHcb3ZTqQa2PHp
 prBxvkLm1UGCtF7I1s4GJHJWQqlLdFi/ATBnr8tQMEmmPVf3aJzDljD8yG3p3ZOI2S3I
 dAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=j2MdWTXrVhnhQ+ibtc2fhVrnWv0Vkniz9grEFn+s5Is=;
 b=UVRXjMEZAww0NGrRzD/Rkuteof+vf9dSgvIVrTTdTEfWV1TvCi6GLuQzMW0lq5JPHE
 RQ5gBn1Y973kMUexCbAE4UbMiQyiS9Qym1kiG9TogEufkLho6cXVrBbmdTD25wUnajGX
 SAfrnwdT8u8lW5JzgTc37jgcrzFVp4d78AQNWPaAdSpZkYBRirefKuwjfHH7eXCR4zC2
 x7gtQeFbzn9Fgy7r8/fEvCnqtoQsPv+HaoSf5D3vTO8rcyzbkcAqv9sBvoqAD+vmhnib
 k8+ibSJLlJmsLgxJIesNw0ReF6uVKCSIv/ohiMGsAq9aD9YiAOaChrITFA7ywvu9+hQ5
 cXMw==
X-Gm-Message-State: AOAM530UiwgV/YscLWDyA1eEepLgSDuZaqowMDjc+5e7wbv8/EienKYX
 l5q4b3J4QrpUvY9/uJCSoAUFXg==
X-Google-Smtp-Source: ABdhPJziOxlqoLabumb43cO1gcJW7IMTH/7RDF0IeZ1ukOc1P1Y25Xjck1Rj5QQk33/vXQTqRzILrQ==
X-Received: by 2002:a63:d34e:: with SMTP id u14mr10276070pgi.122.1598449943091; 
 Wed, 26 Aug 2020 06:52:23 -0700 (PDT)
Received: from [192.168.81.79]
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id u8sm3101266pfm.133.2020.08.26.06.52.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2020 06:52:22 -0700 (PDT)
Subject: Re: [RFC PATCH v3 06/34] Hexagon (disas) disassembler
To: Taylor Simpson <tsimpson@quicinc.com>, qemu-devel@nongnu.org
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-7-git-send-email-tsimpson@quicinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <96c192d2-e0ba-9b80-d3cd-50eadf3dc349@linaro.org>
Date: Wed, 26 Aug 2020 06:52:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1597765847-16637-7-git-send-email-tsimpson@quicinc.com>
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
> +    len = disassemble_hexagon(words, i, buf, PACKET_BUFFER_LEN);
> +    slen = strlen(buf);
> +    if (buf[slen - 1] == '\n') {
> +        buf[slen - 1] = '\0';
> +    }
> +    (*info->fprintf_func)(info->stream, "%s", buf);

Normally our disassemblers print the instruction address; sometimes the raw
bytes (or word) of the instruction.

Looking forward to patch 14 where disassemble_hexagon is defined, I see none of
that.  Indeed, if disassembly fails, we get...

> +    if (decode_this(nwords, words, &pkt)) {
> +        snprint_a_pkt(buf, bufsize, &pkt);
> +        return pkt.encod_pkt_size_in_bytes;
> +    } else {
> +        snprintf(buf, bufsize, "<invalid>");
> +        return 0;
> +    }

... no indication at all what happened or where, just "<invalid>".  That's not
going to make it easy to find problems.


r~

