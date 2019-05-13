Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9165CC04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 19:33:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AF8320850
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 19:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AF8320850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34025 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQGhG-0007Ae-KC
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 15:33:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1hQGeQ-000552-Fj
	for qemu-devel@nongnu.org; Mon, 13 May 2019 15:30:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1hQGRk-0004Te-Ty
	for qemu-devel@nongnu.org; Mon, 13 May 2019 15:17:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>)
	id 1hQGRh-0004Rq-D0; Mon, 13 May 2019 15:17:10 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A8E0D3082E66;
	Mon, 13 May 2019 19:17:05 +0000 (UTC)
Received: from kamzik.brq.redhat.com (ovpn-116-151.ams2.redhat.com
	[10.36.116.151])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9DB3C60856;
	Mon, 13 May 2019 19:17:02 +0000 (UTC)
Date: Mon, 13 May 2019 21:16:59 +0200
From: Andrew Jones <drjones@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190513191659.2vmrw3act5qkudou@kamzik.brq.redhat.com>
References: <20190512083624.8916-1-drjones@redhat.com>
	<fa220ee2-b4bc-cdfa-ddde-90206e417cf3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa220ee2-b4bc-cdfa-ddde-90206e417cf3@linaro.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Mon, 13 May 2019 19:17:05 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 00/13] target/arm/kvm: enable SVE in guests
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, armbru@redhat.com,
	qemu-arm@nongnu.org, abologna@redhat.com, alex.bennee@linaro.org,
	Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 13, 2019 at 11:46:29AM -0700, Richard Henderson wrote:
> On 5/12/19 1:36 AM, Andrew Jones wrote:
> >    CPU type | accel | sve-max-vq | sve-vls-map
> >    -------------------------------------------
> >  1)     max | tcg   |  $MAX_VQ   |  $VLS_MAP
> >  2)     max | kvm   |  $MAX_VQ   |  $VLS_MAP
> >  3)    host | kvm   |  N/A       |  $VLS_MAP
> 
> This doesn't seem right.  Why is -cpu host not whatever the host supports?  It
> certainly has been so far. 

-cpu host can support whatever the host (hardware + KVM ) supports, but if
a user doesn't want to expose all of it to the guest, then the user doesn't
have to. For example, the host cpu may have a PMU, but the guest doesn't
necessarily get one (-cpu host,pmu=off).

> I really don't see how -cpu max makes any sense for
> kvm.
>

It's already supported for kvm. This series just extends that support
to match tcg's sve support. The reason it's supported is that you can
then use '-cpu max' along with '-machine accel=kvm:tcg' in a command
line and it'll just work.
 
> 
> > The QMP query returns a list of valid vq lists. For example, if
> > a guest can use vqs 1, 2, 3, and 4, then the following list will
> > be returned
> > 
> >  [ [ 1 ], [ 1, 2 ], [ 1, 2, 3 ], [ 1, 2, 3, 4 ] ]
> > 
> > Another example might be 1, 2, 4, as the architecture states 3
> > is optional. In that case the list would be
> > 
> >  [ [ 1 ], [ 1, 2 ], [ 1, 2, 4 ] ]
> > 
> > This may look redundant, but it's necessary to provide a future-
> > proof query, because while KVM currently requires vector sets to
> > be strict truncations of the full valid vector set, that may change
> > at some point.
> 
> How and why would that make sense?
> 
> Real hardware is going to support one set of vector lengths.

The guest's view of the hardware will be a single set. That set can be
different for different guests though, within the constraints of the
architecture and KVM or TCG implementations.

> Whether VQ=3 is
> valid or not is not going to depend on the maximum VQ, surely.

Exactly. That's why we need a way to explicitly state what is supported.
We can't assume anything from the max VQ alone. Additionally, while
strict truncation is required now for KVM, things may be more flexible
later. TCG is already more flexible. For TCG, all sets that at least
include all the power-of-2 lengths up to the maximum VQ are valid, as
the architecture states. Plus, all the sets that can be derived by adding
one ore more optional lengths to those sets are also valid. Listing each
of them allows management software to know what's going to work and what's
not without having to know all the rules itself.

> 
> I'll also note that if we want to support the theoretical
> beyond-current-architecture maximum VQ=512, such that migration works
> seemlessly with current hardware, then we're going to have to change the
> migration format.
> 
> So far I'm supporting only the current architecture maximum VQ=16.  Which
> seemed plenty, given that the first round of hardware only supports VQ=4.
> 

I agree. The changes won't be small to QEMU, but hopefully we can design
a QMP query that won't need to change, saving libvirt some pain.

Thanks,
drew

