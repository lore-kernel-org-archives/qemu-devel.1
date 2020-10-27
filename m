Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,HEADER_FROM_DIFFERENT_DOMAINS,HTML_FONT_FACE_BAD,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15616C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 03:25:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF4A32075B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 03:25:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF4A32075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXFcG-0000m3-Lr
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 23:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FelixCui-oc@zhaoxin.com>)
 id 1kXFbC-0000JZ-VL
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 23:24:39 -0400
Received: from zxshcas2.zhaoxin.com ([203.148.12.82]:18846)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <FelixCui-oc@zhaoxin.com>)
 id 1kXFb6-00063s-0H
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 23:24:38 -0400
Received: from zxbjmbx2.zhaoxin.com (10.29.252.164) by ZXSHCAS2.zhaoxin.com
 (10.28.252.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 27 Oct
 2020 11:18:06 +0800
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by zxbjmbx2.zhaoxin.com
 (10.29.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 27 Oct
 2020 11:18:06 +0800
Received: from zxbjmbx1.zhaoxin.com ([fe80::290a:f538:51e7:1416]) by
 zxbjmbx1.zhaoxin.com ([fe80::290a:f538:51e7:1416%16]) with mapi id
 15.01.1979.003; Tue, 27 Oct 2020 11:18:06 +0800
From: FelixCui-oc <FelixCui-oc@zhaoxin.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>
Subject: =?gb2312?B?tPC4tDogtPC4tDogW1BBVENIIDEvMV0gU2tpcCBmbGF0dmlld19zaW1wbGlm?=
 =?gb2312?Q?y()_for_cpu_vendor_zhaoxin?=
Thread-Topic: =?gb2312?B?tPC4tDogW1BBVENIIDEvMV0gU2tpcCBmbGF0dmlld19zaW1wbGlmeSgpIGZv?=
 =?gb2312?Q?r_cpu_vendor_zhaoxin?=
Thread-Index: AQHWo6+lIFwCGFufXkSJFIAohPLGXamZlV6AgAUx0wCAAPEVAIAA32uAgACU/oCAALuMAIAAEROAgADx78v//46xgIAAs1FmgAek4RE=
Date: Tue, 27 Oct 2020 03:18:06 +0000
Message-ID: <ff715cb194d24e44b3a4de1c96faafe8@zhaoxin.com>
References: <20201016112933.14856-1-FelixCui-oc@zhaoxin.com>
 <20201016112933.14856-2-FelixCui-oc@zhaoxin.com>
 <a971c9db-469f-ddc0-1a27-3e21958f6ff7@redhat.com>
 <20201019130206.1d3baffc@w520.home>
 <4d2b96cb-8f7f-2598-39e6-4cf0f61d567b@redhat.com>
 <20201020164437.5e3cb4ce@w520.home>
 <783b5ef0-277c-363d-f342-7c0351f9ac16@redhat.com>
 <20201021124908.53c7a98b@w520.home>
 <eaab570f-741e-7397-09c2-8e47f0a6d32c@redhat.com>
 <0e275d4de640431cb07de7fafb4d9ef1@zhaoxin.com>,
 <606cf65a-a614-5c9b-705f-3a8f3707fb10@redhat.com>,
 <2b934315e08b4725b60c62602189d59a@zhaoxin.com>
In-Reply-To: <2b934315e08b4725b60c62602189d59a@zhaoxin.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.29.8.40]
Content-Type: multipart/alternative;
 boundary="_000_ff715cb194d24e44b3a4de1c96faafe8zhaoxincom_"
MIME-Version: 1.0
Received-SPF: pass client-ip=203.148.12.82;
 envelope-from=FelixCui-oc@zhaoxin.com; helo=ZXSHCAS2.zhaoxin.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 23:18:08
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: 38
X-Spam_score: 3.8
X-Spam_bar: +++
X-Spam_report: (3.8 / 5.0 requ) BAYES_00=-1.9, CHARSET_FARAWAY_HEADER=3.2,
 HTML_FONT_FACE_BAD=0.001, HTML_MESSAGE=0.001, MIME_CHARSET_FARAWAY=2.45,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: CobeChen-oc <CobeChen-oc@zhaoxin.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>, RockCui-oc <RockCui-oc@zhaoxin.com>,
 Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_ff715cb194d24e44b3a4de1c96faafe8zhaoxincom_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

aGkgcGFvbG8sDQoNCj5TbyByZW1vdmluZyBmbGF0dmlld19zaW1wbGlmeSgpIHdvcmtzIGJlY2F1
c2UgdGhlIGhpZ2hlciBhcmVhICgweDEwMDAwDQo+YW5kIGFib3ZlKSByZW1haW5zIHRoZSBzYW1l
LiAgSSBndWVzcyB0aGUgc2ltcGxlc3QgdGhpbmcgdG8gZG8gaXMgdG8NCj5hcHBseSBmbGF0dmll
d19zaW1wbGlmeSgpIG9ubHkgdG8gSS9PIGFyZWFzLCB0aG91Z2ggd2UgY2FuIGFsc28gY29uc2lk
ZXINCj5yZW1vdmluZyBpdCBjb21wbGV0ZWx5LiAgSSdtIG5vdCBzdXJlIGluIHdoaWNoIGNhc2Ug
aXQgd291bGQgcHJvdmlkZSBhDQo+bm90aWNlYWJsZSBpbXByb3ZlbWVudC4NCg0KV2hpY2ggb25l
IGRvIHlvdSB0aGluayBpcyBiZXR0ZXI/IEkgcHJlZmVyIHRvIHJlbW92ZSBmbGF0dmlld19zaW1w
bGlmeSgpIGRpcmVjdGx5Lg0KUGxlYXNlIGhlbHAgZ2l2ZSBzb21lIHN1Z2dlc3Rpb25zICwgYW5k
IHRoZW4gaSB3aWxsIHJlc3VibWl0IHRoZSBwYXRjaC4NCg0KQmVzdCByZWdhcmRzDQpGZWxpeEN1
aS1vYw0KDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQq3orz+yMs6IEZlbGl4
Q3VpLW9jDQq3osvNyrG85DogMjAyMMTqMTDUwjIyyNUgMTQ6MzE6MjYNCsrVvP7IyzogUGFvbG8g
Qm9uemluaTsgQWxleCBXaWxsaWFtc29uDQqzrcvNOiBSaWNoYXJkIEhlbmRlcnNvbjsgRWR1YXJk
byBIYWJrb3N0OyBxZW11LWRldmVsQG5vbmdudS5vcmc7IFJvY2tDdWktb2M7IFRvbnkgVyBXYW5n
LW9jOyBDb2JlQ2hlbi1vYw0K1vfM4jogtPC4tDogtPC4tDogW1BBVENIIDEvMV0gU2tpcCBmbGF0
dmlld19zaW1wbGlmeSgpIGZvciBjcHUgdmVuZG9yIHpoYW94aW4NCg0KDQpoaSBwYW9sbywNCg0K
DQo+U28gcmVtb3ZpbmcgZmxhdHZpZXdfc2ltcGxpZnkoKSB3b3JrcyBiZWNhdXNlIHRoZSBoaWdo
ZXIgYXJlYSAoMHgxMDAwMA0KDQo+YW5kIGFib3ZlKSByZW1haW5zIHRoZSBzYW1lLiAgSSBndWVz
cyB0aGUgc2ltcGxlc3QgdGhpbmcgdG8gZG8gaXMgdG8NCj5hcHBseSBmbGF0dmlld19zaW1wbGlm
eSgpIG9ubHkgdG8gSS9PIGFyZWFzLCB0aG91Z2ggd2UgY2FuIGFsc28gY29uc2lkZXINCj5yZW1v
dmluZyBpdCBjb21wbGV0ZWx5LiAgSSdtIG5vdCBzdXJlIGluIHdoaWNoIGNhc2UgaXQgd291bGQg
cHJvdmlkZSBhDQo+bm90aWNlYWJsZSBpbXByb3ZlbWVudC4NCg0KDQpJIGFncmVlIHdpdGggeW91
IHZlcnkgbXVjaC4gQm90aCBvZiB0aGVzZSBjYXNlcyBjYW4gc29sdmUgdGhpcyBidWcuDQoNClRo
YW5rcy4NCg0KDQpCZXN0IHJlZ2FyZHMNCg0KRmVsaXhjdWktb2MNCg0KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18NCreivP7IyzogUGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0
LmNvbT4NCreiy83KsbzkOiAyMDIwxOoxMNTCMjLI1SAxMTozMDozNw0KytW8/sjLOiBGZWxpeEN1
aS1vYzsgQWxleCBXaWxsaWFtc29uDQqzrcvNOiBSaWNoYXJkIEhlbmRlcnNvbjsgRWR1YXJkbyBI
YWJrb3N0OyBxZW11LWRldmVsQG5vbmdudS5vcmc7IFJvY2tDdWktb2M7IFRvbnkgVyBXYW5nLW9j
OyBDb2JlQ2hlbi1vYw0K1vfM4jogUmU6ILTwuLQ6IFtQQVRDSCAxLzFdIFNraXAgZmxhdHZpZXdf
c2ltcGxpZnkoKSBmb3IgY3B1IHZlbmRvciB6aGFveGluDQoNCk9uIDIyLzEwLzIwIDA1OjAyLCBG
ZWxpeEN1aS1vYyB3cm90ZToNCj4gSW4gYWRkaXRpb24sIGJlZm9yZSB3cml0ZSBwYW0gcmVnaXN0
ZXJzLCBmbGF0dmlld19zaW1wbGlmeSgpIGhhcyBtZXJnZWQNCj4gYSB2ZXJ5IGxhcmdlIHJhbmdl
LkZvciBleGFtcGxlLA0KPg0KPiB0aGlzIGxhcmdlIHJhbmdlIGlzIDB4YzAwMDAtMHhiZmZmZmZm
Zi4gU28gZXZlbiBpZiBFSENJIGlzIGNvbmZpZ3VyZWQgdG8NCj4gbm90IGFsbG9jYXRlIGJ1ZmZl
cnMgaW4gbG93IG1lbW9yeSwNCj4NCj4gdGhpcyBidWcgd2lsbCBzdGlsbCBvY2N1ci5UaGFua3Mu
DQoNClNvIHJlbW92aW5nIGZsYXR2aWV3X3NpbXBsaWZ5KCkgd29ya3MgYmVjYXVzZSB0aGUgaGln
aGVyIGFyZWEgKDB4MTAwMDANCmFuZCBhYm92ZSkgcmVtYWlucyB0aGUgc2FtZS4gIEkgZ3Vlc3Mg
dGhlIHNpbXBsZXN0IHRoaW5nIHRvIGRvIGlzIHRvDQphcHBseSBmbGF0dmlld19zaW1wbGlmeSgp
IG9ubHkgdG8gSS9PIGFyZWFzLCB0aG91Z2ggd2UgY2FuIGFsc28gY29uc2lkZXINCnJlbW92aW5n
IGl0IGNvbXBsZXRlbHkuICBJJ20gbm90IHN1cmUgaW4gd2hpY2ggY2FzZSBpdCB3b3VsZCBwcm92
aWRlIGENCm5vdGljZWFibGUgaW1wcm92ZW1lbnQuDQoNClBhb2xvDQoNCg==

--_000_ff715cb194d24e44b3a4de1c96faafe8zhaoxincom_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p></p>
<div style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont=
; font-size: 16px; margin-top: 0px; margin-bottom: 0px;">
<font face=3D"Microsoft YaHei UI,Microsoft YaHei,=CE=A2=C8=ED=D1=C5=BA=DA,S=
imSun,=CB=CE=CC=E5,sans-serif,serif,EmojiFont" size=3D"1" color=3D"#212121"=
><span style=3D"font-size: 13.32px;">hi paolo,</span></font></div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont=
; font-size: 16px; margin-top: 0px; margin-bottom: 0px;">
<font face=3D"Microsoft YaHei UI,Microsoft YaHei,=CE=A2=C8=ED=D1=C5=BA=DA,S=
imSun,=CB=CE=CC=E5,sans-serif,serif,EmojiFont" size=3D"1" color=3D"#212121"=
><span style=3D"font-size: 13.32px;"><br>
</span></font></div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont=
; font-size: 16px; margin-top: 0px; margin-bottom: 0px;">
<font face=3D"Microsoft YaHei UI,Microsoft YaHei,=CE=A2=C8=ED=D1=C5=BA=DA,S=
imSun,=CB=CE=CC=E5,sans-serif,serif,EmojiFont" size=3D"1" color=3D"#212121"=
><span style=3D"font-size: 13.32px;">&gt;So removing flatview_simplify() wo=
rks because the higher area (0x10000</span></font></div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont=
; font-size: 16px; margin-top: 0px; margin-bottom: 0px;">
<font face=3D"Microsoft YaHei UI,Microsoft YaHei,=CE=A2=C8=ED=D1=C5=BA=DA,S=
imSun,=CB=CE=CC=E5,sans-serif,serif,EmojiFont" size=3D"1" color=3D"#212121"=
><span style=3D"font-size: 13.32px;">&gt;and above) remains the same.&nbsp;=
 I guess the simplest thing to do is to</span></font><br>
<font face=3D"Microsoft YaHei UI,Microsoft YaHei,=CE=A2=C8=ED=D1=C5=BA=DA,S=
imSun,=CB=CE=CC=E5,sans-serif,serif,EmojiFont" size=3D"1" color=3D"#212121"=
><span style=3D"font-size: 13.32px;">&gt;apply flatview_simplify() only to =
I/O areas, though we can also consider</span></font><br>
<font face=3D"Microsoft YaHei UI,Microsoft YaHei,=CE=A2=C8=ED=D1=C5=BA=DA,S=
imSun,=CB=CE=CC=E5,sans-serif,serif,EmojiFont" size=3D"1" color=3D"#212121"=
><span style=3D"font-size: 13.32px;">&gt;removing it completely.&nbsp; I'm =
not sure in which case it would provide a</span></font><br>
<font face=3D"Microsoft YaHei UI,Microsoft YaHei,=CE=A2=C8=ED=D1=C5=BA=DA,S=
imSun,=CB=CE=CC=E5,sans-serif,serif,EmojiFont" size=3D"1" color=3D"#212121"=
><span style=3D"font-size: 13.32px;">&gt;noticeable improvement.</span></fo=
nt></div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont=
; font-size: 16px; margin-top: 0px; margin-bottom: 0px;">
<font face=3D"Microsoft YaHei UI,Microsoft YaHei,=CE=A2=C8=ED=D1=C5=BA=DA,S=
imSun,=CB=CE=CC=E5,sans-serif,serif,EmojiFont" size=3D"1" color=3D"#212121"=
><span style=3D"font-size: 13.32px;"><br>
</span></font></div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont=
; font-size: 16px; margin-top: 0px; margin-bottom: 0px;">
<font face=3D"Microsoft YaHei UI,Microsoft YaHei,=CE=A2=C8=ED=D1=C5=BA=DA,S=
imSun,=CB=CE=CC=E5,sans-serif,serif,EmojiFont" size=3D"1" color=3D"#212121"=
><span style=3D"font-size: 13.32px;">Which one do you think is better? I pr=
efer to remove flatview_simplify() directly.</span></font></div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont=
; font-size: 16px; margin-top: 0px; margin-bottom: 0px;">
<font face=3D"Microsoft YaHei UI,Microsoft YaHei,=CE=A2=C8=ED=D1=C5=BA=DA,S=
imSun,=CB=CE=CC=E5,sans-serif,serif,EmojiFont" size=3D"1" color=3D"#212121"=
><span style=3D"font-size: 13.32px;">Please help give some suggestions , an=
d then i will resubmit the patch.</span></font></div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont=
; font-size: 16px; margin-top: 0px; margin-bottom: 0px;">
<font face=3D"Microsoft YaHei UI,Microsoft YaHei,=CE=A2=C8=ED=D1=C5=BA=DA,S=
imSun,=CB=CE=CC=E5,sans-serif,serif,EmojiFont" size=3D"1" color=3D"#212121"=
><span style=3D"font-size: 13.32px;"><br>
</span></font></div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont=
; font-size: 16px; margin-top: 0px; margin-bottom: 0px;">
<font face=3D"Microsoft YaHei UI,Microsoft YaHei,=CE=A2=C8=ED=D1=C5=BA=DA,S=
imSun,=CB=CE=CC=E5,sans-serif,serif,EmojiFont" size=3D"1" color=3D"#212121"=
><span style=3D"font-size: 13.32px;">Best regards</span></font></div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont=
; font-size: 16px; margin-top: 0px; margin-bottom: 0px;">
<font face=3D"Microsoft YaHei UI,Microsoft YaHei,=CE=A2=C8=ED=D1=C5=BA=DA,S=
imSun,=CB=CE=CC=E5,sans-serif,serif,EmojiFont" size=3D"1" color=3D"#212121"=
><span style=3D"font-size: 13.32px;">FelixCui-oc</span></font></div>
<br>
<p></p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>=B7=A2=BC=FE=C8=CB:</b> FelixCu=
i-oc<br>
<b>=B7=A2=CB=CD=CA=B1=BC=E4:</b> 2020=C4=EA10=D4=C222=C8=D5 14:31:26<br>
<b>=CA=D5=BC=FE=C8=CB:</b> Paolo Bonzini; Alex Williamson<br>
<b>=B3=AD=CB=CD:</b> Richard Henderson; Eduardo Habkost; qemu-devel@nongnu.=
org; RockCui-oc; Tony W Wang-oc; CobeChen-oc<br>
<b>=D6=F7=CC=E2:</b> =B4=F0=B8=B4: =B4=F0=B8=B4: [PATCH 1/1] Skip flatview_=
simplify() for cpu vendor zhaoxin</font>
<div>&nbsp;</div>
</div>
<div>
<meta content=3D"text/html; charset=3DUTF-8">
<style type=3D"text/css" style=3D"">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div id=3D"x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; col=
or:#000000; font-family:Calibri,Helvetica,sans-serif">
<p>hi paolo,</p>
<p><br>
</p>
<p><span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI=
&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=
=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">&gt;So removing fla=
tview_simplify() works because the higher area (0x10000</span></p>
<p><span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI=
&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=
=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px"></span><span style=
=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&quot;,&quot;M=
icrosoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,sans-seri=
f,serif,EmojiFont; font-size:13.3333px">&gt;and
 above) remains the same.&nbsp; I guess the simplest thing to do is to</spa=
n><br style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">&gt;apply flatview_sim=
plify() only to I/O areas, though we can also consider</span><br style=3D"c=
olor:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&quot;,&quot;Micros=
oft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,sans-serif,ser=
if,EmojiFont; font-size:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">&gt;removing it comple=
tely.&nbsp; I'm not sure in which case it would provide a</span><br style=
=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&quot;,&quot;M=
icrosoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,sans-seri=
f,serif,EmojiFont; font-size:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">&gt;noticeable improve=
ment.</span><br>
</p>
<p><span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI=
&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=
=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px"><br>
</span></p>
<p><span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI=
&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=
=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">I agree with you ve=
ry much. Both of these cases can solve this bug.</span></p>
<p><span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI=
&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=
=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">Thanks.</span></p>
<p><span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI=
&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=
=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px"><br>
</span></p>
<p><font color=3D"#212121" face=3D"Microsoft YaHei UI, Microsoft YaHei, =CE=
=A2=C8=ED=D1=C5=BA=DA, SimSun, =CB=CE=CC=E5, sans-serif, serif, EmojiFont">=
<span style=3D"font-size:13.3333px">Best regards</span></font></p>
<p><font color=3D"#212121" face=3D"Microsoft YaHei UI, Microsoft YaHei, =CE=
=A2=C8=ED=D1=C5=BA=DA, SimSun, =CB=CE=CC=E5, sans-serif, serif, EmojiFont">=
<span style=3D"font-size:13.3333px">Felixcui-oc</span></font></p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>=B7=A2=BC=FE=C8=CB:</b> Paolo=
 Bonzini &lt;pbonzini@redhat.com&gt;<br>
<b>=B7=A2=CB=CD=CA=B1=BC=E4:</b> 2020=C4=EA10=D4=C222=C8=D5 11:30:37<br>
<b>=CA=D5=BC=FE=C8=CB:</b> FelixCui-oc; Alex Williamson<br>
<b>=B3=AD=CB=CD:</b> Richard Henderson; Eduardo Habkost; qemu-devel@nongnu.=
org; RockCui-oc; Tony W Wang-oc; CobeChen-oc<br>
<b>=D6=F7=CC=E2:</b> Re: =B4=F0=B8=B4: [PATCH 1/1] Skip flatview_simplify()=
 for cpu vendor zhaoxin</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">On 22/10/20 05:02, FelixCui-oc wrote:<br>
&gt; In addition, before write pam registers, flatview_simplify() has merge=
d<br>
&gt; a very large range.For example,<br>
&gt; <br>
&gt; this large range is 0xc0000-0xbfffffff.&nbsp;So even if EHCI is config=
ured to<br>
&gt; not allocate buffers in low memory,<br>
&gt; <br>
&gt; this bug will still occur.Thanks.<br>
<br>
So removing flatview_simplify() works because the higher area (0x10000<br>
and above) remains the same.&nbsp; I guess the simplest thing to do is to<b=
r>
apply flatview_simplify() only to I/O areas, though we can also consider<br=
>
removing it completely.&nbsp; I'm not sure in which case it would provide a=
<br>
noticeable improvement.<br>
<br>
Paolo<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_ff715cb194d24e44b3a4de1c96faafe8zhaoxincom_--

