Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2037BC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 12:54:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD9F720658
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 12:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TN8MiUwp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD9F720658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJGPK-0005Hd-1Y
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 08:54:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38236)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jJGOj-0004mz-4j
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:53:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jJGOh-0002gc-OA
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:53:40 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50580)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jJGOh-0002ef-DR
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:53:39 -0400
Received: by mail-wm1-x341.google.com with SMTP id t128so2350432wma.0
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 05:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=bc3saWV0ftPoTYclYc6gSCVV0Zk8+YiuJV4dwGsa3jE=;
 b=TN8MiUwpEizRnDkXCHrzJg1LiKbH6vosZtgzRu1lwFS++6CS57aCQKR5G5BSaT5D3g
 CZWz/Or/XM639hO/cBpYJ+zBc9iDzffWy4VcB8adeVJbuO8jhsd3Mb2q0N+6SyVgedHi
 YtZFuGCZyWtjV43OvqnaJg4ifkCeHv4AC3LmgMTmxp7bZitNJkHg61eMvS259r7IFHNF
 OkcRAtgpNmI6C5HFaFQnZFF06g5oz9JFDSvm7kmG4qmNnxM9zLwwzwCC0LzfocfDOMex
 EnjZ2MIduJhbX6xkeChJYAKekKvMze2Mqej5IAM0xXdeW71Olc4uJ80XAsm9NHUDsWkq
 UsMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=bc3saWV0ftPoTYclYc6gSCVV0Zk8+YiuJV4dwGsa3jE=;
 b=DovFdUU61n/jQ0HILlYt4RRjw6CRtT3w5b5r1i0fa9Yj9trOuiHF4DGX4ZtkfcgJE3
 p8alVYket8WU1JMTx5awoKDkQcS7bpAtQU/MTc4uk4emvcWLOUF7SGbG2gT+IakKarfF
 IR2tlSybe3qI6dcxKTG9xp3EdGDKGlsjHLpWYPEZdeZYSxEzTuTBeI4obNyYXa7sQRgY
 u3tcVEjKg6zKDpCtVgSag5KPsoltSfERxuIkGB/fnqEjNKIIsQU0lTw8M9xM/KUlTPYe
 nY61WUqlvNy/f3bcal9OM3l+LAYYN9XxVmiwlqMaROLqo8z8qaW/B5GpU5z91/ixeFq+
 PWoQ==
X-Gm-Message-State: ANhLgQ2Z9IOQz+GtaEVgbXw6k+C4z5c3uxX3zU3/dBIVGoJOPr9EfZN8
 Nhdhtn7ecP21Mt/mjBF5THvrtw==
X-Google-Smtp-Source: ADFU+vtXnjjJjpnUj7DeHvJBUUUSEjMKo22l+HDvl4IXdE0sAzjTMHSYBOVzhRWu2QFvtHNFb33Pdg==
X-Received: by 2002:a1c:bcd4:: with SMTP id m203mr3291644wmf.35.1585659218050; 
 Tue, 31 Mar 2020 05:53:38 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z1sm14928185wrp.90.2020.03.31.05.53.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2020 05:53:36 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C889A1FF7E;
 Tue, 31 Mar 2020 13:53:35 +0100 (BST)
References: <20200331035456.6494-1-richard.henderson@linaro.org>
 <CAFEAcA8ZZPQpgSciPbHc+G03CwoPhfU++0=v5656nmtzjbYo2w@mail.gmail.com>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL for-5.0 00/10] tcg patch queue
In-reply-to: <CAFEAcA8ZZPQpgSciPbHc+G03CwoPhfU++0=v5656nmtzjbYo2w@mail.gmail.com>
Date: Tue, 31 Mar 2020 13:53:35 +0100
Message-ID: <87a73wfzxs.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 31 Mar 2020 at 04:54, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> My tcg patch queue, plus one mips patch on request of Aleksander.
>>
>>
>> r~
>>
>>
>> The following changes since commit 5acad5bf480321f178866dc28e38eeda5a3f1=
9bb:
>>
>>   Merge remote-tracking branch 'remotes/jnsnow/tags/ide-pull-request' in=
to staging (2020-03-28 00:27:04 +0000)
>>
>> are available in the Git repository at:
>>
>>   https://github.com/rth7680/qemu.git tags/pull-tcg-20200330
>>
>> for you to fetch changes up to b412378785c1bd95e3461c1373dd8938bc54fb4e:
>>
>>   decodetree: Use Python3 floor division operator (2020-03-30 11:44:04 -=
0700)
>>
>> ----------------------------------------------------------------
>> Improve PIE and other linkage
>> Fix for decodetree vs Python3 floor division operator
>> Fix i386 INDEX_op_dup2_vec expansion
>> Fix loongson multimedia condition instructions
>
> NB: something in your workflow is leaving the '---' and the following
> v1/v2 changes info in the commit messages in pull requests. We usually
> prefer to strip those out.

FWIW I used to have a script that reminded me if they were in and
triggered a clean-up re-base. As people on list have mentioned the
usefulness of maintaining a Message-Id I have now changed my process to
always build a PR by applying messages from the list which

  a) applies a Message-Id
  b) strips version history

The one thing I have to watch out for is if I've started applying tags
to a branch - so now I only do that once I've made the decision to
either rev a branch or create a PR.=20

>
> Applied, thanks.
>
> Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
> for any user-visible changes.
>
> -- PMM


--=20
Alex Benn=C3=A9e

