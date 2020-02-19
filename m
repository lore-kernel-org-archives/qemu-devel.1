Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A327EC34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 15:51:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C80724656
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 15:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="DdOrKeq1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C80724656
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4RdU-0004T7-MR
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 10:51:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34286)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <juterry@microsoft.com>) id 1j4RcS-00043T-Ms
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 10:50:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <juterry@microsoft.com>) id 1j4RcQ-0001h5-2i
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 10:50:35 -0500
Received: from mail-co1nam11on2109.outbound.protection.outlook.com
 ([40.107.220.109]:8288 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <juterry@microsoft.com>)
 id 1j4RcP-0001dx-MC
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 10:50:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YvIHjrg4mc5Ht1TFk4zzYXoyHDXAPiJVqCUzBWmO5a/QsiwdKvTVv/uuXwOUPvkMqyqotbd34/MtI2RTjEGr4vOX/atUHXcualyJPcgH0vm4BgcGdenIt4rNoaRQvydHRNrfQmzYNlmymzrnQcq2sjQ8LKpBsnZvAaaznqhKfmMze4xZHPkSxrTpG0qUG5qNrgK45ocy3ROCeyyKCxvvrjygz5r4R6Q2UsUQSbG105HVtNf6etc4s35ePx6K5FekD1uC/tTBEEv9Gst44VcsKPntIXEFq6BemL7QUl6ELW1tJTUXlc/F8OV2aY47wuQyJEMUfzh5SZ1OFQH/A8Za6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXzFAgegLjzt+n0B3GlScnBiRcJOvaw077Gmdfs+SaE=;
 b=LpZrMlBEpIK6bF13pt+F4GXT8oode/Q+VRWMwe3axlonxWBDWI14O168e1Ijn1Xcgn9CtsOWqlfjtZU62qKXwOBJkhnxIf+l252d4GFUKh9rh/59imohVDZIpV6eYuer3F9VKIXzymo8BRJQVa04O2GQCZyCZYHS5Zv9Totb1SgSNjSCfgTjl0AOqoVkSyDxpPq4dgZw/Xi2i9sO5OAE0hR54ErzdbIbGuZNstT8b/PLQucEC9Mo1OH5t7aPZRxowwJsglWrPVYefnOO6nV32SIm7L42UkZ1XL4ZdWp+ADEvOjSh0bwU5gg0Vf2gAGkMWcgpXoVGWuktYzzZqbHTwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXzFAgegLjzt+n0B3GlScnBiRcJOvaw077Gmdfs+SaE=;
 b=DdOrKeq1c8m+NKzKJC5ZP2zlXCuPzF5fz5gxk+1cNONQu6rmu5zny2bUAA7tJTrtrNx8sF6FZRWLwNUofdhrkvIug42aPupk9h1a1DewMRbcxnKYCs+apC8uqcWzQEsnRog0kLCYEJX8mhyW+lD04hPxcNBN97UVLuc39erkDnE=
