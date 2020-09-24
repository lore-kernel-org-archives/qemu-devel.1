Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF8DC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 14:10:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8757212CC
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 14:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="b0Dfuh1F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8757212CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLRx0-0006bH-0b
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 10:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kLRvq-0005qj-8x
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 10:09:10 -0400
Received: from mail-bn7nam10on2054.outbound.protection.outlook.com
 ([40.107.92.54]:19553 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kLRvn-0001Fd-HI
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 10:09:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYzB7aKtBQC+jQ2Av9GE8kin9utDir3KqWyhhTK+K1+he82hwuy4m+oO6fGJHpn98eOogBYNP8sw3/HOu+UjQjOe9JHDjEIZnadb4JRL/J7iWw8Qj39e2hDj2YZlsC+zaQAY1aN9hdZc8RqWOZOhbosvGawYfGpyXlNV5Ib5IaSpd1s5s2qY9aZKuZISDb0oA+p7lMJJmVc3ZvbpS1g7rKYQT4IVxhMdY2qWhPRRpTOIr0j5afW/AHXCMGlTmYTLfa/fYL0hyu+sbZETAgf+gzyIXnhdrJwbBLPKqfSdr0ZdyYN3a9OVYwsaB48wUz79jPa8jhgquvtiUq8Gvzb3ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8heo25Rls01Tfc5MpG1lJjsEzLcODH6YJrP76oJZcA=;
 b=iYk5OwYeALsy+8/UCE1nxKUXuYN01gsiKH8me8IOlee/6Bzoppp6rXRShYTGJrJEai2UgEkcsTZ+ZfngaaOjIjUpDxoDDbrocX+5gJJRVpjjHe8FcdNOMsNB4jreZzQkKiKwsv/X7KEkiZM6RrPRL79JTulaIfiVN1+RRd4OVJq7V2E7g4WA/03mpa2B0Oyba619cM+/8FUOHnfMRqfTRqTZD76w1jMatkC76UIU3i1dcE+nZJ7shrbEid008btcYdxjSP2Hbr5ZjSR+Kkt7jL5GMlOsPxnLh5E9BEYuVI6QSALv5bkceGWCxSgUSMQN1KckEeahRXI1d+zbUhK0qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8heo25Rls01Tfc5MpG1lJjsEzLcODH6YJrP76oJZcA=;
 b=b0Dfuh1Fg5nCSQOEibCiMJG/9U55no5XO5ywug1LfJuu/qffiDE2PRnuccmRJtoXknny2MUQvRZfEKrIEFSE78A8YGAEWHsCMa64kGwbjeOczz4VoMgtW/Cw491AJoYLWcVUBghbfhDj8A2TokUNekZe2THKi24ADZe+cmHL0uE=
Received: from BY5PR02MB6772.namprd02.prod.outlook.com (2603:10b6:a03:206::11)
 by BYAPR02MB6438.namprd02.prod.outlook.com (2603:10b6:a03:11d::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.21; Thu, 24 Sep
 2020 14:09:04 +0000
Received: from BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::68a7:8ea6:8731:d69f]) by BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::68a7:8ea6:8731:d69f%6]) with mapi id 15.20.3391.027; Thu, 24 Sep 2020
 14:09:04 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: RE: [PATCH v8 3/7] usb/hcd-xhci: Split pci wrapper for xhci base model
Thread-Topic: [PATCH v8 3/7] usb/hcd-xhci: Split pci wrapper for xhci base
 model
Thread-Index: AQHWkOLKk1Cu3IDKWEiZvWkxL9ktaal2At4AgAB25VCAAMhMAIAAlIsw
Date: Thu, 24 Sep 2020 14:09:04 +0000
Message-ID: <BY5PR02MB6772F84D6E3E6B3ADC719544CA390@BY5PR02MB6772.namprd02.prod.outlook.com>
References: <1600780837-8231-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1600780837-8231-4-git-send-email-sai.pavan.boddu@xilinx.com>
 <20200923101428.zilaxig5yi5u45rn@sirius.home.kraxel.org>
 <BY5PR02MB67721C6F6152DBA2AD4E3663CA380@BY5PR02MB6772.namprd02.prod.outlook.com>
 <20200924051654.phuk3bmqjz3v3lxu@sirius.home.kraxel.org>
