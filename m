Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7F3C3404B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 20:52:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2666D206F4
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 20:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="eB0bLpEN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2666D206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j49rP-0006E1-Bv
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 15:52:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48134)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <juterry@microsoft.com>) id 1j49qT-0005RJ-8T
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 15:51:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <juterry@microsoft.com>) id 1j49qQ-0006Al-OY
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 15:51:52 -0500
Received: from mail-bn8nam11on2125.outbound.protection.outlook.com
 ([40.107.236.125]:7201 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <juterry@microsoft.com>)
 id 1j49qP-00067N-LG
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 15:51:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AiVyCtgqTwiXexpC3GLz0U+wNoc2pvQIo3w0T/n1jxMIYS8q0P3ZicWkmWti7TX7uZClorZ2gg6cGsLisp/N0p7IooeSXMmDlHrQAOFGNStwesCPAS1ArspzLRo6Cx0R7jeB+43NQBMJp77uOydPwvNoU+hhO1VDsRHNFJ5ihRLURKqhm6k74pOqwIojUoyi5scBTE9gdNA0VvX1Axf4EaHXwr74XzhdSLfmFpZPzWaeV+2OGp1gUUd8JOVsClirfHEYo/Gyzc/nPFqmmx7WdFptYT5fsp4I2k9iN8AtB4ORYYhB5qm08krsTrfRw2noPyaX022Uy8HEe1FrAoW1PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SqKdxnB2WRZWiDMkmhHkYARaMVTgbGNNlrZbsi1DCtI=;
 b=b3rKvjAVXrDJf9on9RDsKP+yzFoEnzVFgumW7Fyk3GJyAuHshYPDmcU4fJwYNtCPQ5QSrRG/RTCJ+XdzrKERbamNqq8s1S0ByrE/3zsAo1eEyCJY886/0PlKYll3BDyzVPQM+CanUGl7gxOhhMEEFRWdXVdXUGnOTqvryJaYE6AO0iJbkY3qW0t3X6XqqAjNnyLlNUWnt22Y0OHUmU8o5btQyki5Xp+Vw6iFH8vhBZqPaUKiLDWs9VyrDHv6msAcenFBNSdCWoJEa1awcz/aswQHegtYfboM/uZPAhdxV5ErZba/h24D0yOa/VO38c2nK9hxSySxAug6RuP5Ch9U0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SqKdxnB2WRZWiDMkmhHkYARaMVTgbGNNlrZbsi1DCtI=;
 b=eB0bLpENtltgATh0EUMpUHLKspHC4u/mTUuys8DBPBw9vAz7X1522jKWlawJzGW/cZYwPP0T9a0PoBXe4gDtl0YWFAJaktbSiDLp+MCzJ9VJY9hsLrOCR27INoQnPN5/MDpvXhvUpOdLccGWD0hQdl1uM7D93BCsTpJnQTN+phE=
Received: from BN8PR21MB1297.namprd21.prod.outlook.com (20.179.74.207) by
 BN8PR21MB1186.namprd21.prod.outlook.com (20.179.73.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.5; Tue, 18 Feb 2020 20:51:47 +0000
Received: from BN8PR21MB1297.namprd21.prod.outlook.com
 ([fe80::b03c:f27:72c7:8b9b]) by BN8PR21MB1297.namprd21.prod.outlook.com
 ([fe80::b03c:f27:72c7:8b9b%7]) with mapi id 15.20.2772.004; Tue, 18 Feb 2020
 20:51:47 +0000
From: "Justin Terry (SF)" <juterry@microsoft.com>
To: Sunil Muthuswamy <sunilmut@microsoft.com>, Eduardo Habkost
 <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <rth@twiddle.net>
CC: Stefan Weil <sw@weilnetz.de>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH] WHPX: Assigning maintainer for Windows Hypervisor Platform
Thread-Topic: [PATCH] WHPX: Assigning maintainer for Windows Hypervisor
 Platform
