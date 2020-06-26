Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235E9C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 10:20:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2E1C20DD4
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 10:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="kMYUsNvA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2E1C20DD4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jolSw-00088h-6k
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 06:20:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jolS7-0007eL-KN
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 06:19:23 -0400
Received: from mail-bn8nam12on2041.outbound.protection.outlook.com
 ([40.107.237.41]:16140 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jolS3-0008Fg-24
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 06:19:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m2zvI/vprbfq1Ui2O5sPCM96Z0LIeRC5CoT4mop68FBgfKDAtPf47dAK5CwDI3GMrwKLCMJ5USC8TSW44nb3xdB9zM5cK3caR40t/WpP1vFAKvPCxm4bVlJDh6/D4SLC7GbxAWFN88FYDW0WMbWEAOTzFU0oQf4bQNpFkGpN9Fkip4mLAAbrCgNm/Hl48/aT0ktIIEeC1Dsk4ucwZWC2wJoTZDrAjhqhqKOtuzJab+Cz7jy4N2ocLHfMvY7xpWNVaF4sfJUChne7LopWWpQaiJGXbRzuLw5Ylg3NSAhUVMSxr6wgFR1f0b6J7f5fxP4E0u0a137LzEr6daxFUDYBSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Se7fOwZTVbauTOEdp+S+8oQcPlLPR0QmowKy/TUOuvk=;
 b=EOfQPcQ/q2AqrAy121BxQ7qZDGPuOZfwjojOZ/phDcFaOfrkkRLvp5gPQce4/c7KuzAJKINSs21QcwYAfVhwvogx2uXHCpfY8+M+t9DXHT0VpxMtcL/aHXta3Rzr06dblhkfPBFPLVOvcIox0nVbKzAf79rytgc915hurarFO3/rXOYhM6muSOPJxsSoRbdECIRXT2tNlbZYKucFy+siztO3Zh0F1Sp5zWSmIJyOnk+PPechMM/HZb8Ep6uNAtg/YtHXNngvOhYMe/0npMvcQe3fYy0WbBrpxlFvIxAT6mOUFsYxlEYKsAKekUK6d8RMCVoAhyNxPJwsiDmlCzTn0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Se7fOwZTVbauTOEdp+S+8oQcPlLPR0QmowKy/TUOuvk=;
 b=kMYUsNvApLQDfuDa+JorsIivPuLbBCDyk4Eaoyn/YsNAB5L0fBDGZaNpdf65IWFowr9bNg1NmuUUCIze8k6ZK311tm3f6uKh0F6XAa6gnS+XeQ+GPVEwrGUKjHAVHULyD1xToX7EiJYh9a0E/dNCqwq30XQ+XMs98hb1hUrMZJ0=
Received: from BY5PR02MB6772.namprd02.prod.outlook.com (2603:10b6:a03:206::11)
 by BYAPR02MB5541.namprd02.prod.outlook.com (2603:10b6:a03:a6::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Fri, 26 Jun
 2020 10:19:15 +0000
Received: from BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::4477:7134:37a6:c828]) by BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::4477:7134:37a6:c828%3]) with mapi id 15.20.3131.024; Fri, 26 Jun 2020
 10:19:15 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: RE: [PATCH v2 3/3] usb/hcd-xhci: Split pci wrapper for xhci base model
Thread-Topic: [PATCH v2 3/3] usb/hcd-xhci: Split pci wrapper for xhci base
 model
Thread-Index: AQHWSshDrYoefVt0mk6gEfaCZTEJaajpoDjAgADLyH+AAAVdsA==
Date: Fri, 26 Jun 2020 10:19:15 +0000
Message-ID: <BY5PR02MB6772B9C9031FD35A9FA8A969CA930@BY5PR02MB6772.namprd02.prod.outlook.com>
References: <1593008176-9629-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1593008176-9629-4-git-send-email-sai.pavan.boddu@xilinx.com>
 <87y2obzhsc.fsf@dusky.pond.sub.org>
 <BY5PR02MB67723A0D247E4D2BC60A0710CA920@BY5PR02MB6772.namprd02.prod.outlook.com>
 <871rm2tkxn.fsf@dusky.pond.sub.org>
