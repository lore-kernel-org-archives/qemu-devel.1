Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD1AC3A5A6
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 05:58:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B06A20820
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 05:58:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B06A20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCHMd-0003sw-7i
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 01:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50894)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iCHLt-0003Px-G8
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 01:57:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iCHLs-0003tj-8L
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 01:57:37 -0400
Received: from mga01.intel.com ([192.55.52.88]:13557)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1iCHLr-0002Qc-V7
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 01:57:36 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 22 Sep 2019 22:56:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,539,1559545200"; d="scan'208";a="190561039"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by orsmga003.jf.intel.com with ESMTP; 22 Sep 2019 22:56:27 -0700
Date: Mon, 23 Sep 2019 13:56:08 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 0/3] migration/postcopy: unsentmap is not necessary
Message-ID: <20190923055608.GA7750@richard>
References: <20190819061843.28642-1-richardw.yang@linux.intel.com>
 <20190916060642.GA13437@richard> <20190920185351.GD2687@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920185351.GD2687@work-vm>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.88
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
Cc: pbonzini@redhat.com, quintela@redhat.com,
 Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 20, 2019 at 07:53:51PM +0100, Dr. David Alan Gilbert wrote:
>* Wei Yang (richardw.yang@linux.intel.com) wrote:
>> Hi, Dave and Juan
>> 
>> Would you mind taking a look at this one?
>
>Yes, I'll have a look, I'm just fighting through a bunch of other stuff.
>

Yep, thanks ~ Me too :-)

Have a good day

>Dave
>
>> On Mon, Aug 19, 2019 at 02:18:40PM +0800, Wei Yang wrote:
>> >Three patches to cleanup postcopy:
>> >
>> >[1]: split canonicalize bitmap and discard page
>> >[2]: remove unsentmap since it is not necessary
>> >[3]: cleanup the get_queued_page_not_dirty
>> >
>> >Wei Yang (3):
>> >  migration/postcopy: not necessary to do discard when canonicalizing
>> >    bitmap
>> >  migration/postcopy: unsentmap is not necessary for postcopy
>> >  migration: remove sent parameter in get_queued_page_not_dirty
>> >
>> > include/exec/ram_addr.h |  6 ---
>> > migration/ram.c         | 94 +++++++----------------------------------
>> > migration/trace-events  |  2 +-
>> > 3 files changed, 16 insertions(+), 86 deletions(-)
>> >
>> >-- 
>> >2.17.1
>> 
>> -- 
>> Wei Yang
>> Help you, Help me
>--
>Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

-- 
Wei Yang
Help you, Help me

