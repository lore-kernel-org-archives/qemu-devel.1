Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC52C55ABD
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 20:48:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F393A206D4
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 20:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CL7fERA1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F393A206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbrc4-0005TN-1d
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 15:48:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbrZP-00034T-03
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 15:45:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20749)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbrZJ-0000Io-CO
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 15:45:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604868343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RxbEJTR5B5WMysiDHrphxZCz9A2ItZe7MKIkvIU7hW4=;
 b=CL7fERA1pt5utnB3CC70pUroK0R8fw9RYpsqHt2s8zuv1YzwKbbz6NBlbznkPfFbBvtZs4
 +edKwDkqxj1OaRNXpEWId2fP+ZgbGllfHCcwApmaPmRVrtRLNLf96ADISiLL1lKEmJqEVN
 C2i9FlCNRg6G1Tl+12bysTMTz1HeWkU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-583-H8UtL-O7NWa7P_L9pQHEyg-1; Sun, 08 Nov 2020 15:45:40 -0500
X-MC-Unique: H8UtL-O7NWa7P_L9pQHEyg-1
Received: by mail-wr1-f71.google.com with SMTP id q1so3384008wrn.5
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 12:45:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YTTl5likalrV4jRgBXddTPjRQdmFwcFdUXBBmjRiJbI=;
 b=N2FGT/tUvRTZNJ5FT7WhGxZskh2JvjpBgllpugnV7GgaDe8kZoowg6l8LqgWp4AJjU
 XpPMGkxTLn1qxI9xbK39tI3f4DtQjMoqX4ZwmUcComU8gdd5GsE3OLrAvj7YTE+9C2Lq
 WxoDd0v9n9CG+IkoMMHpaHnGgd412mJaY2SwRDbfZoD0TY04LBYwru4M3QnUQ7dZN+CA
 jv0fjJQjDY65QwZ7VvhIuCWVix4n8rkK+5nU3vLrB4vXEXudCXI7mu0BaJIuXfPE5xXn
 oxQKOYG6YPsRrcFw3TsoYADPwgmVTjtV2sPUN5MmWeKPxIRwwco5BuuNUUSAmcKCCLII
 Uhiw==
X-Gm-Message-State: AOAM531HYlOCYVIWfQvHfTsQmPIbjN3HrqdbCItH5pP+9s0r64AcdwF8
 CBip2ECMs78kGmqwoOw5gvKcOsGkQYHk8G0mHM/AneAVVbvyYYwRioSLLlO28x2cQb9BewivvLP
 PHnD8pwbLKFUibv8=
X-Received: by 2002:adf:ed45:: with SMTP id u5mr13868994wro.48.1604868338801; 
 Sun, 08 Nov 2020 12:45:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyWx1vsRY0nVrpgOjLQb37xx9h1u0ObnfO9UEyd6ODULcq7zJxAv8dw9VvBGDKzxPjGxSk7GA==
X-Received: by 2002:adf:ed45:: with SMTP id u5mr13868971wro.48.1604868338565; 
 Sun, 08 Nov 2020 12:45:38 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id n6sm11048802wrj.60.2020.11.08.12.45.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2020 12:45:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 v4 00/17] ci: Move various jobs from Travis to GitLab
 CI
Date: Sun,  8 Nov 2020 21:45:18 +0100
Message-Id: <20201108204535.2319870-1-philmd@redhat.com>
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We have various job covered on Travis-CI, but recommend the=0D
community to use GitLab, so build failures are missed.=0D
=0D
We need help to move the jobs to GitLab (we will keep the s390x=0D
and ppc64 containerized jobs on Travis as there is no similar=0D
offer on GitLab). Start moving jobs.=0D
=0D
Resulting pipelines (96 jobs in 71 minutes and 4 seconds)=0D
  https://gitlab.com/philmd/qemu/-/pipelines/213351318=0D
  https://gitlab.com/philmd/qemu/-/pipelines/213378500=0D
=0D
Patches 1-3 are included because without them some jobs are=0D
failing; but they will be merged via different trees.=0D
=0D
Since v3:=0D
- moving various other jobs=0D
- make some jobs optional=0D
=0D
Since v2:=0D
- Run m68k qtests (Thomas)=0D
- Reworded hw/9pfs description (Greg)=0D
- Added tags=0D
=0D
Since v1:=0D
- Fix Xen+9pfs config (Paolo)=0D
- Run AVR qtests (Thomas)=0D
=0D
Based-on: <20201104115706.3101190-1-philmd@redhat.com>=0D
=0D
Philippe Mathieu-Daud=C3=A9 (16):=0D
  configure: Check vhost-user is available to build=0D
    vhost-user-blk-server=0D
  hw/i386/acpi-build: Fix maybe-uninitialized error when ACPI hotplug=0D
    off=0D
  MAINTAINERS: Add gitlab-pipeline-status script to GitLab CI section=0D
  gitlab-ci: Split CONFIGURE_ARGS one argument per line for=0D
    build-disabled=0D
  gitlab-ci: Update 'build-disabled' to cover all configurable options=0D
  gitlab-ci: Move job testing --without-default-devices across to gitlab=0D
  gitlab-ci: Move linux-user debug-tcg test across to gitlab=0D
  gitlab-ci: Move gprof/gcov test across to gitlab=0D
  gitlab-ci: Move user-static test across to gitlab=0D
  gitlab-ci: Move tools-only and softfloat tests across to gitlab=0D
  gitlab-ci: Move coroutine tests across to gitlab=0D
  tests/docker: Install lttng-ust-devel package in Fedora image=0D
  gitlab-ci: Move trace backend tests across to gitlab=0D
  gitlab-ci: Add test for Xen (on CentOS 7)=0D
  gitlab-ci: Make some ARM 32-bit jobs optional=0D
  gitlab-ci: Make MIPS user-mode 32-bit little-endian job optional=0D
=0D
Stefan Hajnoczi (1):=0D
  meson: always include contrib/libvhost-user=0D
=0D
 configure                                  |   3 +=0D
 meson.build                                |   6 +-=0D
 hw/i386/acpi-build.c                       |  45 ++--=0D
 .gitlab-ci.d/crossbuilds.yml               |   9 +=0D
 .gitlab-ci.yml                             | 228 +++++++++++++++++++--=0D
 .travis.yml                                |  78 -------=0D
 MAINTAINERS                                |   3 +-=0D
 scripts/{travis =3D> ci}/coverage-summary.sh |   2 +-=0D
 tests/docker/dockerfiles/fedora.docker     |   1 +=0D
 9 files changed, 249 insertions(+), 126 deletions(-)=0D
 rename scripts/{travis =3D> ci}/coverage-summary.sh (92%)=0D
=0D
--=20=0D
2.26.2=0D
=0D


