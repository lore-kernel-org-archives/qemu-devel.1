Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485B8C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 18:09:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F841206B9
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 18:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ppJ0S/tu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F841206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYCrm-0003p1-5l
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 14:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYCpr-0001us-NC
 for qemu-devel@nongnu.org; Mon, 11 May 2020 14:07:27 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:45395)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYCpp-00042l-NA
 for qemu-devel@nongnu.org; Mon, 11 May 2020 14:07:27 -0400
Received: by mail-pl1-x643.google.com with SMTP id u22so4246908plq.12
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 11:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=oAGh1ZXsQm99jnA/576mUtAvj+sISGxBOLGIFcGm+D8=;
 b=ppJ0S/tubQOlM41SEl/DLKk/cwCUAlPn1UyPzMQm3c3ZFblkV5MjHkm4lLIZdANjWz
 mbz9Ct1CQohK5ps7QTHuQeNA8JMft6CldQ/fVP5uGukHuiM2fCJgHSAM73arzscUflTm
 frWYNJN3abHu+0vISC4s5mEG9spWL8kuHVryAPXbEwQbUjZ3n27fHeZqgC+B0VKnlJNV
 yvKMbzxR3of0HCsxkMHq/Sg0zbfZuCjbsVc/zHayw/JcTgnXcGrCHwatV4hqqMQL+0Hu
 2eJxG+D9bWr+ayI4qeqL/wZ9IYYS0ecPkUtad8esgotYIJ2K9nSDu+WB4nEMz5eMU8Ft
 6cjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oAGh1ZXsQm99jnA/576mUtAvj+sISGxBOLGIFcGm+D8=;
 b=g10pRV1DkFMCRdlDlPB1GOZI2wTAs76z+LP7VdVj3coE+8U3mAh7rHNX4lMmV+36SY
 sGm2Otf8BL9U/QrCwuBSeBfAZ5WEeMbOeb2kURHjpiQACP8t4MNztBoVRUdyoDdUPgXS
 kn2IqL21E6jGDHm6/Eaoe8XjGpuECnhaHyyBiOrhLzUFbbDD+YvuC98IUaCCasbJuD83
 mSmuTGmLpXW1BVM4FY5BTlvI/fXOAYGbicMgPgwyr2FR7OMpGk2BTqDZYhCvFgiqxbpW
 Yla3hTz3iWqgfLz6+T+jEukZbuTNSk958sKrHPnhYER3uYGiM2R8h1yKCmFSiVcRM2pm
 pGyA==
X-Gm-Message-State: AGi0PuauCQ5HxuYPa8Bj/hpi/0qgSeM9mPYApZCMbEj5MuoPHaIZiqii
 SM3aziFiahBvLmhz1E5vFfpqZQ==
X-Google-Smtp-Source: APiQypKPlspg7AQrPyhEvi9fbYSw1e4SSI1S9zcSNeiKQtoDv+x/HHjqqKTTBcAgfo8thQaz0k3fBA==
X-Received: by 2002:a17:902:aa86:: with SMTP id
 d6mr16345891plr.87.1589220444260; 
 Mon, 11 May 2020 11:07:24 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id a142sm9824046pfa.6.2020.05.11.11.07.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2020 11:07:23 -0700 (PDT)
Subject: Re: [RFC PATCH 4/8] riscv: Implement payload load interfaces
From: Richard Henderson <richard.henderson@linaro.org>
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, peter.maydell@linaro.org
References: <20200430072139.4602-1-zhiwei_liu@c-sky.com>
 <20200430072139.4602-5-zhiwei_liu@c-sky.com>
 <5a960977-eb88-1fc1-ae45-b10812777e04@linaro.org>
Message-ID: <8bb5eeee-fa86-4deb-ab67-53ea904d3b82@linaro.org>
Date: Mon, 11 May 2020 11:07:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <5a960977-eb88-1fc1-ae45-b10812777e04@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
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
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, wxy194768@alibaba-inc.com,
 wenmeng_zhang@c-sky.com, palmer@dabbelt.com, alistair23@gmail.com,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/11/20 11:03 AM, Richard Henderson wrote:
>> +        if (m->regs[i] != a->regs[i]) {
>> +            fprintf(f, "  X%-2d    : %016" PRIx64 " vs %016" PRIx64 "\n",
>> +                    i, m->regs[i], a->regs[i]);
>> +        }
> 
> riscv doesn't name its registers with an x.

Duh.  It does.  Nevermind this.


r~

