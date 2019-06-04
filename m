Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40793C28CC6
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 05:33:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19FF62440F
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 05:33:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19FF62440F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46000 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hY24k-0002t2-92
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 01:33:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hY23M-0002GV-7P
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 01:32:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hY23L-0002UY-By
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 01:32:08 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45575)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hY23L-0002Sg-6W
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 01:32:07 -0400
Received: by mail-wr1-f66.google.com with SMTP id b18so14310515wrq.12
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 22:32:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=ME+de7G7kPlvL1eBvVBSn8nzj27BFrwDCVfSAJv+SO4=;
	b=gktoRUX2IuaIxi1b2h9vtb68rcnPwFUGFWi5vxzedlm3EJeYQU3E+ZTj+22qcYrX+K
	ctNtT0kQV4wf+cFtUmUvWgcm8+E/F0e91BOHxnTjd+41woz5/2jC7YjbQ2pmsoHcoXx+
	75OJtK78F4VsD59TtJI3wEZw4BlLcWAa6nLt3DmPokuVVj3AUH9o4FMZWwMaMcht8NBI
	ODmQEbqXyM5TRwoqYeW+cbdEo3Hun0vDC3sCDYIormVwrT0yMjOIhtO69U/E8WV0xkrt
	eGuCa7klZIAtVTgqw7EQNtIEnkFaIWcJKM1dXFEaqenIBYUtc8WQTQiGju8DdsRxRN+o
	RVXA==
X-Gm-Message-State: APjAAAVaJ/8/qX6gQP2+EyG/8lu4TslqZFqCKslRPP1sMcFlsA6bWpyV
	9wCTMCKGFIqNjh6FTaLKRpFviA==
X-Google-Smtp-Source: APXvYqzT9N/M3X5lQy2B7gp0saazMw9qhqD2okJhq+J1NzRZlIFdNk9MZLZ8LN+a2vgd+uAsG54+uw==
X-Received: by 2002:a5d:554f:: with SMTP id g15mr18911020wrw.318.1559626326085;
	Mon, 03 Jun 2019 22:32:06 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
	[88.21.202.183])
	by smtp.gmail.com with ESMTPSA id v6sm5235772wru.6.2019.06.03.22.32.05
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 22:32:05 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190531134315.4109-1-richard.henderson@linaro.org>
	<20190531134315.4109-13-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <ca987c52-f3c2-9799-2c7a-312c87e00e2a@redhat.com>
Date: Tue, 4 Jun 2019 07:32:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190531134315.4109-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v16 12/23] target/rx: Add RX to SysEmuTarget
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
Cc: Markus Armbruster <armbru@redhat.com>, ysato@users.sourceforge.jp
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/31/19 3:43 PM, Richard Henderson wrote:
> Fixes check-qtest-rx: tests/qmp-cmd-test
> 
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  qapi/common.json | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/qapi/common.json b/qapi/common.json
> index 99d313ef3b..d0fc931159 100644
> --- a/qapi/common.json
> +++ b/qapi/common.json
> @@ -183,6 +183,7 @@
>  #        is true even for "qemu-system-x86_64".
>  #
>  # ppcemb: dropped in 3.1
> +# rx: added in 4.1
>  #
>  # Since: 3.0
>  ##
> @@ -190,6 +191,6 @@
>    'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa', 'i386', 'lm32',
>               'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
>               'mips64el', 'mipsel', 'moxie', 'nios2', 'or1k', 'ppc',
> -             'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
> +             'ppc64', 'riscv32', 'riscv64', 'rx', 's390x', 'sh4',
>               'sh4eb', 'sparc', 'sparc64', 'tricore', 'unicore32',
>               'x86_64', 'xtensa', 'xtensaeb' ] }
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

