Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EC2C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 17:06:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B531206DA
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 17:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T6LMDAMP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B531206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6dAB-0008GX-C2
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 13:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6d53-0000Je-2v
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 13:01:25 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:43897)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6d50-00058W-HP
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 13:01:24 -0400
Received: by mail-pl1-x642.google.com with SMTP id t10so4432994plz.10
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 10:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=dK/Jbv6Z1WN5kglGdcCFivMd6XzzLV9h7t+tyagGMR0=;
 b=T6LMDAMPIO7Ltfjt3vihOjHqC9pE1E5DRt08ziwvkD8QvHpidjvpKOIm4wopKCau6p
 qdR6e/dJptJv6qcBf6XBH9lZ+HkMUNaou7/1POVNTCQ7tRveyHsDmycP0j4hnp38Heyi
 0qSoMyrhYvPfd77Q8jSQSS5JySdc4hqoIgTW1yLkVEAlGDSf0R2FIjVEjRlJ19l1fjLN
 B3xl9YBV6Gx1u9NWma+16jCEULxgct1z8XL+j1gsPGipw+hHfL+XlHgufa95dq+ZkREN
 s738jCfYPCRLa/sJ7OWsQB50nWXBlpPaBTuI2lnKn21JudWL4hvVXO4oDQk7o7J2LB30
 fa3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dK/Jbv6Z1WN5kglGdcCFivMd6XzzLV9h7t+tyagGMR0=;
 b=IhP5zOHIrmcJuwe5JxtnFh2L+rPB+7nRXdu22Eo5waq+lmmhMfA0dyuagA/t+xaIvK
 8if3buadnkD2xiAGva3Ida44g2Io8WVG3MhisJwhDHIEL2voyAAHlhT/k5JBlRByoV7t
 LbQbtDcFfMn2qUdMUbZC8DbeEeKnu8LInwCqbtJChBQj2cf48Niu9gEOa9HBQCd89mdO
 uRBKBTflAkwmWOHxeOOhcc6g4xguJrn4lpvziAbq8ASfD8blT6mgp00CXZRAfvchjlqq
 3k0Qi+pvf00rhvBFfMwoQN6LJK1TAKX1t0oUDhgERMCXlOK9tD5tskFEpV7Ykt8eSHo8
 EimA==
X-Gm-Message-State: AOAM533C7ALAeSYvCc7X2giX45ymVtqdDXdk4YyH+yFKIpo6HsnEnGtT
 eUBWa9tl5AIvvG/nVSdG46HV+w==
X-Google-Smtp-Source: ABdhPJxORJNNOSM3xn774JDD/8GRVjsPhTs/EH61gHDRZbCT/yEK2skCb4rwuIANSCFa8K79zJn6uw==
X-Received: by 2002:a17:902:ea8c:: with SMTP id
 x12mr2751922plb.60.1597424481321; 
 Fri, 14 Aug 2020 10:01:21 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j13sm9835783pfa.149.2020.08.14.10.01.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 10:01:20 -0700 (PDT)
Subject: Re: [PATCH 7/7] hw/scsi/scsi-disk: Replace magic '512' value by
 BDRV_SECTOR_SIZE
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200814082841.27000-1-f4bug@amsat.org>
 <20200814082841.27000-8-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9a14b897-4e1d-368b-a559-f54f53bc1e96@linaro.org>
Date: Fri, 14 Aug 2020 10:01:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200814082841.27000-8-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/14/20 1:28 AM, Philippe Mathieu-Daudé wrote:
> Use self-explicit definitions instead of magic '512' value.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/scsi/scsi-disk.c | 44 +++++++++++++++++++++++---------------------
>  1 file changed, 23 insertions(+), 21 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


