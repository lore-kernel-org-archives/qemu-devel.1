Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A790C04AB1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 11:56:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10E09208CA
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 11:56:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10E09208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55674 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ9Yl-0001qe-9e
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 07:55:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hQ9XE-0000rH-8h
	for qemu-devel@nongnu.org; Mon, 13 May 2019 07:54:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hQ9Pt-0003fX-6p
	for qemu-devel@nongnu.org; Mon, 13 May 2019 07:46:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45004)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hQ9Pr-0003eU-8S; Mon, 13 May 2019 07:46:47 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DCB4336807;
	Mon, 13 May 2019 11:46:45 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E88F26B8E3;
	Mon, 13 May 2019 11:46:39 +0000 (UTC)
Date: Mon, 13 May 2019 13:46:37 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: David Hildenbrand <david@redhat.com>
Message-ID: <20190513134637.3d8bb275.cohuck@redhat.com>
In-Reply-To: <c690c4a8-c277-e3c6-3697-3f0a1924559b@redhat.com>
References: <1556749903-19221-1-git-send-email-walling@linux.ibm.com>
	<a87c71be-5bf8-a115-5843-720c9ad10c7b@redhat.com>
	<bc2fd9bb-7b94-eac7-590b-f01d2063ef9c@redhat.com>
	<e948a030-bd30-180e-bbd6-76f4a2390bb9@de.ibm.com>
	<ea6df6b1-4062-c057-92ea-5be40d778fe9@redhat.com>
	<09293a1c-d000-83a8-46b8-b97ad4fa9774@de.ibm.com>
	<56e3ace1-6e48-0e20-47d5-b07ac6dfcf31@redhat.com>
	<e140a076-28a0-0db6-4c59-80e0f2ab44bb@de.ibm.com>
	<c690c4a8-c277-e3c6-3697-3f0a1924559b@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Mon, 13 May 2019 11:46:46 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4] s390: diagnose 318 info reset and
 migration support
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Collin Walling <walling@linux.ibm.com>, mst@redhat.com,
	qemu-devel@nongnu.org, pasic@linux.ibm.com,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	qemu-s390x@nongnu.org, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 13 May 2019 13:34:35 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 13.05.19 12:55, Christian Borntraeger wrote:
> > 
> > 
> > On 13.05.19 11:57, David Hildenbrand wrote:  
> >> On 13.05.19 11:51, Christian Borntraeger wrote:  
> >>>
> >>>
> >>> On 13.05.19 11:40, David Hildenbrand wrote:  
> >>>> On 13.05.19 11:34, Christian Borntraeger wrote:  
> >>>>>
> >>>>>
> >>>>> On 13.05.19 10:03, David Hildenbrand wrote:  
> >>>>>>>> +    if ((SCCB_SIZE - sizeof(ReadInfo)) / sizeof(CPUEntry) < S390_MAX_CPUS)
> >>>>>>>> +        mc->max_cpus = S390_MAX_CPUS - 8;  
> >>>>>>>
> >>>>>>> This is too complicated, just set it always to 240.
> >>>>>>>
> >>>>>>> However, I am still not sure how to best handle this scenario. One
> >>>>>>> solution is
> >>>>>>>
> >>>>>>> 1. Set it statically to 240 for machine > 4.1
> >>>>>>> 2. Keep the old machines unmodifed
> >>>>>>> 3. Don't indicate the CPU feature for machines <= 4.0
> >>>>>>>
> >>>>>>> #3 is the problematic part, as it mixes host CPU features and machines.
> >>>>>>> Bad. The host CPU model should always look the same on all machines. I
> >>>>>>> don't like this.
> >>>>>>>  
> >>>>>>
> >>>>>> FWIW, #3 is only an issue when modeling it via the CPU model, like
> >>>>>> Christian suggested.
> >>>>>>
> >>>>>> I suggest the following
> >>>>>>
> >>>>>> 1. Set the max #cpus for 4.1 to 240 (already done)
> >>>>>> 2. Keep it for the other machines unmodified (as suggested by Thomas)
> >>>>>> 3. Create the layout of the SCCB depending on the machine type (to be done)
> >>>>>>
> >>>>>> If we want to model diag318 via a CPU feature (which makes sense for
> >>>>>> migration):
> >>>>>>
> >>>>>> 4. Disable diag318 with a warning if used with a machine < 4.1
> >>>>>>  
> >>>>>
> >>>>> I think there is a simpler solution. It is perfectly fine to fail the startup
> >>>>> if we cannot fulfil the cpu model. So lets just allow 248 and allow this feature 
> >>>>> also for older machines. And if somebody chooses both at the same time,
> >>>>> lets fails the startup.  
> >>>>
> >>>> To which knob do you want to glue the layout of the SCLP response? Like
> >>>> I described?  Do you mean instead of warning and masking the feature off
> >>>> as I suggested, simply failing?  
> >>>
> >>> The sclp response will depend on the dia318 cpu model flag. If its on, the sclp
> >>> response will have it, otherwise not.
> >>> - host-passthrough: not migration safe anyway
> >>> - host-model: if the target has diag318 good, otherwise we reject migration   
> >>>>
> >>>> In that case, -machine ..-4.0 -cpu host will not work on new HW with new
> >>>> KVM. Just noting.  
> >>>
> >>> Only if you have 248 CPUs (which is unlikely). My point was to do that for all
> >>> machine levels.
> >>>  
> >>
> >> The issue with this approach is that e.g. libvirt is not aware of this
> >> restriction. It could query "max_cpus" and expand the host-cpu model,
> >> but starting a guest with > 240 cpus would fail. Maybe this is acceptable.  
> > 
> > As of today we do the cpu model check in the same way. libvirt actually tries
> > to run QEMU and handles failures.
> > 
> > For a failure, the user still has still to use >240 CPUs in its XML. The only downside
> > is that libvirt will not reject this right away.
> > 
> > During startup we would then print an error message like
> > 
> > "The diag318 cpu feature is only supported for 240 and less CPUs."
> > 
> > This is of similar quality as
> > "Selected CPU GA level is too new. Maximum supported model in the configuration: \'%s\'",
> >   
> 
> But that can be tested using the runability information if I am not wrong.

You mean the cpu level information, right?

> 
> > and others that we have today.
> > 
> > So yes, I think this would be acceptable.  
> 
> I guess it is acceptable yes. I doubt anybody uses that many CPUs in
> production either way. But you never know.

I think that using that many cpus is a more uncommon setup, but I still
think that having to wait for actual failure is worse than being able
to find out beforehand. Any way to make this discoverable?

