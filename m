Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B87CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 08:51:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A75A320684
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 08:51:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A75A320684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNYpn-0001ii-SI
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 04:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37830)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1iNYQg-0000jP-6v
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 04:25:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1iNYQc-0003Yr-Gk
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 04:25:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46788)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1iNYQc-0003QV-9s
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 04:25:06 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 556EE81F13
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 08:25:04 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id v8so11504145wrt.16
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 01:25:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=PMK3FoVqeHtFAHu+Je0eiPFwasL9q0NBMhYVU8ZwzB4=;
 b=Dba1fZKBXVtRD3qrMSLnKBwN1adyjCBSIvG67Sx9iRnwT41n+AR+4bsRZIK58U4LjK
 3GfDbGVAHIRBzHbuRiHDFk4cEzzGDMvegvkHpeJjk6lSa4xQp+ICjjaKiOJtcrMJ/oEv
 RfkFN+tY+wuv8cYAqFeghPU00AsEh2Y1wDML3ynAdxGw1O4XyVFLLqvtpt7iyDGxf1K/
 xwkfd9BNlqMgyyQk+Wyw+gHR8VRlaRJX3GvHL8GlyTJ4S6CParrUmpss7NnP59gkJfv5
 aapl3o6Om/8JhlQpIk1KRWiNYcG4wHjcPGCwmixWpP2gkv6jvXoXA26kIPmZCWzhuaPu
 D98A==
X-Gm-Message-State: APjAAAUHA0BJlvBdc7+qdwAnukLk6Qyq36tBva4WxtHzBtlLxnGdhqvg
 X4/8Zh2CU/qQVozd2hzsj+0p9A2H/mKKS7RVLQO5ohOUSmg2YkNmOlgxJ+1u2j1M3srT5TZPoTP
 HQqxuBPX3s9f+vEc=
X-Received: by 2002:a1c:a551:: with SMTP id o78mr3490054wme.4.1571905502997;
 Thu, 24 Oct 2019 01:25:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwCrSfCK0gJgzYTlEHS/uh83ZkT3aeUAG/WwGkPpFjkyxCZ00GHxfDeo0ZBPSVKO59hOMMrkg==
X-Received: by 2002:a1c:a551:: with SMTP id o78mr3490027wme.4.1571905502713;
 Thu, 24 Oct 2019 01:25:02 -0700 (PDT)
Received: from steredhat (host174-200-dynamic.52-79-r.retail.telecomitalia.it.
 [79.52.200.174])
 by smtp.gmail.com with ESMTPSA id v128sm2945588wmb.14.2019.10.24.01.25.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 01:25:02 -0700 (PDT)
Date: Thu, 24 Oct 2019 10:25:00 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jidong Xia <xiajidong@cmss.chinamobile.com>
Subject: Re: [PATCH] hw/audio: fix a memory leak in OPLCreate()
Message-ID: <20191024082500.q3t4fmsc5crxp2yc@steredhat>
References: <1571824420-24893-1-git-send-email-xiajidong@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571824420-24893-1-git-send-email-xiajidong@cmss.chinamobile.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: qemu-devel@nongnu.org, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 23, 2019 at 05:53:40PM +0800, Jidong Xia wrote:
> There is a memory leak in OPLCreate(),Should free allocated mem
> before return.
> 
> Signed-off-by: Jidong Xia <xiajidong@cmss.chinamobile.com>
> ---
>  hw/audio/fmopl.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/audio/fmopl.c b/hw/audio/fmopl.c
> index 9f50a89..ca9825b 100644
> --- a/hw/audio/fmopl.c
> +++ b/hw/audio/fmopl.c
> @@ -1112,6 +1112,7 @@ FM_OPL *OPLCreate(int clock, int rate)
>  		opl_dbg_maxchip++;
>  	}
>  #endif
> +	free(ptr);
>  	return OPL;

I don't know this code well, but I don't think is correct to free 'ptr' in
the success case, since it is the pointer returned by this function that
will be freed by OPLDestroy().

Does that sound right or did I miss something?

Thanks,
Stefano

