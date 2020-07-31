Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B06C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 21:35:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8003C208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 21:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="A168Pliv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8003C208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1cgL-0006Ru-L2
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 17:35:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robhenry@microsoft.com>)
 id 1k1cfa-000636-PY
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 17:34:27 -0400
Received: from mail-eopbgr700116.outbound.protection.outlook.com
 ([40.107.70.116]:31467 helo=NAM04-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robhenry@microsoft.com>)
 id 1k1cfW-0004JW-Qq
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 17:34:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDGBGESxzRKev96zpE4qQYxxy8L3JCrSNQ1a78NAo3YvbEJR4tMi1jODjYE7NvwnLrEuny9evf6L/fU09MBp5RRLbhTvYgccxQ1tIZPOxYnwrjskQ9mniX6NJ/iBuK+oZwR5vynwSCkJM1SB9swkoXbzWeTLe1wQ9+OlzTCIMcBPA30eSB645JZ8PF5nMssvZx0nLho1xhtMBCVCLr/lutvIMDtn7Esb+kqby9gm3UVKaB2GyjKc4byJlO8pCHrxYkt7GXBKTbuDBLimvftMlpI/bpMo+iTRftYXH5B5LUGoXE+zvsOiWjyyZyH0W/Mam6RykxqqcHnk1IVTtUgEKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDD4EOIRCII2IXSUBR/t64WKyQq2q+OtNBwH6k1lAuA=;
 b=QpR49JQo5zcesmC10UMmKQeph1Te3g3Zs/fugUOn3uXcUdvXCbIgBQpLQYmWYrXATnYPuJpgpSTAq8mVbCjj/Qc9sFjahPb4Wcxn0NgGMzAoT+uXOBBsJIT7wE3M7+T19uXlJYJPgnXKsjHPKzDBfQrWm4YfJVicBF+BJq2zcU0t1guNcCvLzqfscKJqdSfv2nGfPCldxfN0PcwYOdulO2LCIZfQ/kTNHWESxnR1et30+xc11S/5qcKDR5Pc0qogX0CKC+jsRD8PfdfyOr69hj8m163qHt18J89vLleOwxxd2EoWGHeev9elix2zsYPIkn2mzfpjCelV5/2TtPUVVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDD4EOIRCII2IXSUBR/t64WKyQq2q+OtNBwH6k1lAuA=;
 b=A168PlivMJkIswLxJXUQq4CSOtAWLHH44rFlEnM9yQVXLwOvQna5FxssIBjP8iHonsO1qMkUiyWrZU5aYYuP102u3GVEa3oSDtHTAs2oQ7HTpcROfPhWGfE2+p3mn7fSSQNGssaJCwSp/9hSA4RrgFK7bvrvZF3EcfCwu2dl0L4=
