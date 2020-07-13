Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFC5C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 13:06:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82BA520738
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 13:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R2v+GbsC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82BA520738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juyAY-0000gJ-Je
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 09:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juy9a-0008K3-M7
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 09:05:54 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:34295)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juy9Y-0005RW-Lc
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 09:05:54 -0400
Received: by mail-oi1-x244.google.com with SMTP id e4so10923859oib.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 06:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eCwTRgt+aqBNRZTciBAj03pXt+4vXdHOb6MN+oYTGWE=;
 b=R2v+GbsCn4grwk1HO+zln0rWvp38jSdbk6lJ/7ePf6kp5WWoZcoNkG9PQ9PP8zg7OC
 SXlDe++I/pQm8GK9Cv3Wdew/URwER5DK2ls/ENGgoSS7KgDcK6RB0TIrqwK8FoEpBqSI
 bUWIXIs4BPrJe9dUbia/H++FOn2tNm7vXaloPUV9Slpi/Avsn0wRmrTqLt722Yg01FEk
 roxIY6uANi/lwufbz+iPubCo22QqARAov7L29KueU1GVXDNaRblpPBmbDF5RKMVdeZ/D
 auyx8gPYHlhV4k8E4VEn0CvjKI82lHUZWexWF26o2GapRw3tRb4S7ws0fpPzGGlJn1VM
 1/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eCwTRgt+aqBNRZTciBAj03pXt+4vXdHOb6MN+oYTGWE=;
 b=AYugiGhI+o9LItnRD1yJ1iYWIBQMw4kfhfAGYTZTYO3cMGbhzdmaMu6Qct5vYJGk5a
 eLLpnuPaER5wqV531PaOUA9XnjRVOz4x3y4y58FTrXxqf2oU5NcutuaViFyb/LFEWkaZ
 N6IPXqmnn49eNkk/2x4vK0+2rVVUkPzxyNmyVEpL9oTHt1B8UnL9wGOSshMIJmbZ/WpB
 e/d71kpruZuhHlLOmKCJb/t2dmPreSw2Sdac8YsFmqhh5RGFqZPtAgZ5uEat4pbLOPhT
 yOZgnBzvq5+JYRI6Rs4tjpeGO5UXWM4wU2u2b3pRqqxLgvRQhAq83H3GfK+KPc3d2fO3
 UV6A==
X-Gm-Message-State: AOAM530XS6UeZ8wVz7zOUp8WfZOnPdIaX5m/68xtjlE6OQ5kioayRnmz
 gaXWDRRktEwLkAWM/+motQW1l8BsxENM2G1gtqisdw==
X-Google-Smtp-Source: ABdhPJzltJabvlpfHJnDLjPqvSGCjnRMQ48hBvWGdJzD32UU+eAPxZ5JibqMBDGQkAdE99SXCiCHrGoJM5ElVVRfKAw=
X-Received: by 2002:aca:2819:: with SMTP id 25mr12855717oix.48.1594645551168; 
 Mon, 13 Jul 2020 06:05:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200710133103.2153250-1-armbru@redhat.com>
 <20200710133103.2153250-2-armbru@redhat.com>
In-Reply-To: <20200710133103.2153250-2-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Jul 2020 14:05:40 +0100
Message-ID: <CAFEAcA86WzTpFEF=OsH=zbG8Fk8P7FTJHKWSqdABKeJtT+Z4ng@mail.gmail.com>
Subject: Re: [PULL v2 14/53] qemu-option: Use returned bool to check for
 failure
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x244.google.com
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 10 Jul 2020 at 14:31, Markus Armbruster <armbru@redhat.com> wrote:
>
> The previous commit enables conversion of
>
>     foo(..., &err);
>     if (err) {
>         ...
>     }
>
> to
>
>     if (!foo(..., &err)) {
>         ...
>     }
>
> for QemuOpts functions that now return true / false on success /
> error.

Hi; this patch changes a lot of callsites of qemu_opts_absorb_qdict()
which previously didn't check their return value to now check it,
like this:

> diff --git a/block.c b/block.c
> index 62e40db2f1..850755e04e 100644
> --- a/block.c
> +++ b/block.c
> @@ -1629,8 +1629,7 @@ static int bdrv_open_common(BlockDriverState *bs, BlockBackend *file,
>      assert(options != NULL && bs->options != options);
>
>      opts = qemu_opts_create(&bdrv_runtime_opts, NULL, 0, &error_abort);
> -    qemu_opts_absorb_qdict(opts, options, &local_err);
> -    if (local_err) {
> +    if (!qemu_opts_absorb_qdict(opts, options, &local_err)) {
>          error_propagate(errp, local_err);
>          ret = -EINVAL;
>          goto fail_opts;

This has triggered Coverity's "X out of Y callsites preferred to
check the return value" heuristic. Specifically,
null_file_open() (CID 1430366) and nvme_file_open() (CID 1430347)
don't check the return value. In both cases that's in some sense
OK, because they pass error_abort; but it seems a bit inconsistent
that other foo_file_open() functions check and pass up the error
and these do not.

thanks
-- PMM

