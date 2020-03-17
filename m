Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069B3C18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:33:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7CC0206EC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="FqkKUubR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7CC0206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEEDv-0001V4-Ti
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 11:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33335)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jEDxp-0002xi-TO
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:17:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jEDxo-000201-8P
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:17:05 -0400
Received: from mail-he1eur04on071f.outbound.protection.outlook.com
 ([2a01:111:f400:fe0d::71f]:1794
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jEDxn-0001d5-Tf
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:17:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ds7VH+MOrsU463V5zMQBbo6UFgFCYHBr82LFeqCDrfDOcxEHH3LJqLbwDQ8ULaPpfDr89ojjRv9zqSaC2tZnKa4MdcAJ1+oxDrEWCSfG80D4q45luY/bZgH4fiCqt/prhqjSnp+8V920L2Yvl0fxIcEdfGaQLo0okJ4SEnbqu8eGB5UdpLHMXddCGfV+JhyaG24UmpSp4oYrLZ3pYjeRgwV4MAi5H2jcHklERLnKSLO2u+IDosJ965aiyfabeAbxSCuVBiR3XKF6HWNK5NlPipohFrkGemei/uKY3LqG7bOi61BzR5fwi3VNUXcMB9kyzwoS5hBlJft6HLoBtR74Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmefC/lvr09AIhgGCB50fZJW6BwAZK3vMfeQYk4zbJc=;
 b=LtL79ac02SCk2iU3sSbiznEN2C2mtn3NPsPJsE71o000nQP0JDrTHsnLd/OU5gH2xYIX+ElbzTl8N+jl3Usc+r72pXZ+nNCfJzh9D6PgL2Kghhf2+ypw9UNHZRU8AeX3Jtp7Ldx2mrGgFW+gsUDQOc1FvUK35hpP6QlW5Nh5PsmDKqhd9qRsjW3LuH9TqKRSWs2J/OPy608LqsbMN1BSiG07uGMl18oh5MD97qUhrzJAhNT9CWL6Q8nXC3sp4yZ2Nmg4WDFmqE0cuvokACriw8wBPNFfoVpTdypIMUXHtuKP2FrtAXGzYcrNI9BvnsDRDvd/GJzIw0k9aIk2vhaX1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmefC/lvr09AIhgGCB50fZJW6BwAZK3vMfeQYk4zbJc=;
 b=FqkKUubRW1G910v9h8NtANUZ7cnWoNgcoYkNB3Dm4NABbTk8YdAPEW13DKu2LSaiq7lSIDpe/T7G8KqlJTRuC5s+wIV1GRLl6nKAp6iHyf1JfSHegYTO6KYREBuiZUJXI8Qcfi0HZGD/dpi/RahxvvZ0b++W3SmTBe8sJ83gAT0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from HE1PR0802MB2507.eurprd08.prod.outlook.com (10.175.35.136) by
 HE1PR0802MB2620.eurprd08.prod.outlook.com (10.175.36.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.21; Tue, 17 Mar 2020 15:17:01 +0000
Received: from HE1PR0802MB2507.eurprd08.prod.outlook.com
 ([fe80::4d32:e4e1:5b9f:240f]) by HE1PR0802MB2507.eurprd08.prod.outlook.com
 ([fe80::4d32:e4e1:5b9f:240f%12]) with mapi id 15.20.2814.021; Tue, 17 Mar
 2020 15:17:01 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 6/9] virtio-9p: introduce ERRP_AUTO_PROPAGATE
Date: Tue, 17 Mar 2020 18:16:22 +0300
Message-ID: <20200317151625.20797-7-vsementsov@virtuozzo.com>
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
 Transport; Tue, 17 Mar 2020 15:17:00 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.248]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa60b06c-fc19-4d2d-c943-08d7ca863e20
