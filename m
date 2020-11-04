Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770DCC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 22:47:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8564207BB
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 22:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eJ6+LFqr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8564207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaRZL-0006RK-Q5
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 17:47:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaRXi-0004xY-6X
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 17:46:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23034)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaRXb-0006sj-HN
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 17:46:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604529964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=24FmUnLIzP+vDSOj2F56RQ+qN8x50NQXrQbZyJTmU88=;
 b=eJ6+LFqrfJfgwARAkzkuUesoaqjpC7iShxDZ+ogmE4eWHT01jrCPXJIu+LmQP6hbFpQWP1
 5gGbvMc7JCTUNdiyekPV2wH6Gud9YSBbn2uPaReq450dazcrYUkdBCQV3nHukxYTxPI5eV
 YfTHhIhECPap/yjcaiPPpZHks+4cu10=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-61d3l7e4ML2QXPT14SCztA-1; Wed, 04 Nov 2020 17:46:02 -0500
X-MC-Unique: 61d3l7e4ML2QXPT14SCztA-1
Received: by mail-wr1-f69.google.com with SMTP id p12so21103wrx.3
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 14:46:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=24FmUnLIzP+vDSOj2F56RQ+qN8x50NQXrQbZyJTmU88=;
 b=qaP6kGvhYPzgqQDjRf0jKEbHtSdYjUG2lT0HqDeY132apSO/tPdomTyjbY2v41aSXJ
 VOyTv0sagvm7tzWPsAL7CVCUNaRa+88ji2a8637DWEQvyOx1M4JhUF1Ieos7hokjIC4s
 /FJTmcbzhDGrP1NQPxNyWrY6MUTZflDeTaOK9kAaSG54MGGthpk3CyC8eYopN+9634bD
 OFAy4Qp6GKDqHTku3IVIf2nPDQqVQSW+f/8qY2WVbha/+/e8ifsCmvji+/zdf2ywyXJx
 use2tPqM0IzFRbr3R23tQ01PlZdd/kibwIuk1Vo7sRrp9surnyfFFaRwjFP6NTrTYpac
 h7ow==
X-Gm-Message-State: AOAM530nnbeFht+6uKBeFpg3Fc8o77tzxHgy4xXsxkhi0vegZmiiyKw1
 0jY5tq5B3tefYIIeNPvWPc1atjD6gFKJuCINE555brLrkZrkGShGxWbHgikdxiemJX//YchN3Fz
 9Tu7Cc0InUFv6k8s=
X-Received: by 2002:a5d:4103:: with SMTP id l3mr251229wrp.260.1604529960850;
 Wed, 04 Nov 2020 14:46:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzsB1CwTjAuRp9LB6ibH6rwQe9xug/tkKhYeenQuRGINZh1nANevjZEX4duQgYi4kiuFRuF2w==
X-Received: by 2002:a5d:4103:: with SMTP id l3mr251208wrp.260.1604529960648;
 Wed, 04 Nov 2020 14:46:00 -0800 (PST)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id t12sm4969439wrm.25.2020.11.04.14.45.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2020 14:45:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 0/9] gitlab-ci: Allow forks to skip some build jobs
Date: Wed,  4 Nov 2020 23:45:49 +0100
Message-Id: <20201104224558.3384595-1-philmd@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
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
 "Daniel P . Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,=0D
=0D
2 months ago GitLab added time limit to their free CI offer [1].=0D
This series provide developers with the possibility to not run=0D
all jobs. By default all jobs are started, but we can disable=0D
a subset of them.=0D
=0D
I think this should be the other way around (enable features one=0D
wants to test, with a default to the "all" keyword), but I didn't=0D
want to disrupt the current workflow.=0D
=0D
I'm not sure supporting both ("SKIP_BUILD=3D3Dall INCLUDE_BUILD=3D3Dsystem"=
)=0D
options is easy to implement, or to maintain (unlikely).=0D
=0D
In the next iteration I'll add the possibility to use a project-=0D
wide environment variable [2] to set the default set of enabled /=0D
disabled features a fork is interested in. User will still be=0D
able to overload using git-push on the command line. A friendly=0D
way to use this feature is with git aliases [3]:=0D
=0D
 $ git config alias.pushci_system \=0D
    'push -o ci.variable=3D3D"SKIP_BUILD=3D3Duser"'=0D
 $ git config alias.pushci_debian \=0D
    'push -o ci.variable=3D3D"SKIP_BUILD=3D3Dcentos,fedora,ubuntu"'=0D
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
ia=3D=0D
ble-in-the-ui=0D
[3] https://docs.gitlab.com/ee/user/project/push_options.html#useful-git-al=
ia=3D=0D
ses=0D
=0D
Philippe Mathieu-Daud=3DC3=3DA9 (9):=0D
  gitlab-ci: Replace YAML anchors by extends (cross_system_build_job)=0D
  gitlab-ci: Replace YAML anchors by extends (native_build_job)=0D
  gitlab-ci: Replace YAML anchors by extends (native_test_job)=0D
  gitlab-ci: Replace YAML anchors by extends (acceptance_test_job)=0D
  gitlab-ci: Rename acceptance_test_job -> integration_test_job=0D
  gitlab-ci: Extract common job definition as 'cross_common_job'=0D
  gitlab-ci: Extract common job definition as 'native_common_job'=0D
  gitlab-ci: Add rules to skip building cross-jobs=0D
  gitlab-ci: Add rules to skip building/testing native jobs=0D
=0D
 .gitlab-ci.d/crossbuilds.yml |  57 +++++++++++--------=0D
 .gitlab-ci.yml               | 104 +++++++++++++++++++++--------------=0D
 2 files changed, 98 insertions(+), 63 deletions(-)=0D
=0D
--=3D20=0D
2.26.2=0D
=0D


