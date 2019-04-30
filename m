Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC74C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 20:55:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1C0420652
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 20:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1C0420652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53273 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLZmQ-0007ww-7N
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 16:55:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hLZeM-0002Ob-T8
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:46:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hLZeH-00088x-Ut
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:46:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39746)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hLZeG-00088D-Po
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:46:45 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 21D308AE52;
	Tue, 30 Apr 2019 20:46:43 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 32862191EA;
	Tue, 30 Apr 2019 20:46:38 +0000 (UTC)
Date: Tue, 30 Apr 2019 17:46:36 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190430204636.GK28722@habkost.net>
References: <20190426003652.32633-1-richardw.yang@linux.intel.com>
	<20190426003652.32633-2-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190426003652.32633-2-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Tue, 30 Apr 2019 20:46:43 +0000 (UTC)
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
	Haozhong Zhang <haozhong.zhang@intel.com>, qemu-devel@nongnu.org,
	yi.z.zhang@linux.intel.com, yu.c.zhang@linux.intel.com,
	stefanha@redhat.com, imammedo@redhat.com, pbonzini@redhat.com,
	dan.j.williams@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430204636.vdLNs3BvmddXeNXtbLIQXX0kaYXZTaFLmkBHKPOv2QE@z>

Hi,

On Fri, Apr 26, 2019 at 08:36:51AM +0800, Wei Yang wrote:
> From: Zhang Yi <yi.z.zhang@linux.intel.com>
> 
> When a file supporting DAX is used as vNVDIMM backend, mmap it with
> MAP_SYNC flag in addition which can ensure file system metadata
> synced in each guest writes to the backend file, without other QEMU
> actions (e.g., periodic fsync() by QEMU).
> 
> Current, We have below different possible use cases:
> 
> 1. pmem=on is set, shared=on is set, MAP_SYNC supported:
>    a: backend is a dax supporting file.
>     - MAP_SYNC will active.
>    b: backend is not a dax supporting file.
>     - mmap will trigger a warning. then MAP_SYNC flag will be ignored
> 
> 2. The rest of cases:
>    - we will never pass the MAP_SYNC to mmap2
> 
> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
> [ehabkost: Rebased patch to latest code on master]
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> Tested-by: Wei Yang <richardw.yang@linux.intel.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> 
> ---
> v15: fix compile issue on pre-linux4.15
> v14: rebase on top of current upstream

Note that v14 was already merged, so the build fix would need to
be submitted separately.  However:

[...]
> +#ifdef CONFIG_LINUX
> +#include <linux/mman.h>
> +#endif /* CONFIG_LINUX */
> +
> +#ifndef MAP_SYNC
> +#define MAP_SYNC 0
> +#endif
> +#ifndef MAP_SHARED_VALIDATE
> +#define MAP_SHARED_VALIDATE 0
> +#endif

Why would we need this, if we added copies of mman.h to
linux-headers?

-- 
Eduardo

