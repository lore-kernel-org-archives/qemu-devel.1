Return-Path: <SRS0=rO5d=BF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130BBC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2020 17:00:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D164A206D8
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2020 17:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=leostella.onmicrosoft.com header.i=@leostella.onmicrosoft.com header.b="Ncz6MFny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D164A206D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=leostella.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzk0u-0005qu-VY
	for qemu-devel@archiver.kernel.org; Sun, 26 Jul 2020 13:00:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthieu.bucchianeri@leostella.com>)
 id 1jzjzg-0004zk-Qn; Sun, 26 Jul 2020 12:59:24 -0400
Received: from mail-bn3usg02on0107.outbound.protection.office365.us
 ([23.103.208.107]:54301 helo=USG02-BN3-obe.outbound.protection.office365.us)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthieu.bucchianeri@leostella.com>)
 id 1jzjze-00055v-CH; Sun, 26 Jul 2020 12:59:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=xISa+TQNRQvHoYyH06RjeH1g5C1tUMt2yxmgozuxBBn1Y+kdWbVvtf2hXWejFnip0dOcEfFFieEFC29bYowZmgiIGUbDkchmOqunXeG7oCeDJJbk+sNvmjX7LgDMJCHqEmg7huTc1hirKMdF4nAyHumG8OhN3GHx88yZhG7CJFkGy95u1dDR8A8jjjhXxGz8hRmFyDlCkhZWMMgUphl1YrzR4FSW5v8IU2B0I/u1sLHZV5VfqRs/4yPI7OC/NRHHZzv3y//IeJeahJVfR0WEEJFvLotBPhlJCnaWECCNO114Fa1fr3/SkbU9HEIbVmG2l4Q+vsjUScO4ES//AlM7cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/8W/yeSSqP5M8MhrgFRmaaw8m1KLmma5MeGReArvgI=;
 b=tv49m+y+GO2d+ZGZvMZN5pvcyIfG4/XBXlsMXewTbbPNNlNvHHZdTAGZywKDp9bgbfszf6p6tyL+Q5llWXgVuvqicH7A7DS5sH2PSV8376HmGkQ7Rhn4eSwomYXZA/pF/FtY2+y2Xg8C52mOwT7yKGJOLJf6Hvsc/05aPxNyBBC/csnR7uJ/AwQ71bNnaeUYAsamy71H4mnjzi9fcgnFCXoZL2iQP1OQgamwMb3mPzRWmZslVwSrpo3hXZoyIjHbX9LyOByPqm9lFQjUHmQJISQ1kkx1Lts9E398oW3+Rd5YRG0TDHd/vwuZmTErUnguQ3o/4NkwflGPiiLDD2FjMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leostella.com; dmarc=pass action=none
 header.from=leostella.com; dkim=pass header.d=leostella.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leostella.onmicrosoft.com; s=selector1-leostella-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/8W/yeSSqP5M8MhrgFRmaaw8m1KLmma5MeGReArvgI=;
 b=Ncz6MFny1IayTZ6t/5/4KRIr0c2lHWemqCVZppcK6etenESZx4wvo0DggPATefK2fznCLUmaqV20AVC8VRgWYcbNA40l6nrC7GUKbgjgeyMiBaX3ugFPOInPJk9UFygHhrIftZxACCGaxJTcHOEVD6MqmNKK3ZY/CRXZnd6hAXg=
Received: from SN5P110MB0543.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:41c::10)
 by SN5P110MB0510.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:41b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.28; Sun, 26 Jul
 2020 16:59:16 +0000
Received: from SN5P110MB0543.NAMP110.PROD.OUTLOOK.COM
 ([fe80::d0e1:84ad:f42:f6f2]) by SN5P110MB0543.NAMP110.PROD.OUTLOOK.COM
 ([fe80::d0e1:84ad:f42:f6f2%5]) with mapi id 15.20.3195.029; Sun, 26 Jul 2020
 16:59:16 +0000
From: Matthieu Bucchianeri <matthieu.bucchianeri@leostella.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org"
 <qemu-ppc@nongnu.org>, BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [PATCH] target/ppc: Fix SPE unavailable exception triggering
Thread-Topic: [PATCH] target/ppc: Fix SPE unavailable exception triggering
Thread-Index: AQHWYrfk1Mes9sSNm0m4bx3FUJe/kKkZov8AgABw2pA=
Date: Sun, 26 Jul 2020 16:59:16 +0000
Message-ID: <SN5P110MB05433223A83842B1686867CB84750@SN5P110MB0543.NAMP110.PROD.OUTLOOK.COM>
References: <20200725191436.31828-1-matthieu.bucchianeri@leostella.com>
 <alpine.BSF.2.22.395.2007261202050.35472@zero.eik.bme.hu>
