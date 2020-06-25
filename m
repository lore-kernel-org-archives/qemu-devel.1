Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920CBC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:12:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D69A2070A
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vAqx8Gfm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D69A2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joOs1-0007nJ-FC
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 06:12:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joOr9-0007KZ-Vr
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 06:11:44 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:44290)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joOr7-0003J6-Tm
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 06:11:43 -0400
Received: by mail-ot1-x341.google.com with SMTP id 5so2727478oty.11
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 03:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LUNyh6+vb/DeP9taqQHwavJHODE4vNHs1FApurtl/e4=;
 b=vAqx8GfmIJoN71XTIByUDu9BdP2cEBHt76trFsKCnA/T3KuYkPKKKvwYkV1UtG5Xz9
 QH9GLI4GHrj1dn12NahfAxDNRy0h5QfG5GxGQrh8CcPq3foHl7/fPfetIjYHkjgD4A9m
 b6onEdz84TN8L+SBvK0FySmYkDcFkBi+cOpirLoeSJejg5VrqqMqt4yNVmDRwgIWmzif
 /qyIg9jqXSOSbtOO/+ni8yvc8DPxJ6F9SOozuv+fMJYDwZU7g+aMmpifZrqmrqZUEkWB
 l00bjv7BKeQgJfOlvqivWk8ggveQ49o1psgaH+VOxHR5ILqHxm8ApHR8vocMpCLNCry+
 nkEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LUNyh6+vb/DeP9taqQHwavJHODE4vNHs1FApurtl/e4=;
 b=tHtFET9qYJhayhfjnt58cqW9zwY1D5L2e5eR7wQEziJkKwfVvuxO+1PgWxnGk9IKhu
 tbNp/D+02MpeCCLow08fWiDoISmTeIZ5q7Pbk2XmMNNMH1ZFcWFnzvimGaaww/IFuAKa
 HObe94ugYgvxV+v1k5A8bp0xrrcfNalXoEYURbq+x5x7DL69fine1w3UXaA2Og3UNmR9
 xG/MUkCd4fYLdGiLxhzZP9cmAyal7R9Wlpz6CS+42QPNuOx9VYisk2AeHunSyrKG+bNo
 5drYtQNeAV7sEmBJc93hKVKAJlxsFlxv/7IKb/hkTFDJz8oZrbF6R0rP3m1AwEpgDbQl
 BPdQ==
X-Gm-Message-State: AOAM532kSmFEU7PZFXvTbtkcxzWDoiAranE4cY4ZtbCT1KxZqT2LvEVh
 EOfD1vO1uEIVkhESB30vnFtAzufh3pSV/H62Sz3LRg==
X-Google-Smtp-Source: ABdhPJyPud+ypTRAD5XZ3OPkEnNumYNlbzB9giHqyiefLWnVtXKgvcNqP2O9vslkuSIxGj6iUWZHzLP+8M6domaVsyw=
X-Received: by 2002:a05:6830:8d:: with SMTP id
 a13mr25973161oto.91.1593079900384; 
 Thu, 25 Jun 2020 03:11:40 -0700 (PDT)
MIME-Version: 1.0
References: <f0b64bf047e343f8b2e91baeccb4753bc26b17cc.1592686588.git.balaton@eik.bme.hu>
 <20200624164737.A941374633D@zero.eik.bme.hu>
In-Reply-To: <20200624164737.A941374633D@zero.eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2020 11:11:29 +0100
Message-ID: <CAFEAcA9MEhe96mqQ9jm3vZsdfMhK6SxS69s35-pEuRFWK8Xb2w@mail.gmail.com>
Subject: Re: [PATCH v4] sm501: Fix and optimize overlap check
To: BALATON Zoltan <balaton@eik.bme.hu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
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
Cc: Sebastian Bauer <mail@sebastianbauer.info>,
 Magnus Damm <magnus.damm@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 24 Jun 2020 at 17:47, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> When doing reverse blit we need to check if source and dest overlap
> but it is not trivial due to possible different base and pitch of
> source and dest. Do rectangle overlap if base and pitch match,
> otherwise just check if memory area containing the rects overlaps so
> rects could possibly overlap.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
> This version fixes overlap check according to Peter's suggestion, only
> resending this patch as v4, others still valid from v3. Let me know if
> you want the whole series resent instead.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

