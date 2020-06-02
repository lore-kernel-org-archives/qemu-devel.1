Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A320BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 13:05:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72F91206A4
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 13:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="DGW19FCg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72F91206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg6c8-000683-NX
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 09:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jg41J-0000TT-K0
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 06:19:45 -0400
Received: from mail-db8eur05on2111.outbound.protection.outlook.com
 ([40.107.20.111]:56761 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jg41H-0006OM-QP
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 06:19:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBYaY3Au6czt/cZThiO0nf62sDu7cvdwzyG4ZNzFMKNH/ZdnJ3I0dInchB5AaWOFr25mMUGiJnUfpRttd9WILF7AYu20swOSFXvK4oNokvPSJGOuwJ1lL6ndd+lRx7nT/ifbTMMnzRxnlp0EeZsgBCvfN9jcfoMsCE7y9zE10Ordsq9wgg5fJBkKDdG65jfSmDBgKjMBIs9HtWcgsmw3oUgz6RrI6yHZOJFuEkAGisGyUUynEwvFVt6/oz6TsEz8+0GMXdu6lNDXtRJ/bu/pzhz4lyyB1rdQohITH4yXuU9XO4J931HTAvgaPJe6WSrzrneAskOm4IMb3BHivjMpfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sr6ycZF1ceQ2RBy1iEJnam659WHVTMd4mrdCT0t9BqA=;
 b=m/JwFa00BirvXSzyT/GpYHPjNstRp/Sx/NayR7hVDK3fxyj+o7QyL7C7gQV9qt5r1nclL7o50dGBcw3PMEavmtkGUd1zGkP2yRPLXicX/92ktsJ87KTi3NEg0d6G/pMOK7QSdzUahtV9vzxTXiY0OXQz+gjvc1I8v2m2GqmsNqUTu016rT5692y4aQL99lGOQSTRB7lNshQJbYf6P9cJ7vD8wO+xDAsYHCc95pBeZaFeF5MyvxC4Rs/FUOaZNBHvpMufMHjnDZNAbKaWy53urr8MII0/ec2iKpYAWK5NL5oEvbMRUv/p1tdAW3oLZCY/9UdbRpSp8ajWE8WnsZA/3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sr6ycZF1ceQ2RBy1iEJnam659WHVTMd4mrdCT0t9BqA=;
 b=DGW19FCg0L4NQev1Sesk3JgXLDuCEbQ5/jVsMGMzihn//lkK67axldNqBV0dcQH82mQ21A//qY+p0m+k73eDYkPoEMtEw6y+73U26Kg+hEukPIrsnBRz+biqz1QaEy46GBLESpgrq1ZAiKkQ8NyTeaWKugeQ2pSIRnaJcPBgQyI=
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB6104.eurprd03.prod.outlook.com (2603:10a6:20b:ec::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Tue, 2 Jun
 2020 10:04:37 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::7935:50dd:e879:bca8]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::7935:50dd:e879:bca8%7]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 10:04:37 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH 1/2] mailmap: Change email address of Filip Bozuta
Thread-Topic: [PATCH 1/2] mailmap: Change email address of Filip Bozuta
Thread-Index: AQHWOLs1M9+0h9C6gU+anhj+gcP/EajFGPuA
Date: Tue, 2 Jun 2020 10:04:37 +0000
Message-ID: <86c8f35e-083f-4015-7bf9-43c014f6ee35@syrmia.com>
References: <20200602085215.12585-1-aleksandar.qemu.devel@gmail.com>
 <20200602085215.12585-2-aleksandar.qemu.devel@gmail.com>
