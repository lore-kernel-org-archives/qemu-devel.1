Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81730C7618F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 14:47:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58B2C2173B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 14:47:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58B2C2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnlDi-0006dv-DM
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 10:47:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45976)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hnlDW-0006DN-TC
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 10:47:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hnlDV-0002Js-Ps
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 10:47:38 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35582)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hnlDV-0002Gp-JC
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 10:47:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id y4so25158635wrm.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 07:47:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/ggKdWtlQwFyOb8+KKEvP5iXZq/excFZiXGjj8Cuo5A=;
 b=W7g2R6LQeuBQ2NSgUcfGUquHmfqXsXFjtvs2hrJ8yb6A94gEmd5AemgjbC31/dM/Sv
 mx6rBleDD7TIlXZW3D5BqB+y9gEP6hWWFJMK5N0vEWghNO+/id0duWZjnAfAkBSk+NcG
 xPr8DvIRGmZHN9gOnHh17tCVaBOafS7csn6ony2aRTAH4lLAQqRr32L7gqYhutdDGpBZ
 QUlgvzOXxgFzW0+IBixLncAh4TBddeXl4SLALXxdU9OC0xSBmGyLBUtGBoa2+mevfSxu
 VtoA9wGoFDLDt3VK48bnn28dwpMlmo/FhzmKLw+cLZB/+k0UZYb25RROD3FAF6qCnPvA
 R/ig==
X-Gm-Message-State: APjAAAW6Srr3OUgnAWXG7ky2KEImXkP3m4XcaQ9PXgvwBEes+lqoQPub
 qMZVj6+U1BAASI0CPBQHC+za1A==
X-Google-Smtp-Source: APXvYqx9tVhaYOZBVash9ynMslK4YnAzuVzR6ZFJxJE92aePeSw9d6h2k+TMAft0KZt5sPzvVYfJGw==
X-Received: by 2002:a5d:670b:: with SMTP id o11mr43731775wru.311.1563374854267; 
 Wed, 17 Jul 2019 07:47:34 -0700 (PDT)
Received: from [10.201.33.29] ([195.166.127.210])
 by smtp.gmail.com with ESMTPSA id z1sm25972582wrv.90.2019.07.17.07.47.33
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 17 Jul 2019 07:47:33 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190717134335.15351-1-alex.bennee@linaro.org>
 <20190717134335.15351-17-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <90652c6d-fe54-9935-a5a1-8592eed20dd7@redhat.com>
Date: Wed, 17 Jul 2019 16:47:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190717134335.15351-17-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v2 16/23] NSIS: Add missing firmware blobs
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
Cc: Stefan Weil <sw@weilnetz.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/17/19 3:43 PM, Alex Bennée wrote:
> From: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> Various firmwares has been added in the pc-bios/ directory:
> 
> - CCW     (since commit 0c1fecdd523)
> - Skiboot (since commit bcad45de6a0)
> - EDK2    (since commit f7fa38b74c3)
> 
> Since we install qemu-system able to run the architectures
> targetted by these firmware, include them in the NSIS exe.
> 

This one has:
Acked-by: Laszlo Ersek <lersek@redhat.com>

https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg03594.html

> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Message-Id: <20190715174817.18981-10-philmd@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  qemu.nsi | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/qemu.nsi b/qemu.nsi
> index 75f1608b9e0..89c7c04f957 100644
> --- a/qemu.nsi
> +++ b/qemu.nsi
> @@ -122,6 +122,9 @@ Section "${PRODUCT} (required)"
>      File "${BINDIR}\*.bmp"
>      File "${BINDIR}\*.bin"
>      File "${BINDIR}\*.dtb"
> +    File "${BINDIR}\*.fd"
> +    File "${BINDIR}\*.img"
> +    File "${BINDIR}\*.lid"
>      File "${BINDIR}\*.rom"
>      File "${BINDIR}\openbios-*"
>  
> 

