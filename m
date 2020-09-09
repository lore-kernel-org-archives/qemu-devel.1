Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8010FC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 11:06:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7855621582
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 11:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="OlLN3/uF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7855621582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFxvf-0007R7-DW
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 07:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kFxuq-0006Xm-5C
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 07:05:28 -0400
Received: from mail-dm6nam10on2053.outbound.protection.outlook.com
 ([40.107.93.53]:48897 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kFxun-0003ZN-E8
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 07:05:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=THNw7ff3SCuHdCv7G9Pr1MzMaZKvCi6eMB5FPsloSYed28v6Dd53dr+M+lkT99teUMaFpBIO9MECA1PqOteNX8G0ck9NBDkMWvyOnmrC1PAsS2nzpXMfPoJxgXxh6H/JpAoHeh8cFmvbZQ3/DrlzbySkxUi69U7OspDOD8DmZLWcUGZvwNQCZw+FdmE44MVM3zoip5X7c6VZZU197jpyybCWcMoQ/PeLTaUpVd564oVdhcAD+iFtiLHEUc4xXG2uCtQxvs2NTgNNUTttqHSkLn2GYKewuzEFREfO2v/J7o5EyFpG0lUx6SBbJGJnTFIqwNPedccz0SQWJyHjAhqJ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5tgrnB/lIHF83TclPCA7yHceMDwbwjZ9WsHqlEceEBk=;
 b=BNma+Lz/rC+Iz1tQWPIMhfjYLC0UJBAzruhzRYsA5n/eQ4HcNvQwu5XWsbP/X6RnK6RWqIPgVSjBrU3ag4cjL+dOXhrgttlvig/kXgbJ6eP8WhUAM2HhZyL7qELkfHzidNqhOuMlUFn1OERNxwanJey+V3ZvtGoR3/Lv6maPDPrM/GqxyFqEw+aGdTa9xLbTCmqlpGgLfsktpSDjdexAlrJ/sWMAYCo3k9puD1f9g9NJ4VcLrMCxDfKUzKYpVoMNAsalI6A/aGvNfjP4wUcNFzrOXe/uQ5PiFR/BWyMvpr56fLx0ntAM6f8sD5WJKpvO+UC2RdUN+dGIxHsOAO1R3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5tgrnB/lIHF83TclPCA7yHceMDwbwjZ9WsHqlEceEBk=;
 b=OlLN3/uF7QgTv/PIjSPCMdCE51M6wYPBCYd1QXNUBi9p9fqht4faeT7ebquxpKB/7giPTwitqFYz3Q0I926dbweQHXF4qk0aLshbZNWeWJ89ONyDX6qdIjvH+2QzEu2t1inOiJr6hVUgzFY7RVXW/EB0rLzhVgxK+WjDE56na3Y=
Received: from BY5PR02MB6772.namprd02.prod.outlook.com (2603:10b6:a03:206::11)
 by BY5PR02MB6275.namprd02.prod.outlook.com (2603:10b6:a03:1b6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 9 Sep
 2020 10:50:15 +0000
Received: from BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::1007:f094:45c9:bb47]) by BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::1007:f094:45c9:bb47%8]) with mapi id 15.20.3370.016; Wed, 9 Sep 2020
 10:50:15 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 =?utf-8?B?J01hcmMtQW5kcsOpIEx1cmVhdSc=?= <marcandre.lureau@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Edgar
 Iglesias <edgari@xilinx.com>, Francisco Eduardo Iglesias
 <figlesia@xilinx.com>, David Gibson <david@gibson.dropbear.id.au>
