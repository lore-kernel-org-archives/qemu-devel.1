Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346E4C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 11:47:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C7FC206B8
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 11:47:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C7FC206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmzSW-0004vU-2c
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 07:47:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55021)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hmzSK-0004Wv-Hd
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 07:47:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hmzSJ-0002j1-Im
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 07:47:44 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39862)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hmzSJ-0002g0-Cn
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 07:47:43 -0400
Received: by mail-wm1-f66.google.com with SMTP id u25so4507371wmc.4
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 04:47:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Bx1Mj43e3L8tkr656L0fZ5aV1gQG/Os3tmEURzqk3Js=;
 b=jfjy01DEv9c44wG9v0b2CoUzjF2OXXXhz7/cDSXOjfvPYtph0hO+PeOgZUR+P9U/2r
 BZwRK0pgkP8Wd3JP1qKRwPe8VqwkI7QHcTBjhZuQJE8kJi7OFiAv01wS2yv3Rb8yM8uB
 HstVQvbJpVsy/UfuYRNjIDZa0y1muGQHhb40cKNNlmiEtZpmJyfCPt8eXKvh6WS+fJZZ
 8XvX/99z1WFyolY6F60p3aIpsBvtGfRIb5HU9jVAMaH+HCiy9QiziA1BfAnk10X4jHid
 3ejKAwM//Q57GWY2jalCJtA/xv62sTmBLRKT1KgTvMHDLEFDb9fONt0YT3p6WIRWTAHD
 lB4w==
X-Gm-Message-State: APjAAAVhC+X0EiyKTdcH0mGUH7C0MUce2glUQCAjIEjrMauNZsQHPcRw
 L58XmQgBq3vldr4FjTv3dnialg==
X-Google-Smtp-Source: APXvYqzqegGXsRh7cKN9bHkkk62a795s6AoWdcy1E+LZLCp5zpER6cbSlywXqfmKOxQTBO1+uX5eMA==
X-Received: by 2002:a1c:cb43:: with SMTP id b64mr23963659wmg.135.1563191262039; 
 Mon, 15 Jul 2019 04:47:42 -0700 (PDT)
Received: from [192.168.1.37] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id y16sm36157376wrg.85.2019.07.15.04.47.41
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Jul 2019 04:47:41 -0700 (PDT)
To: qemu-devel@nongnu.org
References: <20190714124755.14356-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <ebd6d5a3-4f3e-b0ef-50c7-333996375b96@redhat.com>
Date: Mon, 15 Jul 2019 13:47:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190714124755.14356-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH-for-4.1] hw/lm32/Kconfig: Milkymist One
 provides a USB 1.1 Controller
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
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Walle <michael@walle.cc>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/14/19 2:47 PM, Philippe Mathieu-Daudé wrote:
> The Milkymist SoftUSB block provides the OHCI USB standard
> (missed in 0858746b835).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/lm32/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/lm32/Kconfig b/hw/lm32/Kconfig
> index 3d09c2dd6f..ed2e3060b0 100644
> --- a/hw/lm32/Kconfig
> +++ b/hw/lm32/Kconfig
> @@ -11,3 +11,4 @@ config MILKYMIST
>      select PFLASH_CFI01
>      select FRAMEBUFFER
>      select SD
> +    select USB_OHCI
> 

Markus asked me how I noticed that, if it was auditing the code.

I ran 'qemu-system-lm32 -device help' and noticed all the USB devices
had disappeared.

