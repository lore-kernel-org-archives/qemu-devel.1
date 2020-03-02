Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A75C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 20:04:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 243FA21556
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 20:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="gydTYSCl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 243FA21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8rJ3-0007sm-AT
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 15:04:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33912)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sunilmut@microsoft.com>) id 1j8rIF-00078m-Pr
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 15:04:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sunilmut@microsoft.com>) id 1j8rIE-00024j-M5
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 15:03:59 -0500
Received: from mail-bn8nam11on2114.outbound.protection.outlook.com
 ([40.107.236.114]:60480 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sunilmut@microsoft.com>)
 id 1j8rIE-00022g-Hf
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 15:03:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1hbfAUxSZh2obdSUQmeeMa508uZbLW06wpfrDW/j4a0WHOD+xCH4gBYIrFhvwNCOOrvwhXTOBs1JKdRuTIb5Azur2mMjkw3VuGVFI+I2nPiZtmi6DrxWm61BX04WHNU6F+UB7s6PBtGcZ3PCdafNe23U/GX4LgXh3M7OypwuzSNnj816avPQkX9jKNKY6JoxxLsRwNpZc8sdRLE/uhZnJdXFKEWIrtcfxxotoRFPn9clzCcn5Z/g3WNaENeOBt9wVtwlwSmataxjI43egd8IZxVXM2zs/gEx7Udkjl0TlUP7eYbuNHghVKaHrFTjEniY7KmXMk42Q/qA8NpdAAhug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMML/CTueYHNz4PYdg+r4YOO/yDEaE7Tw/58FO1cNjA=;
 b=FLnNA6jJevHXl0bIk+TdR55bI7k91q1hftsEnQU5mRr1AYLgMXGhd929uTOqYxP2D0klE+CMycDOoF2ojbrOr0zVteKf7rbMyTHVkq/x+kUYBDszW+T/h44jqC1xVkMY1skL6PeHZsUJLfwDwL0YcmGbO8sRUjSQzrzMSDGE1Cndc9fnMGV6R9DfJnBRfqrklTEPDozJOawbP9+LRW/7PDCQ7L9RpG6J+JKmtbBsrFDIqi9Op9gOkjDZAvoo7HBbrNGOCV9eLq8Uj6DdwRm8QOK/hJOaudh4KoUxa0igi0bv+xchXUcyyRO7CnjTMAOYd15H02dL1xu5OFjKUd+72Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMML/CTueYHNz4PYdg+r4YOO/yDEaE7Tw/58FO1cNjA=;
 b=gydTYSClw2thpLR5/yEUe/sf1uioZkbMdmLykJaN/XoZS+GtHTg1GqwgB9oL8fJbTW1BGBOwk26YeNO1Ym3K1QJYWuIKJd2GTMVz0XfehR/4WEZW/TUuaIiMp4UquWp1hBAdWXQPmc2aObYEm/I/8vkCZkaEpkfU2UwPMEc89+0=
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 (2603:10b6:803:51::33) by SN4PR2101MB0735.namprd21.prod.outlook.com
 (2603:10b6:803:51::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.0; Mon, 2 Mar
 2020 20:03:55 +0000
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::b1fc:af97:6a7b:4fe]) by SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::b1fc:af97:6a7b:4fe%5]) with mapi id 15.20.2814.001; Mon, 2 Mar 2020
 20:03:55 +0000
From: Sunil Muthuswamy <sunilmut@microsoft.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, 
 Eduardo Habkost <ehabkost@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefan Weil
 <sw@weilnetz.de>, "Justin Terry (SF)" <juterry@microsoft.com>
Subject: RE: [PATCH] WHPX: Use proper synchronization primitives while
 processing
Thread-Topic: [PATCH] WHPX: Use proper synchronization primitives while
 processing
