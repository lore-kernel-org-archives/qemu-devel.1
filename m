Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF672C76194
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 09:38:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B66F2190F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 09:38:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B66F2190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqaCp-0001dQ-RJ
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 05:38:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40510)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hqaCf-0001Dp-JY
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 05:38:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hqaCe-000888-ID
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 05:38:25 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40026)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hqaCe-00087o-9G
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 05:38:24 -0400
Received: by mail-wm1-f65.google.com with SMTP id v19so44125294wmj.5
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 02:38:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+eqFSeGd2jTWRbokRoEiK0+Mi+6wvB97fgIZw56Ufv0=;
 b=WLpHHWSqsMig0agOVwioJy6LZ7u7tAxexJLoT8TUVUpXKtSfMqdObfkWhtQs6gcVWe
 AarImMvHfHcLtdT3gp/vpauvr+EAAomwNXHuPVOmZSuzdYlOVu5hrntmxM7r7pbHxygx
 MZYCpLLM0PckN4xwRu62WDNsEWBC/uz0oDG3I8X8IwkX+mq2nAFwLS1QDrl3uxUqjX63
 FtRKFcwstp0wgDGbiAyhPZiW1/gwntkPtDaDx/u436awUwkMI3txtIJzeX8i7KzXwJJy
 saHu/F+4EU9M/4YdGMm9kJmUWypHzXkwxbcTUjv+bWlCfDXt/+9Fj4mWR9O0ruRTPGkL
 f0Hw==
X-Gm-Message-State: APjAAAUJrVfG8zyqat4jdYyR0VbhPn7x+y7TuJzMQ0OFqfzYoISSMnSe
 ePs//M4g7D6P79BcZEHinhxOmQ==
X-Google-Smtp-Source: APXvYqyLu6BW425E+75t4y5vSCU+Dmyv6ZsyYzbfBqsFMDKnaxNke5bm4mY1Sxouw9JSoZ8FD6XvNg==
X-Received: by 2002:a1c:c188:: with SMTP id r130mr74693871wmf.73.1564047503175; 
 Thu, 25 Jul 2019 02:38:23 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:cc23:f353:392:d2ee?
 ([2001:b07:6468:f312:cc23:f353:392:d2ee])
 by smtp.gmail.com with ESMTPSA id f12sm53517926wrg.5.2019.07.25.02.38.22
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Jul 2019 02:38:22 -0700 (PDT)
To: "Oleinik, Alexander" <alxndr@bu.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20190725032321.12721-1-alxndr@bu.edu>
 <20190725032321.12721-11-alxndr@bu.edu>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <fad9d12a-39df-e2fa-064b-5132add9daff@redhat.com>
Date: Thu, 25 Jul 2019 11:38:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725032321.12721-11-alxndr@bu.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [RFC 10/19] fuzz: expose real_main (aka regular
 vl.c:main)
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
Cc: "bsd@redhat.com" <bsd@redhat.com>,
 "superirishdonkey@gmail.com" <superirishdonkey@gmail.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/07/19 05:23, Oleinik, Alexander wrote:
> Export normal qemu-system main so it can be called from tests/fuzz/fuzz.c
> 
> Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
> ---
>  include/sysemu/sysemu.h |  4 ++++
>  vl.c                    | 21 ++++++++++++++++++++-
>  2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index 984c439ac9..1bb8cf184c 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -184,6 +184,10 @@ QemuOpts *qemu_get_machine_opts(void);
>  
>  bool defaults_enabled(void);
>  
> +#ifdef CONFIG_FUZZ
> +int real_main(int argc, char **argv, char **envp);
> +#endif
> +
>  extern QemuOptsList qemu_legacy_drive_opts;
>  extern QemuOptsList qemu_common_drive_opts;
>  extern QemuOptsList qemu_drive_opts;
> diff --git a/vl.c b/vl.c
> index b426b32134..b71b99b6f8 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -130,6 +130,10 @@ int main(int argc, char **argv)
>  #include "sysemu/iothread.h"
>  #include "qemu/guest-random.h"
>  
> +#ifdef CONFIG_FUZZ
> +#include "tests/libqtest.h"
> +#endif
> +
>  #define MAX_VIRTIO_CONSOLES 1
>  
>  static const char *data_dir[16];
> @@ -2853,8 +2857,11 @@ static void user_register_global_props(void)
>      qemu_opts_foreach(qemu_find_opts("global"),
>                        global_init_func, NULL, NULL);
>  }
> -
> +#ifdef CONFIG_FUZZ
> +int real_main(int argc, char **argv, char **envp)
> +#else
>  int main(int argc, char **argv, char **envp)
> +#endif
>  {
>      int i;
>      int snapshot, linux_boot;
> @@ -2903,7 +2910,9 @@ int main(int argc, char **argv, char **envp)
>      atexit(qemu_run_exit_notifiers);
>      qemu_init_exec_dir(argv[0]);
>  
> +#ifndef CONFIG_FUZZ // QOM is already set up by the fuzzer.
>      module_call_init(MODULE_INIT_QOM);
> +#endif

You can modify module_call_init to record the modules that have been
initialized, and skip the call (i.e. make it idempotent).

>      qemu_add_opts(&qemu_drive_opts);
>      qemu_add_drive_opts(&qemu_legacy_drive_opts);
> @@ -4196,9 +4205,11 @@ int main(int argc, char **argv, char **envp)
>       */
>      migration_object_init();
>  
> +#ifndef CONFIG_FUZZ // Already set up by the fuzzer
>      if (qtest_chrdev) {
>          qtest_init(qtest_chrdev, qtest_log, &error_fatal);
>      }
> +#endif

Here, I suspect the fuzzing target would have qtest_chrdev == NULL,
therefore you can assert that qtest_init is only called once.  For
example, add an

    assert(!test_log_fp)

in the function.

>      machine_opts = qemu_get_machine_opts();
>      kernel_filename = qemu_opt_get(machine_opts, "kernel");
> @@ -4470,6 +4481,14 @@ int main(int argc, char **argv, char **envp)
>      accel_setup_post(current_machine);
>      os_setup_post();
>  
> +/*
> + * Return to the fuzzer since it will run qtest programs and run the
> + * main_loop
> +*/
> +#ifdef CONFIG_FUZZ
> +    return 0;
> +#endif

Just place everything up to this point into a new function qemu_init();
for CONFIG_FUZZ that's what you call from LLVMFuzzerInitialize, while
for !CONFIG_FUZZ you can call it from main().  All the functions below
have no arguments, so the patch is trivial.

Paolo

>      main_loop();
>  
>      gdbserver_cleanup();
> 


