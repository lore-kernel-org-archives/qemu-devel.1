Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72917C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:31:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40168206B9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NoXcMCtX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40168206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVd4I-0006gK-3E
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 11:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVd2C-0003mB-0F
 for qemu-devel@nongnu.org; Mon, 04 May 2020 11:29:32 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37104
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVd29-0003rZ-E8
 for qemu-devel@nongnu.org; Mon, 04 May 2020 11:29:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588606168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0dDwkE6p8SsMPnxAPkn333jCRizbTYLoA4qGzMJg5yE=;
 b=NoXcMCtXsgWYcEWGC2DkT32qnSv28yVE73gRE/1h4e42AFTpIZDKcc0kR5oAzEMHHoo0Pm
 XanNDJ0D0CMXWg9Om7wJFqO94MD+3HCV2sTCEcq2EMcBX0IGdPUgJ+Dr27sExGsNBuc8ZL
 9fPIha0gz1ur0LMa4jT/FDHzj4FUUic=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-UM_GtwHbP4KQ6mOj_oQ-yQ-1; Mon, 04 May 2020 11:29:26 -0400
X-MC-Unique: UM_GtwHbP4KQ6mOj_oQ-yQ-1
Received: by mail-wm1-f69.google.com with SMTP id s12so5103912wmj.6
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 08:29:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qUA+L4wC7Y/HEYRNDubgMlJGc6s5bp4bBZMbUfsNJrk=;
 b=gIHa8e5laBIp4RDBq6sx5dl0zsZqmLzgMl6ozYg1TWngrsz6MkAKug0nFFwHF7uUBy
 SHVW/OYAIm+PiRuUTr2UUyJ8R2LECHWCaw5LdEQFNOM/VziZSwIf9lKgCxW3uVUitsri
 bLoKsf1GbD6Ft+ecufFkHI/W7ykZHUAbsNe+TczaueDijmhpI93YC+pAurEkYjoKykQ0
 9wlEkPit7kvaEVIlkC2UUh5EhA28vGgdoTKwkTuwsJfh4oMS9Z0omlxJsRPC0/mqva3c
 4bqiNp96ECLhXoUUZ+eB7GYFXZCXQKdYq4CPJjH8rFVrFdHh7zmJZ8FgLLdLA8cUpHXU
 tGlg==
X-Gm-Message-State: AGi0PuYfWJewWpnrdctRSvUp5aRD2lngC0gERCqCuUX1h6da5R4u/jRQ
 Gu0n9hVvvyuaYxmzaYgiu6b58P35xldBcKwgIMfRHGsp0jzLT+gRDOh/h0PC2Z/X/lNE6+xIWzq
 cpITTgzv7uqX8bD0=
X-Received: by 2002:a7b:c0d5:: with SMTP id s21mr15170764wmh.107.1588606165067; 
 Mon, 04 May 2020 08:29:25 -0700 (PDT)
X-Google-Smtp-Source: APiQypIq2QWQaCbGOj3Z7IwnTK7lXrQAhrMqXCntIn0TWYJZSO5HjLt49L/E9tbTZiIA8hEffVUcjw==
X-Received: by 2002:a7b:c0d5:: with SMTP id s21mr15170665wmh.107.1588606163927; 
 Mon, 04 May 2020 08:29:23 -0700 (PDT)
Received: from x1w.redhat.com (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id a13sm12076658wrv.67.2020.05.04.08.29.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 08:29:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/12] user-mode: Prune build dependencies (part 1)
Date: Mon,  4 May 2020 17:29:10 +0200
Message-Id: <20200504152922.21365-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 01:21:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is the first part of a series reducing user-mode
dependencies. By stripping out unused code, the build
and testing time is reduced (as is space used by objects).

Part 1 (generic):
- reduce user-mode object list
- remove some migration code from user-mode
- remove cpu_get_crash_info()

This series is fully reviewed.

Since v2:
- Rebased due to conflict when applying patch:
  "util/Makefile: Reduce the user-mode object list"
  because commit 01ef6b9e4e modified util/Makefile.objs:
  "linux-user: factor out reading of /proc/self/maps"

Since v1:
- Addressed Laurent/Richard review comments
- Removed 'exec: Drop redundant #ifdeffery'
- Removed 'target: Restrict write_elfXX_note() handlers to system-mode'

$ git backport-diff -u v1 -r v2
Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respecti=
vely

001/12:[----] [--] 'Makefile: Only build virtiofsd if system-mode is enable=
d'
002/12:[----] [--] 'configure: Avoid building TCG when not needed'
003/12:[----] [--] 'tests/Makefile: Only display TCG-related tests when TCG=
 is available'
004/12:[----] [--] 'tests/Makefile: Restrict some softmmu-only tests'
005/12:[----] [-C] 'util/Makefile: Reduce the user-mode object list'
006/12:[----] [--] 'stubs/Makefile: Reduce the user-mode object list'
007/12:[----] [--] 'target/riscv/cpu: Restrict CPU migration to system-mode=
'
008/12:[----] [--] 'exec: Assert CPU migration is not used on user-only bui=
ld'
009/12:[----] [--] 'arch_init: Remove unused 'qapi-commands-misc.h' include=
'
010/12:[----] [--] 'target/i386: Restrict CpuClass::get_crash_info() to sys=
tem-mode'
011/12:[----] [--] 'target/s390x: Restrict CpuClass::get_crash_info() to sy=
stem-mode'
012/12:[----] [--] 'hw/core: Restrict CpuClass::get_crash_info() to system-=
mode'

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
2.21.3


