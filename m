Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CEEC55178
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 17:22:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD10E206B6
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 17:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gvQRspw+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD10E206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaixa-0002No-P1
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 12:22:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kairW-00047e-1z
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 12:15:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54129)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kairL-00008p-IH
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 12:15:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604596533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Kt8VNc7q/O/WmPMtLhHyEiZbAdRmqjH+/AfFLVv2PRM=;
 b=gvQRspw+updXZTCe9UXGZZsrtDB0OYZ9qZFDdYSodU9uIwNCmzGp9PYuTYmwhy4rd4gUVl
 7vx5Jk0HWNri9UiMQ7TBZbPP8ujyKmr+Uy3lp8IbfzYtVCaWftt5b5z7UW1dV6GAilPwRG
 XNoX3TLS6o7/igjRu27pHaq8Fi1ldJY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-IYIOD6EFMMiSikcmBPgrwA-1; Thu, 05 Nov 2020 12:15:31 -0500
X-MC-Unique: IYIOD6EFMMiSikcmBPgrwA-1
Received: by mail-wm1-f70.google.com with SMTP id o19so879265wme.2
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 09:15:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5mlWPUWCo1DVzHeObueurpViXc1j4gYsOIFhvz3wayA=;
 b=MFv4C3sHiCCXsKezaH4g9KvvdaMDLEpsuKqv4OSFJNZLyDl7fZMJK+9GdVIyqvQoos
 6iiAVPAxAA+6gS98xh0q7qOJQvKBQ77K/5coFSyOZrZ3b4f+h/ovfSea0JQBozDmR9Do
 bQ80Tf2/5r7WEaeDzEwCS6se4naYhoiHN9C3Dk3kdP+v+Um+XkAiYpCZTXd3sTBDZnYq
 cBZ/EmsWGry1y/3Jizk/IeD3DU7LAuOT/JGpfNCjMLr3wnntAqSevkXzcL6nhpUWDleZ
 mRBKLAFdowpFBNLzeFZ9E0+SRNpCaHX8M9IO7404LBYyojg32ZRVDFh+w0rgkJsEy7+I
 n8Gg==
X-Gm-Message-State: AOAM531oCM9faTf7MSgzO/jvSF96ZPV8Smh7y90Gpm2vHymz/fBJT6F+
 9qt4/h4mGOhSnmF/34UnIEwt5y0BwOofvSVVPHxRQeLbuBEPyEzE9h7y8DiDhVBgQDdZmxm3zzq
 Hy5wFfAb57f7LFi8=
X-Received: by 2002:adf:a29e:: with SMTP id s30mr4487180wra.29.1604596530040; 
 Thu, 05 Nov 2020 09:15:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxEobgLtK6GaBhV5ktnQKBwJuAU+imkWiFMvfUagKFT9NuPZ9UDpUFBN4/cD0LkjWKRqu5OFw==
X-Received: by 2002:adf:a29e:: with SMTP id s30mr4487146wra.29.1604596529794; 
 Thu, 05 Nov 2020 09:15:29 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id h4sm3399661wrq.3.2020.11.05.09.15.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 09:15:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 00/11] gitlab-ci: Allow forks to select & restrict
 build jobs
Date: Thu,  5 Nov 2020 18:15:15 +0100
Message-Id: <20201105171526.3763499-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 22:46:30
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 John Snow <jsnow@redhat.com>
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
Since v1:=0D
- switch from "all but skip some" to "all or select some"=0D
=0D
I tried to use a project-wide environment variable [2] to set=0D
the default set of selected features a fork is interested in,=0D
but it didn't work out well yet.=0D
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
Supersedes: <20201104224558.3384595-1-philmd@redhat.com>=0D
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
 .gitlab-ci.d/crossbuilds.yml |  77 ++++++++++++------=0D
 .gitlab-ci.yml               | 148 +++++++++++++++++++----------------=0D
 2 files changed, 136 insertions(+), 89 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


