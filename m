Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE8EC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 16:40:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11CF421744
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 16:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XywNkfIu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11CF421744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1Y4p-0007G8-BZ
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 12:40:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k1Y4F-0006l0-2V
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 12:39:35 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42429
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k1Y4C-0001cc-RJ
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 12:39:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596213571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pVaVJKF3nKWNFjeBSa9CUBALm5sxqAi8xm8yQOOmn/U=;
 b=XywNkfIuv1WT60WvhHEXtSgb2iEiLjevOTM4NwbFqw2dWlYc6RKK0Qq6IiOx/exkxL6B88
 ybn9LrZdA2dUmh0moOO6UzRII28TPXMCVOWno+umQIej13vIqc0/IWP1cWtP4SJeaB0pyS
 RHqpxmP8hU8RBIKmAvlHs93bcZjm2p4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-bRw6HxT0Pvq3pAO2K2JQJw-1; Fri, 31 Jul 2020 12:39:28 -0400
X-MC-Unique: bRw6HxT0Pvq3pAO2K2JQJw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CC7C18839D5;
 Fri, 31 Jul 2020 16:39:27 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-24.ams2.redhat.com [10.36.113.24])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A30C227CB8;
 Fri, 31 Jul 2020 16:39:15 +0000 (UTC)
Date: Fri, 31 Jul 2020 18:39:14 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH] schemas: Add vim modeline
Message-ID: <20200731163914.GF4707@linux.fritz.box>
References: <20200729185024.121766-1-abologna@redhat.com>
 <87ime52wxd.fsf@dusky.pond.sub.org>
 <20200730093732.GB3477223@redhat.com>
 <87k0ylz0ep.fsf@dusky.pond.sub.org>
 <20200730132446.GL3477223@redhat.com>
 <875za33ku1.fsf@dusky.pond.sub.org>
 <20200731150738.GB3660103@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200731150738.GB3660103@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 12:28:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Andrea Bolognani <abologna@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 31.07.2020 um 17:07 hat Daniel P. Berrangé geschrieben:
> On Fri, Jul 31, 2020 at 02:55:34PM +0200, Markus Armbruster wrote:
> > Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > >> Some of the criticism there doesn't matter for our use case.
> > >
> > > Yeah, what matters is whether it can do the job we need in a way that is
> > > better than what we have today, and whether there are any further options
> > > to consider that might be viable alternatives.
> > 
> > Would it improve things enough to be worth the switching pain?
> 
> The short answer is that I don't think that question matters. We should
> do the conversion regardless, as our JSON-but-not file format has no
> compelling reason to exist as a thing when there's a variety of standard
> file formats that could do the job.

I think the question does matter. Reusing existing code is not an end in
itself, but it has to actually improve something. Usually this would be
simplifying the code because a lot of the work is done by something
external now.

"The job" is defining APIs in a way that we they describe JSON messages
and we can generate C boilerplate code and documentation from the
description.

If we look for a standard format, then we should start with this rather
than keeping the non-standard thing that we have, but wrapping a new
syntax around it.

> I'd explicitly ignore the sunk costs and minor amount of work to
> convert to a new format.

I'm not worried about the work to convert the QAPI generator.
QAPISchemaParser is 264 lines of code, presumably not a lot of work to
rewrite. This is also the upper limit of code that could be improved.

Given the discussion so far, I wouldn't even be sure that the diffstat
after pulling in an external dependeny would be at least minimally
favourable.

More time will be spent with dealing with the results of the actual
conversion of the schema file because people will get lots of merge
conflicts.

Sometimes this is worth it, but then the benefit has to be a little more
than just that we could say we've reused an external library.

> The long answer is that as a general philosophy I'm in favour of agressively
> eliminating anything that is custom to a project and isn't offering an
> compelling benefit over a functionally equivalent, commonly used / standard
> solution.

The differences between JSON and the QAPI schema lower layer language is
structured documentation comments (I don't think any of the proposed
alternatives have this - might be a compelling benefit) and having
multiple objects in a single file (I would rather put brackets around
the whole file and commas between each definition and live with that
ugliness than taking the pain of a merge conflicts).

> Any time a project re-invents the wheel, that is one more piece of custom
> knowledge a contributor has to learn. Each one may seem insignificant on
> its own, but cummulatively they result in death by a 1000 cuts. This makes
> a project increasingly less attractive to contribute to over the long term.

I doubt documentation comments and having multiple objects in a single
file makes QEMU less attractice to contribute to.

> Measuring the long term benefit of the change is generally quite difficult,
> because while you can see what impact a change will have today on current
> code, it is hard to usefully evaluate future benefits as you're trying to
> imagine the impact on things that don't even exist.
> 
> Overall my POV is not to think too hard about measuring improvements, and
> discard any concern about sunk costs. Instead have a general presumption
> in favour of eliminating any examples of wheel re-invention in a project.
> Even if regular contributors don't want to spend time on such work, this
> kind of thing is pretty amenable to new contributors looking for tasks to
> start their involvement.
> 
> The QAPI JSON-but-not file format is a case where I think we should just
> adopt a standard file format no matter what. A conversion will have some
> short term work, but this is really simple data to deal with and the code
> involved is nicely self contained.

Almost every subsystem has some QAPI parts that would be affected.

> Again I'm not saying QAPI maintainers must do it, just put the idea
> out there as a piece of work that would be welcomed if someone is
> interested in working ont.
> 
> Another example would be elimination of anything in QEMU code that is
> duplicating functionality in GLib, even if there zero functional
> difference between the two impls.

If it's an actual duplicate and exact match, sure. But if using the GLib
functions results in double the code size that implementing the
functionality from scratch was, it becomes questionable in my opinion.

Kevin


