Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212F1C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 20:23:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D671D2070A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 20:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sj3+HTb6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D671D2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHZ2i-0007DU-3j
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 16:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33531)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jHYeE-0003gg-HD
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:58:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jHYeD-0005Fr-8Y
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:58:38 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:34662)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jHYeD-0005FP-2e
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:58:37 -0400
Received: by mail-pl1-x644.google.com with SMTP id a23so2583715plm.1
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+IsL7mZVn3n4BOMnLkuuNnEWQvMIXmw2NaS3aw2XqdE=;
 b=Sj3+HTb6+3EIwELpASSELsRqjup51PfCV6xOJRydacLZyl0Wdw9VhMr/P5vhBE4NOL
 7/aSWJBF30OM1RtQDEfkn75Hp80fVjb0GaWTFNAjByHWrc75bknN0RKtN/fUzD6W5VVN
 u1msHZiD/uQftQyk/ErMqirOp3ApyE7TggRjD8YSk7Q4EK67nhtIKAPbegurHl2N68jF
 QrRQ65g7It7bUqrAFBPh2hJE+sjFcevh4hPVPL7fQo1717EKWSORsIg4UNbeklJlWlja
 hU3m96et3txpl8ezp0YlepZ9yLnHhR7A6SDHb32AaMgsTjBS9qj5pgPXb0bJI3pRMcto
 W4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+IsL7mZVn3n4BOMnLkuuNnEWQvMIXmw2NaS3aw2XqdE=;
 b=Ozq1BzsMDU10Y6WkLxt3AQ3YjT4+CdCjP55kGQ4fbarsmwCDa4M4blo3BhHxxLN1LB
 n4JDgC59acw6lIRqeARbEDbIR3kVrzJakXOXhaHGJP5sUysDFDRvQ0Ggwb9Zv9wxFCg/
 goseiG1XCZEJwzQ7JTG0qHctPA9uEQ4/jNSaZfxLWAlqIjq1m5Hnl5WKsi8JG5vqGotR
 nj5WpYkKdDaZc4RuiqvJHCTGywYzEHscCENE8a6lm8iaNYMLnVY8eyYIN6K314z7Z3Aq
 9xcnDk7i6aTS+EYZ3ZohQohpOeed5v4QUFb7GHKa3saCIGfyq6/d6XMaFY7xNmJ1CVk5
 5kaw==
X-Gm-Message-State: ANhLgQ2zlKll6CzJQ4QGeol+lptijXrOik12xvqnAdL5qRn4XtfkGeL7
 mJwl63+0WmlFyAg1q3k2HblF3w==
X-Google-Smtp-Source: ADFU+vvzechy4IEuNTE2+v0dy65cNZ17KvUObR9xPyM8YnxB434Sf5OT+GB5wSgpp8Z/t6TyrBOATg==
X-Received: by 2002:a17:90a:304:: with SMTP id 4mr1902825pje.28.1585252715765; 
 Thu, 26 Mar 2020 12:58:35 -0700 (PDT)
Received: from [192.168.1.11] (174-21-138-234.tukw.qwest.net. [174.21.138.234])
 by smtp.gmail.com with ESMTPSA id c8sm2430835pfj.108.2020.03.26.12.58.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2020 12:58:34 -0700 (PDT)
Subject: Re: [PATCH] qemu/atomic.h: add #ifdef guards for stdatomic.h
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200326170121.13045-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fd05f470-1c3f-3357-ac91-26c06379bee2@linaro.org>
Date: Thu, 26 Mar 2020 12:58:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200326170121.13045-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
Cc: peter.maydell@linaro.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/26/20 10:01 AM, Alex Bennée wrote:
> +
> +#ifndef atomic_fetch_add
>  #define atomic_fetch_add(ptr, n) __atomic_fetch_add(ptr, n, __ATOMIC_SEQ_CST)
>  #define atomic_fetch_sub(ptr, n) __atomic_fetch_sub(ptr, n, __ATOMIC_SEQ_CST)
>  #define atomic_fetch_and(ptr, n) __atomic_fetch_and(ptr, n, __ATOMIC_SEQ_CST)
>  #define atomic_fetch_or(ptr, n)  __atomic_fetch_or(ptr, n, __ATOMIC_SEQ_CST)
>  #define atomic_fetch_xor(ptr, n) __atomic_fetch_xor(ptr, n, __ATOMIC_SEQ_CST)
> +#endif

Do we really get sequential consistency from <stdatomic.h>?
Should we not in fact #undef as a workaround instead?


r~

