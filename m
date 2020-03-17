Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DEBC2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:42:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BDC420663
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="lvrpAZDY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BDC420663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEEMP-0005jY-JR
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 11:42:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33505)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jEDxx-0003E9-1q
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:17:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jEDxt-0002eR-4W
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:17:12 -0400
Received: from mail-db3eur04on0705.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::705]:32769
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jEDxs-0002RE-NV; Tue, 17 Mar 2020 11:17:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CcbGzDvgmo4stBOG4bu8vBrLOBsHHyb1orhnCjgKg1wYFc0eKKlWXzkHM+aEtvZV9orOHXfSIcA+lHXOBt+4hvVWd4BA73bFBC7hXTv/GpYXi8R16vYItqlwWpUdu4QSvN9bmwhpmHBSXxzym6br5LMgSjBTW1d9zkwc1+POuOlqa6acHE2mWbHsdPRVNf353YbLHVSOZBOHwoRau9iNodXcUiImSwpRQFLZvoag1xARbQ+r57oOZxf1TAnUelxQEk2egJ0Zgl+w2DE2h8IarzUN/iUseM0g8W9R7SPNjNi2jMcd+ByriW5+M/PGRgflwfacNBu62N1hwNtlb41bpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XwTQjo26AZ7w0MXa3LZcBy1dibOpY9v7cdvOb/3d730=;
 b=mY6tbZaPJChnIgYPz9z2UhwqjHhPDVoDAk+iv++mOigHovD7FOF1Pqob+W80upMrhpBWcPe2Zz9CxZa34xXqe4h4PpgZ4WbkgjWP8yL/87OO+84Nwy9lUeCjle+r8sKniSI24S7h587KaG7EX9DlUKjKH71BYv/TY/kjZ+rrQZT5/CjoNeBGexUXVPAufqR5vggW0xInN3gwn7fY2rB6QYwWk/CDUg9NcgawSewG8MQ2+p1ndJNo2PicAmgEu/lizggtDS66H57OqI1ey5Yg2VRonx2DIdeVTTzDEGQx/1bHxYCnzUyskbAqw9G3VELNf+4LnpsThW5+etFlLa6Qjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XwTQjo26AZ7w0MXa3LZcBy1dibOpY9v7cdvOb/3d730=;
 b=lvrpAZDYBZ167kiV8jcQwrtjWROXyZZ9ivTnZVNADUjiKT2hX1jd0cTfKfppBI6I2Tv0ymcQD0XNob0s1lvM7lRzmVyaAp0/eBRt3zRgfsBbdD/lBxE/RaoplIs+zovAPBblRFueqZP7k5Vb/Q3emMvYKN7c4VDDj5VwCYJiSfw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from HE1PR0802MB2507.eurprd08.prod.outlook.com (10.175.35.136) by
 HE1PR0802MB2299.eurprd08.prod.outlook.com (10.172.125.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.22; Tue, 17 Mar 2020 15:17:05 +0000
Received: from HE1PR0802MB2507.eurprd08.prod.outlook.com
 ([fe80::4d32:e4e1:5b9f:240f]) by HE1PR0802MB2507.eurprd08.prod.outlook.com
 ([fe80::4d32:e4e1:5b9f:240f%12]) with mapi id 15.20.2814.021; Tue, 17 Mar
 2020 15:17:05 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 9/9] xen: introduce ERRP_AUTO_PROPAGATE
Date: Tue, 17 Mar 2020 18:16:25 +0300
Message-ID: <20200317151625.20797-10-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200317151625.20797-1-vsementsov@virtuozzo.com>
References: <20200317151625.20797-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0005.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::15) To HE1PR0802MB2507.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.248) by
 AM0PR10CA0005.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.15 via Frontend
 Transport; Tue, 17 Mar 2020 15:17:04 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.248]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4de4470-1e7f-4b80-89eb-08d7ca864084
