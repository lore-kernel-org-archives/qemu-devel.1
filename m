Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D7DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 00:53:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 804432073E
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 00:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="j1/TYqR3";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="KvAVlWAZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 804432073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr9xB-0006k6-Pf
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 20:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=446c5dbe3=Dmitry.Fomichev@wdc.com>)
 id 1jr9qx-0003R3-PF; Thu, 02 Jul 2020 20:46:55 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:42256)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=446c5dbe3=Dmitry.Fomichev@wdc.com>)
 id 1jr9qv-0006re-RU; Thu, 02 Jul 2020 20:46:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593737213; x=1625273213;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Z5OgAryDHUOSDGXRsIqJHLxCjmETcUk1oIVdgXmPkWE=;
 b=j1/TYqR3y8jgJqrrV1hobIPcJ76PV8MYQkxUUXrpfffhPCzVRxZR8yxG
 67h9Kf4zWukKiF+zzf56yi6ZcfSCYHd3BtAdQDheLfLsN9Ym0Lr7HCVeq
 WNpcELcp2N2KfNqPX53Vx4LYvKNO7Oj0quvaXqXvhFV2bYHDTy2GBZ3eU
 izI7qNX9IMZKVbT8e6IxEm/+GzMMNt2APX2kx3NZZsqjjEGo4P6TfA95T
 El1JPOblVMG7VpYC8CwvZ5Deh4RzUi4yxjeJf3Iwh/FM0On7hjvfvONDx
 lmRbjb+7YrK0WultZQSE9CFXJIpTZtk66MSBvq9X/dcUYeIU5oNkdoBCv A==;
IronPort-SDR: Tlxfvr/PB00UMi3E/Ht8Fv994QQcPmpcMaPZmktdAnv/VrdICGo4AvQcED6JT1AGS+gj4MW1Es
 JZdPFGYl6akKTYloygEC7XCCyJDNI5IXLZ6Ojy1z9iwviZr+ug4xJOv64Rn92PZOxQsILj5bSP
 ngM4KYkzAVdACSIV6rLFIGdx18kOKXG32Pmn29qK4CmqGurilWHmS0f0iWgG/c/MeBXf+lQ/hZ
 lgWMnkbr6KeXvrzvzRXz5vPfYj7Fs/obHrx783fTlkCYeFTpIbwlNakQVw4YKsYQOnrkQPXiYM
 5co=
X-IronPort-AV: E=Sophos;i="5.75,306,1589212800"; d="scan'208";a="250767691"
Received: from mail-bn8nam11lp2177.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.177])
 by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2020 08:46:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ms4NGyiB/X7+QiLBvJFiJLoKq40ig/ZASlWv66lrppZCV3LRkpR7bHlN08aKSyxdHr02IyMfH0zauC5EBF90apVjntJ89sT2xoteq2JDmiwEEls1gX5NGRuDf0QjkeOKhs4DoOar1aCqtBia1TIywzanNCi62kWLGXutMSXKbpfcYvDVu28TpT8okdn7+E38ThA/mnJwjaqnb5bV4Y4A9QDjehAxyM/wWIKvFNoKIkmplQkyOmbJYavoAYSEVOn97HLVmBPs2dvB1No0CYYey5SyUBDLFHDJKIUgXfA8/+IGsFcFOnkADbTR/AmKrHXyVdWHeMgMSFlvvC9gB96mKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5OgAryDHUOSDGXRsIqJHLxCjmETcUk1oIVdgXmPkWE=;
 b=mmliKs9PJQ1zdgvJQwuigNXKzHaqBzLqftbm+H3cM02Md124WIs4t49X5nEzPf921gbIyIC1Fyyr1FVxAcybpjk23IVns16pKKlSRWlCefnxo91Fkh+OmwzcFgbDldlFG/aGYHHjQvlpqyxiDFQuqb9BGlwyWD357TJjLaYiLMvowkkAAmeg14exmghZai5Kml2aIkVvBigC/gOg9fI5akuV8GROhaZjBc7sygCWO0MiQaJ4/myePaV3BUmjVYrGLe8bfeF/DrCwsxrSizgzGMvW7AISbHkzptVyr2Bi1HC0GiwJRSRfgmlMRL1RRd0u4K/EKZgMdGqou8riAEMIkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5OgAryDHUOSDGXRsIqJHLxCjmETcUk1oIVdgXmPkWE=;
 b=KvAVlWAZINO3Bza2wQgSlFhnDLtcgSeJ4s3+P1kG6sGfl+07PGwky+/YFxoHlwoYnwOr5dnbAxZ180MHC34wnAQzZNAaHwojUCv8+JdGYhgWWHl8+KI475oUME9fwY4dHrFMy2wqOEn2/V6w0LmXdnzA3FFmW1zjcp6QB0HJFE8=
