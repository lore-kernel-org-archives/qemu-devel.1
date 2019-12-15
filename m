Return-Path: <SRS0=VgCP=2F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E117C43603
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2019 21:16:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67B1624676
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2019 21:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=infinera.com header.i=@infinera.com header.b="PdAVYWFp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67B1624676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=infinera.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igbFV-00071N-Iy
	for qemu-devel@archiver.kernel.org; Sun, 15 Dec 2019 16:16:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45714)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Joakim.Tjernlund@infinera.com>) id 1igbEq-0006b6-Ps
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 16:15:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Joakim.Tjernlund@infinera.com>) id 1igbEp-0005rI-B4
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 16:15:40 -0500
Received: from mail-dm6nam10on2068.outbound.protection.outlook.com
 ([40.107.93.68]:11502 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Joakim.Tjernlund@infinera.com>)
 id 1igbEm-0005g7-A9; Sun, 15 Dec 2019 16:15:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JeEPLAjFBL+0x2ak89MJv7+o69W69FQwYzQO7w90JZUhuqJ7ziJRRTe++sITOQbWKugxlN9jJLvZocklNPAy73OlOrU6yhDT/f4Dmw9HAuV/0DPXbdcoDlbMAKSF0uXx37m20bKEJ+SJuLjCafI3KiB30D94avjxns0TWs1dWxMfd/UwKHgPJCWbJGLRK3UzglSPNECb00Q13wbdlpBYxyfBqvdHjHEOJo3TM5rUvzwW0JeenJULoqDVE6bfJl2QPDlfWU9hWB1AsNSfRIwFAZUw702P+tsVzZ7DZ+31WSyrPXzR506JjvvU+OJdSHABlTwkiUCgVBohe3sh6i8AIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxV37EcwcAB+QMUQUgd5c2iwLykfIteRnEI1U9+GJVY=;
 b=jJUOy6ezdgtoaAiFyQx0Vrmk8a3zx/WEQOZnEGdCkkyPFaKP4lkwFYIXEo9MK2yit66sLvcjyB/94Q2QkcBbC7F1jnRtpkZa4wobbE1nJ5iXeRWeimgHkTjGdmKOGJI6YxhgK0zbJHZ5VVJIGOIpfomiEkeFv6xroQ50AC5/C/2wdgwGWkca6rugkwJnyk6IMCTyIwZq0hdtq3bZShltDMmnT8WjdA4Tt1aIfq2LBbbHVIhR2OQUQnSFgkbsc9uPdc+5rP1FeWwGJUlva5NzJdFhdG74teSsn8K3tmx787vi0nzN4cQKHA1coAUpl0wDTvWWbl6TGPUhZavtliDZ5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxV37EcwcAB+QMUQUgd5c2iwLykfIteRnEI1U9+GJVY=;
 b=PdAVYWFpgDTeJkpKHRd56M5d9rlAZxz+wqtGxTavJfoprhxpxjSFFcj0EA6DLZ/vKQvblNohjnTbRxYgF3jalKicZzv4xCYpaO6xcecWBSw6FHQ9VhF/wkezIwSWvWsaLoVPV1svfwyc8okq0E7nKmRKicK0zhObQJGhKaTuvAk=
