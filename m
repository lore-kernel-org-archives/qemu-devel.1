Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F58C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 17:34:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C70A921707
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 17:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RAVpADLU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C70A921707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJKHM-0000nS-TC
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 13:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kJKGV-0000KN-Rf
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 13:33:45 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a]:34553)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kJKGT-0007ka-IN
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 13:33:43 -0400
Received: by mail-ej1-x62a.google.com with SMTP id gr14so9249081ejb.1
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 10:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Eo/CzxyoJnL+imn+wmiYtAIOxblRxrO0zpmWLLv7G0g=;
 b=RAVpADLU85NiLf+JA34XnHjoqhMdj4VAsZHJPR0vrS/6OL+R3VVV+KJptXbIP2dp6o
 WCB9HUUkQhgDuCKT+dIWZaj8YP315WeVNcRAOvK3cxKbCeycveJMeZ/bNmd8khOYvJA4
 exND7y5XMOqggYPZ9VqbS9mRnvuU9c1fwD/tFyAHDYWPIX4V/xjFlLGDUxQ209w6Bq6B
 KgJzmu5bMZvnIc3D4XRkT4YKchJzGkLkOKi2pmVuUzkw2FiQ9paa37iKI0jNYpbwOd3a
 oPZrFOWNkVBXSsMDYaVl7P06H0ituMz2DZeZqCVgb063GNYQ07xFU7xmV1Ke5k/C40df
 s48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Eo/CzxyoJnL+imn+wmiYtAIOxblRxrO0zpmWLLv7G0g=;
 b=YbzZiMMIDnzHvKXthtXcIGDiYwJPKRdwDrJUDrn3ZWSeUm4LK44svgL07s3TQwNSVc
 wz91SvV+JGA5KhqquGTXzem/Qf6ZYrTg8D8R3OWB8cXbfOe9zjrZYhacbsI0E4Rgjkao
 e1LKkc5jsIuLpQZBtKSTfpd8eXC1rptELs22iw9ygPfjZucRpoj5h+sGWm6+23/JBdu3
 98UmP8Jh7oAB0WFhAwZUfIrjgeavo6mJiHEO6GD4qxw3+ZewxrtAPhxT/wPHpyunNPKP
 oYADCi94sXYNg/BcKxthC4EXYbOCbmazwBX3xhvocI89FtyDAquymagCm86gDiiU8R74
 w1fw==
X-Gm-Message-State: AOAM5329Yvxj/gJ/TyzeQ3Hw2zxg0fvlPdZooY9MuEki1ZtOE1pXn/CK
 Fc2+9yWM9xFLFDJE+B35z+U18QsXGvvS4JkDb0VgSw==
X-Google-Smtp-Source: ABdhPJzpVZEsYU91OQI9xn8zUOTeCsbLskRmIuw36kyhDRgZ13oVCUJxAUfCNK2B0Rb0p5jOCABk1aIs6pOlHKTaY/M=
X-Received: by 2002:a17:907:20d9:: with SMTP id
 qq25mr35553172ejb.382.1600450419700; 
 Fri, 18 Sep 2020 10:33:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200916114731.102080-1-thuth@redhat.com>
 <20200916114731.102080-6-thuth@redhat.com>
In-Reply-To: <20200916114731.102080-6-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Sep 2020 18:33:27 +0100
Message-ID: <CAFEAcA-cr39jxB-AZV2Nb7jhN497RF66RTrf2eqsWxJ4Ad8F_w@mail.gmail.com>
Subject: Re: [PULL 05/24] Simplify the .gitignore file
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62a.google.com
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
Cc: Yonggang Luo <luoyonggang@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 16 Sep 2020 at 12:47, Thomas Huth <thuth@redhat.com> wrote:
>
> Now that we always do out-of-tree builds (and the in-tree builds are
> faked via a "build" directory), we can simplify out .gitignore file
> quite a bit.
>
> Message-Id: <20200909080305.258961-1-thuth@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  .gitignore | 152 -----------------------------------------------------
>  1 file changed, 152 deletions(-)

This change removed .pyc files from the set of things we
ignore:

> -*.pyc

But the meson build still runs python scripts which live in
the source tree, which means python still dumps its bytecode
files in the source tree too, and they appear in 'git status' now:

Untracked files:
  (use "git add <file>..." to include in what will be committed)

        docs/sphinx/__pycache__/
        scripts/qapi/__pycache__/
        scripts/tracetool/__pycache__/
        scripts/tracetool/backend/__pycache__/
        scripts/tracetool/format/__pycache__/

So I think we should put *.pyc back into .gitignore.

thanks
-- PMM

