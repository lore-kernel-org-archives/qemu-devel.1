Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3195AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 15:27:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07BAB207D0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 15:27:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07BAB207D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtYSp-0001nz-8Q
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 11:27:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jtYRK-0007y7-En
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 11:26:22 -0400
Received: from relay64.bu.edu ([128.197.228.104]:54786)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jtYRI-0002Dt-No
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 11:26:22 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 069FPVel024397
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 9 Jul 2020 11:25:32 -0400
Date: Thu, 9 Jul 2020 11:25:31 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] softmmu/vl: Include "qemu/rcu.h" for rcu_disable_atfork()
Message-ID: <20200709152531.meffwc6sw2tqbpha@mozz.bu.edu>
References: <20200709133411.23929-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200709133411.23929-1-philmd@redhat.com>
User-Agent: NeoMutt/20180716
Received-SPF: pass client-ip=128.197.228.104; envelope-from=alxndr@bu.edu;
 helo=relay64.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 11:26:20
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Alexander Bulekov <alxndr@bu.edu>

If rcu.h should be explicitly included, should any of these other files
that reference the rcu but do not explicitly #include qemu/rcu.h also
get such includes?

util/qht.c
166:    struct rcu_head rcu;

migration/savevm.c
1822:    rcu_register_thread();

util/log.c
43:    rcu_read_lock();

linux-user/syscall.c
6000:    rcu_register_thread();

hw/virtio/virtio.c
74:    struct rcu_head rcu;

target/arm/kvm.c
998:    rcu_read_lock();

On 200709 1534, Philippe Mathieu-Daudé wrote:
> In commit 73c6e4013b we let vl.c use rcu_disable_atfork()
> which is declared in "qemu/rcu.h", but forgot to include
> this header. Fortunately has never been a problem since
> vl.c includes "exec/memory.h" which includes "qemu/rcu.h".
> 
> Include the missing header now in case we split vl.c later.
> 
> Fixes: 73c6e4013b ("rcu: disable pthread_atfork callbacks ASAP")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  softmmu/vl.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index ecbc18ba75..f243745c51 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -83,6 +83,7 @@
>  #include "qemu/config-file.h"
>  #include "qemu-options.h"
>  #include "qemu/main-loop.h"
> +#include "qemu/rcu.h"
>  #ifdef CONFIG_VIRTFS
>  #include "fsdev/qemu-fsdev.h"
>  #endif
> -- 
> 2.21.3
> 
> 

