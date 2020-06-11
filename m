Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE33C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:09:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88DA7206DC
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MvWz5QYq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88DA7206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjPle-0005KN-QO
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 12:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jjPfn-0005fK-Vg
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:03:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35107
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jjPfl-0000SY-E4
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591891392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dlPfoBkgj3244PT36ks5g/rODQHPFVhSdTxZisWUE2k=;
 b=MvWz5QYqxRjdBN1uTO/bokEqzjbToSQky4KGlFeA8zWodTKLv8wxRzmjdHc13RH6wD+1GB
 L0Ux4Fk6R9UudyqJol+0r4p5aq3x4RsXG36+l0KaESo0KKGyhe2nuMWvr/1ib6dZI6TH1X
 7tNO1SCWWTQ/blJzzZ1/EUpZPGQsdBE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-AYH4h0hmO0ShgLI_ktVYfg-1; Thu, 11 Jun 2020 12:03:10 -0400
X-MC-Unique: AYH4h0hmO0ShgLI_ktVYfg-1
Received: by mail-wm1-f72.google.com with SMTP id q7so1225573wmj.9
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 09:03:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dlPfoBkgj3244PT36ks5g/rODQHPFVhSdTxZisWUE2k=;
 b=WlT28mMc4aX36bXBwijq5m7EiGg2NgZpsys5YtOp6Zsmd8ahU5CNcRNDf9djAPuPXN
 KSlKJK9U6/Pb15k6jsBis5qHc4clz1by4O9RXfu/6LrJlLf8np3sDKxU7YRe6PEDUhEi
 yQKYk0HignwupjMlO+1OLqkPG3cD7p3j3pbx0h09NOZ8IP1q3Tbn+FrKSNBp6IA2jdA1
 Z3Zd0YFt5otIiZlMynznc13y7oF4mA8gVrTCerKDSTwcK9BX3deSyxcvPsUUuISoXvtg
 ET9VwSd0MuY/8zpzbsEYpxNm99vAvtDAhvY3FKjlM3XUH436qcadTW8kdGho2puNNsz9
 TgxQ==
X-Gm-Message-State: AOAM531Yw9fHJ7/+YWcmnDDAi/bRMXUgJ0I60FzmDIKeD29LZreBdEcR
 AJzIkZEcfRJUunBEszcJK6Y4ltGbiXfMGRmOMYtHRL/s5KfulgP/B9rmVYqQyGrkQzwRHRczeIF
 fqpcb0w7CfcOj4cU=
X-Received: by 2002:a1c:6389:: with SMTP id x131mr8746872wmb.90.1591891389263; 
 Thu, 11 Jun 2020 09:03:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbv9a5Vd3rjD0fp04mKDR1/iavu5lmNT90ZBAbGMXgz1zRNePNfiN758I28J+m00lhl0XagQ==
X-Received: by 2002:a1c:6389:: with SMTP id x131mr8746850wmb.90.1591891388998; 
 Thu, 11 Jun 2020 09:03:08 -0700 (PDT)
Received: from x1w.redhat.com (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id q11sm5599429wrv.67.2020.06.11.09.03.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2020 09:03:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/11] tpm: Split hw/ vs backends/
Date: Thu, 11 Jun 2020 18:02:55 +0200
Message-Id: <20200611160306.2751-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:29:33
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
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Yesterday I started to review some vTPM patches and got very
confused by the files under hw/tpm/. In particular after
running:

  $ git grep TYPE_TPM_BACKEND
  backends/tpm.c:188:    .name = TYPE_TPM_BACKEND,
  hw/tpm/tpm_emulator.c:985:    .parent = TYPE_TPM_BACKEND,
  hw/tpm/tpm_passthrough.c:393:    .parent = TYPE_TPM_BACKEND,
  include/sysemu/tpm_backend.h:21:#define TYPE_TPM_BACKEND "tpm-backend"

