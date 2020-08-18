Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9EBC433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 13:11:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 572FD20706
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 13:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="nXp9mz48";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="qZlEA9+O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 572FD20706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k81OW-0002HG-Hw
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 09:11:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44234)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Cyril.Jean@microchip.com>)
 id 1k81NU-00014y-Mz; Tue, 18 Aug 2020 09:10:12 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:54901)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Cyril.Jean@microchip.com>)
 id 1k81NJ-0007zH-Ai; Tue, 18 Aug 2020 09:10:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1597756201; x=1629292201;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=9rndCP+t+rc7uoJFdbnJpFHUvXiBqVXZzcuPE5uNr90=;
 b=nXp9mz48Kqu0dUgxBeCcp39P2hXaGiYRjniLz/iZxrxpjOWazA8z7LED
 6Z3pVF2ndeITmExeo33V4lXzgdcwqGtGbGIKpETprCsi+mr2kTOtqTpIe
 j98ff7cpL/Ur8hI+Sgrf7GDTuisdDhl4TiBWZnVshUrLdrxYarVxgjkRZ
 0X0+M9uSyGHpD0aDkBBmDZMGYOOzZrpB9sms9tHiPHwDFy3o5GNg3KyW1
 Am2XUL28C2PtDAVM4yipo3RNP+c+vFI6QpqPB/CegmaxYLP36LqpTZ4cW
 Uqbbd4W9ymHHZPndXeW1ugPk9xcekYYIas4ZKj+WI7fNC75IdhnY56C+t A==;
IronPort-SDR: RoYFC3MUU+nHHOPhwf3Fiip7lXqrGTMPNNeL4pLa/yTao2OpkIqvcaPxZGyj/Na/pOyO99HkJ3
 cD7SMB7lzbM/kZQSMh4srTfiSWO5w2nURA59I/QK628KyP1ix0JxDpAD8DjmjEkZb0lHMtjdoW
 e1GRUxUIDKH+RqpP8jbZ5rjIrucP1Cu05WqVkbdjIGrusbB485ZQwhpikws4tmIGGM/3HR02QK
 bV7EFQl460fWs3VLTLXSx0Z9JBXfPDfAiljiNnnt6ivgi2lZ1m8v7aJuGo6NMNYi68dPKFsHne
 IJg=
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; d="scan'208";a="88445125"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256;
 18 Aug 2020 06:09:55 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 18 Aug 2020 06:09:06 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Tue, 18 Aug 2020 06:09:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G85OmsZSGn/pc3a0mZGwY4lAUxNomgQhPhXb2/2zf1gmCsNyuaSfPPULG4gvlhDNhbXNd5sGXRVdulYo2VQZ0FNHPDxDJw6sr6neSe/jHNMv8iL7/aFz1Ce8R9ZfIlOKI7P8YEyxSgRYqjkRgLRo9DKpT2YtdyZySfoH+M6MYc9t0x+VdIIrx1eKzA1YVKsd4Al99RM0ARNh1sgnQ8VYgZrNycbZxNXAofAodFZe3AZPA1RHukJItfV1jpL0dZoQylUANIJ60d4/16vjEsSb210QmwX5xVJDmu4adhVX/5qWiK74eISxn+H8sD28whX1gZfKaOSnuIHRRJViDEGvAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rndCP+t+rc7uoJFdbnJpFHUvXiBqVXZzcuPE5uNr90=;
 b=fWZAoCLMHqu8pXV6jgJLYqay8rJ0CPNqg70CqQG9R3qEE+FaXpWlUyz8bvHKj5IDrN8KeVG41whC+LY9SbF6yxCMgf3CXYuBqL5kJ0Ad3BBbPog/DDk3U5q4jeSKx6i/gC89uyXRXlTuLRkNNNVK/Nt/PpS7UUx0yFlIBAwNegiMSR//+nkTInXpWRTsCEBEcjvw1o+Ck6aXZLfQaCJakBCLnlXNMMaxIHiXkFlRJFMiDYKZngO6ay73ku65DhzvoP/xNiAab6/mFpiaj8gdJev0QK64dK61xK+WkEis49Toy06tRBtEasclDiSjl7l0jmD+eL2Fj+i+Jm0n7ofxuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rndCP+t+rc7uoJFdbnJpFHUvXiBqVXZzcuPE5uNr90=;
 b=qZlEA9+Ovs6AafSpk4YkJsxlTFzcK8ppTeQRqX0HgmjlZy1tapyd/LcKYjDptS1Rk373MOh8YYb7AlvaL/cyknINZ91kwS+by0/nIqGmufkTm/NGgRwu2czsWs4xi+Lxw+K9uvEbf3Fwa09ncAg7dEgxRZuDrDt/KTbZMQy1bJw=
