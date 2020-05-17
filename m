Return-Path: <SRS0=EQsI=67=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8392CC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 08:04:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 374AC2067D
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 08:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bt.com header.i=@bt.com header.b="hJGHyTTI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 374AC2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaEHc-0008Ax-D2
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 04:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasper.lowell@bt.com>)
 id 1jaEGw-0007js-Vy
 for qemu-devel@nongnu.org; Sun, 17 May 2020 04:03:47 -0400
Received: from smtpe1.intersmtp.com ([213.121.35.74]:29424)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasper.lowell@bt.com>)
 id 1jaEGu-0000zy-VD
 for qemu-devel@nongnu.org; Sun, 17 May 2020 04:03:46 -0400
Received: from tpw09926dag06f.domain1.systemhost.net (10.9.202.25) by
 BWP09926079.bt.com (10.36.82.110) with Microsoft SMTP Server (version=TLS1_2, 
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1713.5; Sun, 17
 May 2020 08:57:15 +0100
Received: from tpw09926dag08g.domain1.systemhost.net (10.9.202.43) by
 tpw09926dag06f.domain1.systemhost.net (10.9.202.25) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Sun, 17 May 2020 08:57:37 +0100
Received: from bwp09926077.bt.com (10.36.82.108) by
 tpw09926dag08g.domain1.systemhost.net (10.9.202.43) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4 via Frontend Transport; Sun, 17 May 2020 08:57:37
 +0100
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (104.47.21.54) by
 smtpe1.intersmtp.com (10.36.82.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.1.1713.5; Sun, 17 May 2020 08:57:15 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7aY9aSL2+B2Quk8Ae8e1l3h33vKZFW42enT6lz33LBKRgXvIsSQu0PUrycntSXhWVBg9PlBJgBb57JOl0UhQ1HBQ9ChGLhIvqe0CDbgdnoKqxLJAMyHnxS3AfgaeEB7UVG6OmGUz6m/9gPh3UDP3arDf1remqBaTNCZ0CW617CsYpqXGygZjBTFIULWtG7cjsR7GNjry9v6MMwz6RsOfixCeeQnqcHS0qlGjW8rtbjlA6740Sfwh2eRpcQZD4jkETAOuWCD1fi+IWQGc7xVTsojX6eULjWl6GK1mtmor9fXFAMpzlf6TNBCILBWzCYsgN2SaKtwkI4KDwi4f3acfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kaYmZUWetPIS1/jY24ZfZzWa6mzkyzVCXcERH95DkZM=;
 b=fqYBnbSIVwfwkVd+1kq35BejWXOKVIh1RR3XtajaTXP74mHbygZbck/hK2lTek5EnWPtbpo8vQb/ZNJd3pB2IgExz6g9F8WObd6SLBNjPw4xwsca1dMFdiezLe+G1IINKfaFpL+D+RWvnLBcgFKSfxoCnbqObiMSSlHjGz2d99eLO9My8/pk+hP+TAgO63hjkR9sfNeVvmNgSBKUvGbTCGjy5UF5Nt2OpvxNawkytfem68zbjyHbFHQr5UqVWTRK5E0OxvNuBoly/4aymS5RMJkMN3qDC/0hbeM9c9GB5GjsOhMAIdpgNKpJ0/hNNk4qLAMTNUl9dZ8G4eVGwKE4eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bt.com; dmarc=pass action=none header.from=bt.com; dkim=pass
 header.d=bt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bt.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kaYmZUWetPIS1/jY24ZfZzWa6mzkyzVCXcERH95DkZM=;
 b=hJGHyTTIpJ/1GyF+X8IT7t2mIeSmf1knZKdJOaiOPBXHtw794z6mBA9ZeH2aY12YQW8CD+osO3tb2FmSOZsOjq4gddQszZ35hcWwisa9ljMireMSQ0AuOgy+WPyh1C932cMyK0NFkMu56w9mAOQrrARxMDeIoaI0/JkgJDqSMs0=
Received: from CWXP123MB1958.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:7b::18)
 by CWXP123MB2565.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:80::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24; Sun, 17 May
 2020 07:57:34 +0000
Received: from CWXP123MB1958.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f132:e811:f232:2bdf]) by CWXP123MB1958.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f132:e811:f232:2bdf%7]) with mapi id 15.20.3000.022; Sun, 17 May 2020
 07:57:34 +0000
