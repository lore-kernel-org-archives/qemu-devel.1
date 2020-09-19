Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4924C43464
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 12:55:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F92921741
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 12:55:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F92921741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=outlook.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJcOd-0002eH-N4
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 08:55:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atmgnd@outlook.com>)
 id 1kJZc3-0000Da-Qe
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 05:56:59 -0400
Received: from mail-oln040092253069.outbound.protection.outlook.com
 ([40.92.253.69]:13745 helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atmgnd@outlook.com>)
 id 1kJZc1-0006Ql-Dj
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 05:56:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=feQOa7FlETyoiQVOdIQJQSvrh1xXzo28eKl1vEMXgVe0TbJT4LJnCsAzOV1oQc/0XdfgPsXHdwbp4gVD1WlucMpCsmGKzuYH9S2Jx3EyIb7e9cL/AzCqUYLeiteIZrprm8RnB08b9iBk/ZLSjhPUGdB0UZWw0buOs0QjhFBLv3H7F9kxpVpHQFI+Yvd7rPWG+taWlrwl9YtLincnErQsegTELApgdcTjGswNrDL2zV2IMCCaZnq10kNw1Nbhv9sniIArBQwsxmKR1BmpBToTm6P5WGfNs4Faw/E4nsN9kvCLpYRMYFRZCt2U4WrYe1RPXV6Vi3RBrqRxkDNHEtzSrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGMi2t4EEp6DiUn1YhCfV/kqPxM1d1Qc8h3wDenhNB0=;
 b=kaXjGEzALERJb3tT2NuGt7qrQXKGvivRTfMWMH+TNb8h0cNbcwdXZ4xde7IaO5FQ+N7BULPqc5C2gybUhhMKabay3B4bNfrJ3zzJHyw0QdIWLyq5JfCx1/iDHvUpKYC4yrufZxXSFfVUQgk6/pdB/EMGcYJtbTDF2LYkRCWDc6l0z06eH8nOX5aiX25Y4bJt7cQH4AvtEupoQMX1g7rVHurKa22snvcYVhyLWZ0ySX2zR8TMJ+l7FDsvibLK8Dbqqh285tM43CWz4OudrVYXVuRLC6znd4zn2uuOWWLG1lj1MvRhKHaBoMwIbO5LkAePQEwL/6cKZGJDTs7BCcXnoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGMi2t4EEp6DiUn1YhCfV/kqPxM1d1Qc8h3wDenhNB0=;
 b=il12SqOE0oWJeeXm6DhifeqaPA0mlmW0NaDAuvPwXx2CRINIXXzr+8YlOznsFPNDgkmXRbKqUTGRgABxM1eDBoMQXnU30LoNsEWTQ3DICLV/wWySVtrRH8DN0nkoePUAwjG7Q1zZcRX7/Zg9OHgQQyU7c9kZ3V0pQ6c6DxdM83wVN9mtxYxDuO4kSh8yK5Qssocrk5MGXUM/CEor6QYIb6U7F1VLzvmRqt60K6VxDwwFXxCTcOCz5ibeWzmJ2Ch8/CMt7p0NDYjjcVF2Bc6WAQ1Xat/nLQ6egkejN3VDmWzIFFQhpslepJDQtB2XkPjPQ90QiacuRc9c3eDLGJRBdA==
Received: from PU1APC01FT051.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebe::4a) by
 PU1APC01HT197.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebe::439)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.15; Sat, 19 Sep
 2020 09:41:27 +0000
Received: from SYBP282MB0012.AUSP282.PROD.OUTLOOK.COM (2a01:111:e400:7ebe::4a)
 by PU1APC01FT051.mail.protection.outlook.com
 (2a01:111:e400:7ebe::402) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.15 via Frontend
 Transport; Sat, 19 Sep 2020 09:41:27 +0000
