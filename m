Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB14C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 23:58:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05947206CD
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 23:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqBRxmtm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05947206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNPVn-0006hh-V2
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 19:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <snizovtsev@gmail.com>)
 id 1kNPL5-0001dV-7d; Tue, 29 Sep 2020 19:47:19 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:40236)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <snizovtsev@gmail.com>)
 id 1kNPL3-0003Dd-8A; Tue, 29 Sep 2020 19:47:18 -0400
Received: by mail-ej1-x642.google.com with SMTP id p15so68653ejm.7;
 Tue, 29 Sep 2020 16:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:mime-version:date:message-id:subject:to:cc;
 bh=KhSGaXrogwd/Fi04sIgiySppfiPQ9ooG3Z4HZ+ITPnI=;
 b=mqBRxmtm67ioXMInTZjemci+6L/dxaP7U/eHHOx4u8PVx45jI2aGXkeTwRcw5L+wTD
 WrfxicpZFzeu2ojzrL+btYIK23QXrk0gv59lAvoRtOP3Ak51NG8txKqbyUp+4c5K2cvv
 IGkVksu45z6jSVr4xkFqtrAPb8nZI4WHG8NJPXX1J6KvK6KpnnJCPb9RwF95KgsCI5SU
 P8LRv/guuX6QYhShVVxqRmGhDZq/OysfiFOw89jvE1PmeiIstHeUEmABCMq2IIYD/fd2
 Eo7s+/YrBjNPl+rkM+LzjGpxnGSpZfHNJG1d5je45Qbbzcl6Oi2uViPCAHxwCd7dmWpf
 N8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:mime-version:date:message-id:subject:to:cc;
 bh=KhSGaXrogwd/Fi04sIgiySppfiPQ9ooG3Z4HZ+ITPnI=;
 b=h43JXERzyvQEMrvcGp2HrnXKYoTH0w5pSChoIZ34P3vt4/XFOgmBqPb85knO/vtDsH
 PEPjneW89vx1lOwaeVdOm3q4oorVWhcmdlT6/djsPYLH9uGlhqjnWph3fUpJAUOlIck4
 ufx3qzC6OkgwSSypNJiJV42zJcuCvMJtZPidg3RGm1kDn4e8NNQO/MexYDQdbnxDSzsU
 cithU92ZvLMaaVOKN10pKreGnBHH9K5i3UJy44iOlyLr0jVEd2dzInDC1qeuSsY5FF7V
 EJWd03sNgGt50sIroyGwHRkvKxRz3lC75l5WSAcCl4p+qlTWLdPx2B6IS/5aR7RVP8an
 XcBg==
X-Gm-Message-State: AOAM531a3KZnU0dxwBdk4z7Wa7ddaGXlZwWdssY2k65b8hsM0Ng822w6
 rqsJ3Ru1hb4Xp5PIwPVzihkODDBuDcoi0ngv+1/9BnEL3lkD1Q==
X-Google-Smtp-Source: ABdhPJzbtkEQEJ8RtOxDAdrNjzt8PRm+KRaHRT6zE6umW4T9ZFW74esZAFsEH45wVwHuBNasp873LHxbUtoMYB7T4pk=
X-Received: by 2002:a17:906:30cf:: with SMTP id
 b15mr60606ejb.351.1601423235078; 
 Tue, 29 Sep 2020 16:47:15 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 29 Sep 2020 16:47:14 -0700
From: Sergey Nizovtsev <snizovtsev@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Date: Tue, 29 Sep 2020 16:47:14 -0700
Message-ID: <CAHOaf96qxm6_qigD+DuoJ5GpS9rOqXe4Gv=2UnujiiwcfN0HHQ@mail.gmail.com>
Subject: [PATCH] qom: fix objects with improper parent type
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=snizovtsev@gmail.com; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Ben Warren <ben@skyportsystems.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-trivial@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Sergey Nizovtsev <snizovtsev@gmail.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some objects accidentally inherit ObjectClass instead of Object.
They compile silently but may crash after downcasting.

