Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE969C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 13:01:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63C0C20833
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 13:01:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63C0C20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54990 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRG0z-0002bC-DA
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 09:01:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hRFu8-0005SK-Kq
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:54:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hRFu5-0000wB-IE
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:54:36 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40668)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hRFu5-0000vO-DI
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:54:33 -0400
Received: by mail-wm1-f67.google.com with SMTP id h11so3346531wmb.5
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 05:54:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=npX1je2ba+s2/1p5jIINyFoiKvvHOlXzsX7IuaKUEiY=;
	b=m7Fwy1dPsdSKJDRAGUb7vLhAFuiFxIme+l8MBeTw9uepEIJfc7hK2RN5rU4bIXpU4C
	4Kjy1tjP1t5PubylqUhpVllK1XwZ4gBxtjDxPvbYq67W5nu/roR+nrlr06nYz9XjeJI3
	YctNZ2KGfGoTDkI2Sn2dAAIlHSUHZPpqzSf2i/jbqoBlbK60xjARoM4LzDSHFK6oGLKr
	XpoW9WzX+iGWmOhmFqNrt6MVBRVsSojrDFzkOrhujPPg8HRSk9ZRAJ7y2CfqML428DnZ
	xw74TechMXNKH3Rzgs9pfwf46cVEZEBagX5nXnrKv7HssK96QjW7xPHvpSrxTMey73BG
	s6KA==
X-Gm-Message-State: APjAAAVwl9BNv5O2vr+yb6Z19FiJRuv6JAgPdi8/159MSUKTLtc5pZgy
	Rbxe3X/4xg8dnAph2AizPjmNmA==
X-Google-Smtp-Source: APXvYqxsVJef8kZfO0OZOGa62m+IiMfMCOeyP5VAffiSvGds3r8NV5IgI3VYz6ToVZQ1kJk7bLUDBQ==
X-Received: by 2002:a1c:7312:: with SMTP id d18mr27458908wmb.147.1558011272314;
	Thu, 16 May 2019 05:54:32 -0700 (PDT)
Received: from [192.168.1.43] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228]) by smtp.gmail.com with ESMTPSA id
	h11sm6622282wrr.44.2019.05.16.05.54.31
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 May 2019 05:54:31 -0700 (PDT)
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20190516055244.95559-1-ysato@users.sourceforge.jp>
	<20190516055244.95559-13-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <d991b8bf-699c-d4a6-95f9-4c0c7c6d37e4@redhat.com>
Date: Thu, 16 May 2019 14:54:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516055244.95559-13-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH v13 12/12] MAINTAINERS: Add RX
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/16/19 7:52 AM, Yoshinori Sato wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  MAINTAINERS | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a73a61a546..ef6a02702e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -272,6 +272,13 @@ F: include/hw/riscv/
>  F: linux-user/host/riscv32/
>  F: linux-user/host/riscv64/
>  
> +RENESAS RX
> +M: Yoshinori Sato <ysato@users.sourceforge.jp>
> +S: Maintained
> +F: target/rx/
> +F: hw/rx/
> +F: include/hw/rx/
> +
>  S390
>  M: Richard Henderson <rth@twiddle.net>
>  M: David Hildenbrand <david@redhat.com>
> @@ -1106,6 +1113,18 @@ F: pc-bios/canyonlands.dt[sb]
>  F: pc-bios/u-boot-sam460ex-20100605.bin
>  F: roms/u-boot-sam460ex
>  
> +RX Machines
> +-----------
> +RX-QEMU
> +M: Yoshinori Sato <ysato@users.sourceforge.jp>
> +S: Maintained
> +F: hw/rx/rxqemu.c

This is now "hw/rx/rx-virt.c"

> +F: hw/intc/rx_icu.c
> +F: hw/timer/renesas_*.c
> +F: hw/char/renesas_sci.c
> +F: include/hw/timer/renesas_*.h
> +F: include/hw/char/renesas_sci.h

You missed:

F: include/hw/intc/rx_icu.h
F: default-configs/rx-softmmu.mak

With the 3 changes:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Richard, that would be nice if you can apply those changes directly ;)

> +
>  SH4 Machines
>  ------------
>  R2D
>

