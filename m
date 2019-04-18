Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_HK_NAME_DR,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E07C10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 15:00:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74CC1206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 15:00:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74CC1206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42540 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hH8WD-0003XL-Ls
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 11:00:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hH8US-0002P9-JZ
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 10:58:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hH8Td-0003gA-1J
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 10:57:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hH8Tc-0003g0-P2
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 10:57:24 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0865DDBD73;
	Thu, 18 Apr 2019 14:57:24 +0000 (UTC)
Received: from work-vm (ovpn-117-54.ams2.redhat.com [10.36.117.54])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3065A60BEC;
	Thu, 18 Apr 2019 14:57:19 +0000 (UTC)
Date: Thu, 18 Apr 2019 15:57:16 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Andrew Jones <drjones@redhat.com>
Message-ID: <20190418145716.GH2984@work-vm>
References: <20190418092841.fzrcegkbal7dpfcy@kamzik.brq.redhat.com>
	<20190418094634.sr4s4qkzceqftque@kamzik.brq.redhat.com>
	<20190418105204.GF3567@e103592.cambridge.arm.com>
	<20190418112847.4hnafafcxlp4vuou@kamzik.brq.redhat.com>
	<20190418140302.GI3567@e103592.cambridge.arm.com>
	<20190418144306.5sxrbcjbkw2tzslj@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190418144306.5sxrbcjbkw2tzslj@kamzik.brq.redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Thu, 18 Apr 2019 14:57:24 +0000 (UTC)
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"peter.maydell@linaro.org" <peter.maydell@linaro.org>,
	"imammedo@redhat.com" <imammedo@redhat.com>,
	Dave Martin <Dave.Martin@arm.com>, "armbru@redhat.com" <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418145716.0lpILXdDdslObiwzxXRkosHCrwy-W1Sj3MLyu-38EME@z>