Received: from SYBP282MB0012.AUSP282.PROD.OUTLOOK.COM
 ([fe80::69c8:4a0a:9647:972f]) by SYBP282MB0012.AUSP282.PROD.OUTLOOK.COM
 ([fe80::69c8:4a0a:9647:972f%6]) with mapi id 15.20.3391.015; Sat, 19 Sep 2020
 09:41:25 +0000
From: zhou qi <atmgnd@outlook.com>
To: =?utf-8?B?Vm9sa2VyIFLDvG1lbGlu?= <vr_qemu@t-online.de>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIEZpeCB2aWRlbyBwbGF5YmFjayBzbG93ZG93biB3?=
 =?utf-8?Q?hen_spice_client_no_audio_enabled?=
Thread-Topic: [PATCH] Fix video playback slowdown when spice client no audio
 enabled
Thread-Index: AQHWh2Nf15JHbfwDZk+Tob2Rs7FGzqlmg7oAgAabsQCAAqDcEg==
Date: Sat, 19 Sep 2020 09:41:25 +0000
Message-ID: <SYBP282MB00120DBA84D39F5FF8F32514C93C0@SYBP282MB0012.AUSP282.PROD.OUTLOOK.COM>
References: <SYBP282MB00121EE06C845D33A07413BAC9270@SYBP282MB0012.AUSP282.PROD.OUTLOOK.COM>
 <ba86e0a0-4864-0881-f6ed-704ff90428fe@t-online.de>,
 <e3006ac7-b92b-40b0-e3b8-15b81a26647c@t-online.de>
In-Reply-To: <e3006ac7-b92b-40b0-e3b8-15b81a26647c@t-online.de>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:9F6234AADA99AA507FFC3E6DD33856313D15760CCE905FA163D7047755DD1612;
 UpperCasedChecksum:3B6AFCCA0B744236FF90EF0C7FD060426BF12CF8E512E004AD6D5DCF723659F6;
 SizeAsReceived:7128; Count:45
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [f6I8MHmEw/9v706tOMMasZxT+wXy+TviK0M1f+EDrYU=]
x-ms-publictraffictype: Email
x-incomingheadercount: 45
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 390f04d3-15c9-4c49-9c79-08d85c802d48
x-ms-traffictypediagnostic: PU1APC01HT197:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V9Fev4WgD3XgdkVMhyT/+8iUdel/mboAOzTy7Fv0cBBrKdotntq6DzKPJKPOPZoaSLdImJQqVNxPuvzHmv5Ber+X42P9JcVy7OST5cKOkiCD8XkbF+gFdpvVpcskL6vLZGrhXl2x1bfNyv5Sl8dqKxMKD/TPFUuRZekjEtFhj6UEaKBdV5dg9936KmVh1jSrANDpHR3b3bOXpF7LI8ZC+g==
x-ms-exchange-antispam-messagedata: sOEoEbgKClt/7HUwidp6YWPJpBKj7tmMg4zBzZabfZ/1Vtw1d/FuGuqEqYD3CooW1gCQ4RlqvuRp5rON3iGLzeVrntu0s5xzNf+1UHAQeKc49Unh/xQFvhIAkNj5O5LOICzqC3SorNclPSOsH088jA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-AuthSource: PU1APC01FT051.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 390f04d3-15c9-4c49-9c79-08d85c802d48
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2020 09:41:25.7008 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT197
Received-SPF: pass client-ip=40.92.253.69; envelope-from=atmgnd@outlook.com;
 helo=APC01-SG2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/19 05:56:53
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 19 Sep 2020 08:54:21 -0400
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

