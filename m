Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6701C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:38:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84ED920749
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UUbhixuf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84ED920749
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCpCH-00018d-MW
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 14:38:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53070)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jCpB8-0007dd-0A
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:37:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jCpB6-0002FU-UB
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:37:01 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46089
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jCpB6-0002E0-Qc
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:37:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584124620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LlpMWUrtmzUqdAEMSyBsmvOkuEwO+0Reg5YUJ16z+Cc=;
 b=UUbhixufxUESgXn2O7fHUgevqCdovQrqFU9pooIXot6NXYHesJxgpBZ6goLQkNMFDeo+BS
 fnjr9SgFk3P0Hf5vOkppyyyls/18OxAFWoNMd+fjmeqtMz9+EImHKRJtWC6gIoNA825MQE
 sZzXKEzYphMafzzGM1/YkpaHArj/ejQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-6WYAFVE_N42RpWLN0TQthw-1; Fri, 13 Mar 2020 14:36:57 -0400
X-MC-Unique: 6WYAFVE_N42RpWLN0TQthw-1
Received: by mail-wm1-f69.google.com with SMTP id i16so3776061wmd.9
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 11:36:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=tT9l7cduJOEnaW27bPqDaHoIXT0dr05sJq/BTyFEpNQ=;
 b=d9WKA7dovIMgwxmpkDY47BThO/7roysKxHOl1JASg0FNk7RXJ4s7ZBPAVjVJDuXelJ
 CiWrNVavrdSU8LnN4jBF8ytjMG6jblbthmxPdLKhw6vA58+3d5POFhXy9smFBtFIGUUL
 1CnZpIT1fJ7PPJViH/St2OGM6uyTf8jNNwFQmAlk93+kk86+s5ydT7CaM5W/gXEV0AuY
 O351vg94OJwt1suW6h1a3UwnkkLll/0Nag2uMbvK5UlQ81mRoW9XSTYvrm2VjZs3KyuQ
 6PQ0SfQIen6NRDcWNWzZMJr1YETnrR4zKrBc6szulV81/b0C97UsXCaO53udiaybtqMy
 NEyw==
X-Gm-Message-State: ANhLgQ0GRot/rf92XMJHhl5y00NNXuvwY1ML6OpUs1iiWWaGZgGlyiqC
 rxDtqcJNWon3v9RZveHmhS2IRUpzR1R4ivsB1prHSXxzgjgrndUY8h0095So5QAVkxDmKnbn5YU
 zXpOyDAqEXd6CjDk=
X-Received: by 2002:adf:e883:: with SMTP id d3mr18744594wrm.75.1584124615568; 
 Fri, 13 Mar 2020 11:36:55 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vt9mytHYo/pSWgoSKjkVW0PoSDhZoUUt6iMQk5TCvXjj6f09M3be890BT+eyPIlV2DYV8WIKA==
X-Received: by 2002:adf:e883:: with SMTP id d3mr18744553wrm.75.1584124615257; 
 Fri, 13 Mar 2020 11:36:55 -0700 (PDT)
Received: from x1w.redhat.com (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id l7sm9367538wrw.33.2020.03.13.11.36.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2020 11:36:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/14] user-mode: Prune build dependencies (part 1)
Date: Fri, 13 Mar 2020 19:36:38 +0100
Message-Id: <20200313183652.10258-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is the first part of a series reducing user-mode
dependencies. By stripping out unused code, the build
and testing time is reduced (as is space used by objects).

Part 1:
- reduce user-mode object list
- remove some migration code from user-mode
- remove cpu_get_crash_info()

Philippe Mathieu-Daud=C3=A9 (14):
  Makefile: Only build virtiofsd if system-mode is enabled
  configure: Avoid building TCG when not needed
  tests/Makefile: Only display TCG-related tests when TCG is available
  tests/Makefile: Restrict some softmmu-only tests
  stubs/Makefile: Reduce the user-mode object list
  util/Makefile: Reduce the user-mode object list
  target/riscv/cpu: Restrict CPU migration to system-mode
  exec: Assert CPU migration is not used on user-only build
  exec: Drop redundant #ifdeffery
  arch_init: Remove unused 'qapi-commands-misc.h' include
  target: Restrict write_elfXX_note() handlers to system-mode
  target/i386: Restrict CpuClass::get_crash_info() to system-mode
  target/s390x: Restrict CpuClass::get_crash_info() to system-mode
  hw/core: Restrict CpuClass::get_crash_info() to system-mode

 configure                       |  4 +++
 Makefile                        |  4 +--
 include/hw/core/cpu.h           |  7 +++-
 target/arm/cpu.h                | 10 +++---
 target/i386/cpu.h               | 18 +++++-----
 target/ppc/cpu.h                |  2 --
 target/s390x/internal.h         |  3 +-
 arch_init.c                     |  1 -
 exec.c                          |  8 ++---
 hw/core/cpu.c                   |  2 ++
 target/i386/cpu.c               |  6 +++-
 target/ppc/translate_init.inc.c |  2 --
 target/riscv/cpu.c              |  6 ++--
 target/s390x/cpu.c              | 12 +++----
 stubs/Makefile.objs             | 52 +++++++++++++++++------------
 tests/Makefile.include          | 18 +++++-----
 util/Makefile.objs              | 59 +++++++++++++++++++++------------
 17 files changed, 125 insertions(+), 89 deletions(-)

--=20
2.21.1


