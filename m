Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751C7C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 19:26:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F02620838
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 19:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ugsib26i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F02620838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6Js9-0000jK-Q5
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 15:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42623)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1i6Jfb-0003Wa-QV
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:13:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1i6Jfa-0004Us-Q0
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:13:19 -0400
Received: from mail-co1nam05on062f.outbound.protection.outlook.com
 ([2a01:111:f400:fe50::62f]:38336
 helo=NAM05-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1i6Jfa-0004UI-HJ
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:13:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFi3VNTXRhwx9MuYpU7eNAVHh3jfwutxP2cnsieQNoK7dscNSlQw52xx+LaQDM7FDLvUUxtJyKRrLxhDwtp9sWXDCplNnqIaKaZm+y0YFouc4kmI2j+VBnyk4Q6jX7yLTBDrtLTa+pI/R5JEgRafgJHyB3s0DWpYUo4/GG94IPqA9xnzqnCAGYhDuiOhLeqV18BKBRqkEqWbjv8SLqaMpsBJ7Zn1f8GWgz5DzM8mi0swPknAWvq0SL2ce79zz74w/LHZVSTHYAtUy2koVh68c8bYLMj/pAc5SMC6BqjXvTYVRYl/FnaG2Ug5ndlpqsk4vPSJjN5g3Lo8mFh2CjTK5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3LHZYnVopTC1IPH6nQ+8bqE3i3EePO4xMp+dCs8mFc=;
 b=AjiZwD5s+J+Nl81GphwLlfM7R47K1bjMehTD9M+3U2RIHPLPfv4/LbJR+N5njXM+U52Lo/vWiPRI4dn5k+Vr5fn0tBbTh7tdC6MyJ0lB7TPlnKPuHv2uJscWci1MWm3Fy6bkWtPEaNOkrfo6N2EgG27Dx/bOLTojQ+E7mjHJVmPSzvQzp/HB50VOzhY6PIcv/53ltIw4dgW8KqzGNwC01aOojH5HYUcWsWNis8pcTRlJrd6MXv6qis/KK88lYyE2C3biBE43CSaI8DUUgKQxyuQjRiHbTWJltjVf/cgql3/9nUswILZgrls14QMsH1FxJ99akIiMxYosCQcdHMLOdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3LHZYnVopTC1IPH6nQ+8bqE3i3EePO4xMp+dCs8mFc=;
 b=ugsib26ib6YZlByFUEsNqg0uqyFCKyhvIx0JZ7CN37MAyathBuN7v4tqSqWVlEQtTQbnMg0SNWH7d+J3ZYxNZRThBh2lIONY7eVR+4MeqcMPwhu6vWhgzqq5THkoAKPgpZOG+IakRKdpMNIuSq+0V9FYbLL78g7kvHo8QeFATRg=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1179.namprd12.prod.outlook.com (10.168.234.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.14; Fri, 6 Sep 2019 19:13:16 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::6c7c:4b6d:f136:1bf8]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::6c7c:4b6d:f136:1bf8%3]) with mapi id 15.20.2220.022; Fri, 6 Sep 2019
 19:13:16 +0000
From: "Moger, Babu" <Babu.Moger@amd.com>
To: ssg.sos.staff <ssg.sos.staff@amd.com>, "ehabkost@redhat.com"
 <ehabkost@redhat.com>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>, "mst@redhat.com" <mst@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net"
 <rth@twiddle.net>, "eblake@redhat.com" <eblake@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>, "imammedo@redhat.com"
 <imammedo@redhat.com>
Thread-Topic: [RFC 2 PATCH 14/16] hw/i386: Introduce epyc mode function
 handlers