Received: from DM6PR11MB3690.namprd11.prod.outlook.com (2603:10b6:5:13d::32)
 by DM5PR1101MB2249.namprd11.prod.outlook.com (2603:10b6:4:5a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.20; Tue, 18 Aug
 2020 13:09:52 +0000
Received: from DM6PR11MB3690.namprd11.prod.outlook.com
 ([fe80::e0ca:f0fd:7675:46d7]) by DM6PR11MB3690.namprd11.prod.outlook.com
 ([fe80::e0ca:f0fd:7675:46d7%4]) with mapi id 15.20.3283.027; Tue, 18 Aug 2020
 13:09:52 +0000
To: <anup@brainfault.org>
CC: <alistair23@gmail.com>, <bmeng.cn@gmail.com>, <Alistair.Francis@wdc.com>, 
 <kbastian@mail.uni-paderborn.de>, <palmerdabbelt@google.com>,
 <sagark@eecs.berkeley.edu>, <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>, 
 <peter.maydell@linaro.org>, <alistair@alistair23.me>,
 <qemu-block@nongnu.org>, <jasowang@redhat.com>, <bin.meng@windriver.com>,
 <pbonzini@redhat.com>, <palmer@dabbelt.com>, <qemu-arm@nongnu.org>,
 <marcandre.lureau@redhat.com>, <edgar.iglesias@gmail.com>,
 <philmd@redhat.com>
Subject: Re: [PATCH 00/18] hw/riscv: Add Microchip PolarFire SoC Icicle Kit
 board support
Thread-Topic: [PATCH 00/18] hw/riscv: Add Microchip PolarFire SoC Icicle Kit
 board support
Thread-Index: AQHWdIGDfQ2ADX3iMkmaUQkzVWiMJKk8cXaAgAA+ugCAAAcHgIAArjWAgABzR4A=
Date: Tue, 18 Aug 2020 13:09:52 +0000
Message-ID: <1f17cc4c-83f8-a024-ebef-79e28fab9a32@microchip.com>
References: <1597423256-14847-1-git-send-email-bmeng.cn@gmail.com>
 <CAAhSdy2D=TcENAJDja4r6pnhz0LRi-T+A9k3Btrs_EuB4x0e4w@mail.gmail.com>
 <CAEUhbmV5=B5xKhYqMj1MQb61nt5cNUJG1MXT++C1w1YMYTfLCQ@mail.gmail.com>
 <202949f7-c9d5-4d4d-3ebe-53727f4fa169@microchip.com>
 <CAKmqyKM3nm0rhxgDvWKWfO+4b23ZLSkHW2TzmcVZ_ZFy4L7MRg@mail.gmail.com>
 <d3f61c2c-a489-887e-0143-4d9a1e66e6f2@microchip.com>
 <CAAhSdy32owLO0KytyYsg-zH6JyyfNfGofa4vanqTFJLntPq0=g@mail.gmail.com>
In-Reply-To: <CAAhSdy32owLO0KytyYsg-zH6JyyfNfGofa4vanqTFJLntPq0=g@mail.gmail.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: brainfault.org; dkim=none (message not signed)
 header.d=none;brainfault.org; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [86.40.244.225]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 418b860f-0bed-4979-61d3-08d84377fe7b
x-ms-traffictypediagnostic: DM5PR1101MB2249:
x-microsoft-antispam-prvs: <DM5PR1101MB2249893C282B4E0FD439E8B99E5C0@DM5PR1101MB2249.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dttwt1oEbXtq8ze4vqEjEoG+noDFi2/x9bJDGe5xynU8ljO5WiWTsuO2Qp7rbafYtBW/qdzcv56KtdivQCJekVmRyKmuvHupv4gOPE9vGSQ5pb198rXrr/xZgr4QFdIpoIBg9AVWJwywfzNpemvtenJDh9Ks20yw7s2JP54TLnG5TdlNyRsqyAQtCRSFUS+am0dEpfgeaoIqWtWtExeyKFk6ZxFC5hBULPOWFeFw4eN1bX5D34Gba9+OV4nPAOZe75pmQ2hdiIkXAf2COEmVlOFOQbPTag4+yMFoOFaaBoxp7kaAlf2d6HlL8gkXlFny2SBM2vVSeSEq26TnxOs3LA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR11MB3690.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(498600001)(66476007)(5660300002)(8936002)(6916009)(86362001)(66946007)(76116006)(71200400001)(91956017)(4326008)(83380400001)(8676002)(31686004)(36756003)(2906002)(53546011)(6506007)(31696002)(54906003)(7416002)(2616005)(6486002)(64756008)(66556008)(66446008)(26005)(186003)(6512007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: x1vbcRjwLCDlcQazTNABCbeH6rwz9e/+aeT1FTVX1L+6CQWx/k99koqvpr/dsXYZKBOndygj2k8kOC+L75eNW9ssqRDZQ+ldrP3WaPhJV0n3AjDMeFZZsl8ayngEwrDWOxN8oFNEKlFXJ7OpFVmLo7vxE+IsYmkWsWizQsW8htm28bpgUjfpiDFlqa1sP/HS9FCiTIKNzdBjbihEqg8fevLX97PQbijaHXL2WXpGvvV3B83GaWMBIe4VMHCRjVajh11AzQX5fGnuxxgWgC4zk5Ij+JKVGIFcwlfol5fiIQ9vi5WpQQlmWBirlmHVlEyjsejcz8l4wIF8nemCKKHCBpx0gSIZxQn7vBZKvE0Z69jYwJLoBjq0NhXXxXbUCtyKyr9Y/+fIBueUmhXULM1DfDyc/oDGKnbEwGQaYLdyCx5RGl2ke1jyq+rsnUPyyZqDn3C4ciApdo6Gx2ZHyeJPGcGYbpYmeqr9O2HUhatk2TOLcLOrFAFu97V/9BhwICPZInKFda2k/wEZWZeCywbUnrjXXgnYD0SfmX8PssAuj4Rheg2TNPDBGnyLbOclbr3NnrbuNW+ZqAe8k2IPfICf8pf84zVSsoEQeFf1b8Iimggx8wHhEWGeap2b8rt36FFdiHLqy0Q5k9Y8crQ4NvMaPw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <03E618FC1A83EB45A03757FFB0592C20@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3690.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 418b860f-0bed-4979-61d3-08d84377fe7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2020 13:09:52.1743 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FkcoSDvmKQKlaEzrk9E/FDyJ3au2vFj+HQHowbHTidzpJm6xFqa97P19Xai37GVxkdy0NbGUoRPcOIsdcWQTOcd1VblEEmqBoMgX3Bolw8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2249
Received-SPF: pass client-ip=68.232.153.233;
 envelope-from=Cyril.Jean@microchip.com; helo=esa3.microchip.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 09:09:56
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: <Cyril.Jean@microchip.com>
From:  via <qemu-devel@nongnu.org>

T24gOC8xOC8yMCA3OjE3IEFNLCBBbnVwIFBhdGVsIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDog
RG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRo
ZSBjb250ZW50IGlzIHNhZmUNCj4NCj4gT24gVHVlLCBBdWcgMTgsIDIwMjAgYXQgMToyMyBBTSA8
Q3lyaWwuSmVhbkBtaWNyb2NoaXAuY29tPiB3cm90ZToNCj4+IE9uIDgvMTcvMjAgODoyOCBQTSwg
QWxpc3RhaXIgRnJhbmNpcyB3cm90ZToNCj4+PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNr
IGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlz
IHNhZmUNCj4+Pg0KPj4+IE9uIE1vbiwgQXVnIDE3LCAyMDIwIGF0IDExOjEyIEFNIHZpYSA8cWVt
dS1kZXZlbEBub25nbnUub3JnPiB3cm90ZToNCj4+Pj4gSGkgQW51cCwNCj4+Pj4NCj4+Pj4gT24g
OC8xNy8yMCAxMTozMCBBTSwgQmluIE1lbmcgd3JvdGU6DQo+Pj4+PiBFWFRFUk5BTCBFTUFJTDog
RG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRo
ZSBjb250ZW50IGlzIHNhZmUNCj4+Pj4+DQo+Pj4+PiBIaSBBbnVwLA0KPj4+Pj4NCj4+Pj4+IE9u
IFNhdCwgQXVnIDE1LCAyMDIwIGF0IDE6NDQgQU0gQW51cCBQYXRlbCA8YW51cEBicmFpbmZhdWx0
Lm9yZz4gd3JvdGU6DQo+Pj4+Pj4gT24gRnJpLCBBdWcgMTQsIDIwMjAgYXQgMTA6MTIgUE0gQmlu
IE1lbmcgPGJtZW5nLmNuQGdtYWlsLmNvbT4gd3JvdGU6DQo+Pj4+Pj4+IEZyb206IEJpbiBNZW5n
IDxiaW4ubWVuZ0B3aW5kcml2ZXIuY29tPg0KPj4+Pj4+Pg0KPj4+Pj4+PiBUaGlzIGFkZHMgc3Vw
cG9ydCBmb3IgTWljcm9jaGlwIFBvbGFyRmlyZSBTb0MgSWNpY2xlIEtpdCBib2FyZC4NCj4+Pj4+
Pj4gVGhlIEljaWNsZSBLaXQgYm9hcmQgaW50ZWdyYXRlcyBhIFBvbGFyRmlyZSBTb0MsIHdpdGgg
b25lIFNpRml2ZSdzDQo+Pj4+Pj4+IEU1MSBwbHVzIGZvdXIgVTU0IGNvcmVzIGFuZCBtYW55IG9u
LWNoaXAgcGVyaXBoZXJhbHMgYW5kIGFuIEZQR0EuDQo+Pj4+Pj4gTmljZSBXb3JrICEhISBUaGlz
IGlzIHZlcnkgaGVscGZ1bC4NCj4+Pj4+IFRoYW5rcyENCj4+Pj4+DQo+Pj4+Pj4gVGhlIE1pY3Jv
Y2hpcCBIU1MgaXMgcXVpdGUgY29udm9sdXRlZC4gSXQgaGFzOg0KPj4+Pj4+IDEuIEREUiBJbml0
DQo+Pj4+Pj4gMi4gQm9vdCBkZXZpY2Ugc3VwcG9ydA0KPj4+Pj4+IDMuIFNCSSBzdXBwb3J0IHVz
aW5nIE9wZW5TQkkgYXMgbGlicmFyeQ0KPj4+Pj4+IDQuIFNpbXBsZSBURUUgc3VwcG9ydA0KPj4+
Pj4+DQo+Pj4+Pj4gSSB0aGluayBwb2ludCAxKSBhbmQgMikgYWJvdmUgc2hvdWxkIGJlIHBhcnQg
b2YgVS1Cb290IFNQTC4NCj4+Pj4+PiBUaGUgcG9pbnQgMykgY2FuIGJlIE9wZW5TQkkgRldfRFlO
QU1JQy4NCj4+Pj4+Pg0KPj4+Pj4+IExhc3RseSxmb3IgcG9pbnQgNCksIHdlIGFyZSB3b3JraW5n
IG9uIGEgbmV3IE9wZW5TQkkgZmVhdHVyZSB1c2luZw0KPj4+Pj4+IHdoaWNoIHdlIGNhbiBydW4g
aW5kZXBlbmRlbnQgU2VjdXJlIE9TIGFuZCBOb24tU2VjdXJlIE9TIHVzaW5nDQo+Pj4+Pj4gVS1C
b290X1NQTCtPcGVuU0JJIChmb3IgYm90aCBTaUZpdmUgVW5sZWFzaGVkIGFuZCBNaWNyb2NoaXAN
Cj4+Pj4+PiBQb2xhckZpcmUpLg0KPj4+Pj4+DQo+Pj4+Pj4gRG8geW91IGhhdmUgcGxhbnMgZm9y
IGFkZGluZyBVLUJvb3QgU1BMIHN1cHBvcnQgZm9yIHRoaXMgYm9hcmQgPz8NCj4+Pj4+ICsgQ3ly
aWwgSmVhbiBmcm9tIE1pY3JvY2hpcA0KPj4+Pj4NCj4+Pj4+IEkgd2lsbCBoYXZlIHRvIGxlYXZl
IHRoaXMgcXVlc3Rpb24gdG8gQ3lyaWwgdG8gY29tbWVudC4NCj4+Pj4+DQo+Pj4+IEkgY3VycmVu
dGx5IGRvIG5vdCBoYXZlIGEgcGxhbiB0byBzdXBwb3J0IFUtQm9vdCBTUEwuIFRoZSBpZGVhIG9m
IHRoZQ0KPj4+PiBIU1MgaXMgdG8gY29udGFpbiBhbGwgdGhlIHNpbGljb24gc3BlY2lmaWMgaW5p
dGlhbGl6YXRpb24gYW5kDQo+Pj4+IGNvbmZpZ3VyYXRpb24gY29kZSB3aXRoaW4gdGhlIEhTUyBi
ZWZvcmUganVtcGluZyB0byBVLUJvb3QgUy1tb2RlLiBJDQo+Pj4+IHdvdWxkIHJhdGhlciBrZWVw
IGFsbCB0aGlzIHdpdGhpbiB0aGUgSFNTIGZvciB0aGUgdGltZSBiZWluZy4gSSB3b3VsZA0KPj4+
PiB3YWl0IHVudGlsIHdlIHJlYWNoIHByb2R1Y3Rpb24gc2lsaWNvbiBiZWZvcmUgYXR0ZW1wdGlu
ZyB0byBtb3ZlIHRoaXMgdG8NCj4+Pj4gVS1Cb290IFNQTCBhcyB0aGUgSFNTIGlzIGxpa2VseSB0
byBjb250YWluIHNvbWUgb3BhcXVlIHNpbGljb24gcmVsYXRlZA0KPj4+PiBjaGFuZ2VzIGZvciBh
bm90aGVyIHdoaWxlLg0KPj4+IFRoYXQgaXMgdW5mb3J0dW5hdGUsIGEgbG90IG9mIHdvcmsgaGFz
IGdvbmUgaW50byBtYWtpbmcgdGhlIGJvb3QgZmxvdw0KPj4+IHNpbXBsZSBhbmQgZWFzeSB0byB1
c2UuDQo+Pj4NCj4+PiBRRU1VIG5vdyBpbmNsdWRlcyBPcGVuU0JJIGJ5IGRlZmF1bHQgdG8gbWFr
ZSBpdCBlYXN5IGZvciB1c2VycyB0byBib290DQo+Pj4gTGludXguIFRoZSBJY2ljbGUgS2l0IGJv
YXJkIGlzIG5vdyB0aGUgbW9zdCBkaWZmaWN1bHQgUUVNVSBib2FyZCB0bw0KPj4+IGJvb3QgTGlu
dXggb24uIE5vdCB0byBtZW50aW9uIGl0IG1ha2VzIGl0IGhhcmQgdG8gaW1wb3NzaWJsZSB0bw0K
Pj4+IHN1cHBvcnQgaXQgaW4gc3RhbmRhcmQgdG9vbCBmbG93cyBzdWNoIGFzIG1ldGEtcmlzY3Yu
DQo+Pj4NCj4+PiBBbGlzdGFpcg0KPj4gSWYgaXQgaXMgc3VjaCBhIHByb2JsZW0gd2UgY2FuIGFk
ZCBhIFUtQm9vdCBTUEwgc3RhZ2UgYW5kIHRoZSBIU1MgY2FuIGJlDQo+PiB0cmVhdGVkIGFzIHN0
YW5kYXJkIFNvQyBST00gY29kZS4NCj4gSXQncyBub3QgbWFuZGF0b3J5IGZvciBVLUJvb3QgU1BM
IHRvIGhhdmUgc3RhYmxlIERSQU0gY2FsaWJyYXRpb24gc2V0dGluZ3MNCj4gZnJvbSB0aGUgc3Rh
cnQgaXRzZWxmLiBUaGUgaW5pdGlhbCBVLUJvb3QgU1BMIHN1cHBvcnQgZm9yIG1vc3QNCj4gcGxh
dGZvcm1zIChhY2Nyb3NzDQo+IGFyY2hpdGVjdHVyZXMpIHVzdWFsbHkgaW5jbHVkZSBiYXNpYyB3
b3JraW5nIERSQU0gY2FsaWJyYXRpb24gc2V0dGluZ3Mgd2hpY2gNCj4gaXMgbGF0ZXIgb24gdXBk
YXRlZCB3aXRoIHNlcGFyYXRlIHBhdGNoZXMuIEFsc28sIHdlIGRvbid0IG5lZWQgYWxsIFUtQm9v
dA0KPiBkcml2ZXJzIHRvIGJlIHVwc3RyZWFtZWQgaW4gb25lLWdvIGFzIHRoaXMgY2FuIGJlIGRv
bmUgaW4gcGhhc2VzLg0KPg0KPiBUaGUgYWR2YW50YWdlIHdlIGhhdmUgd2l0aCBQb2xhckZpcmUg
U29DIEljaWNsZSBib2FyZCBpcyB0aGF0IHdlIGFscmVhZHkNCj4gaGF2ZSBhIFUtQm9vdCBTLW1v
ZGUuIGFuZCB3ZSBiZWxpZXZlIHRoZSBPcGVuU0JJIGdlbmVyaWMgcGxhdGZvcm0gd2lsbA0KPiB3
b3JrIGZpbmUgZm9yIFBvbGFyRmlyZSBTb0MgSWNpY2xlIGJvYXJkIHNvIHRoZSBvbmx5IHRoaW5n
IG1pc3NpbmcgcmlnaHQgbm93DQo+IGlzIHRoZSBVLUJvb3QgU1BMIHN1cHBvcnQgZm9yIE9wZW5T
b3VyY2UgYm9vdC1mbG93Lg0KPg0KPiBJdCB3aWxsIGNlcnRhaW5seSBhY2NlbGVyYXRlIG9wZW4t
c291cmNlIGRldmVsb3BtZW50IGlmIHdlIGhhdmUgYm9vdC1mbG93DQo+IFUtQm9vdF9TUEwgPT4g
T3BlblNCSSAoRldfRFlOQU1JQykgPT4gVS1Cb290X1MtbW9kZSB3b3JraW5nDQo+IG9uIFBvbGFy
RmlyZSBTb0MgSWNpY2xlIGJvYXJkLiBJbml0aWFsbHksIHdlIGp1c3QgbmVlZCBEUkFNLCBTRC9l
TU1DLA0KPiBhbmQgU2VyaWFsIHBvcnQgc3VwcG9ydCBmb3IgVS1Cb290IFNQTCBhbmQgVS1Cb290
IFMtbW9kZS4gTGF0ZXIgb24sDQo+IG1vcmUgcGF0Y2hlcyBjYW4gYWRkIGV0aGVybmV0IGFuZCBv
dGhlciBib290aW5nIGRldmljZSBkcml2ZXJzIHRvIFUtQm9vdC4NCj4NCj4gUmVnYXJkaW5nIHNl
Y3VyaXR5IHNlcnZpY2VzIG9mIEhTUywgd2UgYXJlIHdvcmtpbmcgb24gYSBPcGVuU0JJDQo+IGZl
YXR1cmUgd2hpY2ggd2lsbCBhbGxvdyBIU1Mgc2VjdXJpdHkgc2VydmljZXMgdG8gcnVuIGFzIGlu
ZGVwZW5kZW50DQo+IGJpbmFyeSBpbiBNLW1vZGUgKG5vdCBsaW5rZWQgdG8gT3BlblNCSSkgYW5k
IE9wZW5TQkkgRldfRFlOQU1JQw0KPiB3aWxsIGJlIGEgc2VwYXJhdGUgYmluYXJ5IGFjdGluZyBh
cyBhIHNlY3VyZSBtb25pdG9yLg0KPg0KPiBSZWdhcmRzLA0KPiBBbnVwDQoNCldoYXQgSSBoYXZl
IGluIG1pbmQgaXMgdGhhdCB0aGUgZXh0ZXJuYWwgbWVtb3J5IHdpbGwgYmUgdXAgYW5kIHJ1bm5p
bmcgDQpieSB0aGUgdGltZSB3ZSBnZXQgdG8gVS1Cb290IFNQTC4gSW4gdGhlIGNhc2Ugb2YgUG9s
YXJGaXJlIFNvQyB0aGUgUk9NIA0KY29kZSBlcXVpdmFsZW50IGJyaW5ncyB1cCB0aGUgRERSIG1l
bW9yeSBpbnRlcmZhY2Ugc28gd2UgZG8gbm90IG5lZWQgdG8gDQp3b3JyeSBhYm91dCB0aGlzIGFz
IHBhcnQgb2YgVS1Cb290Lg0KDQpTb3VuZHMgdG8gbWUgdGhlIGNvbXBvbmVudCB0aGF0IG5lZWRz
IHRvIGJlIHVwc3RyZWFtZWQgbmV4dCBpcyB0aGUgZU1NQyANCnN1cHBvcnQgc28gdGhhdCBpdCBj
YW4gYmUgdXNlZCBhcyBwYXJ0IG9mIFUtQm9vdCBTUEwuIENvcnJlY3Q/DQoNCg0KUmVnYXJkcywN
Cg0KQ3lyaWwuDQoNCg==

