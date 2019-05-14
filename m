Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D6BC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 17:11:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B5CA2084A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 17:11:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B5CA2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51420 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQaxf-0004Zu-N7
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 13:11:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hQau1-0001D5-Ko
	for qemu-devel@nongnu.org; Tue, 14 May 2019 13:07:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hQamg-0003Us-A9
	for qemu-devel@nongnu.org; Tue, 14 May 2019 13:00:11 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33617)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hQamg-0003To-4T
	for qemu-devel@nongnu.org; Tue, 14 May 2019 13:00:10 -0400
Received: by mail-wm1-f66.google.com with SMTP id c66so2810493wme.0
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 10:00:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=h9AOnCLueME9f+uOyX+juJN1gfzEWa2awgFUucETZcs=;
	b=HXxMwQWX7R6qHf7hAn3c+rjup1CcxQbR/LPIAELmR/kmrW5n7cZso7EhYgZ5dMQXNI
	3IKizdIFHskU7mQb3uCYBVAEfANXd1H+UP2oQuhtubneqkpcPhAoQdtMRySu08IHKm/X
	U68i3wsB7nunN2LrU6uSJr+4U6gMhqcP00RUslLZUtqwPdBlFnc4TkSQIoeNJ+e9YsBO
	aoohcbCztg/Tv6tfSZyMr0Ce9Uv8Gpo3+lho2KrqEjtXzxtQxAYSaFWINTnfTOHZrnZG
	mfrAAO9txzaWdc4nvul7a027n/Mx/g8L1ezWsZsxcD1LOsrSi7rLBf9DQrTIJhzM/+Fn
	kbxQ==
X-Gm-Message-State: APjAAAWR4ce9FWGUfnojmT8Yi0puCgkQC7qjoX6S23sDdc25sWVAW/ua
	ZDDQsCrPTiQ1g7aecvz+OolT0w==
X-Google-Smtp-Source: APXvYqxy1liWWpb8M+h0UVSjMtrH8k8ZKSgTThfmHiOusa4Ab+uOGM828rZIFn+W/Fm4xJsIPY4cSg==
X-Received: by 2002:a1c:6502:: with SMTP id z2mr19270880wmb.119.1557853209200; 
	Tue, 14 May 2019 10:00:09 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193])
	by smtp.gmail.com with ESMTPSA id z4sm3633476wru.69.2019.05.14.10.00.08
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 10:00:08 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
References: <20190514155301.16123-1-alex.bennee@linaro.org>
	<20190514155301.16123-12-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <55ff9fcc-0431-befb-2b66-3803ea85b64d@redhat.com>
Date: Tue, 14 May 2019 19:00:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514155301.16123-12-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [RFC PATCH 11/11] MAINTAINERS: update for
 semihostings new home
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
Cc: qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/14/19 5:53 PM, Alex Bennée wrote:
> Seeing as I touched it I should at least keep an eye on it.

Thanks for that.

> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

FWIW:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a73a61a5465..e9050beb222 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2559,6 +2559,13 @@ F: docs/pvrdma.txt
>  F: contrib/rdmacm-mux/*
>  F: qapi/rdma.json
>  
> +Semihosting
> +M: Alex Bennée <alex.bennee@linaro.org>
> +L: qemu-devel@nongnu.org
> +S: Maintained
> +F: hw/semihosting/
> +F: include/hw/semihosting/
> +
>  Build and test automation
>  -------------------------
>  Build and test automation
> 