Thread-Index: AdXmmxkvbI0n3XG6RKSCtw/4QRCyRQAAgE9w
Date: Tue, 18 Feb 2020 20:51:47 +0000
Message-ID: <BN8PR21MB1297D3D88C41B6AFADE36DCCB6110@BN8PR21MB1297.namprd21.prod.outlook.com>
References: <SN4PR2101MB0880E245954826FD91C9D67DC0110@SN4PR2101MB0880.namprd21.prod.outlook.com>
In-Reply-To: <SN4PR2101MB0880E245954826FD91C9D67DC0110@SN4PR2101MB0880.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=juterry@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-02-18T20:51:45.5718511Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3dabcb1c-1ada-49bb-8a95-260961e74438;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=juterry@microsoft.com; 
x-originating-ip: [67.185.128.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2ebd86cd-3419-4a15-71ed-08d7b4b45f18
x-ms-traffictypediagnostic: BN8PR21MB1186:|BN8PR21MB1186:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR21MB118616E2ED53AF352B3945B9B6110@BN8PR21MB1186.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-forefront-prvs: 031763BCAF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(189003)(199004)(186003)(86362001)(8990500004)(9686003)(5660300002)(55016002)(8936002)(71200400001)(2906002)(478600001)(33656002)(26005)(110136005)(52536014)(4326008)(8676002)(53546011)(6506007)(66446008)(66556008)(64756008)(66476007)(66946007)(7696005)(10290500003)(81166006)(76116006)(54906003)(4744005)(316002)(81156014);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BN8PR21MB1186;
 H:BN8PR21MB1297.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MLz1wJYrjdEJjq2ErImxNufKgKYiSsRqvPC/5eHsEpmNLrzaGSu6CYbFpwPIW2hcPjuxXYTVmCiBRm6+d1YmZRxY1gvZkPUrnWAc+hIS7I9wYbHXaCfIeCZTM/NhjYtR1a+UbBP76G1A2DI3dTKMoDQFCpVyE+qfeeXuQ5MaGoarZomUqg0WO+c3XV7pOa6skcNByAVdCX5XOSY+WwiIGdvE4gMnGfc+9bEgL4QNOie7769e8HNMq0z8u4uC/bwEpP0McqeRoYr6hjXuhSQ2nA5+Hk4HUwZ3aoHGbR7LkqUCz7+ZzVFI5fiLQCrFVBxA0I7BSBk+eD4DoLpfPr1fL6G7isNA5FqJ5ZrQX5GdsP/pzBpBbraLDaOQKfU8+VhAhuEDboly76NlF2tjq5WAfrtuVdKDpTekAdW2VlreyiB9WYID8ucXHPwaqolucZBR
x-ms-exchange-antispam-messagedata: zqc3axoh+6pGDdE6cU7IbYkH5TwE5yvQFuJW7fbKs8IYeB+w1uqnnKNs4Xu8tWTsz0DPFjuPq3m7y8Gf/X65P4bX2RF/Aj2BpYywOHCcbnfCiAf1nz7NURZMx3YxZDG4xfW9h7nAFtqymNoX2sjFJQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ebd86cd-3419-4a15-71ed-08d7b4b45f18
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2020 20:51:47.6816 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M2UN//Ww2wknKttNNOISeZzQw8LccsAb8T/mvd3pF1upiSehaGya4AujHZlPPr8Yzw6AqZcTK2RpVrbgZzt9/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1186
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.236.125
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

Looks good to me! Thanks Sunil.

Signed-off-by: Justin Terry (VM) <juterry@microsoft.com>

> -----Original Message-----
> From: Sunil Muthuswamy <sunilmut@microsoft.com>
> Sent: Tuesday, February 18, 2020 12:39 PM
> To: Eduardo Habkost <ehabkost@redhat.com>; Paolo Bonzini
> <pbonzini@redhat.com>; Richard Henderson <rth@twiddle.net>
> Cc: Stefan Weil <sw@weilnetz.de>; qemu-devel@nongnu.org; Justin Terry
> (SF) <juterry@microsoft.com>
> Subject: [PATCH] WHPX: Assigning maintainer for Windows Hypervisor
> Platform
>=20
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1740a4fddc..9b3ba4e1b5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -404,6 +404,14 @@ S: Supported
>  F: target/i386/kvm.c
>  F: scripts/kvm/vmxcap
>=20
> +WHPX CPUs
> +M: Sunil Muthuswamy <sunilmut@microsoft.com>
> +S: Supported
> +F: target/i386/whpx-all.c
> +F: target/i386/whp-dispatch.h
> +F: accel/stubs/whpx-stub.c
> +F: include/sysemu/whpx.h
> +
>  Guest CPU Cores (Xen)
>  ---------------------
>  X86 Xen CPUs
> --
> 2.17.1

