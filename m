Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27911C433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:42:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE6A620725
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:42:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE6A620725
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtw6k-00040y-7f
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 12:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jtw0G-00026M-1a
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 12:36:00 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45979
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jtw0E-0000BX-IU
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 12:35:59 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-ZjBRCmJUNZ66V9EEGRMIDA-1; Fri, 10 Jul 2020 12:35:53 -0400
X-MC-Unique: ZjBRCmJUNZ66V9EEGRMIDA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD048107BEF5;
 Fri, 10 Jul 2020 16:35:51 +0000 (UTC)
Received: from bahia.redhat.com (ovpn-112-37.ams2.redhat.com [10.36.112.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 86D1574F59;
 Fri, 10 Jul 2020 16:35:50 +0000 (UTC)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 1/1] 9p: null terminate fs driver options list
Date: Fri, 10 Jul 2020 18:35:31 +0200
Message-Id: <20200710163531.526224-2-groug@kaod.org>
In-Reply-To: <20200710163531.526224-1-groug@kaod.org>
References: <20200710163531.526224-1-groug@kaod.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=groug@kaod.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=207.211.31.81; envelope-from=groug@kaod.org;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 23:35:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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
Cc: Li Qiang <liq3ea@gmail.com>, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Greg Kurz <groug@kaod.org>, Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

NULL terminate fs driver options' list, validate_opt() looks for
a null entry to terminate the loop.

Fixes: aee7f3ecd8b7 ("fsdev: Error out when unsupported option is passed")
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Message-Id: <20200709175848.650400-1-ppandit@redhat.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 fsdev/qemu-fsdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fsdev/qemu-fsdev.c b/fsdev/qemu-fsdev.c
index a9e069c0c78d..3da64e9f72b4 100644
--- a/fsdev/qemu-fsdev.c
+++ b/fsdev/qemu-fsdev.c
@@ -78,6 +78,7 @@ static FsDriverTable FsDrivers[] =3D {
             "throttling.iops-read-max-length",
             "throttling.iops-write-max-length",
             "throttling.iops-size",
+            NULL
         },
     },
     {
@@ -85,6 +86,7 @@ static FsDriverTable FsDrivers[] =3D {
         .ops =3D &synth_ops,
         .opts =3D (const char * []) {
             COMMON_FS_DRIVER_OPTIONS,
+            NULL
         },
     },
     {
@@ -95,6 +97,7 @@ static FsDriverTable FsDrivers[] =3D {
             "socket",
             "sock_fd",
             "writeout",
+            NULL
         },
     },
 };
--=20
2.26.2


