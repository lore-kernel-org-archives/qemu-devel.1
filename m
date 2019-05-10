Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29BBC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 11:34:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 775D020850
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 11:34:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 775D020850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41553 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP3nY-0005L2-KP
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 07:34:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jdenemar@redhat.com>) id 1hP3m0-0004hm-Hl
	for qemu-devel@nongnu.org; Fri, 10 May 2019 07:33:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jdenemar@redhat.com>) id 1hP3lz-00030r-I1
	for qemu-devel@nongnu.org; Fri, 10 May 2019 07:33:08 -0400
Received: from smtp.vivo.cz ([185.219.166.8]:36332)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jdenemar@redhat.com>) id 1hP3lz-00030P-7W
	for qemu-devel@nongnu.org; Fri, 10 May 2019 07:33:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by smtp.vivo.cz (Postfix) with ESMTP id 14E1317CD137;
	Fri, 10 May 2019 13:33:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at vivo.cz
Received: from smtp.vivo.cz ([127.0.0.1])
	by localhost (smtp.vivo.cz [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id m2LRnuv6t5oS; Fri, 10 May 2019 13:33:04 +0200 (CEST)
Received: from orkuz.int.mamuti.net (185-219-164-37-static.vivo.cz
	[185.219.164.37])
	by smtp.vivo.cz (Postfix) with ESMTPS id 02FC917CD121;
	Fri, 10 May 2019 13:33:04 +0200 (CEST)
Received: by orkuz.int.mamuti.net (Postfix, from userid 500)
	id B1FD82A531A; Fri, 10 May 2019 13:33:03 +0200 (CEST)
Date: Fri, 10 May 2019 13:33:03 +0200
From: Jiri Denemark <jdenemar@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190510113303.GQ7181@orkuz.int.mamuti.net>
References: <20190422234742.15780-1-ehabkost@redhat.com>
	<20190509133537.GK7181@orkuz.int.mamuti.net>
	<20190509135617.GH4189@habkost.net>
	<20190509152616.GL7181@orkuz.int.mamuti.net>
	<20190509160825.GL4189@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509160825.GL4189@habkost.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 185.219.166.8
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

On Thu, May 09, 2019 at 13:08:25 -0300, Eduardo Habkost wrote:
> On Thu, May 09, 2019 at 05:26:16PM +0200, Jiri Denemark wrote:
> > On Thu, May 09, 2019 at 10:56:17 -0300, Eduardo Habkost wrote:
> > > On Thu, May 09, 2019 at 03:35:37PM +0200, Jiri Denemark wrote:
> > > > Would this unavailable-features property contain only canonical names of
> > > > the features or all possible aliases of all features? For example,
> > > > "tsc-adjust" can also be spelled as "tsc_adjust". When calling
> > > > query-cpu-model-expansion, we have a way to request all variants by
> > > > running full expansion on the result of a previous static expansion. Can
> > > > we get something like this for unavailable-features too?
> > > 
> > > I'd like to avoid that, and refer only to the canonical names.
> > > 
> > > Could you explain the use case you have in mind, so we can look
> > > for alternatives?
> > 
> > Libvirt only knows about a single spelling for each CPU feature and
> > quite often it is not the canonical variant. Thus libvirt would only
> > recognize features for which the name known by libvirt is the canonical
> > name.
> > 
> > We could theoretically make the translation in libvirt, but it's not
> > going to be future proof. If a new spelling is introduced, it's because
> > the old one is not considered correct and the new one becomes the
> > canonical version. When libvirt doesn't have the translation (libvirt is
> > older or just didn't catch up yet) we have a big problem.
> > 
> > I guess a good alternative would be some way of querying all CPU feature
> > names and their aliases. If I'm not mistaken, we can either get a list
> > of canonical names or all names, but without any clue which names
> > actually refer to a single feature.
> 
> Right.  But (as described below) if you want to know the status a
> specific feature you already know about (even if you are using
> the old spelling), qom-get should work for you.

Yeah, since we'll be checking all features anyway, we can detect enabled
and disabled features at the same time. However, we don't know whether a
specific feature was disabled because we did not ask for it to be
enabled (remember, CPU model definition may differ between libvirt and
QEMU) or because it was filtered out.

Depending on the domain XML used to start a domain, libvirt may not (and
usually will not) refuse to start a domain for which QEMU filtered out
some CPU features. Of course, once the domain is running, the checking
becomes very strict and libvirt would refuse to start the domain on
another host during migration if any feature is filtered out.

Thus libvirt stores all features QEMU filtered out when a domain was
started in the non-strict way. So we need to match the features in the
unavailable-features list with our features. Just checking for the list
being empty is not sufficient.

Jirka

