Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76DBC282CE
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 09:50:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B81282084D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 09:50:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B81282084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45256 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEWLO-0000mh-Qv
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 05:50:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEWKZ-0000S5-Ip
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:49:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEWKY-0003wf-HM
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:49:15 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56308)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hEWKY-0003rr-4B
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:49:14 -0400
Received: by mail-wm1-f66.google.com with SMTP id o25so5861822wmf.5
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 02:49:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=1tmy64TP2DL8qUhTRUG7HDRmYFRWG9v4vL9bCM9VxZk=;
	b=WubVejyntxjHQV/ANamtqppkuZVPH7osYlOgt2s3T6b5BPZLeLBvEGpHN+VKrRYxJe
	BfRUA4das1abUppU4OeVhnh+nscb7zxwHgkvOnTnFDjyus+kpJ1I9WlBJrRXEKKdFxfb
	ISdSp8qad6UNRgnnX0X9fof9O4D5BDVO+A6/8dD1JVJ4jpyrnshY25WEMrTOysG8cF1K
	EtAFyo1zWnBpQh3vGtfS/TVQkT1CsjlHLw+CqchWmFiKSYUTfJVEP4hbtXZVRafH5zwO
	fdkot2a5xcR3aYhSFyHf/wFgizrYXoUikXHMOdJw0imn15AJ7W0WAci0INdc6B8mkIk1
	q6og==
X-Gm-Message-State: APjAAAVk2ife+f9sTpmLaoTtETZye8es1MZ5TBG6fQnCGbLoWmYs+hHT
	UfLZTfcr5bxwce5CGk1NXgpdRQ==
X-Google-Smtp-Source: APXvYqzVQVqrmjeTJ5JH7vtNT6rD/qYcizpY95i1K+x36WIUw4QtJ70RBhvzka4HB5r+eQmddMjkMg==
X-Received: by 2002:a1c:55c3:: with SMTP id j186mr6122182wmb.127.1554976152998;
	Thu, 11 Apr 2019 02:49:12 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	t74sm11056069wmt.3.2019.04.11.02.49.12
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 11 Apr 2019 02:49:12 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190315032629.21234-1-richard.henderson@linaro.org>
	<20190315032629.21234-13-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <6ea1d95e-f5c7-7b14-04c7-07699e9d564a@redhat.com>
Date: Thu, 11 Apr 2019 11:49:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190315032629.21234-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH v3 12/23] linux-user: Call qcrypto_init if
 not using -seed
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
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411094911.MqKOASxb1W22KSVxL4hcoCwzz6wi838OTYvrnbG6NsQ@z>

Hi Richard,

On 3/15/19 4:26 AM, Richard Henderson wrote:
> Cc: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/main.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/linux-user/main.c b/linux-user/main.c
> index cf7095bdaf..8478306eef 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -38,6 +38,7 @@
>  #include "trace/control.h"
>  #include "target_elf.h"
>  #include "cpu_loop-common.h"
> +#include "crypto/init.h"
>  
>  char *exec_path;
>  
> @@ -686,8 +687,18 @@ int main(int argc, char **argv, char **envp)
>      if (seed_optarg == NULL) {
>          seed_optarg = getenv("QEMU_RAND_SEED");
>      }
> -    if (seed_optarg != NULL) {
> -        qemu_guest_random_seed_main(seed_optarg, &error_fatal);
> +    {

Since 7be41675f7c we use gnu99 C, so this extra block indentation can be
removed.

> +        Error *err = NULL;
> +        if (seed_optarg != NULL) {
> +            qemu_guest_random_seed_main(seed_optarg, &err);
> +        } else {
> +            /* ??? Assumes qcrypto is only used by qemu_guest_getrandom.  */
> +            qcrypto_init(&err);
> +        }
> +        if (err) {
> +            error_reportf_err(err, "cannot initialize crypto: ");
> +            exit(1);
> +        }
>      }
>  
>      target_environ = envlist_to_environ(envlist, NULL);
> 

