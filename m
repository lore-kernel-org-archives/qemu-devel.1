Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B409FA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 08:07:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4F0C20872
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 08:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4F0C20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL0oy-0003IF-Sm
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 04:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42747)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iL0oK-0002qz-PL
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 04:07:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iL0oJ-00020e-CC
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 04:07:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48160)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iL0oJ-00020V-3N
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 04:07:03 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E6A178AC6FB;
 Thu, 17 Oct 2019 08:07:01 +0000 (UTC)
Received: from redhat.com (ovpn-116-80.ams2.redhat.com [10.36.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 53EFF5D70D;
 Thu, 17 Oct 2019 08:06:58 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v3] migration: Support QLIST migration
In-Reply-To: <20191015125045.5006-1-eric.auger@redhat.com> (Eric Auger's
 message of "Tue, 15 Oct 2019 14:50:45 +0200")
References: <20191015125045.5006-1-eric.auger@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
Date: Thu, 17 Oct 2019 10:06:56 +0200
Message-ID: <87r23bpzhb.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Thu, 17 Oct 2019 08:07:02 +0000 (UTC)
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
Reply-To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Auger <eric.auger@redhat.com> wrote:
> Support QLIST migration using the same principle as QTAILQ:
> 94869d5c52 ("migration: migrate QTAILQ").
>
> The VMSTATE_QLIST_V macro has the same proto as VMSTATE_QTAILQ_V.
> The change mainly resides in QLIST_RAW_INSERT_TAIL implementation.
>
> Tests also are provided.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Hi


How long are these lists normally?  I think that the INSERT_TAIL is the
wrong approach.  If lists can be long, it is much better to just insert
at the beggining and as last operation, reverse things, no?

> +#define QLIST_RAW_INSERT_TAIL(head, elm, entry) do {                           \
> +        void *iter, *last = NULL;                                              \
> +        *QLIST_RAW_NEXT(elm, entry) = NULL;                                    \
> +        if (!*QLIST_RAW_FIRST(head)) {                                         \
> +            *QLIST_RAW_FIRST(head) = elm;                                      \
> +            *QLIST_RAW_PREVIOUS(elm, entry) = head;                            \
> +            break;                                                             \
> +        }                                                                      \
> +        for (iter = *QLIST_RAW_FIRST(head);                                    \
> +             iter; last = iter, iter = *QLIST_RAW_NEXT(iter, entry))           \
> +            { }                                                                \
> +        *QLIST_RAW_NEXT(last, entry) = elm;                                    \
> +        *QLIST_RAW_PREVIOUS(elm, entry) = last;                                \

I think that you normally want to do this two instructions in the
reverse order, just in case (famous last words).


> +static int get_qlist(QEMUFile *f, void *pv, size_t unused_size,
> +                     const VMStateField *field)
> +{
> +    int ret = 0;
> +    const VMStateDescription *vmsd = field->vmsd;
> +    /* size of a QLIST element */
> +    size_t size = field->size;
> +    /* offset of the QLIST entry in a QLIST element */
> +    size_t entry_offset = field->start;
> +    int version_id = field->version_id;
> +    void *elm;
> +
> +    trace_get_qlist(field->name, vmsd->name, vmsd->version_id);
> +    if (version_id > vmsd->version_id) {
> +        error_report("%s %s",  vmsd->name, "too new");
> +        return -EINVAL;
> +    }
> +    if (version_id < vmsd->minimum_version_id) {
> +        error_report("%s %s",  vmsd->name, "too old");
> +        return -EINVAL;
> +    }
> +
> +    while (qemu_get_byte(f)) {
> +        elm = g_malloc(size);
> +        ret = vmstate_load_state(f, vmsd, elm, version_id);
> +        if (ret) {
> +            error_report("%s: failed to load %s (%d)", field->name,
> +                         vmsd->name, ret);
> +            g_free(elm);
> +            return ret;
> +        }
> +        QLIST_RAW_INSERT_TAIL(pv, elm, entry_offset);

Here we insert at the beggining.

> +    }

Here we reverse?

We move from O(n^2) to O(2n), much better, no?
As said, except if the lists are normally very short.


The rest of the patch looks ok to me.

Later, Juan.

