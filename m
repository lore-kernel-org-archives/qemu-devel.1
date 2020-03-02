Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD87C3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 20:00:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3937720866
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 20:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="EhU8Q2Zh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3937720866
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8rEY-0005js-CB
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 15:00:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33431)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sunilmut@microsoft.com>) id 1j8rDr-0005Gh-9L
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 14:59:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sunilmut@microsoft.com>) id 1j8rDp-00018M-Lm
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 14:59:26 -0500
Received: from mail-bn8nam11on20707.outbound.protection.outlook.com
 ([2a01:111:f400:7eae::707]:20064
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sunilmut@microsoft.com>)
 id 1j8rDp-000186-9T
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 14:59:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+SLAj1GwpRpqjQV6zpMdYKkj6QjDkrZzDUqjUhaXoFjbZ87ORc1lznt8t5nGKrmGg8qMD4VOEWNpoKJMfRPkYemvvtT228Ngk4bDd6Ax+yp9F/NHgeLCj/XZXrRuQz766AjL9J6fzqNzAkKzyF7miDxKdtzyM8Ih7O83ocdoLRZBNSgWRGBPDbWxscBUMBn80MJrHFuXw2K+Pj9mrt+B7wTJr+g7Sn1px7U+dybvZxWQWpOxkgOght2kgr98sgYJ7mnJ06Ys0T+dvy65/1DpKwRzuJkBduQCCXkdqoFCYhOEbmfDT05PSxfz5jtW/WApsgb57olTIb2ekefR/gJqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIZrW+IP9vg3OLESfqq81prp5m2KtO9CVuNIe2D/Cg4=;
 b=hMfJsvIexA97TyhvL3cxrxEqeW7+0h3hxHBBXZWSXwB7DhTSt4BVl5SxqWZP6xTxwgO4KQB3zygHcFCOw0kpkBQVMslp5Yshf01bl2zD/SmrOGt1wj0gjbCsUkpCcRlq1b98Ciap99vULwTPiNHo9bhUBFwzMq8BkxhJXIVIcmIbsQb/sGZ19medeaY87jllcskLZIOGWmS9cfBw90RLR3Ncob5WJd5f6w3t2AenKX46/l60JbtNh9q0siRXjD/stMJCWm6Frx1F1D1adh9DKub637r2fUZOUwMRqUlxdUg67QKt37Fuwc2GqOsFe6D3sz9EQTBrQFw2dzOeggpAVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIZrW+IP9vg3OLESfqq81prp5m2KtO9CVuNIe2D/Cg4=;
 b=EhU8Q2ZhGJAadmcrYz+RccffgbPGnMcYr/LZHQsPyFIjyW8N1nwjQ4OKjq4EwCGuwBsWLYJ0TJF6d9D/2kqgkfYN6YWOQpT8oQDVPNaR6XeRnkP+buuH+fYaDbsmYAQSsLS7cfsam6RRGjVcykXZn3ffSxS3cjebF3/yZeMaPpo=
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 (2603:10b6:803:51::33) by SN4PR2101MB0735.namprd21.prod.outlook.com
 (2603:10b6:803:51::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.0; Mon, 2 Mar
 2020 19:59:22 +0000
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::b1fc:af97:6a7b:4fe]) by SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::b1fc:af97:6a7b:4fe%5]) with mapi id 15.20.2814.001; Mon, 2 Mar 2020
 19:59:22 +0000
From: Sunil Muthuswamy <sunilmut@microsoft.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, 
 Eduardo Habkost <ehabkost@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefan Weil
 <sw@weilnetz.de>
Subject: RE: [EXTERNAL] Re: PATCH] WHPX: TSC get and set should be dependent
 on VM state
Thread-Topic: [EXTERNAL] Re: PATCH] WHPX: TSC get and set should be dependent
 on VM state
