Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C97C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 18:21:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCF9A2222A
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 18:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c0qyb28C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCF9A2222A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRfxx-0008WI-KU
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 14:21:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRfwQ-00084y-5T
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 14:19:30 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:45829)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRfwO-0006oT-7Q
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 14:19:29 -0400
Received: by mail-ej1-x641.google.com with SMTP id dt13so20152116ejb.12
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2020 11:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=U8afVzLe2PGpoHIk80te0tvm8+J+uAeMy3EH0wjpfiU=;
 b=c0qyb28CSNJumfFq0UldrR2UYfHH1LKRdCllg+r+OY0e5UqotTXcWCUbXt/aKD34H1
 QoLjFKdBZm0FN1WUmegc4POlFPFxPQa5aAd9C18OL9fHHhZniBS9B61TkRE//1R3OYMu
 UzjIACxCE33oskzeMaxh3yXiSKUFdZS6tunxJUpaC4NDwMzsHGVirVgHw8qWVyU9yyOg
 dfstOm36/vL6yKlUGWhpxKQfw7nTt4MzxSvlqLlTUtq5aTegsE4YZAg0gsUTq+ei5Bcm
 lSTULRIOI3UDSRrL1E1QY/4AdSe/D95H6++WiPi6uP083XxGMUwT/AXKa+O3wyvdUArM
 16xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=U8afVzLe2PGpoHIk80te0tvm8+J+uAeMy3EH0wjpfiU=;
 b=TV5NrF8Hpd84G+rhnY/8ziE5V15cpnXzT2zNNl2+6HXXypMDNmii5wCsBGZGlNnRtD
 SKV5/PLJDlL64cQb8EBibwjpHUY3thWVxme6Dj2xocvpbD6Y4dC6neWnRE0QlYa2M4kF
 nqgpduhOnEqPEQOHXeQtw2oldqa6FlthW39lYjWHGubKRjeKrZLawvhSJYJm1bn5gzBn
 G9ZYsmiElR2RYqLBKXLks+f0jZYilW8pQlzzFwSfELuld92avMZlZJNP6KPl/Qgg6WYf
 9rkV7XpIFQOng+6Qvwxzy25GSevs7s0ElQ1CswhAC0TqCmWK1RcaQCKMiFa2D0Vn6S0K
 jhpA==
X-Gm-Message-State: AOAM530RTe0KNnZuGAmBm23EQjp5hv2TZ7fF7vfcDVRpXOgCtnagpk9L
 0uZbkMymHRKYZfQFQIAPxWfpmgpV0T2uwoMDhurZTw==
X-Google-Smtp-Source: ABdhPJw8bj7PqBBx7UqoXyJnRpa3gRFwgnfoC4S09bZug/98CvhlQCHRfTwM6iXgTjuJZkzx6BJyL6MJudDVi2TR9ng=
X-Received: by 2002:a17:906:7254:: with SMTP id
 n20mr23506543ejk.382.1602440366397; 
 Sun, 11 Oct 2020 11:19:26 -0700 (PDT)
MIME-Version: 1.0
References: <1602413863-19513-1-git-send-email-yubihong@huawei.com>
 <1602413863-19513-3-git-send-email-yubihong@huawei.com>
In-Reply-To: <1602413863-19513-3-git-send-email-yubihong@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 11 Oct 2020 19:19:15 +0100
Message-ID: <CAFEAcA_VGzPsteNKjYkm7PGUn5As5Z+XWLMZq60ph055LqqfrA@mail.gmail.com>
Subject: Re: [PATCH v1 2/8] migration: Don't use '#' flag of printf format
To: Bihong Yu <yubihong@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x641.google.com
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
Cc: alex.chen@huawei.com, Juan Quintela <quintela@redhat.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, zhengchuan@huawei.com,
 wanghao232@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 11 Oct 2020 at 14:52, Bihong Yu <yubihong@huawei.com> wrote:
> @@ -998,7 +998,7 @@ static int block_load(QEMUFile *f, void *opaque, int version_id)
>                     (addr == 100) ? '\n' : '\r');
>              fflush(stdout);
>          } else if (!(flags & BLK_MIG_FLAG_EOS)) {
> -            fprintf(stderr, "Unknown block migration flags: %#x\n", flags);
> +            fprintf(stderr, "Unknown block migration flags: %0x\n", flags);

This doesn't look right. "%#x" will print a number in hex with a leading '0x'.
To get the same effect without using "#" you need "0x%x" (that is,
the format string provides the 0x characters literally).
What you've written is '%0x", which is a format string where the '0' is
a request to print with zero padding (which is ignored since there's no
field width given), so the result is the same as if you'd just said '%x',
and there is no '0x' in the output.

$ cat /tmp/zz9.c
#include <stdio.h>
int main(void) {
  printf("%#x\n", 42);
  printf("%0x\n", 42);
  printf("0x%x\n", 42);
  return 0;
}
$ gcc -g -Wall -o /tmp/zz9 /tmp/zz9.c
$ /tmp/zz9
0x2a
2a
0x2a

>          default:
> -            error_report("Unknown combination of migration flags: %#x"
> +            error_report("Unknown combination of migration flags: %0x"
>                           " (postcopy mode)", flags);
>              ret = -EINVAL;
>              break;
> @@ -3576,7 +3576,7 @@ static int ram_load_precopy(QEMUFile *f)
>              if (flags & RAM_SAVE_FLAG_HOOK) {
>                  ram_control_load_hook(f, RAM_CONTROL_HOOK, NULL);
>              } else {
> -                error_report("Unknown combination of migration flags: %#x",
> +                error_report("Unknown combination of migration flags: %0x",
>                               flags);
>                  ret = -EINVAL;
>              }

These two similarly should be "0x%x".

thanks
-- PMM

