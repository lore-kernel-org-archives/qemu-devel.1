Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9365C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 20:18:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 277EC2145D
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 20:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="POXS6/iO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 277EC2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG6Y4-0005zO-BM
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 16:18:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilmut@microsoft.com>)
 id 1kG6XT-0005T5-Hc
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 16:17:55 -0400
Received: from mail-dm6nam10on20702.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::702]:43233
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilmut@microsoft.com>)
 id 1kG6XR-0003Yv-A0
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 16:17:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0TweFBDrFJImzmPLML71Apvbyu4cs9OK+AaXY/eKCwdtysOG37OVB1UjsULe3rvqf9jrHf8cwXgmgOYPnpggCmHLTRrxKss7AAMvZ3d1V76259BbLcEN+f0CtKXxzDYwcExot9MI1VOGsWKfNmWMMMpce8HSelizFioXxqQKkrmkQR2cdBO4vkUvddKc8TG2iLVwHw91PWqZdqDuN243UpXdaNoAFCUAITufpsSePyItPgphkQG6SczskhhjN3OgoCAjC9uTVYqcUq9j0ItSccSbhXx6ti/hywsYDrGAQs9Vv2Zjj5t08mIuouVpmtYZctU8Ohr3LnwwSxP2i2jHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+Eie3XdiEnaAqdRARA2RtcZQZX/w6WlR6k4CHZNdI8=;
 b=BNDNC5ny4Q1xdBd5aaJPou0a/amIpgcrJQ81bfvDWByYjXEumnRgt+76fgG46TUNWo+p6rR49RwDh0gWf/ZTV5wt0SJeg0CwFulIOvj9RvMKH9kHWfkFnHP7ot0Lo5YVktVSuwiAEwjIKA5Bgi4Fu+6sX6+p8nNM0E59fnvAcatmLxRc4fFuKOtioGKvW0zLL884URpcH9SAmAnXm1L24tQCtZ3rr+Ey02GjRS7RF4+s/K9q0oT0VyUW1/OsfQYMcICiFrQurEM1GjRtIuQWBeUKSrXoaj6S2nSYMjUX88VaUe+cMqmQljgGW36aGsaEo8jWqw90hHhun5jfZNV4KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+Eie3XdiEnaAqdRARA2RtcZQZX/w6WlR6k4CHZNdI8=;
 b=POXS6/iO2kog/OaQ9hTcJd+bcN2Ftkn0b8P8nGmS1Q9++ETJSenI+NLr7lHOCd+6g8WOC0bFIRh16jVm/KxRvZzzoUxeY4B+4lPKizuC+8H5+3za8ZihsQdRd/OfirjqsF+BppF1LXJX2yHDy837Dn19RRAyDW5EubR7m9smOiI=
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 (2603:10b6:803:51::33) by SN6PR2101MB1053.namprd21.prod.outlook.com
 (2603:10b6:805:6::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.0; Wed, 9 Sep
 2020 20:12:47 +0000
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::b12a:e7a7:640e:8953]) by SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::b12a:e7a7:640e:8953%9]) with mapi id 15.20.3326.016; Wed, 9 Sep 2020
 20:12:47 +0000
From: Sunil Muthuswamy <sunilmut@microsoft.com>
To: Stefan Weil <sw@weilnetz.de>, Thomas Huth <thuth@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Paolo Bonzini <pbonzini@redhat.com>
Subject: RE: [EXTERNAL] Re: [PATCH] configure: Do not intent to build WHPX on
 32-bit host
Thread-Topic: [EXTERNAL] Re: [PATCH] configure: Do not intent to build WHPX on
 32-bit host
Thread-Index: AQHWhti6FapAYjOQakuFKDGtFJVOb6lgp3CAgAAU2uA=
Date: Wed, 9 Sep 2020 20:12:47 +0000
Message-ID: <SN4PR2101MB0880C47FA8B2B8CC2A658798C0260@SN4PR2101MB0880.namprd21.prod.outlook.com>
References: <20200909182449.360472-1-f4bug@amsat.org>
 <357d7fe2-558f-4c3d-d178-742cb9eb6e21@redhat.com>
 <0e6dc9fb-6262-926a-f730-98ac352bb789@weilnetz.de>
