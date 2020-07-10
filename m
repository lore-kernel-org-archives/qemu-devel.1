Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FA2C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 11:07:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC7542076A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 11:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u+kRtzdg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC7542076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtqsj-00021I-9M
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 07:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtqs8-0001UI-0P
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 07:07:16 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45192)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtqs6-0000NE-EW
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 07:07:15 -0400
Received: by mail-ot1-x344.google.com with SMTP id h1so3885126otq.12
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 04:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xnXdh8oSQlqOdWk5oiWIM/x6Ix8ycMlgSMO6IWyXku4=;
 b=u+kRtzdgLjJHuywTiURO6iYLtE6rHZIQ0t8t5n7TM7FJmuzk2c6XVLcOBfP+4F4Ebw
 lFucZC6NREFaUCInR4ASj+YheZd+dw1F4kITwgAqN1hs0PLck2Z9WUfK7A2OYCnWeRKY
 c/wfh6H1p4Y5cyYv3q1vsGhEMmxIDwSwwHFYBRWGuXf0cR+yp5tmW2/FfcbEeFVXJ3mh
 fzY4wFa6KIg9pxk8cTyPGLO7VNpXhwxGoxZZnl0b+WQb8H+D4VwvPbj9ztfC/4zlVxZv
 ZmWldBmz8XgmODXYNVHOFIPFvkTj2ayOHb9XHHBHgx3Gvbt+Mmsxhmm80nnINhJKP/Pw
 BKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xnXdh8oSQlqOdWk5oiWIM/x6Ix8ycMlgSMO6IWyXku4=;
 b=goNs0yIFx50QLxqmYsGfvp6jocwJxy4PVI7plFDpykruc8f06+7wE7Vf0l6fu1hliM
 p6V+BOcsnpf54yuRiaa8U6z67aXWg6bcBKbTCTRRsuDsr6tRYW/lB4qyLYrx8xlDp4ya
 wCeFu+Tn87AYNe0zr3W38dBnP+OYmrINhEC5XQLe/ByiU9JklTb28Hjth4lINVb6fzmQ
 getg6XOKquvfio4PabxXMCaXcy1pGh1Zw19P0PRcR3rbz8dZTLYBTco6H+HKupE4A/Xg
 SU0eAHNrm9n5uM6bS3Pb3bhUKrpKKK7v40fvldc0T8SkoqZdMDTYnaSRg3Pt6RvDLhZx
 qVXg==
X-Gm-Message-State: AOAM531Hn/pGLFW8a74X2ccYZDYUbnK15SDV4cL2rVqIktOQW6mAnKPO
 NAyKSRhJ+OoMRAgo0dGhg8em8X0JdE7ZF5f/gR0ioA==
X-Google-Smtp-Source: ABdhPJwYBGbMAiZ+OYwtZ8CcutkWZUcUeBDOT7NUrzOpUdQHKWFQt7SQoRShekPjO7kGO5BMbnEHspPpDABAuf/axkY=
X-Received: by 2002:a05:6830:10ce:: with SMTP id
 z14mr50911267oto.135.1594379232994; 
 Fri, 10 Jul 2020 04:07:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200710091940.641296-1-mcascell@redhat.com>
In-Reply-To: <20200710091940.641296-1-mcascell@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jul 2020 12:07:02 +0100
Message-ID: <CAFEAcA9XQUcdiy2x18Zr+EYDaJ4hY-1Bd-DgL6-j6sJi5Ow+Gg@mail.gmail.com>
Subject: Re: [PATCH] hw/net/xgmac: Fix buffer overflow in xgmac_enet_send()
To: Mauro Matteo Cascella <mcascell@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Rob Herring <robh@kernel.org>, Jason Wang <jasowang@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 ziming zhang <ezrakiez@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 10 Jul 2020 at 10:20, Mauro Matteo Cascella <mcascell@redhat.com> wrote:
>
> A buffer overflow issue was reported by Mr. Ziming Zhang, CC'd here. It
> occurs while sending an Ethernet frame due to missing break statements
> and improper checking of the buffer size.
>
> Reported-by: Ziming Zhang <ezrakiez@gmail.com>
> Signed-off-by: Mauro Matteo Cascella <mcascell@redhat.com>
> ---
>  hw/net/xgmac.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/hw/net/xgmac.c b/hw/net/xgmac.c
> index 574dd47b41..b872afbb1a 100644
> --- a/hw/net/xgmac.c
> +++ b/hw/net/xgmac.c
> @@ -224,17 +224,20 @@ static void xgmac_enet_send(XgmacState *s)
>              DEBUGF_BRK("qemu:%s:ERROR...ERROR...ERROR... -- "
>                          "xgmac buffer 1 len on send > 2048 (0x%x)\n",
>                           __func__, bd.buffer1_size & 0xfff);
> +            break;
>          }
>          if ((bd.buffer2_size & 0xfff) != 0) {
>              DEBUGF_BRK("qemu:%s:ERROR...ERROR...ERROR... -- "
>                          "xgmac buffer 2 len on send != 0 (0x%x)\n",
>                          __func__, bd.buffer2_size & 0xfff);
> +            break;
>          }
> -        if (len >= sizeof(frame)) {
> +        if (frame_size + len >= sizeof(frame)) {
>              DEBUGF_BRK("qemu:%s: buffer overflow %d read into %zu "
> -                        "buffer\n" , __func__, len, sizeof(frame));
> +                        "buffer\n" , __func__, frame_size + len, sizeof(frame));
>              DEBUGF_BRK("qemu:%s: buffer1.size=%d; buffer2.size=%d\n",
>                          __func__, bd.buffer1_size, bd.buffer2_size);
> +            break;
>          }
>
>          cpu_physical_memory_read(bd.buffer1_addr, ptr, len);

This is correct in the sense that it avoids the buffer overflow.

I suspect that we should probably also be reporting the error
back to the guest via some kind of error flag in the descriptor
and/or in a status register. Unfortunately I don't have a copy
of the datasheet and it doesn't seem to be available online :-(
Does anybody have a copy to check ?

thanks
-- PMM

