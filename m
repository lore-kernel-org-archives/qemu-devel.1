Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89FFECE58F
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 02:32:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A563C2086A
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 02:32:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A563C2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKZ6g-0002Jr-Ee
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 22:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59366)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iKZ4S-0000kQ-5X
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 22:29:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iKZ4P-0004gx-7l
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 22:29:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38090)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iKZ4O-0004gn-Qk
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 22:29:49 -0400
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D8B14C056808
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 02:29:46 +0000 (UTC)
Received: by mail-pl1-f198.google.com with SMTP id y13so13268650plr.17
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 19:29:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ccCMDrHGxCKkgU5v5gWecIh7jisIfWw7Kr3nmse1H5I=;
 b=sbAnzyUdhqCz3Av5KJg1F5/1oMHs9hCuPh0HqF0eZlYLXrJ0K/ezY+5sVMOVmazuxy
 zH4ez3Q6wdpY4NRva7RejBf/x3HzSPgsm9kP4OK6/GOHi4BABPPfbWxR8Ra/6v9oWkgE
 becQyPij6/y0DHXAUO4/9wAQdOK/CSwkwHWI8gZxLuQ2yGiM+eIbq/aYZWr4/CT2MffW
 SUPuHSvxic6CHmVyw9wJHtXP/7XpjwrdeJtHEPJo4AU0nSfgpdes3XolqWi6QAvWE6o8
 Pvj0xw+K0fjH9i4aOLv2CtFUz6KGv8fclrf6Nh+Fm8c4Wr0x0hSMeg2PKQpkSTD8XOmz
 /FJw==
X-Gm-Message-State: APjAAAUxsZAL9aoRmVIevg6t/8yfsgrSQ9oVUG4OQE8Thm54HKDbGItp
 ULWf2x2ok9dpnKO3vg5wQYlZHqKa8c8o4Lhwr/yjRxwc4vNRr+JxYcDNfK2CXSdy6L45Cm9rZa9
 iq9Scfjp8Q7V9xJM=
X-Received: by 2002:a17:90a:d818:: with SMTP id
 a24mr2006758pjv.5.1571192985943; 
 Tue, 15 Oct 2019 19:29:45 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx8/uW8ux0NHMUREFcGLjScLdMYm7W2J9PKQT76WQjiWcb3ldQ5ke1OEkFKlwnd7F0/UALibg==
X-Received: by 2002:a17:90a:d818:: with SMTP id
 a24mr2006729pjv.5.1571192985648; 
 Tue, 15 Oct 2019 19:29:45 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id b5sm26175722pfp.38.2019.10.15.19.29.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2019 19:29:44 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/4] apic: Fix migration breakage of >255 vcpus
Date: Wed, 16 Oct 2019 10:29:29 +0800
Message-Id: <20191016022933.7276-1-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v2:
- use uint32_t rather than int64_t [Juan]
- one more patch (patch 4) to check dup SaveStateEntry [Dave]
- one more patch to define a macro (patch 1) to simplify patch 2

Please review, thanks.

Peter Xu (4):
  migration: Define VMSTATE_INSTANCE_ID_ANY
  migration: Change SaveStateEntry.instance_id into uint32_t
  apic: Use 32bit APIC ID for migration instance ID
  migration: Check in savevm_state_handler_insert for dups

 hw/arm/stellaris.c           |  2 +-
 hw/core/qdev.c               |  3 ++-
 hw/display/ads7846.c         |  2 +-
 hw/i2c/core.c                |  2 +-
 hw/input/stellaris_input.c   |  3 ++-
 hw/intc/apic_common.c        |  7 +++++--
 hw/misc/max111x.c            |  2 +-
 hw/net/eepro100.c            |  2 +-
 hw/pci/pci.c                 |  2 +-
 hw/ppc/spapr.c               |  2 +-
 hw/timer/arm_timer.c         |  2 +-
 hw/tpm/tpm_emulator.c        |  3 ++-
 include/migration/register.h |  2 +-
 include/migration/vmstate.h  |  6 ++++--
 migration/savevm.c           | 40 +++++++++++++++++++++++++-----------
 stubs/vmstate.c              |  2 +-
 16 files changed, 53 insertions(+), 29 deletions(-)

--=20
2.21.0


