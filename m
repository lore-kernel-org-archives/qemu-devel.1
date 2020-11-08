Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0E1C388F9
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 22:20:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5C67206E3
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 22:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FzKmFNmj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5C67206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbt3J-000710-JX
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 17:20:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37918)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbt26-0005kd-ND
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 17:19:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54005)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbt24-00024s-ED
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 17:19:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604873971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=B17PjAEChMxAQOnEt0Ifp1nUaSgA3OaOjNx04Ed1BzQ=;
 b=FzKmFNmjRBcngiDo3i5TIWuWZISFhk5wdffw/gwaBAncRf6kd7UX6fDFs0hnZcrhGn7Vha
 aM1baq7o0ufV/2lEZunzBCdqcSNBJag5YpypgwRWbfLVbfcQLx9O+kyu8i0wU4BmJgFAX7
 sEU93QvJlp8JdmIxNId1iAF8AWoQxa0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-zzFjREOIOFiU6HKbCix3pA-1; Sun, 08 Nov 2020 17:19:29 -0500
X-MC-Unique: zzFjREOIOFiU6HKbCix3pA-1
Received: by mail-wr1-f71.google.com with SMTP id 67so3488028wra.2
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 14:19:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XXxr586VY7UbyUc6vzBVmuBrzXY3zQ+1zDR0I1A3Ijc=;
 b=b/pYlE2YsHIuH/etdnxOHrOUbk3dvKTv7EsmR+d2UxN3QjuXEmvSOsoCwDxFAJV3tb
 Uf6LhbhUT5GIWMVrDUVaO1X+8hU+TzZchpkEXG9kftfWbA4HdBEDRCmZKJZ6lmOAByD/
 H2wzMZ4rLc/28gwutfb7ApvxinPYS0dyDCwWmnjfSteZG0PDrOChJtga1QXsrkBZN7r1
 kUrpOR215ERh7xyGQjjZConAJg35r5o1ktGF+ExRMKyjKLO8paxNE4tumdJoFcznN6cQ
 BaB6cXuVXIvqhDCzMcL1+dhQ/IavWwPOjmy8vU8i8tPYUkcqWPki/90uJ2ckQYw6P1r8
 rzQA==
X-Gm-Message-State: AOAM531lgrsmRbay5yhLeXIIhDPDLNG/plujSzSY8m+Lm5Nu+i/RUPBh
 sli0UFmCqFeTTUJPhLFRxY+wUEptvWhrZQ/GTrCopDlrvRYJx2kIQmWESjM7WH59LP4d5bqUVqR
 YsTmUSREmoppYZck=
X-Received: by 2002:a7b:c00b:: with SMTP id c11mr11325285wmb.175.1604873968358; 
 Sun, 08 Nov 2020 14:19:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyyL6Dw8t8yKNZuoWokjckwB7MlXNhMtUIRGFeAG1+pz2ArbILTPro2Thhu4GfKjXLOu6yJtg==
X-Received: by 2002:a7b:c00b:: with SMTP id c11mr11325266wmb.175.1604873968167; 
 Sun, 08 Nov 2020 14:19:28 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id i10sm2384716wrs.22.2020.11.08.14.19.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2020 14:19:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/11] gitlab-ci: Allow forks to select & restrict build
 jobs
Date: Sun,  8 Nov 2020 23:19:14 +0100
Message-Id: <20201108221925.2344515-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 15:45:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,=0D
=0D
2 months ago GitLab added time limit to their free CI offer [1].=0D
This series provide developers with the possibility to not run=0D
all jobs. By default all jobs are started, but we can restrict=0D
by selecting a subset of them.=0D
=0D
Since v2:=0D
- no more RFC=0D
- project-wide environment variable works=0D
- do not remove the jobs from the pipeline, mark them 'manual'=0D
  so user can still run them=0D
=0D
Since v1:=0D
- switch from "all but skip some" to "all or select some"=0D
=0D
A friendly way to use this feature is with git aliases [3]:=0D
=0D
 $ git config alias.pushci_system \=0D
    'push -o ci.variable=3D"QEMU_BUILD=3Dsystem"'=0D
 $ git config alias.pushci_debian \=0D
    'push -o ci.variable=3D"QEMU_BUILD=3Ddebian"'=0D
=0D
Then you can run the jobs based on Debian images (only) using:=0D
=0D
 $ git pushci_debian gitlab_repo my_branch_for_debian=0D
=0D
Or run all system-mode emulation jobs only using:=0D
=0D
  $ git pushci_system my_gitlab_repo branch_with_system_feature=0D
=0D
You can also set the default QEMU_BUILD you want for your fork=0D
adding a project-wide environment variable [2]. Your pipelines=0D
will be restricted to this set, but you can overwrite it from=0D
the git-push command line (using QEMU_BUILD=3Dall).=0D
=0D
Comments welcomed!=0D
=0D
Regards,=0D
=0D
Phil.=0D
=0D
[1] https://about.gitlab.com/releases/2020/09/01/ci-minutes-update-free-use=
rs/=0D
[2] https://docs.gitlab.com/ee/ci/variables/README.html#create-a-custom-var=
iable-in-the-ui=0D
[3] https://docs.gitlab.com/ee/user/project/push_options.html#useful-git-al=
iases=0D
=0D
Philippe Mathieu-Daud=C3=A9 (11):=0D
  gitlab-ci: Drop generic cache rule=0D
  gitlab-ci: Replace YAML anchors by extends (cross_system_build_job)=0D
  gitlab-ci: Replace YAML anchors by extends (native_build_job)=0D
  gitlab-ci: Replace YAML anchors by extends (native_test_job)=0D
  gitlab-ci: Replace YAML anchors by extends (acceptance_test_job)=0D
  gitlab-ci: Rename acceptance_test_job -> integration_test_job=0D
  gitlab-ci: Extract common job definition as 'cross_common_job'=0D
  gitlab-ci: Extract common job definition as 'native_common_job'=0D
  gitlab-ci: Add rules to select cross-jobs to build=0D
  gitlab-ci: Add rules to select building/testing native jobs=0D
  gitlab-ci: Move artifacts expiry rule to common 'native_build_job'=0D
=0D
 .gitlab-ci.d/crossbuilds.yml |  82 +++++++++++++------=0D
 .gitlab-ci.yml               | 153 ++++++++++++++++++++---------------=0D
 2 files changed, 146 insertions(+), 89 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


