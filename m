Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C20BCA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 06:41:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2019A2089E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 06:41:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2019A2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMnrZ-00060y-Ap
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 02:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35451)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iMnqa-0005ZR-SR
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 02:40:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iMnqY-0004JM-56
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 02:40:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32856)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iMnqX-0004J0-T9
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 02:40:46 -0400
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A7EF84E926
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 06:40:43 +0000 (UTC)
Received: by mail-pf1-f197.google.com with SMTP id s139so12711924pfc.21
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 23:40:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=nehKTnzaTjJyYII7bXjzyNr4s+5S/C3+IKQ7IVPqY0c=;
 b=UviwIagK+0tsVC6369nlNlnxc4t5CRL4KGqB/3TH3ZO0QbHGeFUs0daw3/sSVkzTZT
 H9ML6aoMaKxJWvzBPDpMyjl4OhYIKvVJ/4IX9XkY+TFZIIdGzzXFH8U9EY9cvAGA+77/
 0UdeeBnoATgRc4AJFcxSq8fCdxwE0IW4+IcrSrSN/50Tbnydt4IeoDFs4kMIhISD/iSt
 55B3ZZUIlmpBZfetkp149UVL2wJuDUsXw92Kj0L4KGckoglNdHVrqB52e8r08dYWYRo9
 WFSOOKt1XP3XPqTVXlvq53hEg0fTZZQ6Xuh/U3WjcvkfDhTX0LIWckiBk9lJkHoffngt
 O9QA==
X-Gm-Message-State: APjAAAWKY6t7doNJz1PoPS3e1h2N+a1/z/o5wI/FQENVNqEGUxLDaxgo
 VlP+Ewn/iBMWAj+tir/HbvTa+BCvNCSbty65ttjZCxuQyV4/grzh+47ZkTOCR+6xQ6F2KB1BaFi
 hgy0HNtKiLa/hDIY=
X-Received: by 2002:a17:902:a404:: with SMTP id
 p4mr2100719plq.42.1571726443108; 
 Mon, 21 Oct 2019 23:40:43 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwZtVhv2B8PkuiUpAilMrCVfmToa+InVHZKb2GI9p/mAe7LomUgjYGqhrVixI/veN16KEtW6A==
X-Received: by 2002:a17:902:a404:: with SMTP id
 p4mr2100688plq.42.1571726442732; 
 Mon, 21 Oct 2019 23:40:42 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id s202sm19267471pfs.24.2019.10.21.23.40.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2019 23:40:41 -0700 (PDT)
