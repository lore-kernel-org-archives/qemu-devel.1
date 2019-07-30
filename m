Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAB6C0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 14:47:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10412206E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 14:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="AnjN+DPE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10412206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsTP3-0000Ng-Vk
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 10:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36945)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1hsTO2-0008FW-49
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 10:45:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1hsTO0-0007wm-KW
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 10:45:58 -0400
Received: from mail-eopbgr70120.outbound.protection.outlook.com
 ([40.107.7.120]:50515 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1hsTO0-0007vg-CX
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 10:45:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=khuyt8x554BOny1xXKmKRzGhQ6izswxRIOOQg7tB3gYhCX4qx6cMedshkfuBskc8KJFS3M/L/03l+BdXu3MCj5UO69RoyNt23y4GGmLlLDON3wRmIpx+mp73l3rCYArGzZbi+PCYgsKcawfvF/J5so6CW4ZamTZAs2WdvIrDuxKT9hh5elM5kaTSqEhvobCfnAxe179Orme86RtE08E6+/DQpRasaVAHBpo8D6Dx2IlvTIMF/tFEJpTglBF04yLyefgfdPgLZTrMoQJ+bMyqe+vrCjtnemzA7WAg+E1knGRohZAaG1DddBKvxT2JB6xK9+Ob+JXr8dAdyfqJVahWjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7BgcnztUFHM97PXmRK1EXDhn1ZqlCBG+gjujsHwkbVk=;
 b=cm/5vL3Hw5WdY6LaTLG0LVtzMA6FzAqsDJUVtmyPvXP/bcjX2ACERuf41CJVKY6JpqRbZ/SpScOKww9O7d2VAFnkJu0Gwkdd5aE8Cu7uwZezMRQ7UQSPFOr9MBDqzlyfAYzhCnQabo2zLvlrLfYKlV92PO4c4B0bz9bqPxf8iq0doOsl7a+9+Ca26uyzAjb2kxwLHcNM2ucpYH1BLIK72JiWUQIVuIr1J77389uuqtsK7+EzEi8TGJEcZwDp10tMXTeWw/cdK7yfVfpqQDMVEkXvrDOcOx0yYfEcXHA9u+F4x14pNcuvtMYkRKnvechSGsvQ3DFgSWTA7ZDToGL2yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7BgcnztUFHM97PXmRK1EXDhn1ZqlCBG+gjujsHwkbVk=;
 b=AnjN+DPEXlgkcEFfUCeKwtirvVPnLe/1p03qmj7UlaIZQbqWvxUsvXxLwV4DWSOtTkRnbdLXFdsFFdyLg1JDiif/gBW+mnR7pHL3O1uWaRYEWXtSIIZn7zNpwM5vEWO7hjxCT98uoGF4oIrmEhVWZNYL3X6eiQ38GUnZkgYbFS0=
Received: from VI1PR08MB3760.eurprd08.prod.outlook.com (20.178.14.92) by
 VI1PR08MB3872.eurprd08.prod.outlook.com (20.178.80.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.13; Tue, 30 Jul 2019 14:45:55 +0000
Received: from VI1PR08MB3760.eurprd08.prod.outlook.com
 ([fe80::39df:28b7:2704:36cc]) by VI1PR08MB3760.eurprd08.prod.outlook.com
 ([fe80::39df:28b7:2704:36cc%7]) with mapi id 15.20.2115.005; Tue, 30 Jul 2019
 14:45:55 +0000
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com"
 <mreitz@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>
Thread-Topic: [Qemu-devel] [PATCH v2 0/3] add zstd cluster compression
Thread-Index: AQHVMmomDcJsRQ8pz0G55mjwXrsq+abjZhaA
Date: Tue, 30 Jul 2019 14:45:55 +0000
Message-ID: <99CF1695-466B-4F46-83C7-50E9A5847519@getmailspring.com>
References: <20190704130949.14017-1-dplotnikov@virtuozzo.com>
In-Reply-To: <20190704130949.14017-1-dplotnikov@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0102CA0038.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::15) To VI1PR08MB3760.eurprd08.prod.outlook.com
 (2603:10a6:803:b9::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Mailspring
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1ea28a0-c82f-46e5-3281-08d714fca041
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:VI1PR08MB3872; 
x-ms-traffictypediagnostic: VI1PR08MB3872:
x-microsoft-antispam-prvs: <VI1PR08MB387272B1B48EAB4EA6579CE1CFDC0@VI1PR08MB3872.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0114FF88F6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(39850400004)(346002)(376002)(366004)(136003)(54534003)(53754006)(199004)(189003)(14454004)(2201001)(36756003)(5660300002)(71200400001)(229853002)(102836004)(476003)(733005)(71190400001)(316002)(99286004)(6436002)(76176011)(86362001)(486006)(54906003)(6486002)(110136005)(68736007)(66446008)(26005)(186003)(305945005)(7736002)(478600001)(25786009)(11346002)(446003)(66476007)(66556008)(64756008)(66946007)(52116002)(81166006)(81156014)(8676002)(9686003)(33656002)(66066001)(3846002)(6116002)(6512007)(8936002)(256004)(53936002)(3736002)(6306002)(2501003)(50226002)(4326008)(386003)(6506007)(18926415008)(6246003)(2906002)(54896002)(19627235002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB3872;
 H:VI1PR08MB3760.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xmooacZHhh1n2cCeacuKIlPK3WQ4dFFBE5Js5ORKZ+vS7xwMR3k9EKoP6zZXZwULoe6s7HGqpkXYKsjgOsoCuDUhwhHQb5Jxb0bYDAfqESfonhImac7L75GymV2+7RHsQBvvdKg7jIyeVkFfo9N34byA2zFWOqSbadwR+xcUs7/WGxxODOSyt8272qfkYP0eKgduyrqZy1Fh1nOEFyJQxKI7sgkZF9hhNa6RBuInmuUbOL2MxlKEaj26hef4u2j+rqfuidYRnvz5dpGXJ8tLxjPyoI7PpNxZxGKAxuH1D3LTN3aG1+GVHKLuj0O37jypJqXYmqYB5FJxy6BAO+bDy/4QcVAGxEMt8V2gL8ZP0ZwcSXGFROMFU11nqhAUPlYVIL3J2kIdFVfo5+Ci8Lyuq6RtaBNgdGDacNtjTnxpovQ=
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ea28a0-c82f-46e5-3281-08d714fca041
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2019 14:45:55.0545 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dplotnikov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3872
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.120
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v2 0/3] add zstd cluster compression
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgYWxsISBJcyB0aGVyZSBhbnkgb3RoZXIgY29tbWVudHMgYmVzaWRlcyBNYXJrdXMncyBvbmUg
YWJvdXQgYWRkaW5nIHpsaWIvenN0ZCBsaW5rcyB0byBjb21wcmVzc2VkIGNsdXN0ZXIgbGF5b3V0
IGRlc2NyaXB0aW9uPw0KDQpPbiBKdWwgNCAyMDE5LCBhdCA0OjA5IHBtLCBEZW5pcyBQbG90bmlr
b3YgPGRwbG90bmlrb3ZAdmlydHVvenpvLmNvbT4gd3JvdGU6DQpjaGFuZ2UgbG9nOg0KDQp2MjoN
CiogcmVsYXggdGhlIGNvbXByZXNzaW9uIHR5cGUgc2V0dGluZyByZXN0cmljdGlvbiBpbiB0aGUg
c3BlYw0KKiBmaXggcWNvdzIgaGVhZGVyIHNpemUgY2hlY2tpbmcNCiogZml4IGVycm9yIHByb2Nl
c3NpbmcgYW5kIG1lc3NhZ2luZw0KKiBmaXggcWNvdzIgaW1hZ2Ugc3BlY2lmaWMgaW5mbyByZXBv
cnRpbmcNCiogc2V0IFFjb3cyQ29tcHJlc3Npb25UeXBlIHpzdGQgY29uZmlnIGRlcGVuZGFudA0K
KiBhZGQgenN0ZCBjb21wcmVzc2VkIGNsdXN0ZXIgZm9ybWF0IGRlc2NyaXB0aW9uIHRvIHRoZSBz
cGVjDQoNCnYxOg0KKiBleHRlbmQgcWNvdzIgaGVhZGVyIGluc3RlYWQgb2YgYWRkaW5nIGEgbmV3
IGluY29tcGF0aWJsZSBleHRlbnNpb24gaGVhZGVyDQpzcGVjaWZpY2F0aW9uIHJlLXdyaXR0ZW4g
YWNjb3JkaW5nbHkNCiogZW5hYmxlIHpzdGQgY29tcHJlc3Npb24gdmlhIGNvbmZpZw0KKiBmaXgg
enN0ZCAoZGUpY29tcHJlc3Npb24gZnVuY3Rpb25zDQoqIGZpeCBjb21tZW50cy9kZXNjcmlwdGlv
bg0KKiBmaXggZnVuY3Rpb24gbmFtaW5nDQoNCi0tLQ0KVGhlIGdvYWwgb2YgdGhlIHBhdGNoLXNl
dCBpcyB0byBlbmFibGUgcWNvdzIgdG8gdXNlIHpzdGQgY29tcHJlc3Npb24gZm9yDQpjbHVzdGVy
cy4gWlNURCBwcm92aWRlcyBiZXR0ZXIgKGRlKWNvbXByZXNzaW9uIHBlcmZvcm1hbmNlIHRoYW4g
Y3VycmVudGx5DQp1c2VkIFpMSUIuIFVzaW5nIGl0IHdpbGwgaW1wcm92ZSBwZXJmb3JhbW5jZSAo
cmVkdWNlIGNvbXByZXNzaW9uIHRpbWUpDQp3aGVuIHRoZSBjb21wcmVzc2VkIGNsdXN0ZXJzIGlz
IHVzZWQsIGUuZyBiYWNrdXAgc2NlbmFyaW9zLg0KDQpBbHNvLCB0aGUgcGF0Y2gtc2V0IGV4dGVu
ZHMgcWNvdzIgc3BlY2lmaWNhdGlvbiBieSBhZGRpbmcgY29tcHJlc3Npb25fdHlwZQ0KZmVhdHVy
ZS4gVGhlIGZlYXR1cmUgZW5hYmxlcyBhZGRpbmcgWlNURCBhbmQgYW5vdGhlciBjb21wcmVzc2lv
biBhbGdvcml0aG1zDQppbiB0aGUgZnV0dXJlLg0KDQpIZXJlIGlzIHNvbWUgbWVhc3VyZW1lbnRz
IFpTVEQgdnMgWkxJQjoNCg0KVGhlIHRlc3Q6DQpUZXN0IGNvbXByZXNzZXMgYW5kIGRlY29tcHJl
c3NlcyBxZW11IHFjb3cyIGltYWdlIHdpdGgganVzdA0KaW5zdGFsbGVkIHJoZWwtNy42IGd1ZXN0
Lg0KSW1hZ2UgY2x1c3RlciBzaXplOiA2NEsuIEltYWdlIG9uIGRpc2sgc2l6ZTogMi4yRw0KDQpU
aGUgdGVzdCB3YXMgY29uZHVjdGVkIHdpdGggYnJkIGRpc2sgdG8gcmVkdWNlIHRoZSBpbmZsdWVu
Y2UNCm9mIGRpc2sgc3Vic3lzdGVtIHRvIHRoZSB0ZXN0IHJlc3VsdHMuDQpUaGUgcmVzdWx0cyBp
cyBnaXZlbiBpbiBzZWNvbmRzLg0KDQpjb21wcmVzcyBjbWQ6DQp0aW1lIC4vcWVtdS1pbWcgY29u
dmVydCAtTyBxY293MiAtYyAtbyBjb21wcmVzc2lvbl90eXBlPVt6bGlifHpzdGRdDQpzcmMuaW1n
IFt6bGlifHpzdGRdX2NvbXByZXNzZWQuaW1nDQpkZWNvbXByZXNzIGNtZA0KdGltZSAuL3FlbXUt
aW1nIGNvbnZlcnQgLU8gcWNvdzINClt6bGlifHpzdGRdX2NvbXByZXNzZWQuaW1nIHVuY29tcHJl
c3NlZC5pbWcNCg0KDQpUaGUgcmVzdWx0czoNCmNvbXByZXNzaW9uIGRlY29tcHJlc3Npb24NCnps
aWIgenN0ZCB6bGliIHpzdGQNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KcmVhbCA2NS41IDE2LjMgKC03NSAlKSAxLjkgMS42ICgt
MTYgJSkNCnVzZXIgNjUuMCAxNS44IDUuMyAyLjUNCnN5cyAzLjMgMC4yIDIuMCAyLjANCg0KQm90
aCBaTElCIGFuZCBaU1REIGdhdmUgdGhlIHNhbWUgY29tcHJlc3Npb24gcmF0aW86IH4xLjUNCmNv
bXByZXNzZWQgaW1hZ2Ugc2l6ZSBpbiBib3RoIGNhc2VzOiB+MS40Rw0KDQpEZW5pcyBQbG90bmlr
b3YgKDMpOg0KcWNvdzI6IGludHJvZHVjZSBjb21wcmVzc2lvbiB0eXBlIGZlYXR1cmUNCnFjb3cy
OiByZXdvcmsgdGhlIGNsdXN0ZXIgY29tcHJlc3Npb24gcm91dGluZQ0KcWNvdzI6IGFkZCB6c3Rk
IGNsdXN0ZXIgY29tcHJlc3Npb24NCg0KYmxvY2svcWNvdzIuYyB8IDI4NyArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKy0tLQ0KYmxvY2svcWNvdzIuaCB8IDI2ICsrKy0NCmNvbmZp
Z3VyZSB8IDMyICsrKysrDQpkb2NzL2ludGVyb3AvcWNvdzIudHh0IHwgNDAgKysrKystDQppbmNs
dWRlL2Jsb2NrL2Jsb2NrX2ludC5oIHwgMSArDQpxYXBpL2Jsb2NrLWNvcmUuanNvbiB8IDIzICsr
LQ0KNiBmaWxlcyBjaGFuZ2VkLCAzNzkgaW5zZXJ0aW9ucygrKSwgMzAgZGVsZXRpb25zKC0pDQoN
Ci0tDQoyLjE3LjANCg0K
