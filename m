Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660AAC04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 09:45:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34FAC261B8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 09:45:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34FAC261B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39285 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWe6M-0003Eh-1a
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 05:45:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hWe5U-0002q9-Ji
	for qemu-devel@nongnu.org; Fri, 31 May 2019 05:44:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hWe5T-00081J-Ew
	for qemu-devel@nongnu.org; Fri, 31 May 2019 05:44:36 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45468)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hWe5T-00080N-9Q
	for qemu-devel@nongnu.org; Fri, 31 May 2019 05:44:35 -0400
Received: by mail-wr1-f67.google.com with SMTP id b18so6025777wrq.12
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 02:44:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=g+7ed+uwrMjQRGI8ZdcsjRc0J1OqCMgBgdTQDPZxKeM=;
	b=CY28Ns9Yvlu2UKIPamUMbYPoO8WnAM0vO46ZVUEi2nxaTlVYUS0sWOi8/hOLe9o57O
	vnaw5y9d/kAhHl3pA9iXStk1TQFjYOyRvbRglyegBlUsQtr5fZxDKf/TC+a0LoS+yEZP
	pGFFpKNKP+ZzwAXljwB5QeznxQ1UUPOqEBk1ZKumYyzLYBGWw234u5szXBVSuTQc6/i7
	+zkReN+SisvyD5FQJuQzR9Ye59JKKww5Xr/23xGzD34c15lkj0prWNtjcAKF6HvalEVC
	Mc3fWrsiocFHMWRsz/x1jrzwaALLiRNK9XnEr34oOTrmiC+jQ2jLhfYQJdrzsnFNeM7L
	Z9VA==
X-Gm-Message-State: APjAAAWZsvrY11ZQrEajIU03CUrtKtH93nB2S5USuMpMxchfz3b5KEVz
	hYgkY2zIoYrlviR/MSRzq7onxA==
X-Google-Smtp-Source: APXvYqyGJZkR2z2lOnShCoJ0K+PY6a9wyN+4PBzaexnYRQx7SF+hhf4Uw6tPPBwE1zAwYU770jDCPA==
X-Received: by 2002:a5d:498a:: with SMTP id r10mr5830200wrq.28.1559295873732; 
	Fri, 31 May 2019 02:44:33 -0700 (PDT)
Received: from [192.168.1.43] (183.red-88-21-202.staticip.rima-tde.net.
	[88.21.202.183]) by smtp.gmail.com with ESMTPSA id
	a125sm1676971wmf.42.2019.05.31.02.44.32
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 31 May 2019 02:44:33 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190530173824.30699-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <5d985216-8521-f4a2-a9c3-7a00c6066b2f@redhat.com>
Date: Fri, 31 May 2019 11:44:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190530173824.30699-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH] util: Adjust qemu_guest_getrandom_nofail
 for Coverity
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
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/30/19 7:38 PM, Richard Henderson wrote:
> Explicitly ignore the return value of qemu_guest_getrandom.
> Because we use error_fatal, all errors are already caught.
> 
> Fixes: CID 1401701
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  util/guest-random.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/util/guest-random.c b/util/guest-random.c
> index e8124a3cad..00a08fd981 100644
> --- a/util/guest-random.c
> +++ b/util/guest-random.c
> @@ -56,7 +56,7 @@ int qemu_guest_getrandom(void *buf, size_t len, Error **errp)
>  
>  void qemu_guest_getrandom_nofail(void *buf, size_t len)
>  {
> -    qemu_guest_getrandom(buf, len, &error_fatal);
> +    (void)qemu_guest_getrandom(buf, len, &error_fatal);
>  }
>  
>  uint64_t qemu_guest_random_seed_thread_part1(void)
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

