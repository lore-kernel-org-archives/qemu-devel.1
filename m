Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537E7C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 16:10:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E5822074D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 16:10:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E5822074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEEHq-00087a-94
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 12:10:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kEEGd-00071T-1g
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 12:08:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47273
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kEEGa-0003Mv-FJ
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 12:08:46 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-svIn_akpM2ixolck4iGXJg-1; Fri, 04 Sep 2020 12:08:41 -0400
X-MC-Unique: svIn_akpM2ixolck4iGXJg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D5AA801AFD;
 Fri,  4 Sep 2020 16:08:40 +0000 (UTC)
Received: from redhat.com (ovpn-114-5.ams2.redhat.com [10.36.114.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 702DD18B59;
 Fri,  4 Sep 2020 16:08:39 +0000 (UTC)
Date: Fri, 4 Sep 2020 17:08:36 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: Should we apply for GitLab's open source program?
Message-ID: <20200904160836.GS721059@redhat.com>
References: <878sdp4ks9.fsf@linaro.org>
MIME-Version: 1.0
In-Reply-To: <878sdp4ks9.fsf@linaro.org>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 01:57:12
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 "qemu@sfconservancy.org" <qemu@sfconservancy.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 04, 2020 at 04:35:34PM +0100, Alex Bennée wrote:
> 
> Hi,
> 
> Given our growing reliance on GitLab and the recent announcement about
> free tier minutes:
> 
>   https://about.gitlab.com/pricing/faq-consumption-cicd/
> 
> is it time we officially apply for GitLab's Open Source Program:
> 
>   https://about.gitlab.com/solutions/open-source/program/
> 
> ?
> 
> From what I can see the QEMU project will easily qualify - the only
> minor inconvenience is needing to reapply every year. So far it seems as
> a public project their are no usage limits anyway. We are currently
> listed as 0 of 50,000 minutes:
> 
>   https://gitlab.com/groups/qemu-project/-/usage_quotas#pipelines-quota-tab

I suspect that ultimately we will end up wanting / needing to do
this. As you say, there's no significant downside, and it will
unlock features.

Note there is an issue open about making the application process
simpler:

https://gitlab.com/groups/gitlab-com/marketing/community-relations/opensource-program/-/epics/18

which could be a reason to not rush into applying immediately
if we don't have an obvious pressing need.

As you say there's no enforcement of CI minutes at all right now
anyway as reported at:

  https://gitlab.com/gitlab-org/gitlab/-/issues/243722


> So we are in no pressing hurry to do this for the minutes but I suspect
> there may be other things that are made easier by having access to all
> the toys GitLab provides. Daniel has already posted to the forum
> requesting details about how this might affect our workflow so maybe we
> should just wait for feedback until pressing on?
> 
>   https://forum.gitlab.com/t/ci-cd-minutes-for-free-tier/40241/33

Yep, my key observation is that I don't think the open source program
fully solves the CI minutes problems for projects using a fork'ing
workflow, as the increased minutes only applies for jobs run in the
main repo. Each individual contributor is still limited in their
fork.  Similarly their suggestion that people bring their own
custom runners doesn't really help projects with a forking workflow
as custom runners aren't accessible to forks.

It would be crazy if they enforced limited CI time on public repos
right now, because if any individual contributor runs out of CI
minutes they will be unable to contribute to a project that mandates
succesful CI pipeline, even if the project is in the OSS program.

Hopefully they will come up with a more practical answer to the
forking-workflow problems.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


