Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EDCC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 08:36:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FEA02224A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 08:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QhbsKlie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FEA02224A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSykc-0004x3-Qk
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 04:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kSyip-0004OB-Ed
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 04:34:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37026)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kSyin-000881-9F
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 04:34:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602750887;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1Kk4VtrvFvUsngjd4gvh5ipDBcv54kqFPYDkQ/zYABw=;
 b=QhbsKliegt0NLOXkoZFKYslkqQkQyWobdvINhe7lFvRwM8FK45exJcWznT6vJo2B5dxxIO
 eyyHION5lwweoGXvNYweqWEN96vQiV7eTDpqWOWAE9E5RaawSWOleTB4fpLDiA5YW9gBpt
 9cFdTQdSC0AYlc6qeKEcvuHQTVnrHko=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-ZNUOZ3DeOwuBJQp9iMrVfg-1; Thu, 15 Oct 2020 04:34:43 -0400
X-MC-Unique: ZNUOZ3DeOwuBJQp9iMrVfg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1E941868422;
 Thu, 15 Oct 2020 08:34:42 +0000 (UTC)
Received: from redhat.com (ovpn-114-115.ams2.redhat.com [10.36.114.115])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8019860C07;
 Thu, 15 Oct 2020 08:34:35 +0000 (UTC)
Date: Thu, 15 Oct 2020 09:34:31 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Cleber Rosa <crosa@redhat.com>
Subject: Re: [PATCH v3 4/4] Jobs based on custom runners: add job definitions
 for QEMU's machines
Message-ID: <20201015083431.GC163620@redhat.com>
References: <20201014052140.1146924-1-crosa@redhat.com>
 <20201014052140.1146924-5-crosa@redhat.com>
 <20201014174655.GW115189@redhat.com>
 <20201014211356.GA1199212@localhost.localdomain>
MIME-Version: 1.0
In-Reply-To: <20201014211356.GA1199212@localhost.localdomain>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:10:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 14, 2020 at 05:13:56PM -0400, Cleber Rosa wrote:
> On Wed, Oct 14, 2020 at 06:46:55PM +0100, Daniel P. Berrangé wrote:
> > On Wed, Oct 14, 2020 at 01:21:40AM -0400, Cleber Rosa wrote:
> > > The QEMU project has two machines (aarch64 and s390) that can be used
> > > for jobs that do build and run tests.  This introduces those jobs,
> > > which are a mapping of custom scripts used for the same purpose.
> > > 
> > > Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > > ---
> > >  .gitlab-ci.d/custom-runners.yml | 192 ++++++++++++++++++++++++++++++++
> > >  1 file changed, 192 insertions(+)
> > > 
> > > diff --git a/.gitlab-ci.d/custom-runners.yml b/.gitlab-ci.d/custom-runners.yml
> > > index 3004da2bda..5b51d1b336 100644
> > > --- a/.gitlab-ci.d/custom-runners.yml
> > > +++ b/.gitlab-ci.d/custom-runners.yml
> > > @@ -12,3 +12,195 @@
> > >  # strategy.
> > >  variables:
> > >    GIT_SUBMODULE_STRATEGY: recursive
> > > +
> > > +# All ubuntu-18.04 jobs should run successfully in an environment
> > > +# setup by the scripts/ci/setup/build-environment.yml task
> > > +# "Install basic packages to build QEMU on Ubuntu 18.04/20.04"
> > > +ubuntu-18.04-s390x-all-linux-static:
> > > + needs: []
> > > + stage: build
> > > + tags:
> > > + - ubuntu_18.04
> > > + - s390x
> > > + rules:
> > > + - if: '$CI_COMMIT_BRANCH =~ /^staging/'
> > 
> > IIRC, in the previous v2 (or was it v1) we discussed changing this
> > so that users who provide their own runners, don't have to always
> > use the "staging" branch name.
> >
> 
> Right, and what I got from that is that users can use a *prefix* as a
> flag to indicate that they want the extra set of jobs.
> 
> > IIUC, the key thing is that we don't want the job running on the
> > "master" or "stable-*" branches in the primary QEMU git. So could
> > check
> > 
> >    $CI_PROJECT_NAMESPACE == 'qemu-project'
> >    &&
> >    $CI_COMMIT_BRANCH !~ '^master$'
> >    &&
> >    $CI_COMMIT_BRANCH !~ '^stable-$'
> > 
> > which would let it work on users forks no matter what branch names
> > they use
> > 
> > What happens to the job if the user doesn't have runners ? Is it
> > simply skipped, or does the pipeline stall and get marked as failed ?
> >
> 
> The pipeline gets "stuck" (literaly, that's the status name it gets).
> That's the main issue that made me believe that opting *in* (by using
> a common branch name prefix) was the simpler solution.

Hmm, that's very annoying behaviour.

> > If the jobs aren't auto-skiped, we would need to add an env variable
> > 
> >    (
> >    $CI_PROJECT_NAMESPACE == 'qemu-project'
> >    &&
> >    $CI_COMMIT_BRANCH !~ '^master$'
> >    &&
> >    $CI_COMMIT_BRANCH !~ '^stable-$'
> >    )
> >    ||
> >    $QEMU_ENABLE_CUSTOM_RUNNERS == 'yes'
> > 
> > and require the user to set the QEMU_ENABLE_CUSTOM_RUNNERS variable
> > in the web UI for their fork
> >
> 
> We can do that, but I think it's more than we need.  The odds that a
> user will have all of the same runners, and will be able to run all
> the extra jobs, are very very low IMO.  Right from the start, very few
> people have an s390 machine running Ubuntu 18.04.
> 
> So, I believe that whenever a user pushes to a branch such as
> "staging-topic-foo", he will have to deal with some of the extra jobs
> (such as canceling the ones that will never run) anyway.  Having to
> deal with those on every single push, or alternatively having to turn
> on/off $QEMU_ENABLE_CUSTOM_RUNNERS doesn't the best experience to me.
> 
> The "staging" prefix convention (with a better prefix name now or in
> the future?) seems to result in the best experience to me.

Well "staging" prefix wasn';t appealing to me since none of the branches
I work on have such a name prefix.

> > That all said, I don't mind if you postpone this rules change to a
> > followup patch.
> >
> 
> OK, let me know if you agree with my explanation above, or if you
> really want to see a followup patch.

Just ignore it for now. I'll do more thinking to see if I can figure
out a more attractive solution.



Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