Received: from BN8PR21MB1297.namprd21.prod.outlook.com (20.179.74.207) by
 BN8PR21MB1250.namprd21.prod.outlook.com (20.179.74.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.5; Wed, 19 Feb 2020 15:50:29 +0000
Received: from BN8PR21MB1297.namprd21.prod.outlook.com
 ([fe80::b03c:f27:72c7:8b9b]) by BN8PR21MB1297.namprd21.prod.outlook.com
 ([fe80::b03c:f27:72c7:8b9b%7]) with mapi id 15.20.2772.004; Wed, 19 Feb 2020
 15:50:29 +0000
From: "Justin Terry (SF)" <juterry@microsoft.com>
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>, Sunil
 Muthuswamy <sunilmut@microsoft.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
CC: Stefan Weil <sw@weilnetz.de>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [EXTERNAL] Re: [PATCH] WHPX: Assigning maintainer for Windows
 Hypervisor Platform
Thread-Topic: [EXTERNAL] Re: [PATCH] WHPX: Assigning maintainer for Windows
 Hypervisor Platform
Thread-Index: AdXmmxkvbI0n3XG6RKSCtw/4QRCyRQAAgE9wABh4YAAAD08KsA==
Date: Wed, 19 Feb 2020 15:50:29 +0000
Message-ID: <BN8PR21MB12974CEDAEC173FC8CD626DFB6100@BN8PR21MB1297.namprd21.prod.outlook.com>
References: <SN4PR2101MB0880E245954826FD91C9D67DC0110@SN4PR2101MB0880.namprd21.prod.outlook.com>
 <BN8PR21MB1297D3D88C41B6AFADE36DCCB6110@BN8PR21MB1297.namprd21.prod.outlook.com>
 <ecc9b0c5-7cd7-1f8d-d10c-bee7aff8fa01@redhat.com>
In-Reply-To: <ecc9b0c5-7cd7-1f8d-d10c-bee7aff8fa01@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=juterry@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-02-19T15:50:28.4146355Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=658a359d-51aa-47cc-a510-1d168f0b788e;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=juterry@microsoft.com; 
x-originating-ip: [67.185.128.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3febc573-df70-4252-6514-08d7b553721c
x-ms-traffictypediagnostic: BN8PR21MB1250:|BN8PR21MB1250:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR21MB12504E3FAB5AAA3D9EFDAC86B6100@BN8PR21MB1250.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:446;
x-forefront-prvs: 0318501FAE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(199004)(189003)(110136005)(54906003)(66476007)(478600001)(52536014)(66946007)(7696005)(81156014)(64756008)(66556008)(10290500003)(76116006)(66446008)(316002)(5660300002)(26005)(2906002)(4326008)(9686003)(33656002)(55016002)(81166006)(86362001)(8936002)(8990500004)(6506007)(186003)(53546011)(8676002)(71200400001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BN8PR21MB1250;
 H:BN8PR21MB1297.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wf1/eQwZUgxMQvzHLBYyNYrjyNs0UhZAP9w+Px0485lLu9xyJGTzIOotmERtaMmzZ6ffTHDBHiMNj4tr0ILNxKExKWrExeWmYdYz0VtzZyCEqybvE9994zMdJBtP86BuOd7u/lYC/IQpxfm/VU/i5+VyB51/RaLPILx5tBWBxv300/SHZJVjC6gYs2j+7q3KAmyWYibnjJfeN+ouDetb9o6u+fvdxjzQTYAL9k47AarNvJpgv0T02lzvbSkMsKGwDPaxyT0K0oGV46f9mcxVo/5liFt0OoZdrLeyw8j6m9yF5aY5DrNKsWMGzrDRJga0M8uTavFE3yukxUSbT0nSWAwOAdHIBo1j89u76BVD7TIcyoH9lQQXVHOnhQYXpZbbYp8EEUD8kvx9XhNenXgaK3WWKLShwsczMJINvEUvlAL53HYQERLZdwB6AUUL3W2X
x-ms-exchange-antispam-messagedata: tvVlKD8+624fEYpccIaqUBoWRii/oEO6RQov5z7HATx+0BIZtUOEXAQ6pYGPxLwlbNoS+xCd9Vibrj5FQvsedX+W6Fww+JZuem/JrSA2xOmOxCkljuxRn2I7WoTgjoKfPprRNH+YPye6oORLs0JHLQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3febc573-df70-4252-6514-08d7b553721c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2020 15:50:29.5592 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /7zNdgg+fDxWNixLGh35rEkmmhO7dBHaLvTU0Eagu/ZyDjGIBqZUv6FT72gTxfLU3EZG/WyrbwBX8CPw2hFxgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1250
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.220.109
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

Ha yes. LGTM Thanks!

Reviewed-by: Justin Terry (VM) <juterry@microsoft.com>

> -----Original Message-----
> From: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Sent: Wednesday, February 19, 2020 12:32 AM
> To: Justin Terry (SF) <juterry@microsoft.com>; Sunil Muthuswamy
> <sunilmut@microsoft.com>; Eduardo Habkost <ehabkost@redhat.com>;
> Paolo Bonzini <pbonzini@redhat.com>; Richard Henderson
> <rth@twiddle.net>
> Cc: Stefan Weil <sw@weilnetz.de>; qemu-devel@nongnu.org
> Subject: [EXTERNAL] Re: [PATCH] WHPX: Assigning maintainer for Windows
> Hypervisor Platform
>=20
> Thank you Sunil!
>=20
> On 2/18/20 9:51 PM, Justin Terry (SF) wrote:
> > Looks good to me! Thanks Sunil.
> >
> > Signed-off-by: Justin Terry (VM) <juterry@microsoft.com>
>=20
> Justin, I suppose you meant:
> Reviewed-by: Justin Terry (VM) <juterry@microsoft.com>
>=20
> >
> >> -----Original Message-----
> >> From: Sunil Muthuswamy <sunilmut@microsoft.com>
> >> Sent: Tuesday, February 18, 2020 12:39 PM
> >> To: Eduardo Habkost <ehabkost@redhat.com>; Paolo Bonzini
> >> <pbonzini@redhat.com>; Richard Henderson <rth@twiddle.net>
> >> Cc: Stefan Weil <sw@weilnetz.de>; qemu-devel@nongnu.org; Justin
> Terry
> >> (SF) <juterry@microsoft.com>
> >> Subject: [PATCH] WHPX: Assigning maintainer for Windows Hypervisor
> >> Platform
> >>
> >> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> >> ---
> >>   MAINTAINERS | 8 ++++++++
> >>   1 file changed, 8 insertions(+)
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS index 1740a4fddc..9b3ba4e1b5
> >> 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -404,6 +404,14 @@ S: Supported
> >>   F: target/i386/kvm.c
> >>   F: scripts/kvm/vmxcap
> >>
> >> +WHPX CPUs
>=20
> Using "X86 WHPX CPUs" instead:
>=20
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
>=20
> >> +M: Sunil Muthuswamy <sunilmut@microsoft.com>
> >> +S: Supported
> >> +F: target/i386/whpx-all.c
> >> +F: target/i386/whp-dispatch.h
> >> +F: accel/stubs/whpx-stub.c
> >> +F: include/sysemu/whpx.h
> >> +
> >>   Guest CPU Cores (Xen)
> >>   ---------------------
> >>   X86 Xen CPUs
> >> --
> >> 2.17.1
> >


