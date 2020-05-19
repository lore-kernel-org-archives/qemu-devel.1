Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E44CC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 14:56:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34944204EF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 14:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QIgopq74"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34944204EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb3fr-0002YY-1P
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 10:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb3b8-0004Sr-9j
 for qemu-devel@nongnu.org; Tue, 19 May 2020 10:52:02 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430]:42249)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb3b7-0002ul-4U
 for qemu-devel@nongnu.org; Tue, 19 May 2020 10:52:01 -0400
Received: by mail-pf1-x430.google.com with SMTP id y18so3593pfl.9
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 07:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=uCuwUN641w7FMV6oZtDjYFL14mnyofEsSTqbFVKRVnE=;
 b=QIgopq74gWfwo/pcTlYeTWjTUqmHG0zAV+V9YjlXf8zi34VxS65UOOuo/XC2hj5m1L
 lC+bdj8+j2smujKMTUWR9DBLZHWLcCbqtF8r5MIwwuBo/ymrrUI4c8m10urW7RdccEi5
 yPYaSV2A1H2bdlvg3Qg+4NrqCZf3w6fA2UbFjA3/oLYYeIlMsgA7HK70wzxG1LiZMgl6
 HKtunavDTykqZ/4twOpIYdiTrpFANHyTu/r0sjJ3zX/mOd4QqJrJnabt9ldek5VYjc3I
 XjQXiFwqJJ0ssmkN11Qm3tnUwhB/mOXMHciEEDQM6snLZRgBGmkJN1wj4mjDirRX9nUW
 CHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uCuwUN641w7FMV6oZtDjYFL14mnyofEsSTqbFVKRVnE=;
 b=CJbFEmSJY17RISBkxZrnl8+vNeISbDh6es1YjnIefjA+C+ytBkPcG+le8cY4RGIWty
 Q/mKsfmAjwkvmfQDhpPqVxMdcmDpXA9h2pS9CXmqEjXKctuRRLK9yV87xJ29t5S0yyVn
 hxVjvNJ6D58avOgYqL+fjzJrayAU6AJVH1n2piYP1eTQwGR4hi1r6lWYOpLMsApvNsmh
 uq5CblXvql5c4uARRuHMoRP8ofvVfgbCqCDji8tTkxZN1MpdQlG60pWGIpTPhhhuCmzr
 S93HXPZ/60E6ImeuAGJv5X1QJ1AqPSrylC9FhiiLJueWt6fJ37PCai4BmcRGyCFojb/R
 q4+Q==
X-Gm-Message-State: AOAM531BVGMBAUAIZ/TTj2Q511xXxx442rhbqVQBcoPjyhJY/MyZ3wMq
 owGIYnZT9zgPje2XImAgqu9slwn80GA=
X-Google-Smtp-Source: ABdhPJzaXxF1hh6U0c19g7VHH2Vtk7b80/8XtSREBIPHUnvlCWbLfTSB6tfDk10Rz7uE/9GNbZMiRQ==
X-Received: by 2002:aa7:8d93:: with SMTP id i19mr22709455pfr.112.1589899918310; 
 Tue, 19 May 2020 07:51:58 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id s199sm11649807pfs.124.2020.05.19.07.51.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2020 07:51:57 -0700 (PDT)
Subject: Re: [RFC] Various questions about TCG implementation, DRM patches
 dealing with pointers over guest-host barrier.
To: "Catherine A. Frederick" <agrecascino123@gmail.com>, qemu-devel@nongnu.org
References: <9d75f1f6-3440-8dec-9266-4841362844d0@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8573dda3-a4f4-2590-678d-d45cfb62ced6@linaro.org>
Date: Tue, 19 May 2020 07:51:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <9d75f1f6-3440-8dec-9266-4841362844d0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/17/20 4:05 PM, Catherine A. Frederick wrote:
> - I've been implementing an instruction scheduler(list scheduler, with priority
> given to most successors) for TCG and currently if I replace instructions in
> s->ops(the TCG context) I get a crash later in tcg_reg_alloc_op, even if the
> instruction stream is identical. Is there anything else I need to move when I
> do this?

If you're getting a crash in tcg_reg_alloc_op, are you updating liveness info?
 Where are you inserting your scheduler in the list of passes?

> - Is insn_start necessary to have in order(and what does it do?)? These
> currently are serializing instructions in my scheduler and significantly limit
> my reordering as they create lots of dependencies every few instructions.

insn_start is required for unwinding from exceptions.  You can consider it a
barrier for call and qemu_ld/st.  Anything else cannot raise an exception and
can be moved.


r~

