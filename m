Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8DFC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 19:28:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D451F2065D
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 19:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GZ//0iui";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="dAPR/PLt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D451F2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtFjj-0004Kj-6z
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 15:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=45148fd95=Dmitry.Fomichev@wdc.com>)
 id 1jtFhr-0002Qr-Jm; Wed, 08 Jul 2020 15:26:11 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:51218)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=45148fd95=Dmitry.Fomichev@wdc.com>)
 id 1jtFhp-0002tC-Bv; Wed, 08 Jul 2020 15:26:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594236369; x=1625772369;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=YungXAMDultkid7UrF8Pnp0f5618WflQz4K7KzYiA7g=;
 b=GZ//0iuilC4ouYLE3yGtRabYN4sxAcNKhZW80sVm7VMm1mknX+hWgFm4
 /YeeHAFDfTbMdX8TFnBaJlo0g9HB00Yl2sDHpuGIDaiFbnIGC11Vpiaug
 gd1HQSYQGAfkgDE2J5Mu5LekQf9sWZo/FjmqdiU29RvqUQnftlvWdnZvo
 FEZ9RKgOGtkt14/wZq7OLhJHWDkC1Njk80TUqqc9suY0Wb9iJ/KyVjOBj
 x4WevkYtL2eNeuMsJaEnHElHYv8alJSW/mGnKvRAmOCIXF8wr6aJek+u8
 sIKVrwYb6i251A3vnsNmxwfHlx7GL9VC3upzRODy/b/zFVqaw4/jgm5Q9 w==;
IronPort-SDR: DWz91QMFeSPQyJTV9qZjj8rXWhh4sSXhJM3BRUbV9l3178p3/7WNgvrB7LpE7fRSBA5Bt3CklP
 EAxMmin5KuF7A+gdGZ0R3HyRdQgFSXJ6OBSwR8Xvuc19S4jg2gX5c/6Tvxc3r0vvTyYXxf//qf
 /Fc4exAttQOxrJttRkFabdWU/qfEMnT0zU0WPiVdv+RB9Wuxv9vbdvGYMcIq0FKNYMbfjCMep3
 Kl5v2yp6YJmkLFfDJ7epAJ8IU3edpzk8yLBIt0cp5pOZXUYpoFX9oMORobVzMYc7065TaytGLw
 v3w=
X-IronPort-AV: E=Sophos;i="5.75,328,1589212800"; d="scan'208";a="141956615"
Received: from mail-dm6nam10lp2108.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.108])
 by ob1.hgst.iphmx.com with ESMTP; 09 Jul 2020 03:26:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KvBagvdA0Pj+PNX1iVB0BrVrUidGzY8Sb+8U4zQFUwb76sTOwk0nNFponnbUMwQAMkkjqsHzwUsMXVlB3FjPJqFLKXHwFGMTv43rALCz19sC0rbcpucajgnRqIz6jbrgJQyHwFysh7XR4zBMhzq8PcqSkxnaMBJunT2/4dEHkQz0204chiTrtR1PKjybK49Bgc17W2QNXkR0TFAEbEc0qOdYyVP8uMK9Rx6xIySqgDSZ60/t/DAPoZ2vpcEOlsAjUSwRGfVHY+GPQFPZ/xHZv2m6lbH8Xb75RmrUockpmY4bmzWDyNXP8YS5vR3FO2pAz6GHE9M9coASx1kGBt+P+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YungXAMDultkid7UrF8Pnp0f5618WflQz4K7KzYiA7g=;
 b=JS/RgNzry/1FBHtjJ2Sqqb9LCJ2qbYPZpnnPPPpGybZ4B3v9G2Wg/XBgG7MXVtd/3ZJqpLHPmOQ+WyCZ3I2h4m75pqgO7IfpIzB2MHTQrTOalApE0A0WhBtwkZbqTInBvG5cujJZbAvBi+c5JQW9nj/4Dqk9OegMMiMAMEtQ05t6a7p1Vwn7+FdUHUaE0b1RLUS6YrpKM1myc9zqDKHzpm3hNVP5x1LzdDUw+z9eRA0cKKh6t7oOU6qg64Pajw8ZAgWbO30WgagT0CQX9dM4Zb2RbnoAgnhRtC2hQGDJNRYr5J4a+l8P0sWnbhZ16MPiO8MJyx5T3dHJT6uMYTXm9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YungXAMDultkid7UrF8Pnp0f5618WflQz4K7KzYiA7g=;
 b=dAPR/PLthS53u91GluLAyOuwNdXF8t9kldgWQHVxzx6cv0fuwmoipKNLr5gBC5sTCjiNsHAIsWv9DouvovlsDJoK5GI35QKFF2TxU5LkwMHAKudG4hfnTVU40k2y83Bspwm0aMeh6ncIhjR4KzhqoZkX3i7in9yU2EnluqHQ/8U=
