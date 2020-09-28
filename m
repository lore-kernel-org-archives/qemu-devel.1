Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065BBC4346E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 02:34:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4488F21582
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 02:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AsItMM6w";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="H4cj8M0X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4488F21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMiza-0005qD-5j
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 22:34:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5334b480d=Dmitry.Fomichev@wdc.com>)
 id 1kMiya-0005KS-UZ; Sun, 27 Sep 2020 22:33:17 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:28758)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5334b480d=Dmitry.Fomichev@wdc.com>)
 id 1kMiyX-00035e-62; Sun, 27 Sep 2020 22:33:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601260676; x=1632796676;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Qwgb1N9Fq1IKuxjsTJ9u6k8NvaP6xp8AHNgrPhcn9oE=;
 b=AsItMM6w5Yen6oNfy5cyc8RsQ87Ny7OPLuGKkpXTa9f8cLKiDBCqNASH
 9gxB90EQrfEqixL4Bt/7LdRoUQ8RErgVQgHL1gljBQawG1HAZNNHtJSB+
 TqABqhgmhBMA5fjNmV8Z4UiC7FFaQMvtL6QFqw7nL/VapEzkBchDjsn/A
 ATvVqPatA8TcnLxADO9m5OYNg+OKbECSAejqi7+lrTsOPsKOcaVhlvjgC
 1ScItBjMfucqDAMOzNhe/uzZ5uB8Q+v54DS72MJtEY9nDNLuTTYAXKIBl
 KdlseYPw/9mc1rZ+p6aRWteG5KP5R+zLl6K3ey0hy2djkalSLJAEXayn1 Q==;
IronPort-SDR: e8IZRnentePKvbY8Bs/rE90AMg061cmJ3G6Bso4OY7SCFZEx1n+Aq0kVe+YFbnn8ZmzbzbvHZU
 ZxswR5oT5vmNx6Xq8Va4mp0mR+J30Vl29I0hp0Etu5EXZ+BsSmM2DPQ8SO5rWIbv/i4H2M2PGe
 rf2TyxMgAlMnGummVXOMgaljHVKiBqweJCHUSnBKfD/nUcSbm08HK3w1WVvSTn5efWCgG64tvQ
 HaAJPr1prD0S0A7JxjW/YuexXteIM7VKk9UkTndU15BmovnLcVx2G508ee5JEz/95JL0zo8gvC
 FTY=
X-IronPort-AV: E=Sophos;i="5.77,312,1596470400"; d="scan'208";a="251795743"
Received: from mail-bn8nam12lp2177.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.177])
 by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2020 10:37:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=edmHi9QadhqUDlHIb/xsJcXNfDN4vxRp+uW47s/bxkh1E0F9fcx2KFR5LJUieQjD3ZhNROyLYZ1dnX4+TNC9hn96apaqiSQId5gX/avmGES60hy4XOmsFNNI86ZmsHXVTQxziwWqttcemWkKfkCxuQUyiNZdYqmUHet8ht5V48IyyR8Sa/QMDDaUsEki+n8i7UfCwGg7dc156u7YAJcHL8SsQXU4b0/qorG1+hmej1mDI73cjznfIN9rzOU+iWsCcDoRmw1PgeqeuEgUsTlBk3vYzadm360/4kN4wWWUMJ8zUzFkjWQvHAlI5/cB9ZTD9Wm/AeJ6NugUArzMwbEMpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qwgb1N9Fq1IKuxjsTJ9u6k8NvaP6xp8AHNgrPhcn9oE=;
 b=W71cvfCMVTk9+zKLmCmV+LDTUqenuMN85NyQcfkMYa9RYb2w/DLtrU4Lsn+/Mv4N7C4uFxpscrm3UguJPrt6ncndxZvnHp/FODfUFdmt+66GER9ttsrr7K7yCAyo6jofnkYSChMTu2YD8v3wjV0TSyTTi11lURABa599+ANxkosb4rqfCNjTJIEAN77kfRkNlwzjibvRVi2qOsOod6asKt8YIIWPh5vSXgi2njMa8CRbamUvyTOCYigu2rvjp4a+JQYjdte2czfLkj+v7JwJ/tbNd7LVqWE6KmAaxamY1IEroe6oGWIMKJZN5pPyfNL6KhxkJHUdwSUVgnJTBbLZJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qwgb1N9Fq1IKuxjsTJ9u6k8NvaP6xp8AHNgrPhcn9oE=;
 b=H4cj8M0X6pB8oAnaHLzZ8TGh0k3tMEQ751jxn6DLre/8UUdeYKC1b6ifmNNJ6S/bB5HMWwUV8IPjmXcow8c7V+WfzMbhwUn5WmDn/9DyMzWOg3GsXRBKxcBjtzB2yDgEOwXrW/4HtpYlqLAlIjfshuxmD4Z4W1PNx2RWYYzv2VY=
