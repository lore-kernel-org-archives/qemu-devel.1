Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDCEC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 17:09:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E134C205CB
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 17:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gatech.edu header.i=@gatech.edu header.b="i6L4nlog"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E134C205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gatech.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYusr-0005Rb-Di
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 13:09:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rding@gatech.edu>) id 1jYusE-0004pC-N4
 for qemu-devel@nongnu.org; Wed, 13 May 2020 13:08:50 -0400
Received: from mail-dm6nam11on2095.outbound.protection.outlook.com
 ([40.107.223.95]:36094 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rding@gatech.edu>) id 1jYusD-00036S-IP
 for qemu-devel@nongnu.org; Wed, 13 May 2020 13:08:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LEWM81U+9J1KcwbRtFfEgqs8bvMe1O+b1hJgUf2M4Jmz7WWpHSg0CEFX3bqsQoXuvu6041pcz//MLepPx5P1kkhoAN1gJWn3iLlFlbu7K6iSemFbzIhPi2f+jAO6ozQN5qazqMjpFSblwea7AouBh5DvD+RL5bKEMJL2Omf2eYE9sB92ecEjCjVxBFzR0CO+3IgqCxYmaOIIB2PR3k2rv7NGUHji97ADa/WVL+1MDC/gqeY+W++Ub3rWuWqBiFGDkvp5K3IKHtg8HkfiaFVSHb5NMPQBC+XcNT6lxUM2O3cncmuzCWbgzHz/r5pxcplVr7olH9c4EdaUBZyv4HesBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8rmCc+V1B2hz/LRKwLMVJ5tExyRMjTs/5xDcxfxo5Rc=;
 b=bPUxwYdRM0lVGKOxE/mO0nuwl5puXkGh4c84mlo0+nb4k1cToQxXJ5Nijeh9FKAA7mMwUw8wc5ufA8yoM8cs2PAcRfy7FMJQcmZctLvq3NJyNMTe0Qw34JTrMz0ZKsGiWZGMBrpCSX9btjZqvK++1cl0RIia0PkHSumhNC2ydHx4WsFpOP3wlSuhCor3OYHtKVXM/8igWCAiQEyMfgmLUl+HofI461pC7BuJvN7ee3j96yb7uLehUhZZ7RBtLWnwXGtxjQtjDfOssHkNGbuznb4VZZ6rpv5RMS1doemtZc6vfVqcfUTZ/LyxhP2MFGEQ4+nuvvkm/SuKOClJ/CFF5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gatech.edu; dmarc=pass action=none header.from=gatech.edu;
 dkim=pass header.d=gatech.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gatech.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8rmCc+V1B2hz/LRKwLMVJ5tExyRMjTs/5xDcxfxo5Rc=;
 b=i6L4nlog7rcDLZspnHuJP88+rO2U2n4aQnRPCM3+MAsTqf46s02lYrDxvUf0X6kcKOTK7SYCpV5pZC1VW+v14whHzO05Osf9JxTKBCT/bR0scoQx/SgEMVDOpKIKMVg/x1GElvqYETpsABT1Q8Rj+OMo9J6zXd8kUqmpeeu7H4k=