U29ycnkgZm9yIHRoZSBsYXRlIHJlcGx5LCBJIGFtIG5vdCB3b3JraW5nIG9uIGltcHJvdmUgdGhp
cyBwYXRjaChhdCBsZWFzdCBub3Qgbm93KSwgQW5kIHlvdSBhcmUgd2VsY29tZSB0byBzZW5kIHlv
dXIgcGF0Y2hlcy4KCgrlj5Hku7bkuro6IFZvbGtlciBSw7xtZWxpbiA8dnJfcWVtdUB0LW9ubGlu
ZS5kZT4K5Y+R6YCB5pe26Ze0OiAyMDIw5bm0OeaciDE45pelIDE6MjIK5pS25Lu25Lq6OiB6aG91
IHFpIDxhdG1nbmRAb3V0bG9vay5jb20+CuaKhOmAgTogcWVtdS1kZXZlbEBub25nbnUub3JnIDxx
ZW11LWRldmVsQG5vbmdudS5vcmc+CuS4u+mimDogUmU6IFtQQVRDSF0gRml4IHZpZGVvIHBsYXli
YWNrIHNsb3dkb3duIHdoZW4gc3BpY2UgY2xpZW50IG5vIGF1ZGlvIGVuYWJsZWQgCsKgCgo+IEhl
bGxvIFFpLAo+Cj4geW91ciBwYXRjaCBicmVha3MgYXVkaW8gcGxheWJhY2sgd2l0aCB0aGUgZHNv
dW5kYXVkaW8gYmFja2VuZC4KPgo+IEkgc3VnZ2VzdCB5b3UgbWFrZSB0aGUgZm9sbG93aW5nIGNo
YW5nZXM6Cj4KPiAtIFRlc3QgZm9yIHNpemUgPT0gMCBmaXJzdCBhbmQgbGVhdmUgdGhlIGxvb3Ag
aW4gdGhhdCBjYXNlLgo+IC0gRm9yIGJ1ZiA9PSBOVUxMIGRyb3Agc2l6ZSBieXRlcy4gRG9uJ3Qg
bGVhdmUgdGhlIGxvb3Agd2l0aCBicmVhayBvciByZXR1cm4uCj4gLSBWZXJpZnkgYWxsIGF1ZGlv
IGJhY2tlbmRzIGFkaGVyZSB0byB0aGUgbmV3IHJ1bGVzIGFuZCBmaXggdGhlbSBpZiBuZWNlc3Nh
cnkuIEl0J3MgcXVpdGUgcG9zc2libGUgbm8gcGF0Y2hlcyBhcmUgbmVlZGVkLgo+IC0gUmF0ZSBs
aW1pdCB0aGUgYXVkaW8gc3RyZWFtIGluIGZ1bmN0aW9uIGxpbmVfb3V0X2dldF9idWZmZXIoKSBp
biBhdWRpby9zcGljZWF1ZGlvLmMgZm9yIHRoZSBub2F1ZGlvIGNhc2UgdG9vLiBIYXZlIGEgbG9v
ayBhdCBhdWRpby9zcGljZWF1ZGlvLmMgYXQgdmVyc2lvbiB2NC4xLjAuIFRoZSBjb2RlIHRoZXJl
IHdhcyBjb3JyZWN0Lgo+Cj4gUGxlYXNlIGRvbid0IGZvcmdldCB0byBydW4gc2NyaXB0cy9jaGVj
a3BhdGNoLnBsIG9uIHlvdXIgbmV4dCBwYXRjaGVzIGFuZCBkb24ndCBmb3JnZXQgdG8gQ0MgdGhl
IG1haW50YWluZXIuCj4KPiBXaXRoIGJlc3QgcmVnYXJkcywKPgo+IFZvbGtlcgoKSGVsbG8gUWks
CgpJIHdvbmRlciBpZiB5b3UgYXJlIGFscmVhZHkgd29ya2luZyBvbiBhbiBpbXByb3ZlZCBmaXgu
IE90aGVyd2lzZSBJIHdpbGwgc2VuZCBteSBwYXRjaGVzIHRoaXMgd2Vla2VuZCB0byB0aGUgbWFp
bGluZyBsaXN0LgoKV2l0aCBiZXN0IHJlZ2FyZHMsClZvbGtlcgo=

