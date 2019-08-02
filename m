Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE57C32750
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 11:35:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 132A82087C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 11:35:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 132A82087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htVqK-0004Eq-2b
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 07:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53037)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1htVpo-0003Wp-6U
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 07:34:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1htVpm-0004ce-PN
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 07:34:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36138)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1htVpm-0004c7-Hg
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 07:34:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0D1758F91B;
 Fri,  2 Aug 2019 11:34:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-51.ams2.redhat.com
 [10.36.116.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 65A075C219;
 Fri,  2 Aug 2019 11:34:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E61D51138619; Fri,  2 Aug 2019 13:34:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
References: <1564684930-107089-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Date: Fri, 02 Aug 2019 13:34:49 +0200
In-Reply-To: <1564684930-107089-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 (Andrey Shinkevich's message of "Thu, 1 Aug 2019 21:42:10 +0300")
Message-ID: <87imrfkdgm.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Fri, 02 Aug 2019 11:34:52 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] make check-unit: use after free in
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
> results in use-after-free issue.

Let's mention the reproducer: valgrind tests/test/opts-visitor.

>                                  Also, the Visitor object call back
> functions are supposed to set the Error parameter in case of failure.

As far as I can tell, they all do.  The only place where you set an
error is the new failure you add to lookup_scalar().

> A new mode ListMode::LM_TRAVERSED is declared to mark the list
> traversal completed.
>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>
> v2:
>  01: A new mode LM_TRAVERSED has been introduced to check instead of the
>      repeated_opts pointer for NULL.
>
>  qapi/opts-visitor.c | 78 +++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 49 insertions(+), 29 deletions(-)
>
> diff --git a/qapi/opts-visitor.c b/qapi/opts-visitor.c
> index 324b197..23ac383 100644
> --- a/qapi/opts-visitor.c
> +++ b/qapi/opts-visitor.c
> @@ -22,33 +22,42 @@
>  
>  enum ListMode
>  {
> -    LM_NONE,             /* not traversing a list of repeated options */
> -
> -    LM_IN_PROGRESS,      /* opts_next_list() ready to be called.
> -                          *
> -                          * Generating the next list link will consume the most
> -                          * recently parsed QemuOpt instance of the repeated
> -                          * option.
> -                          *
> -                          * Parsing a value into the list link will examine the
> -                          * next QemuOpt instance of the repeated option, and
> -                          * possibly enter LM_SIGNED_INTERVAL or
> -                          * LM_UNSIGNED_INTERVAL.
> -                          */
> -
> -    LM_SIGNED_INTERVAL,  /* opts_next_list() has been called.
> -                          *
> -                          * Generating the next list link will consume the most
> -                          * recently stored element from the signed interval,
> -                          * parsed from the most recent QemuOpt instance of the
> -                          * repeated option. This may consume QemuOpt itself
> -                          * and return to LM_IN_PROGRESS.
> -                          *
> -                          * Parsing a value into the list link will store the
> -                          * next element of the signed interval.
> -                          */
> -
> -    LM_UNSIGNED_INTERVAL /* Same as above, only for an unsigned interval. */
> +    LM_NONE,              /* not traversing a list of repeated options */
> +
> +    LM_IN_PROGRESS,       /*
> +                           * opts_next_list() ready to be called.
> +                           *
> +                           * Generating the next list link will consume the most
> +                           * recently parsed QemuOpt instance of the repeated
> +                           * option.
> +                           *
> +                           * Parsing a value into the list link will examine the
> +                           * next QemuOpt instance of the repeated option, and
> +                           * possibly enter LM_SIGNED_INTERVAL or
> +                           * LM_UNSIGNED_INTERVAL.
> +                           */
> +
> +    LM_SIGNED_INTERVAL,   /*
> +                           * opts_next_list() has been called.
> +                           *
> +                           * Generating the next list link will consume the most
> +                           * recently stored element from the signed interval,
> +                           * parsed from the most recent QemuOpt instance of the
> +                           * repeated option. This may consume QemuOpt itself
> +                           * and return to LM_IN_PROGRESS.
> +                           *
> +                           * Parsing a value into the list link will store the
> +                           * next element of the signed interval.
> +                           */
> +
> +    LM_UNSIGNED_INTERVAL, /* Same as above, only for an unsigned interval. */
> +
> +    LM_TRAVERSED          /*
> +                           * opts_next_list() has been called.
> +                           *
> +                           * No more QemuOpt instance in the list.
> +                           * The traversal has been completed.
> +                           */
>  };
>  
>  typedef enum ListMode ListMode;

Please don't change the spacing without need.  The hunk should look like
this:

  @@ -24,7 +24,8 @@ enum ListMode
   {
       LM_NONE,              /* not traversing a list of repeated options */

  -    LM_IN_PROGRESS,      /* opts_next_list() ready to be called.
  +    LM_IN_PROGRESS,       /*
  +                           * opts_next_list() ready to be called.
                              *
                              * Generating the next list link will consume the most
                              * recently parsed QemuOpt instance of the repeated
  @@ -36,7 +37,8 @@ enum ListMode
                              * LM_UNSIGNED_INTERVAL.
                              */

  -    LM_SIGNED_INTERVAL,  /* opts_next_list() has been called.
  +    LM_SIGNED_INTERVAL,   /*
  +                           * opts_next_list() has been called.
                              *
                              * Generating the next list link will consume the most
                              * recently stored element from the signed interval,
  @@ -48,7 +50,14 @@ enum ListMode
                              * next element of the signed interval.
                              */

  -    LM_UNSIGNED_INTERVAL /* Same as above, only for an unsigned interval. */
  +    LM_UNSIGNED_INTERVAL, /* Same as above, only for an unsigned interval. */
  +
  +    LM_TRAVERSED          /*
  +                           * opts_next_list() has been called.
  +                           *
  +                           * No more QemuOpt instance in the list.
  +                           * The traversal has been completed.
  +                           */
   };

   typedef enum ListMode ListMode;

> @@ -238,6 +247,8 @@ opts_next_list(Visitor *v, GenericList *tail, size_t size)
>      OptsVisitor *ov = to_ov(v);
>  
>      switch (ov->list_mode) {
> +    case LM_TRAVERSED:
> +        return NULL;
>      case LM_SIGNED_INTERVAL:
>      case LM_UNSIGNED_INTERVAL:
>          if (ov->list_mode == LM_SIGNED_INTERVAL) {
> @@ -258,6 +269,8 @@ opts_next_list(Visitor *v, GenericList *tail, size_t size)
>          opt = g_queue_pop_head(ov->repeated_opts);
>          if (g_queue_is_empty(ov->repeated_opts)) {
>              g_hash_table_remove(ov->unprocessed_opts, opt->name);
> +            ov->repeated_opts = NULL;
> +            ov->list_mode = LM_TRAVERSED;
>              return NULL;
>          }
>          break;
> @@ -289,8 +302,11 @@ opts_end_list(Visitor *v, void **obj)
>  
>      assert(ov->list_mode == LM_IN_PROGRESS ||
>             ov->list_mode == LM_SIGNED_INTERVAL ||
> -           ov->list_mode == LM_UNSIGNED_INTERVAL);
> -    ov->repeated_opts = NULL;
> +           ov->list_mode == LM_UNSIGNED_INTERVAL ||
> +           ov->list_mode == LM_TRAVERSED);
> +    if (ov->list_mode != LM_TRAVERSED) {
> +        ov->repeated_opts = NULL;
> +    }

What's wrong with zapping ov->repeated_opts unconditionally?

>      ov->list_mode = LM_NONE;
>  }
>  
> @@ -306,6 +322,10 @@ lookup_scalar(const OptsVisitor *ov, const char *name, Error **errp)
>          list = lookup_distinct(ov, name, errp);
>          return list ? g_queue_peek_tail(list) : NULL;
>      }
> +    if (ov->list_mode == LM_TRAVERSED) {
> +        error_setg(errp, QERR_INVALID_PARAMETER, name);

Beware, @name is null when visiting list members.  The test still passes
for me, since g_strdup_vprintf() formats a null argument to %s as
"(null)".

For what it's worth, the qobject input visitor uses
QERR_MISSING_PARAMETER with a made-up name.  Computing the name is
pretty elaborate, see full_name_nth().  I'd rather not duplicate that
here.

Suggest something like

           error_setg(errp, "Fewer list elements than expected");

The error message fails to mention the name of the list.  Bad, but the
error is a corner case; we don't normally visit beyond the end of the
list.  For a better message, we'd have to have start_list() store its
@name in struct OptsVisitor.  I'm not asking you to do that now.

> +        return NULL;
> +    }
>      assert(ov->list_mode == LM_IN_PROGRESS);
>      return g_queue_peek_head(ov->repeated_opts);
>  }

I checked the remaining uses of ->list_mode, and I think they are okay.

