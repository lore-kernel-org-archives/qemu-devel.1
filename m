Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9019C0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 15:51:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93CD8208E3
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 15:51:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93CD8208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsUPW-0000gy-Jb
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 11:51:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47461)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hsUOw-0000Gs-B1
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 11:50:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hsUOv-0000C9-EZ
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 11:50:58 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34474)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hsUOv-0000BI-An
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 11:50:57 -0400
Received: by mail-qk1-f195.google.com with SMTP id t8so46976204qkt.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 08:50:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=1NTy5QZ1FFbyv1LCsynIAmuJOUNRXSw2yEzFMO0UYzI=;
 b=V89tzb7Dkcj7rOzhrsCSWuZ1SpWLnJg2G94htOA4bDIxAJ+tfqthqfwRv+OfKULX8L
 NXn14Ty0THixZPednq/1oG+iPBYtIUtMPU8pRt7XujOilOWQGztibBeUir2BqZduuy7K
 iZ7cXwjaum/fkC6LGvYUBHcBEaFkJZzuRzNa8i2zNWo9isuKYudhcOUxnyCVhbK32zHm
 G51TAjEJJbmZTclag8DLaONOX47sdlHEywmduJp5njI2dZPGkAimL6zUJTQcdSmzogW1
 /ra5VakCuY675JgeT3uUD1ZiZlxErX02yzTBeqz9p/37N/+o0XWXEgSJwyjcIs6mGuNO
 vUrA==
X-Gm-Message-State: APjAAAXktuaQUXoBoZxuBCmi2d8cs0BJgkBETLXXknXTXwiHJ2vL7qRK
 kUeSnv4uuIXb6CA4ZpSs5b7Raid9pdsTzA==
X-Google-Smtp-Source: APXvYqx5GOLV/01TnZy36YYyOWaFhgCpeOl4VIe8jrRTOgqj0SX/bZe6AIiFTmA8bkrcj3XF0bQ58g==
X-Received: by 2002:ae9:eb87:: with SMTP id
 b129mr74355734qkg.453.1564501855450; 
 Tue, 30 Jul 2019 08:50:55 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
 by smtp.gmail.com with ESMTPSA id
 g2sm28451422qkf.32.2019.07.30.08.50.52
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 30 Jul 2019 08:50:54 -0700 (PDT)
Date: Tue, 30 Jul 2019 11:50:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190730114210-mutt-send-email-mst@kernel.org>
References: <20190729211404.1533-1-mst@redhat.com>
 <20190723160859.27250-1-imammedo@redhat.com>
 <20190730143638.208a2f56@Igors-MacBook-Pro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730143638.208a2f56@Igors-MacBook-Pro>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.222.195
Subject: Re: [Qemu-devel] [PULL 3/3] pc-dimm: fix crash when invalid slot
 number is used
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 30, 2019 at 02:36:38PM +0200, Igor Mammedov wrote:
> On Mon, 29 Jul 2019 17:16:14 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> Hi Michael,
> 
> it seems tooling used for pull req is a bit broken
>  * minor issue is CC list contains bogus addresses like: &lt@redhat.com, Mammedov@redhat.com,

Ouch. Looks like the html version ended up there in git somehow.
I'll look into fixing that.

>  * a bigger issie is that Message-Id is taken from original patch even though [PULL 3/3]
>    is not 100% the same as original which confuses mail clients quite a bit.

That's somehow the fault of the mail sending script.
I checked and I don't see any logs of how it run though.
I think I somehow triggered an old version by mistake.
Sorry :(

-- 
MST

