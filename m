Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4706BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 16:58:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00B8E20776
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 16:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0w04FF7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00B8E20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdcuh-0006uc-7V
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 12:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jdcly-0007Gs-1U; Tue, 26 May 2020 12:49:50 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:42005)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jdclx-0007qE-4I; Tue, 26 May 2020 12:49:49 -0400
Received: by mail-il1-x144.google.com with SMTP id 18so21175643iln.9;
 Tue, 26 May 2020 09:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=2KoUX+e5g1rmy+CRz+7sdJM4czxsGYzwfbSWV5cSDkM=;
 b=S0w04FF7T7bnf84GgZ7iEeaGAjKRa99jBNbbiznc6NxicvC649WmHhpTTTPuIWktIG
 2yiSdjFAXjNfZ4uA6tP0KDgaynlXOjPbFq4aMIvgZ4LlKgdDfhWhSBdceF7LO5c4IMLy
 xFQ0XemyFB7fKVX6AL/8TEcgT+MRNRJ5HovYRKZeBXWLPa/6tuqpe7rJBzTe3dSv6NEE
 bM/A1e16xbiefPkTt1poacZ7ZTW3Byt2LzIW+89rFls7/Jk9tSUykZaMpI4gnRt8cg57
 LaPBd/x8NLo7oRWF2uO1n3vPqcTOPbQMiZgSLViQg/9JmHnivyGepGA/0YLPJqZqplIA
 ClZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=2KoUX+e5g1rmy+CRz+7sdJM4czxsGYzwfbSWV5cSDkM=;
 b=BvrWCe9GsLf1NVIcFwxyDrGDzEspVk+qxKoLrZbGAbf4cdnakKUypKnSStUnW/fuTc
 fOZJQVerT0uvE5Y30y7tPoxGrLAcLlc/lwVwGe7/VykoAtjzwvCmvvBhdHXorarY8haL
 WRPd4RokZTd+qZAFkw7taIdptsX08crBJ7UEEF/2QQx7YzrX2OFad5DgRj/+TJwXsN6L
 JxVOR38bYhVrPU81zk579u4yHYzV7yDuzIKzXSQfdfssR37L8YxGF1E8y2iyU9eYs6mN
 +J4ZZBj/VUlR9YFghsa8DRQo0wpJzYkJ6WJUDr26QInpliVqaJMvbdXU0t4FeDQdscDn
 tqKA==
X-Gm-Message-State: AOAM532/jMibkaTkuxfbwkeyFg+SevJ/1D1SdQfzbu9hEfN02aSj4Fa6
 Qpls3Uzq0KrI2vHP1ZCeQLcKJ/2MtAWwd6uLBVw=
X-Google-Smtp-Source: ABdhPJy9jkbUJ0bO2l2TwYZZcEJFfChtxqwdylPwijaQfoGltI/7LJsBOc55rLhfY7fb+WSD2C+oYznmELJZ958imGs=
X-Received: by 2002:a92:d087:: with SMTP id h7mr2131565ilh.227.1590511787083; 
 Tue, 26 May 2020 09:49:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200526062252.19852-1-f4bug@amsat.org>
 <20200526062252.19852-2-f4bug@amsat.org>
In-Reply-To: <20200526062252.19852-2-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 26 May 2020 09:40:48 -0700
Message-ID: <CAKmqyKNqv=CKpWpshU854joqp4KjxYjbNGdaik-BX-XePx5kvg@mail.gmail.com>
Subject: Re: [PATCH 01/14] hw/display/edid: Add missing 'qdev-properties.h'
 header
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::144;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Trivial <qemu-trivial@nongnu.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 25, 2020 at 11:23 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
>
> When trying to consume the DEFINE_EDID_PROPERTIES() macro
> by including "hw/display/edid.h", we get this build failure:
>
>   include/hw/display/edid.h:24:5: error: implicit declaration of
>   function =E2=80=98DEFINE_PROP_UINT32=E2=80=99 [-Werror=3Dimplicit-funct=
ion-declaration]
>      24 |     DEFINE_PROP_UINT32("xres", _state, _edid_info.prefx, 0),   =
 \
>         |     ^~~~~~~~~~~~~~~~~~
>
> Headers should be self-contained, and one shouldn't have to
> dig to find the missing headers.
> In this case "hw/qdev-properties.h" is missing. Add it.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/hw/display/edid.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/hw/display/edid.h b/include/hw/display/edid.h
> index ff99dc0a05..23371ee82c 100644
> --- a/include/hw/display/edid.h
> +++ b/include/hw/display/edid.h
> @@ -2,6 +2,7 @@
>  #define EDID_H
>
>  #include "qom/object.h"
> +#include "hw/qdev-properties.h"
>
>  typedef struct qemu_edid_info {
>      const char *vendor; /* http://www.uefi.org/pnp_id_list */
> --
> 2.21.3
>
>