Subject: RE: [PATCH v4 1/7] usb/hcd-xhci: Make dma read/writes hooks pci free
Thread-Topic: [PATCH v4 1/7] usb/hcd-xhci: Make dma read/writes hooks pci free
Thread-Index: AQHWfW+Ua1yvfd0S/EK+NcJs9pMBDKlUAL+AgAqNz+CAAAypgIAAAVCAgAAQfFCAAA69AIABdrbA
Date: Wed, 9 Sep 2020 10:50:15 +0000
Message-ID: <BY5PR02MB67727BBAE2E8F8D15948FD35CA260@BY5PR02MB6772.namprd02.prod.outlook.com>
References: <1598642380-27817-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1598642380-27817-2-git-send-email-sai.pavan.boddu@xilinx.com>
 <cefca93c-37d5-63b7-aff3-e6966d771892@redhat.com>
 <BY5PR02MB6772B6F211489F7E2A9D5CCDCA290@BY5PR02MB6772.namprd02.prod.outlook.com>
 <2330f661-2ef0-cfb5-4a05-8a2d43ab53e4@redhat.com>
 <79ff4a95-d276-6681-6a06-9b8dc66de93f@redhat.com>
 <BY5PR02MB67724F130F0AF42FB0689148CA290@BY5PR02MB6772.namprd02.prod.outlook.com>
 <fe1cf46a-7669-8d84-aa5e-4ad67a23db3c@redhat.com>
