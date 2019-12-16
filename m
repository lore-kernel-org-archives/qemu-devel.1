Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00922C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 08:53:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB1F920725
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 08:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=infinera.com header.i=@infinera.com header.b="E1TPDGl/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB1F920725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=infinera.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igm88-000189-TN
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 03:53:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46505)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Joakim.Tjernlund@infinera.com>) id 1igm7L-0000dd-VI
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 03:52:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Joakim.Tjernlund@infinera.com>) id 1igm7L-0003fr-0V
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 03:52:39 -0500
Received: from mail-eopbgr750044.outbound.protection.outlook.com
 ([40.107.75.44]:38662 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Joakim.Tjernlund@infinera.com>)
 id 1igm7H-0003Yb-PF; Mon, 16 Dec 2019 03:52:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKrt4aamfMCetrpPFg85sNG3SQaUMAnkHQffssPYKuICvSSIX+hLnYK/c9NVP5UmLwLn0USV4KM1lLwSJebUVjfdw3Abrv/Vr2/LR3VDQvel3GlXpCfQks8hIksqKLYLCN4700+xFn67GHgtetq2O0EXTC8cIZZoxM0fAJGbSlPusE7kdCY2AMGF4WsHHAyl9icIVO7EjJdUA6T2gcaQBV5XCKusIcnYYU/gU1jxPk4HRwjCx9sI0V7P1iUPzmW9Ipqg8dEh0/4gwt4PtQ9jfLRjjFGfNgjzGGPY+Oykrp7vGpXlhTv3H3tKjafCdizFF9sYByMJf7jTVBdlo73k3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfAQoxg9fRP9YE643uMgUHN+ozYnXxXPPLyb1dJ4FNY=;
 b=QJot1iyUshpC/Va4v7F4UWrkP4Iv2/z5jH/ZRvDEfIltQ8oxxJ/3SnMIWvwzpsjy3m9OVqZbZhfSKpQ/b1wVCulYBQ+Ymgk9rZLGzmP8DJiHGCmt5ayR/4Yl1eiDi13q/8d3v87LCPqmaxL6Y8p66mh4bvTH+siiOcZ6/+Ypv88R7AInLQE/H5ggqXF0iBj3HcojVEdJ4epQt/P47uAtR+rXAQ+uQardWvQcaRKR7O8M/Dgudx8GCL9CyW9K9J5l30u816K55M7Js5+jbzDwUGB1A6QWVrJLkHW3pDSNdWdmqXAIfwaj2HXdib8uwRSKzUVCI8aLBU2qdVmUsHyKlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfAQoxg9fRP9YE643uMgUHN+ozYnXxXPPLyb1dJ4FNY=;
 b=E1TPDGl/LnonPWhu7jVXnGak9qOfg6jP+ZOMN5xDCQK26WWbc0HCTBp19DqsKWxJG1B64XSFDhngkLEn1FVVsxYKXiqmX72SmOTNMFzXPTCoX0kqC6PUq840lNTZh3dygTY547uCM695XwbSGmWVbSSY7a+u6KpsMg8c7nv0V2g=
