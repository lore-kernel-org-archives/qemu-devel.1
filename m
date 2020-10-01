Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B86C4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:54:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D6F020872
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="i2eeCJBV";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="VsGI0zcF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D6F020872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO0uN-0001JR-Lj
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 11:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=536559953=Niklas.Cassel@wdc.com>)
 id 1kO0r7-00051A-KO; Thu, 01 Oct 2020 11:50:54 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:47718)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=536559953=Niklas.Cassel@wdc.com>)
 id 1kO0qw-0005P8-Dy; Thu, 01 Oct 2020 11:50:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601567442; x=1633103442;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=m/9Wxum6kvCiU1sHyWmO9InipzI0Eb1Tw6DWnNtJRpA=;
 b=i2eeCJBVg04nE4UV+IUy+q18Ru6frDhFapEvvAjrXtSAUiRqqHLEsCw6
 cGIuHVoIBBKM8GvtHPmReNzMP++LXoZ+I4fuv/OICuOlrpwgC3PHSWgWY
 55vcAYu1d4OI3Ysb6Sv5EDoe6FOoseycsdYagbm3xym+1ZrOqzhZFIxX7
 5j1hS2jd7YmbF62t5geKrR87cwtj+6hpnXMIhPiIHVUrVxNhuelLCz3Fj
 SmDznYaVG8QBfv/JZ2Zwqf+Wq3kCEfABwIFmBnby+KScHYMiNucmta07U
 VBFY7Jc+VL2lWynjMdy/zDn928M3xrTNjGHMNfqZmeyfuJVEkBtuyeS+Z g==;
IronPort-SDR: t1mYyRNnvVWthK+h0vnYtng9zqGreKk3K6ZqfBcxB48eQvif2lZbACVDIDsflRRxz5dgkGxtBa
 QwHdIlbPzjn80kIH+nEtKYp1CTYHp34vkCPM5PZqVlU3ZcyQHdJxfXzVuv0eBWP6mP14TP5P8y
 Fej3GdWE1zvMyAae3D015FIT01EnSVwfWqwKvD+cFp2YJO6E9SjjVLGo7XV8jcks9Fow3zT/SA
 hJvG1jSrozoP9oO6WHclLV9Dy/dvAVJwo/sZoSk2Z0I7wmLnQFNFzXFp5t+R3oPRdBrjuMXyQY
 oEI=
X-IronPort-AV: E=Sophos;i="5.77,323,1596470400"; d="scan'208";a="148843279"
Received: from mail-bn8nam11lp2170.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.170])
 by ob1.hgst.iphmx.com with ESMTP; 01 Oct 2020 23:50:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WeVFIZrhaihbfaBNM9aNqxyupHXXM0swT/ycLzekKi55N1GQBAHz+EN4xuAxdwK/CK7/UwY2Lw+E43EzHu0x+StsKOmR4cMKHBgO+I2JJRr703Fs9Omysxmd0HShusoV2VjQ7bQjSeZRPHr7mA54kZ+JnMaorBVCBWErb+8BcbnIo+pElyQTQqqH3S4hGuqfaQcu/wLuxHDYq+5Sf1ILxhtkqfZhS9jnxQSizGxszwT4/dTEZAO+eWwbRTjmCcEO21rWgWuBV0r/gOZuHfMF6QHpj0dNi1KPz9oV6coJlSRCZTKyLlf50BsGcOScjEvzOHu2yQ5mJN1jMztm6NEtcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/9Wxum6kvCiU1sHyWmO9InipzI0Eb1Tw6DWnNtJRpA=;
 b=oL/Btp9DuVl+WzjAy+NGWT8DM6XDkPVaUYHQ0IgorYxm1v82FdGgdTao3fBqG2XQqgFXLzJiEOTBZFymhBxVViT2Au/t4swqQlqQkI0eK7SA180X6Ji92qCZm3vsggSFQSeVx2aSqHmg6cLiRDtX8V892us5z06BntbWxwwy3segIkpl2t0T3pBUcfCmMWTvjyU9hDNJJCwI9aMwxOk65iYNpbrEzIHEO3lG3VtW3DUS9ZuV9MeOsUs/Li7moXLSF+cNuBAK7KrAb4Fuhpf7nZWnWNypUMhtV1DoJRsomVW6yvSvabpD6UWhLbcntOcKqo3rBe5FD6kPVALoFC0gBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/9Wxum6kvCiU1sHyWmO9InipzI0Eb1Tw6DWnNtJRpA=;
 b=VsGI0zcFECxFnuk3bY2FaRmrTL1Y2vGe+StJ6WWGh8acInhKoojh/87bRHxMRAubjss8aeBy85/LrfMO2LhLmj0hbYPB/GfstRwxwWt+cIKsfbGKLels2Zr4Z5uj87reHdlJdVq7yiqX+oKR9wMW6jfUlSd2fHbn1+ahaQoyoEE=
