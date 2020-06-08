Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C53FC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 19:29:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6593A20760
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 19:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRyTpS94"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6593A20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiNSX-0001RZ-Nn
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 15:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atar4qemu@gmail.com>)
 id 1jiNRa-0000aL-Sp
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 15:28:26 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:46883)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atar4qemu@gmail.com>)
 id 1jiNRa-0001Rd-3d
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 15:28:26 -0400
Received: by mail-io1-xd43.google.com with SMTP id k8so7729762iol.13
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 12:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=GH5hgzNywsWRYwA1w+FeoGmyA1eAJ18zjwj9STpawBI=;
 b=QRyTpS94iYX887VGlI6EE4NOyOIFnvlsnYBRjlz4K9v/OeacA4zsLSBqG16a3mAIEP
 Qnb9yZ5XayCKGfoyUfTZoLIN+3xdp/OeNW6LBwDFf5lVoM+uc5XX1pFl2S2mUDi0wDwE
 k5PITP34ILmgVscuZNRA1h2bQKmKjeiyY+mjT73GgDNIskp8rkDLN3AxF9x4gzqPKRhN
 SfocBBk9uY40I+d1WMzj9R75d3g8UUjN5ntIJt8VMAmDb8FfL4uB9PMhcN6QYcCdfeA+
 JcJTy02cR7XlS7EUwqmlRC6U07iuZ+zOHZVZz42VJLUxSWsbev9s7CVG+gXM4qbFYIxB
 FAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=GH5hgzNywsWRYwA1w+FeoGmyA1eAJ18zjwj9STpawBI=;
 b=LF9vskY0Gdb/OOMTisvaxBxly+UPqA76KXpu8MEdzdjzB+Zr5wRLCnCWU+omAmTWei
 1img2S5u6TfvBBEcZE5QTxxqHdy9g2h2a8sooK/ytaAPlgAO6n+SxBD/31AjEs6hiXGw
 3PZHjfxdeo7Y2iYEyoB0EmEQGc0/rHoR7EuY9oxhsMjoPwNKSrGP+zp3/D1qXhNbwDDV
 eD9qvxdnV2qSdSCPR8YSxIJXawL1acVkcjrYKfOPXCLAcgh3fd+pCAViawtDD2fw3FEb
 Qp7Ce61Fi6zyLn9InwepPWsXbUtJ5Jbm99eCIH6eV3nYLk9yor7mylM9deqVZxi9K9Ht
 0hAQ==
X-Gm-Message-State: AOAM532naVMkLVgCGS4mvPzBZ16ixkQDYxWgMVZGZBwPmzvsaJ3oMbvz
 r3xobhYPx/lIIrA8Wx4VI3TaeKun1AwPBIJxuqU=
X-Google-Smtp-Source: ABdhPJwIM5GFXgj9+YxzvhvzQ80fVHoGP9gkc4MZ7zZPskeom88vbQCvCZtugizDbgEDEMDYBkwSlt7uH40rxghdF5c=
X-Received: by 2002:a6b:740b:: with SMTP id s11mr21055961iog.10.1591644505033; 
 Mon, 08 Jun 2020 12:28:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200608172144.20461-1-f4bug@amsat.org>
 <20200608172144.20461-3-f4bug@amsat.org>
In-Reply-To: <20200608172144.20461-3-f4bug@amsat.org>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Mon, 8 Jun 2020 21:28:13 +0200
Message-ID: <CACXAS8Aod2ShDROtissrQb-woNYpSvrb=n0OdzG=yfu-Wtf9iQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] hw/sparc64/niagara: Remove duplicated
 NIAGARA_UART_BASE definition
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=atar4qemu@gmail.com; helo=mail-io1-xd43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: KONRAD Frederic <frederic.konrad@adacore.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel <qemu-devel@nongnu.org>, Fabien Chouteau <chouteau@adacore.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 8, 2020 at 7:21 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> NIAGARA_UART_BASE is already defined few lines earlier.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Thanks!
Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>

> ---
>  hw/sparc64/niagara.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
> index ab5ef8c5b3..201fb05d50 100644
> --- a/hw/sparc64/niagara.c
> +++ b/hw/sparc64/niagara.c
> @@ -68,7 +68,6 @@ typedef struct NiagaraBoardState {
>
>  #define NIAGARA_VDISK_BASE  0x1f40000000ULL
>  #define NIAGARA_RTC_BASE    0xfff0c1fff8ULL
> -#define NIAGARA_UART_BASE   0x1f10000000ULL
>
>  /* Firmware layout
>   *
> --
> 2.21.3
>


--=20
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/q=
emu