Thread-Index: AdXrRhI7Cc8PiKCvTlmOyf8oQX8z/gFh4vkg
Date: Mon, 2 Mar 2020 20:03:55 +0000
Message-ID: <SN4PR2101MB08809732CE13BD1F8AF116E6C0E70@SN4PR2101MB0880.namprd21.prod.outlook.com>
References: <SN4PR2101MB0880A1C19D64131DE3D261B5C0EC0@SN4PR2101MB0880.namprd21.prod.outlook.com>
In-Reply-To: <SN4PR2101MB0880A1C19D64131DE3D261B5C0EC0@SN4PR2101MB0880.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sunilmut@microsoft.com; 
x-originating-ip: [2001:4898:80e8:9:13f8:4346:c8dc:67a9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dbcab71c-5a87-4223-1d96-08d7bee4d68f
x-ms-traffictypediagnostic: SN4PR2101MB0735:|SN4PR2101MB0735:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR2101MB073580C4B2CE7D92FF87C883C0E70@SN4PR2101MB0735.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:346;
x-forefront-prvs: 033054F29A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(189003)(199004)(10290500003)(186003)(53546011)(6506007)(81166006)(8676002)(81156014)(4326008)(66476007)(66556008)(52536014)(107886003)(66946007)(5660300002)(2906002)(8936002)(64756008)(66446008)(54906003)(478600001)(55016002)(71200400001)(8990500004)(9686003)(76116006)(86362001)(7696005)(33656002)(316002)(110136005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN4PR2101MB0735;
 H:SN4PR2101MB0880.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p/3LfIkktETi6QC/A4tbCzIHanCpb3GxgyXFzS+sSCgF6Y+8fPd6E0mhMXr9EXTamjDafDiYh/TOCxHOg8Nm4R4py24CH4blFELZ0CTEGkhbF8BghAp/XqkDLkoYPoFAjHU8GaVkK9bEo4Mx807Co0hQNWn/j/qyufQ4nexyHzvKghT5J2pI/s6ntHk8XpeGHxy8JiRce6Ln1N5XPTQfbiXU74nOg1tDlOsvgwkpXBWKmFMmoel9sTpKFvOpIDM6OMcZZs5jdoziVrGIeqhiEkysTOfPotMlVF7bH4Pgjk9p4jsW9pyxyo4Xjw1a7/MavpxP2cG4uvSw6oAs6JqKM4zbjx4YXBRY9YG8PKjG0O67l6kCCqQvDU132dhyRZ7WxvRfmfunRLs/264OMKxvN5R0iSqTkK2/bJHDr8fBs7tx4D71X3dBzQAo6tAoo7aM
x-ms-exchange-antispam-messagedata: SLSHt0wUWBxSr4pofzQzqjRGOrj7YfQISAWfvsV8qFGZoxb5YHfZHZDRjZcn3z4UbbESNWvILIEQRuyQXSbHUoY8alQ0eoXO2KgF9Dv0BPNBlBh7+VKT/7cVqKWA11GLmMrXU7odTg+1cwq45yM3uiKgAJAipCuIF0qQzH8tvnQMAvuBJEf/DdYg38UhBJYOrdiMy0Fz/Y5WDN7VCz0Grg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbcab71c-5a87-4223-1d96-08d7bee4d68f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 20:03:55.6749 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gu0JR1kRi8hjH51FUBFW5ujn0ngoP2SInhS6cqFhM+b68GqryOqSaVPMDw3invwFnXjrCIqeTwNruHMIr/j5eRpKKHpsNnyoBfFSIY/8h0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR2101MB0735
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.236.114
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

> -----Original Message-----
> From: Sunil Muthuswamy
> Sent: Monday, February 24, 2020 11:28 AM
> To: Paolo Bonzini <pbonzini@redhat.com>; Richard Henderson <rth@twiddle.n=
et>; Eduardo Habkost <ehabkost@redhat.com>
> Cc: qemu-devel@nongnu.org; Stefan Weil <sw@weilnetz.de>; Justin Terry (SF=
) <juterry@microsoft.com>
> Subject: [PATCH] WHPX: Use proper synchronization primitives while proces=
sing
>=20
> WHPX wasn't using the proper synchronization primitives while
> processing async events, which can cause issues with SMP.
>=20
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> ---
>  target/i386/whpx-all.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
>=20
> diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
> index 35601b8176..868ade5fd0 100644
> --- a/target/i386/whpx-all.c
> +++ b/target/i386/whpx-all.c
> @@ -841,9 +841,8 @@ static void whpx_vcpu_process_async_events(CPUState *=
cpu)
>=20
>      if ((cpu->interrupt_request & CPU_INTERRUPT_INIT) &&
>          !(env->hflags & HF_SMM_MASK)) {
> -
> +        whpx_cpu_synchronize_state(cpu);
>          do_cpu_init(x86_cpu);
> -        cpu->vcpu_dirty =3D true;
>          vcpu->interruptable =3D true;
>      }
>=20
> @@ -859,17 +858,13 @@ static void whpx_vcpu_process_async_events(CPUState=
 *cpu)
>      }
>=20
>      if (cpu->interrupt_request & CPU_INTERRUPT_SIPI) {
> -        if (!cpu->vcpu_dirty) {
> -            whpx_get_registers(cpu);
> -        }
> +        whpx_cpu_synchronize_state(cpu);
>          do_cpu_sipi(x86_cpu);
>      }
>=20
>      if (cpu->interrupt_request & CPU_INTERRUPT_TPR) {
>          cpu->interrupt_request &=3D ~CPU_INTERRUPT_TPR;
> -        if (!cpu->vcpu_dirty) {
> -            whpx_get_registers(cpu);
> -        }
> +        whpx_cpu_synchronize_state(cpu);
>          apic_handle_tpr_access_report(x86_cpu->apic_state, env->eip,
>                                        env->tpr_access_type);
>      }
> @@ -1067,8 +1062,10 @@ static int whpx_vcpu_run(CPUState *cpu)
>=20
>  static void do_whpx_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data=
 arg)
>  {
> -    whpx_get_registers(cpu);
> -    cpu->vcpu_dirty =3D true;
> +    if (!cpu->vcpu_dirty) {
> +        whpx_get_registers(cpu);
> +        cpu->vcpu_dirty =3D true;
> +    }
>  }
>=20
>  static void do_whpx_cpu_synchronize_post_reset(CPUState *cpu,
> --
> 2.17.1

Can we please get this reviewed/queued till I figure out the GPG key thing?

