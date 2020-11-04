Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAD4C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 08:44:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D988208C7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 08:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h4p9yADQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D988208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaEPU-0008JN-Iz
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 03:44:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaEOO-0006et-M9
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 03:43:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40551)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaEOJ-0005tT-Cj
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 03:43:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604479417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Lj6H7keHrrdCmEBaEI0EpV0SOoKDSdfaTVVqFG1wZPg=;
 b=h4p9yADQ8atwBbKcN9jeN1dVlK8Dlx49COGW01zowDPy7Zzto/AYh+p4qTtQ1WXHKdMLPZ
 NLZl6uAYkhuR0csQAWJM42tpbub/ewa8pmGE0clJysRfkhqIgc2r2ZXMWZwDfLW4irX3l3
 qtQC5ovJwmpvkc0MuEpXb0nRnSrgrlc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-QWkXB2afMQusTVPgUJccmw-1; Wed, 04 Nov 2020 03:43:32 -0500
X-MC-Unique: QWkXB2afMQusTVPgUJccmw-1
Received: by mail-wr1-f71.google.com with SMTP id q15so8947371wrw.8
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 00:43:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=w9gCJzZaQaNCJQtwt3AWVsvFYux2gSsOpMcav8qIZ+w=;
 b=dPx70ND5DZSkschFV/qOrgDzBxfnCEfVIdPAOvWVAzFATx+9on3JI577osjwaNgKkM
 C9UwUnp9MgLG1fcb+JiN0mz6VABbFU+2fJBXg417x+thSCa6Do4qfrbWF+z3xvAcBOHn
 BvHF/oN0xyXhSujKoUSLcsLJh4MSvK1W0KLgH+wZJteHCn6j1ZbT9yh2i6o1C/VpBKDW
 4SyVdks6Oq4tJalbxgvVSJDFXy6TJ+Ip/L3Z4UipLp67mlFz9fsfcGeKkSb8UfG776gC
 zZV7xz6EXtoeyYJiU6ExIPqHraGqgXuQxlbOaSMFCzn6pWdTy4ANZpajI2ucLBmSJm7o
 Is+g==
X-Gm-Message-State: AOAM532XkTffHxIROTzUJ8QdoOWG1unXQeBxf5K5CkyZpLQO+IyJTaNj
 GGiqsSO0YGaj7m+59suD6dpEqqoNbDnXV75YzQGVZScKepJikC7TlZLmowrqmrg9idQvX8sf80Z
 PkU1PEF7WZJvzG6A=
X-Received: by 2002:a7b:c1d8:: with SMTP id a24mr176915wmj.112.1604479410814; 
 Wed, 04 Nov 2020 00:43:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzGDE+d1ToAiVdcwzYYqtDOUal9uLaSJoTWxFDeE7UhMQgAn76d6K8/DBtYkpkccrATjQZVZQ==
X-Received: by 2002:a7b:c1d8:: with SMTP id a24mr176886wmj.112.1604479410587; 
 Wed, 04 Nov 2020 00:43:30 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id v67sm1360953wma.17.2020.11.04.00.43.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2020 00:43:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 v2 0/4] ci: Move --without-default-devices job from
 Travis to GitLab
Date: Wed,  4 Nov 2020 09:43:23 +0100
Message-Id: <20201104084327.3010593-1-philmd@redhat.com>
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We have a job covering the --without-default-devices configure=0D
option on Travis-CI, but recommend the community to use GitLab,=0D
so build failures are missed.=0D
=0D
We need help to move the jobs to GitLab (we will keep the s390x=0D
and ppc64 containerized jobs on Travis as there is no similar=0D
offer on GitLab). Start with this single job.=0D
=0D
Since v1:=0D
- Fix Xen+9pfs config (Paolo)=0D
- Run AVR qtests (Thomas)=0D
=0D
Cornelia Huck (1):=0D
  s390x: fix build for --without-default-devices=0D
=0D
Philippe Mathieu-Daud=C3=A9 (3):=0D
  hw/9pfs: Fix Kconfig dependency problem between 9pfs and Xen=0D
  gitlab-ci: Add a job to cover the --without-default-devices config=0D
  travis-ci: Remove the --without-default-devices job=0D
=0D
 include/hw/s390x/s390-pci-vfio.h | 3 ++-=0D
 .gitlab-ci.yml                   | 7 +++++++=0D
 .travis.yml                      | 8 --------=0D
 hw/9pfs/Kconfig                  | 4 ----=0D
 hw/9pfs/meson.build              | 2 +-=0D
 hw/s390x/meson.build             | 2 +-=0D
 6 files changed, 11 insertions(+), 15 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


