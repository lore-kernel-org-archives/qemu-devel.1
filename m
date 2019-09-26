Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2272C432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 07:10:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85E4421A4A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 07:10:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85E4421A4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDNv2-0006Xk-7e
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 03:10:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53861)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iDNtG-0004kC-JK
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 03:08:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iDNtF-00053S-Jz
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 03:08:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40444)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iDNtF-00052p-CW
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 03:08:37 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 599095D66B
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 07:08:36 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id t11so530270wro.10
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 00:08:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZEQu9J7pbUUo+bMaxUC8iyKjc4mOcQ9uA3S0igNaUzk=;
 b=GnvQE+kohJh9u2Q/TBUZSMzqIfIpsgrpoqzg8qDeWtY8JfHFy1rlKBCsXUmTrRN6nw
 4iStf9ncmIIpcPrnWQ9l3aTj8FAyvc1OYRYif/PmWMHIFoV6GgxRS5dgT27RYd8KhZqf
 1k04F14nHU5KS3U4EVPdNW4GjqQq1Uu76s58PaCJFQi/celGeX9sdsbrOLTi9D8Fi7pT
 K6I53WM1j5uPU43+W7ezp+ce4sMn6Fycd/OSZ68wU/mcBHRi+vFqC4d/9XWRj6z013Fh
 a+ZBLPK9qgV5TtL7/vGKaIXroToHv9eEluhMh8BrMRnhfbgoqiMOmOxfpwAJteQVTKGK
 Ug0A==
X-Gm-Message-State: APjAAAX66FEJkiuXYIZ880EKOnw7tmD7mWua31RiQuiP2P1HpnbSvSvo
 OpfP/f/QcHZddEywbyMHZGmqNHKEtL2bI8gnOlGU0uPJB+4UmnpfCmtEQlL7+xMtL0x5zx/2PJ7
 GGsPBe3Lh+ulCQ+o=
X-Received: by 2002:a5d:408c:: with SMTP id o12mr1715781wrp.312.1569481715083; 
 Thu, 26 Sep 2019 00:08:35 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwLO2DNe1Af2glbykD1tBb0HZQibBpGC+vJ8MSWGGD1cg8vbZDyHGBfPvHJWWXQTVsMe4yTbQ==
X-Received: by 2002:a5d:408c:: with SMTP id o12mr1715765wrp.312.1569481714911; 
 Thu, 26 Sep 2019 00:08:34 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id s5sm1408661wro.27.2019.09.26.00.08.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Sep 2019 00:08:34 -0700 (PDT)
Subject: Re: [PATCH 07/20] spapr: Fold spapr_phb_lsi_qirq() into its single
 caller
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 clg@kaod.org, qemu-devel@nongnu.org
References: <20190925064534.19155-1-david@gibson.dropbear.id.au>
 <20190925064534.19155-8-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <e4a773b6-e3bc-7149-0049-6428e9c47ab8@redhat.com>
Date: Thu, 26 Sep 2019 09:08:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190925064534.19155-8-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, groug@kaod.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/25/19 8:45 AM, David Gibson wrote:
> No point having a two-line helper that's used exactly once, and not lik=
ely
> to be used anywhere else in future.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr_pci.c          | 3 ++-
>  include/hw/pci-host/spapr.h | 7 -------
>  2 files changed, 2 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 7b71ad7c74..6934d506a7 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -721,9 +721,10 @@ static void pci_spapr_set_irq(void *opaque, int ir=
q_num, int level)
>       * corresponding qemu_irq.
>       */
>      SpaprPhbState *phb =3D opaque;
> +    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> =20
>      trace_spapr_pci_lsi_set(phb->dtbusname, irq_num, phb->lsi_table[ir=
q_num].irq);
> -    qemu_set_irq(spapr_phb_lsi_qirq(phb, irq_num), level);
> +    qemu_set_irq(spapr_qirq(spapr, phb->lsi_table[irq_num].irq), level=
);
>  }
> =20
>  static PCIINTxRoute spapr_route_intx_pin_to_irq(void *opaque, int pin)
> diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
> index abd87605b2..23506f05d9 100644
> --- a/include/hw/pci-host/spapr.h
> +++ b/include/hw/pci-host/spapr.h
> @@ -128,13 +128,6 @@ struct SpaprPhbState {
>  #define SPAPR_PCI_NV2ATSD_WIN_SIZE   (NVGPU_MAX_NUM * NVGPU_MAX_LINKS =
* \
>                                        64 * KiB)
> =20
> -static inline qemu_irq spapr_phb_lsi_qirq(struct SpaprPhbState *phb, i=
nt pin)
> -{
> -    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> -
> -    return spapr_qirq(spapr, phb->lsi_table[pin].irq);
> -}
> -
>  int spapr_dt_phb(SpaprPhbState *phb, uint32_t intc_phandle, void *fdt,
>                   uint32_t nr_msis, int *node_offset);
> =20
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

