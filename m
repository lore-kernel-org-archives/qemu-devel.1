Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC27C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 09:11:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92C0D20675
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 09:11:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92C0D20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51147 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOf5b-0008E0-P6
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 05:11:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hOf4i-0007Ti-NU
	for qemu-devel@nongnu.org; Thu, 09 May 2019 05:10:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hOf4h-0000CA-Vh
	for qemu-devel@nongnu.org; Thu, 09 May 2019 05:10:48 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:34649)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hOf4h-0000Bk-Oj
	for qemu-devel@nongnu.org; Thu, 09 May 2019 05:10:47 -0400
Received: by mail-wm1-f49.google.com with SMTP id m20so3717466wmg.1
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 02:10:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=Z3XlCPOS6wXqmxqlRkSZtI8P+8EHQho0tRi71AYaKNo=;
	b=GxTKsGDJXtt3DRQgVuCbojrlAcs/w6EduRFn5o3HJkOVYXm+f6d0JwCH15bBqqhxSR
	f+DSExigGt0Q9eEAJXUMV96b196rsScr7JVHCXyOx8Kc3+i/Gii/QvvRjLLIzYY60SYc
	05OlduMRMuboDpQncfhjhqz/cFvIRHYRGWPYw7xSf/UfzmksLW/mOfgJ1KCpSKV2wT30
	hgcQ5hzFreyZV7dggR0yAZupI5GVNuqKjs0JChRe1gXKw/TcXsEp0BYkBv9tRorQbeZZ
	pm5Yq08WBehZpt7b0Lyk27YnQYFatsTGDfXyoywHIb43i2aAnN0VzDkENx09xnhVnBRM
	lb/w==
X-Gm-Message-State: APjAAAWYtgtuGDVKSoPlQgON9iW92wp5xSeVTmFRVLLyfdFLM7AocMYJ
	3py9BI34j7C9FVlPnV7QSAwmZQ==
X-Google-Smtp-Source: APXvYqxRWww4yBl27dLzYcg84ZOtO0JEmS9WWzc7VFVb5fi3/FxP4cWe28mRFhBx8ThGSdjGNwk8dA==
X-Received: by 2002:a1c:c910:: with SMTP id f16mr2075004wmb.118.1557393046489; 
	Thu, 09 May 2019 02:10:46 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:f572:d55d:64bb:59f8?
	([2001:b07:6468:f312:f572:d55d:64bb:59f8])
	by smtp.gmail.com with ESMTPSA id
	u14sm1722280wrn.30.2019.05.09.02.10.45
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 02:10:45 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20190508150608.3311-1-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6cb2ea74-b3f8-09f3-90cb-e3b8344e67bd@redhat.com>
Date: Thu, 9 May 2019 11:10:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508150608.3311-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.49
Subject: Re: [Qemu-devel] [PATCH] include/exec/poison: Mark TARGET_FMT_lu as
 poisoned, too
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
Cc: qemu-trivial@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/05/19 10:06, Thomas Huth wrote:
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  include/exec/poison.h | 1 +
>  1 file changed, 1 insertion(+)

Queued, thanks.

Paolo

