Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95886C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 15:20:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CED92073E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 15:20:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CED92073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnkiP-0002Lt-Oc
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 11:20:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34938)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jnkLV-0007Ki-Jw
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 10:56:21 -0400
Received: from relay64.bu.edu ([128.197.228.104]:50945)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jnkLT-00031y-Lq
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 10:56:20 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 05NEt0ou014755
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 23 Jun 2020 10:55:04 -0400
Date: Tue, 23 Jun 2020 10:55:00 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [RFC PATCH 3/3] fuzz: Add callbacks for dma-access functions
Message-ID: <20200623145500.jtdb5skwj5htgfcz@mozz.bu.edu>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 10:56:19
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
> This way the conditional is moved inside fuzz_dma_read_cb() and deadcode
> elimination becomes trivial for the compiler:
> 
>   fuzz_read_cb(as, is_write, addr, len);

Do you think it would be better to have a "trace_dma_read" or
"trace_device_read_from_guest_memory"? I haven't looked under the hood
too much for the tracepoint api, but these would just be standard
tracepoints(disabled for the majority of builds). When we build the
fuzzer, we could compile with --wrap="trace_dma_read" and implement
a __wrap_trace_dma_read in the generic fuzzer. I looked at the symbols
for a qemu build and it looks like trace_* are actual functions, rather
than preprocessor magic, so maybe this could work?
-Alex

