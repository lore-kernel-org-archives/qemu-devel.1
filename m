Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14F9C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 14:06:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DDB3214AF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 14:06:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DDB3214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45751 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw51s-0008Kj-OD
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 09:06:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49419)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <adrian.glaubitz@suse.com>) id 1ivzpz-0005OL-Ps
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 03:33:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <adrian.glaubitz@suse.com>) id 1ivzpx-0006TQ-Lk
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 03:33:38 -0500
Received: from m9a0013g.houston.softwaregrp.com ([15.124.64.91]:53380)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <adrian.glaubitz@suse.com>) id 1ivzpx-00064r-Fn
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 03:33:37 -0500
Received: FROM m9a0013g.houston.softwaregrp.com (15.121.0.191) BY
 m9a0013g.houston.softwaregrp.com WITH ESMTP; 
 Mon, 27 Jan 2020 08:32:41 +0000
Received: from M9W0067.microfocus.com (2002:f79:be::f79:be) by
 M9W0068.microfocus.com (2002:f79:bf::f79:bf) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 27 Jan 2020 08:30:48 +0000
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (15.124.72.10) by
 M9W0067.microfocus.com (15.121.0.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Mon, 27 Jan 2020 08:30:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hRIB7HK+b+JlXsPiGcK9rSCY644CyFENwPEmi3YeZyDaZ0Sb5cTDMSrLWhO42ZkF0cMRVY1pNU/m+ymj58wzAXAK0+YhKfJ+DYL3RDBZTvbx8kz3Sm6+BQqh/SLSJz6jhqFD/2MR9HywJnJ8ouHzKFIExo0oUKamKd5CoOxDpBnznDDW5LGDuY88yXCsu0EqiTQqW1mRhj38QLvY2HqsTVNDmF02F29XOsgRBvLTRrhffLOvN+KRadOf+tFKptZhcbgV4YVGSQtKSQ2pPfGaJt352Xhlr8lTpnYOKTfP96O9b+ruduYNhR1EZHCN9LXSbZXqA75WxciseTMftA2r7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMrWZHe8ff21m7bxfWRm5tK9uV+/7aZ0XXPCBlw9924=;
 b=bK87rGii0EoPXU+ZK85u67uo3rBE07r0FpRgcsrZXL6vdRc9irv+hKyuPlSnu8EolReQTm5uEzYgvEieRBpfpYiRtNyvArazpBuJ8L2ZiH/A/69o/CF3o8FWmd2OLlDGjWwDYMAG5wE2opNmCmSVmSKMDZFwiW3ZvK96rIeNlD0jgPkDVpGRj5et5NZ9z0cZx4A/UoC5wH43iOInVpkEdNPOX4x8KNfa1IAFwE+3kT5Omr0y5idPNfe2lSo31j+OBcvpMpB9XWTLzRkR1TAdK3gmJmay9+0sanEDmIgu4AKwA3DnCo3RPphUM2PwrcS/Yv7wi2EKj49DxOWuZwMExg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from DM6PR18MB3436.namprd18.prod.outlook.com (10.255.173.25) by
 DM6PR18MB3402.namprd18.prod.outlook.com (10.255.172.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.23; Mon, 27 Jan 2020 08:30:48 +0000
Received: from DM6PR18MB3436.namprd18.prod.outlook.com
 ([fe80::a989:db8:3a72:6ace]) by DM6PR18MB3436.namprd18.prod.outlook.com
 ([fe80::a989:db8:3a72:6ace%7]) with mapi id 15.20.2665.017; Mon, 27 Jan 2020
 08:30:48 +0000
Received: from [IPv6:2003:d1:df16:ef00:7292:cc72:6b0:c7e0]
 (2003:d1:df16:ef00:7292:cc72:6b0:c7e0) by
 LNXP265CA0073.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:76::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.20 via Frontend Transport; Mon, 27 Jan 2020 08:30:47 +0000
From: John Paul Adrian Glaubitz <adrian.glaubitz@suse.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>
Subject: Re: Booting Debian in qemu-system-alpha
Thread-Topic: Booting Debian in qemu-system-alpha
Thread-Index: AQHV1OwTgHfbLF6YKEeVFRfuNKZNaw==
Date: Mon, 27 Jan 2020 08:30:48 +0000
Message-ID: <f7e044ca-17a4-7ef3-e8a7-ad830e7b062b@suse.com>
References: <b71832b2-8b2e-a49b-1bf9-6590056bbdbe@physik.fu-berlin.de>
 <f3843562-cd89-d1b1-19ed-6ae505a94148@linaro.org>
 <22dd1024-6dd1-81b1-1a91-8d2cbf31853c@physik.fu-berlin.de>
 <775a62cd-8041-de5e-97c9-b1def80b3f58@redhat.com>
In-Reply-To: <775a62cd-8041-de5e-97c9-b1def80b3f58@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LNXP265CA0073.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::13) To DM6PR18MB3436.namprd18.prod.outlook.com
 (2603:10b6:5:1c5::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=adrian.glaubitz@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2003:d1:df16:ef00:7292:cc72:6b0:c7e0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f89e519f-afe2-4af1-5b45-08d7a30335ce
x-ms-traffictypediagnostic: DM6PR18MB3402:
x-microsoft-antispam-prvs: <DM6PR18MB3402F19BF09BB37810134C75800B0@DM6PR18MB3402.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 02951C14DC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(396003)(39860400002)(346002)(366004)(136003)(199004)(189003)(4326008)(5660300002)(66446008)(64756008)(66556008)(66476007)(66946007)(2616005)(86362001)(8676002)(81156014)(81166006)(31686004)(8936002)(6486002)(36756003)(31696002)(16526019)(478600001)(71200400001)(2906002)(186003)(53546011)(110136005)(52116002)(54906003)(316002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM6PR18MB3402;
 H:DM6PR18MB3436.namprd18.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qdqW1rZMx1IWBjtkNAYRwvpynJgd3BlmpLSsihZp1EDDMojJM9EBKsze0QqXQX13022GSF1nXXuRaeAuT1dxUdyxYroVi8qHIuO1oea8ynagtkTvvq7NrLyMFrWjf6IhnB8Ffv97L6TGST9+Xyt+kWr+OKDxGvMaLzB+FeIVAvirviiJZnts3+IEQEO6VIv/QidlE6sQD+/5KhzmoxpqUoEPXKteiVWO7FtmljKtUeUPvTWXzBSB/fOQjd/D1iID4WtwQ18zA3XixolkCfXzIX5D662RIO6uZpN/3f9W7yMbhs7M4etNbBGTV2hm/ltbRXr15LsdTtLRsySG+N2/L7+qmCJNOOO77z+H54mVImSXjs9j1W9LguS9fmyZP4GrAGCrMvmbOP90h8v5cgwVV+lJb908KGNIKXZmrQX/1FcQwhm8W1ErCPCSZISSVW3q
x-ms-exchange-antispam-messagedata: NbVBMxpVOL+95TW97OVt7bfs6U5KYeaEKNVEV8gmij5yJvVvrtbVDaK8ZsbcmnYVFriwWhRCFiRf3HasJa9BKodokyDDmdHzbzigq1qhFxjyw0ygC0ADXGCP+FNGA8gAKD51Kij4KxtYRozNN8xn2c+rlVc2xvwDeTSceh2HaxooIc+cwvNfEqHm6oNkFEpecHdjktvWOhTZ5aJ6Qra1/A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD4FC1C82CB7574FAC615205D44A2B25@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f89e519f-afe2-4af1-5b45-08d7a30335ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2020 08:30:48.1958 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I3CT3rEqm5wK9EQ2N7FA7/BtyN62N12AE0j785PzJrgrFHCqK1AAEO9WbJln5CYGK2Y5QYecuGGbVQpady5ysPg6E43fhVzFtrowAb2fiIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB3402
X-OriginatorOrg: suse.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 15.124.64.91
X-Mailman-Approved-At: Mon, 27 Jan 2020 09:04:34 -0500
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
Cc: "debian-alpha@lists.debian.org" <debian-alpha@lists.debian.org>, QEMU
 Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gMS8yNy8yMCA4OjQ3IEFNLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4+IEkn
bSBjb25zaWRlcmluZyBzZXR0aW5nIHVwIHR3byBxZW11LWJhc2VkIGJ1aWxkZHMgZm9yIGFscGhh
IGluIHRoZSBjbG91ZCBub3cuDQo+IA0KPiBOaWNlIQ0KPiANCj4gTG9va2luZyBhdCBjbG91ZCBw
cm92aWRlciBkZWZhdWx0IHBsYW5zLCBhbmQgcHJvYmxlbXMgd2l0aCBidWlsZGQgb24gb3RoZXIg
YXJjaHMNCj4gKG1pcHNlbCBpbiBwYXJ0aWN1bGFyKSBJIHJlY29tbWVuZCB5b3UgdG8gdXNlIGF0
IGxlYXN0IDJHQiBpbnN0ZWFkIG9mIDUxMk1CLg0KDQpTdXJlLiBJIGhhdmUgdHdvIGZyZWUgY2xv
dWQgVk1zIHdoaWNoIEkgd2lsbCB1c2UgZm9yIHRoZSBhbHBoYSBidWlsZGRzLiBXZSdyZQ0KYWxy
ZWFkeSB1c2luZyBxZW11IGZvciBidWlsZHMgaW4gRGViaWFuLg0KDQpGb3IgbTY4ayBhbmQgc2g0
LCB3ZSdyZSB1c2luZyBxZW11LXVzZXIgd2hpY2ggaGVscGVkIGRpc2NvdmVyaW5nIGEgbG90IG9m
IGJ1Z3MsDQplc3BlY2lhbGx5IHdpdGggcWVtdS11c2VyLiBDdXJyZW50bHksIHdlIGNhbid0IHVz
ZSBxZW11LXN5c3RlbSBvbiBtNjhrIGFuZCBzaDQNCnNpbmNlIHRoZSBzeXN0ZW0gbWVtb3J5IGlz
IGxpbWl0ZWQgdGhlcmUgdG8gMSBHaUIgYW5kIDY0IE1pQiwgYWx0aG91Z2ggdGhlIGxhdHRlcg0K
aXMgYSBsaW1pdGF0aW9uIGJ5IHFlbXUgYXMgZmFyIGFzIEkga25vdy4NCg0KRm9yIHJpc2N2NjQs
IG1vc3QgYnVpbGRkcyBpbiBEZWJpYW4gYW5kIGJ1aWxkIHdvcmtlcnMgaW4gb3BlblNVU0UgYXJl
IGJhc2VkIG9uDQpxZW11LXN5c3RlbSBhcyBjaGVhcCByaXNjdjY0IGhhcmR3YXJlIGlzIHN0aWxs
IHZlcnkgaGFyZCB0byBjb21lIGJ5Lg0KDQpBZHJpYW4NCg0KLS0gDQogLicnYC4gIEpvaG4gUGF1
bCBBZHJpYW4gR2xhdWJpdHoNCjogOicgOiAgRGViaWFuIERldmVsb3BlciAtIGdsYXViaXR6QGRl
Ymlhbi5vcmcNCmAuIGAnICAgRnJlaWUgVW5pdmVyc2l0YWV0IEJlcmxpbiAtIGdsYXViaXR6QHBo
eXNpay5mdS1iZXJsaW4uZGUNCiAgYC0gICAgR1BHOiA2MkZGIDhBNzUgODRFMCAyOTU2IDk1NDYg
IDAwMDYgNzQyNiAzQjM3IEY1QjUgRjkxMw0K

