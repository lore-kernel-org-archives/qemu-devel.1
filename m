Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17A4C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 20:25:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9C602053B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 20:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="izPmUDPB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9C602053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0sdn-0008DH-RM
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 16:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilmut@microsoft.com>)
 id 1k0scm-0007f1-Mt
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 16:24:28 -0400
Received: from mail-mw2nam10on2118.outbound.protection.outlook.com
 ([40.107.94.118]:34619 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilmut@microsoft.com>)
 id 1k0sck-00030K-GI
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 16:24:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jIPQ5IYDSG9IY3rAu351x3iLHQhbTuzsF20dxFgPqy+Ehgc8yXkpHIugozPEx4zgnkzXPF5l9Sh1ibIixcDhdgz5TFlAxkCzJWPpJ6gAH7qiOwS5FUt+H9QRHyvBtdEMLSHC9xXsIw7LTPTLPA5hnExNKzzXrqj/ecOBb3GdMH8ObYkmzp4SpIeqbcSCt06sGX2Nnh5yHR4P1vg6HPC0LA+NxRwhVGVQN8ydbAN3jIhsavYT7z2lB/1voiT/NJorEcNEdKxyzYNuiU7yf6c7iTz/tWs7K049Av94ha5Hp5pOaSApW0924sjg6ORIc9OKwAHFwuKFTTm4kF8fyKfT0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAJqDMu2K6jd0kl45NlPE0dAJVwf809BZTgG914uYjo=;
 b=KAh9/Qjn3d2ZaMazOcq8dIKWClsZbrVUCAWB5xA4PemA/Qmi9zj/53OmDrFb1G/LMyssL7Bp7QMa/7J0L844+uAKhy9b0dFttZ+x11Ui5EAbgyNq+tbfUvAJdWywTMRe2PJc5QMn2s5Cq/4dnEG7tn5uGRGXkBSrWl7tR4ldGFN1cAjAsKJd3oJFzCGgOSNHl7TbtlPvg0glhJ9Q0x40WvYwwwmG/bp8n/pmpTdfL+RmHF9cs69IaSxO8OozCvbMr12uzWYatOgBvUtqw88v3LOFYUUDFOSfTGILQ8RPhugcEtK4iGgwGIY0n79MkaCdmdRekmly4IVZMq8QIB312A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAJqDMu2K6jd0kl45NlPE0dAJVwf809BZTgG914uYjo=;
 b=izPmUDPB9ssZvtPl3zUJQmxtkMI7vV1vCXXKXUYsxZw/v/Wr1CYUmcPYA0W2F9ls4ThDsw6TktPPMHnzi39y4mSPE5SjYKolNor7f7njCfEYFTPHqDmCXJkTdas/RiIFk2/DGTt3tFzVYWqflzScicz0XIX8XbyRYwGg12sEQ5k=
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 (2603:10b6:803:51::33) by SN6PR2101MB1102.namprd21.prod.outlook.com
 (2603:10b6:805:6::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.5; Wed, 29 Jul
 2020 20:24:22 +0000
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::99a:30fe:609e:be35]) by SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::99a:30fe:609e:be35%8]) with mapi id 15.20.3239.016; Wed, 29 Jul 2020
 20:24:22 +0000
From: Sunil Muthuswamy <sunilmut@microsoft.com>
To: Eric Blake <eblake@redhat.com>, Paolo Bonzini <bonzini@gnu.org>, Peter
 Maydell <peter.maydell@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [EXTERNAL] Re: qemu repo lockdown message for a WHPX PR
Thread-Topic: [EXTERNAL] Re: qemu repo lockdown message for a WHPX PR
Thread-Index: AdZlFApWhEK0UloZS9GdU/X2cvsH+AAz1PVgAACF4IAAACb7cA==
Date: Wed, 29 Jul 2020 20:24:22 +0000
Message-ID: <SN4PR2101MB08807B47F07C6D622224ADA7C0700@SN4PR2101MB0880.namprd21.prod.outlook.com>
References: <SN4PR2101MB08805B8E85196354ACA49B54C0730@SN4PR2101MB0880.namprd21.prod.outlook.com>
 <SN4PR2101MB088065186D10AC74BE9721BDC0700@SN4PR2101MB0880.namprd21.prod.outlook.com>
 <4164d89a-9009-2ee3-3dc4-da3edeff4ab7@redhat.com>
