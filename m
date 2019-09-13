Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14085C4CEC8
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 18:26:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3C46206A5
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 18:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="tBSDHAHw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3C46206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8qHQ-0004Nw-RA
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 14:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50820)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i8qGf-0003sG-Mw
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 14:26:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i8qGe-0003LQ-7T
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 14:26:01 -0400
Received: from mail-eopbgr130124.outbound.protection.outlook.com
 ([40.107.13.124]:33937 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i8qGd-0003KF-GZ; Fri, 13 Sep 2019 14:26:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kOQoFCBOT8A76vIzNRB0jU8agNmdCg/MIrHKda93KwEb7YzEqud86vVcy5Q+wM4KTuXVS7BkWqPr94AcTjtS8aIwiUzXpTGr6gAdltvIBeRsl5Kr34GtuYWvFzoR2hNaJS0lyn3Lc3msbei5TW5edOvHWisi8SAFQnB1tFk+jGY68ulLRIxXBINjdScVxhZd7b3q9NLU8G1ExguW29WgVc6RZyCFh8cJ3jCKt2tJ1V0oaX+KONE811CWnSG1qJKkFQQSv8fnPsjZaC8c3mx6w4UrfmAQo/VUVYM8CFcnAXNL54Ebvk5BPeP/rvnvhpIOzqK790SEUnUClBIJfEanhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQi3kG9r/XxFIOUQ6FgZC/TKjKlfSHr4wbA80T7JEww=;
 b=LUVcHj6dg8M1Mm1CaxR1Er78wtqiVUWcd8fXTLkaXe6mIO/qamKq+1C865H4wJUqyuXV+3HoYBaOiE+SQVMTa0JVEUYP8BUDZc+ah6EN0bsygJ8KABP9OANr7hVifDcBeTCwCCMeYSVtqRi1JP09cOMaKPPu87MlAt015EYYfuR46tgAbJi4CAm+IhlnYPy0uwGAT1OasM05gtQZ+vTwxGLtCtxc5gz8+7CJ0hOa6qYU9fLb9sxcnz2+Fqw3w7dN5DWyAgmePeHHcR3laPa5wbpgE/eyloqxPI1TjvxqUYFoZ3qWVp6EEPIZpcWNNEfgmqic5w1ldmW6zb1kwEQ+Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQi3kG9r/XxFIOUQ6FgZC/TKjKlfSHr4wbA80T7JEww=;
 b=tBSDHAHwEai++ambNYZVoBHIO9S7RYAh8hAHpqwG1WtPfyPJbBifY3IAutWArPd9NaN4SW+o93xQLKf2j5iKDPM++0m4jBUZbVb/l7KtzE5az/gght0m5pUJGKVmpZsbBIhXUW0Tnx/VZ3qWvh6tJgazgYbyipauClXPQ05cEvU=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5244.eurprd08.prod.outlook.com (10.255.17.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.18; Fri, 13 Sep 2019 18:25:56 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2263.016; Fri, 13 Sep 2019
 18:25:56 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v11 04/14] block/backup: introduce BlockCopyState
Thread-Index: AQHVZ8HWULZDkPZpMke6HdjhrfznqKcp8daA
Date: Fri, 13 Sep 2019 18:25:56 +0000
Message-ID: <bafea6c6-38cc-1848-92ea-ec891457515a@virtuozzo.com>
References: <20190910102332.20560-1-vsementsov@virtuozzo.com>
 <20190910102332.20560-5-vsementsov@virtuozzo.com>
In-Reply-To: <20190910102332.20560-5-vsementsov@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0226.eurprd05.prod.outlook.com
 (2603:10a6:3:fa::26) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190913212553627
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5cfae784-806b-474a-dad3-08d73877d160
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5244; 
x-ms-traffictypediagnostic: DB8PR08MB5244:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB5244BB806868CEEDAF125B9BC1B30@DB8PR08MB5244.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:42;
x-forefront-prvs: 0159AC2B97
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(346002)(136003)(376002)(39850400004)(189003)(199004)(305945005)(66946007)(6506007)(476003)(5660300002)(486006)(71200400001)(31686004)(6486002)(386003)(2616005)(76176011)(7736002)(7416002)(3846002)(71190400001)(66476007)(446003)(11346002)(2906002)(81166006)(66556008)(2351001)(8676002)(81156014)(64756008)(102836004)(229853002)(26005)(8936002)(66446008)(186003)(6916009)(52116002)(99286004)(107886003)(86362001)(36756003)(478600001)(2501003)(14454004)(53936002)(6116002)(6436002)(14444005)(6246003)(256004)(5640700003)(4326008)(316002)(66066001)(6512007)(54906003)(25786009)(31696002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5244;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9gK5i3ImcBs53sqE+tt7ygGkedtUvcQyi3nHCUIJq2lOqA/AFHs7tr6kXre+8KI1AjOUpGsngJN0sEJZQC0P6Rqqsir9Rrs6Yr761ERH8Z42vFFzey9K/ySz2k+3INQFg/ePsj0fhkJ5U8Xo4KU94dsW4rgH73j11uMCrdpoy/PDzEYfO1fGpXoBXK/SCZ7oGYOTk4prmRYaVoAcfI0/1rKzoHCfeX/2mMtmjWphOxN7tGE5QqdyyKfqUgJR2QYbu4nZy5ZLfQ3DSfWPkBM7JcCzfM2OVuIv7aSaMCAql1LSSL1WXnhTCIAwCf3BX18QiE8DNms2uTvIrWD/AZV7sZ9jGHc935GnG/DmNjImHJ2va1pUH8b0Ayh8t9f3lakIN5otnvLuQjmrGfCvsTTBjz5IbL4Dx7X6xVBWaoG4w1o=
Content-Type: text/plain; charset="utf-8"
Content-ID: <68A2E29C8538524D89692CB6312212E1@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cfae784-806b-474a-dad3-08d73877d160
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2019 18:25:56.2935 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9laShDq8ODgcwW5okFP+CdURRMcoJXjeJvVLgSlvlGS9URO2WlK43bTanREH5YiwqxGSy+ynMGPkYuQO+5pwxMumz8KUpWd+JxbrsjbY7GU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5244
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.124
Subject: Re: [Qemu-devel] [PATCH v11 04/14] block/backup: introduce
 BlockCopyState
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
 "wencongyang2@huawei.com" <wencongyang2@huawei.com>,
 "xiechanglong.d@gmail.com" <xiechanglong.d@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTAuMDkuMjAxOSAxMzoyMywgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
U3BsaXQgY29weWluZyBjb2RlIHBhcnQgZnJvbSBiYWNrdXAgdG8gImJsb2NrLWNvcHkiLCBpbmNs
dWRpbmcgc2VwYXJhdGUNCj4gc3RhdGUgc3RydWN0dXJlIGFuZCBmdW5jdGlvbiByZW5hbWluZy4g
VGhpcyBpcyBuZWVkZWQgdG8gc2hhcmUgaXQgd2l0aA0KPiBiYWNrdXAtdG9wIGZpbHRlciBkcml2
ZXIgaW4gZnVydGhlciBjb21taXRzLg0KPiANCj4gTm90ZXM6DQo+IA0KPiAxLiBBcyBCbG9ja0Nv
cHlTdGF0ZSBrZWVwcyBvd24gQmxvY2tCYWNrZW5kIG9iamVjdHMsIHJlbWFpbmluZw0KPiBqb2It
PmNvbW1vbi5ibGsgdXNlcnMgb25seSB1c2UgaXQgdG8gZ2V0IGJzIGJ5IGJsa19icygpIGNhbGws
IHNvIGNsZWFyDQo+IGpvYi0+Y29tbWVuLmJsayBwZXJtaXNzaW9ucyBzZXQgaW4gYmxvY2tfam9i
X2NyZWF0ZSBhbmQgYWRkDQo+IGpvYi0+c291cmNlX2JzIHRvIGJlIHVzZWQgaW5zdGVhZCBvZiBi
bGtfYnMoam9iLT5jb21tb24uYmxrKSwgdG8ga2VlcA0KPiBpdCBtb3JlIGNsZWFyIHdoaWNoIGJz
IHdlIHVzZSB3aGVuIGludHJvZHVjZSBiYWNrdXAtdG9wIGZpbHRlciBpbg0KPiBmdXJ0aGVyIGNv
bW1pdC4NCj4gDQo+IDIuIFJlbmFtZSBzL2luaXRpYWxpemluZ19iaXRtYXAvc2tpcF91bmFsbG9j
YXRlZC8gdG8gc291bmQgYSBiaXQgYmV0dGVyDQo+IGFzIGludGVyZmFjZSB0byBCbG9ja0NvcHlT
dGF0ZQ0KPiANCj4gMy4gU3BsaXQgaXMgbm90IHZlcnkgY2xlYW46IHRoZXJlIGxlZnQgc29tZSBk
dXBsaWNhdGVkIGZpZWxkcywgYmFja3VwDQo+IGNvZGUgdXNlcyBzb21lIEJsb2NrQ29weVN0YXRl
IGZpZWxkcyBkaXJlY3RseSwgbGV0J3MgcG9zdHBvbmUgaXQgZm9yDQo+IGZ1cnRoZXIgaW1wcm92
ZW1lbnRzIGFuZCBrZWVwIHRoaXMgY29tbWVudCBzaW1wbGVyIGZvciByZXZpZXcuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZp
cnR1b3p6by5jb20+DQo+IC0tLQ0KDQoNClsuLl0NCg0KPiArDQo+ICtzdGF0aWMgQmxvY2tDb3B5
U3RhdGUgKmJsb2NrX2NvcHlfc3RhdGVfbmV3KA0KPiArICAgICAgICBCbG9ja0RyaXZlclN0YXRl
ICpzb3VyY2UsIEJsb2NrRHJpdmVyU3RhdGUgKnRhcmdldCwNCj4gKyAgICAgICAgaW50NjRfdCBj
bHVzdGVyX3NpemUsIEJkcnZSZXF1ZXN0RmxhZ3Mgd3JpdGVfZmxhZ3MsDQo+ICsgICAgICAgIFBy
b2dyZXNzQnl0ZXNDYWxsYmFja0Z1bmMgcHJvZ3Jlc3NfYnl0ZXNfY2FsbGJhY2ssDQo+ICsgICAg
ICAgIFByb2dyZXNzUmVzZXRDYWxsYmFja0Z1bmMgcHJvZ3Jlc3NfcmVzZXRfY2FsbGJhY2ssDQo+
ICsgICAgICAgIHZvaWQgKnByb2dyZXNzX29wYXF1ZSwgRXJyb3IgKiplcnJwKQ0KPiArew0KPiAr
ICAgIEJsb2NrQ29weVN0YXRlICpzOw0KPiArICAgIGludCByZXQ7DQo+ICsgICAgdWludDY0X3Qg
bm9fcmVzaXplID0gQkxLX1BFUk1fQ09OU0lTVEVOVF9SRUFEIHwgQkxLX1BFUk1fV1JJVEUgfA0K
PiArICAgICAgICAgICAgICAgICAgICAgICAgIEJMS19QRVJNX1dSSVRFX1VOQ0hBTkdFRCB8IEJM
S19QRVJNX0dSQVBIX01PRDsNCj4gKyAgICBCZHJ2RGlydHlCaXRtYXAgKmNvcHlfYml0bWFwOw0K
PiArDQo+ICsgICAgY29weV9iaXRtYXAgPSBiZHJ2X2NyZWF0ZV9kaXJ0eV9iaXRtYXAoc291cmNl
LCBjbHVzdGVyX3NpemUsIE5VTEwsIGVycnApOw0KPiArICAgIGlmICghY29weV9iaXRtYXApIHsN
Cj4gKyAgICAgICAgcmV0dXJuIE5VTEw7DQo+ICsgICAgfQ0KPiArICAgIGJkcnZfZGlzYWJsZV9k
aXJ0eV9iaXRtYXAoY29weV9iaXRtYXApOw0KPiArDQo+ICsgICAgcyA9IGdfbmV3KEJsb2NrQ29w
eVN0YXRlLCAxKTsNCj4gKyAgICAqcyA9IChCbG9ja0NvcHlTdGF0ZSkgew0KPiArICAgICAgICAu
c291cmNlID0gYmxrX25ldyhiZHJ2X2dldF9haW9fY29udGV4dChzb3VyY2UpLA0KPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICBCTEtfUEVSTV9DT05TSVNURU5UX1JFQUQsIG5vX3Jlc2l6ZSks
DQo+ICsgICAgICAgIC50YXJnZXQgPSBibGtfbmV3KGJkcnZfZ2V0X2Fpb19jb250ZXh0KHRhcmdl
dCksDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgIEJMS19QRVJNX1dSSVRFLCBub19yZXNp
emUpLA0KPiArICAgICAgICAuY29weV9iaXRtYXAgPSBjb3B5X2JpdG1hcCwNCj4gKyAgICAgICAg
LmNsdXN0ZXJfc2l6ZSA9IGNsdXN0ZXJfc2l6ZSwNCj4gKyAgICAgICAgLmxlbiA9IGJkcnZfZGly
dHlfYml0bWFwX3NpemUoY29weV9iaXRtYXApLA0KPiArICAgICAgICAud3JpdGVfZmxhZ3MgPSB3
cml0ZV9mbGFncywNCj4gKyAgICAgICAgLnVzZV9jb3B5X3JhbmdlID0gISh3cml0ZV9mbGFncyAm
IEJEUlZfUkVRX1dSSVRFX0NPTVBSRVNTRUQpLA0KPiArICAgICAgICAucHJvZ3Jlc3NfYnl0ZXNf
Y2FsbGJhY2sgPSBwcm9ncmVzc19ieXRlc19jYWxsYmFjaywNCj4gKyAgICAgICAgLnByb2dyZXNz
X3Jlc2V0X2NhbGxiYWNrID0gcHJvZ3Jlc3NfcmVzZXRfY2FsbGJhY2ssDQo+ICsgICAgICAgIC5w
cm9ncmVzc19vcGFxdWUgPSBwcm9ncmVzc19vcGFxdWUsDQo+ICsgICAgfTsNCj4gKw0KPiArICAg
IHMtPmNvcHlfcmFuZ2Vfc2l6ZSA9IFFFTVVfQUxJR05fVVAoTUlOKGJsa19nZXRfbWF4X3RyYW5z
ZmVyKHMtPnNvdXJjZSksDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgYmxrX2dldF9tYXhfdHJhbnNmZXIocy0+dGFyZ2V0KSksDQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBzLT5jbHVzdGVyX3NpemUpOw0KDQpwcmVleGlzdGVu
dCwgYnV0IGl0IG9idmlvdXNseSBzaG91bGQgYmUgUUVNVV9BTElHTl9ET1dOLiBJIGNhbiByZXNl
bmQgd2l0aCBhIHNlcGFyYXRlDQpmaXgsIGl0IG1heSBiZSBmaXhlZCB3aGlsZSBxdWV1aW5nIChp
ZiByZXNlbmQgaXMgbm90IG5lZWRlZCBmb3Igb3RoZXIgcmVhc29ucykgb3INCkknbGwgc2VuZCBh
IGZvbGxvdy11cCBmaXggbGF0ZXIsIHdoaWNoZXZlciB5b3UgcHJlZmVyLg0KDQo+ICsNCj4gKyAg
ICAvKg0KPiArICAgICAqIFdlIGp1c3QgYWxsb3cgYWlvIGNvbnRleHQgY2hhbmdlIG9uIG91ciBi
bG9jayBiYWNrZW5kcy4gYmxvY2tfY29weSgpIHVzZXINCj4gKyAgICAgKiAobm93IGl0J3Mgb25s
eSBiYWNrdXApIGlzIHJlc3BvbnNpYmxlIGZvciBzb3VyY2UgYW5kIHRhcmdldCBiZWluZyBpbiBz
YW1lDQo+ICsgICAgICogYWlvIGNvbnRleHQuDQo+ICsgICAgICovDQo+ICsgICAgYmxrX3NldF9k
aXNhYmxlX3JlcXVlc3RfcXVldWluZyhzLT5zb3VyY2UsIHRydWUpOw0KPiArICAgIGJsa19zZXRf
YWxsb3dfYWlvX2NvbnRleHRfY2hhbmdlKHMtPnNvdXJjZSwgdHJ1ZSk7DQo+ICsgICAgYmxrX3Nl
dF9kaXNhYmxlX3JlcXVlc3RfcXVldWluZyhzLT50YXJnZXQsIHRydWUpOw0KPiArICAgIGJsa19z
ZXRfYWxsb3dfYWlvX2NvbnRleHRfY2hhbmdlKHMtPnRhcmdldCwgdHJ1ZSk7DQo+ICsNCg0KWy4u
XQ0KDQo+IEBAIC03NjAsMjEgKzg2MCwxOSBAQCBCbG9ja0pvYiAqYmFja3VwX2pvYl9jcmVhdGUo
Y29uc3QgY2hhciAqam9iX2lkLCBCbG9ja0RyaXZlclN0YXRlICpicywNCj4gICAgICAgICogRm9y
IG1vcmUgaW5mb3JtYXRpb24gc2VlIGNvbW1pdCBmOGQ1OWRmYjQwYmIgYW5kIHRlc3QNCj4gICAg
ICAgICogdGVzdHMvcWVtdS1pb3Rlc3RzLzIyMg0KDQpbLi5dDQoNCj4gICAgICAgam9iLT5jbHVz
dGVyX3NpemUgPSBjbHVzdGVyX3NpemU7DQo+IC0gICAgam9iLT5jb3B5X2JpdG1hcCA9IGNvcHlf
Yml0bWFwOw0KPiAtICAgIGNvcHlfYml0bWFwID0gTlVMTDsNCj4gLSAgICBqb2ItPnVzZV9jb3B5
X3JhbmdlID0gIWNvbXByZXNzOyAvKiBjb21wcmVzc2lvbiBpc24ndCBzdXBwb3J0ZWQgZm9yIGl0
ICovDQo+IC0gICAgam9iLT5jb3B5X3JhbmdlX3NpemUgPSBNSU5fTk9OX1pFUk8oYmxrX2dldF9t
YXhfdHJhbnNmZXIoam9iLT5jb21tb24uYmxrKSwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBibGtfZ2V0X21heF90cmFuc2Zlcihqb2ItPnRhcmdldCkpOw0KPiAt
ICAgIGpvYi0+Y29weV9yYW5nZV9zaXplID0gTUFYKGpvYi0+Y2x1c3Rlcl9zaXplLA0KPiAtICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIFFFTVVfQUxJR05fVVAoam9iLT5jb3B5X3Jhbmdl
X3NpemUsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBq
b2ItPmNsdXN0ZXJfc2l6ZSkpOw0KPiAtDQo+IC0gICAgLyogUmVxdWlyZWQgcGVybWlzc2lvbnMg
YXJlIGFscmVhZHkgdGFrZW4gd2l0aCB0YXJnZXQncyBibGtfbmV3KCkgKi8NCj4gKw0KPiArICAg
IC8qIFJlcXVpcmVkIHBlcm1pc3Npb25zIGFyZSBhbHJlYWR5IHRha2VuIGJ5IGJsb2NrLWNvcHkt
c3RhdGUgdGFyZ2V0ICovDQo+ICAgICAgIGJsb2NrX2pvYl9hZGRfYmRydigmam9iLT5jb21tb24s
ICJ0YXJnZXQiLCB0YXJnZXQsIDAsIEJMS19QRVJNX0FMTCwNCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICZlcnJvcl9hYm9ydCk7DQo+ICAgICAgIGpvYi0+bGVuID0gbGVuOw0KDQoNCi0tIA0K
QmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

