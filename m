Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6ADEC49ECA
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:42:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1FBA206B5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kvaC6+rR";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="KyvT8Hy7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1FBA206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNMSV-0004ji-Tb
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 16:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=53408e89f=Matias.Bjorling@wdc.com>)
 id 1kNKBj-0005X9-Bd; Tue, 29 Sep 2020 14:17:19 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:15136)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=53408e89f=Matias.Bjorling@wdc.com>)
 id 1kNKBe-0003Mk-Vh; Tue, 29 Sep 2020 14:17:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601403773; x=1632939773;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=97zj24CjdGGKyYtRKXyuGTiqwdv7nrg2oZIr+/6iYjc=;
 b=kvaC6+rRD80wmdUhlICseY3FrGzXgxpRsjwuUMmKlg/xPR6Rp2cyIoNq
 /w59hNqJFCrZQ0d7ZZ1Np1ssBCD+I8uvcCC9Vek3mU6z6JtEh5Zw/gQph
 f9laU63wmXTvnOQP8W03wp345idWfNUffu9n6lOXww+sWhxQL+WYGi85t
 9EsN9I6cYXPVs9Ss7pTZ9eikYgbY9WHxflogGohI6Zxlk8cI6VZTvSW4+
 SikU98Ht0QRztnHT6OYkXSHh6PLN5+nlu7P84RtsRvp3yC+8tJHk52tbs
 uVV39B31XiWocIn4Vlqxb21QcnKIT/0JHr8OZgLSJe/F1Eyxd7lCI+HKN w==;
IronPort-SDR: ngp/Bktumn38KuPlE0sPiT1rKd2etqljNCojgHdK4UJPSTvNMY1ql28xXTmfKjLjvMQcsep0xF
 q7RxIWfofnaPQYtbDMMEu5gndEclA4xFZ80dwGqZ9+/ScFQuFt+ci1OxLCdyuqzad47ufxLy9h
 tB7Fd45zJt/3Mp3eE0N8ZbpHzKq2waXvs5meO4Ld0PNj7PtspuVPKP7XahOKOndQ6j02Yxh63Z
 NwlKmm2DFBapKH1p3wf0PDrIHNjEmMzxNvZb/m5OwQeMwj2+MrN9YJSHp0Mg4EF8W7BDtcKOli
 IS4=
X-IronPort-AV: E=Sophos;i="5.77,319,1596470400"; d="scan'208";a="251984504"
Received: from mail-dm6nam08lp2044.outbound.protection.outlook.com (HELO
 NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.44])
 by ob1.hgst.iphmx.com with ESMTP; 30 Sep 2020 02:22:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZhHFfiWDtV4HiOCt1bi0VWzN7OzDyC36uHd5g7IeADHkxnNcBEmjNNq0hHU0UMfx/47PYJX36yElaM80OGxmTih1kZNYPiPczC1fJ7DoragbrHn+r+rkQgm3T3TIcI9cQy6+jJGRYd11e3EBIxySKfvaxIf0yj7DIufEwERjUzaWhzOUwXbFzPt3hCS70nHhwRWlH7ISxjscwVz6CU8dMS7xuFjcX91I79JmTK+6GkYbVUpEpptmrT+BhZEP4o7WAVv/EANgG6PSDBft2xmHhW47xkMHE41wTWOUFMkHcSuImVG2WN+hJznjc4KWgShPRlgC5PFyO0dDaUO80IsGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97zj24CjdGGKyYtRKXyuGTiqwdv7nrg2oZIr+/6iYjc=;
 b=CjQn6FHx9zlEz0QaWAg7Fqz19MdJpIx9kfILXR1J2IFeAp0rrlQ5Q9ePlnL2aIi6X9/kqxsLxc+1rUhhn5jUtgdcWFBb33iRFbv4D4KPEr5qj7aVEpyfOuhaMMCPb3C5K4SaMyyFUBtgCsYz1vBsCMABfTywKJ0BuAxaar3RdguyZeATpe4jhcrxyyiWv+7Wo6hUD3hYEK/J2xBskYa7QcOUhAS2308WDuRYpatFctYg7TzJbLd2PuoKBYZrW3weM+usrrB9eUzzX3GL/8oIlzTwrm6/atBVGPjaqa4tPHZLHiMstW+Di4+somFL5wQt+fkVgxsBtsJKdGkBYVpUCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97zj24CjdGGKyYtRKXyuGTiqwdv7nrg2oZIr+/6iYjc=;
 b=KyvT8Hy7BnJjTsL3MmOyVg7X80m1Sw1aOIdUZTyo9HjedhgXTlsq2ntwCNBs1w7iMwF32+eGVdem5F0XZFfws0NqQMMc4YY3jAMeoEPB+uSSt0ObmACGrHkxyMngWy02nomqkJjQKnMYl8+VFo0oeEJVjZRjVzC42D5ziXPYQyQ=
