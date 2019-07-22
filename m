Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8555BC76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 13:19:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 539CC217F9
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 13:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i0ojXGNg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 539CC217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpYE5-0005Tn-Gj
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 09:19:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48805)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hpYDv-00055Q-ND
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 09:19:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hpYDu-0007pV-5o
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 09:19:27 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:39192)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hpYDu-0007os-0c
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 09:19:26 -0400
Received: by mail-ot1-x343.google.com with SMTP id r21so34116622otq.6
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 06:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=obMtpujnZwtyElCeRGeLA3HwD5977WQZloEysmgPmU4=;
 b=i0ojXGNgE99VQhprGal6b45/wcDgNk5W4XQqWKxNzRoieljT7zaG6pr3LXebrbmI2x
 MG1IqHK6gCDbkLM/JwPZUcl0QswgmjPy3k5CZXR20nqGkGKJRoxqpZMS6ZFBNTpP0GMy
 bOGmkW9FY7reBp1EqGM2DtMbj4F1m2QYBazH4qxaLJEgQW2sGq4BZ/hsTszm6GcDMAAz
 iaPKEq5ckGBnHXcBsypVKVSuCPVRhF9IS3JQ8oeTN7ojMk56KpqVuS3HrnCbaN4Rl7PV
 ou7n+QOsMkUm3w53P2p65HHy9wJQOdBq8mdEniCllsqLjfWCnYWpelNl8Vaih/PvYIdq
 80EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=obMtpujnZwtyElCeRGeLA3HwD5977WQZloEysmgPmU4=;
 b=pnp+WmJ+QUZvT7gRTI8l3ACTogVjmFCkkLwd//W1iphZrAmMNkmib9Ly8jdW9vicTA
 tTCFdpukweBlrIx5KqpGCGpBMChRA4A+EYizUwAc8D9KhUkixmrTkkRAZZl6YohfOG6T
 5RCQQG6SxaLHTpbCDx/H7/AFU46BgkPfMSR4ZEjpWbhtvtcHFLQt+L+IfxHRr64m1J+N
 pBtsy6tDaRDr7eWepqjLOkb40tYhihjbOdagZyrMe8DSiTDUdmwQg0HfLoue/l52EbGq
 uQvM3inQcIFagVXokPoeK+qLBFOLoSCGnkTTac9a4dvKAUf1Yf/UOnpJj3dO7sXWzOUJ
 OkGA==
X-Gm-Message-State: APjAAAWTfZeCQwt39g30a5e6bW+r52M80qlrH3AfNqG2kre48Z6wi72X
 vC4djbMRmJgvhkXyNegNLFlbuSd1wCPz/SJ4GlBGeA==
X-Google-Smtp-Source: APXvYqzXPaXulMX9DXfB7Jlu/0KggWL6Vt8q/T54vSdybqCAvtTDWst0S6uqXGgC0aHQzVNF1Upu+hsMTA42vpeX3Q8=
X-Received: by 2002:a9d:4d81:: with SMTP id u1mr4751190otk.221.1563801564881; 
 Mon, 22 Jul 2019 06:19:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190721085854.12026-1-chen.zhang@intel.com>
In-Reply-To: <20190721085854.12026-1-chen.zhang@intel.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jul 2019 14:19:14 +0100
Message-ID: <CAFEAcA9UF716KmhsbO+p8TFTiC2+MwCFYK99ZvrNWddkxioqeA@mail.gmail.com>
To: Zhang Chen <chen.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH V4] net/colo-compare.c: Fix memory leak and
 code style issue.
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-dev <qemu-devel@nongnu.org>,
 Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 21 Jul 2019 at 10:04, Zhang Chen <chen.zhang@intel.com> wrote:
>
> From: Zhang Chen <chen.zhang@intel.com>
>
> This patch to fix the origin "char *data" memory leak, code style issue
> and add necessary check here.
> Reported-by: Coverity (CID 1402785)
>
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>

> @@ -1008,21 +1019,24 @@ static void compare_notify_rs_finalize(SocketReadState *notify_rs)
>  {
>      CompareState *s = container_of(notify_rs, CompareState, notify_rs);
>
> -    /* Get Xen colo-frame's notify and handle the message */
> -    char *data = g_memdup(notify_rs->buf, notify_rs->packet_len);
> -    char msg[] = "COLO_COMPARE_GET_XEN_INIT";
> +    const char msg[] = "COLO_COMPARE_GET_XEN_INIT";
>      int ret;
>
> -    if (!strcmp(data, "COLO_USERSPACE_PROXY_INIT")) {
> +    if (packet_matches_str("COLO_USERSPACE_PROXY_INIT",
> +                           notify_rs->buf,
> +                           notify_rs->packet_len)) {
>          ret = compare_chr_send(s, (uint8_t *)msg, strlen(msg), 0, true);
>          if (ret < 0) {
>              error_report("Notify Xen COLO-frame INIT failed");
>          }
> -    }
> -
> -    if (!strcmp(data, "COLO_CHECKPOINT")) {
> +    } else if (packet_matches_str("COLO_CHECKPOINT",
> +                                  notify_rs->buf,
> +                                  notify_rs->packet_len)) {
>          /* colo-compare do checkpoint, flush pri packet and remove sec packet */
>          g_queue_foreach(&s->conn_list, colo_flush_packets, s);
> +    } else {
> +        error_report("COLO compare got unsupported instruction '%s'",
> +                     (char *)notify_rs->buf);
>      }

The notify_rs->buf is not NUL-terminated, so you can't use it
in a %s format string like this. The simplest fix is just
to not try to print the contents of the incoming packet at all.

The rest of the patch looks good.

thanks
-- PMM

