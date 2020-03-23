Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8410C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 20:00:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 840F6206F9
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 20:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U6lEYMWu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 840F6206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGTFL-0000UZ-NQ
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 16:00:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51629)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jGTDp-0007YY-0F
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 15:58:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jGTDn-0001wi-LB
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 15:58:52 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:35984)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jGTDn-0001uy-53
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 15:58:51 -0400
Received: by mail-pf1-x442.google.com with SMTP id i13so8053901pfe.3
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 12:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=iJ3FK28d85aYDqI9PVYlE3XqQqXopes7u6G/mfDiM+k=;
 b=U6lEYMWuOtMoW5rm1WLjobLU3vaAKMxo0AnFlQeGmb6L1KAgSsx6EVsz2Tu6+hFM+4
 kR7Q9Qds52xjeI9eJyYsv0crLZA94VXdEqv5mx+V60PzXK/ffWwNKFQWpaJ4kn/FzQSx
 zDVNmQ19PfHgqZtvExrqXq8+o0c3oMK+pF/7YVmm/SrC0tE/C4KcWA+7iwahjy2RI5Wt
 axDx/SvyXdA5BAFCMUm6h4gYfaKbs/Gx7CX3xvcbWDtO0DcmmiUbzgPNeFLv1jmOPzwW
 87nkSCc/Z8hUBNIle2knZ8plo3S/aCjTt2aft5O4RJp+VRFtz5tNsVaULY0gFOJmlH5k
 nCOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iJ3FK28d85aYDqI9PVYlE3XqQqXopes7u6G/mfDiM+k=;
 b=JObgSomQTuGlME/viYlNxMUb4Dg12RaHxGF3ycrG7pviNHwlZ/a7ZjhiditmfLst1w
 YOB5V7dlAk3YYEq10/FMt+SfAGbipo1Be08hLOmhzx9/2jiLg6RjV65t1DvCJbpTIKZW
 BvbvHcEGN9yuS4VweYUf7aa9gmK7NddUjh8zPsP8hg7MzKwvuJBWIm+Os+AVbRGsFrbg
 lep19uV0ns1upj8Bw62lfRoMUlPxwvh5Mo6qA4/6V8dtD8ZSF42hVWeb6eNVhLhaZDjg
 kDQTh7dak7mvDLHSsll8yx5fUGY5FuW2p1tdgUoqdjWXsY4Xvis7/CT97JpQRP6SPPOS
 5CKA==
X-Gm-Message-State: ANhLgQ1TPD/y5OCEte/vizV9TEyuJPFUkdHfYggKXFd8M34XJ6jKQP7R
 z3ZxnHnvdRSPJAZBHFOGnVrdtHWidE8=
X-Google-Smtp-Source: ADFU+vuOqC3DS7vfgnCyK7q6hmTPlFVWwkcAyQkqpnDlqhnoUgM2Xtaa+JTQhXDaGcRLJd7uVEX7Nw==
X-Received: by 2002:a63:778e:: with SMTP id s136mr6109329pgc.155.1584993529229; 
 Mon, 23 Mar 2020 12:58:49 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 t4sm2667523pfb.156.2020.03.23.12.58.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2020 12:58:47 -0700 (PDT)
Subject: Re: [PATCH v1 for 5.0 00/11] testing/next
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200323161514.23952-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <409671dd-7684-c95d-f9d4-a94e8b6fe2ce@linaro.org>
Date: Mon, 23 Mar 2020 12:58:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200323161514.23952-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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

On 3/23/20 9:15 AM, Alex Bennée wrote:
> Alex Bennée (2):
>   tests/vm: fix basevm config
>   configure: disable MTTCG for MIPS guests
> 
> Gerd Hoffmann (4):
>   tests/vm: write raw console log
>   tests/vm: move vga setup
>   tests/vm: update FreeBSD to 12.1
>   tests/vm: update NetBSD to 9.0
> 
> Philippe Mathieu-Daudé (5):
>   tests/docker: Keep package list sorted
>   tests/docker: Install gcrypt devel package in Debian image
>   tests/docker: Use Python3 PyYAML in the Fedora image
>   tests/docker: Add libepoxy and libudev packages to the Fedora image
>   .travis.yml: Add a KVM-only s390x job

Whole series:
Tested-by: Richard Henderson <richard.henderson@linaro.org>


r~