Received: from BN6PR04MB0724.namprd04.prod.outlook.com (2603:10b6:404:ce::23)
 by BN7PR04MB4132.namprd04.prod.outlook.com (2603:10b6:406:ef::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Thu, 1 Oct
 2020 15:50:37 +0000
Received: from BN6PR04MB0724.namprd04.prod.outlook.com
 ([fe80::acb1:47a4:73ba:69a7]) by BN6PR04MB0724.namprd04.prod.outlook.com
 ([fe80::acb1:47a4:73ba:69a7%9]) with mapi id 15.20.3433.037; Thu, 1 Oct 2020
 15:50:35 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v5 05/14] hw/block/nvme: Add support for Namespace Types
Thread-Topic: [PATCH v5 05/14] hw/block/nvme: Add support for Namespace Types
Thread-Index: AQHWlUAVwLU3dDmYeECN1HNLSzDofqmCn96AgABE5wCAAAXtAA==
Date: Thu, 1 Oct 2020 15:50:35 +0000
Message-ID: <20201001155034.GA337287@localhost.localdomain>
References: <20200928023528.15260-1-dmitry.fomichev@wdc.com>
 <20200928023528.15260-6-dmitry.fomichev@wdc.com>
 <20201001112245.GA316454@localhost.localdomain>
 <20201001152922.GC3343@C02WT3WMHTD6>
