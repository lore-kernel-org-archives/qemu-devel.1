Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7595C388F9
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 03:59:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3456420760
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 03:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="WEbOE5/b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3456420760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbbrX-0003pr-3p
	for qemu-devel@archiver.kernel.org; Sat, 07 Nov 2020 22:59:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kbbqY-0003OC-Nw
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 22:58:30 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50985)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kbbqW-0007uN-Sd
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 22:58:30 -0500
Received: by mail-wm1-x343.google.com with SMTP id h2so5034288wmm.0
 for <qemu-devel@nongnu.org>; Sat, 07 Nov 2020 19:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=hjA510b0lEyqZghqBO8pHB+/4x3cyn/2++5FT1ISoSI=;
 b=WEbOE5/b2sGu1w1u1ToTjsXztrrocJo9y72nEJ5noIZp7UopddPzkNcGWAEGtDfiO2
 lhGF1+kqSP27egH/f0QhuW3N088UsFtj0XAqSLEcNpRbnxsUeecEZIf9gUqd79RQjwtB
 gvStqZcb5V4tpJK/HKVCtazxtbutI6Kc8OL7QvYHTPN5RHVNvr5Nxt+uXa3YpxGVoy1g
 asxDIcPbLJ5Wf+Ith3lvW79UxR4tguaa2d6MabhJjQg1NacjubtAKkgxrWstlihJybPz
 9Nk7iQel2CelVtEi3hdw5fUk+ettWbhEBescb3E+hCM7dAjscINXPTZL+izYtc0ekPI2
 7NnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=hjA510b0lEyqZghqBO8pHB+/4x3cyn/2++5FT1ISoSI=;
 b=e98dWUklNVKlBIAZ8ScYNkF0m+7pjqXT/8JFUZoKuHB6a9116BLVRFplLFt/kSemfv
 MRqEjN/Isy3SGhCyWEFBLzpAEchsNu6nZe57J8UnvSV1yC3xd8zJ18dYs0tfKIcb2qLN
 yBCgdUjAQWDjaTbRhEoa/YJwUYFxUSRpUa8Ve79tKCcsKOsV8v0bXxE3pkZ1qwmsLH9o
 WBWyrdQSP0XEkbwwr6C9N5JOSRAG+yqkjvQN8uhbDacjLl7veccAVXUywD2r4f0v30c2
 aacjXzEce/ep9Ecx5k6lXCsXUaYgmOV9ngT7BUHD7T0FR9t5P+7DpI11iDFZjj7a6X+y
 4GPw==
X-Gm-Message-State: AOAM530+Fyh9i6CaoqnhlYn75634gPbvcAxXD3nogWwZ0RaveP0pyCu6
 fppLMsIS3uxWzGuV9uiC1X1y2iDgqjrCA/9wSyVHhQ==
X-Google-Smtp-Source: ABdhPJyBsMm20cLmvf9Ukk+pFYf2G/6g1h8h03MPMy3hgybeEBxceV28Bj0H0/oRyDPl6nNaRFrSCkfoCGLWZpC5pXo=
X-Received: by 2002:a05:600c:214a:: with SMTP id
 v10mr7483185wml.20.1604807906349; 
 Sat, 07 Nov 2020 19:58:26 -0800 (PST)
MIME-Version: 1.0
References: <20201107194045.438027-1-philmd@redhat.com>
In-Reply-To: <20201107194045.438027-1-philmd@redhat.com>
From: Ani Sinha <ani@anisinha.ca>
Date: Sun, 8 Nov 2020 09:28:14 +0530
Message-ID: <CAARzgwxCXmCZsVWKFX6Fp=SBBj0BvY5=ntLwLZva2NZywD48Lw@mail.gmail.com>
Subject: Re: [PATCH-for-5.2 v2] hw/i386/acpi-build: Fix maybe-uninitialized
 error when ACPI hotplug off
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2a00:1450:4864:20::343;
 envelope-from=ani@anisinha.ca; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Nov 8, 2020 at 1:10 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>
