Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C26DAC3A59D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 10:28:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98AF8233A2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 10:28:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98AF8233A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0kKN-0004tA-Ef
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 06:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34250)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i0kGk-0001j2-Gx
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 06:24:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i0kGj-0000a8-0v
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 06:24:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39396)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i0kGi-0000ZW-RW
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 06:24:36 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A4AD02D0FCE
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 10:24:35 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id d64so2762167wmc.7
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 03:24:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gFuSvWt36Q6iT39X+6eI17hmIDTYdDFgkEmhvb7j5uM=;
 b=jR7cgCD37UT4JMuSdGqLm8IBsMz6pjPAbC2P3w4/eTG5RWnFbyDuyITAc4WjuF45qg
 A/UWrg58uZQ7wUSSL6kpgtKjrQW6+LH6mvdA031ihsGvVmvGqCXNJ89BiZu8MQhtKmbq
 19UDLjqRkR368PsIbw+g5qAI+E2Oj0eJw9GiS02E5TGZA5js+/ZLZTaAjGiIA6VqyQzG
 sz+R9Rii1gN8qh4cW9AQ2rIrzL/5er8kn26Tjo4sFqKrHjD1UY++j06jxPKzTjxQaMcE
 usJRfjHrtKosrV8PHE20FOSYEDZiSvUwTcrnOs6jso+P3jOum3cuuTXTASKmV1sCxeCH
 kyyg==
X-Gm-Message-State: APjAAAUf7J4q5II3lkzF3NEhO7kuMA969sY7IRd5YijZTEaeyh43B+0I
 ztJbCt8r+pvc+zRL1VqerhsajWAG8+i2j0ZqA8J1/O3TCqSJsO3D4Ohqrk9840oXhzzI+nB8fYs
 LKUNBg8EuLeAKWLU=
X-Received: by 2002:adf:ef05:: with SMTP id e5mr46565394wro.158.1566469474224; 
 Thu, 22 Aug 2019 03:24:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyQzjBu6sZF7eQ6Ao50+rGb1S8fxCZ+AJ3TXd2tqWkzD/4BnrdxXAvaTxf1+5nCFCRWwlfZfw==
X-Received: by 2002:adf:ef05:: with SMTP id e5mr46565352wro.158.1566469473900; 
 Thu, 22 Aug 2019 03:24:33 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:21b9:ff1f:a96c:9fb3?
 ([2001:b07:6468:f312:21b9:ff1f:a96c:9fb3])
 by smtp.gmail.com with ESMTPSA id 4sm46502044wro.78.2019.08.22.03.24.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Aug 2019 03:24:33 -0700 (PDT)
To: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org
References: <20190321082555.21118-1-richardw.yang@linux.intel.com>
 <20190321082555.21118-3-richardw.yang@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <d5fb9e01-acb9-06ab-edf9-57e2b80bd880@redhat.com>
Date: Thu, 22 Aug 2019 12:24:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190321082555.21118-3-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/6] exec.c: remove an unnecessary assert
 on PHYS_MAP_NODE_NIL in phys_map_node_alloc()
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
Cc: rth@twiddle.net, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/03/19 09:25, Wei Yang wrote:
> PHYS_MAP_NODE_NIL is assigned to PhysPageEntry.ptr in case this is not a
> leaf entry, while map->nodes_nb range in [0, nodes_nb_alloc).
> 
> Seems we are asserting on two different things, just remove it.

The assertion checks that this "if" is not entered incorrectly:

    if (lp->skip && lp->ptr == PHYS_MAP_NODE_NIL) {
        lp->ptr = phys_map_node_alloc(map, level == 0);
    }

Paolo

> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>  exec.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/exec.c b/exec.c
> index 98ebd0dd1d..8e8b6bb1f9 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -242,7 +242,6 @@ static uint32_t phys_map_node_alloc(PhysPageMap *map, bool leaf)
>  
>      ret = map->nodes_nb++;
>      p = map->nodes[ret];
> -    assert(ret != PHYS_MAP_NODE_NIL);
>      assert(ret != map->nodes_nb_alloc);
>  
>      e.skip = leaf ? 0 : 1;
> 


