Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EA6C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 16:10:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 931282173B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 16:10:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 931282173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57332 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOlcS-0006j0-S3
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 12:10:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hOlbZ-0006Jx-Sj
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:09:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hOlbX-0002hf-Vp
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:09:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33326)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hOlbS-0002VM-VO
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:09:05 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1D45E33025F;
	Thu,  9 May 2019 16:08:29 +0000 (UTC)
Received: from localhost (ovpn-116-61.gru2.redhat.com [10.97.116.61])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9C0A61001E65;
	Thu,  9 May 2019 16:08:28 +0000 (UTC)
Date: Thu, 9 May 2019 13:08:25 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Jiri Denemark <jdenemar@redhat.com>
Message-ID: <20190509160825.GL4189@habkost.net>
References: <20190422234742.15780-1-ehabkost@redhat.com>
	<20190509133537.GK7181@orkuz.int.mamuti.net>
	<20190509135617.GH4189@habkost.net>
	<20190509152616.GL7181@orkuz.int.mamuti.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509152616.GL7181@orkuz.int.mamuti.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Thu, 09 May 2019 16:08:29 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/2] i386: "unavailable-features" QOM
 property
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
	qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 09, 2019 at 05:26:16PM +0200, Jiri Denemark wrote:
> On Thu, May 09, 2019 at 10:56:17 -0300, Eduardo Habkost wrote:
> > On Thu, May 09, 2019 at 03:35:37PM +0200, Jiri Denemark wrote:
> > > Would this unavailable-features property contain only canonical names of
> > > the features or all possible aliases of all features? For example,
> > > "tsc-adjust" can also be spelled as "tsc_adjust". When calling
> > > query-cpu-model-expansion, we have a way to request all variants by
> > > running full expansion on the result of a previous static expansion. Can
> > > we get something like this for unavailable-features too?
> > 
> > I'd like to avoid that, and refer only to the canonical names.
> > 
> > Could you explain the use case you have in mind, so we can look
> > for alternatives?
> 
> Libvirt only knows about a single spelling for each CPU feature and
> quite often it is not the canonical variant. Thus libvirt would only
> recognize features for which the name known by libvirt is the canonical
> name.
> 
> We could theoretically make the translation in libvirt, but it's not
> going to be future proof. If a new spelling is introduced, it's because
> the old one is not considered correct and the new one becomes the
> canonical version. When libvirt doesn't have the translation (libvirt is
> older or just didn't catch up yet) we have a big problem.
> 
> I guess a good alternative would be some way of querying all CPU feature
> names and their aliases. If I'm not mistaken, we can either get a list
> of canonical names or all names, but without any clue which names
> actually refer to a single feature.

Right.  But (as described below) if you want to know the status a
specific feature you already know about (even if you are using
the old spelling), qom-get should work for you.

The goal of filtered-features and unavailable-features is to
catch all the rest: features you might not know about, but that
should prevent a CPU model from running.

> 
> > > As you mentioned, there are two interesting QOM properties:
> > > filtered-features and feature-words and both are used by libvirt. We use
> > > feature-words to get CPU features which were enabled in the guest CPU on
> > > top of what we expected. This is the case of, e.g., a feature added to a
> > > given CPU model for new machine types. I guess we could switch to
> > > checking QOM properties for individual features as a replacement for
> > > feature-words which covers both CPUID and MSR features.
> > 
> > I guess it depends on your goal:
> > 
> > If your just want to know if one specific feature is missing for
> > some reason, you can check the QOM properties directly.  That's
> > OK, and it's even better than checking the `feature-words`
> > property.
> > 
> > If you want to be 100% sure no property was missing when starting
> > the VM (e.g. emulate the behavior of the "enforce" option), I
> > suggest you check if `unavailable-features` is empty.
> 
> That's what filtered-features is used for.

Right.  My goal here is to replace filtered-features, not
feature-words.

> 
> As I tried to explain (and apparently failed :-)) we use feature-words
> for a different thing. I guess it will be more clear using a specific
> example. For example, when arat CPU feature was introduced, it was added
> into several existing CPU models and thus libvirt's version of the CPU
> model differs from the one in QEMU. (This is actually safer and better
> then changing the libvirt's CPU model too since migration relies on both
> hosts having the same definition of the CPU model used by a domain.) So,
> for example, when a domain with Broadwell CPU model is started, libvirt
> checks feature-words to see whether some CPU features not defined in
> libvirt's definition of Broadwell CPU model were enabled. And it will
> see arat. As a result the live domain definition will actually be
> changed to Broadwell+arat to make sure arat is not lost after migration.
> 
> Is the usage clear now?
> 
> Anyway, I think we can just check all features we know about via CPU
> properties to get the same result. It's not going to be as nice as using
> feature-words, but it's doable.

For the use case you describe here, qom-get sounds better than
using feature-words, yes.

-- 
Eduardo

