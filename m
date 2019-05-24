Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81A7C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 05:18:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D25C20657
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 05:18:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D25C20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48970 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU2am-0002hd-RK
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 01:18:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hU2a0-0002Q6-Dw
	for qemu-devel@nongnu.org; Fri, 24 May 2019 01:17:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hU2Zz-0000V4-4J
	for qemu-devel@nongnu.org; Fri, 24 May 2019 01:17:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40981)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hU2Zx-0000Sc-J1
	for qemu-devel@nongnu.org; Fri, 24 May 2019 01:17:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id u16so4638224wrn.8
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 22:17:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=wIVChAZUgPtkEv6ZWKDNL9HS2rmE2V9jx7KId5XKAu4=;
	b=Onp34Vtu0AMFh8RlDaXN3KJOiS5F0pzantmYX5lC4RMyZLASEXP83Opb3dibrKWrNc
	7jxCWDUZDGIZXF2MbAYIYLmBqg3onk9FKlpywSmeK1gb4pNQyHb6P7+VsyqYLxeT7K+k
	LiGF5C1PVBRlkOzywKKMpRgZt3JdtdECn1EHP59xnAoHQiQ1gmnU9tRsGiuO5PLUuIyd
	DW7W8PMC0JH2WKKn/f2FCTuuxLRBo6f++RaDQw3lajhJ43zlfWJKyva/Y24AW4psp4og
	vRr3I29jdadc4YJPzXZxz20yO6l8I9Sx56d9FQFsfijjzP4EkKoxWFKfc6YmKSDbpdWm
	pG4A==
X-Gm-Message-State: APjAAAVEp2hIFY+naKFf4s1KseVBDbE8Lr90BQzwbRLCC9g7lWrcoN6Z
	/lBcdSTiqklssVHhU63f35R67w==
X-Google-Smtp-Source: APXvYqyXYyg3W9nT5HfEVQ9uOdvYhxN5mSd3wSLdqaVGlouttHJALItLR7lohBQNp9hXMgh9xpptHQ==
X-Received: by 2002:adf:eb02:: with SMTP id s2mr56582325wrn.29.1558675036708; 
	Thu, 23 May 2019 22:17:16 -0700 (PDT)
Received: from [192.168.1.43] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228]) by smtp.gmail.com with ESMTPSA id
	g11sm1066338wrx.62.2019.05.23.22.17.15
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 22:17:15 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190523081538.2291-1-armbru@redhat.com>
	<20190523081538.2291-3-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <f71ec5e1-ba7e-4b9e-fa5d-86f450601b77@redhat.com>
Date: Fri, 24 May 2019 07:17:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523081538.2291-3-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [RFC v4 2/7] Makefile: Drop bogus cleaning of
 $(ALL_SUBDIRS)/qemu-options.def
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
Cc: peter.maydell@linaro.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/23/19 10:15 AM, Markus Armbruster wrote:
> When commit df2943ba3c7 moved "rm -f qemu-options.def" from distclean
> to clean, it also added "rm -f $$d/qemu-options.def" to the for d in
> $(ALL_SUBDIRS) loop.  That file doesn't exist.  Remove the mistaken
> rm.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  Makefile | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 8ec833a5fb..12e470fa03 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -647,7 +647,6 @@ clean:
>  	rm -rf qga/qapi-generated
>  	for d in $(ALL_SUBDIRS); do \
>  	if test -d $$d; then $(MAKE) -C $$d $@ || exit 1; fi; \
> -	rm -f $$d/qemu-options.def; \
>          done
>  	rm -f config-all-devices.mak
>  
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

