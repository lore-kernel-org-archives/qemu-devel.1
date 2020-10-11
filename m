Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496E2C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 15:37:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B24C1206CB
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 15:37:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B24C1206CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRdPv-0001la-CZ
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 11:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kRdOq-0001F5-OM
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 11:36:40 -0400
Received: from relay68.bu.edu ([128.197.228.73]:53073)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kRdOo-00067D-VB
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 11:36:40 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay68.bu.edu (8.14.3/8.14.3) with ESMTP id 09BFZMfV013467
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 11 Oct 2020 11:35:26 -0400
Date: Sun, 11 Oct 2020 11:35:22 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 02/16] fuzz: Add general virtual-device fuzzer
Message-ID: <20201011153522.oyad5n47p4hphgfm@mozz.bu.edu>
References: <20200921022506.873303-1-alxndr@bu.edu>
 <20200921022506.873303-3-alxndr@bu.edu>
 <63ca7622-557b-4217-f15e-ee9b024fbd77@redhat.com>
 <20200921143405.3taiymgzwvscxsry@mozz.bu.edu>
 <74511624-33ed-ff5d-62c2-f9b2b632b39a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74511624-33ed-ff5d-62c2-f9b2b632b39a@redhat.com>
Received-SPF: pass client-ip=128.197.228.73; envelope-from=alxndr@bu.edu;
 helo=relay68.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 11:36:35
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=0.441, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
 stefanha@redhat.com,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 201008 0903, Paolo Bonzini wrote:
> On 21/09/20 16:34, Alexander Bulekov wrote:
> >> Can you fuzz writing "FUZZ" in memory? Like:
> >> OP_WRITE(0x100000, "UsingLibFUZZerString")?
> > No.. Hopefully that's not a huge problem.
> > 
> 
> Instead of always looking for a separator, can you:
> 
> 1) skip over it if you find it naturally at the end of a command (that
> is, "FUZZ" is like a comment command)
> 
> 2) actively search for it only if you stumble upon an unrecognized command?
> 

What is the end goal? Is it to be able to use the "FUZZ" bytes to fuzz
devices?
My concern is that we want to keep the "stability" added by the FUZZ
separators (ie removing a single byte shouldn't completely change the
sequence of operations).

> In that case, if you have
> 
>   AbcFUZZD0x100000UsingLibFUZZerFUZZ
> 
> The first and third instances would be ignored, while the second would
> be part of the input.  On the other hand if you have
> 
>   bcFUZZD0x100000UsingLibFUZZerFUZZ
> 
> "b" is an invalid command and therefore you'd skip directly to "D".

There aren't any invalid OPCodes, since we interpret the opcode modulo
the size of the OPcode table. We only have invalid/skipped commands when
there isn't enough data after the opcode to figure out what we should do.

> 
> Paolo
> 

