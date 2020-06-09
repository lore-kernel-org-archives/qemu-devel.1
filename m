Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98832C433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 19:42:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DA82206C3
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 19:42:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DA82206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jik8Y-0006iB-MW
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 15:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sean.j.christopherson@intel.com>)
 id 1jik7s-0006HN-0u; Tue, 09 Jun 2020 15:41:36 -0400
Received: from mga14.intel.com ([192.55.52.115]:58481)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sean.j.christopherson@intel.com>)
 id 1jik7q-0008Ge-1t; Tue, 09 Jun 2020 15:41:35 -0400
IronPort-SDR: ucM/8V6Av/yxpRzu4akGLARy5zjD8O21KESuTx8J54Zh9lSyzaoJeJzppWtS2XuPWeS1lgZ8WM
 26kJkijVTYpQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2020 12:41:15 -0700
IronPort-SDR: fhpdYRU5FgDmU+5o30NEvGCc5e7/YKXxQnuMiuSUD8hh0wChFEOHE5LVXEdfazJB2uHlQbzAxZ
 TYStdIYJL2Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,493,1583222400"; d="scan'208";a="349620540"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com)
 ([10.54.74.152])
 by orsmga001.jf.intel.com with ESMTP; 09 Jun 2020 12:41:14 -0700
Date: Tue, 9 Jun 2020 12:41:14 -0700
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 00/20] virtio-mem: Paravirtualized memory hot(un)plug
Message-ID: <20200609194114.GA15818@linux.intel.com>
References: <20200603144914.41645-1-david@redhat.com>
 <20200609091034-mutt-send-email-mst@kernel.org>
 <08385823-d98f-fd9d-aa9d-bc1bd6747c29@redhat.com>
 <20200609115814-mutt-send-email-mst@kernel.org>
 <20200609161814.GJ2366737@habkost.net>
 <33021b38-cf60-fbfc-1baa-478ee6eed376@redhat.com>
 <20200609144242-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609144242-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Received-SPF: pass client-ip=192.55.52.115;
 envelope-from=sean.j.christopherson@intel.com; helo=mga14.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 15:41:15
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 teawater <teawaterz@linux.alibaba.com>, Janosch Frank <frankja@linux.ibm.com>,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Richard Henderson <rth@twiddle.net>, Eric Farman <farman@linux.ibm.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Hailiang Zhang <zhang.zhanghailiang@huawei.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Pierre Morel <pmorel@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-s390x@nongnu.org, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 09, 2020 at 02:42:59PM -0400, Michael S. Tsirkin wrote:
> On Tue, Jun 09, 2020 at 08:38:15PM +0200, David Hildenbrand wrote:
> > On 09.06.20 18:18, Eduardo Habkost wrote:
> > > On Tue, Jun 09, 2020 at 11:59:04AM -0400, Michael S. Tsirkin wrote:
> > >> On Tue, Jun 09, 2020 at 03:26:08PM +0200, David Hildenbrand wrote:
> > >>> On 09.06.20 15:11, Michael S. Tsirkin wrote:
> > >>>> On Wed, Jun 03, 2020 at 04:48:54PM +0200, David Hildenbrand wrote:
> > >>>>> This is the very basic, initial version of virtio-mem. More info on
> > >>>>> virtio-mem in general can be found in the Linux kernel driver v2 posting
> > >>>>> [1] and in patch #10. The latest Linux driver v4 can be found at [2].
> > >>>>>
> > >>>>> This series is based on [3]:
> > >>>>>     "[PATCH v1] pc: Support coldplugging of virtio-pmem-pci devices on all
> > >>>>>      buses"
> > >>>>>
> > >>>>> The patches can be found at:
> > >>>>>     https://github.com/davidhildenbrand/qemu.git virtio-mem-v3
> > >>>>
> > >>>> So given we tweaked the config space a bit, this needs a respin.
> > >>>
> > >>> Yeah, the virtio-mem-v4 branch already contains a fixed-up version. Will
> > >>> send during the next days.
> > >>
> > >> BTW. People don't normally capitalize the letter after ":".
> > >> So a better subject is
> > >>   virtio-mem: paravirtualized memory hot(un)plug
> > > 
> > > I'm not sure that's still the rule:
> > > 
> > > [qemu/(49ee115552...)]$ git log --oneline v4.0.0.. | egrep ': [A-Z]' | wc -l
> > > 5261
> > > [qemu/(49ee115552...)]$ git log --oneline v4.0.0.. | egrep ': [a-z]' | wc -l
> > > 2921
> > > 
> > 
> > Yeah, I switched to this scheme some years ago (I even remember that
> > some QEMU maintainer recommended it). I decided to just always
> > capitalize. Not that it should really matter ... :)
> 
> Don't mind about qemu but you don't want to do that for Linux.

Heh, depends on who you ask.  The tip tree maintainers (strongly) prefer
capitalizing the first word after the colon[*], and that naturally
percolates into a lot of other subsystems, e.g. I follow that pattern for
KVM so that I don't have to remember to switch when submitting patches
against a tip branch.


+Patch subject
+^^^^^^^^^^^^^
+
+The tip tree preferred format for patch subject prefixes is
+'subsys/component:', e.g. 'x86/apic:', 'x86/mm/fault:', 'sched/fair:',
+'genirq/core:'. Please do not use file names or complete file paths as
+prefix. 'git log path/to/file' should give you a reasonable hint in most
+cases.
+
+The condensed patch description in the subject line should start with a
+uppercase letter and should be written in imperative tone.

[*] https://lkml.kernel.org/r/20181107171149.165693799@linutronix.de


