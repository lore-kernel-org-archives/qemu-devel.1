Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD36C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 09:42:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C207A2084D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 09:42:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C207A2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45118 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEWES-0005gL-1Q
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 05:42:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEWDi-0005N8-0x
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:42:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEWDf-0006TG-Hl
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:42:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33200)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hEWDe-0006Rr-A4
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:42:06 -0400
Received: by mail-wr1-f66.google.com with SMTP id q1so6468117wrp.0
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 02:42:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=DtFmfnbhdNttFxJzIv4n90zrlvuXIoyD0lAPPiAQvY8=;
	b=pjII3oM2tXoXcotyawfP3ebzI1NdGVd3RQd7QxtrdFs0Vxu84HYnQEHC4yXUrKeb/z
	vRnLnK0cYh2OLY9Y5VArvGQyYhYhpqbsJK9rKv8KVROuttPHWdoXbWYtQUl/WCz3TO4C
	4Eo/ahM6P+TtStbgAEjeqMNKhFrxk9/KBzXgxujelssdfM1FLwrk8wYjPAfikp4x7MuN
	STA3/qL1x03XtACoBL17bynuHRnkFQjWC22ss3Q9vb0ERC9G3mVe1ABiM861a2rn7h/2
	IseEk5kw2BsymUqU/mPMzQUOpph1dwVqXzNgsCpulwmoqywnlCKCHtpkY5DmerxYs/xd
	6Rlw==
X-Gm-Message-State: APjAAAXn88h/V2Cr8isvXDx+3mx1rZ8q8aHdzkFZGkAg6KGJ7QS9WwEx
	vSS3y5xU5CjNOAAXDba47zsH7j806TY=
X-Google-Smtp-Source: APXvYqwGR9mZFBEZkJ7ATXb7V04LsBp2YjaGSvrv5BmPmDt2q9ScrzxpvxxY3WPpvVdKGBsjvO+7Kg==
X-Received: by 2002:adf:f7c2:: with SMTP id a2mr30905872wrq.242.1554975722592; 
	Thu, 11 Apr 2019 02:42:02 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193])
	by smtp.gmail.com with ESMTPSA id 84sm8548444wme.43.2019.04.11.02.42.01
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 11 Apr 2019 02:42:02 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190315032629.21234-1-richard.henderson@linaro.org>
	<20190315032629.21234-10-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <119d86ff-1436-d847-fefe-b71011d1557e@redhat.com>
Date: Thu, 11 Apr 2019 11:42:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190315032629.21234-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v3 09/23] util: Add qemu_guest_getrandom
 and associated routines
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411094201.Jdn4jCRQm-8zPo9Lyapmj43DXIzAS7WDSmSy6BzXcMg@z>

