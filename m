Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C2EC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 18:32:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BB0E20673
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 18:32:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BB0E20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58521 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUEzi-0005Oy-97
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 14:32:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hUExa-0004M3-IQ
	for qemu-devel@nongnu.org; Fri, 24 May 2019 14:30:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hUErv-0008TP-7s
	for qemu-devel@nongnu.org; Fri, 24 May 2019 14:24:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34466)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hUErv-0008Ss-0V
	for qemu-devel@nongnu.org; Fri, 24 May 2019 14:24:39 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EF95A308421A;
	Fri, 24 May 2019 18:24:37 +0000 (UTC)
Received: from localhost (ovpn-116-14.gru2.redhat.com [10.97.116.14])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 347BC68738;
	Fri, 24 May 2019 18:24:36 +0000 (UTC)
Date: Fri, 24 May 2019 15:24:34 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Andrea Bolognani <abologna@redhat.com>
Message-ID: <20190524182434.GH10764@habkost.net>
References: <20190418112610.GO13773@redhat.com>
	<877ebrmch2.fsf@dusky.pond.sub.org>
	<20190513184237.i2ha3ixvhjqzkn5q@kamzik.brq.redhat.com>
	<87bm05ab6c.fsf@dusky.pond.sub.org>
	<20190514090225.vel4xm4x743o4rge@kamzik.brq.redhat.com>
	<20190514164838.48fc7603@Igors-MacBook-Pro>
	<20190515081854.kcpjm4zd2bzc7f6o@kamzik.brq.redhat.com>
	<20190515125229.1784f586@redhat.com>
	<20190515115413.cqvzjkky7xubnsuo@kamzik.brq.redhat.com>
	<2186eb85f8541b0c9cc69cacae9321ace8addaa6.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2186eb85f8541b0c9cc69cacae9321ace8addaa6.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Fri, 24 May 2019 18:24:38 +0000 (UTC)
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
Cc: peter.maydell@linaro.org, Andrew Jones <drjones@redhat.com>,
	Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
	qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>, Dave.Martin@arm.com,
	dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 23, 2019 at 10:35:24AM +0200, Andrea Bolognani wrote:
> On Wed, 2019-05-15 at 13:54 +0200, Andrew Jones wrote:
> > On Wed, May 15, 2019 at 12:52:29PM +0200, Igor Mammedov wrote:
> > > since using magic numbers is not very descriptive
> > > (but if there is some spec where they come from that we could point users to
> > > it might be acceptable too, but I'd reserve number approach for values only).
> > 
> > The numbers aren't magic, they're part of the name. '1' in the above
> > 'sve1' means one quadword. It would probably have been better to use bits
> > instead in the example, i.e.
> > 
> >   -cpu host,sve128=on,sve256=on,sve384=off,sve512=on
> > 
> > where it's now clear that "sve512" has an analogy with x86's "avx512".
> > 
> [...]
> > 
> > So I set off to convince Igor of the wide word idea (he sits next to me,
> > so I didn't have go far), but he has convinced me of the above property
> > idea. He used the magic phrase: "less code would be needed". If we use
> > the properties like above then we get introspection for free (cpu property
> > listing which libvirt already knows how to do) - so no QMP query needed.
> > The cost is adding several properties (16 to handle the current 2048-bit
> > limit), but I guess that's cheap enough. The command line is verbose, but
> > also much easier for a human to construct and read. I'm pretty sold on
> > this path, but adding Andrea and Eduardo for their input as well.
> 
> Sorry for taking a while to respond. Anyway, the above looks good to
> me as a general direction, but note that you'll have to implement at
> the very least the query-cpu-model-expansion QMP command for the
> introspection to work.

Why is query-cpu-model-expansion needed?  Isn't
device-list-properties enough?

> 
> query-cpu-model-baseline and query-cpu-model-comparison are two more
> QMP command which, while perhaps not immediately applicabile, we will
> want to implement at some point; more in general, what s390x is doing
> with respect to CPU models is a good blueprint, according to the
> libvirt developer who's the most involved with that specific area of
> the project.

Agreed.  Even if not necessary right now, query-cpu-model-* will
probably be needed eventually.

-- 
Eduardo

