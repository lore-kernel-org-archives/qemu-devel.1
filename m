Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2535BC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 11:01:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3A9B206EF
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 11:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="WY7/Aza6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3A9B206EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD42r-000784-UU
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 07:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kD41z-0006gt-Ij
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 07:00:51 -0400
Received: from mail-eopbgr770073.outbound.protection.outlook.com
 ([40.107.77.73]:7654 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kD41x-0004UY-R4
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 07:00:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DDzX1o2xprqAfRWxOH7swKiTtW1/Ro+S9p6RrYed6ixhckr/KN89jz7s0LjM7US3xfqZhCmIwVkCn6nKA/fy7gkf1KBprTQsiq44oyGS3F4qWr95VQuC6iEMlvojDNQDafgT1TH4DtniZRtMT/GezGhuKDjwkLb71R6l+RET/d6vtNu8p03N8NkMnpGEdsIJpWhhrmQTGQwcAlLKK0A3uYqEoNlRl4AuWKRQhrYayrmxkvdF7hsfXEekfwanf9u72NrY3b5uAETTyFwtOBU+3KNUOiumwLPwo5Jqso/WpkSSLK4yQwIixGwZBznn0Onb9GC6kW3dXEAZx8rCVOkQEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DXIBAJF+D6RmObUkijFVtch7MloXxZbB23kCbrGeQRM=;
 b=io+PHivubDM91z3bjZzGscGjqsML2/r7BXyh/jE8IqKSvmfj59cV50BMwWQx6wn6f2WN4hLDNukHebM8jB0w3ZHvkFb88/21zqHb62lebHV6yVvMaYygpuE8mekd5KZMtH1KT8VnwpGpKF5jEzfV8SagqAmvs0vVivBp6wjb+fe+RUae1QrUMCZsXAKlVyGUcLnd8jet+FjC9Vh/qssh3DomGMMmmlfqpR/au7+kOQu0hR3vZB71y2lmQ0nFMeFQ7yvBw3CQ5TyFTP7+Mo/WFv3w7z00vZN71zYt1Vjtt8oglwqZBKOoC7k3AGByj0PDh4JlFyjjsgQ2AAdlS3KmXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DXIBAJF+D6RmObUkijFVtch7MloXxZbB23kCbrGeQRM=;
 b=WY7/Aza6t3OOc1jyttXD2mZkaYF4w33To8bYc6UbSIMlfSkek4LrhK6Q8nvm+VFRbkC5CiwJ/Go4CoINZoW+v7hUJiKpqFnufuMTR3/lYO9kakdlEGpp1JDZsVu1+ZthGrWAIjnR0zCcCLad8MQieUO80aJy8QRjwBWfmva+gxg=
Received: from BY5PR02MB6772.namprd02.prod.outlook.com (2603:10b6:a03:206::11)
 by BYAPR02MB4789.namprd02.prod.outlook.com (2603:10b6:a03:46::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Tue, 1 Sep
 2020 11:00:46 +0000
Received: from BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::1007:f094:45c9:bb47]) by BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::1007:f094:45c9:bb47%8]) with mapi id 15.20.3326.025; Tue, 1 Sep 2020
 11:00:46 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: RE: [PATCH v4 0/7] Make hcd-xhci independent of pci hooks
