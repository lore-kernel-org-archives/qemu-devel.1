Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B451C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 00:46:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64B9A207D4
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 00:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IW2wTz/y";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="s93RBpwQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64B9A207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr9q5-0001SK-KC
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 20:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=446c5dbe3=Dmitry.Fomichev@wdc.com>)
 id 1jr9ot-0008Jn-C8; Thu, 02 Jul 2020 20:44:47 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:1435)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=446c5dbe3=Dmitry.Fomichev@wdc.com>)
 id 1jr9op-0006UZ-Kh; Thu, 02 Jul 2020 20:44:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593737083; x=1625273083;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=E/NUS7mzliHFBWquGPY5VPL/XRJZAAH/b1aZNaTVd1w=;
 b=IW2wTz/yOHkah9iVszPLrjNaCeBPgzslHDL4frnFNJ4Sl35J8jLMRZk5
 A9kzrKmKXIyWzKgrPuPVLdryW7/m3IDaQybw8qxNZCer2Fp0Nfx8xfRMl
 jy4KSH+gFAbNUJl21p3POhBTNA2g2+ImQwTuDGdTaZ3tBrJGxKOCz0LNf
 M6abQVsiAkBj4TcrR71XUhGzbfy2W77RnMdJqpB0zLkf2QmgKLtamO6iW
 Vm5fSWj9AIRFoXgsjaGn3W8QQA6voeTbNM/P4LOqjtFPxk/qscKRN9lfv
 d1q5QXV26enF+l/LPHCB9Mvs7c77FUu9/DhfcEKkyvMvD8Z4YEfJmIxrn g==;
IronPort-SDR: 7qP0b5wk8tlTPQbiwVsvHT6k7Nqpg/rogutRPDwYii4aaC7qJ0rMY3aICWNFc/S81QMO9xH+br
 t9u//qjkHR9GmlShnwNNX0gcAkJmkCBQC00wVVyFlza+VHe7y+IOUKpp6Ckqdd6PnK4RixelOx
 +B2fUhinN9qczujLMKL7PAhef0+LJ0WP5+OG4QYLiGf3ctBGXPxK5iAS3jlpztUuB41e9iJh+3
 ZGZQK/aOw+tb7aqPJxL19I/4BHG1j4lwLY5X12py0MhbNcEC+OTUOWmcZVaH1/fnYV8I8Hg03E
 TP8=
X-IronPort-AV: E=Sophos;i="5.75,306,1589212800"; d="scan'208";a="141727559"
Received: from mail-bn8nam11lp2175.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.175])
 by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2020 08:44:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WIjno99s1aMzoOQXsDeDri1d4W/rYvTjZaAXqoNqAwQMI4dqUgLXfjzgV/24tXWvSn/WIaI2jTs4EBFBz5kgXI6dwKfjX1bcLIMnfsAPrDUSGDuxselwM+7CXSZyVTG8g16P6ZEGFyxCxf3v3K0jKMl/WkJDP6TDrgCd/r1EW+83uABxVyf6mvU7EKALMYBevZz6GzhefVoQaYmc4oYtWSEvrBJsZng7RAGaXF1k4wL+p7VVyzNwwyHw2nai83m2NDieNT7hZtwIG4J9vZ3GKeQXWlQJ8JtAc2jwecyha7BguCNGWY0PVqo+Hwxs0mou8PzxEa+TNxX2lRNMUPFzaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/NUS7mzliHFBWquGPY5VPL/XRJZAAH/b1aZNaTVd1w=;
 b=S+itEe7AEwFidMOGBqGF/gNtTTl9HbaU7i91EMXqR5qr+KswdpOCj+LQ2MPfQB2AQPq6U1eKLftalkVi3dZrZka3BibZrspOjakkFj25bii0217ts1BYXxw3T1y+GMrO+xyOd89IuPy4PfayZlXGGKbl3lFjzdPN3VMLs01bZFl4CbmmDLK1lT+asGSdADUlkeIlZ6qERfw67z7kuPtIckD3zz+4GtVxMDZu9nyV5684/YkSOmAlL31K40bHmHr5sGleAozoBf8/ZVJhgiBzrlKMq1zxGxRAkLxKvUWGAt+ZtaH9vIo1ymZPtqi51MIY4wWBtd2SUspeRjJGfc5JdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/NUS7mzliHFBWquGPY5VPL/XRJZAAH/b1aZNaTVd1w=;
 b=s93RBpwQGEXFqqJFuuVXThbCAojbElSE7kL4SUnMmmD/0ltQ3a7EnB95X/HorCU5YP5wl3m0q/krxgO+I/ULu2MQYr2PucTKsQEz/l9/MppE2r8FLWpNwwrCkU1FnUv3/P6o/OoZweGhWXrXNPtyqGAScZC0itF1CjDm02rHkeM=
