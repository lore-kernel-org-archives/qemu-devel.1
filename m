Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC58C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 17:37:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29FB7206F0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 17:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CEIyvjN+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29FB7206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixaEY-0007X9-At
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 12:37:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37886)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ixaDx-0006wU-3X
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:36:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ixaDw-00007l-21
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:36:56 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:35536)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ixaDv-000071-SD
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:36:55 -0500
Received: by mail-ot1-x343.google.com with SMTP id r16so7358019otd.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 09:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=MwQf5wKkqC3KOw72XmYMlxq7E2cPK4kiOzIVY+cdHzw=;
 b=CEIyvjN+UEAPsXxwBS3yFt/laAeUK4sbYeeUvDFmSgLExP4Lmr1tA4o48bEZ5QriWZ
 Ni5CsntzAMvOJmptTeQ0761PFw+407EGaoeiFsrsIBgBxt50Fuxljb0RMrIPSwD0foE+
 qXOIpY7lbtwu2jT8SYndsVmsu2zkbY0rNwThYQBZFSZvoH/LQyLGQPZLkZccgcNXbqvm
 95PPLo+Mo7qs8ckj8Rx5369G+4JIm8Q1bvG5fw4EYFdoXeFk+sYXMr7OjkPO69tmpniv
 oKVe4nYbnPRhbOr7tjyuePZjvkLQlHL7dQkojszXXdw3/K7cGJXGeZ2EAphynCSMRn1p
 fKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=MwQf5wKkqC3KOw72XmYMlxq7E2cPK4kiOzIVY+cdHzw=;
 b=DQ+IIWrcf2d3bkBtg3unEa1SqJqR1FibepW5PzFtFjxQhp5bAra3Rf1dagJRF9R0Qx
 P3dNQO6mu23pYhX7yzCC6104zurab1rKkWiaOIpIh1vokHtC6yrFM2RTCk529KQh5gec
 E2p2cQRSbz8MADbxCjn515FeTrL0OpIYVOnDYEIVtfewOqpQLXkf0dUd8T58e01WFQUK
 PRM2UhVVtY4ai/4k1DNpB9UDhsfYLLkTVnSwYtgc6xJLAckQgOQIZTBeT/AIx9TJAKYQ
 FmZZPFEUuS7+0VRCN5VKP73MHELHNky0MmldsdIp5lJ6BnhfQeK8J3tSc9s7R7j6JBz9
 7dNg==
X-Gm-Message-State: APjAAAV/1yqdSavmrP7XYrSMCzWk+CIk++I1oS+AWvDxCksdLeaIsvhX
 fsLnIWqIQCZpO6TB7Dp9jVWUTHWw5Gie/KIIFmUCAA==
X-Google-Smtp-Source: APXvYqzH8zJ5o4thc7JBUmbJZcxzhmAT5AWeP4jPytYUoqO1FmoQvkhMSRfFzFvpk2/wDnaU/akRvoSoh4bt/0ad79M=
X-Received: by 2002:a05:6830:4a4:: with SMTP id
 l4mr8446213otd.91.1580492215139; 
 Fri, 31 Jan 2020 09:36:55 -0800 (PST)
MIME-Version: 1.0
References: <20200131153439.26027-1-alex.bennee@linaro.org>
 <86de4318-8937-c228-973e-f88b41248d03@redhat.com>
In-Reply-To: <86de4318-8937-c228-973e-f88b41248d03@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 Jan 2020 17:36:44 +0000
Message-ID: <CAFEAcA8KAuKfb07xf=zs6bY-T2zQzRbifW5wdg1kEcBb+zPGGw@mail.gmail.com>
Subject: Re: [PATCH] target/arm: fix TCG leak for fcvt half->double
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 31 Jan 2020 at 16:50, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> On 1/31/20 4:34 PM, Alex Benn=C3=A9e wrote:
> > When support for the AHP flag was added we inexplicably only freed the
> > new temps in one of the two legs. Move those tcg_temp_free to the same
> > level as the allocation to fix that leak.
>
> Probably too much code refactoring :/
>
> >
> > Fixes: 486624fcd3eac
>
> Maybe:
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
>
> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thanks; applied to master as that will let me apply the
tracing pullreq without having to suppress or ignore the
warning.

-- PMM

