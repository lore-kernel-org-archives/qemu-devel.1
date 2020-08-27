Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5972DC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 11:15:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F8FC22CF6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 11:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y/nMY+Bp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F8FC22CF6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBFs1-0003GP-8I
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 07:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBFoz-0000Wv-V7
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 07:11:57 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:32931)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBFoy-00009B-Dw
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 07:11:57 -0400
Received: by mail-pf1-x442.google.com with SMTP id u20so3239733pfn.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 04:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=bdzM5DdLA8liq6AhFdEDRbk2jBC0vtPtllwcfjpUt9I=;
 b=y/nMY+BpwqKrY7vMJ7ECvZPyj1u902fYlQdjfB5MNqeJOg8D1z6fhgrsNe+bIJpzka
 zgAiJFkYBknLe0aQckvrfwOX0CafAcc5tLOAJAp3pO3WLz0gNbcYwUr6fnTQdSGlWovo
 SlGwhjltgyE8FAUkXZ9FEU3rNZgIy6rEYe8d5v72ZWvQtgcYBwxfV3SYyoq49TQloMYL
 +F0hQuP3J/qMdeucEtHnUjLmtjErtcdkYbzpWdXhU7gNdDMxQYUShbGOEUmEtZvvQyFj
 ttaA+QPkMQUGkvXFLr7/qoaazT+BfIx/ZlGDWbvjv4Rcb8UwT64S9oPST/N9eGkyBu+d
 KDiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bdzM5DdLA8liq6AhFdEDRbk2jBC0vtPtllwcfjpUt9I=;
 b=B9sCNvAM+x7VUvHXvARysJl0Kji6o4pDRyzlRCmaIozC26LBhyCoUGpdGjRxmKFpHj
 9eoVUAW0hnB2TFNDGuTeLyDPW/SckOKibIYqjc3aFkurvJCY/R7WKIVY86CNoXpfIso2
 QjB7fUqUQppafCxuknV+5CEDJfsJbuxgNhTePDgOCtw0wSBmAW9rBreAaRR6MVkxNi+u
 Ey0ZvW3i8a8YCfaQZlcWh9k/dx/n+3zQuVjx8V/4ujfUd1RSi9rJUc+a052lQEKE2phM
 YE3ukXN7MsVGIaZnynqtBD4CKA9Q+DkvrlPwZ4PPq8SCIlcUhdFPFS8ZS1ymUALdkkM7
 hO6Q==
X-Gm-Message-State: AOAM532mdMUG3Rn2rACl2sU5pAYRogYjthWH0szHNi7AoZxYU1TmB5mk
 v/Fs1pqzSSvEvkGFiVbzH4cqePPZbAgwFQ==
X-Google-Smtp-Source: ABdhPJwJTvuGjqpOuzE3zfa0GezzGJSfND8sawyRg9FbMpZo5T5biB3bIVEh2OYFvY3DswvO8aeEEw==
X-Received: by 2002:a63:ee0d:: with SMTP id e13mr13903793pgi.337.1598526714445; 
 Thu, 27 Aug 2020 04:11:54 -0700 (PDT)
Received: from [192.168.101.174] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id 8sm1810360pjx.14.2020.08.27.04.11.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2020 04:11:53 -0700 (PDT)
Subject: Re: [PATCH 64/77] target/microblaze: Convert mbar to decodetree
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
 <20200825205950.730499-65-richard.henderson@linaro.org>
 <20200827092413.GL2954729@toto>
 <7e242b2a-d582-059c-f282-9e001653b627@linaro.org>
 <20200827100834.GM2954729@toto>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9317325a-de01-50b1-2ab3-8d6d5faf5a9d@linaro.org>
Date: Thu, 27 Aug 2020 04:11:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200827100834.GM2954729@toto>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.782,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/27/20 3:08 AM, Edgar E. Iglesias wrote:
>> Ok.  I assume this follows a write to something like an interrupt controller
>> register?
> 
> yes, kind of. It's a memory store to a device that raises an interrupt as a
> result of that store. The interrupt propagates to the CPU and on real HW if
> the pipeline depth of the core is small, it gets taken within a couple of
> cycles after the barrier completes. In QEMU, that delay can become very long
> if we don't break the TB.

Ok, yeah, same idea.  The data store alters the set of interrupts pending.

> Architecturally, it would be wrong to make such assumptions about the pipeline
> but there's code out there already..

Yes indeed.


r~

