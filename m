Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED07C432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 07:13:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8C5221A4A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 07:13:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8C5221A4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDNyK-0001vu-IF
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 03:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54513)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iDNvo-00081z-1j
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 03:11:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iDNvm-0007M7-KH
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 03:11:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:64720)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iDNvm-0007Kc-Ct
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 03:11:14 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 623FCC06512C
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 07:11:11 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id z8so534981wrs.14
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 00:11:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Xen6qL0B0p30H/ek3UjK60QpqxMYdUJMbKTKXb7Ml3w=;
 b=dCUjiOtG123939IX4tx+szk+hvgKEr+tVL1NuZ1qmuTyBcQCFrBh+U2I4O/U6vUSz9
 k31uDjzpqLEqGRipqvDeHkkMe2DuHeioQmSLfPl6o94bwma+jTkb/8wQ0Rd5fzoglkm/
 GVeHieXbaiIKhNcjoWd/SQjDx8+P0fhXXVpALpVdxFQGFzsLA8AWYmzQ1vW0S+OoNRG+
 BeK2jmZmqrK304hdgUmW8A5McvGNtTnUpksmZ/OcX1+A5q/rElyjfh0mTStsdymQnmpM
 vsP1ITzq2oMcdKszZCuQYxonxr0JYDvnFmdI8QmkrJ9qF4tzKx4kvErl71EEFZM5R2nz
 2qHw==
X-Gm-Message-State: APjAAAVeIspDsF9n2AdgR4ZC4MmkVeaawoxCBVwUusjrth8tXtXSFfVx
 x1y4ETCHT0JyGQrrKHpCZH6bPaTGLvpkkbf2MOw/vHJoq+QU475B6rfSXWvoEqv+3S+GcNLP6DN
 8BJOz9zmiCQtn7b0=
X-Received: by 2002:a7b:cc91:: with SMTP id p17mr1583142wma.43.1569481870145; 
 Thu, 26 Sep 2019 00:11:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwcJaahijvFAdwKeol0CCjw4J2ATQLRtU7/qPsHcMnUVX3nVziE6bsuuFOcdz3l0p4jqbzQOw==
X-Received: by 2002:a7b:cc91:: with SMTP id p17mr1583131wma.43.1569481869966; 
 Thu, 26 Sep 2019 00:11:09 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id i73sm2353419wmg.33.2019.09.26.00.11.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Sep 2019 00:11:09 -0700 (PDT)
Subject: Re: [PATCH 13/20] spapr: Eliminate SpaprIrq:get_nodename method
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 clg@kaod.org, qemu-devel@nongnu.org
References: <20190925064534.19155-1-david@gibson.dropbear.id.au>
 <20190925064534.19155-14-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <dcb62065-40f5-e422-e144-dd124d863822@redhat.com>
Date: Thu, 26 Sep 2019 09:11:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190925064534.19155-14-david@gibson.dropbear.id.au>
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
> This method is used to determine the name of the irq backend's node in =
the
> device tree, so that we can find its phandle (after SLOF may have modif=
ied
> it from the phandle we initially gave it).
>=20
> But, in the two cases the only difference between the node name is the
> presence of a unit address.  Searching for a node name without consider=
ing
> unit address is standard practice for the device tree, and
> fdt_subnode_offset() will do exactly that.
>=20
> So, the method is unnecessary.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr_irq.c         | 25 +++----------------------
>  include/hw/ppc/spapr_irq.h |  1 -
>  2 files changed, 3 insertions(+), 23 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 038bfffff4..79167ccc68 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -211,11 +211,6 @@ static void spapr_irq_reset_xics(SpaprMachineState=
 *spapr, Error **errp)
