Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77948C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 16:09:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAC3F20EDD
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 16:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GZjCEHgh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAC3F20EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHr2q-0004He-PU
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 12:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52938)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHpRn-0004CM-GL
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:27:11 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:38455)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHpRl-00022c-Oi
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:27:11 -0400
Received: by mail-ed1-x544.google.com with SMTP id c8so17822694edv.5
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 07:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PZhkTNi/pJh7IihjbEyxUbIgZfOnL8LFpBN4Qfkw1uo=;
 b=GZjCEHgh9ihtofT8uxzYJfdJEZPfVhx2cI0+KXElBdJpgzwCKVh8KqUdOllmtIxjiO
 rrBtTsohiK3Um1oX9vy5ihIisWBezPMjeX8QCwoBCteZcwAyH1erGRbbRpSw7EZz+Tu8
 vTtYlNawewKFujtsdJWnYlDNAV1xJyv+Lgx4sZhR9pPUv0KAWIUKXkAoF8i197nxP4+i
 fwhyz8pMXoU4ySXrSMJbyFO6I8KFXIwuOdL4JOQ54EtnMJEjX+83e8SSF4vDsxaU1sUn
 wPS4DqoV9H9XXTjAqtVdd5jsMS+GFeOpL/b+Gqmwq+meVn4XqbjeGvFpNDbf9YfRotT4
 8ENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PZhkTNi/pJh7IihjbEyxUbIgZfOnL8LFpBN4Qfkw1uo=;
 b=eXyY/2i/ke1sOs3TU7VMs5//PPK1tiC2taMoeRQd9oXXlJ0qY/tzRlvoT4HsjM5Y6Y
 CscBXixYM8UL4buGeHDX0HswNdRZWQwYr3WOp8VGwm8Z6fjwY6qv5F+RCTlT6jQWVLt/
 UdYuxOoleKKQN0zsC6N1d3u5ZR+ipOSKl7aD0fwn0Lvw+lUNi412M3gPKrsuLANadczi
 aVyQc3eJcPQ1tbw8Vrto36nNn5u2NgNRHgQyhyBbeun4BM1Gg7kDS7nGiXT4/YT4GIdx
 68/LqiU4GIOhLVnMAQjAD8PMdPDLfsoKVr/yy6WXaSzmd2hyg3brhfuplXGwhC+B3yGr
 0mCg==
X-Gm-Message-State: AOAM530qMKwc8sPZKkuhNfMe0bgU+t29zSaI6d/u/hdfgWDEFTJ4Xneh
 zs1pJafJ2uK7PUybQCBzr8bZjzjtjsVJ2u28V5q0Ag==
X-Google-Smtp-Source: ABdhPJyltT5pXczhbS6mj+yJgC4xG5EWALiXY5e9wq7Y4DSjxe/LNNUu8Q6ZYULUugEyHgxDY5DvO+f5nxWUssdku9E=
X-Received: by 2002:a50:f1cf:: with SMTP id y15mr17831613edl.204.1600093627867; 
 Mon, 14 Sep 2020 07:27:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200914141730.90279-1-mreitz@redhat.com>
In-Reply-To: <20200914141730.90279-1-mreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Sep 2020 15:26:56 +0100
Message-ID: <CAFEAcA9CruJdDK4JDgpod6oo6cN0cp9AxH=_n781NoxuqfMNuw@mail.gmail.com>
Subject: Re: [PATCH v2] iotests: Work around failing readlink -f
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x544.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 14 Sep 2020 at 15:17, Max Reitz <mreitz@redhat.com> wrote:
>
> On macOS, (out of the box) readlink does not have -f.  If the recent
> "readlink -f" call introduced by b1cbc33a397 fails, just fall back to
> the old behavior (which means you can run the iotests only from the
> build tree, but that worked fine for six years, so it should be fine
> still).
>
> Suppress all error messages, so in case using $PWD works out, we do not
> cause the user to worry.  If it does not work, we will end up printing
> the following error message anyway:
>
>   check: failed to source common.env (make sure the qemu-iotests are run
>   from tests/qemu-iotests in the build tree)
>
> Following that hint (running check from $build_tree/tests/qemu-iotests)
> will make it work, and is probably even easier than obtaining a readlink
> that understands -f.
>
> Fixes: b1cbc33a3971b6bb005d5ac3569feae35a71de0f
>        ("iotests: Allow running from different directory")
> Reported-by: Claudio Fontana <cfontana@suse.de>
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
> v2: Suppress stderr (as requested and suggested by Peter)
> ---
>  tests/qemu-iotests/check | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
> index e14a1f354d..3c9ccc117b 100755
> --- a/tests/qemu-iotests/check
> +++ b/tests/qemu-iotests/check
> @@ -44,7 +44,11 @@ then
>          _init_error "failed to obtain source tree name from check symlink"
>      fi
>      source_iotests=$(cd "$source_iotests"; pwd) || _init_error "failed to enter source tree"
> -    build_iotests=$(readlink -f $(dirname "$0"))
> +    build_iotests=$(readlink -f $(dirname "$0") 2>/dev/null)


Having woken up and actually looked at the context for what
we're doing with readlink here, my usual rune for "give me
the absolute path that this script is in" is

thisdir="$(cd "$(dirname "$0")"; pwd)"

which should be more portable than readlink. It doesn't
give quite the same behaviour if it's run via a path which
is a symlink to a directory, eg if bar/ is a symlink to
foo/ and you run a script as bar/thescript then you'll get
back /path/to/bar/ rather than /path/to/foo/, but do you
really need the path with all the symlinks followed
rather than just some valid absolute path to the build dir?

thanks
-- PMM