X-MS-TrafficTypeDiagnostic: HE1PR0802MB2299:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0802MB2299D7FD8321DD923FADC5B4C1F60@HE1PR0802MB2299.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:111;
X-Forefront-PRVS: 0345CFD558
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(366004)(39850400004)(376002)(396003)(136003)(199004)(26005)(52116002)(16526019)(86362001)(8676002)(186003)(6916009)(66476007)(7416002)(66556008)(66946007)(8936002)(6666004)(81156014)(6512007)(478600001)(69590400007)(6506007)(36756003)(81166006)(54906003)(6486002)(2906002)(30864003)(316002)(2616005)(4326008)(1076003)(956004)(5660300002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:HE1PR0802MB2299;
 H:HE1PR0802MB2507.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: alCQNG+fBTQZPOOWGCgJ18uOgdw+aLj8/rID+FyBePMuqqWTShhzKXGXsZn0yyVJIPOe7rrhg/uiVhW5DbckipS0oNgUKRt7nvXIfAPCI/bSCnK2d2A59TVPOFSk9S3wYp1tl3D08AulTocmBGQdkEgviP0Q7lh+Sf49ijIn0rljGFXvFC7mpuMK7Tu+h8u5Ha5sNsLIPJzWp4zjwyAxU/Q3Y/vbsdJKJ3LhMz7Hh3JwpHhKd+TYLM1DqfOhF/DrHU0NS1Q2lZ8KI5ukaiwK4P6QfnW1B1TeDuZwttxsuD+YveCjX/sL+PopRrUv/WB9gZs8K9oo4PA6fAB5S0Ny/K1qBvLuYyj7VcueaYveyd8iTTg3SLZC/OVLfFbbj2p9EKKEv4JvQGkY+SKUhW03jUCjTVms6YRpOZ5KvivP0ZZF6KisKPv98uBrxGoQn1ShZoRLc3VoJDRMZul3sb/qdUroyGCHUljymqGMdeKp8OQo8Dhv/3ok37m40ZbihMRS
X-MS-Exchange-AntiSpam-MessageData: PtT3V71taMn8mpJsqKU/KLjBWm8Bm8735QN190FFdtlYaPf/jQta2Bo46SH1hJLRjCxDPHoiBUe3uHXVIhLipmcsE8F0x94cOA/kuTW9NzyszuyDIRRJtLGWnDvXm7SZldJ74R7Orx0AFsqaAsfQ+g==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4de4470-1e7f-4b80-89eb-08d7ca864084
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 15:17:05.6259 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7EMKphGNm8R9ervG41b3mqdED0J9ff4UHsZwsHOI8FoqXGIHWjuWEx/Sd8EKmCvROOIGfXENjR0hTP9Rt7ma6DIfW8o0oGD3ntOqTKk7KpI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2299
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0c::705
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org, Paul Durrant <paul@xen.org>, armbru@redhat.com,
 Greg Kurz <groug@kaod.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If we want to add some info to errp (by error_prepend() or
error_append_hint()), we must use the ERRP_AUTO_PROPAGATE macro.
Otherwise, this info will not be added when errp =3D=3D &error_fatal
(the program will exit prior to the error_append_hint() or
error_prepend() call).  Fix such cases.

If we want to check error after errp-function call, we need to
introduce local_err and then propagate it to errp. Instead, use
ERRP_AUTO_PROPAGATE macro, benefits are:
1. No need of explicit error_propagate call
2. No need of explicit local_err variable: use errp directly
3. ERRP_AUTO_PROPAGATE leaves errp as is if it's not NULL or
   &error_fatal, this means that we don't break error_abort
   (we'll abort on error_set, not on error_propagate)

This commit is generated by command

    sed -n '/^X86 Xen CPUs$/,/^$/{s/^F: //p}' MAINTAINERS | \
    xargs git ls-files | grep '\.[hc]$' | \
    xargs spatch \
        --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
        --macro-file scripts/cocci-macro-file.h \
        --in-place --no-show-diff --max-width 80

Reported-by: Kevin Wolf <kwolf@redhat.com>
Reported-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Paul Durrant <paul@xen.org>
---
 hw/block/dataplane/xen-block.c |  17 ++---
 hw/block/xen-block.c           | 122 ++++++++++++++-------------------
 hw/pci-host/xen_igd_pt.c       |   7 +-
 hw/xen/xen-backend.c           |   7 +-
 hw/xen/xen-bus.c               |  92 +++++++++++--------------
 hw/xen/xen-host-pci-device.c   |  27 ++++----
 hw/xen/xen_pt.c                |  25 +++----
 hw/xen/xen_pt_config_init.c    |  20 +++---
 8 files changed, 138 insertions(+), 179 deletions(-)

diff --git a/hw/block/dataplane/xen-block.c b/hw/block/dataplane/xen-block.=
c
index 288a87a814..3a8469fe87 100644
--- a/hw/block/dataplane/xen-block.c
+++ b/hw/block/dataplane/xen-block.c
@@ -739,8 +739,8 @@ void xen_block_dataplane_start(XenBlockDataPlane *datap=
lane,
                                unsigned int protocol,
                                Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     XenDevice *xendev =3D dataplane->xendev;
-    Error *local_err =3D NULL;
     unsigned int ring_size;
     unsigned int i;
=20
@@ -776,9 +776,8 @@ void xen_block_dataplane_start(XenBlockDataPlane *datap=
lane,
     }
=20
     xen_device_set_max_grant_refs(xendev, dataplane->nr_ring_ref,
-                                  &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+                                  errp);
+    if (*errp) {
         goto stop;
     }
=20
@@ -786,9 +785,8 @@ void xen_block_dataplane_start(XenBlockDataPlane *datap=
lane,
                                               dataplane->ring_ref,
                                               dataplane->nr_ring_ref,
                                               PROT_READ | PROT_WRITE,
-                                              &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+                                              errp);
+    if (*errp) {
         goto stop;
     }
=20
@@ -821,9 +819,8 @@ void xen_block_dataplane_start(XenBlockDataPlane *datap=
lane,
     dataplane->event_channel =3D
         xen_device_bind_event_channel(xendev, event_channel,
                                       xen_block_dataplane_event, dataplane=
,
-                                      &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+                                      errp);
+    if (*errp) {
         goto stop;
     }
=20
diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index 7b3b6dee97..5d4c94181c 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -195,6 +195,7 @@ static const BlockDevOps xen_block_dev_ops =3D {
=20
 static void xen_block_realize(XenDevice *xendev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     XenBlockDevice *blockdev =3D XEN_BLOCK_DEVICE(xendev);
     XenBlockDeviceClass *blockdev_class =3D
         XEN_BLOCK_DEVICE_GET_CLASS(xendev);
@@ -202,7 +203,6 @@ static void xen_block_realize(XenDevice *xendev, Error =
**errp)
     XenBlockVdev *vdev =3D &blockdev->props.vdev;
     BlockConf *conf =3D &blockdev->props.conf;
     BlockBackend *blk =3D conf->blk;
-    Error *local_err =3D NULL;
=20
     if (vdev->type =3D=3D XEN_BLOCK_VDEV_TYPE_INVALID) {
         error_setg(errp, "vdev property not set");
@@ -212,9 +212,8 @@ static void xen_block_realize(XenDevice *xendev, Error =
**errp)
     trace_xen_block_realize(type, vdev->disk, vdev->partition);
=20
     if (blockdev_class->realize) {
-        blockdev_class->realize(blockdev, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        blockdev_class->realize(blockdev, errp);
+        if (*errp) {
             return;
         }
     }
@@ -284,8 +283,8 @@ static void xen_block_frontend_changed(XenDevice *xende=
v,
                                        enum xenbus_state frontend_state,
                                        Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     enum xenbus_state backend_state =3D xen_device_backend_get_state(xende=
v);
-    Error *local_err =3D NULL;
=20
     switch (frontend_state) {
     case XenbusStateInitialised:
@@ -294,15 +293,13 @@ static void xen_block_frontend_changed(XenDevice *xen=
dev,
             break;
         }
=20
-        xen_block_disconnect(xendev, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        xen_block_disconnect(xendev, errp);
+        if (*errp) {
             break;
         }
=20
-        xen_block_connect(xendev, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        xen_block_connect(xendev, errp);
+        if (*errp) {
             break;
         }
=20
@@ -315,9 +312,8 @@ static void xen_block_frontend_changed(XenDevice *xende=
v,
=20
     case XenbusStateClosed:
     case XenbusStateUnknown:
-        xen_block_disconnect(xendev, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        xen_block_disconnect(xendev, errp);
+        if (*errp) {
             break;
         }
=20
@@ -404,10 +400,10 @@ static int vbd_name_to_disk(const char *name, const c=
har **endp,
 static void xen_block_set_vdev(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     DeviceState *dev =3D DEVICE(obj);
     Property *prop =3D opaque;
     XenBlockVdev *vdev =3D qdev_get_prop_ptr(dev, prop);
-    Error *local_err =3D NULL;
     char *str, *p;
     const char *end;
=20
@@ -416,9 +412,8 @@ static void xen_block_set_vdev(Object *obj, Visitor *v,=
 const char *name,
         return;
     }
=20
-    visit_type_str(v, name, &str, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    visit_type_str(v, name, &str, errp);
+    if (*errp) {
         return;
     }
=20
@@ -672,9 +667,9 @@ static void xen_block_blockdev_del(const char *node_nam=
e, Error **errp)
 static char *xen_block_blockdev_add(const char *id, QDict *qdict,
                                     Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     const char *driver =3D qdict_get_try_str(qdict, "driver");
     BlockdevOptions *options =3D NULL;
-    Error *local_err =3D NULL;
     char *node_name;
     Visitor *v;
=20
@@ -689,18 +684,16 @@ static char *xen_block_blockdev_add(const char *id, Q=
Dict *qdict,
     trace_xen_block_blockdev_add(node_name);
=20
     v =3D qobject_input_visitor_new(QOBJECT(qdict));
-    visit_type_BlockdevOptions(v, NULL, &options, &local_err);
+    visit_type_BlockdevOptions(v, NULL, &options, errp);
     visit_free(v);
=20
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (*errp) {
         goto fail;
     }
=20
-    qmp_blockdev_add(options, &local_err);
+    qmp_blockdev_add(options, errp);
=20
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (*errp) {
         goto fail;
     }
=20
@@ -719,14 +712,12 @@ fail:
=20
 static void xen_block_drive_destroy(XenBlockDrive *drive, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     char *node_name =3D drive->node_name;
=20
     if (node_name) {
-        Error *local_err =3D NULL;
-
-        xen_block_blockdev_del(node_name, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        xen_block_blockdev_del(node_name, errp);
+        if (*errp) {
             return;
         }
         g_free(node_name);
@@ -740,6 +731,7 @@ static XenBlockDrive *xen_block_drive_create(const char=
 *id,
                                              const char *device_type,
                                              QDict *opts, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     const char *params =3D qdict_get_try_str(opts, "params");
     const char *mode =3D qdict_get_try_str(opts, "mode");
     const char *direct_io_safe =3D qdict_get_try_str(opts, "direct-io-safe=
");
@@ -747,7 +739,6 @@ static XenBlockDrive *xen_block_drive_create(const char=
 *id,
     char *driver =3D NULL;
     char *filename =3D NULL;
     XenBlockDrive *drive =3D NULL;
-    Error *local_err =3D NULL;
     QDict *file_layer;
     QDict *driver_layer;
=20
@@ -826,13 +817,12 @@ static XenBlockDrive *xen_block_drive_create(const ch=
ar *id,
=20
     g_assert(!drive->node_name);
     drive->node_name =3D xen_block_blockdev_add(drive->id, driver_layer,
-                                              &local_err);
+                                              errp);
=20
     qobject_unref(driver_layer);
=20
 done:
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (*errp) {
         xen_block_drive_destroy(drive, NULL);
         return NULL;
     }
@@ -857,8 +847,8 @@ static void xen_block_iothread_destroy(XenBlockIOThread=
 *iothread,
 static XenBlockIOThread *xen_block_iothread_create(const char *id,
                                                    Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     XenBlockIOThread *iothread =3D g_new(XenBlockIOThread, 1);
-    Error *local_err =3D NULL;
     QDict *opts;
     QObject *ret_data;
=20
@@ -867,13 +857,11 @@ static XenBlockIOThread *xen_block_iothread_create(co=
nst char *id,
     opts =3D qdict_new();
     qdict_put_str(opts, "qom-type", TYPE_IOTHREAD);
     qdict_put_str(opts, "id", id);
-    qmp_object_add(opts, &ret_data, &local_err);
+    qmp_object_add(opts, &ret_data, errp);
     qobject_unref(opts);
     qobject_unref(ret_data);
=20
-    if (local_err) {
-        error_propagate(errp, local_err);
-
+    if (*errp) {
         g_free(iothread->id);
         g_free(iothread);
         return NULL;
@@ -885,6 +873,7 @@ static XenBlockIOThread *xen_block_iothread_create(cons=
t char *id,
 static void xen_block_device_create(XenBackendInstance *backend,
                                     QDict *opts, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     XenBus *xenbus =3D xen_backend_get_bus(backend);
     const char *name =3D xen_backend_get_name(backend);
     unsigned long number;
@@ -892,7 +881,6 @@ static void xen_block_device_create(XenBackendInstance =
*backend,
     XenBlockDrive *drive =3D NULL;
     XenBlockIOThread *iothread =3D NULL;
     XenDevice *xendev =3D NULL;
-    Error *local_err =3D NULL;
     const char *type;
     XenBlockDevice *blockdev;
=20
@@ -924,52 +912,48 @@ static void xen_block_device_create(XenBackendInstanc=
e *backend,
         goto fail;
     }
=20
-    drive =3D xen_block_drive_create(vdev, device_type, opts, &local_err);
+    drive =3D xen_block_drive_create(vdev, device_type, opts, errp);
     if (!drive) {
-        error_propagate_prepend(errp, local_err, "failed to create drive: =
");
+        error_prepend(errp, "failed to create drive: ");
         goto fail;
     }
=20
-    iothread =3D xen_block_iothread_create(vdev, &local_err);
-    if (local_err) {
-        error_propagate_prepend(errp, local_err,
-                                "failed to create iothread: ");
+    iothread =3D xen_block_iothread_create(vdev, errp);
+    if (*errp) {
+        error_prepend(errp, "failed to create iothread: ");
         goto fail;
     }
=20
     xendev =3D XEN_DEVICE(qdev_create(BUS(xenbus), type));
     blockdev =3D XEN_BLOCK_DEVICE(xendev);
=20
-    object_property_set_str(OBJECT(xendev), vdev, "vdev", &local_err);
-    if (local_err) {
-        error_propagate_prepend(errp, local_err, "failed to set 'vdev': ")=
;
+    object_property_set_str(OBJECT(xendev), vdev, "vdev", errp);
+    if (*errp) {
+        error_prepend(errp, "failed to set 'vdev': ");
         goto fail;
     }
=20
     object_property_set_str(OBJECT(xendev),
                             xen_block_drive_get_node_name(drive), "drive",
-                            &local_err);
-    if (local_err) {
-        error_propagate_prepend(errp, local_err, "failed to set 'drive': "=
);
+                            errp);
+    if (*errp) {
+        error_prepend(errp, "failed to set 'drive': ");
         goto fail;
     }
=20
     object_property_set_str(OBJECT(xendev), iothread->id, "iothread",
-                            &local_err);
-    if (local_err) {
-        error_propagate_prepend(errp, local_err,
-                                "failed to set 'iothread': ");
+                            errp);
+    if (*errp) {
+        error_prepend(errp, "failed to set 'iothread': ");
         goto fail;
     }
=20
     blockdev->iothread =3D iothread;
     blockdev->drive =3D drive;
=20
-    object_property_set_bool(OBJECT(xendev), true, "realized", &local_err)=
;
-    if (local_err) {
-        error_propagate_prepend(errp, local_err,
-                                "realization of device %s failed: ",
-                                type);
+    object_property_set_bool(OBJECT(xendev), true, "realized", errp);
+    if (*errp) {
+        error_prepend(errp, "realization of device %s failed: ", type);
         goto fail;
     }
=20
@@ -993,31 +977,29 @@ fail:
 static void xen_block_device_destroy(XenBackendInstance *backend,
                                      Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     XenDevice *xendev =3D xen_backend_get_device(backend);
     XenBlockDevice *blockdev =3D XEN_BLOCK_DEVICE(xendev);
     XenBlockVdev *vdev =3D &blockdev->props.vdev;
     XenBlockDrive *drive =3D blockdev->drive;
     XenBlockIOThread *iothread =3D blockdev->iothread;
-    Error *local_err =3D NULL;
=20
     trace_xen_block_device_destroy(vdev->number);
=20
     object_unparent(OBJECT(xendev));
=20
     if (iothread) {
-        xen_block_iothread_destroy(iothread, &local_err);
-        if (local_err) {
-            error_propagate_prepend(errp, local_err,
-                                "failed to destroy iothread: ");
+        xen_block_iothread_destroy(iothread, errp);
+        if (*errp) {
+            error_prepend(errp, "failed to destroy iothread: ");
             return;
         }
     }
=20
     if (drive) {
-        xen_block_drive_destroy(drive, &local_err);
-        if (local_err) {
-            error_propagate_prepend(errp, local_err,
-                                "failed to destroy drive: ");
+        xen_block_drive_destroy(drive, errp);
+        if (*errp) {
+            error_prepend(errp, "failed to destroy drive: ");
         }
     }
 }
diff --git a/hw/pci-host/xen_igd_pt.c b/hw/pci-host/xen_igd_pt.c
index efcc9347ff..29ade9ca25 100644
--- a/hw/pci-host/xen_igd_pt.c
+++ b/hw/pci-host/xen_igd_pt.c
@@ -79,17 +79,16 @@ static void host_pci_config_read(int pos, int len, uint=
32_t *val, Error **errp)
=20
 static void igd_pt_i440fx_realize(PCIDevice *pci_dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     uint32_t val =3D 0;
     size_t i;
     int pos, len;
-    Error *local_err =3D NULL;
=20
     for (i =3D 0; i < ARRAY_SIZE(igd_host_bridge_infos); i++) {
         pos =3D igd_host_bridge_infos[i].offset;
         len =3D igd_host_bridge_infos[i].len;
-        host_pci_config_read(pos, len, &val, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        host_pci_config_read(pos, len, &val, errp);
+        if (*errp) {
             return;
         }
         pci_default_write_config(pci_dev, pos, val, len);
diff --git a/hw/xen/xen-backend.c b/hw/xen/xen-backend.c
index da065f81b7..1cc0694053 100644
--- a/hw/xen/xen-backend.c
+++ b/hw/xen/xen-backend.c
@@ -98,9 +98,9 @@ static void xen_backend_list_remove(XenBackendInstance *b=
ackend)
 void xen_backend_device_create(XenBus *xenbus, const char *type,
                                const char *name, QDict *opts, Error **errp=
)
 {
+    ERRP_AUTO_PROPAGATE();
     const XenBackendImpl *impl =3D xen_backend_table_lookup(type);
     XenBackendInstance *backend;
-    Error *local_error =3D NULL;
=20
     if (!impl) {
         return;
@@ -110,9 +110,8 @@ void xen_backend_device_create(XenBus *xenbus, const ch=
ar *type,
     backend->xenbus =3D xenbus;
     backend->name =3D g_strdup(name);
=20
-    impl->create(backend, opts, &local_error);
-    if (local_error) {
-        error_propagate(errp, local_error);
+    impl->create(backend, opts, errp);
+    if (*errp) {
         g_free(backend->name);
         g_free(backend);
         return;
diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index 18237b34ea..97259c964b 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -53,9 +53,9 @@ static char *xen_device_get_frontend_path(XenDevice *xend=
ev)
=20
 static void xen_device_unplug(XenDevice *xendev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     XenBus *xenbus =3D XEN_BUS(qdev_get_parent_bus(DEVICE(xendev)));
     const char *type =3D object_get_typename(OBJECT(xendev));
-    Error *local_err =3D NULL;
     xs_transaction_t tid;
=20
     trace_xen_device_unplug(type, xendev->name);
@@ -69,14 +69,14 @@ again:
     }
=20
     xs_node_printf(xenbus->xsh, tid, xendev->backend_path, "online",
-                   &local_err, "%u", 0);
-    if (local_err) {
+                   errp, "%u", 0);
+    if (*errp) {
         goto abort;
     }
=20
     xs_node_printf(xenbus->xsh, tid, xendev->backend_path, "state",
-                   &local_err, "%u", XenbusStateClosing);
-    if (local_err) {
+                   errp, "%u", XenbusStateClosing);
+    if (*errp) {
         goto abort;
     }
=20
@@ -96,7 +96,6 @@ abort:
      * from ending the transaction.
      */
     xs_transaction_end(xenbus->xsh, tid, true);
-    error_propagate(errp, local_err);
 }
=20
 static void xen_bus_print_dev(Monitor *mon, DeviceState *dev, int indent)
@@ -205,15 +204,13 @@ static XenWatch *watch_list_add(XenWatchList *watch_l=
ist, const char *node,
                                 const char *key, XenWatchHandler handler,
                                 void *opaque, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     XenWatch *watch =3D new_watch(node, key, handler, opaque);
-    Error *local_err =3D NULL;
=20
     notifier_list_add(&watch_list->notifiers, &watch->notifier);
=20
-    xs_node_watch(watch_list->xsh, node, key, watch->token, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-
+    xs_node_watch(watch_list->xsh, node, key, watch->token, errp);
+    if (*errp) {
         notifier_remove(&watch->notifier);
         free_watch(watch);
=20
@@ -255,11 +252,11 @@ static void xen_bus_backend_create(XenBus *xenbus, co=
nst char *type,
                                    const char *name, char *path,
                                    Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     xs_transaction_t tid;
     char **key;
     QDict *opts;
     unsigned int i, n;
-    Error *local_err =3D NULL;
=20
     trace_xen_bus_backend_create(type, path);
=20
@@ -314,13 +311,11 @@ again:
         return;
     }
=20
-    xen_backend_device_create(xenbus, type, name, opts, &local_err);
+    xen_backend_device_create(xenbus, type, name, opts, errp);
     qobject_unref(opts);
=20
-    if (local_err) {
-        error_propagate_prepend(errp, local_err,
-                                "failed to create '%s' device '%s': ",
-                                type, name);
+    if (*errp) {
+        error_prepend(errp, "failed to create '%s' device '%s': ", type, n=
ame);
     }
 }
=20
@@ -692,9 +687,9 @@ static void xen_device_remove_watch(XenDevice *xendev, =
XenWatch *watch,
=20
 static void xen_device_backend_create(XenDevice *xendev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     XenBus *xenbus =3D XEN_BUS(qdev_get_parent_bus(DEVICE(xendev)));
     struct xs_permissions perms[2];
-    Error *local_err =3D NULL;
=20
     xendev->backend_path =3D xen_device_get_backend_path(xendev);
=20
@@ -706,30 +701,27 @@ static void xen_device_backend_create(XenDevice *xend=
ev, Error **errp)
     g_assert(xenbus->xsh);
=20
     xs_node_create(xenbus->xsh, XBT_NULL, xendev->backend_path, perms,
-                   ARRAY_SIZE(perms), &local_err);
-    if (local_err) {
-        error_propagate_prepend(errp, local_err,
-                                "failed to create backend: ");
+                   ARRAY_SIZE(perms), errp);
+    if (*errp) {
+        error_prepend(errp, "failed to create backend: ");
         return;
     }
=20
     xendev->backend_state_watch =3D
         xen_device_add_watch(xendev, xendev->backend_path,
                              "state", xen_device_backend_changed,
-                             &local_err);
-    if (local_err) {
-        error_propagate_prepend(errp, local_err,
-                                "failed to watch backend state: ");
+                             errp);
+    if (*errp) {
+        error_prepend(errp, "failed to watch backend state: ");
         return;
     }
=20
     xendev->backend_online_watch =3D
         xen_device_add_watch(xendev, xendev->backend_path,
                              "online", xen_device_backend_changed,
-                             &local_err);
-    if (local_err) {
-        error_propagate_prepend(errp, local_err,
-                                "failed to watch backend online: ");
+                             errp);
+    if (*errp) {
+        error_prepend(errp, "failed to watch backend online: ");
         return;
     }
 }
@@ -866,9 +858,9 @@ static bool xen_device_frontend_exists(XenDevice *xende=
v)
=20
 static void xen_device_frontend_create(XenDevice *xendev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     XenBus *xenbus =3D XEN_BUS(qdev_get_parent_bus(DEVICE(xendev)));
     struct xs_permissions perms[2];
-    Error *local_err =3D NULL;
=20
     xendev->frontend_path =3D xen_device_get_frontend_path(xendev);
=20
@@ -885,20 +877,18 @@ static void xen_device_frontend_create(XenDevice *xen=
dev, Error **errp)
         g_assert(xenbus->xsh);
=20
         xs_node_create(xenbus->xsh, XBT_NULL, xendev->frontend_path, perms=
,
-                       ARRAY_SIZE(perms), &local_err);
-        if (local_err) {
-            error_propagate_prepend(errp, local_err,
-                                    "failed to create frontend: ");
+                       ARRAY_SIZE(perms), errp);
+        if (*errp) {
+            error_prepend(errp, "failed to create frontend: ");
             return;
         }
     }
=20
     xendev->frontend_state_watch =3D
         xen_device_add_watch(xendev, xendev->frontend_path, "state",
-                             xen_device_frontend_changed, &local_err);
-    if (local_err) {
-        error_propagate_prepend(errp, local_err,
-                                "failed to watch frontend state: ");
+                             xen_device_frontend_changed, errp);
+    if (*errp) {
+        error_prepend(errp, "failed to watch frontend state: ");
     }
 }
=20
@@ -1247,11 +1237,11 @@ static void xen_device_exit(Notifier *n, void *data=
)
=20
 static void xen_device_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     XenDevice *xendev =3D XEN_DEVICE(dev);
     XenDeviceClass *xendev_class =3D XEN_DEVICE_GET_CLASS(xendev);
     XenBus *xenbus =3D XEN_BUS(qdev_get_parent_bus(DEVICE(xendev)));
     const char *type =3D object_get_typename(OBJECT(xendev));
-    Error *local_err =3D NULL;
=20
     if (xendev->frontend_id =3D=3D DOMID_INVALID) {
         xendev->frontend_id =3D xen_domid;
@@ -1267,10 +1257,9 @@ static void xen_device_realize(DeviceState *dev, Err=
or **errp)
         goto unrealize;
     }
=20
-    xendev->name =3D xendev_class->get_name(xendev, &local_err);
-    if (local_err) {
-        error_propagate_prepend(errp, local_err,
-                                "failed to get device name: ");
+    xendev->name =3D xendev_class->get_name(xendev, errp);
+    if (*errp) {
+        error_prepend(errp, "failed to get device name: ");
         goto unrealize;
     }
=20
@@ -1293,22 +1282,19 @@ static void xen_device_realize(DeviceState *dev, Er=
ror **errp)
     xendev->feature_grant_copy =3D
         (xengnttab_grant_copy(xendev->xgth, 0, NULL) =3D=3D 0);
=20
-    xen_device_backend_create(xendev, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    xen_device_backend_create(xendev, errp);
+    if (*errp) {
         goto unrealize;
     }
=20
-    xen_device_frontend_create(xendev, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    xen_device_frontend_create(xendev, errp);
+    if (*errp) {
         goto unrealize;
     }
=20
     if (xendev_class->realize) {
-        xendev_class->realize(xendev, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        xendev_class->realize(xendev, errp);
+        if (*errp) {
             goto unrealize;
         }
     }
diff --git a/hw/xen/xen-host-pci-device.c b/hw/xen/xen-host-pci-device.c
index 1b44dcafaf..02379c341c 100644
--- a/hw/xen/xen-host-pci-device.c
+++ b/hw/xen/xen-host-pci-device.c
@@ -333,8 +333,8 @@ void xen_host_pci_device_get(XenHostPCIDevice *d, uint1=
6_t domain,
                              uint8_t bus, uint8_t dev, uint8_t func,
                              Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     unsigned int v;
-    Error *err =3D NULL;
=20
     d->config_fd =3D -1;
     d->domain =3D domain;
@@ -342,36 +342,36 @@ void xen_host_pci_device_get(XenHostPCIDevice *d, uin=
t16_t domain,
     d->dev =3D dev;
     d->func =3D func;
=20
-    xen_host_pci_config_open(d, &err);
-    if (err) {
+    xen_host_pci_config_open(d, errp);
+    if (*errp) {
         goto error;
     }
=20
-    xen_host_pci_get_resource(d, &err);
-    if (err) {
+    xen_host_pci_get_resource(d, errp);
+    if (*errp) {
         goto error;
     }
=20
-    xen_host_pci_get_hex_value(d, "vendor", &v, &err);
-    if (err) {
+    xen_host_pci_get_hex_value(d, "vendor", &v, errp);
+    if (*errp) {
         goto error;
     }
     d->vendor_id =3D v;
=20
-    xen_host_pci_get_hex_value(d, "device", &v, &err);
-    if (err) {
+    xen_host_pci_get_hex_value(d, "device", &v, errp);
+    if (*errp) {
         goto error;
     }
     d->device_id =3D v;
=20
-    xen_host_pci_get_dec_value(d, "irq", &v, &err);
-    if (err) {
+    xen_host_pci_get_dec_value(d, "irq", &v, errp);
+    if (*errp) {
         goto error;
     }
     d->irq =3D v;
=20
-    xen_host_pci_get_hex_value(d, "class", &v, &err);
-    if (err) {
+    xen_host_pci_get_hex_value(d, "class", &v, errp);
+    if (*errp) {
         goto error;
     }
     d->class_code =3D v;
@@ -381,7 +381,6 @@ void xen_host_pci_device_get(XenHostPCIDevice *d, uint1=
6_t domain,
     return;
=20
 error:
-    error_propagate(errp, err);
=20
     if (d->config_fd >=3D 0) {
         close(d->config_fd);
diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index b91082cb8b..f57b81588e 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -767,12 +767,12 @@ static void xen_pt_destroy(PCIDevice *d) {
=20
 static void xen_pt_realize(PCIDevice *d, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     XenPCIPassthroughState *s =3D XEN_PT_DEVICE(d);
     int i, rc =3D 0;
     uint8_t machine_irq =3D 0, scratch;
     uint16_t cmd =3D 0;
     int pirq =3D XEN_PT_UNASSIGNED_PIRQ;
-    Error *err =3D NULL;
=20
     /* register real device */
     XEN_PT_LOG(d, "Assigning real physical device %02x:%02x.%d"
@@ -783,10 +783,9 @@ static void xen_pt_realize(PCIDevice *d, Error **errp)
     xen_host_pci_device_get(&s->real_device,
                             s->hostaddr.domain, s->hostaddr.bus,
                             s->hostaddr.slot, s->hostaddr.function,
-                            &err);
-    if (err) {
-        error_append_hint(&err, "Failed to \"open\" the real pci device");
-        error_propagate(errp, err);
+                            errp);
+    if (*errp) {
+        error_append_hint(errp, "Failed to \"open\" the real pci device");
         return;
     }
=20
@@ -813,11 +812,10 @@ static void xen_pt_realize(PCIDevice *d, Error **errp=
)
             return;
         }
=20
-        xen_pt_setup_vga(s, &s->real_device, &err);
-        if (err) {
-            error_append_hint(&err, "Setup VGA BIOS of passthrough"
-                    " GFX failed");
-            error_propagate(errp, err);
+        xen_pt_setup_vga(s, &s->real_device, errp);
+        if (*errp) {
+            error_append_hint(errp, "Setup VGA BIOS of passthrough"
+                              " GFX failed");
             xen_host_pci_device_put(&s->real_device);
             return;
         }
@@ -830,10 +828,9 @@ static void xen_pt_realize(PCIDevice *d, Error **errp)
     xen_pt_register_regions(s, &cmd);
=20
     /* reinitialize each config register to be emulated */
-    xen_pt_config_init(s, &err);
-    if (err) {
-        error_append_hint(&err, "PCI Config space initialisation failed");
-        error_propagate(errp, err);
+    xen_pt_config_init(s, errp);
+    if (*errp) {
+        error_append_hint(errp, "PCI Config space initialisation failed");
         rc =3D -1;
         goto err_out;
     }
diff --git a/hw/xen/xen_pt_config_init.c b/hw/xen/xen_pt_config_init.c
index 31ec5add1d..af3fbd1bfb 100644
--- a/hw/xen/xen_pt_config_init.c
+++ b/hw/xen/xen_pt_config_init.c
@@ -2008,8 +2008,8 @@ static void xen_pt_config_reg_init(XenPCIPassthroughS=
tate *s,
=20
 void xen_pt_config_init(XenPCIPassthroughState *s, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     int i, rc;
-    Error *err =3D NULL;
=20
     QLIST_INIT(&s->reg_grps);
=20
@@ -2052,10 +2052,9 @@ void xen_pt_config_init(XenPCIPassthroughState *s, E=
rror **errp)
                                                   reg_grp_offset,
                                                   &reg_grp_entry->size);
             if (rc < 0) {
-                error_setg(&err, "Failed to initialize %d/%zu, type =3D 0x=
%x,"
+                error_setg(errp, "Failed to initialize %d/%zu, type =3D 0x=
%x,"
                            " rc: %d", i, ARRAY_SIZE(xen_pt_emu_reg_grps),
                            xen_pt_emu_reg_grps[i].grp_type, rc);
-                error_propagate(errp, err);
                 xen_pt_config_delete(s);
                 return;
             }
@@ -2068,13 +2067,14 @@ void xen_pt_config_init(XenPCIPassthroughState *s, =
Error **errp)
=20
                 /* initialize capability register */
                 for (j =3D 0; regs->size !=3D 0; j++, regs++) {
-                    xen_pt_config_reg_init(s, reg_grp_entry, regs, &err);
-                    if (err) {
-                        error_append_hint(&err, "Failed to init register %=
d"
-                                " offsets 0x%x in grp_type =3D 0x%x (%d/%z=
u)", j,
-                                regs->offset, xen_pt_emu_reg_grps[i].grp_t=
ype,
-                                i, ARRAY_SIZE(xen_pt_emu_reg_grps));
-                        error_propagate(errp, err);
+                    xen_pt_config_reg_init(s, reg_grp_entry, regs, errp);
+                    if (*errp) {
+                        error_append_hint(errp, "Failed to init register %=
d"
+                                          " offsets 0x%x in grp_type =3D 0=
x%x (%d/%zu)",
+                                          j,
+                                          regs->offset,
+                                          xen_pt_emu_reg_grps[i].grp_type,
+                                          i, ARRAY_SIZE(xen_pt_emu_reg_grp=
s));
                         xen_pt_config_delete(s);
                         return;
                     }
--=20
2.21.0