In-Reply-To: <20200602085215.12585-2-aleksandar.qemu.devel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=syrmia.com;
x-originating-ip: [46.240.135.226]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 06318936-34a2-418f-a5ef-08d806dc5c00
x-ms-traffictypediagnostic: AM6PR03MB6104:
x-microsoft-antispam-prvs: <AM6PR03MB6104247F0F6F1166CE0D5566EB8B0@AM6PR03MB6104.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-forefront-prvs: 0422860ED4
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jIINh+VjmrGM4r8Qsw/r5g6BWH+bpRn0fIQ5/6gWKFP8vmKxPhGFkWfv1SNeZ7PBUj6mucPfym1o7Qn7JmVgwof8l9tOVJsgL5FDmGyjRBh8O4teN0CqAcRNNq8jOWVvObs8JUQb4D7I/mDzxB2hr2Ed6CrDhhS0N0MSFpIxJBg9HWANOzqPAZEJ+WP06qtLiErHzSSwEeCLZnLJ+BUhStb/XRcwEEUTHKgs6XOkdZ+W6n3hp36UWJHxvWIRG2peFDb3T2sHHHkbuFYOQABPBFA4cdxpDeTlGhT6t2gvzDzE5eH+jy3tNgleiJi0oNLn
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(366004)(396003)(376002)(39830400003)(346002)(136003)(508600001)(71200400001)(2616005)(6506007)(31686004)(26005)(66446008)(66556008)(2906002)(186003)(64756008)(66946007)(4744005)(6486002)(86362001)(5660300002)(110136005)(66476007)(31696002)(76116006)(6512007)(91956017)(8936002)(8676002)(316002)(36756003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: cwjlGQT42eiy8dpkmUqUcOKILIkm9DQ/S7XwOdNDI4DFdp0ykDMiL8zGdVwXW6HW8FmQJrJgGYaQzcVHZ7VeSZk/hQU0pXrkX33Svicpj4uSVX8e+IQGPFfC5wLhMyXJi6+rZAn6KRpWBtcdQrJ+TsyeoQPmoZUjJY3vO6CZB20bh8XLLClSEamYTavhPY3yj6mcz22NHo/BC3Rb/qOQ/J7pTynXlkPCobnLTnE7yeY835B3jXr8O5jmmr8pzrKmecdkkT5COIv7usY+xKipycCEVyELtZeS5vbwJyTfXzKizDsKHwJT1gyM9nXP+wMGJWGRohQpIpwq3ivl/lys9hrI4S3yDa60vDnWk4IKv+FJD8hQGD1XWS6vfmIa0DaOlJ3q8NtEa+O3YrpqrpH3xmq/KSwLgbxN2OWWUvxb0C7Zkpw9IYNdW8XYL6M8Oq/eNLQV8Qtyhe1I/40+n5AZ8LDHrg+nsV9GIY/g5L4xciZuIfx19nzu//3N7v60UIWv
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0CD78217460D0E4AB25C1658E30DAB43@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06318936-34a2-418f-a5ef-08d806dc5c00
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2020 10:04:37.8593 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VJdpL5SzjF97+KwWL3+6C3N7VoTuyI5Gu0YG3TEcn8aWvUlQBm38hukpuwGF7FhRKJScc0jbRdqV222sqfqLzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB6104
Received-SPF: pass client-ip=40.107.20.111;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 06:19:41
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 02 Jun 2020 09:04:50 -0400
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

T24gMi42LjIwLiAxMDo1MiwgQWxla3NhbmRhciBNYXJrb3ZpYyB3cm90ZToNCj4gRmlsaXAgQnV6
dXRhIHdhbnRzIHRvIHVzZSBoaXMgbmV3IGVtYWlsIGFkZHJlc3MgZm9yIGhpcyBmdXR1cmUNCj4g
d29yayBpbiBRRU1VLg0KPg0KPiBDQzogRmlsaXAgQm96dXRhIDxmaWxpcC5ib3p1dGFAc3lybWlh
LmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQWxla3NhbmRhciBNYXJrb3ZpYyA8YWxla3NhbmRhci5x
ZW11LmRldmVsQGdtYWlsLmNvbT4NClJldmlld2VkLWJ5OiBGaWxpcCBCb3p1dGEgPGZpbGlwLmJv
enV0YUBzeXJtaWEuY29tPg0KPiAtLS0NCj4gICAubWFpbG1hcCB8IDEgKw0KPiAgIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvLm1haWxtYXAgYi8ubWFp
bG1hcA0KPiBpbmRleCBlMzYyOGM3YTY2Li45ZjJhM2E1NWY5IDEwMDY0NA0KPiAtLS0gYS8ubWFp
bG1hcA0KPiArKysgYi8ubWFpbG1hcA0KPiBAQCAtNDUsNiArNDUsNyBAQCBBbGVrc2FuZGFyIE1h
cmtvdmljIDxhbGVrc2FuZGFyLnFlbXUuZGV2ZWxAZ21haWwuY29tPiA8YW1hcmtvdmljQHdhdmVj
b21wLmNvbT4NCj4gICBBbGVrc2FuZGFyIFJpa2FsbyA8YWxla3NhbmRhci5yaWthbG9Ac3lybWlh
LmNvbT4gPGFyaWthbG9Ad2F2ZWNvbXAuY29tPg0KPiAgIEFsZWtzYW5kYXIgUmlrYWxvIDxhbGVr
c2FuZGFyLnJpa2Fsb0BzeXJtaWEuY29tPiA8YWxla3NhbmRhci5yaWthbG9AcnQtcmsuY29tPg0K
PiAgIEFudGhvbnkgTGlndW9yaSA8YW50aG9ueUBjb2RlbW9ua2V5LndzPiBBbnRob255IExpZ3Vv
cmkgPGFsaWd1b3JpQHVzLmlibS5jb20+DQo+ICtGaWxpcCBCb3p1dGEgPGZpbGlwLmJvenV0YUBz
eXJtaWEuY29tPiA8ZmlsaXAuYm96dXRhQHJ0LXJrLmNvbS5jb20+DQo+ICAgSmFtZXMgSG9nYW4g
PGpob2dhbkBrZXJuZWwub3JnPiA8amFtZXMuaG9nYW5AaW1ndGVjLmNvbT4NCj4gICBMZWlmIExp
bmRob2xtIDxsZWlmQG51dmlhaW5jLmNvbT4gPGxlaWYubGluZGhvbG1AbGluYXJvLm9yZz4NCj4g
ICBQYXVsIEJ1cnRvbiA8cGJ1cnRvbkB3YXZlY29tcC5jb20+IDxwYXVsLmJ1cnRvbkBtaXBzLmNv
bT4NCg0KDQo=