On 3/15/19 4:26 AM, Richard Henderson wrote:
> This routine is intended to produce high-quality random numbers to the
> guest.  Normally, such numbers are crypto quality from the host, but a
> command-line option can force the use of a fully deterministic sequence
> for use while debugging.
> 
> Cc: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/qemu/guest-random.h | 68 +++++++++++++++++++++++++++
>  util/guest-random.c         | 93 +++++++++++++++++++++++++++++++++++++
>  util/Makefile.objs          |  1 +
>  3 files changed, 162 insertions(+)
>  create mode 100644 include/qemu/guest-random.h
>  create mode 100644 util/guest-random.c
> 
> diff --git a/include/qemu/guest-random.h b/include/qemu/guest-random.h
> new file mode 100644
> index 0000000000..09ff9c2236
> --- /dev/null
> +++ b/include/qemu/guest-random.h
> @@ -0,0 +1,68 @@
> +/*
> + * QEMU guest-visible random functions
> + *
> + * Copyright 2019 Linaro, Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the Free
> + * Software Foundation; either version 2 of the License, or (at your option)
> + * any later version.
> + */
> +
> +#ifndef QEMU_GUEST_RANDOM_H
> +#define QEMU_GUEST_RANDOM_H
> +
> +/**
> + * qemu_guest_random_seed_main(const char *optarg, Error **errp)
> + * @optarg: a non-NULL pointer to a C string
> + * @errp: an error indicator
> + *
> + * The @optarg value is that which accompanies the -seed argument.
> + * This forces qemu_guest_getrandom into deterministic mode.
> + *
> + * Returns 0 on success, < 0 on failure while setting *errp.
> + */
> +int qemu_guest_random_seed_main(const char *optarg, Error **errp);
> +
> +/**
> + * qemu_guest_random_seed_thread_part1(void)
> + *
> + * If qemu_getrandom is in deterministic mode, returns an
> + * independent seed for the new thread.  Otherwise returns 0.
> + */
> +uint64_t qemu_guest_random_seed_thread_part1(void);
> +
> +/**
> + * qemu_guest_random_seed_thread_part2(uint64_t seed)
> + * @seed: a value for the new thread.
> + *
> + * If qemu_guest_getrandom is in deterministic mode, this stores an
> + * independent seed for the new thread.  Otherwise a no-op.
> + */
> +void qemu_guest_random_seed_thread_part2(uint64_t seed);
> +
> +/**
> + * qemu_guest_getrandom(void *buf, size_t len, Error **errp)
> + * @buf: a buffer of bytes to be written
> + * @len: the number of bytes in @buf
> + * @errp: an error indicator
> + *
> + * Fills len bytes in buf with random data.  This should only be used
> + * for data presented to the guest.  Host-side crypto services should
> + * use qcrypto_random_bytes.
> + *
> + * Returns 0 on success, < 0 on failure while setting *errp.
> + */
> +int qemu_guest_getrandom(void *buf, size_t len, Error **errp);
> +
> +/**
> + * qemu_guest_getrandom_nofail(void *buf, size_t len)
> + * @buf: a buffer of bytes to be written
> + * @len: the number of bytes in @buf

API documentation appreciated, thanks!

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> + *
> + * Like qemu_guest_getrandom, but will assert for failure.
> + * Use this when there is no reasonable recovery.
> + */
> +void qemu_guest_getrandom_nofail(void *buf, size_t len);
> +
> +#endif /* QEMU_GUEST_RANDOM_H */
> diff --git a/util/guest-random.c b/util/guest-random.c
> new file mode 100644
> index 0000000000..e8124a3cad
> --- /dev/null
> +++ b/util/guest-random.c
> @@ -0,0 +1,93 @@
> +/*
> + * QEMU guest-visible random functions
> + *
> + * Copyright 2019 Linaro, Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the Free
> + * Software Foundation; either version 2 of the License, or (at your option)
> + * any later version.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +#include "qemu/cutils.h"
> +#include "qapi/error.h"
> +#include "qemu/guest-random.h"
> +#include "crypto/random.h"
> +
> +
> +static __thread GRand *thread_rand;
> +static bool deterministic;
> +
> +
> +static int glib_random_bytes(void *buf, size_t len)
> +{
> +    GRand *rand = thread_rand;
> +    size_t i;
> +    uint32_t x;
> +
> +    if (unlikely(rand == NULL)) {
> +        /* Thread not initialized for a cpu, or main w/o -seed.  */
> +        thread_rand = rand = g_rand_new();
> +    }
> +
> +    for (i = 0; i + 4 <= len; i += 4) {
> +        x = g_rand_int(rand);
> +        __builtin_memcpy(buf + i, &x, 4);
> +    }
> +    if (i < len) {
> +        x = g_rand_int(rand);
> +        __builtin_memcpy(buf + i, &x, i - len);
> +    }
> +    return 0;
> +}
> +
> +int qemu_guest_getrandom(void *buf, size_t len, Error **errp)
> +{
> +    if (unlikely(deterministic)) {
> +        /* Deterministic implementation using Glib's Mersenne Twister.  */
> +        return glib_random_bytes(buf, len);
> +    } else {
> +        /* Non-deterministic implementation using crypto routines.  */
> +        return qcrypto_random_bytes(buf, len, errp);
> +    }
> +}
> +
> +void qemu_guest_getrandom_nofail(void *buf, size_t len)
> +{
> +    qemu_guest_getrandom(buf, len, &error_fatal);
> +}
> +
> +uint64_t qemu_guest_random_seed_thread_part1(void)
> +{
> +    if (deterministic) {
> +        uint64_t ret;
> +        glib_random_bytes(&ret, sizeof(ret));
> +        return ret;
> +    }
> +    return 0;
> +}
> +
> +void qemu_guest_random_seed_thread_part2(uint64_t seed)
> +{
> +    g_assert(thread_rand == NULL);
> +    if (deterministic) {
> +        thread_rand =
> +            g_rand_new_with_seed_array((const guint32 *)&seed,
> +                                       sizeof(seed) / sizeof(guint32));
> +    }
> +}
> +
> +int qemu_guest_random_seed_main(const char *optarg, Error **errp)
> +{
> +    unsigned long long seed;
> +    if (parse_uint_full(optarg, &seed, 0)) {
> +        error_setg(errp, "Invalid seed number: %s", optarg);
> +        return -1;
> +    } else {
> +        deterministic = true;
> +        qemu_guest_random_seed_thread_part2(seed);
> +        return 0;
> +    }
> +}
> diff --git a/util/Makefile.objs b/util/Makefile.objs
> index 835fcd69e2..4d4db653cc 100644
> --- a/util/Makefile.objs
> +++ b/util/Makefile.objs
> @@ -53,5 +53,6 @@ util-obj-y += iova-tree.o
>  util-obj-$(CONFIG_INOTIFY1) += filemonitor-inotify.o
>  util-obj-$(CONFIG_LINUX) += vfio-helpers.o
>  util-obj-$(CONFIG_OPENGL) += drm.o
> +util-obj-y += guest-random.o
>  
>  stub-obj-y += filemonitor-stub.o
> 