In this patch, we introduce a coccinelle script to find broken
declarations and fix them manually with proper base type.

Signed-off-by: Sergey Nizovtsev <snizovtsev@gmail.com>
---
 scripts/coccinelle/qobject-parent-type.cocci | 26 ++++++++++++++++++++
 include/hw/acpi/vmgenid.h                    |  2 +-
 include/hw/misc/vmcoreinfo.h                 |  2 +-
 include/net/can_host.h                       |  2 +-
 MAINTAINERS                                  |  1 +
 5 files changed, 30 insertions(+), 3 deletions(-)
 create mode 100644 scripts/coccinelle/qobject-parent-type.cocci

diff --git a/scripts/coccinelle/qobject-parent-type.cocci
b/scripts/coccinelle/qobject-parent-type.cocci
new file mode 100644
index 0000000000..9afb3edd97
--- /dev/null
+++ b/scripts/coccinelle/qobject-parent-type.cocci
@@ -0,0 +1,26 @@
+// Highlight object declarations that don't look like object class but
+// accidentally inherit from it.
+
+@match@
+identifier obj_t, fld;
+type parent_t =~ ".*Class$";
+@@
+struct obj_t {
+    parent_t fld;
+    ...
+};
+
+@script:python filter depends on match@
+obj_t << match.obj_t;
+@@
+is_class_obj = obj_t.endswith('Class')
+cocci.include_match(not is_class_obj)
+
+@replacement depends on filter@
+identifier match.obj_t, match.fld;
+type match.parent_t;
+@@
+struct obj_t {
+*   parent_t fld;
+    ...
+};
diff --git a/include/hw/acpi/vmgenid.h b/include/hw/acpi/vmgenid.h
index d50fbacb8e..cb4ad37fc5 100644
--- a/include/hw/acpi/vmgenid.h
+++ b/include/hw/acpi/vmgenid.h
@@ -19,7 +19,7 @@
 OBJECT_DECLARE_SIMPLE_TYPE(VmGenIdState, VMGENID)

 struct VmGenIdState {
-    DeviceClass parent_obj;
+    DeviceState parent_obj;
     QemuUUID guid;                /* The 128-bit GUID seen by the guest */
     uint8_t vmgenid_addr_le[8];   /* Address of the GUID (little-endian) */
 };
diff --git a/include/hw/misc/vmcoreinfo.h b/include/hw/misc/vmcoreinfo.h
index ebada6617a..0b7b55d400 100644
--- a/include/hw/misc/vmcoreinfo.h
+++ b/include/hw/misc/vmcoreinfo.h
@@ -24,7 +24,7 @@ DECLARE_INSTANCE_CHECKER(VMCoreInfoState, VMCOREINFO,
 typedef struct fw_cfg_vmcoreinfo FWCfgVMCoreInfo;

 struct VMCoreInfoState {
-    DeviceClass parent_obj;
+    DeviceState parent_obj;

     bool has_vmcoreinfo;
     FWCfgVMCoreInfo vmcoreinfo;
diff --git a/include/net/can_host.h b/include/net/can_host.h
index 4e3ce3f954..caab71bdda 100644
--- a/include/net/can_host.h
+++ b/include/net/can_host.h
@@ -35,7 +35,7 @@
 OBJECT_DECLARE_TYPE(CanHostState, CanHostClass, CAN_HOST)

 struct CanHostState {
-    ObjectClass oc;
+    Object oc;

     CanBusState *bus;
     CanBusClientState bus_client;
diff --git a/MAINTAINERS b/MAINTAINERS
index 5eed1e692b..2160b8196a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2402,6 +2402,7 @@ F: qobject/
 F: include/qapi/qmp/
 X: include/qapi/qmp/dispatch.h
 F: scripts/coccinelle/qobject.cocci
+F: scripts/coccinelle/qobject-parent-type.cocci
 F: tests/check-qdict.c
 F: tests/check-qjson.c
 F: tests/check-qlist.c
-- 
2.28.0

