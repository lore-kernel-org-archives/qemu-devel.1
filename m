Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D41C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 04:14:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE4FD20768
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 04:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="F/HSsTgU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE4FD20768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kA3sQ-0006tA-4h
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 00:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kA3rh-0006Id-R6; Mon, 24 Aug 2020 00:13:49 -0400
Received: from mail-mw2nam10on2075.outbound.protection.outlook.com
 ([40.107.94.75]:7232 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kA3rf-0001Bd-IH; Mon, 24 Aug 2020 00:13:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nf38rCgJPSfYAHRe/0pzSJMDOYA0euyOilbtRwMOgPove2bpi7xxztA0b7rvtx2O/sfsgn38Dn82bcLD2T4I/IYChZkaZDSaxiFVdWn4Vng1YFUkupAiSsKr1dTFeiDoGOMYBXKo/W7zMyXUU9o0JMOCDH4+KYRyALoaXE0xlloMda6L9ItuG6BeViqO9wnkRq04e2S/WnOH/iNaFVI8VtG1IYp5qBX+Did012Vv3Qb3Va9y3alNRe7qJWEVxQzq+8200MIYEyDJ2CYIfWl0u5pHPvhZ/N5Tj8U3obN+URQAa0sXENm11XgQW8NOt/9d2jlvs0N8/vcrIawd6iuyvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=522o/979bj0oZ419FGeFUvDNT5DeG6peU1I0ZqyKw8s=;
 b=LDTUfGBJgJoJJAa2FA+qQ3eP5r6Qpc6hjs8/mYj73/eTTR+qTo7o20P32Jih06EMj6ObgcTeVMre8/UCZoeuBf8nq753KVYZNoHgA94K8+l1mZkAC1qDiFsPjDFrzhvii13c4nGJIqHmf46W2h1JIC1CADqwaVYx+m7tq0EGvPM6ooQUXVg1CKVrvbAXVUdc5EcY96c7hLtv0M08fEhOfrlJNMMx1rDtrCC0z2iqFec8YrfSHgJ6LVJf0HcctF5ON2HckdjXhJ6ewMXRxmAs2nffuy+G0AMWGinVu3Bn9r6iG9KXrx3lvWk+wM/ktEX+CHBlQEfM7EGrRpvuwXENMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=522o/979bj0oZ419FGeFUvDNT5DeG6peU1I0ZqyKw8s=;
 b=F/HSsTgU5JRwCNVN/QIwh2QLriWCTB8ov6M/mSwfL7Qox64R6M5bOZHkaelWeCMdDmApFoF7GlUB3hMm5l+SlfzReWMPgWCJOfb57Ioy7AqUmCYG4AyyqIifYjrFGPZdMk8V23iwDqnFnKcaQM2lbGvTeKgJHgdOlSiPRnE9AL8=
Received: from BY5PR02MB6772.namprd02.prod.outlook.com (2603:10b6:a03:206::11)
 by BYAPR02MB5269.namprd02.prod.outlook.com (2603:10b6:a03:6e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Mon, 24 Aug
 2020 04:13:39 +0000
Received: from BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::1007:f094:45c9:bb47]) by BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::1007:f094:45c9:bb47%8]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 04:13:39 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: Bin Meng <bmeng.cn@gmail.com>
Subject: RE: [PATCH 07/18] hw/sd: sd: Fix incorrect populated function switch
 status data structure
Thread-Topic: [PATCH 07/18] hw/sd: sd: Fix incorrect populated function switch
 status data structure
Thread-Index: AQHWctnsU/SfbQBsXUKm8YZh5uGNLKk+E8PAgARM5gD///+JAIABmMgQ
Date: Mon, 24 Aug 2020 04:13:39 +0000
Message-ID: <BY5PR02MB6772CBEA855C60F4F21162A3CA560@BY5PR02MB6772.namprd02.prod.outlook.com>
References: <1597423256-14847-1-git-send-email-bmeng.cn@gmail.com>
 <1597423256-14847-8-git-send-email-bmeng.cn@gmail.com>
 <565d9936-3eda-db2f-b390-05f675cf6644@amsat.org>
 <BY5PR02MB67720168B25F53370840545BCA5C0@BY5PR02MB6772.namprd02.prod.outlook.com>
 <20200821100940.GA30457@xhdsaipava40.xilinx.com>
 <CAEUhbmVX7_+SeVJpn_qPMoeLZXH-E3232ggVnq55UeskK3bDGQ@mail.gmail.com>
