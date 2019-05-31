Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C4CC04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 06:23:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FD0A2644C
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 06:23:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FD0A2644C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37386 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWaxK-0002uR-8e
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 02:23:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hWaw5-00029m-33
	for qemu-devel@nongnu.org; Fri, 31 May 2019 02:22:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hWaw3-0000X3-Cm
	for qemu-devel@nongnu.org; Fri, 31 May 2019 02:22:41 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38207)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hWaw3-0000Uy-5A
	for qemu-devel@nongnu.org; Fri, 31 May 2019 02:22:39 -0400
Received: by mail-wm1-f65.google.com with SMTP id t5so5114310wmh.3
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 23:22:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=enkrfyNEHaBvtaVchRZKZpa1sfjLnd/j/ZmTKC3Jdjs=;
	b=kKKzPHRVq77QR6AEzc3636VX+h0yNXo9yIIzZ2IUbExXRpF53ZF7hPP2BGv9WpqyrU
	4dFPxjZfJcXmfKIIiXWpdkIvHJDITOay31ezdVo3WlSpt8xIwLB7yxdHwJpWxlMsy8Qa
	XDd7/IfyM0lDs8pyCx7tch1sq9EZEXUig49nkGGT+2VmqDiLp43p9dildGGCNgY5uD9E
	Xa1ygszbzLP2/X51ibNP/ZKp5zolVaqqsf6JT5nJdVX6zCcP2guKTEGyGtUjpRZ1eMNz
	IQwYJys08VzNlu5VeVvLzIOb1wZUM8cuIFyt6RoOffCaCMHSHek2Ysn3DKW2pjZntm/I
	/9xg==
X-Gm-Message-State: APjAAAWHgg5CZo84/pBb8All5Nq2eoG9A7NPyOhTkmktQ3rEJRTwV9/k
	pbJZ45iiUKdCFanERDrH2P4uYw==
X-Google-Smtp-Source: APXvYqyM7m5tj0ZEGvD85aQTSKODomCVbNMHMbh9m68cIhvJUrnf87THuY95fVwU/ooY71IlflHPvA==
X-Received: by 2002:a7b:cbcc:: with SMTP id n12mr4669921wmi.167.1559283758127; 
	Thu, 30 May 2019 23:22:38 -0700 (PDT)
Received: from [192.168.1.43] (183.red-88-21-202.staticip.rima-tde.net.
	[88.21.202.183])
	by smtp.gmail.com with ESMTPSA id 95sm9590546wrk.70.2019.05.30.23.22.37
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 30 May 2019 23:22:37 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
References: <20190530101603.22254-1-alex.bennee@linaro.org>
	<20190530101603.22254-10-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <36317eb1-95be-5629-a92c-39f43caab02b@redhat.com>
Date: Fri, 31 May 2019 08:22:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190530101603.22254-10-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH v1 09/26] tests/vm: Use python configured
 on build
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
> Changed the vm-test makefile to execute python scripts
> with the interpreter configured on build. This allows to
> run vm-test targets properly in Linux distros with Python 3
> only support.
> 
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> Message-Id: <20190329210804.22121-2-wainersm@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  tests/vm/Makefile.include | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
> index 992d823f6bd..6f82676306d 100644
> --- a/tests/vm/Makefile.include
> +++ b/tests/vm/Makefile.include
> @@ -35,7 +35,7 @@ $(IMAGES_DIR)/%.img:	$(SRC_PATH)/tests/vm/% \
>  			$(SRC_PATH)/tests/vm/Makefile.include
>  	@mkdir -p $(IMAGES_DIR)
>  	$(call quiet-command, \
> -		$< \
> +		$(PYTHON) $< \
>  		$(if $(V)$(DEBUG), --debug) \
>  		--image "$@" \
>  		--force \
> @@ -46,7 +46,7 @@ $(IMAGES_DIR)/%.img:	$(SRC_PATH)/tests/vm/% \
>  # Build in VM $(IMAGE)
>  vm-build-%: $(IMAGES_DIR)/%.img
>  	$(call quiet-command, \
> -		$(SRC_PATH)/tests/vm/$* \
> +		$(PYTHON) $(SRC_PATH)/tests/vm/$* \
>  		$(if $(V)$(DEBUG), --debug) \
>  		$(if $(DEBUG), --interactive) \
>  		$(if $(J),--jobs $(J)) \
> 

