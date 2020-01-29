Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62489C33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 05:37:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E8672071E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 05:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="6qzcou98"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E8672071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwg2o-0005i8-Af
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 00:37:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44851)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iwfze-00081h-Qi
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 00:34:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iwfzd-00026B-Ql
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 00:34:26 -0500
Received: from mail-mw2nam10on2098.outbound.protection.outlook.com
 ([40.107.94.98]:3168 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iwfzd-0001yv-K0
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 00:34:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLuK0eAC1okGqjv2JREKVCJw8VebXkI0JdsSt427r2nunkHCSuhTNMuTM8s2ItQvMhoGKAD/nSkWOGsFBJ6N1uovNKLvOwyiCxKOSIDawIBnmBDNp2xymc2JyKPyn7SyifM+RTLdNJUPTw8PGZIRq0SYkddQ3oKCdjWWWTBsnQiEME20zMfE7woXFdiXEit6/DfFwxcyH/tAAQUJIUFhg0l743wk2Gjkh47hNb/qoWp6C9vkkR0tdwNFnamXGZJTXWNXoKqsulW63UJK/fdQywiTbYjyZVWzXspKxfmq93q6C5khAZAKJFgvdncVt7qNgzUWprG9quSBhEq1eYYFHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvfyRSpFXX3eIenuPDNFrheDQPbJAcUwIoiwm3X01go=;
 b=PSRWpCv8NYqyht3paBYv7XJKeHDo+gpNE1W0utPLuIzDsWLfnuodY1LpanX2gSFgtQLy+cXlbCkqexS7eTYSBvgNMtgHsmXfYv1b1A7L2XKAWQwU2ClU71BDVEEgoJ13rgyCmYq2bc+hGt3GOWp2RlfGtd1r4sdo3Q7OgLY+uaFS9lqpcEOj5eFDqTSSR5Hd2fK1RAvkXF9p+R/kBtH+9vXjtesm/7KqF2VPaePEilzfrs5DkUwJcV5N6tQPcwDdm9uk6buWiINj6J9i19wS2r7xQBP8b1eWpwoaJ6oYCUTDuR/wkTO2D5Zf6mKZhAq7IyyE44i4p7ifkrKINB8BJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvfyRSpFXX3eIenuPDNFrheDQPbJAcUwIoiwm3X01go=;
 b=6qzcou98DFJFuhlNxSEeuA447qibkpAKeKO5nfp7tqXVgIhrkEhQy8f2JR11nXIjq+jDMZf4I66lNOFOd/zqXt/AFCDtbcHTP7ej9oJfniXkNVHKGLkbz46bbT0oW6TgGsipO0+/StYaq40OydcMxCCKPsb88UzeW2nFpNkcVkA=
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (52.135.102.32) by
 SN6PR03MB4206.namprd03.prod.outlook.com (52.135.110.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.20; Wed, 29 Jan 2020 05:34:23 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2665.026; Wed, 29 Jan 2020
 05:34:23 +0000
Received: from mozz.bu.edu (128.197.127.33) by
 MN2PR05CA0029.namprd05.prod.outlook.com (2603:10b6:208:c0::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.19 via Frontend Transport; Wed, 29 Jan 2020 05:34:21 +0000
From: "Bulekov, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v8 13/21] main: keep rcu_atfork callback enabled for qtest
Thread-Topic: [PATCH v8 13/21] main: keep rcu_atfork callback enabled for qtest
Thread-Index: AQHV1mXCBspw526GPkKCIjsEVHUgMg==
Date: Wed, 29 Jan 2020 05:34:22 +0000
Message-ID: <20200129053357.27454-14-alxndr@bu.edu>
References: <20200129053357.27454-1-alxndr@bu.edu>
In-Reply-To: <20200129053357.27454-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: MN2PR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:208:c0::42) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 01c32329-7a7c-4799-06cc-08d7a47ce4f9
x-ms-traffictypediagnostic: SN6PR03MB4206:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR03MB4206D511F884A5747CC230C5BA050@SN6PR03MB4206.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:843;
x-forefront-prvs: 02973C87BC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(189003)(199004)(478600001)(4744005)(75432002)(36756003)(316002)(6916009)(2906002)(786003)(4326008)(54906003)(26005)(186003)(956004)(2616005)(6486002)(7696005)(52116002)(16526019)(1076003)(5660300002)(71200400001)(86362001)(66446008)(66556008)(66946007)(66476007)(8936002)(81156014)(81166006)(64756008)(8676002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB4206;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4113KCy4d0taWdVzCZmx3fVmYWqbZ4ssqLkRwKi4G9cbEzVsdtxSsDV+9qk8j0EUrtdrvQwucn6uMHKgeRq6NpcXPAhJT5z5d+f8YTb7IqxkgT3lTu07yQhlcEvYiIezi5ML+ohka2oDymk0RDFHBNhzq0MpexBul77IUZ6odMX2XrZB0F0t2JxBbKRlfjvqFa068D5RkaoIgu25fQmwIyYfZ5zGby7Qbjl9x5b/bb6HaTrYQwUl6DfcLcI0ABBxxb7jqyOowQ4ux3rHtpiiQe67l4UfZc0lx0yChj6OfdiNqTHK89kpcWqqnxbsemZ1AbLTTRVptyRGLLvZEjiYqrSG8mTw5yb+tJzM5Ms9U9zP4oHVi/Jz13jKuZ7S0l817jMyw29z/9MTYFoQSvc+OKDj24ACulJI8x/gQ0pg9Kl6+i0D6Euy3+c+0uAVmc5f
x-ms-exchange-antispam-messagedata: oZ9IHV6DODpu7HHh+yvb4CvzVe0aVEjxsJ+xhf0SYzZ47I2oGE9KZOaAcSS3XR3Puftsn6UaRYJSe0UH6cjyA3q1SoApuCiRleiCOUp/uHRnnfQb0SHqaU5vdPznvoPlZlE21CV1zqSgBT8rBJKt0w==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c32329-7a7c-4799-06cc-08d7a47ce4f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2020 05:34:22.2978 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YjUYm3TDT1CoHlMfSKE1SlJeiv0uPWLc4HVMI5dplqDIfRGfDkQ6gfaHNXqWoh3h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4206
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.94.98
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>,
 "Bulekov, Alexander" <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The qtest-based fuzzer makes use of forking to reset-state between
tests. Keep the callback enabled, so the call_rcu thread gets created
within the child process.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 vl.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/vl.c b/vl.c
index bb77935f04..cf8e2d3ebb 100644
--- a/vl.c
+++ b/vl.c
@@ -3794,7 +3794,14 @@ void qemu_init(int argc, char **argv, char **envp)
     set_memory_options(&ram_slots, &maxram_size, machine_class);
=20
     os_daemonize();
-    rcu_disable_atfork();
+
+    /*
+     * If QTest is enabled, keep the rcu_atfork enabled, since system proc=
esses
+     * may be forked testing purposes (e.g. fork-server based fuzzing)
+     */
+    if (!qtest_enabled()) {
+        rcu_disable_atfork();
+    }
=20
     if (pid_file && !qemu_write_pidfile(pid_file, &err)) {
         error_reportf_err(err, "cannot create PID file: ");
--=20
2.23.0


