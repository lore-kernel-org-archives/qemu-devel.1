Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AC1C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 09:04:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 980142054F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 09:04:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 980142054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBEqM-0007lF-Ou
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 05:04:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50617)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iBEpO-0007Ky-Q7
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 05:03:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iBEpM-0002i2-Bt
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 05:03:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50454)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iBEpM-0002hc-5d
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 05:03:44 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E503381129
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 09:03:42 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id v18so2000089wro.16
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 02:03:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PO5Pn57yUIRl+GQNpLm6nMU/xoeZCsQpYsccBYoZZvk=;
 b=J4x1/r3i8DOGmOH3AdQ+oOq8DU+qHrChhuGkCb/8zdspYQL6kig4kNseLoKfCMTVBo
 +LJcoQWK+am54onq3d16OQJQCa/X3Lc3kL2/qaLLQghXcZXAXyUlXapjMBlNpcxfYNkv
 yKHDkrgBVtMSOY1JWErzbcDd85RMkQCSNzK3p1IXYo1wO0dZabbEOEncwtq48nEMZ4o9
 01Oqggygpx6S9OV3uPT6aNSyiPvlRIjM/CmYnf058ej6SGRVeAzK+WO2+2GRj2fqxpy4
 gHqpFbYq+OriI7XkerLl5wPB/aV+hlUgE4JUeOlX/7a4bD1gY1DLiTP58xItqb03joxC
 ipTA==
X-Gm-Message-State: APjAAAW0YwNmzxHg0ltXbxQ0HeHaL5VhKm3Xz7ShfJDIO01HiA7G6MHt
 /+a1AypV2EHpZQXwx+c+v4wf6szwhT8SvB1mUKhrn2g37IL5I5vDP2/zl0YAecE0TeUCQGAI9kU
 2fxUjvjjekCTJJ8A=
X-Received: by 2002:a1c:7dd1:: with SMTP id y200mr2504552wmc.59.1568970221610; 
 Fri, 20 Sep 2019 02:03:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz7gI/9+xVtzUpZWBWIZaLyB/f8hhPn3FIVhw+uX+bv5pSQJlVbxqdxit+sOPc8A5keZkn8cA==
X-Received: by 2002:a1c:7dd1:: with SMTP id y200mr2504524wmc.59.1568970221342; 
 Fri, 20 Sep 2019 02:03:41 -0700 (PDT)
Received: from [192.168.1.40] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id n1sm1497071wrg.67.2019.09.20.02.03.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Sep 2019 02:03:40 -0700 (PDT)
Subject: Re: [RFC 1/4] Add qapi for block error injection
To: Tony Asleson <tasleson@redhat.com>, qemu-devel@nongnu.org, kwolf@redhat.com
References: <20190919194847.18518-1-tasleson@redhat.com>
 <20190919194847.18518-2-tasleson@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <042391ce-1a18-9eb1-5a78-ac40613affb0@redhat.com>
Date: Fri, 20 Sep 2019 11:03:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190919194847.18518-2-tasleson@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Tony,