In-Reply-To: <0e6dc9fb-6262-926a-f730-98ac352bb789@weilnetz.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: weilnetz.de; dkim=none (message not signed)
 header.d=none;weilnetz.de; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [2601:602:9400:570:4936:5e14:3347:d0c4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 883ae233-a3d4-42dc-5e0a-08d854fcb85f
x-ms-traffictypediagnostic: SN6PR2101MB1053:
x-microsoft-antispam-prvs: <SN6PR2101MB10530AB070886455156A0BB4C0260@SN6PR2101MB1053.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JRkpnGdwfbIJJF5SnzftaYXKxef+vgME6gt86xK13sUgr60qxCVwwhLDHaKgsAwTbLQxMstJuS3XaRngjxQTkzNyHkPG/gnMSGuaVGs4CmeuEegC+UoIq+Dtpqlr086IXMDS6W6ZdujVQYekkIVIR4t29A0PsUZhW4gqNSFyUKbiq4uhp+XxpzmoMiqHO9rq0lpwvD/qV+/UFflVW0u70Rr5M+ISOWv1gEj+dIlNTpjypKgyJ8nGERLD2OyW77fdVqzZ2TKL8j9ua7QTjmWfPZyBMhoj3Lt/ULOs/XxfvizccUNHc0U4T3IzyvUguqAV4iJvltGNBT5Esa5IHnQBnzFMnYp1Trn2SgyrNmxwJT6+pz+Jho34B/jIx1xGED7x
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN4PR2101MB0880.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(71200400001)(86362001)(4326008)(82960400001)(83380400001)(66556008)(76116006)(55016002)(9686003)(64756008)(186003)(82950400001)(66946007)(66476007)(66446008)(33656002)(8936002)(10290500003)(2906002)(8676002)(478600001)(110136005)(7696005)(6506007)(52536014)(5660300002)(316002)(8990500004);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: d3SbpBqrs4bSSdJNQ3Izbfxpn2UPxScbSeRza3L9VkaZntehLEErNF9YLbvh88DgVkbZOs7otHA8A+n/cY+20TTAJm07pkcTxkMTONRO+Hs918nqJ/4aWn1EnkCM6648etEvMXNrzbQbTw/oUe/TcmBDXOfPwp5gRL/6CbPrP+QXvh0WxTjUiPd32/Col1R6uBkyknmdtvp2pKnXpJBQVJbmO3itaXdxcz1vvKrOqR69IiIEkGuCKNfYn8sEQ9iDvLgvCc9qaoiqT1mGd+kl+WMbfzP3IkTit8GWpNQs4pb5Zvdpk3YCxwH3QO2FyfVHDZfRYUBKKhwV7W87tJ66fVgf1xiKw6KETUEznYlK6FmfUc+kcNA1TH70VPrUUBYmXEiCS4jaRW3/ZQv1ATKnCF9pm7dJj2YwpTx+rV006VvDd8oJxVKKXND+ZX2JC/EBIBManltHD9vMZ0YQAb/HMAMFi2Swz6616tv6bg5+JrmgIO1ZZ7PIEw/yoaXQzdyK1joIKbBayMqQKCVx5pymsGhdb2LJiY4vPG062aBcams3MJ2YuaFz1xovSditfLE9pH9twTKQVxpNKRIYiGeWb0IvqnLQK0hk+2YXsponrWQetXZ5Dz15IWIFr5twKMOpQoM6jaQPaJUbJTCb2u56vFasi+d0Oqwt0LuBg/bL6OXse8df5SfH3Fn+qBzvKXQwwVCoWrNW/3w81u8iXiKIxQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR2101MB0880.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 883ae233-a3d4-42dc-5e0a-08d854fcb85f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2020 20:12:47.3855 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7FuPi5Mh+lwLpiMoI2mp+YqZWFS+vBkJipb+Zd9+qN5kAE0xZfSED6KghQ7EWQ3m/r255IAlBb9XyBoJWi2ZA7nPzOGadQV0XXhANxF7C8g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1053
Received-SPF: pass client-ip=2a01:111:f400:7e88::702;
 envelope-from=sunilmut@microsoft.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

U2lnbmVkLW9mZi1ieTogU3VuaWwgTXV0aHVzd2FteSA8c3VuaWxtdXRAbWljcm9zb2Z0LmNvbT4N
Cg0KPiBBbSAwOS4wOS4yMCB1bSAyMDo0MCBzY2hyaWViIFRob21hcyBIdXRoOg0KPiANCj4gPiBP
biAwOS8wOS8yMDIwIDIwLjI0LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gPj4g
SHlwZXItViBpcyBhdmFpbGFibGUgb24gNjQtYml0IHZlcnNpb25zIG9mIFdpbmRvd3MsDQo+ID4+
IGRvIG5vdCB0cnkgdG8gYnVpbGQgaXRzIHN1cHBvcnQgb24gMzItYml0IHZlcnNpb25zLg0KPiA+
Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8ZjRidWdAYW1z
YXQub3JnPg0KPiA+PiAtLS0NCj4gPj4gIGNvbmZpZ3VyZSB8IDMgKysrDQo+ID4+ICAxIGZpbGUg
Y2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9jb25maWd1
cmUgYi9jb25maWd1cmUNCj4gPj4gaW5kZXggNDIzMWQ1NmJjYzAuLjRiZDA4ZjU0NjliIDEwMDc1
NQ0KPiA+PiAtLS0gYS9jb25maWd1cmUNCj4gPj4gKysrIGIvY29uZmlndXJlDQo+ID4+IEBAIC0y
OTg5LDYgKzI5ODksOSBAQCBpZiB0ZXN0ICIkd2hweCIgIT0gIm5vIiA7IHRoZW4NCj4gPj4gICAg
ICAgICAgZmkNCj4gPj4gICAgICAgICAgd2hweD0ibm8iDQo+ID4+ICAgICAgZmkNCj4gPj4gKyAg
ICBpZiB0ZXN0ICIkd2hweCIgPSAieWVzIiAmJiB0ZXN0ICIkQVJDSCIgPSAiaTM4NiI7IHRoZW4N
Cj4gPj4gKyAgICAgIGVycm9yX2V4aXQgIldIUFggcmVxdWlyZXMgNjQtYml0IGhvc3QiDQo+ID4+
ICsgICAgZmkNCj4gPj4gIGZpDQo+ID4gSSB0aGluayB5b3Ugc2hvdWxkIGFsc28gYWRkIGEgY2hl
Y2sgdG8gdGhlIE1JTkdXMzIgY2FzZSAoc2VlIGNvbW1pdA0KPiA+IGU3YTIyMmFlYjgxM2EpIHRv
IHByZXZlbnQgdGhhdCB0aGUgYXV0b21hdGljIGRldGVjdGlvbiBraWNrcyBpbiAoc28gdGhhdA0K
PiA+IHlvdSB3b3VsZCBlbmQgdXAgd2l0aCB0aGlzIGVycm9yIG1lc3NhZ2UgZXZlbiBpZiB5b3Ug
ZGlkIG5vdCBzcGVjaWZ5DQo+ID4gLS1lbmFibGUtd2hweCkNCj4gPg0KPiA+ICBUaG9tYXMNCj4g
Pg0KPiANCj4gWWVzLCB0aGF0J3MgZGVmaW5pdGVseSByZXF1aXJlZC4gVGhlIGF1dG9tYXRpYyBk
ZXRlY3Rpb24gY3VycmVudGx5DQo+IGVuYWJsZXMgV0hQWCBmb3IgMzIgYml0IGJ1aWxkcywgdG9v
Lg0KPiANCj4gU3RlZmFuDQo+IA0KDQo=

