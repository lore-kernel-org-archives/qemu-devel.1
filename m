Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3534C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 17:53:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B70A42075D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 17:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZFqZlXyV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B70A42075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv2dm-0006nO-Vz
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 13:53:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jv2ci-0005Wp-8Z
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 13:52:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22365
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jv2cf-0007R8-Qa
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 13:52:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594662733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nB/uzKuZZDiL83rkEbZGDB7cJ1ANtuAgCpQb5NzfACg=;
 b=ZFqZlXyVIxSMIf8Uh/mIL3BJfNoanUf9NdkA9iS46o2zSqiy7hiGS0VrqS4MrCHNam0VHg
 A5p3GgJzX972Fw9xQLyHleIBj1E8kUqbgWPBwVBDgUrSAx3e50/sIpKjWFwoAY6Hkf/d6+
 5hLWL5xbWVjFtE/+NLmCBl8s8/SKqyY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-N5pqc-jHM1eUFvLaE6TTHA-1; Mon, 13 Jul 2020 13:52:11 -0400
X-MC-Unique: N5pqc-jHM1eUFvLaE6TTHA-1
Received: by mail-wm1-f69.google.com with SMTP id g187so318460wme.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 10:52:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nB/uzKuZZDiL83rkEbZGDB7cJ1ANtuAgCpQb5NzfACg=;
 b=rw16p2O1otrCL10aODe2A7JkSOjO/05FWwIyTWsK/VLiacF/WiXfdZWyIzUqEz5u7Q
 jWNm9Iuw4jXgpsiBeNpxU0KIJZCjGTs1kb5K/Lq4S3mwjzbBFnuaUstFGtRT0bNpdEzc
 Kc5O3P5yepERbNRF5F1g+4wX1+Zj2a40mBAOp8KX7PGy3CyjyyXCskdwNYZZx9zlPkMA
 teYyxRRgej0okM+fLArGScZoFdhHgrWXcM8RlbvQEOO7DSQzTXWtKsyb4HL8GiATebTp
 Loc4pRWEZ5PyWDNLXJEoKaAQSpZiBkigLSTiEA25SGebcLZeBeWNM81ay3MKfFykEpby
 riRQ==
X-Gm-Message-State: AOAM532ythVsPceMhMxoeOnRRv79zH0cOuO3XEHU88YSmhHMlbomF+Me
 A+Cil55xvZsCyjP4eKTS0ZJeqMdDUxWsWJxNYAFqV2/2U0bK/NkbXev3WpZa9DwabIq1rcGxweh
 JKrQh5vFb+hH5KXk=
X-Received: by 2002:a5d:4b84:: with SMTP id b4mr606792wrt.334.1594662729652;
 Mon, 13 Jul 2020 10:52:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy3i7CYXMEjudRRHopEweLyKQtciLOLpG/Mt0bGReR2KqW7O8VM4uniPuVNgVFZ4n82n9VbkA==
X-Received: by 2002:a5d:4b84:: with SMTP id b4mr606768wrt.334.1594662729406;
 Mon, 13 Jul 2020 10:52:09 -0700 (PDT)
Received: from localhost (trasno.trasno.org. [83.165.45.250])
 by smtp.gmail.com with ESMTPSA id 59sm26487390wrj.37.2020.07.13.10.52.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 10:52:08 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/3] migration: fix memory leak in qmp_migrate_set_parameters
Date: Mon, 13 Jul 2020 19:52:04 +0200
Message-Id: <20200713175206.13659-2-quintela@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200713175206.13659-1-quintela@redhat.com>
References: <20200713175206.13659-1-quintela@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=quintela@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=quintela@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 02:19:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: HaiLiang <zhang.zhanghailiang@huawei.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Zheng Chuan <zhengchuan@huawei.com>, quintela@trasno.org,
 KeQian Zhu <zhukeqian1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Zheng Chuan <zhengchuan@huawei.com>

"tmp.tls_hostname" and "tmp.tls_creds" allocated by migrate_params_test_apply()
is forgot to free at the end of qmp_migrate_set_parameters(). Fix that.