In-Reply-To: <fe1cf46a-7669-8d84-aa5e-4ad67a23db3c@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ecda68d1-5fc0-4c5a-f822-08d854ae2281
x-ms-traffictypediagnostic: BY5PR02MB6275:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR02MB62754C714CEDCABFE49F8C97CA260@BY5PR02MB6275.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: buMTohe81hHQrLDZbos3SI1OHT0LnrwKMd1AbJRPcfUg4ATHoAZcOcUoBi7mYl0S5HipjHQKpTfCBbbUHpPjarxZzsickSrX94t7WS2XfowZDtPwcZ4rvMRL0UK5ykJS52CjYhldbVSTftGk3hfyWDbhEsovpz+GaR14fAW3p7PKSLlIqRKCWnQAI2QM7HqpqlLnELo46Yj5hUvXK5t4hAwL1khfSJnwhFMZFwZxUFC1sJrcjxDUZe65k7V2+4eX3b/3LWm2KUVmk6hEEZAtpiPes6lHsHao5q698Xff5++xHtIY9QORw3MlBtCGCe/YPAWPDwIA+iYuhMKtUzsm+w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6772.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(39860400002)(376002)(366004)(346002)(396003)(136003)(71200400001)(186003)(76116006)(66446008)(66476007)(7696005)(64756008)(52536014)(66556008)(5660300002)(66946007)(316002)(9686003)(86362001)(53546011)(7416002)(6506007)(55016002)(8676002)(478600001)(83380400001)(33656002)(26005)(8936002)(2906002)(4326008)(110136005)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: jfiZh/cSgxArdC2+jH9cyGwZuxIaGH4N/HbTosYt8DxSi44az5f+EP69a3T9IRqrpzp+AvJMExYwig94hcNJx8SBU9zGRuP52yT0sQFKllJqpLW/KaDRNg0QQqV8wliIZgXMPy/1JZYKb9Bk7y7FI80biO5Q7AmYMHb6NNYvLnvTwPMZ3pL90Vt5T7o9OelotDD26hrMOUs1YjwH/8u01QjHSFz3jQX1gbZHUtQ+f2rsASgBImckZFj1GvtCAvMkrQhhXRxtOlf6pZbSADTE0ChU85gheSFf4UjA3eAIBE4N3vKI6M6ymsD6HDs/Yym6TWoCR/c5nBfbjBltzec1NkeGNs20nAqcjIVrWpVlhNaveqzGa0vqEi5OP0Q1cS35ElQbUe5u36dCnXDjBnNW9QA1Vyciwk/F1gOIKwwTufpWRpSomlg1KO7LhG541mHxzS1OFaGm7RLQAsgIdvQJytTlvluonQLPWh1bZ/eUIMlBhUFztjVq6NtiVSglQWMwaIN7ReGFm/xySgDZggRRWBaFP1HkuMOzTqeEs3IflSPSLubF/5hsqxxr5X+NIRcwXXAu96RaUAe7yejgs0eeBU3UZIPYAm/q/9X8Qmk8U1haK576FK8uMTh5Bo2K4f9+64I9NN5PY3BTadSWHuHjWg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6772.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecda68d1-5fc0-4c5a-f822-08d854ae2281
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2020 10:50:15.1407 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sSbrhQH3G0hWf2LAuLt5uQlQm4AiSm+WK5XqCmvrNZbV2x/NpfZ8CAoJVjHhMzQgaGQWcmdSIiPn0CO3DDAZeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6275
Received-SPF: pass client-ip=40.107.93.53; envelope-from=saipava@xilinx.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 07:05:23
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Vikram Garhwal <fnuv@xilinx.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Paul Zimmerman <pauldzim@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>, Ying Fang <fangying1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgUGhpbGlwcGUsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGhp
bGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPg0KPiBTZW50OiBUdWVzZGF5
LCBTZXB0ZW1iZXIgOCwgMjAyMCA1OjU3IFBNDQo+IFRvOiBTYWkgUGF2YW4gQm9kZHUgPHNhaXBh
dmFAeGlsaW54LmNvbT47IFBldGVyIE1heWRlbGwNCj4gPHBldGVyLm1heWRlbGxAbGluYXJvLm9y
Zz47IE1hcmt1cyBBcm1icnVzdGVyIDxhcm1icnVAcmVkaGF0LmNvbT47DQo+ICdNYXJjLUFuZHLD
qSBMdXJlYXUnIDxtYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20+OyBQYW9sbyBCb256aW5pDQo+
IDxwYm9uemluaUByZWRoYXQuY29tPjsgR2VyZCBIb2ZmbWFubiA8a3JheGVsQHJlZGhhdC5jb20+
OyBFZGdhcg0KPiBJZ2xlc2lhcyA8ZWRnYXJpQHhpbGlueC5jb20+OyBGcmFuY2lzY28gRWR1YXJk
byBJZ2xlc2lhcw0KPiA8ZmlnbGVzaWFAeGlsaW54LmNvbT47IERhdmlkIEdpYnNvbiA8ZGF2aWRA
Z2lic29uLmRyb3BiZWFyLmlkLmF1Pg0KPiBDYzogcWVtdS1kZXZlbEBub25nbnUub3JnOyBBbGlz
dGFpciBGcmFuY2lzIDxhbGlzdGFpci5mcmFuY2lzQHdkYy5jb20+Ow0KPiBFZHVhcmRvIEhhYmtv
c3QgPGVoYWJrb3N0QHJlZGhhdC5jb20+OyBZaW5nIEZhbmcNCj4gPGZhbmd5aW5nMUBodWF3ZWku
Y29tPjsgVmlrcmFtIEdhcmh3YWwgPGZudXZAeGlsaW54LmNvbT47IFBhdWwNCj4gWmltbWVybWFu
IDxwYXVsZHppbUBnbWFpbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMS83XSB1c2Iv
aGNkLXhoY2k6IE1ha2UgZG1hIHJlYWQvd3JpdGVzIGhvb2tzIHBjaQ0KPiBmcmVlDQo+IA0KPiBP
biA5LzgvMjAgMTozNSBQTSwgU2FpIFBhdmFuIEJvZGR1IHdyb3RlOg0KPiA+IEhpIFBoaWxpcHBl
LA0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IFBoaWxp
cHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAcmVkaGF0LmNvbT4NCj4gPj4gU2VudDogVHVlc2Rh
eSwgU2VwdGVtYmVyIDgsIDIwMjAgNDowNSBQTQ0KPiA+PiBUbzogU2FpIFBhdmFuIEJvZGR1IDxz
YWlwYXZhQHhpbGlueC5jb20+OyBQZXRlciBNYXlkZWxsDQo+ID4+IDxwZXRlci5tYXlkZWxsQGxp
bmFyby5vcmc+OyBNYXJrdXMgQXJtYnJ1c3RlciA8YXJtYnJ1QHJlZGhhdC5jb20+Ow0KPiA+PiAn
TWFyYy1BbmRyw6kgTHVyZWF1JyA8bWFyY2FuZHJlLmx1cmVhdUByZWRoYXQuY29tPjsgUGFvbG8g
Qm9uemluaQ0KPiA+PiA8cGJvbnppbmlAcmVkaGF0LmNvbT47IEdlcmQgSG9mZm1hbm4gPGtyYXhl
bEByZWRoYXQuY29tPjsgRWRnYXINCj4gPj4gSWdsZXNpYXMgPGVkZ2FyaUB4aWxpbnguY29tPjsg
RnJhbmNpc2NvIEVkdWFyZG8gSWdsZXNpYXMNCj4gPj4gPGZpZ2xlc2lhQHhpbGlueC5jb20+OyBE
YXZpZCBHaWJzb24gPGRhdmlkQGdpYnNvbi5kcm9wYmVhci5pZC5hdT4NCj4gPj4gQ2M6IHFlbXUt
ZGV2ZWxAbm9uZ251Lm9yZzsgQWxpc3RhaXIgRnJhbmNpcw0KPiA+PiA8YWxpc3RhaXIuZnJhbmNp
c0B3ZGMuY29tPjsgRWR1YXJkbyBIYWJrb3N0IDxlaGFia29zdEByZWRoYXQuY29tPjsNCj4gPj4g
WWluZyBGYW5nIDxmYW5neWluZzFAaHVhd2VpLmNvbT47IFZpa3JhbSBHYXJod2FsIDxmbnV2QHhp
bGlueC5jb20+Ow0KPiA+PiBQYXVsIFppbW1lcm1hbiA8cGF1bGR6aW1AZ21haWwuY29tPg0KPiA+
PiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDEvN10gdXNiL2hjZC14aGNpOiBNYWtlIGRtYSByZWFk
L3dyaXRlcyBob29rcw0KPiA+PiBwY2kgZnJlZQ0KPiA+Pg0KPiA+PiBPbiA5LzgvMjAgMTI6MzAg
UE0sIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPiA+Pj4+PiBPbiA4LzI4LzIwIDk6
MTkgUE0sIFNhaSBQYXZhbiBCb2RkdSB3cm90ZToNCj4gPj4+Pj4+IFRoaXMgcGF0Y2ggc3RhcnRz
IG1ha2luZyB0aGUgaGNkLXhoY2kuYyBwY2kgZnJlZSwgYXMgcGFydCBvZiB0aGlzDQo+ID4+Pj4+
PiByZXN0cnVjdHVyaW5nIGRtYSByZWFkL3dyaXRlcyBhcmUgaGFuZGxlZCB3aXRob3V0IHBhc3Np
bmcgcGNpDQo+IG9iamVjdC4NCj4gPj4+Pj4+DQo+ID4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBTYWkg
UGF2YW4gQm9kZHUgPHNhaS5wYXZhbi5ib2RkdUB4aWxpbnguY29tPg0KPiA+Pj4+Pj4gLS0tDQo+
ID4+Pj4+PiAgaHcvdXNiL2hjZC14aGNpLmMgfCAyNCArKysrKysrKysrKy0tLS0tLS0tLS0tLS0N
Cj4gPj4+Pj4+IGh3L3VzYi9oY2QteGhjaS5oDQo+ID4+Pj4+PiB8DQo+ID4+Pj4+PiAzICsrKw0K
PiA+Pj4+Pj4gIDIgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25z
KC0pDQo+ID4+Pj4+Pg0KPiA+Pj4gWy4uLl0NCj4gPj4+Pj4+IC0tLSBhL2h3L3VzYi9oY2QteGhj
aS5oDQo+ID4+Pj4+PiArKysgYi9ody91c2IvaGNkLXhoY2kuaA0KPiA+Pj4+Pj4gQEAgLTIyLDYg
KzIyLDggQEANCj4gPj4+Pj4+ICAjaWZuZGVmIEhXX1VTQl9IQ0RfWEhDSV9IDQo+ID4+Pj4+PiAg
I2RlZmluZSBIV19VU0JfSENEX1hIQ0lfSA0KPiA+Pj4+Pj4NCj4gPj4+Pj4+ICsjaW5jbHVkZSAi
c3lzZW11L2RtYS5oIg0KPiA+Pj4+Pg0KPiA+Pj4+PiBBZGRyZXNzU3BhY2UgaXMgZm9yd2FyZC1k
ZWNsYXJlZCBpbiAicWVtdS90eXBlZGVmcy5oIiwgc28gbm8gbmVlZA0KPiA+Pj4+PiB0byBpbmNs
dWRlIGl0IGhlcmUgKHllcyBpbiB0aGUgc291cmNlcyBpbmNsdWRpbmcgaGNkLXhoY2kuaCkuDQo+
ID4+Pj4gW1NhaSBQYXZhbiBCb2RkdV0gWWVzIHlvdSBhcmUgcmlnaHQhLCBidXQgd2l0aG91dCB0
aGlzICIgZG1hX2FkZHJfdA0KPiA+Pj4+ICIgaXMNCj4gPj4gdW5kZWZpbmVkLg0KPiA+Pj4+IEF0
IHRoaXMgcG9pbnQgb2YgdGhlIHBhdGNoLCBoY2QteGhjaS5oIGlzIGNvbXBpbGVkIGFsb25nIHdp
dGggcGNpLmgNCj4gPj4+PiB3aGljaA0KPiA+PiB3b3VsZCBwcm92aWRlICdkbWFfYWRkcl90Jywg
YnV0IHdoZW4gd2Ugc3RyaXAgdGhlIHBjaSB3cmFwcGVyIGFyb3VuZA0KPiA+PiBoY2QtIHhoY2kg
d2Ugd291bGQgbWlzcyBpdC4gTGV0IG1lIGtub3csIGlmIGl0cyBnb29kIHRvIGFkZCBsYXRlciBp
bg0KPiA+PiB0aGUgcGF0Y2ggc2VyaWVzIHdoZW4gdGhlIHNwbGl0IGhhcHBlbnMuDQo+ID4+Pg0K
PiA+Pj4gT0sgOiggSSdkIHByZWZlciB0byBvbmx5IGluY2x1ZGUgInN5c2VtdS9kbWEuaCIgaW4g
aHcvdXNiL2hjZC14aGNpLmMuDQo+ID4+Pg0KPiA+Pj4gQ2MnaW5nIERhdmlkIHdobyBhZGRlZCBk
bWFfYWRkcl90IGluIGNvbW1pdCBlNTMzMmU2MzM0Zg0KPiA+Pj4gKCJpb21tdTogSW50cm9kdWNl
IElPTU1VIGVtdWxhdGlvbiBpbmZyYXN0cnVjdHVyZSIpLCBpdCBtaWdodCBiZQ0KPiA+Pj4gc2lt
cGxlciB0byBtb3ZlIGl0cyBkZWNsYXJhdGlvbiB0byAicWVtdS90eXBlZGVmcy5oIg0KPiA+Pj4g
dG9vLg0KPiA+Pg0KPiA+PiBCdHcgdGhpcyB0eXBlIHNob3VsZCBiZSBwb2lzb25lZCBmb3IgdXNl
ci1tb2RlLg0KPiA+IFtTYWkgUGF2YW4gQm9kZHVdIFRoYW5rcywgSSB3b3VsZCB0cnkgdG8gZGVm
aW5lIHRoZW0gaW4gdHlwZWRlZnMuaC4NCj4gPiBCVFcgSSdtIG5vdCBjbGVhciBhYm91dCBwb2lz
b25pbmcgdGhlbiBpbiB1c2VyLW1vZGUuIERvIHlvdSBtZWFuIGhpZGUNCj4gdGhlc2UgZGVmaW5l
cyBmb3IgdXNlci1tb2RlID8NCj4gDQo+IFRoaXMgZG9lc24ndCAiaGlkZSIgYnV0IHBvaXNvbiB0
aGVtOiBpZiB5b3UgdHJ5IHRvIHVzZSB0aGVtIHRoZSBjb21waWxlciAoY3BwDQo+IGFjdHVhbGx5
KSB3aWxsIHJhaXNlIGFuIGVycm9yLg0KPiANCj4gVGhpcyB3YXMgbm90IGEgZGlyZWN0IGNvbW1l
bnQgZm9yIHlvdSwgbW9yZSBzb21ldGhpbmcgdG8gZGlzY3VzcyBvdXQgb2YgdGhlDQo+IHNjb3Bl
IG9mIHlvdXIgc2VyaWVzIDspIE5vIG5lZWQgdG8gdHJ5IHRvIGRlY2xhcmUgaXQgcG9pc29uZWQg
bm93Lg0KW1NhaSBQYXZhbiBCb2RkdV0gT25lIG1vcmUgdGhpbmcsIHdoaWNoIGNhbWUgdXAgZHVy
aW5nIGltcGxlbWVudGF0aW9uIGlzIGRtYV9tZW1vcnlfcmVhZC8gZG1hX21lbW9yeV93cml0ZSBm
dW5jdGlvbnMgd2hpY2ggdXNlZCBpbiB0aGlzIHBhdGNoIHdvdWxkIHJlcXVpcmUgdGhhdCBoZWFk
ZXIuDQoNClJlZ2FyZHMsDQpTYWkgUGF2YW4NCj4gDQo+ID4NCj4gPiBSZWdhcmRzDQo+ID4gU2Fp
IFBhdmFuDQo+ID4+DQo+ID4+Pg0KPiA+Pj4gU28gbm8gY2hhbmdlIG5lZWRlZCBmb3IgdGhpcyBw
YXRjaC4NCj4gPj4+DQo+ID4+Pj4NCj4gPj4+PiBSZWdhcmRzLA0KPiA+Pj4+IFNhaSBQYXZhbg0K
PiA+Pj4+Pg0KPiA+Pj4+PiBXaXRoIHRoYXQgZml4ZWQ6DQo+ID4+Pj4+IFJldmlld2VkLWJ5OiBQ
aGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQHJlZGhhdC5jb20+DQo+ID4+Pj4+DQo+ID4+
Pj4+PiArDQo+ID4+Pj4+PiAgI2RlZmluZSBUWVBFX1hIQ0kgImJhc2UteGhjaSINCj4gPj4+Pj4+
ICAjZGVmaW5lIFRZUEVfTkVDX1hIQ0kgIm5lYy11c2IteGhjaSINCj4gPj4+Pj4+ICAjZGVmaW5l
IFRZUEVfUUVNVV9YSENJICJxZW11LXhoY2kiDQo+ID4+Pj4+PiBAQCAtMTg5LDYgKzE5MSw3IEBA
IHN0cnVjdCBYSENJU3RhdGUgew0KPiA+Pj4+Pj4NCj4gPj4+Pj4+ICAgICAgVVNCQnVzIGJ1czsN
Cj4gPj4+Pj4+ICAgICAgTWVtb3J5UmVnaW9uIG1lbTsNCj4gPj4+Pj4+ICsgICAgQWRkcmVzc1Nw
YWNlICphczsNCj4gPj4+Pj4+ICAgICAgTWVtb3J5UmVnaW9uIG1lbV9jYXA7DQo+ID4+Pj4+PiAg
ICAgIE1lbW9yeVJlZ2lvbiBtZW1fb3BlcjsNCj4gPj4+Pj4+ICAgICAgTWVtb3J5UmVnaW9uIG1l
bV9ydW50aW1lOw0KPiA+Pj4+Pj4NCj4gPj4+Pg0KPiA+Pj4NCj4gPg0KDQo=

