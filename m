Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B92C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 11:28:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 045712064C
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 11:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="M3yxocjY";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Llyy29Up"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 045712064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPOfY-0004H1-5A
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 07:28:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=54048c3c4=Niklas.Cassel@wdc.com>)
 id 1kPOe8-0002si-AD; Mon, 05 Oct 2020 07:27:14 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:17824)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=54048c3c4=Niklas.Cassel@wdc.com>)
 id 1kPOe4-0006AK-2u; Mon, 05 Oct 2020 07:27:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601897227; x=1633433227;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=s8zgPgJo06rPcs9a+aVHwtOlxaKDhcf0BxUQsx697xk=;
 b=M3yxocjY//N0GXw0c9VndLbkYO/fkRoq1jQvl1CZM6dqYWVntce+ikYe
 IBkj7Ju7XJ+F285Pkkgbv2UWfLx4CajBj19CnVfmLbr7K5epTHDFFqsqu
 jyq2ly5RS7DCKqPWMfv5bvHreNiCw8VSRstpPNo5WygEW0cfYXNoQQnBd
 tUU7i/Jc2M1xIYJlanmJpMtKpYlxuDvQHj4VkRiUPNrM5HwHMOAhRXxEl
 IGybHajgc5OLS1j3ZpwxYinlrrfywI7iaj1OxMx0EVwWDVSxj+L3eBrZ4
 I3+oAR85DtNLhBC4+jLINQlEv1SM7sG/ASwdzjOMdyem8PQgSq9vKHF/B Q==;
IronPort-SDR: 3SkEd+51TGXVlUNY3D6siaaZWU9HLx7BEOSvD2xSEOY3CvE/ssyqcLf2caDI+xBC+nOD3V6KoT
 LMolU0nVzmev49UUZ/Xz7cuCDkI6HInZZMfHlwXdSdEKKCDL9r7bZnqPr7/F4j3Zt1h0kG1L3T
 Kedba4IGivn6Atv/NogL38jjqCFkRv1W9Uevj7qx9b7pAJ9u0flM4R4ZEm7tNNoTgupzD7Ds2Y
 BfDPQ4vFetGHNYdetV7p4BH8/SyQrtgDtoNOVl9H83qpRijXApkMnisCAzmIhMj3Avv6BvCCK9
 vps=
X-IronPort-AV: E=Sophos;i="5.77,338,1596470400"; d="scan'208";a="258858149"
Received: from mail-bn8nam12lp2176.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.176])
 by ob1.hgst.iphmx.com with ESMTP; 05 Oct 2020 19:27:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y08QzKPPu9wEryBO+x6Jejb6I6GkKSIUv6NKYTj+GFs1mmbZ5FwH+rsBHgUCDeUi6+JS3CZ22LbVIxli8CSHl0CKVks7E2822QI9Wzxu1Ja1NDdnQjj+pIL/o5TSj05J03Kz+nBfaiguvwJhkwanFwxOvmOtS3qT5GZV+arnpwyFzItqoXUJZ3kII5MAMxKmyJC+g8EtmNID+yCNGD3zL7XKP0q/XqMqx01JTc2qKo9WZd4j2sLiLkW/b/IB+AJFqPlHfVzx2ZyoGsa5b7ErzYmDb+vR1izbHPKXH1Q7LEhMk8b49JW7ehzajtLHSCNJSl47CjsoU0ti9M9IZZnMyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8zgPgJo06rPcs9a+aVHwtOlxaKDhcf0BxUQsx697xk=;
 b=XR14LnJtMuiF0T8CC5of2l/lXW05OvphVP78F6Sdd9mtPL7olORXApDmz1NfwAi5kIoNv+WbdffhypvRdzbt1C6chq0LaRZ6csOkb+HXmwoRIAqzQzEL3cKBaTDneEsyXO3QpZrQBP4ThNwhaHzJueYcofCETvmYe7JmQTy9jf5ifr3mMLWXJxmnlDPuWBl3B1UZnXDbBNCVjk3QZ6UypjdhJS1nm0LkgCxjpy/Vk9QD314FJNoQhs0D4EFahVORp52/3g77uwIq958GG4OGwDoQz05nAVI/kPVjRVROjkQJMxv0tgOS+kaqfp/VqwMRYzp7VvyMWhfwBD6ZnRex0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8zgPgJo06rPcs9a+aVHwtOlxaKDhcf0BxUQsx697xk=;
 b=Llyy29Upv70rFEjpzrT1MGe5Bm0kkQas89znsFfIn1OjdkaQSVoG3vH6nFKLQQSTWVmHrw2VzBYDB4VmRUZWJIGscQu0mmStexD7gOgwRZGlfql7ZzOQgqA1wDoowDIs/RRnz5WDJKVb7dlX1TZmz5ph1azojYuJtqQMQBpJkvM=
