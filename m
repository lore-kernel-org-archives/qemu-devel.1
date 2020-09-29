Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CC3C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 15:47:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95D98206D9
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 15:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hIMii0l4";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="v400Bmx4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95D98206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNHqn-0006gp-6N
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 11:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=534de8db0=Dmitry.Fomichev@wdc.com>)
 id 1kNHnQ-0003Ud-8q; Tue, 29 Sep 2020 11:44:04 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:28050)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=534de8db0=Dmitry.Fomichev@wdc.com>)
 id 1kNHnN-0004M4-P3; Tue, 29 Sep 2020 11:44:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601394242; x=1632930242;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=eH8D8nsXQ8QX54YpviwwCpC1jOd8Jx5TBpQXzIbUUhc=;
 b=hIMii0l42uqd6LfdKto5VyV8QxhsLSk3LaacmfwrCJ9M3DAX/BfY45KL
 6LjDU/goqUU+hUoBnnuPfLwq9G1XX0XFYy9EXjG6G+Spdm3etANz0sMde
 2Bd7mXf2XXUq6nsLCza1JgJVm8IIryqAtGWSEb1ZYp3kpElaZ6c3u7hqP
 0m7m7v2muGeYaBeiQCu00lt3fWvrRqIIONbyYNuJXbaqX4YdKcUx98zId
 6e3YRK4bIxQkWlitOeecOj1IrrHu2U6lb4g+ptdRnfhVz5R16S++nIH0g
 unzvuhFTlzYb0ph8lea/YPLsBfsO1OzBlInbJKyArOzppNzJNeWDqPTXr w==;
IronPort-SDR: 6LI7BMvXQEQxI7V7Cy1wDgUKJ2SGGg0v+GbE2WjEhfC8BmRu4UXm6oSPI+fGCyklBbJD73TJqD
 Ua1Nw353NeiLJXreN29I1mg1MLHqxSDXabfbp3DpmWBq8cUIepDdLgQMkbatf69cRUOb9naLfn
 Is4ajfj1xPJ/syACQH7RTq072XrIpcgXeOKYN6D0DtN9IPTk2SxZin6bfRTVw5vWiUlwrTGhSh
 9ECckRNCm+y/jgarSQj/IgtCDLXGjOv4oSm6uES37j0zINxSqvn4474I6wGFrDoZ2xiryrQ9pC
 e4s=
X-IronPort-AV: E=Sophos;i="5.77,319,1596470400"; d="scan'208";a="152938374"
Received: from mail-co1nam11lp2171.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.171])
 by ob1.hgst.iphmx.com with ESMTP; 29 Sep 2020 23:43:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nYSI+DK3JwJGTnPKvleqBd1tUmeC5VjIx5qJr4oWwJtOqZtP1/buhMc+fIPCetp/3Itqo/crmUDEGQGfqL3mMkgYUdd9Dlcw6wg3ySuFPBknPPFFvemyPueXKEIg/ZlLBXO9Zuj9a0f86pgoVxRY9Jx7L8lsqcYC35Zwl2d3FWS4xqbnjip7KiEsTlQBQqJMIa9x5ui/XuujlcMEuJIjONIT6+ECAJ7/+bzDVBhMzRIG28sEQd3KhQSoJjpzYEhjUb4PJrX2xrWJLPHCnDl/jbCmMOPMYc+tZGqffKFCZfM9S3zKCsOj4oiF57E5Qyi2EmW7PdQ4i61DJ+4cIfoFZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eH8D8nsXQ8QX54YpviwwCpC1jOd8Jx5TBpQXzIbUUhc=;
 b=T7YpLo/PFc8I/WojBzvyWaKh8RGsCY4rUAZAX/dyEaNMe9jBfh5v8cqKxpZMG86oKwZOMFP8nYVXOhT5XuShkUrSCx1BXHL97o7FUu7tj+09ymrW9LZ/MKL1Foqj3qWqgAYQe26HqiUIjisfh1FyD0ag5zw/gVmYolUxK5pC5latbvRmWf9eCI5K07gGo6ylceLCOu4oubTEZGObXYehVQBn076JnsDFob4S81ZUCiqSFks60HYeibF4MujE45odU8n2oGclgigEHfFpjXfj4ry1MFphai+RizrXbqhREnmJLKKNkGZLpqw8VjewFZIm0AxmUvUEOLwmvmizeOWkKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eH8D8nsXQ8QX54YpviwwCpC1jOd8Jx5TBpQXzIbUUhc=;
 b=v400Bmx4LVK/QlhMZ6ZRY8izTpLP7oMkK7xWf3i17p1XzT9o0j+JhjdnjqazDJdwzDn3Op6fnNOntHt2zPgnCKdQqE5hqipnQpQuIbXTAA+W3Pf4TYliH4R77r1JHiCp8WUmz9rvqhdCipJhs5867Ujun9hEIenjF7cKOeUVFI8=