Received: from BN6PR07MB3412.namprd07.prod.outlook.com (2603:10b6:405:62::19)
 by BN6PR07MB3508.namprd07.prod.outlook.com (2603:10b6:405:6a::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.29; Wed, 13 May
 2020 17:08:46 +0000
Received: from BN6PR07MB3412.namprd07.prod.outlook.com
 ([fe80::c9dc:66b8:c941:d0c9]) by BN6PR07MB3412.namprd07.prod.outlook.com
 ([fe80::c9dc:66b8:c941:d0c9%7]) with mapi id 15.20.2979.033; Wed, 13 May 2020
 17:08:46 +0000
From: "Ding, Ren" <rding@gatech.edu>
To: P J P <ppandit@redhat.com>
Subject: Re: [PATCH 0/2] use unsigned type for MegasasState fields
Thread-Topic: [PATCH 0/2] use unsigned type for MegasasState fields
Thread-Index: AQHWJF6W07NroReLN0GJrXmoymoO16ikfYmAgABSZgCAAAilgIAACyoAgAEuOQCAAAirgIAACTqAgAAluIA=
Date: Wed, 13 May 2020 17:08:46 +0000
Message-ID: <1F5C89FF-377C-48F4-B873-B1E88274566B@gatech.edu>
References: <20200507105718.1319187-1-ppandit@redhat.com>
 <26201c24-c483-85a7-2f4b-b3cc56d4b8b7@redhat.com>
 <nycvar.YSQ.7.76.2005122357030.1451610@xnncv>
 <20200512190803.o6vr2shjmhsplsjx@mozz.bu.edu>
 <20200512194759.nb42yurlnynr5yrw@mozz.bu.edu>
 <nycvar.YSQ.7.76.2005131905010.1451610@xnncv>
 <20200513142043.lfcamp5j43ke5md4@mozz.bu.edu>
 <nycvar.YSQ.7.76.2005132016550.1451610@xnncv>
In-Reply-To: <nycvar.YSQ.7.76.2005132016550.1451610@xnncv>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=gatech.edu;
x-originating-ip: [2601:c0:c67f:9210:b1c8:5cf8:eb62:317b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ea4d354-91c6-4857-811c-08d7f7604c55
x-ms-traffictypediagnostic: BN6PR07MB3508:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR07MB3508BE1D48BD4FF1CA85ACF0CABF0@BN6PR07MB3508.namprd07.prod.outlook.com>
x-gt-tenant: 042d12d7-75fe-4547-b5b6-0573f80f829d
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0402872DA1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TsyBVblmqtZngVEVarABv/9SBlGpWW5p/XAMrd355GYEfRXPcNZoEJuAbQYwp6trZVXZ5xJ5EPc+EzgJGP+XX9aZMG1ySidWmgLS/Sd0kXcqs2azk96PNjv5QSE7vQ/lbVcy4aOurGsBoV9PvwE4RyX6KkpnDGS1vCSOmD8nfU/T8qTl/B3gOjr2Znkh21n3v5TyJYRSrNGYkxwD1NeplmGcdtSL8ay8cU40ZDVyM690iE2tTEUrw6snc7udGovWJxA/eoUiEYSBg+6pKUoUVi7l70DYe4QJ4oNRC1O8kuubgsEtp1BP+awQ4ayBkCUvjn1cbgTagbpNiPlBfIZy5UJfuIjeyuy6+qpBNgMO7lUd2LNaUTDeOeszOn2yFamIbULwNhJpK9cV79zy1q0Uc99jBci5SfU/C4nnmpklcyFciavTVsRYRmFBxPvV7t9PPifW3DrMBf6M3E0XtntSocpmlZr7qpr4LurPt5V407oUH4dOmhk1FnEvroOfgBuDYyFKmsP+8TuoTNKC/yRcd/baXn2KYy6UrKnHcIQaq0FQQwf4hHwFeDWClyzePH8KW+Q6koAqgZ5VW4VJl1M0/bqjhCF4CwzniHLhVlfqcIw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR07MB3412.namprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(39860400002)(376002)(346002)(396003)(33430700001)(71200400001)(76116006)(66476007)(6486002)(36756003)(2906002)(6506007)(53546011)(478600001)(33440700001)(66556008)(316002)(54906003)(33656002)(166002)(786003)(186003)(64756008)(4326008)(86362001)(66446008)(66946007)(6512007)(75432002)(8936002)(4744005)(2616005)(5660300002)(6916009)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: NgJAaPVMYvxfHJDMRtcIDwLtYXjmGOtneGjTYJq4Sk6war1EQENOv27FoIIlOVnQqO9jpyjNwOtBvTaaeoD3laWD9kdvDm3uN0Bq7GLVzooIMo+siorDp9FwNCI4otQDb3n/nUnvCREU2oCgan0AxTEPiHq2spNldWUA9JgqfrmrLaspOY1ccGXNM+QBIw92Pkk0L4j+taiKupZcGGsyVbNLgrRI2aPs69HgtrNcY9ac4G2PRiJYIkxB+zryCHT9d9BnyCLck5/WfyJkQpEwZb2CxpTYOnBWSk2Djq5l9AcpHhRGXdA5ztcUnXNnX3xlOAKakIDWPKsCxcN+iOeixZ4nAJJoJDa0fIqqWo8WtEnVPCKh4XsW8KO0j3zVjviccFnilpDgkV7jmmjxgvAu3yx7HTfw1g/5OFIDIQFRU3t4VcMXBug2Z4WCOYdFLRPkLb1Cfi+FozQcWidD9js+KnbcGLlXOIZxUQ5RVB9GzmwCbOa++R6BudDz2RHbcCA7uQarBsu+mHZIdcGw1IXqD59QJdm3dOhBp5QsH5Fca4U=
Content-Type: multipart/alternative;
 boundary="_000_1F5C89FF377C48F4B873B1E88274566Bgatechedu_"
MIME-Version: 1.0
X-OriginatorOrg: gatech.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea4d354-91c6-4857-811c-08d7f7604c55
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2020 17:08:46.3518 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 482198bb-ae7b-4b25-8b7a-6d7f32faa083
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uaFVyfDsZ6xDWk0uFhnsEYlzBKScWFXoXmmSrwA2AFasmH7Lridm4yi52SVfNm+d5g3O9wXoSZ1Yo2YMJTE6Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB3508
Received-SPF: pass client-ip=40.107.223.95; envelope-from=rding@gatech.edu;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 13:08:47
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, QEMU Developers <qemu-devel@nongnu.org>,
 Alexander Bulekov <alxndr@bu.edu>,
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, "Ding,
 Ren" <rding@gatech.edu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_1F5C89FF377C48F4B873B1E88274566Bgatechedu_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgYWxsLA0KDQpXZSBjb3VsZG7igJl0IHJlcHJvZHVjZSB0aGUgYnVnIHdpdGggdGhlIHBhdGNo
IHByb3ZpZGVkIGJ5IG91ciByZXByb2R1Y2VyIGVhcmxpZXIsIHRob3VnaCB3ZSBkaWQgbm90IGRp
ZyBpbnRvIHRoZSBkZXRhaWxzIG9mIGl0LiBNZWFud2hpbGUsIHdlIGRvIGFsc28gc2VlIHRoZSBu
dWxsIHBvaW50ZXIgZGVyZWZlcmVuY2UgY3Jhc2ggd2l0aCB0aGUgY3VycmVudCB1cHN0cmVhbSAo
aHR0cHM6Ly9idWdzLmxhdW5jaHBhZC5uZXQvcWVtdS8rYnVnLzE4NzgyNTkpLg0KDQpSZW4NCg0K
T24gTWF5IDEzLCAyMDIwLCBhdCAxMDo1MyBBTSwgUCBKIFAgPHBwYW5kaXRAcmVkaGF0LmNvbTxt
YWlsdG86cHBhbmRpdEByZWRoYXQuY29tPj4gd3JvdGU6DQoNCistLSBPbiBXZWQsIDEzIE1heSAy
MDIwLCBBbGV4YW5kZXIgQnVsZWtvdiB3cm90ZSAtLSsNCnwgVGhleSBhcmUgbm90IG5lY2Vzc2Fy
eSwgYnV0IGZvciBtZSBRRU1VIGNyYXNoZXMgYmVmb3JlIHF0ZXN0IGV2ZXIgdHJpZXMgdG8NCnwg
cGFyc2UgdGhlbS4gSXMgeW91ciBRRU1VIGJ1aWx0IHdpdGggQVNBTj8NCg0KWWVzLCBpdCBpcw0K
UUVNVV9DRkxBR1MgICAgICAgLUkvdXNyL2luY2x1ZGUvcGl4bWFuLTEgICAtV2Vycm9yIC1mc2Fu
aXRpemU9YWRkcmVzcw0KUUVNVV9MREZMQUdTICAgICAgLVdsLC0td2Fybi1jb21tb24gLWZzYW5p
dGl6ZT1hZGRyZXNzDQoNCkJ0dywgUmVuIGNvbmZpcm1lZCB0aGF0IGhlIHdhc24ndCBhYmxlIHRv
IHJlcHJvZHVjZSB0aGUgaXNzdWUgd2l0aCB0aGUNCnByb3Bvc2VkIHBhdGNoLg0KDQpUaGFuayB5
b3UuDQotLQ0KUHJhc2FkIEogUGFuZGl0IC8gUmVkIEhhdCBQcm9kdWN0IFNlY3VyaXR5IFRlYW0N
Cjg2ODUgNTQ1RSBCNTRDIDQ4NkIgQzZFQiAyNzFFIEUyODUgOEI1QSBGMDUwIERFOEQNCg0KDQo=

--_000_1F5C89FF377C48F4B873B1E88274566Bgatechedu_
Content-Type: text/html; charset="utf-8"
Content-ID: <5D9C5976A9732A4A9BA3CCE0D6862A75@namprd07.prod.outlook.com>
Content-Transfer-Encoding: base64

PGh0bWw+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0i
dGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjwvaGVhZD4NCjxib2R5IHN0eWxlPSJ3b3JkLXdy
YXA6IGJyZWFrLXdvcmQ7IC13ZWJraXQtbmJzcC1tb2RlOiBzcGFjZTsgbGluZS1icmVhazogYWZ0
ZXItd2hpdGUtc3BhY2U7IiBjbGFzcz0iIj4NCjxkaXYgY2xhc3M9IiI+SGkgYWxsLDwvZGl2Pg0K
PGRpdiBjbGFzcz0iIj48YnIgY2xhc3M9IiI+DQo8L2Rpdj4NCjxkaXYgY2xhc3M9IiI+V2UgY291
bGRu4oCZdCByZXByb2R1Y2UgdGhlIGJ1ZyB3aXRoIHRoZSBwYXRjaCBwcm92aWRlZCBieSBvdXIg
cmVwcm9kdWNlciBlYXJsaWVyLCB0aG91Z2ggd2UgZGlkIG5vdCBkaWcgaW50byB0aGUgZGV0YWls
cyBvZiBpdC4gTWVhbndoaWxlLCB3ZSBkbyBhbHNvIHNlZSB0aGUgbnVsbCBwb2ludGVyIGRlcmVm
ZXJlbmNlIGNyYXNoIHdpdGggdGhlIGN1cnJlbnQgdXBzdHJlYW0gKDxhIGhyZWY9Imh0dHBzOi8v
YnVncy5sYXVuY2hwYWQubmV0L3FlbXUvJiM0MztidWcvMTg3ODI1OSIgY2xhc3M9IiI+aHR0cHM6
Ly9idWdzLmxhdW5jaHBhZC5uZXQvcWVtdS8mIzQzO2J1Zy8xODc4MjU5PC9hPikuPC9kaXY+DQo8
ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIj4NCjwvZGl2Pg0KPGRpdiBjbGFzcz0iIj5SZW48L2Rp
dj4NCjxiciBjbGFzcz0iIj4NCjxkaXY+DQo8YmxvY2txdW90ZSB0eXBlPSJjaXRlIiBjbGFzcz0i
Ij4NCjxkaXYgY2xhc3M9IiI+T24gTWF5IDEzLCAyMDIwLCBhdCAxMDo1MyBBTSwgUCBKIFAgJmx0
OzxhIGhyZWY9Im1haWx0bzpwcGFuZGl0QHJlZGhhdC5jb20iIGNsYXNzPSIiPnBwYW5kaXRAcmVk
aGF0LmNvbTwvYT4mZ3Q7IHdyb3RlOjwvZGl2Pg0KPGJyIGNsYXNzPSJBcHBsZS1pbnRlcmNoYW5n
ZS1uZXdsaW5lIj4NCjxkaXYgY2xhc3M9IiI+DQo8ZGl2IGNsYXNzPSIiPiYjNDM7LS0gT24gV2Vk
LCAxMyBNYXkgMjAyMCwgQWxleGFuZGVyIEJ1bGVrb3Ygd3JvdGUgLS0mIzQzOzxiciBjbGFzcz0i
Ij4NCnwgVGhleSBhcmUgbm90IG5lY2Vzc2FyeSwgYnV0IGZvciBtZSBRRU1VIGNyYXNoZXMgYmVm
b3JlIHF0ZXN0IGV2ZXIgdHJpZXMgdG8gPGJyIGNsYXNzPSIiPg0KfCBwYXJzZSB0aGVtLiBJcyB5
b3VyIFFFTVUgYnVpbHQgd2l0aCBBU0FOPzxiciBjbGFzcz0iIj4NCjxiciBjbGFzcz0iIj4NClll
cywgaXQgaXM8YnIgY2xhc3M9IiI+DQpRRU1VX0NGTEFHUyAmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDstSS91c3IvaW5jbHVkZS9waXhtYW4tMSAmbmJzcDsmbmJzcDstV2Vycm9y
IC1mc2FuaXRpemU9YWRkcmVzczxiciBjbGFzcz0iIj4NClFFTVVfTERGTEFHUyAmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDstV2wsLS13YXJuLWNvbW1vbiAtZnNhbml0aXplPWFkZHJlc3M8
YnIgY2xhc3M9IiI+DQo8YnIgY2xhc3M9IiI+DQpCdHcsIFJlbiBjb25maXJtZWQgdGhhdCBoZSB3
YXNuJ3QgYWJsZSB0byByZXByb2R1Y2UgdGhlIGlzc3VlIHdpdGggdGhlIDxiciBjbGFzcz0iIj4N
CnByb3Bvc2VkIHBhdGNoLjxiciBjbGFzcz0iIj4NCjxiciBjbGFzcz0iIj4NClRoYW5rIHlvdS48
YnIgY2xhc3M9IiI+DQotLTxiciBjbGFzcz0iIj4NClByYXNhZCBKIFBhbmRpdCAvIFJlZCBIYXQg
UHJvZHVjdCBTZWN1cml0eSBUZWFtPGJyIGNsYXNzPSIiPg0KODY4NSA1NDVFIEI1NEMgNDg2QiBD
NkVCIDI3MUUgRTI4NSA4QjVBIEYwNTAgREU4RDxiciBjbGFzcz0iIj4NCjxiciBjbGFzcz0iIj4N
CjwvZGl2Pg0KPC9kaXY+DQo8L2Jsb2NrcXVvdGU+DQo8L2Rpdj4NCjxiciBjbGFzcz0iIj4NCjwv
Ym9keT4NCjwvaHRtbD4NCg==

--_000_1F5C89FF377C48F4B873B1E88274566Bgatechedu_--

