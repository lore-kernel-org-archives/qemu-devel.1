Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551F3C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 20:22:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDE3F2067D
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 20:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BGz0UeTz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDE3F2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34816 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLCmv-0003dA-Ob
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 16:22:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLCkt-00025u-E1
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 16:20:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLCkr-0003Bm-O2
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 16:20:03 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:41079)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLCkr-0003BD-IE
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 16:20:01 -0400
Received: by mail-pf1-x42b.google.com with SMTP id 188so5876894pfd.8
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 13:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=LnNGI5I0VJx4xzw+4g9mjcpG0Vs25uv88jy/kAAL84c=;
	b=BGz0UeTzR4/h0FaFQCxRK+i1XFeMPbQgggChtY08jAQOpGz5hZDgT4bv8qMUnukVGt
	cMR82/aIeFQ9IudjKFTL+GDDjfIEq5s443wxzp730trJBZO4D8ThMycl3CROyoRsbazx
	JpusxFAS0apF9QpM5ZyCwudFuCV6rXeK5aLlm7jXT/FRMSTYMFepS3hueFx/A3jr2tim
	zqcgNCPq3N7yHdSQRyobZlfphsWaelB+OOco3tk6j7YMvqiKYV+R/VjAslHwOva5Zg9h
	Em1m4eNkXSXzWl9p48IQCQ3j3HzMkWspGydkP3r1lzmuPGNgWFwDZDpG1lmbD+jlFe+N
	nZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=LnNGI5I0VJx4xzw+4g9mjcpG0Vs25uv88jy/kAAL84c=;
	b=I4sfBQDpwqurdMGBNEN+4NUnyZG1dFLF3KOv2ZbreBlcSlBhRqZZhQ85+BH02RzjNG
	gAs+ZTvq/P109p76HgSchwqePvU5D41TxvwVaqfw7gY+fex1q7mWZhnAiUFWh3/Lgy0u
	y1h1SvN/3lvDkxLgeUj41FYmepzcriToDFM0s3NgdA0z7G2L5Ob6FF7WHr0qEOuZKGLB
	sPqrAiDUJItafei+j4Mk/X7PFr/Ka4vMFW0PmiwWc4r9NHDip/ZAF1pmh9cjghAJpNhN
	Hq+iL8gjnUCQQN073O1ZlHL/JCCb1IU8VY8Xn2/SpljmBqehU3q3QuN7/IRDsKC557Wg
	0nAg==
X-Gm-Message-State: APjAAAWV8WZ1KXSV/s/kSulGkcdB6rgS8AEaLJxbneAl4UMZO8S/7sRw
	xLYwhSZ6hLCrEn3PwDGJjbTpyfPUY0U=
X-Google-Smtp-Source: APXvYqwPZG0iPwaiyxGCFlqfOrz7gm1bFtDedi+dPHUVNvampIhr8JptTxcMdygPbHOsD/qfe7QToQ==
X-Received: by 2002:a63:f64f:: with SMTP id u15mr53406413pgj.192.1556569198722;
	Mon, 29 Apr 2019 13:19:58 -0700 (PDT)
Received: from [192.168.1.11] (97-113-179-147.tukw.qwest.net. [97.113.179.147])
	by smtp.gmail.com with ESMTPSA id
	e8sm63626700pfc.47.2019.04.29.13.19.56
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 13:19:57 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190420073442.7488-1-richard.henderson@linaro.org>
	<1137bf7b-b889-8680-86ae-4c7076fc99c9@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <27962519-cb27-12d3-6e6e-ac44f5e5c981@linaro.org>
Date: Mon, 29 Apr 2019 13:19:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1137bf7b-b889-8680-86ae-4c7076fc99c9@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::42b
Subject: Re: [Qemu-devel] [PATCH 00/38] tcg vector improvements
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429201953.Nu4MZpEawuv1DZygNNK1uyzMN277nxIAWBQteoii1Ww@z>

On 4/29/19 12:28 PM, David Hildenbrand wrote:
> Hi Richard,
> 
> what are your plans with this series? (and shlv and friends?)
> 

I expect to submit them this week, barring any other comment on the patches
themselves.

r~

