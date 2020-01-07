Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE74CC282DD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 19:01:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C44EF2081E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 19:01:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C44EF2081E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iou6W-0001Pr-Oi
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 14:01:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43568)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <LYan@suse.com>) id 1iou5d-0000gM-NB
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 14:00:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <LYan@suse.com>) id 1iou5b-0008Vi-Cz
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 14:00:28 -0500
Received: from m9a0014g.houston.softwaregrp.com ([15.124.64.90]:48774)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <LYan@suse.com>) id 1iou5b-0008Oi-6V
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 14:00:27 -0500
Received: FROM m9a0014g.houston.softwaregrp.com (15.121.0.190) BY
 m9a0014g.houston.softwaregrp.com WITH ESMTP; 
 Tue,  7 Jan 2020 18:59:19 +0000
Received: from M4W0334.microfocus.com (2002:f78:1192::f78:1192) by
 M9W0067.microfocus.com (2002:f79:be::f79:be) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Tue, 7 Jan 2020 18:47:58 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (15.124.8.10) by
 M4W0334.microfocus.com (15.120.17.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Tue, 7 Jan 2020 18:47:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DHqwianGGow7lFED6i8P4EUcraEV0PNWHiT0lEZG/8yG0vrhAafBkmkK21IeHBIDOlIXwP6V7gbj7s3GURl9wYaj8qhme8QYFuYhEwEaVb8ZxLc607JRKuhNMPv/rPTND0YEh346sJ/zQXzftFwpwTz9CAkf0zEiNRmyuiaYtt5UM4joz3QAKmQCSzQ94EbDqrBSZvu+93jK71M3nMuAUfrxriKPKA2vD3J1HMXQqgaO5NincT1YM7hYF6qcCGIz2QpHdXl308SbvZ+52uIBXn8HBYms+22muxhlk8nfBGWUs6k5luts6CSBVAiiQQNMfm6ruMyDjYN5D+RFzq9h4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H882Qgbj3b0oEZoOlySODB5cbhJdKaM0JVxYukcR5vU=;
 b=AWJ2UlgIZTmxSEGN9Wm7zJ+O0UODNpZ/Of4+lNOEePRdfG1EOA/fjGK9qufgIjIqZDvbzF9X13xR4gCRNFEKbtztfvMgIhDwjca1pINyFtzRkPtIWrKUjLNUhjRiSNoDvSVGIx8kPlnna6px9UCZC0ApxN+1+MaMTK22iX6ZWebKn4nOHW3UWmFFYy3+WVim1ai88iuJnlTPGt3Vhf7ABWv2eJpiyl9wPaGBknthZbcM/HmeCgIFYyr8MNfgbuwlTaMMOz00wwqq0FdgsA1CzA83shvhi5/aSqwW2JndsHX2aKPS6XJjj5whla3Yk6pguYau4I277bRc7rDEIVOl4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from BYAPR18MB2888.namprd18.prod.outlook.com (20.179.58.203) by
 BYAPR18MB2502.namprd18.prod.outlook.com (20.179.94.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Tue, 7 Jan 2020 18:47:57 +0000
Received: from BYAPR18MB2888.namprd18.prod.outlook.com
 ([fe80::70c4:1802:725e:e829]) by BYAPR18MB2888.namprd18.prod.outlook.com
 ([fe80::70c4:1802:725e:e829%7]) with mapi id 15.20.2602.016; Tue, 7 Jan 2020
 18:47:57 +0000
Received: from [192.168.1.162] (74.130.68.133) by
 CH2PR18CA0035.namprd18.prod.outlook.com (2603:10b6:610:55::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.10 via Frontend Transport; Tue, 7 Jan 2020 18:47:56 +0000
From: Liang Yan <LYan@suse.com>
To: "Moger, Babu" <Babu.Moger@amd.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net"
 <rth@twiddle.net>, "ehabkost@redhat.com" <ehabkost@redhat.com>
Subject: Re: [PATCH v2 0/2] Add support for 2nd generation AMD EPYC processors
Thread-Topic: [PATCH v2 0/2] Add support for 2nd generation AMD EPYC processors
Thread-Index: AQHVxYr6aLAEiZ+ixUGwyn+6AvLnZA==
Date: Tue, 7 Jan 2020 18:47:57 +0000
Message-ID: <0a6fe793-d5b1-bb9e-b9b3-fb8fefb26cb6@suse.com>
References: <157314957337.23828.3860599077487615762.stgit@naples-babu.amd.com>
In-Reply-To: <157314957337.23828.3860599077487615762.stgit@naples-babu.amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CH2PR18CA0035.namprd18.prod.outlook.com
 (2603:10b6:610:55::15) To BYAPR18MB2888.namprd18.prod.outlook.com
 (2603:10b6:a03:10d::11)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=LYan@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [74.130.68.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d8b1ec9-83ec-4c77-de32-08d793a21ccd
x-ms-traffictypediagnostic: BYAPR18MB2502:
x-microsoft-antispam-prvs: <BYAPR18MB25027580A1775BF958833FAEBF3F0@BYAPR18MB2502.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 027578BB13
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(136003)(396003)(376002)(366004)(39860400002)(199004)(189003)(26005)(2616005)(66946007)(66446008)(64756008)(66556008)(66476007)(53546011)(186003)(4326008)(956004)(71200400001)(478600001)(52116002)(16526019)(31696002)(86362001)(5660300002)(966005)(31686004)(316002)(81156014)(81166006)(8676002)(16576012)(36756003)(110136005)(8936002)(6486002)(4744005)(2906002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR18MB2502;
 H:BYAPR18MB2888.namprd18.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FhDQWlqon7TbnXllI9vEt8l6yqeH//WQZWb453/aTuao2JaVWohI1lq7dG/6bClwKuaB1637+sX1Uipp4roforLsbUWARrlqrB9N5ze7OPppuJn3p2Ouhf6szT8tX1F5ZVz269eXwiTHXi7WtexM+SS85QVvcpXW4Z0Y9o1C5DCgMUle+5825m+ImkR3IngMAXZulRjxp4g1kT47LytMaP1MDK/qR2ZtzAGl1nq+W+FG1j7Jef2bssqX7hXjdcNWIN0fHywOcE+zCrRoiBexPIFhop6RKnvML/UApAsmo7LgiWpqFa6SCu41aGvPswa3xuSyk7+v4wirfRFuIZrbnkYmSJlTSwiOx7/81rQXWwhgwao2LrmsC4FhMdV/hlUPsoTijuotby5Szw6KSB8Y0T7q/4k+ReZBaNhX9XrUBe/jvHYj4jsFNkTD/O6qjINV4VEthl02xgARV9b8ETEQEPrXeaoQxXzJXdqYPXFNttyBiBJ51gegdIqlFcOW91YcVbnYHzQq8MgDf0Y9U9arAA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F202C4AC03CEA4FAB2C7C581D74540A@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d8b1ec9-83ec-4c77-de32-08d793a21ccd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2020 18:47:57.5292 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hjnlqwaw9h3HQ5M/E7ha0A1zIusq/xL296GJmpbiprLi+CK1PqJG/qhLTQR3q6Nc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2502
X-OriginatorOrg: suse.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 15.124.64.90
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

S2luZGx5IFBpbmcuDQpKdXN0IHdvbmRlcmluZyBpZiB0aGVyZSBhcmUgYW55IHBsYW5zIGZvciBp
dC4NCg0KQmVzdCwNCkxpYW5nDQoNCg0KT24gMTEvNy8xOSAxOjAwIFBNLCBNb2dlciwgQmFidSB3
cm90ZToNCj4gVGhlIGZvbGxvd2luZyBzZXJpZXMgYWRkcyB0aGUgc3VwcG9ydCBmb3IgMm5kIGdl
bmVyYXRpb24gQU1EIEVQWUMgUHJvY2Vzc29ycw0KPiBvbiBxZW11IGd1ZXN0cy4gVGhlIG1vZGVs
IGRpc3BsYXkgbmFtZSBmb3IgMm5kIGdlbmVyYXRpb24gd2lsbCBiZSBFUFlDLVJvbWUuDQo+IA0K
PiBBbHNvIGZpeGVzIGZldyBtaXNzZWQgY3B1IGZlYXR1cmUgYml0cyBpbiAxc3QgZ2VuZXJhdGlv
biBFUFlDIG1vZGVscy4NCj4gDQo+IFRoZSBSZWZlcmVuY2UgZG9jdW1lbnRzIGFyZSBhdmFpbGFi
bGUgYXQNCj4gaHR0cHM6Ly9kZXZlbG9wZXIuYW1kLmNvbS93cC1jb250ZW50L3Jlc291cmNlcy81
NTgwM18wLjU0LVBVQi5wZGYNCj4gaHR0cHM6Ly93d3cuYW1kLmNvbS9zeXN0ZW0vZmlsZXMvVGVj
aERvY3MvMjQ1OTQucGRmDQo+IA0KPiAtLS0NCj4gdjI6IFVzZWQgdGhlIHZlcnNpb25lZCBDUFUg
bW9kZWxzIGluc3RlYWQgb2YgbWFjaGluZS10eXBlLWJhc2VkIENQVQ0KPiAgICAgY29tcGF0aWJp
bGl0eSAoY29tbWVudGVkIGJ5IEVkdWFyZG8pLg0KPiANCj4gQmFidSBNb2dlciAoMik6DQo+ICAg
ICAgIGkzODY6IEFkZCBtaXNzaW5nIGNwdSBmZWF0dXJlIGJpdHMgaW4gRVBZQyBtb2RlbA0KPiAg
ICAgICBpMzg2OiBBZGQgMm5kIEdlbmVyYXRpb24gQU1EIEVQWUMgcHJvY2Vzc29ycw0KPiANCj4g
DQo+ICB0YXJnZXQvaTM4Ni9jcHUuYyB8ICAxMTkgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrLS0NCj4gIHRhcmdldC9pMzg2L2NwdS5oIHwgICAgMiAr
DQo+ICAyIGZpbGVzIGNoYW5nZWQsIDExNiBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0K
PiANCj4gLS0NCj4gDQo=

