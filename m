Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15A1C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 07:29:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5F0221582
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 07:29:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5F0221582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maskray.me
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihTm6-0006iw-0w
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 02:29:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53215)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <emacsray@gmail.com>) id 1ihTlS-0006KM-Hh
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 02:28:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <emacsray@gmail.com>) id 1ihTlR-0001rX-Ew
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 02:28:58 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43254)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <emacsray@gmail.com>) id 1ihTlR-0001q3-90
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 02:28:57 -0500
Received: by mail-pg1-f196.google.com with SMTP id k197so775535pga.10
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 23:28:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=rpRSIrQzYUtT04Bq9+TA2kfih33jB33fRgfkZXrcHW4=;
 b=URorQaSMlYTxtcFD8cd6w4FPScj12nmEi3X4HYxFrRVggy9U89x7scF0mPT7kZ+EAO
 42MMf9vda13SYINmxuboN+M5WhGqAvuecD1q4TqC80WY7RrajiZTW2eHi9V/jhJIZkhu
 OL5o7WsL+xmty122swoajlvC+OV0EfoZ0oWKE+hr/yDbnMDrYf4nyLuwKC5HB1iZaxDh
 /0FcuGYdKLOJq6/GkK+eawtMXkNczevQSykUjAQai1XcRR2Ipu0AtcrIAxaXvHpaFggX
 eXdPRSYeXb8XL1QqHPSzCWNUBj5B5zM+WFxhH177an+BWw4iWE0xdcaJ5aq//ic0gZYv
 ta3w==
X-Gm-Message-State: APjAAAX2vYRayssC+YdmdkoMVPmW1Za1LwQ8Qyx5lf/GP/MhrxOUQhY1
 g7GlNf71DZGj5lZLFA0ZgkY=
X-Google-Smtp-Source: APXvYqzXb0sCdCb3eaTfGmcbFLwDo6dZT+QOy+VcVAonJR82VSOM03WwdEiok0vMrALZ2bsDrrF20A==
X-Received: by 2002:a63:cd06:: with SMTP id i6mr1485257pgg.48.1576654135855;
 Tue, 17 Dec 2019 23:28:55 -0800 (PST)
Received: from localhost (c-71-204-169-238.hsd1.ca.comcast.net.
 [71.204.169.238])
 by smtp.gmail.com with ESMTPSA id bo9sm1427694pjb.21.2019.12.17.23.28.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2019 23:28:55 -0800 (PST)
Date: Tue, 17 Dec 2019 23:28:54 -0800
From: Fangrui Song <i@maskray.me>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 0/7] configure: Improve PIE and other linkage
Message-ID: <20191218072854.3j3sld6dsikgqjtx@gmail.com>
References: <20191218031920.6414-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191218031920.6414-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.196
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
Cc: philmd@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2019-12-17, Richard Henderson wrote:
>This begins by dropping the -Ttext-segment stuff, which Fangrui Song
>correctly points out does not work with lld.  But it's also obsolete,
>so instead of adding support for lld's --image-base, remove it all.
>
>Then, remove some other legacy random addresses that were supposed
>to apply to softmmu, but didn't really make any sense, and aren't
>used anyway when PIE is used, which is the default with a modern
>linux distribution.
>
>Then, clean up some of the configure logic surrounding PIE, and its
>current non-application to non-x86.
>
>Finally, add support for static-pie linking.
>
>
>r~
>
>
>Richard Henderson (7):
>  configure: Drop adjustment of textseg
>  tcg: Remove softmmu code_gen_buffer fixed address
>  configure: Do not force pie=no for non-x86
>  configure: Always detect -no-pie toolchain support
>  configure: Unnest detection of -z,relro and -z,now
>  configure: Override the os default with --disable-pie
>  configure: Support -static-pie if requested
>
> accel/tcg/translate-all.c |  37 ++----------
> configure                 | 120 ++++++++++++--------------------------
> 2 files changed, 41 insertions(+), 116 deletions(-)
>
>-- 
>2.20.1

Thank you for the patch set. I hope this will make that lld qemu user
happy.

How will this patch set affect statically linked user mode binaries?
(qemu-user-static packages on Debian, CentOS, ...)

