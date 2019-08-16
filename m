Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101A4C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 16:49:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D15802077C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 16:49:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D15802077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyfQK-0003bI-IT
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 12:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46065)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1hyfPi-0003BH-0P
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 12:49:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hyfPg-0003Gk-Dg
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 12:49:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52194)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hyfPg-0003G2-7k
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 12:49:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3EA3181F0F;
 Fri, 16 Aug 2019 16:49:15 +0000 (UTC)
Received: from localhost (ovpn-116-32.gru2.redhat.com [10.97.116.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 48DA83795;
 Fri, 16 Aug 2019 16:49:12 +0000 (UTC)
Date: Fri, 16 Aug 2019 13:49:10 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190816164910.GA3908@habkost.net>
References: <20190815183803.13346-1-ehabkost@redhat.com>
 <20190815183803.13346-4-ehabkost@redhat.com>
 <87pnl5sks3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pnl5sks3.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Fri, 16 Aug 2019 16:49:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/3] pc: Don't make CPU properties
 mandatory unless necessary
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
Cc: Peter Krempa <pkrempa@redhat.com>, Like Xu <like.xu@linux.intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 16, 2019 at 08:10:20AM +0200, Markus Armbruster wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
> 
> > We have this issue reported when using libvirt to hotplug CPUs:
> > https://bugzilla.redhat.com/show_bug.cgi?id=1741451
> >
> > Basically, libvirt is not copying die-id from
> > query-hotpluggable-cpus, but die-id is now mandatory.
> 
> Uh-oh, "is now mandatory": making an optional property mandatory is an
> incompatible change.  When did we do that?  Commit hash, please.

Sorry, forgot to include a "Fixes:" line.

commit 176d2cda0dee9f4f78f604ad72d6a111e8e38f3b
Author: Like Xu <like.xu@linux.intel.com>
Date:   Wed Jun 12 16:40:58 2019 +0800

    i386/cpu: Consolidate die-id validity in smp context
    
    The field die_id (default as 0) and has_die_id are introduced to X86CPU.
    Following the legacy smp check rules, the die_id validity is added to
    the same contexts as leagcy smp variables such as hmp_hotpluggable_cpus(),
    machine_set_cpu_numa_node(), cpu_slot_to_string() and pc_cpu_pre_plug().
    
    Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
    Signed-off-by: Like Xu <like.xu@linux.intel.com>
    Message-Id: <20190612084104.34984-4-like.xu@linux.intel.com>
    Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
    Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>


-- 
Eduardo

