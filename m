Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466ECC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 19:35:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11DF32065C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 19:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="NKniUGWb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11DF32065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0VNx-0000dm-6U
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 15:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilmut@microsoft.com>)
 id 1k0VNB-0000Cp-8B
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 15:34:49 -0400
Received: from mail-mw2nam12on2090.outbound.protection.outlook.com
 ([40.107.244.90]:17345 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilmut@microsoft.com>)
 id 1k0VN9-0005Om-7p
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 15:34:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n1H2qB2pjtQDPLmkFYerXuCl7/kBb5Wr9nRmBeqXsNva/Lk4RNi3abmVQnySDEank5i2UdjAUPLtzMqdcpwUdZGv24ngXiaInRyUxVyeTZODDfqP0vhKd7gSKlrcNXNjU6Metm4Ky1kVYaaSYYuRraA8u3GH/lrvcaIj5zg4r3IEeIeouzAgIFHU7YwuHoJfuJ8szpNlP9eb2VgEvax0GsAB1GraH3VlfL4tkyhUIJNKYspEza5VZpwhLTLDLqrXnxQiRtUUddCwouxO/mU3pJwAXgD9NOlwMBu1Hp+XgZ0AqPkY9p/rlmC21pW67WdpYUI37+06kWc5Zsc6FGfVfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DgoAseGbocwszal/kxD3JgaMToshd/aK/+OXqFeGU/Q=;
 b=DQx/OeW2gTasvNrVfy5l1boqga/qdhsQQhstqVK/2kI7hTBgpsdC1LK88CgSJ8c+ULm6eUTORp9mt8/gpCW7ZzdGtsY/7kzDd18XbgyrXbgKKVYDnytYOaiRndBhULcS7q0VZD9jNDDIDpWC/mdO3OVdaqj30KQlKf3w87+x2MCWgBj2eLSLt7b6/bfwnywlTdUQ3LI1t7ZhkmSfu4QuQOH/CeELUF91+fkqYnm2BEL9EVzt5P1IMFm5O+Lz3aUaMpOeO2F7XmTh8PzeF6i1Ko86drhsqA5aHfmlsZ/htWjZ8IIag4c/j3ZdEunZbcvB54zW4x1tihyusYcq4kPzew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DgoAseGbocwszal/kxD3JgaMToshd/aK/+OXqFeGU/Q=;
 b=NKniUGWbUuEr8VG1aw6OJ2e0RW4zS34FafXpxJOaph+r1UukeFX3cGk1VXuxZ9GKBqHRvgyfY0UF7mTWkUehnbtZU7Po7dCSBGcx/AaOTOLczNNnOwhX0oCsG5APEZ0Zk99f7TUHiGFr8Ov2XvdyUY2saGd4HNxQUiuUq6Cwd1w=
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 (2603:10b6:803:51::33) by SN6PR2101MB1614.namprd21.prod.outlook.com
 (2603:10b6:805:54::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.1; Tue, 28 Jul
 2020 19:19:42 +0000
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::99a:30fe:609e:be35]) by SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::99a:30fe:609e:be35%8]) with mapi id 15.20.3239.016; Tue, 28 Jul 2020
 19:19:42 +0000
