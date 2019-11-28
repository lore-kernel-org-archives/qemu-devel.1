Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D949C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 18:24:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3217E21771
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 18:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="2ukjRON2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3217E21771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaOSf-0006eA-Aw
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 13:24:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49967)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1iaMyA-0002bk-VQ
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 11:48:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1iaMy8-0002BR-0a
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 11:48:41 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:35042)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1iaMxy-00025f-Su
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 11:48:33 -0500
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xASGd55C019889; Thu, 28 Nov 2019 08:48:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=proofpoint20171006;
 bh=9/y86O0fcib9u/3XfLFuPCy111agbrDNp4oh2CTm8h8=;
 b=2ukjRON2Lwj0JCvW5SJBzkxbUdtK3uY8YNzDc79lzzHiJ3oUqIQ8jyiLE9UFA53codDe
 OHRdrU+LkOPpBuLRVMh9djdFwwe2S/Fsmwy5cMZcSstuV4tXkj2ilKwC7Hyx77QjctKT
 HPrnZzIbZmkTfcjdAY9XOotG4xZe9kVZ8HkIQQ8UYj/6qs3RZOZm8h8ivW8ZCuyfuIZr
 HdNez679vC/qW30qEmks4BdagjS8xdX6YkRsijcoG0n0bR5smuCAIAh7GqRC4t0ts/2N
 4Dy/eKFd2IPMxxnUmc8xgL7Z0MWaqA0/wqErhUnuv0H2zFxyYHo677s6X1mYop87G2gN bw== 
Received: from nam03-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam03lp2059.outbound.protection.outlook.com [104.47.41.59])
 by mx0a-002c1b01.pphosted.com with ESMTP id 2whnfju44h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 28 Nov 2019 08:48:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JArq1is3NeGsT1OUQvsWZ53yBkQ3bToWG65NXxZcCJjqtC44fnUdMe4yDdITgQXh92Batosall0CGqgJdM9y274ct9rcOwg4DajAJhPrUIdq4bw2sf7bYpOXn7/5WiqVNhvv6fw4uhmOkYnpWM//Trw5y8+Qif+Oqfjfa/0DVqOMPyFY/cDcRWbfdVDVk6LDID/AI0KoqAvrwm3K/DTfVtLBCCEq6WDNF2iXxvePmxuPXpDnL3zwUAq0h7J/QgPsQP8MlcI32ho55eFIRQTo98/J5rDiHHQNV8300FkblgAZAkCCus4UIi8qJybqRQOyQuvFhxfkf4s6QU1OXhsCYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/y86O0fcib9u/3XfLFuPCy111agbrDNp4oh2CTm8h8=;
 b=HzllTd7jIDRavjrZtHKz35hALoj5oV/mqIkUUxx2EyDZLXgsvRPnjMdN1TB/7i2QQoZwDjDcB1RKVr67R7zNxVY48x5RfyYbB5cYImR3bHuN3tQWmYPqsQkZr/UC3E7x/XeD3rfImafOvw1NPf5HVq7gUVfh7OpKouwfk2ReHhb2nljlENUqy395hRHmcLhHb2ge4JoVzHG4g5XylOW/rfjaNAN6dSz2qftkqjOe05NSLzKPHfLpIW/8f1IvJY6A7JoxbJ3c+xiE180vkHPI0TdXn5GDbnyXkhGYLFz3samxNWL3Cm1RMdXRbPqFMkD4Hy+x22HeQDZ2MZLhxgmITQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.142) by
 MWHPR02MB2398.namprd02.prod.outlook.com (10.168.243.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Thu, 28 Nov 2019 16:48:25 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::f801:763d:e7fc:6bf]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::f801:763d:e7fc:6bf%7]) with mapi id 15.20.2474.023; Thu, 28 Nov 2019
 16:48:25 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: Marc-Andre Lureau <marcandre.lureau@gmail.com>, Philippe Mathieu-Daude
 <philmd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eduardo Habkost
 <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alexey
 Kardashevskiy <aik@ozlabs.ru>
Subject: [PATCH v2 0/4] Improve default object property_add uint helpers
Thread-Topic: [PATCH v2 0/4] Improve default object property_add uint helpers
Thread-Index: AQHVpgumwd/y95y1Kk69/TuE/fVBnA==
Date: Thu, 28 Nov 2019 16:48:25 +0000
Message-ID: <20191128164810.54279-1-felipe@nutanix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM3PR05CA0154.eurprd05.prod.outlook.com
 (2603:10a6:207:3::32) To MWHPR02MB2656.namprd02.prod.outlook.com
 (2603:10b6:300:45::14)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb4b719e-5890-40f8-dd4d-08d77422c95b