On 9/19/19 9:48 PM, Tony Asleson wrote:
> Proof of concept code to dynamically create/delete media errors
> for block devices using the qapi interface.  This is useful for testing
> the OS and the block and FS layers for error handling.  Utilizing this
> in a VM allows it to be OS agnostic and test the OS at it's lowest levels
> of hardware interaction.
> 
> Signed-off-by: Tony Asleson <tasleson@redhat.com>
> ---
>  block/Makefile.objs  |   2 +-
>  block/error_inject.c | 179 +++++++++++++++++++++++++++++++++++++++++++
>  block/error_inject.h |  43 +++++++++++
>  block/qapi.c         |  18 +++++
>  qapi/block.json      |  36 +++++++++
>  5 files changed, 277 insertions(+), 1 deletion(-)
>  create mode 100644 block/error_inject.c
>  create mode 100644 block/error_inject.h
> 
> diff --git a/block/Makefile.objs b/block/Makefile.objs
> index 35f3bca4d9..c8fcbc276b 100644
> --- a/block/Makefile.objs
> +++ b/block/Makefile.objs
> @@ -1,4 +1,4 @@
> -block-obj-y += raw-format.o vmdk.o vpc.o
> +block-obj-y += raw-format.o vmdk.o vpc.o error_inject.o
>  block-obj-$(CONFIG_QCOW1) += qcow.o
>  block-obj-$(CONFIG_VDI) += vdi.o
>  block-obj-$(CONFIG_CLOOP) += cloop.o
> diff --git a/block/error_inject.c b/block/error_inject.c
> new file mode 100644
> index 0000000000..26a47dfb8c
> --- /dev/null
> +++ b/block/error_inject.c
> @@ -0,0 +1,179 @@
> +/*
> + * Error injection code for block devices
> + *
> + * Copyright (c) 2019 Red Hat, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +#include "error_inject.h"
> +
> +#include <gmodule.h>
> +
> +#include "qemu/thread.h"
> +
> +static QemuMutex error_inject_lock;
> +static GHashTable *error_inject_data;
> +
> +
> +static void delete_lba_entries(void *entry)
> +{
> +    GSequence *e = (GSequence *) entry;
> +    g_sequence_free(e);
> +}
> +
> +struct value {
> +    uint64_t error_lba;
> +
> +    /*
> +     * TODO Actually do something with behavior
> +     */
> +    MediaErrorBehavior behavior;
> +    /*
> +     * TODO Add data for generating bitrot, when we do change free function
> +     */
> +};
> +
> +static int key_compare(gconstpointer a, gconstpointer b, gpointer data)
> +{
> +    uint64_t left = ((struct value *)a)->error_lba;
> +    uint64_t right = ((struct value *)b)->error_lba;
> +
> +    if (left < right) {
> +        return -1;
> +    } else if (left > right) {
> +        return 1;
> +    } else {
> +        return 0;
> +    }
> +}
> +
> +static uint64_t error_lba_get(GSequenceIter *iter)
> +{
> +    gpointer tmp = g_sequence_get(iter);
> +    return ((struct value *)tmp)->error_lba;
> +}
> +
> +void media_error_create(const char *device_id, uint64_t lba,
> +                        MediaErrorBehavior behavior)
> +{
> +    qemu_mutex_lock(&error_inject_lock);
> +
> +    GSequence *block_device = g_hash_table_lookup(error_inject_data, device_id);
> +    if (!block_device) {
> +        block_device = g_sequence_new(g_free);
> +        char *key = strdup(device_id);
> +        g_hash_table_insert(error_inject_data, key, block_device);
> +    }
> +
> +    struct value lookup = {lba, MEDIA_ERROR_BEHAVIOR__MAX};
> +    if (!g_sequence_lookup(block_device, &lookup, key_compare, NULL)) {
> +        struct value *val = g_new(struct value, 1);
> +        val->error_lba = lba;
> +        val->behavior = behavior;
> +
> +        g_sequence_insert_sorted(block_device, val, key_compare, NULL);
> +    }
> +
> +    qemu_mutex_unlock(&error_inject_lock);
> +}
> +
> +void media_error_delete(const char *device_id, uint64_t lba)

Can you explain the goal of this function? I don't understand it from
the hardware PoV. Or is it a simple code cleanup function?

Once hw starts to break, it is unlikely it recovers magically to a
previous sane state...

In real world, block hardware starts to fail, controller notice
inconsistency and set some bits, the controller driver react.
Eventually the hw will still be used, with the failing block avoided.

What do you think? How is your current use case setup?

Thanks,

Phil.

