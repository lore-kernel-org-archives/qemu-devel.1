Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F16C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 18:25:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08D512220C
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 18:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OAUbchqE";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="wJuL2rHg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08D512220C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLVvb-0007nv-SZ
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 14:25:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=5292f8049=Niklas.Cassel@wdc.com>)
 id 1kLVtd-00077n-36; Thu, 24 Sep 2020 14:23:09 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:42153)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=5292f8049=Niklas.Cassel@wdc.com>)
 id 1kLVtZ-0006ba-Ab; Thu, 24 Sep 2020 14:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600971785; x=1632507785;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=1RO04w9j+ODWjRi3kSO34+78dRj5pWNHmTIuYGyRRlc=;
 b=OAUbchqEbK83jJbYflPXKACdjRyqBWk2jdMs6ygxJsaNhExWs8x/93vJ
 yBl7RXXbA9kuMU6EAszz7EOOmYjI5OuGomidOSDVq3IthlYCSdK3TzgRY
 ks05me5MH6skyBbW1wgycN1BfZ0FzjVpBPnWNzj1Wg1fsv7t85fkjlCUM
 t3VWmedIR37q6Xui2d5zv7hCVARuuqBMxh3v9fVQg1rFXjTjUkwsek0t+
 fV4iOY2PHLdhOReU2RdlQaZKB1QG6Pll4BsYgTOWMEJZvog9e4xcgvAYc
 ljAv9+i/LWsx87ALLb8pP6yaPwPGsi7+tYqUxuDXyI6tQEFgQA2lSHgX3 Q==;
IronPort-SDR: L0P8SGp7WwUvPtQzY9Q9Wf8Q4gsZ7hlS+5vxfogjUrm5KkPoXwpUjL7elN1X+xf4E1URrdsG1O
 qplJmM6p+9KTnV03hQnnm69ikPR8fesl4/mtVu0BY3a26AykWsc0vyQE2Clqhr26sddGdqxQ0U
 6gCJeXFy8GBmHjyNpyh36C8TRTrSWwyqDrx0PAE5wCIMYJr9gcRM9vdO7gOcgMP85xywYzT07K
 aItkMzRRJBdUpKlBOZsALIGiN/RF72qf5rCFkkA8fV7lQ9xp+zIytOwEPqk/1mH4QVcVXP/uqp
 hfg=
X-IronPort-AV: E=Sophos;i="5.77,298,1596470400"; d="scan'208";a="148126029"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
 by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2020 02:17:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9Neclj3m2C7JAhdMwzzhVta7RSZD5x6LA0m7sn1rZhKy00JS8Ar0yEevWYHbKMgP+WChfNTb1h4Ts/eXcXNM96AzAT5M0g7bcN4E9PaDoT7s1Tb7H9bjgzRPEt8lQMKXObqdrUevC4hWm73Hd1qALbnWoLodBGLzW0iw2ILldOnykbZRRxG2OOHRlyZWDk5EBIYZ2rJdBfmAx2Xjc/SIhPXYCBSMcmQr42YtViYNvCuscgSigmW1LykTn+kJZCD4k8FaMqpTO+MXTHMXshfsDXgt4J5Lc/OwxpyL4nkfnaGtofmLnDOHoiXpz09xEbQj0TQZ+XxUHVCGF3Yzc5ibA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1RO04w9j+ODWjRi3kSO34+78dRj5pWNHmTIuYGyRRlc=;
 b=PqjxDtzxKsKB7eHzuZsSoq1zaUpwSkFymi1ta/uoTzwcGSS9yw7nrWm9hQNk6MS1Egs5aE4/kPjJMC8jziI38l6mPvLQ3KxjawK+GJlRlpXg095J9vve5VltB5c577/h+oU86BCHVj6HTnS+GfyrLjG8pPkfYRLOjjj7yjOmHt+QcrxtlQEQR3A4pU9MIrmimZ6Q3bNVmTEEo9lIS+9AUTlaIQO9EaT6W99Qoy6MZ6jSiy7mjbrzxdx+3AJerX2J2f5e08qyM6ltnF5k730I042y161fMo6B4nGXp05DNSlubAinWbJakUkeAUUBqQudWOGRRGiqCTqse9KQqaKkng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1RO04w9j+ODWjRi3kSO34+78dRj5pWNHmTIuYGyRRlc=;
 b=wJuL2rHgRgmsNBESRNT8tq6BHM9tBuy7S6banqIjkvPsmEEaLq9te60dJMVQOMBRKS32cWsMTE7IBV50io8SzSatKwGmgd8V7HtI5Znl5H5Jhco4p8uOWGHo228iCyjhbUANYWh5qTDOUhtBL0HHKwwsOfF/yiHAFiTtbh/O6zc=
