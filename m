Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0350EC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 21:22:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFE4F2068D
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 21:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H+WsSYRF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFE4F2068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jilhR-0002Um-Ue
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 17:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jilgf-0001zB-PB
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 17:21:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36834
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jilge-0004lx-5X
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 17:21:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591737695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jmq9dZbIvOQR5syu6kZkIdAKM74eEaIGserCzuFeWmY=;
 b=H+WsSYRF9N0RFyt0wAxy8jR9EQCw2ao0s+Im+TtQ0gnU4ukP2nZ7glR5itXn3I3VSpdbHb
 OGFoLUW6BUKrLShT1UjuEw9TeTd8YnGRf44IXUUPLuV7Y6ku5yZDSWtz11tFezs3dvrfYz
 BlVUfv74TXV0vlylIES8kTEmssuubJk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-0gskeKr-Osq1hBiYJU9xJw-1; Tue, 09 Jun 2020 17:21:16 -0400
X-MC-Unique: 0gskeKr-Osq1hBiYJU9xJw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8899C1005510;
 Tue,  9 Jun 2020 21:21:15 +0000 (UTC)
Received: from [10.3.113.22] (ovpn-113-22.phx2.redhat.com [10.3.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 114E17A8C9;
 Tue,  9 Jun 2020 21:21:10 +0000 (UTC)
Subject: Re: [PATCH v6 4/7] scripts: add coroutine-wrapper.py
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200609141329.3945-1-vsementsov@virtuozzo.com>
 <20200609141329.3945-5-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <73e06745-24c7-f7b8-9494-20f710b77e9f@redhat.com>
Date: Tue, 9 Jun 2020 16:21:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200609141329.3945-5-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 01:38:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, kwolf@redhat.com, ehabkost@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com,
 crosa@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/9/20 9:13 AM, Vladimir Sementsov-Ogievskiy wrote:
> We have a very frequent pattern of creating coroutine from function
> with several arguments:
> 
>    - create structure to pack parameters
>    - create _entry function to call original function taking parameters
>      from struct
>    - do different magic to handle completion: set ret to NOT_DONE or
>      EINPROGRESS, use separate bool for void functions

Stale comment, now that you got rid of void functions earlier in the series.

>    - fill the struct and create coroutine from _entry function and this
>      struct as a parameter
>    - do coroutine enter and BDRV_POLL_WHILE loop
> 
> Let's reduce code duplication by generating coroutine wrappers.
> 
> This patch adds scripts/coroutine-wrapper.py together with some
> friends, which will generate functions with declared prototypes marked
> by 'generated_co_wrapper' specifier.
> 
> The usage of new code generation is as follows:
> 
>      1. define somewhere
> 
>          int coroutine_fn bdrv_co_NAME(...) {...}
> 
>         function
> 
>      2. declare in some header file
> 
>          int generated_co_wrapper bdrv_NAME(...);
> 
>         function with same list of parameters. (you'll need to include
>         "block/generated-co-wrapper.h" to get the specifier)
> 
>      3. both declarations should be available through block/coroutines.h
>         header.
> 
>      4. add header with generated_co_wrapper declaration into
>         COROUTINE_HEADERS list in Makefile
> 
> Still, no function is now marked, this work is for the following
> commit.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   Makefile                             |   8 ++
>   block/block-gen.h                    |  55 +++++++++
>   include/block/generated-co-wrapper.h |  35 ++++++
>   block/Makefile.objs                  |   1 +
>   scripts/coroutine-wrapper.py         | 174 +++++++++++++++++++++++++++
>   5 files changed, 273 insertions(+)
>   create mode 100644 block/block-gen.h
>   create mode 100644 include/block/generated-co-wrapper.h
>   create mode 100755 scripts/coroutine-wrapper.py

My python review is weak, but here goes.

> +++ b/block/block-gen.h

> +
> +#include "block/block_int.h"
> +
> +/* This function is called at the end of generated coroutine entries. */
> +static inline void bdrv_poll_co__on_exit(void)
> +{
> +    aio_wait_kick();
> +}

I still think it's worth inlining aio_wait_kick() into the generated 
code, instead of this one-line wrapper function.  Patch below.

> +
> +/* Base structure for argument packing structures */
> +typedef struct BdrvPollCo {
> +    BlockDriverState *bs;
> +    bool in_progress;
> +    int ret;
> +    Coroutine *co; /* Keep pointer here for debugging */
> +} BdrvPollCo;
> +
> +static inline int bdrv_poll_co(BdrvPollCo *s)
> +{
> +    assert(!qemu_in_coroutine());
> +
> +    bdrv_coroutine_enter(s->bs, s->co);
> +    BDRV_POLL_WHILE(s->bs, s->in_progress);
> +
> +    return s->ret;
> +}
> +
> +#endif /* BLOCK_BLOCK_GEN_H */
> diff --git a/include/block/generated-co-wrapper.h b/include/block/generated-co-wrapper.h
> new file mode 100644
> index 0000000000..62c6e053ba
> --- /dev/null
> +++ b/include/block/generated-co-wrapper.h

> +#ifndef BLOCK_GENERATED_CO_WRAPPER_H
> +#define BLOCK_GENERATED_CO_WRAPPER_H
> +
> +/*
> + * generated_co_wrapper
> + * Function specifier, which does nothing but marking functions to be
> + * generated by scripts/coroutine-wrapper.py
> + */
> +#define generated_co_wrapper

Do we need a standalone header just for this definition, or could we 
stick it in include/block/block.h?  Also in my patch below.

> diff --git a/scripts/coroutine-wrapper.py b/scripts/coroutine-wrapper.py
> new file mode 100755
> index 0000000000..dbe6fb97d9
> --- /dev/null
> +++ b/scripts/coroutine-wrapper.py
> @@ -0,0 +1,174 @@
> +#!/usr/bin/env python3

> +"""Generate coroutine wrappers for block subsystem.
> +def prettify(code: str) -> str:
> +    """Prettify code using clang-format if available"""
> +
> +    try:
> +        style = '{IndentWidth: 4, BraceWrapping: {AfterFunction: true}, ' \
> +            'BreakBeforeBraces: Custom, SortIncludes: false, ' \
> +            'MaxEmptyLinesToKeep: 2}'

It looks odd to pass in style as a string (requiring \-newline) rather 
than a dict (which would not), but I guess that's because...

> +        p = subprocess.run(['clang-format', f'-style={style}'], check=True,

...you have to stringify it anyway for the subprocess command line.

> +class ParamDecl:
> +    param_re = re.compile(r'(?P<decl>'
> +                          r'(?P<type>.*[ *])'
> +                          r'(?P<name>[a-z][a-z0-9_]*)'

I guess you're safe not including A-Z based on our coding style.

> +                          r')')
> +
> +    def __init__(self, param_decl: str) -> None:
> +        m = self.param_re.match(param_decl.strip())
> +        if m is None:
> +            raise ValueError(f'Wrong parameter declaration: "{param_decl}"')
> +        self.decl = m.group('decl')
> +        self.type = m.group('type')
> +        self.name = m.group('name')
> +
> +
> +class FuncDecl:
> +    def __init__(self, return_type: str, name: str, args: str) -> None:
> +        self.return_type = return_type.strip()
> +        self.name = name.strip()
> +        self.args = [ParamDecl(arg.strip()) for arg in args.split(',')]
> +
> +    def gen_list(self, format: str) -> str:
> +        return ', '.join(format.format_map(arg.__dict__) for arg in self.args)
> +
> +    def gen_block(self, format: str) -> str:
> +        return '\n'.join(format.format_map(arg.__dict__) for arg in self.args)
> +
> +
> +# Match wrappers declared with a generated_co_wrapper mark
> +func_decl_re = re.compile(r'^int\s*generated_co_wrapper\s*'
> +                          r'(?P<wrapper_name>[a-z][a-z0-9_]*)'
> +                          r'\((?P<args>[^)]*)\);$', re.MULTILINE)
> +

Makes sense (requires coroutines to return int, but you fixed that 
earlier in the series).

> +
> +def func_decl_iter(text: str) -> Iterator:
> +    for m in func_decl_re.finditer(text):
> +        yield FuncDecl(return_type='int',
> +                       name=m.group('wrapper_name'),
> +                       args=m.group('args'))
> +
> +
> +def snake_to_camel(func_name: str) -> str:
...

Nothing else jumped out at me, so:
Reviewed-by: Eric Blake <eblake@redhat.com>

Still, here's the promised diffs I'm thinking of:

for 4/7

 From 8c089d488ed8d9778fd5ee1f18dbc3845e4349f2 Mon Sep 17 00:00:00 2001
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 9 Jun 2020 17:13:26 +0300
Subject: [PATCH] fixup? scripts: add coroutine-wrapper.py

Worth squashing in to the coroutine generator?

Signed-off-by: Eric Blake <eblake@redhat.com>
---
  scripts/coroutine-wrapper.py         |  5 ++--
  block/block-gen.h                    |  6 -----
  include/block/block.h                |  7 ++++++
  include/block/generated-co-wrapper.h | 35 ----------------------------
  4 files changed, 10 insertions(+), 43 deletions(-)
  delete mode 100644 include/block/generated-co-wrapper.h

diff --git a/scripts/coroutine-wrapper.py b/scripts/coroutine-wrapper.py
index dbe6fb97d9bd..0c2cf13401ce 100755
--- a/scripts/coroutine-wrapper.py
+++ b/scripts/coroutine-wrapper.py
@@ -57,7 +57,8 @@ def gen_header():

  #include "qemu/osdep.h"
  #include "block/coroutines.h"
-#include "block/block-gen.h"\
+#include "block/block-gen.h"
+#include "block/block_int.h"\
  """


@@ -139,7 +140,7 @@ static void coroutine_fn {name}_entry(void *opaque)
      s->poll_state.ret = {name}({ func.gen_list('s->{name}') });
      s->poll_state.in_progress = false;

-    bdrv_poll_co__on_exit();
+    aio_wait_kick();
  }}

  int {func.name}({ func.gen_list('{decl}') })