Received: from MN2PR04MB5951.namprd04.prod.outlook.com (2603:10b6:208:3f::13)
 by MN2PR04MB5552.namprd04.prod.outlook.com (2603:10b6:208:de::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Fri, 3 Jul
 2020 00:46:50 +0000
Received: from MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::60c5:4424:8ce4:59a9]) by MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::60c5:4424:8ce4:59a9%5]) with mapi id 15.20.3153.023; Fri, 3 Jul 2020
 00:46:50 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: "its@irrelevant.dk" <its@irrelevant.dk>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 14/17] hw/block/nvme: support identify namespace
 descriptor list
Thread-Topic: [PATCH 14/17] hw/block/nvme: support identify namespace
 descriptor list
Thread-Index: AQHWTkP8KIvxKKleOkuX6guhzpXruaj1ClaA
Date: Fri, 3 Jul 2020 00:46:50 +0000
Message-ID: <8853e75db9b51badaee777e6e2542fc417c4eb6b.camel@wdc.com>
References: <20200629182642.1170387-1-its@irrelevant.dk>
 <20200629182642.1170387-15-its@irrelevant.dk>
In-Reply-To: <20200629182642.1170387-15-its@irrelevant.dk>
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
x-ms-office365-filtering-correlation-id: 7f0e59c2-71e7-44f3-73e9-08d81eea928c
x-ms-traffictypediagnostic: MN2PR04MB5552:
x-microsoft-antispam-prvs: <MN2PR04MB555262688EF2333CEAA96481E16A0@MN2PR04MB5552.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 045315E1EE
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r+gYiVAPPCjjEGrQv0P//v6ykCbtbKMB8zEzLSOz4gA4XxBnn5vLHKHoq71hhEoJXbeIJWih5/uVgzonxrpjb6CGL1EVxlIlxNaniRGBLTr6xz7QdmZvbSyZ45u2dcQV7rI+OJCl9hFXU+QqiS71qjQimfJCkUjE9QQiJuWLrLr5tpQ5IHwurIDHRRapoVAV4EWVShShL6bMOmkTC8rRa/zWU6JvNngXjmRGIM3+7diOin5kn+m6HnP6ZjYMNlYz5TL12zDt3bd8k6RC3dhbnPa9SqaGEMwbzmCpz4bIB3BDhuD9QN8FqkR1ky848st4Rs1qPqiTCACVxOauRNbd9Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB5951.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(4326008)(186003)(76116006)(2616005)(83380400001)(6486002)(6512007)(110136005)(66946007)(66476007)(66446008)(54906003)(64756008)(66556008)(36756003)(71200400001)(8936002)(26005)(86362001)(316002)(5660300002)(2906002)(8676002)(478600001)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: /MeceMDuGb1AtuMPtYeqQsHdekP+RD3Gmuc3AGBKAz2pNSc5jUKFcztE8c91bY8VzsUW/PFII+1nLmFNvxQ1XLMUgwshMV/UbXoth2KuP4Rr09ud7B8A5FwPBEvXopfBnLxuJuaq3RiMMhNoi8Jj0CGWAxwlsDFVmV5VuYbEuN9SKH4ALUMa3izt1qK1aBDMdBiSgv+c7Q/jdXzevedUnSrM4vLsYMMe/7pUflOE0soZ/Kcpag698HzJ9PM9U1MlZArp7oP0px13HGiqk+t6lSzsX4UE717yyI0EQflD5i/u3r/kzi0Aki5O/TwTnhOLlO7+75HcrFolJWGBdKW4Nsp4sAuc0uD0zVMYAqHePuJKeP1JICsGSWrNYgIljvn8+Kea1G4/C06ln0VRBj9Cwai8KmL4T6SdeWZbPVSt9de+lXwn9tgVejytMFiXTuX4CQ+/X6bQpbHtpEg9w1ec3DAs8UeQ8Li79RfHO6qHrHQqtDRH92vCmFSSnZbKo9uE
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D776D9360223B42A9819647F436D780@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5951.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f0e59c2-71e7-44f3-73e9-08d81eea928c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2020 00:46:50.1144 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5/zJ8XS8mrGTRHqrikNDkZ8x/dKP8sad2uZ776xyv8kkikw1ZfIL6PwEacJZVZ5N+A4OqiEO9jRvbMKRvXAfrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5552
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=446c5dbe3=Dmitry.Fomichev@wdc.com; helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 20:46:09
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
 "k.jensen@samsung.com" <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IERtaXRyeSBGb21pY2hldiA8ZG1pdHJ5LmZvbWlj