Received: from MN2PR04MB5951.namprd04.prod.outlook.com (2603:10b6:208:3f::13)
 by MN2PR04MB5693.namprd04.prod.outlook.com (2603:10b6:208:a0::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Tue, 29 Sep
 2020 15:43:51 +0000
Received: from MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44d8:522e:db29:bb94]) by MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44d8:522e:db29:bb94%6]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 15:43:51 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: Klaus Jensen <its@irrelevant.dk>
Subject: RE: [PATCH v5 13/14] hw/block/nvme: Use zone metadata file for
 persistence
Thread-Topic: [PATCH v5 13/14] hw/block/nvme: Use zone metadata file for
 persistence
Thread-Index: AQHWlUAhPX2lK+k4SUiaE/AfsLE3xal9reUAgAH5ySA=
Date: Tue, 29 Sep 2020 15:43:51 +0000
Message-ID: <MN2PR04MB59511B0C4F1DB91B38085DB0E1320@MN2PR04MB5951.namprd04.prod.outlook.com>
References: <20200928023528.15260-1-dmitry.fomichev@wdc.com>
 <20200928023528.15260-14-dmitry.fomichev@wdc.com>
 <20200928075140.GC1967@apples.localdomain>
In-Reply-To: <20200928075140.GC1967@apples.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: irrelevant.dk; dkim=none (message not signed)
 header.d=none;irrelevant.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 42c4b165-c6e9-4ac4-728f-08d8648e76d7
