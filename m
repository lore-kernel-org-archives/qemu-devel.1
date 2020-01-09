Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A81FC3F68F
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:22:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B758C2077B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2UJE6N6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B758C2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipWpO-0007Va-TG
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 07:22:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42592)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ipWoQ-0006Gd-6C
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:21:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ipWoG-00037g-Mg
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:21:18 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:44047)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ipWoG-00033C-1o
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:21:08 -0500
Received: by mail-ot1-x341.google.com with SMTP id h9so6984142otj.11
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 04:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=mj88aPUB7YEpIQVWYbFqEGtNyraJdgBqiUNW0ehD50g=;
 b=L2UJE6N6hw8n54qKti88G9zTFoK1TaqtyijnWvTZW/l1uIt8S710K5PDW2XhzTnIHy
 bOnMvBLbIQwYd33nBIptGnSkgo6TtbnhiY449lohtXLvhGQO9lti+T/uNrp9luNPVlf5
 cXJyFGphMxitN4ZDVLwhLGpnnmWaG6uN/D0SI/moXJQb0DFjwBNty7nbu2vwy7kAVQvo
 Pqd8P0waBU2ClANT5Hj05qtEFUqc0qZMfxUlD6Wr7G5n5k+qpG2MgqGDEqQeJYfp50Bk
 OvvpXASEMFyIwOCaKjrVEO7lc2/AzQrQB3XKq1E5fc99A0lAus7bfQfuRoSTtgTYCAO8
 m5cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=mj88aPUB7YEpIQVWYbFqEGtNyraJdgBqiUNW0ehD50g=;
 b=Jo9ZGcH8NMhYbiMqVGVG4vdIFzfM1ZJuaV4bQmWix4s+0f2m5Y0IZUxhayFREH3kWm
 WS9nz7IEx5X8vvf1FLsUcmpzeGJrSMK1gwhqmEMvV7sMAdnasRCx6vwDvY1hxuaqFRNL
 Yv9xSKCCXhH/iRc3bqaTJ+FyAmKXJ29DqSggtmjtiWB7Did14Z6gp7maBSiVsAd4Z6+t
 4SjpAnpmkqImzoFOooWtLiWRyM1vKZDEMd/AxGmqivhLaEgi0s3+ztAjB6NSwGz5k0dW
 htgErXwm+OTZE0srqRt64UJBAJzMYdicLVeVa/qiLNA1ZuV5Hk474L4312TU4tq+eWn9
 tnLQ==
X-Gm-Message-State: APjAAAX2YGpiWnIZCBS9CsgqTxlfotDnJD650ymh8JWGG0rqFUlmT7I8
 apXToyXtQUV+2Hv3a4LIsyXSKOrhwZhrljQoWis4tg==
X-Google-Smtp-Source: APXvYqyCZOUi6tyIdDOi+AC6LAqzyNp+na+LnAmrVetUDFIhgPo+0vYSUvi1DXt3ftvmudD2zo7veO4eylUrMxnwouk=
X-Received: by 2002:a9d:5e93:: with SMTP id f19mr7783995otl.121.1578572465327; 
 Thu, 09 Jan 2020 04:21:05 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Thu, 9 Jan 2020 04:21:04 -0800 (PST)
In-Reply-To: <20191212163904.159893-8-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-8-dgilbert@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 9 Jan 2020 13:21:04 +0100
Message-ID: <CAL1e-=hfCRVFbppJwJiTCiv=k1BfbzuxRg9NbcRLtxgA33r-uQ@mail.gmail.com>
Subject: Re: [PATCH 007/104] virtiofsd: Format imported files to qemu style
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000000c5368059bb40bfb"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "vgoyal@redhat.com" <vgoyal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000000c5368059bb40bfb
Content-Type: text/plain; charset="UTF-8"

On Thursday, December 12, 2019, Dr. David Alan Gilbert (git) <
dgilbert@redhat.com> wrote:

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Mostly using a set like:
>
> indent -nut -i 4 -nlp -br -cs -ce --no-space-after-function-call-names
> file
> clang-format -style=file -i -- file
> clang-tidy -fix-errors -checks=readability-braces-around-statements file
> clang-format -style=file -i -- file
>
> With manual cleanups.
>
> The .clang-format used is below.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>
> Language:        Cpp
> AlignAfterOpenBracket: Align
> AlignConsecutiveAssignments: false # although we like it, it creates churn
> AlignConsecutiveDeclarations: false
> AlignEscapedNewlinesLeft: true
> AlignOperands:   true
> AlignTrailingComments: false # churn
> AllowAllParametersOfDeclarationOnNextLine: true
> AllowShortBlocksOnASingleLine: false
> AllowShortCaseLabelsOnASingleLine: false
> AllowShortFunctionsOnASingleLine: None
> AllowShortIfStatementsOnASingleLine: false
> AllowShortLoopsOnASingleLine: false
> AlwaysBreakAfterReturnType: None # AlwaysBreakAfterDefinitionReturnType
> is taken into account
> AlwaysBreakBeforeMultilineStrings: false
> BinPackArguments: true
> BinPackParameters: true
> BraceWrapping:
>   AfterControlStatement: false
>   AfterEnum:       false
>   AfterFunction:   true
>   AfterStruct:     false
>   AfterUnion:      false
>   BeforeElse:      false
>   IndentBraces:    false
> BreakBeforeBinaryOperators: None
> BreakBeforeBraces: Custom
> BreakBeforeTernaryOperators: false
> BreakStringLiterals: true
> ColumnLimit:     80
> ContinuationIndentWidth: 4
> Cpp11BracedListStyle: false
> DerivePointerAlignment: false
> DisableFormat:   false
> ForEachMacros:   [
>   'CPU_FOREACH',
>   'CPU_FOREACH_REVERSE',
>   'CPU_FOREACH_SAFE',
>   'IOMMU_NOTIFIER_FOREACH',
>   'QLIST_FOREACH',
>   'QLIST_FOREACH_ENTRY',
>   'QLIST_FOREACH_RCU',
>   'QLIST_FOREACH_SAFE',
>   'QLIST_FOREACH_SAFE_RCU',
>   'QSIMPLEQ_FOREACH',
>   'QSIMPLEQ_FOREACH_SAFE',
>   'QSLIST_FOREACH',
>   'QSLIST_FOREACH_SAFE',
>   'QTAILQ_FOREACH',
>   'QTAILQ_FOREACH_REVERSE',
>   'QTAILQ_FOREACH_SAFE',
>   'QTAILQ_RAW_FOREACH',
>   'RAMBLOCK_FOREACH'
> ]
> IncludeCategories:
>   - Regex:           '^"qemu/osdep.h'
>     Priority:        -3
>   - Regex:           '^"(block|chardev|crypto|disas|exec|fpu|hw|io|
> libdecnumber|migration|monitor|net|qapi|qemu|qom|
> standard-headers|sysemu|ui)/'
>     Priority:        -2
>   - Regex:           '^"(elf.h|qemu-common.h|glib-
> compat.h|qemu-io.h|trace-tcg.h)'
>     Priority:        -1
>   - Regex:           '.*'
>     Priority:        1
> IncludeIsMainRegex: '$'
> IndentCaseLabels: false
> IndentWidth:     4
> IndentWrappedFunctionNames: false
> KeepEmptyLinesAtTheStartOfBlocks: false
> MacroBlockBegin: '.*_BEGIN$' # only PREC_BEGIN ?
> MacroBlockEnd:   '.*_END$'
> MaxEmptyLinesToKeep: 2
> PointerAlignment: Right
> ReflowComments:  true
> SortIncludes:    true
> SpaceAfterCStyleCast: false
> SpaceBeforeAssignmentOperators: true
> SpaceBeforeParens: ControlStatements
> SpaceInEmptyParentheses: false
> SpacesBeforeTrailingComments: 1
> SpacesInContainerLiterals: true
> SpacesInParentheses: false
> SpacesInSquareBrackets: false
> Standard:        Auto
> UseTab:          Never
> ...
> ---
>  tools/virtiofsd/buffer.c              |  550 ++--
>  tools/virtiofsd/fuse.h                | 1572 +++++------
>  tools/virtiofsd/fuse_common.h         |  764 ++---
>  tools/virtiofsd/fuse_i.h              |  127 +-
>  tools/virtiofsd/fuse_log.c            |   38 +-
>  tools/virtiofsd/fuse_log.h            |   32 +-
>  tools/virtiofsd/fuse_loop_mt.c        |   66 +-
>  tools/virtiofsd/fuse_lowlevel.c       | 3678 +++++++++++++------------
>  tools/virtiofsd/fuse_lowlevel.h       | 2401 ++++++++--------
>  tools/virtiofsd/fuse_misc.h           |   30 +-
>  tools/virtiofsd/fuse_opt.c            |  659 ++---
>  tools/virtiofsd/fuse_opt.h            |   79 +-
>  tools/virtiofsd/fuse_signals.c        |  118 +-
>  tools/virtiofsd/helper.c              |  517 ++--
>  tools/virtiofsd/passthrough_helpers.h |   33 +-
>  tools/virtiofsd/passthrough_ll.c      | 2063 +++++++-------
>  16 files changed, 6530 insertions(+), 6197 deletions(-)
>
>
Reviewed by: Aleksandar Markovic <amarkovic@wavecomp.com>


