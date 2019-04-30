Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956BEC43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 22:59:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6764420835
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 22:59:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6764420835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54721 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLbix-0002ov-Li
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 18:59:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hLbgx-00019q-Sa
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 18:57:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hLbaO-0003Lv-IW
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 18:50:53 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38728)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hLbaO-0003Ju-Cu
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 18:50:52 -0400
Received: by mail-qt1-f196.google.com with SMTP id d13so18332782qth.5
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 15:50:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=oA4JinMBZ71nnY3EmXqS0AIizff3OVr/8/y3M/y/qlA=;
	b=kfjbAqev4ZuMjZxo47h7bJCHhPfFj/VBwrztxk0sLJSKS2Paor/U4Ls0ZFPmUlXtC7
	CeZS/peHZ2O+FCK8AUMtbYZYnol50btJ2EvmcbwQROVdvnRs0KQWdahF+CZJZIxmvl70
	0R6Vy9yjKVo3pgwZppbKLxMn+zzcIc1miUhEelWDZOSsrHwSENmwt18Ge8jFF0neWbhV
	fsdNUAb5wq5sjCFJoYU4HluWHG2RXpd39v18/yzf5e9Tl9P9b76HZlwgB2C5ZqrDScVS
	iE2jqvzL4yDfuwZcMhLkFLSiDV+pFj0dItekrQ6ieD903ESr0Ecd/NAgb5ZkXKvXMivt
	ZuSA==
X-Gm-Message-State: APjAAAUBHJNPh0/H31xZmGAEGFzYgfcHH20E3RuLtFMWbWBBlaGktJKA
	3cf/AL0KI6w/nhVNITrFkQwdTQ==
X-Google-Smtp-Source: APXvYqxZu9xTFw7dGhQpevpZULtE7lcfDgZiI8/E2tJsHBEDSLGpoB/FksUrMzgUqC99mNR/2CR0Pw==
X-Received: by 2002:aed:2314:: with SMTP id h20mr58373669qtc.24.1556664650733; 
	Tue, 30 Apr 2019 15:50:50 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net.
	[173.76.105.71]) by smtp.gmail.com with ESMTPSA id
	w58sm20754802qtw.93.2019.04.30.15.50.49
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 30 Apr 2019 15:50:49 -0700 (PDT)
Date: Tue, 30 Apr 2019 18:50:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190430185011-mutt-send-email-mst@kernel.org>
References: <20190426003652.32633-1-richardw.yang@linux.intel.com>
	<20190426003652.32633-2-richardw.yang@linux.intel.com>
	<20190430204636.GK28722@habkost.net>
	<20190430223618.lyl3ribm7gg5haa5@master>
	<20190430224816.GL28722@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190430224816.GL28722@habkost.net>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.196
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
	pbonzini@redhat.com, imammedo@redhat.com, dan.j.williams@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430225047.krj8u5JgTsFmKH0SfqxkkZkVSFYKY_-RuElVgvTRCLs@z>

On Tue, Apr 30, 2019 at 07:48:16PM -0300, Eduardo Habkost wrote:
> On Tue, Apr 30, 2019 at 10:36:18PM +0000, Wei Yang wrote:
> [...]
> > >> +#ifdef CONFIG_LINUX
> > >> +#include <linux/mman.h>
> > >> +#endif /* CONFIG_LINUX */
> > >> +
> > >> +#ifndef MAP_SYNC
> > >> +#define MAP_SYNC 0
> > >> +#endif
> > >> +#ifndef MAP_SHARED_VALIDATE
> > >> +#define MAP_SHARED_VALIDATE 0
> > >> +#endif
> > >
> > >Why would we need this, if we added copies of mman.h to
> > >linux-headers?
> > 
> > This is reported by Stefan.
> > 
> > https://www.mail-archive.com/qemu-devel@nongnu.org/msg612168.html
> 
> Stefan, did you hit a build failure, or it was just theoretical?
> 
> linux-headers/*/mman.h is updated by "linux-headers: add
> linux/mman.h" (commit 8cf108c5d159).  If the build really fails,
> something else is broken in our build system.

I think it's for non-linux hosts. linux-headers/ is only used
on linux hosts.

> -- 
> Eduardo