Received: from BN6PR04MB0724.namprd04.prod.outlook.com (2603:10b6:404:ce::23)
 by BN7PR04MB4178.namprd04.prod.outlook.com (2603:10b6:406:f1::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Thu, 24 Sep
 2020 18:17:23 +0000
Received: from BN6PR04MB0724.namprd04.prod.outlook.com
 ([fe80::acb1:47a4:73ba:69a7]) by BN6PR04MB0724.namprd04.prod.outlook.com
 ([fe80::acb1:47a4:73ba:69a7%9]) with mapi id 15.20.3412.020; Thu, 24 Sep 2020
 18:17:23 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH v4 06/14] hw/block/nvme: Add support for active/inactive
 namespaces
Thread-Topic: [PATCH v4 06/14] hw/block/nvme: Add support for active/inactive
 namespaces
Thread-Index: AQHWkdZQA+v6X0FIe0SRVZTk+KHqRKl3tCaAgABmEIA=
Date: Thu, 24 Sep 2020 18:17:23 +0000
Message-ID: <20200924181721.GA5376@localhost.localdomain>
References: <20200923182021.3724-1-dmitry.fomichev@wdc.com>
 <20200923182021.3724-7-dmitry.fomichev@wdc.com>
 <20200924121203.GA1738917@apples.localdomain>
In-Reply-To: <20200924121203.GA1738917@apples.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: irrelevant.dk; dkim=none (message not signed)
 header.d=none;irrelevant.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.226.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0745e701-adc0-41ea-5560-08d860b615a6
