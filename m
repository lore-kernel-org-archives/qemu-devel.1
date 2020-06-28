Return-Path: <SRS0=WNoQ=AJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306FBC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 01:47:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0307A20768
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 01:47:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0307A20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpMPr-0000NG-6e
	for qemu-devel@archiver.kernel.org; Sat, 27 Jun 2020 21:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1jpMPG-0008OY-5X
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 21:46:54 -0400
Received: from mga05.intel.com ([192.55.52.43]:36585)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1jpMPD-00033y-2e
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 21:46:53 -0400
IronPort-SDR: vmjMuFDM/ecgooy6dNVW/juwM7SRfLqqMBXV3VY+RPM06galTFB7wCGK45H2kSU5S5Ce4LLsAw
 TPmypPexOh1w==
X-IronPort-AV: E=McAfee;i="6000,8403,9665"; a="230540871"
X-IronPort-AV: E=Sophos;i="5.75,289,1589266800"; d="scan'208";a="230540871"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2020 18:46:46 -0700
IronPort-SDR: CoYf6tHUz10Ma+Sm2kZjdKVEH2bgOaSEdr8VgEo9gTelxe4gzOgyRwJ9r9mdDlUfvpl0avvJ4i
 FveS+tAwyzHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,289,1589266800"; d="scan'208";a="309746486"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.16])
 by orsmga007.jf.intel.com with ESMTP; 27 Jun 2020 18:46:43 -0700
Date: Sat, 27 Jun 2020 21:36:37 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [RFC v2 1/1] memory: Delete assertion in
 memory_region_unregister_iommu_notifier
Message-ID: <20200628013637.GD18338@joy-OptiPlex-7040>
References: <20200626064122.9252-1-eperezma@redhat.com>
 <20200626064122.9252-2-eperezma@redhat.com>
 <20200626212917.GD175520@xz-x1>
 <20200627072644.GC18338@joy-OptiPlex-7040>
 <20200627125714.GA212287@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200627125714.GA212287@xz-x1>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: pass client-ip=192.55.52.43; envelope-from=yan.y.zhao@intel.com;
 helo=mga05.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/27 21:46:46
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 Yan Zhao <yan.y.zhao@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Auger <eric.auger@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Jun 27, 2020 at 08:57:14AM -0400, Peter Xu wrote:
> On Sat, Jun 27, 2020 at 03:26:45AM -0400, Yan Zhao wrote:
> > > -    assert(entry->iova >= notifier->start && entry_end <= notifier->end);
> > > +    if (notifier->notifier_flags & IOMMU_NOTIFIER_ARBITRARY_MASK) {
> > > +        tmp.iova = MAX(tmp.iova, notifier->start);
> > > +        tmp.addr_mask = MIN(tmp.addr_mask, notifier->end);
> > NIT:
> >        tmp.addr_mask = MIN(entry_end, notifier->end) - tmp.iova;
> 
> Right.  Thanks. :)
> 
> > > +        assert(tmp.iova <= tmp.addr_mask);
> > no this assertion then.
> 
> Or change it into:
> 
>   assert(MIN(entry_end, notifier->end) >= tmp.iova);
> 
> To double confirm no overflow.
>
what about assert in this way, so that it's also useful to check overflow
in the other condition.

hwaddr entry_end = entry->iova + entry->addr_mask;
+
+ assert(notifier->end >= notifer->start && entry_end >= entry->iova);


then as there's a following filter
    if (notifier->start > entry_end || notifier->end < entry->iova) {
        return;
    }

we can conclude that

entry_end >= entry->iova(tmp.iova)
entry_end >= notifier->start,
--> entry_end >= MAX(tmp.iova, notfier->start)
--> entry_end >= tmp.iova


notifier->end >= entry->iova (tmp.iova),
notifier->end >= notifer->start,
--> notifier->end >= MAX(tmp.iova, nofier->start)
--> notifier->end >= tmp.iova

==> MIN(end_end, notifer->end) >= tmp.iova

Thanks
Yan

