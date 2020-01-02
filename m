Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D175C2D0DC
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 11:04:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBF6D206E6
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 11:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="OauzZhek"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBF6D206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imyHO-0005u1-VS
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 06:04:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41442)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1imyGY-0005TD-5U
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 06:03:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1imyGV-0000m1-LK
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 06:03:45 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:3856)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1imyGV-0000kw-Es
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 06:03:43 -0500
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 002Av2C1029252; Thu, 2 Jan 2020 03:03:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=fdNfZP3PM3h/c1F8ZEdy32Na1Z3VuL6wLjO3r32ulW8=;
 b=OauzZhek+soB/MVGfvFPAsuzB02mU29bEdKjuE/XmNHad4pRNh8mNTpiT0vMMjmXBt6r
 hWagIpHL068JQFUEJVylT7jpuzfdMnT1twkwXeRFeR/4euyp5V6ZtolOhWRffagLnsXc
 WJuDRVAAbNxbAzJCx/5LXXTe46JTssar77cwZNHuTxSApo6J5wIGs/BuOqY6SxCut2xV
 evqpqrUaG1w47DxpGbtCNYDNXYTSleNgXBh9zWzPX8foaCnwNbOSwQ0u1WWgAmeOz/wj
 8GkUIsR6hQ7L/QAVdmeKIYT5l2uUGNYooBIB4npNHKaQXivjFY7fTiByGJqdpOxMfeAS Nw== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
 by mx0b-002c1b01.pphosted.com with ESMTP id 2x65fff8wf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jan 2020 03:03:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZrAEbUxKXz9VHswsuVGqKfemC03lNAfl6mb5csQFtnqMmnMuRrFaKYg7pEolZ4BFlPm3hGTGqP2ZJYp7LYFA1ty5zc4J9ROiEqYJp8RuRs3ld3PJ+hRNd/sR6Jsk5VKnKD6tyQ44qLbR7ZF7yAhgr5JXNyUydXWV/LR/pz75utomm6fSPdq1ZNm8Fy2wwVdlNg/ckvvPo/xZz3Yh3sjZaKjpiZheZTMzHdCtf3+NFPXv8ebY4AlW0DVkeCIf8I+NiFjuxbIrRHZ4MkZieP27/JtyLbi7Ti85FRRpiiffCCma60prk0HC1ebmT0x3kc+oc/BJEpulDBR+QbXXcIsZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdNfZP3PM3h/c1F8ZEdy32Na1Z3VuL6wLjO3r32ulW8=;
 b=di1bZHu7jWsuBTwgnv1Ie6jlswX3c3MXn2NgwKblKWDeCS35JJjy4mOFH9dhvoTEIIhOkGIWC6WBPxwGQjTjDJoT71FY/HO2K9oWNMzUoQH6faxns+wa5Ab/A1KawL42vYSPB++oBey3qtHKAgirQjynZLUiJYVWVUmgp77H1ZTQunkAzvyGd79P/CZ2K+hYmZPn6DFmQ218y+69KwjuZenwVaQPUlofpcklKhwMduJIGBVCVu+b9FfkkL1EH3mXFHjCqM9lHxyIPW+WVK4EjuHl+ILvb0vmt92GVPiQ8tc8nqvIRp690SqD79XFgcXyeSwQcFE73yydAGWSENtVrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.142) by
 MWHPR02MB2832.namprd02.prod.outlook.com (10.175.50.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.10; Thu, 2 Jan 2020 11:03:22 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c8f8:4820:a24c:3029]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c8f8:4820:a24c:3029%10]) with mapi id 15.20.2602.012; Thu, 2 Jan 2020
 11:03:22 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [RFC v4 PATCH 00/49] Initial support of multi-process qemu -
 status update
Thread-Topic: [RFC v4 PATCH 00/49] Initial support of multi-process qemu -
 status update
