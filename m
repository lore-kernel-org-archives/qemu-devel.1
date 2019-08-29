Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F41C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 17:55:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 975A12189D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 17:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J93/47+V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 975A12189D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3Oe8-0004w8-Ih
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 13:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38350)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vandersonmr2@gmail.com>) id 1i3OdG-0004JN-86
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 13:54:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vandersonmr2@gmail.com>) id 1i3OdF-0007V0-0j
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 13:54:50 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:42871)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <vandersonmr2@gmail.com>)
 id 1i3OdE-0007U9-GU
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 13:54:48 -0400
Received: by mail-qt1-x844.google.com with SMTP id t12so4638125qtp.9
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 10:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DqzQGmzCpgwpDk05T5GyGmVoLSN0BcVik8Ui2PAaj64=;
 b=J93/47+VV0YhlHsi9dA080jNVL7ndHYrw7h+A/d7WbWQ+uB7uCkxW3qKOSrAUzfG8O
 erzYyJc6+uyCoI3ih5+GG1NCdhUVKFz087qhr3w/BiZnFPHcjN/ESwlPwRc2Z063G9Oz
 9ERLP8b5AeqHCQRfXXtGZTvZWumPQ9+gOB2tkJUp+jTPPr/dgf96KUfKC7YRxJwhXUwY
 XrUObOHei4cm0pllUfZN56KNvU0NAZbMLoLfnmFpCTWtim/c1ncVKCJfnA3uQPtYx+vC
 UetCPsJhoPsTLIvAyjrPt4n9AU/Lt1pegELrg9PlwU9RrepJazSriYHIZqzp5LkMdvRl
 di/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DqzQGmzCpgwpDk05T5GyGmVoLSN0BcVik8Ui2PAaj64=;
 b=tOrdZhWcWm3gdxdiFJNTtsjiGbRpn9kbi0465lxf+2So56tMbKGbsa5MECC8+LOBy8
 wGaJXvtQ5KXXvJvS5XBuFNfZAQg1+1591DvPIKGwETcNOlqRSqf9FIDjOK6fXEipC6j0
 ByWFbszzBDW9yMgfWNV01EaxCrY3KrCSuyzScpUUD8rhzjUuHY/O2sMORsyuWo8tY7dV
 vIdJT1cnwGv9Lx88nfJDHjB4GvhN27ahQymPFXUu9YIIgzlFvxN5dV76sLractdFFpGh
 0OrAjks/hpx5Pch4YGsNYKQ3WaMbyf0GmkKXajMk2EmkYUkaSg4hSH3VoxOAKBSW1iqB
 YogQ==
X-Gm-Message-State: APjAAAVzhipKxwv1XeQ/aVSKtv4DXVDypaYWS4/y8ZUkxdNCGvMI3apP
 EtvQrJ37Kwf2S8urjzzy8CcFFfgURgtedAJegyAul7hEM30=
X-Google-Smtp-Source: APXvYqyIL/GjDQOTSYFajDlUBh3u1ODNHKW6J02Dc+bt4MD6TG8QtCKZM1rd+s+HPCZRquOcSCFJ5b3cI3t27vI/+lw=
X-Received: by 2002:ac8:7046:: with SMTP id y6mr11322960qtm.131.1567101287376; 
 Thu, 29 Aug 2019 10:54:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190829173437.5926-1-vandersonmr2@gmail.com>
 <20190829173437.5926-9-vandersonmr2@gmail.com>
In-Reply-To: <20190829173437.5926-9-vandersonmr2@gmail.com>
From: Vanderson Martins do Rosario <vandersonmr2@gmail.com>
Date: Thu, 29 Aug 2019 14:54:35 -0300
Message-ID: <CAMzYVD0JWptmFTswVz42zdoJu=WBzRgAJ_Ycdz+JkWO-+RYHew@mail.gmail.com>
To: qemu-devel@nongnu.org
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::844
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v8 08/11] Adding tb_stats
 [start|pause|stop|filter] command to hmp.
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
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ops, this commit shouldn't exist. My mistake. The series still work though.
I will remove this on v9.


Vanderson M. Rosario


On Thu, Aug 29, 2019 at 2:35 PM vandersonmr <vandersonmr2@gmail.com> wrote:

> This allows controlling the collection of statistics.
> It is also possible to set the level of collection:
> all, jit, or exec.
>
> tb_stats filter allow to only collect statistics for the TB
> in the last_search list.
>
> The goal of this command is to allow the dynamic exploration
> of the TCG behavior and quality. Therefore, for now, a
> corresponding QMP command is not worthwhile.
>
> Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
> ---
>  monitor/misc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/monitor/misc.c b/monitor/misc.c
> index b389ca09a1..218263d29a 100644
> --- a/monitor/misc.c
> +++ b/monitor/misc.c
> @@ -74,6 +74,8 @@
>  #include "sysemu/cpus.h"
>  #include "qemu/cutils.h"
>  #include "tcg/tcg.h"
> +#include "exec/tb-stats.h"
> +#include "qemu-common.h"
>
>  #if defined(TARGET_S390X)
>  #include "hw/s390x/storage-keys.h"
> --
> 2.22.0
>
>
