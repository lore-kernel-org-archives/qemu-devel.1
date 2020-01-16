Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D3BC33CB6
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 18:32:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA5D8206D7
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 18:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D6S7v/9k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA5D8206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is9wq-00014U-10
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 13:32:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37559)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1is9v9-00081g-Cf
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 13:31:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1is9v7-0001DD-Vc
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 13:31:07 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:45191)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1is9v7-0001Bs-Nu
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 13:31:05 -0500
Received: by mail-pg1-x541.google.com with SMTP id b9so10295991pgk.12
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 10:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=aRYc9++vppC68niNgxhrBYIGTUxhmzkEilcEDZiNFuA=;
 b=D6S7v/9kQ5egwCRZcEVs5Zca/cjDHmXmy9IjCrOhWD9VM2oLiIvvhDTIQnDA+Cq/GG
 6DWcb8jkCwc+MFtkHprVxkMEPEwjUXkbkxT4fVPCY5yGyCiEoY6eCd9SNratP1vDiFgN
 /0J+WyQ6dnrLch+QTRcLNC7/ohXyjT0kwr/AuU+/TYcrhm32VwT4QIbLaZFulTKNclUn
 sZYlvlX3Eqn/E7iaY0pYlGyrJ4igXbnbugNFLRPLqIREpHj528E1B704U3ErJOwXFQgs
 Tam3fFrbGVmtgHgXHQSwpUnybaBrNuFUvlDM+3N5Ff2sRl5kRVSH6mVu0EiCh6ArEHuF
 JV3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aRYc9++vppC68niNgxhrBYIGTUxhmzkEilcEDZiNFuA=;
 b=FdGvmYBt6y5lKa8uYRjnti0AiegoYX92OLuEAFUs5QKWQACVmarDRA+BnvPyx9F9HU
 7/lECahu5mPMuoE6iCGa8UwPu6Kq3Z0uIhF6S5e4RZJmKQZtgyx+ZtoI4PLLsMlgGbty
 nVOHw3+FaX73C9EsefARzPvgMpv3t57sEKGNw0/jCc1TP8q6UBGXV0oeX4rf+Wav92t/
 bGT++EMov0/68eYJ8CHHuMceyWaHnvU+XhyoOUqUkWFSfqirnVQMAA6gOVJbbIi2eaAj
 uUTFh6wC1UOJ+Dtp+oddvsye0FTKR7rZuoTh7A8hzQXFyrBkLO7lZsBy2Co3weMmo7Fa
 nb0A==
X-Gm-Message-State: APjAAAUnsnUHhacaCxu4NqJvRcrbTvI68XEskjg2q6LCWpBmVEJ7+IAU
 KaLqKvlYRTOG/4K6FIRwWhaVBhw637U=
X-Google-Smtp-Source: APXvYqxkOWyxzq9D/JFi97Rs8cvSRc32ec3A+gbJ2CwJZw8rw1q1jsbdNDC2KaHhz59bVNnSHe5GBg==
X-Received: by 2002:a63:1d1a:: with SMTP id d26mr38760622pgd.98.1579199464498; 
 Thu, 16 Jan 2020 10:31:04 -0800 (PST)
Received: from [192.168.3.43] (rrcs-66-91-136-155.west.biz.rr.com.
 [66.91.136.155])
 by smtp.gmail.com with ESMTPSA id z16sm27216482pff.125.2020.01.16.10.31.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2020 10:31:03 -0800 (PST)
Subject: Re: [PATCH 0/3] linux-user: Implement x86_64 vsyscalls
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200114210921.11216-1-richard.henderson@linaro.org>
 <87imlblbi3.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7435787b-7bf0-66c6-b520-120fa74904b8@linaro.org>
Date: Thu, 16 Jan 2020 08:31:00 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <87imlblbi3.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, riku.voipio@iki.fi,
 laurent@vivier.eu, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/16/20 4:30 AM, Alex Bennée wrote:
> /x86_64-linux-user/qemu-x86_64 ~/lsrc/linux.git/tools/testing/selftests/x86/test_vsyscall_64
> [WARN]  failed to find vDSO
>         no vsyscall map in /proc/self/maps
> [RUN]   test gettimeofday()
> [RUN]   test time()
> [RUN]   getcpu() on CPU 0
> [RUN]   getcpu() on CPU 1
> [RUN]   Checking read access to the vsyscall page
> [OK]    We do not have read access: #PF(0x4)
> [RUN]   Make sure that vsyscalls really page fault
> **
> ERROR:/home/alex/lsrc/qemu.git/linux-user/x86_64/../i386/cpu_loop.c:185:emulate_vsyscall: assertion failed: (ret != -TARGET_EFAULT)
> qemu:handle_cpu_signal received signal outside vCPU context @ pc=0x7f6eed31b613

Ok, thanks.


r~


