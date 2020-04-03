Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58255C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 16:58:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1948F206F6
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 16:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AceMutnm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1948F206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKPdq-00069T-4d
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 12:58:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41874)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jKPdB-0005iO-T0
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 12:57:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jKPdA-0007hi-HM
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 12:57:21 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:45359)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jKPdA-0007h8-5H
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 12:57:20 -0400
Received: by mail-ot1-x32c.google.com with SMTP id c9so7910728otl.12
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 09:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=sqgcOWtHVLHeHx21G69dFpZ3GgFRWH0IBxCoTEKcH/A=;
 b=AceMutnm2ww8Aq8k5xJl9L97UZNvM41jleuGHPbIigzCUNhMOecnIWMCf049Ru3inh
 0SqatZEB2Od1AQ+Iua0oXmv7TBfBVNfWIMnoxSoLbxYBVUjsntFlPfJM8EqqvRYDIl+U
 BkBwwt2QSsUccKXMzgl18M7Jo1IrYCvpj3Z1DQiscRRwht0zTURdQE98+3wi1UfzEKON
 ndg4FOxWiMpP/jdi8qDPycUt6x5kHEnrspACwBQhw4QzvziK5Tlz57YCLOW+o77Fjqfu
 GIaHx7CnZAnz90AeWvD3NsP7C4SlC9TxuyLcdTTUTY6MuRn0LZFYpBJCQzgd238W74nf
 igPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=sqgcOWtHVLHeHx21G69dFpZ3GgFRWH0IBxCoTEKcH/A=;
 b=YI+fe+FJ10LjNB+OWM+MEgKk0cbcWeOCGpGr1MJm7mdoqWRxcrxk4fyAL1d8SNe/qC
 rz3QYS3SPMoPU0f8MzCvvXhyaaTVarwClekvNujgCi50dVyrn2t8HjFUjaqS0lIT9cWj
 YPMptroEse6dVbaCQdbUWH3SzRlnaHtm1wO8dctfNTT+AAcFY56aOyQTMy3szEXmarsu
 FvoEFerGOaWbdtd4TSraX8IGxm1oW9T2+32p96KlKzgaUmHoJMYEztymNHJMDCULN4bb
 /1I0Zt9sjtqcadqBSoEYkTYfZAfLBRWZjOWxMgFJ2mxaV2Rr0TWOMPHh/c+JSaP+oYmD
 WnGw==
X-Gm-Message-State: AGi0PuY9O0qIRD20sQS2ZErPawZJtHLS4ZVptJxvbFIa4dMHOOx6Uo5k
 FpPA0lNpbToseOVXRaTQ/BylZ/5NgU0Lj3hgUptqCg==
X-Google-Smtp-Source: APiQypK+qC70BSqr0o8eh4hq49MtE1INYFZ8cQ/PnHiO3mz20WNcICnue/TUQoHs2GImwfFbM+A6t7UtlXAe5kWZScQ=
X-Received: by 2002:a05:6830:11d5:: with SMTP id
 v21mr7295685otq.91.1585933039060; 
 Fri, 03 Apr 2020 09:57:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200403165422.21714-1-philmd@redhat.com>
In-Reply-To: <20200403165422.21714-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Apr 2020 17:57:07 +0100
Message-ID: <CAFEAcA-BAvi3HEuvpMyyir9CqAbkg3nF3920zBVF-sPyFz++Rg@mail.gmail.com>
Subject: Re: [PATCH-for-5.0?] configure: Do not leave sphinx in-tree artifacts
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32c
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
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 3 Apr 2020 at 17:54, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> When ./configure checks the sphinx version is new enough, it leaves
> the docs/sphinx/__pycache__/ directory. Avoid this by using the '-B'
> option (don't write .py[co] files on import) via the
> PYTHONDONTWRITEBYTECODE environment variable.
>
> Reported-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

This only happens for an in-tree build, right? I think in
that case you're kind of OK with having random stuff
left in the source tree... It seems easy enough to suppress
them though, so I guess we might as well.

thanks
-- PMM

