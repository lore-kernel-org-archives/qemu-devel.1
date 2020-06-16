Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEEBFC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 19:15:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8503720776
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 19:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ni4HzdVE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8503720776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlH34-0001aC-Pm
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 15:15:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlH2M-00014w-R4
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 15:14:22 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:44508)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlH2K-00040h-NM
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 15:14:22 -0400
Received: by mail-pl1-x644.google.com with SMTP id bh7so8805744plb.11
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 12:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=E+uSJAmjqneFK8rKzf6jR9rMRCMZMpc2wWay7eGyotU=;
 b=ni4HzdVEeBiXyWErKo47uW5DHlapQbEcG5efn9DnGljzJ1wPn5VHVP6ArUsY75KBp5
 +/MBmvUjV0HcK1DfWOjPdkle6E2ZxtNG5Z+59mIJ1ZYz/ZINgaBVDxLtVQN0P/kuWvrm
 Qz2DazpWxq5XtTnqYps+5lSCbdZnNB1AW8FrZ+L6fv2NTtEqpujfxfK2pguBuEz7y0hM
 3iEGDYgBRKtJpC1xAuafvJqe93ZvVsnLghMf7YK9JaaXgZbTrb59nu14nM/Xju4spn4E
 rKmk1PK5fKXr/00CHX4C6pKvaU7oCbEwcS6aEPjM/cgRW+0ahDaEZwPDBi6KkJkXncr8
 WynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=E+uSJAmjqneFK8rKzf6jR9rMRCMZMpc2wWay7eGyotU=;
 b=lxTXmMO6zhV8IFuq6uiMb/n5alOuygHmWseyKDrpiAi4G+aORxYBIt3Qyv4sk5hNnt
 ID+KnkLiv0Q+Z7Q/gQYJ2pLFYgnqU5FRv1VBTh5Mk/x+gSQ3laUHuk7pQl8glQTEQzQ/
 7JiOGskulAGU+VwwKUvGicUpbsC+OhBTBqm3LdpVV/ucUJ3E8gQmM8fD56/Nx4KGeT7E
 UfL9q2wUAfX7ImqDV/eBjVzSAgwplaIG0QpSMrFWgNxTHqrbVrqd4CSoosXdivXPG9fK
 pMFWqt567ClGfmoItdZRI3g3EWhcpUlE8v1GsXa/uf+9moz27TGxdKCUiVVtWZWDKNNN
 rp6g==
X-Gm-Message-State: AOAM532dwgGoprszxkXC8SJNE4rmWnltJ7Uc7ASpNU8Izv+88ykDlb7X
 Sgg2l5a1MDOg6MVDhGct+3TDCw==
X-Google-Smtp-Source: ABdhPJwv16ChbxKLvqT/iaLjrK3XTWUMJDS0vmrjNaifd/aX2fq/4wnGfpTyMn2uanOJaVPluLPJ+A==
X-Received: by 2002:a17:90a:db16:: with SMTP id
 g22mr3927082pjv.26.1592334858835; 
 Tue, 16 Jun 2020 12:14:18 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id i12sm18235596pfk.180.2020.06.16.12.14.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2020 12:14:18 -0700 (PDT)
Subject: Re: [PATCH v2] target/arm: Implement SVE2 fp convert precision
To: Stephen Long <steplong@quicinc.com>, qemu-devel@nongnu.org
References: <20200430132813.7750-1-steplong@quicinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <329e48d1-f1ef-b73e-24ed-f4dc90f414e9@linaro.org>
Date: Tue, 16 Jun 2020 12:14:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200430132813.7750-1-steplong@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/30/20 6:28 AM, Stephen Long wrote:
> Implements FCVTLT, FCVTX, FCVTNT, FCVTXNT
> 
> Signed-off-by: Stephen Long <steplong@quicinc.com>
> ---
> 
> Fixed a compilation error and collapsed the translation functions with a
> macro.
> 
>> Ignore my previous patchset. I missed the insn FCVTX and I ended up
>> squashing those commits into this one. At the moment, I'm working on a
>> patch for the SVE2 bitwise shift by imm insns.

Having missed this just a minute ago, I squashed FCVTX into the adjusted v1
patch for FCVTXNT, using do_frint_mode.


r~

