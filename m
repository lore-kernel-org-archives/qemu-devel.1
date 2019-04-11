Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704E6C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 09:37:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43BAF20850
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 09:37:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43BAF20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45042 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEW9X-00035c-ER
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 05:37:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEW8h-0002kJ-39
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:36:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEW8f-0004EZ-V7
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:36:59 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55711)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hEW8f-0004E9-IE
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:36:57 -0400
Received: by mail-wm1-f65.google.com with SMTP id o25so5812429wmf.5
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 02:36:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=JRZCJRNGk4wYeGII4Kbzq+2CB4rv54Hrmp4TctJ//aU=;
	b=SIBy9TC57ERUa3YfawYWiNMLdZLEfbnXxz9fKZSlpJMnZq+gbU1GDw14G/nun7NoYl
	YEGcsVRrv3Eay8dr/9ZhijViPzQxPkmRGreLOqi9BiBt+G5ZEvxAfWRWOwe8SgGdymYT
	ETg7UXlsi1wUACssj0oYA93hJeWxb3b4Goe+94NuP4ly+hqbDkNrXYYZqWjrU1aE6oJc
	L9hMgGCuhE3O7x2Lf/CRktMC42GUxPFmsy0M7altf3d3y8oqH51asqOHTnfUDRkuAZtr
	/Mz76sh4JSGrYBSRKnos4azK4hQ6vWo6hVwG2BVFopsnJFNcZDeBrQhKBWXjn6f+FwB7
	JZeQ==
X-Gm-Message-State: APjAAAX5s4ZDq9B+PFd2+5z9uIvqtgrPpy2UuhaZ2rxKvfknHGXJsBn1
	3DFFyt2ShwOXTIfocBYR6o6IG0w8edE=
X-Google-Smtp-Source: APXvYqyId8YG/SejZHnq7OimKVgVvcgLPRqdHTW8xg7FZXXWX24yMTvCx8/7C1IfTD4Hr9StleudUA==
X-Received: by 2002:a1c:7512:: with SMTP id o18mr6220301wmc.68.1554975416124; 
	Thu, 11 Apr 2019 02:36:56 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	v16sm70890991wro.48.2019.04.11.02.36.55
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 11 Apr 2019 02:36:55 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190315032629.21234-1-richard.henderson@linaro.org>
	<20190315032629.21234-5-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <ffa34897-8a8b-418a-07be-f12f86822380@redhat.com>
Date: Thu, 11 Apr 2019 11:36:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190315032629.21234-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH v3 04/23] crypto: Use O_CLOEXEC in
 qcrypto_random_init
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
Message-ID: <20190411093655.dM0Us6iQULMxSNcwdmzN5O24QBRdq9bof31GpG6poag@z>

On 3/15/19 4:26 AM, Richard Henderson wrote:
> Avoids leaking the /dev/urandom fd into any child processes.
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  crypto/random-platform.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/crypto/random-platform.c b/crypto/random-platform.c
> index 260b64564d..6df40744c7 100644
> --- a/crypto/random-platform.c
> +++ b/crypto/random-platform.c
> @@ -42,9 +42,9 @@ int qcrypto_random_init(Error **errp)
>  #else
>      /* TBD perhaps also add support for BSD getentropy / Linux
>       * getrandom syscalls directly */
> -    fd = open("/dev/urandom", O_RDONLY);
> +    fd = open("/dev/urandom", O_RDONLY | O_CLOEXEC);
>      if (fd == -1 && errno == ENOENT) {
> -        fd = open("/dev/random", O_RDONLY);
> +        fd = open("/dev/random", O_RDONLY | O_CLOEXEC);
>      }
>  
>      if (fd < 0) {
> 

