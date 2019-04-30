Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730BBC43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 23:40:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C77E20835
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 23:40:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C77E20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55228 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLcMZ-0004Q5-IA
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 19:40:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hLcL4-0003Y5-O7
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 19:39:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hLcL3-0003oO-QN
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 19:39:06 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36176)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hLcL1-0003mj-W6
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 19:39:05 -0400
Received: by mail-qt1-f195.google.com with SMTP id c35so18469407qtk.3
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 16:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=oPLJgEt5GSKwl/hsC7HnZBQJxjznGmxoEpGIncT11WE=;
	b=alHam4xBA0ZNfv8qf9O6HNzWS8CFjzXc32RNuxoR2aMmZQpfq6jQyxWgMxQso2Q4bQ
	E8HkyC9S3llJ1LR0eNbyzO4M/3Ym7rgLHVeqMmWzXUFK7I0bs443QYWq7T1AYZhXiaX/
	+pm4aV3SZIyFkZ96E4IChEpZvIidxa5ZFuevOcqR7bZO8+JPW903bPjyV1+HeLpo3vPn
	MD8VpTaX15QKkLMECvq3WOaneQ9istFqJxfAHAvIE07u5kuNRUfwZnVykNYEGftekZQt
	dlMrKKgfzRu4AljduITFBW+kWPxTQ9ZpmgbqbtIJxQBVXL9/7jgig+Y8iGJz+eYs1MLU
	bVvw==
X-Gm-Message-State: APjAAAWoc6YR4nKudlywfga/F0ZFhv7/f7E8kTyDO8rO+saS9pdb0yKR
	SZowfrKg/RjAeoKRuvTfdPwirA==
X-Google-Smtp-Source: APXvYqyg/LcHhp6Hjz1niBf+ZrF8n+j18QxwwEbMcuOXKnRokNfmI+n0OC9uzDGzaeQ7E5U+ULdxyw==
X-Received: by 2002:aed:23da:: with SMTP id k26mr56623326qtc.387.1556667543172;
	Tue, 30 Apr 2019 16:39:03 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net.
	[173.76.105.71]) by smtp.gmail.com with ESMTPSA id
	r54sm8834390qtr.86.2019.04.30.16.39.01
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 30 Apr 2019 16:39:02 -0700 (PDT)
Date: Tue, 30 Apr 2019 19:38:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190430193838-mutt-send-email-mst@kernel.org>
References: <20190426003652.32633-1-richardw.yang@linux.intel.com>
	<20190426003652.32633-2-richardw.yang@linux.intel.com>
	<20190430204636.GK28722@habkost.net>
	<20190430223618.lyl3ribm7gg5haa5@master>
	<20190430224816.GL28722@habkost.net>
	<20190430185011-mutt-send-email-mst@kernel.org>
	<86e00247-588c-37c1-0737-82614a8f18c0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <86e00247-588c-37c1-0737-82614a8f18c0@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.195
Subject: Re: [Qemu-devel] [PATCH v15 1/2] util/mmap-alloc: support MAP_SYNC
 in qemu_ram_mmap()
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
Cc: pagupta@redhat.com, xiaoguangrong.eric@gmail.com,
	Haozhong Zhang <haozhong.zhang@intel.com>, qemu-devel@nongnu.org,
	Wei Yang <richard.weiyang@gmail.com>, yi.z.zhang@linux.intel.com,
	yu.c.zhang@linux.intel.com,
	Wei Yang <richardw.yang@linux.intel.com>, stefanha@redhat.com,
	imammedo@redhat.com, dan.j.williams@intel.com,
	Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430233859.H86datj5rTUWS5qajksxERZlybg1IghqqxhRYlcLk_o@z>

On Wed, May 01, 2019 at 01:11:34AM +0200, Paolo Bonzini wrote:
> On 01/05/19 00:50, Michael S. Tsirkin wrote:
> >> Stefan, did you hit a build failure, or it was just theoretical?
> >>
> >> linux-headers/*/mman.h is updated by "linux-headers: add
> >> linux/mman.h" (commit 8cf108c5d159).  If the build really fails,
> >> something else is broken in our build system.
> > I think it's for non-linux hosts. linux-headers/ is only used
> > on linux hosts.
> 
> Yes, it is.  Maybe the #ifndef/#define  part should be only used for
> non-Linux.
> 
> Paolo

Makes sense. We'd rather have an error on linux than stub it out as 0.

-- 
MST

