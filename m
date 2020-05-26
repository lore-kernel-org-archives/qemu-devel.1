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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F0EC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 16:27:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F5CC2073B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 16:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3HFgQfC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F5CC2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdcQV-0000lT-Jh
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 12:27:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jdcPm-0008Tn-Us; Tue, 26 May 2020 12:26:54 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:37731)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jdcPl-0001HP-Mw; Tue, 26 May 2020 12:26:54 -0400
Received: by mail-io1-xd43.google.com with SMTP id r2so12356192ioo.4;
 Tue, 26 May 2020 09:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=xs1WdF5fP6lxE8eq6v707XjDgHgEkFuq+mQF9FJR/HM=;
 b=a3HFgQfC2Bs99jop3X0v7/QPt2AxWe71X03l+KQ073uCwMmETMsKdGEdXdKJnbaYaT
 AiOi5zfnp3knDP3oVhy/MLA7NH+g1LgPfWrvKrYf+VOjcxcEsOI37nIUTqBU8dh31Jct
 MmvTMMlWDz1GYAD+1bt3I8m+0v/NrXN7QPn38CynHMVic4HBKMAyp53d1zbP7nQc+cNK
 +95t2aCdBjAGqb2i9KqZTS144z0Doljgzz7nrUZxn5ZioYVJMjAb4F6uAGhLNvPbC8+m
 BtiRbB+fRynLSUCC16GqVwK0X/WitvwtwIXswNcx+qsnGjfrZ7DqnWXOxn6s1c8okC9v
 HpwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=xs1WdF5fP6lxE8eq6v707XjDgHgEkFuq+mQF9FJR/HM=;
 b=kxpbeHo2drBy+W3nFPR3q3VE7tsMyQxB0zDM367rOL671npn4Bf+0Y70ciddKpRKB1
 crNDZkHqwWG7qDc/WFqbrc05V2UxZW6U6oj4qB3DIf9JpoxJmb+v88Cu+dTxgVHcWjUY
 ZTiXhPl2ptVdmmeItcdwbo9gU0I1NOX25aU2BWdIsNaXeUhTZyqZ6FtN69JNmtfBbEFH
 gB7S0Ezsh+mZ5NZ6t9GidpVwfWtbuN8uVkTk0xmZsCiO9gViB/fzdEMF1JrlAo8qFGvX
 euBcK5UIdJ1+iei2oNDCcE5w84bHhd2NufRvS1g5BZInlkYHm3cDoDHIStU7dsJWttVk
 IQsA==
X-Gm-Message-State: AOAM530o08dxe23YViXu0VdQ/EIW5zfj8UkF5EKL0f78q7oEEAb1HUy4
 UN/urQQQTAghBNS9/CYkd9xl4CvmBvkp3ju0/FI=
X-Google-Smtp-Source: ABdhPJwU9HNHY2EYA4fuxyNw09V5EY6lQs8ZqIpczXrOCc1SBb8TLZ3dT5UNRNgZscpNzpOibapzruwdgPp7dbNQvnA=
X-Received: by 2002:a5d:9d03:: with SMTP id j3mr4422414ioj.176.1590510411634; 
 Tue, 26 May 2020 09:26:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200525034459.28535-1-f4bug@amsat.org>
 <20200525034459.28535-2-f4bug@amsat.org>
In-Reply-To: <20200525034459.28535-2-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 26 May 2020 09:17:52 -0700
Message-ID: <CAKmqyKPtvUKYkdGXSNNhHSc1yW+8-Bm+caAu_ZTrOt0RzFfe9w@mail.gmail.com>
Subject: Re: [PATCH 1/4] hw/misc/auxbus: Use qemu_log_mask(UNIMP) instead of
 debug printf
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd43.google.com
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
 Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, May 24, 2020 at 8:46 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> Convert the deprecated DPRINTF() call by qemu_log_mask(LOG_UNIMP).
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/misc/auxbus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/misc/auxbus.c b/hw/misc/auxbus.c
> index f8e7b97971..06aabf20c5 100644
> --- a/hw/misc/auxbus.c
> +++ b/hw/misc/auxbus.c
> @@ -196,7 +196,7 @@ AUXReply aux_request(AUXBus *bus, AUXCommand cmd, uin=
t32_t address,
>          }
>          break;
>      default:
> -        DPRINTF("Not implemented!\n");
> +        qemu_log_mask(LOG_UNIMP, "AUX cmd=3D%u not implemented\n", cmd);
>          return AUX_NACK;
>      }
>
> --
> 2.21.3
>
>

