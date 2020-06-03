Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C3AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 19:29:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4736D2067B
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 19:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B5quf2Bq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4736D2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgZ4n-00009b-JY
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 15:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgZ46-0008Bv-BW
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 15:28:42 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:36363)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgZ44-0007at-MO
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 15:28:41 -0400
Received: by mail-ej1-x641.google.com with SMTP id z5so3434522ejb.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2020 12:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yFkxj4Z1MMHcofbLREtvJ46j1yv76xg7ZRDVnHhkcs8=;
 b=B5quf2Bqjm2rZwegVxJ5JaKFgmFKcxryBDmzygndL3Sve4aFKUt6B/Eosj5+flf68c
 ZJ+80lzZ5cyVGYPbaWjRiRd3cYHGku2Q8tEQOsfMkBXkbZ5zEPBbfJsx/raTpv8ZYxwQ
 IsIv5iFRwtSQT9ZXUPaiw2vFrspb8OIxovsEkQJsEBdBIeejiWd9KPtKmbChY5UC2vNr
 GHB5cPpFCzoWEnY4Wr16UAQLsao0xYgHEY24W71K+N+Jhi4rLP2tldJ2S+nXMjgF7p6w
 NTwdZBl3O5TsQfKkSXqhGc5sCLmiI9gREpXYLZQy9awv44MdIa8eaMjHX5XdOJVLXFNA
 UvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yFkxj4Z1MMHcofbLREtvJ46j1yv76xg7ZRDVnHhkcs8=;
 b=JYCCgnBAPxq/EuCjhStDVlaHOQHCcGqxfca2BVXOVVmIIMGOlQqbJbwYLqkXP2th+t
 cYogjbTxX9lIBwndVBBrxXXtumjwR0MqxOXrii0ujv50IY8m6DRnfeU+VAYR+5zZPrhz
 qOIySTZYiUgxRIgOZul4GMQC6k07ufH2ySM+Hhanp1rBSSNqHhGJNPVkNoJpUr19Q/1m
 rkfWrL9nefcLJX2rAMEvTp/6g2Ljh7TlGNdk7cSk9yMZG6CKcCJcMbqfmEWTG9nApp66
 If0AWBiFqIkJJ8kImt24OewezlPTNB90cw387d3ojHIk5CdxeGnYYQIwsb23gWusEZtR
 b8VA==
X-Gm-Message-State: AOAM5328pY0eWud6/hansIt7sjID4hHxW0zkYF3bLz9bs0mJ81GpYWkH
 AxF9F5HK6Z48LiPQGn/840R580UlANtaYl7pKLSJVw==
X-Google-Smtp-Source: ABdhPJxQt0ien7KRflqNvmPNMYvuWsXPVMz9pHo38+6OzFWhGQRzV4ap3B9zPymBRO0brRlh95BUNKWfScty1BLThnc=
X-Received: by 2002:a17:906:7848:: with SMTP id
 p8mr823163ejm.244.1591212519067; 
 Wed, 03 Jun 2020 12:28:39 -0700 (PDT)
MIME-Version: 1.0
References: <1588208375-19556-1-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1588208375-19556-1-git-send-email-wei.w.wang@intel.com>
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 3 Jun 2020 12:28:27 -0700
Message-ID: <CAFXwXrm4R5nxk6ruTJ2kP5dUnF7Qm3TfRRiKVAUDNA1uwYf65w@mail.gmail.com>
Subject: Re: [PATCH v3] migration/xbzrle: add encoding rate
To: Wei Wang <wei.w.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kevin.tian@intel.com, Juan Quintela <quintela@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 gloryxiao@tencent.com, yi.y.sun@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 29 Apr 2020 at 18:54, Wei Wang <wei.w.wang@intel.com> wrote:
> +        if (xbzrle_counters.pages == rs->xbzrle_pages_prev) {
> +            xbzrle_counters.encoding_rate = 0;
> +        } else if (!encoded_size) {
> +            xbzrle_counters.encoding_rate = UINT64_MAX;
> +        } else {
> +            xbzrle_counters.encoding_rate = unencoded_size / encoded_size;
> +        }

With clang 10, this produces

  CC      aarch64-softmmu/migration/ram.o
/home/rth/qemu/qemu/migration/ram.c:919:45: error: implicit conversion
from 'unsigned long' to 'double' changes value from
18446744073709551615 to 18446744073709551616
[-Werror,-Wimplicit-int-float-conversion]
            xbzrle_counters.encoding_rate = UINT64_MAX;
                                          ~ ^~~~~~~~~~
/usr/include/stdint.h:130:23: note: expanded from macro 'UINT64_MAX'
# define UINT64_MAX             (__UINT64_C(18446744073709551615))
                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/usr/include/stdint.h:107:25: note: expanded from macro '__UINT64_C'
#  define __UINT64_C(c) c ## UL
                        ^~~~~~~
<scratch space>:36:1: note: expanded from here
18446744073709551615UL
^~~~~~~~~~~~~~~~~~~~~~
1 error generated.

UINT64_MAX apprears both arbitrary and wrong.

The only way I can imagine encoded_size == 0 is unencoded_size == 0,
so 0 seems like the correct answer.  Moreover, it really seems like
the first test sufficiently covers that possibility.

In addition, the only user of this value is

> +        monitor_printf(mon, "xbzrle encoding rate: %0.2f\n",
> +                       info->xbzrle_cache->encoding_rate);

which would be quite happy to print NaN even if the 0/0 computation
were to run.  Though as I say above, I don't think that's reachable.


r~