From: <jasper.lowell@bt.com>
To: <peter.tribble@gmail.com>, <mark.cave-ayland@ilande.co.uk>,
 <atar4qemu@gmail.com>
Subject: Re: Emulating Solaris 10 on SPARC64 sun4u
Thread-Topic: Emulating Solaris 10 on SPARC64 sun4u
Thread-Index: AdXb7aKPCyPc5BgLRMag+zXZgy3FKQDThhmAEVAOwAAAASBWgAAYKG4AAA0xpYAACkUqgABNi1OAAA3dmwABXQ4+gA==
Date: Sun, 17 May 2020 07:57:34 +0000
Message-ID: <feaccbcfcd5a36d1024e91e40bef6eb6f359a628.camel@bt.com>
References: <CWXP123MB2262B6F3159B7AA7AB010F4183020@CWXP123MB2262.GBRP123.PROD.OUTLOOK.COM>
 <f0f00ecd-1989-9bc1-02e0-8a9b4819f051@ilande.co.uk>
 <f833edcfed7dd58a6bb27269de66acfed0e550eb.camel@bt.com>
 <CACXAS8D9CAo3oGKHdA0qvxs9g9rTJMdYKtJrhw7QqHA6jvtYYg@mail.gmail.com>
 <81bfbfd669c652657421f66a30d144d02d8fa79d.camel@bt.com>
 <CAEgYsbHejSdBiL0o-AOLURhcMw+BHyFeZskmAV4w1cN6V46N3A@mail.gmail.com>
 <CACXAS8D5YLs2BMHBR39h_XEsMZ4n7XpDE+FSdKBLDgxFGpwzbQ@mail.gmail.com>
 <3926d33de12c70af150c9e9e2d75bda69e971546.camel@bt.com>
 <34b47695-c61e-360a-ffc4-6171e25a7c0a@ilande.co.uk>