diff --git a/block/block-gen.h b/block/block-gen.h
index 482d06737d10..f80cf4897d11 100644
--- a/block/block-gen.h
+++ b/block/block-gen.h
@@ -28,12 +28,6 @@

  #include "block/block_int.h"

-/* This function is called at the end of generated coroutine entries. */
-static inline void bdrv_poll_co__on_exit(void)
-{
-    aio_wait_kick();
-}
-
  /* Base structure for argument packing structures */
  typedef struct BdrvPollCo {
      BlockDriverState *bs;
diff --git a/include/block/block.h b/include/block/block.h
index 46965a77801c..59a002e06f23 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -10,6 +10,13 @@
  #include "block/blockjob.h"
  #include "qemu/hbitmap.h"

+/*
+ * generated_co_wrapper
+ * Function specifier, which does nothing but marking functions to be
+ * generated by scripts/coroutine-wrapper.py
+ */
+#define generated_co_wrapper
+
  /* block.c */
  typedef struct BlockDriver BlockDriver;
  typedef struct BdrvChild BdrvChild;
diff --git a/include/block/generated-co-wrapper.h 
b/include/block/generated-co-wrapper.h
deleted file mode 100644
index 62c6e053ba12..000000000000
--- a/include/block/generated-co-wrapper.h
+++ /dev/null
@@ -1,35 +0,0 @@
-/*
- * Block layer I/O functions
- *
- * Copyright (c) 2020 Virtuozzo International GmbH
- *
- * Permission is hereby granted, free of charge, to any person 
obtaining a copy
- * of this software and associated documentation files (the 
"Software"), to deal
- * in the Software without restriction, including without limitation 
the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or 
sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be 
included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR 
OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, 
ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
DEALINGS IN
- * THE SOFTWARE.
- */
-
-#ifndef BLOCK_GENERATED_CO_WRAPPER_H
-#define BLOCK_GENERATED_CO_WRAPPER_H
-
-/*
- * generated_co_wrapper
- * Function specifier, which does nothing but marking functions to be
- * generated by scripts/coroutine-wrapper.py
- */
-#define generated_co_wrapper
-
-#endif /* BLOCK_GENERATED_CO_WRAPPER_H */
-- 
2.27.0



for 5/7

diff --git i/block/coroutines.h w/block/coroutines.h
index 145a2d264524..c62b3a2697ca 100644
--- i/block/coroutines.h
+++ w/block/coroutines.h
@@ -26,7 +26,6 @@
  #define BLOCK_COROUTINES_INT_H

  #include "block/block_int.h"
-#include "block/generated-co-wrapper.h"

  int coroutine_fn bdrv_co_check(BlockDriverState *bs,
                                 BdrvCheckResult *res, BdrvCheckMode fix);
diff --git i/include/block/block.h w/include/block/block.h
index 321d75675768..9f94c5905788 100644
--- i/include/block/block.h
+++ w/include/block/block.h
@@ -9,7 +9,6 @@
  #include "block/dirty-bitmap.h"
  #include "block/blockjob.h"
  #include "qemu/hbitmap.h"
-#include "block/generated-co-wrapper.h"

  /*
   * generated_co_wrapper


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


