Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3758C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 09:53:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C013920673
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 09:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I/r04Mb5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C013920673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i16Gc-0004Z8-1t
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 05:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56127)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i16Fw-00041p-H2
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 05:53:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i16Fv-0000Ej-1e
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 05:53:16 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:34737)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i16Fu-0000E4-ML
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 05:53:14 -0400
Received: by mail-ot1-x341.google.com with SMTP id c7so8264032otp.1
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 02:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1N/MPYspOOwWSZow8EBbvkmSf9GgVqTR3hgCBI3DMKA=;
 b=I/r04Mb5ofrYOcMdmH41B6qEu6pvPW51t+t8WUQm3f1sOHxxbp/DYcsNxYN9wXOtQD
 94DBkKhArUW52eGAjh3ujJ0hTD6yD98yYnzNKKAbi/hkcy8cguPnoQU84fordZi9rWyv
 oiBx0m9h1Zy09UOu+bBFfpme/PMt+zD4incADF0gAZckq0ptn7YgXzzMSKlb0FACG3i3
 ++3I/lDWHP2j80/sFvYs9k436knbFfnDh/bf6wTWRFavI7rn+PR/EOOlvftACro6rkL8
 f7XYQ0EOodugEXcjIHF5dfdlEeIwYU2914+yEg/y9uRpWJ8AW4o07z+QTW5Z1Rw6I54G
 /q6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1N/MPYspOOwWSZow8EBbvkmSf9GgVqTR3hgCBI3DMKA=;
 b=rMex0mzJbx6xcrR/iJUuVcGpkDbNknKpWI7HOAFGLuGn64o8GjeVKMH/pEixxECEud
 AHTgb5WxKnGkcTECxRYdE1WY9vIkayHGcC8VJZu1EAWkx27Q5o1kDox0RttSwFwP1uKJ
 fBEr647dvrwnXiqey+R1xPykvEVsUf0S6BlcAruTSZndIM0OrhPYK/fFwBvXF2nTKw6U
 HTNEAwrhBS+sped5HA8GI+PJXc2rKQHdeRH3yGyQWlbrkscNUxUfbY3QLwFYKK128Qet
 iUaNyp86c0beQ9zFmAqpLeezOrtxErHeulPZTpw5aEPA6Y0wdk/4RycXS7fh/Nj5BFBa
 dDyQ==
X-Gm-Message-State: APjAAAXJqgdeKZUZfqyq3rRrNnKuOOHa5c4yGKlFBUJ9FRV2nJt6BzpN
 KWYVl+qpf5BRh7LzspvEDZ8j9ZLZdBbC6g3ZI3KZ1Q==
X-Google-Smtp-Source: APXvYqx6HlMbAPnG8+ced8/1vjCnHiY9FsuLCuVUnV5D7sut+aOlDwbnBWtnzF7LL7wXoSzv5LmBaxHthzDwy97fDS4=
X-Received: by 2002:a9d:6a94:: with SMTP id l20mr3128107otq.221.1566553993590; 
 Fri, 23 Aug 2019 02:53:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190823084203.29734-1-thuth@redhat.com>
 <CAFEAcA9bqzoT01E3tQREeAb1U3UJU0t8rOeX3E=pjmCM3J+O0g@mail.gmail.com>
 <3ccbd1c5-b60a-eb0b-6870-f6320bcbbbae@redhat.com>
In-Reply-To: <3ccbd1c5-b60a-eb0b-6870-f6320bcbbbae@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Aug 2019 10:53:02 +0100
Message-ID: <CAFEAcA_F9oscKx9zM=8=E55Ju7B72EQq2hLk1gptQ81zBEO_Ug@mail.gmail.com>
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH] tests/check-block: Skip iotests when
 sanitizers are enabled
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
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 23 Aug 2019 at 10:35, Thomas Huth <thuth@redhat.com> wrote:
>
> On 8/23/19 11:04 AM, Peter Maydell wrote:
> > On Fri, 23 Aug 2019 at 09:43, Thomas Huth <thuth@redhat.com> wrote:
> >>
> >> The sanitizers (especially the address sanitizer from Clang) are
> >> sometimes printing out warnings or false positives - this spoils
> >> the output of the iotests, causing some of the tests to fail.
> >> Thus let's skip the automatic iotests during "make check" when the
> >> user configured QEMU with --enable-sanitizers.
> >
> > Do you have a log of what the sanitizer is saying?
>
> https://patchew.org/logs/QEMU/testing.asan/?type=project