In-Reply-To: <871rm2tkxn.fsf@dusky.pond.sub.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ed5a681f-5481-4a4a-a037-08d819ba610a
x-ms-traffictypediagnostic: BYAPR02MB5541:
x-microsoft-antispam-prvs: <BYAPR02MB5541BA08256A028D148785CBCA930@BYAPR02MB5541.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0446F0FCE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GgxEcb6rdVDaIFc7VzNv1LPiTicb7TRBrSMQAyeACyVaRAqINhlPSxyXu5X4OMKb2lgxGNAH2SW+aUF2gsJfyIH9+WcgNO45LOoEq2gqe+LGMTy+mv4FYUCZ1G4q9oo+YVCWJpLNITVF25fWPFmt6HwqzXSrWQH4ARlMnq8rg+65B0lxUjy61hj/1Hu4JhtqwfI8/5uMGlvbKroB7GKpvk9FZFQASyEDT6yng36a6S/JJRWKkeDDNJ9xwn+C13Iyk9SgCvirlYSts8XjRC31VXzklA2+FkZLN+RATHM4TLCezkbAHd8oHuJWkFShQlglpDUfT2navTBlIa7R7bU7cg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6772.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(376002)(396003)(366004)(136003)(39860400002)(346002)(7696005)(186003)(26005)(6506007)(478600001)(316002)(8936002)(5660300002)(2906002)(9686003)(33656002)(64756008)(76116006)(66446008)(66556008)(8676002)(54906003)(52536014)(71200400001)(6916009)(66946007)(4326008)(86362001)(55016002)(7416002)(83380400001)(66476007)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: fA4azR9T9NxIQHaWssX2790jEMJCAgcefSPeTy3QQ+SaSwK3proSb3vtBvJHNK+OYopxZ0to+Fw4yxxq97MzUpBuMNrzcQwX0V8t02e9gXmLBu+/Txfs9VFUUaK/YaYjuyiEbhEGiSgk3E4DnSxw/POmtfl+p+shPp6tKdSqpx0iw+IAAbDpVtP3jLqosZ/fiIF0DJwcglbqzUhOPb6HBLf6ugBR7/YIS8u2yvdQYj4BSTT9gbVj0+6JbgEagmjVzF/zcbb9Q88fNbegzvnZzJfVZEBSBk2UaDpJlZzcpkiRTHk4fOrjL36ID6opx/WyiGHOLfQB8i8cVkoyZyK3eH5HH/mHMNt/0PZ7rGf1lH3s/e0s2JFE2qez30YhRwA6MtgMmxltOwzuljEWoB3L7j3RMmFbiwLoUPtAo+nmroF4dRyR2vhaEv6++L+TdLHMF+CTlb3WLk8i3rbRgAe3xlUC91A0jHTyF5eGoQTdqdhThItvhbqZmHV3Z7icWD2j
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed5a681f-5481-4a4a-a037-08d819ba610a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2020 10:19:15.4582 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: InXiiDDdQ4dM1MGxMzxcc7SEqilcDEk5Ps3vknYGJnYZt+2eCfj4ZGzWKW9LwhMdUeWE+Oa1SdzihszmVxWumw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5541
Received-SPF: pass client-ip=40.107.237.41; envelope-from=saipava@xilinx.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 06:19:16
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?utf-8?B?J01hcmMtQW5kcsOpIEx1cmVhdSc=?= <marcandre.lureau@redhat.com>,
 Ying Fang <fangying1@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?B?J1BoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpJw==?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SEkgTWFya3VzLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmt1
