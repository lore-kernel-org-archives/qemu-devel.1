Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF38C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 11:59:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 250F622208
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 11:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TDUgEeoo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 250F622208
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIW5d-0006fJ-Vl
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 07:59:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kIVui-0006fq-1F
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 07:47:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29109)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kIVug-00088K-4C
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 07:47:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600256869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WWHisNxk1is5b9d8cFYEQyOm2gWnVtJm6fIUPNqikiw=;
 b=TDUgEeooS5E2VYQd2b1OuBv4xfPJU2YfKkNRZBxtlR0R3e8Vye46P4RpSSkl6xtaKLvZuH
 ntvjX7PRMZ2mmuUYM/aBU/28PoOR/RilvXBnS+5XJoGznuAwf0JbukKHY+wf8rUSTege3D
 lDZAya6g2tsSo7AVtxOJyUrF/foUgVs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-2nvZmvL_MZuZ27RO-xRqZg-1; Wed, 16 Sep 2020 07:47:43 -0400
X-MC-Unique: 2nvZmvL_MZuZ27RO-xRqZg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9C01802B4C;
 Wed, 16 Sep 2020 11:47:42 +0000 (UTC)
Received: from thuth.com (ovpn-113-19.ams2.redhat.com [10.36.113.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 843BF5DE86;
 Wed, 16 Sep 2020 11:47:41 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 05/24] Simplify the .gitignore file
Date: Wed, 16 Sep 2020 13:47:12 +0200
Message-Id: <20200916114731.102080-6-thuth@redhat.com>
In-Reply-To: <20200916114731.102080-1-thuth@redhat.com>
References: <20200916114731.102080-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:16:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
Cc: Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that we always do out-of-tree builds (and the in-tree builds are
faked via a "build" directory), we can simplify out .gitignore file
quite a bit.

Message-Id: <20200909080305.258961-1-thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .gitignore | 152 -----------------------------------------------------
 1 file changed, 152 deletions(-)

diff --git a/.gitignore b/.gitignore
index b6fdd34ddf..5515f595e6 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,163 +1,11 @@
 /GNUmakefile
 /build/
-/.doctrees
-/config-devices.*
-/config-host.*
-/config-target.*
-/config.status
-/config-temp
-/tools/virtiofsd/50-qemu-virtiofsd.json
-/elf2dmp
-/trace-events-all
-/trace/generated-events.h
-/trace/generated-events.c
-/trace/generated-helpers-wrappers.h
-/trace/generated-helpers.h
-/trace/generated-helpers.c
-/trace/generated-tcg-tracers.h
-/ui/shader/texture-blit-frag.h
-/ui/shader/texture-blit-vert.h
-/ui/shader/texture-blit-flip-vert.h
-/ui/input-keymap-*.c.inc
-*-timestamp
-/*-softmmu
-/*-darwin-user
-/*-linux-user
-/*-bsd-user
-/ivshmem-client
-/ivshmem-server
-/libdis*
-/libuser
-/linux-headers/asm
-/qga/qapi-generated
-/qapi-gen-timestamp
-/qapi/qapi-builtin-types.[ch]
-/qapi/qapi-builtin-visit.[ch]
-/qapi/qapi-commands-*.[ch]
-**/qapi/qapi-commands.[ch]
-**/qapi/qapi-emit-events.[ch]
-/qapi/qapi-events-*.[ch]
-**/qapi/qapi-events.[ch]
-**/qapi/qapi-init-commands.[ch]
-**/qapi/qapi-introspect.[ch]
-/qapi/qapi-types-*.[ch]
-**/qapi/qapi-types.[ch]
-/qapi/qapi-visit-*.[ch]
-!/qapi/qapi-visit-core.c
-**/qapi/qapi-visit.[ch]
-**/qapi/qapi-doc.texi
-/qemu-edid
-/qemu-img
-/qemu-nbd
-/qemu-options.def
-/qemu-options.texi
-/qemu-img-cmds.texi
-/qemu-img-cmds.h
-/qemu-io
-/qemu-ga
-/qemu-bridge-helper
-/qemu-keymap
-/qemu-monitor.texi
-/qemu-monitor-info.texi
-/qemu-storage-daemon
-/qemu-version.h
-/qemu-version.h.tmp
-/module_block.h
-/scsi/qemu-pr-helper
-/vhost-user-scsi
-/vhost-user-blk
-/vhost-user-gpu
-/vhost-user-input
-/fsdev/virtfs-proxy-helper
-*.tmp
-*.[1-9]
-*.a
-*.aux
-*.cp
-*.exe
-*.msi
-*.dll
-*.so
-*.fn
-*.ky
-*.log
-*.pdf
-*.pod
-*.cps
-*.fns
-*.kys
-*.pg
-*.pyc
-*.toc
-*.tp
-*.vr
-*.d
-!/.gitlab-ci.d
-!/scripts/qemu-guest-agent/fsfreeze-hook.d
-*.o
 .sdk
-*.gcda
-*.gcno
-*.gcov
-/pc-bios/bios-pq/status
-/pc-bios/edk2-*.fd
-/pc-bios/vgabios-pq/status
-/pc-bios/optionrom/linuxboot.asm
-/pc-bios/optionrom/linuxboot.bin
-/pc-bios/optionrom/linuxboot.raw
-/pc-bios/optionrom/linuxboot.img
-/pc-bios/optionrom/linuxboot_dma.asm
-/pc-bios/optionrom/linuxboot_dma.bin
-/pc-bios/optionrom/linuxboot_dma.raw
-/pc-bios/optionrom/linuxboot_dma.img
-/pc-bios/optionrom/pvh.asm
-/pc-bios/optionrom/pvh.bin
-/pc-bios/optionrom/pvh.raw
-/pc-bios/optionrom/pvh.img
-/pc-bios/optionrom/multiboot.asm
-/pc-bios/optionrom/multiboot.bin
-/pc-bios/optionrom/multiboot.raw
-/pc-bios/optionrom/multiboot.img
-/pc-bios/optionrom/kvmvapic.asm
-/pc-bios/optionrom/kvmvapic.bin
-/pc-bios/optionrom/kvmvapic.raw
-/pc-bios/optionrom/kvmvapic.img
-/pc-bios/s390-ccw/s390-ccw.elf
-/pc-bios/s390-ccw/s390-ccw.img
-/docs/built
-/docs/interop/qemu-ga-qapi.texi
-/docs/interop/qemu-ga-ref.html
-/docs/interop/qemu-ga-ref.info*
-/docs/interop/qemu-ga-ref.txt
-/docs/interop/qemu-qmp-qapi.texi
-/docs/interop/qemu-qmp-ref.html
-/docs/interop/qemu-qmp-ref.info*
-/docs/interop/qemu-qmp-ref.txt
-/docs/version.texi
-/contrib/vhost-user-gpu/50-qemu-gpu.json
-*.tps
 .stgit-*
 .git-submodule-status
 cscope.*
 tags
 TAGS
-docker-src.*
 *~
 *.ast_raw
 *.depend_raw
-trace.c
-trace-ust.h
-trace-ust.h
-trace-dtrace.h
-trace-dtrace.dtrace
-trace-root.h
-trace-root.c
-trace-ust-root.h
-trace-ust-root.h
-trace-ust-all.h
-trace-ust-all.c
-trace-dtrace-root.h
-trace-dtrace-root.dtrace
-trace-ust-all.h
-trace-ust-all.c
-/target/arm/decode-sve.c.inc
-- 
2.18.2