In-Reply-To: <4164d89a-9009-2ee3-3dc4-da3edeff4ab7@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [2601:602:9400:570:c5c8:1863:df3a:3ff6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dfccabd0-135e-4543-b489-08d833fd6111
x-ms-traffictypediagnostic: SN6PR2101MB1102:
x-microsoft-antispam-prvs: <SN6PR2101MB1102F301A65534F02FED90F0C0700@SN6PR2101MB1102.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oMvjWgdbjTkOBBscDEOD/Q+pcfv/ikRgqNS4QR6snhKo98ATiSIcHYjlZu4pGFtgKZ6STJoYnYKaHxh/HgUt1WcF/d+IUaAU4b3Q4Ush8AIZqta1AIzX3L4jC7Si8ucg9TWOGwX6v5LdPKVeLCWPJsARCd2/UrChOFTHZPyWCz98ye9rufZMHFIMgKcU+Nw89TyT5CMgLOMfs2x2gb0YkiKGFWT9ONBzuYqH96Nbz/jisDDWPUjyBFTRK6J5jWbqPjtoSoCU5sHSvfpcQJN3xkUKnJBdq055KCp8G37zK2vdb3rmaDevB8efSQ9ii44qkHP2NUPFmu/JI5Ap7fzMIZRW60zpBgYKcYPitaTJFlt0L3sv2rc0zo5IrJTzPZXUB3aHqDQ6NTbXYAJXLGXD6w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN4PR2101MB0880.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(39860400002)(366004)(136003)(376002)(15650500001)(2906002)(7696005)(86362001)(110136005)(8990500004)(53546011)(83380400001)(4326008)(71200400001)(5660300002)(64756008)(316002)(82950400001)(66946007)(6506007)(55016002)(8676002)(10290500003)(66476007)(66446008)(8936002)(33656002)(66556008)(478600001)(82960400001)(9686003)(186003)(76116006)(966005)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: IIknoum6a/HNKBROFF1npMZ+lyVf0vZNKEyDeDqFB3rh3TvnADg/7eP2iesNb9e21WA+Yi4vPrp5TLQcAl7zXH5AdIrg62bp1j+hJsweBaa6u74aCGQyg56dVtAax9LvhsYQbOIbRpTe0H2tNWPEfgWYkW05qEFeMzCI4gfRFqrXyN2/prf8013WKGl77BszK8uOSCyOQyqzBi9HcC7azBD2HSVc7ZGUqYgsKFm/YIPr2B5K+ndSCPhW2HReLMDciFLTQPvonqKBr704RRCMkrc7al7l+fh5baYczkVb4G4yjHDKNUZpBLr+IxNOcFe12qW6ubpl/8k/b7OWKNMuGfIdOTDN6J7cn/63NHeXjNxaM5uP2vo5YXuc2DqlZy4IfehihFplNrVnX1GYqHtjViebyhv1pAmPAXhNcLnH0+889Y7AyMMl5tGutUwFs7A/V3OgK8tJtXuGYd79JVek+ERMjWKXLDeI5X/Lb22roc6PusFI/s3E12LiSWzeskB74FhdSkgj2myDMHuJ9/90g4/Aj2EwATPsK5s+GiHX3xnWgoz6DgqndbNEbg/b8tlxsWpbZrK19IM2wi6m1DC1OU4Rwvdm9bMtwLHp2uNanDK3KnO1THF9smONhKXGssUETmJ5ESnwqeyLQfHYZhf7LwY1FgZ/KFkuO4Dk6CO8JW0scqv256Um8sYnmPoMxPdxdTex+bLyK+po75gSQbOJig==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR2101MB0880.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfccabd0-135e-4543-b489-08d833fd6111
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2020 20:24:22.0278 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w0jKshVmc4hBBWWsox3LRXy1H187vg7y/0pKFz8rttpe0QyBBcaM07qHJoqYu2eeOMslMoMWDb9DZyOukh/GSLi7G+02p6wYCOvLsX6/DEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1102
Received-SPF: pass client-ip=40.107.94.118;
 envelope-from=sunilmut@microsoft.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 16:24:23
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
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

Tm8sIEkgYW0gdHJ5aW5nIHRvIHN1Ym1pdCBhIHB1bGwgcmVxdWVzdCBhcyBzdWdnZXN0ZWQgYnkg
UGFvbG8gaW4gdGhpcyBwb3N0Og0KaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0
L3FlbXUtZGV2ZWwvcGF0Y2gvU040UFIyMTAxTUIwODgwNEQyMzQzOTE2NkU4MUZGMTUxRjdDMEVB
MEBTTjRQUjIxMDFNQjA4ODAubmFtcHJkMjEucHJvZC5vdXRsb29rLmNvbS8jMjM3MzgyOQ0KDQo+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEVyaWMgQmxha2UgPGVibGFrZUBy
ZWRoYXQuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEp1bHkgMjksIDIwMjAgMToxOSBQTQ0KPiBU
bzogU3VuaWwgTXV0aHVzd2FteSA8c3VuaWxtdXRAbWljcm9zb2Z0LmNvbT47IFBhb2xvIEJvbnpp
bmkgPGJvbnppbmlAZ251Lm9yZz47IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJv
Lm9yZz4NCj4gQ2M6IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBTdWJqZWN0OiBbRVhURVJOQUxd
IFJlOiBxZW11IHJlcG8gbG9ja2Rvd24gbWVzc2FnZSBmb3IgYSBXSFBYIFBSDQo+IA0KPiBPbiA3
LzI5LzIwIDM6MDUgUE0sIFN1bmlsIE11dGh1c3dhbXkgd3JvdGU6DQo+ID4gQWRkaW5nIFBldGVy
IE1heWRlbGwgYXMgd2VsbC4NCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiA+PiBGcm9tOiBTdW5pbCBNdXRodXN3YW15DQo+ID4+IFNlbnQ6IFR1ZXNkYXksIEp1bHkgMjgs
IDIwMjAgMTI6MjAgUE0NCj4gPj4gVG86IFBhb2xvIEJvbnppbmkgPGJvbnppbmlAZ251Lm9yZz4N
Cj4gPj4gQ2M6IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiA+PiBTdWJqZWN0OiBxZW11IHJlcG8g
bG9ja2Rvd24gbWVzc2FnZSBmb3IgYSBXSFBYIFBSDQo+ID4+DQo+ID4+IEhleSBQYW9sbywNCj4g
Pj4NCj4gPj4gRm9sbG93aW5nIHlvdXIgc3VnZ2VzdGlvbiBvZiBjcmVhdGluZyBQUnMgZm9yIFdI
UFggY2hhbmdlcywgSSB0cmllZCBjcmVhdGluZyBhIFBSDQo+IGh0dHBzOi8vbmFtMDYuc2FmZWxp
bmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmdpdGh1Yi5jb20l
MkZxZW11JTJGcWVtdSUyRnB1bGwlMkY5NSZhbXA7ZGF0YT0NCj4gMDIlN0MwMSU3Q3N1bmlsbXV0
JTQwbWljcm9zb2Z0LmNvbSU3QzNlY2U1MmMyODYxYzQ4YzViMmRjMDhkODMzZmM5Y2ZiJTdDNzJm
OTg4YmY4NmYxNDFhZjkxYWIyZDdjZDAxMWRiNDclN0MNCj4gMSU3QzAlN0M2MzczMTY1MDczNDQy
OTgzMDgmYW1wO3NkYXRhPU1ER0slMkZYMzdqNVFoJTJGJTJGRG9xTW1taWlxWm1QdlhzMzRZSFBr
b2pyTnlIUkElM0QmYW1wO3Jlc2Vydg0KPiBlZD0wDQo+ID4+DQo+ID4+IEJ1dCwgSSBhbSBnZXR0
aW5nIHJlcG8tbG9ja2Rvd24gbWVzc2FnZS4gV2hhdCBkbyBJIG5lZWQgdG8gZG8gZGlmZmVyZW50
bHk/DQo+IA0KPiBBcmUgeW91IHRyeWluZyB0byBzdWJtaXQgYSBwYXRjaD8gIElmIHNvLCB3ZSBw
cmVmZXIgc3VibWlzc2lvbnMgdG8gdGhlDQo+IG1haWxpbmcgbGlzdCByYXRoZXIgdGhhbiB2aWEg
Z2l0aHViIHB1bGwgcmVxdWVzdHM6DQo+IA0KPiBodHRwczovL25hbTA2LnNhZmVsaW5rcy5wcm90
ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZ3aWtpLnFlbXUub3JnJTJGQ29u
dHJpYnV0ZSUyRlN1Ym1pdEFQYXRjaCZhbXA7ZGF0YQ0KPiA9MDIlN0MwMSU3Q3N1bmlsbXV0JTQw
bWljcm9zb2Z0LmNvbSU3QzNlY2U1MmMyODYxYzQ4YzViMmRjMDhkODMzZmM5Y2ZiJTdDNzJmOTg4
YmY4NmYxNDFhZjkxYWIyZDdjZDAxMWRiNDclNw0KPiBDMSU3QzAlN0M2MzczMTY1MDczNDQyOTgz
MDgmYW1wO3NkYXRhPVdwMHlmcGNMSCUyRkY4JTJGJTJCR0FSUVN3RmIzWnhsWVN1bzVTVlVNcGxt
VEJ4ZmslM0QmYW1wO3Jlc2VydmUNCj4gZD0wDQo+IA0KPiAtLQ0KPiBFcmljIEJsYWtlLCBQcmlu
Y2lwYWwgU29mdHdhcmUgRW5naW5lZXINCj4gUmVkIEhhdCwgSW5jLiAgICAgICAgICAgKzEtOTE5
LTMwMS0zMjI2DQo+IFZpcnR1YWxpemF0aW9uOiAgcWVtdS5vcmcgfCBsaWJ2aXJ0Lm9yZw0KDQo=

