Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDADC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 10:33:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 741D22080C
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 10:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eBj/LUP3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 741D22080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmELH-0004y1-Ok
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 06:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jmEKS-0004Q8-Bx
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 06:33:00 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:38022)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jmEKQ-0008TV-GJ
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 06:32:59 -0400
Received: by mail-oi1-x244.google.com with SMTP id c194so8031784oig.5
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 03:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=QEHSM19UExQ+wzExvHKU+WECe5y+V9mJsPRGL1RqxZQ=;
 b=eBj/LUP3aJJJWrXoM7QmakUki+DoFlTF3a7JdMXVM0+6Ob6YGiGYF5SloqRy7q0VaS
 UwNie5YiKuav6TShMQFXmduQVjRwYekx/Chzqm+J/FiOb8oXfG4cnOmZHco+au4UZPf/
 OSlU+avXXdzegjzaV0wyQZUCpMS6+2gLNOisB8jcVs3I6cPz0wGUy2bE4AFcut9nRKYC
 6Fd07GwrNIgY7O/N+fbdgD3K21XsqJzL2bhYRgJzbPufqKspp98S0CPPpgX7jfG6yXQ/
 m36tia709GmpVKLrCLmF1iZ1DetnxDIJkNPWAg/UTQAf1WzToWb7mW77GGPw1dfpnlZy
 LhuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=QEHSM19UExQ+wzExvHKU+WECe5y+V9mJsPRGL1RqxZQ=;
 b=NyksyLaaxGns+yWvQNH3TXAZRGL3XR9xkplhMogTCle0+0NXEttcVuQZLF2t+UoZSo
 rxfhSkXyLiBo/XdGb0BNU20uXfqRPW3Ygx8xt6gjpWCEEs3FLFbticC94TeQ5M1Ban1W
 /UJ9aqp/PmStU10SPWz9RgPVaFasce+Azai9/l99CaK+3744mp7Q93JaVxqnhfhVG/bi
 S8siqYzzoA4cA3Yv4h6i3EN1TNfX4kAvw/MQfiKoW1XN4j/0xYN7ggKuznIIXwCgmwG0
 B2H4/ub0PqBRrb/UsvWUq2KFUwfP8/BMC6dekZ1rPAd6w6mgXYHnEXBNpWWlM5M9niJo
 EWrA==
X-Gm-Message-State: AOAM532DD1uFepM+MRJz34CJCZE5FmmGAAYwu75f3vONoc4r0oxMRo8T
 9ZgC8BEdRvJvUOEKVhTHSGy2F7fJVT5rhNLAvRwuCQ==
X-Google-Smtp-Source: ABdhPJxdWFBrO6yzo1fcpwYWDdt0B6xKItKSAqJwZALM2sL0yYQII3AqOvOoqDJKqIrPN8ptsjtba1z2aJl65JZsMfM=
X-Received: by 2002:aca:5152:: with SMTP id f79mr2411658oib.146.1592562777164; 
 Fri, 19 Jun 2020 03:32:57 -0700 (PDT)
MIME-Version: 1.0
References: <20180724105109.8392-1-alex.bennee@linaro.org>
 <20180724105109.8392-7-alex.bennee@linaro.org>
In-Reply-To: <20180724105109.8392-7-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jun 2020 11:32:46 +0100
Message-ID: <CAFEAcA8BzEiBVyy7CDbsJdG4FCy_GErW_ZuXQt++__vZ149=jw@mail.gmail.com>
Subject: Re: [PULL 06/17] docker: move make check into check_qemu helper
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Fam Zheng <famz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 24 Jul 2018 at 11:51, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Not all docker images can run the check step. Let's move everything
> into a common helper so we don't need to replicate checks in the
> future.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
> diff --git a/tests/docker/common.rc b/tests/docker/common.rc
> index ba1f942328..4ff5974016 100755
> --- a/tests/docker/common.rc
> +++ b/tests/docker/common.rc
> @@ -40,6 +40,17 @@ build_qemu()
>      make $MAKEFLAGS
>  }
>
> +check_qemu()
> +{
> +    # default to make check unless the caller specifies
> +    if test -z "$@"; then
> +        INVOCATION=3D"check"
> +    else
> +        INVOCATION=3D"$@"
> +    fi

Philippe pointed out on IRC that a recent change has resulted
in the shell now pointing out an error in the above code
(with "common.rc: line 50: test: check: binary operator expected").

test -z wants a single string argument, so passing it "$@" is wrong
(that will expand to multiple arguments if the function was
called with multiple arguments).

Probably what is wanted is
  if [ $# =3D=3D 0 ]; then

ie test whether the function was passed no arguments, rather
than looking specifically for whether all its arguments
squashed together end up being the empty string. (If you
really want the latter that's "$*".)

> +    make $MAKEFLAGS $INVOCATION
> +}

thanks
-- PMM

