Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD58C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 16:01:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C7AB21D47
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 16:01:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C7AB21D47
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGlUa-00035y-2R
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 12:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kGlSm-0001jg-8D
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 11:59:48 -0400
Received: from relay64.bu.edu ([128.197.228.104]:34973)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kGlSj-0003dZ-Gp
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 11:59:47 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 08BFwfQm007813
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 11 Sep 2020 11:58:44 -0400
Date: Fri, 11 Sep 2020 11:58:41 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: P J P <ppandit@redhat.com>
Subject: Re: About 'qemu-security' mailing list
Message-ID: <20200911155841.yjkkep7zfneoi3jb@mozz.bu.edu>
References: <nycvar.YSQ.7.78.906.2009111910280.36374@xnncv>
 <20200911154055.hnh6wgqpc5pdcyjl@mozz.bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911154055.hnh6wgqpc5pdcyjl@mozz.bu.edu>
Received-SPF: pass client-ip=128.197.228.104; envelope-from=alxndr@bu.edu;
 helo=relay64.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 11:41:17
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

And I forgot to mention that I think it is a great idea :) . Over the past
couple months, I reported a few dozen bugs on launchpad. Even though
many of them are memory-corruptions and might fall under the
"security-bug" label, they could be fixed faster simply because the
reports can reach the maintainer, without a manual triage process.
With more eyes available, it could be possible to report fuzzing bugs,
while sticking to the security process. It would be especially useful as
we are ramping up automated fuzzing on google's oss-fuzz and thinking
about how to handle those reports.
-Alex

On 200911 1140, Alexander Bulekov wrote:
> Hi Prasad,
> A couple questions:
>  * I'm guessing this will be a closed list with some application/vetting
>    procedure for the participants? (Maybe this is what you mean by
>    "moderated" ?)
>  * How will the communication be encrypted?
>  * Will secalert still be subscribed (for managing CVE ID assignments)?
>  * Assuming PGP will be gone, will it be possible to make the "This bug
>    is a security vulnerability" button work on Launchpad?
> Thanks!
> -Alex
> 
> On 200911 1950, P J P wrote:
> >   Hello all,
> > 
> > Recently while conversing with DanPB this point came up
> > 
> >    -> https://www.qemu.org/contribute/security-process/
> > 
> > * Currently QEMU security team is a handful of individual contacts which
> >   restricts community participation in dealing with these issues.
> > 
> > * The Onus also lies with the individuals to inform the community about QEMU
> >   security issues, as they come in.
> > 
> > 
> > Proposal: (to address above limitations)
> > =========
> > 
> > * We set up a new 'qemu-security' mailing list.
> > 
> > * QEMU security issues are reported to this new list only.
> > 
> > * Representatives from various communities subscribe to this list. (List maybe
> >   moderated in the beginning.)
> > 
> > * As QEMU issues come in, participants on the 'qemu-security' list shall
> >   discuss and decide about how to triage them further.
> > 
> > Please kindly let us know your views about it. I'd appreciate if you have
> > any suggestions/inputs/comments about the same.
> > 
> > 
> > Thank you.
> > --
> > Prasad J Pandit / Red Hat Product Security Team
> > 8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D
> > 
> > 
> 

