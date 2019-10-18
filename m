Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260DCCA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 22:16:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA6AA21852
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 22:16:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA6AA21852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLaXw-0003Kc-0U
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 18:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58526)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iLaWg-0002Qn-HO
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 18:15:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iLaWd-00063Y-My
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 18:15:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39456)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iLaWd-0005zy-Eb
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 18:15:11 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 265A33086E23;
 Fri, 18 Oct 2019 22:15:09 +0000 (UTC)
Received: from redhat.com (ovpn-116-49.ams2.redhat.com [10.36.116.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 991EE79AD;
 Fri, 18 Oct 2019 22:15:08 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Scott Cheloha <cheloha@linux.vnet.ibm.com>
Subject: Re: [PATCH] migration: savevm_state_insert_handler: constant-time
 element insertion
In-Reply-To: <20191017192508.nwa2a34hzen3xgnr@rascal.austin.ibm.com> (Scott
 Cheloha's message of "Thu, 17 Oct 2019 14:25:08 -0500")
References: <20191016164156.4506-1-cheloha@linux.vnet.ibm.com>
 <87lftjpxsz.fsf@trasno.org>
 <20191017192508.nwa2a34hzen3xgnr@rascal.austin.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
Date: Sat, 19 Oct 2019 00:15:07 +0200
Message-ID: <87pnit7las.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Fri, 18 Oct 2019 22:15:09 +0000 (UTC)
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
Reply-To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Scott Cheloha <cheloha@linux.vnet.ibm.com> wrote:
> On Thu, Oct 17, 2019 at 10:43:08AM +0200, Juan Quintela wrote:
>> Scott Cheloha <cheloha@linux.vnet.ibm.com> wrote:
>> 
>> > Registering a SaveStateEntry object via savevm_state_insert_handler()
>> > is an O(n) operation because the list is a priority queue maintained by
>> > walking the list from head to tail to find a suitable insertion point.
>> >
>> > This adds considerable overhead for VMs with many such objects.  For
>> > instance, ppc64 machines with large maxmem (8T+) spend ~10% or more of
>> > their CPU time in savevm_state_insert_handler() before attempting to
>> > boot a kernel.

> I was trying to avoid churning the file more than absolutely
> necessary.  There are 18 QTAILQ_FOREACH() loops in savevm.c right now.
> Making ~15 of them double-loops doesn't make the code easier to read.

Change thecode to be something different, I agree that is more churn,
but ...

>
> I think incurring slight complexity on insertion/removal to make
> insertion fast is well worth the conceptual simplicity of addressing
> one big list of elements for every other operation.
>
>> savevm_state_handler_insert() for instance becomes even easier, just a
>> QTALIQ_INSERT_TAIL() in the proper queue, right?
>
> Yes, insertion becomes extremely obvious: you just append the element
> to the tail of its priority queue, which must already exist.
>
> But see above for the cost.
>
>> I agree with the idea of the patch.  Especially when you told us how bad
>> the performance of the current code is.
>> 
>> Out of curiosity, how many objects are we talking about?
>
> At maxmem=8T I'm seeing about 40000 elements in that list.  At
> maxmem=64T I'm seeing around 262000.  The vast majority of these
> elements are "spapr_drc" objects, each of which (IIRC) corresponds to
> a 256MB chunk of address space.

We are having trouble because we have too many objects.  So, the right
approach IMHO is just to add the list of queueue.  Looking into the
functions:

static int calculate_new_instance_id(const char *idstr)
static int calculate_compat_instance_id(const char *idstr)
   * We can call QTAILQ_FOREACH in the propper subqueue

static void savevm_state_handler_insert(SaveStateEntry *nse)
   * We don't need the call if we do propper subqueues array

void unregister_savevm(DeviceState *dev, const char *idstr, void
   *opaque)
   * We can use the propper subqueue

vmstate_unregister
   * We can use the propper subqueue

bool qemu_savevm_state_blocked(Error **errp)
  * We need to loop over all queues

void qemu_savevm_state_setup(QEMUFile *f)
int qemu_savevm_state_resume_prepare(MigrationState *s)
int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy)
void qemu_savevm_state_complete_postcopy(QEMUFile *f)
int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool
  in_postcopy)
int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
void qemu_savevm_state_pending(QEMUFile *f, uint64_t threshold_size,
void qemu_savevm_state_cleanup(void)
int qemu_save_device_state(QEMUFile *f)
static int qemu_loadvm_state_setup(QEMUFile *f)
void qemu_loadvm_state_cleanup(void)
 * Loop over all queues

static SaveStateEntry *find_se(const char *idstr, int instance_id)
qemu_loadvm_section_part_end(QEMUFile *f, MigrationIncomingState *mis)
* we know the propper queue


But basically all the ones that we need to loop over all queues don't
have local state, so we can create a

loop_over_all_handlers() function that takes a callback and does all the
work.  They don't share states between iterations.

What do you think?
My problem with your appreach is that it makes insertion/removal more
expensive, that is where you are showing performance problems.  In the
places where we need to loop over all queues, we need to do it over all
elements anyways, so the performance difference is going to be
negigible.

Once told that, having 40000 elements on that queue, it will make
"downtime" for migration "interesting", to say the least, no?  How much
size are we talking about?  Should we consider moving it to a live
section?


Later, Juan.

