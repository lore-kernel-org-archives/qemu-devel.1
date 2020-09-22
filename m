Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3601C4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 05:08:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 226D023A84
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 05:08:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 226D023A84
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKaXp-0004kp-50
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 01:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.hu@linux.intel.com>)
 id 1kKaWX-0003Um-3p
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 01:07:29 -0400
Received: from mga12.intel.com ([192.55.52.136]:38959)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.hu@linux.intel.com>)
 id 1kKaWU-0008RP-Sd
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 01:07:28 -0400
IronPort-SDR: LwxK5Ey9vZOIIEu95TjjCONOp15Hpkvd0XtcKCHZfYK8y2ROusKRXH6kqEk5iyUOQrAjepIlpj
 /zFKUk/mNDTA==
X-IronPort-AV: E=McAfee;i="6000,8403,9751"; a="140015124"
X-IronPort-AV: E=Sophos;i="5.77,289,1596524400"; d="scan'208";a="140015124"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2020 22:07:24 -0700
IronPort-SDR: ThgZnCzHyubb2V+1EWT5So6/E+DWi4b8MOfcYqChq4rIBwcj8qEtACg0T0Bnj+co4R6J+67GT5
 VePW03M3RRuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,289,1596524400"; d="scan'208";a="304814554"
Received: from sqa-gate.sh.intel.com (HELO robert-ivt.tsp.org)
 ([10.239.48.212])
 by orsmga003.jf.intel.com with ESMTP; 21 Sep 2020 22:07:22 -0700
Message-ID: <d973bb935279f97b39a398e1fcdeedfb0ef6fc84.camel@linux.intel.com>
Subject: Re: [PATCH v3 1/2] Introduce (x86) CPU model deprecation API
From: Robert Hoo <robert.hu@linux.intel.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 22 Sep 2020 13:07:21 +0800
In-Reply-To: <20200921153704.GN57321@habkost.net>
References: <1600245434-63021-1-git-send-email-robert.hu@linux.intel.com>
 <20200917181831.GU7594@habkost.net>
 <509a84f209fe6ac60b2e4b913a49190d0f1eeaa2.camel@linux.intel.com>
 <20200918164237.GZ7594@habkost.net>
 <d3a01f58e5ab0886b2e4d53d5a73162769722cd7.camel@linux.intel.com>
 <20200921153704.GN57321@habkost.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-8.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=192.55.52.136;
 envelope-from=robert.hu@linux.intel.com; helo=mga12.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 01:07:24
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>, "Hu, Robert" <robert.hu@intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2020-09-21 at 11:37 -0400, Eduardo Habkost wrote:
> > 
...
> > Yes. Trying as less refactor as possible. I think my changes even
> > cannot be called refactor at all. :)
> > My idea is to make unversioned CPU model virtual. I did some patch,
> > doable:
> > 1) in x86_register_cpudef_types(), don't register cpu_model type
> > for
> > the unversioned 'Model'.
> > 2) in x86_cpu_class_by_name(), check passed-in cpu_model param
> > versioned or not, if the virtual unversioned 'Model', parse it to
> > some
> > concrete version by global default_cpu_version designation.
> > 
> > So, user can still use '-cpu Model' as before, no interface
> > changes.
> > And no nature changes:
> > 1) in current code, even legacy 'Model', you have created a v1
> > model
> > for it. i.e., every virtual 'Model' already has at least one
> > concrete
> > versioned one.
> > 2) in current code, x86_cpu_model_resolve_version() is called when
> > x86_cpu_load_model(). x86_cpu_model_resolve_version() actually does
> > kind of work that concreting unversioned Model to its versioned
> > one, by
> > global default_cpu_version designation. Same as my aforementioned
> > above.
> > 
> > Would you like me to integrate this implementation in v4? to have a
> > look.
> 
> I think we might give this a try, but I wouldn't like to have
> your model deprecation series delayed because of this.  Some
> obstacles I expect to see:
> 
> Right now the code assumes a 1:1 mapping between CPU model and
> QOM class.  We even have a `typename` field returned by
> query-cpu-definitions.
> 
> It would also become an obstacle for removing the existing
> arch-specific class_by_name methods and do the model->class
> mapping based solely on a string template.  See this thread for a
> glimpse on what we have been trying to do:
> https://lore.kernel.org/qemu-devel/877eb173a3.fsf@dusky.pond.sub.org/
> 
> I'm not saying we shouldn't do what you suggest, but it would add
> a lot of complexity to your CPU model deprecation work (that's
> very close to be ready to be merged).
> 
OK, I'm going to send v4 without this.
Then send this in a separate patch for discussion.
> > > > 
> > > --
> > > Eduardo
> > > 
> 
> 


