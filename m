Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90621C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 22:15:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E5112075F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 22:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="eDYJfmm/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E5112075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbAWA-0007BA-A9
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 18:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilmut@microsoft.com>)
 id 1jbAVE-0006Ky-G0
 for qemu-devel@nongnu.org; Tue, 19 May 2020 18:14:24 -0400
Received: from mail-mw2nam12on2139.outbound.protection.outlook.com
 ([40.107.244.139]:44362 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilmut@microsoft.com>)
 id 1jbAVC-000722-5F
 for qemu-devel@nongnu.org; Tue, 19 May 2020 18:14:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBJuZ5NJeg6go03CLQjEAmwnCW77XIDcloGraaVI1pskbCTZqUx6I6yc5ulBasPNJ5BPCBfX9rle71tNFlo3txtUWoQr0B6gStdK0JgCyVNc/ggukMvQ6DBruDM44LlHFDi7w3CLhGkhjOlQqsoJDpFpKTtjhpvjlK485Kormr6Dc5Uk7VPHeKQGKB7xYQrR2FcHUsZjr3dCplrmTRtr9UqMSUdASja9YhGfzxH2boTNPjOfneaifaPvqfHyUlngz7wDcGNtTv19SyF+82B7AtMdTH+PsKBFPaFAXUt0ciSo7QIPzbhOoJYhfc5IBCotdv/vJ9eL7+nZ864kWB4ibg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QTzxWHbC4wazVHAFFLNerhNZ1M+OPsadSf10VQ+c08k=;
 b=YNFN5WoqEjZKULQn4o++Wi5TJ/V1YoPsWj8S2qeSilmoy65cDVBwqqk1LUZNGlhM/sVOu1ioJsNt/NkpKdeRuMqgjtodm2tLZ3Ts8IB1kI1EVwFq5aI/i1z/idOG50a2NH+/92wkKdJWifI4Pb6TsuijlP2ortxKwviu2pVlnFupvsw3lucVu/EpMqUnmM0QbWUZ41ow0DnhMm2r5i3TFxVCKm6Mcqm4s9u7sG3sBRzOKRhKQgX8Wmrbq89GELrL1CZyLcMxj5+88oE+N+fHe5aaob3UKb+vlxEJFU76f8IVvmbBp2ekUWaUDm0UtqWnc0R9GkIP/7wlvkz0enhfhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QTzxWHbC4wazVHAFFLNerhNZ1M+OPsadSf10VQ+c08k=;
 b=eDYJfmm/3gte7g2rDkGPSW8uQpmi1s1/+Z8xYD5aQmKPCAvphoNoahi+DC1eYUoMHpFVf19sbgZCs2wurK2bAfFrqbe1J2+bdROk7747w/W/eUhmtuRFaa2u8hcjOz3u9ZILF0IJ78BB1i8A3ITo+M0u/3VYaBn+VwUHQl6WSLI=
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 (2603:10b6:803:51::33) by SN4PR2101MB0880.namprd21.prod.outlook.com
 (2603:10b6:803:51::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.15; Tue, 19 May
 2020 21:59:16 +0000
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::e954:af85:b4a6:a718]) by SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::e954:af85:b4a6:a718%7]) with mapi id 15.20.3021.018; Tue, 19 May 2020
 21:59:16 +0000
From: Sunil Muthuswamy <sunilmut@microsoft.com>
To: Stefan Weil <sw@weilnetz.de>, "Justin Terry (SF)" <juterry@microsoft.com>, 
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>, Eduardo
 Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <rth@twiddle.net>, Mike Battista <Mike.Battista@microsoft.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [EXTERNAL] Re: [PATCH] WHPX: Assigning maintainer for Windows
 Hypervisor Platform
Thread-Topic: [EXTERNAL] Re: [PATCH] WHPX: Assigning maintainer for Windows
 Hypervisor Platform
Thread-Index: AdXmmxkvbI0n3XG6RKSCtw/4QRCyRQAAgE9wABh4YAAAD08KsABT+sQAEWcNVVA=
Date: Tue, 19 May 2020 21:59:16 +0000
Message-ID: <SN4PR2101MB0880A6DE49500BCA0B1898EBC0B90@SN4PR2101MB0880.namprd21.prod.outlook.com>
References: <SN4PR2101MB0880E245954826FD91C9D67DC0110@SN4PR2101MB0880.namprd21.prod.outlook.com>
 <BN8PR21MB1297D3D88C41B6AFADE36DCCB6110@BN8PR21MB1297.namprd21.prod.outlook.com>
 <ecc9b0c5-7cd7-1f8d-d10c-bee7aff8fa01@redhat.com>
 <BN8PR21MB12974CEDAEC173FC8CD626DFB6100@BN8PR21MB1297.namprd21.prod.outlook.com>
 <6b5c046a-af4b-8adf-e3a2-64d904c9ff16@weilnetz.de>
