Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C86C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 20:25:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 544982187F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 20:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wZGb5iF+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 544982187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiPLD-0005yX-3L
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 16:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39233)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hiNsN-0000BT-4f
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 14:51:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hiNsM-0006Rm-4T
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 14:51:35 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:43950)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hiNsL-0006QE-RC
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 14:51:34 -0400
Received: by mail-oi1-x243.google.com with SMTP id w79so13982466oif.10
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 11:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8ChSzfU1R66vRAXZx92c63Fkrw2EjXXnEeBM9QyLGJ8=;
 b=wZGb5iF+9QSVDOwPwRsfXvmY6v77V72cExA+ASyuB609mhjVJvVugNmUj4yT9U2xn/
 qkPrPJ7Cn1617vRF9JXLN/1JZ1Z6wKQgLYLA0EVsXQR7qPs88PHFZoilty+/kZZzQSiO
 4X28agaxK52jACZ+hmV4T+trsqtDy/63zmvZXeayGSatC5NOQGAum1hFj/310/vdo4RG
 TecgqhsBuASHR5M26woB3ugUw2tjc+CwVFktrNrHZIP2JXIiaTeid60IIRXLlyQZ9hCI
 fikbNzOTz6ZCqdv41SBN9CwpM7AcnpiiWaGBGVxRMahR9eepPeENlZD5LWWUsdVDlB2V
 2KrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8ChSzfU1R66vRAXZx92c63Fkrw2EjXXnEeBM9QyLGJ8=;
 b=ErDZPBjYr09t4HOwZJz6RNKIVOkzJltpKfO4aUbm9qE2fipknWn9tCQvZV45v0kHDw
 5eYj8pDbrItYuk6EQqMPFRq5ATK6fmyBGHelhd67q4yJC8ky2bbUq43fkxgUXtvixROn
 y2/NLUrCgs10FrmYViy3cWuGQLEftEI5txGeeuDusC+OY9KwVdQnZRZ2qYvqS0UBQ0rX
 sReC3y65ehRVMcp5HR/Y4x9bKmpoZ5XpNB1zy9f+dKnugrGkdsoljnXxLjd61U2xxlXc
 jb0lAjnmbjD2rulfHRNUHauPI9tubRKBs7hf2T/RHo7vxFyUQsv5W2fxaBBu2XzBMOAC
 xq6Q==
X-Gm-Message-State: APjAAAViPunVnZJ2fJZCUh85g1WMVBVAM5nzJ5MeAXcCYTkFnALEQFkr
 y8sE0AsjNmvqd/84xlAmI82GRM2hrZUHaW6JQPY3Hg==
X-Google-Smtp-Source: APXvYqyjhY0c7G3d0Ou7BvGSqiCr/ZzX5R1dH/BMneQoMOearh0ZsyV6QCGeoCItUugKAbcAiAXxw51ssBQfEm6tFOk=
X-Received: by 2002:aca:5cd7:: with SMTP id q206mr3618668oib.146.1562093493075; 
 Tue, 02 Jul 2019 11:51:33 -0700 (PDT)
MIME-Version: 1.0
References: <1562034689-6539-1-git-send-email-jasowang@redhat.com>
 <1562034689-6539-17-git-send-email-jasowang@redhat.com>
In-Reply-To: <1562034689-6539-17-git-send-email-jasowang@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Jul 2019 19:51:22 +0100
Message-ID: <CAFEAcA_mC2mfgDj+QqtGFNuxi+UCBq=XuZOswgZMGuEnpkg=sA@mail.gmail.com>
To: Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PULL 16/17] COLO-compare: Add colo-compare remote
 notify support
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
Cc: Zhang Chen <chen.zhang@intel.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2 Jul 2019 at 03:32, Jason Wang <jasowang@redhat.com> wrote:
>
> From: Zhang Chen <chen.zhang@intel.com>
>
> This patch make colo-compare can send message to remote COLO frame(Xen) when occur checkpoint.
>
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Hi; Coverity reports a problem (CID 1402785) with this function:

> @@ -989,7 +1006,24 @@ static void compare_sec_rs_finalize(SocketReadState *sec_rs)
>
>  static void compare_notify_rs_finalize(SocketReadState *notify_rs)
>  {
> +    CompareState *s = container_of(notify_rs, CompareState, notify_rs);
> +
>      /* Get Xen colo-frame's notify and handle the message */
> +    char *data = g_memdup(notify_rs->buf, notify_rs->packet_len);
> +    char msg[] = "COLO_COMPARE_GET_XEN_INIT";
> +    int ret;
> +
> +    if (!strcmp(data, "COLO_USERSPACE_PROXY_INIT")) {
> +        ret = compare_chr_send(s, (uint8_t *)msg, strlen(msg), 0, true);
> +        if (ret < 0) {
> +            error_report("Notify Xen COLO-frame INIT failed");
> +        }
> +    }
> +
> +    if (!strcmp(data, "COLO_CHECKPOINT")) {
> +        /* colo-compare do checkpoint, flush pri packet and remove sec packet */
> +        g_queue_foreach(&s->conn_list, colo_flush_packets, s);
> +    }
>  }

We allocate data using g_memdup(), but we never free it before returning,
so the function has a memory leak. It's not clear to me why we're
duplicating the string at all -- it would be cleaner to do the
check of the packet contents to identify in-place. That would be
the best way to fix/avoid the leak.

Some other things I notice reading the function:

(1) after the first if() we will go ahead and check the second if().
This means we'll unnecessarily check whether the data string
matches COLO_CHECKPOINT, when we know already it cannot. I think
an if (!strcmp(...)) { ... } else if (!strcmp(...)) { ... }
structure would be more normal C here.

(2) the g_memdup() call is treating the data as a buffer-and-length,
and we don't enforce that it is NUL-terminated. But then we do a
strcmp() against it, which assumes that the data is a NUL-terminated
string. Is this safe ?

(3) More minor point: you could mark 'msg' as const here, since
I think we never need to modify it.

thanks
-- PMM

