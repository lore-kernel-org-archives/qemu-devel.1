Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D49EC4363C
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 13:27:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EDEE20754
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 13:27:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EDEE20754
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQVxc-00015A-Ad
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 09:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kQVwo-0000VN-RS
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 09:27:06 -0400
Received: from relay68.bu.edu ([128.197.228.73]:38266)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kQVwn-0006FT-5Y
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 09:27:06 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay68.bu.edu (8.14.3/8.14.3) with ESMTP id 098DQBmu028318
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 8 Oct 2020 09:26:15 -0400
Date: Thu, 8 Oct 2020 09:26:11 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 04/16] fuzz: Add DMA support to the generic-fuzzer
Message-ID: <20201008132611.stxybcthnpwaclbc@mozz.bu.edu>
References: <20200921022506.873303-1-alxndr@bu.edu>
 <20200921022506.873303-5-alxndr@bu.edu>
 <4fa19590-4b40-aedb-fa1d-44c844337ecf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fa19590-4b40-aedb-fa1d-44c844337ecf@redhat.com>
Received-SPF: pass client-ip=128.197.228.73; envelope-from=alxndr@bu.edu;
 helo=relay68.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 09:27:03
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=0.903, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, darren.kenny@oracle.com, bsd@redhat.com,
 stefanha@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 201008 0943, Paolo Bonzini wrote:
> On 21/09/20 04:24, Alexander Bulekov wrote:
> > +    if (qtest_log_enabled) {
> > +        /*
> > +         * With QTEST_LOG, use a normal, slow QTest memwrite. Prefix the log
> > +         * that will be written by qtest.c with a DMA tag, so we can reorder
> > +         * the resulting QTest trace so the DMA fills precede the last PIO/MMIO
> > +         * command.
> > +         */
> > +        fprintf(stderr, "[DMA] ");
> > +        fflush(stderr);
> > +        qtest_memwrite(qts_global, ar.addr, buf, ar.size);
> > +    } else {
> > +       /*
> > +        * Populate the region using address_space_write_rom to avoid writing to
> > +        * any IO MemoryRegions
> > +        */
> > +        address_space_write_rom(first_cpu->as, ar.addr, MEMTXATTRS_UNSPECIFIED,
> > +                buf, ar.size);
> > +    }
> 
> I wonder if you should just copy address_space_write_rom to your own
> code.  This way you can log the write just like qtest_memwrite would,
> while skipping memwrites that would access IO regions.
> 
> Paolo

I took a quick look, and I think this should be possible, though I might
also need to carry over memory_access_size and invalidate_and_set_dirty.
That would certainly make things better for building reproducers, since
I have seen cases where bugs were not reproducible with QTEST_LOG=1,
because we were not using address_space_write_rom. I'll give it a shot!
Thanks