In-Reply-To: <20200924051654.phuk3bmqjz3v3lxu@sirius.home.kraxel.org>
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
x-ms-office365-filtering-correlation-id: 1ce81f45-3818-48ec-e641-08d86093650a
x-ms-traffictypediagnostic: BYAPR02MB6438:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB64389FA80CEECD55B856436CCA390@BYAPR02MB6438.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1091;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J8/KIFXprEMbDn09ZhZkW048ezy1uFx7w+sh890WCV+PBdE7FvYKvXo+DKX91z4T5u/GxpJ8zTTcWXo+yGoAott92Ozxh1agxduE4L8PNv6fEMVAdEYfyh75e+fARhyU16JvOnOzqIFrHgbHpX+qYYj6LcrSvIKL+8JvQ6RLtg06gxu8KQ1ybbB5g/aUg6hd5ymzaxZEx3PYyeyToxOHNUMe2RezxvZ5dzvYrRkpt2PMJLvawIngE6I3EYJ27QBvvOAaUNwxr+6OJytKlC9j2gvJNavxjo58d6SqrVGUdfDM1tpdoA5tEmaFVYFMaEhQchnZYjVZJzFYpnGy0sozQQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6772.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(39860400002)(396003)(366004)(346002)(376002)(136003)(316002)(8936002)(54906003)(66556008)(86362001)(19627235002)(71200400001)(8676002)(6916009)(66476007)(66946007)(478600001)(5660300002)(52536014)(83380400001)(64756008)(66446008)(76116006)(33656002)(55016002)(7416002)(26005)(4326008)(9686003)(6506007)(7696005)(53546011)(2906002)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: EZdrRecTgF3dTmL2f6IdKKHJhKpsMLxXCff9kbNvfPDUwSRhYgRMVvyF+A7EczjDpdKofgL8MFJOdhBr52ACEplPJLVFX/fmqXe/enhKRK9dkzCPupJT6uKiYNSbeUe8IRb6nKXEYZDI9cWacj2AZEnnSvi2XgkUr5e4QtUnmn5ltqFjdLS88Jq+mRgTG3NoEc9FujOugE3uS2QbayD/6X5tF8oRCzS4BAbrpW7iie6YHaAYK1/LVGOHKWAFIfVMewjsctCb6IIpKRDhjdc4dEgv82/0xn6Yav1FtiGfjmdRZ/O2yEKUD+B84CqoN1xeyf3jooHJqAVf/zKkn/8oyXqmL8vCATZ3efdX7QEOSKjG4DeBU1s01odeuOruxPVsVHZSSdyw6cLfLtkRDTuKrsmCvF+tYigD5+GGq3E2oH2P9F6819TynX5dUHxXdjDVcZ3q8TF6FiSG9NLU2FxpLWEBWiC9+0VDxxXT4BB+n3dQF2oXipetwlbg7bKb3CxBAxFAnEOt4WkwpyEXbAVfYdIa9o/5R/MexkLXaAgjaEjAaViGtmp5o7wU2JoKd9vUp4vj7embkDiWYajo/IIk2pH1X+9Gx5kkh4bs2lKb6mqq4UAKZKWigwZOWykDcGTR1RU+RT4wYK4yN/lhB1dKxA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6772.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce81f45-3818-48ec-e641-08d86093650a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2020 14:09:04.3103 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OuI0R/GuLfIl1o34wYcz90scnPPbNTnr5ocDkUva/rfzTtEa/bvvvtkf098b36p32vJzzLwgAQlENDyWAOPM2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB6438
Received-SPF: pass client-ip=40.107.92.54; envelope-from=saipava@xilinx.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 10:09:06
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Thanks Gerd.

I would test this over V10.

Regards,
Sai Pavan

> -----Original Message-----
> From: Gerd Hoffmann <kraxel@redhat.com>
> Sent: Thursday, September 24, 2020 10:47 AM
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
> Subject: Re: [PATCH v8 3/7] usb/hcd-xhci: Split pci wrapper for xhci base
> model
>=20
>   Hi,
>=20
> > Can you also provide any steps to test vmstate migration ?
>=20
> Helper script below, run it with something like:
>=20
> $script -m 4G -vga std \
>   -cdrom Fedora-Workstation-Live-x86_64-32-1.6.iso \
>   -device qemu-xhci -device usb-tablet
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D cut here
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D #!/bin/bash
>=20
> # most recent release
> src=3D"/usr/local/bin/qemu-system-x86_64"
>=20
> # master branch / devel branch
> dst=3D"/home/kraxel/projects/qemu/build/default/x86_64-softmmu/qemu-
> system-x86_64"
>=20
> # time to wait before migration
> sec=3D60
>=20
> # vmstate storage
> tmp=3D"$(mktemp ${TMPDIR-/var/tmp}/vmstate-XXXXXXXXXXXXXX)"
> trap "rm -f $tmp" EXIT
>=20
> # figure machine type to use
> machine=3D$($src -M help | awk '/default/ { print $1 }')
> machine=3D"${machine},vmport=3Doff"
> machine=3D"${machine},accel=3Dkvm"
>=20
> ################################################################
> ########
>=20
> echo "#"
> echo "# vmsave (after $sec seconds)"
> echo "#"
> (
>     sleep $sec
>     echo "migrate_set_speed 100M"
>     echo "migrate exec:cat>$tmp"
>     echo "quit"
> ) |\
> $src -nodefaults \
>     -monitor stdio \
>     -M $machine \
>     "$@"
>=20
> echo "#"
> echo "# vmload"
> echo "#"
> $dst -nodefaults \
>     -monitor stdio \
>     -incoming "exec:cat $tmp" \
>     -M $machine \
>     "$@"


