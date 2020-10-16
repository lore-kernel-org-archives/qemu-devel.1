Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5EA2C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 16:33:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCAFD20829
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 16:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=emdalo.onmicrosoft.com header.i=@emdalo.onmicrosoft.com header.b="iowrAnmt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCAFD20829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emdalo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTSft-0005ab-If
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 12:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivan.griffin@emdalo.com>)
 id 1kTSdY-0004O5-Aw; Fri, 16 Oct 2020 12:31:24 -0400
Received: from mail-eopbgr30048.outbound.protection.outlook.com
 ([40.107.3.48]:44038 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivan.griffin@emdalo.com>)
 id 1kTSdT-00024b-Ev; Fri, 16 Oct 2020 12:31:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YL5lGSrVqk1gVD+5RJx3c3ZFrXXCTa3dHlb7wmQdXrD8jbcBdm6hCQrO5orEnO/BJ5vllr6X/hZdZ7xn9wxla9NxA4fYA5Q+1/1ygYTKlzw+Iyn7xahRlZRW5/2fWOo6i3EM/u6LkCZIpjwyOLXXH6QNbfDGqXMD3mZcUbnSba5ZTahOBSZRdkXsCEKbV+aWcRspWZoGDVDM4Xz7h9hzh+C5pHQEjQLSldR6dbKj7C6VUWP3Rou5Fli7VY30KOJ+TeLIpeEq2SfwyJs9Az1obuir7rjo8+o/5q8zKpavqmX/QlOLUXyG9AfVz9wrMFx8z/yj1c+kNE8JoBygcmp8AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OBQiO74wx+xB+fKlLVJe69SmsRNnGoXKVUJ/eAhGG4=;
 b=O5UVjsgJOe3V8x2xNOV9zX4COqlip15Z7HbwuzKy5qWPcPAsykkDz1r5F3Quy8uBusVl/n1uVucEqEh1TUa1RlVzUZAoFqRhL2wet+fHt/ZCK3TbESmlCXkRAYu6Dssx4ozaQemZi/JCS8xkfJp5xipBo1dxG0fuPsMFxtCGwkycY8R/dy4/kqubdOhR7e7EIetu/31xdOpiqI843BiH7N2v2FtNz6bxf9RZXZwDCZlOdmaaIDAw36Mn+N95SYEkqSkez2n/Wuw6Gn4dpicWSwad8QIzqyjYeHjNz6K32RvmMJKjnV4rXAMkN/VOLpCW27fbHBoUXwqRg7k8njn21A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=emdalo.com; dmarc=pass action=none header.from=emdalo.com;
 dkim=pass header.d=emdalo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=emdalo.onmicrosoft.com; s=selector2-emdalo-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OBQiO74wx+xB+fKlLVJe69SmsRNnGoXKVUJ/eAhGG4=;
 b=iowrAnmtX8b/uYpsoI5M0m6MkuMedZspc5IirmwBmLJSPLNew/3fF7WeIp6OFbLfFcVcvKofYp64YEkTxbBL7BSjeZznObzJD6pcK8b+0L6ksokObpY9GpW/YdlgIHD/NYcSxjgKus2K9gsf8/N1FDV7k8MM1b8DBiOr61iEcC0=
Received: from DB7PR10MB1915.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:5:e::24) by
 DB8PR10MB2761.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:a9::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21; Fri, 16 Oct 2020 16:31:12 +0000
Received: from DB7PR10MB1915.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2cbe:c29d:d77f:e65f]) by DB7PR10MB1915.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2cbe:c29d:d77f:e65f%7]) with mapi id 15.20.3477.021; Fri, 16 Oct 2020
 16:31:12 +0000
From: Ivan Griffin <ivan.griffin@emdalo.com>
To: Alistair Francis <alistair23@gmail.com>
Subject: RE: [PATCH] hw/riscv: microchip_pfsoc: IOSCBCTRL memmap entry
Thread-Topic: [PATCH] hw/riscv: microchip_pfsoc: IOSCBCTRL memmap entry
Thread-Index: AQHWo7koTlHYzPX6kkGBi37eK2QKsqmaZYWAgAAFWCA=
Date: Fri, 16 Oct 2020 16:31:12 +0000
Message-ID: <DB7PR10MB191544AA04D0B3ECF82C57CDFE030@DB7PR10MB1915.EURPRD10.PROD.OUTLOOK.COM>
References: <20201016123737.8118-1-ivan.griffin@emdalo.com>
 <CAKmqyKNykruYK2AQ05KZyGCGD0rUsqQOVBbnccY+ELATBF=Ozg@mail.gmail.com>