x-ms-traffictypediagnostic: MN2PR04MB5693:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB569378C0F86C011E6AE053C9E1320@MN2PR04MB5693.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:294;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mn3PsHgVenKhCfAE05KuqrnHVs2Vtsnu6KdyNpx6aKdUjmOkLqp82VtTRi/Urpg20Dq/jZS4y4+SgX5Mwfyi2rR6RBaag6ZyCd6YqX9Vp3b/+oTY8WifraWRq46b5Dw1puTG7kkETPpVKl94TKDFVTY8s8sFj/LUFxEvlCAh/Firwne4GMxcXOzyJr0kyJeQQsigCYD0pMg+IjuKqV2ntuCiLyWtVGGialCgfj14XlwQUBIh3BmfwUnH4KPA1wRioJ0qhDDye6HRJ/IcEWETlmuwaiMhcB55Ht28Q70QvtVURNsideS6NMsYR2VmKuOd24/16w/wjHCg6SDCuK4POg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB5951.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(39860400002)(346002)(366004)(5660300002)(33656002)(76116006)(8936002)(71200400001)(2906002)(6506007)(53546011)(9686003)(55016002)(52536014)(7696005)(186003)(86362001)(478600001)(6916009)(26005)(83380400001)(4326008)(8676002)(64756008)(66446008)(66476007)(66556008)(66946007)(316002)(54906003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: abXae7OGdYU+vQjZV+fD5GYcCmVCKl9ztZwld5LebW3lkqbl4+x6enpNyzygWw3t2drVJRPB+z4L2fNuaJpRcfFr3hzRQm8PM9x1F6vYcVKXaSxYlI9uw/xgYmzvlYJhHOFOpiVRSBL6Wo3iGkGqMUxKiQbKYyMXOjs3qMYObYx3oeY5Wg2sXKvVX2xTD8AuARkq9DTtlFHqY/pKc27/S2MGpV71drjzv0DL6MGg6Te4xKBTfgpzHiKNHqR3yOv+JOuWRFSugW41WD4GAWpOyejtWk5cOflrS0xbWrFh48tLX6SrMx3RDHCqpySCT/L5t6+55O2b3vJ5vx8hAbokmK4ld5DrIaUHVIIG7wHQJfZuYMRe2uEGw3FnF4/0Qb4usq8WYKcq2brVuuWNrYJriuq5JlV+rRttejaZnpVEZ8AlQqL6GMFa+hnZzVYO5/wC2V12M4zXCI+hamHe10k+8G6ZtNk9zLmwTWenU64PdKBuudKE8H8uw3kMp+3dZzaLLlETcPfANgPBcUl3uGwcDHBdHEdRpHIkfUBHNYqaIUbjoJ6do/ZCrp/0Sgk0IilYjO3vS3SJRw6ijYBKwKi0me/gPnsOvMJqLCMcEi7OqgXloN9iZOWuJGFBXBw1GVoDxNuxRzBZG/jCdmRgin8t7w==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5951.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42c4b165-c6e9-4ac4-728f-08d8648e76d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 15:43:51.3640 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JmnyjRzVVmQKpkIez5O+vvUDyTUc9xtA4X45N61c5RgrBZPzgKavt+AIRXUtA3dl299Ex9Ofg+8W9vFvV22G5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5693
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=534de8db0=Dmitry.Fomichev@wdc.com; helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 11:43:59
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
 Niklas Cassel <Niklas.Cassel@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Keith Busch <kbusch@kernel.org>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS2xhdXMgSmVuc2VuIDxp
dHNAaXJyZWxldmFudC5kaz4NCj4gU2VudDogTW9uZGF5LCBTZXB0ZW1iZXIgMjgsIDIwMjAgMzo1
MiBBTQ0KPiBUbzogRG1pdHJ5IEZvbWljaGV2IDxEbWl0cnkuRm9taWNoZXZAd2RjLmNvbT4NCj4g
Q2M6IEtlaXRoIEJ1c2NoIDxrYnVzY2hAa2VybmVsLm9yZz47IEtsYXVzIEplbnNlbg0KPiA8ay5q
ZW5zZW5Ac2Ftc3VuZy5jb20+OyBLZXZpbiBXb2xmIDxrd29sZkByZWRoYXQuY29tPjsgUGhpbGlw
cGUNCj4gTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPjsgTWF4aW0gTGV2aXRza3kN
Cj4gPG1sZXZpdHNrQHJlZGhhdC5jb20+OyBGYW0gWmhlbmcgPGZhbUBldXBob24ubmV0PjsgTmlr
bGFzIENhc3NlbA0KPiA8TmlrbGFzLkNhc3NlbEB3ZGMuY29tPjsgRGFtaWVuIExlIE1vYWwgPERh
bWllbi5MZU1vYWxAd2RjLmNvbT47DQo+IHFlbXUtYmxvY2tAbm9uZ251Lm9yZzsgcWVtdS1kZXZl
bEBub25nbnUub3JnOyBBbGlzdGFpciBGcmFuY2lzDQo+IDxBbGlzdGFpci5GcmFuY2lzQHdkYy5j
b20+OyBNYXRpYXMgQmpvcmxpbmcgPE1hdGlhcy5Cam9ybGluZ0B3ZGMuY29tPg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIHY1IDEzLzE0XSBody9ibG9jay9udm1lOiBVc2Ugem9uZSBtZXRhZGF0YSBm
aWxlIGZvcg0KPiBwZXJzaXN0ZW5jZQ0KPiANCj4gT24gU2VwIDI4IDExOjM1LCBEbWl0cnkgRm9t
aWNoZXYgd3JvdGU6DQo+ID4gQSBaTlMgZHJpdmUgdGhhdCBpcyBlbXVsYXRlZCBieSB0aGlzIG1v
ZHVsZSBpcyBjdXJyZW50bHkgaW5pdGlhbGl6ZWQNCj4gPiB3aXRoIGFsbCB6b25lcyBFbXB0eSB1
cG9uIHN0YXJ0dXAuIEhvd2V2ZXIsIGFjdHVhbCBaTlMgU1NEcyBzYXZlIHRoZQ0KPiA+IHN0YXRl
IGFuZCBjb25kaXRpb24gb2YgYWxsIHpvbmVzIGluIHRoZWlyIGludGVybmFsIE5WUkFNIGluIHRo
ZSBldmVudA0KPiA+IG9mIHBvd2VyIGxvc3MuIFdoZW4gc3VjaCBhIGRyaXZlIGlzIHBvd2VyZWQg
dXAgYWdhaW4sIGl0IGNsb3NlcyBvcg0KPiA+IGZpbmlzaGVzIGFsbCB6b25lcyB0aGF0IHdlcmUg
b3BlbiBhdCB0aGUgbW9tZW50IG9mIHNodXRkb3duLiBCZXNpZGVzDQo+ID4gdGhhdCwgdGhlIHdy
aXRlIHBvaW50ZXIgcG9zaXRpb24gYXMgd2VsbCBhcyB0aGUgc3RhdGUgYW5kIGNvbmRpdGlvbg0K
PiA+IG9mIGFsbCB6b25lcyBpcyBwcmVzZXJ2ZWQgYWNyb3NzIHBvd2VyLWRvd25zLg0KPiA+DQo+
ID4gVGhpcyBjb21taXQgYWRkcyB0aGUgY2FwYWJpbGl0eSB0byBoYXZlIGEgcGVyc2lzdGVudCB6
b25lIG1ldGFkYXRhDQo+ID4gdG8gdGhlIGRldmljZS4gVGhlIG5ldyBvcHRpb25hbCBtb2R1bGUg
cHJvcGVydHksICJ6b25lX2ZpbGUiLA0KPiA+IGlzIGludHJvZHVjZWQuIElmIGFkZGVkIHRvIHRo
ZSBjb21tYW5kIGxpbmUsIHRoaXMgcHJvcGVydHkgc3BlY2lmaWVzDQo+ID4gdGhlIG5hbWUgb2Yg
dGhlIGZpbGUgdGhhdCBzdG9yZXMgdGhlIHpvbmUgbWV0YWRhdGEuIElmICJ6b25lX2ZpbGUiIGlz
DQo+ID4gb21pdHRlZCwgdGhlIGRldmljZSB3aWxsIGJlIGluaXRpYWxpemVkIHdpdGggYWxsIHpv
bmVzIGVtcHR5LCB0aGUgc2FtZQ0KPiA+IGFzIGJlZm9yZS4NCj4gPg0KPiA+IElmIHpvbmUgbWV0
YWRhdGEgaXMgY29uZmlndXJlZCB0byBiZSBwZXJzaXN0ZW50LCB0aGVuIHpvbmUgZGVzY3JpcHRv
cg0KPiA+IGV4dGVuc2lvbnMgYWxzbyBwZXJzaXN0IGFjcm9zcyBjb250cm9sbGVyIHNodXRkb3du
cy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IERtaXRyeSBGb21pY2hldiA8ZG1pdHJ5LmZvbWlj
aGV2QHdkYy5jb20+DQo+ID4gLS0tDQo+ID4gIGh3L2Jsb2NrL252bWUtbnMuYyAgICB8IDM0MQ0K
PiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0NCj4gPiAgaHcvYmxv
Y2svbnZtZS1ucy5oICAgIHwgIDMzICsrKysNCj4gPiAgaHcvYmxvY2svbnZtZS5jICAgICAgIHwg
ICAyICsNCj4gPiAgaHcvYmxvY2svdHJhY2UtZXZlbnRzIHwgICAxICsNCj4gPiAgNCBmaWxlcyBj
aGFuZ2VkLCAzNjIgaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZm
IC0tZ2l0IGEvaHcvYmxvY2svbnZtZS1ucy5jIGIvaHcvYmxvY2svbnZtZS1ucy5jDQo+ID4gaW5k
ZXggNDc3NTFmMmQ1NC4uYTk0MDIxZGE4MSAxMDA2NDQNCj4gPiAtLS0gYS9ody9ibG9jay9udm1l
LW5zLmMNCj4gPiArKysgYi9ody9ibG9jay9udm1lLW5zLmMNCj4gPiBAQCAtMjkzLDEyICs0MjEs
MTgwIEBAIHN0YXRpYyB2b2lkDQo+IG52bWVfaW5pdF96b25lX21ldGEoTnZtZU5hbWVzcGFjZSAq
bnMpDQo+ID4gICAgICAgICAgICAgIGktLTsNCj4gPiAgICAgICAgICB9DQo+ID4gICAgICB9DQo+
ID4gKw0KPiA+ICsgICAgaWYgKG5zLT5wYXJhbXMuem9uZV9maWxlKSB7DQo+ID4gKyAgICAgICAg
bnZtZV9zZXRfem9uZV9tZXRhX2RpcnR5KG5zKTsNCj4gPiArICAgIH0NCj4gPiArfQ0KPiA+ICsN
Cj4gPiArc3RhdGljIGludCBudm1lX29wZW5fem9uZV9maWxlKE52bWVOYW1lc3BhY2UgKm5zLCBi
b29sICppbml0X21ldGEsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJv
ciAqKmVycnApDQo+ID4gK3sNCj4gPiArICAgIE9iamVjdCAqZmlsZV9iZTsNCj4gPiArICAgIEhv
c3RNZW1vcnlCYWNrZW5kICpmYjsNCj4gPiArICAgIHN0cnVjdCBzdGF0IHN0YXRidWY7DQo+ID4g
KyAgICBpbnQgcmV0Ow0KPiA+ICsNCj4gPiArICAgIHJldCA9IHN0YXQobnMtPnBhcmFtcy56b25l
X2ZpbGUsICZzdGF0YnVmKTsNCj4gPiArICAgIGlmIChyZXQgJiYgZXJybm8gPT0gRU5PRU5UKSB7
DQo+ID4gKyAgICAgICAgKmluaXRfbWV0YSA9IHRydWU7DQo+ID4gKyAgICB9IGVsc2UgaWYgKCFT
X0lTUkVHKHN0YXRidWYuc3RfbW9kZSkpIHsNCj4gPiArICAgICAgICBlcnJvcl9zZXRnKGVycnAs
ICJcIiVzXCIgaXMgbm90IGEgcmVndWxhciBmaWxlIiwNCj4gPiArICAgICAgICAgICAgICAgICAg
IG5zLT5wYXJhbXMuem9uZV9maWxlKTsNCj4gPiArICAgICAgICByZXR1cm4gLTE7DQo+ID4gKyAg
ICB9DQo+ID4gKw0KPiA+ICsgICAgZmlsZV9iZSA9IG9iamVjdF9uZXcoVFlQRV9NRU1PUllfQkFD
S0VORF9GSUxFKTsNCj4gPiArICAgIG9iamVjdF9wcm9wZXJ0eV9zZXRfc3RyKGZpbGVfYmUsICJt
ZW0tcGF0aCIsIG5zLT5wYXJhbXMuem9uZV9maWxlLA0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgJmVycm9yX2Fib3J0KTsNCj4gPiArICAgIG9iamVjdF9wcm9wZXJ0eV9zZXRfaW50
KGZpbGVfYmUsICJzaXplIiwgbnMtPm1ldGFfc2l6ZSwgJmVycm9yX2Fib3J0KTsNCj4gPiArICAg
IG9iamVjdF9wcm9wZXJ0eV9zZXRfYm9vbChmaWxlX2JlLCAic2hhcmUiLCB0cnVlLCAmZXJyb3Jf
YWJvcnQpOw0KPiA+ICsgICAgb2JqZWN0X3Byb3BlcnR5X3NldF9ib29sKGZpbGVfYmUsICJkaXNj
YXJkLWRhdGEiLCBmYWxzZSwgJmVycm9yX2Fib3J0KTsNCj4gPiArICAgIGlmICghdXNlcl9jcmVh
dGFibGVfY29tcGxldGUoVVNFUl9DUkVBVEFCTEUoZmlsZV9iZSksIGVycnApKSB7DQo+ID4gKyAg
ICAgICAgb2JqZWN0X3VucmVmKGZpbGVfYmUpOw0KPiA+ICsgICAgICAgIHJldHVybiAtMTsNCj4g
PiArICAgIH0NCj4gPiArICAgIG9iamVjdF9wcm9wZXJ0eV9hZGRfY2hpbGQoT0JKRUNUKG5zKSwg
Il9mYiIsIGZpbGVfYmUpOw0KPiA+ICsgICAgb2JqZWN0X3VucmVmKGZpbGVfYmUpOw0KPiA+ICsN
Cj4gPiArICAgIGZiID0gTUVNT1JZX0JBQ0tFTkQoZmlsZV9iZSk7DQo+ID4gKyAgICBucy0+em9u
ZV9tciA9IGhvc3RfbWVtb3J5X2JhY2tlbmRfZ2V0X21lbW9yeShmYik7DQo+ID4gKw0KPiA+ICsg
ICAgcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgbnZtZV9tYXBfem9u
ZV9maWxlKE52bWVOYW1lc3BhY2UgKm5zLCBib29sICppbml0X21ldGEpDQo+ID4gK3sNCj4gPiAr
ICAgIG5zLT56b25lX21ldGEgPSAodm9pZCAqKW1lbW9yeV9yZWdpb25fZ2V0X3JhbV9wdHIobnMt
PnpvbmVfbXIpOw0KPiANCj4gSSBmb3Jnb3QgdGhhdCB0aGUgSG9zdE1lbW9yeUJhY2tlbmQgZG9l
c24ndCBtYWdpY2FsbHkgbWFrZSB0aGUgbWVtb3J5DQo+IGF2YWlsYWJsZSB0byB0aGUgZGV2aWNl
LCBzbyBvZiBjb3Vyc2UgdGhpcyBpcyBzdGlsbCBuZWVkZWQuDQo+IA0KPiBBbnl3YXkuDQo+IA0K
PiBObyByZWFzb24gZm9yIG1lIHRvIGtlZXAgY29tcGxhaW5pbmcgYWJvdXQgdGhpcy4gSSBkbyBu
b3QgbGlrZSBpdCwgSQ0KPiB3aWxsIG5vdCBBQ0sgaXQgYW5kIEkgdGhpbmsgSSBtYWRlIG15IHJl
YXNvbnMgcHJldHR5IGNsZWFyLg0KDQpTbywgbWVtb3J5X3JlZ2lvbl9tc3luYygpIGlzIG9rLCBi
dXQgbWVtb3J5X3JlZ2lvbl9nZXRfcmFtX3B0cigpIGlzIG5vdD8/DQpUaGlzIGlzIHRoZSBzYW1l
IEFQSSEgWW91IGFyZSByZWFsbHkgc3BsaXR0aW5nIGhhaXJzIGhlcmUgdG8gc3VpdCB5b3VyIGFn
ZW5kYS4NCk1vdmluZyBnb2FsIHBvc3RzIGFnYWluLi4uLg0KDQpUaGUgIkkgZG8gbm90IGxpa2Ug
aXQiIHBhcnQgaXMgcHJpY2VsZXNzLiBJdCBpcyBncmVhdCB0aGF0IHdlIGhhdmUgbWFpbCBhcmNo
aXZlcyBhdmFpbGFibGUuDQoNCg==

