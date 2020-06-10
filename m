Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4E8C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 20:04:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 969682074B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 20:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Equ33pS1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 969682074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj6xu-00057G-N3
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 16:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jj6w5-0003UT-Fj
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 16:02:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27826
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jj6w4-0000PG-Ja
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 16:02:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591819375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5K+j86GjMZEuaRrMgXDXEmyE/N0J9a1V3v2/sTANT/0=;
 b=Equ33pS1gabCXE631GXp2VEbK4HhMkdy80pN1DaNDs9ZMmI+ficktlDsEkdDfZ80ReYB92
 xHHeyB3hTRM9H32m3fjCiFlCfCW6yYflqP9xlXxwKrOipQr6kwP/q6GWlDW7r1wBiZZPW5
 qJfqfFPr1yehYcLYNZw5S36u6vgIVg4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-B0xUrR1iM-293iNiDNPBtA-1; Wed, 10 Jun 2020 16:02:51 -0400
X-MC-Unique: B0xUrR1iM-293iNiDNPBtA-1
Received: by mail-wm1-f70.google.com with SMTP id r1so731204wmh.7
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 13:02:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5K+j86GjMZEuaRrMgXDXEmyE/N0J9a1V3v2/sTANT/0=;
 b=dAnguWk49u2K3v0TABmpMSs3qw/pwBBgnZrIjNNm7m2JEKfjv7pNqprhgyaKyddvX0
 QUt2wdqZ7FuY/QWMiLPnSesiiYt2JBPFpGkb/H1BdvGKizycJE1t1pxtthMI7kgB8HHD
 FZoSH1QiJ+3oVfBvWsXuCZa22uqzCTMNwxfSeGa6/Xw0E1QxY/bGwHfM4vA4E21l8JuW
 3Ye39daPh+ELvHlbDQI3+HvlJ8GHpkiH9Lhv9kia0rpmpBYicHo14E0yqse71k9eTSZj
 n4cTr7hIZZv5AplFz+tZ9e47EasDYKhllandQwrB0KnVklQXiFjWCx+gYU1j/RLe49K0
 XfDg==
X-Gm-Message-State: AOAM533EKCXxAIwtibEj54ta90UThEFtVAK9duecBWoQVgkaGdnzyYYA
 uOQmlUs4EwgMLqbt/KafPFc+DYe0YeOSgrkvYRyMBYfGqwyEm7tiUV0lhJxxHLMbb2DLTvCzuRB
 fAZcgmaqbtNHB2II=
X-Received: by 2002:a1c:4d0a:: with SMTP id o10mr4792548wmh.150.1591819370259; 
 Wed, 10 Jun 2020 13:02:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwRUmMn3+fjzcHkfEqPwArOGmQv0Gb9qXmUHK/bXOHIkkJMFd6XgVfRZym1fH5ewMlsrb7jkw==
X-Received: by 2002:a1c:4d0a:: with SMTP id o10mr4792532wmh.150.1591819370032; 
 Wed, 10 Jun 2020 13:02:50 -0700 (PDT)
Received: from x1w.redhat.com (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id t188sm928311wmt.27.2020.06.10.13.02.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2020 13:02:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/8] tpm: Split hw/ vs backends/
Date: Wed, 10 Jun 2020 22:02:39 +0200
Message-Id: <20200610200247.21378-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 15:44:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Today I started to review some vTPM patches and got very
confused by the files under hw/tpm/. In particular after
running:

  $ git grep TYPE_TPM_BACKEND
  backends/tpm.c:188:    .name = TYPE_TPM_BACKEND,
  hw/tpm/tpm_emulator.c:985:    .parent = TYPE_TPM_BACKEND,
  hw/tpm/tpm_passthrough.c:393:    .parent = TYPE_TPM_BACKEND,
  include/sysemu/tpm_backend.h:21:#define TYPE_TPM_BACKEND "tpm-backend"

As there is no particular reason to keep this mixed, clean it up.

Philippe Mathieu-Daudé (8):
  hw/tpm: Do not include 'qemu/osdep.h' in header
  hw/tpm: Include missing 'qemu/option.h' header
  hw/tpm: Move 'hw/acpi/tpm.h' inclusion from header to sources
  hw/tpm: Remove unnecessary 'tpm_int.h' header inclusion
  hw/tpm: Move few declarations from 'tpm_util.h' to 'tpm_int.h'
  hw/tpm: Move DEFINE_PROP_TPMBE() macro to 'tmp_prop.h' local header
  hw/tpm: Make 'tpm_util.h' publicly accessible as "sysemu/tpm_util.h"
  tpm: Move backend code under the 'backends/' directory

 Makefile                               |  2 +-
 {hw/tpm => backends}/tpm_int.h         | 19 +++++++++++---
 {hw/tpm => backends}/tpm_ioctl.h       |  0
 hw/tpm/tpm_ppi.h                       |  1 -
 hw/tpm/tpm_prop.h                      | 31 +++++++++++++++++++++++
 hw/tpm/tpm_tis.h                       |  1 -
 {hw/tpm => include/sysemu}/tpm_util.h  | 19 +++-----------
 {hw/tpm => backends}/tpm_emulator.c    |  2 +-
 {hw/tpm => backends}/tpm_passthrough.c |  2 +-
 {hw/tpm => backends}/tpm_util.c        |  2 +-
 hw/tpm/tpm_crb.c                       |  4 +--
 hw/tpm/tpm_spapr.c                     |  4 +--
 hw/tpm/tpm_tis_common.c                |  4 +--
 hw/tpm/tpm_tis_isa.c                   |  3 ++-
 hw/tpm/tpm_tis_sysbus.c                |  3 ++-
 tests/qtest/tpm-emu.c                  |  2 +-
 MAINTAINERS                            |  2 +-
 backends/Kconfig                       | 14 +++++++++++
 backends/Makefile.objs                 |  3 +++
 backends/trace-events                  | 32 ++++++++++++++++++++++++
 hw/tpm/Kconfig                         | 15 ------------
 hw/tpm/Makefile.objs                   |  3 ---
 hw/tpm/trace-events                    | 34 +-------------------------
 23 files changed, 116 insertions(+), 86 deletions(-)
 rename {hw/tpm => backends}/tpm_int.h (81%)
 rename {hw/tpm => backends}/tpm_ioctl.h (100%)
 create mode 100644 hw/tpm/tpm_prop.h
 rename {hw/tpm => include/sysemu}/tpm_util.h (80%)
 rename {hw/tpm => backends}/tpm_emulator.c (99%)
 rename {hw/tpm => backends}/tpm_passthrough.c (99%)
 rename {hw/tpm => backends}/tpm_util.c (99%)
 create mode 100644 backends/Kconfig

-- 
2.21.3