> diff --git a/tools/virtiofsd/buffer.c b/tools/virtiofsd/buffer.c
> index 5ab9b87455..38521f5889 100644
> --- a/tools/virtiofsd/buffer.c
> +++ b/tools/virtiofsd/buffer.c
> @@ -1,321 +1,343 @@
>  /*
> -  FUSE: Filesystem in Userspace
> -  Copyright (C) 2010  Miklos Szeredi <miklos@szeredi.hu>
> -
> -  Functions for dealing with `struct fuse_buf` and `struct
> -  fuse_bufvec`.
> -
> -  This program can be distributed under the terms of the GNU LGPLv2.
> -  See the file COPYING.LIB
> -*/
> + * FUSE: Filesystem in Userspace
> + * Copyright (C) 2010  Miklos Szeredi <miklos@szeredi.hu>
> + *
> + * Functions for dealing with `struct fuse_buf` and `struct
> + * fuse_bufvec`.
> + *
> + * This program can be distributed under the terms of the GNU LGPLv2.
> + * See the file COPYING.LIB
> + */
>
>  #define _GNU_SOURCE
>
>  #include "config.h"
>  #include "fuse_i.h"
>  #include "fuse_lowlevel.h"
> +#include <assert.h>
> +#include <errno.h>
>  #include <string.h>
>  #include <unistd.h>
> -#include <errno.h>
> -#include <assert.h>
>
>  size_t fuse_buf_size(const struct fuse_bufvec *bufv)
>  {
> -       size_t i;
> -       size_t size = 0;
> -
> -       for (i = 0; i < bufv->count; i++) {
> -               if (bufv->buf[i].size == SIZE_MAX)
> -                       size = SIZE_MAX;
> -               else
> -                       size += bufv->buf[i].size;
> -       }
> -
> -       return size;
> +    size_t i;
> +    size_t size = 0;
> +
> +    for (i = 0; i < bufv->count; i++) {
> +        if (bufv->buf[i].size == SIZE_MAX) {
> +            size = SIZE_MAX;
> +        } else {
> +            size += bufv->buf[i].size;
> +        }
> +    }
> +
> +    return size;
>  }
>
>  static size_t min_size(size_t s1, size_t s2)
>  {
> -       return s1 < s2 ? s1 : s2;
> +    return s1 < s2 ? s1 : s2;
>  }
>
>  static ssize_t fuse_buf_write(const struct fuse_buf *dst, size_t dst_off,
> -                             const struct fuse_buf *src, size_t src_off,
> -                             size_t len)
> +                              const struct fuse_buf *src, size_t src_off,
> +                              size_t len)
>  {
> -       ssize_t res = 0;
> -       size_t copied = 0;
> -
> -       while (len) {
> -               if (dst->flags & FUSE_BUF_FD_SEEK) {
> -                       res = pwrite(dst->fd, (char *)src->mem + src_off,
> len,
> -                                    dst->pos + dst_off);
> -               } else {
> -                       res = write(dst->fd, (char *)src->mem + src_off,
> len);
> -               }
> -               if (res == -1) {
> -                       if (!copied)
> -                               return -errno;
> -                       break;
> -               }
> -               if (res == 0)
> -                       break;
> -
> -               copied += res;
> -               if (!(dst->flags & FUSE_BUF_FD_RETRY))
> -                       break;
> -
> -               src_off += res;
> -               dst_off += res;
> -               len -= res;
> -       }
> -
> -       return copied;
> +    ssize_t res = 0;
> +    size_t copied = 0;
> +
> +    while (len) {
> +        if (dst->flags & FUSE_BUF_FD_SEEK) {
> +            res = pwrite(dst->fd, (char *)src->mem + src_off, len,
> +                         dst->pos + dst_off);
> +        } else {
> +            res = write(dst->fd, (char *)src->mem + src_off, len);
> +        }
> +        if (res == -1) {
> +            if (!copied) {
> +                return -errno;
> +            }
> +            break;
> +        }
> +        if (res == 0) {
> +            break;
> +        }
> +
> +        copied += res;
> +        if (!(dst->flags & FUSE_BUF_FD_RETRY)) {
> +            break;
> +        }
> +
> +        src_off += res;
> +        dst_off += res;
> +        len -= res;
> +    }
> +
> +    return copied;
>  }
>
>  static ssize_t fuse_buf_read(const struct fuse_buf *dst, size_t dst_off,
> -                            const struct fuse_buf *src, size_t src_off,
> -                            size_t len)
> +                             const struct fuse_buf *src, size_t src_off,
> +                             size_t len)
>  {
> -       ssize_t res = 0;
> -       size_t copied = 0;
> -
> -       while (len) {
> -               if (src->flags & FUSE_BUF_FD_SEEK) {
> -                       res = pread(src->fd, (char *)dst->mem + dst_off,
> len,
> -                                    src->pos + src_off);
> -               } else {
> -                       res = read(src->fd, (char *)dst->mem + dst_off,
> len);
> -               }
> -               if (res == -1) {
> -                       if (!copied)
> -                               return -errno;
> -                       break;
> -               }
> -               if (res == 0)
> -                       break;
> -
> -               copied += res;
> -               if (!(src->flags & FUSE_BUF_FD_RETRY))
> -                       break;
> -
> -               dst_off += res;
> -               src_off += res;
> -               len -= res;
> -       }
> -
> -       return copied;
> +    ssize_t res = 0;
> +    size_t copied = 0;
> +
> +    while (len) {
> +        if (src->flags & FUSE_BUF_FD_SEEK) {
> +            res = pread(src->fd, (char *)dst->mem + dst_off, len,
> +                        src->pos + src_off);
> +        } else {
> +            res = read(src->fd, (char *)dst->mem + dst_off, len);
> +        }
> +        if (res == -1) {
> +            if (!copied) {
> +                return -errno;
> +            }
> +            break;
> +        }
> +        if (res == 0) {
> +            break;
> +        }
> +
> +        copied += res;
> +        if (!(src->flags & FUSE_BUF_FD_RETRY)) {
> +            break;
> +        }
> +
> +        dst_off += res;
> +        src_off += res;
> +        len -= res;
> +    }
> +
> +    return copied;
>  }
>
>  static ssize_t fuse_buf_fd_to_fd(const struct fuse_buf *dst, size_t
> dst_off,
> -                                const struct fuse_buf *src, size_t
> src_off,
> -                                size_t len)
> +                                 const struct fuse_buf *src, size_t
> src_off,
> +                                 size_t len)
>  {
> -       char buf[4096];
> -       struct fuse_buf tmp = {
> -               .size = sizeof(buf),
> -               .flags = 0,
> -       };
> -       ssize_t res;
> -       size_t copied = 0;
> -
> -       tmp.mem = buf;
> -
> -       while (len) {
> -               size_t this_len = min_size(tmp.size, len);
> -               size_t read_len;
> -
> -               res = fuse_buf_read(&tmp, 0, src, src_off, this_len);
> -               if (res < 0) {
> -                       if (!copied)
> -                               return res;
> -                       break;
> -               }
> -               if (res == 0)
> -                       break;
> -
> -               read_len = res;
> -               res = fuse_buf_write(dst, dst_off, &tmp, 0, read_len);
> -               if (res < 0) {
> -                       if (!copied)
> -                               return res;
> -                       break;
> -               }
> -               if (res == 0)
> -                       break;
> -
> -               copied += res;
> -
> -               if (res < this_len)
> -                       break;
> -
> -               dst_off += res;
> -               src_off += res;
> -               len -= res;
> -       }
> -
> -       return copied;
> +    char buf[4096];
> +    struct fuse_buf tmp = {
> +        .size = sizeof(buf),
> +        .flags = 0,
> +    };
> +    ssize_t res;
> +    size_t copied = 0;
> +
> +    tmp.mem = buf;
> +
> +    while (len) {
> +        size_t this_len = min_size(tmp.size, len);
> +        size_t read_len;
> +
> +        res = fuse_buf_read(&tmp, 0, src, src_off, this_len);
> +        if (res < 0) {
> +            if (!copied) {
> +                return res;
> +            }
> +            break;
> +        }
> +        if (res == 0) {
> +            break;
> +        }
> +
> +        read_len = res;
> +        res = fuse_buf_write(dst, dst_off, &tmp, 0, read_len);
> +        if (res < 0) {
> +            if (!copied) {
> +                return res;
> +            }
> +            break;
> +        }
> +        if (res == 0) {
> +            break;
> +        }
> +
> +        copied += res;
> +
> +        if (res < this_len) {
> +            break;
> +        }
> +
> +        dst_off += res;
> +        src_off += res;
> +        len -= res;
> +    }
> +
> +    return copied;
>  }
>
>  #ifdef HAVE_SPLICE
>  static ssize_t fuse_buf_splice(const struct fuse_buf *dst, size_t dst_off,
> -                              const struct fuse_buf *src, size_t src_off,
> -                              size_t len, enum fuse_buf_copy_flags flags)
> +                               const struct fuse_buf *src, size_t src_off,
> +                               size_t len, enum fuse_buf_copy_flags flags)
>  {
> -       int splice_flags = 0;
> -       off_t *srcpos = NULL;
> -       off_t *dstpos = NULL;
> -       off_t srcpos_val;
> -       off_t dstpos_val;
> -       ssize_t res;
> -       size_t copied = 0;
> -
> -       if (flags & FUSE_BUF_SPLICE_MOVE)
> -               splice_flags |= SPLICE_F_MOVE;
> -       if (flags & FUSE_BUF_SPLICE_NONBLOCK)
> -               splice_flags |= SPLICE_F_NONBLOCK;
> -
> -       if (src->flags & FUSE_BUF_FD_SEEK) {
> -               srcpos_val = src->pos + src_off;
> -               srcpos = &srcpos_val;
> -       }
> -       if (dst->flags & FUSE_BUF_FD_SEEK) {
> -               dstpos_val = dst->pos + dst_off;
> -               dstpos = &dstpos_val;
> -       }
> -
> -       while (len) {
> -               res = splice(src->fd, srcpos, dst->fd, dstpos, len,
> -                            splice_flags);
> -               if (res == -1) {
> -                       if (copied)
> -                               break;
> -
> -                       if (errno != EINVAL || (flags &
> FUSE_BUF_FORCE_SPLICE))
> -                               return -errno;
> -
> -                       /* Maybe splice is not supported for this
> combination */
> -                       return fuse_buf_fd_to_fd(dst, dst_off, src,
> src_off,
> -                                                len);
> -               }
> -               if (res == 0)
> -                       break;
> -
> -               copied += res;
> -               if (!(src->flags & FUSE_BUF_FD_RETRY) &&
> -                   !(dst->flags & FUSE_BUF_FD_RETRY)) {
> -                       break;
> -               }
> -
> -               len -= res;
> -       }
> -
> -       return copied;
> +    int splice_flags = 0;
> +    off_t *srcpos = NULL;
> +    off_t *dstpos = NULL;
> +    off_t srcpos_val;
> +    off_t dstpos_val;
> +    ssize_t res;
> +    size_t copied = 0;
> +
> +    if (flags & FUSE_BUF_SPLICE_MOVE) {
> +        splice_flags |= SPLICE_F_MOVE;
> +    }
> +    if (flags & FUSE_BUF_SPLICE_NONBLOCK) {
> +        splice_flags |= SPLICE_F_NONBLOCK;
> +    }
> +    if (src->flags & FUSE_BUF_FD_SEEK) {
> +        srcpos_val = src->pos + src_off;
> +        srcpos = &srcpos_val;
> +    }
> +    if (dst->flags & FUSE_BUF_FD_SEEK) {
> +        dstpos_val = dst->pos + dst_off;
> +        dstpos = &dstpos_val;
> +    }
> +
> +    while (len) {
> +        res = splice(src->fd, srcpos, dst->fd, dstpos, len, splice_flags);
> +        if (res == -1) {
> +            if (copied) {
> +                break;
> +            }
> +
> +            if (errno != EINVAL || (flags & FUSE_BUF_FORCE_SPLICE)) {
> +                return -errno;
> +            }
> +
> +            /* Maybe splice is not supported for this combination */
> +            return fuse_buf_fd_to_fd(dst, dst_off, src, src_off, len);
> +        }
> +        if (res == 0) {
> +            break;
> +        }
> +
> +        copied += res;
> +        if (!(src->flags & FUSE_BUF_FD_RETRY) &&
> +            !(dst->flags & FUSE_BUF_FD_RETRY)) {
> +            break;
> +        }
> +
> +        len -= res;
> +    }
> +
> +    return copied;
>  }
>  #else
>  static ssize_t fuse_buf_splice(const struct fuse_buf *dst, size_t dst_off,
> -                              const struct fuse_buf *src, size_t src_off,
> -                              size_t len, enum fuse_buf_copy_flags flags)
> +                               const struct fuse_buf *src, size_t src_off,
> +                               size_t len, enum fuse_buf_copy_flags flags)
>  {
> -       (void) flags;
> +    (void)flags;
>
> -       return fuse_buf_fd_to_fd(dst, dst_off, src, src_off, len);
> +    return fuse_buf_fd_to_fd(dst, dst_off, src, src_off, len);
>  }
>  #endif
>
>
>  static ssize_t fuse_buf_copy_one(const struct fuse_buf *dst, size_t
> dst_off,
> -                                const struct fuse_buf *src, size_t
> src_off,
> -                                size_t len, enum fuse_buf_copy_flags
> flags)
> +                                 const struct fuse_buf *src, size_t
> src_off,
> +                                 size_t len, enum fuse_buf_copy_flags
> flags)
>  {
> -       int src_is_fd = src->flags & FUSE_BUF_IS_FD;
> -       int dst_is_fd = dst->flags & FUSE_BUF_IS_FD;
> -
> -       if (!src_is_fd && !dst_is_fd) {
> -               char *dstmem = (char *)dst->mem + dst_off;
> -               char *srcmem = (char *)src->mem + src_off;
> -
> -               if (dstmem != srcmem) {
> -                       if (dstmem + len <= srcmem || srcmem + len <=
> dstmem)
> -                               memcpy(dstmem, srcmem, len);
> -                       else
> -                               memmove(dstmem, srcmem, len);
> -               }
> -
> -               return len;
> -       } else if (!src_is_fd) {
> -               return fuse_buf_write(dst, dst_off, src, src_off, len);
> -       } else if (!dst_is_fd) {
> -               return fuse_buf_read(dst, dst_off, src, src_off, len);
> -       } else if (flags & FUSE_BUF_NO_SPLICE) {
> -               return fuse_buf_fd_to_fd(dst, dst_off, src, src_off, len);
> -       } else {
> -               return fuse_buf_splice(dst, dst_off, src, src_off, len,
> flags);
> -       }
> +    int src_is_fd = src->flags & FUSE_BUF_IS_FD;
> +    int dst_is_fd = dst->flags & FUSE_BUF_IS_FD;
> +
> +    if (!src_is_fd && !dst_is_fd) {
> +        char *dstmem = (char *)dst->mem + dst_off;
> +        char *srcmem = (char *)src->mem + src_off;
> +
> +        if (dstmem != srcmem) {
> +            if (dstmem + len <= srcmem || srcmem + len <= dstmem) {
> +                memcpy(dstmem, srcmem, len);
> +            } else {
> +                memmove(dstmem, srcmem, len);
> +            }
> +        }
> +
> +        return len;
> +    } else if (!src_is_fd) {
> +        return fuse_buf_write(dst, dst_off, src, src_off, len);
> +    } else if (!dst_is_fd) {
> +        return fuse_buf_read(dst, dst_off, src, src_off, len);
> +    } else if (flags & FUSE_BUF_NO_SPLICE) {
> +        return fuse_buf_fd_to_fd(dst, dst_off, src, src_off, len);
> +    } else {
> +        return fuse_buf_splice(dst, dst_off, src, src_off, len, flags);
> +    }
>  }
>
>  static const struct fuse_buf *fuse_bufvec_current(struct fuse_bufvec
> *bufv)
>  {
> -       if (bufv->idx < bufv->count)
> -               return &bufv->buf[bufv->idx];
> -       else
> -               return NULL;
> +    if (bufv->idx < bufv->count) {
> +        return &bufv->buf[bufv->idx];
> +    } else {
> +        return NULL;
> +    }
>  }
>
>  static int fuse_bufvec_advance(struct fuse_bufvec *bufv, size_t len)
>  {
> -       const struct fuse_buf *buf = fuse_bufvec_current(bufv);
> -
> -       bufv->off += len;
> -       assert(bufv->off <= buf->size);
> -       if (bufv->off == buf->size) {
> -               assert(bufv->idx < bufv->count);
> -               bufv->idx++;
> -               if (bufv->idx == bufv->count)
> -                       return 0;
> -               bufv->off = 0;
> -       }
> -       return 1;
> +    const struct fuse_buf *buf = fuse_bufvec_current(bufv);
> +
> +    bufv->off += len;
> +    assert(bufv->off <= buf->size);
> +    if (bufv->off == buf->size) {
> +        assert(bufv->idx < bufv->count);
> +        bufv->idx++;
> +        if (bufv->idx == bufv->count) {
> +            return 0;
> +        }
> +        bufv->off = 0;
> +    }
> +    return 1;
>  }
>
>  ssize_t fuse_buf_copy(struct fuse_bufvec *dstv, struct fuse_bufvec *srcv,
> -                     enum fuse_buf_copy_flags flags)
> +                      enum fuse_buf_copy_flags flags)
>  {
> -       size_t copied = 0;
> -
> -       if (dstv == srcv)
> -               return fuse_buf_size(dstv);
> -
> -       for (;;) {
> -               const struct fuse_buf *src = fuse_bufvec_current(srcv);
> -               const struct fuse_buf *dst = fuse_bufvec_current(dstv);
> -               size_t src_len;
> -               size_t dst_len;
> -               size_t len;
> -               ssize_t res;
> -
> -               if (src == NULL || dst == NULL)
> -                       break;
> -
> -               src_len = src->size - srcv->off;
> -               dst_len = dst->size - dstv->off;
> -               len = min_size(src_len, dst_len);
> -
> -               res = fuse_buf_copy_one(dst, dstv->off, src, srcv->off,
> len, flags);
> -               if (res < 0) {
> -                       if (!copied)
> -                               return res;
> -                       break;
> -               }
> -               copied += res;
> -
> -               if (!fuse_bufvec_advance(srcv, res) ||
> -                   !fuse_bufvec_advance(dstv, res))
> -                       break;
> -
> -               if (res < len)
> -                       break;
> -       }
> -
> -       return copied;
> +    size_t copied = 0;
> +
> +    if (dstv == srcv) {
> +        return fuse_buf_size(dstv);
> +    }
> +
> +    for (;;) {
> +        const struct fuse_buf *src = fuse_bufvec_current(srcv);
> +        const struct fuse_buf *dst = fuse_bufvec_current(dstv);
> +        size_t src_len;
> +        size_t dst_len;
> +        size_t len;
> +        ssize_t res;
> +
> +        if (src == NULL || dst == NULL) {
> +            break;
> +        }
> +
> +        src_len = src->size - srcv->off;
> +        dst_len = dst->size - dstv->off;
> +        len = min_size(src_len, dst_len);
> +
> +        res = fuse_buf_copy_one(dst, dstv->off, src, srcv->off, len,
> flags);
> +        if (res < 0) {
> +            if (!copied) {
> +                return res;
> +            }
> +            break;
> +        }
> +        copied += res;
> +
> +        if (!fuse_bufvec_advance(srcv, res) ||
> +            !fuse_bufvec_advance(dstv, res)) {
> +            break;
> +        }
> +
> +        if (res < len) {
> +            break;
> +        }
> +    }
> +
> +    return copied;
>  }
> diff --git a/tools/virtiofsd/fuse.h b/tools/virtiofsd/fuse.h
> index 6c16a0041d..945ebc7a0d 100644
> --- a/tools/virtiofsd/fuse.h
> +++ b/tools/virtiofsd/fuse.h
> @@ -1,15 +1,15 @@
>  /*
> -  FUSE: Filesystem in Userspace
> -  Copyright (C) 2001-2007  Miklos Szeredi <miklos@szeredi.hu>
> -
> -  This program can be distributed under the terms of the GNU LGPLv2.
> -  See the file COPYING.LIB.
> -*/
> + * FUSE: Filesystem in Userspace
> + * Copyright (C) 2001-2007  Miklos Szeredi <miklos@szeredi.hu>
> + *
> + * This program can be distributed under the terms of the GNU LGPLv2.
> + * See the file COPYING.LIB.
> + */
>
>  #ifndef FUSE_H_
>  #define FUSE_H_
>
> -/** @file
> +/*
>   *
>   * This file defines the library interface of FUSE
>   *
> @@ -19,15 +19,15 @@
>  #include "fuse_common.h"
>
>  #include <fcntl.h>
> -#include <time.h>
> -#include <sys/types.h>
>  #include <sys/stat.h>
>  #include <sys/statvfs.h>
> +#include <sys/types.h>
>  #include <sys/uio.h>
> +#include <time.h>
>
> -/* ----------------------------------------------------------- *
> - * Basic FUSE API                                             *
> - * ----------------------------------------------------------- */
> +/*
> + * Basic FUSE API
> + */
>
>  /** Handle for a FUSE filesystem */
>  struct fuse;
> @@ -36,38 +36,39 @@ struct fuse;
>   * Readdir flags, passed to ->readdir()
>   */
>  enum fuse_readdir_flags {
> -       /**
> -        * "Plus" mode.
> -        *
> -        * The kernel wants to prefill the inode cache during readdir.  The
> -        * filesystem may honour this by filling in the attributes and
> setting
> -        * FUSE_FILL_DIR_FLAGS for the filler function.  The filesystem
> may also
> -        * just ignore this flag completely.
> -        */
> -       FUSE_READDIR_PLUS = (1 << 0),
> +    /**
> +     * "Plus" mode.
> +     *
> +     * The kernel wants to prefill the inode cache during readdir.  The
> +     * filesystem may honour this by filling in the attributes and setting
> +     * FUSE_FILL_DIR_FLAGS for the filler function.  The filesystem may
> also
> +     * just ignore this flag completely.
> +     */
> +    FUSE_READDIR_PLUS = (1 << 0),
>  };
>
>  enum fuse_fill_dir_flags {
> -       /**
> -        * "Plus" mode: all file attributes are valid
> -        *
> -        * The attributes are used by the kernel to prefill the inode cache
> -        * during a readdir.
> -        *
> -        * It is okay to set FUSE_FILL_DIR_PLUS if FUSE_READDIR_PLUS is
> not set
> -        * and vice versa.
> -        */
> -       FUSE_FILL_DIR_PLUS = (1 << 1),
> +    /**
> +     * "Plus" mode: all file attributes are valid
> +     *
> +     * The attributes are used by the kernel to prefill the inode cache
> +     * during a readdir.
> +     *
> +     * It is okay to set FUSE_FILL_DIR_PLUS if FUSE_READDIR_PLUS is not
> set
> +     * and vice versa.
> +     */
> +    FUSE_FILL_DIR_PLUS = (1 << 1),
>  };
>
> -/** Function to add an entry in a readdir() operation
> +/**
> + * Function to add an entry in a readdir() operation
>   *
>   * The *off* parameter can be any non-zero value that enables the
>   * filesystem to identify the current point in the directory
>   * stream. It does not need to be the actual physical position. A
>   * value of zero is reserved to indicate that seeking in directories
>   * is not supported.
> - *
> + *
>   * @param buf the buffer passed to the readdir() operation
>   * @param name the file name of the directory entry
>   * @param stat file attributes, can be NULL
> @@ -75,9 +76,9 @@ enum fuse_fill_dir_flags {
>   * @param flags fill flags
>   * @return 1 if buffer is full, zero otherwise
>   */
> -typedef int (*fuse_fill_dir_t) (void *buf, const char *name,
> -                               const struct stat *stbuf, off_t off,
> -                               enum fuse_fill_dir_flags flags);
> +typedef int (*fuse_fill_dir_t)(void *buf, const char *name,
> +                               const struct stat *stbuf, off_t off,
> +                               enum fuse_fill_dir_flags flags);
>  /**
>   * Configuration of the high-level API
>   *
> @@ -87,186 +88,186 @@ typedef int (*fuse_fill_dir_t) (void *buf, const
> char *name,
>   * file system implementation.
>   */
>  struct fuse_config {
> -       /**
> -        * If `set_gid` is non-zero, the st_gid attribute of each file
> -        * is overwritten with the value of `gid`.
> -        */
> -       int set_gid;
> -       unsigned int gid;
> -
> -       /**
> -        * If `set_uid` is non-zero, the st_uid attribute of each file
> -        * is overwritten with the value of `uid`.
> -        */
> -       int set_uid;
> -       unsigned int uid;
> -
> -       /**
> -        * If `set_mode` is non-zero, the any permissions bits set in
> -        * `umask` are unset in the st_mode attribute of each file.
> -        */
> -       int set_mode;
> -       unsigned int umask;
> -
> -       /**
> -        * The timeout in seconds for which name lookups will be
> -        * cached.
> -        */
> -       double entry_timeout;
> -
> -       /**
> -        * The timeout in seconds for which a negative lookup will be
> -        * cached. This means, that if file did not exist (lookup
> -        * retuned ENOENT), the lookup will only be redone after the
> -        * timeout, and the file/directory will be assumed to not
> -        * exist until then. A value of zero means that negative
> -        * lookups are not cached.
> -        */
> -       double negative_timeout;
> -
> -       /**
> -        * The timeout in seconds for which file/directory attributes
> -        * (as returned by e.g. the `getattr` handler) are cached.
> -        */
> -       double attr_timeout;
> -
> -       /**
> -        * Allow requests to be interrupted
> -        */
> -       int intr;
> -
> -       /**
> -        * Specify which signal number to send to the filesystem when
> -        * a request is interrupted.  The default is hardcoded to
> -        * USR1.
> -        */
> -       int intr_signal;
> -
> -       /**
> -        * Normally, FUSE assigns inodes to paths only for as long as
> -        * the kernel is aware of them. With this option inodes are
> -        * instead remembered for at least this many seconds.  This
> -        * will require more memory, but may be necessary when using
> -        * applications that make use of inode numbers.
> -        *
> -        * A number of -1 means that inodes will be remembered for the
> -        * entire life-time of the file-system process.
> -        */
> -       int remember;
> -
> -       /**
> -        * The default behavior is that if an open file is deleted,
> -        * the file is renamed to a hidden file (.fuse_hiddenXXX), and
> -        * only removed when the file is finally released.  This
> -        * relieves the filesystem implementation of having to deal
> -        * with this problem. This option disables the hiding
> -        * behavior, and files are removed immediately in an unlink
> -        * operation (or in a rename operation which overwrites an
> -        * existing file).
> -        *
> -        * It is recommended that you not use the hard_remove
> -        * option. When hard_remove is set, the following libc
> -        * functions fail on unlinked files (returning errno of
> -        * ENOENT): read(2), write(2), fsync(2), close(2), f*xattr(2),
> -        * ftruncate(2), fstat(2), fchmod(2), fchown(2)
> -        */
> -       int hard_remove;
> -
> -       /**
> -        * Honor the st_ino field in the functions getattr() and
> -        * fill_dir(). This value is used to fill in the st_ino field
> -        * in the stat(2), lstat(2), fstat(2) functions and the d_ino
> -        * field in the readdir(2) function. The filesystem does not
> -        * have to guarantee uniqueness, however some applications
> -        * rely on this value being unique for the whole filesystem.
> -        *
> -        * Note that this does *not* affect the inode that libfuse
> -        * and the kernel use internally (also called the "nodeid").
> -        */
> -       int use_ino;
> -
> -       /**
> -        * If use_ino option is not given, still try to fill in the
> -        * d_ino field in readdir(2). If the name was previously
> -        * looked up, and is still in the cache, the inode number
> -        * found there will be used.  Otherwise it will be set to -1.
> -        * If use_ino option is given, this option is ignored.
> -        */
> -       int readdir_ino;
> -
> -       /**
> -        * This option disables the use of page cache (file content cache)
> -        * in the kernel for this filesystem. This has several affects:
> -        *
> -        * 1. Each read(2) or write(2) system call will initiate one
> -        *    or more read or write operations, data will not be
> -        *    cached in the kernel.
> -        *
> -        * 2. The return value of the read() and write() system calls
> -        *    will correspond to the return values of the read and
> -        *    write operations. This is useful for example if the
> -        *    file size is not known in advance (before reading it).
> -        *
> -        * Internally, enabling this option causes fuse to set the
> -        * `direct_io` field of `struct fuse_file_info` - overwriting
> -        * any value that was put there by the file system.
> -        */
> -       int direct_io;
> -
> -       /**
> -        * This option disables flushing the cache of the file
> -        * contents on every open(2).  This should only be enabled on
> -        * filesystems where the file data is never changed
> -        * externally (not through the mounted FUSE filesystem).  Thus
> -        * it is not suitable for network filesystems and other
> -        * intermediate filesystems.
> -        *
> -        * NOTE: if this option is not specified (and neither
> -        * direct_io) data is still cached after the open(2), so a
> -        * read(2) system call will not always initiate a read
> -        * operation.
> -        *
> -        * Internally, enabling this option causes fuse to set the
> -        * `keep_cache` field of `struct fuse_file_info` - overwriting
> -        * any value that was put there by the file system.
> -        */
> -       int kernel_cache;
> -
> -       /**
> -        * This option is an alternative to `kernel_cache`. Instead of
> -        * unconditionally keeping cached data, the cached data is
> -        * invalidated on open(2) if if the modification time or the
> -        * size of the file has changed since it was last opened.
> -        */
> -       int auto_cache;
> -
> -       /**
> -        * The timeout in seconds for which file attributes are cached
> -        * for the purpose of checking if auto_cache should flush the
> -        * file data on open.
> -        */
> -       int ac_attr_timeout_set;
> -       double ac_attr_timeout;
> -
> -       /**
> -        * If this option is given the file-system handlers for the
> -        * following operations will not receive path information:
> -        * read, write, flush, release, fsync, readdir, releasedir,
> -        * fsyncdir, lock, ioctl and poll.
> -        *
> -        * For the truncate, getattr, chmod, chown and utimens
> -        * operations the path will be provided only if the struct
> -        * fuse_file_info argument is NULL.
> -        */
> -       int nullpath_ok;
> -
> -       /**
> -        * The remaining options are used by libfuse internally and
> -        * should not be touched.
> -        */
> -       int show_help;
> -       char *modules;
> -       int debug;
> +    /**
> +     * If `set_gid` is non-zero, the st_gid attribute of each file
> +     * is overwritten with the value of `gid`.
> +     */
> +    int set_gid;
> +    unsigned int gid;
> +
> +    /**
> +     * If `set_uid` is non-zero, the st_uid attribute of each file
> +     * is overwritten with the value of `uid`.
> +     */
> +    int set_uid;
> +    unsigned int uid;
> +
> +    /**
> +     * If `set_mode` is non-zero, the any permissions bits set in
> +     * `umask` are unset in the st_mode attribute of each file.
> +     */
> +    int set_mode;
> +    unsigned int umask;
> +
> +    /**
> +     * The timeout in seconds for which name lookups will be
> +     * cached.
> +     */
> +    double entry_timeout;
> +
> +    /**
> +     * The timeout in seconds for which a negative lookup will be
> +     * cached. This means, that if file did not exist (lookup
> +     * retuned ENOENT), the lookup will only be redone after the
> +     * timeout, and the file/directory will be assumed to not
> +     * exist until then. A value of zero means that negative
> +     * lookups are not cached.
> +     */
> +    double negative_timeout;
> +
> +    /**
> +     * The timeout in seconds for which file/directory attributes
> +     * (as returned by e.g. the `getattr` handler) are cached.
> +     */
> +    double attr_timeout;
> +
> +    /**
> +     * Allow requests to be interrupted
> +     */
> +    int intr;
> +
> +    /**
> +     * Specify which signal number to send to the filesystem when
> +     * a request is interrupted.  The default is hardcoded to
> +     * USR1.
> +     */
> +    int intr_signal;
> +
> +    /**
> +     * Normally, FUSE assigns inodes to paths only for as long as
> +     * the kernel is aware of them. With this option inodes are
> +     * instead remembered for at least this many seconds.  This
> +     * will require more memory, but may be necessary when using
> +     * applications that make use of inode numbers.
> +     *
> +     * A number of -1 means that inodes will be remembered for the
> +     * entire life-time of the file-system process.
> +     */
> +    int remember;
> +
> +    /**
> +     * The default behavior is that if an open file is deleted,
> +     * the file is renamed to a hidden file (.fuse_hiddenXXX), and
> +     * only removed when the file is finally released.  This
> +     * relieves the filesystem implementation of having to deal
> +     * with this problem. This option disables the hiding
> +     * behavior, and files are removed immediately in an unlink
> +     * operation (or in a rename operation which overwrites an
> +     * existing file).
> +     *
> +     * It is recommended that you not use the hard_remove
> +     * option. When hard_remove is set, the following libc
> +     * functions fail on unlinked files (returning errno of
> +     * ENOENT): read(2), write(2), fsync(2), close(2), f*xattr(2),
> +     * ftruncate(2), fstat(2), fchmod(2), fchown(2)
> +     */
> +    int hard_remove;
> +
> +    /**
> +     * Honor the st_ino field in the functions getattr() and
> +     * fill_dir(). This value is used to fill in the st_ino field
> +     * in the stat(2), lstat(2), fstat(2) functions and the d_ino
> +     * field in the readdir(2) function. The filesystem does not
> +     * have to guarantee uniqueness, however some applications
> +     * rely on this value being unique for the whole filesystem.
> +     *
> +     * Note that this does *not* affect the inode that libfuse
> +     * and the kernel use internally (also called the "nodeid").
> +     */
> +    int use_ino;
> +
> +    /**
> +     * If use_ino option is not given, still try to fill in the
> +     * d_ino field in readdir(2). If the name was previously
> +     * looked up, and is still in the cache, the inode number
> +     * found there will be used.  Otherwise it will be set to -1.
> +     * If use_ino option is given, this option is ignored.
> +     */
> +    int readdir_ino;
> +
> +    /**
> +     * This option disables the use of page cache (file content cache)
> +     * in the kernel for this filesystem. This has several affects:
> +     *
> +     * 1. Each read(2) or write(2) system call will initiate one
> +     *    or more read or write operations, data will not be
> +     *    cached in the kernel.
> +     *
> +     * 2. The return value of the read() and write() system calls
> +     *    will correspond to the return values of the read and
> +     *    write operations. This is useful for example if the
> +     *    file size is not known in advance (before reading it).
> +     *
> +     * Internally, enabling this option causes fuse to set the
> +     * `direct_io` field of `struct fuse_file_info` - overwriting
> +     * any value that was put there by the file system.
> +     */
> +    int direct_io;
> +
> +    /**
> +     * This option disables flushing the cache of the file
> +     * contents on every open(2).  This should only be enabled on
> +     * filesystems where the file data is never changed
> +     * externally (not through the mounted FUSE filesystem).  Thus
> +     * it is not suitable for network filesystems and other
> +     * intermediate filesystems.
> +     *
> +     * NOTE: if this option is not specified (and neither
> +     * direct_io) data is still cached after the open(2), so a
> +     * read(2) system call will not always initiate a read
> +     * operation.
> +     *
> +     * Internally, enabling this option causes fuse to set the
> +     * `keep_cache` field of `struct fuse_file_info` - overwriting
> +     * any value that was put there by the file system.
> +     */
> +    int kernel_cache;
> +
> +    /**
> +     * This option is an alternative to `kernel_cache`. Instead of
> +     * unconditionally keeping cached data, the cached data is
> +     * invalidated on open(2) if if the modification time or the
> +     * size of the file has changed since it was last opened.
> +     */
> +    int auto_cache;
> +
> +    /**
> +     * The timeout in seconds for which file attributes are cached
> +     * for the purpose of checking if auto_cache should flush the
> +     * file data on open.
> +     */
> +    int ac_attr_timeout_set;
> +    double ac_attr_timeout;
> +
> +    /**
> +     * If this option is given the file-system handlers for the
> +     * following operations will not receive path information:
> +     * read, write, flush, release, fsync, readdir, releasedir,
> +     * fsyncdir, lock, ioctl and poll.
> +     *
> +     * For the truncate, getattr, chmod, chown and utimens
> +     * operations the path will be provided only if the struct
> +     * fuse_file_info argument is NULL.
> +     */
> +    int nullpath_ok;
> +
> +    /**
> +     * The remaining options are used by libfuse internally and
> +     * should not be touched.
> +     */
> +    int show_help;
> +    char *modules;
> +    int debug;
>  };
>
>
> @@ -293,515 +294,535 @@ struct fuse_config {
>   * Almost all operations take a path which can be of any length.
>   */
>  struct fuse_operations {
> -       /** Get file attributes.
> -        *
> -        * Similar to stat().  The 'st_dev' and 'st_blksize' fields are
> -        * ignored. The 'st_ino' field is ignored except if the 'use_ino'
> -        * mount option is given. In that case it is passed to userspace,
> -        * but libfuse and the kernel will still assign a different
> -        * inode for internal use (called the "nodeid").
> -        *
> -        * `fi` will always be NULL if the file is not currently open, but
> -        * may also be NULL if the file is open.
> -        */
> -       int (*getattr) (const char *, struct stat *, struct fuse_file_info
> *fi);
> -
> -       /** Read the target of a symbolic link
> -        *
> -        * The buffer should be filled with a null terminated string.  The
> -        * buffer size argument includes the space for the terminating
> -        * null character.      If the linkname is too long to fit in the
> -        * buffer, it should be truncated.      The return value should be
> 0
> -        * for success.
> -        */
> -       int (*readlink) (const char *, char *, size_t);
> -
> -       /** Create a file node
> -        *
> -        * This is called for creation of all non-directory, non-symlink
> -        * nodes.  If the filesystem defines a create() method, then for
> -        * regular files that will be called instead.
> -        */
> -       int (*mknod) (const char *, mode_t, dev_t);
> -
> -       /** Create a directory
> -        *
> -        * Note that the mode argument may not have the type specification
> -        * bits set, i.e. S_ISDIR(mode) can be false.  To obtain the
> -        * correct directory type bits use  mode|S_IFDIR
> -        * */
> -       int (*mkdir) (const char *, mode_t);
> -
> -       /** Remove a file */
> -       int (*unlink) (const char *);
> -
> -       /** Remove a directory */
> -       int (*rmdir) (const char *);
> -
> -       /** Create a symbolic link */
> -       int (*symlink) (const char *, const char *);
> -
> -       /** Rename a file
> -        *
> -        * *flags* may be `RENAME_EXCHANGE` or `RENAME_NOREPLACE`. If
> -        * RENAME_NOREPLACE is specified, the filesystem must not
> -        * overwrite *newname* if it exists and return an error
> -        * instead. If `RENAME_EXCHANGE` is specified, the filesystem
> -        * must atomically exchange the two files, i.e. both must
> -        * exist and neither may be deleted.
> -        */
> -       int (*rename) (const char *, const char *, unsigned int flags);
> -
> -       /** Create a hard link to a file */
> -       int (*link) (const char *, const char *);
> -
> -       /** Change the permission bits of a file
> -        *
> -        * `fi` will always be NULL if the file is not currenlty open, but
> -        * may also be NULL if the file is open.
> -        */
> -       int (*chmod) (const char *, mode_t, struct fuse_file_info *fi);
> -
> -       /** Change the owner and group of a file
> -        *
> -        * `fi` will always be NULL if the file is not currenlty open, but
> -        * may also be NULL if the file is open.
> -        *
> -        * Unless FUSE_CAP_HANDLE_KILLPRIV is disabled, this method is
> -        * expected to reset the setuid and setgid bits.
> -        */
> -       int (*chown) (const char *, uid_t, gid_t, struct fuse_file_info
> *fi);
> -
> -       /** Change the size of a file
> -        *
> -        * `fi` will always be NULL if the file is not currenlty open, but
> -        * may also be NULL if the file is open.
> -        *
> -        * Unless FUSE_CAP_HANDLE_KILLPRIV is disabled, this method is
> -        * expected to reset the setuid and setgid bits.
> -        */
> -       int (*truncate) (const char *, off_t, struct fuse_file_info *fi);
> -
> -       /** Open a file
> -        *
> -        * Open flags are available in fi->flags. The following rules
> -        * apply.
> -        *
> -        *  - Creation (O_CREAT, O_EXCL, O_NOCTTY) flags will be
> -        *    filtered out / handled by the kernel.
> -        *
> -        *  - Access modes (O_RDONLY, O_WRONLY, O_RDWR, O_EXEC, O_SEARCH)
> -        *    should be used by the filesystem to check if the operation is
> -        *    permitted.  If the ``-o default_permissions`` mount option is
> -        *    given, this check is already done by the kernel before
> calling
> -        *    open() and may thus be omitted by the filesystem.
> -        *
> -        *  - When writeback caching is enabled, the kernel may send
> -        *    read requests even for files opened with O_WRONLY. The
> -        *    filesystem should be prepared to handle this.
> -        *
> -        *  - When writeback caching is disabled, the filesystem is
> -        *    expected to properly handle the O_APPEND flag and ensure
> -        *    that each write is appending to the end of the file.
> -        *
> -         *  - When writeback caching is enabled, the kernel will
> -        *    handle O_APPEND. However, unless all changes to the file
> -        *    come through the kernel this will not work reliably. The
> -        *    filesystem should thus either ignore the O_APPEND flag
> -        *    (and let the kernel handle it), or return an error
> -        *    (indicating that reliably O_APPEND is not available).
> -        *
> -        * Filesystem may store an arbitrary file handle (pointer,
> -        * index, etc) in fi->fh, and use this in other all other file
> -        * operations (read, write, flush, release, fsync).
> -        *
> -        * Filesystem may also implement stateless file I/O and not store
> -        * anything in fi->fh.
> -        *
> -        * There are also some flags (direct_io, keep_cache) which the
> -        * filesystem may set in fi, to change the way the file is opened.
> -        * See fuse_file_info structure in <fuse_common.h> for more
> details.
> -        *
> -        * If this request is answered with an error code of ENOSYS
> -        * and FUSE_CAP_NO_OPEN_SUPPORT is set in
> -        * `fuse_conn_info.capable`, this is treated as success and
> -        * future calls to open will also succeed without being send
> -        * to the filesystem process.
> -        *
> -        */
> -       int (*open) (const char *, struct fuse_file_info *);
> -
> -       /** Read data from an open file
> -        *
> -        * Read should return exactly the number of bytes requested except
> -        * on EOF or error, otherwise the rest of the data will be
> -        * substituted with zeroes.      An exception to this is when the
> -        * 'direct_io' mount option is specified, in which case the return
> -        * value of the read system call will reflect the return value of
> -        * this operation.
> -        */
> -       int (*read) (const char *, char *, size_t, off_t,
> -                    struct fuse_file_info *);
> -
> -       /** Write data to an open file
> -        *
> -        * Write should return exactly the number of bytes requested
> -        * except on error.      An exception to this is when the
> 'direct_io'
> -        * mount option is specified (see read operation).
> -        *
> -        * Unless FUSE_CAP_HANDLE_KILLPRIV is disabled, this meth

--0000000000000c5368059bb40bfb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Thursday, December 12, 2019, Dr. David Alan Gilbert (git) &lt;<a=
 href=3D"mailto:dgilbert@redhat.com">dgilbert@redhat.com</a>&gt; wrote:<br>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">From: &quot;Dr. David Alan Gilbert&quot; &lt=
;<a href=3D"mailto:dgilbert@redhat.com" target=3D"_blank">dgilbert@redhat.c=
om</a>&gt;<br>
<br>
Mostly using a set like:<br>
<br>
indent -nut -i 4 -nlp -br -cs -ce --no-space-after-function-<wbr>call-names=
 file<br>
clang-format -style=3Dfile -i -- file<br>
clang-tidy -fix-errors -checks=3Dreadability-braces-<wbr>around-statements =
file<br>
clang-format -style=3Dfile -i -- file<br>
<br>
With manual cleanups.<br>
<br>
The .clang-format used is below.<br>
<br>
Signed-off-by: Dr. David Alan Gilbert &lt;<a href=3D"mailto:dgilbert@redhat=
.com" target=3D"_blank">dgilbert@redhat.com</a>&gt;<br>
<br>
Language:=C2=A0 =C2=A0 =C2=A0 =C2=A0 Cpp<br>
AlignAfterOpenBracket: Align<br>
AlignConsecutiveAssignments: false # although we like it, it creates churn<=
br>
AlignConsecutiveDeclarations: false<br>
AlignEscapedNewlinesLeft: true<br>
AlignOperands:=C2=A0 =C2=A0true<br>
AlignTrailingComments: false # churn<br>
AllowAllParametersOfDeclaratio<wbr>nOnNextLine: true<br>
AllowShortBlocksOnASingleLine: false<br>
AllowShortCaseLabelsOnASingleL<wbr>ine: false<br>
AllowShortFunctionsOnASingleLi<wbr>ne: None<br>
AllowShortIfStatementsOnASingl<wbr>eLine: false<br>
AllowShortLoopsOnASingleLine: false<br>
AlwaysBreakAfterReturnType: None # AlwaysBreakAfterDefinitionRetu<wbr>rnTyp=
e is taken into account<br>
AlwaysBreakBeforeMultilineStri<wbr>ngs: false<br>
BinPackArguments: true<br>
BinPackParameters: true<br>
BraceWrapping:<br>
=C2=A0 AfterControlStatement: false<br>
=C2=A0 AfterEnum:=C2=A0 =C2=A0 =C2=A0 =C2=A0false<br>
=C2=A0 AfterFunction:=C2=A0 =C2=A0true<br>
=C2=A0 AfterStruct:=C2=A0 =C2=A0 =C2=A0false<br>
=C2=A0 AfterUnion:=C2=A0 =C2=A0 =C2=A0 false<br>
=C2=A0 BeforeElse:=C2=A0 =C2=A0 =C2=A0 false<br>
=C2=A0 IndentBraces:=C2=A0 =C2=A0 false<br>
BreakBeforeBinaryOperators: None<br>
BreakBeforeBraces: Custom<br>
BreakBeforeTernaryOperators: false<br>
BreakStringLiterals: true<br>
ColumnLimit:=C2=A0 =C2=A0 =C2=A080<br>
ContinuationIndentWidth: 4<br>
Cpp11BracedListStyle: false<br>
DerivePointerAlignment: false<br>
DisableFormat:=C2=A0 =C2=A0false<br>
ForEachMacros:=C2=A0 =C2=A0[<br>
=C2=A0 &#39;CPU_FOREACH&#39;,<br>
=C2=A0 &#39;CPU_FOREACH_REVERSE&#39;,<br>
=C2=A0 &#39;CPU_FOREACH_SAFE&#39;,<br>
=C2=A0 &#39;IOMMU_NOTIFIER_FOREACH&#39;,<br>
=C2=A0 &#39;QLIST_FOREACH&#39;,<br>
=C2=A0 &#39;QLIST_FOREACH_ENTRY&#39;,<br>
=C2=A0 &#39;QLIST_FOREACH_RCU&#39;,<br>
=C2=A0 &#39;QLIST_FOREACH_SAFE&#39;,<br>
=C2=A0 &#39;QLIST_FOREACH_SAFE_RCU&#39;,<br>
=C2=A0 &#39;QSIMPLEQ_FOREACH&#39;,<br>
=C2=A0 &#39;QSIMPLEQ_FOREACH_SAFE&#39;,<br>
=C2=A0 &#39;QSLIST_FOREACH&#39;,<br>
=C2=A0 &#39;QSLIST_FOREACH_SAFE&#39;,<br>
=C2=A0 &#39;QTAILQ_FOREACH&#39;,<br>
=C2=A0 &#39;QTAILQ_FOREACH_REVERSE&#39;,<br>
=C2=A0 &#39;QTAILQ_FOREACH_SAFE&#39;,<br>
=C2=A0 &#39;QTAILQ_RAW_FOREACH&#39;,<br>
=C2=A0 &#39;RAMBLOCK_FOREACH&#39;<br>
]<br>
IncludeCategories:<br>
=C2=A0 - Regex:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;^&quot;qemu/os=
dep.h&#39;<br>
=C2=A0 =C2=A0 Priority:=C2=A0 =C2=A0 =C2=A0 =C2=A0 -3<br>
=C2=A0 - Regex:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;^&quot;(block|=
chardev|crypto|<wbr>disas|exec|fpu|hw|io|<wbr>libdecnumber|migration|<wbr>m=
onitor|net|qapi|qemu|qom|<wbr>standard-headers|sysemu|ui)/&#39;<br>
=C2=A0 =C2=A0 Priority:=C2=A0 =C2=A0 =C2=A0 =C2=A0 -2<br>
=C2=A0 - Regex:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;^&quot;(elf.h|=
qemu-common.h|glib-<wbr>compat.h|qemu-io.h|trace-tcg.<wbr>h)&#39;<br>
=C2=A0 =C2=A0 Priority:=C2=A0 =C2=A0 =C2=A0 =C2=A0 -1<br>
=C2=A0 - Regex:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;.*&#39;<br>
=C2=A0 =C2=A0 Priority:=C2=A0 =C2=A0 =C2=A0 =C2=A0 1<br>
IncludeIsMainRegex: &#39;$&#39;<br>
IndentCaseLabels: false<br>
IndentWidth:=C2=A0 =C2=A0 =C2=A04<br>
IndentWrappedFunctionNames: false<br>
KeepEmptyLinesAtTheStartOfBloc<wbr>ks: false<br>
MacroBlockBegin: &#39;.*_BEGIN$&#39; # only PREC_BEGIN ?<br>
MacroBlockEnd:=C2=A0 =C2=A0&#39;.*_END$&#39;<br>
MaxEmptyLinesToKeep: 2<br>
PointerAlignment: Right<br>
ReflowComments:=C2=A0 true<br>
SortIncludes:=C2=A0 =C2=A0 true<br>
SpaceAfterCStyleCast: false<br>
SpaceBeforeAssignmentOperators<wbr>: true<br>
SpaceBeforeParens: ControlStatements<br>
SpaceInEmptyParentheses: false<br>
SpacesBeforeTrailingComments: 1<br>
SpacesInContainerLiterals: true<br>
SpacesInParentheses: false<br>
SpacesInSquareBrackets: false<br>
Standard:=C2=A0 =C2=A0 =C2=A0 =C2=A0 Auto<br>
UseTab:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Never<br>
...<br>
---<br>
=C2=A0tools/virtiofsd/buffer.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 550 ++--<br>
=C2=A0tools/virtiofsd/fuse.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 1572 +++++------<br>
=C2=A0tools/virtiofsd/fuse_common.<wbr>h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 764 ++---<br>
=C2=A0tools/virtiofsd/fuse_i.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 127 +-<br>
=C2=A0tools/virtiofsd/fuse_log.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A038 +-<br>
=C2=A0tools/virtiofsd/fuse_log.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A032 +-<br>
=C2=A0tools/virtiofsd/fuse_loop_mt.<wbr>c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A066 +-<br>
=C2=A0tools/virtiofsd/fuse_<wbr>lowlevel.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 3678=
 +++++++++++++------------<br>
=C2=A0tools/virtiofsd/fuse_<wbr>lowlevel.h=C2=A0 =C2=A0 =C2=A0 =C2=A0| 2401=
 ++++++++--------<br>
=C2=A0tools/virtiofsd/fuse_misc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A030 +-<br>
=C2=A0tools/virtiofsd/fuse_opt.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 659 ++---<br>
=C2=A0tools/virtiofsd/fuse_opt.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A079 +-<br>
=C2=A0tools/virtiofsd/fuse_signals.<wbr>c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 118 +-<br>
=C2=A0tools/virtiofsd/helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 517 ++--<br>
=C2=A0tools/virtiofsd/passthrough_<wbr>helpers.h |=C2=A0 =C2=A033 +-<br>
=C2=A0tools/virtiofsd/passthrough_<wbr>ll.c=C2=A0 =C2=A0 =C2=A0 | 2063 ++++=
+++-------<br>
=C2=A016 files changed, 6530 insertions(+), 6197 deletions(-)<br>
<br></blockquote><div><br></div><div><span style=3D"color:rgb(34,34,34);fon=
t-size:14px;line-height:22.1200008392334px">Reviewed by: Aleksandar Markovi=
c &lt;</span><a href=3D"mailto:amarkovic@wavecomp.com" target=3D"_blank" st=
yle=3D"font-size:14px;line-height:22.1200008392334px">amarkovic@wavecomp.co=
m</a><span style=3D"color:rgb(34,34,34);font-size:14px;line-height:22.12000=
08392334px">&gt;</span><br></div><div>=C2=A0</div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex">
diff --git a/tools/virtiofsd/buffer.c b/tools/virtiofsd/buffer.c<br>
index 5ab9b87455..38521f5889 100644<br>
--- a/tools/virtiofsd/buffer.c<br>
+++ b/tools/virtiofsd/buffer.c<br>
@@ -1,321 +1,343 @@<br>
=C2=A0/*<br>
-=C2=A0 FUSE: Filesystem in Userspace<br>
-=C2=A0 Copyright (C) 2010=C2=A0 Miklos Szeredi &lt;<a href=3D"mailto:miklo=
s@szeredi.hu" target=3D"_blank">miklos@szeredi.hu</a>&gt;<br>
-<br>
-=C2=A0 Functions for dealing with `struct fuse_buf` and `struct<br>
-=C2=A0 fuse_bufvec`.<br>
-<br>
-=C2=A0 This program can be distributed under the terms of the GNU LGPLv2.<=
br>
-=C2=A0 See the file COPYING.LIB<br>
-*/<br>
+ * FUSE: Filesystem in Userspace<br>
+ * Copyright (C) 2010=C2=A0 Miklos Szeredi &lt;<a href=3D"mailto:miklos@sz=
eredi.hu" target=3D"_blank">miklos@szeredi.hu</a>&gt;<br>
+ *<br>
+ * Functions for dealing with `struct fuse_buf` and `struct<br>
+ * fuse_bufvec`.<br>
+ *<br>
+ * This program can be distributed under the terms of the GNU LGPLv2.<br>
+ * See the file COPYING.LIB<br>
+ */<br>
<br>
=C2=A0#define _GNU_SOURCE<br>
<br>
=C2=A0#include &quot;config.h&quot;<br>
=C2=A0#include &quot;fuse_i.h&quot;<br>
=C2=A0#include &quot;fuse_lowlevel.h&quot;<br>
+#include &lt;assert.h&gt;<br>
+#include &lt;errno.h&gt;<br>
=C2=A0#include &lt;string.h&gt;<br>
=C2=A0#include &lt;unistd.h&gt;<br>
-#include &lt;errno.h&gt;<br>
-#include &lt;assert.h&gt;<br>
<br>
=C2=A0size_t fuse_buf_size(const struct fuse_bufvec *bufv)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0size_t i;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0size_t size =3D 0;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; bufv-&gt;count; i++) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (bufv-&gt;buf[i]=
.size =3D=3D SIZE_MAX)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0size =3D SIZE_MAX;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0size +=3D bufv-&gt;buf[i].size;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return size;<br>
+=C2=A0 =C2=A0 size_t i;<br>
+=C2=A0 =C2=A0 size_t size =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; bufv-&gt;count; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (bufv-&gt;buf[i].size =3D=3D SIZE_MAX) {<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size =3D SIZE_MAX;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size +=3D bufv-&gt;buf[i].size;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return size;<br>
=C2=A0}<br>
<br>
=C2=A0static size_t min_size(size_t s1, size_t s2)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return s1 &lt; s2 ? s1 : s2;<br>
+=C2=A0 =C2=A0 return s1 &lt; s2 ? s1 : s2;<br>
=C2=A0}<br>
<br>
=C2=A0static ssize_t fuse_buf_write(const struct fuse_buf *dst, size_t dst_=
off,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct fuse_buf *src, size_t src_off,<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t len)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct fuse_buf *src, size_t src_off,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t len)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0ssize_t res =3D 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0size_t copied =3D 0;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0while (len) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dst-&gt;flags &=
amp; FUSE_BUF_FD_SEEK) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0res =3D pwrite(dst-&gt;fd, (char *)src-&gt;mem + src_off, len,<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dst-&gt;pos + dst_off)=
;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0res =3D write(dst-&gt;fd, (char *)src-&gt;mem + src_off, len);<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (res =3D=3D -1) =
{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (!copied)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -errno;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (res =3D=3D 0)<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0copied +=3D res;<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(dst-&gt;flags=
 &amp; FUSE_BUF_FD_RETRY))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0src_off +=3D res;<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dst_off +=3D res;<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0len -=3D res;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return copied;<br>
