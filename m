Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E81C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 08:19:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 388BD206C9
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 08:19:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 388BD206C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kE6w5-0007iJ-4r
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 04:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kE6vX-0007HN-2z
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 04:18:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35509
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kE6vU-0003Df-W9
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 04:18:30 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-t4JDN5I4PLmwwGNgSUH0FA-1; Fri, 04 Sep 2020 04:18:26 -0400
X-MC-Unique: t4JDN5I4PLmwwGNgSUH0FA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E03518A225E;
 Fri,  4 Sep 2020 08:18:25 +0000 (UTC)
Received: from redhat.com (ovpn-114-5.ams2.redhat.com [10.36.114.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 813A45C1C2;
 Fri,  4 Sep 2020 08:18:19 +0000 (UTC)
Date: Fri, 4 Sep 2020 09:18:16 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Cleber Rosa <crosa@redhat.com>
Subject: Re: [PATCH v2 2/2] GitLab Gating CI: initial set of jobs,
 documentation and scripts
Message-ID: <20200904081816.GB721059@redhat.com>
References: <20200709024657.2500558-1-crosa@redhat.com>
 <20200709024657.2500558-3-crosa@redhat.com>
 <20200709103029.GK3753300@redhat.com>
 <20200904001139.GE55646@localhost.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200904001139.GE55646@localhost.localdomain>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 03:58:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
 Beraldo Leal <bleal@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 03, 2020 at 08:11:39PM -0400, Cleber Rosa wrote:
> On Thu, Jul 09, 2020 at 11:30:29AM +0100, Daniel P. Berrangé wrote:
> > On Wed, Jul 08, 2020 at 10:46:57PM -0400, Cleber Rosa wrote:
> > > This is a mapping of Peter's "remake-merge-builds" and
> > > "pull-buildtest" scripts, gone through some updates, adding some build
> > > option and removing others.
> > > 
> > > The jobs currently cover the machines that the QEMU project owns, and that
> > > are setup and ready to run jobs:
> > > 
> > >  - Ubuntu 18.04 on S390x
> > >  - Ubuntu 20.04 on aarch64
> > > 
> > > During the development of this set of jobs, the GitLab CI was tested
> > > with many other architectures, including ppc64, s390x and aarch64,
> > > along with the other OSs (not included here):
> > > 
> > >  - Fedora 30
> > >  - FreeBSD 12.1
> > > 
> > > More information can be found in the documentation itself.
> > > 
> > > Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > > ---
> > >  .gitlab-ci.d/gating.yml                | 146 +++++++++++++++++
> > 
> > AFAIK, the jobs in this file just augment what is already defined
> > in the main .gitlab-ci.yml. Also since we're providing setup info
> > for other people to configure custom runners, these jobs are usable
> > for non-gating CI scenarios too.
> >
> 
> If you mean that they introduced new jobs, you're right.
> 
> > IOW, the jobs in this file happen to be usable for gating, but they
> > are not the only gating jobs, and can be used for non-gating reasons.
> >
> 
> Right, I do not doubt these jobs may be useful to other people and on
> scenarios other than "before merging a patch series".
> 
> > This is a complicated way of saying that gating.yml is not a desirable
> > filename, so I'd suggest splitting it in two and having these files
> > named based on what their contents is, rather than their use case:
> > 
> >    .gitlab-ci.d/runners-s390x.yml
> >    .gitlab-ci.d/runners-aarch64.yml
> > 
> > The existing jobs in .gitlab-ci.yml could possibly be moved into
> > a .gitlab-ci.d/runners-shared.yml file for consistency.
> >
> 
> Do you imply that every gitlab CI job should be a gating job?  And
> that the same jobs should be used when other people with their own
> forks?  I find this problematic because:
> 
> * It would trigger pipelines with jobs that, unless every user has the
>   same runners configured, would have unfulfilled jobs that don't have
>   a matching hardware.

Jobs that require a custom runner should not be set to run by default,
but individual contributors must absolutely be able to opt-in to running
those jobs simply by registering a runner on their account.

> * It dilutes the idea that those jobs are inherently different with
>   regards to the management of their infrastructure.

I don't really know what yiu mean here, but "Inherantly different"
does not sound like a desirable property.

> * It destroys the notion of layered testing, for whatever people find
>   that worth it, where a faster turnaround could/would be possible
>   with fewer jobs for every push, and many more jobs before a merge.

The key goal of CI is to reduce the burden on maintainers. The biggest
cost is if we merge code and failure is noticed after merge. IT is
still a large cost, however, if Peter only finds a CI failure when he
attempts the pre-merge test. He has to throw out the pull request
putting more work on the subsystem maintainer. The subsystem maintainer
may have to throw it back to the original author.

The ideal scenario that we need to strive towards is that the original
author has tested their code with 100% coverage of all the CI jobs QMEU
has defined.

Any time there is a job that is not run by authors, but only by the
maintainers, we are putting increased burden on the maintainers, so
must be minimize that.

IOW, layered testing is not desirable as goal. Rather layered testing
is just a default setup, but we'd encourage contributors to run the
full set of CI jobs, especially if they are frequent contributors.
The more they run themselves, the less burden on subsystem maintainers
and Peter, and thus the better we all scale.

> Finally, I find the split by runner architecture you suggested
> problematic because different organizations may have jobs for the same
> architecture.  I believe that files for different organizations may be
> a better organization instead.  Entries in the MAINTAINERS are one
> example where the grouping by architecture may not be optimal.

I don't think we should be structuring jobs around organizations. We
should be defining a set of desired jobs we wish to be able to run.
Any organization can bring a runner that is capable of running the
jobs and donate it to the QEMU project for our formal CI runner
The organization is not defining the job though - QEMU is  defining
the jobs we expect to have used for testing.

This is key because any contributor needs to be able to spin up an
identical envrionment to replicate any build failures. We don't want
runners for merge testing that are built as a blackbox by someone.
That is the single biggest painpoint with Peter's current merge
jobs - we can't easily replicate Peter's merge env even if we had
the matching hardware available.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


