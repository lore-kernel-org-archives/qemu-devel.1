Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B40CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 17:27:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCF0F222C3
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 17:27:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCF0F222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLW2O-0006mb-U3
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 13:27:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57639)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iLW1W-0006H7-H8
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:26:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iLW1T-0001Ck-Pu
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:26:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58470)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iLW1T-0001CL-Hf
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:26:43 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7EA943071CD1;
 Fri, 18 Oct 2019 17:26:42 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D6B5A100EA05;
 Fri, 18 Oct 2019 17:26:40 +0000 (UTC)
Date: Fri, 18 Oct 2019 18:26:38 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/2] migration: savevm_state_handler_insert:
 constant-time element insertion
Message-ID: <20191018172638.GD2990@work-vm>
References: <20191017205953.13122-1-cheloha@linux.vnet.ibm.com>
 <20191017205953.13122-3-cheloha@linux.vnet.ibm.com>
 <20191018081625.GA2990@work-vm>
 <351dca8e-e77c-c450-845b-d78ba621156a@redhat.com>
 <20191018094352.GC2990@work-vm>
 <157141671749.15348.15966144834012002565@sif>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157141671749.15348.15966144834012002565@sif>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Fri, 18 Oct 2019 17:26:42 +0000 (UTC)
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
Cc: Laurent Vivier <lvivier@redhat.com>, david@gibson.dropbear.id.au,
 Scott Cheloha <cheloha@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Michael Roth (mdroth@linux.vnet.ibm.com) wrote:
> Quoting Dr. David Alan Gilbert (2019-10-18 04:43:52)
> > * Laurent Vivier (lvivier@redhat.com) wrote:
> > > On 18/10/2019 10:16, Dr. David Alan Gilbert wrote:
> > > > * Scott Cheloha (cheloha@linux.vnet.ibm.com) wrote:
> > > >> savevm_state's SaveStateEntry TAILQ is a priority queue.  Priority
> > > >> sorting is maintained by searching from head to tail for a suitable
> > > >> insertion spot.  Insertion is thus an O(n) operation.
> > > >>
> > > >> If we instead keep track of the head of each priority's subqueue
> > > >> within that larger queue we can reduce this operation to O(1) time.
> > > >>
> > > >> savevm_state_handler_remove() becomes slightly more complex to
> > > >> accomodate these gains: we need to replace the head of a priority's
> > > >> subqueue when removing it.
> > > >>
> > > >> With O(1) insertion, booting VMs with many SaveStateEntry objects is
> > > >> more plausible.  For example, a ppc64 VM with maxmem=8T has 40000 such
> > > >> objects to insert.
> > > > 
> > > > Separate from reviewing this patch, I'd like to understand why you've
> > > > got 40000 objects.  This feels very very wrong and is likely to cause
> > > > problems to random other bits of qemu as well.
> > > 
> > > I think the 40000 objects are the "dr-connectors" that are used to plug
> > > peripherals (memory, pci card, cpus, ...).
> > 
> > Yes, Scott confirmed that in the reply to the previous version.
> > IMHO nothing in qemu is designed to deal with that many devices/objects
> > - I'm sure that something other than the migration code is going to get upset.
> 
> The device/object management aspect seems to handle things *mostly* okay, at
> least ever since QOM child properties started being tracked by a hash table
> instead of a linked list. It's worth noting that that change (b604a854) was
> done to better handle IRQ pins for ARM guests with lots of CPUs. I think it is
> inevitable that certain machine types/configurations will call for large
> numbers of objects and I think it is fair to improve things to allow for this
> sort of scalability.
> 
> But I agree it shouldn't be abused, and you're right that there are some
> problem areas that arise. Trying to outline them:
> 
>  a) introspection commands like 'info qom-tree' become pretty unwieldly,
>     and with large enough numbers of objects might even break things (QMP
>     response size limits maybe?)
>  b) various related lists like reset handlers, vmstate/savevm handlers might
>     grow quite large
> 
> I think we could work around a) with maybe flagging certain
> "internally-only" objects as 'hidden'. Introspection routines could then
> filter these out, and routines like qom-set/qom-get could return report
> something similar to EACCESS so they are never used/useful to management
> tools.
> 
> In cases like b) we can optimize things where it makes sense like with
> Scott's patch here. In most cases these lists need to be walked one way
> or another, whether it's done internally by the object or through common
> interfaces provided by QEMU. It's really just the O(n^2) type handling
> where relying on common interfaces becomes drastically less efficient,
> but I think we should avoid implementing things in that way anyway, or
> improve them as needed.
> 
> > 
> > Is perhaps the structure wrong somewhere - should there be a single DRC
> > device that knows about all DRCs?
> 
> That's an interesting proposition, I think it's worth exploring further,
> but from a high level:
> 
>  - each SpaprDrc has migration state, and some sub-classes SpaprDrc (e.g.
>    SpaprDrcPhysical) have additional migration state. These are sent
>    as-needed as separate VMState entries in the migration stream.
>    Moving to a single DRC means we're either sending them as an flat
>    array or a sparse list, which would put just as much load on the
>    migration code (at least, with Scott's changes in place). It would
>    also be difficult to do all this in a way which maintains migration
>    compatibility with older machine types.

Having sparse arrays etc within a vmstate isn't as bad; none of
them actually need to be 'objects' as such - even if you have
separate chunks of VMState.

>  - other aspects of modeling these as QOM objects, such as look-ups,
>    reset-handling, and memory allocations, wouldn't be dramatically
>    improved upon by handling it all internally within the object
> 
> AFAICT the biggest issue with modeling the DRCs as individual objects
> is actually how we deal with introspection, and we should try to
> improve. What do you think of the alternative suggestion above of
> marking certain objects as 'hidden' from various introspection
> interfaces?

That's one for someone who knows/cares about QOM more than me;
Paolo, Dan Berrange, or Eduardo Habkost are QOM people.

Dave

> > 
> > Dave
> > 
> > 
> > > https://github.com/qemu/qemu/blob/master/hw/ppc/spapr_drc.c
> > > 
> > > They are part of SPAPR specification.
> > > 
> > > https://raw.githubusercontent.com/qemu/qemu/master/docs/specs/ppc-spapr-hotplug.txt
> > > 
> > > CC Michael Roth
> > > 
> > > Thanks,
> > > Laurent
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

