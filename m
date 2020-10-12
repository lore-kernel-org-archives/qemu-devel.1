Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D33C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 12:17:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B0A720757
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 12:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gx9p3BcQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B0A720757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRwm3-0005CZ-5J
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 08:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kRwjz-0003wr-4o
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 08:15:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44100)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kRwjv-0004N5-KF
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 08:15:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602504941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Y+hsLCC8trhTW5zkxm21k2wEJagIvsFiW8XPUIUWeYQ=;
 b=gx9p3BcQq0oXAqAzBfOTf2DvUN0MDm56/dNCsPVIlstAox8BE7jAYSQCY05U1Cu4XB5D1A
 u4lAx2tbCQOGaL/XUleIhmDCrJSBtMzVSs01Jebn0MCvGJpgiedVBekPLH0mKsJMrDGzPn
 IDqzUBlBVai9kdqibjSTWMP0PWTGtdk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-1-btFFnoNLGxDfUagALIaw-1; Mon, 12 Oct 2020 08:15:40 -0400
X-MC-Unique: 1-btFFnoNLGxDfUagALIaw-1
Received: by mail-wr1-f70.google.com with SMTP id f11so9210645wro.15
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 05:15:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Hx9oAa6orjAiRyrjMAlDExZ6I0zLe+yEo4wAyxHjb8c=;
 b=F3fQ6SC8G7N6JMZGRGEsxftCVGPZHmcpzZ32Ttoc1wvzBkkE/EYFpvxMOiLdUJRsnv
 HlsoUjk7phAlZctUfU7gibiliFOV/4xQUPCMIZhwiCq0mHQMc04S6easquwTzRDYCSQd
 yR5NAMMReXeLS1sqVfby9sPUabQPRyoz6bkBVTeMaecqBJjo3/CuFqtPO27HiklJSOhs
 XU+Ox5+miO0mglJ349kWDi+usphXdUiijkCXZTMcbdfBkqjXpQqX+Ijv7xJtJ2zBL5zC
 4Y6valA3LzEdHn+jnOAOSWkySEYx043pjcSNjCfgAh4yAshHUrY2JDhe+9PX1EwOR6ex
 mkyQ==
X-Gm-Message-State: AOAM532YdDdUPNf0fgtM6M7+Q3wdLjZRePD9VnEixpHe7xMhkl+3vasR
 8E4c9fW3Z75jpGEMhd/bbQSE7ijkOqehD3L02w5X2zBmg6w3uliuM+kiq0a92tuwDW94Xr19gWi
 isxeAKoqyfubATpA=
X-Received: by 2002:a7b:c309:: with SMTP id k9mr10206530wmj.125.1602504938622; 
 Mon, 12 Oct 2020 05:15:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyF32zv2YEm93720qJs+KF7aqnBOkQp7KfDYLim+HY9XtFHyQAW8RLARHOA8XJYC1a6doCT4Q==
X-Received: by 2002:a7b:c309:: with SMTP id k9mr10206514wmj.125.1602504938421; 
 Mon, 12 Oct 2020 05:15:38 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id j17sm24900598wrw.68.2020.10.12.05.15.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 05:15:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH v2 0/5] qapi: Restrict machine (and migration) specific
 commands
Date: Mon, 12 Oct 2020 14:15:31 +0200
Message-Id: <20201012121536.3381997-1-philmd@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 23:52:29
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reduce the machine code pulled into qemu-storage-daemon.=0D
=0D
The series is fully Acked, but Markus wants it reviewed=0D
by the Machine core maintainers.=0D
=0D
Since v1:=0D
- Added A-b tags=0D
- Rebased=0D
=0D
Philippe Mathieu-Daud=C3=A9 (5):=0D
  qapi: Restrict 'inject-nmi' command to machine code=0D
  qapi: Restrict 'system wakeup/reset/powerdown' commands to=0D
    machine.json=0D
  qapi: Restrict '(p)memsave' command to machine code=0D
  qapi: Restrict 'query-kvm' command to machine code=0D
  qapi: Restrict Xen migration commands to migration.json=0D
=0D
 qapi/machine.json      | 168 +++++++++++++++++++++++++++++++++=0D
 qapi/migration.json    |  41 ++++++++=0D
 qapi/misc.json         | 209 -----------------------------------------=0D
 accel/stubs/xen-stub.c |   2 +-=0D
 hw/i386/xen/xen-hvm.c  |   2 +-=0D
 migration/savevm.c     |   1 -=0D
 softmmu/cpus.c         |   1 +=0D
 ui/gtk.c               |   1 +=0D
 ui/cocoa.m             |   1 +=0D
 9 files changed, 214 insertions(+), 212 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


