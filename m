Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E3AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 02:14:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0FEE20797
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 02:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0FEE20797
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS9pl-0008Ke-QJ
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 22:14:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kS9oJ-0007ge-1z
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 22:13:07 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:46207)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kS9oH-0008Nz-2G
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 22:13:06 -0400
Received: by mail-il1-f195.google.com with SMTP id l16so18480769ilt.13
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 19:13:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=SEQGrypLZRbBtD2wt1y9OgNdJMOs7PJ0ZhBdDjMMmbY=;
 b=t66YzyODHctIzAYKbOhYwQKlUe2sNMjvp/ykC5U6+zn5v48Tr8JZ5qWkiI76i27TL7
 KA9Dk5L2JeFzDgx20/1qIqhnhTIp8rPfIQZYS3eOTFgrFHM4Vsn2VaUAWJ5iQbioKtif
 saItB2onT80fGiVcisln45Pmx+dAgYuUIQgNcHdzUV2pTFONOljL1/H9Hky2GR6AGMMX
 8jN/v0PijSXMM9Z+g9csI3GO0UmZxVB7DC8+3va2cNaHZ9M8a8moCbZLo0Xp5t3fObeZ
 A3SbH+VfHXxtWEjF2V/LN6CGa3SGH1bms4wpzqp7C23S6ebNBELZhT4QdUdCk1dLRlf+
 gorA==
X-Gm-Message-State: AOAM532rJ5gagF7v6aUrKJa1j+tEBFMdEeJjvyDNm5RAw6Cn9IB7S+aT
 1o9qUlwoo67mJleObiqzV97wFLG9eoQ=
X-Google-Smtp-Source: ABdhPJzOKCnHefhG1kOxtH0UtZSMSGV42Ar1uWL6h05t/sofp6e7553CdYbYyNpZpAd0OrWA8y3K/g==
X-Received: by 2002:a05:6e02:1392:: with SMTP id
 d18mr1295729ilo.196.1602555183616; 
 Mon, 12 Oct 2020 19:13:03 -0700 (PDT)
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com.
 [209.85.166.51])
 by smtp.gmail.com with ESMTPSA id r17sm558547iov.7.2020.10.12.19.13.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2020 19:13:03 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id q202so10985407iod.9
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 19:13:03 -0700 (PDT)
X-Received: by 2002:a02:7b08:: with SMTP id q8mr14845651jac.120.1602555182978; 
 Mon, 12 Oct 2020 19:13:02 -0700 (PDT)
MIME-Version: 1.0
References: <20201012232939.48481-1-j@getutm.app>
 <160255210179.18344.1363604125371198461@66eaa9a8a123>
In-Reply-To: <160255210179.18344.1363604125371198461@66eaa9a8a123>
From: Joelle van Dyne <j@getutm.app>
Date: Mon, 12 Oct 2020 19:12:52 -0700
X-Gmail-Original-Message-ID: <CA+E+eSAPqShPazUDp8zaaPbzjisdMG2VYGmNjyBSXzyokSO+kw@mail.gmail.com>
Message-ID: <CA+E+eSAPqShPazUDp8zaaPbzjisdMG2VYGmNjyBSXzyokSO+kw@mail.gmail.com>
Subject: Re: [PATCH 00/10] iOS and Apple Silicon host support
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=209.85.166.195; envelope-from=osy86dev@gmail.com;
 helo=mail-il1-f195.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 22:13:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I did run the style check tool. Of the errors/warnings, a few are from
