Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57337C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 14:15:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EFB222510
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 14:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="MdGycVQ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EFB222510
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvLi6-0005kp-Ey
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 10:15:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39306)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jvLhN-0005HP-O8
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 10:14:21 -0400
Received: from mail-bn7nam10on2049.outbound.protection.outlook.com
 ([40.107.92.49]:6140 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jvLhK-0005aD-HB
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 10:14:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+Z5XSfZjM5w+MrPQn9NW8ZeqoCdKPT/qNDjBGCEJHIH3N/lcmNVchznH+cbUm67oZ3WhundCoaFfLZmwHxAVsmN8cEtN/NQ0c5J4HZc5Fa/5CRUxINrBijAwLBL7O5U0hZWSoY8Q2y5SUuYm8vpVgW2WkZWYJ4Tu1UK+O6uxsF6ALYDJq5qsFnjGiWENUx+9dQTyRxxFmh2Xax1Y714kRL5oKeHETDblsZWb+DohOAuzdGGcgCkz6q4rvuvCgFKy8ftxjBKUS1dHEhk+vZx/VMETdnlq4db2uSm/JtQOPlFRPJKmUXGd3UJKCvydxXA4uqj3WF85fr2Ol6qUU7hDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5GzzZJVA/qrTz+x/Re6Oml0i4d2Dhtg5ztND6N+j/eI=;
 b=hwcIprL8MR5V/+vki4SILTD1eIChEpUFhk/KlHb/notow+0+2m5TyjdZxTEQOmgrFAyOLK6BqyuQuUASSkWSbOWP4VnmuUQBS6HYOExXBkrVMNLfStkJW5xKkS4mFT3DiECu4gJ/I0HNeYd0y/RjC1RSL34+0stFRig0pKz/pNdUU5hXCaTRDVY7cxx09VvAgBUVRANhMhZwSDoudkcR0z3Hd0hQw2UbfkhHglPDWXLUiEnmcmylHRNYTvkzujq84hiRWvapciBbEEt6qTExWnRhnhps2oA5D2uRjKYAheUb1PUPa3ZFBkUh7Gag8SOFdYTN/PO6mM4pzjK3bXXWAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5GzzZJVA/qrTz+x/Re6Oml0i4d2Dhtg5ztND6N+j/eI=;
 b=MdGycVQ+XEIXvEUdAJU31UBmcxkdvVY2PUcvkflQAF86oa+9DudYY/NMP+XeT2BJW2mbgUO8uQK6OLcCSsbanhcvwib7IE5/jg5ESlvkyWdHGIMqCJPjevLAtvj4aIR08mtERv2ZSQsYckYcLJABM6F4+8Qs+b1y8QK/42KgLkY=
Received: from BY5PR02MB6772.namprd02.prod.outlook.com (2603:10b6:a03:206::11)
 by BYAPR02MB4056.namprd02.prod.outlook.com (2603:10b6:a02:fa::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Tue, 14 Jul
 2020 13:59:12 +0000
Received: from BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::4477:7134:37a6:c828]) by BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::4477:7134:37a6:c828%3]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 13:59:12 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: Sai Pavan Boddu <saipava@xilinx.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster
 <armbru@redhat.com>
