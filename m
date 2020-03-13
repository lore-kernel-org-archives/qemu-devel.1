Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A699C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:49:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2818320650
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aeTz4+kx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2818320650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCpMw-0004GD-Ax
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 14:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35810)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jCpKi-0001iH-3K
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:46:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jCpKg-0007BW-VA
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:46:56 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40112
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jCpKg-0007B5-Qs
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:46:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584125214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZjDGFX22CortiZUqlge2N0NxEGUXl4+FNuK6/r9znhY=;
 b=aeTz4+kxCsOYft0A58Wz54U86sM+vqZaUnV/tKUEznAUzT0DlkHUmSZ/5S38YHSoZGijKb
 rVT2fleBEou/e+TRd5Hu5i50bLgpguAigNqGpAtCedGYwSnoXSHHbLIxW+jnH666WlKH5b
 uLITzMYiNfmbzKRKQkVUHXp9XHJEWn4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-WDZY-YydMTSqCqY67emnkw-1; Fri, 13 Mar 2020 14:46:52 -0400
X-MC-Unique: WDZY-YydMTSqCqY67emnkw-1
Received: by mail-wm1-f69.google.com with SMTP id n25so3306703wmi.5
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 11:46:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MzlEjNxFW1B+Pna0KCr1+SoRrDU73//S4ZgYAyodi0I=;
 b=j3ycLo/92Uqbe5R4KabAZqbzMF5a2R3MQmABQkVQZv9lisVnBL2vI3ZJUfA8P92Vj2
 6CEnLIx3YevA7SerFcRNisxXo0r+QqQxTn4m16oCiKDDHZeLtR5Sew0bIZ2k9dnGqoX0
 1g2s//EAqBv1MlIXv/VO/nLxfOX4StUv3na8s/SnLuDjai+sPhttJNq0rNRt2uzkOww6
 AzQgTVDTT4cPQpoKtGcOk/oI9Q5UQj+qY2sUvJx90wPFlfYetYcTXyil0kZQecyByk5j
 6lJWHTMw4ZBkxTsC9zXilB5p1jBJV+RjYY+Fgp3l1BrMcOrdvpKnGhsDDNrdD1FeQdlL
 Z7YQ==
X-Gm-Message-State: ANhLgQ0WrCJlTjao184Wa/tyQav0a/fmkY+xh4otJS1aFx/NNWQLQIst
 I7GB77+ehHIyCxPnIWiHGJwsTv9xiUI8eN0sg1pu91g6lKKlCYTrhxpT6rm4Sdatrry+rkslCs6
 iM9MOTnMPgY7ZGeM=
X-Received: by 2002:a05:600c:414a:: with SMTP id
 h10mr12617592wmm.53.1584125211441; 
 Fri, 13 Mar 2020 11:46:51 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvcIC8/s7jd8O3tECp2CeXvZNxiE2MgUCHjeZn3Z52bR9hHkvOIdNxLCv9hZxa0j6svSZO9Wg==
X-Received: by 2002:a05:600c:414a:: with SMTP id
 h10mr12617573wmm.53.1584125211201; 
 Fri, 13 Mar 2020 11:46:51 -0700 (PDT)
Received: from x1w.redhat.com (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id b6sm24080755wrv.43.2020.03.13.11.46.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2020 11:46:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 9/9] qapi: Restrict code generated for user-mode
Date: Fri, 13 Mar 2020 19:46:07 +0100
Message-Id: <20200313184607.11792-10-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200313184607.11792-1-philmd@redhat.com>
References: <20200313184607.11792-1-philmd@redhat.com>
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A lot of QAPI generated code is never used by user-mode.

Rewrite the QAPI_COMMON_MODULES variable one entry per line,
and split it in 3 groups:
- always used
- use by system-mode or tools
- only used by system-mode

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 qapi/Makefile.objs | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/qapi/Makefile.objs b/qapi/Makefile.objs
index 4673ab7490..18435db426 100644
--- a/qapi/Makefile.objs
+++ b/qapi/Makefile.objs
@@ -5,11 +5,40 @@ util-obj-y +=3D opts-visitor.o qapi-clone-visitor.o
 util-obj-y +=3D qmp-event.o
 util-obj-y +=3D qapi-util.o
=20
-QAPI_COMMON_MODULES =3D audio authz block-core block char common control c=
rypto
-QAPI_COMMON_MODULES +=3D dump error introspect job machine migration misc
-QAPI_COMMON_MODULES +=3D net pragma qdev qom rdma rocker run-state sockets=
 tpm
-QAPI_COMMON_MODULES +=3D trace transaction ui
+QAPI_COMMON_MODULES =3D common
+QAPI_COMMON_MODULES +=3D introspect
+QAPI_COMMON_MODULES +=3D misc
+
+ifeq ($(CONFIG_SOFTMMU),y)
+QAPI_COMMON_MODULES +=3D audio
+QAPI_COMMON_MODULES +=3D dump
+QAPI_COMMON_MODULES +=3D machine
+QAPI_COMMON_MODULES +=3D migration
+QAPI_COMMON_MODULES +=3D net rocker
+QAPI_COMMON_MODULES +=3D qdev
+QAPI_COMMON_MODULES +=3D rdma
+QAPI_COMMON_MODULES +=3D tpm
+QAPI_COMMON_MODULES +=3D trace
+QAPI_COMMON_MODULES +=3D ui
 QAPI_TARGET_MODULES =3D machine-target misc-target
+endif # CONFIG_SOFTMMU
+
+ifeq ($(call lor,$(CONFIG_SOFTMMU),$(CONFIG_TOOLS)),y)
+QAPI_COMMON_MODULES +=3D authz
+QAPI_COMMON_MODULES +=3D block
+QAPI_COMMON_MODULES +=3D block-core
+QAPI_COMMON_MODULES +=3D char
+QAPI_COMMON_MODULES +=3D control
+QAPI_COMMON_MODULES +=3D crypto
+QAPI_COMMON_MODULES +=3D error
+QAPI_COMMON_MODULES +=3D job
+QAPI_COMMON_MODULES +=3D pragma
+QAPI_COMMON_MODULES +=3D qom
+QAPI_COMMON_MODULES +=3D run-state
+QAPI_COMMON_MODULES +=3D sockets
+QAPI_COMMON_MODULES +=3D transaction
+endif # CONFIG_SOFTMMU || CONFIG_TOOLS
+
 QAPI_MODULES =3D $(QAPI_COMMON_MODULES) $(QAPI_TARGET_MODULES)
=20
 util-obj-y +=3D qapi-builtin-types.o
--=20
2.21.1


