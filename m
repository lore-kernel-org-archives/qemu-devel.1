Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58ED4C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 08:50:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CC162085A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 08:50:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CC162085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42990 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQT8x-0003NO-7B
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 04:50:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hQT89-0002xi-5k
	for qemu-devel@nongnu.org; Tue, 14 May 2019 04:49:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hQT87-0005Ep-9M
	for qemu-devel@nongnu.org; Tue, 14 May 2019 04:49:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52416)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hQT86-00053h-Uz; Tue, 14 May 2019 04:49:47 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 557ECA96EA;
	Tue, 14 May 2019 08:49:43 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 063325D720;
	Tue, 14 May 2019 08:49:36 +0000 (UTC)
Date: Tue, 14 May 2019 10:49:34 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <20190514104934.6bba9232.cohuck@redhat.com>
In-Reply-To: <066c7470-94a3-a922-9a12-1ca42e474c51@de.ibm.com>
References: <1556749903-19221-1-git-send-email-walling@linux.ibm.com>
	<a87c71be-5bf8-a115-5843-720c9ad10c7b@redhat.com>
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
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Tue, 14 May 2019 08:49:43 +0000 (UTC)
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
Cc: Collin Walling <walling@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>, mst@redhat.com,
	qemu-devel@nongnu.org, pasic@linux.ibm.com,
	qemu-s390x@nongnu.org, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 14 May 2019 10:37:32 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 14.05.19 09:28, David Hildenbrand wrote:
> >>>> But that can be tested using the runability information if I am not wrong.  
> >>>
> >>> You mean the cpu level information, right?  
> > 
> > Yes, query-cpu-definition includes for each model runability information
> > via "unavailable-features" (valid under the started QEMU machine).
> >   
> >>>  
> >>>>  
> >>>>> and others that we have today.
> >>>>>
> >>>>> So yes, I think this would be acceptable.    
> >>>>
> >>>> I guess it is acceptable yes. I doubt anybody uses that many CPUs in
> >>>> production either way. But you never know.  
> >>>
> >>> I think that using that many cpus is a more uncommon setup, but I still
> >>> think that having to wait for actual failure  
> >>
> >> That can happen all the time today. You can easily say z14 in the xml when 
> >> on a zEC12. Only at startup you get the error. The question is really:  
> > 
> > "-smp 248 -cpu host" will no longer work, while e.g. "-smp 248 -cpu z12"
> > will work. Actually, even "-smp 248" will no longer work on affected
> > machines.
> > 
> > That is why wonder if it is better to disable the feature and print a
> > warning. Similar to CMMA, where want want to tolerate when CMMA is not
> > possible in the current environment (huge pages).
> > 
> > "Diag318 will not be enabled because it is not compatible with more than
> > 240 CPUs".
> > 
> > However, I still think that implementing support for more than one SCLP
> > response page is the best solution. Guests will need adaptions for > 240
> > CPUs with Diag318, but who cares? Existing setups will continue to work.
> > 
> > Implementing that SCLP thingy will avoid any warnings and any errors. It
> > just works from the QEMU perspective.
> > 
> > Is implementing this realistic?  
> 
> Yes it is but it will take time. I will try to get this rolling. To make
> progress on the diag318 thing, can we error on startup now and simply
> remove that check when when have implemented a larger sccb? If we would
> now do all kinds of "change the max number games" would be harder to "fix".

So, the idea right now is:

- fail to start if you try to specify a diag318 device and more than
  240 cpus (do we need a knob to turn off the device?)
- in the future, support more than one SCLP response page

I'm getting a bit lost in the discussion; but the above sounds
reasonable to me.