Date: Tue, 22 Oct 2019 14:40:32 +0800
From: Peter Xu <peterx@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v4] migration: Support QLIST migration
Message-ID: <20191022064032.GB21643@xz-x1>
References: <20191018092136.26581-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191018092136.26581-1-eric.auger@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: quintela@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 18, 2019 at 11:21:36AM +0200, Eric Auger wrote:
> Support QLIST migration using the same principle as QTAILQ:
> 94869d5c52 ("migration: migrate QTAILQ").
> 
> The VMSTATE_QLIST_V macro has the same proto as VMSTATE_QTAILQ_V.
> The change mainly resides in QLIST RAW macros: QLIST_RAW_INSERT_HEAD
> and QLIST_RAW_REVERSE.
> 
> Tests also are provided.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> v3 -> v4:
> - replace QLIST_RAW_INSERT_TAIL by QLIST_RAW_INSERT_HEAD and
>   QLIST_RAW_REVERSE as suggested by Juan
> ---
>  include/migration/vmstate.h |  21 ++++++
>  include/qemu/queue.h        |  40 +++++++++++
>  migration/trace-events      |   5 ++
>  migration/vmstate-types.c   |  70 +++++++++++++++++++
>  tests/test-vmstate.c        | 133 ++++++++++++++++++++++++++++++++++++
>  5 files changed, 269 insertions(+)
> 
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index b9ee563aa4..ea2f1f4749 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -225,6 +225,7 @@ extern const VMStateInfo vmstate_info_tmp;
>  extern const VMStateInfo vmstate_info_bitmap;
>  extern const VMStateInfo vmstate_info_qtailq;
>  extern const VMStateInfo vmstate_info_gtree;
> +extern const VMStateInfo vmstate_info_qlist;
>  
>  #define type_check_2darray(t1,t2,n,m) ((t1(*)[n][m])0 - (t2*)0)
>  /*
> @@ -794,6 +795,26 @@ extern const VMStateInfo vmstate_info_gtree;
>      .offset       = offsetof(_state, _field),                                  \
>  }
>  
> +/*
> + * For migrating a QLIST
> + * Target QLIST needs be properly initialized.
> + * _type: type of QLIST element
> + * _next: name of QLIST_ENTRY entry field in QLIST element
> + * _vmsd: VMSD for QLIST element
> + * size: size of QLIST element
> + * start: offset of QLIST_ENTRY in QTAILQ element
> + */
> +#define VMSTATE_QLIST_V(_field, _state, _version, _vmsd, _type, _next)  \
> +{                                                                        \
> +    .name         = (stringify(_field)),                                 \
> +    .version_id   = (_version),                                          \
> +    .vmsd         = &(_vmsd),                                            \
> +    .size         = sizeof(_type),                                       \
> +    .info         = &vmstate_info_qlist,                                 \
> +    .offset       = offsetof(_state, _field),                            \
> +    .start        = offsetof(_type, _next),                              \
> +}
> +
>  /* _f : field name
>     _f_n : num of elements field_name
>     _n : num of elements
> diff --git a/include/qemu/queue.h b/include/qemu/queue.h
> index 73bf4a984d..cd8ad4f386 100644
> --- a/include/qemu/queue.h
> +++ b/include/qemu/queue.h
> @@ -491,4 +491,44 @@ union {                                                                 \
>          QTAILQ_RAW_TQH_CIRC(head)->tql_prev = QTAILQ_RAW_TQE_CIRC(elm, entry);  \
>  } while (/*CONSTCOND*/0)
>  
> +#define QLIST_RAW_FIRST(head)                                                  \
> +        field_at_offset(head, 0, void *)
> +
> +#define QLIST_RAW_NEXT(elm, entry)                                             \
> +        field_at_offset(elm, entry, void *)
> +
> +#define QLIST_RAW_PREVIOUS(elm, entry)                                         \
> +        field_at_offset(elm, entry + sizeof(void *), void *)
> +
> +#define QLIST_RAW_FOREACH(elm, head, entry)                                    \
> +        for ((elm) = *QLIST_RAW_FIRST(head);                                   \
> +             (elm);                                                            \
> +             (elm) = *QLIST_RAW_NEXT(elm, entry))
> +
> +#define QLIST_RAW_INSERT_HEAD(head, elm, entry) do {                           \
> +        void *first = *QLIST_RAW_FIRST(head);                                  \
> +        *QLIST_RAW_FIRST(head) = elm;                                          \
> +        *QLIST_RAW_PREVIOUS(elm, entry) = head;                                \
> +        if (first) {                                                           \
> +            *QLIST_RAW_PREVIOUS(first, entry) = first;                         \
                                                   ^^^^^
                                         should this be "elm"?

> +            *QLIST_RAW_NEXT(elm, entry) = first;                               \
> +        } else {                                                               \
> +            *QLIST_RAW_NEXT(elm, entry) = NULL;                                \
> +        }                                                                      \
> +} while (0)
> +
> +#define QLIST_RAW_REVERSE(head, elm, entry) do {                               \
> +        void *iter = *QLIST_RAW_FIRST(head), *prev = NULL, *next;              \
> +        while (iter)                                                           \
> +            {                                                                  \

(indent issue)

> +                next = *QLIST_RAW_NEXT(iter, entry);                           \
> +                *QLIST_RAW_PREVIOUS(iter, entry) = next;                       \
> +                *QLIST_RAW_NEXT(iter, entry) = prev;                           \
> +                prev = iter;                                                   \
> +                iter = next;                                                   \
> +        }                                                                      \
> +        *QLIST_RAW_FIRST(head) = prev;                                         \
> +        *QLIST_RAW_PREVIOUS(prev, entry) = head;                               \
> +} while (0)

[...]

Otherwise looks good to me.

Thanks,

-- 
Peter Xu

