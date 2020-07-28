Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126C5C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 16:17:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDE3F2065C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 16:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ILsmPP4z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDE3F2065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0SII-0000hG-4t
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 12:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k0SGY-0007xK-RC
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 12:15:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44278
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k0SGX-0001dt-0e
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 12:15:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595952944;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yMpjBF9fcK+6hE9WqUcO5bVU3zLWoR7DRhRRm1viStI=;
 b=ILsmPP4zjxNUGfS4bhawTdQsdBv6B7H/3dt0ZI/LF/E+zCF8ZS5Xz0Kw5wfHk1q7nLXL+3
 KQt2Ge9nJhEcLReZ1OhGtPBvjKHIqDf+QFfk5PN7G8Z7vRnj23vWDdomlTOGY01Wi4RnbG
 nBGmYIWKPP3MPxYuRmcou0YIGvwzEwo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-JuJbfCkLM-6yWJFRPjvZew-1; Tue, 28 Jul 2020 12:15:38 -0400
X-MC-Unique: JuJbfCkLM-6yWJFRPjvZew-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9955D80BCAB;
 Tue, 28 Jul 2020 16:15:37 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.24])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DDEEA70A18;
 Tue, 28 Jul 2020 16:15:19 +0000 (UTC)
Date: Tue, 28 Jul 2020 17:15:17 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Cleber Rosa <crosa@redhat.com>
Subject: Re: [PATCH v2 0/2] QEMU Gating CI
Message-ID: <20200728161517.GD3443476@redhat.com>
References: <20200709024657.2500558-1-crosa@redhat.com>
 <CAFEAcA9qdYm+a-PTPE-Vbhmp4iZ5Bo0Gt-2RcCrO7CS2yp9_CA@mail.gmail.com>
 <20200720172210.GA3987025@localhost.localdomain>
 <CAFEAcA8BD3BoJB9FAmeuZc8fKFNZywJT2LdGON670uM8ATdhZw@mail.gmail.com>
 <20200728145134.GB3443476@redhat.com>
 <20200728161306.GB389264@localhost.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200728161306.GB389264@localhost.localdomain>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 10:31:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 Eduardo Habkost <ehabkost@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 28, 2020 at 12:13:06PM -0400, Cleber Rosa wrote:
> On Tue, Jul 28, 2020 at 03:51:34PM +0100, Daniel P. Berrangé wrote:
> > On Tue, Jul 28, 2020 at 03:48:38PM +0100, Peter Maydell wrote:
> > > On Mon, 20 Jul 2020 at 18:22, Cleber Rosa <crosa@redhat.com> wrote:
> > > > Sure.  It's important that PATCH 2/2 in this series is included in a
> > > > branch that you need to push to the "staging" branch on the
> > > > https://gitlab.com/qemu-project/qemu repo (it could be just that one
> > > > patch).  Then, you can run:
> > > >
> > > >   ./scripts/ci/gitlab-pipeline-status --verbose -w
> > > >
> > > > And that should be it.  You can drop '--verbose' if you just want the
> > > > final outcome as the result.
> > > 
> > > I tried this (local branch named "staging", pushed to gitlab
> > > remote "staging" branch), but it said:
> > > 
> > > e104462:bionic:qemu$ ./scripts/ci/gitlab-pipeline-status --verbose -w
> > > ERROR: No pipeline found
> > > failure
> > > 
> > > It does seem to have kicked off the pipeline on gitlab though:
> > > https://gitlab.com/qemu-project/qemu/-/pipelines/171671136/builds
> > > OTOH I can't see anything on that web page that suggests that
> > > it's submitting jobs to the s390 or aarch64 boxes -- is it
> > > intended to?
> > 
> > It looks like those jobs are all in the "test" stage of the pipeline, so
> > it is waiting for the earlier stages to complete before running the jobs.
> >
> 
> Hi Daniel,
> 
> Right.  IIUC the criteria for putting jobs in the test stage at the
> moment is "if they include running tests (in addition to builds) they
> should be in test".  Looking at that from this perspective, they're in
> the right place.
> 
> But, these jobs don't depend on anything else, including container
> builds, so there's no reason to have them wait for so long to run.
> The solution may be to rename the first stage (containers) to something
> more generic (and unfortunately less descriptive) so that all of them
> will run concurrently and earlier.

Just add 'needs: []'  to any jobs that don't depend on earlier jobs.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