As there is no particular reason to keep this mixed, clean it up.

Since v1:
- Amended docs/ changes
- Renamed Kconfig TPM_BACKEND variable
- Move backend files under backends/tpm/ (Marc-André & Stefan)
- Fix x86-64 build error (patchew)

Philippe Mathieu-Daudé (11):
  docs/specs/tpm: Correct header path name
  backends: Add TPM files into their own directory
  hw/tpm: Rename TPMDEV as TPM_BACKEND in Kconfig
  hw/tpm: Do not include 'qemu/osdep.h' in header
  hw/tpm: Include missing 'qemu/option.h' header
  hw/tpm: Move 'hw/acpi/tpm.h' inclusion from header to sources
  hw/tpm: Remove unnecessary 'tpm_int.h' header inclusion
  hw/tpm: Move few declarations from 'tpm_util.h' to 'tpm_int.h'
  hw/tpm: Move DEFINE_PROP_TPMBE() macro to 'tmp_prop.h' local header
  hw/tpm: Make 'tpm_util.h' publicly accessible as "sysemu/tpm_util.h"
  tpm: Move backend code under the 'backends/' directory

 docs/specs/tpm.rst                     | 14 +++++------
 Makefile                               |  2 +-
 Makefile.objs                          |  1 +
 {hw => backends}/tpm/tpm_int.h         | 19 +++++++++++---
 {hw => backends}/tpm/tpm_ioctl.h       |  0
 hw/tpm/tpm_ppi.h                       |  1 -
 hw/tpm/tpm_prop.h                      | 31 +++++++++++++++++++++++
 hw/tpm/tpm_tis.h                       |  1 -
 {hw/tpm => include/sysemu}/tpm_util.h  | 19 +++-----------
 backends/{tpm.c => tpm/tpm_backend.c}  |  0
 {hw => backends}/tpm/tpm_emulator.c    |  2 +-
 {hw => backends}/tpm/tpm_passthrough.c |  2 +-
 {hw => backends}/tpm/tpm_util.c        |  2 +-
 hw/tpm/tpm_crb.c                       |  4 +--
 hw/tpm/tpm_ppi.c                       |  1 +
 hw/tpm/tpm_spapr.c                     |  4 +--
 hw/tpm/tpm_tis_common.c                |  4 +--
 hw/tpm/tpm_tis_isa.c                   |  3 ++-
 hw/tpm/tpm_tis_sysbus.c                |  3 ++-
 tests/qtest/tpm-emu.c                  |  2 +-
 MAINTAINERS                            |  2 +-
 backends/Kconfig                       |  1 +
 backends/Makefile.objs                 |  2 +-
 backends/tpm/Kconfig                   | 14 +++++++++++
 backends/tpm/Makefile.objs             |  4 +++
 backends/tpm/trace-events              | 33 +++++++++++++++++++++++++
 hw/tpm/Kconfig                         | 21 +++-------------
 hw/tpm/Makefile.objs                   |  3 ---
 hw/tpm/trace-events                    | 34 +-------------------------
 29 files changed, 132 insertions(+), 97 deletions(-)
 rename {hw => backends}/tpm/tpm_int.h (81%)
 rename {hw => backends}/tpm/tpm_ioctl.h (100%)
 create mode 100644 hw/tpm/tpm_prop.h
 rename {hw/tpm => include/sysemu}/tpm_util.h (80%)
 rename backends/{tpm.c => tpm/tpm_backend.c} (100%)
 rename {hw => backends}/tpm/tpm_emulator.c (99%)
 rename {hw => backends}/tpm/tpm_passthrough.c (99%)
 rename {hw => backends}/tpm/tpm_util.c (99%)
 create mode 100644 backends/Kconfig
 create mode 100644 backends/tpm/Kconfig
 create mode 100644 backends/tpm/Makefile.objs
 create mode 100644 backends/tpm/trace-events

-- 
2.21.3


