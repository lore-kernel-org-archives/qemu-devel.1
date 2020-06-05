Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE370C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 02:48:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A09FC207D5
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 02:48:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A09FC207D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh2PN-0007Lq-Sq
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 22:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.hu@linux.intel.com>)
 id 1jh2Ol-0006vE-Rp
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 22:47:59 -0400
Received: from mga09.intel.com ([134.134.136.24]:11562)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.hu@linux.intel.com>)
 id 1jh2Oj-0008FQ-RA
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 22:47:59 -0400
IronPort-SDR: 8eFs7toWm2WHVM0FQZHoNYTPqj8XCXEYWltVM9+fea5rPMGzRhaml6eDK58kbX33DAgk78I9iQ
 P/uZqpi0eLkA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2020 19:47:50 -0700
IronPort-SDR: mIStpf+EmSOJZC8gYTKpqfkMEgDcDYSBvNT4J19+MBYnnMO/LCuwSoxsItWDzeY7+LcS7xGrMZ
 I1/gPNgd79CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,474,1583222400"; d="scan'208";a="304922191"
Received: from sqa-gate.sh.intel.com (HELO robert-ivt.tsp.org)
 ([10.239.48.212])
 by fmsmga002.fm.intel.com with ESMTP; 04 Jun 2020 19:47:47 -0700
Message-ID: <f43f253883e448edbf4cc4e7d685cbf66256f743.camel@linux.intel.com>
Subject: Re: [PATCH 1/2] Introduce (x86) CPU model deprecation API
From: Robert Hoo <robert.hu@linux.intel.com>
To: Eric Blake <eblake@redhat.com>, pbonzini@redhat.com, rth@twiddle.net, 
 ehabkost@redhat.com, armbru@redhat.com
Date: Fri, 05 Jun 2020 10:47:46 +0800
In-Reply-To: <c0c1643d-ff3c-919b-7684-dac14f0d5229@redhat.com>
References: <1591184823-140846-1-git-send-email-robert.hu@linux.intel.com>
 <70e5d2d1-8bd0-5582-4f8f-066824a7d263@redhat.com>
 <f4ea936819b698c88773ec69cf9d535fb7c32a4a.camel@linux.intel.com>
 <c0c1643d-ff3c-919b-7684-dac14f0d5229@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-5.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=134.134.136.24;
 envelope-from=robert.hu@linux.intel.com; helo=mga09.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 22:47:50
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001 autolearn=_AUTOLEARN
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

On Thu, 2020-06-04 at 06:59 -0500, Eric Blake wrote:
> On 6/4/20 3:07 AM, Robert Hoo wrote:
> 
> > > > +++ b/qapi/machine-target.json
> > > > @@ -309,7 +309,8 @@
> > > >                'static': 'bool',
> > > >                '*unavailable-features': [ 'str' ],
> > > >                'typename': 'str',
> > > > -            '*alias-of' : 'str' },
> > > > +            '*alias-of' : 'str',
> > > > +            'deprecated' : 'bool' },
> > > 
> > > Missing documentation of the new member.  Should it be optional
> > > (present
> > > only when true)?
> > 
> > Which document do you mean?

Thanks Eric:)

> 
> A few lines earlier is '@alias-of: ...'; you'll need to add a
> similar 
> line for '@deprecated', mentioning it is '(since 5.1)'.
> 
> > How to make it optional?

How about not making it optional? refer to Machineinfo::deprecated.
> 
> Name it '*deprecated', then deal with 'has_deprecated' in the C code
> for 
> the cases where the member should be output.
> 


