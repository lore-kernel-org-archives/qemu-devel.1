Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 936D5C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 23:01:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C60420835
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 23:01:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C60420835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54756 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLbkC-0003zo-IW
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 19:01:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hLbh5-00019q-Oh
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 18:57:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hLbXz-0002C9-GO
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 18:48:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44130)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hLbXz-0002AL-B3
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 18:48:23 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5DABE3082B15;
	Tue, 30 Apr 2019 22:48:22 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 54BDA81764;
	Tue, 30 Apr 2019 22:48:17 +0000 (UTC)
Date: Tue, 30 Apr 2019 19:48:16 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Wei Yang <richard.weiyang@gmail.com>
Message-ID: <20190430224816.GL28722@habkost.net>
References: <20190426003652.32633-1-richardw.yang@linux.intel.com>
	<20190426003652.32633-2-richardw.yang@linux.intel.com>
	<20190430204636.GK28722@habkost.net>
	<20190430223618.lyl3ribm7gg5haa5@master>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190430223618.lyl3ribm7gg5haa5@master>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Tue, 30 Apr 2019 22:48:22 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: pagupta@redhat.com, xiaoguangrong.eric@gmail.com, mst@redhat.com,
	stefanha@redhat.com, qemu-devel@nongnu.org,
	yi.z.zhang@linux.intel.com, yu.c.zhang@linux.intel.com,
	Wei Yang <richardw.yang@linux.intel.com>,
	Haozhong Zhang <haozhong.zhang@intel.com>, pbonzini@redhat.com,
	imammedo@redhat.com, dan.j.williams@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430224816.ks_nSlzkkTdbZqYA899WJnk_twJTGoBlsObArUEkmCo@z>

On Tue, Apr 30, 2019 at 10:36:18PM +0000, Wei Yang wrote:
[...]
> >> +#ifdef CONFIG_LINUX
> >> +#include <linux/mman.h>
> >> +#endif /* CONFIG_LINUX */
> >> +
> >> +#ifndef MAP_SYNC
> >> +#define MAP_SYNC 0
> >> +#endif
> >> +#ifndef MAP_SHARED_VALIDATE
> >> +#define MAP_SHARED_VALIDATE 0
> >> +#endif
> >
> >Why would we need this, if we added copies of mman.h to
> >linux-headers?
> 
> This is reported by Stefan.
> 
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg612168.html

Stefan, did you hit a build failure, or it was just theoretical?

linux-headers/*/mman.h is updated by "linux-headers: add
linux/mman.h" (commit 8cf108c5d159).  If the build really fails,
something else is broken in our build system.

-- 
Eduardo