x-ms-traffictypediagnostic: MWHPR02MB2398:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR02MB2398B08F83CED393CD8043FED7470@MWHPR02MB2398.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0235CBE7D0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(346002)(366004)(376002)(39860400002)(136003)(54534003)(189003)(199004)(102836004)(110136005)(256004)(14444005)(36756003)(14454004)(2616005)(6436002)(66066001)(4326008)(386003)(6506007)(186003)(26005)(52116002)(66556008)(64756008)(1076003)(71190400001)(66946007)(5660300002)(71200400001)(6486002)(66446008)(66476007)(86362001)(6512007)(478600001)(54906003)(8936002)(50226002)(316002)(81166006)(2906002)(8676002)(7736002)(305945005)(81156014)(99286004)(25786009)(6116002)(3846002)(64030200001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR02MB2398;
 H:MWHPR02MB2656.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /aJmYHOK7SlYd4n7P0+EGavDAcVJ6WY/e/BJrPUqDjmzRtXnH1xqfM2B3Zm9qjyviYgYqpta4zYOFIzAJUUBOp3IygX7wVPLPAekzCochTYutO09qWLMO0zBRm6Sc70WGarV7c3nFZxQpJoMO3ef5OCYD6HPTgSFJrDE4MUoSUq/pIMody5oMZvKVN/g1GGk2rgLyubGKJ3KhJNyqs16VEY2hQWxU5pRI0Z8RJPO63IaQDOqe7tXqb3zxwjqaaGk30j2qHOCefoOa6iiEY2P4z0NWdLKErLfkXMnFC1kAcFI3E3zpzVswRwOFBUCHGg/2BXiVGJZVy2YxEW3fYSwI2Jf9C30uZXSz/4aLxjAcuTuAvwQGprClbgiVE23U33fLr2q/cOmPgjHi17bZmUpiLpVL8AGezFHChpLUtG/l3CLBvPDzOMfSDBu779B9tR6
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb4b719e-5890-40f8-dd4d-08d77422c95b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2019 16:48:25.3744 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wluDqy6a4toX3BK+XR4cH1YoUmiCQ5KR+2Xy/ALx0w4VKpZC1WlANcRFOJqn0YtcBtzb9vb1k5nqioo5Xi1WWdPLgzKAkhIkvznXkYZe1Yw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2398
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-28_05:2019-11-28,2019-11-28 signatures=0
X-Proofpoint-Spam-Reason: safe
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.151.68
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Felipe Franciosi <felipe@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhpcyBpbXByb3ZlcyB0aGUgZmFtaWx5IG9mIG9iamVjdF9wcm9wZXJ0eV9hZGRfdWludFhYX3B0
ciBoZWxwZXJzIGJ5IGVuYWJsaW5nDQphIGRlZmF1bHQgZ2V0dGVyL3NldHRlciBvbmx5IHdoZW4g
ZGVzaXJlZC4gVG8gcHJldmVudCBhbiBBUEkgYmVoYXZpb3VyYWwgY2hhbmdlDQooZnJvbSBjbGll
bnRzIHRoYXQgYWxyZWFkeSB1c2VkIHRoZXNlIGhlbHBlcnMgYW5kIGRpZCBub3Qgd2FudCBhIHNl
dHRlciksIHdlDQphZGQgYSBPQkpfUFJPUF9GTEFHX1JEIGZsYWcgdGhhdCBhbGxvdyBjbGllbnRz
IHRvIG9ubHkgaGF2ZSBhIGdldHRlci4gUGF0Y2ggMQ0KZW5oYW5jZXMgdGhlIEFQSSBhbmQgbW9k
aWZ5IGN1cnJlbnQgdXNlcnMuDQoNCldoaWxlIG1vZGlmeWluZyB0aGUgY2xpZW50cyBvZiB0aGUg
QVBJLCBhIGNvdXBsZSBvZiBpbXByb3ZlbWVudCBvcHBvcnR1bml0aWVzDQp3ZXJlIG9ic2VydmVk
IGluIGljaDkuIFRoZXNlIHdlcmUgYWRkZWQgaW4gc2VwYXJhdGUgcGF0Y2hlcyAoMiBhbmQgMyku
DQoNClBhdGNoIDMgY2xlYW5zIHVwIGEgbG90IG9mIGV4aXN0aW5nIGNvZGUgYnkgbW92aW5nIHZh
cmlvdXMgb2JqZWN0cyB0byB0aGUNCmVuaGFuY2VkIEFQSS4gUHJldmlvdXNseSwgdGhvc2Ugb2Jq
ZWN0cyBoYWQgdGhlaXIgb3duIGdldHRlcnMvc2V0dGVycyB0aGF0IG9ubHkNCnVwZGF0ZWQgdGhl
IHZhbHVlcyB3aXRob3V0IGZ1cnRoZXIgY2hlY2tzLiBTb21lIG9mIHRoZW0gYWN0dWFsbHkgbGFj
a2VkIGEgY2hlY2sNCmZvciBzZXR0aW5nIG92ZXJmbG93cywgd2hpY2ggY291bGQgaGF2ZSByZXN1
bHRlZCBpbiB1bmRlc2lyZWQgdmFsdWVzIGJlaW5nIHNldC4NClRoZSBuZXcgZGVmYXVsdCBzZXR0
ZXJzIGluY2x1ZGUgYSBjaGVjayBmb3IgdGhhdCwgbm90IHVwZGF0aW5nIHRoZSB2YWx1ZXMgaW4N
CmNhc2Ugb2YgZXJyb3JzIChhbmQgcHJvcGFnYXRpbmcgdGhlbSkuIElmIHRoZXkgZGlkIG5vdCBw
cm92aWRlIGFuIGVycm9yDQpwb2ludGVyLCB0aGVuIHRoYXQgYmVoYXZpb3VyIHdhcyBtYWludGFp
bmVkLg0KDQoNCkZlbGlwZSBGcmFuY2lvc2kgKDQpOg0KICBxb20vb2JqZWN0OiBlbmFibGUgc2V0
dGVyIGZvciB1aW50IHR5cGVzDQogIGljaDk6IGZpeCBnZXR0ZXIgdHlwZSBmb3Igc2NpX2ludCBw
cm9wZXJ0eQ0KICBpY2g5OiBTaW1wbGlmeSBpY2g5X2xwY19pbml0Zm4NCiAgcW9tL29iamVjdDog
VXNlIGNvbW1vbiBnZXQvc2V0IHVpbnQgaGVscGVycw0KDQogaHcvYWNwaS9pY2g5LmMgICAgICAg
fCAxMDMgKysrLS0tLS0tLS0tLS0tLS0tLS0tDQogaHcvYWNwaS9wY2locC5jICAgICAgfCAgIDcg
Ky0NCiBody9hY3BpL3BpaXg0LmMgICAgICB8ICAxMiArLS0NCiBody9pc2EvbHBjX2ljaDkuYyAg
ICB8ICAyOCArKy0tLS0NCiBody9taXNjL2VkdS5jICAgICAgICB8ICAxNCArLS0NCiBody9wY2kt
aG9zdC9xMzUuYyAgICB8ICAxNCArLS0NCiBody9wcGMvc3BhcHIuYyAgICAgICB8ICAxOSArLS0t
DQogaHcvcHBjL3NwYXByX2RyYy5jICAgfCAgIDIgKy0NCiBody92ZmlvL3BjaS1xdWlya3MuYyB8
ICAyMCArKy0tDQogaW5jbHVkZS9xb20vb2JqZWN0LmggfCAgNDIgKysrKysrKy0tDQogbWVtb3J5
LmMgICAgICAgICAgICAgfCAgMTUgKy0tDQogcW9tL29iamVjdC5jICAgICAgICAgfCAyMTYgKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLQ0KIHRhcmdldC9hcm0vY3B1
LmMgICAgIHwgIDIzICstLS0tDQogdGFyZ2V0L2kzODYvc2V2LmMgICAgfCAxMDYgKystLS0tLS0t
LS0tLS0tLS0tLS0tDQogdWkvY29uc29sZS5jICAgICAgICAgfCAgIDQgKy0NCiAxNSBmaWxlcyBj
aGFuZ2VkLCAyOTMgaW5zZXJ0aW9ucygrKSwgMzMyIGRlbGV0aW9ucygtKQ0KDQotLSANCjIuMjAu
MQ0KDQpDaGFuZ2Vsb2c6DQotIFVwZGF0ZSBzY2lfaW50IGRpcmVjdGx5IGluc3RlYWQgb2YgdXNp
bmcgc3RhY2sgdmFyaWFibGUNCi0gRGVmaW5pbmcgYW4gZW5oYW5jZWQgT2JqZWN0UHJvcGVydHlG
bGFncyBpbnN0ZWFkIG9mIGp1c3QgJ3JlYWRvbmx5Jw0KLSBFcnJvcmluZyBvdXQgZGlyZWN0bHkg
KGluc3RlYWQgb2YgdXNpbmcgZ290b3MpIG9uIGRlZmF1bHQgc2V0dGVycw0KLSBSZXRhaW5pbmcg
bGFjayBvZiBlcnJwIHBhc3Npbmcgd2hlbiBpdCB3YXNuJ3QgdGhlcmUNCg==

