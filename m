Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101CFC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 23:47:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA1CA206D4
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 23:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="U7dsbw4E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA1CA206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1ejr-0001Zw-3H
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 19:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilmut@microsoft.com>)
 id 1k1ejE-0001Ap-2s
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 19:46:20 -0400
Received: from mail-bn8nam12on2118.outbound.protection.outlook.com
 ([40.107.237.118]:1633 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilmut@microsoft.com>)
 id 1k1ejB-0003Na-F6
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 19:46:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQ2bRnG3AamMgPEA7w+Tozig/9dTvQJmxDGOhFlx26GunR6/+Sz0413NzBiZkOKiJOQMSRWpSFqtZIFAbDnfRW8VEznb1O+9ce9PH0XKqvLFC5llLUmFfojf0Ry0fBAa7Q8asYTLf8HgfKqAQi9pxqQqnwsAp06LknZK21HS6LmeNk/GbDR+dCFfsCdQNEkwHwD61OXsTKUBTzHfIBClwVbTPZKcoHh4wANvd7y16kx3uucV4C960e6k0jWud2SC9GK9Xq/cZc6SY7FFW8lfymYFMLGEnA2hoeyUptGHO/MQFJnuS/q2gRU1+WcV3fHjdZjLEeznqurLKLjgbfJBuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pzdf1AfaT8FcMs4bG4Avg0fY5VZB2Zrb1oHuxQ7D9P4=;
 b=LT6PQr9BjzV7V2u5qQ1/L6S21Ff98ZvP0BvD8O0FOXzEsdTUfxW+udN9dB1psL4CPBlwuqcuGm5qdyuDOkkE3K6N5nRu3sSZB5CdzFojeBc7ybPH5YqJSUYCe2Rl4+1hjf0edHdzxyIUdEr1V8NLn07njQNRGdISdF5e2SbzoqqTkC84cZ4luoD7lpJ+Tw6ElY5aJ1XPSWDllsjkatGmN5CrINSj61+5BeDphJtX68GMFcOssOkj63mWinEUFdOA2Jlc1ggvbN3o4TQTJdDxd2ho7Ivs/hQz/38eHOWytL3BHGDs87ONYN4a4k7zcrbhdAtO0F0MTPBQMMs4wKqCdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pzdf1AfaT8FcMs4bG4Avg0fY5VZB2Zrb1oHuxQ7D9P4=;
 b=U7dsbw4EIegcHNRFyau9NwpbrT9PR6FgMdjojBpUGQZ9irzoygishpfcL5wx1zPAk77JqPCbtaPJuqToS40B+2pJtqpv3r+SZzQCIvJoFV+umwuXCMaGc3griAK+PW+ZjZKFbKWffJtNRnSg1BSUq4J8Cg51xXgRwIIY/HOO0gw=
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 (2603:10b6:803:51::33) by SN6PR2101MB0894.namprd21.prod.outlook.com
 (2603:10b6:805:9::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.0; Fri, 31 Jul
 2020 23:31:11 +0000
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::99a:30fe:609e:be35]) by SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::99a:30fe:609e:be35%8]) with mapi id 15.20.3239.020; Fri, 31 Jul 2020
 23:31:10 +0000
From: Sunil Muthuswamy <sunilmut@microsoft.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: =?utf-8?B?RGFuaWVsIFAgLiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Fam Zheng
 <fam@euphon.net>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, "1879672@bugs.launchpad.net"
 <1879672@bugs.launchpad.net>
Subject: RE: [EXTERNAL] Re: [PATCH v2 0/3] testing: Build WHPX enabled binaries
Thread-Topic: [EXTERNAL] Re: [PATCH v2 0/3] testing: Build WHPX enabled
 binaries
Thread-Index: AQHWZxVKeot30QB7QUymyE/5azx7WKkiVYjw
Date: Fri, 31 Jul 2020 23:31:10 +0000
Message-ID: <SN4PR2101MB0880AF5A5D752F06DB94A15FC04E0@SN4PR2101MB0880.namprd21.prod.outlook.com>
References: <20190920113329.16787-1-philmd@redhat.com>
 <01f2f0ee-a288-921a-58f4-78aeb4d457e1@redhat.com>
 <BYAPR21MB1208F0D09B3E5CA80F1B7C3BB6880@BYAPR21MB1208.namprd21.prod.outlook.com>
 <2acf854f-c49a-0811-31af-80e1e958f058@redhat.com>
 <324f5002-be0a-563e-b5a6-e08ee5e1ddad@redhat.com>