In-Reply-To: <CAKmqyKNykruYK2AQ05KZyGCGD0rUsqQOVBbnccY+ELATBF=Ozg@mail.gmail.com>
Accept-Language: en-IE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=emdalo.com;
x-originating-ip: [88.87.191.50]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ccfceb4e-38c1-4135-76f3-08d871f0e50a
x-ms-traffictypediagnostic: DB8PR10MB2761:
x-microsoft-antispam-prvs: <DB8PR10MB2761794988191DE4BCA3F760FE030@DB8PR10MB2761.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2nAz6WB0jtJ+e7nfjLdIXKSBD9ooa4HX0OHfOvMNBhm/uXdcs13lMtDfpueaTwNZmRCKmgpl+r3xRpfa3xPEndQ+psnNejrmPORZZjsFV6WbFv0Pwrg8/azuFiPxvm5IZv6e9fgsA2kc30pdVEsplbgkq9ouAF+6KQgWZbFBRlGOuMsUEDv8egIxRzRehmys26c2BviPYtGWN8AYjBndra6SuiP485lPy5fNZRQ4urcaYYYoWV8TX4lpOTbYKwDQJD+DD7PXPZXsJKtjNTncRx4XV3vexhu9AOKKD26FYLx1X2IHJGhBXR+57qiXD55gNsjJHNp90/Dp6gA2WerZP+eMquBHtnKrTaWrhcHmmdoSLW1vr0sOy/nj2G7h+FslkzBw1u6WSSvNi+PvNFG4Bg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR10MB1915.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(346002)(136003)(376002)(366004)(39830400003)(396003)(71200400001)(54906003)(316002)(55016002)(33656002)(7696005)(6916009)(66476007)(83380400001)(4326008)(44832011)(186003)(66446008)(86362001)(66946007)(64756008)(2906002)(66556008)(9686003)(966005)(76116006)(478600001)(8936002)(52536014)(5660300002)(26005)(6506007)(8676002)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: tbIMWfaZ+3ZuRhWlyTfQLiJ4UdijXBLvbbCFMBPU4yru1jS/6srfGsuTuFmRzQj/r2nItW9DU4ddCtFz+XmQ4uj4LyjMONNTx7kGYncT4nMP/5yE3FXvGuiqDe3Ap2Ctgprh3kejcY1C/XDsBPzcG5UHjY9MwiTz3wYy8vDaagljGYSNSr/qEw+XLrWoaUgwhZsBgxKwappaf71Z05vAouM/9DLDfloztxJx2X6aNTBR8stWQDe5qRduRdwGMjL7h71UnRtYhlhnWMcBaNZSHz1ACNZPHzGWw0N+m0kbMuQfUc00fnDnI19MkGcyYQeHDf4ImXCuREa0SmieXk2aTnDtP8e6T8QDkeUcVqwXnBn1p9zWZZ9zDn6rXs9ZkTPLCjtmno8j9CYr448TQb2rAHDkGj1r7U7m2vVULBsR/vSzxLuDSTCZ3R0ro+Cf6pHB68kySuDNwRcGIasgZFtVTvilAKwoLA+BLdgxSa8tuYCrPU3qc/U/rHUDYXBcZ55km+kLn+TYgYbLgGhzVhw2JvwJ7Xc/2Dc/xFRE9LiO0upcQaePrZ6yBmFCPDfvIeYQIkRcQbcZjJ7YpxnnzTye4+b63sIIhre0NSXHyRPg+HGNbsY+r3faGS9oMcOLzAiDn0RUZqebdtsOq0obIIoZbg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: emdalo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB1915.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ccfceb4e-38c1-4135-76f3-08d871f0e50a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2020 16:31:12.0323 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 12485e48-c3f6-4e74-8f2d-9058be9b6951
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6PLrnusA4Hcj0UmjzChpLE2V9enzbibcYvfq/vLjYyiAuFws+pes7+8cXKweM9ccUzyBT5ROmPy/QXZ+HVJiJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB2761
Received-SPF: pass client-ip=40.107.3.48; envelope-from=ivan.griffin@emdalo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/16 12:31:14
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Bin Meng <bin.meng@windriver.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>, "qemu-devel@nongnu.org
 Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SSBkb24ndCBrbm93IHdoeSBpdCBpc24ndCBkb2N1bWVudGVkIGluIHRoYXQgUERGIChvciBpbiB0
