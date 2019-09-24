Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C651C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 12:19:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36608214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 12:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ktYtzkj3";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="EijJD6iW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36608214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCjnG-0006gE-8f
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 08:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48454)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1633f89ff=Anup.Patel@wdc.com>)
 id 1iCjmC-0006BZ-Pf
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 08:18:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1633f89ff=Anup.Patel@wdc.com>)
 id 1iCjmB-0002Z4-6I
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 08:18:40 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:51610)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1633f89ff=Anup.Patel@wdc.com>)
 id 1iCjm5-0002Wi-Vk; Tue, 24 Sep 2019 08:18:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1569327514; x=1600863514;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=EN09HBQfHSHKlHLs2f1WBuqVKQJgXYGrOpYl+wdDs9k=;
 b=ktYtzkj3NN3r5ohpt+T4Bgxvr6trJcwhEQ2IuHVhmlkWuedPcHTEvUe2
 5oXD4nb2TDyVufSg96IqDKQCUPJuWghscQbiQjz+uP8Kj/lgL0cvmKYlx
 9aVwC6IMC3/x+bbKdMSxVd1cVmw7fNJbvGQPCzh1fNJSDrYTwKObwjGz6
 Pw4GkyZauFf4uG1yWd2Nsxn8YGoc+Y29Sn0Bdy4W/B/iX+q5bAdvReQKI
 v1k9hDBRJM18OflTee53u3Rbh8RnbpX7PR/9EjtVRjNb50E7xiVu7aqT8
 4K5Cd/kH68ww2/aBVbZ+9pHVyc0U0AEd9+SoC/F5C3/ok3WOtfG9q7vV1 g==;
IronPort-SDR: Os8UnwSRbfQJNl/h1JHg8wwRvCrLEzuLn+9mqg0ThI23bV8gCrf4/ysyI1GDeEtEi3uuTylyyP
 a5bZcMMr+PH9+FCrATRjWHLZaqwDeO367lWHmrWviZ8gL+QyG8VUbuuV7SqDhJgLi28xAOMDmF
 yMCEMZwjFf20NURblX3/4twFojdwJae12QRuQPYq4JzB1LNX3BTzknNnJPpOKR2GjahaCNvuPE
 r8+3FbGKWJGl6xA/53ll4qrbHV+8Rjsbqvl4M705HhI1+hpmtF2YScs9JOAfVQ6vBtyuP0WIkk
 +tA=
X-IronPort-AV: E=Sophos;i="5.64,544,1559491200"; d="scan'208";a="119753136"
Received: from mail-dm3nam03lp2056.outbound.protection.outlook.com (HELO
 NAM03-DM3-obe.outbound.protection.outlook.com) ([104.47.41.56])
 by ob1.hgst.iphmx.com with ESMTP; 24 Sep 2019 20:18:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gx7IlsV6wlk86+MaBQJ5JTdtRHp+eOYWwwDXJYGfQNWjU14SOKCZPxYyp2qhv4wRJUZGpXVieKr1QyPqXDpc+AAICzSg0JQ9rEsXDlkXqHw6w4ugxSbEjZ7S0ZyRTY69vakVNq5XemIhPoUTCxHlj9abSyBNwzkPNORR2TCLpYI+GXFaj4Jpg2SfAUMvHrjsrYMi2rI7rK0PrDxyA1g6CZuSYAekQwodeb9RV93BS8yns7CO0RRLW9vY0fDCQ/sD6sPjuGB+FFUYfesqD4a3yvPYcobGPEAIAIwAc49A0sCZGAnRBc96dnv6yX6DfemjTJ8o1sDe5+0S+4ylOTrexQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EN09HBQfHSHKlHLs2f1WBuqVKQJgXYGrOpYl+wdDs9k=;
 b=YZLnfaAbv7qnV2SkL1OyCU6dF3xisscdKOnEkgOlQJbdgKFNn3qn4hMVR6U29IC5Hell3esNv0M9hbrC2OhjlKwu/LFfqsbe0VghnUvURFM7VBkWX//stqKlmsXP3ok8O/3AqvZ5Ym2asvVYEAZ6hWmsjKdyvpr1eemkZdau/niQh+PewuQac6YRy2CXVDz3kXluu5FqhFD3XlJ0B4Pg9LvICQ7gENDN32MOQf413Tdalr7nWhbkHHx8PoL+6ujVFw8wBAt6O7/g6p5dCTWePRgw4D/Mg26KBm41uiaYiJLKzQp6DwvT4l/Yn/kwuXnUXdIUKv2zQKj77MB+MMPJfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EN09HBQfHSHKlHLs2f1WBuqVKQJgXYGrOpYl+wdDs9k=;
 b=EijJD6iWluJkoUuR1X+MvGGuegoeh+rGl+RylgIAnomsviHeboszw0AnS2/3lBwMkKjRSW80U/eCEax1NicW4gyMRp8vJldrsnTaKzhOmf0GIj7XJUAPmsyaC8ofPnuSlkbpxWrpZfzwQHhFjWVm3kSRymhqYbw6Hw14fuwb9dw=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB6143.namprd04.prod.outlook.com (20.178.249.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Tue, 24 Sep 2019 12:18:29 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::e1a5:8de2:c3b1:3fb0]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::e1a5:8de2:c3b1:3fb0%7]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 12:18:29 +0000