In-Reply-To: <CAEUhbmVX7_+SeVJpn_qPMoeLZXH-E3232ggVnq55UeskK3bDGQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [49.205.235.17]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 41d2d2e1-fcd3-456f-c2f6-08d847e4146d
x-ms-traffictypediagnostic: BYAPR02MB5269:
x-microsoft-antispam-prvs: <BYAPR02MB52694111EC29862D7DAC3DF6CA560@BYAPR02MB5269.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /CzzvNluEP9tHad+Oj7IfHfvhH2gTp9pYAzAtgHdu/eR+7y/CDOoNRN3Au4VSyP6aAbr8t5Z1jgvsoVaJCHX7sEb4t2iiXqacivAwRYl3S7ebF2t8zlelCkbtfJ0P0ZKkmfhmeVTH49wmiq8kft6AFQEhHd5RgtEy/DsW/Y1PSxi3mSsj5i3OmMFJYqCgVE8BASQou5vvo0AAohi7/WtmJLEBp0xnNaMeNHjzJ5Wu/Fx8z8tOBLv15vtOes6MCgHYH+UQ67fQRWcc9J1kN/hbSjHTzdKoDp9WPUwF+F4qxwBQTDX76YczP3dHrK/fpsj
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6772.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(396003)(366004)(346002)(39850400004)(376002)(136003)(52536014)(5660300002)(4326008)(83380400001)(2906002)(9686003)(86362001)(4744005)(26005)(55016002)(186003)(6506007)(6916009)(53546011)(316002)(66556008)(54906003)(76116006)(66476007)(64756008)(8676002)(66946007)(33656002)(7416002)(478600001)(8936002)(71200400001)(66446008)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 7Aq0gqor+C+227czT8604r7qTRUXKOvlJIzTpmhGLuCReu98AnKVGK2qNrd8ZaGGt7Y8n9dpqQ62gx26IDiMBb1FGaMfJJBgH2EGh/MN6J+roqIiWCWnC5pGaSJirxgOZbPE+ZAl9GhY6s2CNH2ZocvbvxdgNMMI7ga/Qq+yXDDuOR0d0Hnqy4+In2Mi6eSag9CFKy5ppp5cn2vDktVXlo4VCIXEtFSnqhig+M7ohtH3+ub0aWTl40CgTykQ/TiUx0FEiGCJo9icwW8nfEoUT+XOdIk/tplns3821bXCHotoC/9cu7RKt+5COPffxt95Ymb5htaGw/aaVVvisF9As0lKBEPnOmA5KPGG3yYWbi9Wuo4sqiU497ecAx58SiJDQtLEOItn3aBGu+hkYNFuKmShhPU25Os7rJrfSstT9BaDtKtHHMr0JdWXslC+nv0M6Khh8OS+6/Z+bDkRjEjbTCBEkL8KU8noov4m00VAowzE1nsXuU4sEPdt7aZTzeSem64RM53PYzOXfby/ZMSsR8ez/O+oHEC2NRfm9RGJzC8hJ6O1jALuxLcVoTxUyTfD+SS867WseoGYPNgqC+0qlEM4WgGE0Ae8gYfXkbyt7wzyz1Wnw7z8LxMYtI+tAd7kOalBxbpRRTHvivqPSvkhMw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6772.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41d2d2e1-fcd3-456f-c2f6-08d847e4146d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2020 04:13:39.2235 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PXBxHDRvrGfsWLcp6V5bROjqVcCHDkt4F9gZgNnVLshP/McSu1MFwxaHJx58g8eUHxNbJgKSLfz9cs7HDOhQAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5269
Received-SPF: pass client-ip=40.107.94.75; envelope-from=saipava@xilinx.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 00:13:44
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Bin Meng <bin.meng@windriver.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgQmluLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEJpbiBNZW5n
IDxibWVuZy5jbkBnbWFpbC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgQXVndXN0IDIxLCAyMDIwIDM6
MzggUE0NCj4gVG86IFNhaSBQYXZhbiBCb2RkdSA8c2FpcGF2YUB4aWxpbnguY29tPg0KPiBDYzog
UGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPGY0YnVnQGFtc2F0Lm9yZz47IEFsaXN0YWlyIEZyYW5j
aXMNCj4gPEFsaXN0YWlyLkZyYW5jaXNAd2RjLmNvbT47IEJhc3RpYW4gS29wcGVsbWFubiA8a2Jh
c3RpYW5AbWFpbC51bmktDQo+IHBhZGVyYm9ybi5kZT47IFBhbG1lciBEYWJiZWx0IDxwYWxtZXJk
YWJiZWx0QGdvb2dsZS5jb20+OyBTYWdhcg0KPiBLYXJhbmRpa2FyIDxzYWdhcmtAZWVjcy5iZXJr
ZWxleS5lZHU+OyBxZW11LWRldmVsQG5vbmdudS5vcmc7IHFlbXUtDQo+IHJpc2N2QG5vbmdudS5v
cmc7IEJpbiBNZW5nIDxiaW4ubWVuZ0B3aW5kcml2ZXIuY29tPjsgcWVtdS0NCj4gYmxvY2tAbm9u
Z251Lm9yZzsgU2FpIFBhdmFuIEJvZGR1IDxzYWlwYXZhQHhpbGlueC5jb20+DQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggMDcvMThdIGh3L3NkOiBzZDogRml4IGluY29ycmVjdCBwb3B1bGF0ZWQgZnVu
Y3Rpb24gc3dpdGNoDQo+IHN0YXR1cyBkYXRhIHN0cnVjdHVyZQ0KPiANCj4gSGkgU2FpLA0KPiAN
Cj4gT24gRnJpLCBBdWcgMjEsIDIwMjAgYXQgNjowNCBQTSBTYWkgUGF2YW4gQm9kZHUNCj4gPHNh
aS5wYXZhbi5ib2RkdUB4aWxpbnguY29tPiB3cm90ZToNCj4gPg0KPiA+IEhpIFBoaWxpcHBlLA0K
PiA+DQo+ID4gRmlyc3QgdHdvIHBhdGNoIG9mIFNEIGxvb2sgZ29vZC4gVGVzdGVkIHRoZW0gb3Zl
ciB6eW5xbXAgYW5kIHZlcnNhbA0KPiA+IHBsYXRmb3Jtcy4NCj4gPg0KPiANCj4gVGhhbmtzIGZv
ciB0ZXN0aW5nLg0KPiANCj4gQ2FuIEkgYWRkIHlvdXIgVGVzdGVkLWJ5IHRhZz8NCltTYWkgUGF2
YW4gQm9kZHVdIFN1cmUuIFRoYW5rcy4NCg0KUmVnYXJkcywNClNhaSBQYXZhbg0KPiANCj4gUmVn
YXJkcywNCj4gQmluDQo=

