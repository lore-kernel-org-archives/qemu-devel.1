Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2674C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 19:22:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BC1F2072F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 19:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="er7uFgUM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BC1F2072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgCUL-0005e7-PS
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 15:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgCTn-0005AR-2v
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 15:21:43 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:46023)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgCTm-0003bU-9I
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 15:21:42 -0400
Received: by mail-pg1-x542.google.com with SMTP id n23so269735pgb.12
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 12:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=M+FoHbEt/7XtXbjEqDCTg555DrlqDz2WQR0KZxbKnyI=;
 b=er7uFgUMehfxZxv9bA/3o+UKv7ZhhmlLtsJoCCbgBPx300JSPv/NToftGRFOty7SHT
 G8dYJaDoRYbDSSF1JHa1vbtw4AWgFXIiDjOu3GjZRrA8yNyqu+5waY465Awk0/Ssq+yl
 F3vTIl3h1Ml4285sBSGsO843TpjHEZPp/tmhs1WrhvlV8S7N0VE8xSXedSMhlg7TJA2E
 zQdZYn0fYrYzvBCDZmsw5O3UneILn/gGO7X39lrpNgphj7Pwr6QVHOLUflZrR2rzoT43
 LdIv/6EYtezopjsFn9SZeQ7CEKfJdjN1KV8wqtvxXnNT95fX3KMwN1C4gffRqIviubjY
 19Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=M+FoHbEt/7XtXbjEqDCTg555DrlqDz2WQR0KZxbKnyI=;
 b=DFIYV5pMKK32U8Zxc4eXyP5tK6N32rZcHr59uaxLC0W0J170wxIXWA6FxGjBd9ZRyg
 MvZXt1FafWSCt03k56u3YLg7Weis7dz1Fpji6A+umCNZtEsaqolxdYkV6f7uctrWE0zQ
 Bt30ny2eUEvH9wKFmfUhYSDFedIOpF04NV3s3wVgHni95Np7FIbzkVCLohuu6Ik5eCHQ
 nvn+AizMi6BVWRlMyJTrm/jmhWiS2m2qldjDlKoy9oE31oBC69RmxWoflT8JA0sRb2Fj
 C2vlUGy8EzIB4EdUDgeYQ5hx9nJdQ6X/htNiVqEkY6sHdVb0Qr4bUsvx6MgyzJYlHfbS
 CG3A==
X-Gm-Message-State: AOAM5310u49EVm/Ed+HVSyl/Ci2Qr0fX4uNF5ORojiSuNWDwkg0hca1o
 9WHjmQMQjIpjQmUAOkq+4qTGUw==
X-Google-Smtp-Source: ABdhPJxU/Qsw6RgLLlKcsGqZprGHHwGKqf10/sDt/sXJPt58murRnzWlkClnqcAoBdb94zMSRm24Zw==
X-Received: by 2002:a62:79d2:: with SMTP id
 u201mr15021668pfc.324.1591125700723; 
 Tue, 02 Jun 2020 12:21:40 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id x11sm2947095pfm.196.2020.06.02.12.21.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jun 2020 12:21:39 -0700 (PDT)
Subject: Re: [PATCH 0/6] target/arm: Convert crypto to gvec
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200514212831.31248-1-richard.henderson@linaro.org>
 <CAFEAcA8y=oF7N2NZCsw818rs__uviQgs7gdrfwC9iA7KvwFZDA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a261a780-1b45-0728-b57f-f22bfdcee3cb@linaro.org>
Date: Tue, 2 Jun 2020 12:21:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8y=oF7N2NZCsw818rs__uviQgs7gdrfwC9iA7KvwFZDA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/2/20 12:16 PM, Peter Maydell wrote:
> On Thu, 14 May 2020 at 22:28, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> In addition, this fixes the missing tail clearing for SVE.
>>
>> The sha1, sha256, sm3 routines that are not fully generalized
>> are not used by sve -- it only supports the newer algorithms.
>>
>> I'm not sure that this:
>>
>> Based-on: <20200508151055.5832-1-richard.henderson@linaro.org>
>> ("tcg vector rotate operations")
>>
>> will be sufficient for patchew, because it also relies on
>> today's target-arm.next merge to master.  But you get the idea.
> 
> Now I've just applied your latest tcg pull, are all the
> prerequisites for this series in master?

Yes.  My branch rebased and rebuilt without incident.


r~

