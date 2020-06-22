Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCAE2C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 12:35:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B5252071A
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 12:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="T8ks0cjJ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="MQ1HTmdI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B5252071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnLfv-0007Os-PI
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 08:35:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=435c605ae=Anup.Patel@wdc.com>)
 id 1jnLeq-0006eE-Fi; Mon, 22 Jun 2020 08:34:40 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:47240)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=435c605ae=Anup.Patel@wdc.com>)
 id 1jnLel-0002KZ-Ss; Mon, 22 Jun 2020 08:34:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592829276; x=1624365276;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=l2cSR5g1tWwgu1Lu5DWIe1G+io1NC2XEowYDaePPXgQ=;
 b=T8ks0cjJ9deDXraQusIyyczMxsSyvv3hdGPYOSvjRI3Vhzwn+SR6zJYb
 EsoRgVfL5aFTuGSAcrmxUQttukV0OQ4tTma++Wa/bj5OTv3SJelEVmRgY
 WEvSbFffZw+9KODpoRGfTQNmJZudg+kVfmWU0a3VaxiBmBOywzWwuQQ7+
 lqvYSUE/N0uiAqj/ZzMN0uY8+X2IYGZ+3phQ1g6TwjObnVYd447XBxP10
 y7caOsMUbBQIMdrR0HaEqj9mhUiWMdzF7PTjFPMAovKnLJWsvj6Qc8Egw
 WVhfFcJ6M9GeoTMO7OOdyZxdUAh8Vip20IU2pMBlz0+8MuM6S3z4T7Xn0 w==;
IronPort-SDR: b6PmTTZKAqbjarT7uG17voAQWDcjDMKOQlg5dH0m/Azc+Q5Rq7v9cob4Qt9Ijur7MDHSnwBhJW
 +KS6/kL7FZX/2vPMWPpTyB4Wdag+qOIhaswGzFvbmCsNLk9+1yESZSCZwrx0967u9/Ya7NjDgg
 N/WvBdt6FkKDcQSTaK5AdHjqzT4N6F/VdWcV9RDfCadcECwslFaBz80YkWKWtJIb2q4ZFYlSp5
 Vp2i10bCHwpZYs0WV0HxORNvS/qP+ARgGtBo7Z4DsOeg9eIKmtxrEjd9+YQNJ8fh5Kj97sbvEL
 JCQ=
X-IronPort-AV: E=Sophos;i="5.75,266,1589212800"; d="scan'208";a="141981015"
Received: from mail-bn8nam12lp2173.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.173])
 by ob1.hgst.iphmx.com with ESMTP; 22 Jun 2020 20:34:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VtXU1sv2o5iNgTMZBTi/G7iuOX1CBpwcKkE0LVV+E3wO4DVAl//uE3wJKCM0I2NDdZMusJ5cZUzrnUGrTSo02Z5d7hB7BKz0vSAMiyqLUOGVe7j4xZlKcO5jq4GPFiODZ3n2iSDGxWqMlY+o3jrnO+g7mrUNCBfy9Mi1nvtCIHoGVqnQOq8ZoOIuSvZ3AAY8b66SOzP8fPWO1KqHoghwKtRAp0bDLrwediW3uTqPVFrjDeFxCDUmyperMWfZoIuKQHQFk+VmjpdRr1Sy/oYaJcgO0JvBDYjayweCN0+qgVVd5DkNEZfvXq45NPpu1leSngVm6dv98d5UrYGtvbeR1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2cSR5g1tWwgu1Lu5DWIe1G+io1NC2XEowYDaePPXgQ=;
 b=YAdWlz8SG8nyWgtDmgFeGUPoM5tmtsePjCOV85Y9QgE9in5Fgk0Ff2CJH6vtDVrgD2K1Di0To7sW/A+W6ai/+nKoGUr2e8OlRemSuYyEzW184XIdRtShtqz7Tav03IE04UfdUAOckIjj33pyVJ6L18eEDiIApSQ1XSsohHY36gAKES/kHxBnYkybvffNERhcC9f2GYEaf1Ro9moHAfCpXwMB4KeeSGWrhIaPZbYjSbdlV+xBeOEF6GYzpeR9jnQmgGA46KTrnSaZFLLnzRP88oX+p2DEVkc+ZgHJ2kgZpgxxWM25NcmvC8GS206oOOkDUjJYbfp4m0boIl+rWL7FVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2cSR5g1tWwgu1Lu5DWIe1G+io1NC2XEowYDaePPXgQ=;
 b=MQ1HTmdIUErM4FUe94OFEHDkVmJEj3+ZzXYC+k0VVzGI3T6VtudQD6hXdKr5+hLPeupwKe7GNnvORM9hDMOrSvn+oLMWb+GlGXEm8QYHbnGcIYqLAkPGEhd74BcVHY+XwsmocehCVjXTiSPjrZT/tRdA62+rfKaGKA+DO24yjso=
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB4460.namprd04.prod.outlook.com (2603:10b6:5:26::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Mon, 22 Jun
 2020 12:34:30 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::e0a4:aa82:1847:dea5]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::e0a4:aa82:1847:dea5%7]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 12:34:30 +0000
