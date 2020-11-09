Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA9DC4741F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 11:21:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0D57206ED
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 11:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZZiYhQo7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0D57206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc5Eu-0000ox-Ik
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 06:21:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kc5Do-0000J0-5Z
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 06:20:28 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630]:43850)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kc5Dl-0002d5-Qu
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 06:20:27 -0500
Received: by mail-ej1-x630.google.com with SMTP id me8so2247207ejb.10
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 03:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=PXnRlIqZI9DgP0CdqT4q+Sqa4Toi7XPKCXnB2PKCgkM=;
 b=ZZiYhQo7YxFZxzoTiR96p2134TW0jMdiQmG/XV7i1H65m56BllGC7yifsVhIWQaTeC
 Pwxw8XS/l7jdG5Vf+ORg3o0EBG0mYyOSbIg6XcE1SKzaBY0ESjRP0y9S3wM6nohOYJzX
 hfQ0OpvBL05a8tPN6U9Fv/8h/7Vz9zEcxWaoPAKlih3f0W+xkqNRyxVxVEuI3ACXIQvf
 lZpCo7dAxKF2TJr3zN88r/pv5rZ2J5NQ3FUhylsljHopbX/UkmPVPIB8MQpbOJJgIs+O
 rVRQLO6hOZ8aKVwH2jWJ6iuzTmmIhgASZeZ0hfvzpwp0rFjFKy6xyfaWxVgv7dhv2l9k
 RhVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=PXnRlIqZI9DgP0CdqT4q+Sqa4Toi7XPKCXnB2PKCgkM=;
 b=W+IWXxN4FwZP2SGZe2mxjU/ns/59ykSSfKMAtkSejQcJ3axPLpwZ8cvz3hACNL3sXj
 9JM8KxOc/C+U+atUXZhZ6ZLGzEYsl/w58Aok6Rr/Vbu5JYk1wozdGz6nDiYey9Y+0ZN1
 0NcgzqpL6x/TTiKC7lgELINNKrMDnnyj2oCpWtPTynAXZNLcydeaml5c8rbLf6Prvwon
 empIjBoaftdCQgI62p0K7NLrwpZixbvqt1auKkPiUDI6n2drRDHo5Jjn9Yrhi6Zsm3yx
 +tBr3txIJT163oUxSbNSEZd0vchLJJ5JQK4ryc+ijvLt+EyKYWnRbTZhufP4ZOM6+mrP
 OtYQ==
X-Gm-Message-State: AOAM531GaaARBDsaxD6z5iV23rlfbMdJLOALmHg5zaBPZHHKzl9bvMBL
 ULZib8MpD48YIWwSRTjSE9hIiYBcJ8Tlr5NAt5JG7w==
X-Google-Smtp-Source: ABdhPJznr8OJ3vHO8tvqSht1gX7vhCnQPCJkcGEJ+Wlnk6TnS8f4XNMB8ojbZb9jTWDBApnz0QNMrCGYSa6EhBJJUaw=
X-Received: by 2002:a17:906:af8c:: with SMTP id
 mj12mr13983406ejb.85.1604920822234; 
 Mon, 09 Nov 2020 03:20:22 -0800 (PST)
MIME-Version: 1.0
References: <20201108234234.2389789-1-f4bug@amsat.org>
In-Reply-To: <20201108234234.2389789-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Nov 2020 11:20:10 +0000
Message-ID: <CAFEAcA81rawbsa3_Dw8oqZbbPV0ztHgE-LvQ_643Pe3xVgyW5w@mail.gmail.com>
Subject: Re: [PULL 0/3] MIPS patches for 5.2-rc1
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x630.google.com
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
Cc: Libvirt <libvir-list@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Paul Burton <paulburton@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 8 Nov 2020 at 23:45, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
>
> The following changes since commit 3493c36f0371777c62d1d72b205b0eb6117e21=
56:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20201106' into =
staging (2020-11-06 13:43:28 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/philmd/qemu.git tags/mips-fixes-20201109
>
> for you to fetch changes up to bf4ee88ab63fcf2dcb75f0d68cc6c8d2edb68212:
>
>   hw/mips/boston: Fix memory leak in boston_fdt_filter() error-handling p=
aths (2020-11-09 00:40:44 +0100)
>
> ----------------------------------------------------------------
> MIPS patches queue
>
> - Deprecate nanoMIPS ISA
> - Fix PageMask with variable page size (Huacai Chen)
> - Fix memory leak in boston_fdt_filter (Coverity CID 1432275, Peter Mayde=
ll)
>
> CI jobs results:
> . https://cirrus-ci.com/build/5439131968864256
> . https://gitlab.com/philmd/qemu/-/pipelines/213403385
> . https://travis-ci.org/github/philmd/qemu/builds/742312387
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