Thread-Index: AQHVZOciXVA3YS7qJ0mAH+PEaBeSRA==
Date: Fri, 6 Sep 2019 19:13:16 +0000
Message-ID: <156779719472.21957.5262347241826039177.stgit@localhost.localdomain>
References: <156779689013.21957.1631551572950676212.stgit@localhost.localdomain>
In-Reply-To: <156779689013.21957.1631551572950676212.stgit@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0601CA0021.namprd06.prod.outlook.com
 (2603:10b6:803:2f::31) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42680ee2-8cea-41d0-4f38-08d732fe4549
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM5PR12MB1179; 
x-ms-traffictypediagnostic: DM5PR12MB1179:
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB11791B62D191C8DAA429784995BA0@DM5PR12MB1179.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-forefront-prvs: 0152EBA40F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(189003)(199004)(6116002)(103116003)(76176011)(305945005)(86362001)(256004)(2201001)(71190400001)(71200400001)(81156014)(81166006)(2906002)(476003)(3846002)(446003)(8676002)(11346002)(486006)(102836004)(7736002)(6506007)(386003)(6486002)(26005)(8936002)(5660300002)(186003)(4326008)(66066001)(6436002)(14454004)(25786009)(52116002)(9686003)(6512007)(53936002)(4744005)(99286004)(2501003)(110136005)(478600001)(316002)(66476007)(64756008)(66446008)(66556008)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1179;
 H:DM5PR12MB2471.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: v9umr7Yv8E8KMzw/ga2DYDltLZGruSzMXPIycZU/lbj4S4XBPPkUhvqrc3Frp3oxdgzyFKTQucnZJPoaibSv+u9CuZuhRh8p/u2bvFMbxExnAwWtZw+D+LLbqX82O/QRwLx2NZuESSiF7dCVZsOF9LfA3cir+Q/66Tpr55Ugj++IhF2s7g2IgDy5+XyRq+lYyWHL5+dBHRxTF4pce1stBOVMf8K2FBVnvuyhqdxjRUlJoNSi1j4x1pyWGDUcyaqTqHAzndffpVf57FAnIT+6OAmPdx5RSFjiut5235LtYXVdEoS9wPcdJHeVS/2cYkUmQ855P65oTwWPbXMCBPMMTUpbSjP3wyrCheN2dDaG+EDcRnsxrKlXYDVrRNMMyatCwPHcsDoIkr2tfauRiApF7rfy4LLhXsFf6x1kQ0mYYlk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <501A89B664746F4DB8CD4E6AAA31D1E9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42680ee2-8cea-41d0-4f38-08d732fe4549
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2019 19:13:16.3048 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f08dujvAehgPEU/7qnnMFwrJOWusgIxXxURNhEpBPjvG+H93GYtYi8RGGTVLVUyk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1179
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe50::62f
Subject: [Qemu-devel] [RFC 2 PATCH 14/16] hw/i386: Introduce epyc mode
 function handlers
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SW50cm9kdWNlIGZvbGxvd2luZyBoYW5kbGVycyBmb3IgbmV3IGVweWMgbW9kZS4NCng4Nl9hcGlj
aWRfZnJvbV9jcHVfaWR4X2VweWM6IEdlbmVyYXRlIGFwaWNpZCBmcm9tIGNwdSBpbmRleC4NCng4
Nl90b3BvX2lkc19mcm9tX2FwaWNpZF9lcHljOiBHZW5lcmF0ZSB0b3BvIGlkcyBmcm9tIGFwaWMg
aWQuDQp4ODZfYXBpY2lkX2Zyb21fdG9wb19pZHNfZXB5Y2k6IEdlbmVyYXRlIGFwaWNpZCBmcm9t
IHRvcG8gaWRzLg0KDQpTaWduZWQtb2ZmLWJ5OiBCYWJ1IE1vZ2VyIDxiYWJ1Lm1vZ2VyQGFtZC5j
b20+DQotLS0NCiBody9pMzg2L3BjLmMgfCAgICA1ICsrKysrDQogMSBmaWxlIGNoYW5nZWQsIDUg
aW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9wYy5jIGIvaHcvaTM4Ni9wYy5j
DQppbmRleCAxNDc2MDUyM2E5Li41OWM3YzRkOGIyIDEwMDY0NA0KLS0tIGEvaHcvaTM4Ni9wYy5j
DQorKysgYi9ody9pMzg2L3BjLmMNCkBAIC0yODI0LDYgKzI4MjQsMTEgQEAgc3RhdGljIHZvaWQg
cGNfbWFjaGluZV9zZXRfZXB5YyhPYmplY3QgKm9iaiwgYm9vbCB2YWx1ZSwgRXJyb3IgKiplcnJw
KQ0KIA0KICAgICBwY21zLT5lcHljID0gdmFsdWU7DQogICAgIG1zLT5lcHljID0gdmFsdWU7DQor
ICAgIGlmIChwY21zLT5lcHljKSB7DQorICAgICAgICBwY21zLT5hcGljaWRfZnJvbV9jcHVfaWR4
ID0geDg2X2FwaWNpZF9mcm9tX2NwdV9pZHhfZXB5YzsNCisgICAgICAgIHBjbXMtPnRvcG9faWRz
X2Zyb21fYXBpY2lkID0geDg2X3RvcG9faWRzX2Zyb21fYXBpY2lkX2VweWM7DQorICAgICAgICBw
Y21zLT5hcGljaWRfZnJvbV90b3BvX2lkcyA9IHg4Nl9hcGljaWRfZnJvbV90b3BvX2lkc19lcHlj
Ow0KKyAgICB9DQogfQ0KIA0KIHN0YXRpYyB2b2lkIHBjX21hY2hpbmVfaW5pdGZuKE9iamVjdCAq
b2JqKQ0KDQo=

