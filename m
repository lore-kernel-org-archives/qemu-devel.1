Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CA1C73C7C
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 08:21:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DFFD20693
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 08:21:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DFFD20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hl7rA-0005ri-E6
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 04:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52879)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cohuck@redhat.com>) id 1hl7qO-0005PJ-W0
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 04:20:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hl7qN-0002sP-5g
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 04:20:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46354)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1hl7qM-0002pe-SE; Wed, 10 Jul 2019 04:20:51 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9A988300602A;
 Wed, 10 Jul 2019 08:20:47 +0000 (UTC)
Received: from gondolin (dhcp-192-232.str.redhat.com [10.33.192.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D16321001B02;
 Wed, 10 Jul 2019 08:20:43 +0000 (UTC)
Date: Wed, 10 Jul 2019 10:20:41 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Collin Walling <walling@linux.ibm.com>
Message-ID: <20190710102041.6be31940.cohuck@redhat.com>
In-Reply-To: <0dd71cfe-a9e9-7ac3-523e-065f05479a57@linux.ibm.com>
References: <20190708125433.16927-1-cohuck@redhat.com>
 <20190708125433.16927-2-cohuck@redhat.com>
 <58b28817-58e5-1cba-6f71-a35093be5cb6@de.ibm.com>
 <0dd71cfe-a9e9-7ac3-523e-065f05479a57@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Wed, 10 Jul 2019 08:20:48 +0000 (UTC)
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

On Tue, 9 Jul 2019 18:55:34 -0400
Collin Walling <walling@linux.ibm.com> wrote:

> On 7/8/19 9:23 AM, Christian Borntraeger wrote:
> > 
> > 
> > On 08.07.19 14:54, Cornelia Huck wrote:  
> >> According to the comment, the bits are supposed to accumulate.
> >>
> >> Reported-by: Stefan Weil <sw@weilnetz.de>
> >> Fixes: 5d1abf234462 ("s390x/pci: enforce zPCI state checking")
> >> Signed-off-by: Cornelia Huck <cohuck@redhat.com>  
> > 
> > This patch does not change behaviour, so it is certainly not wrong.
> > 
> > So lets have a look at if the bug report was actually a real bug or
> > just a missing annotation.
> >   
> >> ---
> >>   hw/s390x/s390-pci-inst.c | 2 ++
> >>   1 file changed, 2 insertions(+)
> >>
> >> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
> >> index 61f30b8e55d2..00235148bed7 100644
> >> --- a/hw/s390x/s390-pci-inst.c
> >> +++ b/hw/s390x/s390-pci-inst.c
> >> @@ -1209,8 +1209,10 @@ int stpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
> >>        * FH Enabled bit is set to one in states of ENABLED, BLOCKED or ERROR. */
> >>       case ZPCI_FS_ERROR:
> >>           fib.fc |= 0x20;
> >> +        /* fallthrough */  
> > 
> > This is correct, in case of an error we are also blocked.
> >   
> 
> Agreed. This is definitely correct based on our architecture.
> 
> >>       case ZPCI_FS_BLOCKED:
> >>           fib.fc |= 0x40;
> >> +        /* fallthrough */  
> > 
> > I think this is also correct, but  it would be good if Collin could verify.
> >   
> 
> I failed to find anything to support setting the function control
> enabled bit when the function state is in error / blocked. I'm
> assuming this might be some QEMU hack to get things working? I'll have
> to dive further to understand why this was done this way, as it doesn't
> align with how the s390x architecture is documented. It's confusing.

Might this also be a real issue? Not matching the architecture is not a
good sign...

> 
> Functionally, this doesn't change anything... so I'll at least give it
> an ACK for now and investigate this further.

I prefer to hold off on this patch for now, unless we're really sure
that the code does not have a problem here. Actually documenting
something that might be wrong does not sound like the right thing to
do :/

> 
> >>       case ZPCI_FS_ENABLED:
> >>           fib.fc |= 0x80;
> >>           if (pbdev->iommu->enabled) {
> >>  
> > 
> >   
> 
> Acked-by: Collin Walling <walling@linux.ibm.com>
> 
> Side note: is there somewhere that I could access this bug report? :)

It's the build log with the extra warnings in
https://qemu.weilnetz.de/results/build-20190708.txt (referenced in
<591d71a5-5b10-ab22-4751-01da8613d84c@weilnetz.de> on qemu-devel).

