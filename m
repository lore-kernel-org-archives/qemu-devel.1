Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083F5C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 11:24:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2472206BF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 11:24:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2472206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54700 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNbjl-0007Ea-4b
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 07:24:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hNbig-0006N5-VB
	for qemu-devel@nongnu.org; Mon, 06 May 2019 07:23:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hNbif-0002qk-Ub
	for qemu-devel@nongnu.org; Mon, 06 May 2019 07:23:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36132)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hNbif-0002qM-KH; Mon, 06 May 2019 07:23:41 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EBF083082B44;
	Mon,  6 May 2019 11:23:40 +0000 (UTC)
Received: from gondolin (unknown [10.40.205.81])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D980D27073;
	Mon,  6 May 2019 11:23:34 +0000 (UTC)
Date: Mon, 6 May 2019 13:23:25 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <20190506132325.7c9cf997.cohuck@redhat.com>
In-Reply-To: <5206e568-c85e-b918-1809-62453c03cb61@de.ibm.com>
References: <1556543381-12671-1-git-send-email-jjherne@linux.ibm.com>
	<daad75f0-c8bb-1c9f-5b43-afa828601c42@redhat.com>
	<df6bde4f-9c83-5009-3ca8-32d7a5e088d3@redhat.com>
	<55907be5-61a5-f251-4609-b0336818de17@redhat.com>
	<98a268ee-17fb-079e-01d1-5dc554a24efd@de.ibm.com>
	<20190506123414.5b33b6f8.cohuck@redhat.com>
	<9493076a-6bbe-21eb-4df3-2b54dc6376b9@de.ibm.com>
	<20190506130542.635513b1.cohuck@redhat.com>
	<5206e568-c85e-b918-1809-62453c03cb61@de.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Mon, 06 May 2019 11:23:41 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH] s390-bios: Skip bootmap
 signature entries
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
Cc: "Jason J. Herne" <jjherne@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
	David Hildenbrand <david@redhat.com>, alifm@linux.ibm.com,
	qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 6 May 2019 13:13:55 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 06.05.19 13:05, Cornelia Huck wrote:
> > On Mon, 6 May 2019 12:46:50 +0200
> > Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> >   
> >> On 06.05.19 12:34, Cornelia Huck wrote:  
> >>> On Mon, 6 May 2019 12:18:42 +0200
> >>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:  
> >   
> >>>> I think we should not. Those entries might have sematic elements that the guest
> >>>> wants to enforce. I do not think that this will come, but imagine a boot entry
> >>>> that mandates some security wishes (e.g. do only run on non-shared cores).    
> >>>
> >>> Can we split the namespace for BOOT_SCRIPT into 'ignore if you don't
> >>> know what that is' and 'fail if you don't know what that is'? I'm
> >>> completely confused how 'optional' those entries are supposed to be...    
> >>
> >> Since we do not know if and what future entries will come the current default
> >> of failing seems the best approach. We can then add things to pc-bios when
> >> necessary.  
> > 
> > That's where I'm coming from: Have some values where unknown entries
> > lead to (desired) failure, and others where unknown entries are simply
> > ignored. That would give us automatic toleration for optional entries.  
> 
> Well, this is the first new entry after 14 years of list-directed-ipl so there
> is a slight chance to over-engineer here ;-)
> 
> In the end this is a field that does not belong to Linux-only, it is also defined
> by the machine architecture.

Yeah, I understand that having to get this into the main architecture
makes this harder to change.

If there is nothing coming in the foreseeable future that would need
toleration (and not failure), it's probably not worth spending more
time on that and we should just go with this patch.

I'd recommend putting this (+ a rebuild) into stable as well, though,
so that at least 4.0-stable will tolerate signatures. (Distros
backporting this would be a good idea as well.)