Received: from MN2PR04MB5951.namprd04.prod.outlook.com (2603:10b6:208:3f::13)
 by MN2PR04MB5552.namprd04.prod.outlook.com (2603:10b6:208:de::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Fri, 3 Jul
 2020 00:44:33 +0000
Received: from MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::60c5:4424:8ce4:59a9]) by MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::60c5:4424:8ce4:59a9%5]) with mapi id 15.20.3153.023; Fri, 3 Jul 2020
 00:44:33 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: "its@irrelevant.dk" <its@irrelevant.dk>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 03/17] hw/block/nvme: add support for the abort command
Thread-Topic: [PATCH 03/17] hw/block/nvme: add support for the abort command
Thread-Index: AQHWTkLq12CkCsyNAUaUouxHWkcpf6j1CbUA
Date: Fri, 3 Jul 2020 00:44:33 +0000
Message-ID: <c30f9982fee035303ae2d54e0c4bbba2128ce1bd.camel@wdc.com>
References: <20200629182642.1170387-1-its@irrelevant.dk>
 <20200629182642.1170387-4-its@irrelevant.dk>
In-Reply-To: <20200629182642.1170387-4-its@irrelevant.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
authentication-results: irrelevant.dk; dkim=none (message not signed)
 header.d=none;irrelevant.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [173.70.233.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e8b66c82-6984-4a28-59e6-08d81eea4108
x-ms-traffictypediagnostic: MN2PR04MB5552:
x-microsoft-antispam-prvs: <MN2PR04MB5552115760870AA7BBE0C8A1E16A0@MN2PR04MB5552.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 045315E1EE
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QVcnpATRSNITQ7e3VTD43cSv0dVB2A1RD+DBLAjxNphcVIw4Z/LZz4ZY2kXiub7AdMSE6nfbT5Osfe+SLcMopK1ZaThBUEEnB8TFQ1oXzPoh8ApJAtlZ1LULgtYS4if5UdY2hQet46Nny9HfJ36RVl9WvaLWHkSgrynjF1Ds36kBZcGf6hyk4RJoRDbQuzC5oClDxOiSffZISlAHVdFVEPwfnXZHk+fJZXhxnGmoCpPtMyFc1d10M13OpWhdeFmae6zEL27pQ65A7E56lhItFqW4HFeJ9+mq9RkGJN7YffEw22jVtB0mEzWG1qtxgWlY4TmNN3rH+NuF29P+S9EMiw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB5951.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(4326008)(186003)(76116006)(2616005)(83380400001)(6486002)(6512007)(110136005)(66946007)(66476007)(66446008)(54906003)(64756008)(66556008)(36756003)(71200400001)(8936002)(26005)(86362001)(316002)(5660300002)(2906002)(8676002)(478600001)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 5Jl2+6orlG+aWAYt1yH7X/NLh8a7i1z9Qe0USkTwRYtkNCj5/prvxrIN2bfMdPzgPujzJ4rZPrnseQzbwwWbh5zG497bWjOIaUpI+XXL75Purps3ua3tWWAdYyqolMRTGNuKytZ0zONwK1Ti1qNzdbHQOpIi7IS4LOFmveCByNbi6jIur9jKyn6cpCdaD0dDCW52AG+hUizTr7DL2VEUM07iSZSF9xoxkBwYnu/UwELHCxmllhEL4caX4IRQD9F1wdCN90XGAEZ0PBIUz4hrwGp5kW/JrZOBBcxqLTOhiqwWbID4makao4Oya3EM6BxbDvgOeL2/PooHsqDRHGqZbphVIZKCXnVk/G8WgYf2F/FZ2d5ceDIh6r6bqsAYvFn28QvXdi/03mz05Tr9vSRmy1JYc0xL10e6PH9xqXkGu5Abm6JngsD8/bj1u4Bftz0TLL0fvKk4V+la21vmO4frWoA2nF5LSvDK/497XQYyQHRjSWx2EFfJoN9SjqJ6meyp
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <15B5EE6C8ADFE2489FC6F1AE7476A4F7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5951.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b66c82-6984-4a28-59e6-08d81eea4108
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2020 00:44:33.3772 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z2B4nbClCwmLDkrnS7rX1m5NX39cDWW6dH7P8HIVO0vHVAvwUi0q2OZDKOZGfX+rJ3ufg68iDp7lKvaZqZgL+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5552
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=446c5dbe3=Dmitry.Fomichev@wdc.com; helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 20:44:41
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "k.jensen@samsung.com" <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IERtaXRyeSBGb21pY2hldiA8ZG1pdHJ5LmZvbWlj
aGV2QHdkYy5jb20+DQoNCk9uIE1vbiwgMjAyMC0wNi0yOSBhdCAyMDoyNiArMDIwMCwgS2xhdXMg
SmVuc2VuIHdyb3RlOg0KPiBGcm9tOiBLbGF1cyBKZW5zZW4gPGsuamVuc2VuQHNhbXN1bmcuY29t
Pg0KPiANCj4gUmVxdWlyZWQgZm9yIGNvbXBsaWFuY2Ugd2l0aCBOVk1lIHJldmlzaW9uIDEuM2Qu
IFNlZSBOVk0gRXhwcmVzcyAxLjNkLA0KPiBTZWN0aW9uIDUuMSAoIkFib3J0IGNvbW1hbmQiKS4N
Cj4gDQo+IFRoZSBBYm9ydCBjb21tYW5kIGlzIGEgYmVzdCBlZmZvcnQgY29tbWFuZDsgZm9yIG5v
dywgdGhlIGRldmljZSBhbHdheXMNCj4gZmFpbHMgdG8gYWJvcnQgdGhlIGdpdmVuIGNvbW1hbmQu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLbGF1cyBKZW5zZW4gPGtsYXVzLmplbnNlbkBjbmV4bGFi
cy5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEtsYXVzIEplbnNlbiA8ay5qZW5zZW5Ac2Ftc3VuZy5j
b20+DQo+IEFja2VkLWJ5OiBLZWl0aCBCdXNjaCA8a2J1c2NoQGtlcm5lbC5vcmc+DQo+IFJldmll
d2VkLWJ5OiBNYXhpbSBMZXZpdHNreSA8bWxldml0c2tAcmVkaGF0LmNvbT4NCj4gLS0tDQo+ICBo
dy9ibG9jay9udm1lLmMgfCAyNyArKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIDEgZmls
ZSBjaGFuZ2VkLCAyNyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaHcvYmxvY2sv
bnZtZS5jIGIvaHcvYmxvY2svbnZtZS5jDQo+IGluZGV4IGY1ZDkxNDhmMDkzNi4uYjcwMzdhN2Qz
NTA0IDEwMDY0NA0KPiAtLS0gYS9ody9ibG9jay9udm1lLmMNCj4gKysrIGIvaHcvYmxvY2svbnZt
ZS5jDQo+IEBAIC03NjEsNiArNzYxLDE4IEBAIHN0YXRpYyB1aW50MTZfdCBudm1lX2lkZW50aWZ5
KE52bWVDdHJsICpuLCBOdm1lQ21kICpjbWQpDQo+ICAgICAgfQ0KPiAgfQ0KPiAgDQo+ICtzdGF0
aWMgdWludDE2X3QgbnZtZV9hYm9ydChOdm1lQ3RybCAqbiwgTnZtZUNtZCAqY21kLCBOdm1lUmVx
dWVzdCAqcmVxKQ0KPiArew0KPiArICAgIHVpbnQxNl90IHNxaWQgPSBsZTMyX3RvX2NwdShjbWQt
PmNkdzEwKSAmIDB4ZmZmZjsNCj4gKw0KPiArICAgIHJlcS0+Y3FlLnJlc3VsdCA9IDE7DQo+ICsg
ICAgaWYgKG52bWVfY2hlY2tfc3FpZChuLCBzcWlkKSkgew0KPiArICAgICAgICByZXR1cm4gTlZN
RV9JTlZBTElEX0ZJRUxEIHwgTlZNRV9ETlI7DQo+ICsgICAgfQ0KPiArDQo+ICsgICAgcmV0dXJu
IE5WTUVfU1VDQ0VTUzsNCj4gK30NCj4gKw0KPiAgc3RhdGljIGlubGluZSB2b2lkIG52bWVfc2V0
X3RpbWVzdGFtcChOdm1lQ3RybCAqbiwgdWludDY0X3QgdHMpDQo+ICB7DQo+ICAgICAgdHJhY2Vf
cGNpX252bWVfc2V0ZmVhdF90aW1lc3RhbXAodHMpOw0KPiBAQCAtODk3LDYgKzkwOSw4IEBAIHN0
YXRpYyB1aW50MTZfdCBudm1lX2FkbWluX2NtZChOdm1lQ3RybCAqbiwgTnZtZUNtZCAqY21kLCBO
dm1lUmVxdWVzdCAqcmVxKQ0KPiAgICAgICAgICByZXR1cm4gbnZtZV9jcmVhdGVfY3EobiwgY21k
KTsNCj4gICAgICBjYXNlIE5WTUVfQURNX0NNRF9JREVOVElGWToNCj4gICAgICAgICAgcmV0dXJu
IG52bWVfaWRlbnRpZnkobiwgY21kKTsNCj4gKyAgICBjYXNlIE5WTUVfQURNX0NNRF9BQk9SVDoN
Cj4gKyAgICAgICAgcmV0dXJuIG52bWVfYWJvcnQobiwgY21kLCByZXEpOw0KPiAgICAgIGNhc2Ug
TlZNRV9BRE1fQ01EX1NFVF9GRUFUVVJFUzoNCj4gICAgICAgICAgcmV0dXJuIG52bWVfc2V0X2Zl
YXR1cmUobiwgY21kLCByZXEpOw0KPiAgICAgIGNhc2UgTlZNRV9BRE1fQ01EX0dFVF9GRUFUVVJF
UzoNCj4gQEAgLTE1ODIsNiArMTU5NiwxOSBAQCBzdGF0aWMgdm9pZCBudm1lX2luaXRfY3RybChO
dm1lQ3RybCAqbiwgUENJRGV2aWNlICpwY2lfZGV2KQ0KPiAgICAgIGlkLT5pZWVlWzFdID0gMHgw
MjsNCj4gICAgICBpZC0+aWVlZVsyXSA9IDB4YjM7DQo+ICAgICAgaWQtPm9hY3MgPSBjcHVfdG9f
bGUxNigwKTsNCj4gKw0KPiArICAgIC8qDQo+ICsgICAgICogQmVjYXVzZSB0aGUgY29udHJvbGxl
ciBhbHdheXMgY29tcGxldGVzIHRoZSBBYm9ydCBjb21tYW5kIGltbWVkaWF0ZWx5LA0KPiArICAg
ICAqIHRoZXJlIGNhbiBuZXZlciBiZSBtb3JlIHRoYW4gb25lIGNvbmN1cnJlbnRseSBleGVjdXRp
bmcgQWJvcnQgY29tbWFuZCwNCj4gKyAgICAgKiBzbyB0aGlzIHZhbHVlIGlzIG5ldmVyIHVzZWQg
Zm9yIGFueXRoaW5nLiBOb3RlIHRoYXQgdGhlcmUgY2FuIGVhc2lseSBiZQ0KPiArICAgICAqIG1h
bnkgQWJvcnQgY29tbWFuZHMgaW4gdGhlIHF1ZXVlcywgYnV0IHRoZXkgYXJlIG5vdCBjb25zaWRl
cmVkDQo+ICsgICAgICogImV4ZWN1dGluZyIgdW50aWwgcHJvY2Vzc2VkIGJ5IG52bWVfYWJvcnQu
DQo+ICsgICAgICoNCj4gKyAgICAgKiBUaGUgc3BlY2lmaWNhdGlvbiByZWNvbW1lbmRzIGEgdmFs
dWUgb2YgMyBmb3IgQWJvcnQgQ29tbWFuZCBMaW1pdCAoZm91cg0KPiArICAgICAqIGNvbmN1cnJl
bnRseSBvdXRzdGFuZGluZyBBYm9ydCBjb21tYW5kcyksIHNvIGxldHMgdXNlIHRoYXQgdGhvdWdo
IGl0IGlzDQo+ICsgICAgICogaW5jb25zZXF1ZW50aWFsLg0KPiArICAgICAqLw0KPiArICAgIGlk
LT5hY2wgPSAzOw0KPiAgICAgIGlkLT5mcm13ID0gNyA8PCAxOw0KPiAgICAgIGlkLT5scGEgPSAx
IDw8IDA7DQo+ICAgICAgaWQtPnNxZXMgPSAoMHg2IDw8IDQpIHwgMHg2Ow0K