> GCC 9.3.0 thinks that 'method' can be left uninitialized. This code
> is already in the "if (bsel || pcihp_bridge_en)" block statement,
> but it isn't smart enough to figure it out.
>
> Restrict the code to be used only in the "if (bsel || pcihp_bridge_en)"
> block statement to fix (on Ubuntu):
>
>   ../hw/i386/acpi-build.c: In function 'build_append_pci_bus_devices':
>   ../hw/i386/acpi-build.c:496:9: error: 'method' may be used uninitialize=
d
>   in this function [-Werror=3Dmaybe-uninitialized]
>     496 |         aml_append(parent_scope, method);
>         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   cc1: all warnings being treated as errors

OK I looked at the patch closely and it makes sense. Can you please
run a "make check" to make sure we have not broken anything?

>
> Fixes: df4008c9c59 ("piix4: don't reserve hw resources when hotplug is of=
f globally")
Acked-by: Ani Sinha <ani@anisinha.ca>

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/i386/acpi-build.c | 45 +++++++++++++++++++++-----------------------
>  1 file changed, 21 insertions(+), 24 deletions(-)
>
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 4f66642d887..1f5c2112452 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -465,34 +465,31 @@ static void build_append_pci_bus_devices(Aml *paren=
t_scope, PCIBus *bus,
>       */
>      if (bsel || pcihp_bridge_en) {
>          method =3D aml_method("PCNT", 0, AML_NOTSERIALIZED);
> -    }
> -    /* If bus supports hotplug select it and notify about local events *=
/
> -    if (bsel) {
> -        uint64_t bsel_val =3D qnum_get_uint(qobject_to(QNum, bsel));
>
> -        aml_append(method, aml_store(aml_int(bsel_val), aml_name("BNUM")=
));
> -        aml_append(method,
> -            aml_call2("DVNT", aml_name("PCIU"), aml_int(1) /* Device Che=
ck */)
> -        );
> -        aml_append(method,
> -            aml_call2("DVNT", aml_name("PCID"), aml_int(3)/* Eject Reque=
st */)
> -        );
> -    }
> +        /* If bus supports hotplug select it and notify about local even=
ts */
> +        if (bsel) {
> +            uint64_t bsel_val =3D qnum_get_uint(qobject_to(QNum, bsel));
>
> -    /* Notify about child bus events in any case */
> -    if (pcihp_bridge_en) {
> -        QLIST_FOREACH(sec, &bus->child, sibling) {
> -            int32_t devfn =3D sec->parent_dev->devfn;
> -
> -            if (pci_bus_is_root(sec) || pci_bus_is_express(sec)) {
> -                continue;
> -            }
> -
> -            aml_append(method, aml_name("^S%.02X.PCNT", devfn));
> +            aml_append(method, aml_store(aml_int(bsel_val), aml_name("BN=
UM")));
> +            aml_append(method, aml_call2("DVNT", aml_name("PCIU"),
> +                                         aml_int(1))); /* Device Check *=
/
> +            aml_append(method, aml_call2("DVNT", aml_name("PCID"),
> +                                         aml_int(3))); /* Eject Request =
*/
> +        }
> +
> +        /* Notify about child bus events in any case */
> +        if (pcihp_bridge_en) {
> +            QLIST_FOREACH(sec, &bus->child, sibling) {
> +                int32_t devfn =3D sec->parent_dev->devfn;
> +
> +                if (pci_bus_is_root(sec) || pci_bus_is_express(sec)) {
> +                    continue;
> +                }
> +
> +                aml_append(method, aml_name("^S%.02X.PCNT", devfn));
> +            }
>          }
> -    }
>
> -    if (bsel || pcihp_bridge_en) {
>          aml_append(parent_scope, method);
>      }
>      qobject_unref(bsel);
> --
> 2.26.2
>

