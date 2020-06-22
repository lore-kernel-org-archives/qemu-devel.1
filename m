Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBFCC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 12:22:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AD3020716
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 12:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NodaJBEe";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="kUoicdy4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AD3020716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnLT6-0007vv-SQ
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 08:22:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=435c605ae=Anup.Patel@wdc.com>)
 id 1jnLR3-00069e-SF; Mon, 22 Jun 2020 08:20:25 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:12841)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=435c605ae=Anup.Patel@wdc.com>)
 id 1jnLQz-0008Le-BO; Mon, 22 Jun 2020 08:20:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592828421; x=1624364421;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=DVBQ+sZNHlvQM69FHbg/nRwA9ycyfLHXYwB9IesQ4L0=;
 b=NodaJBEeq9pn8EbNFw4jjWn32CsVhW8uK0xW1ndv8+og8cAJdGpigc8z
 IwAX2vfXCJAIW1JBpx4akeUqCqExVhP4Is32tdjWZqTWwICD+DlveHoMT
 CcmI7WqldyxLXbu4ecO+h2CoZAQQg7Tmefdgcwe1PXjnsYCg1NmH50lBU
 /2MfKgwpdVY6hLCW2gK0A6rFOp5UAQGwv6aEj8+fbNgpLoeKo1GwfhV+I
 TkjCb9vgfRUoV5Cw5kNMgI/uYQwC+OlX1R3f4l52k91kGxd64Y4E+l+V1
 ITdra14FQveV4zhZoA8CZhokT9a9aLa1uqYviIFImRleKJjpfPdXjCLC5 w==;
IronPort-SDR: rB2PiTXYV00+BVZLpCVqFDWBgcJKxmEtAsSIScsiBhtdhpOg24tQ0qexv/ywP5c6UcxJJyZFVk
 hYaFSdWIU4hPmSRM3qAnXPwwhYMr+vBDBH3RLhcuZ+345Er/+NCCgLXyOa2Vuz0w6ixILjbRSA
 X0JNDoljb8PAUlAlPaR8RqNSYTLM9T3DQz4+gLJsD6/utq1kSIDceQq9TCEOAP83pQJqcq6FvM
 /XeEQWugXZM5oLOLuSHdbRnydepG9brCCXTp5oMOykpj3u5jSKWsGJumVPMbS9gFmB6aKOgRIY
 a+4=
X-IronPort-AV: E=Sophos;i="5.75,266,1589212800"; d="scan'208";a="144924925"
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
 by ob1.hgst.iphmx.com with ESMTP; 22 Jun 2020 20:20:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HV2J+gYvM/AR+xxgyFbz24kaY959wa5jopMeRTWEZBHf0N0/YJ3Qh1aXHSwlWPIxMSJAZmhRdK3h2ffn7hKml7FrtURxcalPmGnoufPcLnMbuzOwJKD+EgQcTfLUs+0Q7edxg0HqLoiYi3jbUm+5WyUMq6NII2lGh7gPvAK6I7X5qD0Q78wmwFNQL0SDLz4bz7t00vD5sjTMVCS4YauOgRHdAPrp0LIbsf357KGhQPvucs4/2HaGjgo9foyWoX/EwnyQmrn96Q9tcBGENBmjGa3JEH/VKEVZ2WUuNIEXwKGQshP8O8s/U0idKrb+qccTXPAYpc7xxPUNdliGXr2fQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVBQ+sZNHlvQM69FHbg/nRwA9ycyfLHXYwB9IesQ4L0=;
 b=CkL9AeTdhn7SxKfWuariMhP886o2sdQKmVFTK35nZ0UkXiONizVkoSZzCB93VvOw1fP2Gx8qquJQzeyxawslEOI3+fozDm+PmaEj5Bh6lBvllI8ZSRS6HJRgF1bdbNv1czlM1E/FMi/bGMFMkY162eBl3n9CK0oSS/dBaII6f9NeQxl+iShEr51cdf9wxfoHmyTRCJL9z2fwCrQc7Jb/vNHe/DcoQ95SP/yCwYwg1ddTPBArzYa1Ty0zj8fUEDjdqVL2CRl94YUCWjj4U/cKRvygN8YzlfZKWjN3xJ93QfcyBxTUcXBs5VxbL5vtnzAaPqyVIlWukXVn+LdY1ZQBPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVBQ+sZNHlvQM69FHbg/nRwA9ycyfLHXYwB9IesQ4L0=;
 b=kUoicdy4BC0qLNkAQyKMNMo69RoVIQ6UFuKSCmgUBRkAQ3UvihdXYa2N5j/UK/eAx+Ml0bBuTG9LeWVQ6uyenOdy30Ti0gPSTzWxK3rN5aSNCXIxuCYi9z4iacFFS1Y/dGE8vSrZsvcZYpf4RTmUu4pe3W4oeEuBj7ezU8fhc+k=
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB6300.namprd04.prod.outlook.com (2603:10b6:5:1e3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Mon, 22 Jun
 2020 12:20:14 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::e0a4:aa82:1847:dea5]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::e0a4:aa82:1847:dea5%7]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 12:20:14 +0000
