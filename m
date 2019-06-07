Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA8EC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 16:15:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCC032089E
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 16:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W1n1AOD8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCC032089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49276 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZHWd-0006FR-25
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 12:15:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46564)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hZGZv-0007Uu-Fp
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:14:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hZGZt-0001yt-Bg
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:14:51 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:37347)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hZGZt-0001vK-6E
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:14:49 -0400
Received: by mail-oi1-x22e.google.com with SMTP id t76so1689301oih.4
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 08:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=E/iJnswotAOpzBU/exKhk4uR4Trfovk/BhsvzXy0/ps=;
 b=W1n1AOD8thU3RYwk9Psd4x/srZrt6mVf5kvWb7Taehs+e5YHWTVlsA+1jW835ukDTZ
 Q75TAz/+b4++eZJgfDtwWNBUQAUeRXGqPA271LbTziP6eBnvU3ZbpZzLA0blgUvAzYY/
 esniB+aJpdV89GNolsu+9s7Lf23T693tDU/abxeXj+PSl6nneG1xAwqo3HDmX7M3ShnO
 ChmFLQ46ZoalEnQ81C326ZDFi0hMTEdRdanHPuUgoKpD45phmhIrIfvVpNTPzRCs7IoI
 6UXafygCrPWwpAGIDp6AQ5UFWKY65BSL+TI3ki2tC1fYKMHL9SIMJ1u2KbsJx5RYZ6m+
 7YIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=E/iJnswotAOpzBU/exKhk4uR4Trfovk/BhsvzXy0/ps=;
 b=IyfcE3PA20lcgALQJZf7Tg8T7Ok/yCvHlLvvuL5XByiAYLhMHj9zycbfplrgA9yQ6H
 Qf6f/VsoBlsXMbSNnto9Gw2LgVWFhxwqWKUaqXUfqB5/o5EYVehJZja9JHIRusTy0vMR
 MI/kB9D/zHODNNgt3exqDpiyAcZfyGoXtGtnI17/NhJxXG/Pz6FaxewfsCLiB0jC0gAq
 RFs6FHQTxKvq4WuuPOsnGnDinRVK1SudO1osfttdFF6FAzC7ULsnWz2hgfppmAibM/wy
 ggQNghFj4r+fox3NlYJOJVjwOWV+x7Ktjp1Mj0sawaqOBN24ByHDheezmLW79hfTKs+l
 e0zg==
X-Gm-Message-State: APjAAAVXNkU/79W4Byuk+pZAVEiVQI+apQ0p77YwmhHlZACQrr76NRGa
 iSo7tOVQlb2Swn9RuSj7b1glNGtF8u9URx5hS0wApQ==
X-Google-Smtp-Source: APXvYqzWXSVYhuskUvB1LN0dCqYR+p1x8Nc3BA24jvw2rSJ86RUqj7PZEZUrcfWhCY8UUcvw1hi8KpCYpFh80BUjISU=
X-Received: by 2002:aca:845:: with SMTP id 66mr2037075oii.163.1559920487698;
 Fri, 07 Jun 2019 08:14:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190607141727.29018-1-cohuck@redhat.com>
In-Reply-To: <20190607141727.29018-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Jun 2019 16:14:36 +0100
Message-ID: <CAFEAcA_-uS4MHCUp-X494dvMb=KsfoBZUYL5LHP-bXwm1do5cQ@mail.gmail.com>
To: Cornelia Huck <cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22e
Subject: Re: [Qemu-devel] [PULL v2 00/34] s390x updates
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
Cc: qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 7 Jun 2019 at 15:17, Cornelia Huck <cohuck@redhat.com> wrote:
>
> The following changes since commit 33556237f652d8a712d0b6d29ecb442e6b65fe42:
>
>   Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-jun-7-2019' into staging (2019-06-07 11:17:28 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/cohuck/qemu tags/s390x-20190607-2
>
> for you to fetch changes up to c984c4e8e31e57c44b3674d9dd8ed6aa5e68306e:
>
>   Merge tag 's390x-tcg-2019-06-07' into s390-next-staging (2019-06-07 16:06:27 +0200)
>
> ----------------------------------------------------------------
> s390x updates:
> - tcg: finalize implementation for the vector facility and
>   add it to the 'qemu' cpu model
> - linux-user: properly generate ELF_HWCAP
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

