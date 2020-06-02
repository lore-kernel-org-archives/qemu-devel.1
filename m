Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC30C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 13:43:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 815BF20757
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 13:43:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 815BF20757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg7CE-0007G7-EE
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 09:43:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jg7B3-0005pM-N1
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 09:42:01 -0400
Received: from relay64.bu.edu ([128.197.228.104]:48664)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jg7B2-0006Is-3s
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 09:42:01 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 052DeoB3027462
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 2 Jun 2020 09:40:54 -0400
Date: Tue, 2 Jun 2020 09:40:50 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Darren Kenny <darren.kenny@oracle.com>
Subject: Re: [PATCH v3 0/2] fuzz: Skip QTest serialization
Message-ID: <20200602134050.k7s6wjwlzxarrc72@mozz.bu.edu>
References: <20200529221450.26673-1-alxndr@bu.edu> <m2v9k9wqae.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2v9k9wqae.fsf@oracle.com>
User-Agent: NeoMutt/20180716
Received-SPF: pass client-ip=128.197.228.104; envelope-from=alxndr@bu.edu;
 helo=relay64.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 09:41:57
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: bsd@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thank you Darren.

On 200602 1428, Darren Kenny wrote:
> 
> Hi Alex,
> 
> In general the series looks good, so:
> 
> Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
> 
> But not sure how to handle the patchew output though, not sure if it is
> really a concern or not, since do/while won't work that context.
> 

Yes - I was not really sure how to deal with those failures, so I sent
the patch anyway. Maybe someone else knows a workaround.
-Alex

> Thanks,
> 
> Darren.
> 
> On Friday, 2020-05-29 at 18:14:48 -04, Alexander Bulekov wrote:
> > In the same vein as Philippe's patch:
> >
> > https://patchew.org/QEMU/20200528165303.1877-1-f4bug@amsat.org/
> >
> > This uses linker trickery to wrap calls to libqtest functions and
> > directly call the corresponding read/write functions, rather than
> > relying on the ASCII-serialized QTest protocol.
> >
> > v2: applies properly
> >
> > v3: add missing qtest_wrappers.c file and fix formatting in fuzz.c
> >
> > Alexander Bulekov (2):
> >   fuzz: skip QTest serialization
> >   fuzz: Add support for logging QTest commands
> >
> >  tests/qtest/fuzz/Makefile.include |  21 +++
> >  tests/qtest/fuzz/fuzz.c           |  20 ++-
> >  tests/qtest/fuzz/fuzz.h           |   3 +
> >  tests/qtest/fuzz/qtest_wrappers.c | 252 ++++++++++++++++++++++++++++++
> >  4 files changed, 295 insertions(+), 1 deletion(-)
> >  create mode 100644 tests/qtest/fuzz/qtest_wrappers.c
> >
> > -- 
> > 2.26.2

