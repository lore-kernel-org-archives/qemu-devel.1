Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711CDC432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 07:16:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45944206E0
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 07:16:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45944206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDO1G-0005La-Q3
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 03:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54900)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iDNxy-00022s-TY
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 03:13:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iDNxw-0000hz-HN
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 03:13:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40406)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iDNxw-0000gs-9a
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 03:13:28 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2C93DC056808
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 07:13:27 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id m14so532125wru.17
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 00:13:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kM1AFANHjXjXyqEMSf7rpjdUvtPyiJmSzZCMdqlyBy4=;
 b=DJs4EhPxvOFklVQj1bGl+tGjvkI4Pvi5hM6VV5OFzK90Ip22vCA65PSrm6ZbhafXwD
 eWwSV3lAgvy8yoEainQ5t0dE3TlF18MaIGrGeA0wexHlm3QbP4GDnG/tZ9RcA1ZlCZur
 4eLuw3Y+6HxelG621QMDfW6QnXiH74oJE2IVTK4l/TdYZwysP4k6meAdHIbFmtunglEs
 b8iDAx2UC7cyQUQMsfZHUZmDbWT6IUm94B5IwnMKYhJyduaBOpJadm3Eqbno53sSGqNr
 1JxdRm6fTPJda/LZQS47Ftnge2T4n0Agp6CYxIcHmUMxLA+BG1mBu9R314obvZJfiZzX
 bcMw==
X-Gm-Message-State: APjAAAWQd3c7nH8vGKV0m+xsOyXaJ267xu4g9j5qlPKnr8OpKBctDAOY
 cb+jP6d61iGLdczuWWcbpbMLcy7cgib7jihpp5pvE9uQpc53Lp4Q5SvshzIOGc0w4gVWNNSQX2k
 QZUiWepdVw5n2EWI=
X-Received: by 2002:adf:ee4d:: with SMTP id w13mr568652wro.90.1569482005869;
 Thu, 26 Sep 2019 00:13:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyyhLU4TFHrRSzoMWiVqZR3LBuEHW9LoXD5AkonOB0MdKKc9C6x2gjhrX+PeFQduuP61lLJJg==
X-Received: by 2002:adf:ee4d:: with SMTP id w13mr568632wro.90.1569482005647;
 Thu, 26 Sep 2019 00:13:25 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id b186sm6090899wmd.16.2019.09.26.00.13.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Sep 2019 00:13:24 -0700 (PDT)
Subject: Re: [PATCH 17/20] spapr: Remove unused return value in claim path
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 clg@kaod.org, qemu-devel@nongnu.org
References: <20190925064534.19155-1-david@gibson.dropbear.id.au>
 <20190925064534.19155-18-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <a2a1906e-a3f0-6c7a-f418-6e0a5b5a3425@redhat.com>
Date: Thu, 26 Sep 2019 09:13:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190925064534.19155-18-david@gibson.dropbear.id.au>
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
> spapr_irq_claim() and the hooks it is based on return an integer error =
code
> as well as taking an Error ** parameter.  But none of the callers check=
 the
> integer, so we can remove it and just use the richer Error **.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr_irq.c         | 32 +++++++++++++-------------------
>  include/hw/ppc/spapr_irq.h |  4 ++--
>  2 files changed, 15 insertions(+), 21 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 261d66ba17..2673a90604 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -112,8 +112,8 @@ static void spapr_irq_init_xics(SpaprMachineState *=
spapr, Error **errp)
>      spapr->ics =3D ICS_SPAPR(obj);
>  }
> =20
> -static int spapr_irq_claim_xics(SpaprMachineState *spapr, int irq, boo=
l lsi,
> -                                Error **errp)
> +static void spapr_irq_claim_xics(SpaprMachineState *spapr, int irq, bo=
ol lsi,
> +                                 Error **errp)
>  {
>      ICSState *ics =3D spapr->ics;
> =20
> @@ -122,11 +122,10 @@ static int spapr_irq_claim_xics(SpaprMachineState=
 *spapr, int irq, bool lsi,
> =20
>      if (!ics_irq_free(ics, irq - ics->offset)) {
>          error_setg(errp, "IRQ %d is not free", irq);
> -        return -1;
> +        return;
>      }
> =20
>      ics_set_irq_type(ics, irq - ics->offset, lsi);
> -    return 0;
>  }
> =20
>  static void spapr_irq_free_xics(SpaprMachineState *spapr, int irq)
> @@ -252,14 +251,12 @@ static void spapr_irq_init_xive(SpaprMachineState=
 *spapr, Error **errp)
>      spapr_xive_hcall_init(spapr);
>  }
> =20
> -static int spapr_irq_claim_xive(SpaprMachineState *spapr, int irq, boo=
l lsi,
> -                                Error **errp)
> +static void spapr_irq_claim_xive(SpaprMachineState *spapr, int irq, bo=
ol lsi,
> +                                 Error **errp)
>  {
>      if (!spapr_xive_irq_claim(spapr->xive, irq, lsi)) {
>          error_setg(errp, "IRQ %d is invalid", irq);
> -        return -1;
>      }
> -    return 0;
>  }
> =20
>  static void spapr_irq_free_xive(SpaprMachineState *spapr, int irq)
> @@ -406,25 +403,22 @@ static void spapr_irq_init_dual(SpaprMachineState=
 *spapr, Error **errp)
