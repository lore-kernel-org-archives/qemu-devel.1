Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DE0C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 15:28:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BF0520449
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 15:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kY6yKTCq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BF0520449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50170 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRemv-0006rG-Ks
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 11:28:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRemB-0006YY-Bu
	for qemu-devel@nongnu.org; Fri, 17 May 2019 11:28:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRem9-0008WU-Jo
	for qemu-devel@nongnu.org; Fri, 17 May 2019 11:28:03 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:41318)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hRem7-0007t8-E4
	for qemu-devel@nongnu.org; Fri, 17 May 2019 11:27:59 -0400
Received: by mail-pl1-x643.google.com with SMTP id f12so3501223plt.8
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 08:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=weCj/cPcQBb92IBSb1dPlYvmryMtX3SyUGLvbpxqS1Y=;
	b=kY6yKTCqvgbzPsYj/Jsrc3UFiPndnY41f9Gbz7ugbksUmiOn4L5OO/2l7884Jxh1Nt
	VP6ny5xZCDUKY0Ng5l4ajBFUgBiAAE1mYdu9QCgUeJJ4SNNjCbnNISDp6JvwXjW8Az53
	WG/VBYIX3DC6Qoxd/HGJnwMt0Gay3YS2X8Q2tDzqGUL33rc7EZ7pTlOgHeyLf7q5+5Gd
	D9kSuCQkft6T8gHL76JeRCb/gnYyfU0tDboYGPlqv9vdmlKKPr3vn4O8BMe5/dBjTsIz
	efupj5O7qQfOFDWS6vAEqorT+9Uu6eYZwbvFjAo6eTeKpwVWuQoPrakKSxH0vT/XCn5N
	w7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=weCj/cPcQBb92IBSb1dPlYvmryMtX3SyUGLvbpxqS1Y=;
	b=s+XWhNF/A5rpmbIZnDlABjhiwb1LAPD0aMT095VyrIJknmtDk4rLbVU/jF8YDyMj7c
	457IPeHd3lH0OgkyFcNuECUZZH4zDGKlHC2d2QU6MmoxoluNvykP4RByNWhwerx+oaRb
	VnO+sUn0zf0soMW2XWhNIEnWQm7fOLScJUaTPXw6FWvD+PArn0u17/gopsKhfpOEEB4v
	VyBpH8An4/D0xh2caGV7Xe9I//BznnelXC9k/XohfIA1Ms98VREt9arQQcZEiEhtUew7
	7md3KFzzRYpOmViF4EwylTZ86tYGqymuWKv64Ko72TQhT9yJM/oy1iDnwHi/qGN28vAA
	HKyA==
X-Gm-Message-State: APjAAAXDo40A4v5a519UpZNCGHlSWvTJn97B2i4NZFx1TIzor8SQTFaI
	eeRKEU6bu2Zw7GTogqCNjSqVNQ==
X-Google-Smtp-Source: APXvYqyOBmvdCp++qFMx+SWSGzra6qsn4quabFDGMjjZhGGq/qo1POOl4qOqFc0cqIfBkQV7vNkmAw==
X-Received: by 2002:a17:902:148:: with SMTP id
	66mr1020520plb.143.1558106872265; 
	Fri, 17 May 2019 08:27:52 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
	by smtp.gmail.com with ESMTPSA id
	q4sm10553858pgb.39.2019.05.17.08.27.50
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 17 May 2019 08:27:51 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org
References: <20190517045136.3509-1-richard.henderson@linaro.org>
	<1d36d568-8fec-f81e-635f-a34560e04b2a@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <a90e775f-7039-8a67-313d-bac3856c3d13@linaro.org>
Date: Fri, 17 May 2019 08:27:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1d36d568-8fec-f81e-635f-a34560e04b2a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: Re: [Qemu-devel] [PATCH v14 00/13] RX architecture support
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
Cc: ysato@users.sourceforge.jp
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/17/19 1:00 AM, Philippe Mathieu-Daudé wrote:
>>   qemu/bitops.h: Add extract8 and extract16
>>   hw/registerfields.h: Add 8bit and 16bit register macros
>>   Add rx-softmmu
>>   MAINTAINERS: Add RX
> 
> Series:
> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Thanks, missed this because patchwork doesn't remember cover letters.

> But please reorder patches before sending the pull request, see:
> https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg03671.html
> 
> - patch 9 first "Add extract8 and extract16"
> - patch 10 then "Add 8bit and 16bit register macros"
> - then other patches 1-8, 11-13

I have reordered extract and register macros properly.

> This will help if we unlikely have to bisect ;)

Bisection is preserved because the rx port is enabled by
patch 12, "Add rx-softmmu".  Eariler than that, the rx
port simply is not built.


r~

