Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9316C48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 14:51:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95CE62080C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 14:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="no9C893y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95CE62080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32796 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfmmq-0007Rr-Qi
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 10:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46526)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <arikalo@wavecomp.com>) id 1hfmVz-0005lx-85
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 10:33:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <arikalo@wavecomp.com>) id 1hfmVx-0003BV-83
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 10:33:43 -0400
Received: from mail-co1nam04on0727.outbound.protection.outlook.com
 ([2a01:111:f400:fe4d::727]:60366
 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <arikalo@wavecomp.com>)
 id 1hfmVw-00035s-NE
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 10:33:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavesemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6eIfbogJdSpcpwFa6bXUeLMFktMdYfGbywx68CZz74=;
 b=no9C893y0Bw9pQsJpzPLb2Z0azweRvtyXtDHgrSed8xRGfmRgU47aax5KWSzvRE9z1YJEcO6r5Dd+qlNTgxsUzqHY32e7pXaqB082QC9xSLroRc4sMFqnwgg1feivy9wTcQCyoAqXZR/U4M4j22eJn35PHj9QG+JdQQzaTVRMq4=
Received: from DM5PR22MB1658.namprd22.prod.outlook.com (10.164.152.163) by
 DM5PR22MB0714.namprd22.prod.outlook.com (10.172.192.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Tue, 25 Jun 2019 14:33:36 +0000
Received: from DM5PR22MB1658.namprd22.prod.outlook.com
 ([fe80::3579:1b6c:1f31:c6b9]) by DM5PR22MB1658.namprd22.prod.outlook.com
 ([fe80::3579:1b6c:1f31:c6b9%7]) with mapi id 15.20.2008.014; Tue, 25 Jun 2019
 14:33:35 +0000
From: Aleksandar Rikalo <arikalo@wavecomp.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH 2/2] dma/rc4030: Minor code style cleanup
Thread-Index: AQHVK2IoNLF7CduNiES5vAKQ9cTlHqasbrtN
Date: Tue, 25 Jun 2019 14:33:35 +0000
Message-ID: <DM5PR22MB1658B6F1F277373069EFD54FD2E30@DM5PR22MB1658.namprd22.prod.outlook.com>
References: <1561472838-32272-1-git-send-email-aleksandar.markovic@rt-rk.com>,
 <1561472838-32272-3-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1561472838-32272-3-git-send-email-aleksandar.markovic@rt-rk.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=arikalo@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3981ae6-fe0b-43e7-011a-08d6f97a1b53
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DM5PR22MB0714; 
x-ms-traffictypediagnostic: DM5PR22MB0714:
x-microsoft-antispam-prvs: <DM5PR22MB07148A695787969EADEC63FCD2E30@DM5PR22MB0714.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:161;
x-forefront-prvs: 0079056367
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(39850400004)(396003)(366004)(136003)(346002)(189003)(199004)(55016002)(486006)(26005)(7736002)(229853002)(446003)(52536014)(476003)(9686003)(11346002)(6116002)(66066001)(54896002)(3846002)(6436002)(2906002)(7696005)(5660300002)(6606003)(53936002)(99286004)(256004)(71190400001)(19627405001)(71200400001)(2501003)(76176011)(316002)(14454004)(14444005)(55236004)(25786009)(91956017)(102836004)(76116006)(64756008)(68736007)(66476007)(66556008)(73956011)(66446008)(66946007)(53546011)(110136005)(54906003)(6246003)(6506007)(8936002)(186003)(478600001)(81166006)(8676002)(81156014)(4326008)(74316002)(86362001)(33656002)(21314003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR22MB0714;
 H:DM5PR22MB1658.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0kXSXSHFkMm20oKlJ+c4xj5Y7kFk75CAJbRsnPTmiHsEVrgx3pCMv1HrJNga2ZzGxsrL2SI9k8pwDZYQ2sbA21GprJamWuOH80mh/FvGZmLDI9KaKrC4I6uSqrPQxCIvvS80h5mgLr7tFXgU6ezj7Vc9PEp3jSV7C6At0mzZPj2xd1ON3I/wMO+wfQ5hOeB4y87xFPdMzWCvCMY+AYxUNdU5slT7kyztz40BD2u6vyccPPejzFqAjcBb53ILFgTFO3c9C7epVnjr5DsOuVZbHHNRZGXT9aDBGfHCImio4JXXJUHkobA7QD9c04dwZ7ZoSTA51a5R2qaS22TceeoLRNIkgw/vtdE/WU9t9iQrQ+P3rHTcUOPMXOBvSCimPz9Sl8n+5gXBDDzJn01j6jOIgBoc9Pdx2SllFn7CHEhjxYY=
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3981ae6-fe0b-43e7-011a-08d6f97a1b53
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2019 14:33:35.7965 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: arikalo@wavecomp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR22MB0714
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe4d::727
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH 2/2] dma/rc4030: Minor code style cleanup
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
Cc: "hpoussin@reactos.org" <hpoussin@reactos.org>,
 "f4bug@amsat.org" <f4bug@amsat.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Sent: Tuesday, June 25, 2019 4:27 PM
