Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27AF1C388F2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 14:44:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4F10223FB
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 14:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S58nul1a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4F10223FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZb4Y-0003g8-IG
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 09:44:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZb2v-0001yb-9n
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 09:42:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34405)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZb2s-00053e-Du
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 09:42:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604328172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YM2Fnfu4AC2/aWa6sBiYYE65XcwJew15+nCC/J3iCqg=;
 b=S58nul1aEvg45INUsVDz/Ti42MKiL419tesWbM+5f2j+tYW9/fvS4UpO4mvQ1tGvDrxBZq
 AgeczZYHfJxxwZy1q+Z9UsnDkgFFZ1h9xvylAX92izJvht5V3dZjGJUJblGS42rF13GVa3
 ZQDhzsYorhkr6v+p7xfM3CHnUgs1kOY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-TmE3hAMvMxeG5ECzWmgecw-1; Mon, 02 Nov 2020 09:42:51 -0500
X-MC-Unique: TmE3hAMvMxeG5ECzWmgecw-1
Received: by mail-wm1-f72.google.com with SMTP id 3so952901wms.9
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 06:42:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=aNXmM6CNlrG0cs+CwnOFmLA6zd4E57Qt+UkaDTpFyhA=;
 b=WcLKHw2jipzwEAI5zGNMST4a0jdgg+HBlMWXywZxs95vIMbPwi2vQanRRoF9R4hn0Y
 D8UPwfYikvLw44gs3kRqTuyIYX3wBmhXnJp0qfGyLiQNeFYZS3k8/feU37EDomfQIcno
 uv3ueekjJ9MMXiXhB+EwTw5klGnzTLgClNsre7mCI7KxevEX4GZtoCYvQT8jx1lK8NJn
 mu8Z8PWHPSSbvRm0U9fQN3NSwgDqJD2nbcNOriUnSQ2tVc6b8qtneMvYxD2KaCruAFcP
 lBlj3k8UxB274Vpx0q+JUaEi4GUvMDHbIwp//ev8qfOV3sDduFtL18yUXaqkmtX16hNi
 eJew==
X-Gm-Message-State: AOAM533Q8yNRi4UgJ4pMGtTn+v17F9sQbMr0rf4i0RiDXfpaUew1Z5hG
 /jU4m5YV9DqLax0T0RYaepfgKb5Ibbsn7JjqtT/q2eD2lewcp0wIFfNUZFdsmCa3CTypgG32GOV
 8eGT2WNrKXx/yEa4=
X-Received: by 2002:a5d:4ed2:: with SMTP id s18mr20513812wrv.36.1604328169835; 
 Mon, 02 Nov 2020 06:42:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzkvVg3qu8oyPLtuVO57fGBz+6N3wrhpwewv+h0SfVj/cHeo9MgyE8reNPaRLrksR1zTcc9fg==
X-Received: by 2002:a5d:4ed2:: with SMTP id s18mr20513787wrv.36.1604328169653; 
 Mon, 02 Nov 2020 06:42:49 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id 3sm16242448wmd.19.2020.11.02.06.42.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 06:42:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: "Daniel P . Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH-for-5.2? 0/5] tests/acceptance: Only run tests tagged
 'gating-ci' on GitLab CI
Date: Mon,  2 Nov 2020 15:42:40 +0100
Message-Id: <20201102144245.2134077-1-philmd@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 03:02:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sarah Harris <S.E.Harris@kent.ac.uk>, Michael Rolnik <mrolnik@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Fabien Chouteau <chouteau@adacore.com>, Aurelien Jarno <aurelien@aurel32.net>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 qemu-ppc@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Antony Pavlov <antonynpavlov@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series try an idea from the CI BoF last week:=0D
- allow adding all test to mainstream repository=0D
- promote test to "gating" once it is proven stable=0D
- only run 'gating-ci' on GitLab CI=0D
=0D
Philippe Mathieu-Daud=C3=A9 (5):=0D
  tests/acceptance: Restrict virtio_check_params tests to X86 target=0D
  tests/acceptance: Restore MIPS Malta multicore tests=0D
  tests/acceptance: Skip incomplete virtio_version tests using '@skip'=0D
  RFC tests/acceptance: Only run tests tagged 'gating-ci' on GitLab CI=0D
  tests/acceptance: Let stable tests use the 'gating-ci' tag=0D
=0D
 tests/Makefile.include                       |  2 +-=0D
 tests/acceptance/boot_linux.py               | 10 ++++--=0D
 tests/acceptance/boot_linux_console.py       | 38 ++++++++++++++++++++=0D
 tests/acceptance/cpu_queries.py              |  1 +=0D
 tests/acceptance/empty_cpu_model.py          |  3 ++=0D
 tests/acceptance/linux_initrd.py             |  4 +--=0D
 tests/acceptance/machine_arm_canona1100.py   |  1 +=0D
 tests/acceptance/machine_arm_integratorcp.py |  2 ++=0D
 tests/acceptance/machine_arm_n8x0.py         |  2 ++=0D
 tests/acceptance/machine_avr6.py             |  1 +=0D
 tests/acceptance/machine_m68k_nextcube.py    |  9 +++++=0D
 tests/acceptance/machine_mips_malta.py       |  6 ++--=0D
 tests/acceptance/machine_rx_gdbsim.py        |  3 --=0D
 tests/acceptance/machine_sparc64_sun4u.py    |  1 +=0D
 tests/acceptance/machine_sparc_leon3.py      |  1 +=0D
 tests/acceptance/migration.py                | 12 ++++++-=0D
 tests/acceptance/pc_cpu_hotplug_props.py     |  3 ++=0D
 tests/acceptance/ppc_prep_40p.py             |  3 +-=0D
 tests/acceptance/replay_kernel.py            | 17 +++++++--=0D
 tests/acceptance/version.py                  |  1 +=0D
 tests/acceptance/virtio_check_params.py      |  7 +++-=0D
 tests/acceptance/virtio_version.py           | 17 ++++++---=0D
 tests/acceptance/vnc.py                      |  9 +++++=0D
 tests/acceptance/x86_cpu_model_versions.py   |  1 +=0D
 24 files changed, 133 insertions(+), 21 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


