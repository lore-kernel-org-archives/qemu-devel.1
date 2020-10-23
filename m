Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54298C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 08:53:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 905252080C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 08:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BvR9rfwD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 905252080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVsom-0007Ot-Hj
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 04:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kVsnd-0006vH-03
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 04:51:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32419)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kVsnY-0005cC-LF
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 04:51:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603443103;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=D9HCrS6Dzl9uGtla06bwNzafmhtBYexTxJLQDYtAnPI=;
 b=BvR9rfwD8DevDlULaiM2ahEcftKxKViU8JOb0mt5Vi47z0erPQFEEj3y9pPr9GXbUNKmV5
 5i1wHDmLWpl0IVCIb5lAzfdzAqt550eVLoWAjHC0tyCRpPTaqTCQk29ok/GVyxCvhu4gas
 9pLMUYt4Hx0UDB5iqsn0zPSieAlBVgE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-Wy1uuc73PvS8yGJ7mpXL0Q-1; Fri, 23 Oct 2020 04:51:41 -0400
X-MC-Unique: Wy1uuc73PvS8yGJ7mpXL0Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC80F804B6E;
 Fri, 23 Oct 2020 08:51:39 +0000 (UTC)
Received: from redhat.com (ovpn-114-187.ams2.redhat.com [10.36.114.187])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DA3FC6EF57;
 Fri, 23 Oct 2020 08:51:33 +0000 (UTC)
Date: Fri, 23 Oct 2020 09:51:31 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [RFC] Using gitlab for upstream qemu repo?
Message-ID: <20201023085131.GC445638@redhat.com>
References: <672b8aa0-2128-23e1-b778-01a4d96b209d@redhat.com>
 <9f6c63c6-599b-ac15-42e2-b9c1991fc7ee@redhat.com>
MIME-Version: 1.0
In-Reply-To: <9f6c63c6-599b-ac15-42e2-b9c1991fc7ee@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 01:44:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 22, 2020 at 12:24:28PM -0500, Eric Blake wrote:
> On 10/22/20 11:47 AM, Paolo Bonzini wrote:
> > Hi all,
> > 
> > now that Gitlab is the primary CI infrastructure for QEMU, and that all
> > QEMU git repositories (including mirrors) are available on Gitlab, I
> > would like to propose that committers use Gitlab when merging commits to
> > QEMU repositories.
> > 
> 
> > Nothing would change for developers, who would still have access to all
> > three sets of repositories (git.qemu.org, gitlab.com and github.com).
> > Committers however would need to have an account on the
> > https://gitlab.com/qemu-project organization with access to the
> > repositories they care about.  They would also lose write access to
> > /srv/git on qemu.org.
> 
> For clarification, I'm assuming the set of committers is rather small,
> and not the same as the set of subsystem maintainers who send pull
> requests for a committer to then merge in.  Does this proposal mean that
> pull requests would have to switch to gitlab merge requests, or would
> there be a transition period where submaintainers still send pull
> requests via whichever means desired (mail or gitlab merge request), but
> the eventual committer repackages that as a gitlab merge request before
> it is upstream?
> 
> > 
> > Of course this is just starting a discussion, so I'm not even proposing
> > a date for the switch.
> 
> I'm hoping that as part of the consideration that we make sure that
> command line tooling can still drive everything; there is a difference
> between requiring a web page to initiate a merge request, vs. proper
> command line tooling one to leave the web page as an optional part of
> the workflow for only those who want it.

Since Paolo's only suggesting move of the git server here, it should not
impact anything that is done today. Any CLI tools that talk plain git
to git.qemu.org will work unchanged against git.qemu.org or gitlab.com.


To answer your question though, GitLab has an extensive REST API that
lets you drive almost everything that is exposed in their Web UI. There
is my own Bichon tool (https://gitlab.com/bichon-project/bichon) that
uses the API to provide an interactive terminal based review UI, while
the Lab tool (https://github.com/zaquestion/lab) provides a text based
non-interactive CLI for use from shell/scripts again using the REST
API.


Not commonly known is that GitLab also has support for Git push options,
which let you create merge requests using a plain "git push":

  https://docs.gitlab.com/ee/user/project/push_options.html

eg if you have a remote called "gitlab", you can open a MR from the CLI
using

 $ git push -o merge_request.create \
            -o merge_request.title="Do awesome thing" \
            gitlab my-branch

This is something that I could see being easily wired up into a
"git-publish" like tool for example.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