In-Reply-To: <324f5002-be0a-563e-b5a6-e08ee5e1ddad@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [2601:602:9400:570:948b:471c:3b83:44f3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: edadf8cc-e390-4bbd-b755-08d835a9cee4
x-ms-traffictypediagnostic: SN6PR2101MB0894:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB0894D16B055FAC15A4D8B9D5C04E0@SN6PR2101MB0894.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN4PR2101MB0880.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(39860400002)(346002)(136003)(396003)(6506007)(5660300002)(8936002)(53546011)(55016002)(4326008)(86362001)(8676002)(7416002)(33656002)(52536014)(66446008)(76116006)(478600001)(71200400001)(2906002)(186003)(8990500004)(10290500003)(9686003)(82950400001)(316002)(83380400001)(54906003)(66946007)(110136005)(64756008)(66556008)(66476007)(7696005)(82960400001);
 DIR:OUT; SFP:1102; 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR2101MB0880.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edadf8cc-e390-4bbd-b755-08d835a9cee4
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2020 23:31:10.8286 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AxZnOSGLILGUhLtVXNDWzYlBixfMtiQMiPLMGhQPbipMHLO/24EYH8h7iDwX7xKhW/IgArQc2k6X0VGNsAqxTRAkcbwhK9v5hegJg47neCU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB0894
Received-SPF: pass client-ip=40.107.237.118;
 envelope-from=sunilmut@microsoft.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 19:46:15
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

PiBIaSBKdXN0aW4sIFN1bmlsLA0KDQpKdXN0aW4gaGFzIG1vdmVkIHRvIGEgZGlmZmVyZW50IHRl
YW0gaXMgbm8gbG9uZ2VyIHdvcmtpbmcgd2l0aCBXSFBYLiBNb3ZpbmcgaGltDQp0byBiY2MuDQoN
Cj4gDQo+IE9uIDUvMjAvMjAgMTI6MjYgUE0sIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3Rl
Og0KPiA+ICtsYXVuY2hwYWQgdGlja2V0DQo+ID4NCj4gPiBPbiA5LzIwLzE5IDY6NTMgUE0sIEp1
c3RpbiBUZXJyeSAoVk0pIHdyb3RlOg0KPiA+PiBIZXkgUGhpbCwNCj4gPj4NCj4gPj4gSSBoYXZl
IGNvbnRhY3RlZCBvdXIgbGVnYWwgZGVwYXJ0bWVudCBmb3IgZ3VpZGFuY2Ugb24gdGhpcyBzcGVj
aWZpYw0KPiA+PiB1c2UgY2FzZSBhbmQgd2lsbCB1cGRhdGUgeW91IHdoZW4gSSBoZWFyIGJhY2su
IFRoYW5rIHlvdSBmb3IgeW91cg0KPiA+PiBwYXRpZW5jZS4NCj4gDQo+IEkgcmVjZW50bHkgdW5k
ZXJzdG9vZCBsZWdhbCBjaGFuZ2VzIGNhbiBiZSB2ZXJ5IGNvbXBsZXgsIHRodXMgaXQgaXMNCj4g
aW1wbGljaXQgaXQgY2FuIHRha2UgeWVhcnMgYmVmb3JlIGdldHRpbmcgdXBkYXRlcy4NCj4gDQo+
IFNpbmNlIHRoZSBwcm9qZWN0IGlzIHN0aWxsIGFjdGl2ZWx5IGRldmVsb3BlZCwgbWF5YmUgeW91
IGNvdWxkIHByb3ZpZGUNCj4gYSBBenVyZSBDSSBqb2IgdG8gYnVpbGQgYSBXSFBYIGJpbmFyeS4g
V2UgZG9uJ3QgbmVlZCB0byBoYXZlIGFjY2VzcyB0bw0KPiB0aGUgYmluYXJ5LCBqdXN0IHRvIHRo
ZSBleGl0IHN0YXR1cyAoc3VjY2Vzcy9mYWlsKSBhbmQgYnVpbGQgbG9ncy4NCj4gDQo+IERvIHlv
dSB0aGluayBpdCBpcyBkb2FibGU/DQo+IA0KPiBUaGFua3MsDQo+IA0KPiBQaGlsLg0KPiANClRo
ZSBhc2sgZ2VuZXJhbGx5IHNvdW5kcyByZWFzb25hYmxlLiBCdXQsIGNhbiB5b3UgaGVscCBtZSB1
bmRlcnN0YW5kIHRoZSBmdWxsDQpzY29wZSBvZiB0aGUgYXNrLiBGZXcgcXVlc3Rpb25zOg0KMS4g
U3RlZmFuIGhhcyBhIENJIHBpcGVsaW5lIHRvIGJ1aWxkIFdIUFguIFdoYXQncyB0aGUgYmVuZWZp
dCBvZiBoYXZpbmcgYW5vdGhlciBDSQ0Kam9iLCB0aGF0IGRvZXNuJ3QgZXhwb3J0IHRoZSBiaW5h
cnksIGJ1dCwganVzdCB0aGUgc3RhdHVzPw0KMi4gV2hpY2ggYnJhbmNoIGlzIHRoZSBDSSBwaXBl
bGluZSBleHBlY3RlZCB0byBidWlsZD8NCjMuIElzIHRoZSBleHBlY3RhdGlvbiBhbHNvIHRoYXQg
aXQgd2lsbCBidWlsZCBXSFBYIHBhdGNoZXMgdGhhdCBhcmUgc3VibWl0dGVkIHRvIHRoZQ0KV0hQ
WCBicmFuY2g/DQo=

