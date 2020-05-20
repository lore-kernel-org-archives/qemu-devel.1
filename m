Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E267DC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:55:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B08F2075F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qfDCtwqa";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="mQ3niX03"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B08F2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbKVs-0005El-RT
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 04:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=402f50500=Anup.Patel@wdc.com>)
 id 1jbKQr-0000Xf-RQ; Wed, 20 May 2020 04:50:34 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:11923)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=402f50500=Anup.Patel@wdc.com>)
 id 1jbKQp-0007lM-6G; Wed, 20 May 2020 04:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1589964632; x=1621500632;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Q+6LrkeC5sBvMvvWJkb3ipMqG7Us75b5OSuyDP9DydY=;
 b=qfDCtwqah+RWx6IjTJoFJBSWDsGw4WjgreASMKM3BbgNN0Jz9ol6AwIz
 tCfXA1/RosFTtL+pj1zeKJa8K/uatTjBZ8TmZRU/UIgt4fU2cXuzh/sui
 8tleywamODSJxwGfvhUaqNLlLHJhppepKXOiVuwNvCfYr6yyMUcsa0z9G
 v93f7qqQPvuzeL/2pWAExsT817kPN33cKIpKsw4iMT8CcD3jLSw9QYCCw
 1K6Q/tXkJKIXTH6LSNsdzsD1bZFFshr2yberSmCT3Ln/kjuKNMVK4jBgy
 LgQcV4pIRR9znXX0oytjGw1KUcaDgJeVOUs5AJYnlVsUHhHnAx8mpew9b g==;
IronPort-SDR: X7Pd0kkrSxHHlK8gGiGI/HwdvdDXrUgbafp+TW0gL5N8NAFJhWJ7T7vwseNPSD7Na4F+JaXcVT
 vdwBRGfG1rx1kWQVaDeFFS7KwsFavjGg8S6tK+3K+7pMLOSgtvYuaG+m3cw/5OgFmCVx25itWK
 P7JCpeZRz4nMEW5xZoAV4WUqRym/ky/j8Ikc/T/mDb7zU8TkVUwaoh0dyp/KMV/YxAzbEcRLKr
 xiCcHtQNWJxhuQxOAtaaI6jrGt9PlykzBPT/SEjFB5MsAZoSDjOsfdSqUYuW38wGyxN0Wv2ZH6
 8qs=
X-IronPort-AV: E=Sophos;i="5.73,413,1583164800"; d="scan'208";a="142447551"
Received: from mail-sn1nam02lp2057.outbound.protection.outlook.com (HELO
 NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.57])
 by ob1.hgst.iphmx.com with ESMTP; 20 May 2020 16:50:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TIaK00cmQHSGEzy8w3nFqka0iBS8ylyFQ/lFHz5gQMC5JrXYfJNfUYvaSDzE6BRBT2hf7zam++vxnhGrV7f72bEKzm/MAKtJZRxWgEVHKm4WT9j/iWEsE+TqBpCQl/nqQU7C4DY2qJp+I/pEcx6DfArUcvKqAR998NDD35AFJiCBlL9iwY5cmbS8ULzDsTtKS4AtYIrQSNuUhZ6tliMfprCrNBYKsFeL6a+Kp9hgM+npM97nV4e8KxBCsixFKqeVWGWvNmsa/gCjzBE5DmBj2bA//xfE8NPP5jHPUQTnYC3Bxi5FZn7F0/Z7sqgOPW0IJQXDY6iCy/v1NhXfWTQhFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+6LrkeC5sBvMvvWJkb3ipMqG7Us75b5OSuyDP9DydY=;
 b=DIeWwScdBgK4NFeoyk3Lr3ZMx4U+VIz7wfy+7XQm3zlPyK+EIqRWpw/dVq4v++Umap3kC6rUbRsROEE2jdxidiijkKmOV8Pc3zhN6bIlOG5fvN3pHbxTY2k2CPl7DKKJyG03W4vx8n40M8tb4MkHZAfOZF01guFbIaoQbQZDxmrXY/EZ5MGLlxmoHNZpUD1nyplC54KstEHHLvzuW8ObGeAdKaLq7dpGL92TpQHBH52vHW60I7C5tjEd70Mlwr6qMX/HBA5xGhYbnkR2FF3yidHTvfyvFKdI6GxtwpB53eQaADf2Z8T/tWoq1/Y+nOKcexVj7VIC9cFb0gg9uefhhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+6LrkeC5sBvMvvWJkb3ipMqG7Us75b5OSuyDP9DydY=;
 b=mQ3niX03wENFF3M6RnrooivTD/6jRF28OL19eXm/SaWnD5F87nNLhvU2oUdW1IpGiZzEDA/KkRsRFKwHgiQYQPjUOqUtv99Hm/wBjxZCI5BGgTmPpnjLB1NedgxrmbON+GZxz1IGlzCq3jhwJRnEq8AI4Pb6NQCekOSFCKK/kIc=
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB4972.namprd04.prod.outlook.com (2603:10b6:5:fc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Wed, 20 May
 2020 08:50:23 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0%5]) with mapi id 15.20.3000.034; Wed, 20 May 2020
 08:50:23 +0000