Received: from BL0PR2101MB1026.namprd21.prod.outlook.com
 (2603:10b6:207:30::21) by BL0PR2101MB0882.namprd21.prod.outlook.com
 (2603:10b6:207:36::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.0; Fri, 31 Jul
 2020 21:19:17 +0000
Received: from BL0PR2101MB1026.namprd21.prod.outlook.com
 ([fe80::dc74:bdf2:aece:7e88]) by BL0PR2101MB1026.namprd21.prod.outlook.com
 ([fe80::dc74:bdf2:aece:7e88%8]) with mapi id 15.20.3261.009; Fri, 31 Jul 2020
 21:19:11 +0000
From: Robert Henry <robhenry@microsoft.com>
To: Eduardo Habkost <ehabkost@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Subject: Re: [EXTERNAL] Re: ia-32/ia-64 fxsave64 instruction behavior when
 saving mmx
Thread-Topic: [EXTERNAL] Re: ia-32/ia-64 fxsave64 instruction behavior when
 saving mmx
Thread-Index: AQHWNd5quifUeAt/N0utXBrhr3uc7ajC2MGjgAB00oCAXzqogIAADH4A
Date: Fri, 31 Jul 2020 21:19:11 +0000
Message-ID: <55c2399f-57b7-f5ef-eccb-f0fc8c283151@microsoft.com>
References: <BL0PR2101MB1026B7400F5A568C9D5FC9DBD68F0@BL0PR2101MB1026.namprd21.prod.outlook.com>
 <BL0PR2101MB1026CD468E4F0929086C177FD68D0@BL0PR2101MB1026.namprd21.prod.outlook.com>
 <0670bf89-5b16-3a58-ef2f-d063ee9d5a5e@redhat.com>
 <20200731203427.GJ225270@habkost.net>
In-Reply-To: <20200731203427.GJ225270@habkost.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [97.113.149.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8d8b11cc-1a1d-47f1-f9ac-08d835975e54
x-ms-traffictypediagnostic: BL0PR2101MB0882:
x-microsoft-antispam-prvs: <BL0PR2101MB08828E23D6DE7811BF4D4978D64E0@BL0PR2101MB0882.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yx2py2r/mbgZGfvbydzhGyNSXUvINCqhKjqrEIY87gP+rJEq0ELwo0q23SQOmQjs/G8y0bd4bjmedLfJC+uNYB8pGr4OpMVbmZ4ZZuWg9OgzO7pQ5mfM2Y6pZLhZTsflvGun2ND3UVd13517e0rOc8cYb2gOEMT/NSXTwCACd4H80T3UwTU06nqTreULgoMsv9OwC1bUzlupWrzFWAjocnYBpFjrmIrO2lN0sV4SPyyDQpEq5eF9K1S9dUJ3GTp4o/oYWr3UXnFj8LPJZaNzKkV/hSpDZlr1SFrLaQ5g+MYAunjXHzdxdy7iKRRLGDi6M12LKgGm+9DbC3Q1tzO9fvSC9lsuTEt+sfrBegkT2cPuU/pZCGYPrVwmYVu7KT0+P2zKvWnZqDEWZ+Ani8gfa/vL+MAO+fzjRIs8I3MN6ihdVRn/XOHcpuplpRTyYLjEEzfN/g8ly7IWk9WgTqYyRQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR2101MB1026.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(39860400002)(346002)(366004)(136003)(2616005)(26005)(2906002)(186003)(10290500003)(6512007)(66446008)(31696002)(8676002)(8936002)(966005)(36756003)(66476007)(76116006)(91956017)(86362001)(5660300002)(4326008)(64756008)(66556008)(6486002)(66946007)(110136005)(316002)(31686004)(6506007)(82960400001)(478600001)(82950400001)(54906003)(83380400001)(71200400001)(53546011)(43740500002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: kaob1QcAbGHLRvhfAIoArRJp5fFzHXx/HsNTENPQwI2pdIgUz05eTdpdV9F/nDicNR0nPxsG4quG3X62qzoMTVN9621nT60nDtdRyRSd1iRXwSIESDtix/G3Ghk0hgQQyMdXMayf7p2oggft/3BjvE1GfgyRh+6jfVBNytS2exmp2zSRKQlW9uAf9P34bvO76qY6gV/PdI2oAQbyLODnqT5PTCFE/kKnqwjmEVP6d10ijOLWLV1lQlRot/hlcoXCf7YKrNNXMDAi3+zDieE2EGYWcI7aQNoeR486ya4K5lweEJcr61xeKKAJlcx6QGcN5p/Nuemvubm5eA5w8p9QTCe9GyMhr0YEX2qwa/Q6gfH2qNMIK+N8gw3o4Spt5wcWUTBFNBT/vT4dIhAv2N7fAxwPHsWNKQw9uJ0Y9o93ie4Pgiosp1WLlEoPTL1zT4uxMH5nFVu/yZJQLbwWGCqWUlW+wnZy/rVI/45xoRdo4yb4jhWp12b4kDpUrPoULFQZ6A1ZhLpBZdIAruzSjUbqCmovPFm5BzKW97mn2zDgSkeUxISGEvF8WPv2vGrZ31pXMKBn2ZiQCD7+RHV3NdsDp1QNs1IzK4MXYH3AeTTNXTI+jCf28eQbY/WO3yAWndhQc3Af9UjsUCVtK/X0UWFuXQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F1A4DD60DFFE4049A21122AAFA3CCB26@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1026.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d8b11cc-1a1d-47f1-f9ac-08d835975e54
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2020 21:19:11.1456 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OwQPsTdXW4PoJHHyGVXSc1xhTU3chRSuyk2ZpkBGo6jD77CTguw0zFjj518VPcZEFFTJ80zYaQ4isWo+WRQrAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0882
Received-SPF: pass client-ip=40.107.70.116;
 envelope-from=robhenry@microsoft.com;
 helo=NAM04-SN1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 17:34:21
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

T24gNy8zMS8yMCAxOjM0IFBNLCBFZHVhcmRvIEhhYmtvc3Qgd3JvdGU6DQo+IE9uIE1vbiwgSnVu
IDAxLCAyMDIwIGF0IDA4OjE5OjUxQU0gKzAyMDAsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMODwqkg
d3JvdGU6DQo+PiBIaSBSb2JlcnQuDQo+Pg0KPj4gVG9wLXBvc3RpbmcgaXMgZGlmZmljdWx0IHRv
IHJlYWQgb24gdGVjaG5pY2FsIGxpc3RzLA0KPj4gaXQncyBiZXR0ZXIgdG8gcmVwbHkgaW5saW5l
Lg0KPj4NCj4+IENjJ2luZyB0aGUgWDg2IEZQVSBtYWludGFpbmVyczoNCj4+DQo+PiAuL3Njcmlw
dHMvZ2V0X21haW50YWluZXIucGwgLWYgdGFyZ2V0L2kzODYvZnB1X2hlbHBlci5jDQo+PiBQYW9s
byBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPiAobWFpbnRhaW5lcjpYODYgVENHIENQVXMp
DQo+PiBSaWNoYXJkIEhlbmRlcnNvbiA8cnRoQHR3aWRkbGUubmV0PiAobWFpbnRhaW5lcjpYODYg
VENHIENQVXMpDQo+PiBFZHVhcmRvIEhhYmtvc3QgPGVoYWJrb3N0QHJlZGhhdC5jb20+IChtYWlu
dGFpbmVyOlg4NiBUQ0cgQ1BVcykNCj4+DQo+PiBPbiA2LzEvMjAgMToyMiBBTSwgUm9iZXJ0IEhl
bnJ5IHdyb3RlOg0KPj4+IEhlcmUncyBhZGRpdGlvbmFsIGluZm9ybWF0aW9uLg0KPj4+DQo+Pj4g
QWxsIG9mIHRoZSByZW1pbGwgdGVzdHMgb2YgdGhlIGxlZ2FjeSBNTVggaW5zdHJ1Y3Rpb25zIGZh
aWwuIFRoZXNlDQo+Pj4gaW5zdHJ1Y3Rpb25zIHdvcmsgb24gNjQtYml0IHJlZ2lzdGVycyBhbGlh
c2VkIHdpdGggdGhlIGxvd2VyIDY0LWJpdHMgb2YNCj4+PiB0aGUgeDg3IGZwODAgcmVnaXN0ZXJz
LiDDgyzDgsKgVGhlIHRlc3RzIGZhaWwgYmVjYXVzZSByZW1pbGwgZXhwZWN0cyB0aGUNCj4+PiBm
eHNhdmU2NCBpbnN0cnVjdGlvbiB0byBkZWxpdmVyIDE2IGJpdHMgb2YgMSdzIChpbmZpbml0eSBv
ciBuYW4gcHJlZml4KQ0KPj4+IGluIHRoZSBmcDgwIGV4cG9uZW50LCBlZyBiaXRzIDc5OjY0LiDD
gyzDgsKgTWV0YWwgZG9lcyB0aGlzLCBidXQgUUVNVSBkb2VzIG5vdC4NCj4+IE1ldGFsIGlzIHdo
YXQgbWF0dGVycywgUUVNVSBzaG91bGQgZW11bGF0ZSBpdCB3aGVuIHBvc3NpYmxlLg0KPj4NCj4+
PiBSZWFkaW5nIG9mIEludGVsIFNvZnR3YXJlIGRldmVsb3BtZW50IG1hbnVhbCwgdGFibGUgMy40
NA0KPj4+IChodHRwczovL25hbTA2LnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91
cmw9aHR0cHMlM0ElMkYlMkZ3d3cuZmVsaXhjbG91dGllci5jb20lMkZ4ODYlMkZGWFNBVkUuaHRt
bCUyM3RibC0zLTQ0JmFtcDtkYXRhPTAyJTdDMDElN0Nyb2JoZW5yeSU0MG1pY3Jvc29mdC5jb20l
N0M1NmI4NWM4NGI3MjM0ZjE2ZjA3YzA4ZDgzNTkxMjViZCU3QzcyZjk4OGJmODZmMTQxYWY5MWFi
MmQ3Y2QwMTFkYjQ3JTdDMSU3QzAlN0M2MzczMTgyNDUzOTAyNDk1NTEmYW1wO3NkYXRhPThDRlVO
ZSUyRiUyQmJMeXVreVY2Qm1tVEJGeW9WJTJCM3BURmglMkJnNVFBczNjY0xiYyUzRCZhbXA7cmVz
ZXJ2ZWQ9MCkgc2F5cyB0aGVzZSAxNg0KPj4+IGJpdHMgYXJlIHJlc2VydmVkLCBidXQgYW5vdGhl
ciB2ZXJzaW9uIG9mIHRoZSBtYW51YWwNCj4+PiAoaHR0cHM6Ly9uYW0wNi5zYWZlbGlua3MucHJv
dGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHAlM0ElMkYlMkZtYXRoLWF0bGFzLnNvdXJjZWZv
cmdlLm5ldCUyRmRldmVsJTJGYXJjaCUyRmlhMzJfYXJjaC5wZGYmYW1wO2RhdGE9MDIlN0MwMSU3
Q3JvYmhlbnJ5JTQwbWljcm9zb2Z0LmNvbSU3QzU2Yjg1Yzg0YjcyMzRmMTZmMDdjMDhkODM1OTEy
NWJkJTdDNzJmOTg4YmY4NmYxNDFhZjkxYWIyZDdjZDAxMWRiNDclN0MxJTdDMCU3QzYzNzMxODI0
NTM5MDI0OTU1MSZhbXA7c2RhdGE9MlNpS3UxY3g0U1Zod3p6U2JqN2hneiUyQjhJQ0NaSERudTBu
cFVzOXlNSkxBJTNEJmFtcDtyZXNlcnZlZD0wKSBzZWN0aW9uDQo+Pj4gOS42LjIgIlRyYW5zaXRp
b25zIGJldHdlZW4geDg3IGZwdSBhbmQgbW14IGNvZGUiIHNheXMgYSB3cml0ZSB0byBhbiBNTVgN
Cj4+PiByZWdpc3RlciBzZXRzIHRob3NlIDE2IGJpdHMgdG8gYWxsIDFzLg0KPj4gWW91IGFyZSBb
MV0gaGVyZSBhbnN3ZXJpbmcgWzJdIHlvdSBhc2tlZCBiZWxvdy4NCj4+DQo+Pj4gSW4gZGlnZ2lu
ZyB0aHJvdWdoIHRoZSBjb2RlIGZvciB0aGUgaW1wbGVtZW50YXRpb24gb2YgdGhlIFNTRS9tbXgN
Cj4+PiBpbnN0cnVjdGlvbiBwYXZnYiBJIHNlZSBhIG5pY2UgY2xlYW4gaW1wbGVtZW50YXRpb24g
aW4gdGhlIFNTRV9IRUxQRVJfQg0KPj4+IG1hY3JvIHdoaWNoIHRha2VzIGEgTU1YUkVHIHdoaWNo
IGlzIGFuIE1NUkVHX1VOSU9OIHdoaWNoIGRvZXMgbm90DQo+Pj4gcHJvdmlkZSwgdG8gdGhlIGV4
dGVudCB0aGF0IEkgY2FuIGZpZ3VyZSB0aGlzIG91dCwgYSBoYW5kbGUgdG8gYml0cw0KPj4+IDc5
OjY0IG9mIHRoZSBhbGlhc2VkLXdpdGggeDg3IHJlZ2lzdGVyLg0KPj4+DQo+Pj4gSSBmaW5kIGl0
IGhhcmQgdG8gYmVsaWV2ZSB0aGF0IGFuIGFwcGFyZW50IGJ1ZyBsaWtlIHRoaXMgaGFzIGJlZW4g
aGVyZQ0KPj4+ICJmb3JldmVyIi4gQW0gSSBtaXNzaW5nIHNvbWV0aGluZz8NCj4+IExpa2VseSB0
aGUgZGV2ZWxvcGVyIHdobyBpbXBsZW1lbnRlZCB0aGlzIGNvZGUgZGlkbid0IGhhdmUgYWxsIHRo
ZQ0KPj4gaW5mb3JtYXRpb24geW91IGZvdW5kLCBub3IgdGhlIHRlc3Qtc3VpdGUsIGFuZCBldmVu
dHVhbGx5IG5vdCBldmVuIHRoZQ0KPj4gaGFyZHdhcmUgdG8gY29tcGFyZS4NCj4+DQo+PiBTaW5j
ZSB5b3UgaGF2ZSBhIGdvb2QgdW5kZXJzdGFuZGluZyBvZiBJbnRlbCBGUFUgYW5kIGhhcmR3YXJl
IHRvDQo+PiBjb21wYXJlLCBkbyB5b3UgbWluZCBzZW5kaW5nIGEgcGF0Y2ggdG8gaGF2ZSBRRU1V
IGVtdWxhdGUgdGhlIGNvcnJlY3QNCj4+IGhhcmR3YXJlIGJlaGF2aW9yPw0KPj4NCj4+IElmIHBv
c3NpYmxlIGFkZCBhIHRlc3QgY2FzZSB0byB0ZXN0cy90Y2cvaTM4Ni90ZXN0LWkzODYuYyAoc2Vl
DQo+PiB0ZXN0X2Z4c2F2ZSB0aGVyZSkuDQo+IFdhcyB0aGlzIGlzc3VlIGFkZHJlc3NlZCwgb3Ig
ZG9lcyBpdCByZW1haW4gdW5maXhlZD8gIEkgcmVtZW1iZXINCj4gc2VlaW5nIHg4NiBGUFUgcGF0
Y2hlcyBtZXJnZWQgcmVjZW50bHksIGJ1dCBJIGRvbid0IGtub3cgaWYgdGhleQ0KPiB3ZXJlIHJl
bGF0ZWQgdG8gdGhpcy4NCj4NCkkgaGF2ZW4ndCBkb25lIGFueXRoaW5nIHRvIGFkZHJlc3MgdGhp
cyBpc3N1ZS4NCj4+PiBSb2JlcnQgSGVucnkNCj4+PiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+PiAqRnJv
bToqIFJvYmVydCBIZW5yeQ0KPj4+ICpTZW50OiogRnJpZGF5LCBNYXkgMjksIDIwMjAgMTA6Mzgg
QU0NCj4+PiAqVG86KiBxZW11LWRldmVsQG5vbmdudS5vcmcgPHFlbXUtZGV2ZWxAbm9uZ251Lm9y
Zz4NCj4+PiAqU3ViamVjdDoqIGlhLTMyL2lhLTY0IGZ4c2F2ZTY0IGluc3RydWN0aW9uIGJlaGF2
aW9yIHdoZW4gc2F2aW5nIG1teA0KPj4+IMODLMOCDQo+Pj4gQmFja2dyb3VuZDogVGhlIGlhLTMy
L2lhLTY0IGZ4c2F2ZTY0IGluc3RydWN0aW9uIHNhdmVzIGZwODAgb3IgbGVnYWN5DQo+Pj4gU1NF
IG1teCByZWdpc3RlcnMuIFRoZSBtbXggcmVnaXN0ZXJzIGFyZSBzYXZlZCBhcyBpZiB0aGV5IHdl
cmUgZnA4MA0KPj4+IHZhbHVlcy4gVGhlIGxvd2VyIDY0IGJpdHMgb2YgdGhlIGNvbnN0cnVjdGVk
IGZwODAgdmFsdWUgaXMgdGhlIG1teA0KPj4+IHJlZ2lzdGVyLsODLMOCwqAgVGhlIHVwcGVyIDE2
IGJpdHMgb2YgdGhlIGNvbnN0cnVjdGVkIGZwODAgdmFsdWUgYXJlIHJlc2VydmVkOw0KPj4+IHNl
ZSB0aGUgbGFzdCByb3cgb2YgdGFibGUgMy00NA0KPj4+IG9mw4Msw4LCoGh0dHBzOi8vbmFtMDYu
c2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRnd3dy5m
ZWxpeGNsb3V0aWVyLmNvbSUyRng4NiUyRmZ4c2F2ZSUyM3RibC0zLTQ0JmFtcDtkYXRhPTAyJTdD
MDElN0Nyb2JoZW5yeSU0MG1pY3Jvc29mdC5jb20lN0M1NmI4NWM4NGI3MjM0ZjE2ZjA3YzA4ZDgz
NTkxMjViZCU3QzcyZjk4OGJmODZmMTQxYWY5MWFiMmQ3Y2QwMTFkYjQ3JTdDMSU3QzAlN0M2Mzcz
MTgyNDUzOTAyNDk1NTEmYW1wO3NkYXRhPTBDQkUlMkJ0bm0yYiUyRkp1OUZqTkhIanVoNXZyWUoy
TVRma2l0TUFweFhSU1pRJTNEJmFtcDtyZXNlcnZlZD0wDQo+Pj4NCj4+PiBUaGUgSW50ZWwgY29y
ZSBpOS05OTgwWEUgU2t5bGFrZSBtZXRhbCBJIGhhdmUgcHV0cyAweGZmZmYgaW50byB0aGVzZQ0K
Pj4+IHJlc2VydmVkIDE2IGJpdHMgd2hlbiBzYXZpbmcgTU1YLg0KPj4+DQo+Pj4gUUVNVSBhcHBl
YXJzIHRvIHB1dCAwJ3MgdGhlcmUuDQo+Pj4NCj4+PiBEb2VzIGFueWJvZHkgaGF2ZSBpbnNpZ2h0
IGFzIHRvIHdoYXQgInJlc2VydmVkIiByZWFsbHkgbWVhbnMsIG9yIG11c3QNCj4+PiBiZSwgaW4g
dGhpcyBjYXNlPw0KPj4gWW91IHNlbGYtYW5zd2VyZWQgdG8gdGhpcyBbMl0gaW4gWzFdIGVhcmxp
ZXIuDQo+Pg0KPj4+IEkgdGFrZSB0aGUgdmVyYiAicmVzZXJ2ZWQiIHRvIG1lYW4gc29tZXRoaW5n
IG90aGVyDQo+Pj4gdGhhbiAidW5kZWZpbmVkIi4NCj4+Pg0KPj4+IEkgY2FtZSBhY3Jvc3MgdGhp
cyBpc3N1ZSB3aGVuIHJ1bm5pbmcgdGhlIHJlbWlsbCBpbnN0cnVjdGlvbiB0ZXN0DQo+Pj4gZW5n
aW5lLsODLMOCwqAgU2VlIG15DQo+Pj4gaXNzdWXDgyzDgsKgaHR0cHM6Ly9uYW0wNi5zYWZlbGlu
a3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGZ2l0aHViLmNvbSUy
RmxpZnRpbmctYml0cyUyRnJlbWlsbCUyRmlzc3VlcyUyRjQyMyUyNUMzJTI1ODMmYW1wO2RhdGE9
MDIlN0MwMSU3Q3JvYmhlbnJ5JTQwbWljcm9zb2Z0LmNvbSU3QzU2Yjg1Yzg0YjcyMzRmMTZmMDdj
MDhkODM1OTEyNWJkJTdDNzJmOTg4YmY4NmYxNDFhZjkxYWIyZDdjZDAxMWRiNDclN0MxJTdDMCU3
QzYzNzMxODI0NTM5MDI0OTU1MSZhbXA7c2RhdGE9QmpXN2dacGxxb1VsS2RwT1Q3ZFJuQ3ZselRy
QzRWZ3B5JTJCRmY4Yk5wVDBrJTNEJmFtcDtyZXNlcnZlZD0wLMOCwqBGb3IgYmV0dGVyIG9yDQo+
Pj4gd29yc2UsIHJlbWlsbCBhc3N1bWVzIHRoYXQgdGhvc2UgYml0cyBhcmUgMHhmZmZmLCBub3Qg
MHgwMDAwDQo+Pj4NCj4+IFJlZ2FyZHMsDQo+Pg0KPj4gUGhpbC4NCj4+DQoNCg==