Thread-Topic: [PATCH v4 0/7] Make hcd-xhci independent of pci hooks
Thread-Index: AQHWfW+WJUtsbmvR+kq41jNhIEErmalSIRIAgAGB9WA=
Date: Tue, 1 Sep 2020 11:00:46 +0000
Message-ID: <BY5PR02MB6772914A14693C006C924D12CA2E0@BY5PR02MB6772.namprd02.prod.outlook.com>
References: <1598642380-27817-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <20200831115800.zgqyd7yv4j3wnkfg@sirius.home.kraxel.org>
In-Reply-To: <20200831115800.zgqyd7yv4j3wnkfg@sirius.home.kraxel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [49.205.235.17]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 71672b19-290c-4583-ee57-08d84e664795
x-ms-traffictypediagnostic: BYAPR02MB4789:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB4789881A06A254D09BF24C37CA2E0@BYAPR02MB4789.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3I2Pkx3O56iiRqL6qzLsUFbi7QmqmbtF0WA5UjDkGusdTb+koWTdEMQ6DKN/n7U7XZYsCPTzP2vP8+oOkLGFnn+pYwomdihqnZg/IK2LaT5IsW/UInx80kb55v+cx7VDt4SHwPua5FacJIdFeq8jHKUEL8mN1KalwKBo1QH2Z2FASJ/WDvI9u7sAAMZlnEPzesnVhZIPPodmdeF8GheVAbBzC7IRyezOaBvfwzRkPZAH2ouAEcVNLhBJt6MPeeFp9g7yGRjDt1gnxF3Njw2iW3q/FAMvHxLks81xjvs1NYTgpkDi14xbVTuB9e27qPApcSNI71p819PvQIvotEyg9w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6772.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(136003)(396003)(39860400002)(346002)(376002)(5660300002)(83380400001)(186003)(26005)(53546011)(4744005)(478600001)(6916009)(52536014)(6506007)(8676002)(8936002)(71200400001)(9686003)(7696005)(7416002)(33656002)(2906002)(66446008)(64756008)(66476007)(66556008)(66946007)(86362001)(54906003)(316002)(55016002)(76116006)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: vGgMfMuDMcfXUp16xd3EHcTpnNQv98Gcx8LMcNS8kAioaJz16ZxiIzhaoB9skyeXK2pw8b4R6p0g5dPpBTFZzPRORpDprNRMw6rf5XZnxj4hZZ+OW8UORsumAKIzCKExBGIlCmKpgo8UGFTo4KKJHcpzdjWeW5P+DHq/X7jJqrWSGwmA1Jf9Xg5ezMolE4VeVZILzyZ1IENBCRUEVj60kJoPGBWT2RmdY8TKS6yjHcuJM7EFbwrV8CTBJ2d/ZQX6C1/VRnwijiE+QniojkE0G+BOFDHfi81kQqvavVeOvm0thF4P23mv5ax9hnR3QsuWH6ci4VGCiuFi5BfP1gaWeqSdhn4U7VbNlmMWYJ7kMOhJWftmS7lyYCXLhjL/6NfJ/8qQa8Pmj/YyE3QkHq5kWBA1b44x/cnH9Eo4/oK937HIjR+Ds7g04gpOWudLrbVeHUENUCzXG2JQuUUbS8BaD3LTuCYbJQRWVm24UvlKAS1kjmHOLxOjZujxVbjUyhs8SxA3ojdcJGA6QMKZaxy3tZN0tcJHH8CHyEooGGIRlnnTJz2O7KZctYA3FmOifyLm4DT37P7ZjdYpsyhevybIkc8qV3946uQmR+sm4+QVGNg4fOZadm/v22O3zJRf2+zTz/CvoILNfDCRoGToijJGUQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6772.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71672b19-290c-4583-ee57-08d84e664795
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2020 11:00:46.6229 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uSmVjD6XbjMVG7I2r3QdW9J59rBlHblqYevCoiOOdNYJVKZZApJuVyV8Lh30tPmEsXSOEn9/UoDOaUmKKYoUWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4789
Received-SPF: pass client-ip=40.107.77.73; envelope-from=saipava@xilinx.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 07:00:47
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Francisco Eduardo Iglesias <figlesia@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Vikram Garhwal <fnuv@xilinx.com>,
 Markus Armbruster <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Edgar Iglesias <edgari@xilinx.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?iso-8859-1?Q?=27Marc-Andr=E9_Lureau=27?= <marcandre.lureau@redhat.com>,
 Ying Fang <fangying1@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 =?iso-8859-1?Q?=27Philippe_Mathieu-Daud=E9=27?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Gred,

> -----Original Message-----
> From: Gerd Hoffmann <kraxel@redhat.com>
> Sent: Monday, August 31, 2020 5:28 PM
> To: Sai Pavan Boddu <saipava@xilinx.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>; Markus Armbruster
> <armbru@redhat.com>; 'Marc-Andr=E9 Lureau'
> <marcandre.lureau@redhat.com>; Paolo Bonzini <pbonzini@redhat.com>;
> Edgar Iglesias <edgari@xilinx.com>; Francisco Eduardo Iglesias
> <figlesia@xilinx.com>; qemu-devel@nongnu.org; Alistair Francis
> <alistair.francis@wdc.com>; Eduardo Habkost <ehabkost@redhat.com>;
> Ying Fang <fangying1@huawei.com>; 'Philippe Mathieu-Daud=E9'
> <philmd@redhat.com>; Vikram Garhwal <fnuv@xilinx.com>; Paul
> Zimmerman <pauldzim@gmail.com>
> Subject: Re: [PATCH v4 0/7] Make hcd-xhci independent of pci hooks
>=20
> On Sat, Aug 29, 2020 at 12:49:33AM +0530, Sai Pavan Boddu wrote:
> > This patch series attempts to make 'hcd-xhci' an independent model so
> > it can be used by both pci and system-bus interface.
>=20
> Doesn't apply to git master.
> Seems the series needs a rebase and adaption to the meson build system.
[Sai Pavan Boddu] Ok, I missed rebasing patches over master branch. I will =
update this in V5.

Thanks,
Sai Pavan
>=20
> take care,
>   Gerd