From: Anup Patel <Anup.Patel@wdc.com>
To: Bin Meng <bmeng.cn@gmail.com>
Subject: RE: [PATCH v2 0/7] riscv: Switch to use generic platform of opensbi
 bios images
Thread-Topic: [PATCH v2 0/7] riscv: Switch to use generic platform of opensbi
 bios images
Thread-Index: AQHWSF8bvVpcQ8q0fEm5PQ775A0UKqjkaUTQgAAi4YCAAAF0AIAAApyAgAABGWA=
Date: Mon, 22 Jun 2020 12:34:30 +0000
Message-ID: <DM6PR04MB6201F12B168C4B0CE45909D78D970@DM6PR04MB6201.namprd04.prod.outlook.com>
References: <1592807604-20805-1-git-send-email-bmeng.cn@gmail.com>
 <DM6PR04MB620142B152292DD3945E4D3C8D970@DM6PR04MB6201.namprd04.prod.outlook.com>
 <CAEUhbmVhHKy70dA5dyQCiWeYk1nbhXHnZH8JBxmRJP6EUb2z9g@mail.gmail.com>
 <DM6PR04MB62013393F37DC653A1D3F1B28D970@DM6PR04MB6201.namprd04.prod.outlook.com>
 <CAEUhbmUQKv9tJfCeWYnO59AoqOHah8J6T0g2zVBnujmSdYtAfg@mail.gmail.com>
