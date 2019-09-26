Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46C8C432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 07:14:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 758FE21A4A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 07:14:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 758FE21A4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDNyZ-0002Gh-0v
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 03:14:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54587)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iDNwL-0008Qx-KK
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 03:11:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iDNwH-0007hR-99
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 03:11:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55354)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iDNwG-0007fp-S1
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 03:11:45 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D828950F45
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 07:11:43 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id m16so611991wmg.8
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 00:11:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=L50BqEk2vG3CzamW0ew1TzwncVMiTDVDnigoLpG8dr0=;
 b=oEN8U7I0sKFw6M8+eVM5MaXSel21ll9ANyLhPauLNxNkzoGCjF4pU2+gxEuwyyV4bi
 Jb0GHrZED8ID9p6gIJqwdv02aXFNsrQ/I16UBWhbZfhj54oapTcCyqlq8mzHr20ErRyI
 JoLQ583RkIq0Jq8I0/ALMTr5AwdnzZm+mcnKVTDA2SgcHRHtVZY+4UYwjFmTWcY1G+k3
 vv1ofbIHSyyvYx7AseIpixWAggd3hnIKWK9XCzWArnenxETGSLSIg2801w6iKnoRGarl
 Jb/nYcSC+uGjdlmxzCVF43AGp9RpWFJkrhlc+wwFsrIk8NEfo/kcYXP37n5OWHiDDVyA
 KQVA==
X-Gm-Message-State: APjAAAWFb1IDsEbO6ShHBA8buWwi02OmVx4QistfawUfYXmNJoplvd/m
 MEarxYMV2ukFRLs1X6F+I4cRYBRGHs8eQQzAdQTKfEGB7KQqBKMU3wsoSzCkoAgCuAiDtxZQSrU
 6Pej8bpAqqcsY2wk=
X-Received: by 2002:a1c:1dd4:: with SMTP id d203mr1704934wmd.45.1569481902656; 
 Thu, 26 Sep 2019 00:11:42 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwz3Sf1hL9VylQZLDJHeuMsTleUqpD3XkjnhKjsihuqMlJQ+oe3V7fTVF4Dok4e4kwOUWuncA==
X-Received: by 2002:a1c:1dd4:: with SMTP id d203mr1704909wmd.45.1569481902430; 
 Thu, 26 Sep 2019 00:11:42 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id a7sm1885776wra.43.2019.09.26.00.11.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Sep 2019 00:11:41 -0700 (PDT)
Subject: Re: [PATCH 14/20] spapr: Remove unhelpful tracepoints from
 spapr_irq_free_xics()
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 clg@kaod.org, qemu-devel@nongnu.org
References: <20190925064534.19155-1-david@gibson.dropbear.id.au>
 <20190925064534.19155-15-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <6cb2b40a-b65c-6c00-e2a3-148ab3334966@redhat.com>
Date: Thu, 26 Sep 2019 09:11:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190925064534.19155-15-david@gibson.dropbear.id.au>
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
> These traces contain some useless information (the always-0 source#) an=
d
> have no equivalents for XIVE mode.  For now just remove them, and we ca=
n
> put back something more sensible if and when we need it.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr_irq.c  | 4 ----
>  hw/ppc/trace-events | 4 ----
>  2 files changed, 8 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 79167ccc68..db6755f3ab 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -140,11 +140,7 @@ static void spapr_irq_free_xics(SpaprMachineState =
*spapr, int irq, int num)
>      int i;
> =20
>      if (ics_valid_irq(ics, irq)) {
> -        trace_spapr_irq_free(0, irq, num);
>          for (i =3D srcno; i < srcno + num; ++i) {
> -            if (ics_irq_free(ics, i)) {
> -                trace_spapr_irq_free_warn(0, i);
> -            }
>              memset(&ics->irqs[i], 0, sizeof(ICSIRQState));
>          }
>      }
> diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
> index 96dad767a1..9ea620f23c 100644
> --- a/hw/ppc/trace-events
> +++ b/hw/ppc/trace-events
> @@ -13,10 +13,6 @@ spapr_pci_msi_retry(unsigned config_addr, unsigned r=
eq_num, unsigned max_irqs) "
>  spapr_cas_failed(unsigned long n) "DT diff buffer is too small: %ld by=
tes"
>  spapr_cas_continue(unsigned long n) "Copy changes to the guest: %ld by=
tes"
> =20
> -# spapr_irq.c
> -spapr_irq_free(int src, int irq, int num) "Source#%d, first irq %d, %d=
 irqs"
> -spapr_irq_free_warn(int src, int irq) "Source#%d, irq %d is already fr=
ee"
> -
>  # spapr_hcall.c
>  spapr_cas_pvr(uint32_t cur_pvr, bool explicit_match, uint32_t new_pvr)=
 "current=3D0x%x, explicit_match=3D%u, new=3D0x%x"
>  spapr_h_resize_hpt_prepare(uint64_t flags, uint64_t shift) "flags=3D0x=
%"PRIx64", shift=3D%"PRIu64
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