Received: from MN2PR04MB5951.namprd04.prod.outlook.com (2603:10b6:208:3f::13)
 by MN2PR04MB6254.namprd04.prod.outlook.com (2603:10b6:208:da::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.28; Wed, 8 Jul
 2020 19:26:04 +0000
Received: from MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::60c5:4424:8ce4:59a9]) by MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::60c5:4424:8ce4:59a9%5]) with mapi id 15.20.3153.029; Wed, 8 Jul 2020
 19:26:04 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: "its@irrelevant.dk" <its@irrelevant.dk>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v3 15/18] hw/block/nvme: reject invalid nsid values in
 active namespace id list
Thread-Topic: [PATCH v3 15/18] hw/block/nvme: reject invalid nsid values in
 active namespace id list
Thread-Index: AQHWU1yO7i5w+hf0fE+rOfM5ahXCCqj+FIOA
Date: Wed, 8 Jul 2020 19:26:04 +0000
Message-ID: <9d66639d9fd9f4b553438e8327fdfc3a0ad4ece3.camel@wdc.com>
References: <20200706061303.246057-1-its@irrelevant.dk>
 <20200706061303.246057-16-its@irrelevant.dk>
In-Reply-To: <20200706061303.246057-16-its@irrelevant.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
authentication-results: irrelevant.dk; dkim=none (message not signed)
 header.d=none;irrelevant.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [100.35.204.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8f3a5146-83ae-474d-c1ef-08d82374c185
x-ms-traffictypediagnostic: MN2PR04MB6254:
x-microsoft-antispam-prvs: <MN2PR04MB625492C1DFACA7D920106396E1670@MN2PR04MB6254.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 04583CED1A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jEquqP5vxeYBVtDOXZUxLSSKAwz7qfzPGu7hRudVwuKBueHx0tCAF1tF+Owvcbgl2Imb1o1I+aIKxDqmI1M5wdOefK8TZ8Ad/trM+rLmDES7PDFiBI+tz90aOw7rPTiueI+Yz+o/AK1FhdmG67m4JCxVbOaMQC5PIycv36EHVn8+t116R6tOYUA14beKlso+zpjXH5o6FyVaDWXtnq3JfYTmMFNYhUSDD0WDMQvjyyqTRnuO6gZUasUpOBtNRsmKFGC52J9FSX/v8bjijlk9pPa8AyU+eY1uJcniGigE15YKLFFlR9RY5UnAI1cTafQw5KZJF8z/41H/TiIoUR5ksQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB5951.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(86362001)(5660300002)(6506007)(6512007)(26005)(71200400001)(2906002)(186003)(110136005)(54906003)(316002)(36756003)(478600001)(66556008)(66446008)(66476007)(64756008)(66946007)(2616005)(76116006)(4326008)(8936002)(7416002)(6486002)(8676002)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: k3FIFwIKpcSmqdWSZl40PMF+N8IISFx9P+JXM/dC0EqUJavlfh2CVgOLak3SFdtfVXxfksXIcd2GFyhvzEJk+FsBKn1Eye5VN7R1f+iNnAoaoXAL1ml6v+GXIEDVLVt9jzNu8EK+OV5jXadTAEJJGs9jMqDHTTheZID0/hd8P447cvz8rgaAV4uUas4D6DoANLAp85JONPzylDKK4SDxN4mc/b/Vbj20QKp1wzd5ZwSvPJwrhhJI0gp5AXRAYllNpa0sUuGnWzX4pZK9NsoW7x13lB/xvT9+q20PVDZxle/gpaWWdwsx7J3gIsgqVWAIRSyntFLAlCVwCBpGGcXyy4gXkSyfxEhEIRF9mV37iKVsy8UGYwPreumlz/a5weqDT3DIV0xtTcqpAw2Qe7htmFqWW3xpweKj4LV+/E2HXB9cnjkl3BEOUf3w3uCTYwCzLY5lDYoI87z0fpZp2JdQFNlKlKROAGwr3wfXBrx7m7qu57EYFG5qOMGQeX+Vd+3e
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E9F8D78C286DCD4682DFFA3DCACF8273@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5951.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f3a5146-83ae-474d-c1ef-08d82374c185
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2020 19:26:04.1113 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1NVuFGsH/5gg+nigBt+eOQx3eB9YD+2zxWWC/Y4mEjs6ITMG/jpTuPIxQlXkT1I6s9Lvx7Hgfs9ryyRnYylmmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6254
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=45148fd95=Dmitry.Fomichev@wdc.com; helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/08 15:19:10
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
 "k.jensen@samsung.com" <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "javier.gonz@samsung.com" <javier.gonz@samsung.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IERtaXRyeSBGb21pY2hldiA8ZG1pdHJ5LmZvbWlj
aGV2QHdkYy5jb20+DQoNCk9uIE1vbiwgMjAyMC0wNy0wNiBhdCAwODoxMyArMDIwMCwgS2xhdXMg
SmVuc2VuIHdyb3RlOg0KPiBGcm9tOiBLbGF1cyBKZW5zZW4gPGsuamVuc2VuQHNhbXN1bmcuY29t
Pg0KPiANCj4gUmVqZWN0IHRoZSBuc2lkIGJyb2FkY2FzdCB2YWx1ZSAoMHhmZmZmZmZmZikgYW5k
IDB4ZmZmZmZmZmUgaW4gdGhlDQo+IEFjdGl2ZSBOYW1lc3BhY2UgSUQgbGlzdC4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IEtsYXVzIEplbnNlbiA8ay5qZW5zZW5Ac2Ftc3VuZy5jb20+DQo+IC0tLQ0K
PiAgaHcvYmxvY2svbnZtZS5jIHwgMTAgKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDEw
IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9ody9ibG9jay9udm1lLmMgYi9ody9i
bG9jay9udm1lLmMNCj4gaW5kZXggZmM1OGYzZDc2NTMwLi5hZjM5MTI2Y2Q4ZDEgMTAwNjQ0DQo+
IC0tLSBhL2h3L2Jsb2NrL252bWUuYw0KPiArKysgYi9ody9ibG9jay9udm1lLmMNCj4gQEAgLTk5
Miw2ICs5OTIsMTYgQEAgc3RhdGljIHVpbnQxNl90IG52bWVfaWRlbnRpZnlfbnNsaXN0KE52bWVD
dHJsICpuLCBOdm1lSWRlbnRpZnkgKmMpDQo+ICANCj4gICAgICB0cmFjZV9wY2lfbnZtZV9pZGVu
dGlmeV9uc2xpc3QobWluX25zaWQpOw0KPiAgDQo+ICsgICAgLyoNCj4gKyAgICAgKiBCb3RoIDB4
ZmZmZmZmZmYgKE5WTUVfTlNJRF9CUk9BRENBU1QpIGFuZCAweGZmZmZmZmZlIGFyZSBpbnZhbGlk
IHZhbHVlcw0KPiArICAgICAqIHNpbmNlIHRoZSBBY3RpdmUgTmFtZXNwYWNlIElEIExpc3Qgc2hv
dWxkIHJldHVybiBuYW1lc3BhY2VzIHdpdGggaWRzDQo+ICsgICAgICogKmhpZ2hlciogdGhhbiB0
aGUgTlNJRCBzcGVjaWZpZWQgaW4gdGhlIGNvbW1hbmQuIFRoaXMgaXMgYWxzbyBzcGVjaWZpZWQN
Cj4gKyAgICAgKiBpbiB0aGUgc3BlYyAoTlZNIEV4cHJlc3MgdjEuM2QsIFNlY3Rpb24gNS4xNS40
KS4NCj4gKyAgICAgKi8NCj4gKyAgICBpZiAobWluX25zaWQgPj0gTlZNRV9OU0lEX0JST0FEQ0FT
VCAtIDEpIHsNCj4gKyAgICAgICAgcmV0dXJuIE5WTUVfSU5WQUxJRF9OU0lEIHwgTlZNRV9ETlI7
DQo+ICsgICAgfQ0KPiArDQo+ICAgICAgbGlzdCA9IGdfbWFsbG9jMChkYXRhX2xlbik7DQo+ICAg
ICAgZm9yIChpID0gMDsgaSA8IG4tPm51bV9uYW1lc3BhY2VzOyBpKyspIHsNCj4gICAgICAgICAg
aWYgKGkgPCBtaW5fbnNpZCkgew0K

