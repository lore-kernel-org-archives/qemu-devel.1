Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBE4C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 13:34:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D1F6207FB
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 13:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SCl84hDm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D1F6207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRbUr-00082l-DP
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 09:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRbUH-0007cD-AC
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 09:34:10 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635]:43886)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRbUF-0007mm-7E
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 09:34:08 -0400
Received: by mail-ej1-x635.google.com with SMTP id md26so19544366ejb.10
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2020 06:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fUw6sfy3NN3Uxsa2VSGJUyvzB2NC6uB9NDYf3NwixBM=;
 b=SCl84hDmWAYuQahS+P0LTQmc4JViMTFwXREoXJvTg7jLq9r4zQk38iKByCN7GWIdSX
 0JFS8WBglaL/DLQZCwzM0ihnNaz24+r5o8VI6YEr56Gmmt2Ayz1E9gNxizFX/OJGqlat
 Vhul20UsIgB5BZYapyPwMio7iaoirMWhMWOe8o8Gf1WjrkVDRpgHvwDgpqgQtAFY7C0u
 3ljCqWmsvqdWJGq0qWptRWQjfBhdaYiW/IQMMLpFp9KS0/eJoGrhzYpiBossGDMzYg6Z
 1o2+MG2OCzl6HPU4NwTDX2BBeN+2bLR8FGdIDVvm4QFm02VKeEv0vASX8uE3o3NzVZkM
 Gnvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fUw6sfy3NN3Uxsa2VSGJUyvzB2NC6uB9NDYf3NwixBM=;
 b=BzkoWPNNEB/u3Re/D/04qdZthE/V1f9QUAdXk3jdGnF1skauazJ0t5ha/elYxFTYtU
 +Iiq11qQt9xPlLpNUPOUf5hRx1t9G23tPCxuM8s6tZEGvW1/1kHflKxDtAsM5oiCKfn4
 Sfmcu0Cmo1yWmX3VPBlQnTQIupi+HLdJOiYL5GW6Ikg9FhzDW1jl6hGqCK/fX3g3QL/Y
 6Uc5Mbw5S463VHxo50u63v++iGwER0EIzoA2h+UM+JoQf+PpYeo9KRJ4WoL9oOTrVUbM
 Cs0Mk9SFGOzzHVFIM4zf4Ru2RbLHseNLhEo7Y4RTq8uWt9QJSkLQQj8IdXPEevJLtMij
 f++g==
X-Gm-Message-State: AOAM530wD+nBrdzpCnyxJfb4PLdfVRW3dtB4N5PBtfjPgSsIMEDQuMsf
 fz9dglyjpeHIKwIx5mDt5s8sJpyWt/SMjnQbFD0kKw==
X-Google-Smtp-Source: ABdhPJxrGSNacdDndE+Etu8LnbGiF1AKUm3WzjeIM0Bi89r9Elo40yzqXx+aTQYXxghNj04hTv9gbSCQfsV5CdAvVHI=
X-Received: by 2002:a17:907:4365:: with SMTP id
 nd5mr24233206ejb.56.1602423244414; 
 Sun, 11 Oct 2020 06:34:04 -0700 (PDT)
MIME-Version: 1.0
References: <20201009200720.1169904-1-eblake@redhat.com>
In-Reply-To: <20201009200720.1169904-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 11 Oct 2020 14:33:52 +0100
Message-ID: <CAFEAcA9QsVbR18f5itBNAwEe936zoUhLF=b=VH_BtkUD3b7zeg@mail.gmail.com>
Subject: Re: [PULL v3 0/8] NBD patches through 2020-10-08
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x635.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 9 Oct 2020 at 21:15, Eric Blake <eblake@redhat.com> wrote:
>
> The following changes since commit 4a7c0bd9dcb08798c6f82e55b5a3423f7ee669f1:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-5.2-20201009' into staging (2020-10-09 15:48:04 +0100)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2020-10-08-v3
>
> for you to fetch changes up to ebd57062a1957307a175a810441af87259d7dbe9:
>
>   nbd: Simplify meta-context parsing (2020-10-09 15:05:08 -0500)
>
> v2: fix BSD build
> v3: fix mingw build (only the affected patch resent)
>
> ----------------------------------------------------------------
> nbd patches for 2020-10-08
>
> - silence compilation warnings
> - more fixes to prevent reconnect hangs
> - improve 'qemu-nbd' termination behavior
> - cleaner NBD protocol compliance on string handling
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

