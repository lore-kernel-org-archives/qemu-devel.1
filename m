Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87628C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 00:34:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9BAE22249
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 00:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Ie1Tx7Es"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9BAE22249
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVOYX-0005Da-GZ
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 20:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilmut@microsoft.com>)
 id 1kVOXO-0004cI-Qo
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 20:33:02 -0400
Received: from mail-bn8nam11on2072e.outbound.protection.outlook.com
 ([2a01:111:f400:7eae::72e]:37344
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilmut@microsoft.com>)
 id 1kVOXL-0007CU-BX
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 20:33:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aci9sPsROkyKut1mgQ7XOD+AbGGqx/nqd67xDuh8zFj8FpROyNBcL4voFwvzwqHQelH+khV/c1bzkZW5Hop3Ms/lYS1kOYERPyJSlaROtimbHMb/rNv2xDhfwvCfLCxE4l8Xw5sMbKPMsv3Y5BEQlG1B2Yv2J01ouhSEAyF7XRzplcWOE+k5HauISjixOQASn80Q2qdYdJJcm/Qh4WWiLILnK2p689I6J2WAhIh7AEggp/OHbw6bEk3VqCXmVohOfdsHordkJ2THVQo6wymrU9y0NJWB3ob36wgmZgjVyI+QpizKCOsw+RM+wkqxckb5BNgcLlvxK0/8SwiHyBfQ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yn0rhG8dP07uU3xsb8Isu/6stYrxu2QdoQuFG3oCYOA=;
 b=UNvFGZu1BBIp/d/BWBUhZFwb6hoHkX5uHL9nuEZZLGOJK+yw309vTv7sVW584pjfRygNa0DIIURFrArkzeWfeBZ0esuRbZiMFrpZECFxW0dpMsgfisy7R7VfCxC8/ESOANGgSP29z+AmIH3CX85/jOQ5esR5y6QIvZVxhwDcPxO+OiARUwE0ziXIEShaQoLOh7+xZwJz83DNlnEHivhGseocY2eCwQT0JFxv6NfHmsFHujxpFmbY3+2yghonk9l74GUNoK3WoodY2ykGtiKo7/0jV/vdxZ4QCW9uZQ2g0dmyX/zFOLHcZFcQci2CDj6mGZnRXeiOM4D6EowarJYeQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yn0rhG8dP07uU3xsb8Isu/6stYrxu2QdoQuFG3oCYOA=;
 b=Ie1Tx7EsYGC8Gj2h9guMvLE7lAS7Wo7DjxTGqrhbCWgPfgCaNqKDuq9mET3XK6PCBHhZElb3NkulGrRi/+JU+rxdH466q7vV1p1vN3j3LCdIiiSyB917qFByrL9FMLq/2A2fOnOpa8Ucpw8B8DbBvAOPa6mrzVBTbpg240NLhk8=
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 (2603:10b6:803:51::33) by SN6PR2101MB1742.namprd21.prod.outlook.com
 (2603:10b6:805:5a::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.3; Thu, 22 Oct
 2020 00:27:55 +0000
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::8d9b:db8c:b902:5006]) by SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::8d9b:db8c:b902:5006%7]) with mapi id 15.20.3499.015; Thu, 22 Oct 2020
 00:27:55 +0000
