Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C5AC04E84
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 11:43:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09211206BF
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 11:43:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09211206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35588 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQsK6-0001Fq-C6
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 07:43:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1hQsJH-0000ym-V3
	for qemu-devel@nongnu.org; Wed, 15 May 2019 07:43:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1hQsJG-0007Qr-TF
	for qemu-devel@nongnu.org; Wed, 15 May 2019 07:42:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56004)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1hQsJG-0007Q0-Lh
	for qemu-devel@nongnu.org; Wed, 15 May 2019 07:42:58 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 42416307D84F;
	Wed, 15 May 2019 11:42:57 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E4945C297;
	Wed, 15 May 2019 11:42:46 +0000 (UTC)
Date: Wed, 15 May 2019 13:42:44 +0200
From: Andrew Jones <drjones@redhat.com>
To: Dave Martin <Dave.Martin@arm.com>
Message-ID: <20190515114244.b7acsng542x6tflj@kamzik.brq.redhat.com>
References: <20190418092841.fzrcegkbal7dpfcy@kamzik.brq.redhat.com>
	<20190418112610.GO13773@redhat.com>
	<877ebrmch2.fsf@dusky.pond.sub.org>
	<20190513184237.i2ha3ixvhjqzkn5q@kamzik.brq.redhat.com>
	<87bm05ab6c.fsf@dusky.pond.sub.org>
	<20190514090225.vel4xm4x743o4rge@kamzik.brq.redhat.com>
	<20190514164838.48fc7603@Igors-MacBook-Pro>
	<20190515081854.kcpjm4zd2bzc7f6o@kamzik.brq.redhat.com>
	<20190515110045.GQ28398@e103592.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515110045.GQ28398@e103592.cambridge.arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Wed, 15 May 2019 11:42:57 +0000 (UTC)
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
	Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	"dgilbert@redhat.com" <dgilbert@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 15, 2019 at 12:00:45PM +0100, Dave Martin wrote:
> On Wed, May 15, 2019 at 09:18:54AM +0100, Andrew Jones wrote:
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
> 
> Note, there is nothing SVE-specific about this.

In the above example there is some specific SVE stuff there. If the
command line has sve4=on, then it must also have sve1=on and sve2=on,
per the architecture requiring all smaller power-of-2 vector lengths.
Only sve3 is optional, but because it's optional we have to explicitly
state when it's on or off in order to ensure we can cleanly fail a
migration to a host that doesn't support that option.

> 
> Either enabling features on a per-vcpu basis is justified, or it isn't:
> if it's justified, then it would be better to have a general way of
> specifying per-vcpu properties, rather than it being reinvented per
> feature.
> 
> Creating mismatched configurations is allowed by the architecture and so
> it's useful for testing the kernel, but probably less useful for real-
> world use cases today.
> 
> So it may be a good idea to get the symmetric support sorted out first
> before thinking about whether and how to specify asymmetric
> configurations.

These properties are per-vcpu for KVM only. QEMU doesn't have a way
to allow per-vcpu features to be described on the command line yet.
With '-cpu host,...' The '...' applies to all vcpus. So we are "just"
working on the symmetric support now.

Thanks,
drew

