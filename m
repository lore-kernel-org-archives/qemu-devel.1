Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A215BC4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:49:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D79DD2072E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NRlqMDL4";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="mVcILSlC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D79DD2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNMZA-0001Ac-Gl
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 16:49:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=53408e89f=Matias.Bjorling@wdc.com>)
 id 1kNLWg-0005gK-2u; Tue, 29 Sep 2020 15:43:02 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:14854)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=53408e89f=Matias.Bjorling@wdc.com>)
 id 1kNLWc-00074W-3y; Tue, 29 Sep 2020 15:43:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601408578; x=1632944578;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=+S8s+v2nkYCRj9fPJISQObQ0lsW6ujq69Zd4I9Oym+k=;
 b=NRlqMDL4jb7nxQu+PLbr4jRpQewL5wEyaWyNip9A5ZsA9TCIy8Id+5vi
 9bPQmshWCOybekOzWhsb2+YD1zZHGoeN1g1BXI6Y5cVpMWL48K2cGkZqU
 NvMShldMqZwIDeV555pDbQpR5EwhiU8WbdipBWYS6KtMFqIYzPJrt6B7j
 n/UX5QCpBepSAnoFfc0jVnDOYOpCBdm7LfvPI6A9/dxl6Y7GisgYrHqSA
 l2seVPLKpyPAk3GiP79j85zJ6T1sYOYzq697cn8t3QjU3YrG0LwduGBB+
 G/8JcYv7D+aSliO9BE898A4uyW9qWCWwsoW3wIDY/9BexfbD39dWOJ1EP A==;
IronPort-SDR: 0iKMdoeMCatSDjY2e84hMjrepoo5rNDOW3qsbS5CTP22JkZ0Zn2skJIRA1LfAQUR23T2bdwdJz
 idXfLJi/wS5a5qJmzywkyeO8N5T00anQjuH+TkBIuPknF5/l9WsFEs4ctJb9J6WGoYW6UgwdYQ
 YPfteQyUPJdOH5PJdg19CWaAVCON5mPuol/36qrMjvNzWKGxKjukXd8K1uwGiTF60Bc75Htrrp
 bUxqKfzjf6UdB97kDmgkkyXudh3HlkozL01rn4TjtKOVa1IKBpaImm1dWYe99SHstMjYNLDxqY
 xbA=
X-IronPort-AV: E=Sophos;i="5.77,319,1596470400"; d="scan'208";a="148614887"
Received: from mail-bn8nam12lp2173.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.173])
 by ob1.hgst.iphmx.com with ESMTP; 30 Sep 2020 03:42:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LxzcWIVlJzrHK8pMlLQR4YG0BC/za+eruHpkZul+jzdmIq9/1jsN/8PXRksJpGccA8QfN0ex413DNSeZXxM//cuTv2edYmpH5EhqFTzz/tgQ53ZKuZ5cKrkeEqalFeA6n6b2OhMABC24LEwkkkH14ku+soZ8+qQwyJT+NxlyQSePKHr/QNZiKwCJpUyCLJN1p4DalVRtEu/tKvxC28UfZWpkF0UuLmwby0KCHTahtylm07g28j7VoLZ9Z1AyX+XSihnkqBUb+lV+LPCnwEVh3wC31rnzhFS+xCg8y0w+xIOehDgsDrIMs/I6vpj90yFGKvTb2w+QMjxrhKYVxx2HDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+S8s+v2nkYCRj9fPJISQObQ0lsW6ujq69Zd4I9Oym+k=;
 b=GB9xv8yYbZXdAve1i6pvOYeET1lIce5Cp8SYZB8lrGyFqhCdsaJCs3rLmKx9byL2mcyfgQ/w24h1rGMQzdq81houEj/63c1IKnwEF5BT1TtHtcn3WVMtcEQOKOHcsYoShXX5VdoTyusT6Ou1T78AWv+5Dlr7a1TOUaayJdHr4AjQSQTallSICxmk+ILXDdo4rsBAIECmp8J9FNGI//HNGhpvbsCew1+wqZMRDLdVzTnXbLrsWl3Lc5J5g4e8WwN4JrosKVtjzC2Ad9ZKjb7SPzXcj6oZBejH/IrR+eS3Qi4Q1Ir0Nmgfxypq/CxhLGtoWl3tmhLgiYU4C6y1GjqkWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+S8s+v2nkYCRj9fPJISQObQ0lsW6ujq69Zd4I9Oym+k=;
 b=mVcILSlCsnnO30Z9H2puCie5JJtP95B3bizS/JST70MnOviIw+oa0BHYjBINo4mMGUquf9LHH0YQX9DNlD+STRiccSjM/iWnun+3Tie6IUDXigvhngzUFLbog/VSZRjOL94ngGUTCOoIzatBxuprDCVI9Q1Xl+mV7bsqkZBzY0Q=