>      }
>  }
> =20
> -static const char *spapr_irq_get_nodename_xics(SpaprMachineState *spap=
r)
> -{
> -    return XICS_NODENAME;
> -}
> -
>  static void spapr_irq_init_kvm_xics(SpaprMachineState *spapr, Error **=
errp)
>  {
>      if (kvm_enabled()) {
> @@ -237,7 +232,6 @@ SpaprIrq spapr_irq_xics =3D {
>      .post_load   =3D spapr_irq_post_load_xics,
>      .reset       =3D spapr_irq_reset_xics,
>      .set_irq     =3D spapr_irq_set_irq_xics,
> -    .get_nodename =3D spapr_irq_get_nodename_xics,
>      .init_kvm    =3D spapr_irq_init_kvm_xics,
>  };
> =20
> @@ -362,11 +356,6 @@ static void spapr_irq_set_irq_xive(void *opaque, i=
nt irq, int val)
>      }
>  }
> =20
> -static const char *spapr_irq_get_nodename_xive(SpaprMachineState *spap=
r)
> -{
> -    return spapr->xive->nodename;
> -}
> -
>  static void spapr_irq_init_kvm_xive(SpaprMachineState *spapr, Error **=
errp)
>  {
>      if (kvm_enabled()) {
> @@ -393,7 +382,6 @@ SpaprIrq spapr_irq_xive =3D {
>      .post_load   =3D spapr_irq_post_load_xive,
>      .reset       =3D spapr_irq_reset_xive,
>      .set_irq     =3D spapr_irq_set_irq_xive,
> -    .get_nodename =3D spapr_irq_get_nodename_xive,
>      .init_kvm    =3D spapr_irq_init_kvm_xive,
>  };
> =20
> @@ -538,11 +526,6 @@ static void spapr_irq_set_irq_dual(void *opaque, i=
nt irq, int val)
>      spapr_irq_current(spapr)->set_irq(spapr, irq, val);
>  }
> =20
> -static const char *spapr_irq_get_nodename_dual(SpaprMachineState *spap=
r)
> -{
> -    return spapr_irq_current(spapr)->get_nodename(spapr);
> -}
> -
>  /*
>   * Define values in sync with the XIVE and XICS backend
>   */
> @@ -560,7 +543,6 @@ SpaprIrq spapr_irq_dual =3D {
>      .post_load   =3D spapr_irq_post_load_dual,
>      .reset       =3D spapr_irq_reset_dual,
>      .set_irq     =3D spapr_irq_set_irq_dual,
> -    .get_nodename =3D spapr_irq_get_nodename_dual,
>      .init_kvm    =3D NULL, /* should not be used */
>  };
> =20
> @@ -697,13 +679,13 @@ void spapr_irq_reset(SpaprMachineState *spapr, Er=
ror **errp)
> =20
>  int spapr_irq_get_phandle(SpaprMachineState *spapr, void *fdt, Error *=
*errp)
>  {
> -    const char *nodename =3D spapr->irq->get_nodename(spapr);
> +    const char *nodename =3D "interrupt-controller";
>      int offset, phandle;
> =20
>      offset =3D fdt_subnode_offset(fdt, 0, nodename);
>      if (offset < 0) {
> -        error_setg(errp, "Can't find node \"%s\": %s", nodename,
> -                   fdt_strerror(offset));
> +        error_setg(errp, "Can't find node \"%s\": %s",
> +                   nodename, fdt_strerror(offset));
>          return -1;
>      }
> =20
> @@ -787,6 +769,5 @@ SpaprIrq spapr_irq_xics_legacy =3D {
>      .post_load   =3D spapr_irq_post_load_xics,
>      .reset       =3D spapr_irq_reset_xics,
>      .set_irq     =3D spapr_irq_set_irq_xics,
> -    .get_nodename =3D spapr_irq_get_nodename_xics,
>      .init_kvm    =3D spapr_irq_init_kvm_xics,
>  };
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index a4e790ef60..9b60378e28 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -52,7 +52,6 @@ typedef struct SpaprIrq {
>      int (*post_load)(SpaprMachineState *spapr, int version_id);
>      void (*reset)(SpaprMachineState *spapr, Error **errp);
>      void (*set_irq)(void *opaque, int srcno, int val);
> -    const char *(*get_nodename)(SpaprMachineState *spapr);

Another Yay!

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>      void (*init_kvm)(SpaprMachineState *spapr, Error **errp);
>  } SpaprIrq;
> =20
>=20

