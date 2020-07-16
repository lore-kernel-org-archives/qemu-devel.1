Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC614C433E4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 13:14:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7294520760
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 13:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="j/N0z2Vp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7294520760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw3i8-0001eh-Ox
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 09:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jw3h2-0000nF-6r
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 09:12:57 -0400
Received: from mail-co1nam11on2085.outbound.protection.outlook.com
 ([40.107.220.85]:46337 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jw3gx-0000Vs-Sx
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 09:12:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C3VhnfpM6PqM9OKW4U2fiWdJRiIkIq8xbanzz+bnVu8BZUe6rbxW4eiZFzUsHojXB+TSD/qvUUQ3TM0cWhCW74itQQ/cNOZeI/RgsOpOEJhG64+tQeiLohTnfsFXi4KquJcz0Q169D6HYzHAY7iqsVImkVI6gOuIoOio4ae31YbJhX9aTFjAZszkRB7SO1s3ArtjNYv02RW2RhM7QW5FnGCZAY1Mezg9pUWU9PjwONN29Qd9N1AN4hzGdv1ZCDNBXflq7HGsOLpdT0X6Dnc7hx4vUZeVeliNZ9XBTC3FUDZw+rCYp40pu94AWs3C/vLXlrrvNsSO90BDJXQmuJ8Z3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z19xqZfmfBfSXKcvZnOjq2kiXs2Qz/Fmsb1Z03t+XzA=;
 b=lROvgDPCU3qL3KWv/3O5yYP0uEKsZvXARoGbmpo/1KyjrkqOWvDqMXQROD3uflBoO10wGICvRk6haAC45ARTv9D3bfyPUg2IAu33Gkp+w5bMXpwg7FlmOB+0KdR+Wf3cTcRIOjACXkImNTORSUGyRvyZPUONM7natcjg3p9bluq4vJ7gKiAjeGYNa5LoOfe1rrCaK2s/gDGCztHHyvKzkFte0wtfYTLTYtfqdHErQPEZM3izFg4lhpvwET/4ffUfzqVNdkJ1XFDWd+cIJiBIKijU/V88wHqc6gznunyt0bfvAXFSXH2BS/0N+PjkxIePQ2QPCW1rA8/lKkOR6KDC0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z19xqZfmfBfSXKcvZnOjq2kiXs2Qz/Fmsb1Z03t+XzA=;
 b=j/N0z2VpdRf1g7h5FZbMdwPaOdn37flA8WRqP5l9qtM4zCOYjMVaT5WO27iVl1bRMbqqz7YNoJLJa3CFaTaEBoWyCK0bdqNwWwH4THcH5LxKZfxFQ+tb4zP9gEMjFRUbBRHXb+z6yC7/kHMIDzw+EqY+f0gSv9hWcdacpDONnhc=
Received: from BY5PR02MB6772.namprd02.prod.outlook.com (2603:10b6:a03:206::11)
 by BYAPR02MB6437.namprd02.prod.outlook.com (2603:10b6:a03:120::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Thu, 16 Jul
 2020 12:57:45 +0000
Received: from BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::4477:7134:37a6:c828]) by BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::4477:7134:37a6:c828%3]) with mapi id 15.20.3174.026; Thu, 16 Jul 2020
 12:57:44 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: RE: [PATCH v3 0/3] Make hcd-xhci independent of pci hooks
Thread-Topic: [PATCH v3 0/3] Make hcd-xhci independent of pci hooks
Thread-Index: AQHWVH9z5HwbdGG7uECzkfpq3kp5uKkHJK6AgAFeDwCAAbVsMA==
Date: Thu, 16 Jul 2020 12:57:44 +0000
Message-ID: <BY5PR02MB67727B3D3EE0AC2572CBB74DCA7F0@BY5PR02MB6772.namprd02.prod.outlook.com>
References: <1594140271-16462-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <BY5PR02MB6772B76423A07CFA4B4E5FA9CA610@BY5PR02MB6772.namprd02.prod.outlook.com>
 <20200715105118.kslptf22i5t7icdy@sirius.home.kraxel.org>
