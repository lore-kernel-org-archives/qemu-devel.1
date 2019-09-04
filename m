Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A36C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 22:12:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FDC220820
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 22:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eaubJY14";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="wDARwnEh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FDC220820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5dWL-0003fY-Hy
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 18:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58438)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=143ed7f17=Dmitry.Fomichev@wdc.com>)
 id 1i5cZK-0001t8-N7
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 17:11:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=143ed7f17=Dmitry.Fomichev@wdc.com>)
 id 1i5cZJ-0008Lf-JI
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 17:11:58 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:53352)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=143ed7f17=Dmitry.Fomichev@wdc.com>)
 id 1i5cZG-0008FA-Ct; Wed, 04 Sep 2019 17:11:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1567631515; x=1599167515;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=grd16iG8V30dFpFKtbl3V7w+PL/FwOH497hYSiSVhLw=;
 b=eaubJY14j9KmrYgRhZDopexqlcbuxBmvLTchpXj281tA4gNEjKhGpPlW
 DgJTyA6TG7gjOfNFqlYK1f/jp8L0JoLyfNkSwjHIC0AzHxOcWOhai8Cpp
 97f9iyks7v6j780l6EkHXuKpDVUMfChjNPUMMGnYe03GZcD8ditUeqnlf
 437BIXFz68UElMRdL8YT2zAwyvxXNzbaKjU7SPqiKzcxojY2CZe1lT8yG
 X0EU9G01jZRbpOmy0KXkSuHBYYR/mWkjjqBPLl+L6vekPN2Lt0b51eC+z
 p9wEjTSXrQqwE6HTm4C6ySXMojSb8hPalWgXvxm9rM2RoWK7thG5VLdVF Q==;
IronPort-SDR: 5ueE3f0S8UD4UeVrmoceKQjfvRdZ/ct1rWBj1y8FHO91K79LrKe47wrhKd2tdxxLKt7/uvJsCF
 E/Vs8rrVe4GZJm3nICas1nvh3kLMfJz7+hiLlLsOFFGEcl3I3+yN/4HqiRdYO2cqWx9bn4rIEg
 +cta9ggV0AK2YopsgNLrT4WppdYqSVjSeagrC96bkdNKmbFlz7nahacHcTkRHI251hjsGT5gkI
 Sta/EAetmIq/qoMxv+xXdiWBgn50GOIZpPIF12oKWad4v4Uv6YrKcqZmKvu7UcAEBW1h9zJ9N3
 m4o=
X-IronPort-AV: E=Sophos;i="5.64,468,1559491200"; d="scan'208";a="117452693"
Received: from mail-sn1nam04lp2059.outbound.protection.outlook.com (HELO
 NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.59])
 by ob1.hgst.iphmx.com with ESMTP; 05 Sep 2019 05:11:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abd6i27ilsd8xBhZMtrb3fc/WGvevchgtQyAR1rB/rtJKWsClY/9X27xRfjresBy7A2HW7HFu8vScMVH1L7uJU+pG5rpkCub4N2AjRQlAq8DrrCple8iCUU9gwOrLG+LBCInwlcs2zJcjeXLIDfWwsGBP6bKI5VLx3D2VpyfY6MJ1lHs61mH71yNTpXb+5KtlmVkokywnMDdSkg7HM2lbMQBAUWgh7QWxVc9ik7gZhKCdmQZBBIt7CLDRDzPwpvaaYm6cg/WHh4k+RarqcANxPhxyliKf7qyUiOAHPg6YJl4Geco5JlJ9s38WjtokKyf1fzhFHAE1EMjrHRSygC5FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grd16iG8V30dFpFKtbl3V7w+PL/FwOH497hYSiSVhLw=;
 b=QRUUDsPonjrKUHt5YeHt/+bgzxnRS6+2aTV+QUMJjJXxWtQedWT/wAjlaeMSFk+CnoNudgZ1P4xkCH1/QyD0arsLvU11pHeRMzSiKTn5MQMPUKOTtedGQ50N67IwJTH9S0iA/+TzbG3P1USvHR41ZacwBdfbM3Mwk5u2ibaxYOcUsCDbhiAkTCC/Bm09AHFv1/tw+df70SHFcPlyyrMxx1Ye17pTAWVV9URv9EjfQjDQ4jw7TN1Tllr0hxV7aC8g6ZHlXu2EeT8u6gOyEFv+hgloLIIq49a2qSYmESKGGPEHAdNM0TaIgxJUKV/kA4vSqm5Z436fygUSp+kY3c8fIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grd16iG8V30dFpFKtbl3V7w+PL/FwOH497hYSiSVhLw=;
 b=wDARwnEhW3zsVfGjlO3XsoudXFl6apuExob932YBzuDcuDhfvFqhOpjO4mOecynOzz/OSMds4kPtmyZZwml7h/8KB27GWBJJTv4OBiloAh7aK0ebaLUXG07MHy3+8Dpd1UDmywQqicg90nPh589SnDrmVwbChBylVDGPDSoS4M4=