In-Reply-To: <CAEUhbmUQKv9tJfCeWYnO59AoqOHah8J6T0g2zVBnujmSdYtAfg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [103.56.182.118]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bf7aae4a-de06-481b-b923-08d816a89c57
x-ms-traffictypediagnostic: DM6PR04MB4460:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB446050E47963F7EA9E1388B18D970@DM6PR04MB4460.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0442E569BC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6kImC1oq66DVlaZE1JyNlEzNVNCZLUoZi6Hgfh6cCmdZ3idd7ANTSBqN1PekcVGEge5Ya5axH0FqsYnA7u4NMn0FySWq7Wyli7gPF1HwzLXbj/1GXosH6XfC6aUUXxuE7V4OfjQa+k77iOH859EtFjCPShxxqOr+im4HS3kbS+1IReUuzbd9eZ5DNZYq0t8+CosDklnXrKOVsCFnAaW4t5TH+D3F/TGAXOwoCbUo77pB24SH6aG70s3y/Jhi0BpRstbeMJSGUilEPciXGYoYLBtPNSr3XpDKhjmboMdcv57V+ByU8/O2pxiUyYvhrdBAVPKVipJ8aQKdcn4HHWjLZP/j4+f9xfrH1pwWjOiGmkbsuS4f+Fji56DKwOBerPwwK8NJSiI05G3v1lfoNuqIrM6UtAHlte4PGeGdru4f0egjJ99vt5s+F2mfkbnQ4Coi+w4XiJYi99s94MEprR7sfw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6201.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(66556008)(64756008)(66446008)(66476007)(6506007)(6916009)(4326008)(53546011)(66946007)(5660300002)(54906003)(76116006)(33656002)(26005)(52536014)(186003)(316002)(966005)(86362001)(9686003)(478600001)(7696005)(83380400001)(2906002)(8936002)(71200400001)(55016002)(8676002)(41533002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 5SptryhQBFxm1YyXHM6zeKykA01VDFajOvTBoarKfsh8Lb3Tyz7s5cDk2DbLpuBSAGNjQqhXpA4+yF9qKV8rdl30gsAYiEmzVTaUHaWp2+239b42cTI6t/hj4QeQihSV1NXjVphzAWfvmPMGWFld4d+XkiKz1REUtmA8uCkQBdat2rTf8UXx/nkAnjRLw3+q1VtPN0oj3ilvIfPkbrildcZ+jJQUwNDknOtH0/G8w1CFNwCSfeI5Td9mJrFy0BP6y0V7SD8Y4KEBjfmcZ8SR41FUo1pctykbSgGuYStFLpLcYrraosQWDCjOo5N1+Rv0dq/1HEK7aXFlL4/xPRihdOZyZeKanI5u5U6TH61wl6IlSReHKJuYehOGzlcu3NMaAzmvp5kP8dCmQS/cE1iEoah/kDh5As+3l7ah3y3NVcth55TEOeEslGEDdchcu7IJG9pnnm3ZD6MhKExLs0IrhbWMks9yfVhd9xJIdst0RzglWFYC+PbLnLxaRYcixF3P
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf7aae4a-de06-481b-b923-08d816a89c57
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2020 12:34:30.5866 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KtqeH6GJEKB/FSyX+WYQh3rr3cVE5US+CEoyzZ0ESiggSjJcXI0wf4ogdPPao4w3vvmUISkNM139tQrf6xkEoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4460
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=435c605ae=Anup.Patel@wdc.com; helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 08:34:33
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
Cc: Bin Meng <bin.meng@windriver.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, Anup Patel <anup@brainfault.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmluIE1lbmcgPGJtZW5n
LmNuQGdtYWlsLmNvbT4NCj4gU2VudDogMjIgSnVuZSAyMDIwIDE3OjU3DQo+IFRvOiBBbnVwIFBh
dGVsIDxBbnVwLlBhdGVsQHdkYy5jb20+DQo+IENjOiBBbGlzdGFpciBGcmFuY2lzIDxBbGlzdGFp
ci5GcmFuY2lzQHdkYy5jb20+OyBCYXN0aWFuIEtvcHBlbG1hbm4NCj4gPGtiYXN0aWFuQG1haWwu
dW5pLXBhZGVyYm9ybi5kZT47IFBhbG1lciBEYWJiZWx0DQo+IDxwYWxtZXJkYWJiZWx0QGdvb2ds
ZS5jb20+OyBTYWdhciBLYXJhbmRpa2FyDQo+IDxzYWdhcmtAZWVjcy5iZXJrZWxleS5lZHU+OyBx
ZW11LWRldmVsQG5vbmdudS5vcmc7IHFlbXUtDQo+IHJpc2N2QG5vbmdudS5vcmc7IEFudXAgUGF0
ZWwgPGFudXBAYnJhaW5mYXVsdC5vcmc+OyBCaW4gTWVuZw0KPiA8YmluLm1lbmdAd2luZHJpdmVy
LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAwLzddIHJpc2N2OiBTd2l0Y2ggdG8gdXNl
IGdlbmVyaWMgcGxhdGZvcm0gb2Ygb3BlbnNiaQ0KPiBiaW9zIGltYWdlcw0KPiANCj4gSGkgQW51
cCwNCj4gDQo+IE9uIE1vbiwgSnVuIDIyLCAyMDIwIGF0IDg6MjAgUE0gQW51cCBQYXRlbCA8QW51
cC5QYXRlbEB3ZGMuY29tPiB3cm90ZToNCj4gPg0KPiA+DQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBCaW4gTWVuZyA8Ym1lbmcuY25AZ21haWwuY29t
Pg0KPiA+ID4gU2VudDogMjIgSnVuZSAyMDIwIDE3OjQzDQo+ID4gPiBUbzogQW51cCBQYXRlbCA8
QW51cC5QYXRlbEB3ZGMuY29tPg0KPiA+ID4gQ2M6IEFsaXN0YWlyIEZyYW5jaXMgPEFsaXN0YWly
LkZyYW5jaXNAd2RjLmNvbT47IEJhc3RpYW4gS29wcGVsbWFubg0KPiA+ID4gPGtiYXN0aWFuQG1h
aWwudW5pLXBhZGVyYm9ybi5kZT47IFBhbG1lciBEYWJiZWx0DQo+ID4gPiA8cGFsbWVyZGFiYmVs
dEBnb29nbGUuY29tPjsgU2FnYXIgS2FyYW5kaWthcg0KPiA+ID4gPHNhZ2Fya0BlZWNzLmJlcmtl
bGV5LmVkdT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsgcWVtdS0NCj4gPiA+IHJpc2N2QG5vbmdu
dS5vcmc7IEFudXAgUGF0ZWwgPGFudXBAYnJhaW5mYXVsdC5vcmc+OyBCaW4gTWVuZw0KPiA+ID4g
PGJpbi5tZW5nQHdpbmRyaXZlci5jb20+DQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDAv
N10gcmlzY3Y6IFN3aXRjaCB0byB1c2UgZ2VuZXJpYyBwbGF0Zm9ybSBvZg0KPiA+ID4gb3BlbnNi
aSBiaW9zIGltYWdlcw0KPiA+ID4NCj4gPiA+IEhpIEFudXAsDQo+ID4gPg0KPiA+ID4gT24gTW9u
LCBKdW4gMjIsIDIwMjAgYXQgNjowOSBQTSBBbnVwIFBhdGVsIDxBbnVwLlBhdGVsQHdkYy5jb20+
DQo+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiA+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiA+ID4gRnJvbTogUWVtdS1yaXNjdiA8cWVtdS1yaXNj
di0NCj4gPiA+ID4gPiBib3VuY2VzK2FudXAucGF0ZWw9d2RjLmNvbUBub25nbnUub3JnPiBPbiBC
ZWhhbGYgT2YgQmluIE1lbmcNCj4gPiA+ID4gPiBTZW50OiAyMiBKdW5lIDIwMjAgMTI6MDMNCj4g
PiA+ID4gPiBUbzogQWxpc3RhaXIgRnJhbmNpcyA8QWxpc3RhaXIuRnJhbmNpc0B3ZGMuY29tPjsg
QmFzdGlhbg0KPiA+ID4gPiA+IEtvcHBlbG1hbm4gPGtiYXN0aWFuQG1haWwudW5pLXBhZGVyYm9y
bi5kZT47IFBhbG1lciBEYWJiZWx0DQo+ID4gPiA+ID4gPHBhbG1lcmRhYmJlbHRAZ29vZ2xlLmNv
bT47IFNhZ2FyIEthcmFuZGlrYXINCj4gPiA+ID4gPiA8c2FnYXJrQGVlY3MuYmVya2VsZXkuZWR1
PjsgcWVtdS1kZXZlbEBub25nbnUub3JnOyBxZW11LQ0KPiA+ID4gPiA+IHJpc2N2QG5vbmdudS5v
cmcNCj4gPiA+ID4gPiBDYzogQW51cCBQYXRlbCA8YW51cEBicmFpbmZhdWx0Lm9yZz47IEJpbiBN
ZW5nDQo+ID4gPiA+ID4gPGJpbi5tZW5nQHdpbmRyaXZlci5jb20+DQo+ID4gPiA+ID4gU3ViamVj
dDogW1BBVENIIHYyIDAvN10gcmlzY3Y6IFN3aXRjaCB0byB1c2UgZ2VuZXJpYyBwbGF0Zm9ybSBv
Zg0KPiA+ID4gPiA+IG9wZW5zYmkgYmlvcyBpbWFnZXMNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEZy
b206IEJpbiBNZW5nIDxiaW4ubWVuZ0B3aW5kcml2ZXIuY29tPg0KPiA+ID4gPiA+DQo+ID4gPiA+
ID4gVGhlIFJJU0MtViBnZW5lcmljIHBsYXRmb3JtIGlzIGEgZmxhdHRlbmVkIGRldmljZSB0cmVl
IChGRFQpDQo+ID4gPiA+ID4gYmFzZWQgcGxhdGZvcm0gd2hlcmUgYWxsIHBsYXRmb3JtIHNwZWNp
ZmljIGZ1bmN0aW9uYWxpdHkgaXMNCj4gPiA+ID4gPiBwcm92aWRlZCBiYXNlZCBvbiBGRFQgcGFz
c2VkIGJ5IHByZXZpb3VzIGJvb3Rpbmcgc3RhZ2UuIFRoZQ0KPiA+ID4gPiA+IHN1cHBvcnQgd2Fz
IGFkZGVkIGluIHRoZSB1cHN0cmVhbSBPcGVuU0JJDQo+ID4gPiA+ID4gdjAuOCByZWxlYXNlIHJl
Y2VudGx5Lg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gVGhpcyBzZXJpZXMgdXBkYXRlcyBRRU1VIHRv
IHN3aXRjaCB0byB1c2UgZ2VuZXJpYyBwbGF0Zm9ybSBvZg0KPiA+ID4gPiA+IG9wZW5zYmkgYmlv
cyBpbWFnZXMuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBUaGUgcGF0Y2ggZW1haWxzIGRvIG5vdCBj
b250YWluIGJpbmFyeSBiaXRzLCBwbGVhc2UgZ3JhYiBhbGwNCj4gPiA+ID4gPiB1cGRhdGVzIGF0
IGh0dHBzOi8vZ2l0aHViLmNvbS9sYm1lbmcvcWVtdS5naXQgYmlvcyBicmFuY2guDQo+ID4gPiA+
DQo+ID4gPiA+IEl0IHdpbGwgYmUgbmljZSB0byBoYXZlIHRoaXMgc2VyaWVzIHVwZGF0ZWQgdG8g
Zm9yIGZ3X2R5bmFtaWMuYmluIC4NCj4gPiA+DQo+ID4gPiBEbyB5b3UgbWVhbiB3ZSBpbmNsdWRl
IGZ3X2R5bmFtaWMuYmluIGZvciB2aXJ0ICYgc2lmaXZlX3UsIGFuZA0KPiA+ID4gZndfZHluYW1p
Yy5lbGYgZm9yIHNwaWtlPw0KPiA+ID4NCj4gPiA+IEJ1dCBwcmV2aW91c2x5IHdlIGFncmVlZCB0
byBpbmNsdWRlIG9ubHkgZ2VuZXJpYyBwbGF0Zm9ybSBCSU4gYW5kIEVMRg0KPiBmaWxlcy4NCj4g
PiA+IFNlZQ0KPiA+ID4gaHR0cHM6Ly9saXN0cy5nbnUub3JnL2FyY2hpdmUvaHRtbC9xZW11LWRl
dmVsLzIwMjAtMDUvbXNnMDA2NjQuaHRtbA0KPiA+DQo+ID4gSSBhbSBzdWdnZXN0aW5nIHRvIHVz
ZSBHZW5lcmljIHBsYXRmb3JtIGZ3X2R5bmFtaWMuYmluIGFuZA0KPiA+IGZ3X2R5bmFtaWMuZWxm
IGZvciBRRU1VIHZpcnQsIFFFTVUgc3Bpa2UsIGFuZCBRRU1VIHNpZml2ZV91IG1hY2hpbmVzLg0K
PiANCj4gRG8geW91IG1lYW4gd2UgcmVwbGFjZSBmd19qdW1wLmJpbiB3aXRoIGZ3X2R5bmFtaWMu
YmluIGluIFFFTVU/IElmDQo+IGV2ZXJ5b25lIGFncmVlcyB0aGlzIGlzIHRoZSB3YXkgdG8gZ28s
IEkgY2FuIHJlYmFzZSB0aGlzIHNlcmllcyBvbiB0b3Agb2YNCj4gQXRpc2gncyBmd19keW5hbWlj
LmJpbiBzdXBwb3J0IHNlcmllcy4NCg0KWWVzLCByZXBsYWNlIGZ3X2p1bXAuYmluIHdpdGggZndf
ZHluYW1pYy5iaW4gaW4gUUVNVS4gSXQgd2lsbCBkZWZpbml0ZWx5DQpiZW5lZml0IGxhcmdlIGtl
cm5lbCBpbWFnZXMgKHN1Y2ggYXMgRnJlZUJTRCBrZXJuZWwpIGFuZCBpdCBhbGxvdyBRRU1VIHRv
DQpkZWNpZGUgdGhlIEZEVCBwbGFjZW1lbnQgaW4gRFJBTS4NCg0KUmVnYXJkcywNCkFudXANCg==