X-MS-TrafficTypeDiagnostic: HE1PR0802MB2620:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0802MB2620A5B9D95DE0FF764A934BC1F60@HE1PR0802MB2620.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:121;
X-Forefront-PRVS: 0345CFD558
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(39850400004)(376002)(136003)(346002)(366004)(396003)(199004)(66946007)(6666004)(1076003)(66556008)(54906003)(66476007)(86362001)(6486002)(16526019)(5660300002)(6916009)(186003)(69590400007)(6506007)(52116002)(4326008)(81166006)(6512007)(81156014)(8676002)(8936002)(316002)(2906002)(26005)(478600001)(956004)(36756003)(2616005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:HE1PR0802MB2620;
 H:HE1PR0802MB2507.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S9LwLetGlPcyMaNizIT9eVN3qXuY6W99efhOm41AXtS9lnMwsMi32ffQrqtoWXEsHHx567SVYvp2ootvEOfTjQ6XU8ZDPrRqby/SK4/gwNebBffRzo+3AVAosJV0aJ5vuGw2rMAeGA0fPMCgyVEREeOGHIVF1x72dVUZUKaNpG63mr3cHPR5gPQOeXHSnMSK+3V+jxf/fg4M1oGLnmtCK2XBCeyakQSwnrLMu9ldkeU4dHLIWQ/UnAth54okwf9kGlMDXboZ9qC19C6EmIhm6GJ681BCQYeQ63mbcKzdnsDo3AxGC4QeqDXmQ3fxOIMHw8CG8hstcF5rRuXFk3wKsiNAfvxubboqZXfFKkxrTEE2GI1lKquLub0WniAtCOwE3PaEyzfbnho5RE+kK3BaP8Rv/5bzdzHPJXAq50Io6a0adDOkwah+BSHgF1xDs2lrdV6CJvrwadrDQqxEgtObY7GLaocfpqxYkKHLsvBF7mcPra57j25Q5LgTuppcIcpM
X-MS-Exchange-AntiSpam-MessageData: Q6TBNhod/sajA+blf8/vJBU9fpTsJvEArtkZVQCTympaIrcGAhW6g+aJQ5JPnZZk/iplUP3fC7bYRBU9cyxiSmazACSyiu5TGmLE655F3dLck5k/NCpnGSl14riZoOL+g4lQTU7kCaUg4rN/BYO5Jw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa60b06c-fc19-4d2d-c943-08d7ca863e20
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 15:17:01.5497 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OfajoGfi113be1Xhe8lZWSNk2ru5VKhBMuihfHztMfCFu9WxLaTDUZG3G4CklzESGLR1tC/jOc4K+ZtgpAmlrr9cgr8QR5Lr4nxwsIYvATc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2620
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0d::71f
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
 Christian Schoenebeck <qemu_oss@crudebyte.com>, armbru@redhat.com,
 Greg Kurz <groug@kaod.org>
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

    sed -n '/^virtio-9p$/,/^$/{s/^F: //p}' MAINTAINERS | \
    xargs git ls-files | grep '\.[hc]$' | \
    xargs spatch \
        --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
        --macro-file scripts/cocci-macro-file.h \
        --in-place --no-show-diff --max-width 80

Reported-by: Kevin Wolf <kwolf@redhat.com>
Reported-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Acked-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p-local.c | 12 +++++-------
 hw/9pfs/9p.c       |  1 +
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 54e012e5b4..0361e0c0b4 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1479,10 +1479,10 @@ static void error_append_security_model_hint(Error =
*const *errp)
=20
 static int local_parse_opts(QemuOpts *opts, FsDriverEntry *fse, Error **er=
rp)
 {
+    ERRP_AUTO_PROPAGATE();
     const char *sec_model =3D qemu_opt_get(opts, "security_model");
     const char *path =3D qemu_opt_get(opts, "path");
     const char *multidevs =3D qemu_opt_get(opts, "multidevs");
-    Error *local_err =3D NULL;
=20
     if (!sec_model) {
         error_setg(errp, "security_model property not set");
@@ -1516,11 +1516,10 @@ static int local_parse_opts(QemuOpts *opts, FsDrive=
rEntry *fse, Error **errp)
             fse->export_flags &=3D ~V9FS_FORBID_MULTIDEVS;
             fse->export_flags &=3D ~V9FS_REMAP_INODES;
         } else {
-            error_setg(&local_err, "invalid multidevs property '%s'",
+            error_setg(errp, "invalid multidevs property '%s'",
                        multidevs);
-            error_append_hint(&local_err, "Valid options are: multidevs=3D=
"
+            error_append_hint(errp, "Valid options are: multidevs=3D"
                               "[remap|forbid|warn]\n");
-            error_propagate(errp, local_err);
             return -1;
         }
     }
@@ -1530,9 +1529,8 @@ static int local_parse_opts(QemuOpts *opts, FsDriverE=
ntry *fse, Error **errp)
         return -1;
     }
=20
-    if (fsdev_throttle_parse_opts(opts, &fse->fst, &local_err)) {
-        error_propagate_prepend(errp, local_err,
-                                "invalid throttle configuration: ");
+    if (fsdev_throttle_parse_opts(opts, &fse->fst, errp)) {
+        error_prepend(errp, "invalid throttle configuration: ");
         return -1;
     }
=20
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 9e046f7acb..3aa6a57f3a 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -4023,6 +4023,7 @@ void pdu_submit(V9fsPDU *pdu, P9MsgHeader *hdr)
 int v9fs_device_realize_common(V9fsState *s, const V9fsTransport *t,
                                Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     int i, len;
     struct stat stat;
     FsDriverEntry *fse;
--=20
2.21.0