Received: from BN8PR10MB3540.namprd10.prod.outlook.com (20.179.77.152) by
 BN8PR10MB3362.namprd10.prod.outlook.com (20.179.139.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Sun, 15 Dec 2019 21:15:33 +0000
Received: from BN8PR10MB3540.namprd10.prod.outlook.com
 ([fe80::a97b:1c2e:601a:3e6e]) by BN8PR10MB3540.namprd10.prod.outlook.com
 ([fe80::a97b:1c2e:601a:3e6e%7]) with mapi id 15.20.2538.019; Sun, 15 Dec 2019
 21:15:32 +0000
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "balaton@eik.bme.hu" <balaton@eik.bme.hu>, "philmd@redhat.com"
 <philmd@redhat.com>
Subject: Re: [PATCH] ppc: remove excessive logging
Thread-Topic: [PATCH] ppc: remove excessive logging
Thread-Index: AQHVsniyPXjCb8LgOky/3NMa8MoAG6e6pm0AgABiCwCAAKwmgA==
Date: Sun, 15 Dec 2019 21:15:32 +0000
Message-ID: <d975fe075db9db4266437e1575987fe0f2d82ca4.camel@infinera.com>
References: <20191214121347.17071-1-joakim.tjernlund@infinera.com>
 <4a608af2-62a2-3ffb-0c02-8e0ca699d586@redhat.com>
 <alpine.BSF.2.21.99999.352.1912151147300.3618@zero.eik.bme.hu>
In-Reply-To: <alpine.BSF.2.21.99999.352.1912151147300.3618@zero.eik.bme.hu>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Joakim.Tjernlund@infinera.com; 
x-originating-ip: [88.131.87.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12dd8eef-7c91-4804-92b0-08d781a3eb93
x-ms-traffictypediagnostic: BN8PR10MB3362:
x-microsoft-antispam-prvs: <BN8PR10MB336297C52C9050639148A930F4560@BN8PR10MB3362.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02524402D6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(396003)(346002)(39860400002)(136003)(376002)(199004)(189003)(6512007)(71200400001)(91956017)(6486002)(8676002)(36756003)(81166006)(81156014)(45080400002)(186003)(76116006)(478600001)(8936002)(66556008)(66476007)(64756008)(66446008)(316002)(4001150100001)(2616005)(4326008)(6506007)(53546011)(66946007)(26005)(5660300002)(966005)(110136005)(86362001)(54906003)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN8PR10MB3362;
 H:BN8PR10MB3540.namprd10.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: infinera.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 41DgXS+cPz9u+ZzKuaSzZUFXj4VaBF8tnRaTHqM+tIaANWWFR3Yxy8zHEFMV/BG3wEMUgztVz+UtLewEtE8L1+JYyG29WOvkM/LjNz5QL5mFP6KBXuL0mpEc9MZ2mBR+eHtC5pKWQe8E88FZ1cY9ehovOAoVlv3m12fC2v9mP3HMZpAxe+PWFuslVjWbYRCwjPIchqHhWJRUV/9H0RLAO+yN5aWgRGYK2IVOALPUDC5TN63dC7dn+peWLEseRLn2Xd2Grb8f+xHHuAW/Bb88Dmh/3+0J8hxUkXJU5VosBu4UNKw8p/aqBIPv7qrGx4xYYma2s1qNbfyOqQ944DFHgBC3NRRePQXmmdnznxzJEQ4aexEvZe0qegs0Ip+vvOBxymqYgDyxyzK46xThE6xBZxAQWwgtGySdaVliBI3T7kqi+hrQyjWCQsMgaa9CraO2s3slm1Ha/y/cLas4f3zSMLr3NOlRI4UvRKU+Ed7tgmw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <927026AAF4746C48B59D58652DAFD793@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12dd8eef-7c91-4804-92b0-08d781a3eb93
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2019 21:15:32.7024 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HK/rF+Ld/YYTtEI4xHIyPLEPPz34H69kQXZoEoVkMXm6q1g8VxNYqjBPtlb1Lo5uMcqwLQKCIM0C+9Bh/rwVnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3362
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.93.68
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

T24gU3VuLCAyMDE5LTEyLTE1IGF0IDExOjU5ICswMTAwLCBCQUxBVE9OIFpvbHRhbiB3cm90ZToN
Cj4gQ0FVVElPTjogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiB0aGUgb3Jn
YW5pemF0aW9uLiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3Mg
eW91IHJlY29nbml6ZSB0aGUgc2VuZGVyIGFuZCBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+
IA0KPiANCj4gT24gU3VuLCAxNSBEZWMgMjAxOSwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3Jv
dGU6DQo+ID4gSGkgSm9ha2ltLA0KPiA+IA0KPiA+IEknbSBjYydpbmcgdGhlIFBQQyBtYWludGFp
bmVycyBmb3IgeW91LCBzbyB0aGV5IHdvbid0IG1pc3MgeW91ciBwYXRjaCAoc2VlDQo+ID4gaHR0
cHM6Ly9uYW0wMy5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNB
JTJGJTJGd2lraS5xZW11Lm9yZyUyRkNvbnRyaWJ1dGUlMkZTdWJtaXRBUGF0Y2glMjNDQ190aGVf
cmVsZXZhbnRfbWFpbnRhaW5lciZhbXA7ZGF0YT0wMiU3QzAxJTdDam9ha2ltLnRqZXJubHVuZCU0
MGluZmluZXJhLmNvbSU3QzhmZDYxNWE2MTFlYzRiZDljY2U0MDhkNzgxNGRkYTFhJTdDMjg1NjQz
ZGU1ZjViNGIwM2ExNTMwYWUyZGM4YWFmNzclN0MxJTdDMCU3QzYzNzEyMDA0MzY4ODI5ODIwNSZh
bXA7c2RhdGE9ZDQzM0RYTzhTRWFGSnFBdTczVlRRd2tacHRtdksyZU1BeGl2RUxHTWNNSSUzRCZh
bXA7cmVzZXJ2ZWQ9MCBhbmQNCj4gPiB0aGUgb3V0cHV0IG9mIC4vc2NyaXB0cy9nZXRfbWFpbnRh
aW5lci5wbCAtZiB0YXJnZXQvcHBjL2V4Y3BfaGVscGVyLmMpLg0KPiA+IA0KPiA+IE9uIDEyLzE0
LzE5IDE6MTMgUE0sIEpvYWtpbSBUamVybmx1bmQgd3JvdGU6DQo+ID4gPiBGcm9tOiBKb2FraW0g
VGplcm5sdW5kIDxKb2FraW0uVGplcm5sdW5kQGluZmluZXJhLmNvbT4NCj4gPiA+IA0KPiA+ID4g
cHBjIGxvZ3MgZXZlcnkgdHlwZSBvZiBJbnZhbGlkIGluc3RydWN0aW9uLiBUaGlzIGdlbmVyYXRl
cyBhIGxvdA0KPiA+ID4gb2YgZ2FyYmFnZSBvbiBjb25zb2xlIHdoZW4gc3NoZC9zc2hfa2V5Z2Vu
IGV4ZWN1dGVzIGFzDQo+ID4gPiB0aGV5IHRyeSB2YXJpb3VzIGluc24gdG8gb3B0aW1pemUgaXRz
IHBlcmZvcm1hbmNlLg0KPiA+ID4gVGhlIGludmFsaWQgb3BlcmF0aW9uIGxvZyBpcyBzdGlsbCB0
aGVyZSBzbyBhbiB1bmtub3duIGluc24NCj4gPiA+IHdpbGwgc3RpbGwgYmUgbG9nZ2VkLg0KPiA+
ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBKb2FraW0gVGplcm5sdW5kIDxKb2FraW0uVGplcm5s
dW5kQGluZmluZXJhLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gDQo+ID4gPiAgICAgIEFzIGZhciBh
cyBJIGNhbiBzZWUsIHBwYyBpcyB0aGUgb25seSBvbmUgZW1pdGluZyB0aHNpDQo+ID4gPiAgICAg
IGRlYnVnIG1zZyBmb3IgSW52YWxpZCBpbnNucy4NCj4gPiA+IA0KPiA+ID4gdGFyZ2V0L3BwYy9l
eGNwX2hlbHBlci5jIHwgMSAtDQo+ID4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0p
DQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQgYS90YXJnZXQvcHBjL2V4Y3BfaGVscGVyLmMgYi90
YXJnZXQvcHBjL2V4Y3BfaGVscGVyLmMNCj4gPiA+IGluZGV4IDUwYjAwNGQwMGQuLjQ1YzJmYTNm
ZjkgMTAwNjQ0DQo+ID4gPiAtLS0gYS90YXJnZXQvcHBjL2V4Y3BfaGVscGVyLmMNCj4gPiA+ICsr
KyBiL3RhcmdldC9wcGMvZXhjcF9oZWxwZXIuYw0KPiA+ID4gQEAgLTMyNiw3ICszMjYsNiBAQCBz
dGF0aWMgaW5saW5lIHZvaWQgcG93ZXJwY19leGNwKFBvd2VyUENDUFUgKmNwdSwgaW50DQo+ID4g
PiBleGNwX21vZGVsLCBpbnQgZXhjcCkNCj4gPiA+ICAgICAgICAgICAgICAgZW52LT5zcHJbU1BS
X0JPT0tFX0VTUl0gPSBFU1JfRlA7DQo+ID4gPiAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+ID4g
ICAgICAgICAgIGNhc2UgUE9XRVJQQ19FWENQX0lOVkFMOg0KPiA+ID4gLSAgICAgICAgICAgIExP
R19FWENQKCJJbnZhbGlkIGluc3RydWN0aW9uIGF0ICIgVEFSR0VUX0ZNVF9seCAiXG4iLA0KPiA+
ID4gZW52LT5uaXApOw0KPiA+IA0KPiA+IEkgZG9uJ3QgdGhpbmsgd2Ugd2FudCB0byByZW1vdmUg
YSBzdWNoIGltcG9ydGFudCBsb2cuIFNpbmNlIGl0IG1ha2Ugc2Vuc2UgdG8NCj4gPiBub3QgZGlz
dHVyYiB0aGUgY29uc29sZSwgbWF5YmUgd2UgY2FuIHJlcGxhY2Ugc29tZSBvZiB0aGUgTE9HX0VY
Q1AoKSBjYWxscyBieQ0KPiA+IHFlbXVfbG9nX21hc2soTE9HX0dVRVNUX0VSUk9SLC4uLikgaW5z
dGVhZD8NCg0KV2h5IGlzIHRoYXQgc28gaW1wb3J0YW50PyBBcyBmYXIgYXMgSSBjYW4gdGVsbCBw
cGMgaXMgdGhlIG9ubHkgYXJjaCBkb2luZyB0aGlzPw0KDQo+IA0KPiBJIGRvbid0IHRoaW5rIHRo
YXQncyBhIGdvb2QgaWRlYS4gVGhhdCB3b3VsZCBmbG9vZCB0aGUgLWQgZ3Vlc3RfZXJyb3JzIGxv
Zw0KPiB3aXRoIHVud2FudGVkIG1lc3NhZ2VzIHRoYXQgYXJlIG5vcm1hbCBub3QgcmVhbGx5IGR1
ZSB0byBndWVzdCBlcnJvcnMuIFRoZQ0KDQpJdCBub3QgT0sgdG8gZmxvb2Qgc29tZSBsb2cgYnV0
IE9LIHRvIGZsb29kIHRoZSBjb25zb2xlPw0KDQo+IExPR19FWENQKCkgaXMgbm90IGVuYWJsZWQg
YnkgZGVmYXVsdCwgeW91IGhhdmUgdG8gZWRpdCBzb3VyY2UgdG8gZW5hYmxlIGl0DQoNCkxPR19F
WENQIGlzIGVuYWJsZWQgb24gR2VudG9vLCB3aGF0IGFib3V0IG90aGVyIGRpc3Ryb3M/DQoNCj4g
c28geW91IGNhbiBhbHNvIHRoZW4gZWRpdCB0aGUgdW53YW50ZWQgbWVzc2FnZXMgYXMgd2VsbCAo
bGlrZSBjb21tZW50aW5nDQo+IHRoaXMgb25lIG91dCBpZiB5b3UgZG9uJ3QgbGlrZSBpdCkuIElm
IHRoaXMgaXMgcmVtb3ZlZCwgaW52YWxpZCBvcGNvZGVzDQo+IGFyZSBzdGlsbCBsb2dnZWQgZnJv
bSB0cmFuc2xhdGUuYyBidXQgdGhlIGV4Y2VwdGlvbiBnZW5lcmF0ZWQgZm9yIHRoZW0gaXMNCj4g
bm90IGxvZ2dlZC4gSSBkb24ndCBrbm93IGlmIHRoYXQncyB1c2VmdWwgb3Igbm90IGJ1dCB0aGVz
ZSBhcmUgZGVidWcgbG9ncw0KPiBzbyBkZXBlbmRzIG9uIHdoYXQgZG8geW91IHdhbnQgdG8gZGVi
dWcuIEkgZG9uJ3QgbWluZCB0aGlzIGJlaW5nIHJlbW92ZWQNCj4gYnV0IHdvdWxkIGJlIGFsc28g
aGFwcHkgbGVhdmluZyBpdCBhcyBpdCBpcyBhcyBpdCdzIG9ubHkgc2hvd24gZm9yDQo+IGRldmVs
b3BlcnMgd2hvIGVuYWJsZSBpdCBhbmQgbWlnaHQgaGVscCBkZWJ1Z2dpbmcuIE9yIG1heWJlIHRo
ZXNlIGNvdWxkIGJlDQo+IGNvbnZlcnRlZCB0byB0cmFjZXMgKGFsdGhvdWdoIEkgZ2VuZXJhbGx5
IGZpbmQgdHJhY2VzIHRvIGJlIGxlc3MNCj4gY29udmVuaWVudCB0byB3b3JrIHdpdGggdGhhbiBk
ZWJ1ZyBsb2dzIGFuZCBub3Qgc3VyZSBhYm91dCBwb3RlbnRpYWwNCj4gcGVyZm9ybWFuY2UgaW1w
YWN0KS4gU28gbXkgcHJlZmVyZW5jZXMgd291bGQgYmUgaW4gb3JkZXI6IDEuIGxlYXZlIGl0DQo+
IGFsb25lLCAyLiByZW1vdmUgaXQsIDMuIGNvbnZlcnQgdG8gdHJhY2VzLg0KPiANCj4gUmVnYXJk
cywNCj4gQkFMQVRPTiBab2x0YW4NCj4gDQo+ID4gPiAgICAgICAgICAgICAgIG1zciB8PSAweDAw
MDgwMDAwOw0KPiA+ID4gICAgICAgICAgICAgICBlbnYtPnNwcltTUFJfQk9PS0VfRVNSXSA9IEVT
Ul9QSUw7DQo+ID4gPiAgICAgICAgICAgICAgIGJyZWFrOw0KDQo=

