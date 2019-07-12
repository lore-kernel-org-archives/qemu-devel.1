Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA606C742D2
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 17:37:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E4342083B
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 17:37:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E4342083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlzUc-0005dJ-OX
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 13:37:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40161)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hlzTo-0002B0-I9
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:37:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hlzTl-0005xA-R5
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:37:07 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37943)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hlzTl-0005vi-6F
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:37:05 -0400
Received: by mail-wm1-f68.google.com with SMTP id s15so9665692wmj.3
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 10:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=X1faAN96ess887B8VaOA42Fh9cAb/DCyoJk65g4NgnE=;
 b=RIB9tJH7GGv2wUahkdDPn8BmoSTAJVhk2yRLkpHwQQJIWn51kOQknycdadQQEzgzMY
 ftVws2eYpxBlzk8Np0eYzHR7BMiaHSwg1lJ40uqc8Y9JO3ps+rYbrDZ57Hedt5iiYIST
 alXcDSPR0ZYbAUAfGJZevx8t5TT6JcCNEfORflrOCi3hLFz0fLNKDr/V+8aZ1qGAS83c
 xTlsTAk2ZrRQVqM+Zon6aT7h1ZIXH586zsTjgCxBq/Tau0ZIkiqXxJf+vc2C1q2gLWwh
 GSa7zguMPNhCcCrFsmd5HREAhvCC/PeIQ75iAcbwEGA/OHzX1c7LaYLXtxxFW0CSJocq
 8zeQ==
X-Gm-Message-State: APjAAAXgXJTJbK2uK2UnTp22T7HAE+sWQBhc240iiDnUsEIXXqhZ2I2T
 QtWYroTwFaYnr7/4OWfy9kAoV4USnic=
X-Google-Smtp-Source: APXvYqzZeKLqDyQR9K6rughtj6wrejHRQgwbtAbualqFrc7UF4KiI7c1F//rz59mTdCjeTLKtMBPig==
X-Received: by 2002:a05:600c:20ca:: with SMTP id
 y10mr10335777wmm.72.1562953023665; 
 Fri, 12 Jul 2019 10:37:03 -0700 (PDT)
Received: from [192.168.1.37] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id g19sm17275393wrb.52.2019.07.12.10.37.02
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 12 Jul 2019 10:37:03 -0700 (PDT)
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20190712172743.17632-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <f9a3ad2f-e895-d4e4-6aee-8d956f907e9b@redhat.com>
Date: Fri, 12 Jul 2019 19:37:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190712172743.17632-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH] build-sys: remove slirp cflags from
 main-loop.o
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
Cc: pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Marc-André,

On 7/12/19 7:27 PM, Marc-André Lureau wrote:
> Left over from c2d63650d962612cfa1b21302782d4cd12142c74.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  util/Makefile.objs | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/util/Makefile.objs b/util/Makefile.objs
> index 38178201ff..68af3cd5e9 100644
> --- a/util/Makefile.objs
> +++ b/util/Makefile.objs
> @@ -3,7 +3,6 @@ util-obj-y += bufferiszero.o
>  util-obj-y += lockcnt.o
>  util-obj-y += aiocb.o async.o aio-wait.o thread-pool.o qemu-timer.o
>  util-obj-y += main-loop.o iohandler.o
> -main-loop.o-cflags := $(SLIRP_CFLAGS)
>  util-obj-$(call lnot,$(CONFIG_ATOMIC64)) += atomic64.o
>  util-obj-$(CONFIG_POSIX) += aio-posix.o
>  util-obj-$(CONFIG_POSIX) += compatfd.o
> 

Since you are looking at slirp, I'm having a bunch of:

$ make help
[...]
  CC      slirp/src/tftp.o
Package glib-2.0 was not found in the pkg-config search path.
Perhaps you should add the directory containing `glib-2.0.pc'
to the PKG_CONFIG_PATH environment variable
No package 'glib-2.0' found
  CC      slirp/src/udp6.o
Package glib-2.0 was not found in the pkg-config search path.
Perhaps you should add the directory containing `glib-2.0.pc'
to the PKG_CONFIG_PATH environment variable
No package 'glib-2.0' found
[...]

On MinGW.

I can silent the warnings using (32-git build):

PKG_CONFIG_PATH=/usr/lib/mxe/usr/i686-w64-mingw32.shared/lib/pkgconfig

This is new since the slirp split.

Any idea where to fix that?

Thanks,

Phil.

