Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BACC5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 12:56:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09CCB2084D
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 12:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0me93jF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09CCB2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iShLB-0007kr-8x
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 07:56:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60923)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iShKO-0007Lz-W3
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 07:55:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iShKK-0004Ab-V3
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 07:55:56 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44325)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iShKK-0004AH-MP
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 07:55:52 -0500
Received: by mail-wr1-x443.google.com with SMTP id f2so2853653wrs.11
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 04:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=PWJdP5t2LruTvlXt/gRemy5Nkm9DyBoFzoeNMw0O6us=;
 b=P0me93jFHH1t+E/CJgg5bGWNKu1uY34QELXViqA2/B5Bf2HlwcLapDlnd5Dig0HNar
 Fo5/fhNDVMlnctTqsqvQ9CBA+yaYAsWk+SA1VV9IVOR1zhFPIySuC9zbuM3dLJQg7Fh4
 gFGGQSfgGqBUwne/eGVnIwkAseARuVCoZsZo1jbeLchZcuSAZ0o7WyqSl9DYbKcGE5fk
 dNATlZdxxQJaKABH+IF2GMVDT080PuizGotdEolAerx3uY766KjarXDO98YW4VbIyz5B
 D0X7lLatU5J4s6+/tbjrRZ0mjuhBohffY24LJXufnmMulJAhOEpHHZkR6vdh1a0PMCmO
 LhSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=PWJdP5t2LruTvlXt/gRemy5Nkm9DyBoFzoeNMw0O6us=;
 b=Bc7x1NPHRo2peNuRQvloflBQq79qG/1avxZNbqika4nZqIC6a4f6yVzF6GzOUlszj5
 sv3skGBNVLLJHQu0ZwqPyQ4Grg69i/H6E10Q+//TNIPT55DBo0xNRd9aEvA65OAEx2eU
 gQRUdCrAKI+VhzQxTjwCLC/cQzqpBhpVwGpOmUzGfm+qzU//qFif9uj/wA7Llp8BhPX9
 5c/O3scplSZg5IDmEHZAAlO9NQ45Npq1F59hGlsityJopitISR5+MkoJcGNlS8flalKE
 BU1d+Cx8Ekcn3TH47X4FkIUG2kiewjYOtFJhsTQ0LtAiJw5jy2zcLk0dMu5/ekzD3xg3
 5TnA==
X-Gm-Message-State: APjAAAWUGjf/hCLGuUDRSD8slv7so5ZMAw39V5gqT7xMteOCDejBUJad
 Nv08aDwntCPnz/JUmnKoY7M=
X-Google-Smtp-Source: APXvYqy4od5IFR+FB9z2RGYBhXOv2ymtaNcqCa4S+ML3AAs7tkcpg7gRPvNlcazDXaMjB7nZxCFAAw==
X-Received: by 2002:adf:e506:: with SMTP id j6mr2815671wrm.19.1573131351242;
 Thu, 07 Nov 2019 04:55:51 -0800 (PST)
Received: from localhost (77.119.131.75.wireless.dyn.drei.com. [77.119.131.75])
 by smtp.gmail.com with ESMTPSA id 5sm1645234wmk.48.2019.11.07.04.55.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2019 04:55:50 -0800 (PST)
Date: Thu, 7 Nov 2019 13:55:40 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v4 15/20] fuzz: add fuzzer skeleton
Message-ID: <20191107125540.GA365089@stefanha-x1.localdomain>
References: <20191030144926.11873-1-alxndr@bu.edu>
 <20191030144926.11873-16-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <20191030144926.11873-16-alxndr@bu.edu>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 30, 2019 at 02:50:00PM +0000, Oleinik, Alexander wrote:
