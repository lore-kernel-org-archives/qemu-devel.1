Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F51C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 13:06:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 648DE20850
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 13:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sy23q4oR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 648DE20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51398 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbluq-0004Iw-Ji
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 09:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36474)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbls3-00037p-Uz
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:03:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbls2-0008J9-GS
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:03:55 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45308)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbls2-0008DH-3r
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:03:54 -0400
Received: by mail-ot1-x344.google.com with SMTP id x21so2507044otq.12
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 06:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=8MyXPf2ufEZ379ZkwSCPqQiWdj1iGW5KBKLNtd5q4dk=;
 b=sy23q4oRNFwwA1n7gZgYGxvj4/d+pqBAHnkCckc82gSkJKDt8f/FW78dg0vLyTv/2S
 UAeooqAbD9lBnnT4MNhXHk19YKEokycH8UlHefYxvCrX4nmULADy7F5ndpw4JiEFX2og
 hvSJAScXlDHwi7Dftp2EXqweywb7cVPUO7+BGNyQe1uXvpqokNWvxGH9U71KQKT8JvVB
 aRT+qD0xFbwSNjnxFDBEOVNHDOCoEwV4B6f/ZGfROTHLilD9+4+l9TbYnWGU6NjeCgXt
 J/uw5REdvmza//Kp4xmwqwijBPGij6/SDShEvuSPiLWtLgpVldOIlUjiB7z6CZh5HvSl
 nn0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=8MyXPf2ufEZ379ZkwSCPqQiWdj1iGW5KBKLNtd5q4dk=;
 b=DYl7wRtRFtHOaEuHq4XkcDV/4QqMBT90hxtnqXbCfL/9+pMOuBjr9EDrI1qu7l4wbx
 VmtgD8J3u/D29SFUJcYSU8IgVpYO6mbGl4VpDrZj6jnQ5lHlcq6TQxDKrAOPFRgCkNU3
 maNXo/VBPKX7Rk0iBK4m27DF5zrrurZzmZ7zrvkR5aSvpM9I/vJKk6s6xEXpLW3GyYNM
 /Ufvx3xNd2IN6N8KFxCc1OoA6lh1A4IeuMsavA1iqf0R5mQznyfXQ42MUy374wD3MhP6
 9bhUJOXNtlA1KV3EHIZyd5beIyNOZ4wbx5qn+dPBYDd/Erx4jZo5HWSSfLS26wyO/yEN
 /Miw==
X-Gm-Message-State: APjAAAX5NkLQCx7NlFgpbG67hoVifK+O13zjJlV7kxPrcZQN9Xi2nckF
 Lserh9VlhRM+69gkcwfBXr23QFQeqcCslw3q2vNwDg==
X-Google-Smtp-Source: APXvYqwaWxHy0XnAb5OIoNwJmjMceZ62ufjIod/IVKdvxV1T+YILhTCH1sQo9QHCocSkvf10peBYKucn9ZH2XDZEs3w=
X-Received: by 2002:a9d:6a0f:: with SMTP id g15mr6011349otn.135.1560517429322; 
 Fri, 14 Jun 2019 06:03:49 -0700 (PDT)
MIME-Version: 1.0
References: <1558550785-20098-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1558550785-20098-2-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1558550785-20098-2-git-send-email-aleksandar.markovic@rt-rk.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Jun 2019 14:03:37 +0100
Message-ID: <CAFEAcA-znG6-4iCKX_8kheROUOTh0HfVxqn=RVdbZKz7-R6VkA@mail.gmail.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH 1/5] linux-user: Fix sigismember() check
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?B?TWlsb8WhIFN0b2phbm92acSH?= <Milos.Stojanovic@rt-rk.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 22 May 2019 at 20:00, Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
>
> From: Milo=C5=A1 Stojanovi=C4=87 <Milos.Stojanovic@rt-rk.com>
>
> Fix copying between the host and target signal sets for the case when
> the target set is larger than the host set.
>
> sigismember() returns 1 if the specified signal number is a member of
> the specified signal set, but it can also return -1 if an error occurs
> (e.g. an out of range signal number is specified). All non-zero values
> would cause the signal to be added, so a comparison with 1 is added to
> assure that only the signals which are really in the set get added to
> the other set.
>
> Signed-off-by: Milo=C5=A1 Stojanovi=C4=87 <Milos.Stojanovic@rt-rk.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  linux-user/signal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/linux-user/signal.c b/linux-user/signal.c
> index 44b2d3b..c08a7fe 100644
> --- a/linux-user/signal.c
> +++ b/linux-user/signal.c
> @@ -116,7 +116,7 @@ void host_to_target_sigset_internal(target_sigset_t *=
d,
>      int i;
>      target_sigemptyset(d);
>      for (i =3D 1; i <=3D TARGET_NSIG; i++) {
> -        if (sigismember(s, i)) {
> +        if (sigismember(s, i) =3D=3D 1) {
>              target_sigaddset(d, host_to_target_signal(i));
>          }
>      }

I think perhaps a better fix for this would be to correct
the loop termination condition to be "i < _NSIG". What
we're doing here is looking at all the host signals in
s to see if we should be adding them to d, so what we
should be looping over is the valid range of host
signal numbers, not the valid range of target signal numbers.
Then we don't need to care about what sigismember() does
if passed an invalid signal number, because we'll never do that.

I also think we may have some off-by-one errors in various
comparisons with TARGET_NSIG and _NSIG: sometimes we
compare with <=3D, ie taking _NSIG or TARGET_NSIG to be
the highest valid signal number, and sometimes we compare
with <, taking it to be one greater than the highest valid
signal number. For instance compare the signal_init() code loop
and the size of arrays like host_to_target_signal_table[]
versus the loop condition in host_to_target_sigset_internal()
and target_to_host_sigset_internal().

I *think* that the correct intepretation is "it's one
greater than the highest valid number" and we should fix
the conditions in:
 host_to_target_sigset_internal
 target_to_host_sigset_internal
 do_sigprocmask
 signal_init
 host_signal_handler
 do_sigaction
 process_pending_signals

but somebody should definitely check whether I'm right or not.

thanks
-- PMM

