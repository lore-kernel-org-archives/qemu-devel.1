Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C58C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 08:54:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C576D2077C
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 08:54:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C576D2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnfi9-0002HV-Um
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 04:54:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53654)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cohuck@redhat.com>) id 1hnfhz-0001oE-N6
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 04:54:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hnfhy-0006k6-Kd
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 04:54:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58940)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1hnfhy-0006jX-By; Wed, 17 Jul 2019 04:54:42 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 90D244E93D;
 Wed, 17 Jul 2019 08:54:41 +0000 (UTC)
Received: from gondolin (dhcp-192-232.str.redhat.com [10.33.192.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C892B600C8;
 Wed, 17 Jul 2019 08:54:37 +0000 (UTC)
Date: Wed, 17 Jul 2019 10:54:35 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Collin Walling <walling@linux.ibm.com>
Message-ID: <20190717105435.64047ca3.cohuck@redhat.com>
In-Reply-To: <f72fb90b-8383-a2f8-b768-b09be5845fb5@linux.ibm.com>
References: <20190708125433.16927-1-cohuck@redhat.com>
 <20190708125433.16927-2-cohuck@redhat.com>
 <58b28817-58e5-1cba-6f71-a35093be5cb6@de.ibm.com>
 <0dd71cfe-a9e9-7ac3-523e-065f05479a57@linux.ibm.com>
 <20190710102041.6be31940.cohuck@redhat.com>
 <20190716172002.77863317.cohuck@redhat.com>
 <f72fb90b-8383-a2f8-b768-b09be5845fb5@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Wed, 17 Jul 2019 08:54:41 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH for-4.1 1/2] s390x/pci: add
 some fallthrough annotations
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
Cc: David Hildenbrand <david@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 16 Jul 2019 14:34:22 -0400
Collin Walling <walling@linux.ibm.com> wrote:

> On 7/16/19 11:20 AM, Cornelia Huck wrote:
> > On Wed, 10 Jul 2019 10:20:41 +0200
> > Cornelia Huck <cohuck@redhat.com> wrote:
> >   
> >> On Tue, 9 Jul 2019 18:55:34 -0400
> >> Collin Walling <walling@linux.ibm.com> wrote:
> >>  
> >>> On 7/8/19 9:23 AM, Christian Borntraeger wrote:  
> >>>>
> >>>>
> >>>> On 08.07.19 14:54, Cornelia Huck wrote:  
> >>>>> According to the comment, the bits are supposed to accumulate.
> >>>>>
> >>>>> Reported-by: Stefan Weil <sw@weilnetz.de>
> >>>>> Fixes: 5d1abf234462 ("s390x/pci: enforce zPCI state checking")
> >>>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>  
> >>>>
> >>>> This patch does not change behaviour, so it is certainly not wrong.
> >>>>
> >>>> So lets have a look at if the bug report was actually a real bug or
> >>>> just a missing annotation.
> >>>>        
> >>>>> ---
> >>>>>    hw/s390x/s390-pci-inst.c | 2 ++
> >>>>>    1 file changed, 2 insertions(+)
> >>>>>
> >>>>> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
> >>>>> index 61f30b8e55d2..00235148bed7 100644
> >>>>> --- a/hw/s390x/s390-pci-inst.c
> >>>>> +++ b/hw/s390x/s390-pci-inst.c
> >>>>> @@ -1209,8 +1209,10 @@ int stpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
> >>>>>         * FH Enabled bit is set to one in states of ENABLED, BLOCKED or ERROR. */
> >>>>>        case ZPCI_FS_ERROR:
> >>>>>            fib.fc |= 0x20;
> >>>>> +        /* fallthrough */  
> >>>>
> >>>> This is correct, in case of an error we are also blocked.
> >>>>        
> >>>
> >>> Agreed. This is definitely correct based on our architecture.
> >>>      
> >>>>>        case ZPCI_FS_BLOCKED:
> >>>>>            fib.fc |= 0x40;
> >>>>> +        /* fallthrough */  
> >>>>
> >>>> I think this is also correct, but  it would be good if Collin could verify.
> >>>>        
> >>>
> >>> I failed to find anything to support setting the function control
> >>> enabled bit when the function state is in error / blocked. I'm
> >>> assuming this might be some QEMU hack to get things working? I'll have
> >>> to dive further to understand why this was done this way, as it doesn't
> >>> align with how the s390x architecture is documented. It's confusing.  
> >>
> >> Might this also be a real issue? Not matching the architecture is not a
> >> good sign...  
> > 
> > Friendly ping. If we still want to have this patch or a fix in 4.1, we
> > need to find out soon...
> >   
> 
> Let's take it for now.
> 
> Acked-by: Collin Walling <walling@linux.ibm.com>
> 

Just to be clear: You think that the current code is correct AFAYCS?

