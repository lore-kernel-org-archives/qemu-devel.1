Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F78C5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 10:07:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0BC4206A3
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 10:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="R7RQlBXR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0BC4206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSIEE-0006Q5-7g
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 05:07:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38689)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <den@virtuozzo.com>) id 1iSIDX-0005s3-89
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 05:07:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <den@virtuozzo.com>) id 1iSIDW-0005qQ-0K
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 05:07:11 -0500
Received: from mail-eopbgr70104.outbound.protection.outlook.com
 ([40.107.7.104]:41455 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <den@virtuozzo.com>)
 id 1iSIDS-0005lP-AQ; Wed, 06 Nov 2019 05:07:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ejwplDvhVFedgM8m8iP77WZjB/6dyvPrtr9jSIyYOXhEfmvIEJzYT9MHDOZAiMm9vJv+6koJUXW/dC8wG2I1sg0EER8cuoSp/KhnpOmJMGaomyfMW6YhzbT8kfPA5r4B6hq8036n9HpKGW8d4fUEkf/sLzyRYoD4ZwnQKR6Iy9NflSXvx78C/Q10dpk4O9saqXJfX+yZYEvwITmkHKShJJPEWrBst3DiQgL4chrAhOnY0DSiPPrq5s2QIQGVkw8bMx9llQdMa5CFzSS/mYqdZe2fRc5BqjPbBiX+ziOqan+QZXy/AMP64sKU+06wbGpElhZ4tXQj+ETp3tlngpC1RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Si/hg45cBANRHRghjaW4qm8FO4BYuaAsfOsmAiCNtNs=;
 b=YqDIewLFHDCDN3wlgrFevXMTgQOSnYM+MuXJSqGbjrSDts3wjbAwTu4z5ReV/nc/uiMTyb9sS4zSU4dXEdH2d/8MnfYNrEFRpUADfMFA8RJHj5sqtxmPy6au8dEbdxhI9hoxGgWgaGRo3n2PzwLPLZELXCjE3VF0QzBOGw88ztZY6dCTZzdip6UwAnwB3wHRiqBbuiWRSxOhasJ40BUbNGTUgjNcikj9gUi7IAqPvOXdm7DQKWac+iCF3XNzK+IpnrqNEgjX3iLMJ+Rwb2u45XRqj+kHpIMoRtUj1fqy7Js4racyZR/Kaz0zOsMSkp66H/rrd7Ohs7poHFDj9MC58g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Si/hg45cBANRHRghjaW4qm8FO4BYuaAsfOsmAiCNtNs=;
 b=R7RQlBXRO2klHyOW5xrR0q8Vz+uMvCkm+Lp51vyG2XK+XGgHp5XyR7VfAjlVKih0Zxf4GtZb2TBCSUgy/hrhdchJRXQPSYHCWlCum3WWw5OuqGLDcstr3SK33vwMCxKidxgpbcTW83GEOFtQvpfYDU5UfYQV0xx8RdgEPk3kgcM=
Received: from DB7PR08MB3052.eurprd08.prod.outlook.com (52.135.131.139) by
 DB7PR08MB3419.eurprd08.prod.outlook.com (20.176.238.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Wed, 6 Nov 2019 10:07:02 +0000
Received: from DB7PR08MB3052.eurprd08.prod.outlook.com
 ([fe80::b0a9:80ac:af62:a71e]) by DB7PR08MB3052.eurprd08.prod.outlook.com
 ([fe80::b0a9:80ac:af62:a71e%6]) with mapi id 15.20.2408.024; Wed, 6 Nov 2019
 10:07:02 +0000
From: Denis Lunev <den@virtuozzo.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Denis Plotnikov
 <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH v1 2/4] virtio: make seg_max virtqueue size dependent
Thread-Topic: [PATCH v1 2/4] virtio: make seg_max virtqueue size dependent
Thread-Index: AQHVk/OqkXMHi75PtE6sQOIqMPmr9ad9DZ2AgADeVwA=
Date: Wed, 6 Nov 2019 10:07:02 +0000
Message-ID: <c32d94d1-a216-dd9e-e0cf-dee2730169e4@virtuozzo.com>
References: <20191105161105.19016-1-dplotnikov@virtuozzo.com>
 <20191105161105.19016-3-dplotnikov@virtuozzo.com>
 <20191105155033-mutt-send-email-mst@kernel.org>
