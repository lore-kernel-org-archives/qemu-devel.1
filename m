Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE13C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 19:54:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56A9C20658
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 19:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="l1o6eHSR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="NWw7bssk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56A9C20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7lDI-0000O2-GE
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 15:54:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Cyril.Jean@microchip.com>)
 id 1k7lCf-0008Ds-I2; Mon, 17 Aug 2020 15:53:57 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:53420)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Cyril.Jean@microchip.com>)
 id 1k7lCb-0005MJ-Od; Mon, 17 Aug 2020 15:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1597694035; x=1629230035;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=1cvPr/VPakVgquhfCH70EKkCqUYBFONRRhpQgq7voTY=;
 b=l1o6eHSRxCk2AkiboLdlRAsCFZtzSkCKRw1L/c8IhIzKO+6tyTVIyUYM
 VS9Vpu6DFtDVfXTsUJB5qnvHWvI831bdQDH9YI7+Rm0bdjKVJH1YY4vzb
 8kmlOCBojWXZqhYBIdDdUTwPhXIkYvo69SK5Bktk6KrJFilJ53xKFWMql
 5nC0Bkk1vof2SrXSRBwuSXt/n9LrvLdn1UYtNbTd5Iv4x4tjAsmeuPGxW
 dHMXT+tPfzkER4bd3nNdX6iOFSMbA3Fnel4ckIPW/wGsysFJzjritT+n9
 D8eDOzhe+KvhscCQIFuSAvJd7dRRDMjH9bmk3T011+j2pA3V2bG98VTOb Q==;
IronPort-SDR: O0hMvaluxUUn0BpRcofJfVT97V6bLTHLO72eCEbds4Lh4o8a1nLzurS94jDhoUUcxe0L551T3f
 zC7ia4n7AthUbU9D4ach/ugVzaslFwUGxN0U9Z4VHbNUegTtaMlaei7PtbZrmxbxRjIpkOdeYx
 ohynk+3uiWuQkZ2g+wiQKwFFpuy9G8K43y7+UPJmpmOG+q4iq+WrzWdJH3PPzWZVubAJizelT2
 gNsyhGWVlt2DMOInaroC/FVka4q1vREf4JkTsiTvRcep6+cLvynbnJ84D5NrIVaE5+vI7gBy6X
 bA8=
X-IronPort-AV: E=Sophos;i="5.76,324,1592895600"; d="scan'208";a="87456517"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256;
 17 Aug 2020 12:53:50 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 17 Aug 2020 12:53:43 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Mon, 17 Aug 2020 12:53:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NB+7M2z+DbCqAVX2csNBdNwc3T8OGPB1NbHZEpVqU/6WQJTodNIOIyrOVQsDv0mTKiPleBY/jE8hITC/cX3hrKEcSqNviHWJJM8F4M0p3jXEMEd+AduRlhaxfhZlAG7oY/SVyJZ1M2hZX5/BxpAdQJlUFwURyL9SXacaFEICvpbe6krijdW7iRK2we/wm4NmdNtlNi5NdC3P9JW93sY/+iiniQazlGaeuu3hcD7RWwNVuipJQCVgSvjkBqV3tQggWMj2PshE4hzmcNy1B9w7FdQCQsmlIXyB6427vQ5/jsU13V/6ZKQKKOBBb5BTl15iZro8If1u/Wf8+9VzQYRZHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cvPr/VPakVgquhfCH70EKkCqUYBFONRRhpQgq7voTY=;
 b=QyFnysAiEVl6peh+zAsScsKPf90Yt7wkDl6OlK2FRVxnuIBdpOC0xIGp5iuP8/gj2LnzzJ96ExgMENR4rkaOvmC9qw24Z6wY8UOkyh5ctrGs4y0iWAhKKiIA5n3yEmR1LBfGGaRmFIeRoGzU1d9PfvZbtPPWA1/2TXYyqqnX12McklJOAw0UW2t3A6wQXMT2FeTu64UG//zSzD/YuFHZ8hiaAFUoXl4I2KCQtMYsoVnS3Sw8DSgVurfL1/XfU5kdHAKAj6HXHmyg1hW1rcv5tz0JLDkDcNPWlfzWCIZsVaokaXBrSqWejxA3ctiB2QEdh8fh6+UxfjoDWvpBOC2SKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cvPr/VPakVgquhfCH70EKkCqUYBFONRRhpQgq7voTY=;
 b=NWw7bsskl4SfVn0Wy1KZ1njWMQt9QitTm2mZIjSVJdzUBMs+xSW0aBwhSJ4t2ug1nCggCVVmGY0OIKZi3CbY7vDp/8fqnPnJSVf0cR8xHa9OxkoDkazBj4ErdhEzrQH9Bf0McMEeGqSO4m77Rw2jVyVNNtK79nByzUXjq8XKPt4=