In-Reply-To: <alpine.BSF.2.22.395.2007261202050.35472@zero.eik.bme.hu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=leostella.com;
x-originating-ip: [2601:601:f01:e820:3805:9c62:2079:6ea0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3edbf4a-98da-4146-1057-08d831853b19
x-ms-traffictypediagnostic: SN5P110MB0510:
x-microsoft-antispam-prvs: <SN5P110MB051002A6E2CA40413CB1A5B984750@SN5P110MB0510.NAMP110.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN5P110MB0543.NAMP110.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(6506007)(508600001)(86362001)(4326008)(7696005)(71200400001)(8676002)(966005)(186003)(8936002)(44832011)(5660300002)(33656002)(2906002)(110136005)(83380400001)(9686003)(55016002)(52536014)(76116006)(66556008)(66446008)(64756008)(66946007)(66476007)(131093003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: leostella.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN5P110MB0543.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b3edbf4a-98da-4146-1057-08d831853b19
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2020 16:59:16.3585 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dbc51146-ab26-404b-9c4b-cce4f3331cc5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN5P110MB0510
Received-SPF: pass client-ip=23.103.208.107;
 envelope-from=matthieu.bucchianeri@leostella.com;
 helo=USG02-BN3-obe.outbound.protection.office365.us
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/26 12:59:19
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
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
Cc: "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGVsbG8gQmFsYXRvbiwNCg0KVGhhbmsgeW91IGZvciB5b3VyIHRob3JvdWdoIHJldmlldyEgU2Vl
IG15IHJlc3BvbnNlIGJlbG93Lg0KDQo+ID4gc3RhdGljIGlubGluZSB2b2lkIGdlbl9ldm13c21p
YWEoRGlzYXNDb250ZXh0ICpjdHgpIHsNCj4gPiAtICAgIFRDR3ZfaTY0IGFjYyA9IHRjZ190ZW1w
X25ld19pNjQoKTsNCj4gPiAtICAgIFRDR3ZfaTY0IHRtcCA9IHRjZ190ZW1wX25ld19pNjQoKTsN
Cj4gPiArICAgIFRDR3ZfaTY0IGFjYzsNCj4gPiArICAgIFRDR3ZfaTY0IHRtcDsNCj4gPiArDQo+
ID4gKyAgICBpZiAodW5saWtlbHkoIWN0eC0+c3BlX2VuYWJsZWQpKSB7DQo+ID4gKyAgICAgICAg
Z2VuX2V4Y2VwdGlvbihjdHgsIFBPV0VSUENfRVhDUF9TUEVVKTsNCj4gPiArICAgICAgICByZXR1
cm47DQo+ID4gKyAgICB9DQo+DQo+IElzbid0IHRoaXMgbWlzc2luZyBoZXJlOg0KPg0KPiBhY2Mg
PSB0Y2dfdGVtcF9uZXdfaTY0KCk7DQo+IHRtcCA9IHRjZ190ZW1wX25ld19pNjQoKTsNCj4NCj4g
WW91J3ZlIHJlbW92ZWQgYWxsb2NhdGluZyB0ZW1wcyBidXQgdGhpcyBodW5rIGRvZXMgbm90IGFk
ZCBpdCBiYWNrIGFmdGVyIHRoZQ0KPiBleGNlcHRpb24gdW5saWtlIG90aGVycyBpbiB0aGlzIHBh
dGNoLg0KDQpJIHNob3VsZCBoYXZlIHByb2JhYmx5IG1lbnRpb25lZCBzb21ld2hlcmUgdGhhdCB0
aGlzIHBhdGNoIGFsc28NCmZpeGVzIGEgcmVzb3VyY2UgbGVhayBpbiB0aGF0IGZ1bmN0aW9uLiBJ
dCBpcyBub3QgdmVyeSBvYnZpb3VzDQp3aGVuIGxvb2tpbmcgYXQgaXQgYXMgYSBwYXRjaCwgYnV0
IGlmIHlvdSB0YWtlIGEgbG9vayBhdCB0aGUNCm9yaWdpbmFsIGNvZGUsIHlvdSB3aWxsIHNlZSB0
aGF0IEkgcmVtb3ZlZCB0aGVzZSBhbGxvY2F0aW9ucyBvbg0KcHVycG9zZToNCg0KaHR0cHM6Ly9n
aXRodWIuY29tL3FlbXUvcWVtdS9ibG9iL2Q1NzdkYmFhYzc1NTM3NjcyMzJmYWFiYjZhM2UyOTFh
ZWJkMzQ4YWUvdGFyZ2V0L3BwYy90cmFuc2xhdGUvc3BlLWltcGwuaW5jLmMjTDUzMg0KDQo+IHN0
YXRpYyBpbmxpbmUgdm9pZCBnZW5fZXZtd3NtaWFhKERpc2FzQ29udGV4dCAqY3R4KQ0KPiB7DQo+
ICAgICBUQ0d2X2k2NCBhY2MgPSB0Y2dfdGVtcF9uZXdfaTY0KCk7DQo+ICAgICBUQ0d2X2k2NCB0
bXAgPSB0Y2dfdGVtcF9uZXdfaTY0KCk7DQo+DQo+ICAgICBnZW5fZXZtd3NtaShjdHgpOyAgICAg
ICAgICAgLyogckQgOj0gckEgKiByQiAqLw0KPg0KPiAgICAgYWNjID0gdGNnX3RlbXBfbmV3X2k2
NCgpOw0KPiAgICAgdG1wID0gdGNnX3RlbXBfbmV3X2k2NCgpOw0KDQpJIGFwb2xvZ2l6ZSBmb3Ig
bm90IG1ha2luZyB0aGlzIGFueSBtb3JlIGNsZWFyIGluIG15IGRlc2NyaXB0aW9uLg0KDQpMZXQg
bWUga25vdyBpZiB0aGlzIGxvb2tzIGNvcnJlY3Qgbm93LCB3aXRoIHRoZSBmdWxsIGNvbnRleHQg
aW4gbWluZC4NCg0KVGhhbmtzLg0KDQpMZW9TdGVsbGEsIExMQw0KQSBqb2ludCB2ZW50dXJlIG9m
IFRoYWxlcyBBbGVuaWEgU3BhY2UgYW5kIFNwYWNlZmxpZ2h0IEluZHVzdHJpZXMNCg0KMTI1MDEg
RSBNYXJnaW5hbCBXYXkgUyDigKIgVHVrd2lsYSwgV0EgOTgxNjgNCg0KUHJvcHJpZXRhcnkgRG9j
dW1lbnQ6IFRoaXMgZG9jdW1lbnQgbWF5IGNvbnRhaW4gdHJhZGUgc2VjcmV0cyBvciBvdGhlcndp
c2UgcHJvcHJpZXRhcnkgYW5kIGNvbmZpZGVudGlhbCBpbmZvcm1hdGlvbiBvd25lZCBieSBMZW9T
dGVsbGEgTExDLiBJdCBpcyBpbnRlbmRlZCBvbmx5IGZvciB0aGUgaW5kaXZpZHVhbCBhZGRyZXNz
ZWUgYW5kIG1heSBub3QgYmUgY29waWVkLCBkaXN0cmlidXRlZCwgb3Igb3RoZXJ3aXNlIGRpc2Ns
b3NlZCB3aXRob3V0IExlb1N0ZWxsYSBMTEMgZXhwcmVzcyBwcmlvciB3cml0dGVuIGF1dGhvcml6
YXRpb24uDQpFeHBvcnQgQ29udHJvbGxlZDogVGhpcyBkb2N1bWVudCBtYXkgY29udGFpbiB0ZWNo
bmljYWwgZGF0YSB3aG9zZSBleHBvcnQgaXMgcmVzdHJpY3RlZCBieSB0aGUgQXJtcyBFeHBvcnQg
Q29udHJvbCBBY3QgKFRpdGxlIDIyLCBVLlMuQy4sIFNlYyAyNzUxIGV0IHNlcS4pIG9yIHRoZSBF
eHBvcnQgQWRtaW5pc3RyYXRpb24gQWN0IG9mIDE5NzksIGFzIGFtZW5kZWQsIFRpdGxlIDUwLFUu
Uy5DLiwgYXBwIDI0MDEgZXQgc2VxLiBWaW9sYXRpb24gb2YgdGhlc2UgZXhwb3J0IGxhd3MgYXJl
IHN1YmplY3QgdG8gc2V2ZXJlIGNyaW1pbmFsIHBlbmFsdGllcy4gUmVjaXBpZW50IHNoYWxsIG5v
dCBleHBvcnQsIHJlLWV4cG9ydCwgb3Igb3RoZXJ3aXNlIHRyYW5zZmVyIG9yIHNoYXJlIHRoaXMg
ZG9jdW1lbnQgdG8gYW55IGZvcmVpZ24gcGVyc29uIChhcyBkZWZpbmVkIGJ5IFUuUy4gZXhwb3J0
IGxhd3MpIHdpdGhvdXQgYWR2YW5jZSB3cml0dGVuIGF1dGhvcml6YXRpb24gZnJvbSBMZW9TdGVs
bGEgTExDLg0K

