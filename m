Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D71DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 19:33:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5118220756
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 19:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZQPBhPL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5118220756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkurb-00039H-ET
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 15:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1jkumN-0001uh-3Q
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 15:28:23 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e]:38200)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1jkumL-0004dY-B6
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 15:28:22 -0400
Received: by mail-ej1-x62e.google.com with SMTP id w16so18164873ejj.5
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 12:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EWVx9sSSwTv5Jhbc9Yzw+I2OIv8ntdWEbnNZIj+p5yg=;
 b=aZQPBhPLruXaUuuvjK3dLkIaOgrfBLtcfzSV+CKmO2F4GqBftoBhQ5jFH9Z5qoAXR4
 5117cmKLpmUMrNyzo6cpJl9Jpe0wrRm4HvAT48IYHTZx4/wMHP6WInNNL3rj4o+GR7Hd
 etOdRG9v6vKk1mv5qWFYJTUhvsq6F4JT4htUQ44MYv+lEaBOOs7My+SzYW6vtUKjR4hC
 8btabS+4Ih2iNkSI+qAOUwGJ3gnPR1yj7z45vbNuIr1pv84RkvRuZOFbgx4jmW2hxmPm
 UZ573q9gStAHDy45gKhubHmyK5aRJAjmtB38d4IekRZvGElqH6d8ezGr1cV/+C6QFcBY
 fILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EWVx9sSSwTv5Jhbc9Yzw+I2OIv8ntdWEbnNZIj+p5yg=;
 b=F/TTaOrlbQSunJwQffWZIKxGKE3VKf5ALfbshlAspLbY/bU8GkZimTq0JmNt6s03kU
 fmrcgxAPEbdQ6Ewk4imid7xuzg71my+Sd9fIzBkMgWRp3NZ9Mg6P8RG0RIjNksOT+b3T
 SylSB0n3Vt//ij65j6hbA5dltbpdt2iUzEwjTBLcVCSSh57SWh2evw/Y9oVsRSPaa9wE
 3GmrBvOz0qisMON4WCfMuVwRG9UA6NZd2WRJcQoR/RznNQs+4GPqYzK75+u/fgC8hkNI
 VjMQ/1aQCCpnPj8iRVQIHB8qIMlXOuIOVpK2R17WjaFAo0C9V2IXsfndrXiknmlUDL6b
 4qMQ==
X-Gm-Message-State: AOAM530cTJElh71dnVnpXsbdVDUtbVDT0V/GKia3+R9S+YrB08uhWFKG
 iOGDLWRL14wDZ7Tu4yk9Ucmb3SAI28RaVCQGzoE=
X-Google-Smtp-Source: ABdhPJwEPEr0UziD3/Kq8pauWFAXTwKAnJtVwfQmvPYGMvLMb8utX/PZsHFz/wpsjd3Y2DleeJXdhy5Sd4WrAdRb7vs=
X-Received: by 2002:a17:906:ae14:: with SMTP id
 le20mr26363674ejb.307.1592249299719; 
 Mon, 15 Jun 2020 12:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <1592248953-8162-1-git-send-email-aleksandar.qemu.devel@gmail.com>
In-Reply-To: <1592248953-8162-1-git-send-email-aleksandar.qemu.devel@gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 15 Jun 2020 21:28:09 +0200
Message-ID: <CAL1e-=g5RCy1eJNNQdrmqGzk8Yxs4x3i8+rB_jJLZMLAmQF6Yw@mail.gmail.com>
Subject: Re: [PULL 00/18] MIPS + misc queue for June 15th, 2020
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=aleksandar.m.mail@gmail.com; helo=mail-ej1-x62e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 15, 2020 at 9:22 PM Aleksandar Markovic
<aleksandar.qemu.devel@gmail.com> wrote:
>
> The following changes since commit 81b53858fed8a316a4715c2f7f92cdfb4a7b4dd8:
>
>   target/mips: msa: Split helpers for SUBS_U.<B|H|W|D> (2020-06-15 20:50:40 +0200)
>

Please discard this pull request. Wrong cover letter. Will send v2 shortly.

> are available in the git repository at:
>
>   https://github.com/AMarkovic/qemu tags/mips-queue-jun-15-2020
>
> for you to fetch changes up to 250bc43a406f7d46e319abe87c19548d4f027828:
>
>   translations: Add Swedish language (2020-06-15 20:51:10 +0200)
>
> ----------------------------------------------------------------
>
> MIPS + misc queue for June 15th, 2020
>
>   Highlights:
>
>     This pull request, just exceptionally, contains two non-MIPS patches:
>
>       - adjust sh4 maintainership
>       - add Swedish translations
>
>     The rest are MIPS patches:
>
>       - refactor emulation of a number of MSA instructions
>       - activate Loongson-related insn_flags
>
>     Notes:
>
>       - one checkpatch warning is benign
>       - some of make check iotest-qcow2 tests fail on my system, both before
>         and after applying the patches from this pull request
>
> ----------------------------------------------------------------
>
>
> Aleksandar Markovic (15):
>   target/mips: msa: Split helpers for MADDV.<B|H|W|D>
>   target/mips: msa: Split helpers for MSUBV.<B|H|W|D>
>   target/mips: msa: Split helpers for DPADD_S.<H|W|D>
>   target/mips: msa: Split helpers for DPADD_U.<H|W|D>
>   target/mips: msa: Split helpers for DPSUB_S.<H|W|D>
>   target/mips: msa: Split helpers for DPSUB_U.<H|W|D>
>   target/mips: msa: Split helpers for DOTP_S.<H|W|D>
>   target/mips: msa: Split helpers for DOTP_U.<H|W|D>
>   target/mips: msa: Split helpers for SUBS_S.<B|H|W|D>
>   target/mips: msa: Split helpers for SUBS_U.<B|H|W|D>
>   target/mips: msa: Split helpers for SUBSUS_U.<B|H|W|D>
>   target/mips: msa: Split helpers for SUBSUU_S.<B|H|W|D>
>   target/mips: msa: Split helpers for SUBV.<B|H|W|D>
>   target/mips: msa: Split helpers for MULV.<B|H|W|D>
>   MAINTAINERS: Adjust sh4 maintainership
>
> Jiaxun Yang (2):
>   target/mips: Legalize Loongson insn flags
>   target/mips: Add comments for vendor-specific ASEs
>
> Sebastian Rasmussen (1):
>   translations: Add Swedish language
>
>  target/mips/helper.h     |   73 ++-
>  target/mips/mips-defs.h  |    8 +-
>  target/mips/msa_helper.c | 1296 ++++++++++++++++++++++++++++++++++++----------
>  target/mips/translate.c  |  213 +++++++-
>  MAINTAINERS              |    8 +-
>  po/sv.po                 |   75 +++
>  6 files changed, 1364 insertions(+), 309 deletions(-)
>  create mode 100644 po/sv.po
>
> --
> 2.7.4
>
>