* Andrew Jones (drjones@redhat.com) wrote:
> On Thu, Apr 18, 2019 at 03:03:02PM +0100, Dave Martin wrote:
> > On Thu, Apr 18, 2019 at 12:28:47PM +0100, Andrew Jones wrote:
> > > On Thu, Apr 18, 2019 at 11:52:04AM +0100, Dave Martin wrote:
> > > > On Thu, Apr 18, 2019 at 10:46:34AM +0100, Andrew Jones wrote:
> > > > > On Thu, Apr 18, 2019 at 11:28:41AM +0200, Andrew Jones wrote:
> > > > > > Hi all,
> > > > > > 
> > > > > > First some background:
> > > > > > 
> > > > > > For the userspace side of AArch64 guest SVE support we need to
> > > > > > expose KVM's allowed vector lengths bitmap to the user and allow
> > > > > > the user to choose a subset of that bitmap. Since bitmaps are a
> > > > > > bit awkward to work with then we'll likely want to expose it as
> > > > > > an array of vector lengths instead. Also, assuming we want to
> > > > > > expose the lengths as number-of-quadwords (quadword == 128 bits
> > > > > > for AArch64 and vector lengths must be multiples of quadwords)
> > > > > > rather than number-of-bits, then an example array (which will
> > > > > > always be a sequence) might be
> > > > > > 
> > > > > >  [ 8, 16, 32 ]
> > > > > > 
> > > > > > The user may choose a subsequence, but only through truncation,
> > > > > > i.e. [ 8, 32 ] is not valid, but [ 8, 16 ] is.
> > > > > > 
> > > > > > Furthermore, different hosts may support different sequences
> > > > > > which have the same maximum. For example, if the above sequence
> > > > > > is for Host_A, then Host_B could be
> > > > > > 
> > > > > >  [ 8, 16, 24, 32 ]
> > > > > 
> > > > > It doesn't really matter for this discussion, but I just realized
> > > > > that I picked bogus numbers for these examples. 32 would be too
> > > > > big. The largest supported is 16. I probably should have just used
> > > > > the simple [ 1, 2, 4 ] and [ 1, 2, 3, 4 ] arrays, corresponding to
> > > > > vector lengths (in bits) 128, 256, 512 and 128, 256, 384, 512.
> > > > 
> > > > I'd argue differently from the ABI perspective.
> > > > 
> > > > If the host supports vq = [ 1,2,3,4 ], then it is entirely valid to ask
> > > > for [ 1,2,4 ].  KVM will fail the KVM_REG_ARM64_SVE_VLS write with
> > > > EINVAL, but I don't distinguish between a set that is not satisfiable on
> > > > this hardware and a set that is not valid at all.  The kernel basically
> > > > doesn't check for the latter: an architecturally invalid set will always
> > > > not be satisfiable on the hardware.
> > > 
> > > I agree that 1,2,4 should be a valid set, but how do we avoid the user
> > > attempting to select it on a platform that supports 1,2,3,4 now? Until
> > > the hardware and KVM will allow it, then I don't think we should try
> > > to "support" it in any way. Maybe we should name the property such that
> > > it's clear we need to use truncation when constructing a subset now.
> > > This would allow us to add another, more generally named, property later
> > > when we can select nearly arbitrary subsets.
> > > 
> > > > 
> > > > Ideally, userspace should not preempt this decision, in case the
> > > > architecture becomes more flexible someday in what it can virtualise.
> > > > 
> > > > > > The host must support all lengths in the sequence, which means
> > > > > > that while Host_A supports 32, since it doesn't support 24 and
> > > > > > we can only truncate sequences, we must use either [ 8 ] or
> > > > > > [ 8, 16 ] for a compatible sequence if we intend to migrate
> > > > > > between the hosts.
> > > > > > 
> > > > > > Now to the $SUBJECT question:
> > > > > > 
> > > > > > My feeling is that we should require the sequence to be
> > > > > > provided on the command line as a cpu property. Something
> > > > > > like
> > > > > > 
> > > > > >   -cpu host,sve-vl-list=8:16
> > > > 
> > > > I can't decide whether it's more or less user-friendly to denote VL in
> > > > terms of bytes in this kind of context.
> > > 
> > > I'm not sure either. Switching to my second take at quadwords this should
> > > have been '1:2'. In bytes [ 1, 2 ] would be '16:32'.
> > > 
> > > > 
> > > > Usually when I say "VL" in the kernel ABI I try to mean this.
> > > > (KVM_REG_ARM64_SVE_VLS is a special case: here the lengths are fancily
> > > > encoded rather than being passed as integers, so the precise unit used
> > > > is a more abstract concept here ... or anyway, that's my excuse.
> > > > _SVE_VQS felt odd here.)
> > > 
> > > My thinking is that using the number of quadwords keeps the numbers
> > > smaller. But, if people are mostly going to want to think about vector
> > > lengths in terms of bits, like the specification does, then maybe we
> > > should just let the numbers be bigger: [ 128, 256, 512 ]
> > > 
> > > > 
> > > > For kvmtool I went with quadwords on the command line, but only as a
> > > > quick hack to simplify the parser slightly.
> > > > 
> > > > OTOH, specifying 1,2,4 on the command line is clearly less annoying and
> > > > error-prone than 16,32,64.
> > > > 
> > > > Naming the option with "vq" instead of "vl" is another option, though
> > > > "vq" is Linux terminology not endorsed by the architecture.
> > > 
> > > I think VL is OK as long we document the unit.
> > 
> > As you wish (and that's basically where I ended up for now with kvmtool).
> > 
> > > > 
> > > > For kvmtool I've considered a range / filtering syntax, but I didn't
> > > > implement it yet.
> > > 
> > > I think we want each VL to be explicitly listed on the command line
> > > for the compatibility issue described above. On one host the range
> > > [1,4] can be different than the range [1,4] on anther host, depending
> > > on whether '3' is in there. And syntax like 1-4:-3 would be overly
> > > complicated, IMO. So I'm inclined to just require all of them to be
> > > listed, but of course order wouldn't matter.
> > 
> > Probably reasonable.  For now (and quite likely forever) the length of
> > the list is at most 16 elements.  To avoid overengineering I stuck with
> > a flat comma-separated list for now.
> > 
> > 
> > It's worth nothing that there are two problems to be solved here: one is
> > to specify an exact set unambiguously, which is important for migration
> > scenarios.
> > 
> > The other is to be able to clamp the vector length for user convenience,
> > but without particularly considering migration.  There's no direct way
> > for the user to know the set of vector lengths supported by KVM today,
> > so cooking up the right magic to go on the command line is non-trivial:
> > you have to create a dummy vcpu and read KVM_REG_ARM64_SVE_VLS to find
> > the host's supported set.  Or you just have to know.
> 
> Right, we'll have to query first to know what's available. libvirt will
> do that and tools built on libvirt should help provide the user with
> sane defaults or a relatively painless selection process. The QEMU command
> line is primarily for developers, so they'll likely just know what they
> want.
> 
> > 
> > A separate max-vl option (or whatever) might be a useful alternative.
> 
> Yeah, we could offer this to be nicer to QEMU command line users that
> don't intend to migrate, or don't care if a migration can fail. This
> would be analogous to '-cpu max' which enables all available cpu
> features. Bad for migration, but a nice shorthand if you want your
> guest to have everything.

One that printed out what was available on that host might be nice
(and/or via a qmp query- command) for when you're trying to figure out
what's going.

Dave

> Thanks,
> drew
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

