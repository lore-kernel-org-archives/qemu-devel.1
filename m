Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C16C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 12:33:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D08C820748
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 12:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KxF7Sckm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D08C820748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtsDy-0004Ds-5l
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 08:33:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtsDM-0003gB-Ar
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 08:33:16 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:36942)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtsDJ-0004iu-Ld
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 08:33:15 -0400
Received: by mail-oi1-x242.google.com with SMTP id 12so4656618oir.4
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 05:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ec+3tL/mYn2UaGCPTACI64Gx48NwQiUE7Q846rYKXio=;
 b=KxF7SckmNguK3qJ1OZZGmwCbY6fzlnixx6EvrO9Ek8Ry8bSa46Y47HOC9JidtMq8QX
 UgUr++dMaLNNaaagQs2o3w00dz+NnRmHi7+Qu1OZKPHOoKy7c2YAQJj2Dn9U5kxAv22+
 8IasDlfdtLjUkhLvaGbeGSU1bedOBekoCn62GDp5ebHJGJ1btmXt2ryAkK8/ebcZWYn7
 7zHYhB2ogtyfdeGBphQCjag1E98QDdHyqPcSNBiP+QjQSw9EmLmgq7P7xBv8nU09ZLwP
 OjKtnLRB58mDlyBxXRxjxxKfvVgh4eR/MicEA6nj5rly0u8jHawl0oy3COEAfHT6aZ3H
 rz6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ec+3tL/mYn2UaGCPTACI64Gx48NwQiUE7Q846rYKXio=;
 b=gP5mJp+1HI0sbDgMK9+6HlB4ICE/mHSokXKy2Jd56fqkF+g3DzWGBbE+QZipG5AwhX
 +ZC3d2tGGvDblw3/rehzYZKAwbgHS9ZGpGfy+n0gsUiNJkTWV8dx5l/DuZU7gEgwvBI1
 mTF+WSocNRQVIaNcby7aN3BD7US+onLg0T6nKzsUBNbD/RRNb1Q4oTRiBzaBpWpekCb5
 iTVkcKqFYzSzyIJt4T0i+7Mp03b9Amvjm6os/JrDalWFRwQbT2jos+PpHA4NCKU2oRBd
 4JjvSfWammjUvOrtYAeuXXdbz7EFBSzcjIpU3cYg1s9yDt8XooiMT9mA/XE1EEnVFesd
 C7fw==
X-Gm-Message-State: AOAM532e/AodpVdKUqQB1DDM60QvG6JkojqogCzZpldy470ngRd1TnW2
 yCZSI2mMacQle8K0vUtwGGVuvN4EWCyy5+S7Yp/8Kg==
X-Google-Smtp-Source: ABdhPJxiL3K2wTSD43tVg2SGckk3XOCgc1RPvfE7eGuMSQvPtHEQOyun7MRsfdARm2SpmvWcuEiZNVQYRrFPEJs/RZA=
X-Received: by 2002:aca:54c9:: with SMTP id i192mr3990490oib.163.1594384392304; 
 Fri, 10 Jul 2020 05:33:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200710121717.28339-1-kwolf@redhat.com>
In-Reply-To: <20200710121717.28339-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jul 2020 13:33:01 +0100
Message-ID: <CAFEAcA-QXayeXzrAv5=5mJvRy-qC5FD3Z7AEw3ZW_UDAZ6V8-w@mail.gmail.com>
Subject: Re: [PATCH for-5.1] qemu-img resize: Require --shrink for shrinking
 all image formats
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 10 Jul 2020 at 13:17, Kevin Wolf <kwolf@redhat.com> wrote:
>
> QEMU 2.11 introduced the --shrink option for qemu-img resize to avoid
> accidentally shrinking images (commit 4ffca8904a3). However, for
> compatibility reasons, it was not enforced for raw images yet, but only
> a deprecation warning was printed. This warning has existed for long
> enough that we can now finally require --shrink for raw images, too, and
> error out if it's not given.
>
> Documentation already describes the state as it is after this patch.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qemu-img.c | 17 +++--------------
>  1 file changed, 3 insertions(+), 14 deletions(-)
>
> diff --git a/qemu-img.c b/qemu-img.c
> index e3b2ec3e78..f6a2703039 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -4011,20 +4011,9 @@ static int img_resize(int argc, char **argv)
>      }
>
>      if (total_size < current_size && !shrink) {
> -        warn_report("Shrinking an image will delete all data beyond the "
> -                    "shrunken image's end. Before performing such an "
> -                    "operation, make sure there is no important data there.");
> -
> -        if (g_strcmp0(bdrv_get_format_name(blk_bs(blk)), "raw") != 0) {
> -            error_report(
> -              "Use the --shrink option to perform a shrink operation.");
> -            ret = -1;
> -            goto out;
> -        } else {
> -            warn_report("Using the --shrink option will suppress this message. "
> -                        "Note that future versions of qemu-img may refuse to "
> -                        "shrink images without this option.");
> -        }
> +        error_report("Use the --shrink option to perform a shrink operation.");

I think it would be nice to retain this bit of text:

> -        warn_report("Shrinking an image will delete all data beyond the "
> -                    "shrunken image's end. Before performing such an "
> -                    "operation, make sure there is no important data there.");

ie, make the raw-shrink case be the same as the non-raw-shrink
case currently does.

thanks
-- PMM

