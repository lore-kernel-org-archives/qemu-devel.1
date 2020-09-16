Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EBDC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 07:57:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D86322078D
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 07:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="ihF9DCa+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D86322078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kISJv-0000rC-Ui
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 03:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Qiang.Zhang@windriver.com>)
 id 1kISIc-0008BZ-9Y
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 03:56:18 -0400
Received: from mail-dm6nam11on2053.outbound.protection.outlook.com
 ([40.107.223.53]:24160 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Qiang.Zhang@windriver.com>)
 id 1kISIZ-0001vA-Hq
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 03:56:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LXvhNmfDPerLhbPMMHcGW7gefLoIPrOeqBBFyKyGp5fuLR/wo5zZrPxoBTVlJ/6fp8GDSbtJD5syAfF4Oqo0BBMwTugjgbBFoiGeGBuIlQSNE/JSzbPHz8uhiiO+p4jZPHFFYlCQWW9Mgu4vv70XhWopxpj1SprYqRRz/ZRsqOCoQrbXRIbCuhBrVxVeFRar3H4stljL3Z1H/OXNBXf8tlOqJioFQNwco/dpvwycNSS/oJ0BKUD+syjcXQX+ZQA4sIBrORNeisWg6Nq3nKWQ3i+QVcm0tcUeQW+1G/mVNLzUeI2D0nrsnCbRfPsIDyv1r4Qfl9iWKs7eTcdu169j4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1Q93ZlgWk8Q3IM/19ImBc4nUF9utGXHKcdnnaNAY5k=;
 b=crTh8jpEMUN1tmxxZDENpXqwjNi3ZAdcL0vbHLx+QHDZIMOrT3svmRD22RGhSevlciFBbxHt48Sfsv00CPH18MR+qC1lijUZmnIdj9cmcsXDNX9q1Xjng8AKAW4QmSi4vyGKMPJBCtd8471o2BrTlhzKTfxLp2TfXpDIw8enCLZQHKPxLWs+TKlelFHFKM89fWHgwCpTdUMpHKtRV7g8Eicrz+GGW9R0eiVOx7AbPqALrtPoGJwlGakm87ZYEHzUmJ78Z1vGihljRLhdy4tMd/72yIb4JuOUYd1hWIb3hLcJQTgtUFfQeWIizFlRi+sdje50sj2LqAGjPrcj68gJIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1Q93ZlgWk8Q3IM/19ImBc4nUF9utGXHKcdnnaNAY5k=;
 b=ihF9DCa+i5bPjj+DZYzN/mcztaDc2mZXm++RA80Vg7tDOBclU7yzwoQk8LH11A1TKnlRI3hixts1yr67olxxDmoKRuAni1IJydBoGsfLzBUGjn23zylR4f5sKC7NTOl6+/FcQiDqEXVgXcorEEnMi8hJRdcbnVxPhcHPyrcvaZA=
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BYAPR11MB3029.namprd11.prod.outlook.com (2603:10b6:a03:8e::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 16 Sep
 2020 07:41:08 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::21a8:8895:6487:5126]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::21a8:8895:6487:5126%6]) with mapi id 15.20.3370.019; Wed, 16 Sep 2020
 07:41:08 +0000
From: "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Question on  --enable-profile
Thread-Topic: Question on  --enable-profile
Thread-Index: AQHWgmbtVo7XOjJvO0q77Gf8e7/Nsalq9GdI
Date: Wed, 16 Sep 2020 07:41:08 +0000
Message-ID: <BYAPR11MB263280A038DAC16629CBBD18FF210@BYAPR11MB2632.namprd11.prod.outlook.com>
References: <BYAPR11MB2632A972EE36949C7CDF9DB9FF2D0@BYAPR11MB2632.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB2632A972EE36949C7CDF9DB9FF2D0@BYAPR11MB2632.namprd11.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9cc09657-3c94-4edc-c794-08d85a13e04c
x-ms-traffictypediagnostic: BYAPR11MB3029:
x-microsoft-antispam-prvs: <BYAPR11MB3029EB15E497E96E0AE6D5D3FF210@BYAPR11MB3029.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:324;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MLhgb9Pa6CXJV8FHHXWh3I2uwqPiUkc/SyECzSdOVLdaFzYKFgbdsiNkVj/FeuK1yem1cVrccoroyc4vR8Dc4d5gjNcaFOa8GVKOsdzaFkWzWU1d5VqsqZw08Vpdf3GZAXfvIYy5f5p0IQZTbhDr/ASEmNAD7+QgeYaSSlbAik4IbdM7479z2OeviK2Wq6Dx+sbcHVBOiKp7cWC1/QozHR6UkfmO0bqxSo1oyK/nTgyrXN9D/BOsfys9Bn4JzRp7T1l/D0lpy/Sw+rVb5rRfpyfLVJHXNM9dSmAJGT2XrZjrGDydc8Tn6cLRqPoI/Reh/lGGL+zPecvWcs1tAUtcDQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR11MB2632.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39850400004)(136003)(396003)(346002)(376002)(366004)(66476007)(478600001)(83380400001)(86362001)(2906002)(8936002)(7696005)(6916009)(316002)(91956017)(9686003)(66946007)(66446008)(66556008)(33656002)(71200400001)(26005)(186003)(76116006)(8676002)(6506007)(55016002)(52536014)(5660300002)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: tOzd8LyztafP26Gbs3fKFVo/Xh7PBr9k66BETORvY24OM0xVIlYsAWkH9RG6sooLwrIJeAqsVUTcDWEpWim78qwFAmHzN2MZeyCEtfgTCfzlTAb5Z/jZDte7HasTVxz90DBB63HDI3kx8Dd1jEGziggUp1QhtbrqbsiJvWIou9X7KOZ9pefrMJ1g0mw1yUj6tBA0w58zZNn8liEJIJcakbA3Bs/JoFKSws7G2fEf4GAhJiThUmij5Lw2PvzFadHkQSuk0H9Oy9V3+psBmbIZKF2Q4ON36Y/s6FnNFn7vc1XrOveBrH9WXcdwwBgRZvJfJtWgZ168UkBFH7aft3fcW1zw5d6QWB5oUP9L1dDUnZ54jyM8NG7wwA/T7218dEHJTKlN5V7kO8pxTptEENLMPu0ERfGLioB/5HhwuJy78L+CyYojc7jXgjDPOfVWmwo1c9fD68YPO55EBWUK4u18tBmMyiV2wGzVRaJwrE5uOJgKNtohKpggPDtUZ4GNBZMo8a+jUuhbAnRXqcuaA5q/8hRYuZwZDtuz1U49F/QkYfCxXDUmRTam2qHTkPHCZ8wGsoy6Bl5wddCkUNHjnFN/CF7ym3s31V1AuGDKr4JPNcR2P9pp9XyTylo0fPtkfX90vjt1mtYic2ZygYDZeysk7g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cc09657-3c94-4edc-c794-08d85a13e04c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2020 07:41:08.5452 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3xfOTf3DqpAeIx9R5z2f0N+fXkEpUQ5hXNuK+8qgY3qdewmbObPJTV05V/hrvTbDVSXiZfgniIVHv5oSTPKAB7MoNnVgasiey1M2va4UZ24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3029
Received-SPF: pass client-ip=40.107.223.53;
 envelope-from=Qiang.Zhang@windriver.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 03:56:13
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