+=C2=A0 =C2=A0 ssize_t res =3D 0;<br>
+=C2=A0 =C2=A0 size_t copied =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 while (len) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dst-&gt;flags &amp; FUSE_BUF_FD_SEEK) {<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D pwrite(dst-&gt;fd, (char=
 *)src-&gt;mem + src_off, len,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0dst-&gt;pos + dst_off);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D write(dst-&gt;fd, (char =
*)src-&gt;mem + src_off, len);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (res =3D=3D -1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!copied) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -errno;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (res =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 copied +=3D res;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(dst-&gt;flags &amp; FUSE_BUF_FD_RETRY)) =
{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 src_off +=3D res;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dst_off +=3D res;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 len -=3D res;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return copied;<br>
=C2=A0}<br>
<br>
=C2=A0static ssize_t fuse_buf_read(const struct fuse_buf *dst, size_t dst_o=
ff,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 const struct fuse_buf *src, size_t src_off,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 size_t len)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct fuse_buf *src, size_t src_off,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t len)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0ssize_t res =3D 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0size_t copied =3D 0;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0while (len) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (src-&gt;flags &=
amp; FUSE_BUF_FD_SEEK) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0res =3D pread(src-&gt;fd, (char *)dst-&gt;mem + dst_off, len,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 src-&gt;pos + src_off)=
;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0res =3D read(src-&gt;fd, (char *)dst-&gt;mem + dst_off, len);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (res =3D=3D -1) =
{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (!copied)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -errno;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (res =3D=3D 0)<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0copied +=3D res;<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(src-&gt;flags=
 &amp; FUSE_BUF_FD_RETRY))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dst_off +=3D res;<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0src_off +=3D res;<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0len -=3D res;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return copied;<br>
