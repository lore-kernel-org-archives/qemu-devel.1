Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFBCC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 08:16:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D5F92332A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 08:16:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D5F92332A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0LnU-0004BR-PZ
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 04:16:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50082)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i0Lln-0002BW-CK
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 04:15:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i0Lll-0001Yn-Qn
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 04:15:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50470)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i0Lll-0001YE-8B
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 04:15:01 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1830510F09
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 08:15:00 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id k10so852021wru.23
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 01:15:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=X5UNM1zBA3D+GmMuNFOZvPh1yV8TBGHdI0TpUL+1j1g=;
 b=uJS81oEHVfNVauevBoCqKh3SWqv2EwSJglE63vsot9tGYrb/46b/EOs8tma4s4sf3D
 SkKxPZag3hXRuQCjQwq7DYU63zhi+hMg7i5paxUP7a8gbmECNW2jH3Zh2cZ3OyM750p+
 jX+omiIB5QVGIAHCXe+GjKGVlsSZ5gonEx0np6Sl+ynsY3dkk+Qw5PzCUg9PMPHaOy8z
 dZwJwMYe5EVQ2oM76AaI3IEk/sZJ/8/hmbXw+LE+MKItWoh3/EPcVaYWmrGC7mvv3WAb
 lztgnrce60BRBVHAj5Fi7xAZr+TpUOYP+QNOiQbLE0gj2xpENh8uUp5NZuH5IbvzlgQh
 ppZQ==
X-Gm-Message-State: APjAAAW4whjcEcPX2E2A99uRXaTKmo5jFMsvrUTqjY7omQ68ZpShV11k
 NLjwmVQGbj8nPfkyhHQrPHn2V5bb3iW9NVeJYV2zapGP1GSXMq6Q6Nhj/ZWx1KwPQJmaPXci+2p
 Whp1xS6p75n6Odqo=
X-Received: by 2002:a05:600c:2486:: with SMTP id
 6mr4813799wms.80.1566375298544; 
 Wed, 21 Aug 2019 01:14:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzTak8u6RxPnxScPmFcoSaj9C9SToXqDEpO2TvHZNIowb8trbYfn7V9DlGemU1jPAuMhmj+pw==
X-Received: by 2002:a05:600c:2486:: with SMTP id
 6mr4813768wms.80.1566375298209; 
 Wed, 21 Aug 2019 01:14:58 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:56e1:adff:fed9:caf0?
 ([2001:b07:6468:f312:56e1:adff:fed9:caf0])
 by smtp.gmail.com with ESMTPSA id w13sm48147902wre.44.2019.08.21.01.14.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2019 01:14:57 -0700 (PDT)
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
References: <20190820141328.10009-1-peterx@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <701cecb0-0cc6-47eb-6ca6-1c66e94fb57d@redhat.com>
Date: Wed, 21 Aug 2019 10:14:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190820141328.10009-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 0/4] memory: Fix up coalesced_io_del not
 working for KVM
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Looks great, thanks!

I'm even squashing together 1/3/4 since it's actually quite readable and
the intermediate states aren't really bisectable.

Paolo

On 20/08/19 16:13, Peter Xu wrote:
> v3:
> - dropping patch 1 because I'm going to drop the has_coalesced_ranges
>   variable later...
> - moving previous patch 2 as patch 1 because I think it's definitely
>   solving a standalone issue of KVM, and also it'll introduce a helper
>   function that will be used in follow up patches.
> - added new patches
>   - patch 3: a cleanup and prepares for the next
>   - patch 4: fixes another issue when add/clear coalescing ranges that
>              Paolo pointed out
> 
> v2:
> - simply migrate has_coalesced_range in patch 1, while I added
>   comments in the code because that can be a bit unobvious [Paolo]
> 
> v1 is here:
> 
> https://lists.gnu.org/archive/html/qemu-devel/2019-08/msg03293.html
> 
> Peter Xu (4):
>   memory: Split zones when do coalesced_io_del()
>   memory: Remove has_coalesced_range counter
>   memory: Refactor memory_region_clear_coalescing
>   memory: Fix up memory_region_{add|del}_coalescing
> 
>  memory.c | 99 +++++++++++++++++++++++++++++---------------------------
>  1 file changed, 52 insertions(+), 47 deletions(-)
> 


