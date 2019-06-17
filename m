Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_HK_NAME_DR,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEA8C31E57
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 10:48:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E674C2084A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 10:48:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E674C2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46022 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcpBs-0005oV-Q4
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 06:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44480)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hcp9y-0005Iu-F8
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 06:46:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hcp9x-0004pz-4a
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 06:46:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57476)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hcp9w-0004Fi-Ry
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 06:46:45 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0AF32149A2;
 Mon, 17 Jun 2019 10:46:09 +0000 (UTC)
Received: from work-vm (ovpn-117-216.ams2.redhat.com [10.36.117.216])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 33968784A6;
 Mon, 17 Jun 2019 10:46:04 +0000 (UTC)
Date: Mon, 17 Jun 2019 11:46:02 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peng Tao <tao.peng@linux.alibaba.com>
Message-ID: <20190617104601.GA2679@work-vm>
References: <1560494113-1141-1-git-send-email-tao.peng@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560494113-1141-1-git-send-email-tao.peng@linux.alibaba.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Mon, 17 Jun 2019 10:46:14 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] migration: allow private destination ram
 with x-ignore-shared
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
Cc: Yury Kotov <yury-kotov@yandex-team.ru>, Xu Wang <xu@hyper.sh>,
 qemu-devel@nongnu.org, Jiangshan Lai <laijs@hyper.sh>,
 kata-dev@lists.katacontainers.io
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Peng Tao (tao.peng@linux.alibaba.com) wrote:
> By removing the share ram check, qemu is able to migrate
> to private destination ram when x-ignore-shared capability
> is on. Then we can create multiple destination VMs based
> on the same source VM.
> 
> This changes the x-ignore-shared migration capability to
> work similar to Lai's original bypass-shared-memory
> work(https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg00003.html)
> which enables kata containers (https://katacontainers.io)
> to implement the VM templating feature.
> 
> An example usage in kata containers(https://katacontainers.io):
> 1. Start the source VM:
>    qemu-system-x86 -m 2G \
>      -object memory-backend-file,id=mem0,size=2G,share=on,mem-path=/tmpfs/template-memory \
>      -numa node,memdev=mem0
> 2. Stop the template VM, set migration x-ignore-shared capability,
>    migrate "exec:cat>/tmpfs/state", quit it
> 3. Start target VM:
>    qemu-system-x86 -m 2G \
>      -object memory-backend-file,id=mem0,size=2G,share=off,mem-path=/tmpfs/template-memory \
>      -numa node,memdev=mem0 \
>      -incoming defer
> 4. connect to target VM qmp, set migration x-ignore-shared capability,
> migrate_incoming "exec:cat /tmpfs/state"
> 5. create more target VMs repeating 3 and 4
> 
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Cc: Yury Kotov <yury-kotov@yandex-team.ru>
> Cc: Jiangshan Lai <laijs@hyper.sh>
> Cc: Xu Wang <xu@hyper.sh>
> Signed-off-by: Peng Tao <tao.peng@linux.alibaba.com>

I think this is OK, but please post this to qemu-devel.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/ram.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 1ca9ba7..cdb82a3 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3373,7 +3373,6 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
>          }
>          if (migrate_ignore_shared()) {
>              qemu_put_be64(f, block->mr->addr);
> -            qemu_put_byte(f, ramblock_is_ignored(block) ? 1 : 0);
>          }
>      }
>  
> @@ -4340,12 +4339,6 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
>                      }
>                      if (migrate_ignore_shared()) {
>                          hwaddr addr = qemu_get_be64(f);
> -                        bool ignored = qemu_get_byte(f);
> -                        if (ignored != ramblock_is_ignored(block)) {
> -                            error_report("RAM block %s should %s be migrated",
> -                                         id, ignored ? "" : "not");
> -                            ret = -EINVAL;
> -                        }
>                          if (ramblock_is_ignored(block) &&
>                              block->mr->addr != addr) {
>                              error_report("Mismatched GPAs for block %s "
> -- 
> 1.8.3.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