In-Reply-To: <34b47695-c61e-360a-ffc4-6171e25a7c0a@ilande.co.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=bt.com;
x-originating-ip: [217.138.204.117]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2bf711a4-78a4-4198-1127-08d7fa37f5b7
x-ms-traffictypediagnostic: CWXP123MB2565:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CWXP123MB2565A2390C97BE8D875461AF83BB0@CWXP123MB2565.GBRP123.PROD.OUTLOOK.COM>
x-antispam-2: 1
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 040655413E
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uBt0ZYerfADxk26xZ6kRJKivvZJX2H/4I+MLoOHiZZQkDUcWiu9wd9NT7yvRs16Z08Q3CAc+8MpaEju9M6V6mVwnjWNT1ZD8Kf3yzR6d2WbuGeFzm9/0tpMF89+F+AYZllcSOTpFg9SuNZ6tsYDyC9MUyiGHfmq2l+Rj10wR+jOMuAe+vWt0IarskShlXQZuFgkktsBAGZZ14pZDKqDcahmxl79ceTBRwLEz2yQsxG7jFukeRNgfxCP7cPPSdwmjoZpHmhnr9Ev2TZOHWdoIUiljwVh3lvC1Up3DvX3Kt1qRdK+qQaYcg6+XNUzqsqHPPoj054zuIhDlJhUf0hVI3Kf+PUZhhGq+KSZkaxjEqL8xshYCRK9xWX2aZQFzqxNhUEc73nFOQdV2BtFR/Cn18OCdNgJ/mAgoc1TOhZOIUd87GstUZQ+K+gyk3fOkLoikrkiFRBdtfyKN1ubUDVbx+wBufGSKsYVcgY2Pd/OuUHHUefP9EEBBETp9SaDmivYR
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWXP123MB1958.GBRP123.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(66946007)(91956017)(6506007)(76116006)(66476007)(26005)(186003)(53546011)(66446008)(64756008)(66556008)(5660300002)(36756003)(4326008)(478600001)(8936002)(2616005)(6512007)(8676002)(2906002)(86362001)(110136005)(54906003)(316002)(6486002)(71200400001)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: QzULQphrjeONjpWlTlvcOyQy4Ed4NXS0HqJCa0jMaZ0RPgu5t9FoNLPiOUTUFGUXXSKfc/agkikrO2QnyvvjL8hMoSsAAYyqIW3K/05U1hocse1+YETw3tuZN/5uRs8E1Gczd/Cbs4xXTTUuDlWwlZnTjUZNroyLhYV3IPi1uxT/REre3k8SilD7qihm9/BbwFOYACW8YsnlR87JHwk/cthycIBGMxjVgiv927tdOkdRv44GWVBGiuu6iy9s4Z/kXwtGccQesUtZMaaV/t9Ib3w054ZzP2X0uKnMithkPhAbNs20vpJfEwf2Kyp3UmET07kz2ygjhRg+Y62upUW5NuCsHkaKaWMZZ/5mkk64D/HE6nN3JC0R063o9dQt7HHxal/XS9XWYBLREOEwnelLm9EXo5SZAhQxbCMw7MPUIuiPNabvWpzTt2akUwJgQwxCYqQc8s84E/JZVBf0cDYgc65+1haDsczJYPqcaAkbXyU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A6CFA3A0E4DC044AA811E1F9AD37C746@GBRP123.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bf711a4-78a4-4198-1127-08d7fa37f5b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2020 07:57:34.7046 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7f35688-9c00-4d5e-ba41-29f146377ab0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gemOOPo28wQTaiEpyErXEYllISPVkYCHF5J5BNZVEMKIih9Sebf1O+WSBxIHetY43blO46ME8EPA3wkto6TYkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB2565
X-OriginatorOrg: bt.com
Received-SPF: pass client-ip=213.121.35.74; envelope-from=jasper.lowell@bt.com;
 helo=smtpe1.intersmtp.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 03:57:39
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: tony.nguyen@bt.com, dgilbert@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SSd2ZSB3cml0dGVuIHVwIGEgYmFzaWMgaW1wbGVtZW50YXRpb24gb2YgdGhlIFNBQiA4MjUzMiBF
U0NDMiBkZXZpY2UNCmFuZCBoYXZlIHdyaXR0ZW4gYSBwYXRjaCBmb3IgT3BlbkJJT1MgdG8gYWRk
IGl0IHRvIHRoZSBkZXZpY2UgdHJlZS4gSQ0Kc3RpbGwgaGF2ZSB0aGUgMTY1NTBBIFVBUlQgYWN0
aW5nIGFzIHR0eWEgdG8gYXZvaWQgaGF2aW5nIHRvIHdyaXRlIGFuDQpPcGVuQklPUyBkZXZpY2Ug
ZHJpdmVyLg0KDQpPcGVuQlNEIGFuZCBTb2xhcmlzIGJvdGggaWRlbnRpZnkgdGhlIGRldmljZSBj
b3JyZWN0bHkgYW5kIGF0dGFjaCBpdC4NCg0KSW50ZXJlc3RpbmdseSwgaXQgbG9va3MgbGlrZSBT
b2xhcmlzIGVudGVyZWQgYW4gaW50ZXJydXB0IGhhbmRsZXIgdG8NCmRlYWwgd2l0aCBhbiBldmVu
dCBmb3IgdGhlIFNBQiA4MjUzMiBhbmQgaXQgcHJvYmVkIGEgZmV3IHN0YXR1cw0KcmVnaXN0ZXJz
LiBHaXZlbiB0aGF0IEkgY291bGRuJ3QgZW5jb3VyYWdlIFNvbGFyaXMgdG8gZG8gYW55dGhpbmcN
Cm91dHNpZGUgb2YgYXR0YWNoIHRoZSBkZXZpY2UgZm9yIHRoZSAxNjU1MEEsIEkgd2FzIHRoaW5r
aW5nIHRoaXMgbWlnaHQNCmJlIGEgZ29vZCBzaWduLg0KDQpUaGVyZSByZWFsbHkgc2hvdWxkbid0
IGJlIGFuIGludGVycnVwdCB0aG91Z2ggYXMgdGhlIHJlc2V0IHN0YXRlIG9mIHRoZQ0KU0FCIDgy
NTMyIGlzIHRvIGhhdmUgYWxsIGludGVycnVwdHMgbWFza2VkLiBTb2xhcmlzIHByb2JlcyB0aGVz
ZQ0KaW50ZXJydXB0IHN0YXR1cyByZWdpc3RlcnMgd2hpbGUgImNvbmZpZ3VyaW5nIiB0aGUgc3Vu
aG1lIGRldmljZS4NCg0KQXR0ZW1wdGluZyB0byBjb25maWd1cmUgaW50ZXJmYWNlIGhtZTAuLi4N
CjE0MDA3MEAxNTg5Njk4NjAzLjI2ODk0Mjplc2NjMl9tZW1fcmVhZCBjaGFubmVsIGEgYWRkciAw
eDM4IHZhbHVlIDB4NA0KMTQwMDcwQDE1ODk2OTg2MDMuMjY5MDExOmVzY2MyX2lycV91cGRhdGUg
dmFsdWUgMHgwDQoxNDAwNzBAMTU4OTY5ODYwMy4yNjkwMTU6ZXNjYzJfbWVtX3JlYWQgY2hhbm5l
bCBhIGFkZHIgMHgzYSB2YWx1ZSAweDgwDQoxNDAwNzBAMTU4OTY5ODYwMy4yNjkwMTc6ZXNjYzJf
aXJxX3VwZGF0ZSB2YWx1ZSAweDANCjE0MDA3MEAxNTg5Njk4NjAzLjI2OTAxODplc2NjMl9tZW1f
cmVhZCBjaGFubmVsIGEgYWRkciAweDNiIHZhbHVlIDB4MA0KMTQwMDcwQDE1ODk2OTg2MDMuMjY5
MDc2OmVzY2MyX21lbV9yZWFkIGNoYW5uZWwgYSBhZGRyIDB4MzggdmFsdWUgMHgwDQpXQVJOSU5H
OiBQb3dlciBvZmYgcmVxdWVzdGVkIGZyb20gcG93ZXIgYnV0dG9uIG9yIFNDLCBwb3dlcmluZyBk
b3duIHRoZQ0Kc3lzdGVtIQ0KMTQwMDcwQDE1ODk2OTg2MTEuMjcwODQ1OmVzY2MyX21lbV9yZWFk
IGNoYW5uZWwgYSBhZGRyIDB4MzggdmFsdWUgMHgwDQoxNDAwNzBAMTU4OTY5ODYxOS4yNzE3NTg6
ZXNjYzJfbWVtX3JlYWQgY2hhbm5lbCBhIGFkZHIgMHgzOCB2YWx1ZSAweDANCg0KSSd2ZSBub3Rp
Y2VkIHRoYXQgcmVtb3ZpbmcgdGhlIHN1bmhtZSBjb2RlIGZvciBzdW40dS5jIGluIFFFTVUgcHJl
dmVudHMNCnRoZSBzcHVyaW91cyBpbnRlcnJ1cHQgZnJvbSBoYXBwZW5pbmcgZm9yIHRoZSBzZXJp
YWwgZGV2aWNlIGFsb25nIHdpdGgNCnByZXZlbnQgdGhlIHVuZXhwZWN0ZWQgcG93ZXIgb2ZmIHJl
cXVlc3QgKHRoZSBwb3dlciBvZmYgcmVxdWVzdCB3YXMgbm90DQppbnRyb2R1Y2VkIGJ5IG15IGNv
ZGUpLiBJIGhhdmVuJ3QgaW52ZXN0aWdhdGVkIHdoeSB0aGUgcHJlc2VuY2Ugb2YNCnN1bmhtZSBj
YXVzZXMgdGhlc2UgZXZlbnRzLg0KDQpJIG1vZGlmaWVkIE9wZW5CSU9TIHRvIHVzZSB0dHliIGZv
ciBzdGRpbi9zdGRvdXQgYW5kIGFzc2lnbmVkIHRoYXQgdG8NCnRoZSAxNjU1MEEgc28gdGhhdCB0
dHlhIGNvdWxkIGJlIGFsaWFzZWQgdG8gdGhlIFNBQiA4MjUzMi4gT3V0c2lkZSBvZg0KdGhlIHNw
dXJpb3VzIGludGVycnVwdCBoYW5kbGVyIGJlaW5nIGNhbGxlZCwgSSdtIGdldHRpbmcgdGhlIHNh
bWUNCmJlaGF2aW91ciB3aGVyZSBTb2xhcmlzIGlkZW50aWZpZXMsIGF0dGFjaGVzLCBhbmQgdGhl
biBpZ25vcmVzIHRoZQ0KZGV2aWNlLiBEb2Vzbid0IGxvb2sgbGlrZSBteSBndWVzcyB3YXMgb24g
dGhlIG1hcmsuDQoNCkknbGwgYmUgbG9va2luZyBhdCBnZXR0aW5nIGFuIE9wZW5Tb2xhcmlzLWxp
a2Uga2VybmVsIGJ1aWx0IHdpdGggcHJvbQ0KZGVidWdnaW5nIG91dHB1dCBmb3IgY29uc29sZS90
dHkgcmVsYXRlZCBmaWxlcyBsaWtlDQp1c3Ivc3JjL3V0cy9jb21tb24vaW8vY29uc2NvbmZpZ19k
YWNmLmMuIFRoZSBpbGx1bW9zIGtlcm5lbCBpcyBwcm9iYWJseQ0Kc3VpdGFibGUgZm9yIHRoaXMg
YmVjYXVzZSBpdCdzIHN0aWxsIG1haW50YWluZWQgYW5kIGFwcGVhcnMgdG8gYmUNCnN1ZmZlcmlu
ZyBmcm9tIHRoZSBzYW1lIGNvbnNvbGUgcHJvYmxlbXMuIEkgZG9uJ3QgaGF2ZSBhIFNQQVJDNjQN
Cm1hY2hpbmUgaW1tZWRpYXRlbHkgYXZhaWxhYmxlIGFuZCBJJ20gdW5mYW1pbGlhciB3aXRoIHRo
ZSBidWlsZCBzeXN0ZW0NCmJlaGluZCB0aGVzZSBkaXN0cmlidXRpb25zLCBzbyBpdCBtaWdodCBi
ZSBhIHdoaWxlIGJlZm9yZSB0aGlzIGhhcHBlbnMuDQoNCkknbSBvdXQgb2YgaWRlYXMuDQoNCg0K
VGhhbmtzLA0KSmFzcGVyIExvd2VsbC4NCg0KDQpPbiBTdW4sIDIwMjAtMDUtMTAgYXQgMTA6MjIg
KzAxMDAsIE1hcmsgQ2F2ZS1BeWxhbmQgd3JvdGU6DQo+IE9uIDEwLzA1LzIwMjAgMDM6NDYsIGph
c3Blci5sb3dlbGxAYnQuY29tIHdyb3RlOg0KPiANCj4gPiBHb29kIGlkZWEuDQo+ID4gDQo+ID4g
VGhlIEVTQ0MgZGV2aWNlIGxvb2tzIGxpa2UgaXQncyB3cml0dGVuIGFzIGEgc3lzYnVzIGRldmlj
ZS4gSSB0aGluaw0KPiA+IHRoZQ0KPiA+IFVsdHJhIDUgaGFzIG5vIGRldmljZXMgb24gdGhlIHJv
b3Qgc2FicmUgYnVzLiBUaGUgc2VyaWFsIGNvbnRyb2xsZXINCj4gPiBpcw0KPiA+IGJlaGluZCB0
aGUgZWJ1cyAoZXNzZW50aWFsbHkgaXNhKS4gSSdtIGd1ZXNzaW5nIEkgd291bGQgbmVlZCB0bw0K
PiA+IHdyaXRlIGENCj4gPiB3cmFwcGVyIGRldmljZSBhcm91bmQgdGhlIG1lbW9yeSBpbyBmdW5j
dGlvbnMgc28gdGhhdCBpdCBjYW4gYmUNCj4gPiB1c2VkDQo+ID4gdW5kZXIgdGhlIGVidXMgLSBq
dWRnaW5nIGZyb20gdGhlIHNlcmlhbC1pc2EgaW1wbGVtZW50YXRpb24uDQo+ID4gDQo+ID4gSSB0
aGluayBpdCBtaWdodCBiZSBwb3NzaWJsZSB0byBsZWF2ZSB0aGUgRVNDQyBhcyBhIHN5c2J1cyBk
ZXZpY2UNCj4gPiBidXQNCj4gPiBJJ20gbm90IGZhbWlsaWFyIGVub3VnaCB3aXRoIE9wZW5CSU9T
IHRvIGV4cG9zZSB0aGUgcmlnaHQNCj4gPiBpbmZvcm1hdGlvbg0KPiA+IHRvIFNvbGFyaXMgYW5k
IHJlYXNvbiBhYm91dCB3aGF0J3MgaGFwcGVuaW5nIGNvbmZpZGVudGFsbHkuIEkgZG9uJ3QNCj4g
PiBleHBlY3Qgd3JpdGluZyBhIHdyYXBwZXIgZm9yIGlzYSB0byBiZSBkaWZmaWN1bHQgc28gSSds
bCBnaXZlIHRoYXQNCj4gPiBhDQo+ID4gZ28uIERvIHlvdSB0aGluayBpdCB3b3VsZCBiZSBmaW5l
IHRvIGp1c3QgY2hvb3NlIGFuIGFyYml0cmFyeQ0KPiA+IGlvcG9ydA0KPiA+IGFkZHJlc3MgZm9y
IHRoZSBkZXZpY2U/DQo+ID4gDQo+ID4gVGhhbmtzLA0KPiA+IEphc3BlciBMb3dlbGwuDQo+IA0K
PiBJJ20gbm90IG92ZXJseSBrZWVuIG9uIHRoaXMgYXBwcm9hY2gsIGJlY2F1c2UgaXQncyBqdXN0
IHN3YXBwaW5nIG91dA0KPiBvbmUgaW5jb3JyZWN0DQo+IGRldmljZSBmb3IgYW5vdGhlci4gVGhl
IGV4aXN0aW5nIHN1bjR1IG1hY2hpbmUgaXMgZmFpcmx5IGNsb3NlIHRvIGFuDQo+IHVsdHJhNSBh
bmQgSSdkDQo+IHByZWZlciB0byBtb3ZlIHRvd2FyZHMgZW11bGF0aW5nIHRoZSByZWFsIG1hY2hp
bmUgcmF0aGVyIHRoYW4ga2VlcA0KPiBzd2FwcGluZyBvdXQNCj4gcmFuZG9tIGJpdHMgb2YgaGFy
ZHdhcmUuDQo+IA0KPiBUaGUgbWFpbiByZWFzb24gSSBhZGRlZCB0aGUgc3VuaG1lIGVtdWxhdGlv
biB0byBRRU1VIHdhcyBiZWNhdXNlIEkNCj4gZm91bmQgdGhhdCBhY3Jvc3MNCj4gYWxsIG15IHRl
c3QgaW1hZ2VzIGRpZmZlcmVudCBPU3MgaGFkIGRpZmZlcmVudCBidWdzIGluIHRoZWlyIE5JQw0K
PiBkcml2ZXJzL0lSUQ0KPiBoYW5kbGluZywgYW5kIHRoaXMgd2FzIHRoZSBvbmx5IHNvbHV0aW9u
IHRoYXQgd291bGQgd29yayBmb3IgYWxsIG9mDQo+IHRoZW0uIE15IGZlYXINCj4gd2l0aCBnb2lu
ZyB0aGUgRVNDQyByb3V0ZSBpcyB0aGF0IHlvdSdsbCBlbmQgdXAgaW4gZXhhY3RseSB0aGUgc2Ft
ZQ0KPiBzaXR1YXRpb24uDQo+IA0KPiANCj4gQVRCLA0KPiANCj4gTWFyay4NCg==

