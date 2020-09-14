Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619B6C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 02:01:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00E2D21655
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 02:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lm4+1GLU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00E2D21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHdoN-0006Hs-5C
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 22:01:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kHdmw-0004T8-3D
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 22:00:14 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:37762)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kHdmu-00007W-8x
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 22:00:13 -0400
Received: by mail-pj1-x1042.google.com with SMTP id kk9so4528000pjb.2
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2020 19:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=uluZ9e4xTwH5WsMOku+/uLhXVuDT1HwGYMAaCi9BPdI=;
 b=lm4+1GLUiTw1CTyGwC2dxSq9XtbeK+iNNAEbAqNyEFLqxArSVwPcovJsE1NbIAblMc
 1uGD+z+yQBKaFtgAaSXMf5yNVZJ79l74g8YNwtfe181xbYdI8qLWcGRJEZkYMFZ4S0h9
 jUsASaLB6uk6mWxU6uFgzc3HEnWZhiMq2jkfY80xiWOvp9pf1oF6xn6BaiTRm2gLHgAo
 H9J78vAAkIbmaadvpIOTbZAqIjZv7XfTdJ5/bxNB+t9/gId2EURbyaQi3+IegvKA0LWC
 pGWGOJlLDqdoSCErV8TLSSruky5dGVORz41iCm4jHCBGUccllTocqNtjzcz/RwZEHYkk
 b+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uluZ9e4xTwH5WsMOku+/uLhXVuDT1HwGYMAaCi9BPdI=;
 b=TNieLcfXxTHONbbNAg1iSCgf3da9iYeEQqpwRGV3ks9hvz/7Nh22sHmOKWTAEQqKlN
 Z0Hg6ZNQeJNDgGCKuW0V57gugWMjn9QRRrBkK2KhDUbDRWWhNVuVwobSpKslcc9GV6cn
 6FQiPE9h4i0tp26jdVUEX/L97KN7N8q3z2bBjn62HP6+6rGMzus/dkcmTHWhJppi3gTC
 /D4biMWTbvlcwuzmcOsDcGewwYHxYGguL9rkLyGwpOJUUcZVYbBV1hdzR49LURKWFtQg
 +TgqN8B4RCj5RSnmh97rbPhw+hb1YsTRT1LTVnFW3DaB74zPRQvrwUZaxP0T8UUNI0FS
 XIbA==
X-Gm-Message-State: AOAM533KOq6c0gSJyoj2qeLIUQg5LORapXazWI8R8iU6bCmMOT6My9VH
 GmJQSK60WVYyg7v5+SEc3LhuqJGQ0Ek1rg==
X-Google-Smtp-Source: ABdhPJxTEEg9wW+SsBeyAB0fNzliRLO6l73KIzniS3Y1J/CbqVTJ+EiJpSrMKBZLsK2iUNw07i2/MQ==
X-Received: by 2002:a17:90a:f407:: with SMTP id
 ch7mr11722047pjb.142.1600048810329; 
 Sun, 13 Sep 2020 19:00:10 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id t25sm6683925pgn.13.2020.09.13.19.00.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Sep 2020 19:00:09 -0700 (PDT)
Subject: Re: [PATCH] lockable.h: always define unknown_lock_type
To: mingli.yu@windriver.com, qemu-devel@nongnu.org
References: <20200914014236.2355289-1-mingli.yu@windriver.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4b20315c-e75d-904c-99d5-3a844ed3bb66@linaro.org>
Date: Sun, 13 Sep 2020 19:00:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200914014236.2355289-1-mingli.yu@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/13/20 6:42 PM, mingli.yu@windriver.com wrote:
> From: Mingli Yu <mingli.yu@windriver.com>
> 
> There comes below build failure when use gcc 10.1.0 and
> "-Og" passed to compiler.
>  | /usr/lib/gcc/x86_64-wrs-linux/10.1.0/../../../../x86_64-wrs-linux/bin/ld.bfd: /mnt/build/tmp/work/x86_64-linux/qemu-system-native/5.1.0-r0/qemu-5.1.0/fsdev/qemu-fsdev-throttle.c:25: undefined reference to `unknown_lock_type'
>  | /usr/lib/gcc/x86_64-wrs-linux/10.1.0/../../../../x86_64-wrs-linux/bin/ld.bfd: ../fsdev/qemu-fsdev-throttle.o: in function `fsdev_co_throttle_request':
>  | /mnt/build/tmp/work/x86_64-linux/qemu-system-native/5.1.0-r0/qemu-5.1.0/fsdev/qemu-fsdev-throttle.c:103: undefined reference to `unknown_lock_type'
>  | /usr/lib/gcc/x86_64-wrs-linux/10.1.0/../../../../x86_64-wrs-linux/bin/ld.bfd: ../fsdev/qemu-fsdev-throttle.o:/mnt/build/tmp/work/x86_64-linux/qemu-system-native/5.1.0-r0/qemu-5.1.0/fsdev/qemu-fsdev-throttle.c:103: more undefined references to `unknown_lock_type' follow
>  | collect2: error: ld returned 1 exit status
> 
> So always define unknown_lock_type to fix the above error.

There's a lot that won't work with -Og, including stuff that uses
qemu_build_not_reached (which this itself should have been using).


r~

