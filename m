Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC0EC4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 09:32:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5930720645
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 09:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7xlBU23"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5930720645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54060 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1had8v-0005jr-Iw
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 05:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41900)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1had7e-0005Cw-UT
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 05:31:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1had7d-0005qW-2V
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 05:31:18 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:42401)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1had7b-0005ZL-1o
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 05:31:16 -0400
Received: by mail-ot1-x344.google.com with SMTP id l15so11177028otn.9
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 02:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=MvyFO0Hra2BD7ZhaHaIIN2/NEA58KsKEEN7GzEaSuBA=;
 b=m7xlBU23g3pkRADGahVmGczp/RdgzRScEAkXF7j+uWg4KeeyiRhTVRRYYHvtLwLNub
 Fx4a5TdtPUE1IfpWmzi2mCVbMPn3tMCLIrzlzihUbrRR9L2NWfGSzZcK+Lv/v5YSygaf
 fZdfnuc22ekriqgAuVZyVLfkPboJIaHUFywICDlIStYS/d0d0+74+IxgNiUoR9Q0j6+L
 W3FU7FiRPZHG1RNTB+1BzgKTB/+6fUNvBhqAlCAbtKGwaxDGroyUkzzySgLL94VX4fdy
 rjzqyiWwdqDvV9akT6UPf3DWnQ3kZwUBir5G8+DxvRABlsi5+RjHRIqD7KZRQJbaX7y7
 UGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=MvyFO0Hra2BD7ZhaHaIIN2/NEA58KsKEEN7GzEaSuBA=;
 b=cMLgyfL73ZJXsLL09XFqQvetPX9Zr9PUefwrq9ITsv2pDSmnuo/G2jQH20Y9daEpAu
 iu9sOZp8NxCmJ2aiA9kZanA+hDcW2XoBmMZF3R7aQM/aciZBJMTIsvwcs8vDN1ky5Jb2
 A/9Mf6V69wM3YZ05tgHJ6ctpJZuy+gogoBD8fPTAgcScjZlD8odZ6cK7LuFHYSNUsmn0
 8Yw4HDNi1VwA//R0i3xRBjezIZ3NN0bfGadgo7muGvdzmLH9JS6oj3/yq0Fi6DtT0MGK
 Dey5Nq1flXw0bHRct9l3H9sXq7k11X+rotjbITAg8QHBmE6CJE5gMU3b4eyLMX6Y3/24
 cZRA==
X-Gm-Message-State: APjAAAWcpdHNIHiAowyVKB9SBI5kAT9onniMNAWg5Cn1p5rZmGVFMXOI
 RsE3C1l3vqDI2Cu3WhGcHgJYFLWfqCEt/Ka4pO0=
X-Google-Smtp-Source: APXvYqzmE/wcUjxqjg0My7DJnFOYtoIvdZM9qKXNUbp04iRrheryn6x60ODGZizRJLZLzfvunOJ8MB9Gq5dE+ITPUcA=
X-Received: by 2002:a9d:6ad7:: with SMTP id m23mr27192983otq.306.1560245458668; 
 Tue, 11 Jun 2019 02:30:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:20e4:0:0:0:0:0 with HTTP; Tue, 11 Jun 2019 02:30:58
 -0700 (PDT)
Received: by 2002:a9d:20e4:0:0:0:0:0 with HTTP; Tue, 11 Jun 2019 02:30:58
 -0700 (PDT)
In-Reply-To: <1559903719-7162-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1559903719-7162-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 11 Jun 2019 11:30:58 +0200
Message-ID: <CAL1e-=iabf+R_UZy4BrZG1xGau53MhjKmEHW5Vo=Z0a4cfOYHg@mail.gmail.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v10 0/3] linux-user: A set of miscellaneous
 patches
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping
On Jun 7, 2019 2:21 PM, "Aleksandar Markovic" <aleksandar.markovic@rt-rk.com>
wrote:

> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> This is a collection of misc patches for Linux user that I recently
> accumulated from variuous sources. All of them originate from problems
> observed on mips target. However, these changes actually affect and fix
> problems on multiple targets.
>
> v9->v10:
>
>   - improved commit messages for patches 2 and 3
>
> v8->v9:
>
>   - fixed build error on some systems related to SOL_ALG
>
> v7->v8:
>
>   - added a patch on setsockopt() option SOL_ALG
>
> v6->v7:
>
>   - fixed a build error for older kernels related to the patch on
>     setsockopt() options
>   - removed four patches that on the meantime got accepted into the
>     main source tree
>
> v5->v6:
>
>   - fixed a mistake in patch #4
>   - improved commit messages in patches #4 and #6
>
> v4->v5:
>
>   - added the patch on statx() support
>   - improved the patch on IPV6_<ADD|DROP>_MEMBERSHIP to take into
>     account the possibility of different names for a field
>   - minor corrections in commit messages
>
> v3->v4:
>
>   - improved commit messages (fixed some typos, improved relevance)
>
> v2->v3:
>
>   - updated and improved commit messages
>   - added IPV6_DROP_MEMBERSHIP support to the patch on setsockopt()'s
>     option
>
> v1->v2:
>
>   - added the patch on setsockopt()'s option IPV6_ADD_MEMBERSHIP
>   - improved the commit me
>
> Aleksandar Rikalo (1):
>   linux-user: Add support for statx() syscall
>
> Neng Chen (1):
>   linux-user: Add support for setsockopt() options
>     IPV6_<ADD|DROP>_MEMBERSHIP
>
> Yunqiang Su (1):
>   linux-user: Add support for setsockopt() option SOL_ALG
>
>  linux-user/syscall.c      | 193 ++++++++++++++++++++++++++++++
> +++++++++++++++-
>  linux-user/syscall_defs.h |  37 +++++++++
>  2 files changed, 229 insertions(+), 1 deletion(-)
>
> --
> 2.7.4
>
>
>
