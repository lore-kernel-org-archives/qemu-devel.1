Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784CCC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 13:09:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 330D5207FF
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 13:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="pPe67wjm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 330D5207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDq03-0008ER-2a
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 09:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53011)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iDpme-0005ZL-G9
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 08:55:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iDpma-00021J-7B
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 08:55:38 -0400
Received: from mail-eopbgr150134.outbound.protection.outlook.com
 ([40.107.15.134]:47589 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iDpmZ-000218-TP; Fri, 27 Sep 2019 08:55:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LgoVl7AXdIQDJii3AyBsiCbMV9BPr5OuGABtH23LDQrbu2ILzrnRRupR3PN/P8YqAYjw9JE4cLlB5T5QH2lkLjcYSFH25HrzLFwC5Xd0g/PfnrfDlmgB8/isoX+iUgw57q0mQz5hZ+nalhIXqlUeC+SxMw759weGDH4Vv3neJQ/NE3MUchi0kgF2RPVifytHCPGFCzxMLMO3xT/Jnm566X1bDK1llBOYe+xhNTCeu7hbr05Shs1fMtITTgSl4SA7bEc4vOYx7wtYhzqPbl1aq4J1QRMPpEu8p5M4GsoAQci7RC4OEYuDAMAhQJRd7IO+mhK3/ZCyyHHr5u/9e6DHog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHzry6Ly3ZmnTeQtXLOKy1ZK/2FTOd8TKX9iBphKcJQ=;
 b=lqHSZMYYoaB+cuAQDEosPKQjINb2+cWkci7OVEqSzfhpRn4m4VFCslq648lRGZqqlrJvY7XXoTqp/pbJilCVQkZpMvMXaSzYvEkd/vgknizBi0IY+AyLHSamWCtjWwpZfpnAYPH7cDd6GoMeKsF/N7NoU56pYMty3Yx+mB88WiSBdHYDOsfJawiykf92B/4gORL6y/iBc674KA5ciTHzYEqZwaYi5jBqz1PGe5cNzeUBuzQ2/D46OM1iNcyyVbPR7N+ikVtkNVZdLC/Osa1bDDpWu2ScnrSc8hd3WeipgpiJ3TIiyB00ycr8AMTKRuR0bfFPxuKC45tdY4eQFEBU0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHzry6Ly3ZmnTeQtXLOKy1ZK/2FTOd8TKX9iBphKcJQ=;
 b=pPe67wjmoLUYsfOcWC1bDjBJ7bqb/wpJm5hTopRFwOV15gibYNlOzFFWMI3pIRtygFyxI6iRgRwv47AsMJVwBOFPea3KQ/hF+GqAih+HG0b+DHbpJZ4bNDoN2natqn9uW+XqGqtsZeT9b4sxr4p6+4Ohesb1CQ2b9YbmeccCRNE=
Received: from AM0PR08MB5491.eurprd08.prod.outlook.com (52.132.215.9) by
 AM0PR08MB3938.eurprd08.prod.outlook.com (20.178.117.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Fri, 27 Sep 2019 10:22:25 +0000
Received: from AM0PR08MB5491.eurprd08.prod.outlook.com
 ([fe80::d552:8bd7:4773:3d75]) by AM0PR08MB5491.eurprd08.prod.outlook.com
 ([fe80::d552:8bd7:4773:3d75%2]) with mapi id 15.20.2305.017; Fri, 27 Sep 2019
 10:22:25 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [Qemu-devel] [PATCH v4 03/10] iotests: add test-case to 165 to
 test reopening qcow2 bitmaps to RW
Thread-Topic: [Qemu-devel] [PATCH v4 03/10] iotests: add test-case to 165 to
 test reopening qcow2 bitmaps to RW
Thread-Index: AQHVTSopNDU5oGi3VU6xm0/sCJBvxac+4RqAgACO6YCAADCOAA==
Date: Fri, 27 Sep 2019 10:22:25 +0000
Message-ID: <6a69ee68-7fc6-4a3b-614e-1ed85a27d58c@virtuozzo.com>
References: <20190807141226.193501-1-vsementsov@virtuozzo.com>
 <20190807141226.193501-4-vsementsov@virtuozzo.com>
 <6c308090-5841-fcba-d319-8b9d65b7d6b8@redhat.com>
 <0db3ca38-65db-c224-e718-210bb910116b@virtuozzo.com>
In-Reply-To: <0db3ca38-65db-c224-e718-210bb910116b@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P189CA0035.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::48)
 To AM0PR08MB5491.eurprd08.prod.outlook.com
 (2603:10a6:208:189::9)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190927132222692
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 33a6c789-3991-4183-4cbf-08d743349739
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:AM0PR08MB3938; 
x-ms-traffictypediagnostic: AM0PR08MB3938:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB3938E261A2B784170895EABCC1810@AM0PR08MB3938.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-forefront-prvs: 0173C6D4D5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(136003)(39850400004)(396003)(366004)(189003)(199004)(81156014)(3846002)(81166006)(110136005)(54906003)(8676002)(2501003)(2906002)(25786009)(86362001)(2616005)(476003)(6512007)(36756003)(8936002)(316002)(4326008)(71190400001)(305945005)(31686004)(71200400001)(66946007)(14444005)(256004)(31696002)(66476007)(66556008)(64756008)(66446008)(26005)(99286004)(7736002)(6246003)(52116002)(76176011)(6506007)(53546011)(478600001)(102836004)(386003)(6436002)(66066001)(6486002)(6116002)(186003)(446003)(486006)(11346002)(14454004)(5660300002)(107886003)(229853002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3938;
 H:AM0PR08MB5491.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rgmaBN/aEP6kaMMds4FDp6zi1VZ8h4En4zyxb5bQdcZhB9VrYoU3/eqQwpxmQnFlI3s10fRMI887bKLFCZOW2fqiymiwvlUtNTAP22UjvDvehzULl+GpZKp+AtTyvWo5dNrK8VT7r/UhniuX+sFvpsAMJHuaQF4bEZlDwbrYXq67C9C719NjXBX3MDyp0cvr/n3dCok2Uv8OqNr9SVwqQWS/LZBymQnQn3rLTbgdEShnpqLqToE3ZdbX8ge7RYSuVF1HOvsy2FOBuh3tuq2CYSbCuPsz0bO/LuvpvJ4IRhY4NbcOc7JCftHQ7Fb16NbRj+lTpAiY9QV+42XtEnPBXGSFl5eNooQO8QmZmhGnUfwDQTAsI9ObiaflCOt4y0NqtZWI3OAShsIVdj0E5pXwbjFiBnWy6rySXN6VTm3rcRE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <594F4377C3BAB443B624930DD75D38A8@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a6c789-3991-4183-4cbf-08d743349739
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2019 10:22:25.2000 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9KMQTAi2AlvmN4enudFNxi8yW0/N/QnXBSlVW6xHatW4K6UBstr0BiBsmxs68csNIvU5i7SrWaOaTXrMLAvVYIsp1b/7YSbZ2DTt3Q4GTA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3938
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.134
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjcuMDkuMjAxOSAxMDoyOCwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
MjcuMDkuMjAxOSAxOjU3LCBKb2huIFNub3cgd3JvdGU6DQo+Pg0KPj4NCj4+IE9uIDgvNy8xOSAx
MDoxMiBBTSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+PiBSZW9wZW5p
bmcgYml0bWFwcyB0byBSVyB3YXMgYnJva2VuIHByaW9yIHRvIHByZXZpb3VzIGNvbW1pdC4gQ2hl
Y2sgdGhhdA0KPj4+IGl0IHdvcmtzIG5vdy4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IFZsYWRp
bWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4+PiAt
LS0NCj4+PiDCoCB0ZXN0cy9xZW11LWlvdGVzdHMvMTY1wqDCoMKgwqAgfCA0NiArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKystLQ0KPj4+IMKgIHRlc3RzL3FlbXUtaW90ZXN0cy8x
NjUub3V0IHzCoCA0ICsrLS0NCj4+PiDCoCAyIGZpbGVzIGNoYW5nZWQsIDQ2IGluc2VydGlvbnMo
KyksIDQgZGVsZXRpb25zKC0pDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvdGVzdHMvcWVtdS1pb3Rl
c3RzLzE2NSBiL3Rlc3RzL3FlbXUtaW90ZXN0cy8xNjUNCj4+PiBpbmRleCA4OGY2MmQzYzZkLi5k
ZDkzYjVhMmQwIDEwMDc1NQ0KPj4+IC0tLSBhL3Rlc3RzL3FlbXUtaW90ZXN0cy8xNjUNCj4+PiAr
KysgYi90ZXN0cy9xZW11LWlvdGVzdHMvMTY1DQo+Pj4gQEAgLTQzLDEwICs0MywxMCBAQCBjbGFz
cyBUZXN0UGVyc2lzdGVudERpcnR5Qml0bWFwKGlvdGVzdHMuUU1QVGVzdENhc2UpOg0KPj4+IMKg
wqDCoMKgwqDCoMKgwqDCoCBvcy5yZW1vdmUoZGlzaykNCj4+PiDCoMKgwqDCoMKgIGRlZiBta1Zt
KHNlbGYpOg0KPj4+IC3CoMKgwqDCoMKgwqDCoCByZXR1cm4gaW90ZXN0cy5WTSgpLmFkZF9kcml2
ZShkaXNrKQ0KPj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gaW90ZXN0cy5WTSgpLmFkZF9kcml2
ZShkaXNrLCBvcHRzPSdub2RlLW5hbWU9bm9kZTAnKQ0KPj4+IMKgwqDCoMKgwqAgZGVmIG1rVm1S
byhzZWxmKToNCj4+PiAtwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGlvdGVzdHMuVk0oKS5hZGRfZHJp
dmUoZGlzaywgb3B0cz0ncmVhZG9ubHk9b24nKQ0KPj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4g
aW90ZXN0cy5WTSgpLmFkZF9kcml2ZShkaXNrLCBvcHRzPSdyZWFkb25seT1vbixub2RlLW5hbWU9
bm9kZTAnKQ0KPj4+IMKgwqDCoMKgwqAgZGVmIGdldFNoYTI1NihzZWxmKToNCj4+PiDCoMKgwqDC
oMKgwqDCoMKgwqAgcmVzdWx0ID0gc2VsZi52bS5xbXAoJ3gtZGVidWctYmxvY2stZGlydHktYml0
bWFwLXNoYTI1NicsDQo+Pj4gQEAgLTEwMiw1ICsxMDIsNDcgQEAgY2xhc3MgVGVzdFBlcnNpc3Rl
bnREaXJ0eUJpdG1hcChpb3Rlc3RzLlFNUFRlc3RDYXNlKToNCj4+PiDCoMKgwqDCoMKgwqDCoMKg
wqAgc2VsZi52bS5zaHV0ZG93bigpDQo+Pj4gK8KgwqDCoCBkZWYgdGVzdF9yZW9wZW5fcncoc2Vs
Zik6DQo+Pj4gK8KgwqDCoMKgwqDCoMKgIHNlbGYudm0gPSBzZWxmLm1rVm0oKQ0KPj4+ICvCoMKg
wqDCoMKgwqDCoCBzZWxmLnZtLmxhdW5jaCgpDQo+Pj4gK8KgwqDCoMKgwqDCoMKgIHNlbGYucW1w
QWRkQml0bWFwKCkNCj4+PiArDQo+Pj4gK8KgwqDCoMKgwqDCoMKgICMgQ2FsY3VsYXRlIHNoYTI1
NiBjb3JyZXNwb25kaW5nIHRvIHJlZ2lvbnMxDQo+Pj4gK8KgwqDCoMKgwqDCoMKgIHNlbGYud3Jp
dGVSZWdpb25zKHJlZ2lvbnMxKQ0KPj4+ICvCoMKgwqDCoMKgwqDCoCBzaGEyNTYgPSBzZWxmLmdl
dFNoYTI1NigpDQo+Pj4gK8KgwqDCoMKgwqDCoMKgIHJlc3VsdCA9IHNlbGYudm0ucW1wKCdibG9j
ay1kaXJ0eS1iaXRtYXAtY2xlYXInLCBub2RlPSdkcml2ZTAnLA0KPj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBuYW1lPSdiaXRtYXAw
JykNCj4+PiArwqDCoMKgwqDCoMKgwqAgc2VsZi5hc3NlcnRfcW1wKHJlc3VsdCwgJ3JldHVybics
IHt9KQ0KPj4+ICsNCj4+PiArwqDCoMKgwqDCoMKgwqAgc2VsZi52bS5zaHV0ZG93bigpDQo+Pj4g
Kw0KPj4+ICvCoMKgwqDCoMKgwqDCoCBzZWxmLnZtID0gc2VsZi5ta1ZtUm8oKQ0KPj4+ICvCoMKg
wqDCoMKgwqDCoCBzZWxmLnZtLmxhdW5jaCgpDQo+Pj4gKw0KPj4+ICvCoMKgwqDCoMKgwqDCoCAj
IFdlJ3ZlIGxvYWRlZCBlbXB0eSBiaXRtYXANCj4+PiArwqDCoMKgwqDCoMKgwqAgYXNzZXJ0IHNo
YTI1NiAhPSBzZWxmLmdldFNoYTI1NigpDQo+Pj4gKw0KPj4+ICvCoMKgwqDCoMKgwqDCoCAjIENo
ZWNrIHRoYXQgd2UgYXJlIGluIFJPIG1vZGUNCj4+PiArwqDCoMKgwqDCoMKgwqAgc2VsZi53cml0
ZVJlZ2lvbnMocmVnaW9uczEpDQo+Pj4gK8KgwqDCoMKgwqDCoMKgIGFzc2VydCBzaGEyNTYgIT0g
c2VsZi5nZXRTaGEyNTYoKQ0KPj4+ICsNCj4+DQo+PiB0aGUgSE1QIG1vbml0b3IgbGV0cyB5b3Ug
YXR0ZW1wdCB3cml0ZXMgdG8gYSBSZWFkIE9ubHkgZHJpdmUuLi4/IE9yIGRvZXMNCj4+IGl0IGVy
cm9yIG91dCBhbmQgd2UganVzdCBkb24ndCBjaGVjayB0aGUgcmVwbHk/DQo+IA0KPiBJdCBtdXN0
IGZhaWwgYW5kIHdlIGNoZWNrIHRoaXMgYnkgY29tcGFyaW5nIGRpcnR5IGJpdG1hcCBoYXNoLg0K
PiANCj4+DQo+PiBJIHdvdWxkIHByZWZlciB3ZSB1c2UgYW4gYWN0dWFsIGRpcnR5IHNlY3RvciBj
b3VudCBoZXJlIGluc3RlYWQ7IHdlIGhhdmUNCj4+IHRoZSBuZXcgQVBJIHRoYXQgc2hvdWxkIG1h
a2UgaXQgZWFzeSB0byBkby4NCj4+DQo+PiBJZiB0aGUgZGVidWcgU0hBIGNoYW5nZXMgdGhpcyBt
aWdodCBiZSBhIGxpdHRsZSBmcmFnaWxlLg0KPiANCj4gSG1tLCBJIGFncmVlIHRoYXQgY2hlY2tp
bmcgdGhhdCBiaXRtYXAgaXMgZW1wdHkgYnkgY29tcGFyaW5nIHdpdGggc29tZSBoYXNoDQo+IGlz
IG5vdCB2ZXJ5IHJlbGlhYmxlLiBXaWxsIGRvLg0KPiANCj4+DQo+PiBBQ0sgb3RoZXJ3aXNlLg0K
Pj4NCj4+PiArwqDCoMKgwqDCoMKgwqAgcmVzdWx0ID0gc2VsZi52bS5xbXAoJ3gtYmxvY2tkZXYt
cmVvcGVuJywgKip7DQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJ25vZGUtbmFtZSc6ICdu
b2RlMCcsDQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJ2RyaXZlcic6IGlvdGVzdHMuaW1n
Zm10LA0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICdmaWxlJzogew0KPj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJ2RyaXZlcic6ICdmaWxlJywNCj4+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgICdmaWxlbmFtZSc6IGRpc2sNCj4+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB9LA0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICdyZWFkLW9ubHknOiBG
YWxzZQ0KPj4+ICvCoMKgwqDCoMKgwqDCoCB9KQ0KPj4+ICvCoMKgwqDCoMKgwqDCoCBzZWxmLmFz
c2VydF9xbXAocmVzdWx0LCAncmV0dXJuJywge30pDQo+Pj4gKw0KPj4+ICvCoMKgwqDCoMKgwqDC
oCAjIENoZWNrIHRoYXQgYml0bWFwIGlzIHJlb3BlbmVkIHRvIFJXIGFuZCB3ZSBjYW4gd3JpdGUg
dG8gaXQuDQo+Pj4gK8KgwqDCoMKgwqDCoMKgIHNlbGYud3JpdGVSZWdpb25zKHJlZ2lvbnMxKQ0K
Pj4+ICvCoMKgwqDCoMKgwqDCoCBhc3NlcnQgc2hhMjU2ID09IHNlbGYuZ2V0U2hhMjU2KCkNCj4+
PiArDQo+Pj4gK8KgwqDCoMKgwqDCoMKgIHNlbGYudm0uc2h1dGRvd24oKQ0KPj4+ICsNCj4+PiAr
DQo+Pj4gwqAgaWYgX19uYW1lX18gPT0gJ19fbWFpbl9fJzoNCj4+PiDCoMKgwqDCoMKgIGlvdGVz
dHMubWFpbihzdXBwb3J0ZWRfZm10cz1bJ3Fjb3cyJ10pDQo+Pj4gZGlmZiAtLWdpdCBhL3Rlc3Rz
L3FlbXUtaW90ZXN0cy8xNjUub3V0IGIvdGVzdHMvcWVtdS1pb3Rlc3RzLzE2NS5vdXQNCj4+PiBp
bmRleCBhZTEyMTNlNmY4Li5mYmM2M2U2MmY4IDEwMDY0NA0KPj4+IC0tLSBhL3Rlc3RzL3FlbXUt
aW90ZXN0cy8xNjUub3V0DQo+Pj4gKysrIGIvdGVzdHMvcWVtdS1pb3Rlc3RzLzE2NS5vdXQNCj4+
PiBAQCAtMSw1ICsxLDUgQEANCj4+PiAtLg0KPj4+ICsuLg0KPj4+IMKgIC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0N
Cj4+PiAtUmFuIDEgdGVzdHMNCj4+PiArUmFuIDIgdGVzdHMNCj4+PiDCoCBPSw0KPj4+DQo+Pg0K
Pj4gVGhpcyBpcyBhIHN1Z2dlc3Rpb24gZm9yIGFuIGV2ZW4gbW9yZSByaWdvcm91cyB0ZXN0Og0K
Pj4NCj4+IC0gQ3JlYXRlIGJpdG1hcA0KPj4gLSBXcml0ZSBhIHJlZ2lvbiBvciB0d28NCj4+IC0g
UmVjb3JkIHRoZSBkaXJ0eSBjb3VudCBhbmQgdGhlIFNIQTsgYXNzZXJ0IGl0IGlzIGVxdWFsIHRv
IGtub3duIC8NCg0KU3RpbGwsIEkgZG9uJ3QgdGhpbmsgd2UgbmVlZCB0byBjaGVjayBjb3VudCwg
aWYgd2UgY2hlY2sgU0hBLg0KDQo+PiBwcmVkZXRlcm1pbmVkIHZhbHVlcy4NCj4+IC0gcmVvcGVu
IFJPDQo+PiAtIHZlcmlmeSB0aGUgYml0bWFwIHN0aWxsIGV4aXN0cyBhbmQgdGhhdCB0aGUgaGFz
aCBhbmQgY291bnQgYXJlIHRoZSBzYW1lLg0KPj4gLSBTdG9wIHRoZSBWTQ0KPj4gLSBTdGFydCB0
aGUgVk0gaW4gcmVhZG9ubHkgbW9kZQ0KPj4gLSB2ZXJpZnkgdGhlIGJpdG1hcCBzdGlsbCBleGlz
dHMgYW5kIHRoYXQgdGhlIGhhc2ggYW5kIGNvdW50IGFyZSB0aGUgc2FtZS4NCj4+IC0gUmVvcGVu
LVJXDQo+PiAtIHZlcmlmeSB0aGUgYml0bWFwIHN0aWxsIGV4aXN0cyBhbmQgdGhhdCB0aGUgaGFz
aCBhbmQgY291bnQgYXJlIHRoZSBzYW1lLg0KPj4gLSBXcml0ZSBmdXJ0aGVyIHJlZ2lvbihzKQ0K
Pj4gLSBHZXQgdGhlIG5ldyBkaXJ0eSBjb3VudCBhbmQgU0hBLCBhbmQgYXNzZXJ0IGl0IGlzIGVx
dWFsIHRvIGtub3duIC8NCj4+IHByZWRldGVybWluZWQgdmFsdWVzLg0KPj4NCj4gDQo+IE9LDQo+
IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

