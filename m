Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0862DC43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 17:00:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA2D820835
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 16:59:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA2D820835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36973 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLsaM-0002Ch-RK
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 12:59:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hLsZJ-0001lB-It
	for qemu-devel@nongnu.org; Wed, 01 May 2019 12:58:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hLsZG-0004vz-Fs
	for qemu-devel@nongnu.org; Wed, 01 May 2019 12:58:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hLsZG-0004r3-93
	for qemu-devel@nongnu.org; Wed, 01 May 2019 12:58:50 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6BAA481F25;
	Wed,  1 May 2019 16:58:48 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1858F752BE;
	Wed,  1 May 2019 16:58:42 +0000 (UTC)
Date: Wed, 1 May 2019 13:58:41 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190501165841.GM28722@habkost.net>
References: <20190426003652.32633-1-richardw.yang@linux.intel.com>
	<20190426003652.32633-2-richardw.yang@linux.intel.com>
	<20190430204636.GK28722@habkost.net>
	<20190430223618.lyl3ribm7gg5haa5@master>
	<20190430224816.GL28722@habkost.net>
	<20190430185011-mutt-send-email-mst@kernel.org>
	<86e00247-588c-37c1-0737-82614a8f18c0@redhat.com>
	<20190430193838-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190430193838-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Wed, 01 May 2019 16:58:48 +0000 (UTC)
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
Cc: pagupta@redhat.com, xiaoguangrong.eric@gmail.com,
	Haozhong Zhang <haozhong.zhang@intel.com>, qemu-devel@nongnu.org,
	Wei Yang <richard.weiyang@gmail.com>, yi.z.zhang@linux.intel.com,
	yu.c.zhang@linux.intel.com,
	Wei Yang <richardw.yang@linux.intel.com>, stefanha@redhat.com,
	imammedo@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
	dan.j.williams@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190501165841.vPFwgJVwHlTx4nnPPsEvRxg31OhIrP9rpga0KQP6tYo@z>

On Tue, Apr 30, 2019 at 07:38:59PM -0400, Michael S. Tsirkin wrote:
> On Wed, May 01, 2019 at 01:11:34AM +0200, Paolo Bonzini wrote:
> > On 01/05/19 00:50, Michael S. Tsirkin wrote:
> > >> Stefan, did you hit a build failure, or it was just theoretical?
> > >>
> > >> linux-headers/*/mman.h is updated by "linux-headers: add
> > >> linux/mman.h" (commit 8cf108c5d159).  If the build really fails,
> > >> something else is broken in our build system.
> > > I think it's for non-linux hosts. linux-headers/ is only used
> > > on linux hosts.
> > 
> > Yes, it is.  Maybe the #ifndef/#define  part should be only used for
> > non-Linux.
> > 
> > Paolo
> 
> Makes sense. We'd rather have an error on linux than stub it out as 0.


I'm confused by these replies.  When exactly do you expect an
error on Linux?

For context, I'm talking about the code in v14 of the series (which was already
merged):

#ifdef CONFIG_LINUX
#include <linux/mman.h>
#else  /* !CONFIG_LINUX */
#define MAP_SYNC              0x0
#define MAP_SHARED_VALIDATE   0x0
#endif /* CONFIG_LINUX */

I fail to see any case where the build would fail in v14.

-- 
Eduardo

