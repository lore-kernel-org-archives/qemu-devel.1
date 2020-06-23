Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7054BC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 20:07:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FD6A206C3
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 20:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZUuDkTuP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FD6A206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnpCz-0007Eb-9R
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 16:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnp0l-000544-MQ
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 15:55:15 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:44434)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnp0j-0008Rz-QW
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 15:55:15 -0400
Received: by mail-pg1-x544.google.com with SMTP id r18so32762pgk.11
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 12:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=MJWqeoUbiMsWn8YWhEsrx3vSel5g8s8d58neBNcu5Pc=;
 b=ZUuDkTuP7KMnUTZ/wIh8gVu+mNAg2igA7/2YFKxrZotR4oOD4BI5y5o1J2SWKmmFri
 5kzxZywJJ00EL1L2J5hrtpx02YHJtwQd/yCySIIp0ODbIXbJmAq+LB14juAqxvd58UnQ
 MC1sIRzgKoxJlsTl2PwGm/JVKX6f1+iIEuZwyTuUZis94b+/U9SbqvpZqaW66IskJBa+
 vxIVT0cWC2yW6VaxTuxDe/W/18MxTrRpvJa1a2Ry4+P4Ku2FYacQ20evABdbXZyFVOeR
 QizWS5DMVTZ4Z/yg3FpOAYtNB7uiQIOWoEpxPJ6LIAm/ui9gXIQD7J4xpBg8M6WdoO08
 TLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MJWqeoUbiMsWn8YWhEsrx3vSel5g8s8d58neBNcu5Pc=;
 b=G2c+qgBFDI7P9ald0B9SDYNVy/7ZKjWjyhhbwBKHdOJ6bpiLh0jYZHEI2F3RVUQbQ9
 6I1wOTwfW74baG0R1X2Isw9dr49uG7oXCUwdvfY+SO9ZxHE/wG0rbjbqtY62E3dxx4Rn
 GWLsW7t1OtXl2AU78sZJoG1IXMiV4AURzmeXTov2AUzkxrnUM4wycP3jwojAuJX45dbh
 fC1mVk0Em+tOrGJC0D/ow6RxTs1Yu8ctShVvMJa+hX37U8Pkf/2CQ2d+iklfFeoGHOD7
 PZmbaVOqIdC4d/o32NHAARMHu/YybEWyhLol/lBJfykYtWJ139T8MGVQE5OmcXHnM7GW
 WXfw==
X-Gm-Message-State: AOAM531ST4QBKviFlzwePDzWhnzHjrClG2xOdRcq1Ccfa/Ol3JRwJy6v
 3zpFMS4+6t9P0TJct1Uj2WF/TOSSVaA=
X-Google-Smtp-Source: ABdhPJzExCSrc3ogtr32BsMWwmTJIFczkuaq8Umz57EZfFfbRScbDdFMk7D+XYXIk0/DMzqIQNFUMA==
X-Received: by 2002:aa7:9a9c:: with SMTP id w28mr24610594pfi.295.1592942111899; 
 Tue, 23 Jun 2020 12:55:11 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id j19sm17571513pfn.109.2020.06.23.12.55.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2020 12:55:11 -0700 (PDT)
Subject: Re: [PATCH] risu: don't do a full register compare for OP_SIGILL
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200522023440.26261-1-richard.henderson@linaro.org>
 <20200623144446.4243-1-alex.bennee@linaro.org>
 <CAFEAcA8LvhhWihVHc_09ZRzZKv8tiWFfd2MfT7ZawJpU3UktyQ@mail.gmail.com>
 <87eeq592pk.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1fc28bd0-1bee-1329-2d8e-ae9362d2c219@linaro.org>
Date: Tue, 23 Jun 2020 12:55:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <87eeq592pk.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/23/20 9:17 AM, Alex Bennée wrote:
> 
> Peter Maydell <peter.maydell@linaro.org> writes:
> 
>> On Tue, 23 Jun 2020 at 16:07, Alex Bennée <alex.bennee@linaro.org> wrote:
>>>
>>> OP_SIGILL means we have an unexpected invalid operation. If this is a
>>> load or store the register state may be un-rectified pointing at the
>>> memblock so would be invalid. In this case just compare the PC and
>>> make sure the other end also faulted at the same place.
>>
>> In case of mismatch of the PC do we still print the full register
>> dump?

No.  If we want that, we should do something else, like remember that the
memory pointer is in use and zap it out before reporting the register set.

But, generally, if we see SIGILL, then we have not actually executed anything,
so the register state doesn't matter too much.  What probably does want
reporting in this case is the insn opcode.


r~