Received: from MN2PR04MB6223.namprd04.prod.outlook.com (2603:10b6:208:db::14)
 by MN2PR04MB5646.namprd04.prod.outlook.com (2603:10b6:208:a2::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Tue, 29 Sep
 2020 19:42:52 +0000
Received: from MN2PR04MB6223.namprd04.prod.outlook.com
 ([fe80::c8ad:fc29:aa88:b8cc]) by MN2PR04MB6223.namprd04.prod.outlook.com
 ([fe80::c8ad:fc29:aa88:b8cc%5]) with mapi id 15.20.3433.034; Tue, 29 Sep 2020
 19:42:51 +0000
From: Matias Bjorling <Matias.Bjorling@wdc.com>
To: Klaus Jensen <its@irrelevant.dk>
Subject: RE: [PATCH v4 00/14] hw/block/nvme: Support Namespace Types and Zoned
 Namespace Command Set
Thread-Topic: [PATCH v4 00/14] hw/block/nvme: Support Namespace Types and
 Zoned Namespace Command Set
Thread-Index: AQHWkdZJ4fU53XqVA0iRKYOMvN8ou6l/d+uAgABwpQCAAAh6AIAAAbLggAAIcYCAAA6O0A==
Date: Tue, 29 Sep 2020 19:42:51 +0000
Message-ID: <MN2PR04MB6223FDFDEB9FD4602A767CDBF1320@MN2PR04MB6223.namprd04.prod.outlook.com>
References: <20200923182021.3724-1-dmitry.fomichev@wdc.com>
 <20200924210751.GD1738917@apples.localdomain>
 <MN2PR04MB59515B1EA1238861DFF3236AE1350@MN2PR04MB5951.namprd04.prod.outlook.com>
 <20200928063648.GA1967@apples.localdomain>
 <20200928212541.GC227320@dhcp-10-100-145-180.wdl.wdc.com>
 <CY4PR04MB3751997C2ED1D5EFB69E32ACE7350@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200929104633.GA179147@apples.localdomain>
 <20200929172944.GB477114@dhcp-10-100-145-180.wdl.wdc.com>
 <20200929180004.GC286786@apples.localdomain>
 <MN2PR04MB62232F2E33E3FCC880E47472F1320@MN2PR04MB6223.namprd04.prod.outlook.com>
 <20200929183621.GE286786@apples.localdomain>
In-Reply-To: <20200929183621.GE286786@apples.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: irrelevant.dk; dkim=none (message not signed)
 header.d=none;irrelevant.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [185.50.194.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 83e5831b-93cf-4111-aa8f-08d864afda17
x-ms-traffictypediagnostic: MN2PR04MB5646:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB56467F3D803D597D226B38A5F1320@MN2PR04MB5646.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3ZAA9X3iYpPBqRog3SxezGsJkcM60tCfrvLnysPFkx7UrwZ/y4HY1gjLvIwjQfCsdSaucWX8Hv/Q5AgpE9/HJJxhPVU95dd8bGBTmVrqXAkx9m8lDjjK1aWmU6vKTZiL7d+8JUZz5uVmQXtSdSW0hdXiNNm51737QsUiyzyS53Ak97kUq9dCin/sGWckLMye+GuDfK/qnPxw+7NpgPNj8oQrpDzPqni/hI7Bo6EGm5LsWDNkjFwHWuNfzmDS80aMhV28htGFvzuHZn4fLPbJN55KfYW06jh2SwMncO/pDywqVqgwrYGQDn4aCl0akXxn5a5R2c7AS38U5tUPHA9fOGHSaJW9tbbLL59mzG1Cn6JBsTIZzBPpbfvu2jRBn1G8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6223.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(39840400004)(136003)(376002)(346002)(66946007)(66476007)(66556008)(64756008)(5660300002)(6506007)(54906003)(7696005)(55016002)(9686003)(83380400001)(71200400001)(26005)(186003)(52536014)(4326008)(2906002)(86362001)(76116006)(66446008)(33656002)(8676002)(8936002)(478600001)(6916009)(316002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: ONTu/tj8I1AqPboYf4ovUs5BzZki27/0bkBXJlRxhZzbusfyu6B3YrqFSiLZE+NswZGy7sNWi6jb3p92nxH7hcMrCOeZrSTgz17V8r875kkFDwsSH0C3cJxV383JEzlHdZJPIsEw1ccmKS25IYvWDNkXHcy9cNDRbvMtiRvpwFr4o2C1rYWaGYW3wW5zU88Tl0OKKWdX8im6hmwAvlhtWpndsC1stx15Xt75Gzu40tnqefAH9PW4OUTeEo3jqBAU4EdQxatIHz7cd5fF7OSI9x+u68EtApgwffWEJ0NSExLc7xtP4sMTnEvowRpy4UaUzO63zJFj9Qb5R/kcrxlMFzQT8uClYAczoks6h44i6Uirr17VxwqR1do6uKGUlnR0VDcXf5PgtLxm4mplwV3I7MCq/w0xXJLy+NImXuUcLxXSTMpojaDNxgT7j21pQFJ5QoO+sRRVi5dtkVQS8VA6TE6uHLk7Q4iSPmuPpb+WNfMFIYqLE52srAgNewaFueU6Tm2o3Ff5sT0rKGuKbrAn6lJhYofSKQ8JEJDu6LJRAjoHOXTY3J5wKf57zA982LCitPgOXlaJ8mmN1+RNEJAdgJduffYm1Pl3OR7s6RVmm2SnFf/5Y2gUcWlUfzojqMEsHhONRF69tQEANG4BMjicGw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6223.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e5831b-93cf-4111-aa8f-08d864afda17
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 19:42:51.2804 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IGc8Cl/18sbbxMlBWa/qfErCfp5BH78egBpU7dsHQZt29hGe4OBQbaPMLef6tn5LWNp9VJpPIbpWHhaNpaRyNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5646
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=53408e89f=Matias.Bjorling@wdc.com; helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 15:42:54
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 29 Sep 2020 16:40:54 -0400
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
 Alistair Francis <Alistair.Francis@wdc.com>, Keith Busch <kbusch@kernel.org>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS2xhdXMgSmVuc2VuIDxp
dHNAaXJyZWxldmFudC5kaz4NCj4gU2VudDogVHVlc2RheSwgMjkgU2VwdGVtYmVyIDIwMjAgMjAu
MzYNCj4gVG86IE1hdGlhcyBCam9ybGluZyA8TWF0aWFzLkJqb3JsaW5nQHdkYy5jb20+DQo+IENj
OiBLZWl0aCBCdXNjaCA8a2J1c2NoQGtlcm5lbC5vcmc+OyBEYW1pZW4gTGUgTW9hbA0KPiA8RGFt
aWVuLkxlTW9hbEB3ZGMuY29tPjsgRmFtIFpoZW5nIDxmYW1AZXVwaG9uLm5ldD47IEtldmluIFdv
bGYNCj4gPGt3b2xmQHJlZGhhdC5jb20+OyBxZW11LWJsb2NrQG5vbmdudS5vcmc7IE5pa2xhcyBD
YXNzZWwNCj4gPE5pa2xhcy5DYXNzZWxAd2RjLmNvbT47IEtsYXVzIEplbnNlbiA8ay5qZW5zZW5A
c2Ftc3VuZy5jb20+OyBxZW11LQ0KPiBkZXZlbEBub25nbnUub3JnOyBBbGlzdGFpciBGcmFuY2lz
IDxBbGlzdGFpci5GcmFuY2lzQHdkYy5jb20+OyBQaGlsaXBwZQ0KPiBNYXRoaWV1LURhdWTDqSA8
cGhpbG1kQHJlZGhhdC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMDAvMTRdIGh3L2Js
b2NrL252bWU6IFN1cHBvcnQgTmFtZXNwYWNlIFR5cGVzIGFuZA0KPiBab25lZCBOYW1lc3BhY2Ug
Q29tbWFuZCBTZXQNCj4gDQo+IE9uIFNlcCAyOSAxODoxNywgTWF0aWFzIEJqb3JsaW5nIHdyb3Rl
Og0KPiA+DQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9t
OiBLbGF1cyBKZW5zZW4gPGl0c0BpcnJlbGV2YW50LmRrPg0KPiA+ID4gU2VudDogVHVlc2RheSwg
MjkgU2VwdGVtYmVyIDIwMjAgMjAuMDANCj4gPiA+IFRvOiBLZWl0aCBCdXNjaCA8a2J1c2NoQGtl
cm5lbC5vcmc+DQo+ID4gPiBDYzogRGFtaWVuIExlIE1vYWwgPERhbWllbi5MZU1vYWxAd2RjLmNv
bT47IEZhbSBaaGVuZw0KPiA+ID4gPGZhbUBldXBob24ubmV0PjsgS2V2aW4gV29sZiA8a3dvbGZA
cmVkaGF0LmNvbT47IHFlbXUtDQo+ID4gPiBibG9ja0Bub25nbnUub3JnOyBOaWtsYXMgQ2Fzc2Vs
IDxOaWtsYXMuQ2Fzc2VsQHdkYy5jb20+OyBLbGF1cw0KPiA+ID4gSmVuc2VuIDxrLmplbnNlbkBz
YW1zdW5nLmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsgQWxpc3RhaXINCj4gPiA+IEZyYW5j
aXMgPEFsaXN0YWlyLkZyYW5jaXNAd2RjLmNvbT47IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpDQo+
ID4gPiA8cGhpbG1kQHJlZGhhdC5jb20+OyBNYXRpYXMgQmpvcmxpbmcgPE1hdGlhcy5Cam9ybGlu
Z0B3ZGMuY29tPg0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAwMC8xNF0gaHcvYmxvY2sv
bnZtZTogU3VwcG9ydCBOYW1lc3BhY2UgVHlwZXMNCj4gPiA+IGFuZCBab25lZCBOYW1lc3BhY2Ug
Q29tbWFuZCBTZXQNCj4gPiA+DQo+ID4gPiBPbiBTZXAgMjkgMTA6MjksIEtlaXRoIEJ1c2NoIHdy
b3RlOg0KPiA+ID4gPiBPbiBUdWUsIFNlcCAyOSwgMjAyMCBhdCAxMjo0NjozM1BNICswMjAwLCBL
bGF1cyBKZW5zZW4gd3JvdGU6DQo+ID4gPiA+ID4gSXQgaXMgdW5taXN0YWthYmx5IGNsZWFyIHRo
YXQgeW91IGFyZSBpbnZhbGlkYXRpbmcgbXkgYXJndW1lbnRzDQo+ID4gPiA+ID4gYWJvdXQgcG9y
dGFiaWxpdHkgYW5kIGVuZGlhbm5lc3MgaXNzdWVzIGJ5IHN1Z2dlc3RpbmcgdGhhdCB3ZQ0KPiA+
ID4gPiA+IGp1c3QgcmVtb3ZlIHBlcnNpc3RlbnQgc3RhdGUgYW5kIGRlYWwgd2l0aCBpdCBsYXRl
ciwgYnV0DQo+ID4gPiA+ID4gcGVyc2lzdGVuY2UgaXMgdGhlIGtpbGxlciBmZWF0dXJlIHRoYXQg
c2V0cyB0aGUgUUVNVSBlbXVsYXRlZA0KPiA+ID4gPiA+IGRldmljZSBhcGFydCBmcm9tIG90aGVy
IGVtdWxhdGlvbiBvcHRpb25zLiBJdCBpcyBub3QgYWJvdXQgdXNpbmcNCj4gPiA+ID4gPiBlbXVs
YXRpb24gaW4gcHJvZHVjdGlvbiAoYmVjYXVzZSB5ZWFoLCB3aHkgd291bGQgeW91PyksIGJ1dA0K
PiA+ID4gPiA+IHBlcnNpc3RlbmNlIGlzIHdoYXQgbWFrZXMgaXQgcG9zc2libGUgdG8gZGV2ZWxv
cCBhbmQgdGVzdCAiem9uZWQNCj4gPiA+ID4gPiBGVExzIiBvciBzb21ldGhpbmcgdGhhdA0KPiA+
ID4gcmVxdWlyZXMgcmVjb3ZlcnkgYXQgcG93ZXIgdXAuDQo+ID4gPiA+ID4gVGhpcyBpcyB3aGF0
IGFsbG93cyB0ZXN0aW5nIG9mIGhvdyB5b3VyIGhvc3Qgc29mdHdhcmUgZGVhbHMgd2l0aA0KPiA+
ID4gPiA+IG9wZW5lZCB6b25lcyBiZWluZyB0cmFuc2l0aW9uZWQgdG8gRlVMTCBvbiBwb3dlciB1
cCBhbmQgdGhlDQo+ID4gPiA+ID4gcGVyc2lzdGVudCB0cmFja2luZyBvZiBMQkEgYWxsb2NhdGlv
biAoaW4gbXkgc2VyaWVzKSBjYW4gYmUgdXNlZA0KPiA+ID4gPiA+IHRvIHByb3Blcmx5IHRlc3Qg
ZXJyb3IgcmVjb3ZlcnkgaWYgeW91IGxvc3Qgc3RhdGUgaW4gdGhlIGFwcC4NCj4gPiA+ID4NCj4g
PiA+ID4gSG9sZCB1cCAtLSB3aHkgZG9lcyBhbiBPUEVOIHpvbmUgdHJhbnNpdGlvbiB0byBGVUxM
IG9uIHBvd2VyIHVwPw0KPiA+ID4gPiBUaGUgc3BlYyBzdWdnZXN0cyBpdCBzaG91bGQgYmUgQ0xP
U0VELiBUaGUgc3BlYyBkb2VzIGFwcGVhciB0bw0KPiA+ID4gPiBzdXBwb3J0IGdvaW5nIHRvIEZV
TEwgb24gYSBOVk0gU3Vic3lzdGVtIFJlc2V0LCB0aG91Z2guIEFjdHVhbGx5LA0KPiA+ID4gPiBu
b3cgdGhhdCBJJ20gbG9va2luZyBhdCB0aGlzIHBhcnQgb2YgdGhlIHNwZWMsIHRoZXNlIGltcGxp
Y2l0DQo+ID4gPiA+IHRyYW5zaXRpb25zIHNlZW0gYSBiaXQgbGVzcyBjbGVhciB0aGFuIEkgZXhw
ZWN0ZWQuIEknbSBub3Qgc3VyZQ0KPiA+ID4gPiBpdCdzIGNsZWFyIGVub3VnaCB0byBldmFsdWF0
ZSBxZW11J3MgY29tcGxpYW5jZSByaWdodCBub3cuDQo+ID4gPiA+DQo+ID4gPiA+IEJ1dCBJIGRv
bid0IHNlZSB3aGF0IHRlc3RpbmcgdGhlc2UgdHJhbnNpdGlvbnMgaGFzIHRvIGRvIHdpdGgNCj4g
PiA+ID4gaGF2aW5nIGEgcGVyc2lzdGVudCBzdGF0ZS4gWW91IGNhbiByZWJvb3QgeW91ciBWTSB3
aXRob3V0IHRlYXJpbmcNCj4gPiA+ID4gZG93biB0aGUgcnVubmluZyBRRU1VIGluc3RhbmNlLiBZ
b3UgY2FuIGFsc28gdW5iaW5kIHRoZSBkcml2ZXIgb3INCj4gPiA+ID4gc2h1dGRvd24gdGhlIGNv
bnRyb2xsZXIgd2l0aGluIHRoZSBydW5uaW5nIG9wZXJhdGluZyBzeXN0ZW0uIFRoYXQNCj4gPiA+
ID4gc2hvdWxkIG1ha2UgdGhvc2UgaW1wbGljaXQgc3RhdGUgdHJhbnNpdGlvbnMgcmVhY2hhYmxl
IGluIG9yZGVyIHRvDQo+ID4gPiA+IGV4ZXJjaXNlIHlvdXIgRlRMJ3MgcmVjb3ZlcnkuDQo+ID4g
PiA+DQo+ID4gPg0KPiA+ID4gT2ggZGVhciAtIGRvbid0ICJzcGVjIiB3aXRoIG1lIDspDQo+ID4g
Pg0KPiA+ID4gTlZNZSB2MS40IFNlY3Rpb24gNy4zLjE6DQo+ID4gPg0KPiA+ID4gICAgIEFuIE5W
TSBTdWJzeXN0ZW0gUmVzZXQgaXMgaW5pdGlhdGVkIHdoZW46DQo+ID4gPiAgICAgICAqIE1haW4g
cG93ZXIgaXMgYXBwbGllZCB0byB0aGUgTlZNIHN1YnN5c3RlbTsNCj4gPiA+ICAgICAgICogQSB2
YWx1ZSBvZiA0RTU2NEQ2NGggKCJOVk1lIikgaXMgd3JpdHRlbiB0byB0aGUgTlNTUi5OU1NSQw0K
PiA+ID4gICAgICAgICBmaWVsZDsNCj4gPiA+ICAgICAgICogUmVxdWVzdGVkIHVzaW5nIGEgbWV0
aG9kIGRlZmluZWQgaW4gdGhlIE5WTWUgTWFuYWdlbWVudA0KPiA+ID4gICAgICAgICBJbnRlcmZh
Y2Ugc3BlY2lmaWNhdGlvbjsgb3INCj4gPiA+ICAgICAgICogQSB2ZW5kb3Igc3BlY2lmaWMgZXZl
bnQgb2NjdXJzLg0KPiA+ID4NCj4gPiA+IEluIHRoZSBjb250ZXh0IG9mIFFFTVUsICJNYWluIHBv
d2VyIiBpcyB0ZWFyaW5nIGRvd24gUUVNVSBhbmQNCj4gPiA+IHN0YXJ0aW5nIGl0IGZyb20gc2Ny
YXRjaC4gSnVzdCBsaWtlIG9uIGEgInJlYWwiIGhvc3QsIHVuYmluZGluZyB0aGUNCj4gPiA+IGRy
aXZlciwgcmVib290aW5nIG9yIHNodXR0aW5nIGRvd24gdGhlIGNvbnRyb2xsZXIgZG9lcyBub3Qg
Y2F1c2UgYQ0KPiA+ID4gc3Vic3lzdGVtIHJlc2V0IChhbmQgZG9lcyBub3QgY2F1c2UgdGhlIHpv
bmVzIHRvIGNoYW5nZSBzdGF0ZSkuIEFuZA0KPiA+ID4gc2luY2UgdGhlIGRldmljZSBkb2VzIG5v
dCBpbmRpY2F0ZSBzdXBwb3J0IGZvciB0aGUgb3B0aW9uYWwNCj4gPiA+IE5TU1IuTlNTUkMgcmVn
aXN0ZXIsIHRoYXQgd2F5IHRvIGluaXRpYXRlIGEgc3Vic3lzdGVtIGNhbm5vdCBiZSB1c2VkLg0K
PiA+ID4NCj4gPiA+IFRoZSByZWFzb24gZm9yIG1vdmluZyB0byBGVUxMIGlzIHRoYXQgd3JpdGUg
cG9pbnRlciB1cGRhdGVzIGFyZSBub3QNCj4gPiA+IHBlcnNpc3RlZCBvbiBlYWNoIGFkdmFuY2Vt
ZW50LCBvbmx5IHdoZW4gdGhlIHpvbmUgc3RhdGUgY2hhbmdlcy4gU28NCj4gPiA+IHpvbmVzIHRo
YXQgd2VyZSBvcGVuZWQgbWlnaHQgaGF2ZSB2YWxpZCBkYXRhLCBidXQgaW52YWxpZCB3cml0ZSBw
b2ludGVyLg0KPiA+ID4gU28gdGhlIGRldmljZSB0cmFuc2l0aW9ucyB0aGVtIHRvIEZVTEwgYXMg
aXQgaXMgYWxsb3dlZCB0by4NCj4gPiA+DQo+ID4NCj4gPiBIb3cgYWJvdXQgd2hlbiBvbmUgbXVz
dCBhbHNvIHJlY292ZXIgZnJvbSBpbnRlcm1lZGlhdGUgc3RhdGVzIChpLmUuLA0KPiA+IG9wZW4v
Y2xvc2VkIHVwb24gcG93ZXIgbG9zcykuIEZvciBleGFtcGxlLCBJIGRvbid0IGhvcGUgYSByZWFs
IFNTRA0KPiA+IGltcGxlbWVudGF0aW9uIHRyYW5zaXRpb24gem9uZXMgdG8gZnVsbCB3aGVuIGl0
IGhhcyB0aG91c2FuZHMgb2Ygb3Blbg0KPiA+IHNpbXVsdGFuZW91c2x5LiBUaGF0IGNvdWxkIGJl
IGEgZGlzYXN0ZXIgZm9yIHRoZSBQRSBjeWNsZXMsIGFuZCBhIGxvdA0KPiA+IG9mIG1lZGlhIGdv
aW5nIHRvIHdhc3RlLiBPbmUgd291bGQgd2FudCBhcHBsaWNhdGlvbnMgdG8gc3VwcG9ydCB0aGF0
DQo+ID4ga2luZCBvZiBmYWlsdXJlIG1vZGUgYXMgd2VsbC4NCj4gDQo+IENocmlzdC4gVGhlIFdE
QyBTdHJpa2UgRm9yY2UgaXMgcmVhbGx5IGp1bXBpbmcgb3V0IG9mIGxpZ2h0c3BlZWQgaGVyZS4N
Cj4gSSdtIGFmcmFpZCBJIGRvbid0IGhhdmUgYW4gb3Bwb3NpbmcgZm9yY2UgdG8gZW5nYWdlIHdp
dGguIFNvIEknbGwgYmUgeW91ciBvbmx5DQo+IGJveGluZyBiYWcgZm9yIHRoZSBldmVuaW5nLg0K
PiANCj4gQXMgS2VpdGgganVzdCBzYWlkLCAiT3BlbmVkIiBpcyBub3QgYSB2YWxpZCBpbnRpYWwg
c3RhdGUuIERpZG4ndCB5b3Ugd3JpdGUgdGhlDQo+IHNwZWM/IDspIEFzIGZvciBDbG9zZWQsIHRo
ZXkgd2lsbCBiZSBicm91Z2h0IHVwIGFzIGlzLg0KDQpVcG9uIHBvd2VyIGZhaWx1cmUsIGEgem9u
ZSBpbiB0aGUgRXhwbGljaXRseSBPcGVuZWQgc3RhdGUgb3IgdGhlIEltcGxpY2l0bHkgT3BlbmVk
IHN0YXRlLCBhbmQgaGFzIExCQXMgd3JpdHRlbiwgY2FuIGVpdGhlciBiZSB0cmFuc2l0aW9uZWQg
dG8gRnVsbCBvciBDbG9zZWQgc3RhdGUgYnkgdGhlIGNvbnRyb2xsZXIuDQoNCkluIHRoZSBwcmV2
aW91cyBtYWlsLCBJIHdhbnRlZCB0byBwb2ludCBvdXQgdGhhdCBpZiB0aGUgaW50ZW50aW9uIG9m
IHFlbXUgd2FzIHRvIHRlc3QgYXBwbGljYXRpb25zIHVwb24gcG93ZXIgZmFpbHVyZXMsIGl0IGNv
dWxkIGJlIGJlbmVmaWNpYWwgdG8gaGF2ZSBhbiBvcHRpb24gdGhhdCBhbGxvd2VkIHRyYW5zaXRp
b25pbmcgb3BlbiB6b25lcyB0byBjbG9zZWQgdXBvbiBwb3dlciBmYWlsdXJlLg0KDQpUaGVuIGFw
cGxpY2F0aW9ucyBjYW4gYmUgdGVzdGVkIHdpdGggdGhhdCBpbiBtaW5kIGFzIHdlbGwsIHdpdGhv
dXQgaGF2aW5nIGFjY2VzcyB0byBhbiBTU0QgdGhhdCBwcm92aWRlZCB0aGF0IGtpbmQgb2YgaW1w
bGVtZW50YXRpb24uDQoNCj4gDQo+IFdpdGggdGhhdCBpbiBtaW5kLCBJJ20gbm90IHN1cmUgd2hh
dCB5b3Ugc3BlY2lmaWNhbGx5IHJlZmVyIHRvPyBJJ2xsIGdlbnRseSByZW1pbmQNCj4geW91IHRo
YXQgdGhlIFFFTVUgbnZtZSBkZXZpY2UgaXMgbm90IGEgcmVhbCBTU0QgYW5kIGRvZXMgbm90IGRl
YWwgd2l0aCBOQU5EDQo+IHNvIGl0IGRvZXMgbm90IHJlYWxseSBkbyBhbnkgInJlY292ZXJpbmci
IG9mIGludGVybWVkaWF0ZSBzdGF0ZXMgb24gcG93ZXIgb24gaWYNCj4gdGhhdCBpcyB3aGF0IHlv
dSByZWZlciB0bz8NCg==

