Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D34AC43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 08:51:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C09920791
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 08:51:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C09920791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kE7Rn-0002Ly-3l
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 04:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kE7R3-0001Vx-22
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 04:51:05 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46676
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kE7R1-00073x-9t
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 04:51:04 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-pU6yU0IoPXyjMEMkUwbmSQ-1; Fri, 04 Sep 2020 04:51:01 -0400
X-MC-Unique: pU6yU0IoPXyjMEMkUwbmSQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54D1E10BBED7;
 Fri,  4 Sep 2020 08:51:00 +0000 (UTC)
Received: from linux.fritz.box (ovpn-112-114.ams2.redhat.com [10.36.112.114])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7DA955D9DC;
 Fri,  4 Sep 2020 08:50:58 +0000 (UTC)
Date: Fri, 4 Sep 2020 10:50:57 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: make -i check resut for msys2
Message-ID: <20200904085057.GB6237@linux.fritz.box>
References: <CAE2XoE_TJ2T2eN82km0pYqDiqOpsd=waH4EmCe==0k=GYpj3Xg@mail.gmail.com>
 <3d2db346-2517-f6e3-748d-79a8ae993e06@redhat.com>
 <CAE2XoE_3Kjjk+tRz1y7rk94+vre2FSfmCGQVWNgjNW14vSNSdw@mail.gmail.com>
 <48c60a95-c30b-433a-7955-3845074776d8@redhat.com>
MIME-Version: 1.0
In-Reply-To: <48c60a95-c30b-433a-7955-3845074776d8@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 03:57:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>, qemu-level <qemu-devel@nongnu.org>,
 luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 04.09.2020 um 08:03 hat Thomas Huth geschrieben:
> On 04/09/2020 00.53, 罗勇刚(Yonggang Luo) wrote:
> > 
> > 
> > On Thu, Sep 3, 2020 at 10:33 PM Thomas Huth <thuth@redhat.com
> > <mailto:thuth@redhat.com>> wrote:
> > 
> >     On 03/09/2020 11.18, 罗勇刚(Yonggang Luo) wrote:
> >     [...]
> >     >   TEST    check-unit: tests/test-replication.exe
> >     > **
> >     > ERROR:C:/work/xemu/qemu/tests/test-replication.c:136:make_temp:
> >     > assertion failed: (fd >= 0)
> >     > ERROR test-replication.exe - Bail out!
> >     > ERROR:C:/work/xemu/qemu/tests/test-replication.c:136:make_temp:
> >     > assertion failed: (fd >= 0)
> > 
> >     At least this one should be easy to fix: The test uses /tmp as
> >     hard-coded directory for temporary files. I think it should use
> >     g_get_tmp_dir() from glib to get that directory instead.
> > 
> >      Thomas
> > 
> > After fixes tmp path, how to fixes following error:
> > $ tests/test-replication.exe                                            
> >                                                                        
> >                                                                        
> >          
> > # random seed: R02Sdf2e4ffc0e6fbe96624598386b538927
> > 1..13
> > # Start of replication tests
> > # Start of primary tests
> > Unexpected error in bdrv_open_inherit() at ../block.c:3456:
> > Block protocol 'file' doesn't support the option 'locking' 
> 
> Not sure ... as a temporary test, try to remove the "locking=off"
> strings from the test. If it then works, it might be worth discussing
> with the block layer folks how to handle this test on Windows in the
> best way. If it still does not work, it's maybe simply not worth the
> effort to try to get this test running on Windows - and thus mark it
> with CONFIG_POSIX in the Makefile / meson.build.

This is a bug in file-win32. It reads "locking" from the options QDict,
but doesn't delete it from it.

Does the following help? (Only compile-tested.)

If it works for you, I'll send it as a proper patch.

Kevin

diff --git a/block/file-win32.c b/block/file-win32.c
index ab69bd811a..e2900c3a51 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -299,6 +299,11 @@ static QemuOptsList raw_runtime_opts = {
             .type = QEMU_OPT_STRING,
             .help = "host AIO implementation (threads, native)",
         },
+        {
+            .name = "locking",
+            .type = QEMU_OPT_STRING,
+            .help = "file locking mode (on/off/auto, default: auto)",
+        },
         { /* end of list */ }
     },
 };
@@ -333,6 +338,7 @@ static int raw_open(BlockDriverState *bs, QDict *options, int flags,
     Error *local_err = NULL;
     const char *filename;
     bool use_aio;
+    OnOffAuto locking;
     int ret;

     s->type = FTYPE_FILE;
@@ -343,10 +349,24 @@ static int raw_open(BlockDriverState *bs, QDict *options, int flags,
         goto fail;
     }

-    if (qdict_get_try_bool(options, "locking", false)) {
+    locking = qapi_enum_parse(&OnOffAuto_lookup,
+                              qemu_opt_get(opts, "locking"),
+                              ON_OFF_AUTO_AUTO, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        ret = -EINVAL;
+        goto fail;
+    }
+    switch (locking) {
+    case ON_OFF_AUTO_ON:
         error_setg(errp, "locking=on is not supported on Windows");
         ret = -EINVAL;
         goto fail;
+    case ON_OFF_AUTO_OFF:
+    case ON_OFF_AUTO_AUTO:
+        break;
+    default:
+        g_assert_not_reached();
     }

     filename = qemu_opt_get(opts, "filename");


