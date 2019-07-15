Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64715C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 09:00:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 348B020868
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 09:00:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 348B020868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmwqN-0007ED-9Y
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 05:00:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44875)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hmwq7-0006ZL-KL
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 05:00:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hmwq6-0005R8-Bz
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 05:00:07 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36503)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hmwq6-0005Nc-1M
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 05:00:06 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so16206376wrs.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 02:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=h04AUmzXzsMNQ+8jBBE3QW+zFoi7B7raryiOrieWp4w=;
 b=Q3jPAAkA0cruMQh47u9GK0ExvMCjgYhS5nXCzUfkFsGQ+oUHsHIY+Li1WztqCsXbIX
 tIv7oyeH2pU3ycquNT8OQvChy0Ngq6aFO5KorZm1AS3RI0+YqJ663Vm5TZnmDW1N5ysu
 0C5U4txcf7SDwkejENOu9wF4jTHcEa4yZwKB8Eid429AzU7P0k1NLY/pPE0c09gy9Ct4
 5FC4dWT+xPK5hS8HhkmTyEp9SuGdCwOvmJkHQdy3fieWjFy/UrUM1xUJ2mw4a1TnaYN6
 ZIkho+zD2+dtJ4O7QXqLQsJVMVLk9BFbgb3SG7pUW5B6aF3Jpuhpa3o3WJdiOQYUKMun
 9ruQ==
X-Gm-Message-State: APjAAAUqzxQtbxwRsKOTdt+lb7mS9egJiM8NwJedsbvoAk9+4KV+ACy0
 J4plcEHzSsuLPdvOkJBKGw7SBA==
X-Google-Smtp-Source: APXvYqxTHfcrajpRwnXQajjRr/I4jBBMZh8MfCusOOGSfXTfQJMkgOTrepZQW1FxCWoo0EEBBd6nlA==
X-Received: by 2002:a5d:53ca:: with SMTP id a10mr28228432wrw.131.1563181203293; 
 Mon, 15 Jul 2019 02:00:03 -0700 (PDT)
Received: from [192.168.1.37] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id s15sm3058393wrw.21.2019.07.15.02.00.02
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Jul 2019 02:00:02 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190715055736.15214-1-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <d13965c7-f0cf-4b53-3388-8ce0a26d206d@redhat.com>
Date: Mon, 15 Jul 2019 11:00:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190715055736.15214-1-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH for-4.1 0/2] qemu-doc build fixes
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/15/19 7:57 AM, Markus Armbruster wrote:
> Markus Armbruster (2):
>   Makefile: Fix missing dependency of on qemu-tech.texi
>   qemu-tech: Fix dangling @menu entries
> 
>  Makefile       | 3 ++-
>  qemu-tech.texi | 3 ---
>  2 files changed, 2 insertions(+), 4 deletions(-)

Series:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Thanks!