Subject: RE: [PATCH v3 0/3] Make hcd-xhci independent of pci hooks
Thread-Topic: [PATCH v3 0/3] Make hcd-xhci independent of pci hooks
Thread-Index: AQHWVH9z5HwbdGG7uECzkfpq3kp5uKkHJK6A
Date: Tue, 14 Jul 2020 13:59:12 +0000
Message-ID: <BY5PR02MB6772B76423A07CFA4B4E5FA9CA610@BY5PR02MB6772.namprd02.prod.outlook.com>
References: <1594140271-16462-1-git-send-email-sai.pavan.boddu@xilinx.com>
In-Reply-To: <1594140271-16462-1-git-send-email-sai.pavan.boddu@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [183.83.78.46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 50e89763-2e62-45e5-e0f2-08d827fe16b1
x-ms-traffictypediagnostic: BYAPR02MB4056:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB4056761FB4E1FB3A7AC3B87FCA610@BYAPR02MB4056.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EYaI6HY6Ca6OgneuhkC5chfOxWbCtulgSkOHY/W+tAvlIIB2dvofMleUzk+wf+TY5vhzub9amAfEYx+T6G8tLyMGsWUNVkkBwju5CEm8dbLXI6Eiidg6t6WGLYYNEOOHzcujXeDUhSjv3pAxrA6k9v44i259L3lu62rzp4hJPCLzpU3D8+7GL6VI8M9MKvVKOGeE/cyd5jx9NhBVsWEqzN85F9yD0edYXQxWsccjFfdkKqNkgnf1pLX/dGb1fKry2/Sx6v790nDWJt7i3ZjQszKtZeTBBznapHZrwbqSv9SkXqV5n0cEnzQxrhccTojVbj3jm6KLK2MLiXrqOFzaiA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6772.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(39860400002)(366004)(376002)(396003)(136003)(346002)(71200400001)(8676002)(478600001)(33656002)(26005)(66946007)(110136005)(5660300002)(54906003)(55016002)(76116006)(4326008)(8936002)(9686003)(86362001)(186003)(52536014)(316002)(7416002)(6506007)(64756008)(83380400001)(66556008)(66476007)(66446008)(53546011)(2906002)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 3gnyUlBTbb55n0NJymf60mKq88EH4I7xWJQiAZQZHP1bYLPczUKZQkg0pYbO9rlublRw0AGO7BPS/kY5/yJdj0QZApjkkLXz7lq18SUmKv0RoJM7UJI7bt8qBRQbEsEIhT9wHWjtJprSQA5kvW+fJzzVrbm2rcQdo8FLmDyIccMXBE8fgQLG1LLb3EBnZrnfO9/+UyoRKSDuj6Nz5rXN7c8rOYQyQZCLYpqp6bN/1DkUCUkk05i+DJ3buQhOsdhjKIP2ibYCjuRqUopSsX5OhB0+P++VG3FF9dpondzuHMJOanKXI+3JGdy8k0B9yaVZlDPZknw0iZqbj9N6eway96/pjvq7bQ1B3CR46mDpujXbC3q4X2TbgcOrq+Yr3SDQEWHEB2klwGOVHTW1dEE8zqSTnSaPTFkFsZZBn/Gt7O7L2c55YkxvfyD9J4aRbbKJRz7kMyqLc2V+jQExgDK/qcJ+4+7injqO+9nnnI2S0wo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6772.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e89763-2e62-45e5-e0f2-08d827fe16b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2020 13:59:12.7921 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9jv35nGYa9WLsXdsTK2qnDyK1hNV2jN8ff1zOdnQdqfJyOhzlow9BswquCJJwO5kT5QJ1QyGGLZzTPvfAFh2Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4056
Received-SPF: pass client-ip=40.107.92.49; envelope-from=saipava@xilinx.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 10:14:17
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
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
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Vikram Garhwal <fnuv@xilinx.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Paul Zimmerman <pauldzim@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ying Fang <fangying1@huawei.com>,
 =?iso-8859-1?Q?=27Marc-Andr=E9_Lureau=27?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?=27Philippe_Mathieu-Daud=E9=27?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Gerd,

Any review on V3. So that I can work on.

Regards,
Sai Pavan

> -----Original Message-----
> From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> Sent: Tuesday, July 7, 2020 10:14 PM
> To: Gerd Hoffmann <kraxel@redhat.com>; Peter Maydell
> <peter.maydell@linaro.org>; Markus Armbruster <armbru@redhat.com>
> Cc: Thomas Huth <thuth@redhat.com>; Eduardo Habkost
> <ehabkost@redhat.com>; qemu-devel@nongnu.org; Alistair Francis
> <alistair.francis@wdc.com>; 'Marc-Andr=E9 Lureau'
> <marcandre.lureau@redhat.com>; Ying Fang <fangying1@huawei.com>;
> Paolo Bonzini <pbonzini@redhat.com>; 'Philippe Mathieu-Daud=E9'
> <philmd@redhat.com>; Vikram Garhwal <fnuv@xilinx.com>; Paul
> Zimmerman <pauldzim@gmail.com>; Sai Pavan Boddu <saipava@xilinx.com>
> Subject: [PATCH v3 0/3] Make hcd-xhci independent of pci hooks
>=20
> Hi
>=20
> This patch series attempts to make 'hcd-xhci' an independent model so it =
can
> be used by both pci and system-bus interface.
>=20
> Changes for V2:
>     Make XHCIState non-qom
>     Use container_of functions for retriving pci device instance
>     Initialize the AddressSpace pointer in PATCH 1/3 itself Changes for V=
3:
>     Convert XHCIState to TYPE_DEVICE and register as a child of XHCIPciSt=
ate.
>=20
>=20
> Sai Pavan Boddu (3):
>   usb/hcd-xhci: Make dma read/writes hooks pci free
>   usb/hcd-xhci: Move qemu-xhci device to hcd-xhci-pci.c
>   usb/hcd-xhci: Split pci wrapper for xhci base model
>=20
>  hw/usb/Kconfig        |   6 ++
>  hw/usb/Makefile.objs  |   1 +
>  hw/usb/hcd-xhci-nec.c |  18 ++--
>  hw/usb/hcd-xhci-pci.c | 242
> ++++++++++++++++++++++++++++++++++++++++++++++
>  hw/usb/hcd-xhci-pci.h |  45 +++++++++
>  hw/usb/hcd-xhci.c     | 259 ++++++++++----------------------------------=
------
>  hw/usb/hcd-xhci.h     |  20 ++--
>  7 files changed, 367 insertions(+), 224 deletions(-)  create mode 100644
> hw/usb/hcd-xhci-pci.c  create mode 100644 hw/usb/hcd-xhci-pci.h
>=20
> --
> 2.7.4