Received: from BN8PR10MB3540.namprd10.prod.outlook.com (20.179.77.152) by
 BN8PR10MB4098.namprd10.prod.outlook.com (20.179.78.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16; Mon, 16 Dec 2019 08:52:33 +0000
Received: from BN8PR10MB3540.namprd10.prod.outlook.com
 ([fe80::a97b:1c2e:601a:3e6e]) by BN8PR10MB3540.namprd10.prod.outlook.com
 ([fe80::a97b:1c2e:601a:3e6e%7]) with mapi id 15.20.2538.019; Mon, 16 Dec 2019
 08:52:33 +0000
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "balaton@eik.bme.hu" <balaton@eik.bme.hu>, "philmd@redhat.com"
 <philmd@redhat.com>, "thuth@redhat.com" <thuth@redhat.com>
Subject: Re: [PATCH] ppc: remove excessive logging
Thread-Topic: [PATCH] ppc: remove excessive logging
Thread-Index: AQHVsniyPXjCb8LgOky/3NMa8MoAG6e6pm0AgABiCwCAAKwmgIAAu6yAgAAHEwA=
Date: Mon, 16 Dec 2019 08:52:33 +0000
Message-ID: <95a3c98d0f6a5aebe02bcd99a4db07db5de2720e.camel@infinera.com>
References: <20191214121347.17071-1-joakim.tjernlund@infinera.com>
 <4a608af2-62a2-3ffb-0c02-8e0ca699d586@redhat.com>
 <alpine.BSF.2.21.99999.352.1912151147300.3618@zero.eik.bme.hu>
 <d975fe075db9db4266437e1575987fe0f2d82ca4.camel@infinera.com>
 <ec67a070-77e2-08dc-9cc5-05907bbcbe79@redhat.com>
In-Reply-To: <ec67a070-77e2-08dc-9cc5-05907bbcbe79@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Joakim.Tjernlund@infinera.com; 
x-originating-ip: [88.131.87.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ceba9a6a-0b8f-45ca-be07-08d782054aa9
x-ms-traffictypediagnostic: BN8PR10MB4098:
x-microsoft-antispam-prvs: <BN8PR10MB4098E046F451CE55625FD694F4510@BN8PR10MB4098.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02530BD3AA
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(376002)(396003)(39860400002)(136003)(366004)(199004)(189003)(8676002)(5660300002)(186003)(8936002)(81156014)(81166006)(26005)(6486002)(66476007)(66556008)(64756008)(66446008)(2906002)(6506007)(6512007)(36756003)(71200400001)(4326008)(110136005)(478600001)(2616005)(86362001)(4001150100001)(91956017)(76116006)(4744005)(316002)(66946007)(54906003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN8PR10MB4098;
 H:BN8PR10MB3540.namprd10.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: infinera.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zK9kJhzqmh1UStq55ZBIGid47cYhLHrXNb5UB3PQAL0A8hZJtEjsNwMmfB/nV1KxUxNPwVIuzATOQw+h8qK34k3I6EZrttH28JCMg7FX+4Nc883nx5IVJS5wd1Ge2OEDGM6cFPFKVSazAoAy8Wz7zrtphUz29WXnKoBfJsfRiIUZcAENEGk6TKEyT4/+PI69Ax2WW4n/A+5CdXLcV7zMkkHlph2CvbG1PMSmhfSlTBM944EAbHaNERUZXJmcpuZz2HdLrttEpBuDjVaqLgOFwiP0C1x+lh8kic058mgOc52/G/uGvsNmbYOFHbb+VX38TeHLbUWx1ARFC4+ajeC2xAP1jaPFEMDHLh3CJEa70RcTOi61LT4n/X/2qkh/8i4vJ4Q+JOonk+wr2M9sWelcrYDtrd1XHCdOETg9WfuHb4MyJqlKCjDRawbcQJtVndSw
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F145444DFE30AC4A9EE46BDE9DB6A173@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceba9a6a-0b8f-45ca-be07-08d782054aa9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2019 08:52:33.4330 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cYNvH8K+bDqHAw0keYPyWQ0revsIHHIx559jGSYQRt20iR0dAhFT+tPzq3IXZYXt22Ymc/e5NWWNN2OBhCGTyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB4098
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.75.44
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
Cc: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gTW9uLCAyMDE5LTEyLTE2IGF0IDA5OjI3ICswMTAwLCBUaG9tYXMgSHV0aCB3cm90ZToNCj4g
DQo+IE9uIDE1LzEyLzIwMTkgMjIuMTUsIEpvYWtpbSBUamVybmx1bmQgd3JvdGU6DQo+IFsuLi5d
DQo+ID4gPiBMT0dfRVhDUCgpIGlzIG5vdCBlbmFibGVkIGJ5IGRlZmF1bHQsIHlvdSBoYXZlIHRv
IGVkaXQgc291cmNlIHRvIGVuYWJsZSBpdA0KPiA+IA0KPiA+IExPR19FWENQIGlzIGVuYWJsZWQg
b24gR2VudG9vLCB3aGF0IGFib3V0IG90aGVyIGRpc3Ryb3M/DQo+IA0KPiBJIGRvbid0IHRoaW5r
IHRoYXQgdGhpcyBpcyBlbmFibGVkIGJ5IGFueSBvdGhlciBkaXN0cm8uIFdoeSBpcyB0aGlzDQo+
IGVuYWJsZWQgb24gR2VudG9vIGF0IGFsbD8gSXQgcmVhbGx5IHNob3VsZCBub3QgYmUgZW5hYmxl
ZCBpbiBidWlsZHMgdGhhdA0KPiBhcmUgc3VwcG9zZWQgdG8gYmUgdXNlZCBieSBub3JtYWwgdXNl
cnMuIEhhdmUgeW91IHRyaWVkIHRvIGNvbnRhY3QgdGhlDQo+IHBhY2thZ2UgbWFpbnRhaW5lcnMg
b2YgdGhlIFFFTVUgR2VudG9vIHBhY2thZ2UgYW5kIGFza2VkIHRoZW0gdG8gZGlzYWJsZQ0KPiBp
dCB0aGVyZSBhZ2Fpbj8NCg0KaG1tLCBJIGhhdmUgYmVlbiBjYXJyeWluZyB0aGF0IHBhdGNoIGZv
ciBhIGxvbmcgdGltZSh5ZWFycykgYW5kIG5vdyB3aGVuIEkgbG9vayBpbnRvIHRoZSBjb2RlL3Bh
Y2thZ2UNCkkgZG9uJ3Qgc2VlIGl0IGVuYWJsZWQgYW55IG1vcmUgc28gSSB3aWxsIGRlbGV0ZSB0
aGlzIHBhdGNoIG5vdyBmcm9tIG15IHRyZWUgYW5kIHNlZSB3aGF0IGhhcHBlbnMuDQoNCiBKb2Nr
ZQ0K

