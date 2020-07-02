Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4933AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 13:41:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19F7120899
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 13:41:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19F7120899
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqzSZ-0007i4-1i
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 09:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39344)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jqzRH-00065d-W2
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 09:39:44 -0400
Received: from relay68.bu.edu ([128.197.228.73]:43020)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jqzRE-0006XV-LU
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 09:39:43 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay68.bu.edu (8.14.3/8.14.3) with ESMTP id 062DcUOq009414
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 2 Jul 2020 09:38:45 -0400
Date: Thu, 2 Jul 2020 09:38:30 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/2] configure: add support for Control-Flow Integrity
Message-ID: <20200702133830.f3mlqli2bxtvk2z4@mozz.bu.edu>
References: <20200702054948.10257-1-dbuono@linux.vnet.ibm.com>
 <20200702054948.10257-3-dbuono@linux.vnet.ibm.com>
 <20200702095252.GF1888119@redhat.com>
 <0ed44c55-1f5d-6866-9555-82134ef628fb@linux.vnet.ibm.com>
 <c81befdd-979c-6060-c0a3-15ea1b142d25@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c81befdd-979c-6060-c0a3-15ea1b142d25@redhat.com>
User-Agent: NeoMutt/20180716
Received-SPF: pass client-ip=128.197.228.73; envelope-from=alxndr@bu.edu;
 helo=relay68.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 09:39:38
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
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Daniele Buono <dbuono@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Can't wait to try this out!

On 200702 1459, Paolo Bonzini wrote:
> On 02/07/20 14:50, Daniele Buono wrote:
> > I also wonder if this is something that could be put in the fuzzing
> > environment. It would probably also help in finding coding error in
> > corner cases quicker.
> 
> Yes, fuzzing and tests/docker/test-debug should enable CFI.  Also,
> tests/docker/test-clang should enable LTO.
> 
> Paolo

I believe CFI is most-useful as an active defensive measure. I can't
think of many cases where a fuzzer/test could raise a CFI alert that
wouldn't also be caught by something like canaries, ASan or UBsan,
though maybe I'm missing something. Maybe testing/fuzzing with CFI could
be useful to weed out any errors due to e.g. an incomplete
cfi-blacklist.txt

-Alex

