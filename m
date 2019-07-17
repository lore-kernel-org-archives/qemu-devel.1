Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A540C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 08:28:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07DAB20818
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 08:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="RTdvkZU7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07DAB20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnfIr-0008Vr-9i
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 04:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44813)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hnfIf-00087C-9u
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 04:28:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hnfId-000258-SJ
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 04:28:33 -0400
Received: from mail-eopbgr130112.outbound.protection.outlook.com
 ([40.107.13.112]:7936 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1hnfIc-000243-Qg
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 04:28:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hS5lraqWTp1/tuNPDwIQOA+tdPtHOkAyFPgesER+b/jkLNkrHnuyw/OiGL639I2p6/rmdqEd4nqEHrt0fRlVLPfklf2XplBrbo99836JMDodJhq/wj35JNPGAHGlqizQhBIwbEhHadhizwxg8LVz5AFR3WBQH6GkJy7hUOTlu48osPeeouLcXFHfGiTloEIqk1rCyVKSuXtgJetyz292o6OFE/XQ9Rv9NPsX59n1HnsIrQ20/O+X4N0AQdIhRWkqlWbGcZfIeDtQ1zCrCi34P3NKKw+FWhheX/F6N6Jctrest/w9YK2P/CmIdVOvm1l40vp73P+T7eLj06KBXJ2lHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xySs3nh0iK2qdO7CWSaLMI1bGjqMOi4QCclu9ay5fmw=;
 b=PxQdQcuoTziqe6nVeakfhLGhMSFzL0aOQjV9zuplCpf8OtNbp6spnWJkKfIR9dWjQ/WMsrgYKAE2zxUqvfnbwizbST1g3zz/mHDbdsqwd4nllQd/dbodFXVyYW91evEc2maZzlUH9wSYiC2VEymML5DlGMVFHpexi44x30/utFr6wyBqvRv5KeXgDa75WnI2y/PF2FSuG02lMRd4huqyGjBks1p25MKEMfdiewp1hf5HAIEcnGOD8/ufVxQi/d8PmxJK4NvGmwuxLMO2uTbgM501vcvXjvvK7UmLHORU37+9+hZhEVmERPhN7N23gn3Y0fYt5Xt5BerUj4qckosm+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xySs3nh0iK2qdO7CWSaLMI1bGjqMOi4QCclu9ay5fmw=;
 b=RTdvkZU7iVVhPp9JTmWfyZR7c4T1TSwuKRP0XQwmXPK7ddW2B42yTpmL0zoFiheDGOQWoOX/V5YAlr3TB8vk+USjy3JaDfMIGgOh01T2Wu8X5JPINWvmydV+Jt6tEDjB56HshIe2lRC7SGKhYOb5AmOVGwj6BjogQJOf7+UblJM=
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com (20.179.28.141) by
 VI1PR08MB3021.eurprd08.prod.outlook.com (52.133.14.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.11; Wed, 17 Jul 2019 08:28:19 +0000
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::4c3d:79b3:a884:18c4]) by VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::4c3d:79b3:a884:18c4%3]) with mapi id 15.20.2073.012; Wed, 17 Jul 2019
 08:28:19 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH] chardev: race condition with
 tcp_chr_disconnect
Thread-Index: AQHVOOZ1DwB6Iz4ObkKXlmNSu3G56abL8iuAgAAR7QCAAn1FgA==
Date: Wed, 17 Jul 2019 08:28:19 +0000
Message-ID: <bc1dfb2a-5210-14e0-0728-fb9a31af81f1@virtuozzo.com>
References: <1562959033-223586-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <b270d0cc-2a28-8a60-ccac-45ac4de89f02@redhat.com>
 <a55d4518-734e-9dd1-296f-473600eacbf7@redhat.com>