aGV2QHdkYy5jb20+DQoNCk9uIE1vbiwgMjAyMC0wNi0yOSBhdCAyMDoyNiArMDIwMCwgS2xhdXMg
SmVuc2VuIHdyb3RlOg0KPiBGcm9tOiBLbGF1cyBKZW5zZW4gPGsuamVuc2VuQHNhbXN1bmcuY29t
Pg0KPiANCj4gU2luY2Ugd2UgYXJlIG5vdCBwcm92aWRpbmcgdGhlIE5HVUlEIG9yIEVVSTY0IGZp
ZWxkcywgd2UgbXVzdCBzdXBwb3J0DQo+IHRoZSBOYW1lc3BhY2UgVVVJRC4gV2UgZG8gbm90IGhh
dmUgYW55IHdheSBvZiBzdG9yaW5nIGEgcGVyc2lzdGVudA0KPiB1bmlxdWUgaWRlbnRpZmllciwg
c28gY29uanVyZSB1cCBhIFVVSUQgdGhhdCBpcyBqdXN0IHRoZSBuYW1lc3BhY2UgaWQuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBLbGF1cyBKZW5zZW4gPGsuamVuc2VuQHNhbXN1bmcuY29tPg0KPiAt
LS0NCj4gIGh3L2Jsb2NrL252bWUuYyAgICAgICB8IDQxICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrDQo+ICBody9ibG9jay90cmFjZS1ldmVudHMgfCAgMSArDQo+ICAy
IGZpbGVzIGNoYW5nZWQsIDQyIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9ody9i
bG9jay9udm1lLmMgYi9ody9ibG9jay9udm1lLmMNCj4gaW5kZXggMjI3OWQ4Mzk1YWFhLi44YTgx
NmI1NThlZWIgMTAwNjQ0DQo+IC0tLSBhL2h3L2Jsb2NrL252bWUuYw0KPiArKysgYi9ody9ibG9j
ay9udm1lLmMNCj4gQEAgLTk3Miw2ICs5NzIsNDUgQEAgc3RhdGljIHVpbnQxNl90IG52bWVfaWRl
bnRpZnlfbnNsaXN0KE52bWVDdHJsICpuLCBOdm1lSWRlbnRpZnkgKmMpDQo+ICAgICAgcmV0dXJu
IHJldDsNCj4gIH0NCj4gIA0KPiArc3RhdGljIHVpbnQxNl90IG52bWVfaWRlbnRpZnlfbnNfZGVz
Y3JfbGlzdChOdm1lQ3RybCAqbiwgTnZtZUlkZW50aWZ5ICpjKQ0KPiArew0KPiArICAgIHVpbnQz
Ml90IG5zaWQgPSBsZTMyX3RvX2NwdShjLT5uc2lkKTsNCj4gKyAgICB1aW50NjRfdCBwcnAxID0g
bGU2NF90b19jcHUoYy0+cHJwMSk7DQo+ICsgICAgdWludDY0X3QgcHJwMiA9IGxlNjRfdG9fY3B1
KGMtPnBycDIpOw0KPiArDQo+ICsgICAgdWludDhfdCBsaXN0W05WTUVfSURFTlRJRllfREFUQV9T
SVpFXTsNCj4gKw0KPiArICAgIHN0cnVjdCBkYXRhIHsNCj4gKyAgICAgICAgc3RydWN0IHsNCj4g
KyAgICAgICAgICAgIE52bWVJZE5zRGVzY3IgaGRyOw0KPiArICAgICAgICAgICAgdWludDhfdCB2
WzE2XTsNCj4gKyAgICAgICAgfSB1dWlkOw0KPiArICAgIH07DQo+ICsNCj4gKyAgICBzdHJ1Y3Qg
ZGF0YSAqbnNfZGVzY3JzID0gKHN0cnVjdCBkYXRhICopbGlzdDsNCj4gKw0KPiArICAgIHRyYWNl
X3BjaV9udm1lX2lkZW50aWZ5X25zX2Rlc2NyX2xpc3QobnNpZCk7DQo+ICsNCj4gKyAgICBpZiAo
dW5saWtlbHkobnNpZCA9PSAwIHx8IG5zaWQgPiBuLT5udW1fbmFtZXNwYWNlcykpIHsNCj4gKyAg
ICAgICAgdHJhY2VfcGNpX252bWVfZXJyX2ludmFsaWRfbnMobnNpZCwgbi0+bnVtX25hbWVzcGFj
ZXMpOw0KPiArICAgICAgICByZXR1cm4gTlZNRV9JTlZBTElEX05TSUQgfCBOVk1FX0ROUjsNCj4g
KyAgICB9DQo+ICsNCj4gKyAgICBtZW1zZXQobGlzdCwgMHgwLCBzaXplb2YobGlzdCkpOw0KPiAr
DQo+ICsgICAgLyoNCj4gKyAgICAgKiBCZWNhdXNlIHRoZSBOR1VJRCBhbmQgRVVJNjQgZmllbGRz
IGFyZSAwIGluIHRoZSBJZGVudGlmeSBOYW1lc3BhY2UgZGF0YQ0KPiArICAgICAqIHN0cnVjdHVy
ZSwgYSBOYW1lc3BhY2UgVVVJRCAobmlkdCA9IDB4MykgbXVzdCBiZSByZXBvcnRlZCBpbiB0aGUN
Cj4gKyAgICAgKiBOYW1lc3BhY2UgSWRlbnRpZmljYXRpb24gRGVzY3JpcHRvci4gQWRkIGEgdmVy
eSBiYXNpYyBOYW1lc3BhY2UgVVVJRA0KPiArICAgICAqIGhlcmUuDQo+ICsgICAgICovDQo+ICsg
ICAgbnNfZGVzY3JzLT51dWlkLmhkci5uaWR0ID0gTlZNRV9OSURUX1VVSUQ7DQo+ICsgICAgbnNf
ZGVzY3JzLT51dWlkLmhkci5uaWRsID0gTlZNRV9OSURUX1VVSURfTEVOOw0KPiArICAgIHN0bF9i
ZV9wKCZuc19kZXNjcnMtPnV1aWQudiwgbnNpZCk7DQo+ICsNCj4gKyAgICByZXR1cm4gbnZtZV9k
bWFfcmVhZF9wcnAobiwgbGlzdCwgTlZNRV9JREVOVElGWV9EQVRBX1NJWkUsIHBycDEsIHBycDIp
Ow0KPiArfQ0KPiArDQo+ICBzdGF0aWMgdWludDE2X3QgbnZtZV9pZGVudGlmeShOdm1lQ3RybCAq
biwgTnZtZUNtZCAqY21kKQ0KPiAgew0KPiAgICAgIE52bWVJZGVudGlmeSAqYyA9IChOdm1lSWRl
bnRpZnkgKiljbWQ7DQo+IEBAIC05ODMsNiArMTAyMiw4IEBAIHN0YXRpYyB1aW50MTZfdCBudm1l
X2lkZW50aWZ5KE52bWVDdHJsICpuLCBOdm1lQ21kICpjbWQpDQo+ICAgICAgICAgIHJldHVybiBu
dm1lX2lkZW50aWZ5X2N0cmwobiwgYyk7DQo+ICAgICAgY2FzZSBOVk1FX0lEX0NOU19OU19BQ1RJ
VkVfTElTVDoNCj4gICAgICAgICAgcmV0dXJuIG52bWVfaWRlbnRpZnlfbnNsaXN0KG4sIGMpOw0K
PiArICAgIGNhc2UgTlZNRV9JRF9DTlNfTlNfREVTQ1JfTElTVDoNCj4gKyAgICAgICAgcmV0dXJu
IG52bWVfaWRlbnRpZnlfbnNfZGVzY3JfbGlzdChuLCBjKTsNCj4gICAgICBkZWZhdWx0Og0KPiAg
ICAgICAgICB0cmFjZV9wY2lfbnZtZV9lcnJfaW52YWxpZF9pZGVudGlmeV9jbnMobGUzMl90b19j
cHUoYy0+Y25zKSk7DQo+ICAgICAgICAgIHJldHVybiBOVk1FX0lOVkFMSURfRklFTEQgfCBOVk1F
X0ROUjsNCj4gZGlmZiAtLWdpdCBhL2h3L2Jsb2NrL3RyYWNlLWV2ZW50cyBiL2h3L2Jsb2NrL3Ry
YWNlLWV2ZW50cw0KPiBpbmRleCA0YTRlZjM0MDcxZGYuLjdiNzMwM2NhYjFkZCAxMDA2NDQNCj4g
LS0tIGEvaHcvYmxvY2svdHJhY2UtZXZlbnRzDQo+ICsrKyBiL2h3L2Jsb2NrL3RyYWNlLWV2ZW50
cw0KPiBAQCAtNDUsNiArNDUsNyBAQCBwY2lfbnZtZV9kZWxfY3EodWludDE2X3QgY3FpZCkgImRl
bGV0ZWQgY29tcGxldGlvbiBxdWV1ZSwgY3FpZD0lIlBSSXUxNiIiDQo+ICBwY2lfbnZtZV9pZGVu
dGlmeV9jdHJsKHZvaWQpICJpZGVudGlmeSBjb250cm9sbGVyIg0KPiAgcGNpX252bWVfaWRlbnRp
ZnlfbnModWludDMyX3QgbnMpICJuc2lkICUiUFJJdTMyIiINCj4gIHBjaV9udm1lX2lkZW50aWZ5
X25zbGlzdCh1aW50MzJfdCBucykgIm5zaWQgJSJQUkl1MzIiIg0KPiArcGNpX252bWVfaWRlbnRp
ZnlfbnNfZGVzY3JfbGlzdCh1aW50MzJfdCBucykgIm5zaWQgJSJQUkl1MzIiIg0KPiAgcGNpX252
bWVfZ2V0X2xvZyh1aW50MTZfdCBjaWQsIHVpbnQ4X3QgbGlkLCB1aW50OF90IGxzcCwgdWludDhf
dCByYWUsIHVpbnQzMl90IGxlbiwgdWludDY0X3Qgb2ZmKSAiY2lkICUiUFJJdTE2IiBsaWQgMHgl
IlBSSXg4IiBsc3AgMHglIlBSSXg4IiByYWUgMHglIlBSSXg4IiBsZW4gJSJQUkl1MzIiIG9mZiAl
IlBSSXU2NCIiDQo+ICBwY2lfbnZtZV9nZXRmZWF0KHVpbnQxNl90IGNpZCwgdWludDhfdCBmaWQs
IHVpbnQ4X3Qgc2VsLCB1aW50MzJfdCBjZHcxMSkgImNpZCAlIlBSSXUxNiIgZmlkIDB4JSJQUkl4
OCIgc2VsIDB4JSJQUkl4OCIgY2R3MTEgMHglIlBSSXgzMiIiDQo+ICBwY2lfbnZtZV9zZXRmZWF0
KHVpbnQxNl90IGNpZCwgdWludDhfdCBmaWQsIHVpbnQ4X3Qgc2F2ZSwgdWludDMyX3QgY2R3MTEp
ICJjaWQgJSJQUkl1MTYiIGZpZCAweCUiUFJJeDgiIHNhdmUgMHglIlBSSXg4IiBjZHcxMSAweCUi
UFJJeDMyIiINCg==

