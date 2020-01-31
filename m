Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215A4C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 21:28:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6A9020CC7
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 21:28:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6A9020CC7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixdqQ-0000mW-3a
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 16:28:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37783)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <LYan@suse.com>) id 1ixdpn-0000BA-9b
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 16:28:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <LYan@suse.com>) id 1ixdpm-0007hA-Aj
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 16:28:15 -0500
Received: from m9a0013g.houston.softwaregrp.com ([15.124.64.91]:40806)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <LYan@suse.com>)
 id 1ixdpj-0007do-12; Fri, 31 Jan 2020 16:28:11 -0500
Received: FROM m9a0013g.houston.softwaregrp.com (15.121.0.190) BY
 m9a0013g.houston.softwaregrp.com WITH ESMTP; 
 Fri, 31 Jan 2020 21:27:10 +0000
Received: from M9W0067.microfocus.com (2002:f79:be::f79:be) by
 M9W0067.microfocus.com (2002:f79:be::f79:be) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Fri, 31 Jan 2020 21:27:50 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (15.124.72.13) by
 M9W0067.microfocus.com (15.121.0.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Fri, 31 Jan 2020 21:27:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HIqZJv1I/ULCRJQbsUdhDcJEnbAa2FywvoGiyJCTtUej6dFFsdAt3cqBDzzNGbzJpyzmtEJxhigaY0mcD0iqty8eyKDI4iFqnr2m/ogeSIKKJFGFNb1wLhMd919Fut8QJ+R5Xvm4phWkNRrUGR4dJewviQtgwseg7m7a6DRYzmTd6ZVNjgtvcr8k7nVI2d7W3+VRUZuYTLBnE9rtGrUFns9FLxQSLIIVKytxDTsDvV1QPxBmn1paPPy84ujdNXm+z92mxc7mM0ykvXsE9SplpHsLHdO0HkJvczG+t6/6D453BSRf5iHTrw2JYKMA6q8Nm/Y4/EM8Vup1XBV9jVsiTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBNMoQsFtd1df2yOjom/+qifWEOxNoB2Cm0QRnaU3ag=;
 b=GsmPh8EzVrsNf5d+l5BCYceUFPhDxcugkKQTOqnHSW8ip9hP9eiAU349hjugaZOj2fQXN2iuwZfnsvoFl56w6gJVSLu8VG3+eTe6fY3gBYjLpeJ+L7IDtFwrbX74Aw6Ge4J531O1q55MBkciPTwQU9I5Mxo1s3nZpx62rAZ1OHXToPyTxSXG9yrKdVuWVNtMNpVTVxRyfcV+RKbNeroUuf8hldpDuWOzd3lUuQiIbiPGjWaGqI/n/BpqQdRC1ypXk37Fw1fGcmWzvB163pQQvnb6x36vbw2U6zaSYsTvlhD/JuFpvGwBTTs5oE9xOR6suaXHnlahy8yeDmJHlZshvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from DM6PR18MB2890.namprd18.prod.outlook.com (20.179.49.208) by
 DM6PR18MB2667.namprd18.prod.outlook.com (20.179.107.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.22; Fri, 31 Jan 2020 21:27:49 +0000
Received: from DM6PR18MB2890.namprd18.prod.outlook.com
 ([fe80::781b:b20f:a2cd:b01c]) by DM6PR18MB2890.namprd18.prod.outlook.com
 ([fe80::781b:b20f:a2cd:b01c%3]) with mapi id 15.20.2665.027; Fri, 31 Jan 2020
 21:27:49 +0000
Received: from leonstudio.lan (2605:a000:160e:228::7d0) by
 CH2PR14CA0024.namprd14.prod.outlook.com (2603:10b6:610:60::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.22 via Frontend Transport; Fri, 31 Jan 2020 21:27:48 +0000
From: Liang Yan <LYan@suse.com>
To: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Subject: [PATCH] target/arm/monitor: query-cpu-model-expansion crashed qemu
 when using machine type none
Thread-Topic: [PATCH] target/arm/monitor: query-cpu-model-expansion crashed
 qemu when using machine type none
Thread-Index: AQHV2H1JjTIiAKMEG0aqSTIqw67CUg==
Date: Fri, 31 Jan 2020 21:27:49 +0000
Message-ID: <20200131212742.18579-1-lyan@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CH2PR14CA0024.namprd14.prod.outlook.com
 (2603:10b6:610:60::34) To DM6PR18MB2890.namprd18.prod.outlook.com
 (2603:10b6:5:167::16)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=LYan@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.25.0
x-originating-ip: [2605:a000:160e:228::7d0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28512272-adcc-4c25-000b-08d7a6946bea
x-ms-traffictypediagnostic: DM6PR18MB2667:
x-microsoft-antispam-prvs: <DM6PR18MB2667E957472EE9B454883D7EBF070@DM6PR18MB2667.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1169;
x-forefront-prvs: 029976C540
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(136003)(346002)(396003)(39860400002)(376002)(189003)(199004)(8676002)(81166006)(81156014)(54906003)(2906002)(110136005)(316002)(36756003)(1076003)(186003)(16526019)(6506007)(8936002)(2616005)(5660300002)(6486002)(66476007)(6512007)(52116002)(66446008)(86362001)(71200400001)(8886007)(4326008)(66946007)(66556008)(478600001)(64756008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM6PR18MB2667;
 H:DM6PR18MB2890.namprd18.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F8N4RT/yNOVbVrPDuyoiJWgWmVQrBGBv9NEJBJwMCSErJ3SjcJA8T+IBW1syvX05DA3/RM5e0jJCSBg1Zs96y7va5CkUIZhkp52k3EBMZUv14pTIc7uephz06ya0x1NbANlnSxTqp2yN7dQkxmbR9Uuonjf4gzpWfRFt3ONvCSOmmP8liLu8etwg1hsnBjdQmLdRtyEOvUVEInHNqFmFTbMByKaxoBqJ7iW6c/dIzUMYO/3XLmkURpHbjbnSSnesxKQLux5E/XLC8qVvF/EGZjyWiDaGVqKxspTRVhbmiZ6yJB2qo48r+S1Zo47b0Itllx9CC6rKArGIM1U0mJxD22e+//JZ/4OoyUnHVPy/IyPKS2f5/W2ZtjX6Tlncd6vJz04Wx/0BbRj8tFIHiQup59U1lCN7nlmigLLN5MrrM9Cw39gcwCdcIYJETg2t9o+5
x-ms-exchange-antispam-messagedata: 1mfJD53lst4yIaFp2UAzFd//UwoGBfKzdHntKW8j4nT/Sk+aEIK4FhAWlLVS+nJkh5L69anPQtBhHfVfSR6VjZOOXOqh2GlSyVruUimh/BHPgzInjog8Vwp6trS/sR4ALFn62XpRaT42oeLc8j5BoE/g9tGSXOff2IrIhhJLYpc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 28512272-adcc-4c25-000b-08d7a6946bea
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2020 21:27:49.4611 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m0EabFiInOb8GRE0TmgNSp97B0HP+f7dfmJ7x+7D4kd3lNpDz2qwoUJ8t1PEFaCn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB2667
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
 target/arm/monitor.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/target/arm/monitor.c b/target/arm/monitor.c
index 9725dfff16..0c0130c1af 100644
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
+			    !strncmp(model->name, cpu_type, len)) {
+		    /* KVM is enabled and we're using this type, so it works. */
+		    supported =3D true;
+            }
         }
         if (!supported) {
             error_setg(errp, "We cannot guarantee the CPU type '%s' works =
"
--=20
2.25.0


