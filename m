Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A227DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 00:56:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BED92073E
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 00:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lezqMoqo";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="r2g0lEdZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BED92073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr9zs-0001du-II
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 20:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=446c5dbe3=Dmitry.Fomichev@wdc.com>)
 id 1jr9rA-0003yF-Lt; Thu, 02 Jul 2020 20:47:08 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:42284)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=446c5dbe3=Dmitry.Fomichev@wdc.com>)
 id 1jr9r8-0006sn-HB; Thu, 02 Jul 2020 20:47:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593737226; x=1625273226;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=0e/vm8l4e1Mxtk0APbdYTx3rvoxkIQdKHe1dqY3pZFU=;
 b=lezqMoqoviVUIehAulwKurCCl3CvETtQv5/yxhMPEK6TZ0thatPMFzMs
 Sf3yvQejUBsVLEfwsEwGrwKrSnthcV39hiIExoXoCaDsRQxkwqgs3HHtT
 gpc3E8gcbEIzgv1+TflA1OePqtudLctnEiSgXNX035IAiq65n+jzXREFd
 q1U0sbmukjf7LMWb51uaifSW2tXguuf7Pic432zoxm6Ot2nyXDmBEtdhi
 wC1aeNfzjc0X8NSU0opAWzgS2eiUi5fbeiK2xhPY1rrjCsafM9v3405BG
 z3xbPCZxA33VvG9ByfeKLDtpRGJE7myqPwJsetCHDatO7u75yF782lOjo w==;
IronPort-SDR: qXrxOpHXFyLoVVgtJJHYRc/51n11+EUwiy1WhZR90p0ikr1tkRkYB32b+Klvnrh1zYwvFNfaLD
 4Erdi0jMN8Ykwroxn7JvLK7OaGs+IClsx9GL7RgaUabBj55HIM+9sN7eD+6WSgT+nbNord96Vb
 Llt4+TAcnCiSXM35LW/H6mSqsUqr33aId2XdM0nbqb+xPHuKclvSrnq9jUhg3oogGWXNPZTQkR
 0bHckiKMb7Zqy3uhwAVv88+ntRTwgPyScS8P628X6ltaXe5+qkCy7RhNroHzdzVxVqX+sDLaVA
 hWc=
X-IronPort-AV: E=Sophos;i="5.75,306,1589212800"; d="scan'208";a="250767702"
Received: from mail-bn8nam11lp2173.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.173])
 by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2020 08:47:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lFhkJzFlMuIgZlQW1I+BSj/Y5J7iubc3MdLQTSWJHausaRD9CBl68fw9VtBac+Fc2cV/7Tm2umzfN8nljtUPOrAjy69EwNW8oq7E10fZZiMEMq30CG+ocOkVe+7BpTx3F14cXSY62F6VyI6RSVnXHV6j42FYgkmrJZgwIZeGW64MMFUm1zL0SXd0bD2TpUxiVp6JvQOHU48aAMxyGoKb9xoglmYxOSBeIpdOlgAaCCChQPkM80xdISgqq1n3bSSDdbW554VDSS8G2Zn9e1U8I3qHMbo0m6UxiIHzmC+pNs7gzTxLN9f22c2EWJhH5S/ZCbUEHeH54FMnIky7u2ejQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0e/vm8l4e1Mxtk0APbdYTx3rvoxkIQdKHe1dqY3pZFU=;
 b=TVJJzwcUWhLo0ZmYSfibs+j0fRvlvByxheF/53d5banKUzGzNDhpp+ZnQ1/rlIvaSK8xd2hR15D+j3UJCqu7djUM0uJp8JBClDfvGdqOuhpfSpkejHUireLAYMXv4RTaTfZxuw20OX5GQBF1a2xHF66XsWDvadDNUle7xPgSh+G7SeHrtgiZRgkgg95+nh6Y8RvDjGZH1a6v7Ht5JTnE0UHRviHIgW1U9ljM0+BHSu3j5PELMcqDIeY9WB4NvQtN9wANHE552tnPYA0KcUNn75Qa1Oy7Zckv/JOv55jg7xVdAEWn48TtVmxut1jCANj5l9rBWPdykdbKv7iE+77J7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0e/vm8l4e1Mxtk0APbdYTx3rvoxkIQdKHe1dqY3pZFU=;
 b=r2g0lEdZx+JN8w+Bt7l04EKSuk0CQwDzn4L7ltin8MZUCAggoUAfZ+boyRGW0iexRvyEhDPQvT/rd/vRgEFKBaPzW37GwDCeUxprs84blSiX9QLNOyNwb1cC1cjRtuiVrWZS6ua5HZX6GQYRjHLHYCp9dSdgMcmeGo9y7JcLhZ4=