Received: from DM6PR04MB5483.namprd04.prod.outlook.com (2603:10b6:5:126::20)
 by DM6PR04MB4105.namprd04.prod.outlook.com (2603:10b6:5:b6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35; Mon, 5 Oct
 2020 11:26:59 +0000
Received: from DM6PR04MB5483.namprd04.prod.outlook.com
 ([fe80::c8ee:62d1:5ed1:2ee]) by DM6PR04MB5483.namprd04.prod.outlook.com
 ([fe80::c8ee:62d1:5ed1:2ee%6]) with mapi id 15.20.3433.044; Mon, 5 Oct 2020
 11:26:59 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
Subject: Re: [PATCH v5 06/14] hw/block/nvme: Add support for active/inactive
 namespaces
Thread-Topic: [PATCH v5 06/14] hw/block/nvme: Add support for active/inactive
 namespaces
Thread-Index: AQHWlUAXdLu5rxVebUe9Shmhcmtp4qmBNrsAgAbyFoCAAMGOAA==
Date: Mon, 5 Oct 2020 11:26:59 +0000
Message-ID: <20201005112658.GB387917@localhost.localdomain>
References: <20200928023528.15260-1-dmitry.fomichev@wdc.com>
 <20200928023528.15260-7-dmitry.fomichev@wdc.com>
 <20200930135012.GA204568@localhost.localdomain>
 <7a552eaa0aee5542d271589ee0279992bc0760d0.camel@wdc.com>
In-Reply-To: <7a552eaa0aee5542d271589ee0279992bc0760d0.camel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.226.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 31a5e568-dbca-4104-56aa-08d869219303
x-ms-traffictypediagnostic: DM6PR04MB4105:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB4105E7734BAE2D6135F9260DF20C0@DM6PR04MB4105.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BdnfCWR05FJfLhyRpFMP6x2xsiitQiqAeKMYpMZxZ1/QtWT8QRBFPc7sWEzROqGtEYQ9jPQ6vU2omsaoH27QTNl0ZhVe57Eo6IBPNQ6G0oWNMA8siB6d1eC8/FadwyTLCO7IvDdtjAmHYvNttMU46lP6XUDU3UgQ2Q4sM7w/CeAFfpu9qf7nEDuI2NIN9UJfXuPVcPLcvXWe0ApbeO5/3/plXFbudctaxAF0uKJG4Ny562urENLhbvZua98D6M5AQyltSNlroGkFS8dtaGx3BBjfJm3kZyRLuoHzr/burUsfiPa58rMHZY3PLeKd9O5J1Uxnq6UAB4A86eGf5Dq6ig==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB5483.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(39860400002)(346002)(366004)(6486002)(76116006)(91956017)(6506007)(54906003)(33656002)(83380400001)(5660300002)(186003)(478600001)(71200400001)(316002)(1076003)(9686003)(4326008)(6512007)(2906002)(86362001)(8936002)(6636002)(6862004)(8676002)(64756008)(66446008)(66946007)(66476007)(66556008)(26005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: p7fFXNlhR3hJ8DqjQdyjawLVgHpQbVTB9U5WWidd5yW3TSrrNvkbcIQK8TLdQPTHM/nPre2QOGG4OZwKpMQRa1WzfYAQD5PnkbGCYOhM4JjjQjK0q/7zxfjWiL93eJwU/YGDgtkoENs9OhHsxfOK87DGz5KxzrFITsjwyxc5S3VEkcEWdNMWxfGFnWidmyjhbvH4TuVDmaVPSIfVfPlPXrVgYfl01UdUxNv0C4NBlVbW+cs5+jkjBuCyGjVAeTI/4keZ/F50bbscUwgCqHd0CYnLIq5zR1M6T7vfQ6KMnykxJu1yzoWm5+Bvm1ijPrC0N++9QXWRILspnD/6W3Mf8lfkJ0n9HLtRmdEt+K8nv1q9KqYioe0heIMc3C09Loa+o1HQGHglKAqbJBjXWXo1CCmdz71zC4+jJDhuSrsaVUYVZLzimKbSv1G5hgmsIVDaT7kl4vXkQQb7YpWA28WorvPHdKd0C/SggCkQp4FbvL+9fbKYhnqwS6ojb+t3P5vmbRsi7x0OV4xovED6Wu4yY5Sj2PsXbD1fK5MxlOD+SMz6tRTY8TzsiQ75oDJwn0iXt9TsXVIc3WrBwHTfpqmL9Tf9k3cSAcIksKRCd/IfUCI/EoWXeCDSh2MSqUMQt5sYolmvYsZqiJSbEgP6JlPvig==
Content-Type: text/plain; charset="utf-8"
Content-ID: <831937FB1458DD4C80E8244B8A63420F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB5483.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31a5e568-dbca-4104-56aa-08d869219303
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2020 11:26:59.1913 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tnUYkWay8EIqHC2sQKKgnAgVEPN3ZD7N6uy1k3Quo6O26zOn66EWZvQpguXOlfzsbtSG2NfXQuLJRtW5VsMVOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4105
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=54048c3c4=Niklas.Cassel@wdc.com; helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 07:27:02
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "k.jensen@samsung.com" <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "philmd@redhat.com" <philmd@redhat.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gU3VuLCBPY3QgMDQsIDIwMjAgYXQgMTE6NTQ6MTNQTSArMDAwMCwgRG1pdHJ5IEZvbWljaGV2
IHdyb3RlOg0KPiBPbiBXZWQsIDIwMjAtMDktMzAgYXQgMTM6NTAgKzAwMDAsIE5pa2xhcyBDYXNz
ZWwgd3JvdGU6DQo+ID4gT24gTW9uLCBTZXAgMjgsIDIwMjAgYXQgMTE6MzU6MjBBTSArMDkwMCwg
RG1pdHJ5IEZvbWljaGV2IHdyb3RlOg0KPiA+ID4gRnJvbTogTmlrbGFzIENhc3NlbCA8bmlrbGFz
LmNhc3NlbEB3ZGMuY29tPg0KPiA+ID4gDQo+ID4gPiBJbiBOVk1lLCBhIG5hbWVzcGFjZSBpcyBh
Y3RpdmUgaWYgaXQgZXhpc3RzIGFuZCBpcyBhdHRhY2hlZCB0byB0aGUNCj4gPiA+IGNvbnRyb2xs
ZXIuDQo+ID4gPiANCj4gPiA+IENBUC5DU1MgKHRvZ2V0aGVyIHdpdGggdGhlIEkvTyBDb21tYW5k
IFNldCBkYXRhIHN0cnVjdHVyZSkgZGVmaW5lcyB3aGF0DQo+ID4gPiBjb21tYW5kIHNldHMgYXJl
IHN1cHBvcnRlZCBieSB0aGUgY29udHJvbGxlci4NCj4gPiA+IA0KPiA+ID4gQ0MuQ1NTICh0b2dl
dGhlciB3aXRoIFNldCBQcm9maWxlKSBjYW4gYmUgc2V0IHRvIGVuYWJsZSBhIHN1YnNldCBvZiB0
aGUNCj4gPiA+IGF2YWlsYWJsZSBjb21tYW5kIHNldHMuIFRoZSBuYW1lc3BhY2VzIGJlbG9uZ2lu
ZyB0byBhIGRpc2FibGVkIGNvbW1hbmQgc2V0DQo+ID4gPiB3aWxsIG5vdCBiZSBhYmxlIHRvIGF0
dGFjaCB0byB0aGUgY29udHJvbGxlciwgYW5kIHdpbGwgdGh1cyBiZSBpbmFjdGl2ZS4NCj4gPiA+
IA0KPiA+ID4gRS5nLiwgaWYgdGhlIHVzZXIgc2V0cyBDQy5DU1MgdG8gQWRtaW4gT25seSwgTlZN
IG5hbWVzcGFjZXMgc2hvdWxkIGJlDQo+ID4gPiBtYXJrZWQgYXMgaW5hY3RpdmUuDQo+ID4gPiAN
Cj4gPiA+IFRoZSBpZGVudGlmeSBuYW1lc3BhY2UsIHRoZSBpZGVudGlmeSBuYW1lc3BhY2UgQ1NJ
IHNwZWNpZmljLCBhbmQgdGhlIG5hbWVzcGFjZQ0KPiA+ID4gbGlzdCBjb21tYW5kcyBoYXZlIHR3
byBkaWZmZXJlbnQgdmVyc2lvbnMsIG9uZSB0aGF0IG9ubHkgc2hvd3MgYWN0aXZlDQo+ID4gPiBu
YW1lc3BhY2VzLCBhbmQgdGhlIG90aGVyIHZlcnNpb24gdGhhdCBzaG93cyBleGlzdGluZyBuYW1l
c3BhY2VzLCByZWdhcmRsZXNzDQo+ID4gPiBvZiB3aGV0aGVyIHRoZSBuYW1lc3BhY2UgaXMgYXR0
YWNoZWQgb3Igbm90Lg0KPiA+ID4gDQo+ID4gPiBBZGQgYW4gYXR0YWNoZWQgbWVtYmVyIHRvIHN0
cnVjdCBOdm1lTmFtZXNwYWNlLCBhbmQgaW1wbGVtZW50IHRoZSBtaXNzaW5nIENOUw0KPiA+ID4g
Y29tbWFuZHMuDQo+ID4gPiANCj4gPiA+IFRoZSBhZGRlZCBmdW5jdGlvbmFsaXR5IHdpbGwgYWxz
byBzaW1wbGlmeSB0aGUgaW1wbGVtZW50YXRpb24gb2YgbmFtZXNwYWNlDQo+ID4gPiBtYW5hZ2Vt
ZW50IGluIHRoZSBmdXR1cmUsIHNpbmNlIG5hbWVzcGFjZSBtYW5hZ2VtZW50IGNhbiBhbHNvIGF0
dGFjaCBhbmQNCj4gPiA+IGRldGFjaCBuYW1lc3BhY2VzLg0KPiA+IA0KPiA+IEZvbGxvd2luZyBt
eSBwcmV2aW91cyBkaXNjdXNzaW9uIHdpdGggS2xhdXMsDQo+ID4gSSB0aGluayB3ZSBuZWVkIHRv
IHJld3JpdGUgdGhpcyBjb21taXQgbWVzc2FnZSBjb21wbGV0ZWx5Og0KPiA+IA0KPiA+IFN1Ympl
Y3Q6IGh3L2Jsb2NrL252bWU6IEFkZCBzdXBwb3J0IGZvciBhbGxvY2F0ZWQgQ05TIGNvbW1hbmQg
dmFyaWFudHMNCj4gPiANCj4gPiBNYW55IENOUyBjb21tYW5kcyBoYXZlICJhbGxvY2F0ZWQiIGNv
bW1hbmQgdmFyaWFudHMuDQo+ID4gVGhlc2UgaW5jbHVkZXMgYSBuYW1lc3BhY2UgYXMgbG9uZyBh
cyBpdCBpcyBhbGxvY2F0ZWQNCj4gPiAoaS5lLiBhIG5hbWVzcGFjZSBpcyBpbmNsdWRlZCByZWdh
cmRsZXNzIGlmIGl0IGlzIGFjdGl2ZSAoYXR0YWNoZWQpDQo+ID4gb3Igbm90LikNCj4gPiANCj4g
PiBXaGlsZSB0aGVzZSBjb21tYW5kcyBhcmUgb3B0aW9uYWwgKHRoZXkgYXJlIG1hbmRhdG9yeSBm
b3IgY29udHJvbGxlcnMNCj4gPiBzdXBwb3J0aW5nIHRoZSBuYW1lc3BhY2UgYXR0YWNobWVudCBj
b21tYW5kKSwgb3VyIFFFTVUgaW1wbGVtZW50YXRpb24NCj4gPiBpcyBtb3JlIGNvbXBsZXRlIGJ5
IGFjdHVhbGx5IHByb3ZpZGluZyBzdXBwb3J0IGZvciB0aGVzZSBDTlMgdmFsdWVzLg0KPiA+IA0K
PiA+IEhvd2V2ZXIsIHNpbmNlIG91ciBRRU1VIG1vZGVsIGN1cnJlbnRseSBkb2VzIG5vdCBzdXBw
b3J0IHRoZSBuYW1lc3BhY2UNCj4gPiBhdHRhY2htZW50IGNvbW1hbmQsIHRoZXNlIG5ldyBhbGxv
Y2F0ZWQgQ05TIGNvbW1hbmRzIHdpbGwgcmV0dXJuIHRoZSBzYW1lDQo+ID4gcmVzdWx0IGFzIHRo
ZSBhY3RpdmUgQ05TIGNvbW1hbmQgdmFyaWFudHMuDQo+ID4gDQo+ID4gSW4gTlZNZSwgYSBuYW1l
c3BhY2UgaXMgYWN0aXZlIGlmIGl0IGV4aXN0cyBhbmQgaXMgYXR0YWNoZWQgdG8gdGhlDQo+ID4g
Y29udHJvbGxlci4NCj4gPiANCj4gPiBDQVAuQ1NTICh0b2dldGhlciB3aXRoIHRoZSBJL08gQ29t
bWFuZCBTZXQgZGF0YSBzdHJ1Y3R1cmUpIGRlZmluZXMgd2hhdA0KPiA+IGNvbW1hbmQgc2V0cyBh
cmUgc3VwcG9ydGVkIGJ5IHRoZSBjb250cm9sbGVyLg0KPiA+IA0KPiA+IENDLkNTUyAodG9nZXRo
ZXIgd2l0aCBTZXQgUHJvZmlsZSkgY2FuIGJlIHNldCB0byBlbmFibGUgYSBzdWJzZXQgb2YgdGhl
DQo+ID4gYXZhaWxhYmxlIGNvbW1hbmQgc2V0cy4NCj4gPiANCj4gPiBFdmVuIGlmIGEgdXNlciBj
b25maWd1cmVzIENDLkNTUyB0byBlLmcuIEFkbWluIG9ubHksIE5WTSBuYW1lc3BhY2VzDQo+ID4g
d2lsbCBzdGlsbCBiZSBhdHRhY2hlZCAoYW5kIHRodXMgbWFya2VkIGFzIGFjdGl2ZSkuDQo+ID4g
U2ltaWxhcmx5LCBpZiBhIHVzZXIgY29uZmlndXJlcyBDQy5DU1MgdG8gZS5nLiBOVk0sIFpOUyBu
YW1lc3BhY2VzDQo+ID4gd2lsbCBzdGlsbCBiZSBhdHRhY2hlZCAoYW5kIHRodXMgbWFya2VkIGFz
IGFjdGl2ZSkuDQo+ID4gDQo+ID4gSG93ZXZlciwgYW55IG9wZXJhdGlvbiBmcm9tIGEgZGlzYWJs
ZWQgY29tbWFuZCBzZXQgd2lsbCByZXN1bHQgaW4gYQ0KPiA+IEludmFsaWQgQ29tbWFuZCBPcGNv
ZGUuDQo+ID4gDQo+ID4gQWRkIGFuIGF0dGFjaGVkIHN0cnVjdCBtZW1iZXIgZm9yIHN0cnVjdCBO
dm1lTmFtZXNwYWNlLA0KPiA+IHNvIHRoYXQgd2UgbGF5IHRoZSBmb3VuZGF0aW9uIGZvciBuYW1l
c3BhY2UgYXR0YWNobWVudA0KPiA+IHN1cHBvcnQuIEFsc28gaW1wbGVtZW50IGxvZ2ljIGluIHRo
ZSBuZXcgQ05TIHZhbHVlcyB0bw0KPiA+IGluY2x1ZGUvZXhjbHVkZSBuYW1lc3BhY2VzIGJhc2Vk
IG9uIHRoaXMgbmV3IHN0cnVjdCBtZW1iZXIuDQo+ID4gVGhlIG9ubHkgdGhpbmcgbWlzc2luZyBo
b29raW5nIHVwIHRoZSBhY3R1YWwgTmFtZXNwYWNlIEF0dGFjaG1lbnQNCj4gPiBjb21tYW5kIG9w
Y29kZSwgd2hpY2ggYWxsb3dzIGEgdXNlciB0byB0b2dnbGUgdGhlIGF0dGFjaGVkDQo+ID4gdmFy
aWFibGUgcGVyIG5hbWVzcGFjZS4gVGhlIHJlYXNvbiBmb3Igbm90IGhvb2tpbmcgdXAgdGhpcw0K
PiA+IGNvbW1hbmQgY29tcGxldGVseSBpcyBiZWNhdXNlIHRoZSBOVk1lIHNwZWNpZmljYXRpb24N
Cj4gPiByZXF1aXJlcyB0aGF0IHRoZSBuYW1lc3BhY2UgbWFuYWdtZW50IGNvbW1hbmQgaXMgc3Vw
cG9ydGVkDQo+ID4gaWYgdGhlIG5hbWVzcGFjZW1lbnQgYXR0YWNobWVudCBjb21tYW5kIGlzIHN1
cHBvcnRlZC4NCj4gPiANCj4gDQoNCihzbmlwKQ0KDQo+ID4gPiBAQCAtMjI3Niw2ICsyMzA0LDIy
IEBAIHN0YXRpYyBpbnQgbnZtZV9zdGFydF9jdHJsKE52bWVDdHJsICpuKQ0KPiA+ID4gICAgICBu
dm1lX2luaXRfc3EoJm4tPmFkbWluX3NxLCBuLCBuLT5iYXIuYXNxLCAwLCAwLA0KPiA+ID4gICAg
ICAgICAgICAgICAgICAgTlZNRV9BUUFfQVNRUyhuLT5iYXIuYXFhKSArIDEpOw0KPiA+ID4gIA0K
PiA+ID4gKyAgICBmb3IgKGkgPSAxOyBpIDw9IG4tPm51bV9uYW1lc3BhY2VzOyBpKyspIHsNCj4g
PiA+ICsgICAgICAgIG5zID0gbnZtZV9ucyhuLCBpKTsNCj4gPiA+ICsgICAgICAgIGlmICghbnMp
IHsNCj4gPiA+ICsgICAgICAgICAgICBjb250aW51ZTsNCj4gPiA+ICsgICAgICAgIH0NCj4gPiA+
ICsgICAgICAgIG5zLT5wYXJhbXMuYXR0YWNoZWQgPSBmYWxzZTsNCj4gPiA+ICsgICAgICAgIHN3
aXRjaCAobnMtPnBhcmFtcy5jc2kpIHsNCj4gPiA+ICsgICAgICAgIGNhc2UgTlZNRV9DU0lfTlZN
Og0KPiA+ID4gKyAgICAgICAgICAgIGlmIChOVk1FX0NDX0NTUyhuLT5iYXIuY2MpID09IENTU19O
Vk1fT05MWSB8fA0KPiA+ID4gKyAgICAgICAgICAgICAgICBOVk1FX0NDX0NTUyhuLT5iYXIuY2Mp
ID09IENTU19DU0kpIHsNCj4gPiA+ICsgICAgICAgICAgICAgICAgbnMtPnBhcmFtcy5hdHRhY2hl
ZCA9IHRydWU7DQo+ID4gPiArICAgICAgICAgICAgfQ0KPiA+ID4gKyAgICAgICAgICAgIGJyZWFr
Ow0KPiA+ID4gKyAgICAgICAgfQ0KPiA+ID4gKyAgICB9DQo+ID4gPiArDQo+ID4gDQo+ID4gQ29u
c2lkZXJpbmcgdGhhdCB0aGUgY29udHJvbGxlciBkb2Vzbid0IGF0dGFjaC9kZXRhY2gNCj4gPiBu
YW1lc3BhY2VzIGJlbG9uZ2luZyB0byBjb21tYW5kIHNldHMgdGhhdCBpdCBkb2Vzbid0DQo+ID4g
c3VwcG9ydCwgSSB0aGluayBhIG5pY2VyIHdheSBpcyB0byByZW1vdmUgdGhpcyBmb3ItbG9vcCwN
Cj4gPiBhbmQgaW5zdGVhZCwgaW4gbnZtZV9uc19zZXR1cCgpIG9yIG52bWVfbnNfaW5pdCgpLA0K
PiA+IGFsd2F5cyBzZXQgYXR0YWNoZWQgPSB0cnVlLiAoU2luY2Ugd2UgY3VycmVudGx5IGRvbid0
DQo+ID4gc3VwcG9ydCBuYW1lc3BhY2UgYXR0YWNobWVudCBjb21tYW5kKS4NCj4gPiANCj4gPiBU
aGUgcGVyc29uIHRoYXQgaW1wbGVtZW50cyB0aGUgbGFzdCBwaWVjZSBvZiBuYW1lc3BhY2UNCj4g
PiBtYW5hZ2VtZW50IGFuZCBuYW1lc3BhY2UgYXR0YWNobWVudCB3aWxsIGhhdmUgdG8gZGVhbA0K
PiA+IHdpdGggcmVhZGluZyAiYXR0YWNoZWQiIGZyb20gc29tZSBraW5kIG9mIHBlcnNpc3RlbnQg
c3RhdGUNCj4gDQo+IA0KPiBJIGRpZCBzb21lIHNwZWMgcmVhZGluZyBvbiB0aGlzIHRvcGljIGFu
ZCBpdCBzZWVtcyB0aGF0DQo+IHRoaXMgbG9naWMgaXMgbmVjZXNzYXJ5IHByZWNpc2VseSBiZWNh
dXNlIHRoZXJlIGlzIG5vDQo+IGF0dGFjaC9kZXRhY2ggY29tbWFuZCBhdmFpbGFibGUuIFN1Y2gg
YSBjb21tYW5kIHdvdWxkDQo+IHByZXZlbnQgYXR0YWNobWVudCBvZiBhIHpvbmVkIG5hbWVzcGFj
ZSBpZiBDQy5DU1MgaXMNCj4gTlZNX09OTFksIHJpZ2h0PyBCdXQgc2luY2Ugd2UgaGF2ZSBhIHN0
YXRpYyBjb25maWcsIHdlDQo+IG5lZWQgdG8gZG8gdGhpcyBJTU8uDQoNCkFzIGZhciBhcyBJIHVu
ZGVyc3RhbmQgdGhlIHNwZWMsIGEgTlZNIENvbW1hbmQgU2V0IG5hbWVzcGFjZSB3aWxsIGJlIGF0
dGFjaGVkDQp0byB0aGUgY29udHJvbGxlciAodGh1cyBhY3RpdmUpLCByZWdhcmRsZXNzIGlmIHlv
dSBzdGFydCB0aGUgY29udHJvbGxlciB3aXRoDQpDQy5DU1MgPSBBZG1pbiBvbmx5LCBvciBDQy5D
U1MgPSBOVk0uDQoNCihBbmQgYXMgZmFyIGFzIEkgdW5kZXJzdGFuZCwgdGhpcyBkb2Vzbid0IGRl
cGVuZCBvbiBpZiB0aGUgY29udHJvbGxlciBzdXBwb3J0cw0KdGhlIG5hbWVzcGFjZSBhdHRhY2ht
ZW50IGNvbW1hbmQgb3Igbm90LikNCg0KU2VlIHRoZSByZWdpc3RlciBkZXNjcmlwdGlvbiBmb3Ig
Q0MuQ1NTOg0KIklmIGJpdCA0NCBpcyBzZXQgdG8g4oCYMeKAmSBpbiB0aGUgQ29tbWFuZCBTZXRz
IFN1cHBvcnRlZCAoQ1NTKSBmaWVsZCwgdGhlbiB0aGUgdmFsdWUNCjExMWIgaW5kaWNhdGVzIHRo
YXQgb25seSB0aGUgQWRtaW4gQ29tbWFuZCBTZXQgaXMgc3VwcG9ydGVkIGFuZCB0aGF0IG5vIEkv
Tw0KQ29tbWFuZCBTZXQgb3IgSS9PIENvbW1hbmQgU2V0IFNwZWNpZmljIEFkbWluIGNvbW1hbmRz
IGFyZSBzdXBwb3J0ZWQuDQpXaGVuIG9ubHkgdGhlIEFkbWluIENvbW1hbmQgU2V0IGlzIHN1cHBv
cnRlZCwgYW55IGNvbW1hbmQgc3VibWl0dGVkIG9uDQphbiBJL08gU3VibWlzc2lvbiBRdWV1ZSBh
bmQgYW55IEkvTyBDb21tYW5kIFNldCBTcGVjaWZpYyBBZG1pbiBjb21tYW5kDQpzdWJtaXR0ZWQg
b24gdGhlIEFkbWluIFN1Ym1pc3Npb24gUXVldWUgaXMgY29tcGxldGVkIHdpdGggc3RhdHVzIElu
dmFsaWQNCkNvbW1hbmQgT3Bjb2RlLiINCg0KU28gSSB0aGluayB0aGF0IG5vIG1hdHRlciB3aGF0
IENDLkNTUyBzZXR0aW5nIHlvdSBoYXZlLCBubyBuYW1lc3BhY2UNCndpbGwgZXZlciBiZSBkZXRh
Y2hlZCBieSB0aGUgY29udHJvbGxlci4gSXQgd2lsbCBzdGlsbCBiZSBhdHRhY2hlZCwNCmJ1dCB5
b3Ugd2lsbCBnZXQgSW52YWxpZCBDb21tYW5kIE9wY29kZSBpZiBzZW5kaW5nIGFueSBjb21tYW5k
Lg0KDQpJIGFzc3VtZSB0aGF0IENDLkNTUyBpcyB3YXkgb2xkZXIgdGhhbiBuYW1lc3BhY2UgbWFu
YWdlbWVudCwgc28gdGhhdCBpcw0KcHJvYmFibHkgd2h5IENDLkNTUyBzaW1wbHkgY2F1c2VzICJJ
bnZhbGlkIENvbW1hbmQgT3Bjb2RlIiByYXRoZXIgdGhhbg0KZGV0YWNoaW5nIG5hbWVzcGFjZXMu
DQoNCj4gDQo+IEFsc28sIDYuMS41IG9mIHRoZSBzcGVjIHNheXMgdGhhdCBhbnkgb3BlcmF0aW9u
IHRoYXQgdXNlcw0KPiBhbiBpbmFjdGl2ZSBOU0lEIHNoYWxsIGZhaWwgd2l0aCBJbnZhbGlkIEZp
ZWxkLiBJIGFtDQo+IGFkZGluZyBhIGZldyBiaXRzIHRvIGZhaWwgYWxsIGkvbyBjb21tYW5kcyBh
bmQgc2V0L2dldA0KPiBmZWF0dXJlcyBhdHRlbXB0ZWQgb24gaW5hY3RpdmUgbmFtZXNwYWNlcy4N
Cg0KSW5hY3RpdmUgTlNJRCA9PSBhIE5TSUQgdGhhdCBpcyBub3QgYXR0YWNoZWQuDQpBcyBmYXIg
YXMgSSB1bmRlcnN0YW5kLCB0aGUgY29udHJvbGxlciBpdHNlbGYgd2lsbCBuZXZlciBkZXRhY2gN
CmEgbmFtZXNwYWNlLiBBbmQgc2luY2UgdGhlIFFFTVUgbW9kZWwgcmlnaHQgbm93IGRvZXMgbm90
IHN1cHBvcnQNCm5hbWVzcGFjZSBtYW5hZ2VtZW50LCBuZWl0aGVyIHdpbGwgdGhlIHVzZXIuDQpT
byBJIGRvbid0IHNlZSB0aGF0IHdlIHdpbGwgaGF2ZSBhbnkgaW5hY3RpdmUgbmFtZXNwYWNlLg0K
DQpUaGVyZWZvcmUsIEkgc3VnZ2VzdGVkIHRoYXQgd2UgcmVtb3ZlIHRoaXMgZm9yLWxvb3AuDQoo
T3IgZHJvcCB0aGlzIHBhdGNoIGFsbCB0b2dldGhlciwgYnV0IEkgZG8gdGhpbmsgdGhhdA0KaXQg
cHJvdmlkZXMgdmFsdWUgdG8gaGF2ZSB0aGUgYWRkaXRpb25hbCBDTlMgY29tbWFuZHMNCmltcGxl
bWVudGVkLCBldmVuIGlmIHRoZXkgd2lsbCByZXR1cm4gdGhlIHNhbWUgcmVzdWx0DQphcyB0aGUg
ZXhpdGluZyBhY3RpdmUgQ05TIGNvbW1hbmRzLikNCg0KDQpLaW5kIHJlZ2FyZHMsDQpOaWtsYXM=