> To: qemu-devel@nongnu.org
> Cc: Aleksandar Markovic; Aleksandar Rikalo; hpoussin@reactos.org; f4bug@a=
msat.org
> Subject: [PATCH 2/2] dma/rc4030: Minor code style cleanup
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> Fix some simple checkpatch.pl warnings in rc4030.c.
>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  hw/dma/rc4030.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/hw/dma/rc4030.c b/hw/dma/rc4030.c
> index 88ff271..155af9b 100644
> --- a/hw/dma/rc4030.c
> +++ b/hw/dma/rc4030.c
> @@ -58,8 +58,8 @@ typedef struct dma_pagetable_entry {
>
>  #define TYPE_RC4030_IOMMU_MEMORY_REGION "rc4030-iommu-memory-region"
>
> -typedef struct rc4030State
> -{
> +typedef struct rc4030State {
> +
>      SysBusDevice parent;
>
>      uint32_t config; /* 0x0000: RC4030 config register */
> @@ -152,8 +152,9 @@ static uint64_t rc4030_read(void *opaque, hwaddr addr=
, unsigned int size)
>      case 0x0058:
>          val =3D s->cache_bmask;
>          /* HACK */
> -        if (s->cache_bmask =3D=3D (uint32_t)-1)
> +        if (s->cache_bmask =3D=3D (uint32_t)-1) {
>              s->cache_bmask =3D 0;
> +        }
>          break;
>      /* Remote Speed Registers */
>      case 0x0070:
> @@ -538,8 +539,9 @@ static void rc4030_reset(DeviceState *dev)
>
>      s->memory_refresh_rate =3D 0x18186;
>      s->nvram_protect =3D 7;
> -    for (i =3D 0; i < 15; i++)
> +    for (i =3D 0; i < 15; i++) {
>          s->rem_speed[i] =3D 7;
> +    }
>      s->imr_jazz =3D 0x10; /* XXX: required by firmware, but why? */
>      s->isr_jazz =3D 0;
>
> @@ -551,7 +553,7 @@ static void rc4030_reset(DeviceState *dev)
>
>  static int rc4030_post_load(void *opaque, int version_id)
>  {
> -    rc4030State* s =3D opaque;
> +    rc4030State *s =3D opaque;
>
>      set_next_tick(s);
>      update_jazz_irq(s);
> @@ -591,7 +593,8 @@ static void rc4030_do_dma(void *opaque, int n, uint8_=
t *buf, int len, int is_wri
>      hwaddr dma_addr;
>      int dev_to_mem;
>
> -    s->dma_regs[n][DMA_REG_ENABLE] &=3D ~(DMA_FLAG_TC_INTR | DMA_FLAG_ME=
M_INTR | DMA_FLAG_ADDR_INTR);
> +    s->dma_regs[n][DMA_REG_ENABLE] &=3D
> +           ~(DMA_FLAG_TC_INTR | DMA_FLAG_MEM_INTR | DMA_FLAG_ADDR_INTR);
>
>      /* Check DMA channel consistency */
>      dev_to_mem =3D (s->dma_regs[n][DMA_REG_ENABLE] & DMA_FLAG_MEM_TO_DEV=
) ? 0 : 1;
> @@ -603,8 +606,9 @@ static void rc4030_do_dma(void *opaque, int n, uint8_=
t *buf, int len, int is_wri
>      }
>
>      /* Get start address and len */
> -    if (len > s->dma_regs[n][DMA_REG_COUNT])
> +    if (len > s->dma_regs[n][DMA_REG_COUNT]) {
>          len =3D s->dma_regs[n][DMA_REG_COUNT];
> +    }
>      dma_addr =3D s->dma_regs[n][DMA_REG_ADDRESS];
>
>      /* Read/write data at right place */
> --
> 2.7.4

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>

