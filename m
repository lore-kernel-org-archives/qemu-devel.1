Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7225C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 13:40:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB52B2076E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 13:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lr9HHJ6/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB52B2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYUe3-0004XE-NL
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 09:40:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYUcI-0003bK-Fp
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 09:38:54 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630]:39319)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYUcG-0002LN-K3
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 09:38:54 -0400
Received: by mail-ej1-x630.google.com with SMTP id bn26so8673698ejb.6
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 06:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tLgimgS94VotXE8VnhIMiE+D+3vRhYWowm+oEHPgvRw=;
 b=lr9HHJ6/1n2EvR4KhPV7M/puhjoMpNeaBaQicTo/lODCo4oApY75OxQ0zj8W/fhQ+Y
 EPDbHwkl/fxfiqHdpWTgVQ6m4yGCnaJ3pa8wKju4V7clWDi3tKGWeRbrW9AULx++YdD3
 97or22qfPQJHIKEZVmIrbkBh1FyYag0b6IZVCCBeCg2zPZ7noZpImR6R63Nd0FifVJWS
 uHE7/knLuGaetZ8LFaHL8yha651qEK9RSQAVlu7OnJx1bcQWdIIVcYb7F7SwAYjhoggD
 Hy4v/uK57b4t7psGYiiMtjCyBRqiB120FT008a7S0RaTh+IK+VEPzAAcZW1oXFCXJ+bO
 P2LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tLgimgS94VotXE8VnhIMiE+D+3vRhYWowm+oEHPgvRw=;
 b=BWnuQTPmknypZNYK5x1OqChu1YBhkd7S0DH37ftjTCWw9Uno5wncnBhJ6PXRUsK20r
 gTLej4ZBETvc3gnZ02ApEedM6ICX6QPdkYFcioQ62A+FsB6I+3U17wcXKWz67J4+UljS
 yu/XoH+F3UoH/PiBRjY5KLqDmO/Xu7ttaE6Squbcf7L2+WSa8zSILnGHCvOSJwyXlsU7
 sXZvjp8wjYLYAgxAgesrUC/oV1xxm4TZ1mX3QxK4gNgzmXtE46P84u8/t3zgQPYQzdbp
 3gpB6qwHn+6dFdqmrAzmTNkbb7pr4T6r74j64ybK2G8MC88ULhC1KFKXjweZCycba/vs
 QYjA==
X-Gm-Message-State: AOAM530sZGMlP49E3WrPakmv/suIRgxP57Wm6tPPOslYcfGP11ZiOPSC
 0EgI4b3DwYDr3LvCAueQcYKWVEs1ywp7nF3s9UlHmw==
X-Google-Smtp-Source: ABdhPJzSKdGTZm7gWniXe72BFnjb5+w4WpezTLKx5o4lOXdJ0G/M6TBf/ibLj+ovurev8BQUTcO0/oZ85qBzTxNCRok=
X-Received: by 2002:a17:907:9e3:: with SMTP id ce3mr2578598ejc.4.1604065126796; 
 Fri, 30 Oct 2020 06:38:46 -0700 (PDT)
MIME-Version: 1.0
References: <e8b378a2-144c-e915-3e5e-c84c9e9a17b5@redhat.com>
In-Reply-To: <e8b378a2-144c-e915-3e5e-c84c9e9a17b5@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Oct 2020 13:38:32 +0000
Message-ID: <CAFEAcA8cc_C6aKkO0n=Z_b3ais6AE0VSvZD1TZweAzhocm6aTg@mail.gmail.com>
Subject: Re: QEMU release tagging script?
To: John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 30 Oct 2020 at 13:32, John Snow <jsnow@redhat.com> wrote:
> Is there a script that's public that you use for tagging the QEMU
> release? I see make-release in scripts/, but that's for creating the
> tarballs after the tagging has been done.

I use this script:
https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/qemu-tag-release

> I am looking into being able to cut releases for our Python QMP library,
> but due to constraints in the Python packaging ecosystem I have not yet
> been able to solve, it requires its own VERSION file.
>
> It would be nice if when 5.2.0 is tagged that "0.5.2.0" could be written
> into ./python/VERSION as well.

I'm pretty strongly against having the version hardcoded
anywhere except the top level VERSION file. Everything else
should read the information from there.

thanks
-- PMM