Received: from DM6PR11MB3690.namprd11.prod.outlook.com (2603:10b6:5:13d::32)
 by DM5PR1101MB2169.namprd11.prod.outlook.com (2603:10b6:4:51::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.24; Mon, 17 Aug
 2020 19:53:46 +0000
Received: from DM6PR11MB3690.namprd11.prod.outlook.com
 ([fe80::e0ca:f0fd:7675:46d7]) by DM6PR11MB3690.namprd11.prod.outlook.com
 ([fe80::e0ca:f0fd:7675:46d7%4]) with mapi id 15.20.3283.027; Mon, 17 Aug 2020
 19:53:46 +0000
To: <alistair23@gmail.com>
CC: <bmeng.cn@gmail.com>, <anup@brainfault.org>, <Alistair.Francis@wdc.com>,
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
Thread-Index: AQHWdIGDfQ2ADX3iMkmaUQkzVWiMJKk8cXaAgAA+ugCAAAcHgA==
Date: Mon, 17 Aug 2020 19:53:46 +0000
Message-ID: <d3f61c2c-a489-887e-0143-4d9a1e66e6f2@microchip.com>
References: <1597423256-14847-1-git-send-email-bmeng.cn@gmail.com>
 <CAAhSdy2D=TcENAJDja4r6pnhz0LRi-T+A9k3Btrs_EuB4x0e4w@mail.gmail.com>
 <CAEUhbmV5=B5xKhYqMj1MQb61nt5cNUJG1MXT++C1w1YMYTfLCQ@mail.gmail.com>
 <202949f7-c9d5-4d4d-3ebe-53727f4fa169@microchip.com>
 <CAKmqyKM3nm0rhxgDvWKWfO+4b23ZLSkHW2TzmcVZ_ZFy4L7MRg@mail.gmail.com>
In-Reply-To: <CAKmqyKM3nm0rhxgDvWKWfO+4b23ZLSkHW2TzmcVZ_ZFy4L7MRg@mail.gmail.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [86.40.244.225]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed454b7c-5877-4b75-2034-08d842e740a0
x-ms-traffictypediagnostic: DM5PR1101MB2169:
x-microsoft-antispam-prvs: <DM5PR1101MB2169BB4F4A67CF8D425923C19E5F0@DM5PR1101MB2169.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dny3CeeP0EOUwqWuFlvz3Z1J76bL7wAiGTJ0asHClfF/PAXS8qVhuXBteyJnHz6iugPoqDMAdv6/SNbt4kQFMA8+GsK2LJ4jSafN3HVq/qZb4d/n2Ez+4U55ec2N3yWMbP7guc9m03Lv+bxdDkOS/wswt2SXEn7O1JD3XrFyt2p6/6PQeOKgkohXz7v453Mr2W+IsoiDqF9fqfuLn0+IzUI8sfRkVxiMH+NEjaK6Ou+ihdwrnrA5xNJ5v62k5dS4Aht5HGNdi0a17ZkiucdUnurjI7wcUj+CDRPd+4LpfrYWYq7JvM+1wy6m6G/bFBGci7D23dnQF0PhfuvSVmuKXA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR11MB3690.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(186003)(54906003)(5660300002)(53546011)(26005)(6486002)(8936002)(66476007)(66556008)(66946007)(66446008)(64756008)(6506007)(4326008)(6512007)(498600001)(8676002)(6916009)(83380400001)(2906002)(2616005)(86362001)(76116006)(91956017)(36756003)(31686004)(31696002)(7416002)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: TfYQrkl+XCurxedsbl1xyLMw+qN8Jy0LOokDCygHpAWk/KKZA7ASmxzZRGBLPCAXPHEIHYT8a4OfkXPX3rfq086fhJact567BmKC9824/Vp9KSnpJ/uXN0oTiKAJkXZkj/ryuFsAWTg7S0l8ojVdR19pGbBiPWYw9cBOg4dL+QiBIcK5TOQUS2tMqfI5uvD+l/clZPcOvpYWyw04HRvcaMwjE5CY6ZU2jhD2FI9q0dxCJqfG1AtsR0VW12kJ+yo09ubTf/7+yN2WKBBpo76v/3aiuyRRRKeWfGE2ELcmf9ctBirV+9TQc+hiq0Qr9/WwKHJf1jxcY+dCP057cqCyfJxEV8NX0JSVah/orvxpcfqemuuLnJDCX6TfYHL9LbK7VwWM+ds6dKgI0H1hYoStLhsyLVuK3RWdGlqlgHaQiuNUHJPMrH215Wht0HBFwFUwR+6tNtWSaVdvwUl4WfCrQkwL1FJ+lCF4m8jR0hwRK2SNh5sJLAzOXjF+iQzj+mvDb1sCSPaIogMpIQJmk12A/d897bgF4TJrxjyXOQe8aEDlymYUypT0z0NLnn9juMZ0Ef4bsOB4GzHuQT7rfHVstF4x629C6B+MybBhXEA1U9PiE+8gE+E3a476IUc6TV+3WfGu0ohJQxSRJ1PHlfG77Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <94AE9F10AC5C344493150A2FB7763272@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3690.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed454b7c-5877-4b75-2034-08d842e740a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2020 19:53:46.0520 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 39jTLBwFOu5XGJt9J19SYZDD3hrKSI5Xh16XH7X63UtUuehc8oiwvO+sO1E7NXGZSsOnEK8dyFdAt99BfH69VBApBgFDm0nBjUNFLAN2oGE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2169
Received-SPF: pass client-ip=216.71.150.166;
 envelope-from=Cyril.Jean@microchip.com; helo=esa5.microchip.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 15:53:49
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

T24gOC8xNy8yMCA4OjI4IFBNLCBBbGlzdGFpciBGcmFuY2lzIHdyb3RlOg0KPiBFWFRFUk5BTCBF
TUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBr
bm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4NCj4gT24gTW9uLCBBdWcgMTcsIDIwMjAgYXQgMTE6
MTIgQU0gdmlhIDxxZW11LWRldmVsQG5vbmdudS5vcmc+IHdyb3RlOg0KPj4gSGkgQW51cCwNCj4+
DQo+PiBPbiA4LzE3LzIwIDExOjMwIEFNLCBCaW4gTWVuZyB3cm90ZToNCj4+PiBFWFRFUk5BTCBF
TUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBr
bm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4+Pg0KPj4+IEhpIEFudXAsDQo+Pj4NCj4+PiBPbiBT
YXQsIEF1ZyAxNSwgMjAyMCBhdCAxOjQ0IEFNIEFudXAgUGF0ZWwgPGFudXBAYnJhaW5mYXVsdC5v
cmc+IHdyb3RlOg0KPj4+PiBPbiBGcmksIEF1ZyAxNCwgMjAyMCBhdCAxMDoxMiBQTSBCaW4gTWVu
ZyA8Ym1lbmcuY25AZ21haWwuY29tPiB3cm90ZToNCj4+Pj4+IEZyb206IEJpbiBNZW5nIDxiaW4u
bWVuZ0B3aW5kcml2ZXIuY29tPg0KPj4+Pj4NCj4+Pj4+IFRoaXMgYWRkcyBzdXBwb3J0IGZvciBN
aWNyb2NoaXAgUG9sYXJGaXJlIFNvQyBJY2ljbGUgS2l0IGJvYXJkLg0KPj4+Pj4gVGhlIEljaWNs
ZSBLaXQgYm9hcmQgaW50ZWdyYXRlcyBhIFBvbGFyRmlyZSBTb0MsIHdpdGggb25lIFNpRml2ZSdz
DQo+Pj4+PiBFNTEgcGx1cyBmb3VyIFU1NCBjb3JlcyBhbmQgbWFueSBvbi1jaGlwIHBlcmlwaGVy
YWxzIGFuZCBhbiBGUEdBLg0KPj4+PiBOaWNlIFdvcmsgISEhIFRoaXMgaXMgdmVyeSBoZWxwZnVs
Lg0KPj4+IFRoYW5rcyENCj4+Pg0KPj4+PiBUaGUgTWljcm9jaGlwIEhTUyBpcyBxdWl0ZSBjb252
b2x1dGVkLiBJdCBoYXM6DQo+Pj4+IDEuIEREUiBJbml0DQo+Pj4+IDIuIEJvb3QgZGV2aWNlIHN1
cHBvcnQNCj4+Pj4gMy4gU0JJIHN1cHBvcnQgdXNpbmcgT3BlblNCSSBhcyBsaWJyYXJ5DQo+Pj4+
IDQuIFNpbXBsZSBURUUgc3VwcG9ydA0KPj4+Pg0KPj4+PiBJIHRoaW5rIHBvaW50IDEpIGFuZCAy
KSBhYm92ZSBzaG91bGQgYmUgcGFydCBvZiBVLUJvb3QgU1BMLg0KPj4+PiBUaGUgcG9pbnQgMykg
Y2FuIGJlIE9wZW5TQkkgRldfRFlOQU1JQy4NCj4+Pj4NCj4+Pj4gTGFzdGx5LGZvciBwb2ludCA0
KSwgd2UgYXJlIHdvcmtpbmcgb24gYSBuZXcgT3BlblNCSSBmZWF0dXJlIHVzaW5nDQo+Pj4+IHdo
aWNoIHdlIGNhbiBydW4gaW5kZXBlbmRlbnQgU2VjdXJlIE9TIGFuZCBOb24tU2VjdXJlIE9TIHVz
aW5nDQo+Pj4+IFUtQm9vdF9TUEwrT3BlblNCSSAoZm9yIGJvdGggU2lGaXZlIFVubGVhc2hlZCBh
bmQgTWljcm9jaGlwDQo+Pj4+IFBvbGFyRmlyZSkuDQo+Pj4+DQo+Pj4+IERvIHlvdSBoYXZlIHBs
YW5zIGZvciBhZGRpbmcgVS1Cb290IFNQTCBzdXBwb3J0IGZvciB0aGlzIGJvYXJkID8/DQo+Pj4g
KyBDeXJpbCBKZWFuIGZyb20gTWljcm9jaGlwDQo+Pj4NCj4+PiBJIHdpbGwgaGF2ZSB0byBsZWF2
ZSB0aGlzIHF1ZXN0aW9uIHRvIEN5cmlsIHRvIGNvbW1lbnQuDQo+Pj4NCj4+IEkgY3VycmVudGx5
IGRvIG5vdCBoYXZlIGEgcGxhbiB0byBzdXBwb3J0IFUtQm9vdCBTUEwuIFRoZSBpZGVhIG9mIHRo
ZQ0KPj4gSFNTIGlzIHRvIGNvbnRhaW4gYWxsIHRoZSBzaWxpY29uIHNwZWNpZmljIGluaXRpYWxp
emF0aW9uIGFuZA0KPj4gY29uZmlndXJhdGlvbiBjb2RlIHdpdGhpbiB0aGUgSFNTIGJlZm9yZSBq
dW1waW5nIHRvIFUtQm9vdCBTLW1vZGUuIEkNCj4+IHdvdWxkIHJhdGhlciBrZWVwIGFsbCB0aGlz
IHdpdGhpbiB0aGUgSFNTIGZvciB0aGUgdGltZSBiZWluZy4gSSB3b3VsZA0KPj4gd2FpdCB1bnRp
bCB3ZSByZWFjaCBwcm9kdWN0aW9uIHNpbGljb24gYmVmb3JlIGF0dGVtcHRpbmcgdG8gbW92ZSB0
aGlzIHRvDQo+PiBVLUJvb3QgU1BMIGFzIHRoZSBIU1MgaXMgbGlrZWx5IHRvIGNvbnRhaW4gc29t
ZSBvcGFxdWUgc2lsaWNvbiByZWxhdGVkDQo+PiBjaGFuZ2VzIGZvciBhbm90aGVyIHdoaWxlLg0K
PiBUaGF0IGlzIHVuZm9ydHVuYXRlLCBhIGxvdCBvZiB3b3JrIGhhcyBnb25lIGludG8gbWFraW5n
IHRoZSBib290IGZsb3cNCj4gc2ltcGxlIGFuZCBlYXN5IHRvIHVzZS4NCj4NCj4gUUVNVSBub3cg
aW5jbHVkZXMgT3BlblNCSSBieSBkZWZhdWx0IHRvIG1ha2UgaXQgZWFzeSBmb3IgdXNlcnMgdG8g
Ym9vdA0KPiBMaW51eC4gVGhlIEljaWNsZSBLaXQgYm9hcmQgaXMgbm93IHRoZSBtb3N0IGRpZmZp
Y3VsdCBRRU1VIGJvYXJkIHRvDQo+IGJvb3QgTGludXggb24uIE5vdCB0byBtZW50aW9uIGl0IG1h
a2VzIGl0IGhhcmQgdG8gaW1wb3NzaWJsZSB0bw0KPiBzdXBwb3J0IGl0IGluIHN0YW5kYXJkIHRv
b2wgZmxvd3Mgc3VjaCBhcyBtZXRhLXJpc2N2Lg0KPg0KPiBBbGlzdGFpcg0KDQpJZiBpdCBpcyBz
dWNoIGEgcHJvYmxlbSB3ZSBjYW4gYWRkIGEgVS1Cb290IFNQTCBzdGFnZSBhbmQgdGhlIEhTUyBj
YW4gYmUgDQp0cmVhdGVkIGFzIHN0YW5kYXJkIFNvQyBST00gY29kZS4NCg0KQ3lyaWwuDQoNCg0K