CkkgaGF2ZSBzb21lIHF1ZXN0aW9ucyBmb3IgeW91LCAgd2hlbiBhZGQgIi0tZW5hYmxlLXByb2Zp
bGUiIG9wdGlvbnMgdG8gY29tcGlsZSBxZW11CnRoZXJlIGFyZSBzb21lIGVycm9yOgoKaW5jbHVk
ZS9xZW11L2NvbXBpbGVyLmg6OTM6MzY6IGVycm9yOiBzdGF0aWMgYXNzZXJ0aW9uIGZhaWxlZDog
Im5vdCBleHBlY3Rpbmc6IHNpemVvZigqJnMtPnByb2YuZGVsX29wX2NvdW50KSA+IEFUT01JQ19S
RUdfU0laRSIKICAgOTMgfCAjZGVmaW5lIFFFTVVfQlVJTERfQlVHX01TRyh4LCBtc2cpIF9TdGF0
aWNfYXNzZXJ0KCEoeCksIG1zZykKICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIF5+fn5+fn5+fn5+fn5+CgpxZW11IHY1LjEuMCwgIGNvbXBpbGVyIGlzIGk2ODYtd3Jz
LWxpbnV4LWdjYyB3aXRoIC1tMzIKSSBzZWUgZGVsX29wX2NvdW50IGlzIGludDY0X3QKCnR5cGVk
ZWYgc3RydWN0IFRDR1Byb2ZpbGUgewogICAgaW50NjRfdCBjcHVfZXhlY190aW1lOwogICAgaW50
NjRfdCB0Yl9jb3VudDE7CiAgICBpbnQ2NF90IHRiX2NvdW50OwogICAgaW50NjRfdCBvcF9jb3Vu
dDsgLyogdG90YWwgaW5zbiBjb3VudCAqLwogICAgaW50IG9wX2NvdW50X21heDsgLyogbWF4IGlu
c24gcGVyIFRCICovCiAgICBpbnQgdGVtcF9jb3VudF9tYXg7CiAgICBpbnQ2NF90IHRlbXBfY291
bnQ7CiAgICBpbnQ2NF90IGRlbF9vcF9jb3VudDsKICAgIGludDY0X3QgY29kZV9pbl9sZW47CiAg
ICBpbnQ2NF90IGNvZGVfb3V0X2xlbjsKICAgIGludDY0X3Qgc2VhcmNoX291dF9sZW47CiAgICBp
bnQ2NF90IGludGVybV90aW1lOwogICAgaW50NjRfdCBjb2RlX3RpbWU7CiAgICBpbnQ2NF90IGxh
X3RpbWU7CiAgICBpbnQ2NF90IG9wdF90aW1lOwogICAgaW50NjRfdCByZXN0b3JlX2NvdW50Owog
ICAgaW50NjRfdCByZXN0b3JlX3RpbWU7CiAgICBpbnQ2NF90IHRhYmxlX29wX2NvdW50W05CX09Q
U107Cn0gVENHUHJvZmlsZTsKCiNpZiBkZWZpbmVkKF9feDg2XzY0X18pIHx8IGRlZmluZWQoX19z
cGFyY19fKSB8fCBkZWZpbmVkKF9fbWlwczY0KQojIGRlZmluZSBBVE9NSUNfUkVHX1NJWkUgIDgK
I2Vsc2UKIyBkZWZpbmUgQVRPTUlDX1JFR19TSVpFICBzaXplb2Yodm9pZCAqKQojZW5kaWYKCndo
ZW4gSSBjb21waWxlIHdpdGggLW0zMiAgIHNpemVvZigqJnMtPnByb2YuZGVsX29wX2NvdW50KSA+
IEFUT01JQ19SRUdfU0laRSB0cmlnZ2VyIGVycm9yLgo=

