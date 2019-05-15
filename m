Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DEAC04E87
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 11:55:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A0552089E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 11:55:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A0552089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35705 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQsV2-00048N-6e
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 07:55:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1hQsUH-0003ph-KF
	for qemu-devel@nongnu.org; Wed, 15 May 2019 07:54:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1hQsUF-0004fa-2o
	for qemu-devel@nongnu.org; Wed, 15 May 2019 07:54:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43148)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1hQsUE-0004e6-R4
	for qemu-devel@nongnu.org; Wed, 15 May 2019 07:54:19 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 64F128666A;
	Wed, 15 May 2019 11:54:17 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B1E05D9E3;
	Wed, 15 May 2019 11:54:15 +0000 (UTC)
Date: Wed, 15 May 2019 13:54:13 +0200
From: Andrew Jones <drjones@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190515115413.cqvzjkky7xubnsuo@kamzik.brq.redhat.com>
References: <20190418092841.fzrcegkbal7dpfcy@kamzik.brq.redhat.com>
	<20190418112610.GO13773@redhat.com>
	<877ebrmch2.fsf@dusky.pond.sub.org>
	<20190513184237.i2ha3ixvhjqzkn5q@kamzik.brq.redhat.com>
	<87bm05ab6c.fsf@dusky.pond.sub.org>
	<20190514090225.vel4xm4x743o4rge@kamzik.brq.redhat.com>
	<20190514164838.48fc7603@Igors-MacBook-Pro>
	<20190515081854.kcpjm4zd2bzc7f6o@kamzik.brq.redhat.com>
	<20190515125229.1784f586@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515125229.1784f586@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Wed, 15 May 2019 11:54:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] How do we do user input bitmap properties?
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
Cc: peter.maydell@linaro.org,
	Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
	ehabkost@redhat.com, Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org, dgilbert@redhat.com, abologna@redhat.com,
	Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 15, 2019 at 12:52:29PM +0200, Igor Mammedov wrote:
> On Wed, 15 May 2019 10:18:54 +0200
> Andrew Jones <drjones@redhat.com> wrote:
> 
> > On Tue, May 14, 2019 at 04:48:38PM +0200, Igor Mammedov wrote:
> > > On Tue, 14 May 2019 11:02:25 +0200
> > > Andrew Jones <drjones@redhat.com> wrote:  
> > > > My thought is primarily machines. If a human wants to use the command
> > > > line and SVE, then I'm assuming they'll be happy with sve-max-vq or
> > > > figuring out a map they like once and then sticking to it.  
> > > 
> > > maybe naive question, but why not use a property/bit as user facing interface,
> > > in line with what we do with CPUID bits. (that's assuming that bits have
> > > fixed meaning).
> > > Yes, it's verbose but follows current practice and works fine with -cpu and
> > > -device.
> > > (I really hate custom preprocessing of -cpu and we were working hard to remove
> > > that in favor of canonical properties at the expense of more verbose CLI).
> > >  
> > 
> > Are you asking if we should do something like the following?
> > 
> >   -cpu host,sve1=on,sve=2=on,sve3=off,sve4=on
> > 
> > (Where the numbers represent the number of vector quadwords supported.)
> 
> something like this, but why not replace 1,2,... with more meaning full
>  sve-encrypt/sve-something-else/...
> since using magic numbers is not very descriptive
> (but if there is some spec where they come from that we could point users to
> it might be acceptable too, but I'd reserve number approach for values only).

The numbers aren't magic, they're part of the name. '1' in the above
'sve1' means one quadword. It would probably have been better to use bits
instead in the example, i.e.

  -cpu host,sve128=on,sve256=on,sve384=off,sve512=on

where it's now clear that "sve512" has an analogy with x86's "avx512".

> 
> > Naturally that would work, but it would be super verbose and require
> > adding tons of properties.
> yep, it's not very (human) user friendly but that's what mgmt applications
> are for and well users always can prepare a script for long CLI and use
> whatever abstractions they could think of.
> 

So I set off to convince Igor of the wide word idea (he sits next to me,
so I didn't have go far), but he has convinced me of the above property
idea. He used the magic phrase: "less code would be needed". If we use
the properties like above then we get introspection for free (cpu property
listing which libvirt already knows how to do) - so no QMP query needed.
The cost is adding several properties (16 to handle the current 2048-bit
limit), but I guess that's cheap enough. The command line is verbose, but
also much easier for a human to construct and read. I'm pretty sold on
this path, but adding Andrea and Eduardo for their input as well.

Thanks,
drew