Received: from MN2PR04MB5951.namprd04.prod.outlook.com (2603:10b6:208:3f::13)
 by MN2PR04MB6159.namprd04.prod.outlook.com (2603:10b6:208:e6::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.24; Mon, 28 Sep
 2020 02:33:06 +0000
Received: from MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44d8:522e:db29:bb94]) by MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44d8:522e:db29:bb94%6]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 02:33:06 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>, Damien
 Le Moal <Damien.LeMoal@wdc.com>
Subject: RE: [PATCH v4 00/14] hw/block/nvme: Support Namespace Types and Zoned
 Namespace Command Set
Thread-Topic: [PATCH v4 00/14] hw/block/nvme: Support Namespace Types and
 Zoned Namespace Command Set
Thread-Index: AQHWkdZJY2r+3+EgB0+n1uDhiCCmB6l4SdmAgAEvKJA=
Date: Mon, 28 Sep 2020 02:33:06 +0000
Message-ID: <MN2PR04MB59515B1EA1238861DFF3236AE1350@MN2PR04MB5951.namprd04.prod.outlook.com>
References: <20200923182021.3724-1-dmitry.fomichev@wdc.com>
 <20200924210751.GD1738917@apples.localdomain>
In-Reply-To: <20200924210751.GD1738917@apples.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: irrelevant.dk; dkim=none (message not signed)
 header.d=none;irrelevant.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 87b50ec8-c85f-4801-ea49-08d86356d4f9