>      }
>  }
> =20
> -static int spapr_irq_claim_dual(SpaprMachineState *spapr, int irq, boo=
l lsi,
> -                                Error **errp)
> +static void spapr_irq_claim_dual(SpaprMachineState *spapr, int irq, bo=
ol lsi,
> +                                 Error **errp)
>  {
>      Error *local_err =3D NULL;
> -    int ret;
> =20
> -    ret =3D spapr_irq_xics.claim(spapr, irq, lsi, &local_err);
> +    spapr_irq_xics.claim(spapr, irq, lsi, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
> -        return ret;
> +        return;
>      }
> =20
> -    ret =3D spapr_irq_xive.claim(spapr, irq, lsi, &local_err);
> +    spapr_irq_xive.claim(spapr, irq, lsi, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
> -        return ret;
> +        return;
>      }
> -
> -    return ret;
>  }
> =20
>  static void spapr_irq_free_dual(SpaprMachineState *spapr, int irq)
> @@ -622,12 +616,12 @@ void spapr_irq_init(SpaprMachineState *spapr, Err=
or **errp)
>                                        spapr->irq->nr_xirqs + SPAPR_XIR=
Q_BASE);
>  }
> =20
> -int spapr_irq_claim(SpaprMachineState *spapr, int irq, bool lsi, Error=
 **errp)
> +void spapr_irq_claim(SpaprMachineState *spapr, int irq, bool lsi, Erro=
r **errp)
>  {
>      assert(irq >=3D SPAPR_XIRQ_BASE);
>      assert(irq < (spapr->irq->nr_xirqs + SPAPR_XIRQ_BASE));
> =20
> -    return spapr->irq->claim(spapr, irq, lsi, errp);
> +    spapr->irq->claim(spapr, irq, lsi, errp);
>  }
> =20
>  void spapr_irq_free(SpaprMachineState *spapr, int irq, int num)
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index ed88b4599a..75279ca137 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -42,7 +42,7 @@ typedef struct SpaprIrq {
>      uint8_t     ov5;
> =20
>      void (*init)(SpaprMachineState *spapr, Error **errp);
> -    int (*claim)(SpaprMachineState *spapr, int irq, bool lsi, Error **=
errp);
> +    void (*claim)(SpaprMachineState *spapr, int irq, bool lsi, Error *=
*errp);
>      void (*free)(SpaprMachineState *spapr, int irq);
>      void (*print_info)(SpaprMachineState *spapr, Monitor *mon);
>      void (*dt_populate)(SpaprMachineState *spapr, uint32_t nr_servers,
> @@ -61,7 +61,7 @@ extern SpaprIrq spapr_irq_xive;
>  extern SpaprIrq spapr_irq_dual;
> =20
>  void spapr_irq_init(SpaprMachineState *spapr, Error **errp);
> -int spapr_irq_claim(SpaprMachineState *spapr, int irq, bool lsi, Error=
 **errp);
> +void spapr_irq_claim(SpaprMachineState *spapr, int irq, bool lsi, Erro=
r **errp);
>  void spapr_irq_free(SpaprMachineState *spapr, int irq, int num);
>  qemu_irq spapr_qirq(SpaprMachineState *spapr, int irq);
>  int spapr_irq_post_load(SpaprMachineState *spapr, int version_id);
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

