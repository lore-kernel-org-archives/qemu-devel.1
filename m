Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26547C432C3
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 07:00:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE3DE206BF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 07:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="lOyg+r6h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE3DE206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZUpR-00049f-WA
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 02:00:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35711)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iZUoX-0003Bm-6o
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 01:59:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iZUfe-0008H0-3m
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 01:49:59 -0500
Received: from mail-eopbgr00090.outbound.protection.outlook.com
 ([40.107.0.90]:9742 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1iZUfd-0008GQ-Il; Tue, 26 Nov 2019 01:49:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDHV5Qza0eS7rTBA1EfwguMmIcFfZc/OM36390Mo9Ncj2Hr7ob918l+vtuPKulqzbRqhMeAF/GW+xD/lxdWVCyVHa9H6Hgf7zn2vLpxv0INYvqK313uaAuxuAvfR3o8iuChTRODLCb6CpB+xhenCnyNZtlk5KJuLaataCp/FGzWN9OypfSTQAsUn8CDY8JN3motR4o2nvJL6rxNRsbmzUU5wnpBhKWXSKyJ95/wVwdzyUl5gCw2NnvdgGjfuuLvZ75phiVFlrMPbLNVBUVslJqId5yfpTgnC2G77/sU7/5nEiW1Z0oLYkx+cZR8R3+a90xLFvNEznWgzDljTgn03og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EocdJgD38K3o3s7SG1GPOpVd7yJWlvaCs0cCyF4L+Og=;
 b=n7u+0XTpXGG4DJ7BcMBCFWqzGW7korefXH82zKeH0lcYtkuM9O2P1IHHrPRexzIE+hyH0q8uEhQvtLeuha5NVnz11qLDvV3rG26huX3KOirL5WY1aArA8zdbL2ycoSSxoEV/pVBFAddUTIAJU9R4hDoQeLFx6fH1E7sF/LiXpqRRmlj1994n/ItqRH0GFrLK1X8zOLrRTeC76azzuTO/Btk7ZV1X3k6Yev3Aomy/5UV6YsW/LyIaQRy7kp5iVkkjYBOk9Ysndqi8A67haRLrFP7PjO/nwljjiVxFHFQ0Hlwi8XShfxdVImTzti6uxSoVa5Kc/xzbk5j+ReFbfxRwoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EocdJgD38K3o3s7SG1GPOpVd7yJWlvaCs0cCyF4L+Og=;
 b=lOyg+r6hAiP+kfee0MrV7q8R4TLM0H+WqM46ZPDtVe60hvbEG+7HcBoQQuHi+KSxAnrem7Iqjhgr57JHUzMYjJc5F5ICGQhYprAmF/ZoxaYksUPRz3SHfBDzB6W/NRdkCaJcfSeiJZnNW7j1E2oldSp6lDkdUJdCZuNif7Xe3mo=
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB3171.eurprd08.prod.outlook.com (52.134.93.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Tue, 26 Nov 2019 06:49:53 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::893d:bf37:4b98:12]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::893d:bf37:4b98:12%4]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 06:49:53 +0000
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH v0 1/2] qdev-properties-system: extend set_pionter for
 unrealized devices
Thread-Topic: [PATCH v0 1/2] qdev-properties-system: extend set_pionter for
 unrealized devices
Thread-Index: AQHVl/nxDteiAUIJXEyH6anabhWATqeRU16AgAYBH4CABMYCgIABAPIA
Date: Tue, 26 Nov 2019 06:49:53 +0000
Message-ID: <e960b6a2-071a-781d-ba3f-18b315a538bd@virtuozzo.com>
References: <20191110190310.19799-1-dplotnikov@virtuozzo.com>
 <20191110190310.19799-2-dplotnikov@virtuozzo.com>
 <20191118185453.GC3812@habkost.net>
 <d5d3ac62-4f46-08d6-bf66-620e410fa954@virtuozzo.com>
 <20191125153011.GL4438@habkost.net>
In-Reply-To: <20191125153011.GL4438@habkost.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR09CA0085.eurprd09.prod.outlook.com
 (2603:10a6:7:3d::29) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [5.138.5.44]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 075d7a85-2e0b-4270-d6ea-08d7723cd75c
