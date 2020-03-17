Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCDCC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:36:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0828620663
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="rKfTsqqj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0828620663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEEGo-0005rx-1W
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 11:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33439)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jEDxu-00038A-9v
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:17:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jEDxo-00023R-Oy
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:17:10 -0400
Received: from mail-he1eur04on071f.outbound.protection.outlook.com
 ([2a01:111:f400:fe0d::71f]:1794
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jEDxo-0001d5-Dq
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:17:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CD0TP3T5jqc1ITfaNiKNTAF+pyYxYIlu+j5OQAq8FAFiAVOboLtu6FDQgRh+xelxF9TAn93xkFIHzTAVstytheSCP2QMW7UziMO2FDjm6atPpbnFFPdxJMb6wouYjm0SS7nbxJm2y1qi9QQoAzpPkcDsHys8XEZbPHieLaJYC8IEk/qjfig/Dm0p5rj8QZhI/PTKQECvT6gKnLQ5rwhM2J0UAGRV7CVGC0Dies6DJHXwQpagGDTTsD8Hq5TLt55ssrXjQt/Tt6JzX5VhpgwYBFK561GRXmMVrnH/Cz4Bs85arVU8i/uPS6dM6MyCBfVR2LA8vkF4vEMsTLKIJ+5NxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=si6nQkmUdczLedju7B7iVXPgkItV2yXZa7yvcN13kXM=;
 b=Seajqej1WOCVJtmMRHtLcqNLqGREqUOmxuTtvM+tK3dWZbJvtPfpQ5EYrr/Ygzv38pVDG5hVg7/43+TYqTICCJOt9k9tpcvg8sfd3TZgTeMv67vBMObwYpuLh/YJ8z4HJblV8s9qUx7uFGdyv3jaMnPmZb61UOAJLB4rpnyGYIkaAqkRUj4UbfTWf8t4W7XdlbGnrR6cM1gdcC7HAWdaH0AzOnAJPAycGxTD2hoa2+IvL4Luf6qLtpO2sbt5so/K66OkbLH9F7JNDX2AexJHxBdKlN+OSW7hj77KgBe1L3on9GDFxjNy/in0tsXfue7rfAgVN6xNtXVUhHDz/1Cw2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=si6nQkmUdczLedju7B7iVXPgkItV2yXZa7yvcN13kXM=;
 b=rKfTsqqjCBpJ8+ZWpV//hMHs1oh4cZ9kagPM0CB/hrvVvG2lHGAwz0wE8xCwQbhYYF9NSRJ9jZs4CCm2EnkvsjTdFc9JHSHkz5Wv+1vRp52UN8mkuU498EvK6elHXYTS2Zywto+gef9SA7zyiW2AZWIxR1thvOEutgsfuEtlPYE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from HE1PR0802MB2507.eurprd08.prod.outlook.com (10.175.35.136) by
 HE1PR0802MB2620.eurprd08.prod.outlook.com (10.175.36.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.21; Tue, 17 Mar 2020 15:17:02 +0000
Received: from HE1PR0802MB2507.eurprd08.prod.outlook.com
 ([fe80::4d32:e4e1:5b9f:240f]) by HE1PR0802MB2507.eurprd08.prod.outlook.com
 ([fe80::4d32:e4e1:5b9f:240f%12]) with mapi id 15.20.2814.021; Tue, 17 Mar
 2020 15:17:02 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 7/9] TPM: introduce ERRP_AUTO_PROPAGATE
Date: Tue, 17 Mar 2020 18:16:23 +0300
Message-ID: <20200317151625.20797-8-vsementsov@virtuozzo.com>
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
 Transport; Tue, 17 Mar 2020 15:17:01 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.248]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c46bcee2-6943-4da8-32d5-08d7ca863ed7
