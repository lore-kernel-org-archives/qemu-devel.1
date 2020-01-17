Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13F4C47409
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 18:11:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 733A12082F
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 18:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HtXI2hIZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 733A12082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isW5r-0008Lo-Jm
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 13:11:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59491)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1isW5G-0007w1-BR
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 13:11:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1isW5F-0001Ze-54
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 13:11:02 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035]:39589)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1isW5E-0001Yz-Uf
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 13:11:01 -0500
Received: by mail-pj1-x1035.google.com with SMTP id e11so3663771pjt.4
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 10:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=kIM2qJaKNgC/FPxNU1vgd63eticI/SEzDMKcNciPvF8=;
 b=HtXI2hIZVKGLpKGYHhJ01rXyiJMoUxTss2tV0ICOfnafpBYYJ7CfATF3M6fK9+wMBL
 ZF808pDLPP5a9C5rGBXlGsqsDcyDdEaGU9k3OHJgzK+AHq7RZp7+6DvRcQLIyN5SB7qp
 Vrhsjo3CaLWmo7s2fHIyoGgANoKnOu9w4RqEkecnXcf8leNTsSz06V4VjGhJZnOZXiNw
 hERkxCk9RH/xIput3r5gJ/lKEMkTq2HVkxU0f3fw5K2bbF3wYQG+HxWdgvFdakihodG9
 J5JdMYFiYyL2kEBMG5PxHO+8ha1px9stsrlLREx4HGIP1bwttw303qe6Y6LUSIIKNBTX
 eAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kIM2qJaKNgC/FPxNU1vgd63eticI/SEzDMKcNciPvF8=;
 b=Y2IxUH2j9g1r+ZldmDpimPx7qPdwh83j8ey9bmINjfK66dSBOOvLyW3eeAL4vE/DUP
 3CIOKBIwaJZIUvxBp05tyhvVQiRilw9W0t1Da2qqLVHvEqK9RqUVUhjSnKeJg8/hrJs2
 9nMkMyqCtBltvu0MwUk64ksliiZ/X8jlX7soi2FFBGOWEtkdMIr5nJ5qT2MwlSMLzRXb
 WKlL/IeOMRsZaVpYA5DOJy6QkYPMvZ24qqnc6nOIRaz5lHFqQGg7hiI2Ea7oy+rl2aba
 m0ik8YQFabphNpWJDbi5/K1glsmlmrPyTdoS/r9reYg8vmSKVcKRWK2BwYq/EPDbWezM
 D0iw==
X-Gm-Message-State: APjAAAUSQ0J3ugDxlZKix8T5Lc43AE5Sim7aPxk4vhjVbhaQ9FeCGn0j
 RrXAQZxfV4THjA4WTbrz9OZrbA==
X-Google-Smtp-Source: APXvYqwK0rZ8G0qBpSuA9+fV3uy9nGqukhGIMqOgDflngkeKB45ZglBoth7nYJs3GqUU3aXh/jHHqg==
X-Received: by 2002:a17:902:9307:: with SMTP id
 bc7mr313644plb.338.1579284659670; 
 Fri, 17 Jan 2020 10:10:59 -0800 (PST)
Received: from [192.168.3.43] (rrcs-66-91-136-155.west.biz.rr.com.
 [66.91.136.155])
 by smtp.gmail.com with ESMTPSA id x18sm30803886pfr.26.2020.01.17.10.10.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2020 10:10:59 -0800 (PST)
Subject: Re: qemu-x86_64, buster /sbin/ldconfig and setup_arg_pages (a mind
 dump)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <874kwukmxr.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3ff41cb9-8d7e-7013-a846-1a9a809bf6f5@linaro.org>
Date: Fri, 17 Jan 2020 08:10:54 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <874kwukmxr.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1035
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
Cc: qemu-devel@nongnu.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/17/20 7:33 AM, Alex Bennée wrote:
> So what do we take away from this?
> 
>  * we need testcases to exercise the memory layout of dynamic binaries
>  * "special" dynamic binaries can break our careful memory layout
>  * I feel as though I've trodden on a nest of vipers
> 
> Does any of this track with you? What is different about ldconfig that
> breaks our memory placement?

We've been through this bug before, but never came to a resolution.  See

https://bugs.launchpad.net/qemu/+bug/1749393
https://lists.nongnu.org/archive/html/qemu-devel/2018-03/msg04700.html


r~