+=C2=A0 =C2=A0 ssize_t res =3D 0;<br>
+=C2=A0 =C2=A0 size_t copied =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 while (len) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (src-&gt;flags &amp; FUSE_BUF_FD_SEEK) {<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D pread(src-&gt;fd, (char =
*)dst-&gt;mem + dst_off, len,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 src-&gt;pos + src_off);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D read(src-&gt;fd, (char *=
)dst-&gt;mem + dst_off, len);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (res =3D=3D -1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!copied) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -errno;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (res =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 copied +=3D res;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(src-&gt;flags &amp; FUSE_BUF_FD_RETRY)) =
{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dst_off +=3D res;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 src_off +=3D res;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 len -=3D res;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return copied;<br>
=C2=A0}<br>
<br>
=C2=A0static ssize_t fuse_buf_fd_to_fd(const struct fuse_buf *dst, size_t d=
st_off,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct fuse_buf *src, size_t s=
rc_off,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t len)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct fuse_buf *src, si=
ze_t src_off,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t len)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0char buf[4096];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct fuse_buf tmp =3D {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.size =3D sizeof(bu=
f),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.flags =3D 0,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0ssize_t res;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0size_t copied =3D 0;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp.mem =3D buf;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0while (len) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t this_len =3D=
 min_size(tmp.size, len);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t read_len;<br=
>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0res =3D fuse_buf_re=
ad(&amp;tmp, 0, src, src_off, this_len);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (res &lt; 0) {<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (!copied)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return res;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (res =3D=3D 0)<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0read_len =3D res;<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0res =3D fuse_buf_wr=
ite(dst, dst_off, &amp;tmp, 0, read_len);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (res &lt; 0) {<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (!copied)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return res;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (res =3D=3D 0)<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0copied +=3D res;<br=
>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (res &lt; this_l=
en)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dst_off +=3D res;<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0src_off +=3D res;<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0len -=3D res;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return copied;<br>
+=C2=A0 =C2=A0 char buf[4096];<br>
+=C2=A0 =C2=A0 struct fuse_buf tmp =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .size =3D sizeof(buf),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .flags =3D 0,<br>
+=C2=A0 =C2=A0 };<br>
+=C2=A0 =C2=A0 ssize_t res;<br>
+=C2=A0 =C2=A0 size_t copied =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 tmp.mem =3D buf;<br>
+<br>
+=C2=A0 =C2=A0 while (len) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t this_len =3D min_size(tmp.size, len);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t read_len;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D fuse_buf_read(&amp;tmp, 0, src, src_of=
f, this_len);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (res &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!copied) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return res;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (res =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 read_len =3D res;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D fuse_buf_write(dst, dst_off, &amp;tmp,=
 0, read_len);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (res &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!copied) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return res;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (res =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 copied +=3D res;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (res &lt; this_len) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dst_off +=3D res;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 src_off +=3D res;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 len -=3D res;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return copied;<br>
=C2=A0}<br>
<br>
=C2=A0#ifdef HAVE_SPLICE<br>
=C2=A0static ssize_t fuse_buf_splice(const struct fuse_buf *dst, size_t dst=
_off,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct fuse_buf *src, size_t src_off,=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t len, enum fuse_buf_copy_flags flags)=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct fuse_buf *src, size_t sr=
c_off,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t len, enum fuse_buf_copy_flags =
flags)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int splice_flags =3D 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0off_t *srcpos =3D NULL;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0off_t *dstpos =3D NULL;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0off_t srcpos_val;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0off_t dstpos_val;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0ssize_t res;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0size_t copied =3D 0;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (flags &amp; FUSE_BUF_SPLICE_MOVE)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0splice_flags |=3D S=
PLICE_F_MOVE;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (flags &amp; FUSE_BUF_SPLICE_NONBLOCK)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0splice_flags |=3D S=
PLICE_F_NONBLOCK;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (src-&gt;flags &amp; FUSE_BUF_FD_SEEK) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0srcpos_val =3D src-=
&gt;pos + src_off;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0srcpos =3D &amp;src=
pos_val;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (dst-&gt;flags &amp; FUSE_BUF_FD_SEEK) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dstpos_val =3D dst-=
&gt;pos + dst_off;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dstpos =3D &amp;dst=
pos_val;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0while (len) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0res =3D splice(src-=
&gt;fd, srcpos, dst-&gt;fd, dstpos, len,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 splice_flags);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (res =3D=3D -1) =
{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (copied)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (errno !=3D EINVAL || (flags &amp; FUSE_BUF_FORCE_SPLICE))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -errno;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* Maybe splice is not supported for this combination */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return fuse_buf_fd_to_fd(dst, dst_off, src, src_off,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 len);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (res =3D=3D 0)<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0copied +=3D res;<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(src-&gt;flags=
 &amp; FUSE_BUF_FD_RETRY) &amp;&amp;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!(dst=
-&gt;flags &amp; FUSE_BUF_FD_RETRY)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0len -=3D res;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return copied;<br>
+=C2=A0 =C2=A0 int splice_flags =3D 0;<br>
+=C2=A0 =C2=A0 off_t *srcpos =3D NULL;<br>
+=C2=A0 =C2=A0 off_t *dstpos =3D NULL;<br>
+=C2=A0 =C2=A0 off_t srcpos_val;<br>
+=C2=A0 =C2=A0 off_t dstpos_val;<br>
+=C2=A0 =C2=A0 ssize_t res;<br>
+=C2=A0 =C2=A0 size_t copied =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 if (flags &amp; FUSE_BUF_SPLICE_MOVE) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 splice_flags |=3D SPLICE_F_MOVE;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (flags &amp; FUSE_BUF_SPLICE_NONBLOCK) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 splice_flags |=3D SPLICE_F_NONBLOCK;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (src-&gt;flags &amp; FUSE_BUF_FD_SEEK) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 srcpos_val =3D src-&gt;pos + src_off;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 srcpos =3D &amp;srcpos_val;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (dst-&gt;flags &amp; FUSE_BUF_FD_SEEK) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dstpos_val =3D dst-&gt;pos + dst_off;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dstpos =3D &amp;dstpos_val;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 while (len) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D splice(src-&gt;fd, srcpos, dst-&gt;fd,=
 dstpos, len, splice_flags);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (res =3D=3D -1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (copied) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (errno !=3D EINVAL || (flags =
&amp; FUSE_BUF_FORCE_SPLICE)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -errno;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Maybe splice is not supported=
 for this combination */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return fuse_buf_fd_to_fd(dst, ds=
t_off, src, src_off, len);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (res =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 copied +=3D res;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(src-&gt;flags &amp; FUSE_BUF_FD_RETRY) &=
amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !(dst-&gt;flags &amp; FUSE_BUF_F=
D_RETRY)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 len -=3D res;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return copied;<br>
=C2=A0}<br>
=C2=A0#else<br>
=C2=A0static ssize_t fuse_buf_splice(const struct fuse_buf *dst, size_t dst=
_off,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct fuse_buf *src, size_t src_off,=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t len, enum fuse_buf_copy_flags flags)=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct fuse_buf *src, size_t sr=
c_off,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t len, enum fuse_buf_copy_flags =
flags)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0(void) flags;<br>
+=C2=A0 =C2=A0 (void)flags;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return fuse_buf_fd_to_fd(dst, dst_off, src, src=
_off, len);<br>
+=C2=A0 =C2=A0 return fuse_buf_fd_to_fd(dst, dst_off, src, src_off, len);<b=
r>
=C2=A0}<br>
=C2=A0#endif<br>
<br>
<br>
=C2=A0static ssize_t fuse_buf_copy_one(const struct fuse_buf *dst, size_t d=
st_off,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct fuse_buf *src, size_t s=
rc_off,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t len, enum fuse_buf_copy_flags=
 flags)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct fuse_buf *src, si=
ze_t src_off,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t len, enum fuse_buf_copy=
_flags flags)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int src_is_fd =3D src-&gt;flags &amp; FUSE_BUF_=
IS_FD;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int dst_is_fd =3D dst-&gt;flags &amp; FUSE_BUF_=
IS_FD;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!src_is_fd &amp;&amp; !dst_is_fd) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char *dstmem =3D (c=
har *)dst-&gt;mem + dst_off;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char *srcmem =3D (c=
har *)src-&gt;mem + src_off;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dstmem !=3D src=
mem) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (dstmem + len &lt;=3D srcmem || srcmem + len &lt;=3D dstmem)<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy(dstmem, srcmem, len);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memmove(dstmem, srcmem, len);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return len;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (!src_is_fd) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return fuse_buf_wri=
te(dst, dst_off, src, src_off, len);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (!dst_is_fd) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return fuse_buf_rea=
d(dst, dst_off, src, src_off, len);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (flags &amp; FUSE_BUF_NO_SPLICE) {<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return fuse_buf_fd_=
to_fd(dst, dst_off, src, src_off, len);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return fuse_buf_spl=
ice(dst, dst_off, src, src_off, len, flags);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 int src_is_fd =3D src-&gt;flags &amp; FUSE_BUF_IS_FD;<br>
+=C2=A0 =C2=A0 int dst_is_fd =3D dst-&gt;flags &amp; FUSE_BUF_IS_FD;<br>
+<br>
+=C2=A0 =C2=A0 if (!src_is_fd &amp;&amp; !dst_is_fd) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 char *dstmem =3D (char *)dst-&gt;mem + dst_off=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 char *srcmem =3D (char *)src-&gt;mem + src_off=
;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dstmem !=3D srcmem) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dstmem + len &lt;=3D srcmem =
|| srcmem + len &lt;=3D dstmem) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(dstmem, src=
mem, len);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memmove(dstmem, sr=
cmem, len);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return len;<br>
+=C2=A0 =C2=A0 } else if (!src_is_fd) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return fuse_buf_write(dst, dst_off, src, src_o=
ff, len);<br>
+=C2=A0 =C2=A0 } else if (!dst_is_fd) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return fuse_buf_read(dst, dst_off, src, src_of=
f, len);<br>
+=C2=A0 =C2=A0 } else if (flags &amp; FUSE_BUF_NO_SPLICE) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return fuse_buf_fd_to_fd(dst, dst_off, src, sr=
c_off, len);<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return fuse_buf_splice(dst, dst_off, src, src_=
off, len, flags);<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0}<br>
<br>
=C2=A0static const struct fuse_buf *fuse_bufvec_current(struct fuse_bufvec =
*bufv)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (bufv-&gt;idx &lt; bufv-&gt;count)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return &amp;bufv-&g=
t;buf[bufv-&gt;idx];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;<br>
+=C2=A0 =C2=A0 if (bufv-&gt;idx &lt; bufv-&gt;count) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return &amp;bufv-&gt;buf[bufv-&gt;idx];<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0}<br>
<br>
=C2=A0static int fuse_bufvec_advance(struct fuse_bufvec *bufv, size_t len)<=
br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0const struct fuse_buf *buf =3D fuse_bufvec_curr=
ent(bufv);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0bufv-&gt;off +=3D len;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0assert(bufv-&gt;off &lt;=3D buf-&gt;size);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (bufv-&gt;off =3D=3D buf-&gt;size) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0assert(bufv-&gt;idx=
 &lt; bufv-&gt;count);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bufv-&gt;idx++;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (bufv-&gt;idx =
=3D=3D bufv-&gt;count)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bufv-&gt;off =3D 0;=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return 1;<br>
+=C2=A0 =C2=A0 const struct fuse_buf *buf =3D fuse_bufvec_current(bufv);<br=
>
+<br>
+=C2=A0 =C2=A0 bufv-&gt;off +=3D len;<br>
+=C2=A0 =C2=A0 assert(bufv-&gt;off &lt;=3D buf-&gt;size);<br>
+=C2=A0 =C2=A0 if (bufv-&gt;off =3D=3D buf-&gt;size) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(bufv-&gt;idx &lt; bufv-&gt;count);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bufv-&gt;idx++;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (bufv-&gt;idx =3D=3D bufv-&gt;count) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bufv-&gt;off =3D 0;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return 1;<br>
=C2=A0}<br>
<br>
=C2=A0ssize_t fuse_buf_copy(struct fuse_bufvec *dstv, struct fuse_bufvec *s=
rcv,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0enum fuse_buf_copy_flags flags)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 enum fuse_buf_copy_flags flags)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0size_t copied =3D 0;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (dstv =3D=3D srcv)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return fuse_buf_siz=
e(dstv);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0for (;;) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct fuse_b=
uf *src =3D fuse_bufvec_current(srcv);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct fuse_b=
uf *dst =3D fuse_bufvec_current(dstv);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t src_len;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t dst_len;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t len;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ssize_t res;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (src =3D=3D NULL=
 || dst =3D=3D NULL)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0src_len =3D src-&gt=
