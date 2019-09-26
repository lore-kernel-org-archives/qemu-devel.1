Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E07C432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 07:09:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D046421A4A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 07:09:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D046421A4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDNuB-0005c4-NN
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 03:09:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53787)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iDNsw-000459-Rf
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 03:08:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iDNsv-0004qB-MX
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 03:08:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52738)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iDNsv-0004pK-Em
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 03:08:17 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5DDE8796E4
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 07:08:16 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id l3so696973wmf.8
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 00:08:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NFYRfA2daw6PSKmS/uxdoDYC9E1me+Bw8k/CApdaAkI=;
 b=Oq+/+F+/Uogd63yaJgyoFGRzJT2v8lfioaQkCtj3fp3lozXfRukW1KRZdG3ALE2imy
 +PIxcptJbF+ibCXtzLpjap3b6/qxgoRMSJDg7XNJCPbHophdVo4yatqN+ECewoJgYTCa
 Iq/Hezo52redDLzg6XQl+j0jlEftqul5RPQmyz3gL44HgMGAHAVhi20KPenNMW4cBFg/
 VofE4pIttd5fZZYktApvJYrjCaS+Tn+GrMvY9nt8w4CrxdrHbL6q396orDK9zPlX8aml
 /at5RrgmLyZjCu0kobxgs371dj0szv1MWcAFrsNhhAsbtmJvIqqElnDBGewevSX6DHNz
 wQCQ==
X-Gm-Message-State: APjAAAVJMLQy006cyOeOc371fzGYS7IDSzdFzsWZDONdG94P1M0kiN3w
 JSJul+va6cX+RtENRo2xbEdSWArV6hoc9I4Lm3hRDdcFdLEjkZe3y7yI1EtMEncJwe1/RWvm0XZ
 qsHwwgMjCNVSNkLo=
X-Received: by 2002:adf:bb8e:: with SMTP id q14mr1787429wrg.74.1569481695124; 
 Thu, 26 Sep 2019 00:08:15 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyQUnEv4x91maskx2fgxeHEM+Tkt2mdulZJatNFdoy3wmiNrsFhQ/2JH3JCn4q2Jyh604uhAA==
X-Received: by 2002:adf:bb8e:: with SMTP id q14mr1787417wrg.74.1569481694911; 
 Thu, 26 Sep 2019 00:08:14 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id y186sm4478161wmb.41.2019.09.26.00.08.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Sep 2019 00:08:14 -0700 (PDT)
Subject: Re: [PATCH 08/20] spapr: Replace spapr_vio_qirq() helper with
 spapr_vio_irq_pulse() helper
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 clg@kaod.org, qemu-devel@nongnu.org
References: <20190925064534.19155-1-david@gibson.dropbear.id.au>
 <20190925064534.19155-9-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <e44ca336-7c13-811c-5c7b-87115533fcd7@redhat.com>
Date: Thu, 26 Sep 2019 09:08:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190925064534.19155-9-david@gibson.dropbear.id.au>
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
> Every caller of spapr_vio_qirq() immediately calls qemu_irq_pulse() wit=
h
> the result, so we might as well just fold that into the helper.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/char/spapr_vty.c        | 3 +--
>  hw/net/spapr_llan.c        | 3 +--
>  hw/ppc/spapr_vio.c         | 3 +--
>  include/hw/ppc/spapr_vio.h | 5 +++--
>  4 files changed, 6 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/char/spapr_vty.c b/hw/char/spapr_vty.c
> index 087c93e4fa..8f4d9fe472 100644
> --- a/hw/char/spapr_vty.c
> +++ b/hw/char/spapr_vty.c
> @@ -5,7 +5,6 @@
>  #include "cpu.h"
>  #include "migration/vmstate.h"
>  #include "chardev/char-fe.h"
> -#include "hw/irq.h"
>  #include "hw/ppc/spapr.h"
>  #include "hw/ppc/spapr_vio.h"
>  #include "hw/qdev-properties.h"
> @@ -37,7 +36,7 @@ static void vty_receive(void *opaque, const uint8_t *=
buf, int size)
> =20
>      if ((dev->in =3D=3D dev->out) && size) {
>          /* toggle line to simulate edge interrupt */
> -        qemu_irq_pulse(spapr_vio_qirq(&dev->sdev));
> +        spapr_vio_irq_pulse(&dev->sdev);
>      }
>      for (i =3D 0; i < size; i++) {
>          if (dev->in - dev->out >=3D VTERM_BUFSIZE) {
> diff --git a/hw/net/spapr_llan.c b/hw/net/spapr_llan.c
> index 701e6e1514..3d96884d66 100644
> --- a/hw/net/spapr_llan.c
> +++ b/hw/net/spapr_llan.c
> @@ -27,7 +27,6 @@
> =20
>  #include "qemu/osdep.h"
>  #include "cpu.h"
> -#include "hw/irq.h"
>  #include "qemu/log.h"
>  #include "qemu/module.h"
>  #include "net/net.h"
> @@ -267,7 +266,7 @@ static ssize_t spapr_vlan_receive(NetClientState *n=
c, const uint8_t *buf,
>      }
> =20
>      if (sdev->signal_state & 1) {
> -        qemu_irq_pulse(spapr_vio_qirq(sdev));
> +        spapr_vio_irq_pulse(sdev);
>      }
> =20
>      return size;
> diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
> index 0803649658..554de9930d 100644
> --- a/hw/ppc/spapr_vio.c
> +++ b/hw/ppc/spapr_vio.c
> @@ -23,7 +23,6 @@
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
>  #include "qapi/visitor.h"
> -#include "hw/irq.h"
>  #include "qemu/log.h"
>  #include "hw/loader.h"
>  #include "elf.h"
> @@ -294,7 +293,7 @@ int spapr_vio_send_crq(SpaprVioDevice *dev, uint8_t=
 *crq)
>      dev->crq.qnext =3D (dev->crq.qnext + 16) % dev->crq.qsize;
> =20
>      if (dev->signal_state & 1) {
> -        qemu_irq_pulse(spapr_vio_qirq(dev));
> +        spapr_vio_irq_pulse(dev);
>      }
> =20
>      return 0;
> diff --git a/include/hw/ppc/spapr_vio.h b/include/hw/ppc/spapr_vio.h
> index 875be28cdd..72762ed16b 100644
> --- a/include/hw/ppc/spapr_vio.h
> +++ b/include/hw/ppc/spapr_vio.h
> @@ -24,6 +24,7 @@
> =20
>  #include "hw/ppc/spapr.h"
>  #include "sysemu/dma.h"
> +#include "hw/irq.h"
> =20
>  #define TYPE_VIO_SPAPR_DEVICE "vio-spapr-device"
>  #define VIO_SPAPR_DEVICE(obj) \
> @@ -84,11 +85,11 @@ extern SpaprVioDevice *spapr_vio_find_by_reg(SpaprV=
ioBus *bus, uint32_t reg);
>  void spapr_dt_vdevice(SpaprVioBus *bus, void *fdt);
>  extern gchar *spapr_vio_stdout_path(SpaprVioBus *bus);
> =20
> -static inline qemu_irq spapr_vio_qirq(SpaprVioDevice *dev)
> +static inline void spapr_vio_irq_pulse(SpaprVioDevice *dev)
>  {
>      SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> =20
> -    return spapr_qirq(spapr, dev->irq);

Good place to add a trace event.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +    qemu_irq_pulse(spapr_qirq(spapr, dev->irq));
>  }
> =20
>  static inline bool spapr_vio_dma_valid(SpaprVioDevice *dev, uint64_t t=
addr,
>=20

