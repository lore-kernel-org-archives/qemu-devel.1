Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739D0C76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 09:19:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49E1D2173B
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 09:19:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49E1D2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoP36-0007GB-Je
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 05:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35863)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cohuck@redhat.com>) id 1hoP2u-0006kH-IS
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 05:19:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hoP2t-0000rK-Gn
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 05:19:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51978)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1hoP2t-0000oj-81; Fri, 19 Jul 2019 05:19:19 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6696F30C0DD6;
 Fri, 19 Jul 2019 09:19:17 +0000 (UTC)
Received: from gondolin (dhcp-192-181.str.redhat.com [10.33.192.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 13D7319C68;
 Fri, 19 Jul 2019 09:19:05 +0000 (UTC)
Date: Fri, 19 Jul 2019 11:19:03 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20190719111903.16c0ddca.cohuck@redhat.com>
In-Reply-To: <1563491554.u6nwg4s25n.astroid@bobo.none>
References: <20190718103951.10027-1-npiggin@gmail.com>
 <20190718103951.10027-2-npiggin@gmail.com>
 <c5e19e51-3a46-c56d-c555-691ec63dcf6e@redhat.com>
 <c697d1c9-b54a-ba0c-0952-7338b76ef01b@de.ibm.com>
 <1563491554.u6nwg4s25n.astroid@bobo.none>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Fri, 19 Jul 2019 09:19:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/3] qmp: don't emit the RESET event on
 wakeup
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org, Luiz Capitulino <lcapitulino@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, qemu-ppc@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 19 Jul 2019 09:24:20 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> Christian Borntraeger's on July 18, 2019 9:27 pm:
> > 
> > 
> > On 18.07.19 13:06, Paolo Bonzini wrote:  
> >> On 18/07/19 12:39, Nicholas Piggin wrote:  
> >>> Commit 1405819637f53 ("qmp: don't emit the RESET event on wakeup from
> >>> S3") changed system wakeup to avoid calling qapi_event_send_reset.
> >>> Commit 76ed4b18debfe ("s390/ipl: fix ipl with -no-reboot") appears to
> >>> have inadvertently broken that logic.
> >>>
> >>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >>> ---
> >>> I'm not quite sure if this patch is correct and haven't tested it, I
> >>> found it by inspection. If this patch is incorrect, I will have to
> >>> adjust patch 2.
> >>>
> >>>  vl.c | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/vl.c b/vl.c
> >>> index 5089fce6c5..ef3c7ab8b8 100644
> >>> --- a/vl.c
> >>> +++ b/vl.c
> >>> @@ -1550,7 +1550,7 @@ void qemu_system_reset(ShutdownCause reason)
> >>>      } else {
> >>>          qemu_devices_reset();
> >>>      }
> >>> -    if (reason != SHUTDOWN_CAUSE_SUBSYSTEM_RESET) {
> >>> +    if (reason && reason != SHUTDOWN_CAUSE_SUBSYSTEM_RESET) {
> >>>          qapi_event_send_reset(shutdown_caused_by_guest(reason), reason);
> >>>      }
> >>>      cpu_synchronize_all_post_reset();
> >>>  
> >> 
> >> Yes, it seems correct and I've queued it for 4.1.  

FWIW,
Acked-by: Cornelia Huck <cohuck@redhat.com>

> > 
> > Yes makes sense. 
> > Would it be better to write out if(reason) e.g. replace "reason" with "reason != SHUTDOWN_CAUSE_NONE" ?  
> 
> I guess it's a matter of preference so I won't weigh in :) My patch
> did try to revert back to the previous form but I'm happy to change
> it.
> 
> > Going even further, I am asking myself if something like
> > 
> > diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> > index 60bd081d3ef3..406743566869 100644
> > --- a/hw/s390x/ipl.c
> > +++ b/hw/s390x/ipl.c
> > @@ -577,7 +577,7 @@ void s390_ipl_reset_request(CPUState *cs, enum s390_reset reset_type)
> >      if (reset_type == S390_RESET_MODIFIED_CLEAR ||
> >          reset_type == S390_RESET_LOAD_NORMAL) {
> >          /* ignore -no-reboot, send no event  */
> > -        qemu_system_reset_request(SHUTDOWN_CAUSE_SUBSYSTEM_RESET);
> > +        qemu_system_reset_request(SHUTDOWN_CAUSE_NONE);
> >      } else {
> >          qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> >      }
> > 
> > would also work.  

Doesn't that have side effects in qemu_system_reset_request()?

> 
> If that works for you, then you could take out the test in the reset
> code. You would have to modify qemu_system_reset_request too of course.
> 
> But it seems a bit unsatisfactory to change the reason for the request
> so as to influence behaviour. Either the requests should ask for 
> particular behaviour, or the logic for determining how to handle
> the type of request should remain in the reset logic, I would say.

Agreed.

