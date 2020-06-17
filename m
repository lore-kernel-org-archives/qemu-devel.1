Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262EEC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 19:06:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF20D2075E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 19:06:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF20D2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jldOJ-0007bN-4N
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 15:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sean.j.christopherson@intel.com>)
 id 1jldNZ-00074F-GJ
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 15:05:45 -0400
Received: from mga01.intel.com ([192.55.52.88]:12384)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sean.j.christopherson@intel.com>)
 id 1jldNW-0004gw-VO
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 15:05:44 -0400
IronPort-SDR: lHs0pygtoXuEkSZ40KwPl0ySOUpUDT9zzNK/FhQ2NhFZ7g8NROwUTyy5jvY5wpT4HegbsokeZq
 jiqC58wBU2AQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2020 12:05:32 -0700
IronPort-SDR: XztOJDHgbQY8wEatCSDsf/pm+Js+VSyGDjFqjN7iS+FfhRetz0YtWeGfJtFMpq9DWsrvzCYFkf
 AB7TIP7maa3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,523,1583222400"; d="scan'208";a="277374707"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com)
 ([10.54.74.152])
 by orsmga006.jf.intel.com with ESMTP; 17 Jun 2020 12:05:32 -0700
Date: Wed, 17 Jun 2020 12:05:32 -0700
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: kvm-forum-2020-pc@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: CFP: KVM Forum 2020 virtual experience
Message-ID: <20200617190531.GL26818@linux.intel.com>
References: <a1d960aa-c1a0-ff95-68a8-6e471028fe1e@redhat.com>
 <391a9edc-57e3-75a8-c762-d1606fefb4ae@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <391a9edc-57e3-75a8-c762-d1606fefb4ae@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Received-SPF: pass client-ip=192.55.52.88;
 envelope-from=sean.j.christopherson@intel.com; helo=mga01.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 15:05:32
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: "libvir-list@redhat.com" <libvir-list@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, KVM list <kvm@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 17, 2020 at 05:09:31PM +0200, Paolo Bonzini wrote:
> In order to allow everyone to present at KVM Forum, including people
> who might not have been able to travel to Dublin, we are extending the
> submission deadline for presentations for 6 more weeks!
> 
> * CFP Closes: Sunday, August 2 at 11:59 PM PST

Blasting the lists as I'm guessing I'm not alone in having a topic whose
status could change substantially in the next 6 weeks...

What is the recommended course of action for people that would like to edit
an already-submitted proposal?  I don't see any way to edit or delete via
the web interface.

