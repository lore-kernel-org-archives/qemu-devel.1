Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CE1C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 15:16:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EECD026B79
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 15:16:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EECD026B79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45116 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWjGp-0004H8-7k
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 11:16:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hWjFV-0003V3-4C
	for qemu-devel@nongnu.org; Fri, 31 May 2019 11:15:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hWjFU-0002X7-1F
	for qemu-devel@nongnu.org; Fri, 31 May 2019 11:15:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:18631)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hWjFT-0002WN-SM
	for qemu-devel@nongnu.org; Fri, 31 May 2019 11:15:15 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 33EDF30C1B9C;
	Fri, 31 May 2019 15:15:15 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 11FB55DE86;
	Fri, 31 May 2019 15:15:11 +0000 (UTC)
Date: Fri, 31 May 2019 17:15:07 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190531171507.7666961e@redhat.com>
In-Reply-To: <6e7ec64f-43e2-fb66-3e47-ea7ff0f86eb4@linaro.org>
References: <20190531134315.4109-1-richard.henderson@linaro.org>
	<20190531134315.4109-14-richard.henderson@linaro.org>
	<20190531162341.3743eb45@redhat.com>
	<6e7ec64f-43e2-fb66-3e47-ea7ff0f86eb4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Fri, 31 May 2019 15:15:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v16 13/23] target/rx: Fix cpu types and
 names
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
Cc: philmd@redhat.com, qemu-devel@nongnu.org, ysato@users.sourceforge.jp
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 31 May 2019 09:59:14 -0500
Richard Henderson <richard.henderson@linaro.org> wrote:

> On 5/31/19 9:23 AM, Igor Mammedov wrote:
> > On Fri, 31 May 2019 08:43:05 -0500
> > Richard Henderson <richard.henderson@linaro.org> wrote:
> >   
> >> There was confusion here about abstract classes and naming cpus.
> >> We had registered a concrete class named "-rxcpu".  This was put
> >> into the default cpu fields, and matched, so basic tests worked.
> >> However, no value for -cpu could ever match in rx_cpu_class_by_name.
> >>
> >> Rename the base class to "rx-cpu" and make it abstract.  This
> >> matches what we do for most other targets.  Create a new concrete
> >> cpu with the name "rx62n-rx-cpu".  
> > 
> > since it hasn't been merged yet, it would be better to squash this
> > fixup into 3/23  
> 
> Except that it's not just 3/23 but also 8/23.  Which is why it was so much
> easier to leave it separate for review.
> 
> I suppose this could be split and squashed, it you insist.  I don't see any
> particular value in that though.

well,
one has to wonder why previous patches looked strange before they stumble
on this one. So it's awkward fro reviewer and I'd guess for whomever would
dig through the history later.

> 
> >> -    typename = g_strdup_printf(RX_CPU_TYPE_NAME(""));
> >> +    typename = g_strdup_printf(RX_CPU_TYPE_NAME("%s"), cpu_model);
> >>      oc = object_class_by_name(typename);  
> > 
> > in case of new cpu, I'd allow only typename as cpu_model
> > 
> > s/typename/cpu_model/
> >   
> > which is compatible with '-device' naming and QMP/monitor interfaces
> > that we support.
> > 
> > and I would not add other naming schemes /like adding suffix to cpu_model or .../
> > that  are existing in QEMU for legacy reasons.  
> 
> I don't understand what you're looking for.
> 
> Do you want a type called "rx62n" for the concrete cpu instance?
> That seems to be contrary to every other device in our system.
> 
> I hope you're not suggesting that the command-line be "-cpu rx62n-rx-cpu".
> That seems pointlessly verbose.
the other interfaces (qmp/monitor/-device) are using verbose form only,
so it would be better to just be consistent with them.

> 
> If we're going to change the way we do things, we should do that everywhere,
> and not make things different for only one target.
We can't do the same for already existing cpus since it might break existing
configurations out-there. But at least the new code won't get in the way
when we get to deprecating multiple ways one could name cpu with -cpu.

> 
> 
> r~


