Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF39BC19759
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 00:50:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A93492083B
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 00:50:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A93492083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htLma-00063z-Ou
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 20:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59379)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richardw.yang@linux.intel.com>) id 1htLmC-0005fO-Ah
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 20:50:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1htLmB-00050c-9i
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 20:50:32 -0400
Received: from mga05.intel.com ([192.55.52.43]:64942)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1htLmA-0003bz-Vm
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 20:50:31 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 01 Aug 2019 17:49:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,336,1559545200"; d="scan'208";a="174786475"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by fmsmga007.fm.intel.com with ESMTP; 01 Aug 2019 17:49:27 -0700
Date: Fri, 2 Aug 2019 08:49:04 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Ivan Ren <renyime@gmail.com>
Message-ID: <20190802004904.GA20638@richard>
References: <1564464992-22305-1-git-send-email-ivanren@tencent.com>
 <20190801022118.GA21992@richard>
 <CA+6E1==Dc5Zac3Q-tt2V2pbq-DofW=AZX6tP1RoDBp4KSNxiKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+6E1==Dc5Zac3Q-tt2V2pbq-DofW=AZX6tP1RoDBp4KSNxiKw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.43
Subject: Re: [Qemu-devel] [PATCH] migration: always initial ram_counters for
 a new migration
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
Cc: quintela@redhat.com, Wei Yang <richardw.yang@linux.intel.com>,
 dgilbert@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 01, 2019 at 04:10:34PM +0800, Ivan Ren wrote:
>>>     s->iteration_start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>>>+    /*
>>>+     * Update s->iteration_initial_bytes to match
>s->iteration_start_time.
>>>+     */
>>>+    s->iteration_initial_bytes = migration_total_bytes(s);
>>
>>Is this one necessary? We have sent out nothing yet.
>
>Yes, currently nothing has been sent yet at this point.
>
>Is that better to always match the update of iteration_initial_bytes
>and iteration_start_time in a explicit way to avoid some potential missing?
>

You may get some point. Well after a close look, we may find other potential
problem.

1. To be consistency, we need to update iteration_initial_pages too.
   So my opinion is to wrap the update of these three counters into a helper
   function. So each time all of them.

2. In function ram_get_total_transferred_pages, do we missed multifd_bytes?

-- 
Wei Yang
Help you, Help me