x-ms-traffictypediagnostic: BN7PR04MB4178:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR04MB417874AA12B6E4E2346B7101F2390@BN7PR04MB4178.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FnhTvDoH2vWJq6Zz8uoxhRsOWZhcoTf7KhAjyVNRvKFPyGcGrIBjJysOvE8CT0c4SVKPK+lefWPIlSeWzVaa+IbPHpoLdtQ/SrWlUINE/8NAK2DodPXMe5BZd+2DqLE+byUMZ+HN5LXab+GvqtwsTi0kS5ilL/sFjdJwN5QaR54HkN0L3T+TldLBQt+ptWH1cI/rg70WdbR2IzaSbXrIrkn1y4X74zTiqYq+1C3cEOnZ5Rlspb2oe5kZvn+nZqsDAdRwf6SFhmniAUhQXpto56dbsF+O1xmJjjfxVtYPT4cGaNfrTBgkxTNJ6uC2ywsdsh01trKliStEDWoEngSrc3V/f/n8a7pPEsy7j96WWergRfeWWNG3FdJ5PTf+8T/R
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR04MB0724.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(316002)(1076003)(54906003)(86362001)(5660300002)(478600001)(71200400001)(66556008)(76116006)(66476007)(66946007)(66446008)(64756008)(91956017)(2906002)(6916009)(6486002)(26005)(4326008)(186003)(33656002)(9686003)(6506007)(6512007)(8676002)(8936002)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: hDxIXu7GFy+F2FKlGZ0tNLyNzMgqS0A2XXlOPAX90wl00V4jPujbIV1WdjONIZ1Ka+U6rUyaPMVebfl6A2rFCbtKl6n6xwJui+BThjGhhzqTAFZ8eepNSVkS9b07CAo45e/0EWBiDMtkd1qo+9YrFfta5GcTGYPCgFAwEc213WN4o0QsEZRMYz2nEy2QwqVZDdspuX3Ga6UFxzET3dB3fB5nu2aGIwzshKlr82ClcCOf1V+yfs2bjtHUUv+qljGDoLDmcn0lR2hZMUYSpmV+Xr7Q4ooVvvG8VP9G+kCMyrf6u72SKsGCMZsleWXKMLbvE/pIy9usXlDx4GwLo3joX2swh5n8NqyMCZKqTXDBNZBWTCjmBKFcNJlV3jU3Ca1iQzm/cPzvd6HGsnn1C57YDcdrKCh7ZI6dlqcwqdkuSWYGD4k4Aj/iQWe4ToL1dDxo1ErSiXyX88TQZwkxpQj0s7DCw4iVSjo5mkbR4GG8ydvQvTzbkP1uaU3xIz4sslyUx2Xgu2YsKuOH6hf0KMrCE2BGiOJ3V9eKXj34QtLm2nx+bX0di5lSuTH3hyW13KUXBSrcP9u1k9giIwnI1nBNmjZm5pHu/kkw2L/lU5mOhFaO8LIdBtg9+Q7D+DjkuLqvie2B3ILr59Lb2wAEeWNLlQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <80549F76896F17469E76D880A33B4804@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR04MB0724.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0745e701-adc0-41ea-5560-08d860b615a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2020 18:17:23.4722 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ft7RdS0YGFGKxzpf4IaTvaz6eWV/86Dkm9e9JwKV9Tw00idTRL0h9YYtuMIr/hJ/68BvX7kCYJ5QKWaVHQRyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB4178
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=5292f8049=Niklas.Cassel@wdc.com; helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 14:22:58
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
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Dmitry Fomichev <Dmitry.Fomichev@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Keith Busch <kbusch@kernel.org>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gVGh1LCBTZXAgMjQsIDIwMjAgYXQgMDI6MTI6MDNQTSArMDIwMCwgS2xhdXMgSmVuc2VuIHdy
b3RlOg0KPiBPbiBTZXAgMjQgMDM6MjAsIERtaXRyeSBGb21pY2hldiB3cm90ZToNCj4gPiBGcm9t
OiBOaWtsYXMgQ2Fzc2VsIDxuaWtsYXMuY2Fzc2VsQHdkYy5jb20+DQo+ID4gDQo+ID4gRS5nLiwg
aWYgdGhlIHVzZXIgc2V0cyBDQy5DU1MgdG8gQWRtaW4gT25seSwgTlZNIG5hbWVzcGFjZXMgc2hv
dWxkIGJlDQo+ID4gbWFya2VkIGFzIGluYWN0aXZlLg0KPiA+IA0KPiANCj4gSG1tLiBJJ20gbm90
IGNvbnZpbmNlZCB0aGF0IHRoaXMgaXMgY29ycmVjdC4gQ2FuIHlvdSByZWZlcmVuY2UgdGhlIHNw
ZWM/DQo+IA0KDQoiSWYgdGhlIHVzZXIgc2V0cyBDQy5DU1MgdG8gQWRtaW4gT25seSwgTlZNIG5h
bWVzcGFjZXMgc2hvdWxkIGJlIG1hcmtlZCBhcyBpbmFjdGl2ZS4iDQoNCkFmdGVyIHJlYWRpbmcg
dGhlIHNwZWMgc2V2ZXJhbCB0aW1lcywgSSBhZ3JlZSB0aGF0IHRoaXMgc3RhdGVtZW50IGlzIGZh
bHNlLA0KYWx0aG91Z2ggSSByZWFsbHkgd2lzaCBpdCB3YXNuJ3QgOikNCg0KDQoNCk15IGludGVy
cHJldGF0aW9uIHdhcyBiYXNlZCBvbjoNCg0KRnJvbSBDQy5DU1M6DQoiSWYgYml0IDQ0IGlzIHNl
dCB0byDigJgx4oCZIGluIHRoZSBDb21tYW5kIFNldHMgU3VwcG9ydGVkIChDU1MpIGZpZWxkLCB0
aGVuIHRoZQ0KdmFsdWUgMTExYiBpbmRpY2F0ZXMgdGhhdCBvbmx5IHRoZSBBZG1pbiBDb21tYW5k
IFNldCBpcyBzdXBwb3J0ZWQgYW5kIHRoYXQgbm8NCkkvTyBDb21tYW5kIFNldCBvciBJL08gQ29t
bWFuZCBTZXQgU3BlY2lmaWMgQWRtaW4gY29tbWFuZHMgYXJlIHN1cHBvcnRlZC4iDQoNClRoZSBO
Vk0gQ29tbWFuZCBTZXQgaXMgYSBDb21tYW5kIFNldCwgc28gSSBhc3N1bWVkIHRoYXQgc2luY2Ug
dGhlIENvbW1hbmQNClNldCB3YXMgbm90IHN1cHBvcnRlZCwgdHJ5aW5nIHRvIGRvIHNvbWV0aGlu
ZyBsaWtlIENOUyAwMGggKElkZW50aWZ5IE5hbWVzcGFjZSksDQp3b3VsZCByZXR1cm4gYW4gemVy
by1maWxsZWQgc3RydWN0LiAoU2luY2UgdGhlIG5hbWVzcGFjZSBiZWxvbmdzIHRvIGENCkNvbW1h
bmQgU2V0IHRoYXQgaXMgbm90IHN1cHBvcnRlZC4pDQoNClRvIG1lIGl0IHNlZW1zIHNpbGx5IHRo
YXQgYSBuYW1lc3BhY2UgY2FuIGJlICJhY3RpdmUiIGF0IHRoZSBzYW1lIHRpbWUNCmFzIHRoZSBD
b21tYW5kIFNldCB0aGF0IHRoZSBuYW1lc3BhY2UgYmVsb25ncyB0byBpcyBub3QgZW5hYmxlZCwN
CmJ1dCB0aGF0IHNlZW1zIGxpa2UgaG93IHRoZSBzcGVjIGlzIHdyaXR0ZW4uLi4NCg0KDQpBZGRp
dGlvbmFsbHkgaW4gVFA0MDU2IHNlY3Rpb24gNS4xOSBpdCBzYXlzOg0KIklmIGFuIGF0dGVtcHQg
aXMgbWFkZSB0byBhdHRhY2ggYSBuYW1lc3BhY2UgdG8gYSBjb250cm9sbGVyIHRoYXQgc3VwcG9y
dHMgdGhlDQpjb3JyZXNwb25kaW5nIEkvTyBDb21tYW5kIFNldCBhbmQgdGhlIGNvcnJlc3BvbmRp
bmcgSS9PIENvbW1hbmQgU2V0IGlzIG5vdA0KZW5hYmxlZCBieSB0aGUgSS9PIENvbW1hbmQgU2V0
IHByb2ZpbGUgZmVhdHVyZSwgdGhlbiB0aGUgY29tbWFuZCBzaGFsbCBiZQ0KYWJvcnRlZCB3aXRo
IGEgc3RhdHVzIG9mIEkvTyBDb21tYW5kIFNldCBOb3QgRW5hYmxlZC4iDQoNCkJ1dCBpZiB5b3Ug
YWxyZWFkeSBoYXZlIGEgZS5nLiBhIEtleSBWYWx1ZSBuYW1lc3BhY2UgYXR0YWNoZWQsIGFuZCBi
b290IHVwIHdpdGgNCmUuZy4gQ0MuQ1NTID0gTlZNLCBvciBDQy5DU1MgPSBBZG1pbiwgeW91IHdp
bGwgaGF2ZSBhIG5hbWVzcGFjZSBiZWxvbmdpbmcgdG8gYQ0KZGlzYWJsZWQgY29tbWFuZCBzZXQg
YXR0YWNoZWQgKGFuZCAiYWN0aXZlIiA6cCkuDQpCdXQgaWYgeW91IGhhdmUgbm8gbmFtZXNwYWNl
cyBhdHRhY2hlZCwgYm9vdCB1cCB3aXRoIENDLkNTUyA9IE5WTSBvcg0KQ0MuQ1NTID0gQWRtaW4s
IHlvdSB3aWxsIG5vdCBiZSBhbGxvd2VkIHRvIGF0dGFjaCB5b3VyIEtleSBWYWx1ZSBuYW1lc3Bh
Y2UuDQooNS4xOSBzYXlzIG5vdGhpbmcgYWJvdXQgQ0MuQ1NTLCBidXQgbGV0J3MgYXNzdW1lIGl0
IGlzbid0IHN1cHBvc2VkIHRvIGJlDQphbGxvd2VkLikNCldpbGwgeW91IGJlIGFsbG93ZWQgdG8g
YXR0YWNoIGEgWk5TIG5hbWVzcGFjZT8gKFNpbmNlIENDLkNTUyAhPSBBTEwgU2VsZWN0ZWQsDQpJ
IHdvdWxkIGFzc3VtZSB0aGF0IGlzIGlzIG5vdCBzdXBwb3NlZCB0byBiZSBhbGxvd2VkLikNCk5v
dywgd2lsbCB5b3UgYmUgYWxsb3dlZCB0byBhdHRhY2ggYSBOVk0gbmFtZXNwYWNlIHdoZW4gQ0Mu
Q1NTID0gQWRtaW4/DQooSSBhc3N1bWUgdGhhdCB0aGUgaW50ZW50aW9uIGlzIHRoYXQgeW91IHNo
b3VsZC4pDQoNCg0KQ0MuQ1NTIGNhbiBvbmx5IGJlIGNoYW5nZWQgd2hlbiB0aGUgY29udHJvbGxl
ciBpcyBkaXNhYmxlZC4NCkkgYXNzdW1lIHRoYXQgeW91IGNhbiBhdHRhY2ggTlZNIG5hbWVzcGFj
ZXMgZXZlbiB3aGVuIENDLkNTUyA9IEFkbWluLg0KKEF0dGFjaGluZyBuYW1lc3BhY2VzICE9IE5W
TSBpcyBwcm9iYWJseSBub3QgYWxsb3dlZCB3aGVuDQpDQy5DU1MgIT0gQUxMIFNlbGVjdGVkLikN
CkF0dGFjaGluZyBuYW1lc3BhY2VzIGFyZSBwZXJzaXN0ZW50LiBFdmVuIGlmIHlvdSByZXN0YXJ0
IHdpdGggQ0MuQ1NTID0gQWRtaW4sDQp0aGV5IHdpbGwgc3RpbGwgYmUgYXR0YWNoZWQsIGFuZCBh
Y3RpdmUuDQooQWx0aG91Z2ggeW91IG1pZ2h0IG5vdCBiZSBhYmxlIHRvIGRvIGFueXRoaW5nIHdp
dGggdGhlbS4uLiBzZWUgdGhlIG5leHQNCnNlY3Rpb24uKQ0KWW91IGNhbiBub3QgY2hhbmdlIHRv
IGEgcHJvZmlsZSAodXNpbmcgU2V0IFByb2ZpbGUpIHRoYXQgbGFja3MgYSBjb21tYW5kIHNldA0K
dGhhdCB5b3UgYXJlIGN1cnJlbnRseSB1c2luZy4gVGhpcyBjaGFuZ2UgaXMgd2hpbGUgdGhlIGNv
bnRyb2xsZXIgaXMgZW5hYmxlZCwNCnNvIEkgZ3Vlc3MgaXQgaXMgb2sgdGhhdCB0aGlzIGNoZWNr
IGlzIHN0cmljdGVyIHRoYW4gQ0MuQ1NTLg0KDQpUaGluZ3Mgd291bGQgaGF2ZSBiZWVuIHdheSBz
aW1wbGVyIGlmIHRoZSBjb250cm9sbGVyIGp1c3QgZGVhdHRhY2hlZA0Kbm9uLXN1cHBvcnRlZCBu
YW1lc3BhY2VzIGludGVybmFsbHkgYXQgcG93ZXIgb24uLi4NCg0KDQo+IE15IC9pbnRlcnByZXRh
dGlvbi8gKGJlY2F1c2UgdGhlIHNwZWMgaXMgdmFndWUgb24gdGhpcyBwb2ludCkgaXMgdGhhdA0K
PiB3aXRoIFRQIDQwNTYsIGlmIHRoZSBob3N0IHdyaXRlcyAweDAgdG8gQ0MuQ1NTLCB5b3Ugd2ls
bCAoc2hvdWxkKSBqdXN0DQo+IHNlZSBJbnZhbGlkIENvbW1hbmQgT3Bjb2RlIGZvciBuYW1lc3Bh
Y2VzIG5vdCBzdXBwb3J0aW5nIHRoZSBOVk0gY29tbWFuZA0KPiBzZXQgc2luY2Ugd2UgYXJlIG9w
ZXJhdGluZyBpbiBhIGJhY2t3YXJkIGNvbXBhdGlibGUgd2F5Lg0KDQpJZiBhIGNvbnRyb2xsZXIg
aXMgYm9vdGVkIHdpdGggQ0MuQ1NTID0gTlZNIENvbW1hbmQgU2V0Og0KDQpXZSBoYXZlIGFuIGF0
dGFjaGVkIEtleSBWYWx1ZSBuYW1lc3BhY2UuIChJdCB3aWxsIGJlIHNldCBhcyBhY3RpdmUuKQ0K
SSB0aGluayB0aGF0IHdlIGNhbiBhZ3JlZSB0aGF0IGFueSBJT0NTIEtleSBWYWx1ZSBzcGVjaWZp
YyBjb21tYW5kDQp3aWxsIGZhaWwuDQoNCldlIGhhdmUgYW4gYXR0YWNoZWQgWm9uZWQgTmFtZXNw
YWNlLiAoSXQgd2lsbCBiZSBzZXQgYXMgYWN0aXZlLikNClN1cmUsIGFueSBJT0NTIFpvbmVkIE5h
bWVzcGFjZSBDb21tYW5kIHNwZWNpZmljIGNvbW1hbmQgd2lsbCBmYWlsLg0KWW91ciBpbnRlcnBy
ZXRhdGlvbiBpcyB0aGF0IGl0IHdpbGwgYWxsb3cgTlZNIENvbW1hbmRzLCBzaW5jZSBhIFpvbmVk
IE5hbWVzcGFjZQ0KaW1wbGVtZW50cyB0aGUgb3Bjb2RlcyBvZiB0aGUgTlZNIENvbW1hbmQgU2V0
Lg0KDQpFYWNoIENvbW1hbmQgU2V0IGhhcyBhIHRhYmxlIHdpdGggdGhlIG9wY29kZXMgdGhhdCBp
dCBzdXBwb3J0cy4NCkluIGUuZy4gS2V5IFZhbHVlIENvbW1hbmQgU2V0LCBvcGNvZGUgMDFoIG1l
YW5zICJTdG9yZSBjb21tYW5kIg0KYnV0IGluIE5WTSBDb21tYW5kIFNldCwgb3Bjb2RlIDAxaCBt
ZWFucyAiV3JpdGUgY29tbWFuZCIuDQoNClRoZXNlIGNvbW1hbmRzIGFyZSB0b3RhbGx5IGRpZmZl
cmVudCwgYW5kIHVzZXMgY29tcGxldGVseSBkaWZmZXJlbnQgZHdvcmRzLg0KU28gSSBkb24ndCB0
aGluayB0aGF0IGl0IGlzIG9idmlvdXMgdGhhdCBDQy5DU1MgPSBOVk0sIHNob3VsZCBhbGxvdw0K
Ik5WTSByZXNlcnZlZCBvcGNvZGVzIiBmb3IgY2VydGFpbiBDb21tYW5kIFNldHMsIGJ1dCBub3Qg
aW4gb3RoZXJzLg0KDQpMaWtlIHNvIG1hbnkgb3RoZXIgdGhpbmdzIGluIE5WTWUsIHRoaXMgd2ls
bCBwcm9iYWJseSBiZSB2ZW5kb3Igc3BlY2lmaWMuDQpGb3IgZGV2aWNlcyBvbmx5IHN1cHBvcnRp
bmcgTlZNICsgWk5TLCBpdCB3aWxsIHByb2JhYmx5IHN1cHBvcnQgTlZNDQpDb21tYW5kIFNldCBj
b21tYW5kcyBldmVuIHdoZW4gQ0MuQ1NTID0gTlZNLCBidXQgaXQncyBwcm9iYWJseSBub3QNCnNv
bWV0aGluZyB0aGF0IGNhbiBiZSBndWFyYW50ZWUgdG8gYmUgdHJ1ZSBmb3IgYWxsIGRldmljZXMg
c3VwcG9ydGluZw0KYSBDb21tYW5kIFNldCB0aGF0IGV4dGVuZHMgdGhlIE5WTSBDb21tYW5kIFNl
dC4NCg0KDQpLaW5kIHJlZ2FyZHMsDQpOaWtsYXM=