x-ms-traffictypediagnostic: MN2PR04MB6159:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB6159AC39E7BE5D24AC3EE67FE1350@MN2PR04MB6159.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e7EJgmBgnB3XZl6WvKWvrcwBofFZEY51P3gRYK8mV0hfhLTjBIF1QIUIy6MsmONQYNVyxzdIEA7XnBtlbB6fm8LO/vixWfGv1qijqBx+LujBeJoTKoMBOslSQxjzMrBvviEOg7ybwEoH1tmdr1yFlBINCH1dwK5Kgnavsg2z4Jx9HvGthJ+iyxMC4AvXGr9u+/V3We9392ONMG23F5tnEWUv5yv7X55/mak4cHxqe89s0UvJ7B1OE7r8XZG5dCaFmjqEG6TNB6bseUWwUEEW1E1cJxXfgEWN3tONoVyxly+AfTQoklu2HdxehfsvcftBYqG0bGEHUL5FPsDbQyx70rKCgrGWMBUwU75JUMIsCEm6yD8XyDrnTi7KHUTgz4LrImaxdBImDWalZDD2gdJo79cNYv4y+QQgie57vIN/EzQ3KnNfbrmXbHdKse+KJ5KbtLGaXUOfP8VOlyqiS+a3lg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB5951.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(66476007)(66556008)(64756008)(66446008)(76116006)(71200400001)(52536014)(54906003)(6636002)(110136005)(316002)(9686003)(186003)(83380400001)(86362001)(5660300002)(33656002)(966005)(66946007)(8936002)(478600001)(55016002)(2906002)(8676002)(7696005)(6506007)(53546011)(26005)(4326008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: ZmtdLTJtPgXw0cvr1O+l6janW/4yUSAmIlKsuT6r/N2pMYsfyqo+nGHHgiB9IEtyc5CA7Q9VK75WR3ugaXq1AC9Db4SQJtQtrD5IgchhNUW5iDdnJNPmOkha8GpcireaO+MZ3hpyEB4IQwD53vSpTBeE5EdXjiYFAU5O30lxCc0jcWOLs8sd9vpVlOICCTByCQoQKpCf0KGgfiI4+swITiJLCeQYmEEUd8xh29hqJlkfFHgWni57c5AaPZj+KMQef8WTZo9GHdR6zLO6VaHcMomwjGxcgKzAdaCgWXwJIJKE4AIYD0Uub9F64uFiiZAywLJqBrsrK4w0wAOSnmN5LLf8n+uxDkRA0fY+lobsEFO4jXTd5S0KbRR7aw1HJCbU3W6PHDa+ynYL7+fLpAKXeETcGq2OUIsAxPieQyiWZjyn5YHlBgmFM/hqp+5e5kMxRWN8mz2FDgo8oA56kxEHyKm6tHgVLUe+iuJT+6570yMZc82MI2n+5BE2wy9PLuwXgTXkDgOklU7ew0YThV8TdoxEMi3RJz5gWvFUjwF5UNr5k1W+MieyooCOBkfHBjbsi4m8l2VAml8KBSH2R4y2KXoAcat2ARgEGigft9Mf+XveQSmmiiVrki08aCRJ0M2sL2m9QS3sULACrzLUX2Mm/A==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5951.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b50ec8-c85f-4801-ea49-08d86356d4f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 02:33:06.2062 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dBLaXJ0XsJGHJUk4464jz/emXCEkuzBquK9EKWLEqZ9Dj1gMdxHBJIOPu8KNyHsZLNxLwOoecyZuDilN3gyJdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6159
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=5334b480d=Dmitry.Fomichev@wdc.com; helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/27 22:33:09
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Niklas Cassel <Niklas.Cassel@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLbGF1cyBKZW5zZW4gPGl0c0Bp
cnJlbGV2YW50LmRrPg0KPiBTZW50OiBUaHVyc2RheSwgU2VwdGVtYmVyIDI0LCAyMDIwIDU6MDgg
UE0NCj4gVG86IERtaXRyeSBGb21pY2hldiA8RG1pdHJ5LkZvbWljaGV2QHdkYy5jb20+DQo+IENj
OiBLZWl0aCBCdXNjaCA8a2J1c2NoQGtlcm5lbC5vcmc+OyBLbGF1cyBKZW5zZW4NCj4gPGsuamVu
c2VuQHNhbXN1bmcuY29tPjsgS2V2aW4gV29sZiA8a3dvbGZAcmVkaGF0LmNvbT47IFBoaWxpcHBl
DQo+IE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAcmVkaGF0LmNvbT47IE1heGltIExldml0c2t5DQo+
IDxtbGV2aXRza0ByZWRoYXQuY29tPjsgRmFtIFpoZW5nIDxmYW1AZXVwaG9uLm5ldD47IE5pa2xh
cyBDYXNzZWwNCj4gPE5pa2xhcy5DYXNzZWxAd2RjLmNvbT47IERhbWllbiBMZSBNb2FsIDxEYW1p
ZW4uTGVNb2FsQHdkYy5jb20+Ow0KPiBxZW11LWJsb2NrQG5vbmdudS5vcmc7IHFlbXUtZGV2ZWxA
bm9uZ251Lm9yZzsgQWxpc3RhaXIgRnJhbmNpcw0KPiA8QWxpc3RhaXIuRnJhbmNpc0B3ZGMuY29t
PjsgTWF0aWFzIEJqb3JsaW5nIDxNYXRpYXMuQmpvcmxpbmdAd2RjLmNvbT4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSCB2NCAwMC8xNF0gaHcvYmxvY2svbnZtZTogU3VwcG9ydCBOYW1lc3BhY2UgVHlw
ZXMNCj4gYW5kIFpvbmVkIE5hbWVzcGFjZSBDb21tYW5kIFNldA0KPiANCj4gT24gU2VwIDI0IDAz
OjIwLCBEbWl0cnkgRm9taWNoZXYgd3JvdGU6DQo+ID4gdjMgLT4gdjQNCj4gPg0KPiA+ICAtIEZp
eCBidWdzIGludHJvZHVjZWQgaW4gdjIvdjMgZm9yIFFEID4gMSBvcGVyYXRpb24uIE5vdywgYWxs
IHdyaXRlcw0KPiA+ICAgIHRvIGEgem9uZSBoYXBwZW4gYXQgdGhlIG5ldyB3cml0ZSBwb2ludGVy
IHZhcmlhYmxlLCB6b25lLT53X3B0ciwNCj4gPiAgICB0aGF0IGlzIGFkdmFuY2VkIHJpZ2h0IGFm
dGVyIHN1Ym1pdHRpbmcgdGhlIGJhY2tlbmQgaS9vLiBUaGUgZXhpc3RpbmcNCj4gPiAgICB6b25l
LT5kLndwIHZhcmlhYmxlIGlzIHVwZGF0ZWQgdXBvbiB0aGUgc3VjY2Vzc2Z1bCB3cml0ZSBjb21w
bGV0aW9uDQo+ID4gICAgYW5kIGl0IGlzIHVzZWQgZm9yIHpvbmUgcmVwb3J0aW5nLiBTb21lIGNv
ZGUgaGFzIGJlZW4gc3BsaXQgZnJvbQ0KPiA+ICAgIG52bWVfZmluYWxpemVfem9uZWRfd3JpdGUo
KSBmdW5jdGlvbiB0byBhIG5ldyBmdW5jdGlvbiwNCj4gPiAgICBudm1lX2FkdmFuY2Vfem9uZV93
cCgpLg0KPiA+DQo+IA0KPiBTYW1lIGFwcHJvYWNoIHRoYXQgSSd2ZSB1c2VkLCArMS4NCj4gDQo+
ID4gIC0gTWFrZSB0aGUgY29kZSBjb21waWxlIHVuZGVyIG1pbmd3LiBTd2l0Y2ggdG8gdXNpbmcg
UUVNVSBBUEkgZm9yDQo+ID4gICAgbW1hcC9tc3luYywgaS5lLiBtZW1vcnlfcmVnaW9uLi4uKCku
IFNpbmNlIG1tYXAgaXMgbm90IGF2YWlsYWJsZSBpbg0KPiA+ICAgIG1pbmd3IChldmVuIHRob3Vn
aCB0aGVyZSBpcyBtbWFuLXdpbjMyIGxpYnJhcnkgYXZhaWxhYmxlIG9uIEdpdGh1YiksDQo+ID4g
ICAgY29uZGl0aW9uYWwgY29tcGlsYXRpb24gaXMgYWRkZWQgYXJvdW5kIHRoZXNlIGNhbGxzIHRv
IGF2b2lkDQo+ID4gICAgdW5kZWZpbmVkIHN5bWJvbHMgdW5kZXIgbWluZ3cuIEEgYmV0dGVyIGZp
eCB3b3VsZCBiZSB0byBhZGQgc3R1Yg0KPiA+ICAgIGZ1bmN0aW9ucyB0byBzb2Z0bW11L21lbW9y
eS5jIGZvciB0aGUgY2FzZSB3aGVuIENPTkZJR19QT1NJWCBpcyBub3QNCj4gPiAgICBkZWZpbmVk
LCBidXQgc3VjaCBjaGFuZ2UgaXMgYmV5b25kIHRoZSBzY29wZSBvZiB0aGlzIHBhdGNoc2V0IGFu
ZCBpdA0KPiA+ICAgIGNhbiBiZSBtYWRlIGluIGEgc2VwYXJhdGUgcGF0Y2guDQo+ID4NCj4gDQo+
IEV3d3d3Lg0KPiANCj4gVGhpcyBmZWVscyBsaWtlIGEgaGFjayBvciBhdCB0aGUgdmVyeSBsZWFz
dCBhbiBhYnVzZSBvZiB0aGUgcGh5c2ljYWwNCj4gbWVtb3J5IG1hbmFnZW1lbnQgQVBJLg0KPiAN
Cj4gSWYgaXQgcmVhbGx5IG5lZWRzIHRvIGJlIG1lbW9yeSBtYXBwZWQsIHRoZW4gSSB0aGluayBh
IGhvc3RtZW0tYmFzZWQNCj4gYXBwcm9hY2ggc2ltaWxhciB0byB3aGF0IEFuZHJ6ZWogZGlkIGZv
ciBQTVIgaXMgbmVlZGVkIChJIHRoaW5rIHRoYXQNCj4gd2lsbCBnZXQgcmlkIG9mIHRoZSBDT05G
SUdfUE9TSVggaWZkZWYgYXQgbGVhc3QsIGJ1dCBzdGlsbCBsZWF2ZSBpdA0KPiBzbGlnaHRseSB0
cmlja3kgdG8gZ2V0IGl0IHRvIHdvcmsgb24gYWxsIHBsYXRmb3JtcyBBRkFJSykuDQoNCk9rLCBp
dCBsb29rcyB0aGF0IHVzaW5nIHRoZSBIb3N0TWVtb3J5QmFja2VuZEZpbGUgYmFja2VuZCB3aWxs
IGJlDQptb3JlIGFwcHJvcHJpYXRlLiBUaGlzIHdpbGwgcmVtb3ZlIHRoZSBuZWVkIGZvciBjb25k
aXRpb25hbCBjb21waWxlLg0KDQpUaGUgbW1hcCgpIHBvcnRhYmlsaXR5IGlzIHByZXR0eSBkZWNl
bnQgYWNyb3NzIHNvZnR3YXJlIHBsYXRmb3Jtcy4NCkFueSBwb29yIFdpbmRvd3MgdXNlciB3aG8g
aXMgZm9yY2VkIHRvIGVtdWxhdGUgWk5TIG9uIG1pbmd3IHdpbGwgYmUNCmFibGUgdG8gZG8gc28s
IGp1c3Qgd2l0aG91dCBoYXZpbmcgem9uZSBzdGF0ZSBwZXJzaXN0ZW5jeS4gQ29uc2lkZXJpbmcN
CmhvdyBzcGVjaWFsaXplZCB0aGlzIHN0dWZmIGlzIGluIGZpcnN0IHBsYWNlLCBJIGVzdGltYXRl
IHRoZSBudW1iZXIgb2YgdXNlcnMNCmFmZmVjdGVkIGJ5IHRoaXMgImxpbWl0YXRpb24iIHRvIGJl
IGV4YWN0bHkgemVyby4NCg0KPiBCdXQgcmVhbGx5LA0KPiBzaW5jZSB3ZSBkbyBub3QgcmVxdWly
ZSBtZW1vcnkgc2VtYW50aWNzIGZvciB0aGlzLCB0aGVuIEkgdGhpbmsgdGhlDQo+IGFic3RyYWN0
aW9uIGlzIGZ1bmRhbWVudGFsbHkgd3JvbmcuDQo+IA0KDQpTZXJpb3VzbHksIHdoYXQgaXMgd3Jv
bmcgd2l0aCB1c2luZyBtbWFwIDopID8gSXQgaXMgdXNlZCBzdWNjZXNzZnVsbHkgZm9yDQpzaW1p
bGFyIGFwcGxpY2F0aW9ucywgZm9yIGV4YW1wbGUgLQ0KaHR0cHM6Ly9naXRodWIuY29tL29wZW4t
aXNjc2kvdGNtdS1ydW5uZXIvYmxvYi9tYXN0ZXIvZmlsZV96YmMuYw0KDQo+IEkgYW0sIG9mIGNv
dXJzZSwgYmxvd2luZyBteSBvd24gaG9ybiwgc2luY2UgbXkgaW1wbGVtZW50YXRpb24gdXNlcyBh
DQo+IHBvcnRhYmxlIGJsb2NrZGV2IGZvciB0aGlzLg0KPiANCg0KWW91IGFyZSBtYWtpbmcgaXQg
c291bmQgbGlrZSB0aGUgZW50aXJlIFdEQyBzZXJpZXMgcmVsaWVzIG9uIHRoaXMgYXBwcm9hY2gu
DQpBY3R1YWxseSwgdGhlIHBlcnNpc3RlbmN5IGlzIGludHJvZHVjZWQgaW4gdGhlIHNlY29uZCB0
byBsYXN0IHBhdGNoIGluIHRoZQ0Kc2VyaWVzIGFuZCBpdCBvbmx5IGFkZHMgYSBjb3VwbGUgb2Yg
bGluZXMgb2YgY29kZSBpbiB0aGUgaS9vIHBhdGggdG8gbWFyaw0Kem9uZXMgZGlydHkuIFRoaXMg
aXMgcG9zc2libGUgYmVjYXVzZSBvZiB1c2luZyBtbWFwKCkgYW5kIEkgZmluZCB0aGUgd2F5DQpp
dCBpcyBkb25lIHRvIGJlIHF1aXRlIGVsZWdhbnQsIG5vdCB1Z2x5IDopDQoNCj4gQW5vdGhlciBp
c3N1ZSBpcyB0aGUgY29tcGxldGUgbGFjayBvZiBlbmRpYW4gY29udmVyc2lvbnMuIERvZXMgaXQN
Cj4gbWF0dGVyPyBJdCBkZXBlbmRzLiBXaWxsIGFueW9uZSBldmVyIHVzZSB0aGlzIG9uIGEgYmln
IGVuZGlhbiBob3N0IGFuZA0KPiBtb3ZlIHRoZSBtZXRhIGRhdGEgYmFja2luZyBmaWxlIHRvIGEg
bGl0dGxlIGVuZGlhbiBob3N0PyBQcm9iYWJseSBub3QuDQo+IFNvIGRvZXMgaXQgcmVhbGx5IG1h
dHRlcj8gUHJvYmFibHkgbm90LCBidXQgaXQgaXMgY3V0dGluZyBjb3JuZXJzLg0KPiANCg0KR3Jl
YXQgcG9pbnQgb24gZW5kaWFubmVzcyEgTmF0dXJhbGx5LCBhbGwgZmlsZSBiYWNrZWQgdmFsdWVz
IGFyZSBzdG9yZWQgaW4NCnRoZWlyIG5hdGl2ZSBlbmRpYW5uZXNzLiBUaGlzIHdheSwgdGhlcmUg
aXMgbm8gZXh0cmEgb3ZlcmhlYWQgb24gYmlnIGVuZGlhbg0KaGFyZHdhcmUgYXJjaGl0ZWN0dXJl
cy4gUG9ydGFiaWxpdHkgY29uY2VybnMgY2FuIGJlIGVhc2lseSBhZGRyZXNzZWQgYnkNCnN0b3Jp
bmcgbWV0YWRhdGEgZW5kaWFubmVzcyBhcyBhIGJ5dGUgZmxhZyBpbiBpdHMgaGVhZGVyLiBUaGVu
LCBkdXJpbmcNCmluaXRpYWxpemF0aW9uLCB0aGUgbWV0YWRhdGEgdmFsaWRhdGlvbiBjb2RlIGNh
biBkZXRlY3QgdGhlIHBvc3NpYmxlDQpkaXNjcmVwYW5jeSBpbiBlbmRpYW5uZXNzIGFuZCBhdXRv
bWF0aWNhbGx5IGNvbnZlcnQgdGhlIG1ldGFkYXRhIHRvIHRoZQ0KZW5kaWFubmVzcyBvZiB0aGUg
aG9zdC4gVGhpcyBwYXJ0IGlzIG91dCBvZiBzY29wZSBvZiB0aGlzIHNlcmllcywgYnV0IEkgd291
bGQNCmJlIGFibGUgdG8gY29udHJpYnV0ZSBzdWNoIGEgc29sdXRpb24gYXMgYW4gZW5oYW5jZW1l
bnQgaW4gdGhlIGZ1dHVyZS4NCg0KPiA+ICAtIE1ha2UgdGhlIGxpc3Qgb2YgcmV2aWV3IGNvbW1l
bnRzIGFkZHJlc3NlZCBpbiB2MiBvZiB0aGUgc2VyaWVzDQo+ID4gICAgKHNlZSBiZWxvdykuDQo+
ID4NCj4gDQo+IFZlcnkgZGV0YWlsZWQhIFRoYW5rcyENCg==

