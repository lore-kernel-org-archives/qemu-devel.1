Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B763C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 08:23:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D690D206B5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 08:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MMWcE3E7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D690D206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3xeb-0008Cd-4n
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 04:23:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k3xds-0007J5-7v
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 04:22:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37844
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k3xdq-0002zO-41
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 04:22:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596788537;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=efaZ0sxWKLA3pqfLSpgsXanWrcIRUb+hFY2pqz84oJs=;
 b=MMWcE3E7PBXL39xqovubmwE0unLQzV+X+8G6IXu06y4YOa2tnfqxQhxvtH3zwZMwurkzBb
 pQkLFzv7uYxJkHIH+1OLpl9hlXNXrQwfIl9zZANwv/IjOARCSyk1ZP3Pjikoasi0ZgJuMF
 URseezdHehP7aW6bLXNUv10EO45BQeU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-Ug5EUo53MdCzNMA6ZBBvbA-1; Fri, 07 Aug 2020 04:22:15 -0400
X-MC-Unique: Ug5EUo53MdCzNMA6ZBBvbA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45F54800688;
 Fri,  7 Aug 2020 08:22:14 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A90987A6D;
 Fri,  7 Aug 2020 08:22:08 +0000 (UTC)
Date: Fri, 7 Aug 2020 09:22:06 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [DRAFT PATCH 000/143] Meson integration for 5.2
Message-ID: <20200807082206.GC120942@redhat.com>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <87364y28jp.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87364y28jp.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 02:21:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: peter.maydell@linaro.org, jsnow@redhat.com, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, stefanha@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 07, 2020 at 09:56:42AM +0200, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
> > This the more or less final version of the Meson conversion.  Due to
> > the sheer size of the series you have been CCed only on the cover
> > letter.
> 
> Perfect timing: right before I drop off for two weeks of vacation.  I'm
> excused!  *Maniacal laughter*
> 
> > The series reaches the point where Makefile.target and unnest-vars
> > can be removed, and all builds become non-recursive.  I have also
> > converted parts of the testsuite, notably qtest since it is needed
> > for fuzzing.  What's left for _after_ the merge is: 1) unit tests;
> > 2) moving the rest of installation to meson (for which I have patches);
> > 3) moving feature detection from configure to meson.
> >
> > Things I still haven't tested:
> > - fuzzing
> > - non-x86/Linux builds
> > - static builds
> > - Docker and VM builds
> >
> > Things I have checked:
> > - x86 builds
> > - modules
> > - "make install"
> > - internal slirp/dtc/capstone.
> 
> Have you run it through our CI?
> 
> > It should be more or less bisectable.  I have not tried building
> > _all_ steps, but I have tried both before and after each major one.
> >
> > Build system rebuild rules seem to work reliably.
> 
> Is it faster in common build scenarios?
> 
> > After a week or quite intense rebasing, my impression is more or less
> > the same as last December: Meson looks more daunting, but it is actually
> > much nicer to work with.
> 
> Not a particularly high bar to cross: our Makefiles are full of the kind
> of black magic that keeps simple things simple (which is quite an
> achievement; kudos!), and makes not-so-simple things really hard.
> 
> I think it's now time to plan the end game, preferably without even more
> weeks of intense rebasing.
> 
> Do we have consensus to move forward with Meson?  If yes, I'd like to
> propose to aim for merging as early as practical in the 5.2 cycle.
> Rationale: rebasing build system changes on top of the Meson work is
> probably easier than rebasing the Meson work, and avoids turning Paolo
> into an overworked bottleneck.
> 
> In more detail:
> 
> 1. Pick a tentative deadline.

I'd suggest we need a bare minimum of half a development cycle to.
So if we want it tin 5.2, we need to make a strong push now and over
next month to review it and iron out any obvious blocking testing
problems.

> 2. Cover the testing gaps and get as much review as we can until then.
>    Fix defects as we go.

In terms of testing I'd suggest the minimium bar is likely the GitLab CI
and Peter's merge scripts.

Anything beyond that is just nice to have.

> 3. If the known defects are expected to disrupt others too much, goto 1.
>    Do not worry about unknown defects at this point.
> 
> 4. Merge.
> 
> 5. Deal with the fallout.

Yep, there's no substitute for getting it used for real by a wide
range of people, which is why we we need leave ourselves at min
1/2 a dev cycle for this.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


