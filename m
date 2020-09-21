Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58761C43465
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 16:43:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEEFD23998
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 16:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pwosWG6b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEEFD23998
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKOuz-00080m-Tr
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 12:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kKOsf-0006aZ-6x
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 12:41:33 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632]:34358)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kKOsc-00014Q-G8
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 12:41:32 -0400
Received: by mail-ej1-x632.google.com with SMTP id gr14so18740169ejb.1
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 09:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=NrbhbaPfUUKx6zEVY61pouTTY7SjTKE1h1Ou4rDRU98=;
 b=pwosWG6bQaL9dtVRF0KD1YHAsqhMPzxcMyxtbkLNnl/BW3xMABjTn8HkbcW9GTIMxh
 WkXMf8mLhGiYSyEwtNG+eyYyAowCgjguT9BQ5JxNFUdUV5F3AZkjgujWgt1HjruvNNhV
 Tl4Vvzjk1urceroiSKThVtt9ZppgWzNqcfU8LUBgNOov/gM+bqzeEbNFSWhOxJ83TsmV
 OP8IFN0i+xO1Io+xD3GAyopS9VSIGT1a37nxMSETQS5uEZIAX6+LDcRRBDB5BSNOatm4
 Z5ZTZh+2DSrNhSUOu7qDb9PQn9suMnPmmZTng1Z/MZmKUQAZZBQyrKXKbfGv/00p2N9p
 UJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=NrbhbaPfUUKx6zEVY61pouTTY7SjTKE1h1Ou4rDRU98=;
 b=NM3ZOwHy0/ZqCY0an99Y/8x2RacxVFxKFE3V2+7au6oPZxx2q2ktEcO+HPKXxF4zvg
 AC/3hC/XuAUnO+dHglUjf5IDQru3lmSNXOMJUdRnR89MpWwqsssjSSttLUByV1w9nGzk
 LnvcEMa73eYEg+nsMwjvqubaayRqhYwdbnD5XCzyBEq8fQHmdlWefU+MpwNU99SReBaZ
 Tq3+qpygQCFQTKUuPdOg0uYrz5XQW5aaTsjx9Nb9Vn+v3h7b3pgw5px23roWmTnLSz14
 VF6uEjU1jMpmV0FabG9VxC7z+VjBZNipsQLeBDNBjdlxU7Wepbm+vMdCcTQl/ATPxSeI
 2olQ==
X-Gm-Message-State: AOAM530f+yhyuW/q09sX1MgynMRN7nbC62+cq5U/N5ndnvoFIZzALsZK
 0cOPHjbN9uYH71Uwrd+B82WlwZrmWkdf+zM8qjWhcQ==
X-Google-Smtp-Source: ABdhPJy/4+crIUYKldg5YFW2bem835cfyAWpuh+QomFnug61mcgfF7LefilirDyKRMYpaH/s+lUrCt6Upt11Hrqh3q0=
X-Received: by 2002:a17:906:4a53:: with SMTP id
 a19mr368048ejv.56.1600706486056; 
 Mon, 21 Sep 2020 09:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200918191852.189151-1-philmd@redhat.com>
In-Reply-To: <20200918191852.189151-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Sep 2020 17:41:14 +0100
Message-ID: <CAFEAcA8nkRt5KPLJo2qkJX+6_XZoQYdL6_Vy4tU7kiQLY=yUfw@mail.gmail.com>
Subject: Re: [PULL 0/2] Acceptance patches for 2020-09-18
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x632.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 18 Sep 2020 at 21:14, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> The following changes since commit 053a4177817db307ec854356e95b5b350800a2=
16:
>
>   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/fw_cfg-2020091=
8' i=3D
> nto staging (2020-09-18 16:34:26 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/philmd/qemu.git tags/acceptance-next-20200918
>
> for you to fetch changes up to b6eea069ab3926e110b8ddf037ff7ea7b2c8c1f5:
>
>   tests/acceptance: Skip slow quanta-gsj U-boot+Linux test (2020-09-18 19=
:46:=3D
> 38 +0200)
>
> ----------------------------------------------------------------
> Acceptance tests queue
>
> Get GitLab CI acceptance jobs green again.
>
> CI jobs results:
>   https://gitlab.com/philmd/qemu/-/pipelines/191795388
> ----------------------------------------------------------------
>
> Philippe Mathieu-Daud=3DC3=3DA9 (2):

Something in your workflow is mangling UTF-8. (The actual
commits in the pull look OK.)


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