From: Anup Patel <Anup.Patel@wdc.com>
To: Bin Meng <bmeng.cn@gmail.com>
Subject: RE: [PATCH v2 0/7] riscv: Switch to use generic platform of opensbi
 bios images
Thread-Topic: [PATCH v2 0/7] riscv: Switch to use generic platform of opensbi
 bios images
Thread-Index: AQHWSF8bvVpcQ8q0fEm5PQ775A0UKqjkaUTQgAAi4YCAAAF0AA==
Date: Mon, 22 Jun 2020 12:20:14 +0000
Message-ID: <DM6PR04MB62013393F37DC653A1D3F1B28D970@DM6PR04MB6201.namprd04.prod.outlook.com>
References: <1592807604-20805-1-git-send-email-bmeng.cn@gmail.com>
 <DM6PR04MB620142B152292DD3945E4D3C8D970@DM6PR04MB6201.namprd04.prod.outlook.com>
 <CAEUhbmVhHKy70dA5dyQCiWeYk1nbhXHnZH8JBxmRJP6EUb2z9g@mail.gmail.com>
In-Reply-To: <CAEUhbmVhHKy70dA5dyQCiWeYk1nbhXHnZH8JBxmRJP6EUb2z9g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [103.56.182.118]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7a8dc265-b2f1-4f56-d8d1-08d816a69e4a
x-ms-traffictypediagnostic: DM6PR04MB6300:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB63003CE069B47CC3A5144E1D8D970@DM6PR04MB6300.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0442E569BC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 18VVJlvYjV1edOaErFm6COcEZm5o80VnHmrsd5L2SUEv0IkjBD3ZmTejihHFteKnnvmb5IezDp+HB3v23LVXukGE4nkDI80wkoDsSpvJuDc3l4p4IYDD7sfI7gaUq6uy69G4PfJjZzCnKJw/YFOR6LHSXciPnco8C9T5+pZuRDeShV5oYZzQbO0h5FzHIKKNEgYk1kZd/3L7ZVJKlgR1cFDzyTbFCFYU2r6w0IUgn0vJkitsCocYjkNRmdxgn4Yq/t1A7O8tVU+D953JJfsAyySl1dLQdZY1LVRhRujtziGnArVifqVjrWeFwD/6J/BHjW6cp4+5qNBt6PaSygXdeWEhxRvwZsEn5h7Koo4Ku9DSQcIncyJ+TR2zpTUDWldamsT0bWwV1bST+Xs8mM0nu6fn6Jyv74nT7ZGtKV5eEUdbtPlwDrf3Jn3zEEkG4N3PbeZo4QbXq3+P/5xJ2/hEgA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6201.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(396003)(366004)(346002)(376002)(33656002)(83380400001)(6506007)(53546011)(55016002)(9686003)(8936002)(76116006)(66556008)(64756008)(66476007)(8676002)(66946007)(66446008)(7696005)(52536014)(4326008)(2906002)(86362001)(6916009)(54906003)(186003)(71200400001)(5660300002)(478600001)(316002)(966005)(26005)(41533002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: kQlyrh6VWRB0x0pXDCuaY77dXsmL6mM9NZvdzU6/7gnD3STDm7XBBhLTNyHP8hkks3JvNOXVsvVMvFxeaA1R5x7I82k6TSGSblby4sbdrBgej1nvC/uehESAme/lLFQx6/LvGz0TRUFDQpcaYxwJGQCQBMPt/13diiw1ZKok0Dv2m7uq6s41/kV3yWkRnAYReXJO/c9DyHriGNnLIQrn3kMTU/s46OdLWSSuHRBioTafRP+9v9gLZFKEF1UkMiZiOYcbwEo4z3KXDke1bwp+eyCIMQ1PWmGyuuGrQB4ETA0VPdxRrUEsIYomCumeWKe3fWHaasYjtC43LxMFO2yGcd++Pk/dAApLlx6OczWCG+OL+OZVILDjamPEnMgqDVdC/astNmX9XQcKCeDSeQV3Dys6CtnbvHUKyBadtcMLDCzZ770GHo1ggPcfkog9u8QtxChaQeN2pFK7dISXW/oyrDcXYJwhV90Wvty2jlxBXQ996asU+xFTYjDcOK1C5uWw
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a8dc265-b2f1-4f56-d8d1-08d816a69e4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2020 12:20:14.8203 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B2nPAZYrXu/j8pk2tl1QlFD9GiX7terx3WmJMmDTVtauAJLeg5pYWN4gRtaULMfVTQlLDBRKVDTemE00ldLSoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6300
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=435c605ae=Anup.Patel@wdc.com; helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 08:20:17
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
Cc: Bin Meng <bin.meng@windriver.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, Anup Patel <anup@brainfault.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmluIE1lbmcgPGJtZW5n
LmNuQGdtYWlsLmNvbT4NCj4gU2VudDogMjIgSnVuZSAyMDIwIDE3OjQzDQo+IFRvOiBBbnVwIFBh
dGVsIDxBbnVwLlBhdGVsQHdkYy5jb20+DQo+IENjOiBBbGlzdGFpciBGcmFuY2lzIDxBbGlzdGFp
ci5GcmFuY2lzQHdkYy5jb20+OyBCYXN0aWFuIEtvcHBlbG1hbm4NCj4gPGtiYXN0aWFuQG1haWwu
dW5pLXBhZGVyYm9ybi5kZT47IFBhbG1lciBEYWJiZWx0DQo+IDxwYWxtZXJkYWJiZWx0QGdvb2ds
ZS5jb20+OyBTYWdhciBLYXJhbmRpa2FyDQo+IDxzYWdhcmtAZWVjcy5iZXJrZWxleS5lZHU+OyBx
ZW11LWRldmVsQG5vbmdudS5vcmc7IHFlbXUtDQo+IHJpc2N2QG5vbmdudS5vcmc7IEFudXAgUGF0
ZWwgPGFudXBAYnJhaW5mYXVsdC5vcmc+OyBCaW4gTWVuZw0KPiA8YmluLm1lbmdAd2luZHJpdmVy
LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAwLzddIHJpc2N2OiBTd2l0Y2ggdG8gdXNl
IGdlbmVyaWMgcGxhdGZvcm0gb2Ygb3BlbnNiaQ0KPiBiaW9zIGltYWdlcw0KPiANCj4gSGkgQW51
cCwNCj4gDQo+IE9uIE1vbiwgSnVuIDIyLCAyMDIwIGF0IDY6MDkgUE0gQW51cCBQYXRlbCA8QW51
cC5QYXRlbEB3ZGMuY29tPiB3cm90ZToNCj4gPg0KPiA+DQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBRZW11LXJpc2N2IDxxZW11LXJpc2N2LQ0KPiA+
ID4gYm91bmNlcythbnVwLnBhdGVsPXdkYy5jb21Abm9uZ251Lm9yZz4gT24gQmVoYWxmIE9mIEJp
biBNZW5nDQo+ID4gPiBTZW50OiAyMiBKdW5lIDIwMjAgMTI6MDMNCj4gPiA+IFRvOiBBbGlzdGFp
ciBGcmFuY2lzIDxBbGlzdGFpci5GcmFuY2lzQHdkYy5jb20+OyBCYXN0aWFuIEtvcHBlbG1hbm4N
Cj4gPiA+IDxrYmFzdGlhbkBtYWlsLnVuaS1wYWRlcmJvcm4uZGU+OyBQYWxtZXIgRGFiYmVsdA0K
PiA+ID4gPHBhbG1lcmRhYmJlbHRAZ29vZ2xlLmNvbT47IFNhZ2FyIEthcmFuZGlrYXINCj4gPiA+
IDxzYWdhcmtAZWVjcy5iZXJrZWxleS5lZHU+OyBxZW11LWRldmVsQG5vbmdudS5vcmc7IHFlbXUt
DQo+ID4gPiByaXNjdkBub25nbnUub3JnDQo+ID4gPiBDYzogQW51cCBQYXRlbCA8YW51cEBicmFp
bmZhdWx0Lm9yZz47IEJpbiBNZW5nDQo+ID4gPiA8YmluLm1lbmdAd2luZHJpdmVyLmNvbT4NCj4g
PiA+IFN1YmplY3Q6IFtQQVRDSCB2MiAwLzddIHJpc2N2OiBTd2l0Y2ggdG8gdXNlIGdlbmVyaWMg
cGxhdGZvcm0gb2YNCj4gPiA+IG9wZW5zYmkgYmlvcyBpbWFnZXMNCj4gPiA+DQo+ID4gPiBGcm9t
OiBCaW4gTWVuZyA8YmluLm1lbmdAd2luZHJpdmVyLmNvbT4NCj4gPiA+DQo+ID4gPiBUaGUgUklT
Qy1WIGdlbmVyaWMgcGxhdGZvcm0gaXMgYSBmbGF0dGVuZWQgZGV2aWNlIHRyZWUgKEZEVCkgYmFz
ZWQNCj4gPiA+IHBsYXRmb3JtIHdoZXJlIGFsbCBwbGF0Zm9ybSBzcGVjaWZpYyBmdW5jdGlvbmFs
aXR5IGlzIHByb3ZpZGVkIGJhc2VkDQo+ID4gPiBvbiBGRFQgcGFzc2VkIGJ5IHByZXZpb3VzIGJv
b3Rpbmcgc3RhZ2UuIFRoZSBzdXBwb3J0IHdhcyBhZGRlZCBpbg0KPiA+ID4gdGhlIHVwc3RyZWFt
IE9wZW5TQkkNCj4gPiA+IHYwLjggcmVsZWFzZSByZWNlbnRseS4NCj4gPiA+DQo+ID4gPiBUaGlz
IHNlcmllcyB1cGRhdGVzIFFFTVUgdG8gc3dpdGNoIHRvIHVzZSBnZW5lcmljIHBsYXRmb3JtIG9m
DQo+ID4gPiBvcGVuc2JpIGJpb3MgaW1hZ2VzLg0KPiA+ID4NCj4gPiA+IFRoZSBwYXRjaCBlbWFp
bHMgZG8gbm90IGNvbnRhaW4gYmluYXJ5IGJpdHMsIHBsZWFzZSBncmFiIGFsbCB1cGRhdGVzDQo+
ID4gPiBhdCBodHRwczovL2dpdGh1Yi5jb20vbGJtZW5nL3FlbXUuZ2l0IGJpb3MgYnJhbmNoLg0K
PiA+DQo+ID4gSXQgd2lsbCBiZSBuaWNlIHRvIGhhdmUgdGhpcyBzZXJpZXMgdXBkYXRlZCB0byBm
b3IgZndfZHluYW1pYy5iaW4gLg0KPiANCj4gRG8geW91IG1lYW4gd2UgaW5jbHVkZSBmd19keW5h
bWljLmJpbiBmb3IgdmlydCAmIHNpZml2ZV91LCBhbmQNCj4gZndfZHluYW1pYy5lbGYgZm9yIHNw
aWtlPw0KPiANCj4gQnV0IHByZXZpb3VzbHkgd2UgYWdyZWVkIHRvIGluY2x1ZGUgb25seSBnZW5l
cmljIHBsYXRmb3JtIEJJTiBhbmQgRUxGIGZpbGVzLg0KPiBTZWUgaHR0cHM6Ly9saXN0cy5nbnUu
b3JnL2FyY2hpdmUvaHRtbC9xZW11LWRldmVsLzIwMjAtMDUvbXNnMDA2NjQuaHRtbA0KDQpJIGFt
IHN1Z2dlc3RpbmcgdG8gdXNlIEdlbmVyaWMgcGxhdGZvcm0gZndfZHluYW1pYy5iaW4gYW5kIGZ3
X2R5bmFtaWMuZWxmDQpmb3IgUUVNVSB2aXJ0LCBRRU1VIHNwaWtlLCBhbmQgUUVNVSBzaWZpdmVf
dSBtYWNoaW5lcy4NCg0KUmVnYXJkcywNCkFudXANCg==