> +{
> +    qemu_mutex_lock(&error_inject_lock);
> +
> +    GSequence *block_device = g_hash_table_lookup(error_inject_data, device_id);
> +    if (block_device) {
> +        struct value find = { lba, MEDIA_ERROR_BEHAVIOR__MAX};
> +        GSequenceIter *found = g_sequence_lookup(block_device, &find,
> +                                                 key_compare, NULL);
> +        if (found) {
> +            g_sequence_remove(found);
> +        }
> +    }
> +
> +    qemu_mutex_unlock(&error_inject_lock);
> +}
> +
> +int error_in_read(const char *device_id, uint64_t lba, uint64_t len,
> +                  uint64_t *error_lba)
> +{
> +    uint64_t error_sector = 0;
> +    const uint64_t transfer_end = lba + len;
> +    int ec = 0;
> +    *error_lba = 0xFFFFFFFFFFFFFFFF;
> +
> +    qemu_mutex_lock(&error_inject_lock);
> +
> +    GSequence *block_device = g_hash_table_lookup(error_inject_data, device_id);
> +    if (block_device && g_sequence_get_length(block_device) != 0) {
> +        struct value find = {lba, MEDIA_ERROR_BEHAVIOR__MAX};
> +        GSequenceIter *iter = g_sequence_search(block_device, &find,
> +                                                key_compare, NULL);
> +
> +        /*
> +         * g_sequence_seach returns where the item would be inserted.
> +         * In the case of a direct match, it's spot is inserted after the
> +         * existing, thus we need to check the one immediately before
> +         * the insertion point to see if it is the one we are looking for.
> +         */
> +        GSequenceIter *prev = g_sequence_iter_prev(iter);
> +        error_sector = error_lba_get(prev);
> +
> +        if (error_sector >= lba && error_sector < transfer_end) {
> +            *error_lba = error_sector;
> +            ec = 1;
> +        } else {
> +            /*
> +             * Lets look at next until we find one in our transfer or bail
> +             * if the error(s) logical block address are greater than the
> +             * end of our transfer.
> +             */
> +            while (!g_sequence_iter_is_end(iter)) {
> +                error_sector = error_lba_get(iter);
> +
> +                if (error_sector >= transfer_end) {
> +                    break;
> +                }
> +                if (error_sector >= lba && error_sector < transfer_end) {
> +                    *error_lba = error_sector;
> +                    ec = 1;
> +                    break;
> +                } else {
> +                    iter = g_sequence_iter_next(iter);
> +                }
> +            }
> +        }
> +    }
> +
> +    qemu_mutex_unlock(&error_inject_lock);
> +
> +    return ec;
> +}
> +
> +
> +static void __attribute__((__constructor__)) error_inject_init(void)
> +{
> +    qemu_mutex_init(&error_inject_lock);
> +
> +    error_inject_data = g_hash_table_new_full(g_str_hash,
> +                                              g_str_equal,
> +                                              g_free,
> +                                              delete_lba_entries);
> +}
> diff --git a/block/error_inject.h b/block/error_inject.h
> new file mode 100644
> index 0000000000..5f2d143c90
> --- /dev/null
> +++ b/block/error_inject.h
> @@ -0,0 +1,43 @@
> +/*
> + * Error injection code for block devices
> + *
> + * Copyright (c) 2019 Red Hat, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +#ifndef ERROR_INJECT
> +#define ERROR_INJECT
> +#include "qemu/osdep.h"
> +
> +#include <stdint.h>
> +
> +#include "qapi/qapi-commands-block.h"
> +#include "qapi/qapi-types-block.h"
> +
> +
> +void media_error_create(const char *device_id, uint64_t lba,
> +                        MediaErrorBehavior behavior);
> +void media_error_delete(const char *device_id, uint64_t lba);
> +
> +
> +int error_in_read(const char *device_id, uint64_t lba, uint64_t len,
> +                  uint64_t *error_lba);
> +
> +#endif
> diff --git a/block/qapi.c b/block/qapi.c
> index 15f1030264..d66201a831 100644
> --- a/block/qapi.c
> +++ b/block/qapi.c
> @@ -26,11 +26,14 @@
>  #include "qemu-common.h"
>  #include "block/qapi.h"
>  #include "block/block_int.h"
> +#include "block/error_inject.h"
>  #include "block/throttle-groups.h"
>  #include "block/write-threshold.h"
>  #include "qapi/error.h"
> +#include "qapi/qapi-commands-block.h"
>  #include "qapi/qapi-commands-block-core.h"
>  #include "qapi/qobject-output-visitor.h"
> +#include "qapi/qapi-types-block.h"
>  #include "qapi/qapi-visit-block-core.h"
>  #include "qapi/qmp/qbool.h"
>  #include "qapi/qmp/qdict.h"
> @@ -841,3 +844,18 @@ void bdrv_image_info_dump(ImageInfo *info)
>          bdrv_image_info_specific_dump(info->format_specific);
>      }
>  }
> +
> +void qmp_media_error_create(const char *device_id, uint64_t lba,
> +        MediaErrorBehavior behavior, Error **errp)
> +{
> +    /*
> +     * We could validate the device_id and lba for existence and range, but we
> +     * want to be able to add entries before a device is hot plugged too.
> +     */
> +    media_error_create(device_id, lba, behavior);
> +}
> +
> +void qmp_media_error_delete(const char *device_id, uint64_t lba, Error **errp)
> +{
> +    media_error_delete(device_id, lba);
> +}
> diff --git a/qapi/block.json b/qapi/block.json
> index 145c268bb6..2b11954b44 100644
> --- a/qapi/block.json
> +++ b/qapi/block.json
> @@ -453,3 +453,39 @@
>  { 'event': 'QUORUM_REPORT_BAD',
>    'data': { 'type': 'QuorumOpType', '*error': 'str', 'node-name': 'str',
>              'sector-num': 'int', 'sectors-count': 'int' } }
> +
> +##
> +# @MediaErrorBehavior:
> +#
> +# Enumerated type for classifying type of read error behavior.
> +#
> +##
> +{ 'enum': 'MediaErrorBehavior', 'data': ['hard', 'fixed_on_write', 'flakey'] }
> +
> +##
> +# @media-error-create:
> +#
> +# Example:
> +# -> {"execute": "media-error-create",
> +#     "arguments": {"device_id": "12345678, "lba" : 10000, "behavior" : "hard"}}
> +# <- { "return": {} }
> +#
> +# Create a synthetic media error for the specified logical block address when
> +# it is read by the guest OS.
> +#
> +##
> +{ 'command':'media-error-create',
> +  'data': {'device_id': 'str', 'lba': 'uint64', 'behavior': 'MediaErrorBehavior'}}
> +
> +##
> +# @media-error-delete:
> +#
> +# Delete a synthetic media error for the specified logical block address.
> +#
> +# # Example:
> +# -> {"execute": "media-error-delete",
> +#     "arguments": {"device_id": "01020304", "lba" : 10000}
> +# <- { "return": {} }
> +##
> +{ 'command':'media-error-delete',
> +  'data': {'device_id': 'str', 'lba': 'uint64'}}
> 