code moved from one place to another, re-formatting the moved code
seems to break another rule (don't include irrelevant changes).



On Mon, Oct 12, 2020 at 6:21 PM <no-reply@patchew.org> wrote:
>
> Patchew URL: https://patchew.org/QEMU/20201012232939.48481-1-j@getutm.app/
>
>
>
> Hi,
>
> This series seems to have some coding style problems. See output below for
> more information:
>
> Type: series
> Message-id: 20201012232939.48481-1-j@getutm.app
> Subject: [PATCH 00/10] iOS and Apple Silicon host support
>
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> git rev-parse base > /dev/null || exit 0
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> git config --local diff.algorithm histogram
> ./scripts/checkpatch.pl --mailback base..
> === TEST SCRIPT END ===
>
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> From https://github.com/patchew-project/qemu
>  * [new tag]         patchew/20201012232939.48481-1-j@getutm.app -> patchew/20201012232939.48481-1-j@getutm.app
> Switched to a new branch 'test'
> b6c449f block: check availablity for preadv/pwritev on mac
> 86f3837 tcg: support JIT on Apple Silicon
> 6389bee tcg: mirror mapping RWX pages for iOS optional
> 8727db6 tcg: implement bulletproof JIT
> e655897 coroutine: add libucontext as external library
> e43d59a slirp: update for iOS resolv fix
> 715f3bd meson: option to build as shared library
> 7276968 qemu: add support for iOS host
> 9f6bafb configure: cross-compiling without cross_prefix
> 9187922 configure: option to disable host block devices
>
> === OUTPUT BEGIN ===
> 1/10 Checking commit 9187922c6d93 (configure: option to disable host block devices)
> WARNING: architecture specific defines should be avoided
> #22: FILE: block/file-posix.c:44:
> +#if defined(CONFIG_HOST_BLOCK_DEVICE) && defined(__APPLE__) && (__MACH__)
>
> total: 0 errors, 1 warnings, 61 lines checked
>
> Patch 1/10 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 2/10 Checking commit 9f6bafb19c1d (configure: cross-compiling without cross_prefix)
> 3/10 Checking commit 72769683dd9c (qemu: add support for iOS host)
> WARNING: architecture specific defines should be avoided
> #27: FILE: block.c:56:
> +#if !defined(__DragonFly__) && !defined(CONFIG_IOS)
>
> ERROR: braces {} are necessary for all arms of this statement
> #45: FILE: block/file-posix.c:189:
> +    if (s->fd >= 0)
> [...]
>
> WARNING: architecture specific defines should be avoided
> #79: FILE: block/file-posix.c:2325:
> +#if !defined(CONFIG_IOS) && defined(__APPLE__) && defined(__MACH__)
>
> WARNING: architecture specific defines should be avoided
> #363: FILE: tcg/aarch64/tcg-target.h:151:
> +#if defined(__APPLE__)
>
> WARNING: architecture specific defines should be avoided
> #369: FILE: tcg/aarch64/tcg-target.h:157:
> +#if defined(__APPLE__)
>
> total: 1 errors, 4 warnings, 316 lines checked
>
> Patch 3/10 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
>
> 4/10 Checking commit 715f3bddd393 (meson: option to build as shared library)
> 5/10 Checking commit e43d59afc25c (slirp: update for iOS resolv fix)
> 6/10 Checking commit e655897c7ab2 (coroutine: add libucontext as external library)
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #97:
> new file mode 160000
>
> total: 0 errors, 1 warnings, 140 lines checked
>
> Patch 6/10 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 7/10 Checking commit 8727db6cfd2d (tcg: implement bulletproof JIT)
> ERROR: externs should be avoided in .c files
> #52: FILE: accel/tcg/translate-all.c:65:
> +extern kern_return_t mach_vm_remap(vm_map_t target_task,
>
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #189:
> new file mode 100644
>
> WARNING: architecture specific defines should be avoided
> #501: FILE: tcg/aarch64/tcg-target.h:171:
> +#if defined(__APPLE__)
>
> WARNING: architecture specific defines should be avoided
> #757: FILE: tcg/i386/tcg-target.h:209:
> +#ifdef __APPLE__
>
> WARNING: architecture specific defines should be avoided
> #768: FILE: tcg/i386/tcg-target.h:220:
> +#if defined(__APPLE__)
>
> total: 1 errors, 4 warnings, 1673 lines checked
>
> Patch 7/10 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
>
> 8/10 Checking commit 6389bee4f3d0 (tcg: mirror mapping RWX pages for iOS optional)
> 9/10 Checking commit 86f3837d7074 (tcg: support JIT on Apple Silicon)
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #206:
> new file mode 100644
>
> WARNING: architecture specific defines should be avoided
> #238: FILE: include/tcg/tcg-apple-jit.h:28:
> +#if defined(__aarch64__) && defined(CONFIG_DARWIN)
>
> total: 0 errors, 2 warnings, 259 lines checked
>
> Patch 9/10 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 10/10 Checking commit b6c449ff37a3 (block: check availablity for preadv/pwritev on mac)
> === OUTPUT END ===
>
> Test command exited with code: 1
>
>
> The full log is available at
> http://patchew.org/logs/20201012232939.48481-1-j@getutm.app/testing.checkpatch/?type=message.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com

