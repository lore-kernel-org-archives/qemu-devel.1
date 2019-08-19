Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9BFC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 19:20:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2301A2087E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 19:20:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2301A2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hznCz-00012Q-8s
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 15:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36222)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1hznC7-0008MU-Pd
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 15:20:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hznC6-0006ST-Nr
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 15:19:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43148)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hznC6-0006Rd-Fj
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 15:19:54 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9F03919CF92
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 19:19:52 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id d64so130694wmc.7
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 12:19:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+8CfRmMceytjIZ7oTu4LtTIymvuNqSeFpkAlGw45ZEI=;
 b=bKW0tBh56rtEwZiPOkn8tWBfjFnSGNfJk6LX3iugk12JHmmbzOx1TUltZItqset0oe
 a/xJ/0qQu6HoKFwTcENFODv5aTcd9UZ0LMceVe8tih/kfMeDmdoTzQg18kSjl+hvyhiJ
 h1Az1EQDKMw22P8+6lKncc+9Rb0Xq4r70YCctqzNh9PC2O29/7CyUOe2Y8Ob9wj3aK2R
 h4Y8kOactKVujTuxvpbaf6VvQUBadDm0MEQajJmLwkgS9QDoQqAgRMy4HTPkjelBB1lh
 QByZ7t+vRcMque4V7G4UMY/R4UyqpSph6BAHZMd45BDALqssrnfc5yLmqzcwiFPfLQu7
 ViSw==
X-Gm-Message-State: APjAAAVboXNJwJwMUkSC6mRQ6Cr0BBFKqz11Oy2dfIE5+TTcbGGZB1cb
 YMOsq3jAep56hW1hsj61Lw43wEA0Pm428lukFDc7Xd3rBeJXrtyrzKy9emGzX4vm3etggOI5bMU
 783PrDEWqZmhHV5Y=
X-Received: by 2002:a5d:45cb:: with SMTP id b11mr30658103wrs.117.1566242391366; 
 Mon, 19 Aug 2019 12:19:51 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxuW/NiWuNs8XJpTDgHxo+9pwCMSQYVNkzRHqDXH57xlHC+GrjNAio8gQ5/bTDsAErJ4bo0+w==
X-Received: by 2002:a5d:45cb:: with SMTP id b11mr30658087wrs.117.1566242391167; 
 Mon, 19 Aug 2019 12:19:51 -0700 (PDT)
Received: from redhat.com (bzq-79-180-62-110.red.bezeqint.net. [79.180.62.110])
 by smtp.gmail.com with ESMTPSA id r23sm11306509wmc.38.2019.08.19.12.19.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 12:19:50 -0700 (PDT)
Date: Mon, 19 Aug 2019 15:19:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190819151913-mutt-send-email-mst@kernel.org>
References: <20190815183803.13346-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815183803.13346-1-ehabkost@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/3] pc: Fix die-id validation and
 compatibility with libvirt
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
Cc: Peter Krempa <pkrempa@redhat.com>, Like Xu <like.xu@linux.intel.com>,
 qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 15, 2019 at 03:38:00PM -0300, Eduardo Habkost wrote:
> Currently, if die-id is omitted on -device for CPUs, we get a
> very confusing error message:
> 
>   $ qemu-system-x86_64 -smp 1,sockets=6,maxcpus=6 \
>     -device qemu64-x86_64-cpu,socket-id=1,core-id=0,thread-id=0
>   qemu-system-x86_64: -device qemu64-x86_64-cpu,socket-id=1,core-id=0,thread-id=0: \
>     Invalid CPU die-id: 4294967295 must be in range 0:5
> 
> This has 3 problems
> 
> 1) The actual range for die-id is 0:0.
>    This is fixed by patch 1/3.
> 2) The user didn't specify die-id=4294967295.
>    This is fixed by patch 2/3.
> 3) It breaks compatibility with libvirt because die-id was not
>    mandatory before.
>    This is addressed by patch 3/3.
> 
> Issues #1 and #2 were reported at:
> https://bugzilla.redhat.com/show_bug.cgi?id=1741151
> 
> Issue #3 was reported at:
> https://bugzilla.redhat.com/show_bug.cgi?id=1741451
> 
> Cc: Like Xu <like.xu@linux.intel.com>
> Cc: Peter Krempa <pkrempa@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>

Looks good

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

I'm traveling and can't test this properly.
Anyone else can merge this? Eduardo?


> Eduardo Habkost (3):
>   pc: Fix error message on die-id validation
>   pc: Improve error message when die-id is omitted
>   pc: Don't make CPU properties mandatory unless necessary
> 
>  hw/i386/pc.c                             | 23 ++++++++-
>  tests/acceptance/pc_cpu_hotplug_props.py | 59 ++++++++++++++++++++++++
>  2 files changed, 81 insertions(+), 1 deletion(-)
>  create mode 100644 tests/acceptance/pc_cpu_hotplug_props.py
> 
> -- 
> 2.21.0

