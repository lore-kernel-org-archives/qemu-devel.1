Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C628FC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 22:07:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 922B82082E
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 22:07:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 922B82082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixeS6-0001v0-OZ
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 17:07:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51060)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <LYan@suse.com>) id 1ixeRV-0001MX-Qb
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 17:07:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <LYan@suse.com>) id 1ixeRU-0001I1-Ml
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 17:07:13 -0500
Received: from m9a0013g.houston.softwaregrp.com ([15.124.64.91]:46215)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <LYan@suse.com>)
 id 1ixeRR-000145-8l; Fri, 31 Jan 2020 17:07:09 -0500
Received: FROM m9a0013g.houston.softwaregrp.com (15.121.0.191) BY
 m9a0013g.houston.softwaregrp.com WITH ESMTP; 
 Fri, 31 Jan 2020 22:06:08 +0000
Received: from M4W0335.microfocus.com (2002:f78:1193::f78:1193) by
 M9W0068.microfocus.com (2002:f79:bf::f79:bf) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Fri, 31 Jan 2020 22:06:57 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (15.124.8.10) by
 M4W0335.microfocus.com (15.120.17.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Fri, 31 Jan 2020 22:06:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQ7E+I71XqsuJX9vh0WghApfQEtZkuEH5gIKPJS+QorAcSo67bgoHov+yDapSgL4mdDA3ONw7dMb6Lcf3eEMMrtdBf2Jov6lB7lkXkgliXFpndRVReZwDsq58vslvONnsLen3w2NTnfGU0JbFeSTDmjWlO76HWyjdWIA33x9PY6fK6GfNS+oFTXq54U9jCUNZJoK6E74DN+riIxIaD4GviXoakgs4/b3tM0WBjJrSTPQNhvUj8JAetJjzyaIVdBIdBrQDuSstPzJ9hNlOCe5prrybQACX11YaZn1BeyJH8j1dq882QqpTULNMqJByi6itu3CSJljSrun4F535Sk4IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vapKNL0d8uBJbm1PoeSvWY+0c6iu5S80ZIiQOsvbLCc=;
 b=aU+Ct4PbRLmvelLHGG15+m+7aD/f/d13hKNGfovCJQhqoS1vjcWXxRE8q/KXH+z00ZF4BCkuwcbBLvQWoqsPNrhB8c/TB21UJNeUn6cAVnX//ZVitsUwGKFiwdDNSlOHPbcFGhqodHCo5DrJAxCI3cX2f0azQBRIXer58v1j9Hg6ZU4wE/xvMUi5FVuTtBW/f1OjayKTLtqToDfGbvT+0QC5f6CxUDoAPT/Yp9SREHzMQi5v4ZYyJLJN2+EKiMK1ER6XJqLWu8PmIIWFws/herHZuEAd5S7sjT14mcoFtROyrkR+HQF6WoZHXf/7+xu2y/Hptt9d+dWh1ggvinv+jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from DM6PR18MB2890.namprd18.prod.outlook.com (20.179.49.208) by
 DM6PR18MB2459.namprd18.prod.outlook.com (20.179.71.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Fri, 31 Jan 2020 22:06:56 +0000
Received: from DM6PR18MB2890.namprd18.prod.outlook.com
 ([fe80::781b:b20f:a2cd:b01c]) by DM6PR18MB2890.namprd18.prod.outlook.com
 ([fe80::781b:b20f:a2cd:b01c%3]) with mapi id 15.20.2665.027; Fri, 31 Jan 2020
 22:06:56 +0000
Received: from leonstudio.lan (2605:a000:160e:228::7d0) by
 CH2PR19CA0023.namprd19.prod.outlook.com (2603:10b6:610:4d::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.22 via Frontend Transport; Fri, 31 Jan 2020 22:06:55 +0000
From: Liang Yan <LYan@suse.com>
To: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Subject: [PATCH v2] target/arm/monitor: query-cpu-model-expansion crashed qemu
 when using machine type none
Thread-Topic: [PATCH v2] target/arm/monitor: query-cpu-model-expansion crashed
 qemu when using machine type none
Thread-Index: AQHV2ILAlB/oLvit6EaIoeUUeSMczQ==
Date: Fri, 31 Jan 2020 22:06:56 +0000
Message-ID: <20200131220649.21141-1-lyan@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CH2PR19CA0023.namprd19.prod.outlook.com
 (2603:10b6:610:4d::33) To DM6PR18MB2890.namprd18.prod.outlook.com
 (2603:10b6:5:167::16)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=LYan@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.25.0
x-originating-ip: [2605:a000:160e:228::7d0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f03cf1c-57f2-429a-d80b-08d7a699e2c2
x-ms-traffictypediagnostic: DM6PR18MB2459:
x-microsoft-antispam-prvs: <DM6PR18MB24593AFE16C0AA3DCF1DFE10BF070@DM6PR18MB2459.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1169;
x-forefront-prvs: 029976C540
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(189003)(199004)(5660300002)(36756003)(71200400001)(1076003)(2616005)(64756008)(66476007)(66446008)(52116002)(66556008)(6506007)(66946007)(186003)(16526019)(110136005)(6512007)(316002)(54906003)(2906002)(6486002)(8886007)(8936002)(8676002)(478600001)(86362001)(81166006)(81156014)(4326008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM6PR18MB2459;
 H:DM6PR18MB2890.namprd18.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iJKxE8iDpTHiubbQ2KC+BlI/sYoApfj8DFj1cf21kh6tvmKvdHUoPUJx4XjE0H/oZ/4/1Rmyw0yELLJKghLlrlv2UL5/6K1p7qh787UHIMNfqGz96KqK/PZbT2a8zA0X5oU0y/53kgv5baVnQRXQn7VEuQupV8CpUR83AKdj/dZzWy3bijIw3uNKwEantp5WC8r8kJDdr3HAP50oGSCCs+bNJvpZCV9SSKgg8SgBmM5s3jhJLDwtTyL6GUxpxsOHN40dMOaFEiCgxyuzBvLbKJIuwiptGp4Omy2qYp6UdXTUVmKQAzqbQ1MSZStw9MuccFEDIUNSyQ04iw6GtdYw43EniBHiX254RWuti+SLG7SEoXOdsstvwfEgrmiW8hNMvbzz/bU5EUMbQzH3D2nBS7kp/tDl9A6O47tdEtM6Of8SjvQV4Nfl/PIU+bjo47l4
x-ms-exchange-antispam-messagedata: 7D/G3r+RWFk3i505AuhlbhrX9A3ZXCo0Yiho3M7Vv+829kUFUYbePPqEH+sXMXqPKa4/dPtBZg7mJsY9aNhW6Mz0Cda7/pi/rMyUJJSczYaInUV3zB7VdeIgqYMn3gzubC8Dpxsfl4ZEhLy85pAUbfeabfH68ySXlqVdnx86aho=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f03cf1c-57f2-429a-d80b-08d7a699e2c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2020 22:06:56.2001 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1a+pTiH601ny8Kqbl9KVot4oGkBX9Ztjjgt4Mh9rGHppvXBW5gIwG3+6n3lqTH19
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB2459
X-OriginatorOrg: suse.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 15.124.64.91
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From commit e19afd56, we know target-arm restricts the list of
queryable cpu models to 'max', 'host', and the current type when
KVM is in use. The logic works well until using machine type none.

For machine type none, cpu_type will be null, and strlen(cpu_type)
will terminate process. So I add a check above it.

This won't affect i386 and s390x, because they are not invovled
current_cpu.

Signed-off-by: Liang Yan <lyan@suse.com>
---
 v2: fix code style issue
---
 target/arm/monitor.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/target/arm/monitor.c b/target/arm/monitor.c
index 9725dfff16..3350cd65d0 100644
--- a/target/arm/monitor.c
+++ b/target/arm/monitor.c
@@ -137,17 +137,19 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(=
CpuModelExpansionType type,
     }
=20
     if (kvm_enabled()) {
-        const char *cpu_type =3D current_machine->cpu_type;
-        int len =3D strlen(cpu_type) - strlen(ARM_CPU_TYPE_SUFFIX);
         bool supported =3D false;
=20
         if (!strcmp(model->name, "host") || !strcmp(model->name, "max")) {
             /* These are kvmarm's recommended cpu types */
             supported =3D true;
-        } else if (strlen(model->name) =3D=3D len &&
-                   !strncmp(model->name, cpu_type, len)) {
-            /* KVM is enabled and we're using this type, so it works. */
-            supported =3D true;
+        } else if (current_machine->cpu_type) {
+            const char *cpu_type =3D current_machine->cpu_type;
+            int len =3D strlen(cpu_type) - strlen(ARM_CPU_TYPE_SUFFIX);
+            if (strlen(model->name) =3D=3D len &&
+                    !strncmp(model->name, cpu_type, len)) {
+                /* KVM is enabled and we're using this type, so it works. =
*/
+                supported =3D true;
+            }
         }
         if (!supported) {
             error_setg(errp, "We cannot guarantee the CPU type '%s' works =
"
--=20
2.25.0


