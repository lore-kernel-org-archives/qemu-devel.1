Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49483C35242
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 16:33:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1799A20709
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 16:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AJKiiBKi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1799A20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv1tj-0004ue-Mh
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 11:33:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39745)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iv1sy-0004Qf-G0
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:32:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iv1sx-00006P-AS
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:32:44 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:40747)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iv1sx-0008WS-4u
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:32:43 -0500
Received: by mail-oi1-x241.google.com with SMTP id c77so47186oib.7
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 08:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=SoXEF+e2UkJgF4ijUV/qZbQaJf+yMp6epNuUlQOSuFM=;
 b=AJKiiBKiobAo6AH6gr3b+V/WAUhstLk6mhTqMoC6WkLiQgac1eizvHnb1CD1cQfLZC
 Ix/9QQeaBUjjZnZrvJeDR3RHaP1LDAzfpJ7pnwtlmLpyp+YvYe8eCTmi/YCtFGRI4Cx4
 vKx5DIdk34SwLF8GPZ9I5fGxcjaq/TACHNnnBw6g8jP1FLG8hzYTytmnHYJGyW9RJo/Z
 YvU+170O3Nz6ZUXJJWqiC1GXBoTVPlbN9F1rcf8wUNW4DoB2nzIj7NrlVAqy6YwOBNV9
 9Iu2wb7VSSjOictckq5W2Z0JsvCfo+h/eIusALQ8JFAvOg7fKMygDuY2KOG2jS6zS5yv
 WV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=SoXEF+e2UkJgF4ijUV/qZbQaJf+yMp6epNuUlQOSuFM=;
 b=l/gju471ubtjzyNB7p5t/tswOjd9qI36k6gAmQc/VB/hZdHKdykU5c3Do7YxvLMm0i
 mnk4oRlife7wPo11Higlbq8gEatOTTtwoBciHVS4mutIcnKiZMQ+/oIWoUlvgIUyOoOC
 Yzw5gkxkHt4NRCsZ81aOYc6LjdwVL8NyyV0S9E0V8SNou4e6qRCVzmKZchl3p9+HvjKS
 pYwpUwY+Av0UUuA5HgmU5jTBTymQcV9U9ju61PvSG2g3VCb9vPBIC75iHrrbUh2kuy++
 a2XrDCsSsUTFdby23UGgOHU7ZA8SzW6/IvM5s/jPhEg9XQ7eudGaRks91pWssM8i0V9L
 6JBg==
X-Gm-Message-State: APjAAAVY30/Ok2ti7z/qx5fvRiFoJ3Z5EiuXL2MeQGlCHhtcjNa4jwQI
 QSkbmah/t7NQJoFueh7yvtnwUuYt3P0RVdpSDYP8sQ==
X-Google-Smtp-Source: APXvYqwMlXwpj5Zeg/lWge0kj5T5EoAYU+Op4pbX53+DoeBt+eBeICSH3P72njcQ/A3Jn1nNQqEP9CDLmfy7eJOjtyo=
X-Received: by 2002:aca:3d7:: with SMTP id 206mr47044oid.98.1579883562069;
 Fri, 24 Jan 2020 08:32:42 -0800 (PST)
MIME-Version: 1.0
References: <1579857411-12996-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1579857411-12996-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Jan 2020 16:32:31 +0000
Message-ID: <CAFEAcA_ex8C=S5QbABQrq8GMO=+YJdr4sAW8NRTxS3xUdE49bQ@mail.gmail.com>
Subject: Re: [PULL v2 00/59] Misc (x86 and QOM) patches for 2020-01-23
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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

On Fri, 24 Jan 2020 at 09:18, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 3e08b2b9cb64bff2b73fa9128c0e49bfcde0dd=
40:
>
>   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/edk2-next-2020=
0121' into staging (2020-01-21 15:29:25 +0000)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to b0993e347e065d2323fbb051fdd5a72c95a6e872:
>
>   tests: fix test-qga on macosx (2020-01-24 10:14:32 +0100)
>
> ----------------------------------------------------------------
> * Register qdev properties as class properties (Marc-Andr=C3=A9)
> * Cleanups (Philippe)
> * virtio-scsi fix (Pan Nengyuan)
> * Tweak Skylake-v3 model id (Kashyap)
> * x86 UCODE_REV support and nested live migration fix (myself)
> * Advisory mode for pvpanic (Zhenwei)

This appears to be hanging somewhere inside 'make check' on
the OpenBSD tests/vm build-n-test :-(  (all the other build
hosts passed tests fine.)

I haven't investigated particularly, but I tried a kill
and rerun, and it is hanging on the second run, so I guess
not an intermittent...

thanks
-- PMM

