Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A822C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 17:13:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEA9520809
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 17:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oviXvmdE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEA9520809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0pdj-0005eT-0A
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 13:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0pdA-0005Cw-GV
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 13:12:40 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:35977)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0pd8-0002GR-Pr
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 13:12:40 -0400
Received: by mail-oi1-x243.google.com with SMTP id s144so11425816oie.3
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 10:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JeY09bKfXNfyQNs0Wj4LxvnKM+i3eVwyDWLquErDRSk=;
 b=oviXvmdEbts1KR3DM//8hIkGGY0s7X4IOZ3POHITsQiGPvvAEi/SXw6eM4Jv/IQQoZ
 GnZMfHr5oRj9GXNlTjKmY9aMG9205WWQCL0I/wdAw1Nhpqa63AfD98OFmjyuryxPdvuQ
 v56LlmJ7aMI15kJ0Xkj9THo6nK0LIXey1lxzoIV+kOanlimwXuVzCm9TEnnrQIuzJxdc
 lCe3c+whfL8rXNL7ndY4erfICOEZcNPMT4UvRcgf0LmgzRzdPmpq34/oliYNewtbrGQJ
 7U8Fr7KZeFG1AuAB48nAgVYAMXHrckK5v9aKMr45F26CHzI/66Nuk7oNRLVqqoDFjjF7
 kQQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JeY09bKfXNfyQNs0Wj4LxvnKM+i3eVwyDWLquErDRSk=;
 b=mF47dkwGQTx1h9nw+gonTHTLcA0FrYYUHR+8Ok3iw9XhUI5Pumt+7hmLtrv+KUEfoe
 BO3uyM8dccEprLKoKDENy3iSnLMv6HgNFkjh0vKVdtF58eCBAqjT2QtODtSQ8tWK9keQ
 M6zKk6Tc+xLhUpjzn+bMa1/fyatQwll2tl8wRpOmyAQOZgGvjmB4uoCc3V2OLJd3bCp7
 xz7jrK8GR3PyQ6Sx2OmMH9ggQf6vIO18v2xvhyIfvB+VaO8lF2o+Awoxc62x6JLmhhsP
 yT8oJmmJQdyBmtflcuULRi/7VuBy9JjC3L2gFP+BfcHLmq1AqnHynFi3QBRyRIAzCpLw
 ldkQ==
X-Gm-Message-State: AOAM531+0YR6GlS8flE/hsIgXY9+8D1ai9qhc5jP3RLbu+PjrFrDZ+j9
 h4qphxP+9z5ZxZxZbCiRrA4GUHPPvoyoSvk0Js39sQ==
X-Google-Smtp-Source: ABdhPJyg9tv+vutfVcwLliAWAo7buTzFnEwWOp/oiW//DbeGHCtZAoNBgrGpGoMGDgryXNlkxxlNyx0jvjl+RD25qEg=
X-Received: by 2002:aca:48d8:: with SMTP id v207mr1847714oia.48.1596042756825; 
 Wed, 29 Jul 2020 10:12:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200729130222.29026-1-pasic@linux.ibm.com>
In-Reply-To: <20200729130222.29026-1-pasic@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 29 Jul 2020 18:12:25 +0100
Message-ID: <CAFEAcA_zbCLb78hjVvZca7RZF6GQGt1m10rU-kcKbDaP43YzCA@mail.gmail.com>
Subject: Re: [PATCH 1/1] s390x/s390-virtio-ccw: fix off-by-one in loadparm
 getter
To: Halil Pasic <pasic@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
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
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 29 Jul 2020 at 14:05, Halil Pasic <pasic@linux.ibm.com> wrote:
>
> As pointed out by Peter, g_memdup(ms->loadparm, sizeof(ms->loadparm) + 1)
> reads one past of the end of ms->loadparm, so g_memdup() can not be used
> here.
>
> Let's use malloc and memcpy instead!
>
> Fixes: d664548328 ("s390x/s390-virtio-ccw: fix loadparm property getter")
> Fixes: Coverity CID 1431058
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> ---
>  hw/s390x/s390-virtio-ccw.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 403d30e13b..8b7bac0392 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -704,8 +704,8 @@ static char *machine_get_loadparm(Object *obj, Error **errp)
>      char *loadparm_str;
>
>      /* make a NUL-terminated string */
> -    loadparm_str = g_memdup(ms->loadparm, sizeof(ms->loadparm) + 1);
> -    loadparm_str[sizeof(ms->loadparm)] = 0;
> +    loadparm_str = g_malloc0(sizeof(ms->loadparm) + 1);
> +    memcpy(loadparm_str, ms->loadparm, sizeof(ms->loadparm));
>      return loadparm_str;
>  }

(relies on the zeroing of g_malloc0 to put in the terminator
but I guess the existing comment makes that clear enough.)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

