Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A38C10DCE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 00:05:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E7E1205C9
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 00:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ERFlFFC4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E7E1205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDdFj-0005BT-SZ
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 20:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43139)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDd8J-0003CL-DI
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 19:57:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDd8H-0007ha-Sh
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 19:57:26 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31623
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDd8H-0007fq-PH
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 19:57:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584316645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=A5wF4UKQa6hyE13AMLkCTJSWqwYFABdzGNM1d2VU3QY=;
 b=ERFlFFC4o73mYX6rekB1h5jF7tqAv7xfjP0BqY9qSOM9K+UPCCVoCOqs8lAawEImVrEpRW
 CGvP+1ERXge73MOIK+ecYs+T2H5pMmhOkkxQDu97pIwU56O+/4nVtFeFC0KSA8T+Vbi9uH
 /i5QLv1UuqRyEqtLxmHt16/3iUkz6nk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-Q92n89wBNECs0z23gpclow-1; Sun, 15 Mar 2020 19:57:21 -0400
X-MC-Unique: Q92n89wBNECs0z23gpclow-1
Received: by mail-wr1-f69.google.com with SMTP id b12so8191297wro.4
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 16:57:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=v9H7ZHM1J1otUFCQRV2HnRwrlN+ErGeadw/66H05kJ8=;
 b=igAkKc4kkNvXJxeivKHt+6aBSsMvrkwlwfckaQ4SeLFQ5QI9YOk2ioDUYbXUcVqGMs
 MF7KOc5kPjhqiRtLcGlnzCiKqK1zrf/36qMljnYbhRR+Uh6I5GKp12DHTq4YkBfCXmaw
 xfMnZaR7h8eu2iTHXyErYQHg5P0hm8VXN4vOngUB8rhGyJ+W/Vti+vAR64qkoeAfKE16
 5R/E+fth2f415dJhwkl+aASTjH/jhtcA+GDkisA0sifFm/lva1GcOQJIqsVsF7/cb1/T
 8tx8GeZeuN45RYU92M54AD1PhG6IyZ9ARuAyWJurvu2Sfumrx0qU7Wyu1wehnZO+Pes7
 0Bqw==
X-Gm-Message-State: ANhLgQ0zx8jYt1HZ8FnqELiUE4qRcHXfK6QqLXteYJ6Ht1TaELioSqAC
 rbWbsEAStZ2YYU9k2ekO21x7i9q6a5CwRY/4uU6p1AnUSrngl20otQnPMTqxV7UWbxC5fgilFVK
 v8VRDNpMwaZp1vSo=
X-Received: by 2002:a7b:cf39:: with SMTP id m25mr23977856wmg.146.1584316640172; 
 Sun, 15 Mar 2020 16:57:20 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvOmTR4IeMGi95EQbhw+xfEVPc8gKsKJNWAvDd5kc2xUszq94/iOf60u4QuzbASa3DUffWwrw==
X-Received: by 2002:a7b:cf39:: with SMTP id m25mr23977828wmg.146.1584316639891; 
 Sun, 15 Mar 2020 16:57:19 -0700 (PDT)
Received: from localhost.localdomain (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id e7sm71252280wrt.70.2020.03.15.16.57.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2020 16:57:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/12] user-mode: Prune build dependencies (part 1)
Date: Mon, 16 Mar 2020 00:57:04 +0100
Message-Id: <20200315235716.28448-1-philmd@redhat.com>
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-s390x@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
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

Since v1:
- Addressed Laurent/Richard review comments
- Removed 'exec: Drop redundant #ifdeffery'
- Removed 'target: Restrict write_elfXX_note() handlers to system-mode'

v1: https://www.mail-archive.com/qemu-devel@nongnu.org/msg688456.html

Philippe Mathieu-Daud=C3=A9 (12):
  Makefile: Only build virtiofsd if system-mode is enabled
  configure: Avoid building TCG when not needed
  tests/Makefile: Only display TCG-related tests when TCG is available
  tests/Makefile: Restrict some softmmu-only tests
  util/Makefile: Reduce the user-mode object list
  stubs/Makefile: Reduce the user-mode object list
  target/riscv/cpu: Restrict CPU migration to system-mode
  exec: Assert CPU migration is not used on user-only build
  arch_init: Remove unused 'qapi-commands-misc.h' include
  target/i386: Restrict CpuClass::get_crash_info() to system-mode
  target/s390x: Restrict CpuClass::get_crash_info() to system-mode
  hw/core: Restrict CpuClass::get_crash_info() to system-mode

 configure              |  4 +++
 Makefile               |  2 +-
 include/hw/core/cpu.h  |  7 ++++-
 arch_init.c            |  1 -
 exec.c                 |  4 ++-
 hw/core/cpu.c          |  2 ++
 target/i386/cpu.c      |  6 ++++-
 target/riscv/cpu.c     |  6 +++--
 target/s390x/cpu.c     | 12 ++++-----
 stubs/Makefile.objs    | 52 +++++++++++++++++++++----------------
 tests/Makefile.include | 18 +++++++------
 util/Makefile.objs     | 59 +++++++++++++++++++++++++++---------------
 12 files changed, 108 insertions(+), 65 deletions(-)

--=20
2.21.1