X-MS-TrafficTypeDiagnostic: HE1PR0802MB2620:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0802MB26200071E45353C5D19B2122C1F60@HE1PR0802MB2620.eurprd08.prod.outlook.com>
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
X-Microsoft-Antispam-Message-Info: WJSdgNHKWnv37npGzJJYr/u+Wbt2l67R8OiXRbPHFiIQlLEZdEfNpqJtU8JdMJalvYh+IAJzxNP1JjGcIi1zaCYMqYSC7uoMmYssidmdRO+QGxfB4A04KQQ2MQ/ulG9me0+9yKsCog2cw3IaATyse4EE9ji3QPmz57iXzRKXH2rUtkLrSESPgxLDYvrnv7jGTscZ+PsLA+3RaVSezJRk+T2c9OGaAh00SN5vpsd9TfCqzlbKRzcqFONj71r1W76+FEDaDvtIULPUmd5/Fum+1N/ZltNfJhNAs06mZ80f/7/GOdEvNPLCR8mUowEPfFTeZZL6H/CREcGOThM+GWPIyW8+2Uisi1UmLeaUvJWaSBxrLFNi3urJgHmGVGYL9Wq4GsGx0Ih9vI6h1khUCxqkzDXK+FQDj+6kz1RqUOz64Y6MXrtLdSmjghJG82RlhFRh/a/PCVV4UekIKgSQuwSLDOCE8UiuzJ0qa4m4gc71it+3A4zj2Nc63OpkKjDM99tK
X-MS-Exchange-AntiSpam-MessageData: AG88XCCbiRGTphLGaH8GqK+0EMmL0hLgm1p036gSd5ZgNQABqsgZiw+hO8gsMGap3UH20R0gD4hAnG6Ka+bXk+uaQ92IN+QhqwYEVgtZ61+2Ll4O0cBhrZC7YzdN0tm+cnaSMJczlLIl5Qqzgo2lbA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c46bcee2-6943-4da8-32d5-08d7ca863ed7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 15:17:02.7402 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NxpZSBKNp4ZnoxtYSlPKNLYekI0EX6AS1VWk3m7AwWXAWOP7No/TtBS+9bt/15lxTFQIap11pX/RAPmGZ1j3wWXNEBTTdtO163mktniJF0M=
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>,
 vsementsov@virtuozzo.com, armbru@redhat.com, Greg Kurz <groug@kaod.org>
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

    sed -n '/^TPM$/,/^$/{s/^F: //p}' MAINTAINERS | \
    xargs git ls-files | grep '\.[hc]$' | \
    xargs spatch \
        --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
        --macro-file scripts/cocci-macro-file.h \
        --in-place --no-show-diff --max-width 80

Reported-by: Kevin Wolf <kwolf@redhat.com>
Reported-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
 hw/tpm/tpm_util.c | 7 +++----
 tpm.c             | 7 +++----
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/hw/tpm/tpm_util.c b/hw/tpm/tpm_util.c
index c0a0f3d71f..66e0e0c7f3 100644
--- a/hw/tpm/tpm_util.c
+++ b/hw/tpm/tpm_util.c
@@ -47,8 +47,8 @@ static void get_tpm(Object *obj, Visitor *v, const char *=
name, void *opaque,
 static void set_tpm(Object *obj, Visitor *v, const char *name, void *opaqu=
e,
                     Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     DeviceState *dev =3D DEVICE(obj);
-    Error *local_err =3D NULL;
     Property *prop =3D opaque;
     TPMBackend *s, **be =3D qdev_get_prop_ptr(dev, prop);
     char *str;
@@ -58,9 +58,8 @@ static void set_tpm(Object *obj, Visitor *v, const char *=
name, void *opaque,
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
diff --git a/tpm.c b/tpm.c
index 9c9e20bbb7..359ebb7f68 100644
--- a/tpm.c
+++ b/tpm.c
@@ -81,11 +81,11 @@ TPMBackend *qemu_find_tpm_be(const char *id)
=20
 static int tpm_init_tpmdev(void *dummy, QemuOpts *opts, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     const char *value;
     const char *id;
     const TPMBackendClass *be;
     TPMBackend *drv;
-    Error *local_err =3D NULL;
     int i;
=20
     if (!QLIST_EMPTY(&tpm_backends)) {
@@ -116,9 +116,8 @@ static int tpm_init_tpmdev(void *dummy, QemuOpts *opts,=
 Error **errp)
     }
=20
     /* validate backend specific opts */
-    qemu_opts_validate(opts, be->opts, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    qemu_opts_validate(opts, be->opts, errp);
+    if (*errp) {
         return 1;
     }
=20
--=20
2.21.0


