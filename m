Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DF3C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 11:36:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70D2420848
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 11:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Og1BL3ce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70D2420848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBGhv-0003pr-IR
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 07:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49724)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jBGhF-0002wS-6s
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 07:35:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jBGhD-0001b8-VJ
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 07:35:44 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:36626)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jBGhD-0001aZ-Oa
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 07:35:43 -0400
Received: by mail-oi1-x244.google.com with SMTP id t24so9809658oij.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 04:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=bTtip2cL91MGIrg0Mc4JsWOrVFkqocrQtKDXBnTyWsk=;
 b=Og1BL3cenMD7H+Yljomz3Y6K9fOixWW0CJudQSIqkUiBjALZt1/45/b1dNqIHKk7IQ
 arZmwyINy5wpe4rrIznToh18Rid+sAy4+9UyEIoywdkIAN/Rwi7i3PJ1sdUXAD7b6IKb
 I/Z0q4EV/eLI/KEDl1eZkujkB4NfXeX/Ta1yb/WDHWMVN2QOQpJzfpUE2x+Mro2j2MPn
 Hn5Ywp6lBSs4jtdTgRnRky466VKYZuB23lYbQv0XhYbv5Av5gtiU7GZqzEH91dPuW9wK
 j55tobReXgC8BnVecDMM9PbMHVczgTFCxddv2LlWlrKpJcMdHDP8fe1ZSxfAGlCWMD1c
 3QJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=bTtip2cL91MGIrg0Mc4JsWOrVFkqocrQtKDXBnTyWsk=;
 b=e4pxQeUiBN+WFmzdJ0xaAcA8+E3I6g6/fQ4RBW2Z2yu9E2Bs/Obi0/uzw0Uqqnp1B3
 KsWlvqxUJTyN/i4j4vjUNSv7QyVi9zwkIQXauPe60oUjJqckBJNOTSgvSiu6VKyuMLAn
 Svxwu3IErEVWMqsIkBgg616HqHhBzbqfq1BTwMQjryMEtH7aY0lw/WrPYe1C87B6LNbh
 HrZe2wPfewy1XN9g+agrIz5RFa+gVSmTqDNnigtDTwO8gNbpVIvcs0oVUnVbTjc49p0L
 tmm3pq4QyiaUxibEbNr4nOVfRp9qIqINIBKuXjUDk7GZabeQW/hPtmQ1/rUANekhghvu
 +VAg==
X-Gm-Message-State: ANhLgQ1cbTA/IVvIjjm7WcqnvzEHlOqpPjCy31ZGeCGdLKCNGE5a18kp
 X5ukIYY3MFrAZnKk8rgiB5Bd0lgwY+73R4vyLTwUfQ==
X-Google-Smtp-Source: ADFU+vvWHQqzhx2R6F2IIi+norYmw7s4QmIxkdYXVvvd/sOCIWwq2Bq4wQ2BZ+IoWfCYpqOf0rXOWlhO3JdKHjdBlDQ=
X-Received: by 2002:a54:478b:: with SMTP id o11mr10542380oic.146.1583753742834; 
 Mon, 09 Mar 2020 04:35:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200305105325.31264-1-kuhn.chenqun@huawei.com>
In-Reply-To: <20200305105325.31264-1-kuhn.chenqun@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Mar 2020 11:35:31 +0000
Message-ID: <CAFEAcA8fnz2oaa-CO-EEK_vQTWfPih4PrAB3i4UUgQpv9Y_4mg@mail.gmail.com>
Subject: Re: [PATCH v2] hw/net/imx_fec: write TGSR and TCSR3 in
 imx_enet_write()
To: Chen Qun <kuhn.chenqun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>, Jason Wang <jasowang@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Peter Chubb <peter.chubb@nicta.com.au>, Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 5 Mar 2020 at 10:53, Chen Qun <kuhn.chenqun@huawei.com> wrote:
>
> The current code causes clang static code analyzer generate warning:
> hw/net/imx_fec.c:858:9: warning: Value stored to 'value' is never read
>         value =3D value & 0x0000000f;
>         ^       ~~~~~~~~~~~~~~~~~~
> hw/net/imx_fec.c:864:9: warning: Value stored to 'value' is never read
>         value =3D value & 0x000000fd;
>         ^       ~~~~~~~~~~~~~~~~~~
>
> According to the definition of the function, the two =E2=80=9Cvalue=E2=80=
=9D assignments
>  should be written to registers.
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> ---
> v1->v2:
>   The register 'ENET_TGSR' write-1-to-clear timer flag.
>   The register 'ENET_TCSRn' 7bit(TF) write-1-to-clear timer flag.
> ---
>  hw/net/imx_fec.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
> index 6a124a154a..322cbdcc17 100644
> --- a/hw/net/imx_fec.c
> +++ b/hw/net/imx_fec.c
> @@ -855,13 +855,15 @@ static void imx_enet_write(IMXFECState *s, uint32_t=
 index, uint32_t value)
>          break;
>      case ENET_TGSR:
>          /* implement clear timer flag */
> -        value =3D value & 0x0000000f;
> +        s->regs[index] ^=3D s->regs[index] & value;
> +        s->regs[index] &=3D 0x0000000f;
>          break;
>      case ENET_TCSR0:
>      case ENET_TCSR1:
>      case ENET_TCSR2:
>      case ENET_TCSR3:
> -        value =3D value & 0x000000fd;
> +        s->regs[index] =3D (value & 0x00000080) ? (0x0000007d & value) :
> +                         (value & 0x000000fd);
>          break;
>      case ENET_TCCR0:
>      case ENET_TCCR1:

This isn't the usual way to write W1C behaviour.
If all the relevant bits are W1C, as for TGSR:

   s->regs[index] &=3D ~(value & 0xf); /* all bits W1C */

If some but not all bits are W1C, as for TCSR*:

   s->regs[index] &=3D ~(value & 0x80); /* W1C bits */
   s->regs[index] &=3D ~0x7d; /* writable fields */
   s->regs[index] |=3D (value & 0x7d);

thanks
-- PMM