The leak stack:
Direct leak of 2 byte(s) in 2 object(s) allocated from:
   #0 0xffffb597c20b in __interceptor_malloc (/usr/lib64/libasan.so.4+0xd320b)
   #1 0xffffb52dcb1b in g_malloc (/usr/lib64/libglib-2.0.so.0+0x58b1b)
   #2 0xffffb52f8143 in g_strdup (/usr/lib64/libglib-2.0.so.0+0x74143)
   #3 0xaaaac52447fb in migrate_params_test_apply (/usr/src/debug/qemu-4.1.0/migration/migration.c:1377)
   #4 0xaaaac52fdca7 in qmp_migrate_set_parameters (/usr/src/debug/qemu-4.1.0/qapi/qapi-commands-migration.c:192)
   #5 0xaaaac551d543 in qmp_dispatch (/usr/src/debug/qemu-4.1.0/qapi/qmp-dispatch.c:165)
   #6 0xaaaac52a0a8f in qmp_dispatch (/usr/src/debug/qemu-4.1.0/monitor/qmp.c:125)
   #7 0xaaaac52a1c7f in monitor_qmp_dispatch (/usr/src/debug/qemu-4.1.0/monitor/qmp.c:214)
   #8 0xaaaac55cb0cf in aio_bh_call (/usr/src/debug/qemu-4.1.0/util/async.c:117)
   #9 0xaaaac55d4543 in aio_bh_poll (/usr/src/debug/qemu-4.1.0/util/aio-posix.c:459)
   #10 0xaaaac55cae0f in aio_dispatch (/usr/src/debug/qemu-4.1.0/util/async.c:268)
   #11 0xffffb52d6a7b in g_main_context_dispatch (/usr/lib64/libglib-2.0.so.0+0x52a7b)
   #12 0xaaaac55d1e3b(/usr/bin/qemu-kvm-4.1.0+0x1622e3b)
   #13 0xaaaac4e314bb(/usr/bin/qemu-kvm-4.1.0+0xe824bb)
   #14 0xaaaac47f45ef(/usr/bin/qemu-kvm-4.1.0+0x8455ef)
   #15 0xffffb4bfef3f in __libc_start_main (/usr/lib64/libc.so.6+0x23f3f)
   #16 0xaaaac47ffacb(/usr/bin/qemu-kvm-4.1.0+0x850acb)

Direct leak of 2 byte(s) in 2 object(s) allocated from:
   #0 0xffffb597c20b in __interceptor_malloc (/usr/lib64/libasan.so.4+0xd320b)
   #1 0xffffb52dcb1b in g_malloc (/usr/lib64/libglib-2.0.so.0+0x58b1b)
   #2 0xffffb52f8143 in g_strdup (/usr/lib64/libglib-2.0.so.0+0x74143)
   #3 0xaaaac5244893 in migrate_params_test_apply (/usr/src/debug/qemu-4.1.0/migration/migration.c:1382)
   #4 0xaaaac52fdca7 in qmp_migrate_set_parameters (/usr/src/debug/qemu-4.1.0/qapi/qapi-commands-migration.c:192)
   #5 0xaaaac551d543 in qmp_dispatch (/usr/src/debug/qemu-4.1.0/qapi/qmp-dispatch.c)
   #6 0xaaaac52a0a8f in qmp_dispatch (/usr/src/debug/qemu-4.1.0/monitor/qmp.c:125)
   #7 0xaaaac52a1c7f in monitor_qmp_dispatch (/usr/src/debug/qemu-4.1.0/monitor/qmp.c:214)
   #8 0xaaaac55cb0cf in aio_bh_call (/usr/src/debug/qemu-4.1.0/util/async.c:117)
   #9 0xaaaac55d4543 in aio_bh_poll (/usr/src/debug/qemu-4.1.0/util/aio-posix.c:459)
   #10 0xaaaac55cae0f in in aio_dispatch (/usr/src/debug/qemu-4.1.0/util/async.c:268)
   #11 0xffffb52d6a7b in g_main_context_dispatch (/usr/lib64/libglib-2.0.so.0+0x52a7b)
   #12 0xaaaac55d1e3b(/usr/bin/qemu-kvm-4.1.0+0x1622e3b)
   #13 0xaaaac4e314bb(/usr/bin/qemu-kvm-4.1.0+0xe824bb)
   #14 0xaaaac47f45ef (/usr/bin/qemu-kvm-4.1.0+0x8455ef)
   #15 0xffffb4bfef3f in __libc_start_main (/usr/lib64/libc.so.6+0x23f3f)
   #16 0xaaaac47ffacb(/usr/bin/qemu-kvm-4.1.0+0x850acb)

Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
Reviewed-by: KeQian Zhu <zhukeqian1@huawei.com>
Reviewed-by: HaiLiang <zhang.zhanghailiang@huawei.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 4e658c397e..08519de56f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1343,12 +1343,12 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
 
     if (params->has_tls_creds) {
         assert(params->tls_creds->type == QTYPE_QSTRING);
-        dest->tls_creds = g_strdup(params->tls_creds->u.s);
+        dest->tls_creds = params->tls_creds->u.s;
     }
 
     if (params->has_tls_hostname) {
         assert(params->tls_hostname->type == QTYPE_QSTRING);
-        dest->tls_hostname = g_strdup(params->tls_hostname->u.s);
+        dest->tls_hostname = params->tls_hostname->u.s;
     }
 
     if (params->has_max_bandwidth) {
-- 
2.25.4


