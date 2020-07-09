Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154C8C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 23:50:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAC4F20674
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 23:50:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAC4F20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtgJ2-0004yr-3e
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 19:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jtgIR-0004YP-Qv
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 19:49:43 -0400
Received: from relay64.bu.edu ([128.197.228.104]:53419)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jtgIQ-0000ie-0x
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 19:49:43 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 069Nmtrt002743
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 9 Jul 2020 19:48:58 -0400
Date: Thu, 9 Jul 2020 19:48:55 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [RFC PATCH 3/3] fuzz: Add callbacks for dma-access functions
Message-ID: <20200709234855.lpto2yc5fanzgzjs@mozz.bu.edu>
References: <20200611055651.13784-1-alxndr@bu.edu>
 <20200611055651.13784-4-alxndr@bu.edu>
 <20200623141456.GK36568@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623141456.GK36568@stefanha-x1.localdomain>
User-Agent: NeoMutt/20180716
Received-SPF: pass client-ip=128.197.228.104; envelope-from=alxndr@bu.edu;
 helo=relay64.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 19:49:39
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
Cc: qemu-devel@nongnu.org, f4bug@amsat.org, darren.kenny@oracle.com,
 bsd@redhat.com, stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200623 1514, Stefan Hajnoczi wrote:
> On Thu, Jun 11, 2020 at 01:56:51AM -0400, Alexander Bulekov wrote:
> > Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> > ---
> >  exec.c                                | 17 ++++++++++++++++-
> >  include/exec/memory.h                 |  8 ++++++++
> >  include/exec/memory_ldst_cached.inc.h |  9 +++++++++
> >  include/sysemu/dma.h                  |  5 ++++-
> >  memory_ldst.inc.c                     | 12 ++++++++++++
> >  5 files changed, 49 insertions(+), 2 deletions(-)
> 
> Please rename dma_read_cb() to fuzz_dma_read_cb() so the purpose of the
> function is clear.
> 
> The ifdefs can be avoided by defining an empty function when CONFIG_FUZZ
> is undefined. In a header file:
> 
>   #ifdef CONFIG_FUZZ
>   void fuzz_dma_read_cb(size_t addr, size_t len);
>   #else
>   static inline void fuzz_dma_read_cb(size_t addr, size_t len)
>   {
>       /* Do nothing */
>   }
>   #endif
> 

If I understand correctly, this still has the problem that normal
qemu-system builds under --enable-fuzzing are broken. I'm not sure if
there is some nice solution for this. For example, a sort-of ugly
solution could add this to softmmu/main.c (ie something that is linked
for the qemu-system build, but not for qemu-fuzz).

#ifdef CONFIG_FUZZ
#include "something.h"
static void fuzz_dma_read_cb(size_t addr, size_t len)
{
    /* Do nothing */
}
#endif

> Now the compiler should eliminate the deadcode:
> 
>   #ifdef CONFIG_FUZZ
>   if (as->root == get_system_memory()) {
>       dma_read_cb(addr, len);
>   }
>   #endif
> 
> becomes:
> 
>   if (as->root == get_system_memory()) {
>       fuzz_dma_read_cb(addr, len);
>   }
> 
> Hopefully gcc and clang will eliminate this and emit no instructions
> when CONFIG_FUZZ is undefined. If not, you can simply pass in 'as' and
> 'is_write' too:
> 
>   void fuzz_dma_read_cb(AddressSpace *as, bool is_write, size_t addr, size_t len)
> 
Yes I'll add in is_write. Hopefully that will make life easier for the
compiler.
Thanks

> This way the conditional is moved inside fuzz_dma_read_cb() and deadcode
> elimination becomes trivial for the compiler:
> 
>   fuzz_read_cb(as, is_write, addr, len);