> diff --git a/tests/fuzz/fuzz.c b/tests/fuzz/fuzz.c
> new file mode 100644
> index 0000000000..0e38f81c48
> --- /dev/null
> +++ b/tests/fuzz/fuzz.c
> @@ -0,0 +1,177 @@
> +/*
> + * fuzzing driver
> + *
> + * Copyright Red Hat Inc., 2019
> + *
> + * Authors:
> + *  Alexander Bulekov   <alxndr@bu.edu>

Bulekov instead of Oleinik?

> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include <stdio.h>
> +#include <stdlib.h>

stdio.h and stdlib.h are already included by qemu/osdep.h.

> +/* Executed for each fuzzing-input */
> +int LLVMFuzzerTestOneInput(const unsigned char *Data, size_t Size)
> +{
> +    if (fuzz_target->fuzz) {

Will this ever be NULL?

> +        fuzz_target->fuzz(fuzz_qts, Data, Size);
> +    }
> +    return 0;
> +}
> +
> +/* Executed once, prior to fuzzing */
> +int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
> +{
> +
> +    char *target_name;
> +
> +    /* Initialize qgraph and modules */
> +    qos_graph_init();
> +    module_call_init(MODULE_INIT_FUZZ_TARGET);
> +    module_call_init(MODULE_INIT_QOM);
> +    module_call_init(MODULE_INIT_LIBQOS);
> +
> +    if (*argc <= 1) {
> +        usage(**argv);
> +    }
> +
> +    /* Identify the fuzz target */
> +    target_name = (*argv)[1];
> +    if (!strstr(target_name, "--fuzz-target=")) {
> +        usage(**argv);
> +    }
> +
> +    target_name += strlen("--fuzz-target=");
> +
> +    fuzz_target = fuzz_get_target(target_name);
> +    if (!fuzz_target) {
> +        usage(**argv);
> +    }
> +
> +    fuzz_qts = qtest_setup();
> +
> +    if (!fuzz_target) {

This is dead code since fuzz_target was already checked above.  Please
remove this if statement.

> +        fprintf(stderr, "Error: Fuzz fuzz_target name %s not found\n",
> +                target_name);
> +        usage(**argv);
> +    }
> +
> +    if (fuzz_target->pre_vm_init) {
> +        fuzz_target->pre_vm_init();
> +    }
> +
> +    /* Run QEMU's softmmu main with the fuzz-target dependent arguments */
> +    char *init_cmdline = fuzz_target->get_init_cmdline(fuzz_target);

Where is init_cmdline freed or should this be const char *?

> +    wordexp_t result;
> +    wordexp(init_cmdline, &result, 0);

What is the purpose of word expansion here?

> +
> +    qemu_init(result.we_wordc, result.we_wordv, NULL);
> +
> +    if (fuzz_target->pre_fuzz) {
> +        fuzz_target->pre_fuzz(fuzz_qts);
> +    }
> +
> +    return 0;
> +}
> diff --git a/tests/fuzz/fuzz.h b/tests/fuzz/fuzz.h
> new file mode 100644
> index 0000000000..b569b622d7
> --- /dev/null
> +++ b/tests/fuzz/fuzz.h
> @@ -0,0 +1,66 @@
> +/*
> + * fuzzing driver
> + *
> + * Copyright Red Hat Inc., 2019
> + *
> + * Authors:
> + *  Alexander Bulekov   <alxndr@bu.edu>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#ifndef FUZZER_H_
> +#define FUZZER_H_
> +
> +#include "qemu/osdep.h"
> +#include "qemu/units.h"
> +#include "qapi/error.h"
> +#include "exec/memory.h"
> +#include "tests/libqtest.h"
> +
> +

Some documentation would be nice:

/**
 * A libfuzzer fuzzing target
 *
 * The QEMU fuzzing binary is built with all available targets, each
 * with a unique @name that can be specified on the command-line to
 * select which target should run.
 *
 * A target must implement ->fuzz() to process a random input.  If QEMU
 * crashes in ->fuzz() then libfuzzer will record a failure.
 *
 * Fuzzing targets are registered with fuzz_add_target():
 *
 *   static const FuzzTarget fuzz_target = {
 *       .name = "my-device-fifo",
 *       .description = "Fuzz the FIFO buffer registers of my-device",
 *       ...
 *   };
 *
 *   static void register_fuzz_target(void)
 *   {
 *       fuzz_add_target(&fuzz_target);
 *   }
 *   fuzz_target_init(register_fuzz_target);
 */

> +typedef struct FuzzTarget {
> +    const char *name;         /* command-line option(FUZZ_TARGET) for the target */
> +    const char *description;  /* help text */
> +

If any of the function pointers can be NULL, please document this.

> +    /* returns the arg-list that is passed to qemu/softmmu init() */
> +    char* (*get_init_cmdline)(struct FuzzTarget *);

Does the caller need to call g_free() on the returned string?  Please
document this.

> +
> +    /*
> +     * will run once, prior to running qemu/softmmu init.
> +     * eg: set up shared-memory for communication with the child-process
> +     */
> +    void(*pre_vm_init)(void);
> +
> +    /*
> +     * will run once, prior to to the fuzz-loop.

s/to to/to/

> +     * eg: detect the memory map
> +     */
> +    void(*pre_fuzz)(QTestState *);

Please also mention that QEMU has been initialized at this point.

> +
> +    /*
> +     * accepts and executes an input from libfuzzer. this is repeatedly
> +     * executed during the fuzzing loop. Its should handle setup, input
> +     * execution and cleanup
> +     */
> +    void(*fuzz)(QTestState *, const unsigned char *, size_t);
> +
> +} FuzzTarget;
> +
> +void flush_events(QTestState *);
> +void reboot(QTestState *);
> +
> +/*
> + * makes a copy of *target and adds it to the target-list.
> + * i.e. fine to set up target on the caller's stack
> + */
> +void fuzz_add_target(FuzzTarget *target);

"makes a copy of *target" -> does this mean the argument type can be
const FuzzTarget *target?

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3EFEwACgkQnKSrs4Gr
c8hkVAf/WQR+uRgSc7x8Tb7ZMdz96Df3/NFShmTj0WzuH2JZJULzlACptG6GkZKf
2nTR/yCbvWueb3szOXIgT7NH3vsX/fi8zTKT6DF/B2h0UDDdEs8Q6iBgQB6SL3lY
PjHyA9EVu35O1dFKK0JFfauDKqyTL45oQWwhv6mABTRa1XvA0uxJhlS7fgJhyEYb
pQY/FlYOp1PimtvAsbVMbcFl07q7Qgu5bdvkZ/yseKxWDRZHznVLM9lVuIbM4maI
AVclBtsYIrrVhobu1ts0p0AgEmbnYnkpfj++IRXuxpJx3YbMQ0xkQDGxH8CB9T6P
g8i1jmrPCtIEjiWb+c1Rf8nnch2yKg==
=Wk91
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--

