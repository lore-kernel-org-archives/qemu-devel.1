Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C651C04AAA
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 08:10:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21DDE2082F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 08:10:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21DDE2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52179 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNYht-0003Ga-Am
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 04:10:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNYgd-0002cn-Lf
	for qemu-devel@nongnu.org; Mon, 06 May 2019 04:09:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNYgc-0000J5-NQ
	for qemu-devel@nongnu.org; Mon, 06 May 2019 04:09:23 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43644)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hNYgc-0000IW-HY
	for qemu-devel@nongnu.org; Mon, 06 May 2019 04:09:22 -0400
Received: by mail-wr1-f66.google.com with SMTP id r4so703278wro.10
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 01:09:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=DJyW7hzwFfLhLUH1Z1bIcC2OS5qVEQgXup+qB9MtToM=;
	b=mr/EP3R4Wsl7B3N1CdllEYbCe3jDVGhe+gSkOl6YT41xcn5xtYp5aUP02riRfTBdEX
	fPGktQ3K+lVPWqBrcnBonREPtBiBmCPaGn+WQxpz/BtbMLwstyKASF88RXbjOzRRDFbr
	WVZtdNX+E+4fIt6bxsgPgbY0xMAhUE+5L2nIhFodh2KQ/AYUE6vocHuKZSyQWUMigk6U
	6MMvvfYIrTE/Y+wfXD+bgg6mB7zG3yzeq3v5uTSko++vOCwKWzNKGjDuiCtdewhDuXIz
	4Wt5tNp09pHdENZCZumEQq8oyZyYMhOD3RGggU31qwBZp7+x4J8Rc28PphTw5+cM9UdS
	asEg==
X-Gm-Message-State: APjAAAU+CelDLn50ggEBeQTyYapqVO+FyrLetZiOblCAh85VXnLI+el1
	8r2uRkl1bl0r2JCI5g5WRpnovQ==
X-Google-Smtp-Source: APXvYqxDu5XbP09ttBHAofmhIiiuAwrv032FQLjMQY3aYOnRW3ImiHhuPKKqn2bqskgWQ+17Qk+Q6Q==
X-Received: by 2002:adf:ef49:: with SMTP id c9mr14398786wrp.240.1557130161592; 
	Mon, 06 May 2019 01:09:21 -0700 (PDT)
Received: from [192.168.1.37] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	t81sm13682173wmb.47.2019.05.06.01.09.20
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 06 May 2019 01:09:21 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
	qemu-devel@nongnu.org
References: <20190506061854.22207-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <a0785ba5-2cf9-6aca-b468-35c67520afb7@redhat.com>
Date: Mon, 6 May 2019 10:09:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190506061854.22207-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [QEMU PATCH] MAINTAINERS: Downgrade status of
 block sections without "M:" to "Odd Fixes"
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
Cc: kwolf@redhat.com, qemu-trivial@nongnu.org, Niels de Vos <ndevos@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/6/19 8:18 AM, Thomas Huth wrote:
> Fixes might still get picked up via the qemu-block mailing list,
> so the status is not "Orphan" yet.
> Also add the gluster mailing list as suggested by Niels here:
> 
>  https://patchwork.kernel.org/patch/10613297/#22409943
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  MAINTAINERS | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 66ddbda9c9..899a4cd572 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2404,12 +2404,13 @@ F: block/ssh.c
>  
>  CURL
>  L: qemu-block@nongnu.org
> -S: Supported
> +S: Odd Fixes
>  F: block/curl.c

Fair enough.

>  GLUSTER
>  L: qemu-block@nongnu.org
> -S: Supported
> +L: integration@gluster.org
> +S: Odd Fixes
>  F: block/gluster.c

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