In-Reply-To: <20201001152922.GC3343@C02WT3WMHTD6>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.226.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a5dbcf72-f3e0-4dcc-048e-08d86621bcb7
x-ms-traffictypediagnostic: BN7PR04MB4132:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR04MB4132C5FCBF96AAB1DC414656F2300@BN7PR04MB4132.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VpsNIowuFLY3RaGrko3HPwVGwS0LOQ6+6LjRFZpEUNsY+RUe8ZJo5/R71VwSlOUfdgd6R+JPkzPVByjQA15Jp4FIALRFTDlJ2hiTm7tyxUGX+na1/FmrN01hTUyFZLd73ZVy5uN4hV0LL/aSYaosZn/V36NU2ydovQlklhaXdQGxMpSepDZugbbyw6v/AAri0OaXkmidstety6LDh5DdqKrZQvtRxgJslZoYoyf3I+sYjTZdtpB+WVq4fS9wzNCWMaIA21OovPXVOVlra+y1ihkZ7K3ZZvYtX1fyZhTUEJyIRE2ghy932bztiippzLKh85vxqKaJzWa8OHSL037kuYv3AJo9oG4ekCYv2FW09O8G58THLY/dAxDEp8xdu69o
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR04MB0724.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(39860400002)(366004)(136003)(346002)(6486002)(316002)(186003)(76116006)(91956017)(5660300002)(83380400001)(66446008)(478600001)(4326008)(6916009)(66946007)(66556008)(54906003)(66476007)(64756008)(8936002)(8676002)(9686003)(6512007)(6506007)(71200400001)(26005)(1076003)(86362001)(33656002)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: dlEg/SAft75HfgVkuLGPhDoV9hkbVF4FMK7YvN68RN0viE1lHwN3BvdARc+Jw4F8Ujr3W51wfhujwP87gI4BniG4y23ardvKcLbhbQHuyvpUu4+HiTp10HQhS0qqPsL6DJmo9/EwBseXDfiIbzRZGZ1GVfSGYUpyXzleA3ZKikzdruwbRPSiIKn5uEX4M5hdsErk3RQOrQ1hWtvsf42ArO/lYy9upuCJmpjxQUCgNfYs/a7/4sbIvcfaw1x5fTCw5LpBSKHZuGy6RVYmxcI7RHR6vsyEELDDrqgMbkFwfAbq3sUOjUS5xlHLsqhtG1FOpn3srT3x4lKq40tVcr6itEG7sNgLgYYbp848ii7A6ZqEf0mfvRWWldX98a2dZwAEw741aHM+tmeOFIHkXFcCAGy1o7kNY88LCU/tSgZtLSm7jMOn3m13WkM3keFQ2HBNvZbIYtBEXHNUxUMlBgSoZxteuBWuDF2rMhNG1EefKIZi0SxqgBom+tEAyo8Al0hPnlZKV+lFF2RXlEo2kWHnUnqqkiaRnQTXxJtHLRMlun+ZKvP6TdD+Ucd3Hlf2aT0BgTdlrrK5QcDclBcBcliXr/7zJ8QVJQXDZClxHb9Rmw9f4qskrrM2t3W4E2o5UONylkMWE1nausjjZqIdUZqmzg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <EDFF4DB5B950D6489AAAFC718F07E63A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR04MB0724.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5dbcf72-f3e0-4dcc-048e-08d86621bcb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2020 15:50:35.4551 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tKodzSOPh3mhI6UMWmiRmqsFGUY5DFGM0Ndpfzayw9hMD84Rq/Naha+yprzymyzmDBZVnQnqF0CycyddXO2uLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB4132
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=536559953=Niklas.Cassel@wdc.com; helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 11:50:38
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Dmitry Fomichev <Dmitry.Fomichev@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gVGh1LCBPY3QgMDEsIDIwMjAgYXQgMDk6Mjk6MjJBTSAtMDYwMCwgS2VpdGggQnVzY2ggd3Jv
dGU6DQo+IE9uIFRodSwgT2N0IDAxLCAyMDIwIGF0IDExOjIyOjQ2QU0gKzAwMDAsIE5pa2xhcyBD
YXNzZWwgd3JvdGU6DQo+ID4gT24gTW9uLCBTZXAgMjgsIDIwMjAgYXQgMTE6MzU6MTlBTSArMDkw
MCwgRG1pdHJ5IEZvbWljaGV2IHdyb3RlOg0KPiA+ID4gRnJvbTogTmlrbGFzIENhc3NlbCA8bmlr
bGFzLmNhc3NlbEB3ZGMuY29tPg0KPiA+ID4gQEAgLTIyMjIsNiArMjMyOCwzMCBAQCBzdGF0aWMg
dm9pZCBudm1lX3dyaXRlX2JhcihOdm1lQ3RybCAqbiwgaHdhZGRyIG9mZnNldCwgdWludDY0X3Qg
ZGF0YSwNCj4gPiA+ICAgICAgICAgIGJyZWFrOw0KPiA+ID4gICAgICBjYXNlIDB4MTQ6ICAvKiBD
QyAqLw0KPiA+ID4gICAgICAgICAgdHJhY2VfcGNpX252bWVfbW1pb19jZmcoZGF0YSAmIDB4ZmZm
ZmZmZmYpOw0KPiA+ID4gKw0KPiA+ID4gKyAgICAgICAgaWYgKE5WTUVfQ0NfQ1NTKGRhdGEpICE9
IE5WTUVfQ0NfQ1NTKG4tPmJhci5jYykpIHsNCj4gPiA+ICsgICAgICAgICAgICBpZiAoTlZNRV9D
Q19FTihuLT5iYXIuY2MpKSB7DQo+ID4gDQo+ID4gSSBqdXN0IHNhdyB0aGlzIHByaW50IHdoZW4g
ZG9pbmcgY29udHJvbGxlciByZXNldCBvbiBhIGxpdmUgc3lzdGVtLg0KPiA+IA0KPiA+IEFkZGVk
IGEgZGVidWcgcHJpbnQ6DQo+ID4gbnZtZV93cml0ZV9iYXIgV1JJVElORzogMHgwIHByZXZpb3Vz
OiAweDQ2NDA2MQ0KPiA+IA0KPiA+IHNvIHRoZSBzZWNvbmQgaWYtc3RhdGVtZW50IGhhcyB0byBi
ZToNCj4gPiANCj4gPiAgICAgaWYgKE5WTUVfQ0NfRU4obi0+YmFyLmNjKSAmJiBOVk1FX0NDX0VO
KGRhdGEpKSB7DQo+ID4gDQo+ID4gU29ycnkgZm9yIGludHJvZHVjaW5nIHRoZSBidWcgaW4gdGhl
IGZpcnN0IHBsYWNlLg0KPiANCj4gTm8gd29ycmllcy4NCj4gDQo+IEkgZG9uJ3QgdGhpbmsgdGhl
IGNoZWNrIHNob3VsZCBiZSBoZXJlIGF0IGFsbCwgcmVhbGx5LiBUaGUgb25seSBjaGVjayBmb3Ig
dmFsaWQNCj4gQ1NTIHNob3VsZCBiZSBpbiBudm1lX3N0YXJ0X2N0cmwoKSwgd2hpY2ggSSBwb3N0
ZWQgeWVzdGVyZGF5Lg0KDQpUaGUgcmVhc29uaW5nIGZvciB0aGlzIGFkZGl0aW9uYWwgY2hlY2sg
aXMgdGhpczoNCg0KRnJvbSBDQy5DQyByZWdpc3RlciBkZXNjcmlwdGlvbjoNCg0KIlRoaXMgZmll
bGQgc2hhbGwgb25seSBiZSBjaGFuZ2VkIHdoZW4gdGhlIGNvbnRyb2xsZXINCmlzIGRpc2FibGVk
IChDQy5FTiBpcyBjbGVhcmVkIHRvIOKAmDDigJkpLiINCg0KSW4gdGhlIFFFTVUgbW9kZWwsIHdl
IGhhdmUgZnVuY3Rpb25zLCBlLmcuIG52bWVfY21kX2VmZmVjdHMoKSwNCnRoYXQgdXNlcyBuLT5i
YXIuY2MgImF0IHJ1bnRpbWUiLg0KDQpTbyBJIGRvbid0IHRoaW5rIHRoYXQgc2ltcGx5IGNoZWNr
aW5nIGZvciB2YWxpZCBDU1MgaW4NCm52bWVfc3RhcnRfY3RybCgpIGlzIHN1ZmZpY2llbnQuDQoN
ClRob3VnaHRzPw0KDQoNCktpbmQgcmVnYXJkcywNCk5pa2xhcw0KDQo+ICANCj4gPiA+ICsgICAg
ICAgICAgICAgICAgTlZNRV9HVUVTVF9FUlIocGNpX252bWVfZXJyX2NoYW5nZV9jc3Nfd2hlbl9l
bmFibGVkLA0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiY2hhbmdpbmcg
c2VsZWN0ZWQgY29tbWFuZCBzZXQgd2hlbiBlbmFibGVkIik7DQo+ID4gPiArICAgICAgICAgICAg
fSBlbHNlIHsNCj4gPiA+ICsgICAgICAgICAgICAgICAgc3dpdGNoIChOVk1FX0NDX0NTUyhkYXRh
KSkgew0KPiA+ID4gKyAgICAgICAgICAgICAgICBjYXNlIENTU19OVk1fT05MWToNCj4gPiA+ICsg
ICAgICAgICAgICAgICAgICAgIHRyYWNlX3BjaV9udm1lX2Nzc19udm1fY3NldF9zZWxlY3RlZF9i
eV9ob3N0KGRhdGEgJg0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMHhmZmZmZmZmZik7DQo+ID4gPiArICAgICAg
ICAgICAgICAgICAgICBicmVhazsNCj4gPiA+ICsgICAgICAgICAgICAgICAgY2FzZSBDU1NfQ1NJ
Og0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgTlZNRV9TRVRfQ0NfQ1NTKG4tPmJhci5jYywg
Q1NTX0NTSSk7DQo+ID4gPiArICAgICAgICAgICAgICAgICAgICB0cmFjZV9wY2lfbnZtZV9jc3Nf
YWxsX2NzZXRzX3NlbF9ieV9ob3N0KGRhdGEgJiAweGZmZmZmZmZmKTsNCj4gPiA+ICsgICAgICAg
ICAgICAgICAgICAgIGJyZWFrOw0KPiA+ID4gKyAgICAgICAgICAgICAgICBjYXNlIENTU19BRE1J
Tl9PTkxZOg0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gPiArICAgICAg
ICAgICAgICAgIGRlZmF1bHQ6DQo+ID4gPiArICAgICAgICAgICAgICAgICAgICBOVk1FX0dVRVNU
X0VSUihwY2lfbnZtZV91Yl91bmtub3duX2Nzc192YWx1ZSwNCj4gPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICJ1bmtub3duIHZhbHVlIGluIENDLkNTUyBmaWVsZCIpOw0K
PiA+ID4gKyAgICAgICAgICAgICAgICB9DQo+ID4gPiArICAgICAgICAgICAgfQ0KPiA+ID4gKyAg
ICAgICAgfQ==

