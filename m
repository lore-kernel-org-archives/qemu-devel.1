Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FE7C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 12:09:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CEE921D40
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 12:09:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CEE921D40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=outlook.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGhsB-0007kS-2K
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 08:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56158)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atmgnd@outlook.com>)
 id 1kGhrc-0007KS-5P
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 08:09:12 -0400
Received: from mail-oln040092253103.outbound.protection.outlook.com
 ([40.92.253.103]:39520 helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atmgnd@outlook.com>)
 id 1kGhra-00062X-2u
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 08:09:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NiYVYGPlrISHuLKGsJNU/J6mXOEjtWbB4lmLCRFPR4WzzJWlKiXtXbhy+FzD7LC1RZnleRNCY7qYFOVAKG+zDkgItxOnjYoaySgQQbZlhOrSwE9ug2e9D8bVPhef7ypBM8QEMVC9HrONtLJ/yoq+Dqqb97x2YCxAQqMoSEa4NgWpkCLu3tx5tG+CFuwcBDejRqN/dNNr0kPY2iLdL1Ub2T8k+Hbk1VYLZ+CQ7v95wkvn4BbJQCtnViJXpCu33DpiKyIIAbB/vV/IKY00VM51Z5PxRxnCC4WQrgk7HoRukBJuy98U3Tmd0qJ8HeGFnM+Up/wcC+9dCDb5XpskzSrSLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfSNojWlY9msgfa0aH49aKi2sC+f09i45QemLUH3zCI=;
 b=EAF3yhc1nPtOslEW5d5SjdN31feh9+eSGvgLkWMdRfzLh+M+27JIKWl3d5wUyyNOV8nJKRcwBv1AerrgmbrxqxvtroPykR3Icq6NmI+H3AjeUKPfCyxX2oKL+5tfH8cH+GYX/bxmZN3L8dA1e8Vyv4SWmuypyf15MGkT61B8P2+268L/TWiijec+huc355Qr4T8JTEgWEPGSO8iz6siN5YOJQQUhH8XYZuf0soooSV5YGVmVZ4ukcWDMKuFHcgUOSxYmLIvLc/I5k9ckaG94B+IaNWz0dHWYVwr4dLe0JwR6jLWdYdL3GkMHAQSqfIL2B703by1dubLamUfSskLaYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfSNojWlY9msgfa0aH49aKi2sC+f09i45QemLUH3zCI=;
 b=E0QxvY17mTjvrBQ+Rny0C+holVSE934N5BmZzvFlh/BWFanLjcVt1UhWtMwLLwVt1fPhebaJUzZV3AxWPVldk745/Sf0O7c9ma0/omXO1mCeeXIn5TffXVFV1uTXeauvgjttp9CD85Jix99lAstId6u1Ypc4ckbOcevxjRsPJj4OehXXAmDXfec79Bd/VDqec9VvN2IV+dElmM7ntf0BOcT5RtsAIyW6YEXN5IyPXL0SqM6KIvFTsVB0uPgs1U8+42koFe3ssJ2apzQutGTiMQz07vf+p4iaptOPZggNTd6eNpNmf51FZYaNvQSH6TDvBIDMH1pGTKE8O+f4SawywQ==
Received: from HK2APC01FT012.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebc::50) by
 HK2APC01HT203.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebc::355)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 11:53:56 +0000