(I get a "Not Found" error for that URL.)

> Example:
>
> +Indirect leak of 4120 byte(s) in 1 object(s) allocated from:
> +    #0 0x562a2ffc3c4e in calloc
> (TEST_DIR/build/x86_64-softmmu/qemu-system-x86_64+0x1a16c4e)
> +    #1 0x7fca6acf3cf0 in g_malloc0 (/lib64/libglib-2.0.so.0+0x55cf0)
> +    #2 0x562a3200c3d0 in bdrv_refresh_filename TEST_DIR/src/block.c:6416:12
> +    #3 0x562a3200b8f7 in bdrv_refresh_filename TEST_DIR/src/block.c:6388:9
> +    #4 0x562a3200b8f7 in bdrv_refresh_filename TEST_DIR/src/block.c:6388:9
> +    #5 0x562a31ffa461 in bdrv_backing_attach TEST_DIR/src/block.c:1064:5
> +    #6 0x562a320212c6 in bdrv_replace_child_noperm
> TEST_DIR/src/block.c:2283:13
> +    #7 0x562a3201ed50 in bdrv_replace_node TEST_DIR/src/block.c:4210:9
> +    #8 0x562a32021649 in bdrv_append TEST_DIR/src/block.c:4250:5
> +    #9 0x562a3234e573 in commit_start TEST_DIR/src/block/commit.c:307:5
> +    #10 0x562a30cc6cce in qmp_block_commit TEST_DIR/src/blockdev.c:3480:9
> +    #11 0x562a31dceb33 in qmp_marshal_block_commit
> TEST_DIR/build/qapi/qapi-commands-block-core.c:407:5
> +    #12 0x562a3260be28 in do_qmp_dispatch
> TEST_DIR/src/qapi/qmp-dispatch.c:131:5
> +    #13 0x562a3260b105 in qmp_dispatch
> TEST_DIR/src/qapi/qmp-dispatch.c:174:11
> +    #14 0x562a31cd1b15 in monitor_qmp_dispatch
> TEST_DIR/src/monitor/qmp.c:120:11
> +    #15 0x562a31ccfd45 in monitor_qmp_bh_dispatcher
> TEST_DIR/src/monitor/qmp.c:209:9
> +    #16 0x562a327a91ea in aio_bh_call TEST_DIR/src/util/async.c:89:5
> +    #17 0x562a327a9902 in aio_bh_poll TEST_DIR/src/util/async.c:117:13
> +    #18 0x562a327cb590 in aio_dispatch TEST_DIR/src/util/aio-posix.c:459:5
> +    #19 0x562a327ae933 in aio_ctx_dispatch TEST_DIR/src/util/async.c:260:5
> +    #20 0x7fca6acededc in g_main_context_dispatch
> (/lib64/libglib-2.0.so.0+0x4fedc)
>
> Since there are also lots of these warnings in the output:
>
> +==24683==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
>
> ... I'm really not sure whether it makes sense to go bug hunting here.

I haven't ever seen anything that's really a false positive
as a result of those warnings. Someday I might go and try to
find out exactly what the makecontext/swapcontext issue is.

> OK. Anyway, since there are also these "WARNING: ASan doesn't fully
> support ..." messages in the output, it simply does not make sense to
> run the iotests automatically in this case, since the output of the
> tests gets spoiled and thus the tests are failing.

I guess you're checking both stdout and stderr, then?
I think it is possible to redirect sanitizer output to
some other file with by adding log_path=somefile to
ASAN_OPTIONS (it then writes to somefile.$PID) but
fishing out the results again would be really annoying,
so that sounds more trouble than it's worth. Just skipping
the iotests seems like a simple fix for now, and we can always
come back to this if/when we've tackled some of the leaks that
show up in the rest of the test suite.

thanks
-- PMM