Received: from CO2PR04MB2328.namprd04.prod.outlook.com (10.166.95.11) by
 CO2PR04MB2165.namprd04.prod.outlook.com (10.166.214.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.18; Wed, 4 Sep 2019 21:11:45 +0000
Received: from CO2PR04MB2328.namprd04.prod.outlook.com
 ([fe80::b44d:f58f:f4bd:fdea]) by CO2PR04MB2328.namprd04.prod.outlook.com
 ([fe80::b44d:f58f:f4bd:fdea%12]) with mapi id 15.20.2199.027; Wed, 4 Sep 2019
 21:11:45 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: "stefanha@gmail.com" <stefanha@gmail.com>
Thread-Topic: [Qemu-block] [PATCH v5 0/4] virtio/block: handle zoned backing
 devices
Thread-Index: AQHVWevkc1m1eVB3CUakRZKW6UwiPacQVbWAgAvBKAA=
Date: Wed, 4 Sep 2019 21:11:45 +0000
Message-ID: <5f53bb6ca5f6281cf92f446a97b8823bdcded8da.camel@wdc.com>
References: <20190823194927.23278-1-dmitry.fomichev@wdc.com>
 <20190828094133.GG5573@stefanha-x1.localdomain>
In-Reply-To: <20190828094133.GG5573@stefanha-x1.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Dmitry.Fomichev@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bfc88857-5f3e-42c2-28c1-08d7317c7e03
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:CO2PR04MB2165; 
x-ms-traffictypediagnostic: CO2PR04MB2165:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO2PR04MB2165EF6859CC3E21727A3806E1B80@CO2PR04MB2165.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0150F3F97D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(54094003)(189003)(199004)(1361003)(54906003)(14454004)(76176011)(25786009)(478600001)(4326008)(316002)(4744005)(11346002)(305945005)(6246003)(8936002)(66066001)(446003)(91956017)(76116006)(71190400001)(71200400001)(99286004)(66476007)(66556008)(64756008)(66446008)(6116002)(66946007)(3846002)(5660300002)(1411001)(6506007)(486006)(36756003)(5640700003)(2906002)(229853002)(102836004)(6512007)(81156014)(6916009)(1730700003)(8676002)(81166006)(53936002)(26005)(118296001)(186003)(6486002)(2501003)(6436002)(2616005)(476003)(7736002)(256004)(2351001)(86362001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CO2PR04MB2165;
 H:CO2PR04MB2328.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XQq6G20PEHH1VPzrYfDEhxsd6fO84zcp0MgioWBmkXTlE3HeznGfiKFXJP5McaZULRTPJVfbrpiTra7JquWWbosWZUXajh4Krjx0pFc5YogUJf//UdPaFcc1Vgz1I9JJW5oJRM2+Q/4LQ8WF6oH6wKmIwm9neRB0S7zuqIBxE33P40vrvQZht/hODVq/VfPYuuDwOzZCePNguIlfXwWUWBMMpwGF63mes9d3mPKAtQtSwEtDvy7NOAoQ4R+K/z8d7bP+lbw5EYLPREI9uyNOP3UDfNXdDyYDTU0nTX1PNAfIm1DAj2VElI6OBAhLJ4zw/99F8O6PVhtUerL7CvDxMtelPa2uy84Smz5MEIRC3BTidSKaXy3FqNLq1zC9rvOIup8h/s8eGJx7vRsi4DXUU+ekJkW4kSQFBFjo9IKkH18=
Content-Type: text/plain; charset="utf-8"
Content-ID: <92DB6E1D8F16AD4D9863070B1DF51561@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfc88857-5f3e-42c2-28c1-08d7317c7e03
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2019 21:11:45.4327 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dZ6wX5KZdv/rKpfxxXEipnVy256FbCXyxOgSWQ5LU4JSAlP491677mr/HY5Y3Ng9iTRb+f+QVBTBMajqUZbHdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR04MB2165
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.154.42
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v5 0/4] virtio/block: handle
 zoned backing devices
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
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gV2VkLCAyMDE5LTA4LTI4IGF0IDEwOjQxICswMTAwLCBTdGVmYW4gSGFqbm9jemkgd3JvdGU6
DQo+IE9uIEZyaSwgQXVnIDIzLCAyMDE5IGF0IDAzOjQ5OjIzUE0gLTA0MDAsIERtaXRyeSBGb21p
Y2hldiB3cm90ZToNCj4gPiBEbWl0cnkgRm9taWNoZXYgKDQpOg0KPiA+ICAgYmxvY2s6IEFkZCB6
b25lZCBkZXZpY2UgbW9kZWwgcHJvcGVydHkNCj4gPiAgIHJhdzogUmVjb2duaXplIHpvbmVkIGJh
Y2tpbmcgZGV2aWNlcw0KPiA+ICAgYmxvY2svaWRlL3Njc2k6IFNldCBCTEtfUEVSTV9TVVBQT1JU
X1pPTkVEDQo+ID4gICByYXc6IERvbid0IG9wZW4gWkJEcyBpZiBiYWNrZW5kIGNhbid0IGhhbmRs
ZSB0aGVtDQo+IA0KPiBUaGUgb3ZlcmFsbCBhcHByb2FjaCBsb29rcyBnb29kLg0KPiANCj4gSSB3
b25kZXIgaWYgYmRydl9nZXRfem9uZWRfaW5mbygpIGlzIHJlYWxseSBuZWVkZWQgc2luY2Ugem9u
ZV9tb2RlbCBpcw0KPiBwYXJ0IG9mIEJsb2NrTGltaXRzIGFuZCBpcyBhbHJlYWR5IGZldGNoZWQg
dmlhIGJkcnZfcmVmcmVzaF9saW1pdHMoKS4NCj4gV2FzIGl0IGludHJvZHVjZWQgYmVjYXVzZSB0
aGUgYmxvY2sgbGltaXRzIGhhdmVuJ3QgYmVlbiBvciBjYW5ub3QgYmUNCj4gZmV0Y2hlZCB3aGVu
IHpvbmVfbW9kZWwgaXMgcXVlcmllZCB0aGUgZmlyc3QgdGltZT8gIEl0IHdvdWxkIGJlIG5pY2Ug
dG8NCj4gZ2V0IHJpZCBvZiBiZHJ2X2dldF96b25lZF9pbmZvKCkgaWYgcG9zc2libGUuDQoNClN0
ZWZhbiwNCg0KVGhhbmsgeW91IGZvciB5b3VyIHJldmlldy4gSSd2ZSBqdXN0IHNlbnQgb3V0IHRo
ZSBuZXcgdmVyc2lvbiBvZiB0aGUNCnBhdGNoc2V0LCB2NiwgdGhhdCBhZGRyZXNzZXMgeW91IGNv
bW1lbnRzLiBJIHdhcyBhYmxlIHRvIGdldCByaWQgb2YNCmJkcnZfZ2V0X3pvbmVkX2luZm8oKSB0
ZW1wbGF0ZSBmdW5jdGlvbiBhcyBhIHBhcnQgb2YgdGhlIGxhdGVzdCBjaGFuZ2VzLg0KDQpCZXN0
IHJlZ2FyZHMsDQpEbWl0cnkNCg==