Thread-Index: AQHVryW4uEZJ1V/hTUic5+7Y9QnlRqe35WUAgAVPdACAAAL3CIABWUIAgABrS4CAAmvVgIAACnqAgAAGGACAAV3YAIAACeWAgBRz+4CAAAW3AA==
Date: Thu, 2 Jan 2020 11:03:22 +0000
Message-ID: <C4F6A4B0-607A-4BEE-B722-8F5447F1ADB7@nutanix.com>
References: <20191213104116.GB1180977@stefanha-x1.localdomain>
 <20191216194655.GA5922@flaka>
 <AFBAD3A1-0E22-4E22-AF22-C56794929D87@nutanix.com>
 <20191217163316.GB1333385@stefanha-x1.localdomain>
 <DDE3DA62-31DD-437B-8392-CAD505253EED@nutanix.com>
 <20191219115545.GD1624084@stefanha-x1.localdomain>
 <772D9CF3-D15D-42D1-B9CF-1279619D7C20@nutanix.com>
 <20191219125504.GI1190276@redhat.com>
 <20191220094712.GA1635864@stefanha-x1.localdomain>
 <20191220102237.GA1699760@redhat.com>
 <20200102104255.GF121208@stefanha-x1.localdomain>
In-Reply-To: <20200102104255.GF121208@stefanha-x1.localdomain>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93102a9a-3a5c-4668-2bb0-08d78f73624d
x-ms-traffictypediagnostic: MWHPR02MB2832:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR02MB28329A0F2098449FF27E1785D7200@MWHPR02MB2832.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0270ED2845
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(396003)(346002)(39860400002)(366004)(136003)(189003)(199004)(91956017)(8936002)(5660300002)(36756003)(66946007)(76116006)(26005)(66446008)(66556008)(64756008)(54906003)(186003)(66476007)(6486002)(6916009)(15650500001)(107886003)(4326008)(33656002)(8676002)(53546011)(6506007)(71200400001)(86362001)(81156014)(81166006)(2906002)(6512007)(478600001)(7416002)(2616005)(316002)(64030200001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR02MB2832;
 H:MWHPR02MB2656.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AwSwjH8ca2tEgtmf0FXh0MSyg4v6hrdnEn1g1Rp9VoatEIQzAbhP46ID4RIn5TwBtMCKlVWusaRGdwqynamvRrGQltTxnRClOOjnbiDgqUFEiX8e5gff/5X9nNPM3ftZuVbvpGoadDSNJWfOHqygEvmBfwK2xcStA8icMrvaEWpUdeP/uEXimyHHAqshdp0nMLxc7LdrxJi9VsoL41RirwfKiFSXB54veGRX2aJfwt2PskbQoBY8Eh2q8XKQfTmaM2O6L17tLIrBNbT3XoxPrhg71SUUeJ6HcgIjkwVlVmLwUBTnrKAkfINCMkAkKwcZeN2v1kYHtDKwhIhBDTvtazb2yIr3IiRm4xjlFBe/QRdwsPrKxzgd64dfFKZBnhV9SjaY4VOGbWCtkBDZ5tkiJOGLl9zUX2QMurmV5TOew+353swqkVbx2rv+J9f/tFcDpFKEoek503t4xfHfZKNNzz+VMK1SRmzD/eaSS6UiOf24XR1BH8TgbleGlLfPKL38
Content-Type: text/plain; charset="utf-8"
Content-ID: <747C7B66F830414681E284314846D687@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93102a9a-3a5c-4668-2bb0-08d78f73624d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2020 11:03:22.6361 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cI9B4j+6B8Vy83C+kGeCPjpKpux7DHZr2ycs2lkDD0nhEJ+MMi5zEhkmMFfwonj0GEn0/7911SRVc6fdqljlasbetZlS4AW2rCYMvhaSWgw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2832
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-02_02:2020-01-02,2020-01-02 signatures=0
X-Proofpoint-Spam-Reason: safe
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.155.12
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "fam@euphon.net" <fam@euphon.net>, Swapnil Ingle <swapnil.ingle@nutanix.com>,
 "john.g.johnson@oracle.com" <john.g.johnson@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Walker,
 Benjamin" <benjamin.walker@intel.com>, "kraxel@redhat.com" <kraxel@redhat.com>,
 "jag.raman@oracle.com" <jag.raman@oracle.com>, "Harris, 
 James R" <james.r.harris@intel.com>,
 "quintela@redhat.com" <quintela@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "kanth.ghatraju@oracle.com" <kanth.ghatraju@oracle.com>,
 "thuth@redhat.com" <thuth@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "liran.alon@oracle.com" <liran.alon@oracle.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 "rth@twiddle.net" <rth@twiddle.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "ross.lagerwall@citrix.com" <ross.lagerwall@citrix.com>,
 "marcandre.lureau@gmail.com" <marcandre.lureau@gmail.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gT24gSmFuIDIsIDIwMjAsIGF0IDEwOjQyIEFNLCBTdGVmYW4gSGFqbm9jemkgPHN0ZWZh
bmhhQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBGcmksIERlYyAyMCwgMjAxOSBhdCAxMDoy
MjozN0FNICswMDAwLCBEYW5pZWwgUC4gQmVycmFuZ8OpIHdyb3RlOg0KPj4gT24gRnJpLCBEZWMg
MjAsIDIwMTkgYXQgMDk6NDc6MTJBTSArMDAwMCwgU3RlZmFuIEhham5vY3ppIHdyb3RlOg0KPj4+
IE9uIFRodSwgRGVjIDE5LCAyMDE5IGF0IDEyOjU1OjA0UE0gKzAwMDAsIERhbmllbCBQLiBCZXJy
YW5nw6kgd3JvdGU6DQo+Pj4+IE9uIFRodSwgRGVjIDE5LCAyMDE5IGF0IDEyOjMzOjE1UE0gKzAw
MDAsIEZlbGlwZSBGcmFuY2lvc2kgd3JvdGU6DQo+Pj4+Pj4gT24gRGVjIDE5LCAyMDE5LCBhdCAx
MTo1NSBBTSwgU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUBnbWFpbC5jb20+IHdyb3RlOg0KPj4+
Pj4+IE9uIFR1ZSwgRGVjIDE3LCAyMDE5IGF0IDEwOjU3OjE3UE0gKzAwMDAsIEZlbGlwZSBGcmFu
Y2lvc2kgd3JvdGU6DQo+Pj4+Pj4+PiBPbiBEZWMgMTcsIDIwMTksIGF0IDU6MzMgUE0sIFN0ZWZh
biBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4gd3JvdGU6DQo+Pj4+Pj4+PiBPbiBNb24s
IERlYyAxNiwgMjAxOSBhdCAwNzo1NzozMlBNICswMDAwLCBGZWxpcGUgRnJhbmNpb3NpIHdyb3Rl
Og0KPj4+Pj4+Pj4+PiBPbiAxNiBEZWMgMjAxOSwgYXQgMjA6NDcsIEVsZW5hIFVmaW10c2V2YSA8
ZWxlbmEudWZpbXRzZXZhQG9yYWNsZS5jb20+IHdyb3RlOg0KPj4+Pj4+Pj4+PiDvu79PbiBGcmks
IERlYyAxMywgMjAxOSBhdCAxMDo0MToxNkFNICswMDAwLCBTdGVmYW4gSGFqbm9jemkgd3JvdGU6
DQo+Pj4+PiBUbyBiZSBjbGVhcjogSSdtIHZlcnkgaGFwcHkgdG8gaGF2ZSBhIHVzZXJzcGFjZS1v
bmx5IG9wdGlvbiBmb3IgdGhpcywNCj4+Pj4+IEkganVzdCBkb24ndCB3YW50IHRvIGRpdGNoIHRo
ZSBrZXJuZWwgbW9kdWxlICh5ZXQsIGFueXdheSkuIDopDQo+Pj4+IA0KPj4+PiBJZiBpdCBkb2Vz
bid0IGNyZWF0ZSB0b28gbGFyZ2Ugb2YgYSBidXJkZW4gdG8gc3VwcG9ydCBib3RoLCB0aGVuIEkg
dGhpbmsNCj4+Pj4gaXQgaXMgdmVyeSBkZXNpcmFibGUuIElJVUMsIHRoaXMgaXMgc2F5aW5nIGEg
a2VybmVsIGJhc2VkIHNvbHV0aW9uIGFzIHRoZQ0KPj4+PiBvcHRpbWl6ZWQvb3B0aW1hbCBzb2x1
dGlvbiwgYW5kIHVzZXJzcGFjZSBVTklYIHNvY2tldCBiYXNlZCBvcHRpb24gYXMgdGhlDQo+Pj4+
IGdlbmVyaWMgIndvcmtzIGV2ZXJ5d2hlcmUiIGZhbGxiYWNrIHNvbHV0aW9uLg0KPj4+IA0KPj4+
IEknbSBzbGlnaHRseSBpbiBmYXZvciBvZiB0aGUga2VybmVsIGltcGxlbWVudGF0aW9uIGJlY2F1
c2UgaXQga2VlcHMgdXMNCj4+PiBiZXR0ZXIgYWxpZ25lZCB3aXRoIFZGSU8uICBUaGF0IG1lYW5z
IHNvbHZpbmcgcHJvYmxlbXMgaW4gb25lIHBsYWNlIG9ubHkNCj4+PiBhbmQgbGVzcyByZWludmVu
dGluZyB0aGUgd2hlZWwuDQo+Pj4gDQo+Pj4gS25vd2luZyB0aGF0IGEgdXNlcnNwYWNlIGltcGxl
bWVudGF0aW9uIGlzIHBvc3NpYmxlIGlzIGEgcGx1cyB0aG91Z2guDQo+Pj4gTWF5YmUgdGhhdCBv
cHRpb24gd2lsbCBiZWNvbWUgYXR0cmFjdGl2ZSBpbiB0aGUgZnV0dXJlIGFuZCBzb21lb25lIHdp
bGwNCj4+PiBkZXZlbG9wIGl0LiAgSW4gZmFjdCwgYSB1c2Vyc3BhY2UgaW1wbGVtZW50YXRpb24g
bWF5IGJlIGEgY29vbCBHb29nbGUNCj4+PiBTdW1tZXIgb2YgQ29kZSBwcm9qZWN0IGlkZWEgdGhh
dCBJJ2QgbGlrZSB0byBjby1tZW50b3IuDQo+PiANCj4+IElmIGl0IGlzIHRlY2huaWNhbGx5IHZp
YWJsZSBhcyBhbiBhcHByb2FjaCwgdGhlbiBJIHRoaW5rICB3ZSBzaG91bGQgYmUNCj4+IHRyZWF0
aW5nIGEgZnVsbHkgdW5wcml2aWxlZ2VkIG11c2VyLW92ZXItVU5JWCBzb2NrZXQgYXMgYSBoaWdo
ZXIgcHJpb3JpdHkNCj4+IHRoYW4ganVzdCAibWF5YmUgYSBHU29DIHN0dWRlbnQgd2lsbCB3YW50
IHRvZG8gaXQiLg0KPj4gDQo+PiBMaWJ2aXJ0IGlzIGdldHRpbmcgc3Ryb25nIG1lc3NhZ2UgZnJv
bSBLdWJlVmlydCBwcm9qZWN0IHRoYXQgdGhleSB3YW50IHRvDQo+PiBiZSBydW5uaW5nIGJvdGgg
bGlidmlydGQgYW5kIFFFTVUgZnVsbHkgdW5wcml2aWxlZ2VkLiBUaGlzIGFsbG93cyB0aGVpcg0K
Pj4gY29udGFpbmVycyB0byBiZSB1bnByaXZpbGVnZWQuIEFueXRoaW5nIHRoYXQgcmVxdWlyZXMg
cHJpdmlsZWdlcyByZXF1aXJlcw0KPj4ganVtcGluZyB0aHJvdWdoIGV4dHJhIGhvb3BzIHdyaXRp
bmcgY3VzdG9tIGNvZGUgaW4gS3ViZVZpcnQgdG8gZG8gdGhpbmdzDQo+PiBvdXRzaWRlIGxpYnZp
cnQgaW4gc2lkZSBsb2FkZWQgcHJpdmlsZWdlZCBjb250YWluZXJzIGFuZCB0aGlzIGxpbWl0cyBo
b3cNCj4+IHdoZXJlIHRob3NlIGZlYXR1cmVzIGNhbiBiZSB1c2VkLg0KPiANCj4gT2theSB0aGlz
IG1ha2VzIHNlbnNlLg0KPiANCj4gVGhlcmUgbmVlZHMgdG8gYmUgYSBjb25zZW5zdXMgb24gd2hl
dGhlciB0byBnbyB3aXRoIGEgcWRldi1vdmVyLXNvY2tldA0KPiBhcHByb2FjaCB0aGF0IGlzIFFF
TVUtc3BlY2lmaWMgYW5kIHN0cm9uZ2x5IGRpc2NvdXJhZ2VzIHRoaXJkLXBhcnR5DQo+IGRldmlj
ZSBkaXN0cmlidXRpb24gb3IgYSBtdXNlci1vdmVyLXNvY2tldCBhcHByb2FjaCB0aGF0IG9mZmVy
cyBhIHN0YWJsZQ0KPiBBUEkgZm9yIFZNTSBpbnRlcm9wZXJhYmlsaXR5IGFuZCB0aGlyZC1wYXJ0
eSBkZXZpY2UgZGlzdHJpYnV0aW9uLg0KDQpUaGUgcmVhc29uIEkgZGlzbGlrZSB5ZXQgYW5vdGhl
ciBvZmZsb2FkaW5nIHByb3RvY29sIChpZS4gdGhlcmUgaXMNCnZob3N0LCB0aGVyZSBpcyB2Zmlv
LCBhbmQgdGhlbiB0aGVyZSB3b3VsZCBiZSBxZGV2LW92ZXItc29ja2V0KSBpcw0KdGhhdCB3ZSBr
ZWVwIHJlaW52ZW50aW5nIHRoZSB3aGVlbC4gSSB2ZXJ5IG11Y2ggcHJlZmVyIHBpY2tpbmcNCnNv
bWV0aGluZyBzb2xpZCAoZWcuIFZGSU8pIGFuZCBrZWVwIGludmVzdGluZyBvbiBpdC4NCg0KPiBJ
bnRlcm9wZXJhYmlsaXR5IGJldHdlZW4gVk1NcyBhbmQgYWxzbyBEUERLL1NQREsgaXMgaW1wb3J0
YW50IGJlY2F1c2UNCj4gdGhleSBmb3JtIHRvZGF5J3Mgb3BlbiBzb3VyY2UgdmlydHVhbGl6YXRp
b24gY29tbXVuaXR5LiAgTm8gb25lIHByb2plY3QNCj4gb3IgY29kZWJhc2UgY292ZXJzIGFsbCB1
c2UgY2FzZXMgb3IgaW50ZXJlc3RpbmcgZGV2ZWxvcG1lbnRzLiAgSWYgd2UgYXJlDQo+IHNob3J0
LXNpZ2h0ZWQgYW5kIHByZXZlbnQgY29sbGFib3JhdGlvbiB0aGVuIHdlJ2xsIGJlY29tZSBpc29s
YXRlZC4NCj4gDQo+IE9uIHRoZSBvdGhlciBoYW5kLCBJJ20gcGVyc29uYWxseSBvcHBvc2VkIHRv
IHByb3ByaWV0YXJ5IHZlbmRvcnMgdGhhdA0KPiBjb250cmlidXRlIHZlcnkgbGl0dGxlIHRvIG9w
ZW4gc291cmNlLiAgV2UgbWFrZSB0aGF0IGVhc2llciBieSBvZmZlcmluZw0KPiBhIHN0YWJsZSBB
UEkgZm9yIHRoaXJkLXBhcnR5IGRldmljZXMuICBBIHN0YWJsZSBBUEkgZGlzY291cmFnZXMgb3Bl
bg0KPiBzb3VyY2UgY29udHJpYnV0aW9ucyB3aGlsZSBhbGxvd2luZyBwcm9wcmlldGFyeSB2ZW5k
b3JzIHRvIGJlbmVmaXQgZnJvbQ0KPiB0aGUgd29yayB0aGF0IHRoZSBvcGVuIHNvdXJjZSBjb21t
dW5pdHkgaXMgZG9pbmcuDQoNCkkgYXBwcmVjaWF0ZSB0aGUgY29uY2Vybi4gSG93ZXZlciwgbXkg
b3BpbmlvbiBpcyB0aGF0IHZlbmRvcnMgY2Fubm90DQpiZSBzdG9wcGVkIGJ5IHByb3ZpZGluZyB0
aGVtIHdpdGggdW5zdGFibGUgQVBJcy4gVGhlcmUgYXJlIHBsZW50eSBvZg0KZXhhbXBsZXMgd2hl
cmUgcHJvamVjdHMgd2VyZSBmb3JrZWQgYW5kIG1haW50YWluZWQgc2VwYXJhdGVseSB0byBrZWVw
DQpjZXJ0YWluIHRoaW5ncyB1bmRlciBjb250cm9sIGFuZCB0aGF0IGlzIGJhZCBmb3IgZXZlcnlv
bmUuIFRoZQ0KY29tbXVuaXR5IGRvZXNuJ3QgZ2V0IGNvbnRyaWJ1dGlvbnMgYmFjaywgYW5kIHZl
bmRvcnMgaGF2ZSBleHRyYSBwYWluDQp0byBtYWludGFpbiB0aGUgZm9ya3MuIEZ1cnRoZXJtb3Jl
LCBzZXJ2aWNlIHZlbmRvcnMgd2lsbCBhbHdheXMgZ2V0DQphd2F5IHdpdGggbXVyZGVyIGJ5IGNv
cHlpbmcgd2hhdGV2ZXIgdGhleSBsaWtlIGFuZCB1c2luZyBob3dldmVyIHRoZXkNCnBsZWFzZSAo
c2luY2UgdGhleSBhcmUgbm90IHNoYXJpbmcgdGhlIHNvZnR3YXJlKS4NCg0KSSB3b3VsZCByYXRo
ZXIgbG9vayBhdCBleGFtcGxlcyBsaWtlIEtWTS4gSXQncyBhIHJlbGF0aXZlbHkgc3RhYmxlIEFQ
SQ0Kd2l0aCBzZXZlcmFsIHByb3ByaWV0YXJ5IHVzZXJzLiBOZXZlcnRoZWxlc3MsIHdlIHNlZSBs
b2FkcyBvZg0KY29udHJpYnV0aW9ucyB0byBpdCAocGVyaGFwcyBsZXNzIHRoYW4gd2Ugd291bGQg
d2FudCwgYnV0IHBsZW50eSkuDQoNCj4gDQo+IE9uZSB3YXkgdG8gY2hvb3NlIGEgcG9zaXRpb24g
aXMgdG8gYmFsYW5jZSB1cCB0aGUgb3BlbiBzb3VyY2UgdnMNCj4gcHJvcHJpZXRhcnkgYXBwbGlj
YXRpb25zIG9mIGEgc3RhYmxlIEFQSS4gIEF0IHRoaXMgcG9pbnQgaW4gdGltZSBJIHRoaW5rDQo+
IHRoZSBEUERLL1NQREsgYW5kIHJ1c3Qtdm1tIGNvbW11bml0aWVzIGJyaW5nIGVub3VnaCB0byB0
aGUgdGFibGUgdGhhdA0KPiBpdCdzIHdvcnRoIGZvc3RlcmluZyBjb2xsYWJvcmF0aW9uIHRocm91
Z2ggYSBzdGFibGUgQVBJLiAgVGhlIGJlbmVmaXQgb2YNCj4gaGF2aW5nIHRoZSBzdGFibGUgQVBJ
IGlzIGxhcmdlIGVub3VnaCB0aGF0IHRoZSBkaXNhZHZhbnRhZ2Ugb2YgbWFraW5nDQo+IGxpZmUg
ZWFzaWVyIGZvciBwcm9wcmlldGFyeSB2ZW5kb3JzIGNhbiBiZSBhY2NlcHRlZC4NCg0KSSBhZ3Jl
ZSB3aXRoIHlvdSBhcyBwZXIgcmVhc29uaW5nIGFib3ZlLg0KDQo+IA0KPiBUaGlzIGlzIGp1c3Qg
YSBtb3JlIGVsYWJvcmF0ZSBleHBsYW5hdGlvbiBmb3IgdGhlICJ0aGUgY2F0IGlzIG91dCBvZiB0
aGUNCj4gYmFnIiBjb21tZW50cyB0aGF0IGhhdmUgYWxyZWFkeSBiZWVuIG1hZGUgb24gbGljZW5z
aW5nLiAgRG9lcyBhbnlvbmUNCj4gc3RpbGwgZGlzYWdyZWUgb3Igd2FudCB0byBkaXNjdXNzIGZ1
cnRoZXI/DQo+IA0KPiBJZiB0aGVyZSBpcyBhZ3JlZW1lbnQgdGhhdCBhIHN0YWJsZSBBUEkgaXMg
b2theSB0aGVuIEkgdGhpbmsgdGhlDQo+IHByYWN0aWNhbCB3YXkgdG8gZG8gdGhpcyBpcyB0byBm
aXJzdCBtZXJnZSBhIGNsZWFuZWQtdXAgdmVyc2lvbiBvZg0KPiBtdWx0aS1wcm9jZXNzIFFFTVUg
YXMgYW4gdW5zdGFibGUgZXhwZXJpbWVudGFsIEFQSS4gIE9uY2UgaXQncyBiZWluZw0KPiB0ZXN0
ZWQgYW5kIHVzZWQgd2UgY2FuIHdyaXRlIGEgcHJvdG9jb2wgc3BlY2lmaWNhdGlvbiBhbmQgcHVi
bGlzaCBpdCBhcw0KPiBhIHN0YWJsZSBpbnRlcmZhY2Ugd2hlbiB0aGUgc3BlYyBoYXMgYWRkcmVz
c2VkIG1vc3QgdXNlIGNhc2VzLg0KPiANCj4gRG9lcyB0aGlzIHNvdW5kIGdvb2Q/DQoNCkluIHRo
YXQgY2FzZSwgd291bGRuJ3QgaXQgYmUgcHJlZmVyYWJsZSB0byByZXZpdmUgb3VyIHByb3Bvc2Fs
IGZyb20NCkVkaW5idXJnaCAoS1ZNIEZvcnVtIDIwMTgpPyBPdXIgcHJvdG90eXBlcyBtb3ZlZCBt
b3JlIG9mIHRoZSBRZW11IFZGSU8NCmNvZGUgdG8gImNvbW1vbiIgYW5kIGFkZGVkIGEgInVzZXIi
IGJhY2tlbmQgdW5kZXJuZWF0aCBpdCwgc2ltaWxhciB0bw0KaG93IHZob3N0LXVzZXItc2NzaSBt
b3ZlZCBzb21lIG9mIHZob3N0LXNjc2kgdG8gdmhvc3Qtc2NzaS1jb21tb24gYW5kDQphZGRlZCB2
aG9zdC11c2VyLXNjc2kuIEl0IHdhcyBjZW50cmljIG9uIFBDSSwgYnV0IGl0IGRvZXNuJ3QgaGF2
ZSB0bw0KYmUuIFRoZSBvdGhlciBzaWRlIGNhbiBiZSBpbXBsZW1lbnRlZCBpbiBsaWJtdXNlciBm
b3IgZmFjaWxpdGF0aW5nIHRoaW5ncy4NCg0KSSBldmVuIHJlY2FsbCBoaWdobGlnaHRpbmcgdGhh
dCB2aG9zdC11c2VyIGNvdWxkIGJlIG1vdmVkIHVuZGVybmVhdGgNCnRoYXQgbGF0ZXIsIGdyZWF0
bHkgc2ltcGxpZnlpbmcgbG90cyBvZiBvdGhlciBRZW11IGNvZGUuDQoNCkYuDQoNCg0KPiANCj4g
U3RlZmFuDQoNCg==

