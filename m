Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB68FC04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 06:50:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2709255FA
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 06:50:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2709255FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37598 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWbMp-0008Os-Vn
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 02:50:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hWbLw-00088A-VF
	for qemu-devel@nongnu.org; Fri, 31 May 2019 02:49:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hWbLw-0001ca-03
	for qemu-devel@nongnu.org; Fri, 31 May 2019 02:49:24 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42218)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hWbLv-0001bA-QY
	for qemu-devel@nongnu.org; Fri, 31 May 2019 02:49:23 -0400
Received: by mail-wr1-f66.google.com with SMTP id l2so5679801wrb.9
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 23:49:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=CIt8LL66+ruje9XlWzhCi03qYSig3IgtceTPmAdxW1Y=;
	b=cv24WwTBYozL4U+Ak6PKHnQr7lcWwNydRTXt44SL1eI4/g8OhHUii9oCBBlre616Di
	WX1miKDrpGOQVW0RFjuo4ms3xM602HENhrYFDD7ME0OXKkjeMtqGZdIGiOY5jXW1sqWp
	O6iD0PjsRZvMsu9Lc1k4O/rXabr3+W1LDMK+Ua+q1vBYF01OieTSJuTRzb33gZl8+9cF
	0D/CZ1VKjfKFVUHWcRUfSQwBWYeSKpgsTsY8sczz/GVdXfvyT2xLQAH9v3rj4gENodmj
	n5Ddd5ajyHmAQQ6E1TWCTWxrP3SntE/DyQARz5d3QX+qO3cugz/cwafRHkZD4IpqqM+m
	nYqA==
X-Gm-Message-State: APjAAAU0tPOV0msnJEvKU04iJgU9Dc1PMhXZwyl16W9HgR+Lp9ZEROtf
	LfTc2IuQqNchaMnbyqmKPUV0Pw==
X-Google-Smtp-Source: APXvYqyOrr98iK0hN/piiOLLCc/N5rycoiZ5cQchtEnkVwqcjGg7OET/V508eYCYb9iFCq4p1LO8lQ==
X-Received: by 2002:a5d:52c7:: with SMTP id r7mr4259090wrv.110.1559285362969; 
	Thu, 30 May 2019 23:49:22 -0700 (PDT)
Received: from [192.168.1.43] (183.red-88-21-202.staticip.rima-tde.net.
	[88.21.202.183])
	by smtp.gmail.com with ESMTPSA id h8sm11232367wmf.5.2019.05.30.23.49.21
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 30 May 2019 23:49:22 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
References: <20190530101603.22254-1-alex.bennee@linaro.org>
	<20190530101603.22254-21-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <6c2efee2-31bb-68f2-12d0-684ca5959ad4@redhat.com>
Date: Fri, 31 May 2019 08:49:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190530101603.22254-21-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v1 20/26] tests/vm: add DEBUG=1 to help text
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi  Alex,

On 5/30/19 12:15 PM, Alex Bennée wrote:
> From: Gerd Hoffmann <kraxel@redhat.com>
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Tested-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <20190520124716.30472-9-kraxel@redhat.com>
> [AJB: fix minor conflict]
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/vm/Makefile.include | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
> index e329129bd65..628eecade78 100644
> --- a/tests/vm/Makefile.include
> +++ b/tests/vm/Makefile.include
> @@ -25,6 +25,8 @@ vm-test:
>  	@echo "  vm-boot-ssh-<guest>             - Boot guest and login via ssh"
>  	@echo
>  	@echo "Special variables:"
> +	@echo "    DEBUG=1                       - be verbose, also start interactive"
> +	@echo "	                                   shell on build failures"

Patch 12 of this series (tests/vm: Add missing variables on help)
already added this, it now appears 2 times:

Special variables:
    DEBUG=1                       - be verbose, also start interactive
                                           shell on build failures
    DEBUG=1                      - Enable verbose output on host and
interactive debugging

This one is more precise although...

>  	@echo "    BUILD_TARGET=foo		 - Override the build target"
>  	@echo "    TARGET_LIST=a,b,c    	 - Override target list in builds"
>  	@echo '    EXTRA_CONFIGURE_OPTS="..."'
> 