Thread-Index: AdXs5oCBJsjFayPuQg++a0KvVJgCQQBPaQ8AABVvfKAAGpE0AAB6DlkQ
Date: Mon, 2 Mar 2020 19:59:22 +0000
Message-ID: <SN4PR2101MB088094833D95758F871BE401C0E70@SN4PR2101MB0880.namprd21.prod.outlook.com>
References: <SN4PR2101MB08804D23439166E81FF151F7C0EA0@SN4PR2101MB0880.namprd21.prod.outlook.com>
 <37e639a1-eb9f-b769-d61c-112d148bcff3@redhat.com>
 <SN4PR2101MB0880FE16EE36BF356552A9DDC0E80@SN4PR2101MB0880.namprd21.prod.outlook.com>
 <4277f568-2b20-f7c4-5764-f516c8e281a9@redhat.com>
In-Reply-To: <4277f568-2b20-f7c4-5764-f516c8e281a9@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sunilmut@microsoft.com; 
x-originating-ip: [2001:4898:80e8:9:13f8:4346:c8dc:67a9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 15192c0b-4ae4-44c4-fb29-08d7bee433e9
x-ms-traffictypediagnostic: SN4PR2101MB0735:
x-microsoft-antispam-prvs: <SN4PR2101MB0735F99AB856566B391C9D3EC0E70@SN4PR2101MB0735.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 033054F29A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(189003)(199004)(10290500003)(186003)(6506007)(81166006)(8676002)(81156014)(4326008)(66476007)(4744005)(66556008)(52536014)(66946007)(5660300002)(2906002)(8936002)(64756008)(66446008)(54906003)(478600001)(55016002)(71200400001)(8990500004)(9686003)(76116006)(86362001)(7696005)(33656002)(316002)(110136005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN4PR2101MB0735;
 H:SN4PR2101MB0880.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mJelP3bfY0qAr7IQwINBopX/bXsBYCk4d/3wKRwwf6nq1CuuXUkehfnvvpheZs4FBN59fjMFHoMpIWm6fp8dKT5vweqIWaetLiYJOKrJu7S0nXqQeFk5zQ+H5ZDVLOA6eTGQP+s6JEc/j2znUDT5d4M+mfBoICdLsaaOcxsgCIVAqIMzetGzTU1FZRkUSpU5t1BUXtbqh0zwL3eZFgQNNwmds1jGIEKpFz4LMpbbIbhWj/WuVaHXxtDGtwIVKImy8ZEAVSQuqccpiJALyagKZ8/CIRY+N4o9hXh44xwhQbWXPIrrCxPk0Ykn/FxVGhIN6FGedjYeVQ1Fqx+4yEsOHQUMWV2PuOxCgLJx0Ji8F3BDRI6fPPwHSczo7qyCUJ/vulSGKbPBq6PqSsMNa9yX9AtYTgZAHK4nwpYmCSlKEEok4Pi1i7+C2psa2bjSKGKi
x-ms-exchange-antispam-messagedata: QN4sV7z8Lhph2vHv9EqFTR3LWPGDUQE0W6J9BNkpWoJEUECLOWoH2KkeLoNBYwn/28otMxGPE0ySppPlCQTxC38M3uvMWPJZDz7lMirfPZUDqW9GpQRt8cVeGT2G/vJhq3PKUeX90RIxqcpVxUv0yrZa3GJlMLHbRa0pDmrDcTa7O1VxKDiwQ7yzQ6wo3NuwKFtb1UT9oxTUMsyXPKrCiw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15192c0b-4ae4-44c4-fb29-08d7bee433e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 19:59:22.7608 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FYv3n48qQZtpgrcAkBT9aMP8GVRnLBxsmz8PJ/lGZQFOX9e5YkKbCiYXOXJIID4P9bdd0E8jh81m+SYcA/wDORCuFcuDz8qTfmqP3AV8o48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR2101MB0735
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:111:f400:7eae::707
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

> >> Looks good.  Do you want me to queue this until you can have your GPG
> >> key signed?  (And also, I can help you sign it of course).
> >>
> >
> > Yes, please. Thanks.
> >
> > I haven't used GPG keys before. What would I be using it for?
>=20
> You'd be using it to include a signed tags in a pull requests; that is,
> the git tag that you ask to pull has a cryptographic signature attached
> to it.

Great. Is there a link that I can use to read up on how to get the GPG key
and how to include the signature or what process should I be following?

> Paolo


