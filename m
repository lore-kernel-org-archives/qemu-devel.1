Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31A5C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 07:14:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 555C7206B8
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 07:14:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 555C7206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ht5Hn-0007mX-EV
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 03:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38430)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1ht5HD-0007MP-4U
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 03:13:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ht5HB-0003W3-Ry
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 03:13:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36532)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ht5HB-0003Vp-Jz
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 03:13:25 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C9F614E927;
 Thu,  1 Aug 2019 07:13:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-51.ams2.redhat.com
 [10.36.116.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 249A560925;
 Thu,  1 Aug 2019 07:13:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 886C51138619; Thu,  1 Aug 2019 09:13:21 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
References: <1563390416-751339-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Date: Thu, 01 Aug 2019 09:13:21 +0200
In-Reply-To: <1563390416-751339-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 (Andrey Shinkevich's message of "Wed, 17 Jul 2019 22:06:56 +0300")
Message-ID: <87h871uzn2.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Thu, 01 Aug 2019 07:13:24 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] make check-unit: use after free in
 test-opts-visitor
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
Cc: den@openvz.org, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Andrey Shinkevich <andrey.shinkevich@virtuozzo.com> writes:

> In struct OptsVisitor, repeated_opts member points to a list in the
> unprocessed_opts hash table after the list has been destroyed. A
> subsequent call to visit_type_int() references the deleted list. It
> results in use-after-free issue. Also, the Visitor object call back
> functions are supposed to set the Error parameter in case of failure.
>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>
> The issue was detected after running tests/test-opts-visitor under the Valgrind tool:
>
>  Invalid read of size 8
>    at 0x55ADB95: g_queue_peek_head (in /usr/lib64/libglib-2.0.so.0.5600.1)
>    by 0x12FD97: lookup_scalar (opts-visitor.c:310)
>    by 0x13008A: opts_type_int64 (opts-visitor.c:395)
>    by 0x1299C8: visit_type_int (qapi-visit-core.c:149)
>    by 0x119389: test_opts_range_beyond (test-opts-visitor.c:240)
>
> after
>  Address 0x9563b30 is 0 bytes inside a block of size 24 free'd
>    at 0x4C2ACBD: free (vg_replace_malloc.c:530)
>    by 0x55A179D: g_free (in /usr/lib64/libglib-2.0.so.0.5600.1)
>    by 0x55B92BF: g_slice_free1 (in /usr/lib64/libglib-2.0.so.0.5600.1)
>    by 0x12F615: destroy_list (opts-visitor.c:102)
>    by 0x558A859: ??? (in /usr/lib64/libglib-2.0.so.0.5600.1)
>    by 0x12FC37: opts_next_list (opts-visitor.c:260)
>    by 0x1296B1: visit_next_list (qapi-visit-core.c:88)
>    by 0x119341: test_opts_range_beyond (test-opts-visitor.c:238)

Reproduced.

>
>  qapi/opts-visitor.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/qapi/opts-visitor.c b/qapi/opts-visitor.c
> index 324b197..e95f766 100644
> --- a/qapi/opts-visitor.c
> +++ b/qapi/opts-visitor.c
> @@ -228,6 +228,7 @@ opts_start_list(Visitor *v, const char *name, GenericList **list, size_t size,
       ov->repeated_opts = lookup_distinct(ov, name, errp);
       if (ov->repeated_opts) {
           ov->list_mode = LM_IN_PROGRESS;
>          *list = g_malloc0(size);
>      } else {
>          *list = NULL;
> +        error_setg(errp, QERR_MISSING_PARAMETER, name);

To get here, lookup_distinct() must have returned null.  It set an error
then.  Setting it again will crash.  Sure you tested this?

>      }
>  }
>  
> @@ -255,9 +256,14 @@ opts_next_list(Visitor *v, GenericList *tail, size_t size)
>      case LM_IN_PROGRESS: {
>          const QemuOpt *opt;
>  
> +        if (!ov->repeated_opts) {
> +            return NULL;
> +        }

How can ov->repeated_opts be null in state LM_IN_PROGRESS?

ov->repeated_opts is initially null (state LM_NONE).  It becomes
non-null on transition to state LM_IN_PROGRESS in opts_start_list(), and
null on transition back to LM_NONE in opts_end_list().

> +
>          opt = g_queue_pop_head(ov->repeated_opts);
>          if (g_queue_is_empty(ov->repeated_opts)) {
>              g_hash_table_remove(ov->unprocessed_opts, opt->name);
> +            ov->repeated_opts = NULL;
>              return NULL;
>          }

Uh, now you're violating the invariant I just described.  I suspect
that's how null can happen now.

If the fix should change the invariant, we need to review the entire
file to make sure nothing that relies on the invariant remains.  The
!ov->repeated_opts check above takes care of one case.  There may be
more.  Before we search for them, let's have a closer look at the bug
you found.  I'll do that below.

>          break;
> @@ -307,6 +313,10 @@ lookup_scalar(const OptsVisitor *ov, const char *name, Error **errp)
>          return list ? g_queue_peek_tail(list) : NULL;
>      }
>      assert(ov->list_mode == LM_IN_PROGRESS);
> +    if (!ov->repeated_opts) {
> +        error_setg(errp, QERR_INVALID_PARAMETER, name);
> +        return NULL;
> +    }

This is another case.

>      return g_queue_peek_head(ov->repeated_opts);
>  }

Now let's step back and review what valgrind is telling us.

The invalid read is indeed a use after free.

The free is opts_next_list()'s g_hash_table_remove(ov->unprocessed_opts,
opt->name), which in turn calls destroy_list() to destroy the value
associated with opt->name.

The use is lookup_scalar()'s g_queue_peek_head(ov->repeated_opts).
We're in state LM_IN_PROGRESS.  ov->repeated_opts points to a value
freed by opts_next_list().

Happens when test_opts_range_beyond() tries to visit more list elements
than actually present.

ov->repeated_opts becomes dangling when opts_next_list() destroys
ov->unprocessed_opts on reaching the end of the list.  Your patch zaps
it right after it becomes dangling.  Good.

But now the state machine has a new state "visiting beyond end of list":
list_mode == LM_IN_PROGRESS, repeated_opts == NULL.

Perhaps giving it its own ListMode member would be clearer.

Regardless, we need to convince ourselves that we handle the new state
correctly everywhere.  Have you done that?

