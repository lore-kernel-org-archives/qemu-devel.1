Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2571C43466
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 14:05:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2975B20756
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 14:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CI/yftaO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2975B20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKMRX-0002es-Vj
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 10:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37392)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kKMPo-0001zm-V9
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 10:03:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23950)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kKMPk-00083P-7W
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 10:03:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600697010;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7+hw10uMaDqdS1BKjS6aEopJlVTkdKVvtVNlC+9N3ZA=;
 b=CI/yftaOxjRRgXzwnqGhEJPwsm706WTEztc07an3WTRTeE2XqrGxqM09pvDWkZSeXdvEdh
 BYE0jRrbgKhyVAndE4fMlF8+Hp3FDV97py7xzJZ/CQJlvRmQ2zwhX4PRcCJQxwwb1xDoLh
 rn9yfgzp876tPdSIupUtu0NvYQsbip4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-ocwGwjCtMGWoOaLULcg99w-1; Mon, 21 Sep 2020 10:03:10 -0400
X-MC-Unique: ocwGwjCtMGWoOaLULcg99w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DC90801FCC;
 Mon, 21 Sep 2020 14:03:09 +0000 (UTC)
Received: from redhat.com (ovpn-113-113.ams2.redhat.com [10.36.113.113])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A2F31002C06;
 Mon, 21 Sep 2020 14:03:07 +0000 (UTC)
Date: Mon, 21 Sep 2020 15:03:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: Should we apply for GitLab's open source program?
Message-ID: <20200921140305.GM1942072@redhat.com>
References: <878sdp4ks9.fsf@linaro.org>
 <20200904160836.GS721059@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200904160836.GS721059@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:43:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 "qemu@sfconservancy.org" <qemu@sfconservancy.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 04, 2020 at 05:08:36PM +0100, Daniel P. Berrangé wrote:
> On Fri, Sep 04, 2020 at 04:35:34PM +0100, Alex Bennée wrote:
> > 
> > Hi,
> > 
> > Given our growing reliance on GitLab and the recent announcement about
> > free tier minutes:
> > 
> >   https://about.gitlab.com/pricing/faq-consumption-cicd/
> > 
> > is it time we officially apply for GitLab's Open Source Program:
> > 
> >   https://about.gitlab.com/solutions/open-source/program/
> > 
> > ?
> > 
> > From what I can see the QEMU project will easily qualify - the only
> > minor inconvenience is needing to reapply every year. So far it seems as
> > a public project their are no usage limits anyway. We are currently
> > listed as 0 of 50,000 minutes:
> > 
> >   https://gitlab.com/groups/qemu-project/-/usage_quotas#pipelines-quota-tab
> 
> I suspect that ultimately we will end up wanting / needing to do
> this. As you say, there's no significant downside, and it will
> unlock features.
> 
> Note there is an issue open about making the application process
> simpler:
> 
> https://gitlab.com/groups/gitlab-com/marketing/community-relations/opensource-program/-/epics/18
> 
> which could be a reason to not rush into applying immediately
> if we don't have an obvious pressing need.
> 
> As you say there's no enforcement of CI minutes at all right now
> anyway as reported at:
> 
>   https://gitlab.com/gitlab-org/gitlab/-/issues/243722

FYI, I've very roughly summed up the CI minutes consumed on

 https://gitlab.com/qemu-project/qemu/-/pipelines/192481227/builds

and it comes to around 1400 minutes.

So the default 400 minute limit proposed is clearly useless.

The Open Source Program  offers 50,000 minutes. With our current
set of jobs that allows for 35 CI pipelines per month, barely
one per day.

IOW, I fear QEMU will easily hit the GitLab CI minute quota even
with the 50k minutes per month limit.

Libvirt only uses about 450 CI minutes per pipeline, but we
merge code on a more frequent basis since we don't use the
pull request model, so we'll use up a 50k minutes allowance
very quickly too.

It looks like joining the Open Source program is a must have
as the proposde 400 CI minute quota is unusably small.

Even once we do that though, it looks inescapable that projects
of our scale will need to bring more of our own CI hardware to
the table, or failing that, continue to leverage a wide variety
3rd party CI systems (travis, cirrus, etc). 

It is still unclear how we'll cope with contributors doing
CI in their own forks, but GitLab continue to offer positive
feedback that they want to make projects in our situation
succesful and thus want to find some kind of solution to the
CI quota problem with the forking workflow.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


