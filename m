Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F447C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 16:28:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6B15207F5
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 16:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y0d9Wpzi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6B15207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkry8-0007BP-4L
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 12:28:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jkrwI-0004Ye-Pg
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 12:26:26 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:38661)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jkrwG-00066V-LN
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 12:26:26 -0400
Received: by mail-ot1-x343.google.com with SMTP id n70so13573315ota.5
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 09:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=451uHoLtgSZhZMkHwRegiT7tWURsT2JFoOdH276EGmc=;
 b=y0d9WpzirfIRVGO4TJmwAVdTnDcrQy6mrqwWQo8cIU/1RurfZ2PLxiZsiz4wL4hInh
 CbvAz72nSKLpL1k043LiaPqyBB45ULpnVRfLtZ74K+ur7L+6Mu4q98eaxIr9vS6Vq7SO
 emksIf5fYt8kQvDrNXHBHQtVas4t9LJyF/33GTjNqUXnGcl4akDGDmZ1C7DG4FJ/3xq/
 3dQxOgzLTPk3TWryUehZvnvT6Ars4C0Yud66c7x+bZfNk8yR74FckFIOCNehFNAjplwQ
 VAzwszb5QalHYm8MDYqFcOtXsS6P6sjrZ95uWKUvbVZ4W5wGbUeSCPFH+HRAjiSNe2NX
 rhyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=451uHoLtgSZhZMkHwRegiT7tWURsT2JFoOdH276EGmc=;
 b=Ty1WXoYTHuvMQ/NTdSvK+HGRt87NJwwldR9q2zeeLvo8bPzwcreXYjTwDEa5meQorA
 JE816q24SczqHgXwe72iuhDsaGmbyBQfHAzKTHmZn6fqDp4shJwbCj8X3YhiPFZsDJF9
 dzhquqro5+KjQ8cvw5SSvrRXvFkLfLzGJ8tGGVhupl/heVftTYPXUkdxj22D4jli5l+0
 q3d6yeuxziiMLeHrtZw3rD3CZjNci59RfZ+H4oWdCaUlUTY4j5nbQ4ubHNbcZed3fmTb
 v9dNx8QUmf1BMyJbh4o0h4IAYZKMGM3H9nPdnX7xX4QOoBfR+ix88unyYnE6yCFSKGJi
 7ktg==
X-Gm-Message-State: AOAM5332Akpt2Islame/KMGlPHHnmFuldehH08HE1zng2pMVnxGlERHN
 N4VzHOFDqOs1VOTZrt+ANOWrWNVqncI70cScjsikLw==
X-Google-Smtp-Source: ABdhPJx8Exijq5m96tAwPtesYoERqZ9dhe2WxPg1xcERKrna7gTdNbL1WsE56ga2PBgmhZCM1dN+RtzJCiwEQP0IfPY=
X-Received: by 2002:a9d:67d6:: with SMTP id c22mr21175875otn.221.1592238383419; 
 Mon, 15 Jun 2020 09:26:23 -0700 (PDT)
MIME-Version: 1.0
References: <CA+XhMqwH6btbKFD0Ei47e+QHN2eBPG5H2PTS92MAje2Tij4Y=A@mail.gmail.com>
 <76587685-fa03-6dd6-5ca3-caeaf3c7504b@redhat.com>
 <20200603090921.64351a28@titan.knownspace>
 <CA+XhMqw2ORNvkN=C+LdvMxDvrX2i25FW-9wXias6Mbu0wGjBrg@mail.gmail.com>
In-Reply-To: <CA+XhMqw2ORNvkN=C+LdvMxDvrX2i25FW-9wXias6Mbu0wGjBrg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jun 2020 17:26:12 +0100
Message-ID: <CAFEAcA9L_+4xBv6wUOTJEMxdGOjoF_nCO2G-wyEHuhvb+dfd7Q@mail.gmail.com>
Subject: Re: [PATCH] util/oslib-posix : qemu_init_exec_dir implementation for
 MacOS
To: David CARLIER <devnexen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
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
Cc: Justin Hibbits <chmeeedalf@gmail.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 John Arbuckle <programmingkidx@gmail.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>, Izik Eidus <izik@veertu.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Mikhail Gusarov <dottedmag@dottedmag.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 3 Jun 2020 at 15:23, David CARLIER <devnexen@gmail.com> wrote:
>
> Good point even tough the libproc api is here in this form since quite a time.
>
> From d23bf60961ee036f8298794f879d1b8b9bd717dc Mon Sep 17 00:00:00 2001
> From: David Carlier <devnexen@gmail.com>
> Date: Tue, 26 May 2020 21:35:27 +0100
> Subject: [PATCH] util/oslib: current process full path resolution on MacOS
>
> Using existing libproc to fill the path.

Could you send new versions of the patch as their own emails
(ie not replies to the first one) with "[PATCH v2]" "[PATCH v3]"
etc in the subject line, please? Otherwise it gets tricky to
figure out which is the most recent version of the patch.

> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  util/oslib-posix.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index 062236a1ab..9dd1e1a18b 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -55,6 +55,10 @@
>  #include <sys/sysctl.h>
>  #endif
>
> +#ifdef __APPLE__
> +#include <libproc.h>
> +#endif
> +
>  #include "qemu/mmap-alloc.h"
>
>  #ifdef CONFIG_DEBUG_STACK_USAGE
> @@ -366,6 +370,15 @@ void qemu_init_exec_dir(const char *argv0)
>              p = buf;
>          }
>      }
> +#elif defined(__APPLE__)
> +    {
> +        int len;
> +        len = proc_pidpath(getpid(), buf, sizeof(buf) - 1);
> +        if (len <= 0) {
> +            return;

I think that if proc_pidpath() doesn't work we should fall back
to the "try argv[0]" code below, not return without initializing
exec_dir[]. This is what the existing Linux and BSD codepaths do.

> +        }
> +        p = buf;
> +    }
>  #endif
>      /* If we don't have any way of figuring out the actual executable
>         location then try argv[0].  */

I did a bit of searching to see whether there were any alternatives
to proc_pidpath(), and I found _NSGetExecutablePath(). This
function *is* documented:
 https://developer.apple.com/library/archive/documentation/System/Conceptual/ManPages_iPhoneOS/man3/dyld.3.html

Will it do what we want here? You'll need to call
realpath() on the results, and we should test that it
actually does better than just looking at argv[0] -- ie
that if you start QEMU via execve(/path/to/qemu,
argv_with_bogus_argv0, ...) then we get the /path/to/qemu,
not whatever the bogus argv0 value was.

There's also the "get the ui/cocoa.m code to find the path
via the AppKit API" approach that Roman suggested, though I
think that is more awkward than _NSGetExecutablePath() as
you'd need to get the ui/cocoa.m code to save the path for you.

If that doesn't work then I guess we can use proc_pidpath(),
but I'd rather avoid that if we can. If we do have to go that
route we should have a comment noting that it's an undocumented
and unsupported API but that it's also used by well-known
applications X, Y...

thanks
-- PMM

