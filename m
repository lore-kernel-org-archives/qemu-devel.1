Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB8CC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 19:13:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95AAA206E2
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 19:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i0GV4b5p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95AAA206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgCM7-0004zB-Sz
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 15:13:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jgCLP-0004Ij-LG
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 15:13:03 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:43099)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jgCLO-00029N-RD
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 15:13:03 -0400
Received: by mail-oi1-x241.google.com with SMTP id j189so5539707oih.10
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 12:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PicOSrggL1/x1zqBdpkyYnSEF7MRMAte2nwFfRUMV1M=;
 b=i0GV4b5pCZqLSY5I9p6olZMFIj+51d31fH9M/Euk+CbB8FE28NE2l1b8VdhqLA7lc1
 FI7CQljqr3Vg5imhJOwDggnuzWazvPZNYEa+WYwhsh4UcXn93aiDesxEk/WODweBekkk
 avhlSuiNh51hSO3l4oKMSMm7TnhPVq/4/dCIC4Qc31t9Lh0YKx9qWgwAeQcbLu6iFd1g
 cGazdQThn1KCeuNzHWyLj+kWtu1WqMr7JsGZGYGS3k5H4ADvYW/czFyQ2Xmo5wl6NFj7
 ONYgRZa1uHVZDZRWWe/El+ZpN5n2Tc0ENS4+580wlItMaK5r2FfIo2y4VpQQ46ZXZbvc
 zemQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PicOSrggL1/x1zqBdpkyYnSEF7MRMAte2nwFfRUMV1M=;
 b=KImKERIoTAiUmA2+U7U5xsP21Zrfs9EqKHTFK6jSNcWiU0kHs2duSI++fufxsVGh7j
 QOOs5Hj1kwPmKXluNUHjXwXC9vHi7lg2no/SudI+5fvM20sNAkrmcMKNiSwsm8gA6g9b
 u6KiNrYSj+vevybewNdO23dY3lkZ59L9z49Cgd2o4Vxk4Ms+JhyPkUnZcfSe1r8Fqm7W
 XKgtMZIy685XEhu3fxeqaHeb+FbzPFat0td516W5L6rCYZn4PaLC9Cdd4e94tQaFVs60
 P+9Qxbt1JFwRHrXjtARO+FbBvd7Z42ICMXHQUpFq6eMxoPseIowIe52PpXc8HbaUcr4F
 eBmg==
X-Gm-Message-State: AOAM531XDKE50arRACEsRZZpXtEoIaztJQEmCxm77Za9YzPyHoNc7Wn7
 5bTHm8XSAfAFK0hrGcvV3aKsXBforrgIK+a/s0XMMQ==
X-Google-Smtp-Source: ABdhPJwgw3Jm39+0K5Psln/NRSHi1h7HP9ayRqmdL2wWH9+8JcJetTwd5K5OzyQ0jc/CdjBEU31HmqvWfwp7SJfV4gk=
X-Received: by 2002:aca:568c:: with SMTP id k134mr1256951oib.48.1591125181698; 
 Tue, 02 Jun 2020 12:13:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200518164052.18689-1-richard.henderson@linaro.org>
 <20200518164052.18689-7-richard.henderson@linaro.org>
In-Reply-To: <20200518164052.18689-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Jun 2020 20:12:50 +0100
Message-ID: <CAFEAcA92ZPQJpnzmjoD6CoaypAH2A6AW3Y1BL_t221YQszFhSg@mail.gmail.com>
Subject: Re: [PATCH 6/8] decodetree: Move semantic propagation into classes
To: Richard Henderson <richard.henderson@linaro.org>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 18 May 2020 at 17:41, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Create ExcMultiPattern to hold an set of non-overlapping patterns.
> The body of build_tree, prop_format become member functions on this
> class.  Add minimal member functions to Pattern and MultiPattern
> to allow recusion through the tree.
>
> Move the bulk of build_incmulti_pattern to prop_masks and prop_width
> in MultiPattern, since we will need this for both kinds of containers.
> Only perform prop_width for variablewidth.
>
> Remove global patterns variable, and pass down container object into
> parse_file from main.
>
> No functional change in all of this.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  scripts/decodetree.py | 464 +++++++++++++++++++++++-------------------
>  1 file changed, 253 insertions(+), 211 deletions(-)
>

I feel like this would have been easier to review if it had been
multiple patches (there's a lot of stuff that's just code-motion
in here together with actual changes) but I've waded through it
now, so
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

