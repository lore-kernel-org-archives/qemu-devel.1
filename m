Return-Path: <SRS0=M8gQ=CP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47207C433E2
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 06:31:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F01620714
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 06:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LeWJjOJK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F01620714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEoCk-0007H3-JQ
	for qemu-devel@archiver.kernel.org; Sun, 06 Sep 2020 02:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1kEoBr-0006ln-23
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 02:30:15 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:40799)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1kEoBn-00031W-Tx
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 02:30:14 -0400
Received: by mail-ej1-x642.google.com with SMTP id z22so13706331ejl.7
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2020 23:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=NFIfJffLfsqYbC3d/3/9ToQuk9mE/JEnDYR3Ic3+ySo=;
 b=LeWJjOJKwjuNNRndgJzGfMgawfvAysUuFipxv3sSErUe5QPLsQXwCHnDBuN7kq+Jcu
 swGfEh5XLfzjKlRCIlubqua5qcgv8UVjwdryPppR/nNrQB6JCmuumo+vbv1vB4N9AVSB
 mX1udSoQzygA5qUBWbID5YBPhhCuKa7StIrEp//1ud7Wk6jOFI/r7RnQWVeDxtnN7Yig
 ObvBfGvWZKsmfI/sgoWf+t+Hk0R68GdXGRUmOZmKxdACH+mpXZQorIYoWp06Mt1T9XVz
 wTkwLufKc5k+BredCXevCFYY/YlLfqSD5iH5E1xhvcbPG26D/fYZovBVzGXPjE1XUrgz
 Eegg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=NFIfJffLfsqYbC3d/3/9ToQuk9mE/JEnDYR3Ic3+ySo=;
 b=D7OrQAVX/6uiEB4VY6EhUgaT0e4rhyiDQ1LrMXjYnsUFyXX5Hq+8bTk8Zn00DfD+YH
 +GBRXlXArSjziFEIA3qt2U27dk0RlXAUuTUrITeVX7U1vZMTytNC2H5rIVBs67XBdCOP
 m8XLecvj1j/MHzQgixvsdQKF1ryPlWswW8Uz/afwwpWzWmNmFakpSC5TshPblPw9/ayo
 dwFXUDZdHuU/F+2OelFV3i2kgLjjCo8DY0OLaW8lvYE9w0ZFYrtLxhZ16RxgORdhAJ8J
 45D4Q6D/EuE1q2Yd353sMMxPgmeaP90ZNI5GQZMPJog0LWAHmr4DvqS1CjPBfrNeDoLf
 iJMw==
X-Gm-Message-State: AOAM532ynxZ544AVH4nvbcy+t2AE3XWN376hKX7x6QtXjteLCHpCNrJd
 zrp4i0MCzjxX3KEXG5Q5LoWcH+WbobQh42cyu4s=
X-Google-Smtp-Source: ABdhPJzz4sLDnWEg1Kiqto24WvGWME/tw5P7hddmUQHZu2ZA+k5OmDuDn0BZqTI1tp6I7895BoszR6X2fSb9J1vxFzk=
X-Received: by 2002:a17:906:375a:: with SMTP id
 e26mr15095502ejc.552.1599373809824; 
 Sat, 05 Sep 2020 23:30:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200906050113.2783642-1-richard.henderson@linaro.org>
In-Reply-To: <20200906050113.2783642-1-richard.henderson@linaro.org>
From: Jon Doron <arilou@gmail.com>
Date: Sun, 6 Sep 2020 09:29:58 +0300
Message-ID: <CAP7QCogkn6mT1JEGsA5tt+jM-t1qOrK_7k1owXgi_zTdeTY0UA@mail.gmail.com>
Subject: Re: [PATCH] hw/hyperv: Fix 32-bit build error for vmbus.
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=arilou@gmail.com; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Richard,

I have already submitted this 7 weeks ago
https://patchew.org/QEMU/20200715084326.678715-1-arilou@gmail.com/202007150=
84326.678715-3-arilou@gmail.com/

On Sun, Sep 6, 2020 at 8:01 AM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> ../qemu/hw/hyperv/vmbus.c: In function =E2=80=98gpadl_iter_io=E2=80=99:
> ../qemu/hw/hyperv/vmbus.c:383:13: error: cast to pointer from integer of =
different size [-Werror=3Dint-to-pointer-cast]
>   383 |         p =3D (void *)(((uintptr_t)iter->map & TARGET_PAGE_MASK) =
| off_in_page);
>       |             ^
> cc1: all warnings being treated as errors
>
> Fixes: 0d71f7082d7 ("vmbus: vmbus implementation")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> Cc: Jon Doron <arilou@gmail.com>
> ---
>  hw/hyperv/vmbus.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
> index 75af6b83dd..3482e9c6cb 100644
> --- a/hw/hyperv/vmbus.c
> +++ b/hw/hyperv/vmbus.c
> @@ -380,7 +380,8 @@ static ssize_t gpadl_iter_io(GpadlIter *iter, void *b=
uf, uint32_t len)
>              }
>          }
>
> -        p =3D (void *)(((uintptr_t)iter->map & TARGET_PAGE_MASK) | off_i=
n_page);
> +        p =3D (void *)(uintptr_t)
> +            (((uintptr_t)iter->map & TARGET_PAGE_MASK) | off_in_page);
>          if (iter->dir =3D=3D DMA_DIRECTION_FROM_DEVICE) {
>              memcpy(p, buf, cplen);
>          } else {
> --
> 2.25.1
>