In-Reply-To: <6b5c046a-af4b-8adf-e3a2-64d904c9ff16@weilnetz.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: weilnetz.de; dkim=none (message not signed)
 header.d=none;weilnetz.de; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [2601:602:9400:570:5974:dfc3:c4fc:f9e2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: de486811-3e3a-4954-7649-08d7fc3fdfb2
x-ms-traffictypediagnostic: SN4PR2101MB0880:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR2101MB0880D977C097AB931D7E7EA9C0B90@SN4PR2101MB0880.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 040866B734
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kRn2Cd3DRS76mzks2UGJyR8JVuRqZ52VrMbUSYVInpJPGZQbyFzz5JoB3Zuzv6JuiS1cnNngwO5P4vg6aEUao0EibQcnMO6NOaGcpf3yzZGOtZBaWvrP+0doCAjX5U9q1gRVKFkT0kJIq7rsRzFtEGilipy70iztIaoNw7AIDDdVvNt/LCZv8q5SgTfIkkBShOjkS3ClO46R1WELITVj13r0zrSRMl0sDMobi3IFu2c8QUz/C1epVF0oHeisn72ONnhK06YMBXasIYzeURBxlHww32/zhojGd4URYi0zAco9cC556MBvjpzmbWKWmjmtmL+k0QsOsgADbZim2OT0ew==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN4PR2101MB0880.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(396003)(376002)(39860400002)(136003)(8676002)(186003)(66946007)(6636002)(66556008)(52536014)(33656002)(4326008)(5660300002)(8990500004)(64756008)(71200400001)(66476007)(66446008)(6506007)(53546011)(10290500003)(316002)(7696005)(55016002)(86362001)(82950400001)(4744005)(2906002)(82960400001)(9686003)(478600001)(8936002)(76116006)(110136005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: sl8HNMnPfJbkRZdpJE8Hfgzu/Fd213fh1BIwC4UHZE0f+fPnvYrIDItQGYwkxSyghS7NqZXgb61v+Up1JwBj9Osroo85MmdE5lIwTKyqavk9giNm7Set/HmxlIUa9jbfTSMrBh2pO1wqDUIOM2X+iQXHfwCiVPGCDLMOeofm4IoE6VaCUXPvEt80ctrD/w9x+emqd6d41SLTtq+05CgeC0FKPPYdaggZrc/q6Y+j0wlCX6onX3LNl/awE4OY5qWFRY8e+5abe3y8JMNU1nLYFDtBJO/Cyk1Mo8k0DqnXP6erEGN8CGiVShx4e76Le6ETnF/pZcm73TCMhakHX4BiLtEsAA8GuAA01/AXtAbpDozmYcn4evQLfnvqZ8x+zj2KKs8vV0vKox2kePFZH1vJOfrMP/qM9CFwF1o7UnUNsBhv49gJSTfCXoabiFlwbQaxmf+VRUmglAMb3hOxBbbrasVwNsrcblarE4+YyIc+n9IkPQM/qF3/xgeecUxrIjdzxwiCRNEOjvfWA1HwRZe6z0XRu3bHuZ26ZRRGAbNyJ4hF8QtlZqr1sQV+UDEDSps6
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de486811-3e3a-4954-7649-08d7fc3fdfb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2020 21:59:16.1589 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vifypGepjBio6a1aczvQ9SPusF/Mjy5w0CgY51451az9uSuKUtDH1ZsP2JMovJ8lhvfDx3JZrKLgdMyy3pGgqeu90EQElWjXVnpW+Zz0YMU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR2101MB0880
Received-SPF: pass client-ip=40.107.244.139;
 envelope-from=sunilmut@microsoft.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 18:14:19
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RlZmFuIFdlaWwgPHN3
QHdlaWxuZXR6LmRlPg0KPiBTZW50OiBUaHVyc2RheSwgRmVicnVhcnkgMjAsIDIwMjAgMTE6NTQg
UE0NCj4gVG86IEp1c3RpbiBUZXJyeSAoU0YpIDxqdXRlcnJ5QG1pY3Jvc29mdC5jb20+OyBQaGls
aXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQHJlZGhhdC5jb20+OyBTdW5pbCBNdXRodXN3YW15
DQo+IDxzdW5pbG11dEBtaWNyb3NvZnQuY29tPjsgRWR1YXJkbyBIYWJrb3N0IDxlaGFia29zdEBy
ZWRoYXQuY29tPjsgUGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT47IFJpY2hhcmQN
Cj4gSGVuZGVyc29uIDxydGhAdHdpZGRsZS5uZXQ+DQo+IENjOiBxZW11LWRldmVsQG5vbmdudS5v
cmcNCj4gU3ViamVjdDogUmU6IFtFWFRFUk5BTF0gUmU6IFtQQVRDSF0gV0hQWDogQXNzaWduaW5n
IG1haW50YWluZXIgZm9yIFdpbmRvd3MgSHlwZXJ2aXNvciBQbGF0Zm9ybQ0KPiANCj4gQW0gMTku
MDIuMjAgdW0gMTY6NTAgc2NocmllYiBKdXN0aW4gVGVycnkgKFNGKToNCj4gDQo+IEhlbGxvIEp1
c3RpbiwgaGVsbG8gU3VuaWwsDQo+IA0KPiBqdXN0IGEgcmVtaW5kZXI6IHdlIHN0aWxsIGhhdmUg
dGhlIHByb2JsZW0gd2l0aCB0aGUgcHJvcHJpZXRhcnkgbGljZW5zZQ0KPiBmb3IgdGhlIHJlcXVp
cmVkIE1pY3Jvc29mdCBoZWFkZXIgZmlsZXMuDQo+IA0KPiBDYW4geW91IGVzdGltYXRlIHdoZW4g
dGhpcyB3aWxsIGJlIHNvbHZlZD8NCj4gDQo+IFJlZ2FyZHMsDQo+IFN0ZWZhbg0KPiANCg0KQWRk
aW5nIE1pa2UgQmF0dGlzdGEsIHdobyBpcyBvbiB0aGUgU0RLIHRlYW0gYW5kIGNhbiBoZWxwIHBy
b3ZpZGUgc29tZSBjbGFyaXR5IGFyb3VuZCB0aGUgcXVlc3Rpb25zIGFib3V0IFNESyBsaWNlbnNp
bmcuDQo=

