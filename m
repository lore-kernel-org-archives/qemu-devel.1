Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E4EC04AB7
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 09:33:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5957A2147A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 09:33:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5957A2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44140 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQTo1-0003uT-MI
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 05:33:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hQTlI-000286-7y
	for qemu-devel@nongnu.org; Tue, 14 May 2019 05:30:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hQTlH-0000dR-Au
	for qemu-devel@nongnu.org; Tue, 14 May 2019 05:30:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hQTlH-0000cd-4n; Tue, 14 May 2019 05:30:15 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2621E87648;
	Tue, 14 May 2019 09:30:14 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 530DC5D729;
	Tue, 14 May 2019 09:30:07 +0000 (UTC)
Date: Tue, 14 May 2019 11:30:05 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: David Hildenbrand <david@redhat.com>
Message-ID: <20190514113005.2d0c2b1c.cohuck@redhat.com>
In-Reply-To: <078b7bcd-de03-743d-a150-456be0b09362@redhat.com>
References: <1556749903-19221-1-git-send-email-walling@linux.ibm.com>
	<bc2fd9bb-7b94-eac7-590b-f01d2063ef9c@redhat.com>
	<e948a030-bd30-180e-bbd6-76f4a2390bb9@de.ibm.com>
	<ea6df6b1-4062-c057-92ea-5be40d778fe9@redhat.com>
	<09293a1c-d000-83a8-46b8-b97ad4fa9774@de.ibm.com>
	<56e3ace1-6e48-0e20-47d5-b07ac6dfcf31@redhat.com>
	<e140a076-28a0-0db6-4c59-80e0f2ab44bb@de.ibm.com>
	<c690c4a8-c277-e3c6-3697-3f0a1924559b@redhat.com>
	<20190513134637.3d8bb275.cohuck@redhat.com>
	<898144e3-615e-5074-fb68-bf9995c64609@de.ibm.com>
	<155d2ca3-6a48-c99a-fe42-dca8e3fd4344@redhat.com>
	<066c7470-94a3-a922-9a12-1ca42e474c51@de.ibm.com>
	<20190514104934.6bba9232.cohuck@redhat.com>
	<47f7134b-338f-0207-88ae-4c1969be3786@redhat.com>
	<13b0f0b2-f7c7-01fb-0e17-92bd47d9c346@de.ibm.com>
	<b280d46f-4a0f-f5dd-c89b-b85210d190ca@redhat.com>
	<00b5d031-227b-38f7-9512-e36c3b655c62@de.ibm.com>
	<27bd36e1-a102-e793-6a61-3e7acb6f1255@de.ibm.com>
	<078b7bcd-de03-743d-a150-456be0b09362@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Tue, 14 May 2019 09:30:14 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v4] s390: diagnose 318 info
 reset and migration support
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

On Tue, 14 May 2019 11:27:32 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 14.05.19 11:25, Christian Borntraeger wrote:
> > 
> > 
> > On 14.05.19 11:23, Christian Borntraeger wrote:  
> >>
> >>
> >> On 14.05.19 11:20, David Hildenbrand wrote:  
> >>> On 14.05.19 11:10, Christian Borntraeger wrote:  
> >>>>
> >>>>
> >>>> On 14.05.19 10:59, David Hildenbrand wrote:  

> >>>>> We can
> >>>>>
> >>>>> 1. Fail to start with #cpus > 240 when diag318=on
> >>>>> 2. Remove the error once we support more than one SCLP response page
> >>>>>
> >>>>> Or
> >>>>>
> >>>>> 1. Allow to start with #cpus > 240 when diag318=on, but indicate only
> >>>>>    240 CPUs via SCLP
> >>>>> 2. Print a warning
> >>>>> 3. Remove the restriction and the warning once we support more than one
> >>>>>    SCLP response page
> >>>>>
> >>>>> While I prefer the second approach (similar to defining zPCI devices
> >>>>> without zpci=on), I could also live with the first approach.  
> >>>>
> >>>> I prefer approach 1.
> >>>>  
> >>>
> >>> Isn't approach #2 what we discussed (limiting sclp, but of course to 247
> >>> CPUs), but with an additional warning? I'm confused.  
> >>
> >> Different numbering interpretion. I was talking about 1 = "Allow to start with #cpus > 240 when diag318=on, but indicate only
> >> 240 CPUs via SCLP"  
> > 
> > So yes, variant 2 when I use your numbering. The only question is: do we need
> > a warning? It probably does not hurt.   
> 
> After all, we are talking about 1 VCPU that the guest can only use by
> indirect probing ... I leave that up to Collin :)

I'd prefer a warning... even if it is a corner case, I think it's
better to be explicit instead of silent.