;size - srcv-&gt;off;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dst_len =3D dst-&gt=
;size - dstv-&gt;off;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0len =3D min_size(sr=
c_len, dst_len);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0res =3D fuse_buf_co=
py_one(dst, dstv-&gt;off, src, srcv-&gt;off, len, flags);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (res &lt; 0) {<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (!copied)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return res;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0copied +=3D res;<br=
>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!fuse_bufvec_ad=
vance(srcv, res) ||<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!fuse=
_bufvec_advance(dstv, res))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (res &lt; len)<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return copied;<br>
+=C2=A0 =C2=A0 size_t copied =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 if (dstv =3D=3D srcv) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return fuse_buf_size(dstv);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 for (;;) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct fuse_buf *src =3D fuse_bufvec_cur=
rent(srcv);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct fuse_buf *dst =3D fuse_bufvec_cur=
rent(dstv);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t src_len;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t dst_len;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t len;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ssize_t res;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (src =3D=3D NULL || dst =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 src_len =3D src-&gt;size - srcv-&gt;off;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dst_len =3D dst-&gt;size - dstv-&gt;off;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D min_size(src_len, dst_len);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D fuse_buf_copy_one(dst, dstv-&gt;off, s=
rc, srcv-&gt;off, len, flags);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (res &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!copied) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return res;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 copied +=3D res;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!fuse_bufvec_advance(srcv, res) ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !fuse_bufvec_advance(dstv, res))=
 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (res &lt; len) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return copied;<br>