From: Sunil Muthuswamy <sunilmut@microsoft.com>
To: Paolo Bonzini <bonzini@gnu.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: qemu repo lockdown message for a WHPX PR
Thread-Topic: qemu repo lockdown message for a WHPX PR
Thread-Index: AdZlFApWhEK0UloZS9GdU/X2cvsH+A==
Date: Tue, 28 Jul 2020 19:19:42 +0000
Message-ID: <SN4PR2101MB08805B8E85196354ACA49B54C0730@SN4PR2101MB0880.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gnu.org; dkim=none (message not signed)
 header.d=none;gnu.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [2601:602:9400:570:c5c8:1863:df3a:3ff6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 794ee28c-35fa-484d-d23f-08d8332b2e34
x-ms-traffictypediagnostic: SN6PR2101MB1614:
x-microsoft-antispam-prvs: <SN6PR2101MB1614B8EE907B2938A309E983C0730@SN6PR2101MB1614.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 60kFVknvWSSFBuB+6CNVsROlv0mJCFyp0oMBCeSgp4U3TFYDvjWkUPF8Z4rGZyKJpbY/OTg2CfhJVA4WuT+QbhDRFzEbbEhL3S9ZScpPCCXM7yfC2DyC0Q7Gqx2XMrwCIVxUmTEwjJBENTIVf7tFQH4yi6l3zDHeI0P0VSlYYA+/X6Cxqa4Y5M5H3VkMsvACX2VmYaH1yWq5/SL/ZAHp3/k68UbT/WhSMej53uCSL5hunh+BhHulfuzrju7W2NSvxcpC1qZ69ElX8sjgVw/Be5Sf5k8GyFxtMSqFHOfzUlpPTMSlyoTSIn80a1gCTimT4txtqCJzujKkw6j8eyO2KAW2fgl/i7Xno/AzY1TomWyMaEdsMg0dG2PUHDEOGXo8voUefVIF2QNMWZILQNhEzw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN4PR2101MB0880.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(9686003)(316002)(558084003)(6506007)(966005)(8676002)(478600001)(8936002)(71200400001)(186003)(82950400001)(82960400001)(2906002)(83380400001)(55016002)(4326008)(86362001)(7696005)(66946007)(66446008)(66476007)(10290500003)(5660300002)(66556008)(64756008)(6916009)(15650500001)(8990500004)(33656002)(52536014)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 00sap8DLDMqbsrBhd2f9C71uioMPUMYD7HLQZs6Uc/l+7U3EWl5youtcSvNcn/qjzXYTwVS9Hp1bQqgO/Yz1RnOY62K2pivifjIooiKTl/oNyJ+qG+pxMjSsqj8i2+KggrnyAAxKJ3dDiC3Yu9KnSA433QiioE1gi5WgVMJIDhwRDDjglv1b8eMMWcjihiVd0W/0gED8Nrv8RT+ik0dOo6Nz2yJItosZS+n+wXBO7mfD/dsV2WfBN1KOtTQjlCBX561wNyyAPAAJatolFWXiLrtEV6Li/lqHQMl01U4Zc7P/6/1eYi395e4A7ZKRtUF4FJvr1bQnwcnFD4sJHYm7lAPKMtc2bK3AHstdpKNHcGXm+cHCyMYVDNoDNATJ2DpuWvt02sAsk7RvPLO1ciHgdiT5gXcgDZi5nf5GFPwBW5Y7bgajGJSuWkWF+BDa3S7VgaVmZlynyR4odGP21gd4zuKOGV3nngdUcnM2wEeyYZTEBCwF1zRrxxMFNSROInfvSqKiz8dEGGmoi2ZSlhaCoBAFvUshWeg8P7wO5fIsq7rnTa0pb8xgoDafBojtuHyTmHxBg9Ad4tOYc9xCuvF1kwvD7WL5rEc0kwIu0JG8F7u6pvvdnZxIp7fkahkMgneZvRiVA5jWdoPYXJ70rycf41hYyHfCBGDjCByS3+hm7TG/KZ442avjqgomZCdqbBa3jfTvxvPF2PoQc92mATj32w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR2101MB0880.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 794ee28c-35fa-484d-d23f-08d8332b2e34
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2020 19:19:42.4429 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R69f2rkTjZEmZaS9qzQ6qmgJjezt5TvYL+xaG6cy3NIBuNkRvhMbpuDjHhnwKkS0ghPNceH3t4nmu30xt7wHpjr/vV2E5o3GBKe0abKGu3I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1614
Received-SPF: pass client-ip=40.107.244.90;
 envelope-from=sunilmut@microsoft.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 15:34:45
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hey Paolo,

Following your suggestion of creating PRs for WHPX changes, I tried creatin=
g a PR https://github.com/qemu/qemu/pull/95

But, I am getting repo-lockdown message. What do I need to do differently?

Thanks,
Sunil

