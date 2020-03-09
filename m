Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB833C10F29
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 13:11:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E97821D56
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 13:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V7IOYdv9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E97821D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBIBX-0007El-KV
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 09:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37641)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jBI9o-0005WT-Cn
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 09:09:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jBI9n-0001VQ-2b
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 09:09:20 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:40627)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jBI9m-0001T8-T5
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 09:09:19 -0400
Received: by mail-ot1-x343.google.com with SMTP id x19so9449973otp.7
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 06:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=aEaJkjoh8PyYMze+XyHwkawwQHMhjHvwyU4PhyTkIBo=;
 b=V7IOYdv9UhamHFADAFYU8H/zdBsXWEI8VzEabcjCVIQlIg3WZFW0yiAPjj5odJQKr6
 GjiVsvDSghkN77QJYbYus05hL0ljlG/0bun1IbnAM8VtcCmAqhZzSCEUtbLfgKtrOPUa
 QCzNihIWamZvvPKBIqbxQmcy7c5eXD7k9loiRQR/NK9x9jDcr5zJoEEa9GCUbUcwziEa
 c5zBc9butPVcsodQLwJDVUmFJFDo/80e5gFI6jFhM+OTPNIcC9zklw5WS4bg5w5Elqx9
 cmVp1gCV5T/rJwmOVTXj4PrRTZF/acTJzAHCnuW15gnOzdtTjNo3Y795yNZttnS0lHrE
 KmFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=aEaJkjoh8PyYMze+XyHwkawwQHMhjHvwyU4PhyTkIBo=;
 b=Z72OyJFfImqqG3r1a2qLPy0SK332us8hmHfAkRxDyemB3/fuY5YVk1VEMP9065Jhph
 DxD+P9IQy6NAwakuTmIdIdN6l6+BF+v0XG5VEv7oZ2gKNNEv2X3z7/4QNsZdfabPN6ms
 4DBowkCtYf4zxM9u9560RPrAhsOCbPC8KPlX6vPTnsb0blql/k8ljQnOu6GQ5k8veYlH
 P4QXFcgfdOHAnLUe6W5JUoIO63bh72uQq4kbeqSQDbLI60SWlfNcoO4Mxujx2/nNei+d
 ID7QfBewnqT5Vk+/Ko5I+070yhugTWQjOUIFb5Mecs79sk6PNPz03nQTdBS3EgE/n1XA
 xJdg==
X-Gm-Message-State: ANhLgQ0HvfJVK5EWiAm3S6jtApaVm2sfAdDE4tEMi8JkB+t2gx4JE/m3
 fKxzJWws2KRar+d3BlSfyHR/Xwv92HQUgzTiohTX2w==
X-Google-Smtp-Source: ADFU+vstbi/ClbrLkvAtqB+s+lQ/CHWEj+JTGfxgsaK+SOpeAK5YhxCWwpZJuVgpb9dAY5OWovrTn9LF+j+JkjTGIt4=
X-Received: by 2002:a9d:6c05:: with SMTP id f5mr2093354otq.232.1583759357831; 
 Mon, 09 Mar 2020 06:09:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200309121103.20234-1-philmd@redhat.com>
 <20200309121103.20234-2-philmd@redhat.com>
In-Reply-To: <20200309121103.20234-2-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Mar 2020 13:09:06 +0000
Message-ID: <CAFEAcA_OHcfsYueYRpXjihgwEDericqkzGqB1EBqaSULAC1YDw@mail.gmail.com>
Subject: Re: [PATCH 1/2] cpu: Do not reset a vCPU before it is created
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Michael Walle <michael@walle.cc>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 9 Mar 2020 at 12:11, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> cpu_reset() might modify architecture-specific fields allocated
> by qemu_init_vcpu(). To avoid bugs similar to the one fixed in
> commit 00d0f7cb66 when introducing new architectures, move the
> cpu_reset() calls after qemu_init_vcpu().
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Why do we need to call cpu_reset() from realize anyway?
Generally for devices this is incorrect as they should be
being reset by some other mechanism.

Obviously actually determining that dropping the cpu_reset()
call is safe would require some tedious auditing.

If we do do a cpu_reset() in realize, should it be after
the call to the parent realize function ?

thanks
-- PMM