=C2=A0}<br>
diff --git a/tools/virtiofsd/fuse.h b/tools/virtiofsd/fuse.h<br>
index 6c16a0041d..945ebc7a0d 100644<br>
--- a/tools/virtiofsd/fuse.h<br>
+++ b/tools/virtiofsd/fuse.h<br>
@@ -1,15 +1,15 @@<br>
=C2=A0/*<br>
-=C2=A0 FUSE: Filesystem in Userspace<br>
-=C2=A0 Copyright (C) 2001-2007=C2=A0 Miklos Szeredi &lt;<a href=3D"mailto:=
miklos@szeredi.hu" target=3D"_blank">miklos@szeredi.hu</a>&gt;<br>
-<br>
-=C2=A0 This program can be distributed under the terms of the GNU LGPLv2.<=
br>
-=C2=A0 See the file COPYING.LIB.<br>
-*/<br>
+ * FUSE: Filesystem in Userspace<br>
+ * Copyright (C) 2001-2007=C2=A0 Miklos Szeredi &lt;<a href=3D"mailto:mikl=
os@szeredi.hu" target=3D"_blank">miklos@szeredi.hu</a>&gt;<br>
+ *<br>
+ * This program can be distributed under the terms of the GNU LGPLv2.<br>
+ * See the file COPYING.LIB.<br>
+ */<br>
<br>
=C2=A0#ifndef FUSE_H_<br>
=C2=A0#define FUSE_H_<br>
<br>
-/** @file<br>
+/*<br>
=C2=A0 *<br>
=C2=A0 * This file defines the library interface of FUSE<br>
=C2=A0 *<br>
@@ -19,15 +19,15 @@<br>
=C2=A0#include &quot;fuse_common.h&quot;<br>
<br>
=C2=A0#include &lt;fcntl.h&gt;<br>
-#include &lt;time.h&gt;<br>
-#include &lt;sys/types.h&gt;<br>
=C2=A0#include &lt;sys/stat.h&gt;<br>
=C2=A0#include &lt;sys/statvfs.h&gt;<br>
+#include &lt;sys/types.h&gt;<br>
=C2=A0#include &lt;sys/uio.h&gt;<br>
+#include &lt;time.h&gt;<br>
<br>
-/* ------------------------------<wbr>----------------------------- *<br>
- * Basic FUSE API=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*<br>
- * ------------------------------<wbr>----------------------------- */<br>
+/*<br>
+ * Basic FUSE API<br>
+ */<br>
<br>
=C2=A0/** Handle for a FUSE filesystem */<br>
=C2=A0struct fuse;<br>
@@ -36,38 +36,39 @@ struct fuse;<br>
=C2=A0 * Readdir flags, passed to -&gt;readdir()<br>
=C2=A0 */<br>
=C2=A0enum fuse_readdir_flags {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/**<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * &quot;Plus&quot; mode.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * The kernel wants to prefill the inode cache =
during readdir.=C2=A0 The<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * filesystem may honour this by filling in the=
 attributes and setting<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * FUSE_FILL_DIR_FLAGS for the filler function.=
=C2=A0 The filesystem may also<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * just ignore this flag completely.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0FUSE_READDIR_PLUS =3D (1 &lt;&lt; 0),<br>
+=C2=A0 =C2=A0 /**<br>
+=C2=A0 =C2=A0 =C2=A0* &quot;Plus&quot; mode.<br>
+=C2=A0 =C2=A0 =C2=A0*<br>
+=C2=A0 =C2=A0 =C2=A0* The kernel wants to prefill the inode cache during r=
eaddir.=C2=A0 The<br>
+=C2=A0 =C2=A0 =C2=A0* filesystem may honour this by filling in the attribu=
tes and setting<br>
+=C2=A0 =C2=A0 =C2=A0* FUSE_FILL_DIR_FLAGS for the filler function.=C2=A0 T=
he filesystem may also<br>
+=C2=A0 =C2=A0 =C2=A0* just ignore this flag completely.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 FUSE_READDIR_PLUS =3D (1 &lt;&lt; 0),<br>
=C2=A0};<br>
<br>
=C2=A0enum fuse_fill_dir_flags {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/**<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * &quot;Plus&quot; mode: all file attributes a=
re valid<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * The attributes are used by the kernel to pre=
fill the inode cache<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * during a readdir.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * It is okay to set FUSE_FILL_DIR_PLUS if FUSE=
_READDIR_PLUS is not set<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * and vice versa.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0FUSE_FILL_DIR_PLUS =3D (1 &lt;&lt; 1),<br>
+=C2=A0 =C2=A0 /**<br>
+=C2=A0 =C2=A0 =C2=A0* &quot;Plus&quot; mode: all file attributes are valid=
<br>
+=C2=A0 =C2=A0 =C2=A0*<br>
+=C2=A0 =C2=A0 =C2=A0* The attributes are used by the kernel to prefill the=
 inode cache<br>
+=C2=A0 =C2=A0 =C2=A0* during a readdir.<br>
+=C2=A0 =C2=A0 =C2=A0*<br>
+=C2=A0 =C2=A0 =C2=A0* It is okay to set FUSE_FILL_DIR_PLUS if FUSE_READDIR=
_PLUS is not set<br>
+=C2=A0 =C2=A0 =C2=A0* and vice versa.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 FUSE_FILL_DIR_PLUS =3D (1 &lt;&lt; 1),<br>
=C2=A0};<br>
<br>
-/** Function to add an entry in a readdir() operation<br>
+/**<br>
+ * Function to add an entry in a readdir() operation<br>
=C2=A0 *<br>
=C2=A0 * The *off* parameter can be any non-zero value that enables the<br>
=C2=A0 * filesystem to identify the current point in the directory<br>
=C2=A0 * stream. It does not need to be the actual physical position. A<br>
=C2=A0 * value of zero is reserved to indicate that seeking in directories<=
br>
=C2=A0 * is not supported.<br>
- * <br>
+ *<br>
=C2=A0 * @param buf the buffer passed to the readdir() operation<br>
=C2=A0 * @param name the file name of the directory entry<br>
=C2=A0 * @param stat file attributes, can be NULL<br>
@@ -75,9 +76,9 @@ enum fuse_fill_dir_flags {<br>
=C2=A0 * @param flags fill flags<br>
=C2=A0 * @return 1 if buffer is full, zero otherwise<br>
=C2=A0 */<br>
-typedef int (*fuse_fill_dir_t) (void *buf, const char *name,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct stat *stbuf, off_t off,<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enum fuse_fill_dir_flags flags);<br>
+typedef int (*fuse_fill_dir_t)(void *buf, const char *name,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct stat *stbuf, off_t off,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enum fuse_fill_dir_flags flags);<br>
=C2=A0/**<br>
=C2=A0 * Configuration of the high-level API<br>
=C2=A0 *<br>
@@ -87,186 +88,186 @@ typedef int (*fuse_fill_dir_t) (void *buf, const char=
 *name,<br>
=C2=A0 * file system implementation.<br>
=C2=A0 */<br>
=C2=A0struct fuse_config {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/**<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * If `set_gid` is non-zero, the st_gid attribu=
te of each file<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * is overwritten with the value of `gid`.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int set_gid;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int gid;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/**<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * If `set_uid` is non-zero, the st_uid attribu=
te of each file<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * is overwritten with the value of `uid`.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int set_uid;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int uid;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/**<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * If `set_mode` is non-zero, the any permissio=
ns bits set in<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * `umask` are unset in the st_mode attribute o=
f each file.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int set_mode;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int umask;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/**<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * The timeout in seconds for which name lookup=
s will be<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * cached.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0double entry_timeout;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/**<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * The timeout in seconds for which a negative =
lookup will be<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * cached. This means, that if file did not exi=
st (lookup<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * retuned ENOENT), the lookup will only be red=
one after the<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * timeout, and the file/directory will be assu=
med to not<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * exist until then. A value of zero means that=
 negative<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * lookups are not cached.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0double negative_timeout;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/**<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * The timeout in seconds for which file/direct=
ory attributes<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * (as returned by e.g. the `getattr` handler) =
are cached.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0double attr_timeout;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/**<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Allow requests to be interrupted<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int intr;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/**<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Specify which signal number to send to the f=
ilesystem when<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * a request is interrupted.=C2=A0 The default =
is hardcoded to<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * USR1.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int intr_signal;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/**<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Normally, FUSE assigns inodes to paths only =
for as long as<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * the kernel is aware of them. With this optio=
n inodes are<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * instead remembered for at least this many se=
conds.=C2=A0 This<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * will require more memory, but may be necessa=
ry when using<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * applications that make use of inode numbers.=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * A number of -1 means that inodes will be rem=
embered for the<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * entire life-time of the file-system process.=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int remember;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/**<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * The default behavior is that if an open file=
 is deleted,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * the file is renamed to a hidden file (.fuse_=
hiddenXXX), and<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * only removed when the file is finally releas=
ed.=C2=A0 This<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * relieves the filesystem implementation of ha=
ving to deal<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * with this problem. This option disables the =
hiding<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * behavior, and files are removed immediately =
in an unlink<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * operation (or in a rename operation which ov=
erwrites an<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * existing file).<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * It is recommended that you not use the hard_=
remove<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * option. When hard_remove is set, the followi=
ng libc<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * functions fail on unlinked files (returning =
errno of<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * ENOENT): read(2), write(2), fsync(2), close(=
2), f*xattr(2),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * ftruncate(2), fstat(2), fchmod(2), fchown(2)=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int hard_remove;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/**<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Honor the st_ino field in the functions geta=
ttr() and<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * fill_dir(). This value is used to fill in th=
e st_ino field<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * in the stat(2), lstat(2), fstat(2) functions=
 and the d_ino<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * field in the readdir(2) function. The filesy=
stem does not<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * have to guarantee uniqueness, however some a=
pplications<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * rely on this value being unique for the whol=
e filesystem.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Note that this does *not* affect the inode t=
hat libfuse <br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * and the kernel use internally (also called t=
he &quot;nodeid&quot;).<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int use_ino;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/**<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * If use_ino option is not given, still try to=
 fill in the<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * d_ino field in readdir(2). If the name was p=
reviously<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * looked up, and is still in the cache, the in=
ode number<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * found there will be used.=C2=A0 Otherwise it=
 will be set to -1.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * If use_ino option is given, this option is i=
gnored.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int readdir_ino;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/**<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * This option disables the use of page cache (=
file content cache)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * in the kernel for this filesystem. This has =
several affects:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * 1. Each read(2) or write(2) system call will=
 initiate one<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0 or more read or write operation=
s, data will not be<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0 cached in the kernel.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * 2. The return value of the read() and write(=
) system calls<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0 will correspond to the return v=
alues of the read and<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0 write operations. This is usefu=
l for example if the<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0 file size is not known in advan=
ce (before reading it).<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Internally, enabling this option causes fuse=
 to set the<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * `direct_io` field of `struct fuse_file_info`=
 - overwriting<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * any value that was put there by the file sys=
tem.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int direct_io;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/**<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * This option disables flushing the cache of t=
he file<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * contents on every open(2).=C2=A0 This should=
 only be enabled on<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * filesystems where the file data is never cha=
nged<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * externally (not through the mounted FUSE fil=
esystem).=C2=A0 Thus<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * it is not suitable for network filesystems a=
nd other<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * intermediate filesystems.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * NOTE: if this option is not specified (and n=
either<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * direct_io) data is still cached after the op=
en(2), so a<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * read(2) system call will not always initiate=
 a read<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * operation.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Internally, enabling this option causes fuse=
 to set the<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * `keep_cache` field of `struct fuse_file_info=
` - overwriting<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * any value that was put there by the file sys=
tem.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int kernel_cache;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/**<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * This option is an alternative to `kernel_cac=
he`. Instead of<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * unconditionally keeping cached data, the cac=
hed data is<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * invalidated on open(2) if if the modificatio=
n time or the<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * size of the file has changed since it was la=
st opened.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int auto_cache;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/**<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * The timeout in seconds for which file attrib=
utes are cached<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * for the purpose of checking if auto_cache sh=
ould flush the<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * file data on open.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int ac_attr_timeout_set;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0double ac_attr_timeout;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/**<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * If this option is given the file-system hand=
lers for the<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * following operations will not receive path i=
nformation:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * read, write, flush, release, fsync, readdir,=
 releasedir,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * fsyncdir, lock, ioctl and poll.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * For the truncate, getattr, chmod, chown and =
utimens<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * operations the path will be provided only if=
 the struct<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * fuse_file_info argument is NULL.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int nullpath_ok;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/**<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * The remaining options are used by libfuse in=
ternally and<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * should not be touched.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int show_help;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0char *modules;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int debug;<br>
+=C2=A0 =C2=A0 /**<br>
+=C2=A0 =C2=A0 =C2=A0* If `set_gid` is non-zero, the st_gid attribute of ea=
ch file<br>
+=C2=A0 =C2=A0 =C2=A0* is overwritten with the value of `gid`.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 int set_gid;<br>
+=C2=A0 =C2=A0 unsigned int gid;<br>
+<br>
+=C2=A0 =C2=A0 /**<br>
+=C2=A0 =C2=A0 =C2=A0* If `set_uid` is non-zero, the st_uid attribute of ea=
ch file<br>
+=C2=A0 =C2=A0 =C2=A0* is overwritten with the value of `uid`.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 int set_uid;<br>
+=C2=A0 =C2=A0 unsigned int uid;<br>
+<br>
+=C2=A0 =C2=A0 /**<br>
+=C2=A0 =C2=A0 =C2=A0* If `set_mode` is non-zero, the any permissions bits =
set in<br>
+=C2=A0 =C2=A0 =C2=A0* `umask` are unset in the st_mode attribute of each f=
ile.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 int set_mode;<br>
+=C2=A0 =C2=A0 unsigned int umask;<br>
+<br>
+=C2=A0 =C2=A0 /**<br>
+=C2=A0 =C2=A0 =C2=A0* The timeout in seconds for which name lookups will b=
e<br>
+=C2=A0 =C2=A0 =C2=A0* cached.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 double entry_timeout;<br>
+<br>
+=C2=A0 =C2=A0 /**<br>
+=C2=A0 =C2=A0 =C2=A0* The timeout in seconds for which a negative lookup w=
ill be<br>
+=C2=A0 =C2=A0 =C2=A0* cached. This means, that if file did not exist (look=
up<br>
+=C2=A0 =C2=A0 =C2=A0* retuned ENOENT), the lookup will only be redone afte=
r the<br>
+=C2=A0 =C2=A0 =C2=A0* timeout, and the file/directory will be assumed to n=
ot<br>
+=C2=A0 =C2=A0 =C2=A0* exist until then. A value of zero means that negativ=
e<br>
+=C2=A0 =C2=A0 =C2=A0* lookups are not cached.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 double negative_timeout;<br>
+<br>
+=C2=A0 =C2=A0 /**<br>
+=C2=A0 =C2=A0 =C2=A0* The timeout in seconds for which file/directory attr=
ibutes<br>
+=C2=A0 =C2=A0 =C2=A0* (as returned by e.g. the `getattr` handler) are cach=
ed.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 double attr_timeout;<br>
+<br>
+=C2=A0 =C2=A0 /**<br>
+=C2=A0 =C2=A0 =C2=A0* Allow requests to be interrupted<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 int intr;<br>
+<br>
+=C2=A0 =C2=A0 /**<br>
+=C2=A0 =C2=A0 =C2=A0* Specify which signal number to send to the filesyste=
m when<br>
+=C2=A0 =C2=A0 =C2=A0* a request is interrupted.=C2=A0 The default is hardc=
oded to<br>
+=C2=A0 =C2=A0 =C2=A0* USR1.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 int intr_signal;<br>
+<br>
+=C2=A0 =C2=A0 /**<br>
+=C2=A0 =C2=A0 =C2=A0* Normally, FUSE assigns inodes to paths only for as l=
ong as<br>
+=C2=A0 =C2=A0 =C2=A0* the kernel is aware of them. With this option inodes=
 are<br>
+=C2=A0 =C2=A0 =C2=A0* instead remembered for at least this many seconds.=
=C2=A0 This<br>
+=C2=A0 =C2=A0 =C2=A0* will require more memory, but may be necessary when =
using<br>
+=C2=A0 =C2=A0 =C2=A0* applications that make use of inode numbers.<br>
+=C2=A0 =C2=A0 =C2=A0*<br>
+=C2=A0 =C2=A0 =C2=A0* A number of -1 means that inodes will be remembered =
for the<br>
+=C2=A0 =C2=A0 =C2=A0* entire life-time of the file-system process.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 int remember;<br>
+<br>
+=C2=A0 =C2=A0 /**<br>
+=C2=A0 =C2=A0 =C2=A0* The default behavior is that if an open file is dele=
ted,<br>
+=C2=A0 =C2=A0 =C2=A0* the file is renamed to a hidden file (.fuse_hiddenXX=
X), and<br>
+=C2=A0 =C2=A0 =C2=A0* only removed when the file is finally released.=C2=
=A0 This<br>
+=C2=A0 =C2=A0 =C2=A0* relieves the filesystem implementation of having to =
deal<br>
+=C2=A0 =C2=A0 =C2=A0* with this problem. This option disables the hiding<b=
r>
+=C2=A0 =C2=A0 =C2=A0* behavior, and files are removed immediately in an un=
link<br>
+=C2=A0 =C2=A0 =C2=A0* operation (or in a rename operation which overwrites=
 an<br>
+=C2=A0 =C2=A0 =C2=A0* existing file).<br>
+=C2=A0 =C2=A0 =C2=A0*<br>
+=C2=A0 =C2=A0 =C2=A0* It is recommended that you not use the hard_remove<b=
r>
+=C2=A0 =C2=A0 =C2=A0* option. When hard_remove is set, the following libc<=
br>
+=C2=A0 =C2=A0 =C2=A0* functions fail on unlinked files (returning errno of=
<br>
+=C2=A0 =C2=A0 =C2=A0* ENOENT): read(2), write(2), fsync(2), close(2), f*xa=
ttr(2),<br>
+=C2=A0 =C2=A0 =C2=A0* ftruncate(2), fstat(2), fchmod(2), fchown(2)<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 int hard_remove;<br>
+<br>
+=C2=A0 =C2=A0 /**<br>
+=C2=A0 =C2=A0 =C2=A0* Honor the st_ino field in the functions getattr() an=
d<br>
+=C2=A0 =C2=A0 =C2=A0* fill_dir(). This value is used to fill in the st_ino=
 field<br>
+=C2=A0 =C2=A0 =C2=A0* in the stat(2), lstat(2), fstat(2) functions and the=
 d_ino<br>
+=C2=A0 =C2=A0 =C2=A0* field in the readdir(2) function. The filesystem doe=
s not<br>
+=C2=A0 =C2=A0 =C2=A0* have to guarantee uniqueness, however some applicati=
ons<br>
+=C2=A0 =C2=A0 =C2=A0* rely on this value being unique for the whole filesy=
stem.<br>
+=C2=A0 =C2=A0 =C2=A0*<br>
+=C2=A0 =C2=A0 =C2=A0* Note that this does *not* affect the inode that libf=
use<br>
+=C2=A0 =C2=A0 =C2=A0* and the kernel use internally (also called the &quot=
;nodeid&quot;).<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 int use_ino;<br>
+<br>
+=C2=A0 =C2=A0 /**<br>
+=C2=A0 =C2=A0 =C2=A0* If use_ino option is not given, still try to fill in=
 the<br>
+=C2=A0 =C2=A0 =C2=A0* d_ino field in readdir(2). If the name was previousl=
y<br>
+=C2=A0 =C2=A0 =C2=A0* looked up, and is still in the cache, the inode numb=
er<br>
+=C2=A0 =C2=A0 =C2=A0* found there will be used.=C2=A0 Otherwise it will be=
 set to -1.<br>
+=C2=A0 =C2=A0 =C2=A0* If use_ino option is given, this option is ignored.<=
br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 int readdir_ino;<br>
+<br>
+=C2=A0 =C2=A0 /**<br>
+=C2=A0 =C2=A0 =C2=A0* This option disables the use of page cache (file con=
tent cache)<br>
+=C2=A0 =C2=A0 =C2=A0* in the kernel for this filesystem. This has several =
affects:<br>
+=C2=A0 =C2=A0 =C2=A0*<br>
+=C2=A0 =C2=A0 =C2=A0* 1. Each read(2) or write(2) system call will initiat=
e one<br>
+=C2=A0 =C2=A0 =C2=A0*=C2=A0 =C2=A0 or more read or write operations, data =
will not be<br>
+=C2=A0 =C2=A0 =C2=A0*=C2=A0 =C2=A0 cached in the kernel.<br>
+=C2=A0 =C2=A0 =C2=A0*<br>
+=C2=A0 =C2=A0 =C2=A0* 2. The return value of the read() and write() system=
 calls<br>
+=C2=A0 =C2=A0 =C2=A0*=C2=A0 =C2=A0 will correspond to the return values of=
 the read and<br>
+=C2=A0 =C2=A0 =C2=A0*=C2=A0 =C2=A0 write operations. This is useful for ex=
ample if the<br>
+=C2=A0 =C2=A0 =C2=A0*=C2=A0 =C2=A0 file size is not known in advance (befo=
re reading it).<br>
+=C2=A0 =C2=A0 =C2=A0*<br>
+=C2=A0 =C2=A0 =C2=A0* Internally, enabling this option causes fuse to set =
the<br>
+=C2=A0 =C2=A0 =C2=A0* `direct_io` field of `struct fuse_file_info` - overw=
riting<br>
+=C2=A0 =C2=A0 =C2=A0* any value that was put there by the file system.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 int direct_io;<br>
+<br>
+=C2=A0 =C2=A0 /**<br>
+=C2=A0 =C2=A0 =C2=A0* This option disables flushing the cache of the file<=
br>
+=C2=A0 =C2=A0 =C2=A0* contents on every open(2).=C2=A0 This should only be=
 enabled on<br>
+=C2=A0 =C2=A0 =C2=A0* filesystems where the file data is never changed<br>
+=C2=A0 =C2=A0 =C2=A0* externally (not through the mounted FUSE filesystem)=
.=C2=A0 Thus<br>
+=C2=A0 =C2=A0 =C2=A0* it is not suitable for network filesystems and other=
<br>
+=C2=A0 =C2=A0 =C2=A0* intermediate filesystems.<br>
+=C2=A0 =C2=A0 =C2=A0*<br>
+=C2=A0 =C2=A0 =C2=A0* NOTE: if this option is not specified (and neither<b=
r>
+=C2=A0 =C2=A0 =C2=A0* direct_io) data is still cached after the open(2), s=
o a<br>
+=C2=A0 =C2=A0 =C2=A0* read(2) system call will not always initiate a read<=
br>
+=C2=A0 =C2=A0 =C2=A0* operation.<br>
+=C2=A0 =C2=A0 =C2=A0*<br>
+=C2=A0 =C2=A0 =C2=A0* Internally, enabling this option causes fuse to set =
the<br>
+=C2=A0 =C2=A0 =C2=A0* `keep_cache` field of `struct fuse_file_info` - over=
writing<br>
+=C2=A0 =C2=A0 =C2=A0* any value that was put there by the file system.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 int kernel_cache;<br>
+<br>
+=C2=A0 =C2=A0 /**<br>
+=C2=A0 =C2=A0 =C2=A0* This option is an alternative to `kernel_cache`. Ins=
tead of<br>
+=C2=A0 =C2=A0 =C2=A0* unconditionally keeping cached data, the cached data=
 is<br>
+=C2=A0 =C2=A0 =C2=A0* invalidated on open(2) if if the modification time o=
r the<br>
+=C2=A0 =C2=A0 =C2=A0* size of the file has changed since it was last opene=
d.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 int auto_cache;<br>
+<br>
+=C2=A0 =C2=A0 /**<br>
+=C2=A0 =C2=A0 =C2=A0* The timeout in seconds for which file attributes are=
 cached<br>
+=C2=A0 =C2=A0 =C2=A0* for the purpose of checking if auto_cache should flu=
sh the<br>
+=C2=A0 =C2=A0 =C2=A0* file data on open.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 int ac_attr_timeout_set;<br>
+=C2=A0 =C2=A0 double ac_attr_timeout;<br>
+<br>
+=C2=A0 =C2=A0 /**<br>
+=C2=A0 =C2=A0 =C2=A0* If this option is given the file-system handlers for=
 the<br>
+=C2=A0 =C2=A0 =C2=A0* following operations will not receive path informati=
on:<br>
+=C2=A0 =C2=A0 =C2=A0* read, write, flush, release, fsync, readdir, release=
dir,<br>
+=C2=A0 =C2=A0 =C2=A0* fsyncdir, lock, ioctl and poll.<br>
+=C2=A0 =C2=A0 =C2=A0*<br>
+=C2=A0 =C2=A0 =C2=A0* For the truncate, getattr, chmod, chown and utimens<=
br>
+=C2=A0 =C2=A0 =C2=A0* operations the path will be provided only if the str=
uct<br>
+=C2=A0 =C2=A0 =C2=A0* fuse_file_info argument is NULL.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 int nullpath_ok;<br>
+<br>
+=C2=A0 =C2=A0 /**<br>
+=C2=A0 =C2=A0 =C2=A0* The remaining options are used by libfuse internally=
 and<br>
+=C2=A0 =C2=A0 =C2=A0* should not be touched.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 int show_help;<br>
+=C2=A0 =C2=A0 char *modules;<br>
+=C2=A0 =C2=A0 int debug;<br>
=C2=A0};<br>
<br>
<br>
@@ -293,515 +294,535 @@ struct fuse_config {<br>
=C2=A0 * Almost all operations take a path which can be of any length.<br>
=C2=A0 */<br>
=C2=A0struct fuse_operations {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/** Get file attributes.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Similar to stat().=C2=A0 The &#39;st_dev&#39=
; and &#39;st_blksize&#39; fields are<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * ignored. The &#39;st_ino&#39; field is ignor=
ed except if the &#39;use_ino&#39;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * mount option is given. In that case it is pa=
ssed to userspace,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * but libfuse and the kernel will still assign=
 a different<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * inode for internal use (called the &quot;nod=
eid&quot;).<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * `fi` will always be NULL if the file is not =
currently open, but<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * may also be NULL if the file is open.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int (*getattr) (const char *, struct stat *, st=
ruct fuse_file_info *fi);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/** Read the target of a symbolic link<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * The buffer should be filled with a null term=
inated string.=C2=A0 The<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * buffer size argument includes the space for =
the terminating<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * null character.=C2=A0 =C2=A0 =C2=A0 If the l=
inkname is too long to fit in the<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * buffer, it should be truncated.=C2=A0 =C2=A0=
 =C2=A0 The return value should be 0<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * for success.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int (*readlink) (const char *, char *, size_t);=
<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/** Create a file node<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * This is called for creation of all non-direc=
tory, non-symlink<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * nodes.=C2=A0 If the filesystem defines a cre=
ate() method, then for<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * regular files that will be called instead.<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int (*mknod) (const char *, mode_t, dev_t);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/** Create a directory<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Note that the mode argument may not have the=
 type specification<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * bits set, i.e. S_ISDIR(mode) can be false.=
=C2=A0 To obtain the<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * correct directory type bits use=C2=A0 mode|S=
_IFDIR<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int (*mkdir) (const char *, mode_t);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/** Remove a file */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int (*unlink) (const char *);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/** Remove a directory */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int (*rmdir) (const char *);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/** Create a symbolic link */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int (*symlink) (const char *, const char *);<br=
>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/** Rename a file<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * *flags* may be `RENAME_EXCHANGE` or `RENAME_=
NOREPLACE`. If<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * RENAME_NOREPLACE is specified, the filesyste=
m must not<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * overwrite *newname* if it exists and return =
an error<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * instead. If `RENAME_EXCHANGE` is specified, =
the filesystem<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * must atomically exchange the two files, i.e.=
 both must<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * exist and neither may be deleted.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int (*rename) (const char *, const char *, unsi=
gned int flags);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/** Create a hard link to a file */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int (*link) (const char *, const char *);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/** Change the permission bits of a file<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * `fi` will always be NULL if the file is not =
currenlty open, but<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * may also be NULL if the file is open.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int (*chmod) (const char *, mode_t, struct fuse=
_file_info *fi);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/** Change the owner and group of a file<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * `fi` will always be NULL if the file is not =
currenlty open, but<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * may also be NULL if the file is open.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Unless FUSE_CAP_HANDLE_KILLPRIV is disabled,=
 this method is<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * expected to reset the setuid and setgid bits=
.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int (*chown) (const char *, uid_t, gid_t, struc=
t fuse_file_info *fi);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/** Change the size of a file<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * `fi` will always be NULL if the file is not =
currenlty open, but<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * may also be NULL if the file is open.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Unless FUSE_CAP_HANDLE_KILLPRIV is disabled,=
 this method is<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * expected to reset the setuid and setgid bits=
.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int (*truncate) (const char *, off_t, struct fu=
se_file_info *fi);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/** Open a file<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Open flags are available in fi-&gt;flags. Th=
e following rules<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * apply.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *=C2=A0 - Creation (O_CREAT, O_EXCL, O_NOCTTY)=
 flags will be<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0 filtered out / handled by the k=
ernel.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *=C2=A0 - Access modes (O_RDONLY, O_WRONLY, O_=
RDWR, O_EXEC, O_SEARCH)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0 should be used by the filesyste=
m to check if the operation is<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0 permitted.=C2=A0 If the ``-o de=
fault_permissions`` mount option is<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0 given, this check is already do=
ne by the kernel before calling<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0 open() and may thus be omitted =
by the filesystem.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *=C2=A0 - When writeback caching is enabled, t=
he kernel may send<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0 read requests even for files op=
ened with O_WRONLY. The<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0 filesystem should be prepared t=
o handle this.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *=C2=A0 - When writeback caching is disabled, =
the filesystem is<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0 expected to properly handle the=
 O_APPEND flag and ensure<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0 that each write is appending to=
 the end of the file.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * <br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*=C2=A0 - When writeback caching is enab=
led, the kernel will<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0 handle O_APPEND. However, unles=
s all changes to the file<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0 come through the kernel this wi=
ll not work reliably. The<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0 filesystem should thus either i=
gnore the O_APPEND flag<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0 (and let the kernel handle it),=
 or return an error<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0 (indicating that reliably O_APP=
END is not available).<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Filesystem may store an arbitrary file handl=
e (pointer,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * index, etc) in fi-&gt;fh, and use this in ot=
her all other file<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * operations (read, write, flush, release, fsy=
nc).<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Filesystem may also implement stateless file=
 I/O and not store<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * anything in fi-&gt;fh.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * There are also some flags (direct_io, keep_c=
ache) which the<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * filesystem may set in fi, to change the way =
the file is opened.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * See fuse_file_info structure in &lt;fuse_com=
mon.h&gt; for more details.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * If this request is answered with an error co=
de of ENOSYS<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * and FUSE_CAP_NO_OPEN_SUPPORT is set in<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * `fuse_conn_info.capable`, this is treated as=
 success and<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * future calls to open will also succeed witho=
ut being send<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * to the filesystem process.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int (*open) (const char *, struct fuse_file_inf=
o *);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/** Read data from an open file<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Read should return exactly the number of byt=
es requested except<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * on EOF or error, otherwise the rest of the d=
ata will be<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * substituted with zeroes.=C2=A0 =C2=A0 =C2=A0=
 An exception to this is when the<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * &#39;direct_io&#39; mount option is specifie=
d, in which case the return<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * value of the read system call will reflect t=
he return value of<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * this operation.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int (*read) (const char *, char *, size_t, off_=
t,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stru=
ct fuse_file_info *);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/** Write data to an open file<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Write should return exactly the number of by=
tes requested<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * except on error.=C2=A0 =C2=A0 =C2=A0 An exce=
ption to this is when the &#39;direct_io&#39;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * mount option is specified (see read operatio=
n).<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Unless FUSE_CAP_HANDLE_KILLPRIV is disabled,=
 this meth</blockquote>

--0000000000000c5368059bb40bfb--