From: Anup Patel <Anup.Patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: RE: [PATCH 1/2] hw: timer: Add Goldfish RTC device
Thread-Topic: [PATCH 1/2] hw: timer: Add Goldfish RTC device
Thread-Index: AQHVcrQNCvgG16FtZEeROSOS3DihBac6lZmAgAAXUFCAAATwAIAABC9A
Date: Tue, 24 Sep 2019 12:18:28 +0000
Message-ID: <MN2PR04MB606135C95B859133F7DC669C8D840@MN2PR04MB6061.namprd04.prod.outlook.com>
References: <20190924084201.107958-1-anup.patel@wdc.com>
 <20190924084201.107958-2-anup.patel@wdc.com>
 <CAFEAcA-cm2GaKHg7_VcSb-OHp8GA9KuWiyWbc6r3F1p7tLc35A@mail.gmail.com>
 <MN2PR04MB60610CCAEED38F30F9B274208D840@MN2PR04MB6061.namprd04.prod.outlook.com>
 <CAFEAcA_nG5F-bXykXPmgXuiM-i0jHvm-BvHVF1CvjpBeNHOjRA@mail.gmail.com>
In-Reply-To: <CAFEAcA_nG5F-bXykXPmgXuiM-i0jHvm-BvHVF1CvjpBeNHOjRA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-originating-ip: [49.207.51.80]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3fb25235-0086-4724-20d7-08d740e94f15
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:MN2PR04MB6143; 
x-ms-traffictypediagnostic: MN2PR04MB6143:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB614372D4E9E9FA3843D7A82B8D840@MN2PR04MB6143.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(199004)(189003)(13464003)(4326008)(64756008)(99286004)(486006)(66556008)(6506007)(2906002)(26005)(55236004)(53546011)(66476007)(7696005)(76176011)(14454004)(186003)(33656002)(66946007)(6246003)(86362001)(102836004)(478600001)(76116006)(66446008)(9686003)(6436002)(6116002)(3846002)(74316002)(25786009)(71200400001)(229853002)(81166006)(55016002)(8676002)(8936002)(81156014)(52536014)(14444005)(66066001)(6916009)(256004)(11346002)(7736002)(446003)(54906003)(5660300002)(305945005)(71190400001)(476003)(316002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR04MB6143;
 H:MN2PR04MB6061.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WEv0pn5qBSyrPelsMnc7LshKAllA10JomzGyHCD4pZPMDwb7b35nxWVSzgkk8DSCU+4yLpeAt/CkySquJF3F4SKUCp3VAKecVX7O+9Y3eDHOI1bGLccVmE7YHZcYD6qheVgyZ7rk/h8+10xftPGzZgzesL3oFm3ECJEQFg/UMlXOrmnTYaZ8RMqBWDqU7zO2letLEOMwLDnXLviID75NJ1+soJfIr0CwpTBZ3HfVByBbrwXG1m1GHkcASOaVFxXRRWEblPqg+/qynbsyxvd7CM8hYLCZ0ie/Y4wTe19fIGxAHX10XnlAKDASVytj9psW4hMZ4yZ7An3VHkpFqhTLaJxqn+H3EIokcCHE2idYUccUHh6kXy2QzD6ZVmOlRPMlYZghr07mbaJuIMt2QtiyxpdHyCLKy1DVzFsGL8LQZLU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb25235-0086-4724-20d7-08d740e94f15
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 12:18:28.9479 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nw6FVBzmyiDq+KwLL7PAr6/QexzDN9LNF4FvvH6OVrxs/xSjmGYrry5F4jn89faBgUTIYXiQ5kq1oVPudOya2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6143
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.153.144
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
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Atish Patra <Atish.Patra@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Anup Patel <anup@brainfault.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGV0ZXIgTWF5ZGVsbCA8
cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMjQs
IDIwMTkgNTowMiBQTQ0KPiBUbzogQW51cCBQYXRlbCA8QW51cC5QYXRlbEB3ZGMuY29tPg0KPiBD
YzogUGFsbWVyIERhYmJlbHQgPHBhbG1lckBzaWZpdmUuY29tPjsgQWxpc3RhaXIgRnJhbmNpcw0K
PiA8QWxpc3RhaXIuRnJhbmNpc0B3ZGMuY29tPjsgU2FnYXIgS2FyYW5kaWthciA8c2FnYXJrQGVl
Y3MuYmVya2VsZXkuZWR1PjsNCj4gQmFzdGlhbiBLb3BwZWxtYW5uIDxrYmFzdGlhbkBtYWlsLnVu
aS1wYWRlcmJvcm4uZGU+OyBBdGlzaCBQYXRyYQ0KPiA8QXRpc2guUGF0cmFAd2RjLmNvbT47IHFl
bXUtcmlzY3ZAbm9uZ251Lm9yZzsgcWVtdS0NCj4gZGV2ZWxAbm9uZ251Lm9yZzsgQW51cCBQYXRl
bCA8YW51cEBicmFpbmZhdWx0Lm9yZz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIGh3OiB0
aW1lcjogQWRkIEdvbGRmaXNoIFJUQyBkZXZpY2UNCj4gDQo+IE9uIFR1ZSwgMjQgU2VwIDIwMTkg
YXQgMTI6MTcsIEFudXAgUGF0ZWwgPEFudXAuUGF0ZWxAd2RjLmNvbT4gd3JvdGU6DQo+ID4NCj4g
Pg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogUGV0
ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPg0KPiA+ID4gU2VudDogVHVlc2Rh
eSwgU2VwdGVtYmVyIDI0LCAyMDE5IDM6MjEgUE0NCj4gPiA+IFRvOiBBbnVwIFBhdGVsIDxBbnVw
LlBhdGVsQHdkYy5jb20+DQo+ID4gPiBDYzogUGFsbWVyIERhYmJlbHQgPHBhbG1lckBzaWZpdmUu
Y29tPjsgQWxpc3RhaXIgRnJhbmNpcw0KPiA+ID4gPEFsaXN0YWlyLkZyYW5jaXNAd2RjLmNvbT47
IFNhZ2FyIEthcmFuZGlrYXINCj4gPiA+IDxzYWdhcmtAZWVjcy5iZXJrZWxleS5lZHU+OyBCYXN0
aWFuIEtvcHBlbG1hbm4NCj4gPiA+IDxrYmFzdGlhbkBtYWlsLnVuaS1wYWRlcmJvcm4uZGU+OyBB
dGlzaCBQYXRyYQ0KPiA8QXRpc2guUGF0cmFAd2RjLmNvbT47DQo+ID4gPiBxZW11LXJpc2N2QG5v
bmdudS5vcmc7IHFlbXUtIGRldmVsQG5vbmdudS5vcmc7IEFudXAgUGF0ZWwNCj4gPiA+IDxhbnVw
QGJyYWluZmF1bHQub3JnPg0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIGh3OiB0aW1l
cjogQWRkIEdvbGRmaXNoIFJUQyBkZXZpY2UNCj4gPiA+DQo+ID4gPiBPbiBUdWUsIDI0IFNlcCAy
MDE5IGF0IDA5OjQ1LCBBbnVwIFBhdGVsIDxBbnVwLlBhdGVsQHdkYy5jb20+IHdyb3RlOg0KPiA+
ID4gPg0KPiA+ID4gPiBUaGlzIHBhdGNoIGFkZHMgbW9kZWwgZm9yIEdvb2dsZSBHb2xkZmlzaCB2
aXJ0dWFsIHBsYXRmb3JtIFJUQyBkZXZpY2UuDQo+ID4gPiA+DQo+ID4gPiA+IFdlIHdpbGwgYmUg
YWRkaW5nIEdvbGRmaXNoIFJUQyBkZXZpY2UgdG8gdGhlIFFFTVUgUklTQy1WIHZpcnQNCj4gPiA+
ID4gbWFjaGluZSBmb3IgcHJvdmlkaW5nIHJlYWwgZGF0ZS10aW1lIHRvIEd1ZXN0IExpbnV4LiBU
aGUNCj4gPiA+ID4gY29ycmVzcG9uZGluZyBMaW51eCBkcml2ZXIgZm9yIEdvbGRmaXNoIFJUQyBk
ZXZpY2UgaXMgYWxyZWFkeSBhdmFpbGFibGUgaW4NCj4gdXBzdHJlYW0gTGludXguDQo+ID4gPiA+
DQo+ID4gPiA+IEZvciBub3csIFZNIG1pZ3JhdGlvbiBzdXBwb3J0IGlzIG5vdCBhdmFpbGFibGUg
Zm9yIEdvbGRmaXNoIFJUQw0KPiA+ID4gPiBkZXZpY2UgYnV0IGl0IHdpbGwgYmUgYWRkZWQgbGF0
ZXIgd2hlbiB3ZSBpbXBsZW1lbnQgVk0gbWlncmF0aW9uDQo+ID4gPiA+IGZvciBLVk0gUklTQy0N
Cj4gPiA+IFYuDQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEFudXAgUGF0ZWwgPGFu
dXAucGF0ZWxAd2RjLmNvbT4NCj4gDQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiArDQo+ID4gPiA+ICtz
dGF0aWMgUHJvcGVydHkgZ29sZGZpc2hfcnRjX3Byb3BlcnRpZXNbXSA9IHsNCj4gPiA+ID4gKyAg
ICBERUZJTkVfUFJPUF9VSU5UNjQoInRpY2stb2Zmc2V0IiwgR29sZGZpc2hSVENTdGF0ZSwgdGlj
a19vZmZzZXQsDQo+IDApLA0KPiA+ID4gPiArICAgIERFRklORV9QUk9QX1VJTlQ2NCgiYWxhcm0t
bmV4dCIsIEdvbGRmaXNoUlRDU3RhdGUsIGFsYXJtX25leHQsDQo+IDApLA0KPiA+ID4gPiArICAg
IERFRklORV9QUk9QX1VJTlQzMigiYWxhcm0tcnVubmluZyIsIEdvbGRmaXNoUlRDU3RhdGUsDQo+
ID4gPiBhbGFybV9ydW5uaW5nLCAwKSwNCj4gPiA+ID4gKyAgICBERUZJTkVfUFJPUF9VSU5UMzIo
ImlycS1wZW5kaW5nIiwgR29sZGZpc2hSVENTdGF0ZSwNCj4gPiA+ID4gKyBpcnFfcGVuZGluZywN
Cj4gPiA+IDApLA0KPiA+ID4gPiArICAgIERFRklORV9QUk9QX1VJTlQzMigiaXJxLWVuYWJsZWQi
LCBHb2xkZmlzaFJUQ1N0YXRlLA0KPiA+ID4gPiArIGlycV9lbmFibGVkLA0KPiA+ID4gMCksDQo+
ID4gPiA+ICsgICAgREVGSU5FX1BST1BfRU5EX09GX0xJU1QoKSwNCj4gPiA+ID4gK307DQo+ID4g
Pg0KPiA+ID4gV2hhdCBhcmUgYWxsIHRoZXNlIHByb3BlcnRpZXMgdHJ5aW5nIHRvIGRvID8NCj4g
Pg0KPiA+IEFyZ2gsIEkgZm9yZ290IHRvIHJlbW92ZSB0aGVzZSBiZWZvcmUgc2VuZGluZy4NCj4g
Pg0KPiA+IEkgd2lsbCBkcm9wIHRoZXNlIGluIG5leHQgcmV2aXNpb24uDQo+ID4NCj4gPiA+DQo+
ID4gPiA+ICsNCj4gPiA+ID4gK3N0YXRpYyB2b2lkIGdvbGRmaXNoX3J0Y19jbGFzc19pbml0KE9i
amVjdENsYXNzICprbGFzcywgdm9pZCAqZGF0YSkgew0KPiA+ID4gPiArICAgIERldmljZUNsYXNz
ICpkYyA9IERFVklDRV9DTEFTUyhrbGFzcyk7DQo+ID4gPiA+ICsgICAgZGMtPnByb3BzID0gZ29s
ZGZpc2hfcnRjX3Byb3BlcnRpZXM7DQo+ID4gPg0KPiA+ID4gTWlzc2luZyByZXNldCBmdW5jdGlv
bi4NCj4gPg0KPiA+IFN1cmUsIEkgd2lsbCBhZGQgaXQuIEkgZ290IGNvbmZ1c2VkIGJlY2F1c2Ug
SSBzYXcgcmVzZXQgZnVuY3Rpb24gaW4NCj4gPiBIUEVUIGJ1dCBub3QgaW4gUEwwMzEuDQo+IA0K
PiBZZWFoLCB0aGUgbGFjayBvZiByZXNldCBpcyBhIGJ1ZyBpbiB0aGUgcGwwMzEuIEkgZGlkIGhh
dmUgYSBkcmFmdCBzZXQgb2YgcGF0Y2hlcw0KPiB3aGVyZSBJIHRyaWVkIHRvIGZpeCB0aGF0LCBi
dXQgSSBnb3Qgc3R1Y2sgYmVjYXVzZSBpdCB3YXMgYSBiaXQgdW5jbGVhciB3aGF0IEkNCj4gb3Vn
aHQgdG8gYmUgcmVzZXR0aW5nLiBJbiBhIHJlYWwgaGFyZHdhcmUgcGwwMzEgdGhlcmUgaXMgbm8g
cGVyc2lzdGVudCBzdG9yYWdlDQo+IG9mIHRoZSBSVEMgdmFsdWUgLS0gaXQncyBqdXN0IGEgMUh6
IGNvdW50ZXIsIHJlYWxseSwgYW5kIGd1ZXN0IGZpcm13YXJlIHdpbGwgd3JpdGUNCj4gdG8gaXQg
b24gc3RhcnR1cCAoZnJvbSBzb21lIG90aGVyIHJlYWwgUlRDKS4gSW4gUUVNVSB3ZSB1c2UgaXQg
YXMgYSBzb3J0IG9mDQo+ICJSVEMgZm9yIGEgVk0iLCBhbmQgYmFjayBpdCB3aXRoIHRoZSBRRU1V
IFJUQyBjbG9jaywgc28gaXQgZG9lc24ndCBiZWhhdmUNCj4gcXVpdGUgYXMgdGhlIGhhcmR3YXJl
IGRvZXMgYnV0IG1vcmUgbGlrZSAidmlldyB0aGF0IHlvdSdkIHNlZSBmcm9tIGENCj4gY29tYmlu
YXRpb24gb2YgaC93IGFuZCBmaXJtd2FyZSBiZWhhdmlvdXIiLg0KPiANCj4gVExEUjogZG9uJ3Qg
dXNlIHRoZSBwbDAzMSBjb2RlIGFzIGEgZ29vZCBtb2RlbCBvZiBob3cgdG8gZG8gYW4gUlRDLCBp
dCBoYXMNCj4gc29tZSBkZWZpbml0ZSBmbGF3cy4geDg2IG9yIHBwYyBSVEMgaGFuZGxpbmcgaXMg
cHJvYmFibHkgYSBiZXR0ZXIgcGxhY2UgdG8NCj4gbG9vay4NCj4gDQo+IEFub3RoZXIgcmFuZG9t
IHF1ZXN0aW9uIC0tIGlzIHRoZXJlIGFuIGV4aXN0aW5nIFJUQyBkZXZpY2Ugd2UgY291bGQgcHV0
IGluDQo+IHRoZSByaXNjdiBib2FyZCByYXRoZXIgdGhhbiBhZGRpbmcgYSBuZXcgbW9kZWwgb2Yg
dGhpcyBnb2xkZmlzaCBkZXZpY2U/IFB1dA0KPiBhbm90aGVyIHdheSwgd2hhdCBhcmUgdGhlIG1l
cml0cyBvZiB1c2luZyBnb2xkZmlzaCBpbiBwYXJ0aWN1bGFyPw0KDQpBcyBvZiBub3csIHRoZXJl
IGlzIG5vIFJUQyBkZXZpY2UgdXNlZCBhY3Jvc3MgU09Dcy4gQXRsZWFzdCBub3RoaW5nIHRoYXQg
SQ0KYW0gYXdhcmUgb2YuDQoNCkkganVzdCB3YW50ZWQgYSB2ZXJ5IHNpbXBsZSBSVEMgZm9yIFJJ
U0MtViB2aXJ0IG1hY2hpbmUgYW5kIGZvdW5kIGdvbGRmaXNoDQpSVEMgdG8gYmUgcmVhbGx5IHVz
ZWZ1bC4gQWx0aG91Z2ggb3RoZXIgR29sZGZpc2ggZGV2aWNlcyBhcmUgbm90IHZlcnkNCmF0dHJh
Y3RpdmUgYW5kIHdlIGdlbmVyYWxseSBoYXZlIGFuIGVxdWl2YWxlbnQgVmlydElPIGRldmljZS4N
Cg0KSWRlYWxseSwgd2Ugc2hvdWxkIGhhdmUgYSBWaXJ0SU8gUlRDIHRoaW5neSBidXQgbm90IHN1
cmUgaWYgUlRDIGZpdHMNCmluIFZpcnRJTyByaW5nIHByb2dyYW1taW5nIG1vZGVsLg0KDQo+IA0K
PiBXZSBzaG91bGQgcHJvYmFibHkgZG9jdW1lbnQgdGhpcyBkZXZpY2UgaW4gZG9jcy9zcGVjcyBz
aW5jZSBpdCdzIGEgcHVyZS0NCj4gdmlydHVhbCBkZXZpY2UuIChZb3UgaGF2ZSBhIGxpbmsgdG8g
dGhlIFVSTCBmb3IgdGhlIEdPTERGSVNILVZJUlRVQUwtDQo+IEhBUkRXQVJFLlRYVCBmb3IgdGhl
IGFuZHJvaWQgZW11bGF0b3IsIGJ1dCB0aGF0IGRvZXNuJ3Qgc2VlbSB0byBtYXRjaA0KPiB0aGUg
aW1wbGVtZW50YXRpb24gaGVyZSAtLSB0aGUgZG9jIHNheXMgdGhlIGFsYXJtIHJlZ2lzdGVycyBh
cmUgbm9uLQ0KPiBmdW5jdGlvbmFsIGJ1dCB0aGlzIGNvZGUgZG9lcyBzb21ldGhpbmcgd2l0aA0K
PiB0aGVtLikNCg0KVGhlIGltcGxlbWVudGF0aW9uIG1hdGNoZXMgY29ycmVzcG9uZGluZyBkcml2
ZXIgYXZhaWxhYmxlIGluIHVwc3RyZWFtDQpMaW51eC4gV2Ugc2hvdWxkIGNlcnRhaW5seSBoYXZl
IGEgbW9yZSBjb21wbGV0ZSBkb2N1bWVudCB1bmRlcg0KZG9jcy9zZXBjcyAobGlrZSB5b3Ugc3Vn
Z2VzdGVkKSBmb3IgdGhpcyBkZXZpY2UuDQoNCj4gDQo+ID4gPiBJZiB5b3UgZG9uJ3Qgd2FudCB0
byBpbXBsZW1lbnQgbWlncmF0aW9uIHN1cHBvcnQgbm93IHlvdSBzaG91bGQgYXQNCj4gPiA+IGxl
YXN0IHB1dCBpbiBzb21ldGhpbmcgdGhhdCBibG9jayBtaWdyYXRpb24uDQo+ID4gPiAoUGVyc29u
YWxseSBJIHByZWZlciB0byBqdXN0IHdyaXRlIHRoZSB2bXN0YXRlLCBpdCdzIGFzIGVhc3kgYXMN
Cj4gPiA+IHdyaXRpbmcgdGhlIGNvZGUgdG8gYmxvY2sgbWlncmF0aW9ucy4pDQo+ID4NCj4gPiBP
a2F5LCBJIHdpbGwgYWRkIHZtc3RhdGUuDQo+ID4NCj4gPiBJcyB0aGVyZSBhIHdheSB0byB1bml0
IHRlc3QgdGhlIHZtc3RhdGUgcGFydCA/DQo+ID4gT1INCj4gPiBBcmUgeW91IGZpbmUgaWYgd2Ug
dGVzdC1uLWZpeCBpdCBsYXRlciA/DQo+IA0KPiBUZXN0IGFuZCBmaXggbGF0ZXIgaXMgZmluZS4g
VGhhdCBzYWlkLCBJJ3ZlIGp1c3QgcmVtZW1iZXJlZCB0aGF0IGZvciBhbiBSVEMNCj4gbWlncmF0
aW9uIGlzIHBvdGVudGlhbGx5IGEgdHJpY2t5IGFyZWEgYmVjYXVzZSB5b3UgdHlwaWNhbGx5IGRv
bid0IHdhbnQgYQ0KPiB2bXNhdmUtdm1sb2FkIHRvIGdpdmUgeW91IHRoZSBzYW1lIFJUQyB2YWx1
ZSBhZnRlciBsb2FkIHRoYXQgdGhlcmUgd2FzIG9uDQo+IHN0b3JlLCB5b3Ugd2FudCBpdCB0byBz
dGlsbCBiZSBmb2xsb3dpbmcgdGhlIGhvc3QgUlRDLg0KPiBXZSBnb3QgdGhhdCB3cm9uZyBvbiB0
aGUgUEwwMzEgYW5kIGhhZCB0byBwdXQgaW4gc29tZSB1Z2x5IHdvcmthcm91bmRzIHRvDQo+IG1h
aW50YWluIG1pZ3JhdGlvbiBjb21wYXRpYmlsaXR5IHdoZW4gd2UgZml4ZWQgaXQuDQo+IFNvIG1h
eWJlIGl0IHdvdWxkIGJlIGJldHRlciB0byBtYXJrIGFzIG5vbi1taWdyYXRhYmxlIGZvciBub3cu
DQoNClllcywgSSBzYXcgdGhlIHdvcmthcm91bmQgaW4gUEwwMzEgYW5kIHRoZSBiYWNrd2FyZCBj
b21wYXRpYmlsaXR5IGJpdHMuDQoNClRoaXMgaXMgZmlyc3QgdmVyc2lvbiBvZiBHb2xkZmlzaCBS
VEMgdm1zdGF0ZSBzbyB3ZSBkb24ndCBuZWVkIHRoZSBQTDAzMQ0KYmFja3dhcmQgY29tcGF0aWJp
bGl0eSBiaXRzLg0KDQpJIHdpbGwgdHJ5IGltcGxlbWVudCB0aGlzIGluIHYyIGFuZCB5b3UgY2Fu
IGhhdmUgYSBsb29rLg0KDQpSZWdhcmRzLA0KQW51cA0K