From: Anup Patel <Anup.Patel@wdc.com>
To: Alistair Francis <alistair23@gmail.com>
Subject: RE: [PATCH 0/4] RISC-V multi-socket support
Thread-Topic: [PATCH 0/4] RISC-V multi-socket support
Thread-Index: AQHWK0yQHwdaM0x1Tka0/hlTAcemqqiv8AaAgACvivA=
Date: Wed, 20 May 2020 08:50:23 +0000
Message-ID: <DM6PR04MB6201E9B6CF062D5FDB07A4B98DB60@DM6PR04MB6201.namprd04.prod.outlook.com>
References: <20200516063746.18296-1-anup.patel@wdc.com>
 <CAKmqyKNURMfx+ONV02DLiJxkMaX7_FCdoNjnUhtqnsvKpty8PA@mail.gmail.com>
In-Reply-To: <CAKmqyKNURMfx+ONV02DLiJxkMaX7_FCdoNjnUhtqnsvKpty8PA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [106.51.25.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4def611a-fabb-48d2-1d9a-08d7fc9ad5b2
x-ms-traffictypediagnostic: DM6PR04MB4972:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB49721E4B54DD384DCCE780668DB60@DM6PR04MB4972.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 04097B7F7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uJJAGlVtlQaYcJSw9mmIf7ewJMssIpx+B5cutiYR4Gn7ZxFJLJkPNNEeUGst9i2SadJt8V9Ars5z/BjfFoJJEUZBFy6d8BOecWkvoF4Whpt7KC5aNxszjbCc23FIkyuIcjvIsXECp5u4qD5gEeq0Cc1bb7t4Kdh+VvYkbFKwRn6zfUPa8Vq2aTjWQy7b7FWfWdkIMWTkpbmhHsB34DDYbLp6TTVLdh1WfF9e+3x/tkkcOssXmImNROomV9xGf2+vrvbOzO7FMtz3eo7zLRFKj/APv5iYMhnuOjjwd7AoEX+gsN2lATgrl4Yh8pKhdohAlWz94POMtuxKqK6iE6W703PetTJ5bVO9xdHsEnho33XtGwFg+8LdghXBL41q4jJYx+Kn8Ml1pyOQf/fTLZhJwoMclhsvdUX1rHUpTKXOwUwMnJwaYY+bFHCauJJrii4rwwWxpyeR6xcVnAl4t/BY2Nms/8xNPxv1UWZXU2a5od+71/62Mq6lPYYk/VyaiFxmbIyB8tjp0l7jADF8T6zIGQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6201.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(39860400002)(346002)(366004)(376002)(66476007)(64756008)(66556008)(66446008)(76116006)(5660300002)(66946007)(8936002)(478600001)(86362001)(966005)(55236004)(4326008)(6506007)(7696005)(8676002)(53546011)(316002)(26005)(71200400001)(186003)(54906003)(2906002)(33656002)(6916009)(9686003)(55016002)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 9CTJTfsIwMMtSoEUmGLJWbTZ4uHHEfHGyDp8j7BTMCi5osnBUuO6362PnJcuyuARAnRTfu3gf1z8HXXRa6p8H+kGw5S53bn3Naq/dKWMDP4o+CPvcyF808seMPw/LoV6HIEZ+IlLgquFMm9CExkK8/Fqti47fcHHDlvrSVfHdZVJS2CirBo8BvkijZCebH9Z4MQd+t1XLteojrPINGFY36M4ZNlZUu6UgNgJ9Shmrg39CLJj909NVDczG7efzOJTER18BXruWIeWYKnSgYmgbHpVXn1kjPohUdyY3/byK1h4u6whqVPqHlYpKUDI57ZLDAZ/nFTunyIp5LoNDUL3rifT0rM73ihEBd1H1OGNtfFiaJ63GglFKI6HQvlUla2gEWrbYcKTWlvspxbD8TmqW6iVe9/HUx2+5KYt38zaiCOhlBW8O0y/OeKUaoBZn4XQ7zzMcMt53m4h3vHRHpjpwM6zWiZrQvC1Q1nZI/3XYSs=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4def611a-fabb-48d2-1d9a-08d7fc9ad5b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2020 08:50:23.4648 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GxxFW7otXkdMVC7g2HIUMmkW/KInnBwnCHyewuUQyYaNfrqZMszWCA7+5gUiWuo4rMDj6pVo6aVI7DJ6rQpH+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4972
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=402f50500=Anup.Patel@wdc.com; helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 04:50:25
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, Anup Patel <anup@brainfault.org>,
 "qemu-devel@nongnu.org
 Developers" <qemu-devel@nongnu.org>, Atish Patra <Atish.Patra@wdc.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxpc3RhaXIgRnJhbmNp
cyA8YWxpc3RhaXIyM0BnbWFpbC5jb20+DQo+IFNlbnQ6IDIwIE1heSAyMDIwIDAyOjUwDQo+IFRv
OiBBbnVwIFBhdGVsIDxBbnVwLlBhdGVsQHdkYy5jb20+DQo+IENjOiBQZXRlciBNYXlkZWxsIDxw
ZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+OyBQYWxtZXIgRGFiYmVsdA0KPiA8cGFsbWVyQGRhYmJl
bHQuY29tPjsgQWxpc3RhaXIgRnJhbmNpcyA8QWxpc3RhaXIuRnJhbmNpc0B3ZGMuY29tPjsgU2Fn
YXINCj4gS2FyYW5kaWthciA8c2FnYXJrQGVlY3MuYmVya2VsZXkuZWR1PjsgQXRpc2ggUGF0cmEg
PEF0aXNoLlBhdHJhQHdkYy5jb20+Ow0KPiBvcGVuIGxpc3Q6UklTQy1WIDxxZW11LXJpc2N2QG5v
bmdudS5vcmc+OyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gRGV2ZWxvcGVycyA8cWVtdS1kZXZl
bEBub25nbnUub3JnPjsgQW51cCBQYXRlbCA8YW51cEBicmFpbmZhdWx0Lm9yZz4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSCAwLzRdIFJJU0MtViBtdWx0aS1zb2NrZXQgc3VwcG9ydA0KPiANCj4gT24g
RnJpLCBNYXkgMTUsIDIwMjAgYXQgMTE6NDAgUE0gQW51cCBQYXRlbCA8YW51cC5wYXRlbEB3ZGMu
Y29tPiB3cm90ZToNCj4gPg0KPiA+IFRoaXMgc2VyaWVzIGFkZHMgbXVsdGktc29ja2V0IHN1cHBv
cnQgZm9yIFJJU0MtViB2aXJ0IG1hY2hpbmUgYW5kDQo+ID4gUklTQy1WIHNwaWtlIG1hY2hpbmUu
IFRoZSBtdWx0aS1zb2NrZXQgc3VwcG9ydCB3aWxsIGhlbHAgdXMgaW1wcm92ZQ0KPiA+IHZhcmlv
dXMgUklTQy1WIG9wZXJhdGluZyBzeXN0ZW1zLCBmaXJtd2FyZXMsIGFuZCBib290bG9hZGVyIHRv
IHN1cHBvcnQNCj4gPiBSSVNDLVYgTlVNQSBzeXN0ZW1zLg0KPiA+DQo+ID4gVGhlc2UgcGF0Y2gg
Y2FuIGJlIGZvdW5kIGluIHJpc2N2X211bHRpX3NvY2tldF92MSBicmFuY2ggYXQ6DQo+ID4gaHR0
cHM6Ly9naXRodWIuY29tL2F2cGF0ZWwvcWVtdS5naXQNCj4gPg0KPiA+IFRvIHRyeSB0aGlzIHBh
dGNoZXMsIHdlIHdpbGwgbmVlZDoNCj4gPiAxLiBPcGVuU0JJIG11bHRpLVBMSUMgYW5kIG11bHRp
LUNMSU5UIHN1cHBvcnQgd2hpY2ggY2FuIGJlIGZvdW5kIGluDQo+ID4gICAgbXVsdGlfcGxpY19j
bGludF92MSBicmFuY2ggYXQ6DQo+ID4gICAgaHR0cHM6Ly9naXRodWIuY29tL2F2cGF0ZWwvb3Bl
bnNiaS5naXQNCj4gPiAyLiBMaW51eCBtdWx0aS1QTElDIGltcHJvdmVtZW50cyBzdXBwb3J0IHdo
aWNoIGNhbiBiZSBmb3VuZCBpbg0KPiA+ICAgIHBsaWNfaW1wX3YxIGJyYW5jaCBhdDoNCj4gPiAg
ICBodHRwczovL2dpdGh1Yi5jb20vYXZwYXRlbC9saW51eC5naXQNCj4gPg0KPiA+IEFudXAgUGF0
ZWwgKDQpOg0KPiA+ICAgaHcvcmlzY3Y6IEFsbG93IGNyZWF0aW5nIG11bHRpcGxlIGluc3RhbmNl
cyBvZiBDTElOVA0KPiA+ICAgaHcvcmlzY3Y6IHNwaWtlOiBBbGxvdyBjcmVhdGluZyBtdWx0aXBs
ZSBzb2NrZXRzDQo+ID4gICBody9yaXNjdjogQWxsb3cgY3JlYXRpbmcgbXVsdGlwbGUgaW5zdGFu
Y2VzIG9mIFBMSUMNCj4gPiAgIGh3L3Jpc2N2OiB2aXJ0OiBBbGxvdyBjcmVhdGluZyBtdWx0aXBs
ZSBzb2NrZXRzDQo+IA0KPiBDYW4geW91IG1ha2Ugc3VyZSBhbGwgdGhlIHBhdGNoZXMgcGFzcyBj
aGVja3BhdGNoPw0KDQpNeSBiYWQsIEkgZm9yZ290IHRvIHJ1biBjaGVja3BhdGNoIG9uIHRoaXMg
c2VyaWVzLg0KDQpJIHdpbGwgdXBkYXRlIGluIHYyLg0KDQpSZWdhcmRzLA0KQW51cA0K