Received: from MN2PR04MB6223.namprd04.prod.outlook.com (2603:10b6:208:db::14)
 by MN2PR04MB5485.namprd04.prod.outlook.com (2603:10b6:208:e2::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.28; Tue, 29 Sep
 2020 18:17:08 +0000
Received: from MN2PR04MB6223.namprd04.prod.outlook.com
 ([fe80::c8ad:fc29:aa88:b8cc]) by MN2PR04MB6223.namprd04.prod.outlook.com
 ([fe80::c8ad:fc29:aa88:b8cc%5]) with mapi id 15.20.3433.034; Tue, 29 Sep 2020
 18:17:08 +0000
From: Matias Bjorling <Matias.Bjorling@wdc.com>
To: Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>
Subject: RE: [PATCH v4 00/14] hw/block/nvme: Support Namespace Types and Zoned
 Namespace Command Set
Thread-Topic: [PATCH v4 00/14] hw/block/nvme: Support Namespace Types and
 Zoned Namespace Command Set
Thread-Index: AQHWkdZJ4fU53XqVA0iRKYOMvN8ou6l/d+uAgABwpQCAAAh6AIAAAbLg
Date: Tue, 29 Sep 2020 18:17:08 +0000
Message-ID: <MN2PR04MB62232F2E33E3FCC880E47472F1320@MN2PR04MB6223.namprd04.prod.outlook.com>
References: <20200923182021.3724-1-dmitry.fomichev@wdc.com>
 <20200924210751.GD1738917@apples.localdomain>
 <MN2PR04MB59515B1EA1238861DFF3236AE1350@MN2PR04MB5951.namprd04.prod.outlook.com>
 <20200928063648.GA1967@apples.localdomain>
 <20200928212541.GC227320@dhcp-10-100-145-180.wdl.wdc.com>
 <CY4PR04MB3751997C2ED1D5EFB69E32ACE7350@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200929104633.GA179147@apples.localdomain>
 <20200929172944.GB477114@dhcp-10-100-145-180.wdl.wdc.com>
 <20200929180004.GC286786@apples.localdomain>
In-Reply-To: <20200929180004.GC286786@apples.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: irrelevant.dk; dkim=none (message not signed)
 header.d=none;irrelevant.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [185.50.194.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0e4d38ee-2ccc-4e86-9cc2-08d864a3e0ac
x-ms-traffictypediagnostic: MN2PR04MB5485:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB5485E04D93B48B346A743DE5F1320@MN2PR04MB5485.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xi1cbIYDjq5Oz1e7ZlkgCyMCHDBc89SpyVnLLg80GYE0OmCIf+zBIf6Jg1N01Xfpoji+vMMs7Z84WPtRELyHgbHHGIfAjw7OERZLODRKNygNVNWlagbtnNsrlBZ2qD8EDWbA1/aGK2xjpAt70crvU9iSuAva6E5Ht+YqXybGzwjZw0ziDKHooKzf/d1HQB6g7onCpj70zsmiwh+U15Vo5DtjeT6SDiOOi8tec17NiLwmdm7eooFGkgY8j0FHEtKCUHjandZFXuRz7gjKoyWI0yXCiVSF/NbOik1biXCHN6iqKme+7MpF/ublGLRaxzLe6jlHceOD1XdrnDA9EiDXlfznaW5vpFrFiydjNQ2CzN+4xtF72qq/UYHywi2dkRZ6
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6223.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(86362001)(4326008)(8936002)(33656002)(26005)(66476007)(76116006)(52536014)(5660300002)(66556008)(64756008)(9686003)(66446008)(66946007)(55016002)(71200400001)(83380400001)(2906002)(478600001)(8676002)(110136005)(316002)(54906003)(6506007)(186003)(7696005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 5KBv3FymDuWsubH/Hh3B3P2etmUVou9xF+J+gnfoxROBYyDW+q8rvPzLFIuAg7NEeKTKJwLLOedx21Z8eoKoDXscoh6NYlupt+RTDdZH7r71dBPgw5zqqNIUptyOWOVHb+MjeAiqojMbL6RplUGlRy6lMTrU/mETPm2eQV/NhBut92rMA1c7uD/JFqyfkFO/e+k8etBeFbMCu/pzzMBEeWbpFS6+gVHVlXcOs1koJG9/gUudI4PUxLRwZXeIsrOn5/xG65I0x0dCas03X/GAdkRQxSnm5iIy2mGJ3b4RjnPo9XsCtSX73fFexVY2oS5Lk8z2gT1hEUsHp/SJguAxqPn9UWaK7s+0vA5VoA2R/533slAQdi9dyDUrPA/I5S8dyTiyb97T2Tybkq4hcyAO6mKBtMFiY3VqO4De5SWM8Q2h4W8JIpQafDpIKUAtxtW5emkeXDIK7vut73gqJaIgBzDiCQEKF4PhYDvdjw+GXTxoSB78t+YRtmVCoBA/ppukNJZW2GyTBJrYjlGK0PTR/yYW457ZsETa8+YvHVJNGll4oO9h7jTsBzVX/mRRYXww3f3kCj2EeQdZc98ey6NAccyt72TOr70DNDxSy4MOcLYVybK+8YI+1ubyGw8M/+a2WYCN8ajctxWhbAszxjMTfQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6223.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e4d38ee-2ccc-4e86-9cc2-08d864a3e0ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 18:17:08.2581 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s47DGTtUDII2t5ml8rwITWRfsdMAAMT/l611rVJ3hE4enKSFSokgeP4vdzlmONQSUlnlIwss/q3X6+2ie+8exQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5485
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=53408e89f=Matias.Bjorling@wdc.com; helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 14:17:10
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
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS2xhdXMgSmVuc2VuIDxp
dHNAaXJyZWxldmFudC5kaz4NCj4gU2VudDogVHVlc2RheSwgMjkgU2VwdGVtYmVyIDIwMjAgMjAu
MDANCj4gVG86IEtlaXRoIEJ1c2NoIDxrYnVzY2hAa2VybmVsLm9yZz4NCj4gQ2M6IERhbWllbiBM
ZSBNb2FsIDxEYW1pZW4uTGVNb2FsQHdkYy5jb20+OyBGYW0gWmhlbmcNCj4gPGZhbUBldXBob24u
bmV0PjsgS2V2aW4gV29sZiA8a3dvbGZAcmVkaGF0LmNvbT47IHFlbXUtDQo+IGJsb2NrQG5vbmdu
dS5vcmc7IE5pa2xhcyBDYXNzZWwgPE5pa2xhcy5DYXNzZWxAd2RjLmNvbT47IEtsYXVzIEplbnNl
bg0KPiA8ay5qZW5zZW5Ac2Ftc3VuZy5jb20+OyBxZW11LWRldmVsQG5vbmdudS5vcmc7IEFsaXN0
YWlyIEZyYW5jaXMNCj4gPEFsaXN0YWlyLkZyYW5jaXNAd2RjLmNvbT47IFBoaWxpcHBlIE1hdGhp
ZXUtRGF1ZMOpIDxwaGlsbWRAcmVkaGF0LmNvbT47DQo+IE1hdGlhcyBCam9ybGluZyA8TWF0aWFz
LkJqb3JsaW5nQHdkYy5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMDAvMTRdIGh3L2Js
b2NrL252bWU6IFN1cHBvcnQgTmFtZXNwYWNlIFR5cGVzIGFuZA0KPiBab25lZCBOYW1lc3BhY2Ug
Q29tbWFuZCBTZXQNCj4gDQo+IE9uIFNlcCAyOSAxMDoyOSwgS2VpdGggQnVzY2ggd3JvdGU6DQo+
ID4gT24gVHVlLCBTZXAgMjksIDIwMjAgYXQgMTI6NDY6MzNQTSArMDIwMCwgS2xhdXMgSmVuc2Vu
IHdyb3RlOg0KPiA+ID4gSXQgaXMgdW5taXN0YWthYmx5IGNsZWFyIHRoYXQgeW91IGFyZSBpbnZh
bGlkYXRpbmcgbXkgYXJndW1lbnRzDQo+ID4gPiBhYm91dCBwb3J0YWJpbGl0eSBhbmQgZW5kaWFu
bmVzcyBpc3N1ZXMgYnkgc3VnZ2VzdGluZyB0aGF0IHdlIGp1c3QNCj4gPiA+IHJlbW92ZSBwZXJz
aXN0ZW50IHN0YXRlIGFuZCBkZWFsIHdpdGggaXQgbGF0ZXIsIGJ1dCBwZXJzaXN0ZW5jZSBpcw0K
PiA+ID4gdGhlIGtpbGxlciBmZWF0dXJlIHRoYXQgc2V0cyB0aGUgUUVNVSBlbXVsYXRlZCBkZXZp
Y2UgYXBhcnQgZnJvbQ0KPiA+ID4gb3RoZXIgZW11bGF0aW9uIG9wdGlvbnMuIEl0IGlzIG5vdCBh
Ym91dCB1c2luZyBlbXVsYXRpb24gaW4NCj4gPiA+IHByb2R1Y3Rpb24gKGJlY2F1c2UgeWVhaCwg
d2h5IHdvdWxkIHlvdT8pLCBidXQgcGVyc2lzdGVuY2UgaXMgd2hhdA0KPiA+ID4gbWFrZXMgaXQg
cG9zc2libGUgdG8gZGV2ZWxvcCBhbmQgdGVzdCAiem9uZWQgRlRMcyIgb3Igc29tZXRoaW5nIHRo
YXQNCj4gcmVxdWlyZXMgcmVjb3ZlcnkgYXQgcG93ZXIgdXAuDQo+ID4gPiBUaGlzIGlzIHdoYXQg
YWxsb3dzIHRlc3Rpbmcgb2YgaG93IHlvdXIgaG9zdCBzb2Z0d2FyZSBkZWFscyB3aXRoDQo+ID4g
PiBvcGVuZWQgem9uZXMgYmVpbmcgdHJhbnNpdGlvbmVkIHRvIEZVTEwgb24gcG93ZXIgdXAgYW5k
IHRoZQ0KPiA+ID4gcGVyc2lzdGVudCB0cmFja2luZyBvZiBMQkEgYWxsb2NhdGlvbiAoaW4gbXkg
c2VyaWVzKSBjYW4gYmUgdXNlZCB0bw0KPiA+ID4gcHJvcGVybHkgdGVzdCBlcnJvciByZWNvdmVy
eSBpZiB5b3UgbG9zdCBzdGF0ZSBpbiB0aGUgYXBwLg0KPiA+DQo+ID4gSG9sZCB1cCAtLSB3aHkg
ZG9lcyBhbiBPUEVOIHpvbmUgdHJhbnNpdGlvbiB0byBGVUxMIG9uIHBvd2VyIHVwPyBUaGUNCj4g
PiBzcGVjIHN1Z2dlc3RzIGl0IHNob3VsZCBiZSBDTE9TRUQuIFRoZSBzcGVjIGRvZXMgYXBwZWFy
IHRvIHN1cHBvcnQNCj4gPiBnb2luZyB0byBGVUxMIG9uIGEgTlZNIFN1YnN5c3RlbSBSZXNldCwg
dGhvdWdoLiBBY3R1YWxseSwgbm93IHRoYXQgSSdtDQo+ID4gbG9va2luZyBhdCB0aGlzIHBhcnQg
b2YgdGhlIHNwZWMsIHRoZXNlIGltcGxpY2l0IHRyYW5zaXRpb25zIHNlZW0gYQ0KPiA+IGJpdCBs
ZXNzIGNsZWFyIHRoYW4gSSBleHBlY3RlZC4gSSdtIG5vdCBzdXJlIGl0J3MgY2xlYXIgZW5vdWdo
IHRvDQo+ID4gZXZhbHVhdGUgcWVtdSdzIGNvbXBsaWFuY2UgcmlnaHQgbm93Lg0KPiA+DQo+ID4g
QnV0IEkgZG9uJ3Qgc2VlIHdoYXQgdGVzdGluZyB0aGVzZSB0cmFuc2l0aW9ucyBoYXMgdG8gZG8g
d2l0aCBoYXZpbmcgYQ0KPiA+IHBlcnNpc3RlbnQgc3RhdGUuIFlvdSBjYW4gcmVib290IHlvdXIg
Vk0gd2l0aG91dCB0ZWFyaW5nIGRvd24gdGhlDQo+ID4gcnVubmluZyBRRU1VIGluc3RhbmNlLiBZ
b3UgY2FuIGFsc28gdW5iaW5kIHRoZSBkcml2ZXIgb3Igc2h1dGRvd24gdGhlDQo+ID4gY29udHJv
bGxlciB3aXRoaW4gdGhlIHJ1bm5pbmcgb3BlcmF0aW5nIHN5c3RlbS4gVGhhdCBzaG91bGQgbWFr
ZSB0aG9zZQ0KPiA+IGltcGxpY2l0IHN0YXRlIHRyYW5zaXRpb25zIHJlYWNoYWJsZSBpbiBvcmRl
ciB0byBleGVyY2lzZSB5b3VyIEZUTCdzDQo+ID4gcmVjb3ZlcnkuDQo+ID4NCj4gDQo+IE9oIGRl
YXIgLSBkb24ndCAic3BlYyIgd2l0aCBtZSA7KQ0KPiANCj4gTlZNZSB2MS40IFNlY3Rpb24gNy4z
LjE6DQo+IA0KPiAgICAgQW4gTlZNIFN1YnN5c3RlbSBSZXNldCBpcyBpbml0aWF0ZWQgd2hlbjoN
Cj4gICAgICAgKiBNYWluIHBvd2VyIGlzIGFwcGxpZWQgdG8gdGhlIE5WTSBzdWJzeXN0ZW07DQo+
ICAgICAgICogQSB2YWx1ZSBvZiA0RTU2NEQ2NGggKCJOVk1lIikgaXMgd3JpdHRlbiB0byB0aGUg
TlNTUi5OU1NSQw0KPiAgICAgICAgIGZpZWxkOw0KPiAgICAgICAqIFJlcXVlc3RlZCB1c2luZyBh
IG1ldGhvZCBkZWZpbmVkIGluIHRoZSBOVk1lIE1hbmFnZW1lbnQNCj4gICAgICAgICBJbnRlcmZh
Y2Ugc3BlY2lmaWNhdGlvbjsgb3INCj4gICAgICAgKiBBIHZlbmRvciBzcGVjaWZpYyBldmVudCBv
Y2N1cnMuDQo+IA0KPiBJbiB0aGUgY29udGV4dCBvZiBRRU1VLCAiTWFpbiBwb3dlciIgaXMgdGVh
cmluZyBkb3duIFFFTVUgYW5kIHN0YXJ0aW5nIGl0DQo+IGZyb20gc2NyYXRjaC4gSnVzdCBsaWtl
IG9uIGEgInJlYWwiIGhvc3QsIHVuYmluZGluZyB0aGUgZHJpdmVyLCByZWJvb3Rpbmcgb3INCj4g
c2h1dHRpbmcgZG93biB0aGUgY29udHJvbGxlciBkb2VzIG5vdCBjYXVzZSBhIHN1YnN5c3RlbSBy
ZXNldCAoYW5kIGRvZXMgbm90DQo+IGNhdXNlIHRoZSB6b25lcyB0byBjaGFuZ2Ugc3RhdGUpLiBB
bmQgc2luY2UgdGhlIGRldmljZSBkb2VzIG5vdCBpbmRpY2F0ZQ0KPiBzdXBwb3J0IGZvciB0aGUg
b3B0aW9uYWwgTlNTUi5OU1NSQyByZWdpc3RlciwgdGhhdCB3YXkgdG8gaW5pdGlhdGUgYSBzdWJz
eXN0ZW0NCj4gY2Fubm90IGJlIHVzZWQuDQo+IA0KPiBUaGUgcmVhc29uIGZvciBtb3ZpbmcgdG8g
RlVMTCBpcyB0aGF0IHdyaXRlIHBvaW50ZXIgdXBkYXRlcyBhcmUgbm90IHBlcnNpc3RlZA0KPiBv
biBlYWNoIGFkdmFuY2VtZW50LCBvbmx5IHdoZW4gdGhlIHpvbmUgc3RhdGUgY2hhbmdlcy4gU28g
em9uZXMgdGhhdCB3ZXJlDQo+IG9wZW5lZCBtaWdodCBoYXZlIHZhbGlkIGRhdGEsIGJ1dCBpbnZh
bGlkIHdyaXRlIHBvaW50ZXIuDQo+IFNvIHRoZSBkZXZpY2UgdHJhbnNpdGlvbnMgdGhlbSB0byBG
VUxMIGFzIGl0IGlzIGFsbG93ZWQgdG8uDQo+IA0KDQpIb3cgYWJvdXQgd2hlbiBvbmUgbXVzdCBh
bHNvIHJlY292ZXIgZnJvbSBpbnRlcm1lZGlhdGUgc3RhdGVzIChpLmUuLCBvcGVuL2Nsb3NlZCB1
cG9uIHBvd2VyIGxvc3MpLiBGb3IgZXhhbXBsZSwgSSBkb24ndCBob3BlIGEgcmVhbCBTU0QgaW1w
bGVtZW50YXRpb24gdHJhbnNpdGlvbiB6b25lcyB0byBmdWxsIHdoZW4gaXQgaGFzIHRob3VzYW5k
cyBvZiBvcGVuIHNpbXVsdGFuZW91c2x5LiBUaGF0IGNvdWxkIGJlIGEgZGlzYXN0ZXIgZm9yIHRo
ZSBQRSBjeWNsZXMsIGFuZCBhIGxvdCBvZiBtZWRpYSBnb2luZyB0byB3YXN0ZS4gT25lIHdvdWxk
IHdhbnQgYXBwbGljYXRpb25zIHRvIHN1cHBvcnQgdGhhdCBraW5kIG9mIGZhaWx1cmUgbW9kZSBh
cyB3ZWxsLiANCg==