In-Reply-To: <20200715105118.kslptf22i5t7icdy@sirius.home.kraxel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9428c8f6-c39d-47d0-2401-08d82987d55e
x-ms-traffictypediagnostic: BYAPR02MB6437:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB6437D8AA05DE1BABAA18D93BCA7F0@BYAPR02MB6437.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3WeR8QLvb71Jqw0Rq3Zt0x86lQhdpymbQU2Sk+gWXtk8Or/1xj/ejUVLc1+k1DHfpgK4e7vJefgQ4z5HfnOzY6CNwnZ7/kBOX3FmBjCNLl7Of7758iInFU9k62/XsJo5KG3TAVIE5Tp45FeKQhIBA4DSPfCGRMCtsLPoO8n0eG7Rv+ZiUHd3om/PEjtHkW6167jochWtObhBmudm1KW8Zh6e3jmknOi/gQxzzZE7hXmGpSQMRhGOBHhooFzUMAN4ii2uvhGobjXDLhHfev666PgNHgoCfZMNieaqlrYMsY1Jn7/nw420xeDq/0DIKvoZpqVBsThKJ3GwlbUiq8CcVg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6772.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(136003)(396003)(366004)(39860400002)(346002)(376002)(5660300002)(86362001)(2906002)(9686003)(66556008)(7696005)(66476007)(4744005)(64756008)(66446008)(66946007)(53546011)(71200400001)(6506007)(8676002)(26005)(76116006)(54906003)(52536014)(6916009)(8936002)(186003)(316002)(55016002)(33656002)(478600001)(7416002)(83380400001)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: MlnkElmVsPYIiMeVUbvUvmIUMG4isxU1uIcyOzQnjZlz4ek9ekuRLV6xycep4G/kQt+T0A7NC0W94GxaOsRDh6SzC7Au3CU17Enjd0t0yHaKmRY+nu1l2fMppRykJGSBZMZTahzxtuzzBzkkQpZCEyoAotDgAqz8I891+b221AdMnZtPsMliSk2d6VhrvSKsSkaqOW8YtnnWOP3XWYtM1TArQfDBZvcZgPVcKln2fdGRV+fHctIKIMg+wZ4eQs2YqJoPysKWoHMrbdEEKnWcRK5I3fU10sDBP/44xPOYVDwWHQQ+sug9z9RK5wN/Gk96mXrIfGFBBie461h0deoNejUPnP3MLEd+dSYh2VzQA08C9SZwI/BZYwq3u2IlIbH+a2TGsMNqh1K9sz49LjxwUuhQUmS2SUayuo9zXPh8pVFgolw4EYWFnIauuQWmSq1T+onU9N9aV5+4DaR8BT4s9/CoARgxUNIo4nRmaLO1H9DIjLdu9zy/eyf1zvQnaMeL
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6772.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9428c8f6-c39d-47d0-2401-08d82987d55e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2020 12:57:44.8362 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WB5Z7bPYxrMTGQFdvR9bDDxFlCaWXKXvi4fFMBDCDm5q+JQ3ty5gV6tja8193YF5wOsAdduQmrWLnLgQ6i7YyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB6437
Received-SPF: pass client-ip=40.107.220.85; envelope-from=saipava@xilinx.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 09:12:48
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Vikram Garhwal <fnuv@xilinx.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ying Fang <fangying1@huawei.com>,
 =?iso-8859-1?Q?=27Marc-Andr=E9_Lureau=27?= <marcandre.lureau@redhat.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 =?iso-8859-1?Q?=27Philippe_Mathieu-Daud=E9=27?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Gred,

> -----Original Message-----
> From: Gerd Hoffmann <kraxel@redhat.com>
> Sent: Wednesday, July 15, 2020 4:21 PM
> To: Sai Pavan Boddu <saipava@xilinx.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>; Markus Armbruster
> <armbru@redhat.com>; Thomas Huth <thuth@redhat.com>; Eduardo
> Habkost <ehabkost@redhat.com>; qemu-devel@nongnu.org; Alistair Francis
> <alistair.francis@wdc.com>; 'Marc-Andr=E9 Lureau'
> <marcandre.lureau@redhat.com>; Ying Fang <fangying1@huawei.com>;
> Paolo Bonzini <pbonzini@redhat.com>; 'Philippe Mathieu-Daud=E9'
> <philmd@redhat.com>; Vikram Garhwal <fnuv@xilinx.com>; Paul
> Zimmerman <pauldzim@gmail.com>
> Subject: Re: [PATCH v3 0/3] Make hcd-xhci independent of pci hooks
>=20
> On Tue, Jul 14, 2020 at 01:59:12PM +0000, Sai Pavan Boddu wrote:
> > Hi Gerd,
> >
> > Any review on V3. So that I can work on.
>=20
> Busy due to freeze, sorry for the delay.
> Looks good to me overall.  Not tested yet.
>=20
> Wasn't the plan to include the sysbus bits too, so it's easier to see how=
 code
> code separation works out on both pci and sysbus?
[Sai Pavan Boddu] Ok, I will include that in V4.

Thanks,
Sai Pavan
>=20
> take care,
>   Gerd


