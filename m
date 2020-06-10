Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05DFC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 15:56:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A99F32070B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 15:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sfmFmpRI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A99F32070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj35k-0005TI-Og
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 11:56:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jj34X-0003dN-PN
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 11:55:25 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:37556)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jj34W-0005AM-MY
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 11:55:25 -0400
Received: by mail-wm1-x332.google.com with SMTP id y20so2304512wmi.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 08:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tLxHap7xM5B8vl55s/tokESX8SHGpSJI34kzmwiZhNU=;
 b=sfmFmpRIZczBnvka/HtSZIF3jUzpWQxrunexyGqlPT/x0A18W/WP0oQkrUN4Ssrj4e
 67xM/VgP5YByPwzRk2tuxWzRT9+FLaQWeQazsWlENKvJerMlNYpsNh6NB97tCnQVEGZO
 ScOkgrXZ+hJZosdQEyRHdytgwpzvQ4HHV5lutxpMC7HUPp4SqeNOdWsXsgLoCS4Xiq95
 BJN17wvgduR7UkW44+iPhz5HFkM6LUMwHGiJWoC0jxn+6s+NBzBom0cnVKVstZyqdnXQ
 oQX5yryhzdbI77t0RkaLJGY7SE27vydyDQaBTfd4a6UM55fbTwM8hTW9uoGPAlV6drVO
 9NYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tLxHap7xM5B8vl55s/tokESX8SHGpSJI34kzmwiZhNU=;
 b=J8n4M9YDdlldFfudyIyIDUl1K//Lz+wVAzx473Xp7U4SNmogSelWNKCOu5djhdYb/s
 svhp7qxE1wB55jQSdcUPTI3ZPy9MkXec6wxhir/a9Z4NNgnJ0z+k72AaPfOwHnFBM6T9
 vSc/rSdrMTydofve8YDB+1NwJ/d7mwnoCstJASTZTupvpYXAB6NobtoKpALwpkNxflov
 WH9UhlLcJL9iYmPmCS0pVgcxST0XTz+80uf3D69w+MQWs1MVL5jIuRM0rOG2F50g1Vb0
 4P1Qoylmx9gLghMmjjVP7koLCf2siKCxb6EwcaVz3ca2k8Vz77hyPlxqQYzbYSgzoK3o
 xBxQ==
X-Gm-Message-State: AOAM530re3G35mTLNfCSoLa4VrGwEnbnwGtHJ6/Zv2qdwJIOxqb5O4Dl
 bvN6j4YERO5wXeR1P6Ice6GxKA==
X-Google-Smtp-Source: ABdhPJylBadDa7A7fRrejhAH4mqjWNEQJhdATseCHzzM846Q+mZIvs8qx4I97Slf2cyYrn5vbwfeew==
X-Received: by 2002:a05:600c:22c9:: with SMTP id
 9mr4143789wmg.68.1591804515275; 
 Wed, 10 Jun 2020 08:55:15 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f9sm342176wrf.74.2020.06.10.08.55.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2020 08:55:11 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 03F691FF87;
 Wed, 10 Jun 2020 16:55:10 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/6] iotests: 194: wait migration completion on target too
Date: Wed, 10 Jun 2020 16:55:04 +0100
Message-Id: <20200610155509.12850-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200610155509.12850-1-alex.bennee@linaro.org>
References: <20200610155509.12850-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 robert.foley@linaro.org, "open list:Block layer core" <qemu-block@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 robhenry@microsoft.com, Max Reitz <mreitz@redhat.com>,
 aaron@os.amperecomputing.com, cota@braap.org, kuhn.chenqun@huawei.com,
 peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

It is possible, that shutdown on target occurs earlier than migration
finish. In this case we crash in bdrv_release_dirty_bitmap_locked()
on assertion "assert(!bdrv_dirty_bitmap_busy(bitmap));" as we do have
busy bitmap, as bitmap migration is ongoing.

We'll fix bitmap migration to gracefully cancel on early shutdown soon.
Now let's fix iotest 194 to wait migration completion before shutdown.

Note that in this test dest_vm.shutdown() is called implicitly, as vms
used as context-providers, see __exit__() method of QEMUMachine class.

Actually, not waiting migration finish is a wrong thing, but the test
started to crash after commit ae00aa239847682
"iotests: 194: test also migration of dirty bitmap", which added dirty
bitmaps here. So, Fixes: tag won't hurt.

Fixes: ae00aa2398476824f0eca80461da215e7cdc1c3b
Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200604083341.26978-1-vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/194     | 10 ++++++++++
 tests/qemu-iotests/194.out |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/tests/qemu-iotests/194 b/tests/qemu-iotests/194
index 3fad7c6c1ab..6dc2bc94d7e 100755
--- a/tests/qemu-iotests/194
+++ b/tests/qemu-iotests/194
@@ -87,4 +87,14 @@ with iotests.FilePath('source.img') as source_img_path, \
             iotests.log(dest_vm.qmp('nbd-server-stop'))
             break
 
+    iotests.log('Wait migration completion on target...')
+    migr_events = (('MIGRATION', {'data': {'status': 'completed'}}),
+                   ('MIGRATION', {'data': {'status': 'failed'}}))
+    event = dest_vm.events_wait(migr_events)
+    iotests.log(event, filters=[iotests.filter_qmp_event])
+
+    iotests.log('Check bitmaps on source:')
     iotests.log(source_vm.qmp('query-block')['return'][0]['dirty-bitmaps'])
+
+    iotests.log('Check bitmaps on target:')
+    iotests.log(dest_vm.qmp('query-block')['return'][0]['dirty-bitmaps'])
diff --git a/tests/qemu-iotests/194.out b/tests/qemu-iotests/194.out
index dd60dcc14f1..f70cf7610e0 100644
--- a/tests/qemu-iotests/194.out
+++ b/tests/qemu-iotests/194.out
@@ -21,4 +21,9 @@ Gracefully ending the `drive-mirror` job on source...
 {"data": {"device": "mirror-job0", "len": 1073741824, "offset": 1073741824, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 Stopping the NBD server on destination...
 {"return": {}}
+Wait migration completion on target...
+{"data": {"status": "completed"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Check bitmaps on source:
+[{"busy": false, "count": 0, "granularity": 65536, "name": "bitmap0", "persistent": false, "recording": true, "status": "active"}]
+Check bitmaps on target:
 [{"busy": false, "count": 0, "granularity": 65536, "name": "bitmap0", "persistent": false, "recording": true, "status": "active"}]
-- 
2.20.1