cyBBcm1icnVzdGVyIDxhcm1icnVAcmVkaGF0LmNvbT4NCj4gU2VudDogRnJpZGF5LCBKdW5lIDI2
LCAyMDIwIDExOjQyIEFNDQo+IFRvOiBTYWkgUGF2YW4gQm9kZHUgPHNhaXBhdmFAeGlsaW54LmNv
bT4NCj4gQ2M6IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz47IFRob21h
cyBIdXRoDQo+IDx0aHV0aEByZWRoYXQuY29tPjsgRWR1YXJkbyBIYWJrb3N0IDxlaGFia29zdEBy
ZWRoYXQuY29tPjsgcWVtdS0NCj4gZGV2ZWxAbm9uZ251Lm9yZzsgQWxpc3RhaXIgRnJhbmNpcyA8
YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPjsgR2VyZA0KPiBIb2ZmbWFubiA8a3JheGVsQHJlZGhh
dC5jb20+OyBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPjsNCj4gWWluZyBGYW5n
IDxmYW5neWluZzFAaHVhd2VpLmNvbT47ICdNYXJjLUFuZHLDqSBMdXJlYXUnDQo+IDxtYXJjYW5k
cmUubHVyZWF1QHJlZGhhdC5jb20+OyAnUGhpbGlwcGUgTWF0aGlldS1EYXVkw6knDQo+IDxwaGls
bWRAcmVkaGF0LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAzLzNdIHVzYi9oY2QteGhj
aTogU3BsaXQgcGNpIHdyYXBwZXIgZm9yIHhoY2kgYmFzZQ0KPiBtb2RlbA0KPiANCj4gU2FpIFBh
dmFuIEJvZGR1IDxzYWlwYXZhQHhpbGlueC5jb20+IHdyaXRlczoNCj4gDQo+ID4gSGkgTWFya3Vz
LA0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IE1hcmt1
cyBBcm1icnVzdGVyIDxhcm1icnVAcmVkaGF0LmNvbT4NCj4gPj4gU2VudDogVGh1cnNkYXksIEp1
bmUgMjUsIDIwMjAgMTo0MiBQTQ0KPiA+PiBUbzogU2FpIFBhdmFuIEJvZGR1IDxzYWlwYXZhQHhp
bGlueC5jb20+DQo+ID4+IENjOiBHZXJkIEhvZmZtYW5uIDxrcmF4ZWxAcmVkaGF0LmNvbT47IFBl
dGVyIE1heWRlbGwNCj4gPj4gPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz47IFRob21hcyBIdXRo
IDx0aHV0aEByZWRoYXQuY29tPjsNCj4gRWR1YXJkbw0KPiA+PiBIYWJrb3N0IDxlaGFia29zdEBy
ZWRoYXQuY29tPjsgcWVtdS1kZXZlbEBub25nbnUub3JnOyBBbGlzdGFpcg0KPiA+PiBGcmFuY2lz
IDxhbGlzdGFpci5mcmFuY2lzQHdkYy5jb20+OyAnTWFyYy1BbmRyw6kgTHVyZWF1Jw0KPiA+PiA8
bWFyY2FuZHJlLmx1cmVhdUByZWRoYXQuY29tPjsgWWluZyBGYW5nIDxmYW5neWluZzFAaHVhd2Vp
LmNvbT47DQo+ID4+IFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5jb20+OyAnUGhpbGlw
cGUgTWF0aGlldS1EYXVkw6knDQo+ID4+IDxwaGlsbWRAcmVkaGF0LmNvbT4NCj4gPj4gU3ViamVj
dDogUmU6IFtQQVRDSCB2MiAzLzNdIHVzYi9oY2QteGhjaTogU3BsaXQgcGNpIHdyYXBwZXIgZm9y
IHhoY2kNCj4gPj4gYmFzZSBtb2RlbA0KPiA+Pg0KPiA+PiBTYWkgUGF2YW4gQm9kZHUgPHNhaS5w
YXZhbi5ib2RkdUB4aWxpbnguY29tPiB3cml0ZXM6DQo+ID4+DQo+ID4+ID4gVGhpcyBwYXRjaCBz
ZXRzIHRoZSBiYXNlIHRvIHVzZSB4aGNpIGFzIHN5c2J1cyBtb2RlbCwgZm9yIHdoaWNoIHBjaQ0K
PiA+PiA+IHNwZWNpZmljIGhvb2tzIGFyZSBtb3ZlZCB0byBoY2QteGhjaS1wY2kuYy4gQXMgYSBw
YXJ0IG9mIHRoaXMNCj4gPj4gPiByZXF1aXJtZW50IG1zaS9tc2l4IGludGVycnVwdHMgaGFuZGxp
bmcgaXMgbW92ZWQgdW5kZXINCj4gPj4gPiBYSENJUENJU3RhdGUsIGFuZCBYSENJU3RhdGUgaXMg
IG5vbiBxb20gb2JqZWN0LCBtYWtlIHVzZSBvZg0KPiA+PiA+ICdjb250YWluZXJfb2YnIGNhbGxz
IHRvIHJldHJpdmUgWEhDSVBjaVN0YXRlLiBNYWRlIHJlcXVpcmVkIGNoYW5nZXMgZm9yDQo+IHFl
bXUteGhjaS1uZWMuDQo+ID4+ID4NCj4gPj4gPiBTaWduZWQtb2ZmLWJ5OiBTYWkgUGF2YW4gQm9k
ZHUgPHNhaS5wYXZhbi5ib2RkdUB4aWxpbnguY29tPg0KPiA+Pg0KPiA+PiBJIGNhbid0IHNlZSBh
ICJzeXNidXMgbW9kZWwiLiAgV2hhdCBJIGNhbiBzZWUgaXMNCj4gPj4NCj4gPj4gICAgICAgICAg
VFlQRV9ERVZJQ0UNCj4gPj4gICAgICAgICAgICAgICB8DQo+ID4+ICAgICAgICBUWVBFX1BDSV9E
RVZJQ0UNCj4gPj4gICAgICAgICAgICAgICB8DQo+ID4+ICAgICAgICAgVFlQRV9YSENJX1BDSSAo
cmVuYW1lZCBmcm9tIFRZUEVfWEhDSSkNCj4gPj4gICAgICAgICAgIC8gICAgICAgXA0KPiA+PiBU
WVBFX1FFTVVfWEhDSSBUWVBFX05FQ19YSENJDQo+ID4+DQo+ID4+IEFsbCBidXQgdGhlIHR3byBs
ZWF2ZXMgYXJlIGFic3RyYWN0Lg0KPiA+Pg0KPiA+PiBEbyB5b3UgaW50ZW5kIHRvIGFkZCBhICJz
eXNidXMgbW9kZWwiIGluIGEgZnV0dXJlIHBhdGNoPw0KPiA+IFtTYWkgUGF2YW4gQm9kZHVdICBZ
ZXMuIEkgd291bGQgYmUgc2VuZGluZyBpdCBhbG9uZyB3aXRoIHRoYXQgYSBkZXZpY2UNCj4gPiB3
aGljaCB3b3VsZCBiZSB1c2luZyBpdC4gKGkuZSBmb3IgenlucW1wIHNvYyApIExldCBtZSBrbm93
LCBpZiBpdHMgZ29vZCB0bw0KPiBpbmNsdWRlIGhjZC14aGNpLXN5c2J1cy5jIGhlcmUgPw0KPiAN
Cj4gSSdtIG5vdCBzdXJlIHRoaXMgc2VyaWVzIGlzIHdvcnRod2hpbGUgdGhpcyBmdXR1cmUgcGF0
Y2guICBVcCB0byB0aGUgbWFpbnRhaW5lci4NCj4gDQo+IEhlcmUncyBhIGNsZWFuIHdheSB0byBw
cm92aWRlIGRpZmZlcmVudCBidXMgY29ubmVjdG9ycyAoc2F5IFBDSSBhbmQNCj4gc3lzYnVzKSBm
b3IgdGhlIHNhbWUgY29yZSBkZXZpY2U6DQo+IA0KPiBNYWtlIHRoZSBjb3JlIGRldmljZSBhIFRZ
UEVfREVWSUNFLg0KPiANCj4gRm9yIGVhY2ggZGVzaXJlZCBidXMsIGhhdmUgYSBidXMtc3BlY2lm
aWMgZGV2aWNlIHRoYXQgY29udGFpbnMgYSBjb3JlIGRldmljZS4NCj4gVXNlIG9iamVjdF9pbml0
aWFsaXplX2NoaWxkKCkgZm9yIHRoZSBjb21wb25lbnQuDQpbU2FpIFBhdmFuIEJvZGR1XSBUaGlz
IHdhcyBteSBWMSBpbXBsZW1lbnRhdGlvbi4NCkNoYW5nZWQgaXQgdG8gbm9uLXFvbSBzdHJ1Y3R1
cmUgYWZ0ZXIgc29tZSBmZWVkYmFjayBmcm9tIEBHcmVkLiBGZWx0IGxpa2UgWEhDSVN0YXRlIHdp
bGwgbm90IGJlIHVzZWQgc3RhbmRhbG9uZS4NCg0KVGhhbmtzLA0Kc2FpIFBhdmFuDQo+IA0KPiBF
eGFtcGxlOiBjb3JlIGRldmljZSBUWVBFX1NFUklBTCwgUENJIGRldmljZSBUWVBFX1BDSV9TRVJJ
QUwsIElTQSBkZXZpY2UNCj4gVFlQRV9JU0FfU0VSSUFMLCBzeXNidXMgZGV2aWNlcyBUWVBFX1NF
UklBTF9JTy4gVFlQRV9TRVJJQUxfTU0uDQoNCg==

