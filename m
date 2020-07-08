Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3323C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:06:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C53B206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AG8nYniq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C53B206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtICi-0002Zv-Px
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jtHiq-0001Vd-23
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:35:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58879
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jtHin-0002zP-W7
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:35:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594244117;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/WEKFxFgj0Nwmzz1j6UoPBrK5zjGJSNbUprMWnWuBUE=;
 b=AG8nYniq5PFUQq6CX4IYVFf5embwp9HU0g+QFvzX+rItxWTWAtR8IP81sTIeFKoNtp1azS
 PWZbC6GrlMV2eBYu9sl72/hCFil6szTro9t2cd97mqEicV4rJeJ7w0UZ+eaoApYuJnfqk2
 C5rRfxvZZBFnlvUTfHzcmnAiiyWqH0w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-MVozCTG5MIufNPg67fuCqA-1; Wed, 08 Jul 2020 07:31:48 -0400
X-MC-Unique: MVozCTG5MIufNPg67fuCqA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15637800C64;
 Wed,  8 Jul 2020 11:31:47 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.36])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F0E711E7C4;
 Wed,  8 Jul 2020 11:31:40 +0000 (UTC)
Date: Wed, 8 Jul 2020 12:31:37 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Migrating custom qemu.org infrastructure to GitLab
Message-ID: <20200708113137.GF3229307@redhat.com>
References: <CAJSP0QV3uB4QY6mzw2JFDedr0PJhGkU5FdmLF5PbjMPyxiYSuw@mail.gmail.com>
 <20200708105353.GE3229307@redhat.com>
 <92e71916-0cf2-2833-6852-de76749c101d@redhat.com>
MIME-Version: 1.0
In-Reply-To: <92e71916-0cf2-2833-6852-de76749c101d@redhat.com>
User-Agent: Mutt/1.14.3 (2020-06-14)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <cleber@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 08, 2020 at 01:17:11PM +0200, Paolo Bonzini wrote:
> On 08/07/20 12:53, Daniel P. Berrangé wrote:
> > Consider if qemu-web.git is hosted on gitlab, using GitLab CI to
> > generate the static site content, and GitLab pages to host the
> > website. If a user wants to contribute to qemu-web, they can fork
> > the repo and be confident that the CI jobs in their fork are going
> > to work in the exact same way as in the master repo. They can use
> > GitLab Pages to browse the generated content for their fork to
> > see exactly how it will look.
> > 
> > This eliminates the big pain point in qemu-web contribution. Many
> > times I was tripped up with the problem of qemu-web.git requiring
> > a version of Jekyll that is incompatible with the version that
> > ships on my distro.
> 
> I would have no issue with using a pull request workflow for qemu-web.
> The lack of "git range-diff" functionality for gitlab is an absolute
> showstopper for using it in QEMU, though.

FWIW, I tried to avoid mentioning merge requests, as I didn't want
to derail the discussion & believe use of gitlab for infrastructure
is worthwhile even if you never use merge requests.  I do tend to
think that merge requests would be a reasonable thing to use for
qemu-web in particular.

> >> GitLab's Continuous Integration (CI) system provides a powerful way to
> >> perform actions defined in yaml files in qemu.git. This includes
> >> running scripts, builds, publishing build artifacts, etc. We have
> >> already begun using it for automated builds and tests:
> >> https://gitlab.com/qemu-project/qemu/-/blob/master/.gitlab-ci.yml
> > 
> > The CI integration has probably been the single best thing about
> > libvirt's switch to GitLab.
> 
> How do you handle non-x86 platforms?  Has there been any progress in
> gitlab runner support for s390 and PPC?

We don't do any native non-x86 stuff right now.  We do all non-x86
builds using cross-compilers. Obviously that means we don't get any
testing coverage, only build coverage.

We did update our lcitool to be able to build VMs to serve as gitlab
runners, principally to provide us FreeBSD runners. After doing all
the work though, we discovered a way to integrate Cirrus CI into
GitLab CI, using a shim called "cirrus-run".  So now we have macOS
and FreeBSD jobs in GitLab CI, that use a shim to call out to Cirrus
CI todo the actual work:

From this pipeline:

  https://gitlab.com/libvirt/libvirt/-/pipelines/164291392

These two jobs actually ran on Cirrus CI:

  https://gitlab.com/libvirt/libvirt/-/jobs/628816093
  https://gitlab.com/libvirt/libvirt/-/jobs/628816086

We don't get a nice build log output in gitlab but that's just a
limitation of the current cirrus-run impl - we could easily enhance
it to pull the buld log out of Cirrus CI, so it is immediately
visible in GitLab logs.

IOW, the cirrus-run hack shows that even if you can't get a native runner
integration for GitLab CI, you can always use a shim to call out to pretty
much any external system you desire. So that provides a backup plan for
non-x86 CI support.

> > The Documentation/Platforms content arguably should be part of
> > the main qemu.git docs.
> > 
> > Many of the feature pages are probably better as part of the formal
> > QEMU documentation too.
> 
> Yes, definitely; but someone has to do the work.  At least the obsolete
> features are clearly marked as so.

Even if no one has time todo the work now, if we can spend a bit of time
to categorize current wiki pages and document a desired "plan", then we
can publicise it as a "bite sized task" and potentially motivate future
contributors to do some of the work as a useful way in to the QEMU world.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