Received: from SYBP282MB0012.AUSP282.PROD.OUTLOOK.COM (10.152.248.60) by
 HK2APC01FT012.mail.protection.outlook.com (10.152.248.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16 via Frontend Transport; Fri, 11 Sep 2020 11:53:56 +0000
Received: from SYBP282MB0012.AUSP282.PROD.OUTLOOK.COM
 ([fe80::69c8:4a0a:9647:972f]) by SYBP282MB0012.AUSP282.PROD.OUTLOOK.COM
 ([fe80::69c8:4a0a:9647:972f%6]) with mapi id 15.20.3370.017; Fri, 11 Sep 2020
 11:53:56 +0000
From: zhou qi <atmgnd@outlook.com>
To: "DirtY.iCE.hu@gmail.com" <DirtY.iCE.hu@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: =?utf-8?B?6L2s5Y+ROiBbUEFUQ0ggUkVTRU5EXSBGaXggdmlkZW8gcGxheWJhY2sgc2xv?=
 =?utf-8?Q?wdown_when_spice_client_no_audio_enabled?=
Thread-Topic: [PATCH RESEND] Fix video playback slowdown when spice client no
 audio enabled
Thread-Index: AQHWiDI6at0TaITbzk2yFrosmHXFkQ==
Date: Fri, 11 Sep 2020 11:53:56 +0000
Message-ID: <SYBP282MB0012C2BA15BB428F4A5506B3C9240@SYBP282MB0012.AUSP282.PROD.OUTLOOK.COM>
References: <SYBP282MB00121EE06C845D33A07413BAC9270@SYBP282MB0012.AUSP282.PROD.OUTLOOK.COM>
In-Reply-To: <SYBP282MB00121EE06C845D33A07413BAC9270@SYBP282MB0012.AUSP282.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:0371851A5E7B9F0C68C31C5A0D526BF10AF79F451B333181D3924E3E764971F3;
 UpperCasedChecksum:E513796088DC452173C55B3E0009FF9CC3D3ACBC8E5B54C454EE6573E3447D23;
 SizeAsReceived:2973; Count:43
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [vL75E4LPXN1/N0xRrkgf5Iac/N25Go21ZsY6uWs2Brc=]
x-ms-publictraffictype: Email
x-incomingheadercount: 43
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: f2216fad-24a7-47a5-5a07-08d856495cde
x-ms-traffictypediagnostic: HK2APC01HT203:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5WlIgeoF2N7luio605Xq90fzs06tWRKDHUTgDU1txU6HyDWxBHB6EoaLHsBjXjdt5/nAvn16wIFMC15B+7Q6lxTMbidKsMJFEkp7VYeOfIrigz1Kc8tq8zI/qvqyZ678bTQlVCHl+eRwtk9pvmMhs5jCpuzWhyO2zmutdeEQwzMFa0QPtlsHwmZzi76O5L41Trl5bxgxAxMfSqdrGsrW3UY5LveS+I+bpBBBT8Ld0xU=
x-ms-exchange-antispam-messagedata: o0H+GRNWdzhbu659kRyRVXyLS0okLaKqd+/XpllNvcF/pNbfMq7/UJy9WsDWEyNbid1J8jopCncLXiwiXNAu7xv92X5j+eJaNQTnklGLHs04ntO/wLyCETTQA7Fi/CBz8SF+MMFYJKHC99Ap8Wwwhg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-AuthSource: HK2APC01FT012.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f2216fad-24a7-47a5-5a07-08d856495cde
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2020 11:53:56.2123 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT203
Received-SPF: pass client-ip=40.92.253.103; envelope-from=atmgnd@outlook.com;
 helo=APC01-SG2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 08:09:06
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

QmVjYXVzZSBJIGRvbid0IHJlY2VpdmVkIGFueSBmZWVkYmFjaywgc28gaSBoYXZlIGRlY2lkZSBy
ZXNlbmQgYWdhaW4uIHdpdGggbW9yZSBkZXRhaWwuCkBEaXJ0WS5pQ0UuaHUsIENhbiB5b3UgcmV2
aWV3IHRoaXMgcGF0Y2g/IG9yIHNvbWVvbmUgZWxzZSBoYXMgdGltZSA/CgpJc3N1ZTogdmlkZW8g
cGxheWJhY2sgc2xvd2Rvd24sIHVzaW5nIHNwaWNlIGNsaWVudCAtLXNwaWNlLWRpc2FibGUtYXVk
aW8gb3B0aW9uCkhvdyB0byByZXByb2R1Y2U6CiAgICAxLiBjb21waWxlIHFlbXUgbWFzdGVyIGZv
ciB4ODZfNjQgdGFyZ2V0IHdpdGggc3BpY2UgZW5hYmxlZC4KICAgIDIuIGxhdWNoZXIgYSB3aW5k
b3dzIDcgdmlydHVhbCBtYWNoaW5lIHdpdGggc29tZSBsaWtlOiBxZW11LXN5c3RlbS14ODZfNjQg
LS1lbmFibGUta3ZtIC1NIHEzNSxhY2NlbD1rdm0gLWRpc3BsYXkgbm9uZSAgLXNwaWNlIHBvcnQ9
NTkwNyxhZGRyPTAuMC4wLjAsZGlzYWJsZS10aWNrZXRpbmcgLWRldmljZSBpbnRlbC1oZGEsaWQ9
czAgLWRldmljZSBoZGEtZHVwbGV4LGlkPXMwLWNvZGVjMCxidXM9czAuMCxjYWQ9MAogICAgMy4g
Y29ubmVjdCB0aGUgdmlydHVhbCBtYWNoaW5lIHVzaW5nIG9mZmljaWFsIHJlbW90ZS12aWV3ZXIg
d2l0aG91dCBzcGljZSBhdWRpbyBjaGFubmVsLiB3aGljaCBpczoKICAgICAgICByZW1vdGUtdmll
d2VyIHNwaWNlOi8vbG9jYWxob3N0OjU5MDcgLS1zcGljZS1kaXNhYmxlLWF1ZGlvCiAgICA0LiBv
cGVuIHdpbmRvd3Mgc2FtcGxlIHZpZGVvIHVzaW5nIGRlZmF1bHQgbWVkaWEgcGxheWVyLiB2aWRl
byBsb2NhdGlvbjogQzpcVXNlcnNcUHVibGljXFZpZGVvc1xTYW1wbGUgVmlkZW9zXFdpbGRsaWZl
LndtdgogICAgICAgIFlvdSB3aWxsIHNlZSB0aGUgdmlkZW8gcGxheWJhY2sgc3BlZWQgaXMgdmVy
eSBzbG93LgoKSSBIQVZFIFRFU1QgUUVNVSA0LjIuMSBET0VTIE5PVCBIQVZFIFRISVMgSVNTVUUu
IEFuZCBJIGJlbGlldmUgdGhpcyBpc3N1ZSB3YXMgaW5kcm9kdWNlZCBieSB0aGlzIGNvbW1pdDog
aHR0cHM6Ly9naXRodWIuY29tL3FlbXUvcWVtdS9jb21taXQvZmIzNWMyY2VjNTg5ODVmMGI4ZDI3
MzNmMWI5MTkyNzU0MmVlYjNmZAoKYmVzdCByZWdhcmRzCgrlj5Hku7bkuro6IHpob3UgcWkgPGF0
bWduZEBvdXRsb29rLmNvbT4K5Y+R6YCB5pe26Ze0OiAyMDIw5bm0OeaciDEw5pelIDE5OjE3CuaU
tuS7tuS6ujogcWVtdS1kZXZlbEBub25nbnUub3JnIDxxZW11LWRldmVsQG5vbmdudS5vcmc+CuS4
u+mimDogW1BBVENIXSBGaXggdmlkZW8gcGxheWJhY2sgc2xvd2Rvd24gd2hlbiBzcGljZSBjbGll
bnQgbm8gYXVkaW8gZW5hYmxlZCAKwqAKRnJvbSBlOGMyZTI4M2YwOTU0ZGUyNTVhMzJlYTcwZDU3
N2Q1ZTYxOTkyMzk5IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBRaSBaaG91IDxhdG1n
bmRAb3V0bG9vay5jb20+CkRhdGU6IFRodSwgMTAgU2VwIDIwMjAgMTk6MDk6MjkgKzA4MDAKU3Vi
amVjdDogW1BBVENIXSBGaXggdmlkZW8gcGxheWJhY2sgc2xvd2Rvd24gd2hlbiBzcGljZSBjbGll
bnQgbm8gYXVkaW8gZW5hYmxlZAoKWW91IHdpbGwgZ2V0IHZpZGVvIHBsYXliYWNrIHNsb3dkb3du
IG9uIHRoZSBmb2xsb3dpbmcgY2FzZXMKCjEuIHVzZSBvZmZpY2lhbCBzcGljZSBjbGllbnQgd2l0
aCBhdWRpbyBjaGFubmVsIGRpc2FibGVkLCB1c2UgLS1zcGljZS1kaXNhYmxlLWF1ZGlvCsKgwqAg
b3B0aW9uCjIuIHRoaXJ0cGFydCBjbGllbnQgZG9lc24ndCBpbXBsZW1lbnQgYXVkaW8gY2hhbm5l
bAoKcmVmOiBodHRwczovL2dpdGh1Yi5jb20vcWVtdS9xZW11L2NvbW1pdC9mYjM1YzJjZWM1ODk4
NWYwYjhkMjczM2YxYjkxOTI3NTQyZWViM2ZkClNpZ25lZC1vZmYtYnk6IFFpIFpob3UgPGF0bWdu
ZEBvdXRsb29rLmNvbT4KLS0tCsKgYXVkaW8vYXVkaW8uYyB8IDYgKysrKystCsKgMSBmaWxlIGNo
YW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2F1ZGlv
L2F1ZGlvLmMgYi9hdWRpby9hdWRpby5jCmluZGV4IGNlOGM2ZGVjNWYuLjUwZmViZTE5MGYgMTAw
NjQ0Ci0tLSBhL2F1ZGlvL2F1ZGlvLmMKKysrIGIvYXVkaW8vYXVkaW8uYwpAQCAtMTA5MSw3ICsx
MDkxLDExIEBAIHN0YXRpYyBzaXplX3QgYXVkaW9fcGNtX2h3X3J1bl9vdXQoSFdWb2ljZU91dCAq
aHcsIHNpemVfdCBsaXZlKQrCoMKgwqDCoCB3aGlsZSAobGl2ZSkgewrCoMKgwqDCoMKgwqDCoMKg
IHNpemVfdCBzaXplLCBkZWNyLCBwcm9jOwrCoMKgwqDCoMKgwqDCoMKgIHZvaWQgKmJ1ZiA9IGh3
LT5wY21fb3BzLT5nZXRfYnVmZmVyX291dChodywgJnNpemUpOwotwqDCoMKgwqDCoMKgwqAgaWYg
KCFidWYgfHwgc2l6ZSA9PSAwKSB7CisKK8KgwqDCoMKgwqDCoMKgIGlmICghYnVmKSB7CivCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGh3LT5taXhfYnVmLT5wb3MgPSAoaHctPm1peF9idWYtPnBvcyAr
IGxpdmUpICUgaHctPm1peF9idWYtPnNpemU7CivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVy
biBjbGlwcGVkICsgbGl2ZTsKK8KgwqDCoMKgwqDCoMKgIH0gZWxzZSBpZiAoIHNpemUgPT0gMCkg
ewrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7CsKgwqDCoMKgwqDCoMKgwqAgfQrCoAot
LSAKMi4xNy4x