In-Reply-To: <a55d4518-734e-9dd1-296f-473600eacbf7@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0901CA0049.eurprd09.prod.outlook.com
 (2603:10a6:3:45::17) To VI1PR08MB4399.eurprd08.prod.outlook.com
 (2603:10a6:803:102::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9f71c67e-5190-478d-a445-08d70a90b916
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:VI1PR08MB3021; 
x-ms-traffictypediagnostic: VI1PR08MB3021:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR08MB3021732EDD87C68BDCE12585F4C90@VI1PR08MB3021.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01018CB5B3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(396003)(39850400004)(376002)(366004)(346002)(199004)(189003)(44832011)(53936002)(52116002)(186003)(68736007)(26005)(76176011)(486006)(99286004)(102836004)(386003)(6506007)(53546011)(6116002)(6486002)(3846002)(31696002)(6436002)(14444005)(2616005)(476003)(256004)(8676002)(11346002)(446003)(2906002)(6306002)(6512007)(54906003)(110136005)(2501003)(86362001)(36756003)(14454004)(316002)(25786009)(31686004)(966005)(478600001)(4326008)(7736002)(6246003)(107886003)(8936002)(229853002)(71200400001)(305945005)(81166006)(66556008)(66476007)(5660300002)(81156014)(66446008)(66946007)(64756008)(66066001)(71190400001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB3021;
 H:VI1PR08MB4399.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XJQhWjKfsqrPhrAZrotxAESRphZ2IwtgpMY6Y5b/tgACf4KyoyJzFG3U5nzbDWV3mPjGrEkFeXvMl4RtFsvZvafyveaxpXBbiL9MaIMt5MFoBwlMWulPOIWfrX5SW43OPFR/QTqKjb6sAv8KpNuVaqdnKzvDgJfJpNPk222KsYjtQKESNh2md6B/3r3ZM7K7P5R3poGRbMjmgfO/0OrfLZpCCi9ldh+EpAh25auGkgAe197EiA6ynk+Wfiubj79x3IyFdzWhT9Kym2VV+chxxGC9oTLWuzbrWkKkuIbowFxqDr4N7oxWSeYwyC/5LJKjOXbHh10cjhfDDe05Vtvig2dxyU/OPUhNYB1vRugpsxhssru5a13imX3wJQ7c7E6s6fNQhLVz2+BnntXvTkFZK+Diyh2pc2uXq/bsvBlB72U=
Content-Type: text/plain; charset="utf-8"
Content-ID: <10F941A939C64447A52A1C80E9A122B0@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f71c67e-5190-478d-a445-08d70a90b916
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2019 08:28:19.5050 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: andrey.shinkevich@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3021
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.112
Subject: Re: [Qemu-devel] [PATCH] chardev: race condition with
 tcp_chr_disconnect
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
Cc: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Roman Kagan <rkagan@virtuozzo.com>, Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDE1LzA3LzIwMTkgMjE6MjcsIFBhb2xvIEJvbnppbmkgd3JvdGU6DQo+IE9uIDE1LzA3
LzE5IDE5OjIzLCBNYXggUmVpdHogd3JvdGU6DQo+PiBPbiAxMi4wNy4xOSAyMToxNywgQW5kcmV5
IFNoaW5rZXZpY2ggd3JvdGU6DQo+Pj4gV2hlbiB0Y3BfY2hyX2Rpc2Nvbm5lY3QoKSBpcyBjYWxs
ZWQsIG90aGVyIHRocmVhZCBtYXkgYmUgc3RpbGwgd3JpdGluZw0KPj4+IHRvIHRoZSBjaGFubmVs
LiBUaGlzIHBhdGNoIHByb3RlY3RzIG9ubHkgcmVhZCBvcGVyYXRpb25zIHRoYXQgaW5pdGlhdGUN
Cj4+PiB0aGUgZGlzY29ubmVjdGlvbi4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IEFuZHJleSBT
aGlua2V2aWNoIDxhbmRyZXkuc2hpbmtldmljaEB2aXJ0dW96em8uY29tPg0KPj4+IC0tLQ0KPj4N
Cj4+IEhhdmUgeW91IGxvb2tlZCBhdA0KPj4gaHR0cHM6Ly9saXN0cy5ub25nbnUub3JnL2FyY2hp
dmUvaHRtbC9xZW11LWRldmVsLzIwMTktMDIvbXNnMDYxNzQuaHRtbA0KPj4gYWxyZWFkeT8gIEZy
b20gYSBnbGFuY2UsIGl0IGxvb2tzIGxpa2UgdGhhdCBzZXJpZXMgc3VwZXJzZWRlcyB0aGlzIG9u
ZS4NCj4+DQo+PiAoTm8sIEkgZG9u4oCZdCBrbm93IHdoeSB0aGUgb3RoZXIgc2VyaWVzIGlzIGRl
bGF5ZWQuDQo+IA0KPiBCZWNhdXNlIGl0IGJyb2tlIHNvbWUgdGVzdGNhc2VzIGluIHRlc3RzL3Zo
b3N0LXVzZXItdGVzdC4gIFRoZXkgYXJlDQo+IGRpc2FibGVkIGJ5IGRlZmF1bHQsIGJlY2F1c2Ug
QUZBSVIgdGhleSBicm9rZSBvbiBzb21lIENJIGVudmlyb25tZW50LA0KPiBidXQgdGhleSBhcmUg
c3VwcG9zZWQgdG8gd29yay4NCj4gDQo+IFBhb2xvDQo+IA0KPj4gSSBrZWVwIHJlbWluZGluZw0K
Pj4gUGFvbG8gb2YgaXQuKQ0KPj4NCj4+IE1heA0KPj4NCj4gDQoNClRoZSB0ZXN0IGNoZWNrLXF0
ZXN0LXg4Nl82NDogdGVzdHMvcW9zLXRlc3QgaGFuZ3Mgd2l0aCB0aGUgDQpRVEVTVF9WSE9TVF9V
U0VSX0ZJWE1FIHNldCBldmVuIHdpdGhvdXQgYXBwbHlpbmcgdGhlIHNlcmllczoNCg0KVGhyZWFk
IDQgKFRocmVhZCAweDJhZGU3YTJiYjcwMCAoTFdQIDQ5MjU2NikpOg0KIzAgIDB4MDAwMDJhZGU2
ZjU0MzFjOSBpbiBzeXNjYWxsICgpIGF0IA0KLi4vc3lzZGVwcy91bml4L3N5c3YvbGludXgveDg2
XzY0L3N5c2NhbGwuUzozOA0KIzEgIDB4MDAwMDU1OTlkZWMwOGJiNiBpbiBxZW11X2Z1dGV4X3dh
aXQgKGY9MHg1NTk5ZGY2NjUxZDQgDQo8cmN1X2NhbGxfcmVhZHlfZXZlbnQ+LCB2YWw9NDI5NDk2
NzI5NSkgYXQgDQovaG9tZS9hbmRyZXkvZ2l0L3FlbXUvaW5jbHVkZS9xZW11L2Z1dGV4Lmg6MjkN
CiMyICAweDAwMDA1NTk5ZGVjMDhkN2YgaW4gcWVtdV9ldmVudF93YWl0IChldj0weDU1OTlkZjY2
NTFkNCANCjxyY3VfY2FsbF9yZWFkeV9ldmVudD4pIGF0IHV0aWwvcWVtdS10aHJlYWQtcG9zaXgu
Yzo0NDINCiMzICAweDAwMDA1NTk5ZGVjMjFlYTEgaW4gY2FsbF9yY3VfdGhyZWFkIChvcGFxdWU9
MHgwKSBhdCB1dGlsL3JjdS5jOjI2MA0KIzQgIDB4MDAwMDU1OTlkZWMwOGYyYyBpbiBxZW11X3Ro
cmVhZF9zdGFydCAoYXJncz0weDU1OTllMTA1NjhmMCkgYXQgDQp1dGlsL3FlbXUtdGhyZWFkLXBv
c2l4LmM6NTAyDQojNSAgMHgwMDAwMmFkZTZmMjM2ZGQ1IGluIHN0YXJ0X3RocmVhZCAoYXJnPTB4
MmFkZTdhMmJiNzAwKSBhdCANCnB0aHJlYWRfY3JlYXRlLmM6MzA3DQojNiAgMHgwMDAwMmFkZTZm
NTQ4ZWFkIGluIGNsb25lICgpIGF0IA0KLi4vc3lzZGVwcy91bml4L3N5c3YvbGludXgveDg2XzY0
L2Nsb25lLlM6MTExDQoNClRocmVhZCAzIChUaHJlYWQgMHgyYWRlN2E0YmM3MDAgKExXUCA0OTI1
NjcpKToNCiMwICAweDAwMDAyYWRlNmY1M2UyMGQgaW4gcG9sbCAoKSBhdCAuLi9zeXNkZXBzL3Vu
aXgvc3lzY2FsbC10ZW1wbGF0ZS5TOjgxDQojMSAgMHgwMDAwMmFkZTU2ZTdjMzJjIGluIGdfbWFp
bl9jb250ZXh0X2l0ZXJhdGUuaXNyYS4xOSAoKSBhdCANCi9saWI2NC9saWJnbGliLTIuMC5zby4w
DQojMiAgMHgwMDAwMmFkZTU2ZTdjNjdhIGluIGdfbWFpbl9sb29wX3J1biAoKSBhdCAvbGliNjQv
bGliZ2xpYi0yLjAuc28uMA0KIzMgIDB4MDAwMDU1OTlkZTdmNjc3MiBpbiBpb3RocmVhZF9ydW4g
KG9wYXF1ZT0weDU1OTllMTE5NmEzMCkgYXQgDQppb3RocmVhZC5jOjgyDQojNCAgMHgwMDAwNTU5
OWRlYzA4ZjJjIGluIHFlbXVfdGhyZWFkX3N0YXJ0IChhcmdzPTB4NTU5OWUxMWE4N2EwKSBhdCAN
CnV0aWwvcWVtdS10aHJlYWQtcG9zaXguYzo1MDINCiM1ICAweDAwMDAyYWRlNmYyMzZkZDUgaW4g
c3RhcnRfdGhyZWFkIChhcmc9MHgyYWRlN2E0YmM3MDApIGF0IA0KcHRocmVhZF9jcmVhdGUuYzoz
MDcNCiM2ICAweDAwMDAyYWRlNmY1NDhlYWQgaW4gY2xvbmUgKCkgYXQgDQouLi9zeXNkZXBzL3Vu
aXgvc3lzdi9saW51eC94ODZfNjQvY2xvbmUuUzoxMTENCg0KVGhyZWFkIDIgKFRocmVhZCAweDJh
ZGU3YTdhZTcwMCAoTFdQIDQ5MjU2OCkpOg0KIzAgIDB4MDAwMDJhZGU2ZjIzZTM2MSBpbiBfX3Np
Z3dhaXQgKHNpZz0weDJhZGU3YTdhYjc1MCwgc2V0PTxvcHRpbWl6ZWQgDQpvdXQ+KSBhdCAuLi9z
eXNkZXBzL3VuaXgvc3lzdi9saW51eC9zaWd3YWl0LmM6NjANCiMxICAweDAwMDAyYWRlNmYyM2Uz
NjEgaW4gX19zaWd3YWl0IChzZXQ9MHgyYWRlN2E3YWI3NjAsIA0Kc2lnPTB4MmFkZTdhN2FiNzUw
KSBhdCAuLi9zeXNkZXBzL3VuaXgvc3lzdi9saW51eC9zaWd3YWl0LmM6OTUNCiMyICAweDAwMDA1
NTk5ZGU2NTVmZWUgaW4gcWVtdV9kdW1teV9jcHVfdGhyZWFkX2ZuIChhcmc9MHg1NTk5ZTExYTll
YjApIA0KYXQgL2hvbWUvYW5kcmV5L2dpdC9xZW11L2NwdXMuYzoxMzMxDQojMyAgMHgwMDAwNTU5
OWRlYzA4ZjJjIGluIHFlbXVfdGhyZWFkX3N0YXJ0IChhcmdzPTB4NTU5OWUxMWNkMTQwKSBhdCAN
CnV0aWwvcWVtdS10aHJlYWQtcG9zaXguYzo1MDINCiM0ICAweDAwMDAyYWRlNmYyMzZkZDUgaW4g
c3RhcnRfdGhyZWFkIChhcmc9MHgyYWRlN2E3YWU3MDApIGF0IA0KcHRocmVhZF9jcmVhdGUuYzoz
MDcNCiM1ICAweDAwMDAyYWRlNmY1NDhlYWQgaW4gY2xvbmUgKCkgYXQgDQouLi9zeXNkZXBzL3Vu
aXgvc3lzdi9saW51eC94ODZfNjQvY2xvbmUuUzoxMTENCg0KVGhyZWFkIDEgKFRocmVhZCAweDJh
ZGU1NjYxYzI4MCAoTFdQIDQ5MjU2NCkpOg0KIzAgIDB4MDAwMDJhZGU2ZjUzZTJjZiBpbiBfX0dJ
X3Bwb2xsIChmZHM9MHg1NTk5ZTIwZTEzNjAsIG5mZHM9OSwgDQp0aW1lb3V0PTxvcHRpbWl6ZWQg
b3V0Piwgc2lnbWFzaz0weDApIGF0IA0KLi4vc3lzZGVwcy91bml4L3N5c3YvbGludXgvcHBvbGwu
Yzo1Ng0KIzEgIDB4MDAwMDU1OTlkZWMwMjMyZCBpbiBxZW11X3BvbGxfbnMgKGZkcz0weDU1OTll
MjBlMTM2MCwgbmZkcz05LCANCnRpbWVvdXQ9NDM3OTM5OTg5NjQwMDApIGF0IHV0aWwvcWVtdS10
aW1lci5jOjMzNA0KIzIgIDB4MDAwMDU1OTlkZWMwMzUxMCBpbiBvc19ob3N0X21haW5fbG9vcF93
YWl0IA0KKHRpbWVvdXQ9NDM3OTM5OTg5NjQwMDApIGF0IHV0aWwvbWFpbi1sb29wLmM6MjQwDQoj
MyAgMHgwMDAwNTU5OWRlYzAzNjM0IGluIG1haW5fbG9vcF93YWl0IChub25ibG9ja2luZz0wKSBh
dCANCnV0aWwvbWFpbi1sb29wLmM6NTIxDQojNCAgMHgwMDAwNTU5OWRlN2ZmNDM5IGluIG1haW5f
bG9vcCAoKSBhdCB2bC5jOjE3OTENCiM1ICAweDAwMDA1NTk5ZGU4MDZkY2EgaW4gbWFpbiAoYXJn
Yz0xOSwgYXJndj0weDdmZmU1YjNiNjZhOCwgDQplbnZwPTB4N2ZmZTViM2I2NzQ4KSBhdCB2bC5j
OjQ0NzMNCg0KQW5kcmV5DQotLSANCldpdGggdGhlIGJlc3QgcmVnYXJkcywNCkFuZHJleSBTaGlu
a2V2aWNoDQoNCg0K

