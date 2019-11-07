Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3B5C5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 12:05:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50F982187F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 12:05:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50F982187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSgXP-0008IU-FB
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 07:05:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54130)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iSgW2-0007Of-2t
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 07:03:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iSgW0-0005oR-Kz
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 07:03:53 -0500
Received: from mga14.intel.com ([192.55.52.115]:11553)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1iSgVz-0005kk-BH
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 07:03:52 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 07 Nov 2019 04:03:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,278,1569308400"; d="scan'208";a="233237290"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by fmsmga002.fm.intel.com with ESMTP; 07 Nov 2019 04:03:42 -0800
Date: Thu, 7 Nov 2019 20:03:32 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 0/6] migration/postcopy: enable compress during postcopy
Message-ID: <20191107120332.GA25593@richard>
References: <20191018004850.9888-1-richardw.yang@linux.intel.com>
 <20191106201144.GM2802@work-vm> <20191107060210.GB13394@richard>
 <20191107091544.GB2816@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107091544.GB2816@work-vm>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.115
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
Cc: qemu-devel@nongnu.org, Wei Yang <richardw.yang@linux.intel.com>,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 07, 2019 at 09:15:44AM +0000, Dr. David Alan Gilbert wrote:
>* Wei Yang (richardw.yang@linux.intel.com) wrote:
>> On Wed, Nov 06, 2019 at 08:11:44PM +0000, Dr. David Alan Gilbert wrote:
>> >* Wei Yang (richardw.yang@linux.intel.com) wrote:
>> >> This patch set tries enable compress during postcopy.
>> >> 
>> >> postcopy requires to place a whole host page, while migration thread migrate
>> >> memory in target page size. This makes postcopy need to collect all target
>> >> pages in one host page before placing via userfaultfd.
>> >> 
>> >> To enable compress during postcopy, there are two problems to solve:
>> >> 
>> >>     1. Random order for target page arrival
>> >>     2. Target pages in one host page arrives without interrupt by target
>> >>        page from other host page
>> >> 
>> >> The first one is handled by counting the number of target pages arrived
>> >> instead of the last target page arrived.
>> >> 
>> >> The second one is handled by:
>> >> 
>> >>     1. Flush compress thread for each host page
>> >>     2. Wait for decompress thread for before placing host page
>> >> 
>> >> With the combination of these two changes, compress is enabled during
>> >> postcopy.
>> >
>> >What have you tested this with? 2MB huge pages I guess?
>> >
>> 
>> I tried with this qemu option:
>> 
>>    -object memory-backend-file,id=mem1,mem-path=/dev/hugepages/guest2,size=4G \
>>    -device pc-dimm,id=dimm1,memdev=mem1
>> 
>> /dev/hugepages/guest2 is a file under hugetlbfs
>> 
>>    hugetlbfs on /dev/hugepages type hugetlbfs (rw,relatime,pagesize=2M)
>
>OK, yes that should be fine.
>I suspect on Power/ARM where they have normal memory with 16/64k pages,
>the cost of the flush will mean compression is more expensive in
>postcopy mode; but still makes it possible.
>

Not get your point clearly about more expensive. You mean more expensive on
ARM/Power?

If the solution looks good to you, I would prepare v2.

>Dave
>
>> >Dave
>> >
>> >> Wei Yang (6):
>> >>   migration/postcopy: reduce memset when it is zero page and
>> >>     matches_target_page_size
>> >>   migration/postcopy: wait for decompress thread in precopy
>> >>   migration/postcopy: count target page number to decide the
>> >>     place_needed
>> >>   migration/postcopy: set all_zero to true on the first target page
>> >>   migration/postcopy: enable random order target page arrival
>> >>   migration/postcopy: enable compress during postcopy
>> >> 
>> >>  migration/migration.c | 11 --------
>> >>  migration/ram.c       | 65 ++++++++++++++++++++++++++++++-------------
>> >>  2 files changed, 45 insertions(+), 31 deletions(-)
>> >> 
>> >> -- 
>> >> 2.17.1
>> >> 
>> >--
>> >Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>> 
>> -- 
>> Wei Yang
>> Help you, Help me
>--
>Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

-- 
Wei Yang
Help you, Help me

