Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B93C04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 16:05:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B792B2084E
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 16:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EmUUimGh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B792B2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59670 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQDRy-0002VA-0E
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 12:05:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hQDKR-0005Tz-Pk
	for qemu-devel@nongnu.org; Mon, 13 May 2019 11:57:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hQD5E-0004yC-AF
	for qemu-devel@nongnu.org; Mon, 13 May 2019 11:41:46 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:46621)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hQD5C-0004wW-Mp
	for qemu-devel@nongnu.org; Mon, 13 May 2019 11:41:43 -0400
Received: by mail-ot1-x341.google.com with SMTP id j49so4517370otc.13
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 08:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=RIQG0vK4M+MGByMGZLuI5pY/Ty564v3mPFm2c9YTl98=;
	b=EmUUimGhqnIUtoVdKOQoMowUqRx3gD6H+oOMB3ea4/3sHboAoRwbatrxaNV0D+o3uN
	ku1JkJ6pLmd24hbv6NFaDNsDdpEkqDjC/TzayKN/SwSzAjbRkEcQqEykj1njZU/VwjNB
	CSb1cbfumrCFjFoKoRilH2q/fqpcRNfHSO3XwNHSrTE7Y8LJ3Fn1clL9HFqyngQujVba
	pKEUmD7uKMwjZ4F9Tlno8us1sLt70vfFvQLfDE7bPJmeFhbb0zkFwUAXTa4GQfTzV4lO
	I830MbjRstUCoZSU8KK0mE8szqalcyKvsml21r8OnhI+kJUJywxeNyvMxHTP/MVLEX/h
	cYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=RIQG0vK4M+MGByMGZLuI5pY/Ty564v3mPFm2c9YTl98=;
	b=VH4hxF4w2Id2jJ7L/MKfPXwjFKeg5udaVxUXgTrfz9znCFvVLbnXZXZwhBAUs5VfOX
	GrviztzlPPwDdMzKSeNJNVDZo8lWHJhZimPiI8skCyCNWMYf4osa6S29Yk97kIOlleWg
	jaAGMTvAGq02oL1qBMaiKp33Q4J9JRSEAe+/P//u4V+kCflAdlOm68HCkEdYKZLJeE2r
	tuLgn9ipC7N4fZETOU5x1I63alBp08TnxJIyzuAORbHv1jrmxICQS7FGFi9vwMYJvNMm
	X6PpkfO6N0MfxjFflIZQvqNpJornResOloq45VKPUcePBBAA8dLMFRhIY5r5Eo4V/kdx
	8uYQ==
X-Gm-Message-State: APjAAAV80HDJjLlmDKaPbxeusUMvBqfbxltssKBWVnSyBeJDLAHgXFEO
	03cf4sUkggClx0MpfraIUZVfFa6kQtKqlVp+SxlFkY3jAk0=
X-Google-Smtp-Source: APXvYqy4WUjMjTZ2AWBakDE1r+rIbDfVlfe2JxvsKg3WIOj518dmVXBEpSJTlvmT/vW6TfqURaDJDgyVM39Vr1A8tR0=
X-Received: by 2002:a9d:6855:: with SMTP id c21mr15646262oto.151.1557762100663;
	Mon, 13 May 2019 08:41:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190513081844.26699-1-armbru@redhat.com>
In-Reply-To: <20190513081844.26699-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 May 2019 16:41:29 +0100
Message-ID: <CAFEAcA9jjVDKsmnmoZ_qye+zbnN8hq9qudV0A+gJ_g1aHEKGQQ@mail.gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PULL 0/9] Miscellaneous patches for 2019-05-13
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 13 May 2019 at 09:24, Markus Armbruster <armbru@redhat.com> wrote:
>
> This is actually a fixed rebase of "[PULL for-4.1 0/9] Miscellaneous
> patches for 2019-04-18", but that subject has since become misleading,
> so I changed it.
>
> v2:
> * Back out the change to tests/fp/platform.h that breaks big endian
> * Rebase
>
> The following changes since commit efb4f3b62c69383a7308d7b739a3193e7c0ccae8:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2019-05-10 14:49:36 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-misc-2019-05-13
>
> for you to fetch changes up to 6834c3f410f6ce77dd9cad78f3a9a864e7fc8ec5:
>
>   Clean up decorations and whitespace around header guards (2019-05-13 08:58:55 +0200)
>
> ----------------------------------------------------------------
> Miscellaneous patches for 2019-05-13
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

