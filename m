Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB385C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:38:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FE2C2081B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:38:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FE2C2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7cbr-00089Y-9Y
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 05:38:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47365)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1i7caM-0006zv-N1
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:37:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1i7caL-0000va-Nw
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:37:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34516)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1i7caL-0000s7-Ic
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:37:17 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B4BED64047
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 09:37:16 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id w3so5819992wrv.10
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 02:37:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=uY5AlJbwk4Jh6cAWYD0kcr3yHT+Fn7G6Kjj9/aU7vgU=;
 b=GOQbfG4jdgzbkHrEq2u1UBx07AtEomm1KXU3aq4mW/ekC2/5/f11pdHr1vQ7sG3j3h
 8FjeZgvjREamw8GfroMbkGnCwmlW7iURg1ARi4Irm32elMF1jt5p9zUNowSl4/I6Bhmk
 mVdvNDbpjhY8RQTN7xvdZ8s56kqx/gGuwq2SAIlusXhJXDeSzL1eHYahjDpD0q0U1pMM
 Woh+tSjm6yLQ+IKlYfq2/9LpMIh0E7YiOsfGAM6wKVm7Uq/nrtMqvmcoJYckMs4oodv5
 HNfFv8k90FixX65vCQz0BVyWxIYd4VnANt4XhHJbmSar/dXh/y/iw6Km4hUZdGfHsKAs
 GzrQ==
X-Gm-Message-State: APjAAAWNIaSBpFzR8jbvtxT0A9zszkh2/A98LtRonQzciG4rN24qqnYk
 WWzoYjL1hXP+Bng/Ez2mn7S/H7ENOPGj8wHxmISp9kvI+Mcs2EjgAG9cFgbHd59sPHDysBZ2ilG
 0flqTORnac9kwerw=
X-Received: by 2002:adf:f20f:: with SMTP id p15mr18908497wro.17.1568108235383; 
 Tue, 10 Sep 2019 02:37:15 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzInxYjPcq/83p6vtA6ydKiQ2Pd0puQFbuoyO8/ctSeJoaIrnGDgOWx/VOQCpGOwDP5LzFgVg==
X-Received: by 2002:adf:f20f:: with SMTP id p15mr18908475wro.17.1568108235185; 
 Tue, 10 Sep 2019 02:37:15 -0700 (PDT)
Received: from steredhat (host170-61-dynamic.36-79-r.retail.telecomitalia.it.
 [79.36.61.170])
 by smtp.gmail.com with ESMTPSA id c1sm2192701wmk.20.2019.09.10.02.37.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 02:37:14 -0700 (PDT)
Date: Tue, 10 Sep 2019 11:37:12 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <20190910093712.l6uwjyhhdnpkginw@steredhat>
References: <20190910075943.12977-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910075943.12977-1-vsementsov@virtuozzo.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] util/qemu-sockets: fix keep_alive handling
 in inet_connect_saddr
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
Cc: den@openvz.org, peter.maydell@linaro.org, berrange@redhat.com,
 qemu-devel@nongnu.org, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 10, 2019 at 10:59:43AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> In "if (saddr->keep_alive) {" we may already be on error path, with
> invalid sock < 0. Fix it by returning error earlier.
> 
> Reported-by: Coverity (CID 1405300)
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  util/qemu-sockets.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