In-Reply-To: <20191105155033-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0102CA0064.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::41) To DB7PR08MB3052.eurprd08.prod.outlook.com
 (2603:10a6:5:28::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=den@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c78508ac-e301-4d4a-83c5-08d762a111ee
x-ms-traffictypediagnostic: DB7PR08MB3419:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR08MB3419B651AE23CF324B6A51E9B6790@DB7PR08MB3419.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(396003)(346002)(136003)(376002)(366004)(199004)(189003)(6246003)(186003)(26005)(6512007)(102836004)(4326008)(14444005)(81166006)(81156014)(2906002)(110136005)(71200400001)(6506007)(54906003)(25786009)(99286004)(3846002)(36756003)(256004)(52116002)(386003)(8936002)(66476007)(66946007)(66556008)(64756008)(66446008)(5660300002)(31686004)(86362001)(66066001)(71190400001)(6116002)(6636002)(14454004)(8676002)(478600001)(476003)(486006)(2616005)(229853002)(316002)(11346002)(6436002)(31696002)(446003)(6486002)(76176011)(305945005)(7736002)(53546011);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB3419;
 H:DB7PR08MB3052.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kSruDM6PyPONYvLO02FSflLqnvk6XA/5GoHnwSghJyKeRY0fXUvn9sL20mEAaHBPzCreYwflPgxpkVqABY8CmJ7WwMJPL4iuvv7sWlE452sdTq17L9T2efY2qimuB1RLEpw7fNWjIxwJEFS/iBKX8lneCp7NbZkFyC4xCJz90zBWQQ5rqnkeNE4L9fTRY3eoXt0ggpNWnwg6in3MabJxqUbGEyhJpoYE8mg0ofQp7o6zebBgiRXhYuLukhEBMwYSF10rCe9Cnv3hCvIt5GdgaEcetd5dk0lLdIOMSkrh9iVJV3N0ayRjNIqxYcS6cVhra2IIsEB5t7NBEUarT7BiZDtBY1o4MflaVJUFV8L62bcCJZPJ/Gy3uk0peb6t2YwXX1tf+qccg3aUIY2lPAB4MOSiui/l87RP2qd6MAo/xpt8rrdSXOpWYkkwVWsRGoR/
Content-Type: text/plain; charset="utf-8"
Content-ID: <D8BFC82740CF384B933740F47F068D83@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c78508ac-e301-4d4a-83c5-08d762a111ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 10:07:02.7644 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E5ufCo0CVOtzrJ1pCvq0NFxNWrPnF7TSLAaJqe6S02G3taxYBdEO2z9050Ofj7TpdS3ykgtJd7leRbB+nXmcBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3419
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.104
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
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gMTEvNS8xOSA5OjUxIFBNLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6DQo+IE9uIFR1ZSwg
Tm92IDA1LCAyMDE5IGF0IDA3OjExOjAzUE0gKzAzMDAsIERlbmlzIFBsb3RuaWtvdiB3cm90ZToN
Cj4+IHNlZ19tYXggaGFzIGEgcmVzdHJpY3Rpb24gdG8gYmUgbGVzcyBvciBlcXVhbCB0byB2aXJ0
cXVldWUgc2l6ZQ0KPj4gYWNjb3JkaW5nIHRvIFZpcnRpbyAxLjAgc3BlY2lmaWNhdGlvbg0KPj4N
Cj4+IEFsdGhvdWdoIHNlZ19tYXggY2FuJ3QgYmUgc2V0IGRpcmVjdGx5LCBpdCdzIHdvcnRoIHRv
IGV4cHJlc3MgdGhpcw0KPj4gZGVwZW5kYW5jeSBkaXJlY3RseSBpbiB0aGUgY29kZSBmb3Igc2Fu
aXR5IHB1cnBvc2UuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogRGVuaXMgUGxvdG5pa292IDxkcGxv
dG5pa292QHZpcnR1b3p6by5jb20+DQo+IFRoaXMgaXMgZ3Vlc3QgdmlzaWJsZSBzbyBuZWVkcyB0
byBiZSBtYWNoaW5lIHR5cGUgZGVwZW5kZW50LCByaWdodD8NCg0Kd2UgaGF2ZSBkaXNjdXNzZWQg
dGhpcyB2ZXJiYWxseSB3aXRoIFN0ZWZhbiBhbmQgdGhpbmsgdGhhdA0KdGhlcmUgaXMgbm8gbmVl
ZCB0byBhZGQgdGhhdCB0byB0aGUgbWFjaGluZSB0eXBlIGFzOg0KDQotIG9yaWdpbmFsIGRlZmF1
bHQgd2FzIDEyNiwgd2hpY2ggbWF0Y2hlcyAxMjggYXMgcXVldWUNCsKgIGxlbmd0aCBpbiBvbGQg
bWFjaGluZSB0eXBlcw0KLSBxdWV1ZSBsZW5ndGggPiAxMjggaXMgbm90IG9ic2VydmVkIGluIHRo
ZSBmaWVsZCBhcw0KwqAgU2VhQmlvcyBoYXMgcXVpcmsgdGhhdCBhc3NlcnRzDQotIGlmIHF1ZXVl
IGxlbmd0aCB3aWxsIGJlIHNldCB0byBzb21ldGhpbmcgPCAxMjggLSBsaW51eA0KwqAgZ3Vlc3Qg
d2lsbCBjcmFzaA0KDQpJZiB3ZSByZWFsbHkgbmVlZCB0byBwcmVzZXJ2ZSBvcmlnaW5hbCBfX2J1
Z2d5X18gYmVoYXZpb3IgLQ0Kd2UgY2FuIGFkZCBib29sZWFuIHByb3BlcnR5LCBwbHMgbGV0IHVz
IGtub3cuDQoNCkRlbg0KDQo+DQo+PiAtLS0NCj4+ICBody9ibG9jay92aXJ0aW8tYmxrLmMgfCAy
ICstDQo+PiAgaHcvc2NzaS92aXJ0aW8tc2NzaS5jIHwgMiArLQ0KPj4gIDIgZmlsZXMgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9o
dy9ibG9jay92aXJ0aW8tYmxrLmMgYi9ody9ibG9jay92aXJ0aW8tYmxrLmMNCj4+IGluZGV4IDA2
ZTU3YTRkMzkuLjIxNTMwMzA0Y2YgMTAwNjQ0DQo+PiAtLS0gYS9ody9ibG9jay92aXJ0aW8tYmxr
LmMNCj4+ICsrKyBiL2h3L2Jsb2NrL3ZpcnRpby1ibGsuYw0KPj4gQEAgLTkwMyw3ICs5MDMsNyBA
QCBzdGF0aWMgdm9pZCB2aXJ0aW9fYmxrX3VwZGF0ZV9jb25maWcoVmlydElPRGV2aWNlICp2ZGV2
LCB1aW50OF90ICpjb25maWcpDQo+PiAgICAgIGJsa19nZXRfZ2VvbWV0cnkocy0+YmxrLCAmY2Fw
YWNpdHkpOw0KPj4gICAgICBtZW1zZXQoJmJsa2NmZywgMCwgc2l6ZW9mKGJsa2NmZykpOw0KPj4g
ICAgICB2aXJ0aW9fc3RxX3AodmRldiwgJmJsa2NmZy5jYXBhY2l0eSwgY2FwYWNpdHkpOw0KPj4g
LSAgICB2aXJ0aW9fc3RsX3AodmRldiwgJmJsa2NmZy5zZWdfbWF4LCAxMjggLSAyKTsNCj4+ICsg
ICAgdmlydGlvX3N0bF9wKHZkZXYsICZibGtjZmcuc2VnX21heCwgcy0+Y29uZi5xdWV1ZV9zaXpl
IC0gMik7DQo+PiAgICAgIHZpcnRpb19zdHdfcCh2ZGV2LCAmYmxrY2ZnLmdlb21ldHJ5LmN5bGlu
ZGVycywgY29uZi0+Y3lscyk7DQo+PiAgICAgIHZpcnRpb19zdGxfcCh2ZGV2LCAmYmxrY2ZnLmJs
a19zaXplLCBibGtfc2l6ZSk7DQo+PiAgICAgIHZpcnRpb19zdHdfcCh2ZGV2LCAmYmxrY2ZnLm1p
bl9pb19zaXplLCBjb25mLT5taW5faW9fc2l6ZSAvIGJsa19zaXplKTsNCj4+IGRpZmYgLS1naXQg
YS9ody9zY3NpL3ZpcnRpby1zY3NpLmMgYi9ody9zY3NpL3ZpcnRpby1zY3NpLmMNCj4+IGluZGV4
IDgzOWYxMjAyNTYuLmY3ZTU1MzNjZDUgMTAwNjQ0DQo+PiAtLS0gYS9ody9zY3NpL3ZpcnRpby1z
Y3NpLmMNCj4+ICsrKyBiL2h3L3Njc2kvdmlydGlvLXNjc2kuYw0KPj4gQEAgLTY1MCw3ICs2NTAs
NyBAQCBzdGF0aWMgdm9pZCB2aXJ0aW9fc2NzaV9nZXRfY29uZmlnKFZpcnRJT0RldmljZSAqdmRl
diwNCj4+ICAgICAgVmlydElPU0NTSUNvbW1vbiAqcyA9IFZJUlRJT19TQ1NJX0NPTU1PTih2ZGV2
KTsNCj4+ICANCj4+ICAgICAgdmlydGlvX3N0bF9wKHZkZXYsICZzY3NpY29uZi0+bnVtX3F1ZXVl
cywgcy0+Y29uZi5udW1fcXVldWVzKTsNCj4+IC0gICAgdmlydGlvX3N0bF9wKHZkZXYsICZzY3Np
Y29uZi0+c2VnX21heCwgMTI4IC0gMik7DQo+PiArICAgIHZpcnRpb19zdGxfcCh2ZGV2LCAmc2Nz
aWNvbmYtPnNlZ19tYXgsIHMtPmNvbmYudmlydHF1ZXVlX3NpemUgLSAyKTsNCj4+ICAgICAgdmly
dGlvX3N0bF9wKHZkZXYsICZzY3NpY29uZi0+bWF4X3NlY3RvcnMsIHMtPmNvbmYubWF4X3NlY3Rv
cnMpOw0KPj4gICAgICB2aXJ0aW9fc3RsX3AodmRldiwgJnNjc2ljb25mLT5jbWRfcGVyX2x1biwg
cy0+Y29uZi5jbWRfcGVyX2x1bik7DQo+PiAgICAgIHZpcnRpb19zdGxfcCh2ZGV2LCAmc2NzaWNv
bmYtPmV2ZW50X2luZm9fc2l6ZSwgc2l6ZW9mKFZpcnRJT1NDU0lFdmVudCkpOw0KPj4gLS0gDQo+
PiAyLjE3LjANCg0K