x-ms-traffictypediagnostic: AM0PR08MB3171:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB31715DFC04D768D64FF94145CF450@AM0PR08MB3171.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0233768B38
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(136003)(366004)(39840400004)(396003)(52314003)(189003)(199004)(31686004)(86362001)(478600001)(14454004)(256004)(66946007)(8936002)(66476007)(66556008)(64756008)(6916009)(76176011)(52116002)(66446008)(102836004)(54906003)(5660300002)(386003)(6506007)(53546011)(99286004)(6512007)(229853002)(31696002)(7736002)(305945005)(2906002)(6246003)(6116002)(26005)(3846002)(186003)(4326008)(71200400001)(71190400001)(316002)(107886003)(25786009)(6486002)(8676002)(81166006)(81156014)(66066001)(11346002)(36756003)(6436002)(2616005)(446003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3171;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: obWTeyEwodGg1vscqW1YKug8fI1F38b/0AOUIUzxez3E+yoDfkuN/MshoNJMHcTdiON7C4s0Te/YH1IN5h62lJaUNHIO7i+hMUeI+6RIgUhwaIi/DLBe3G3NbSEe9s23bE/c71CzajbffPTDm+2ZYAUzwdvbiCfDl7GY4umf2iXB7ufcSZujiXSr3loqBdkYh5sYYMm5Cejr7cd2HrMhISHGs4BuadKh1u9ozrLghFdVW+HfTlqVG1h8Zz0EhVqDageL26Zrwj9s/0eybYLzESUjeqBsyOXV7KtDcvEBO7p147TOdOkfc/uF3THGcYiLERvSqfW952EBzbYVPiwyx7W9mqziu57v8PgIXsmKtCi4j7EJx4PUt8teLLlEW36MxtsScCE4xT/NlMfQkcYPmFUlutyYCVPkFxoF61D/i/S/5N8FY2RWm0OpDqx+W5BM
Content-Type: text/plain; charset="utf-8"
Content-ID: <3200DA74C5BFAE4EA4AF92DA08AB5654@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 075d7a85-2e0b-4270-d6ea-08d7723cd75c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2019 06:49:53.5183 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3OKACsle8ts37mxV3Rv6pqTglXiKoTTzQjr8z/bnV/1UMt5HbZreH/uqniF6Ugc8MaOnNto5BITZO89i5gtE0fM0XBnShcyiW75ztEJMVks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3171
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.90
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDI1LjExLjIwMTkgMTg6MzAsIEVkdWFyZG8gSGFia29zdCB3cm90ZToNCj4gT24gRnJp
LCBOb3YgMjIsIDIwMTkgYXQgMTE6MzY6MzBBTSArMDAwMCwgRGVuaXMgUGxvdG5pa292IHdyb3Rl
Og0KPj4NCj4+IE9uIDE4LjExLjIwMTkgMjE6NTQsIEVkdWFyZG8gSGFia29zdCB3cm90ZToNCj4+
PiBPbiBTdW4sIE5vdiAxMCwgMjAxOSBhdCAxMDowMzowOVBNICswMzAwLCBEZW5pcyBQbG90bmlr
b3Ygd3JvdGU6DQo+Pj4+IFNvbWUgZGV2aWNlJ3MgcHJvcGVydHkgY2FuIGJlIGNoYW5nZWQgaWYg
dGhlIGRldmljZSBoYXMgYmVlbiBhbHJlYWR5DQo+Pj4+IHJlYWxpemVkLiBGb3IgZXhhbXBsZSwg
aXQgY291bGQgYmUgImRyaXZlIiBwcm9wZXJ0eSBvZiBhIHNjc2kgZGlzayBkZXZpY2UuDQo+Pj4+
DQo+Pj4+IFNvIGZhciwgc2V0X3BvaW50ZXIgY291bGQgb3BlcmF0ZSBvbmx5IG9uIGEgcmVsaXpl
ZCBkZXZpY2UuIFRoZSBwYXRjaA0KPj4+PiBleHRlbmRzIGl0cyBpbnRlcmZhY2UgZm9yIG9wZXJh
dGlvbiBvbiBhbiB1bnJlYWxpemVkIGRldmljZS4NCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTog
RGVuaXMgUGxvdG5pa292IDxkcGxvdG5pa292QHZpcnR1b3p6by5jb20+DQo+Pj4+IC0tLQ0KPj4+
PiAgICBody9jb3JlL3FkZXYtcHJvcGVydGllcy1zeXN0ZW0uYyB8IDMyICsrKysrKysrKysrKysr
KysrKysrKy0tLS0tLS0tLS0tDQo+Pj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAyMSBpbnNlcnRpb25z
KCspLCAxMSBkZWxldGlvbnMoLSkNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL2h3L2NvcmUvcWRl
di1wcm9wZXJ0aWVzLXN5c3RlbS5jIGIvaHcvY29yZS9xZGV2LXByb3BlcnRpZXMtc3lzdGVtLmMN
Cj4+Pj4gaW5kZXggYmE0MTJkZDJjYS4uYzUzNDU5MGRjZCAxMDA2NDQNCj4+Pj4gLS0tIGEvaHcv
Y29yZS9xZGV2LXByb3BlcnRpZXMtc3lzdGVtLmMNCj4+Pj4gKysrIGIvaHcvY29yZS9xZGV2LXBy
b3BlcnRpZXMtc3lzdGVtLmMNCj4+Pj4gQEAgLTM4LDkgKzM4LDE0IEBAIHN0YXRpYyB2b2lkIGdl
dF9wb2ludGVyKE9iamVjdCAqb2JqLCBWaXNpdG9yICp2LCBQcm9wZXJ0eSAqcHJvcCwNCj4+Pj4g
ICAgfQ0KPj4+PiAgICANCj4+Pj4gICAgc3RhdGljIHZvaWQgc2V0X3BvaW50ZXIoT2JqZWN0ICpv
YmosIFZpc2l0b3IgKnYsIFByb3BlcnR5ICpwcm9wLA0KPj4+PiAtICAgICAgICAgICAgICAgICAg
ICAgICAgdm9pZCAoKnBhcnNlKShEZXZpY2VTdGF0ZSAqZGV2LCBjb25zdCBjaGFyICpzdHIsDQo+
Pj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZvaWQgKipwdHIsIGNv
bnN0IGNoYXIgKnByb3BuYW1lLA0KPj4+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBFcnJvciAqKmVycnApLA0KPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgdm9p
ZCAoKnBhcnNlX3JlYWxpemVkKShEZXZpY2VTdGF0ZSAqZGV2LA0KPj4+PiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBjaGFyICpzdHIsIHZvaWQg
KipwdHIsDQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGNvbnN0IGNoYXIgKnByb3BuYW1lLA0KPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApLA0KPj4+PiArICAgICAgICAgICAg
ICAgICAgICAgICAgdm9pZCAoKnBhcnNlX3VucmVhbGl6ZWQpKERldmljZVN0YXRlICpkZXYsDQo+
Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29u
c3QgY2hhciAqc3RyLCB2b2lkICoqcHRyLA0KPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IGNoYXIgKnByb3BuYW1lLA0KPj4+PiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJy
cCksDQo+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IGNoYXIgKm5hbWUsIEVy
cm9yICoqZXJycCkNCj4+PiBXb3VsZG4ndCBpdCBiZSBzaW1wbGVyIHRvIGp1c3QgYWRkIGEgUHJv
cGVydHlJbmZvOjphbGxvd19zZXRfYWZ0ZXJfcmVhbGl6ZQ0KPj4+IGJvb2wgZmllbGQsIGFuZCBj
YWxsIHRoZSBzYW1lIHNldHRlciBmdW5jdGlvbj8gIFRoZW4geW91IGNhbg0KPj4+IHNpbXBseSBj
aGFuZ2UgZG9fcGFyc2VfZHJpdmUoKSB0byBjaGVjayBpZiByZWFsaXplZCBpcyB0cnVlLg0KPj4g
TWF5IGJlLCBidXQgSSB0aG91Z2h0IEl0IHdvdWxkIGJlIG1vcmUgY2xlYXIgdG8gaGF2ZSBhIHNl
cGFyYXRlIGNhbGxiYWNrDQo+PiBmb3IgYWxsIHRoZSBkZXZpY2VzIHN1cHBvcnRpbmcgdGhlIHBy
b3BlcnR5IHNldHRpbmcgd2hlbiByZWFsaXplZC4NCj4+IEFsc28gdGhlICJkcml2ZSIgcHJvcGVy
dHkgc2V0dGluZyBvbiByZWFsaXplZCBhbmQgbm9uLXJlYWxpemVkIGRldmljZSBhDQo+PiBsaXR0
bGUgYml0IGRpZmZlcmVudDogaW4gdGhlIHJlYWxpemVkIGNhc2UgdGhlIHNldHRlciBmdW5jdGlv
biBleHBlY3RzDQo+PiB0byBnZXQNCj4+IEJsb2NrRHJpdmVyU3RhdGUgb25seSwgd2hlbiBpbiB0
aGUgdW5yZWFsaXplZCBjYXNlIHRoZSBzZXR0ZXIgY2FuIGFjY2VwdA0KPj4gYm90aCBCbG9ja0Jh
Y2tlbmQgYW5kIEJsb2NrRHJpdmVyU3RhdGUuIEFsc28sIGluIHRoZSB1bnJlYWxpemVkIGNhc2Ug
dGhlDQo+PiBzZXR0ZXIgZnVuY3Rpb24gZG9lc24ndCBleHBlY3QgdG8gaGF2ZSBhIGRldmljZSB3
aXRoIGFuIGVtcHR5IEJsb2NrQmFja2VuZC4NCj4+IEkgZGVjaWRlZCB0aGF0IGV4dGVuZGluZyBk
b19wYXJzZV9kcml2ZSB3b3VsZCBtYWtlIGl0IG1vcmUgY29tcGxleCBmb3INCj4+IHVuZGVyc3Rh
bmRpbmcuIFRoYXQncyB3aHkgSSBtYWRlIHR3byBzZXBhcmF0ZSBmdW5jdGlvbnMgZm9yIGJvdGgg
Y2FzZXMuDQo+IEkgdW5kZXJzdGFuZCB5b3UgbWlnaHQgd2FudCB0d28gc2VwYXJhdGUgZnVuY3Rp
b25zIGluIHRoZQ0KPiBzcGVjaWZpYyBjYXNlIG9mIGRyaXZlLiAgWW91IGNhbiBzdGlsbCBjYWxs
IGRpZmZlcmVudA0KPiBmdW5jdGlvbnMgYWZ0ZXIgY2hlY2tpbmcgZGV2LT5yZWFsaXplZCBpbnNp
ZGUgZG9fcGFyc2VfZHJpdmUoKS4NCj4NCj4gTXkgcG9pbnQgd2FzIHRoYXQgeW91IGRvbid0IG5l
ZWQgdG8gbWFrZSBzZXRfcG9pbnRlcigpIHJlcXVpcmUNCj4gdHdvIHNlcGFyYXRlIGZ1bmN0aW9u
IHBvaW50ZXJzIGp1c3QgdG8gcHJvcGFnYXRlIDEgYml0IG9mDQo+IGluZm9ybWF0aW9uIHRoYXQg
aXMgYWxyZWFkeSBhdmFpbGFibGUgaW4gRGV2aWNlU3RhdGUuICBJbiBwYXRjaA0KPiAyLzIgeW91
IGhhZCB0byBjcmVhdGUgNCBkaWZmZXJlbnQgY29waWVzIG9mIHBhcnNlX2RyaXZlKigpDQo+IGJl
Y2F1c2Ugb2YgdGhpcy4NClllcywgdGhhdCdzIHRydWUuIEkgd2FudGVkIHRvIHN1Z2dlc3QgYSBt
b3JlIGdlbmVyYWwgd2F5IHRvIGRlYWwgd2l0aCBhIA0KZGV2aWNlIG9uIHJlYWxpemVkIGFuZCBu
b24tcmVhbGl6ZWQgc3RhdGUuDQpJIG1heSBiZSB0b28gbXVjaCBhbmQgbm90IG5lY2Vzc2FyeS4g
TWF5IGJlIHdlIHNob3VsZCB3YWl0IGZvciBhIA0KZmVlZGJhY2sgZnJvbSB0aGUgYmxvY2sgbWFp
bnRhaW5lcnM/DQo+DQo+DQo+PiBJJ2QgbGlrZSB0byBtZW50aW9uIHRoYXQgSSBoYXZlIGEgZmV3
IGNvbmNlcm5zIGFib3V0DQo+PiBkb19wYXJzZV9kcml2ZV9yZWFsaXplZCAocGxlYXNlIHNlZSB0
aGUgbmV4dCBwYXRjaCBmcm9tIHRoZSBzZXJpZXMpIGFuZA0KPj4gSSdkIGxpa2UgdGhlbSB0byBi
ZSByZXZpZXdlZCBhcyB3ZWxsLiBBZnRlciB0aGF0LCBtYXkgYmUgaXQgd291bGQgYmUNCj4+IGJl
dHRlciB0byBnbyB0aGUgd2F5IHlvdSBzdWdnZXN0ZWQuDQo+IEluIHRoZSBjYXNlIGlmIHlvdXIg
cXVlc3Rpb25zIGluIHBhdGNoIDIvMiwgSSdtIGFmcmFpZCBJIGRvbid0DQo+IGtub3cgdGhlIGFu
c3dlcnMgYW5kIHdlIG5lZWQgaGVscCBmcm9tIHRoZSBibG9jayBtYWludGFpbmVycy4NCkFueXdh
eSwgdGhhbmtzIGZvciB0YWtpbmcgYSBnbGFuY2UuDQo+DQoNCg==

