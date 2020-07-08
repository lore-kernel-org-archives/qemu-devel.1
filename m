Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1C9C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 09:53:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 062A420771
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 09:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WuWS/cMW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 062A420771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jt6ld-0001Mz-6A
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 05:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jt6l3-0000x8-Ci
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 05:52:53 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:40894)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jt6l1-0000O9-I2
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 05:52:53 -0400
Received: by mail-pl1-x642.google.com with SMTP id x11so17960156plo.7
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 02:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=E/vH64psmFMJWYBsEAn53ZFue8gToH0f0gdSBWaVr+Y=;
 b=WuWS/cMWWVViRfOuIVs3KdsFInVxMP8cQ3Syl3hBJytD0imFlIQQsMcZOVawcElLdz
 d7sw77e6ekKObJ4fjKTXH2aVpPwY884z6hgkcJjS/iYyrPnQg83lC3AHWr3z9gFDZ+5V
 iR0/TQuJrv3wWscWo0s/eNnwI02SfKDliQKp9nJpOPvMfx8xVb1hThh+254OGxHowdG8
 Li+rFqCC7+j8pyKwFxrZ5+ApkfOfnVl2CGsGEf9BsdaOwkAJrGGZDu7Xb9YGMixtU5zA
 ZE0fve0E++K5enX4vAMz9XGyTDJOQF9h6vKCEK+X8NZ4bpb+QtwWo0jGpp3rz9uN3JkY
 eKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=E/vH64psmFMJWYBsEAn53ZFue8gToH0f0gdSBWaVr+Y=;
 b=HpYxfKmz+FTkP8VZNTg1SEKxYjWWGFMF9NxhaXoqODO1sGzI779BDKZkIIBXCbnayl
 Tw6cNz0RbGC1eXkPNCVKep7CsGNyi0ADgkZiWatEXt/WQhBRecVquxA9KBrLSMWFCOPB
 U/B7/ByyY+8UbvFJt34/gPMLLUr8sSKSLSgAuKBZn5VJ+ZSn6dSjmP6ylvaUEEil9wkJ
 Rq1jpGCBDHHdpAphzFqupFNyrVgYKovJZfD0JxHGFHbc1lXUI/CE0WVXrMuZo0mG5D+Q
 DCrTYp3T/PN9P0CZxGZEoZsQ5xTmy49MQuD3yeGbKoAACLCPvr75FesdjM3WCAiEY9Pm
 VI+g==
X-Gm-Message-State: AOAM530CPnZKJJCj7SoGjSW7y/5d8D2MJ/Vo5cEAw+ay7tkhwGao+keF
 iQpbC6asP6bdppqzKVQhaShMWv2KjEPH4Uya4QXmm0Wa
X-Google-Smtp-Source: ABdhPJzthUY+qoPrBeEVO55JQiPw8UYokdupR6y0lcA5JkAO1ImTTMBY/nOXxWbNRbgV7E9b7F/D1RnNuMjBhBHddp8=
X-Received: by 2002:a17:902:6b45:: with SMTP id g5mr706461plt.42.1594201969652; 
 Wed, 08 Jul 2020 02:52:49 -0700 (PDT)
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 8 Jul 2020 10:52:38 +0100
Message-ID: <CAJSP0QV3uB4QY6mzw2JFDedr0PJhGkU5FdmLF5PbjMPyxiYSuw@mail.gmail.com>
Subject: Migrating custom qemu.org infrastructure to GitLab
To: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=stefanha@gmail.com; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, Cleber Rosa <cleber@redhat.com>,
 Jeff Cody <codyprime@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Dear QEMU community,
QEMU currently has a static website, wiki, git repo hosting, and
special-purpose cronjobs/containers running in VMs. There is currently
no system administrator looking after our infrastructure so the most
urgent tasks fall onto me, the remainder are ignored/postponed. The
current situation exposes qemu.org to the risk of downtime and
security issues.

Another limitation is that each piece of infrastructure is managed
separately and one-time contributors cannot easily propose changes
because they do not have access. It would be much better to use our
existing code review process so that anyone can make changes to
infrastructure by sending a patch.

GitLab's Continuous Integration (CI) system provides a powerful way to
perform actions defined in yaml files in qemu.git. This includes
running scripts, builds, publishing build artifacts, etc. We have
already begun using it for automated builds and tests:
https://gitlab.com/qemu-project/qemu/-/blob/master/.gitlab-ci.yml

GitLab also offers git repo hosting, wikis, issue tracking, and other
features. It is possible to log in using GitHub, Google, or Twitter
single sign-on if you do not want to create another account. As more
open source projects use GitLab it becomes easier for one-time
contributors who will already be familiar with the tools from other
projects.

Here is a full list of GitLab's features:
https://about.gitlab.com/features/

GitLab offers the gold/ultimate tier for free to open source projects:
https://about.gitlab.com/solutions/open-source/

GitLab itself is open source and can be self-hosted if we decide to
leave in the future.

With this in mind I propose moving qemu.org infrastructure to GitLab
incrementally. This needs to be done carefully to avoid disruption and
only where GitLab meets the requirements. The QEMU project will
continue to have access to cloud hosting for running custom
infrastructure or adding runners to GitLab CI to improve CI
performance.

The following infrastructure components can be considered for GitLab migration:

1. qemu-web.git static site generation. GitLab CI/CD can build the
static website on each qemu-web.git commit and publish the HTML
artifacts.

2. wiki.qemu.org is a MediaWiki instance. Account creation is a hurdle
to one-time or new contributors. It is unclear whether GitLab's wiki
is expressive enough for a lossless conversion of the existing QEMU
wiki. Any volunteers interested in evaluating the wiki migration would
be appreciated.

3. Git repo hosting is a core feature of GitLab and we already have a
qemu.git mirror. Hosting the repos on GitLab reduces the need for
qemu.org ssh access.

4. The QEMU release process can be moved to CI/CD so that publishing
stable releases and release candidates is less dependent on one
committer's machine or scripts.

5. Issue tracking. Launchpad more or less works, but the login always
bothers me. If we move git repo hosting then it makes sense to do
issue tracking on GitLab too.

There is a snowball effect where the experience is improved the more
GitLab features we use, so I hope that most of these migrations will
be possible.

Next steps:
 * If you have an interest in one or more of these infrastructure
components, please join the discussion.
 * If there are no volunteers for an infrastructure component I'll
slowly work my way through evaluating GitLab and propose migrations

Stefan

