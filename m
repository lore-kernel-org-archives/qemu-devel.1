Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8C1C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 08:15:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 045302075C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 08:15:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 045302075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36363 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMTLc-0003PM-9R
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 04:15:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hMTKh-0002sR-Oy
	for qemu-devel@nongnu.org; Fri, 03 May 2019 04:14:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hMTKg-00017b-NL
	for qemu-devel@nongnu.org; Fri, 03 May 2019 04:14:15 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51930)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hMTKg-00016d-HY
	for qemu-devel@nongnu.org; Fri, 03 May 2019 04:14:14 -0400
Received: by mail-wm1-f67.google.com with SMTP id t76so5992582wmt.1
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 01:14:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=3W13dyiPCJiTr+O1bcLLPyqHVcb7B6SyKBLO5w+yPds=;
	b=hfEiz8QEmZcTRyDZlnqEAPxSrpmfxdHQK0XV/2ZzkDJ4KhBO17rRwu4SRsvUI9VF0I
	7Y1DW90jVaNx/YSN222O49stfYr0NDp8dGZvEpa4jF3ij4MGCExWaO/Rq1GpCLNAWSvT
	da42cYicKxZy67dYkjZf5yAL1v1Vxsen7kH0A8WVQK3u44hIWJXVsmWD6SqHLU5i9+og
	06v8bBWnrpePkCpkXeTJxcLF2xBS8NKsA0HQjXZCx5+4+VwFQL210OYonfSay2Kus2UB
	BmjqIpKcfM7N7mF2UMWWNhZ4T1sik7fpxcLY9JqJRFQpRMB0HiRpKpF01LZZYmisbvjN
	LndA==
X-Gm-Message-State: APjAAAXqezthddmcmbeGD5BgqBicLKBSoT2RBQW/JTb2FyIw+lU1O/0A
	M54sc5C8WfnzjgnK0Q3eCh9Zgw==
X-Google-Smtp-Source: APXvYqzS/Npmo4MYv3wDhG7ANgyTbiFy36iP7DfcYFXUZ+dj89kDzm21e1+qgcHjkKLOb/7eVgIvwg==
X-Received: by 2002:a1c:720b:: with SMTP id n11mr5079712wmc.81.1556871253287; 
	Fri, 03 May 2019 01:14:13 -0700 (PDT)
Received: from steredhat (host103-125-dynamic.46-79-r.retail.telecomitalia.it.
	[79.46.125.103]) by smtp.gmail.com with ESMTPSA id
	v184sm2122851wma.6.2019.05.03.01.14.12
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 03 May 2019 01:14:12 -0700 (PDT)
Date: Fri, 3 May 2019 10:14:10 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190503081410.kzdcwk4yei4qa7fc@steredhat>
References: <20190425133503.30847-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190425133503.30847-1-stefanha@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH v2] security.rst: add Security Guide to
 developer docs
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
Cc: Eduardo Otubo <otubo@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503081410.XZf4Si-exzUKLJUeEoYURM5doVVlKqlzxrEzdTUzsbI@z>

On Thu, Apr 25, 2019 at 02:35:03PM +0100, Stefan Hajnoczi wrote:
> At KVM Forum 2018 I gave a presentation on security in QEMU:
> https://www.youtube.com/watch?v=YAdRf_hwxU8 (video)
> https://vmsplice.net/~stefan/stefanha-kvm-forum-2018.pdf (slides)
> 
> This patch adds a security guide to the developer docs.  This document
> covers things that developers should know about security in QEMU.  It is
> just a starting point that we can expand on later.  I hope it will be
> useful as a resource for new contributors and will save code reviewers
> from explaining the same concepts many times.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> v2:
>  * Added mention of passthrough USB and PCI devices [philmd]
>  * Reworded resource limits [philmd]
>  * Added qemu_log_mask(LOG_GUEST_ERROR) [philmd]
> ---
>  docs/devel/index.rst    |   1 +
>  docs/devel/security.rst | 225 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 226 insertions(+)
>  create mode 100644 docs/devel/security.rst
> 

Very useful docs!

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