Received: from MN2PR04MB5951.namprd04.prod.outlook.com (2603:10b6:208:3f::13)
 by MN2PR04MB5552.namprd04.prod.outlook.com (2603:10b6:208:de::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Fri, 3 Jul
 2020 00:47:03 +0000
Received: from MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::60c5:4424:8ce4:59a9]) by MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::60c5:4424:8ce4:59a9%5]) with mapi id 15.20.3153.023; Fri, 3 Jul 2020
 00:47:03 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: "its@irrelevant.dk" <its@irrelevant.dk>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 15/17] hw/block/nvme: enforce valid queue creation sequence
Thread-Topic: [PATCH 15/17] hw/block/nvme: enforce valid queue creation
 sequence
Thread-Index: AQHWTkNNdjey5t/7aUqa+0JGAtU/Cqj1CmcA
Date: Fri, 3 Jul 2020 00:47:02 +0000
Message-ID: <6bb5284675cc241c11c683c3699b37500fe25a84.camel@wdc.com>
References: <20200629182642.1170387-1-its@irrelevant.dk>
 <20200629182642.1170387-16-its@irrelevant.dk>
In-Reply-To: <20200629182642.1170387-16-its@irrelevant.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
authentication-results: irrelevant.dk; dkim=none (message not signed)
 header.d=none;irrelevant.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [173.70.233.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 082851a2-ac4c-4759-5a5a-08d81eea9a26
x-ms-traffictypediagnostic: MN2PR04MB5552:
x-microsoft-antispam-prvs: <MN2PR04MB555275923526CFA24EDDDB39E16A0@MN2PR04MB5552.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 045315E1EE
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sO9E7sIoHJ2+ydxhJF5kiFd2jrHXJ/G6MK3nEjaNh5WSZlqLTbFKaGv61S3RQSlhoZVI6HPjYQBWJ35XKGzvdoqbz0OKlsCP+RUQI9hYUBc45Xlg1H4vHZem8pouH8Uo01VnK81ADVxd5ffjjw7d63hpgD37V70P1NiL0EzWO5/F9pknQNKXopw3CnwaSDFl5Sf3aQ2ovrTnhlbMuEcJsT1/G9a88trGvDybPpX6eEf7PurPr3/ibap2NWsMmgGXu6ipczkbxRKjv45Byw+r/xHCu7H+/tn2wZZYBftJQa8TV9PBunBv7fcXEaV028/y421ooRLVcvMrooVFaLhdhA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB5951.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(4326008)(186003)(76116006)(2616005)(83380400001)(6486002)(6512007)(110136005)(66946007)(66476007)(66446008)(54906003)(64756008)(66556008)(36756003)(71200400001)(8936002)(26005)(86362001)(316002)(5660300002)(2906002)(8676002)(478600001)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: HyqM/laBsS6EddblW/Syv/m4ewkpSH32ThxFK8SCAbpqt6YvxRWnViJWQkwMoVw3rOqwctlLVmvQ2lve5qq4Z1YYJa8eRdOhQqq+nuylKwmJqMyT8xNMB4ALK/EqRWZi35uEZAw8grYumi8kdwzELXlh/zZUSltPqu34aaFkv4lYIaj02dpZSz0jckwzd/o6x2NFNnZh4c8F62cO/y+BGIlOapVXgGHvrEAyuNXt6GqdobxO8Ixe6DTKcIvjHILU5q5Pi6wK2PcVNexVHXDbGkIWSbxNyRfMAuv4QVR+f8hDQT2SL/WFQ9a1V0slxrgTUNwFnBuDfRmxuC1VyfLo063412KELHyP9xXChJrrLtL+qma5wwXon2WbAb3/ObAzz+iCEzgoTToQ45TSev2yqj2uhqUmPvsIc4+Hx/9vHFyeFfvtS3wl+k4OJlzOk4RQBCL53Bb2Z43BZ1Iu82bDScgigwP7jImzwRphsPpsoYDiy7fbAwbz0SEEI1J7Wo+f
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <DA6F8F106B3A314BAD5F40266CEB82BF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5951.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 082851a2-ac4c-4759-5a5a-08d81eea9a26
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2020 00:47:02.8941 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MiIy9i6DrvAsUPGEsPIOcRFkC9evfWRjkKR9Ym6U3PGH1hxoMEBkIE8SVynpeO3u6+XMLFN6vNYFGUKS5W2X1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5552
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=446c5dbe3=Dmitry.Fomichev@wdc.com; helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 20:46:09
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "k.jensen@samsung.com" <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IERtaXRyeSBGb21pY2hldiA8ZG1pdHJ5LmZvbWlj
aGV2QHdkYy5jb20+DQoNCk9uIE1vbiwgMjAyMC0wNi0yOSBhdCAyMDoyNiArMDIwMCwgS2xhdXMg
SmVuc2VuIHdyb3RlOg0KPiBGcm9tOiBLbGF1cyBKZW5zZW4gPGsuamVuc2VuQHNhbXN1bmcuY29t
Pg0KPiANCj4gU3VwcG9ydCByZXR1cm5pbmcgQ29tbWFuZCBTZXF1ZW5jZSBFcnJvciBpZiBTZXQg
RmVhdHVyZXMgb24gTnVtYmVyIG9mDQo+IFF1ZXVlcyBpcyBjYWxsZWQgYWZ0ZXIgcXVldWVzIGhh
dmUgYmVlbiBjcmVhdGVkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogS2xhdXMgSmVuc2VuIDxrLmpl
bnNlbkBzYW1zdW5nLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IE1heGltIExldml0c2t5IDxtbGV2aXRz
a0ByZWRoYXQuY29tPg0KPiAtLS0NCj4gIGh3L2Jsb2NrL252bWUuYyB8IDEyICsrKysrKysrKysr
Kw0KPiAgaHcvYmxvY2svbnZtZS5oIHwgIDEgKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAxMyBpbnNl
cnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaHcvYmxvY2svbnZtZS5jIGIvaHcvYmxvY2sv
bnZtZS5jDQo+IGluZGV4IDhhODE2YjU1OGVlYi4uNzk4ZjZmMzBlN2RhIDEwMDY0NA0KPiAtLS0g
YS9ody9ibG9jay9udm1lLmMNCj4gKysrIGIvaHcvYmxvY2svbnZtZS5jDQo+IEBAIC05MTEsNiAr
OTExLDEzIEBAIHN0YXRpYyB1aW50MTZfdCBudm1lX2NyZWF0ZV9jcShOdm1lQ3RybCAqbiwgTnZt
ZUNtZCAqY21kKQ0KPiAgICAgIGNxID0gZ19tYWxsb2MwKHNpemVvZigqY3EpKTsNCj4gICAgICBu
dm1lX2luaXRfY3EoY3EsIG4sIHBycDEsIGNxaWQsIHZlY3RvciwgcXNpemUgKyAxLA0KPiAgICAg
ICAgICBOVk1FX0NRX0ZMQUdTX0lFTihxZmxhZ3MpKTsNCj4gKw0KPiArICAgIC8qDQo+ICsgICAg
ICogSXQgaXMgb25seSByZXF1aXJlZCB0byBzZXQgcXNfY3JlYXRlZCB3aGVuIGNyZWF0aW5nIGEg
Y29tcGxldGlvbiBxdWV1ZTsNCj4gKyAgICAgKiBjcmVhdGluZyBhIHN1Ym1pc3Npb24gcXVldWUg
d2l0aG91dCBhIG1hdGNoaW5nIGNvbXBsZXRpb24gcXVldWUgd2lsbA0KPiArICAgICAqIGZhaWwu
DQo+ICsgICAgICovDQo+ICsgICAgbi0+cXNfY3JlYXRlZCA9IHRydWU7DQo+ICAgICAgcmV0dXJu
IE5WTUVfU1VDQ0VTUzsNCj4gIH0NCj4gIA0KPiBAQCAtMTI5OCw2ICsxMzA1LDEwIEBAIHN0YXRp
YyB1aW50MTZfdCBudm1lX3NldF9mZWF0dXJlKE52bWVDdHJsICpuLCBOdm1lQ21kICpjbWQsIE52
bWVSZXF1ZXN0ICpyZXEpDQo+ICAgICAgICAgIGJsa19zZXRfZW5hYmxlX3dyaXRlX2NhY2hlKG4t
PmNvbmYuYmxrLCBkdzExICYgMSk7DQo+ICAgICAgICAgIGJyZWFrOw0KPiAgICAgIGNhc2UgTlZN
RV9OVU1CRVJfT0ZfUVVFVUVTOg0KPiArICAgICAgICBpZiAobi0+cXNfY3JlYXRlZCkgew0KPiAr
ICAgICAgICAgICAgcmV0dXJuIE5WTUVfQ01EX1NFUV9FUlJPUiB8IE5WTUVfRE5SOw0KPiArICAg
ICAgICB9DQo+ICsNCj4gICAgICAgICAgLyoNCj4gICAgICAgICAgICogTlZNZSB2MS4zLCBTZWN0
aW9uIDUuMjEuMS43OiAweGZmZmYgaXMgbm90IGFuIGFsbG93ZWQgdmFsdWUgZm9yIE5DUVINCj4g
ICAgICAgICAgICogYW5kIE5TUVIuDQo+IEBAIC0xNDMwLDYgKzE0NDEsNyBAQCBzdGF0aWMgdm9p
ZCBudm1lX2NsZWFyX2N0cmwoTnZtZUN0cmwgKm4pDQo+ICANCj4gICAgICBuLT5hZXJfcXVldWVk
ID0gMDsNCj4gICAgICBuLT5vdXRzdGFuZGluZ19hZXJzID0gMDsNCj4gKyAgICBuLT5xc19jcmVh
dGVkID0gZmFsc2U7DQo+ICANCj4gICAgICBibGtfZmx1c2gobi0+Y29uZi5ibGspOw0KPiAgICAg
IG4tPmJhci5jYyA9IDA7DQo+IGRpZmYgLS1naXQgYS9ody9ibG9jay9udm1lLmggYi9ody9ibG9j
ay9udm1lLmgNCj4gaW5kZXggMzRkZGRkYTI5ZDk2Li41NGVjNTRmNDkxYmYgMTAwNjQ0DQo+IC0t
LSBhL2h3L2Jsb2NrL252bWUuaA0KPiArKysgYi9ody9ibG9jay9udm1lLmgNCj4gQEAgLTEyNCw2
ICsxMjQsNyBAQCB0eXBlZGVmIHN0cnVjdCBOdm1lQ3RybCB7DQo+ICAgICAgQmxvY2tDb25mICAg
IGNvbmY7DQo+ICAgICAgTnZtZVBhcmFtcyAgIHBhcmFtczsNCj4gIA0KPiArICAgIGJvb2wgICAg
ICAgIHFzX2NyZWF0ZWQ7DQo+ICAgICAgdWludDMyX3QgICAgcGFnZV9zaXplOw0KPiAgICAgIHVp
bnQxNl90ICAgIHBhZ2VfYml0czsNCj4gICAgICB1aW50MTZfdCAgICBtYXhfcHJwX2VudHM7DQo=

