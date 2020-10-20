Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E231BC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 15:12:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B46D22247
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 15:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XmDhOM2I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B46D22247
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUtJq-00054a-B9
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 11:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUtIB-0003fE-Tk
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:11:15 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:38557)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUtHy-0006QQ-3P
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:11:15 -0400
Received: by mail-ej1-x644.google.com with SMTP id ce10so3258708ejc.5
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 08:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1xaArn65ufOMwZocAes/NaZx/wzEkuh8mICC1mT2r+c=;
 b=XmDhOM2I2z+QtiuvCMEw0lo7FXo04jrB9AZWvNJ+k/0PM24kVkf0lzjpAxSz/mdjEO
 y7ITb0qUquKYKyDBEQeIgbkd3k7+pEELWl8sBzCCNLCXMZge4y9EANgqJB2APEHt24Tn
 kVEkxNVCUeRyPjgwGDWulOnzVwb8HBxW49FQmzZXnsPdYEj61zxAMZC/1mFRG+xgTdBw
 ddyEUo79GbuHFYHgCsIGJzJG4d3TMjCA3v1pqTm2N12a3N5Z+6KkDmDS+du1EPGssQvL
 zp7RybhdSb69eJAqBOuhTyYoyTRuPd67lHCfecRz312W5EcuY/62EcnsxwUJutu3RVMP
 lrMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1xaArn65ufOMwZocAes/NaZx/wzEkuh8mICC1mT2r+c=;
 b=OO1Y8bsdU8FnUkF+3WKdd4IZbYoF8Jm40ggYNZmOg1rzrbWIzOzltOLKNUvG0/m6Xy
 QtZRJF4gqCrmH+EKbXQ9cSl/s9O3SMpr5/HewanZ2xU7uTf8mJWEeziM4Av7lSxCnN9x
 tb1L+W7Er8tguZY5X3xl4o0CgpHxHRv+zWqdZCA9Yn1l+s5Vwo+qjZF/kVZvj3gmPhpC
 rO+KP89CglG1mTCK3178+SXSAO9nTWEoOKb/BFHb3VcfcdLajuOd+bzuhvuuX8RZV82L
 cimiOO8Q7TtCkwgD3HG9xoxoc4Y5wrYgGqZd7RCl5BT3uCcz2UzQ3N/6qGx1Qrz3Ve5Y
 Ir7A==
X-Gm-Message-State: AOAM530ug8iZpimRkU1+lJgFG1pedpELbZDb4d0R0cLvPYi9C0H/hBnx
 lvvHkG3Tz8SNhXVefZqGmCS4QSM+Nh5qq94Q0yGvSctwClc=
X-Google-Smtp-Source: ABdhPJx0a4a+myXseYf2fe+bkzXT6t7hKsUxAV7wGhpNA9ShZx3HBB/r8RdY1D+46KFlWC+rwhLhOFilvfaKKxQJxak=
X-Received: by 2002:a17:906:1f42:: with SMTP id
 d2mr3436764ejk.407.1603206314387; 
 Tue, 20 Oct 2020 08:05:14 -0700 (PDT)
MIME-Version: 1.0
References: <20201020140050.1623109-1-ppandit@redhat.com>
In-Reply-To: <20201020140050.1623109-1-ppandit@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Oct 2020 16:05:03 +0100
Message-ID: <CAFEAcA_Bg12kvGAjg127_XpfeJdj9er-e2VEF9YnkNyVUDQ9OQ@mail.gmail.com>
Subject: Re: [PATCH v2] net: remove an assert call in eth_get_gso_type
To: P J P <ppandit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x644.google.com
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
Cc: Jason Wang <jasowang@redhat.com>, Gaoning Pan <pgn@zju.edu.cn>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 20 Oct 2020 at 15:05, P J P <ppandit@redhat.com> wrote:
>
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> eth_get_gso_type() routine returns segmentation offload type based on
> L3 protocol type. It calls g_assert_not_reached if L3 protocol is
> unknown, making the following return statement unreachable. Remove the
> g_assert call, as it maybe triggered by a guest user.
>
> Reported-by: Gaoning Pan <pgn@zju.edu.cn>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  net/eth.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> Update v2: add qemu_log()
>   -> https://lists.nongnu.org/archive/html/qemu-devel/2020-10/msg05576.html
>
> diff --git a/net/eth.c b/net/eth.c
> index 0c1d413ee2..fd76e349eb 100644
> --- a/net/eth.c
> +++ b/net/eth.c
> @@ -16,6 +16,7 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "qemu/log.h"
>  #include "net/eth.h"
>  #include "net/checksum.h"
>  #include "net/tap.h"
> @@ -71,9 +72,7 @@ eth_get_gso_type(uint16_t l3_proto, uint8_t *l3_hdr, uint8_t l4proto)
>              return VIRTIO_NET_HDR_GSO_TCPV6 | ecn_state;
>          }
>      }
> -
> -    /* Unsupported offload */
> -    g_assert_not_reached();
> +    qemu_log("Probably not GSO frame, unknown L3 protocol: %hd\n", l3_proto);

It's generally not a good idea to use qemu_log() without a
particular mask, as then it will get printed if the user turns
on any logging but not otherwise.

If the guest must have done something wrong to get us here:
 use LOG_GUEST_ERROR
If this is some functionality we ought to implement but have
not, and so something will now be broken:
 use LOG_UNIMP
If the fallback for what happens in this situation is fine,
and maybe it's just suboptimal performance, or an unusual
case that might be interesting to know about but which
we're handling within the spec:
 consider a tracepoint instead

thanks
-- PMM

