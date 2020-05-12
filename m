Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8E6CA90AF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 18:53:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29DD4207BC
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 18:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vw/m7/Ni"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29DD4207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYa2M-00048L-B1
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 14:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYa1R-0003C6-HH
 for qemu-devel@nongnu.org; Tue, 12 May 2020 14:52:57 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:40398)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYa1Q-0006Lu-47
 for qemu-devel@nongnu.org; Tue, 12 May 2020 14:52:56 -0400
Received: by mail-oi1-x241.google.com with SMTP id v128so2344468oia.7
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 11:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GI+dEDoYcRGx+2JzHn6knX+nowcYh7nwqE6VUXONGZw=;
 b=Vw/m7/Nil35kSa5KV2++4YIODo3OrPNj77QjcbvztaFs7KZa5sngFD9WoNluS8kRQV
 njsV4z9t//omy2PDw/kjAEqqE1HPtROBncKFqi6UsdiviMcNBs3cVGDVqRvA2f8who+W
 37NoSQS+eHagAulrseF1uAWBMiC1x4TDJAs89wJ2lurga8BV6p1lMH3/xuXrdurLnRv8
 9BAMop1le6dv1IkYSwjH1wfB8bSs9oh/oVqpTD63qPFnWB/ysgU9R7+tcsQtuiJzOtxZ
 H+F3ZbBLcri5UvMvLX6wSEQDT6QqMCw98+SBTAoBzJ+6NHEPRle847lDPZSs7e7xuRl7
 l2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GI+dEDoYcRGx+2JzHn6knX+nowcYh7nwqE6VUXONGZw=;
 b=PyER/G8ovFT41li4yVZ5VGu01SRzegXKv41I7BFoC6itENtZGMVRayhTJoWNHJaXeN
 GCb6bk9gFdURfvxUBHtmPG/y/jDSFSXNS0GbzxcIQnRw+8ZfXO91lp0a86VnrmT5vzAL
 9Krqq7O7y5S6FfE4MaLOU7Oe+wXL/FTN9b/tJ0UBVt+sDHcnE83fS0p2iuCH0hDyVtwD
 sIVzFWYEewdP9iSvDwy+n6f4/apP8dk84R8Td2vxY+7LsdfXIqEv27hMAbYyYS+hBbQu
 iaOrNByC36V5csQiLNjyJteOUier6UIzoAL0je/je3TROmyI6ad5J+ODVXLySwOJqRFb
 r2Vg==
X-Gm-Message-State: AGi0Pual9ShMTTzfIPk4ywAvCPFKospqq3EdQX6bsLZQIl3Do0DqRe2z
 6fJrq0ojzGGm1uo511Cw4dFzxVp0HbWvSvVWEIHuLA==
X-Google-Smtp-Source: APiQypKeq5tkGX5p45P7sW7iwW/1P7aFEIsRBY7N2ZCRVXxcPPvUAg/yPK9tUNqr5XSIkS10fSJZ4dlJAJvRfZK3Gao=
X-Received: by 2002:aca:895:: with SMTP id 143mr24508371oii.163.1589309574629; 
 Tue, 12 May 2020 11:52:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200507105718.1319187-1-ppandit@redhat.com>
 <20200507105718.1319187-2-ppandit@redhat.com>
In-Reply-To: <20200507105718.1319187-2-ppandit@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 May 2020 19:52:43 +0100
Message-ID: <CAFEAcA8Y67h_Kc=M2i5xGz-sQpJwZ++n8wB8szdv0ziViUfmqw@mail.gmail.com>
Subject: Re: [PATCH 1/2] megasas: use unsigned type for reply_queue_head
To: P J P <ppandit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Ren Ding <rding@gatech.edu>,
 Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 7 May 2020 at 12:03, P J P <ppandit@redhat.com> wrote:
>
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> A guest user may set 's->reply_queue_head' MegasasState field to
> a negative value. Later in 'megasas_lookup_frame' it is used to
> index into s->frames[] array. Use unsigned type to avoid OOB
> access issue.
>
> Reported-by: Ren Ding <rding@gatech.edu>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/scsi/megasas.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
> index af18c88b65..433353bad0 100644
> --- a/hw/scsi/megasas.c
> +++ b/hw/scsi/megasas.c
> @@ -112,7 +112,7 @@ typedef struct MegasasState {
>      uint64_t reply_queue_pa;
>      void *reply_queue;
>      int reply_queue_len;
> -    int reply_queue_head;
> +    uint16_t reply_queue_head;
>      int reply_queue_tail;
>      uint64_t consumer_pa;
>      uint64_t producer_pa;

Using a 16-bit type here means that code like this:

    s->reply_queue_head = ldl_le_pci_dma(pcid, s->producer_pa);
    s->reply_queue_head %= MEGASAS_MAX_FRAMES;

suddenly does a truncation of the 32-bit loaded value before
the modulus operation, which is a bit odd, though since
MEGASAS_MAX_FRAMES happens to be a power of 2 the end
result won't change.

It's also a bit weird to change reply_queue_head's type
but not reply_queue_tail or reply_queue_len.

thanks
-- PMM

