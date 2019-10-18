Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B20CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 09:44:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E35020820
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 09:44:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E35020820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLOoY-0004Aa-Fe
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 05:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48352)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iLOnf-0003Bb-LN
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 05:44:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iLOnd-0003BC-OS
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 05:43:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37128)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iLOnd-0003Aj-Io
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 05:43:57 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7654A18CB916;
 Fri, 18 Oct 2019 09:43:56 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 201B71001B33;
 Fri, 18 Oct 2019 09:43:54 +0000 (UTC)
Date: Fri, 18 Oct 2019 10:43:52 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v2 2/2] migration: savevm_state_handler_insert:
 constant-time element insertion
Message-ID: <20191018094352.GC2990@work-vm>
References: <20191017205953.13122-1-cheloha@linux.vnet.ibm.com>
 <20191017205953.13122-3-cheloha@linux.vnet.ibm.com>
 <20191018081625.GA2990@work-vm>
 <351dca8e-e77c-c450-845b-d78ba621156a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <351dca8e-e77c-c450-845b-d78ba621156a@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Fri, 18 Oct 2019 09:43:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>,
 Juan Quintela <quintela@redhat.com>,
 Scott Cheloha <cheloha@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Laurent Vivier (lvivier@redhat.com) wrote:
> On 18/10/2019 10:16, Dr. David Alan Gilbert wrote:
> > * Scott Cheloha (cheloha@linux.vnet.ibm.com) wrote:
> >> savevm_state's SaveStateEntry TAILQ is a priority queue.  Priority
> >> sorting is maintained by searching from head to tail for a suitable
> >> insertion spot.  Insertion is thus an O(n) operation.
> >>
> >> If we instead keep track of the head of each priority's subqueue
> >> within that larger queue we can reduce this operation to O(1) time.
> >>
> >> savevm_state_handler_remove() becomes slightly more complex to
> >> accomodate these gains: we need to replace the head of a priority's
> >> subqueue when removing it.
> >>
> >> With O(1) insertion, booting VMs with many SaveStateEntry objects is
> >> more plausible.  For example, a ppc64 VM with maxmem=8T has 40000 such
> >> objects to insert.
> > 
> > Separate from reviewing this patch, I'd like to understand why you've
> > got 40000 objects.  This feels very very wrong and is likely to cause
> > problems to random other bits of qemu as well.
> 
> I think the 40000 objects are the "dr-connectors" that are used to plug
> peripherals (memory, pci card, cpus, ...).

Yes, Scott confirmed that in the reply to the previous version.
IMHO nothing in qemu is designed to deal with that many devices/objects
- I'm sure that something other than the migration code is going to get upset.

Is perhaps the structure wrong somewhere - should there be a single DRC
device that knows about all DRCs?

Dave


> https://github.com/qemu/qemu/blob/master/hw/ppc/spapr_drc.c
> 
> They are part of SPAPR specification.
> 
> https://raw.githubusercontent.com/qemu/qemu/master/docs/specs/ppc-spapr-hotplug.txt
> 
> CC Michael Roth
> 
> Thanks,
> Laurent
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

