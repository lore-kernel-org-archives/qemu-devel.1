Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CF6C49ED6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 02:52:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A6BB2075C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 02:52:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A6BB2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8FE6-0001hi-BD
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 22:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55672)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richardw.yang@linux.intel.com>) id 1i8FDS-0001G0-Qq
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 22:52:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1i8FDR-0001np-S3
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 22:52:14 -0400
Received: from mga17.intel.com ([192.55.52.151]:25631)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1i8FDR-0001n5-In
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 22:52:13 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Sep 2019 19:52:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; d="scan'208";a="197089110"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by orsmga002.jf.intel.com with ESMTP; 11 Sep 2019 19:52:10 -0700
Date: Thu, 12 Sep 2019 10:51:50 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190912025150.GA25169@richard>
References: <20190321082555.21118-1-richardw.yang@linux.intel.com>
 <20190321082555.21118-3-richardw.yang@linux.intel.com>
 <d5fb9e01-acb9-06ab-edf9-57e2b80bd880@redhat.com>
 <20190823010750.GA21179@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823010750.GA21179@richard>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.151
Subject: Re: [Qemu-devel] [PATCH 2/6] exec.c: remove an unnecessary assert
 on PHYS_MAP_NODE_NIL in phys_map_node_alloc()
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
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, rth@twiddle.net, qemu-devel@nongnu.org,
 mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 23, 2019 at 09:07:50AM +0800, Wei Yang wrote:
>On Thu, Aug 22, 2019 at 12:24:32PM +0200, Paolo Bonzini wrote:
>>On 21/03/19 09:25, Wei Yang wrote:
>>> PHYS_MAP_NODE_NIL is assigned to PhysPageEntry.ptr in case this is not a
>>> leaf entry, while map->nodes_nb range in [0, nodes_nb_alloc).
>>> 
>>> Seems we are asserting on two different things, just remove it.
>>
>>The assertion checks that this "if" is not entered incorrectly:
>>
>>    if (lp->skip && lp->ptr == PHYS_MAP_NODE_NIL) {
>>        lp->ptr = phys_map_node_alloc(map, level == 0);
>>    }
>>
>
>Hmm... I may not get your point.
>
>phys_map_node_alloc() will get an available PhysPageEntry and return its
>index, which will be assigned to its parent's ptr.
>
>The "if" checks on the parent's ptr, while the assertion asserts the index for
>the new child. I may miss something?
>

Hi, Paolo,

Do I miss something?


-- 
Wei Yang
Help you, Help me

