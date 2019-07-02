Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F047BC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 20:29:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB0E821897
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 20:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="djHIpE72"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB0E821897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiPPQ-0000xn-1u
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 16:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51435)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hiOE4-0005fT-33
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 15:14:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hiOE1-0000Cz-C6
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 15:13:59 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:38221)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hiOE0-0008E5-Ss
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 15:13:57 -0400
Received: by mail-oi1-x22f.google.com with SMTP id v186so14032818oie.5
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 12:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=749g3Yz/ff/RX1SC1TO7Y79WkiWuFSlSpBF9PHhm5fg=;
 b=djHIpE726Fk72B/FUWgb5P+Tq5DfJSeu6xGHTRZc9WdVNl/nreK1yQgq34uQOZiTpu
 MLwzGnZs/t6K8j8xohF8ywJp1FOxQKU7F2K5JBi+MOYHbHUz2k+6YZNSEuf0BiOSkA7t
 RHlkxTR4VDilwuMiRsrJLMEYDkQwgXt9x8lA7AOTj+wW21+7P5NdkEVu0oKQvz5AaYaB
 ak7Gyfho3QDZ8jfmjrMzJGIH4fVPZTZC3I1K00Mm2gjjbXJEonGd4CRmj+d1lM5eOi3e
 BCPgVlzYFzau+H99HVKbWA7Ao5+R5d+eNkZKpDz6gKTdoDb4JmNJGwHlNQ8NGHAiI5ub
 rD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=749g3Yz/ff/RX1SC1TO7Y79WkiWuFSlSpBF9PHhm5fg=;
 b=D7xnTHjuXmr3YZB5oRbp/6AMRSyNTK2Ph5JtSd5DyUeUhpC7MZxqjZ2/imQeWvR/0U
 lix4pFKdyd3wHYJsyxyArIIiqfrzCGsX75Wr3gKl97hGChnXQ5OMOx7UIFF11bbu29U5
 NrNGG9yl4WC3Z9rlDQGdYGKTUwXcpp6iEIMPU+lNz0TziVPkPzmgSJVNNiEmo4GFA0Le
 YsAJrJM9hTtqIFzcN5kJi3KCeBuuc7HWzyb7RcExw/HRUiKNnVPqknUB/8jpJpx1TnmS
 AZTAQR3fpO+xq4A0wKq0HmXHaKisfg7NTROhHwQLoWhoUeOHIQmKrJ6cFuybygD6SS/F
 ERBw==
X-Gm-Message-State: APjAAAWLhFIeiA6BnmozFIt1zD4VYlbVwoT8HYWe6ub1Cxf6dUu0LjyV
 bMQQtttuo8GPnvz7eChBweg0G8K8vVAs+IqlgVYxvJgYf4c=
X-Google-Smtp-Source: APXvYqy1ovY4sni/Lb7bCCwUrkwy6JSC6C0QvSHY0c/1btm85tOMC+qGtYtzwbgDUMwqI+WaRGDIpW7guEJ1fminsG4=
X-Received: by 2002:a05:6808:8c2:: with SMTP id
 k2mr3906617oij.98.1562094801801; 
 Tue, 02 Jul 2019 12:13:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190624144740.5338-1-mreitz@redhat.com>
 <20190624144740.5338-7-mreitz@redhat.com>
In-Reply-To: <20190624144740.5338-7-mreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Jul 2019 20:13:10 +0100
Message-ID: <CAFEAcA_jnQj5sUjOiPY5_jaLaWEYVTqKre1TiTVJVBXTaC1vaA@mail.gmail.com>
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22f
Subject: Re: [Qemu-devel] [PULL v2 6/8] vmdk: Add read-only support for
 seSparse snapshots
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
Cc: Kevin Wolf <kwolf@redhat.com>, Sam Eiderman <shmuel.eiderman@oracle.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 24 Jun 2019 at 15:48, Max Reitz <mreitz@redhat.com> wrote:
>
> From: Sam Eiderman <shmuel.eiderman@oracle.com>
>
> Until ESXi 6.5 VMware used the vmfsSparse format for snapshots (VMDK3 in
> QEMU).
>
> This format was lacking in the following:
>
>     * Grain directory (L1) and grain table (L2) entries were 32-bit,
>       allowing access to only 2TB (slightly less) of data.
>     * The grain size (default) was 512 bytes - leading to data
>       fragmentation and many grain tables.
>     * For space reclamation purposes, it was necessary to find all the
>       grains which are not pointed to by any grain table - so a reverse
>       mapping of "offset of grain in vmdk" to "grain table" must be
>       constructed - which takes large amounts of CPU/RAM.
>

Hi; this change has confused Coverity a bit (CID 1402786):

> @@ -481,7 +529,7 @@ static int vmdk_init_tables(BlockDriverState *bs, VmdkExtent *extent,
>      int i;
>
>      /* read the L1 table */
> -    l1_size = extent->l1_size * sizeof(uint32_t);
> +    l1_size = extent->l1_size * extent->entry_size;
>      extent->l1_table = g_try_malloc(l1_size);
>      if (l1_size && extent->l1_table == NULL) {
>          return -ENOMEM;

>      }
>
>      if (extent->l1_backup_table_offset) {
> +        assert(!extent->sesparse);
>          extent->l1_backup_table = g_try_malloc(l1_size);
>          if (l1_size && extent->l1_backup_table == NULL) {
>              ret = -ENOMEM;

Here we allocate extent->l1_backup_table via g_try_malloc(),
and our "ENOMEM" guard checks l1_size. However later on we do:

        for (i = 0; i < extent->l1_size; i++) {
            le32_to_cpus(&extent->l1_backup_table[i]);
        }

which is a dereference of l1_backup_table whose guard
is looking at extent->l1_size. Previously Coverity could
(probably) see this was OK because we were setting
   l1_size = extent->l1_size * sizeof(uint32_t)
so l1_size is 0 if and only if extent->l1_size is zero.
But now there's another possibility because we have changed
the initialization to
   l1_size = extent->l1_size * extent->entry_size;
so if extent->entry_size is zero then l1_size could be 0
(getting us past the ENOMEM check) but extent->l1_size
non-zero (causing us to try to dereference a NULL l1_backup_table
pointer).

This can't in fact happen because if extent->l1_size is
non-zero we'll assert that extent->entry_size is
either 8 or 4, but the logic has become sufficiently
convoluted that it's no longer clear to Coverity that this
is an impossible case. I could mark this as a false positive,
but maybe there's a way of rephrasing this code that makes
the logic a little clearer to both humans and robots?

Supplementary:

(1) this code:
    for (i = 0; i < extent->l1_size; i++) {
        if (extent->entry_size == sizeof(uint64_t)) {
            le64_to_cpus((uint64_t *)extent->l1_table + i);
        } else {
            assert(extent->entry_size == sizeof(uint32_t));
            le32_to_cpus((uint32_t *)extent->l1_table + i);
        }
    }
only asserts that extent->entry_size is sane if the l1_size
is non-zero, and it does it inside the loop so we assert
once for each entry. Hiding the assert like this might be
part of what's confusing Coverity.

(2) we allocate the l1_backup_table() with a size of l1_size,
which will differ depending on extent->entry_size; but then
we do the endianness conversion on it using
        for (i = 0; i < extent->l1_size; i++) {
            le32_to_cpus(&extent->l1_backup_table[i]);
        }
which assumes always 32-bit entries. Is that correct?

thanks
-- PMM

