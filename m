Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD42EC33CB3
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 19:48:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A92D2073A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 19:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wGa5jg+Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A92D2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isB7w-0003Aq-8y
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 14:48:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50680)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1isB61-0000d2-Sx
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 14:46:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1isB60-0000uB-Sf
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 14:46:25 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:43061)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1isB60-0000t6-Lr
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 14:46:24 -0500
Received: by mail-pl1-x641.google.com with SMTP id p27so8769851pli.10
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 11:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=G0HsCZociEsx/t7TxSOdrKk2JcF9xuAN8pW4YIA0PWc=;
 b=wGa5jg+YhJ+u19iQJe3T2VLmJ09qRE5O0+ruFGl85OQtXO18aaE661QE/QYuWnLaRb
 5vBArk/WT7WskFQ1/hB8afFW1h7OcIwa5DJ1OhGHXnW5tDayBwvKhrZgybKn6peD57Dc
 W0c1lffOGbiOJlOnClNJAOpTchzLu+fIqZ5e3YHkq1a92BVdsLnccZTIs+1O3s1Lbpyt
 nlxAINBU9kZf40EgIbqv0bhsCfmXJoBNMeW84FdFNBP45ju77os8ZBwrZO+C2HCHAlf1
 TW9JsPb/IIw9Jk6R2LwKhoimrrYEjEFtroU8fK7W0DfmAs2e37JNvXZlahQ8F5xaFEpn
 mqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=G0HsCZociEsx/t7TxSOdrKk2JcF9xuAN8pW4YIA0PWc=;
 b=qGOL6iKarpFcbjhAHqWXrksEtgWZ+hgUCQoTAkCI8/w+M3J8vezjRkc5P83+b4HfKm
 NM/oopSeCPHJGyaMFoUlltM2qnskjdvY6NGLXXqQdFfjGJp2x9S1+WJ/UUc5iO2jO514
 oSbxER7SiqxyxTDN5LMgfbEl7S5xzfxYAzF/4uyWcczeWyPWIGOD9UTAaag/1UjabJ1U
 C6RrjgdTHGYEOjnH2J5ez0ikusNc8/PEaGzfWTbuwKHVHaizVIXb6b2QobsKmL21EQx4
 u4KdG2diyqys8at9wwfV4xzGODh7mfi36lqHCWfm0mYRXpapeyY3Yf2p3fYCwUi84N3+
 H97g==
X-Gm-Message-State: APjAAAXlcKpTzeRNcTtZ6z4JV8KcHqN9Pvgcs1K+jpjfVaXZwMivRQ2q
 +ABNeZtuhHLiop+w8N7SizGbMuBwGuA=
X-Google-Smtp-Source: APXvYqy92vadcf5hOoalrJqFllaXHvYKmIXmph0y4nZ5zreehAxn3QboEQMKgyzA9FULY1+nPjz7Aw==
X-Received: by 2002:a17:90a:ac0e:: with SMTP id
 o14mr1010300pjq.11.1579203983680; 
 Thu, 16 Jan 2020 11:46:23 -0800 (PST)
Received: from [192.168.3.43] (rrcs-66-91-136-155.west.biz.rr.com.
 [66.91.136.155])
 by smtp.gmail.com with ESMTPSA id o7sm28261356pfg.138.2020.01.16.11.46.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2020 11:46:22 -0800 (PST)
Subject: Re: [PATCH v2 0/5] linux-user: Implement x86_64 vsyscalls
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20200116194341.402-1-richard.henderson@linaro.org>
Message-ID: <449c665f-711b-62b2-8b25-7dd9ece30d13@linaro.org>
Date: Thu, 16 Jan 2020 09:46:19 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200116194341.402-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: alex.bennee@linaro.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/16/20 9:43 AM, Richard Henderson wrote:
> Changes since v2:
> 
>   * Add /proc/self/maps line
> 
> 	I'm not sure this is really necessary.  The linux kernel
> 	self-test checks for it, and modifies the set of tests that
> 	it runs based on it.  But otherwise I think it's unused.
> 
>   * Fix errors in base gettimeofday syscall
> 
> 	This is also checked by test_vsyscall, as noticed by AJB.

Oh, and

    * Set error_code in write_ok_or_segv (patch 2)


r~

