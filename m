Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA839C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 07:39:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79D0526515
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 07:39:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79D0526515
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38013 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWc8q-0001HZ-KA
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 03:39:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hWc80-0000yf-Eo
	for qemu-devel@nongnu.org; Fri, 31 May 2019 03:39:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hWc7z-0003QT-EW
	for qemu-devel@nongnu.org; Fri, 31 May 2019 03:39:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40457)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hWc7z-0003Nr-76
	for qemu-devel@nongnu.org; Fri, 31 May 2019 03:39:03 -0400
Received: by mail-wr1-f67.google.com with SMTP id p11so947658wre.7
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 00:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to:user-agent;
	bh=l6wOF2MId10BMs9r/12ssCBm2FsrlcXoTRXhoU/QTRw=;
	b=PKGqupIyxRTcGgpPi1KHhVfYt7z/a2Ha7BT8eW3dKtfZhULP3D42O+DlmKMYv7bJdm
	QLfMADhQz+FSfpNzH5iFyWtLg+LqbS7KpK2xbS3tSWNc9Qq6mGRU46KLZJ+1fV/1zTim
	ermbZ1mTE6uEVwv7jX3n0KCWpGuAxQ2/A8oTPRSlZINBVLul0Poa2LKM7/CeBAFoxy+0
	/MPUSTZjbd/nA50RF1chRu5gPknPB3XrkR+X2S5X2BJ4dSCQ+eo17CfnPtw9GuZ3uIeJ
	wmZN0OqJFh4ruD1sHMcWRzTVBvmPZJMA32ZqytwqCb4oHRkCQcui9qR4EO3ma0kAmq7n
	n48Q==
X-Gm-Message-State: APjAAAW4un9bw1g0YWGVZGFzopliHBjekNiLERPTTJzH1IAJ/7/JL/De
	4q7vDY3trU6TgAH7otuvCCk+9Q==
X-Google-Smtp-Source: APXvYqzoXjGkLGFl8q9QP003LSbhyr3KCuI3Y++vpA+7SGbUohzko9hPJ+EVxZBf2YOgvbtZf2iHwQ==
X-Received: by 2002:adf:e841:: with SMTP id d1mr5483878wrn.204.1559288341926; 
	Fri, 31 May 2019 00:39:01 -0700 (PDT)
Received: from steredhat.homenet.telecomitalia.it
	(host253-229-dynamic.248-95-r.retail.telecomitalia.it.
	[95.248.229.253])
	by smtp.gmail.com with ESMTPSA id d9sm4438426wro.26.2019.05.31.00.39.00
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 31 May 2019 00:39:01 -0700 (PDT)
Date: Fri, 31 May 2019 09:38:59 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Message-ID: <20190531073859.ojouyr3urzcarn4f@steredhat.homenet.telecomitalia.it>
References: <20190531064341.29730-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190531064341.29730-1-philmd@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH] Makefile: Rename the 'vm-test' target as
 'vm-help'
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
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 31, 2019 at 08:43:41AM +0200, Philippe Mathieu-Daudé wrote:
> We already have 'make check-help', use the 'make vm-help' form
> to display helps about VM testing. Keep the old target to not
> bother old customs.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> Based-on: <20190530101603.22254-1-alex.bennee@linaro.org>
>           "testing/next queue"
> ---
>  Makefile                  | 4 ++--
>  docs/devel/testing.rst    | 4 ++--
>  tests/vm/Makefile.include | 5 +++--
>  3 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index f0be624f47..f67739df7c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -9,7 +9,7 @@ SRC_PATH=.
>  UNCHECKED_GOALS := %clean TAGS cscope ctags dist \
>      html info pdf txt \
>      help check-help print-% \
> -    docker docker-% vm-test vm-build-%
> +    docker docker-% vm-help vm-test vm-build-%
>  
>  print-%:
>  	@echo '$*=$($*)'
> @@ -1121,7 +1121,7 @@ endif
>  	@echo  'Test targets:'
>  	@echo  '  check           - Run all tests (check-help for details)'
>  	@echo  '  docker          - Help about targets running tests inside Docker containers'
> -	@echo  '  vm-test         - Help about targets running tests inside VM'
> +	@echo  '  vm-help         - Help about targets running tests inside VM'
>  	@echo  ''
>  	@echo  'Documentation targets:'
>  	@echo  '  html info pdf txt'
> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
> index da2d0fc964..68aba3926e 100644
> --- a/docs/devel/testing.rst
> +++ b/docs/devel/testing.rst
> @@ -399,12 +399,12 @@ VM testing
>  
>  This test suite contains scripts that bootstrap various guest images that have
>  necessary packages to build QEMU. The basic usage is documented in ``Makefile``
> -help which is displayed with ``make vm-test``.
> +help which is displayed with ``make vm-help``.
>  
>  Quickstart
>  ----------
>  
> -Run ``make vm-test`` to list available make targets. Invoke a specific make
> +Run ``make vm-help`` to list available make targets. Invoke a specific make
>  command to run build test in an image. For example, ``make vm-build-freebsd``
>  will build the source tree in the FreeBSD image. The command can be executed
>  from either the source tree or the build dir; if the former, ``./configure`` is
> diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
> index 5e37063d32..b7311d7bd9 100644
> --- a/tests/vm/Makefile.include
> +++ b/tests/vm/Makefile.include
> @@ -8,8 +8,9 @@ IMAGE_FILES := $(patsubst %, $(IMAGES_DIR)/%.img, $(IMAGES))
>  
>  .PRECIOUS: $(IMAGE_FILES)
>  
> -vm-test:
> -	@echo "vm-test: Test QEMU in preconfigured virtual machines"

What about adding something like this?
vm-test: vm-help
	@echo ""
	@echo "vm-test is deprecated, please use vm-help"

> +# 'vm-help' target was historically named 'vm-test'
> +vm-help vm-test:
> +	@echo "vm-help: Test QEMU in preconfigured virtual machines"
>  	@echo
>  	@echo "  vm-build-ubuntu.i386            - Build QEMU in ubuntu i386 VM"
>  	@echo "  vm-build-freebsd                - Build QEMU in FreeBSD VM"
> -- 
> 2.20.1
> 

With or without the vm-test message:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

