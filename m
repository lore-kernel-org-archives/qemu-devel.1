Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E34C10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 16:32:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45774206A1
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 16:32:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45774206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIbMG-00044x-8r
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 12:32:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41047)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iIb2u-00072Z-Nr
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 12:12:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iIb2t-0007ki-O9
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 12:12:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36634)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iIb2t-0007k7-I9
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 12:12:07 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 98A15883CA
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 16:12:06 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id r187so3298120wme.0
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 09:12:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=x8jnxinEmKHzxvP+P3SVYOXAlo4nnlgwoEQhsYsxDB8=;
 b=plkmLHTtJz9dG78u1iiH8+jBdYlpXEWEKX0agUnNIgqQP/BHPBqpuhkMWKXHzRBul8
 uBSinSE7hsisju4bGyGGXJETzV29InW7f2gXVfo4Di/9koOoDBiC7nMgVHqxJXAR/Mnb
 ndfZ0UxWSZbLS18Lznka/a3+PobeMtL2mNyRJqC3osjWnJqWIzXdobhT00uVXF+qdeGQ
 slYcEFcFWvzo15cIxbFDPoZQ8pBNVIBhEVN7Xtr7G8gwIFUIREEuzjWRn52EW3maPzHO
 J0nW3qaebMcB/A1UNDYXJZ7qbiyfWaw+aQWIwnXWeooNyMSO6AMs2+rSx/lAIdxLIewI
 I0tg==
X-Gm-Message-State: APjAAAW31XmtooI9ehaWmoj0KDLCOGDgHd5z/wUSdoh42+4VJYnl8c4E
 C05UVbGYR1WHjmDPCdu7ytB4gXNWt6tm7pmTLvzajl4jrYfb9blecqrxDOFtbwo8JKWbh6T+0fD
 6UL2ac+exaVelIhA=
X-Received: by 2002:a1c:39d7:: with SMTP id g206mr8506165wma.7.1570723925424; 
 Thu, 10 Oct 2019 09:12:05 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzIylRooxxKIDwd/5A8N0JCxQ3Wt1rcUw7S8/iyLDLFaq2HDewxrQdK8h7nCg3rsghkHzjN6A==
X-Received: by 2002:a1c:39d7:: with SMTP id g206mr8506146wma.7.1570723925258; 
 Thu, 10 Oct 2019 09:12:05 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id b7sm7833791wrx.56.2019.10.10.09.12.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Oct 2019 09:12:04 -0700 (PDT)
Subject: Re: [PATCH v25 00/22] Add RX archtecture support
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org,
 richard.henderson@linaro.org
References: <20190927062302.110144-1-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <557c1c82-433a-c85d-c38d-d330f0ce499b@redhat.com>
Date: Thu, 10 Oct 2019 18:12:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190927062302.110144-1-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: peter.maydell@linaro.org, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/27/19 8:22 AM, Yoshinori Sato wrote:
> Hello.
> This patch series is added Renesas RX target emulation.

This series looks ready to get merged.

Note to the maintainer merging it, various Signed-off-by are misplaced 
and the Message-Id tags should be removed.

Regards,

Phil.

