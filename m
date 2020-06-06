Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18668C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 03:06:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D96FC206DC
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 03:06:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D96FC206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhP9v-0006bP-95
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 23:06:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.hu@linux.intel.com>)
 id 1jhP9N-00069w-9B
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 23:05:37 -0400
Received: from mga06.intel.com ([134.134.136.31]:36159)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.hu@linux.intel.com>)
 id 1jhP9L-0003n2-PM
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 23:05:36 -0400
IronPort-SDR: 9dUO8Z+3IuRfrjrjnTdkBJZWfzkDvEwIt9XPRNXWwmTnSyqm0Ky4aMarv4KmxBTwS8A6ku1JKN
 02tGSoRPSLcA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2020 20:05:26 -0700
IronPort-SDR: ayQmhGKml0x/yYf93fner/r/3ij0ngYoUi15gxwO2mrxhlLpy0btyy57DxwiCQ6J8GjT18+eP/
 hgmRUjyNOfjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,478,1583222400"; d="scan'208";a="305262982"
Received: from sqa-gate.sh.intel.com (HELO robert-ivt.tsp.org)
 ([10.239.48.212])
 by fmsmga002.fm.intel.com with ESMTP; 05 Jun 2020 20:05:24 -0700
Message-ID: <0c3bf5755ed819941c5afe62418042c0a114d3cf.camel@linux.intel.com>
Subject: Re: [PATCH 1/2] Introduce (x86) CPU model deprecation API
From: Robert Hoo <robert.hu@linux.intel.com>
To: Eric Blake <eblake@redhat.com>, pbonzini@redhat.com, rth@twiddle.net, 
 ehabkost@redhat.com, armbru@redhat.com
Date: Sat, 06 Jun 2020 11:05:23 +0800
In-Reply-To: <26e46d40-2e87-9427-40fd-6278caf30546@redhat.com>
References: <1591184823-140846-1-git-send-email-robert.hu@linux.intel.com>
 <70e5d2d1-8bd0-5582-4f8f-066824a7d263@redhat.com>
 <f4ea936819b698c88773ec69cf9d535fb7c32a4a.camel@linux.intel.com>
 <c0c1643d-ff3c-919b-7684-dac14f0d5229@redhat.com>
 <f43f253883e448edbf4cc4e7d685cbf66256f743.camel@linux.intel.com>
 <26e46d40-2e87-9427-40fd-6278caf30546@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-8.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=134.134.136.31;
 envelope-from=robert.hu@linux.intel.com; helo=mga06.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 23:05:27
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_DNSWL_MED=-2.3 autolearn=_AUTOLEARN
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

On Fri, 2020-06-05 at 08:47 -0500, Eric Blake wrote:
> On 6/4/20 9:47 PM, Robert Hoo wrote:
> > On Thu, 2020-06-04 at 06:59 -0500, Eric Blake wrote:
> > > On 6/4/20 3:07 AM, Robert Hoo wrote:
> > > 
> > > > > > +++ b/qapi/machine-target.json
> > > > > > @@ -309,7 +309,8 @@
> > > > > >                 'static': 'bool',
> > > > > >                 '*unavailable-features': [ 'str' ],
> > > > > >                 'typename': 'str',
> > > > > > -            '*alias-of' : 'str' },
> > > > > > +            '*alias-of' : 'str',
> > > > > > +            'deprecated' : 'bool' },
> > > > > 
> > > > > Missing documentation of the new member.  Should it be
> > > > > optional
> > > > > (present
> > > > > only when true)?
> > > > 
> > > > Which document do you mean?
> > 
> > Thanks Eric:)
> > 
> > > 
> > > A few lines earlier is '@alias-of: ...'; you'll need to add a
> > > similar
> > > line for '@deprecated', mentioning it is '(since 5.1)'.
> > > 
> > > > How to make it optional?
> > 
> > How about not making it optional? refer to Machineinfo::deprecated.
> 
> Always providing it doesn't hurt.  If there is precedence for not
> making 
> it optional, mentioning that precedence in the commit message can't
> hurt.

No specific precedence. Just feel a little weird that adding an
additional boolean, just for judging another boolean should present or
not. esp. given that Machineinfo::deprecated is not optional.
> 