From: Sunil Muthuswamy <sunilmut@microsoft.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH] WHPX: Fix WHPX build break
Thread-Topic: [PATCH] WHPX: Fix WHPX build break
Thread-Index: AdaoCgddyZOrMMvORwSJ36gK9HiqBA==
Date: Thu, 22 Oct 2020 00:27:55 +0000
Message-ID: <SN4PR2101MB0880D706A85793DDFC411304C01D0@SN4PR2101MB0880.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [2601:602:9400:570:4b3:a3df:4862:3c6e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 70277272-5804-42ce-f1be-08d876215218
x-ms-traffictypediagnostic: SN6PR2101MB1742:
x-microsoft-antispam-prvs: <SN6PR2101MB1742E93B95C8870628E75CBDC01D0@SN6PR2101MB1742.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:632;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0bPb8PMTJ+UqQrWDDaNm47pYwqRENwh2sh2BG8IEYvXS6OMFoj3s2AWpyLBh9GhhXAkYUDOCn8jNPCAC+Um/BysjGubrOhG+Bh54bbjgPjhj5/7uUqkUiDb7KO5xH5lMw7+FFAEIB4ORy4MhdZNXf+2GXVzm8bTuX839yj+3SVMf85hdGeVKj1k/pGINen1nxvJIaBMLKLWJrEsArI7z4PLLXHTKaU64eEtPVzOrTwaDBQIhB0Wh1d79hz/TvYJ50+qkJ1go5V/iRv4vY1i6OGS+Hhj/BBkej8eUuBEKYO5aZNMirGwr2YWFeyARUh3anTRyejzi7dRqs/ktAEauhg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN4PR2101MB0880.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(5660300002)(33656002)(316002)(55016002)(86362001)(110136005)(186003)(7696005)(8990500004)(4326008)(4744005)(82960400001)(478600001)(83380400001)(8676002)(71200400001)(6506007)(66946007)(66446008)(8936002)(66556008)(82950400001)(76116006)(52536014)(66476007)(10290500003)(9686003)(64756008)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: alHzMB4BVm2GBreCoXa0+Uo8HkBxoXti0BTvuRJDI/5CYoubozIICRgEc1C2uQvgdKxmQSwrb3KpuwfE1XoNtxbW69uHfy65jxXLX67EhRi9vkCyauRY28IDng1zrm0KRsqs5sYh3Vqyt4zCf8r6YLgDF+v2gMLYFynwQ4u7fV32ZIwjabVrelQoEnpswCm0qo17GuCdF4bWuMDpvUNaFF2vpubWo/CvQCLPz4Vxv/rVjGTfACIfPHfaxKA59l7dO+gQ/Qe9AYyUqnqTX/nNJHCboYTymTsMRyZEDBbD/ngla/WF0J+2MXfRX0MaLAhUOlxhj0DIckto9UkVRK1suRr6jAyfDV6rGUFjAmNJAv18DKc0SbFy/Lc/eeUoLgOAwF51zGrjHV/6toiL1CAigkH7brN9FZXkBY1gQxXwvoHPst+YPm57iP5SNLzGldsMjbjzSBg31aYJDSBeLQMtR3m8URMxq/Yr36cc4ORPW1kks3FF8ktGzvBGksNmuP8YCsPDG+tuvF20/TDQN5qH+qxz0zuv+b5lPXixlDyxXlAKLx9hgOMkasyOQfj/Au8Kk3fstcpxzDniZ9YkOOS++ecJmsHH3sOC11mgPcmfjF2Qeo618aSogCOGtXljuu2WMSMD1dLrJNLmRxkVRi2bihTNb37fgGb+Av4gpAadQWML7iRt3G5YV+lqbQzSKXfeGnMUmBDKJYyK1F83ZmnOxw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR2101MB0880.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70277272-5804-42ce-f1be-08d876215218
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2020 00:27:55.5100 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gRLmW08Yjn8/VrpeJ4kjyx1OoWnTVK8s4YM1p3opnpxC5n5A06s0wDJsEUZJdj1giHyW0Y9ce7DvghnzIk63/BlS3Rc4dzuiweAX2tXcAz8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1742
Received-SPF: pass client-ip=2a01:111:f400:7eae::72e;
 envelope-from=sunilmut@microsoft.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

With upstream commit#8a19980e3fc4, logic was introduced to only
allow WHPX build on x64. But, the logic checks for the cpu family
and not the cpu. On my fedora container build, the cpu family is
x86 and the cpu is x86_64. Fixing the build break by checking for
the cpu, instead of the cpu family.

Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 7627a0ae46..2d84e90495 100644
--- a/meson.build
+++ b/meson.build
@@ -198,7 +198,7 @@ else
   have_xen_pci_passthrough =3D false
 endif
 if not get_option('whpx').disabled() and targetos =3D=3D 'windows'
-  if get_option('whpx').enabled() and cpu !=3D 'x86_64'
+  if get_option('whpx').enabled() and host_machine.cpu() !=3D 'x86_64'
     error('WHPX requires 64-bit host')
   elif cc.has_header('WinHvPlatform.h', required: get_option('whpx')) and =
\
        cc.has_header('WinHvEmulation.h', required: get_option('whpx'))
--=20
2.17.1

