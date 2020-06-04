Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E550C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 08:08:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BD21206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 08:08:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BD21206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgkvC-0006eX-Fe
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 04:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.hu@linux.intel.com>)
 id 1jgkuf-0006EZ-Me
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 04:07:45 -0400
Received: from mga09.intel.com ([134.134.136.24]:37625)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.hu@linux.intel.com>)
 id 1jgkue-0000Q3-E4
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 04:07:45 -0400
IronPort-SDR: 93QHr5TXZKV7kAWvx9HKAep9y5PdlSjC3UH7Gq9Nj3keOWBWlP1iDHvAvBZX+yF2yNy4je3w7L
 P/xdDcAln2TA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2020 01:07:40 -0700
IronPort-SDR: n4v14BQNOCknT7pZmBagEQLTwAKcfAzriwBJtgIjsgxQqsI7SRnZ2IS7U4im8++Q9lrnESFamV
 XdP9MBGd727A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,471,1583222400"; d="scan'208";a="257665864"
Received: from sqa-gate.sh.intel.com (HELO robert-ivt.tsp.org)
 ([10.239.48.212])
 by fmsmga007.fm.intel.com with ESMTP; 04 Jun 2020 01:07:38 -0700
Message-ID: <f4ea936819b698c88773ec69cf9d535fb7c32a4a.camel@linux.intel.com>
Subject: Re: [PATCH 1/2] Introduce (x86) CPU model deprecation API
From: Robert Hoo <robert.hu@linux.intel.com>
To: Eric Blake <eblake@redhat.com>, pbonzini@redhat.com, rth@twiddle.net, 
 ehabkost@redhat.com, armbru@redhat.com
Date: Thu, 04 Jun 2020 16:07:37 +0800
In-Reply-To: <70e5d2d1-8bd0-5582-4f8f-066824a7d263@redhat.com>
References: <1591184823-140846-1-git-send-email-robert.hu@linux.intel.com>
 <70e5d2d1-8bd0-5582-4f8f-066824a7d263@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-5.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=134.134.136.24;
 envelope-from=robert.hu@linux.intel.com; helo=mga09.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 04:07:41
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: robert.hu@intel.com, xiaoyao.li@intel.com, qemu-devel@nongnu.org,
 chenyi.qiang@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2020-06-03 at 09:11 -0500, Eric Blake wrote:
> On 6/3/20 6:47 AM, Robert Hoo wrote:
> > Complement versioned CPU model framework with the ability of
> > marking some
> > versions deprecated. When that CPU model is chosen, get some
> > warning. The
> > warning message is customized, e.g. telling in which future QEMU
> > version will
> > it be obsoleted.
> > The deprecation message will also appear by x86_cpu_list_entry(),
> > e.g. '-cpu
> > help'.
> > QMP 'query-cpu-definitions' will also return a bool value
> > indicating the
> > deprecation status.
> > 
> > Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
> > ---
> >   exec.c                   |  3 +++
> >   include/hw/core/cpu.h    |  1 +
> >   qapi/machine-target.json |  3 ++-
> >   target/i386/cpu.c        | 45
> > +++++++++++++++++++++++++++++++++++++++++++--
> >   4 files changed, 49 insertions(+), 3 deletions(-)
> > +++ b/qapi/machine-target.json
> > @@ -309,7 +309,8 @@
> >               'static': 'bool',
> >               '*unavailable-features': [ 'str' ],
> >               'typename': 'str',
> > -            '*alias-of' : 'str' },
> > +            '*alias-of' : 'str',
> > +            'deprecated' : 'bool' },
> 
> Missing documentation of the new member.  Should it be optional
> (present 
> only when true)?
Which document do you mean?
How to make it optional?
(Sorry, new to QMP)
> 
> > @@ -1638,6 +1639,11 @@ struct X86CPUModel {
> >        * This matters only for "-cpu help" and query-cpu-
> > definitions
> >        */
> >       bool is_alias;
> > +    /*
> > +     * If true, this is deprecated and obsoleted in the future.
> > +     * Trying to use deprecated CPU model shall be warned.
> 
> If true, this model is deprecated, and may be removed in the future. 
> Trying to use it now will cause a warning.
Thanks Eric:)
> 
> > +     */
> > +    bool deprecated;
> >   };
> >   
> 
> 


