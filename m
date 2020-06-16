Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C953C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 09:21:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3C1520707
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 09:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mrz8Ckcc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3C1520707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl7mL-0003Dj-1b
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 05:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl7lI-0002Yk-UD
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 05:20:09 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:46584)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl7lH-0005aP-4l
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 05:20:08 -0400
Received: by mail-oi1-x244.google.com with SMTP id 25so18585981oiy.13
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 02:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Vi0cS4u7Tp1s2KW5n1LlvEBhPw5voslC+oFhMHJRJlI=;
 b=mrz8CkcclQV3YWOg807HC+td+H0s7cmYT8fD9FRjRWyVZ19/cm2hLXXYZU0zL/fh8X
 2CoRdrLHNut/AeYwK8ytUhX/BaXeYy8t2gnUfOTJCprNV3mRhDcezGFQFREoMOogR/JV
 xBZ+fgQpf17GwRB1xNmnezDE7+1BFOw0C46hhuJNg5n5RCGtCe/7NhGvwB8PO21HetbM
 ml/8yua190BD/lCWrhsC1lXRHhRqlXspZsy4ljOwqdajr0kQAEmM/8jlTtHV80VlMglk
 0pjYPGXu8Bm3c4FAg0lBFAgjjv5gut/d2tyR2Ovb5PafbtdCldYoKNbljBfUz0ujMZhI
 tCsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Vi0cS4u7Tp1s2KW5n1LlvEBhPw5voslC+oFhMHJRJlI=;
 b=BtZ80wX//jFQH2W7qP+mfIemWkiKevaNfahy+dkUm7x4/s0mrqSrHkkRo4KzORDRjl
 Ye+ZzI9eyXKU3VfYoocjny5bgxZiCZUKRhjo9cSZYe7jzAfS3dVIlzjrTN9ecc5vkR/G
 xCSvIFF36qUCXUSKU2p6HvkEG/12AXJFkYGUWPaN2nwl/FMUzSxsNwYfb51+B4edm4RE
 85fqHRA/CtqXX43IwraZFWf5ywoHrjOxYGQ3FoKvbHtweqRn2ECVLhBxhn5t+CF/1wqW
 KXRp32pUIj+9NS+bNkBhzkev5XL79feszxm1Z6+EDSpvAqqqiLoDzNzv46uxr0/gGYhs
 l6GA==
X-Gm-Message-State: AOAM532f4uSekba6DSe6hjhrY6Y6qXIrYQcb8S6MfPHOeg8HUowl5CQp
 xacnQmFuLymUOc8DM0zOtngO5AW+dh0lbMENQNacQA==
X-Google-Smtp-Source: ABdhPJxy4MWa4nxnxbTFsIvMg3DAiH1AkBIPhxeJh+R+huZr9PrPnAzMVIow811fQvylO+bsOga6Aq4MxxAvIzdfUmw=
X-Received: by 2002:aca:5152:: with SMTP id f79mr2503813oib.146.1592299205682; 
 Tue, 16 Jun 2020 02:20:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200615225827.183062-1-joe.slater@windriver.com>
In-Reply-To: <20200615225827.183062-1-joe.slater@windriver.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2020 10:19:54 +0100
Message-ID: <CAFEAcA_ZU_w7PaYFVVaW1vzGySOLaNaThVcNQFNmd_GV-hG6Qw@mail.gmail.com>
Subject: Re: [PATCH 1/1] os_find_datadir: search as in version 4.2
To: Joe Slater <joe.slater@windriver.com>
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
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 "MacLeod, Randy" <randy.macleod@windriver.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 16 Jun 2020 at 00:00, Joe Slater <joe.slater@windriver.com> wrote:
>
> Always look for ../share/qemu then ../pc-bios when looking for datadir.

Could you provide some more context, please? Why is this
change useful; presumably we broke some setup in 5.0, but
what exactly ?

I'm guessing this might be a regression introduced by commit
6dd2dacedd83d12328 so I'm ccing the relevant people.

> Signed-off-by: Joe Slater <joe.slater@windriver.com>
> ---
>  os-posix.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/os-posix.c b/os-posix.c
> index 3cd52e1e70..f77da94bf6 100644
> --- a/os-posix.c
> +++ b/os-posix.c
> @@ -82,8 +82,9 @@ void os_setup_signal_handling(void)
>
>  /*
>   * Find a likely location for support files using the location of the binary.
> + * Typically, this would be "$bindir/../share/qemu".
>   * When running from the build tree this will be "$bindir/../pc-bios".
> - * Otherwise, this is CONFIG_QEMU_DATADIR.
> + * Otherwise, this is CONFIG_QEMU_DATADIR as constructed by configure.
>   */
>  char *os_find_datadir(void)
>  {
> @@ -93,6 +94,12 @@ char *os_find_datadir(void)
>      exec_dir = qemu_get_exec_dir();
>      g_return_val_if_fail(exec_dir != NULL, NULL);
>
> +    dir = g_build_filename(exec_dir, "..", "share", "qemu", NULL);
> +    if (g_file_test(dir, G_FILE_TEST_IS_DIR)) {
> +        return g_steal_pointer(&dir);
> +    }
> +    g_free(dir);  /* no autofree this time */
> +
>      dir = g_build_filename(exec_dir, "..", "pc-bios", NULL);
>      if (g_file_test(dir, G_FILE_TEST_IS_DIR)) {
>          return g_steal_pointer(&dir);
> --
> 2.17.1