aGUgcmVnaXN0ZXIgbWFwKSwgYnV0IGlmIHlvdSBjaGVjayBodHRwczovL2dpdGh1Yi5jb20vcG9s
YXJmaXJlLXNvYy9wb2xhcmZpcmUtc29jLWJhcmUtbWV0YWwtbGlicmFyeS9ibG9iL21hc3Rlci9z
cmMvcGxhdGZvcm0vZHJpdmVycy9tc3Nfc3lzX3NlcnZpY2VzL21zc19zeXNfc2VydmljZXMuaCB5
b3UnbGwgc2VlIHRoZSBmb2xsb3dpbmcNCg0KYGBgDQp0eXBlZGVmIHN0cnVjdA0Kew0KICAgIHZv
bGF0aWxlIHVpbnQzMl90IFNPRlRfUkVTRVQ7DQogICAgdm9sYXRpbGUgdWludDMyX3QgVkRFVEVD
VE9SOw0KICAgIHZvbGF0aWxlIHVpbnQzMl90IFRWU19DT05UUk9MOw0KICAgIHZvbGF0aWxlIHVp
bnQzMl90IFRWU19URU1QX0E7DQogICAgdm9sYXRpbGUgdWludDMyX3QgVFZTX1RFTVBfQjsNCiAg
ICB2b2xhdGlsZSB1aW50MzJfdCBUVlNfVEVNUF9DOw0KICAgIHZvbGF0aWxlIHVpbnQzMl90IFRW
U19WT0xUX0E7DQogICAgdm9sYXRpbGUgdWludDMyX3QgVFZTX1ZPTFRfQjsNCiAgICB2b2xhdGls
ZSB1aW50MzJfdCBUVlNfVk9MVF9DOw0KICAgIHZvbGF0aWxlIHVpbnQzMl90IFRWU19PVVRQVVQw
Ow0KICAgIHZvbGF0aWxlIHVpbnQzMl90IFRWU19PVVRQVVQxOw0KICAgIHZvbGF0aWxlIHVpbnQz
Ml90IFRWU19UUklHR0VSOw0KICAgIHZvbGF0aWxlIHVpbnQzMl90IFRSSU1fVkRFVDFQMDU7DQog
ICAgdm9sYXRpbGUgdWludDMyX3QgVFJJTV9WREVUMVA4Ow0KICAgIHZvbGF0aWxlIHVpbnQzMl90
IFRSSU1fVkRFVDJQNTsNCiAgICB2b2xhdGlsZSB1aW50MzJfdCBUUklNX1RWUzsNCiAgICB2b2xh
dGlsZSB1aW50MzJfdCBUUklNX0dERVQxUDA1Ow0KICAgIHZvbGF0aWxlIHVpbnQzMl90IFJFU0VS
VkVEMDsNCiAgICB2b2xhdGlsZSB1aW50MzJfdCBSRVNFUlZFRDE7DQogICAgdm9sYXRpbGUgdWlu
dDMyX3QgUkVTRVJWRUQyOw0KICAgIHZvbGF0aWxlIHVpbnQzMl90IFNFUlZJQ0VTX0NSOw0KICAg
IHZvbGF0aWxlIHVpbnQzMl90IFNFUlZJQ0VTX1NSOw0KICAgIHZvbGF0aWxlIHVpbnQzMl90IFVT
RVJfREVURUNUT1JfU1I7DQogICAgdm9sYXRpbGUgdWludDMyX3QgVVNFUl9ERVRFQ1RPUl9DUjsN
CiAgICB2b2xhdGlsZSB1aW50MzJfdCBNU1NfU1BJX0NSOw0KDQp9IFNDQkNUUkxfVHlwZURlZjsN
Cg0KI2RlZmluZSBNU1NfU0NCQ1RSTCAgICAgICAgICAgICAgICAgICAgKChTQ0JDVFJMX1R5cGVE
ZWYqKSAoMHgzNzAyMDAwMFVMKSkNCg0KLyoya0IgYnl0ZXMgbG9uZyBtYWlsYm94LiovDQojZGVm
aW5lIE1TU19TQ0JNQUlMQk9YICAgICAgICAgICAgICAgICAoKHVpbnQzMl90KikgKDB4MzcwMjA4
MDBVTCkpDQpgYGANCg0KQW5kIGluIGh0dHBzOi8vZ2l0aHViLmNvbS9wb2xhcmZpcmUtc29jL3Bv
bGFyZmlyZS1zb2MtYmFyZS1tZXRhbC1saWJyYXJ5L2Jsb2IvbWFzdGVyL3NyYy9wbGF0Zm9ybS9k
cml2ZXJzL21zc19zeXNfc2VydmljZXMvbXNzX3N5c19zZXJ2aWNlcy5jIHlvdSdsbCBzZWUgTVNT
X1NDQiBhbmQgTVNTX1NDQk1BSUxCT1ggdXNlZCBpbiBtYW55IHBsYWNlcyB0byBpbnRlcmFjdCB3
aXRoIHRoZSBGUEdBIHN5c3RlbSBjb250cm9sbGVyIHRvIHBlcmZvcm0gdmFyaW91cyBzZXJ2aWNl
cy4NCg0KDQpDaGVlcnMsDQpJdmFuDQoNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZy
b206IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyMjNAZ21haWwuY29tPiANClNlbnQ6IEZyaWRh
eSAxNiBPY3RvYmVyIDIwMjAgMTc6MDgNClRvOiBJdmFuIEdyaWZmaW4gPGl2YW4uZ3JpZmZpbkBl
bWRhbG8uY29tPg0KQ2M6IEJpbiBNZW5nIDxiaW4ubWVuZ0B3aW5kcml2ZXIuY29tPjsgUUVNVSBU
cml2aWFsIDxxZW11LXRyaXZpYWxAbm9uZ251Lm9yZz47IG9wZW4gbGlzdDpSSVNDLVYgPHFlbXUt
cmlzY3ZAbm9uZ251Lm9yZz47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZyBEZXZlbG9wZXJzIDxxZW11
LWRldmVsQG5vbmdudS5vcmc+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBody9yaXNjdjogbWljcm9j
aGlwX3Bmc29jOiBJT1NDQkNUUkwgbWVtbWFwIGVudHJ5DQoNCk9uIEZyaSwgT2N0IDE2LCAyMDIw
IGF0IDg6MDQgQU0gSXZhbiBHcmlmZmluIDxpdmFuLmdyaWZmaW5AZW1kYWxvLmNvbT4gd3JvdGU6
DQo+DQo+IEFkZGluZyB0aGUgUG9sYXJGaXJlIFNvQyBJT1NDQkNUUkwgbWVtb3J5IHJlZ2lvbiB0
byBwcmV2ZW50IFFFTVUgDQo+IHJlcG9ydGluZyBhIFNUT1JFL0FNTyBBY2Nlc3MgRmF1bHQuDQo+
DQo+IFRoaXMgcmVnaW9uIGlzIHVzZWQgYnkgdGhlIFBvbGFyRmlyZSBTb0MgcG9ydCBvZiBVLUJv
b3QgdG8gaW50ZXJhY3QgDQo+IHdpdGggdGhlIEZQR0Egc3lzdGVtIGNvbnRyb2xsZXIuDQo+DQo+
IFNpZ25lZC1vZmYtYnk6IEl2YW4gR3JpZmZpbiA8aXZhbi5ncmlmZmluQGVtZGFsby5jb20+DQo+
IC0tLQ0KPiAgaHcvcmlzY3YvbWljcm9jaGlwX3Bmc29jLmMgICAgICAgICB8IDYgKysrKysrDQo+
ICBpbmNsdWRlL2h3L3Jpc2N2L21pY3JvY2hpcF9wZnNvYy5oIHwgMSArDQo+ICAyIGZpbGVzIGNo
YW5nZWQsIDcgaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvaHcvcmlzY3YvbWljcm9j
aGlwX3Bmc29jLmMgYi9ody9yaXNjdi9taWNyb2NoaXBfcGZzb2MuYyANCj4gaW5kZXggNDYyNzE3
OWNkMy4uMjBlMTQ5NmUzZSAxMDA2NDQNCj4gLS0tIGEvaHcvcmlzY3YvbWljcm9jaGlwX3Bmc29j
LmMNCj4gKysrIGIvaHcvcmlzY3YvbWljcm9jaGlwX3Bmc29jLmMNCj4gQEAgLTk3LDYgKzk3LDcg
QEAgc3RhdGljIGNvbnN0IHN0cnVjdCBNZW1tYXBFbnRyeSB7DQo+ICAgICAgW01JQ1JPQ0hJUF9Q
RlNPQ19HUElPMl0gPSAgICAgICAgICAgeyAweDIwMTIyMDAwLCAgICAgMHgxMDAwIH0sDQo+ICAg
ICAgW01JQ1JPQ0hJUF9QRlNPQ19FTlZNX0NGR10gPSAgICAgICAgeyAweDIwMjAwMDAwLCAgICAg
MHgxMDAwIH0sDQo+ICAgICAgW01JQ1JPQ0hJUF9QRlNPQ19FTlZNX0RBVEFdID0gICAgICAgeyAw
eDIwMjIwMDAwLCAgICAweDIwMDAwIH0sDQo+ICsgICAgW01JQ1JPQ0hJUF9QRlNPQ19JT1NDQl9D
VFJMXSA9ICAgICAgeyAweDM3MDIwMDAwLCAgICAgMHgxMDAwIH0sDQoNCkkgZG9uJ3Qgc2VlIHRo
aXMgaW4gdGhlIFVHMDg4MCAiVXNlciBHdWlkZSBQb2xhckZpcmUgU29DIEZQR0EgTWljcm9wcm9j
ZXNzb3IgU3ViLVN5c3RlbSIgbWVtb3J5IG1hcC4NCg0KV2hlcmUgaXMgdGhpcyBkb2N1bWVudGVk
Pw0KDQpBbGlzdGFpcg0KDQo+ICAgICAgW01JQ1JPQ0hJUF9QRlNPQ19JT1NDQl9DRkddID0gICAg
ICAgeyAweDM3MDgwMDAwLCAgICAgMHgxMDAwIH0sDQo+ICAgICAgW01JQ1JPQ0hJUF9QRlNPQ19E
UkFNXSA9ICAgICAgICAgICAgeyAweDgwMDAwMDAwLCAgICAgICAgMHgwIH0sDQo+ICB9Ow0KPiBA
QCAtMzQxLDYgKzM0MiwxMSBAQCBzdGF0aWMgdm9pZCBtaWNyb2NoaXBfcGZzb2Nfc29jX3JlYWxp
emUoRGV2aWNlU3RhdGUgKmRldiwgRXJyb3IgKiplcnJwKQ0KPiAgICAgIGNyZWF0ZV91bmltcGxl
bWVudGVkX2RldmljZSgibWljcm9jaGlwLnBmc29jLmlvc2NiLmNmZyIsDQo+ICAgICAgICAgIG1l
bW1hcFtNSUNST0NISVBfUEZTT0NfSU9TQ0JfQ0ZHXS5iYXNlLA0KPiAgICAgICAgICBtZW1tYXBb
TUlDUk9DSElQX1BGU09DX0lPU0NCX0NGR10uc2l6ZSk7DQo+ICsNCj4gKyAgICAvKiBJT1NDQkNU
UkwgKi8NCj4gKyAgICBjcmVhdGVfdW5pbXBsZW1lbnRlZF9kZXZpY2UoIm1pY3JvY2hpcC5wZnNv
Yy5pb3NjYi5jdHJsIiwNCj4gKyAgICAgICAgbWVtbWFwW01JQ1JPQ0hJUF9QRlNPQ19JT1NDQl9D
VFJMXS5iYXNlLA0KPiArICAgICAgICBtZW1tYXBbTUlDUk9DSElQX1BGU09DX0lPU0NCX0NUUkxd
LnNpemUpOw0KPiAgfQ0KPg0KPiAgc3RhdGljIHZvaWQgbWljcm9jaGlwX3Bmc29jX3NvY19jbGFz
c19pbml0KE9iamVjdENsYXNzICpvYywgdm9pZCANCj4gKmRhdGEpIGRpZmYgLS1naXQgYS9pbmNs
dWRlL2h3L3Jpc2N2L21pY3JvY2hpcF9wZnNvYy5oIA0KPiBiL2luY2x1ZGUvaHcvcmlzY3YvbWlj
cm9jaGlwX3Bmc29jLmgNCj4gaW5kZXggOGJmYzdlMWE4NS4uM2YxODc0YjE2MiAxMDA2NDQNCj4g
LS0tIGEvaW5jbHVkZS9ody9yaXNjdi9taWNyb2NoaXBfcGZzb2MuaA0KPiArKysgYi9pbmNsdWRl
L2h3L3Jpc2N2L21pY3JvY2hpcF9wZnNvYy5oDQo+IEBAIC05NSw2ICs5NSw3IEBAIGVudW0gew0K
PiAgICAgIE1JQ1JPQ0hJUF9QRlNPQ19FTlZNX0NGRywNCj4gICAgICBNSUNST0NISVBfUEZTT0Nf
RU5WTV9EQVRBLA0KPiAgICAgIE1JQ1JPQ0hJUF9QRlNPQ19JT1NDQl9DRkcsDQo+ICsgICAgTUlD
Uk9DSElQX1BGU09DX0lPU0NCX0NUUkwsDQo+ICAgICAgTUlDUk9DSElQX1BGU09DX0RSQU0sDQo+
ICB9Ow0KPg0KPiAtLQ0KPiAyLjE3LjENCj4NCj4NCg==

