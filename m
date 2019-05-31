Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23CDC04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 06:46:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6E7F264B1
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 06:46:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6E7F264B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37582 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWbIo-0007Kx-W3
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 02:46:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hWbHs-0006xH-Kj
	for qemu-devel@nongnu.org; Fri, 31 May 2019 02:45:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hWbHr-0000rs-K4
	for qemu-devel@nongnu.org; Fri, 31 May 2019 02:45:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34071)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hWbHr-0000oj-DO
	for qemu-devel@nongnu.org; Fri, 31 May 2019 02:45:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id f8so5708217wrt.1
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 23:45:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=Elkz7JbyyVOqgRr93mxVz0FuJGQLZ6ES/70s5IOKKLQ=;
	b=Sh5YTbLfpCHwNhKEud/1y6/92A15AoxnKY8Io/Q0vKWPCGDF91S70a/1vJ6U28EY9L
	P/oar1tC1w6qmgim8qWAIqcUHlHmW4Xl/ONwqf+A4GzVXfNzndCNuJH2CG+GXvDz24UA
	PFBs0LMG9QbkKwxWPup2xiX3JwTqEpfa/CtUT+v3IL9iHeKNoYEIq2Yu7d7xllAxuVVu
	tN9I/ZvO3gq1U7MH89MLKid2g5KTP2ydN49FCme3/tOQPHGepVnmF+bVt+pjVM5PeKi7
	l7EMK3NCOh3R//062ugZQoMl0QjZiVuPzyeU8SnLhLwB2Pz4COvW7xXpvnGyXdfU5wDc
	E42g==
X-Gm-Message-State: APjAAAVwgxqVUjniG9D4LBSb/BLxQY+e7FPtbl/xz18Opa8nVK5ojoNu
	+tCjGhrBp49kBBKk8P8aX+HLTQ==
X-Google-Smtp-Source: APXvYqwyIEI+9H9zfcMBbnUOTb/JkM3VOHNjutptW6QPWqSR3Sfh72QxnShoms5XghauRYd6X/zGJQ==
X-Received: by 2002:adf:fc8f:: with SMTP id g15mr5142508wrr.122.1559285110244; 
	Thu, 30 May 2019 23:45:10 -0700 (PDT)
Received: from [192.168.1.43] (183.red-88-21-202.staticip.rima-tde.net.
	[88.21.202.183]) by smtp.gmail.com with ESMTPSA id
	y132sm7328966wmd.35.2019.05.30.23.45.09
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 30 May 2019 23:45:09 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
References: <20190530101603.22254-1-alex.bennee@linaro.org>
	<20190530101603.22254-13-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <ff7756d2-6a38-1477-ad38-4f4686094c0b@redhat.com>
Date: Fri, 31 May 2019 08:45:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190530101603.22254-13-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v1 12/26] tests/vm: Add missing variables
 on help
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
Cc: Fam Zheng <fam@euphon.net>,
	Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/30/19 12:15 PM, Alex Bennée wrote:
> From: Wainer dos Santos Moschetta <wainersm@redhat.com>
> 
> Added description of variables missing on vm-test help.
> 
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> Message-Id: <20190329210804.22121-6-wainersm@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/vm/Makefile.include | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
> index 6f82676306d..c59411bee01 100644
> --- a/tests/vm/Makefile.include
> +++ b/tests/vm/Makefile.include
> @@ -21,9 +21,13 @@ vm-test:
>  	@echo "  vm-clean-all                    - Clean up VM images"
>  	@echo
>  	@echo "Special variables:"
> -	@echo "    BUILD_TARGET=foo		 - override the build target"
> -	@echo "    TARGET_LIST=a,b,c    	 - Override target list in builds."
> +	@echo "    BUILD_TARGET=foo		 - Override the build target"
> +	@echo "    TARGET_LIST=a,b,c    	 - Override target list in builds"
>  	@echo '    EXTRA_CONFIGURE_OPTS="..."'
> +	@echo "    J=[0..9]*            	 - Override the -jN parameter for make commands"
> +	@echo "    DEBUG=1              	 - Enable verbose output on host and interactive debugging"
> +	@echo "    V=1				 - Enable verbose ouput on host and guest commands"
> +	@echo "    QEMU=/path/to/qemu		 - Change path to QEMU binary"
>  
>  vm-build-all: $(addprefix vm-build-, $(IMAGES))
>  
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

