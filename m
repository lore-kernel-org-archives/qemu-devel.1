Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6584FC4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 17:40:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32A9E2086D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 17:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y50syWkv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32A9E2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7NeT-0005dc-Fz
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 13:40:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50962)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i7NdZ-00057w-CW
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 13:39:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i7NdY-0001qL-4l
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 13:39:37 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:34310)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i7NdX-0001pn-VK
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 13:39:36 -0400
Received: by mail-ot1-x342.google.com with SMTP id z26so4153943oto.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2019 10:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FqgR83A2DIzZuEwHOjx5GCXJmiIDm3exVmMt45nM2To=;
 b=y50syWkvP+aNNry2E9d1v0E65zQOFyjtuot5GYcQITsgztCvdM5IWwtwi+jZs4I3kl
 PmkjQB+dzB7kvo7M33YibeuEbAgJXnmFivWK9JWxQdZ77TaWjaF9/6SH99smCXEy3bi3
 1wTwNvn28bq2aNyaAcfKzJbzgvbWV+4IdppKnvtAH0Soxt2tfhOTO9wbfT7c1Usz5++J
 4e6ntfuuZdazvRLCQmR09PWPFbPEKkBIG7LTZoE0BB4uQVgvikFWgGKpS1kYW3yWN14f
 tM/8oMzSviYClw9Nlcb1hzKvM1sfn89r6nQ2hXkXtYCO7AmTTXRf7hJjnimMy2Vwp3Z3
 oOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FqgR83A2DIzZuEwHOjx5GCXJmiIDm3exVmMt45nM2To=;
 b=PLlGLYsqiJ6TtXJ9oss8BYv0BtfeEOkLdZlpuMXwoluuXyQxKLHYNbeusVKlS2p+fP
 Sl3vWeICJl9GAfSe96Uau2t+TH9jdXMuc4H+n3KjS6fGOC5+ooZfWjEMLR/v+1hnythd
 2SH7RtNBjDHS/xhfslp+k/aIh0Kymrvr0AtxLPez1MtPQV8QUgESIYVTp7RdhPC7Da58
 WG/taXOFewmMbam2tIayFsJIOKR+JQ8fmwjDa6u3xOR/qJlx8o9OMPmenOjDeK6lUFlR
 NmmUIoyFaftdRI9NOhez3I+Tna/Rd69/vktxbM/Vq0pGf0RX3t5vONOLawz4Ndgh9Hgm
 D9iA==
X-Gm-Message-State: APjAAAVnzlAtqFYfP2akAZdUhSgihGnvNRZru3d0/QvB/HVEOpMOYhsW
 Z3Aingzc9cbtNe6sQFVt2eL80QlzZQeIpsDNDeVSsA==
X-Google-Smtp-Source: APXvYqxl+DjV8akbgx7O7+fh/ioQ36hfUec0ZqZ0OOfyOn5YErjNlgGDtbXRw5NHAToMk8Y5cu8uKe+92AR5CFL0Yzk=
X-Received: by 2002:a9d:6a8a:: with SMTP id l10mr17227290otq.97.1568050775032; 
 Mon, 09 Sep 2019 10:39:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190827201639.30368-1-stefanha@redhat.com>
 <20190827201639.30368-2-stefanha@redhat.com>
In-Reply-To: <20190827201639.30368-2-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Sep 2019 18:39:24 +0100
Message-ID: <CAFEAcA8MsjfKTr9JANt39vGZNPk5McQaex7wTRJkOn+hqB54bg@mail.gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PULL 01/12] util/iov: introduce
 qemu_iovec_init_extended
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 27 Aug 2019 at 21:16, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>
> Introduce new initialization API, to create requests with padding. Will
> be used in the following patch. New API uses qemu_iovec_init_buf if
> resulting io vector has only one element, to avoid extra allocations.
> So, we need to update qemu_iovec_destroy to support destroying such
> QIOVs.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
> Message-id: 20190604161514.262241-2-vsementsov@virtuozzo.com
> Message-Id: <20190604161514.262241-2-vsementsov@virtuozzo.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Hi -- Coverity thinks this new function could have an
out-of-bounds read (CID 1405302):

> +/*
> + * Compile new iovec, combining @head_buf buffer, sub-qiov of @mid_qiov,
> + * and @tail_buf buffer into new qiov.
> + */
> +void qemu_iovec_init_extended(
> +        QEMUIOVector *qiov,
> +        void *head_buf, size_t head_len,
> +        QEMUIOVector *mid_qiov, size_t mid_offset, size_t mid_len,
> +        void *tail_buf, size_t tail_len)
> +{
> +    size_t mid_head, mid_tail;
> +    int total_niov, mid_niov = 0;
> +    struct iovec *p, *mid_iov;
> +
> +    if (mid_len) {
> +        mid_iov = qiov_slice(mid_qiov, mid_offset, mid_len,
> +                             &mid_head, &mid_tail, &mid_niov);
> +    }
> +
> +    total_niov = !!head_len + mid_niov + !!tail_len;
> +    if (total_niov == 1) {
> +        qemu_iovec_init_buf(qiov, NULL, 0);
> +        p = &qiov->local_iov;
> +    } else {
> +        qiov->niov = qiov->nalloc = total_niov;
> +        qiov->size = head_len + mid_len + tail_len;
> +        p = qiov->iov = g_new(struct iovec, qiov->niov);
> +    }
> +
> +    if (head_len) {
> +        p->iov_base = head_buf;
> +        p->iov_len = head_len;
> +        p++;
> +    }
> +
> +    if (mid_len) {
> +        memcpy(p, mid_iov, mid_niov * sizeof(*p));
> +        p[0].iov_base = (uint8_t *)p[0].iov_base + mid_head;
> +        p[0].iov_len -= mid_head;
> +        p[mid_niov - 1].iov_len -= mid_tail;
> +        p += mid_niov;
> +    }
> +
> +    if (tail_len) {
> +        p->iov_base = tail_buf;
> +        p->iov_len = tail_len;
> +    }
> +}

but I'm not familiar enough with the code to be able to tell
if it's correct or if it's just getting confused. Could
somebody have a look? (It's possible it's getting confused
because the calculation of 'total_niov' uses 'mid_niov',
but the condition guarding the code that fills in that part
of the vector is 'mid_len', so it thinks it can take the
"total_niov == 1" codepath and also the "head_len == true"
and "mid_len != 0" paths; in which case using "if (mid_niov)"
instead might make it happier.)

thanks
-- PMM

