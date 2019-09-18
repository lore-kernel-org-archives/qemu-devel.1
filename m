Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B15C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 23:28:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1A12218AF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 23:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="r4N4yViS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1A12218AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAjN8-0001zP-Jq
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 19:28:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33380)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iAjEi-0000ZZ-Mx
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iAjEh-0002iJ-DW
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:48 -0400
Received: from mail-eopbgr700099.outbound.protection.outlook.com
 ([40.107.70.99]:57953 helo=NAM04-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iAjEh-0002fm-7V
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HVQvNNvQQv0DjXO1UjCdlq7rZoNagScwcFwOMCX0eJ4ywSi/h9LgAPjdHA/vVdjchhyOT8HDK8p6Mysxcq0ujTdad2mFLUC2RboVV394Pf4TxW26rmAO5gazQMTogZrqSZBA+G2ZMiqIaIvisX7Cosw48Gx95qp4MTV4DqAtlEc0iUKq0yirRDlammroiaoZGggRwDFwZ9zTNphiAtk6LSS+30Wyfi43iiGiVLCXukTD9k95d9+G7Hd/uA3B5wq2bVtjgKnAgA4G22s43Mi6qrlIxbpKwnbC9C6quYs+9mQEqvtmPTUQp0XMfylPX0zMsw5rBAfqJm8WphTB4ila4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wl9Ilmoqy23y3NtKqm9lMSKbV+7IZFTK9QJyJ/i2mBM=;
 b=GyGGGhFY3B10f/W5ZPUj6czAsnpIsnILs9AptKRSuLv4053GdkPlHaIj52bR6BE6d7i19FWJGZG41G+O2rVkAjJe7wEM9oRZhh58Q9XIeDMvMYWeU4/34S+vZPDUhrgAIn6wYXNteHjIqvQN2iXURVgUbo9OBzSo5wY5imbouj1OvTllg2NSYhbQ/e1xMsn3md62o/by9A14YZce6eEalR2COv4ubVahuC9NfAKGFb35bQF8yVdGEb+JP75fNF1mla1NzVSJk7CXaZLZOqgZw7AamBXbQbZ1dluPdNiczDioHmS85U+MdNVx7pEaftRBl1lABdBQyqgrprMazrsZPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wl9Ilmoqy23y3NtKqm9lMSKbV+7IZFTK9QJyJ/i2mBM=;
 b=r4N4yViSVm29TGCTppq36f3oUnOaRjRsX0auBiZJAsA6cRV5wBlnLw5HFSrfHXBz9ls5dDMOhtPurr7hY/zm8PkcRpGRz75ebU5j1bkGMZzH3evb3of5tMYwGylnuQpXvH6LNx0ARjew3R/AiRml6glUZWl0VU8neqN9WVg1u2w=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB3016.namprd03.prod.outlook.com (10.175.117.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Wed, 18 Sep 2019 23:19:45 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6d88:c5bd:41ad:b107]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6d88:c5bd:41ad:b107%3]) with mapi id 15.20.2263.023; Wed, 18 Sep 2019
 23:19:45 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v3 18/22] fuzz: expose fuzz target name
Thread-Index: AQHVbneO3sQ55jcPO0e0ifKPRYeJHg==
Date: Wed, 18 Sep 2019 23:19:45 +0000
Message-ID: <20190918231846.22538-19-alxndr@bu.edu>
References: <20190918231846.22538-1-alxndr@bu.edu>
In-Reply-To: <20190918231846.22538-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: BL0PR02CA0124.namprd02.prod.outlook.com
 (2603:10b6:208:35::29) To CY4PR03MB2872.namprd03.prod.outlook.com
 (2603:10b6:903:134::17)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92a69b34-9bd0-4f99-7502-08d73c8eb11c
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:CY4PR03MB3016; 
x-ms-traffictypediagnostic: CY4PR03MB3016:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR03MB30163B515FE54EA847A4B395BA8E0@CY4PR03MB3016.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 01644DCF4A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(199004)(189003)(66066001)(86362001)(52116002)(478600001)(2616005)(7736002)(71190400001)(8676002)(36756003)(71200400001)(14454004)(54906003)(316002)(786003)(6486002)(81156014)(75432002)(256004)(6436002)(305945005)(6916009)(6512007)(5640700003)(386003)(486006)(26005)(11346002)(186003)(102836004)(99286004)(76176011)(66946007)(446003)(476003)(66476007)(66556008)(64756008)(66446008)(6506007)(5660300002)(4326008)(2501003)(2351001)(6116002)(81166006)(50226002)(25786009)(1076003)(2906002)(88552002)(8936002)(3846002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB3016;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: L2Pg+DuhoYoZjpOcIBn70LPHp2/ZtA/3dUC6RorVzySJFLRsQKrr/rVUKL8rzdFaSrpChVq9/TTghix0MVJ9Gw4QmXg40rfuILTBAJXzRlkWML5vFP2uRSEgwp7HQbWck4/qZTCMrpYt7pRXpsRQSJJcRjTPcBf1XTwcUK63IgZC6UGpGU1SdOQ32UK8hg5XrGjPm7q5evXOrAGa7UiRd+xvjkoY2YAgMaAiC2j5G4hcDTXX+zM6NPGcZgYJ/gC046iGcllzX+tJWEKTr4ptN9QhqcCSsXtIfZrpyy5Bv+ZaRJlqxTKZDk7c52Q1SrgUF4o831jb8vJqDzQ+rEBXgiFJrHX1vo4gukSj1tFZx+MKJyh2EGPeA1PwBchM8bJxzzoKedP59Fe2XihSNvOkYmfSkbQMN5rm8uoHdsLYfqs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 92a69b34-9bd0-4f99-7502-08d73c8eb11c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2019 23:19:45.3148 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hTDBQUdQwjYRk1m2zwquRC/L4kf4C9r366y/G/QIpf0nBdrBBs/HDBvmNaQw5cGY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3016
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.70.99
Subject: [Qemu-devel] [PATCH v3 18/22] fuzz: expose fuzz target name
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
 "Oleinik, Alexander" <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is needed for the qos-assisted fuzzers which walk the qos tree and
need a way to check if the current path matches the name of the fuzz
target.

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 tests/fuzz/fuzz.c | 3 +++
 tests/fuzz/fuzz.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/tests/fuzz/fuzz.c b/tests/fuzz/fuzz.c
index 833f436731..d44dab7360 100644
--- a/tests/fuzz/fuzz.c
+++ b/tests/fuzz/fuzz.c
@@ -33,6 +33,9 @@ void set_fuzz_target_args(int argc, char **argv)
         fuzz_target->main_argv =3D argv;
     }
 }
+char *get_fuzz_target_name(void){
+    return fuzz_target->name->str;
+}
=20
 void reboot(QTestState *s)
 {
diff --git a/tests/fuzz/fuzz.h b/tests/fuzz/fuzz.h
index 73af029c82..d9d0bf11a8 100644
--- a/tests/fuzz/fuzz.h
+++ b/tests/fuzz/fuzz.h
@@ -19,6 +19,7 @@ typedef struct FuzzTarget {
 } FuzzTarget;
=20
 void set_fuzz_target_args(int argc, char **argv);
+char *get_fuzz_target_name(void);
 void reboot(QTestState *);
 void fuzz_add_target(const char *name, const char *description, FuzzTarget
         *target);
--=20
2.23.0


