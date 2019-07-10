Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C947C73C7C
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 10:13:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0548520838
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 10:13:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0548520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hl9bj-0005kC-BP
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 06:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37140)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hl9b7-000517-9x
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 06:13:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hl9b5-00011V-C3
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 06:13:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33159)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hl9b3-0000lt-Cg
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 06:13:11 -0400
Received: by mail-wr1-f65.google.com with SMTP id n9so1845924wru.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 03:12:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dZpvBFJejrVnM7Jsia37Vdk+aQaraKTCfPECUD4wFNM=;
 b=n954DU56lqBVMQfZGQw0dUd9qVExm30WCy2FARsLJt5I+HJNKJSj+VBFAsYUwH7YUb
 AwCx10G6xeWYXaNjScjXdZBz7LP3e3peAsemJM1UEj1U4JzZZecO5UQJJpXQ5gzRRork
 G3/B4QprXhkn59XObvpkCML7nqcVeF5zAqaMa27fgKb7VfxE4vlaBMKrqchPoEVDY+9d
 44tvJAtLoXD4g9xwvpVKo2PE3zx/w2KMjXMEkjiEDYW8xfy1Y3P6UWonWYfsiH75wYL3
 1pl7MDQQ0ci/rhIFmcVvTj6owypJ2qRr1ivkoVem7Cfa5vJZV8uSkXmoKd+G7tNRS/Mk
 rYRA==
X-Gm-Message-State: APjAAAVld8ONFF7FTha05EdYHkGJMey3NDq5MJD0Hs62zX5HxGuoKn+I
 IRFP7xgx0t3QSKAE+dtaoQLNbA==
X-Google-Smtp-Source: APXvYqx0SunnH5Dk48ERuUkbyVEkOekOL+pvnRc/TJgbilxrxAzJzCRHz8sBWmb2COacqL1WNfY6ng==
X-Received: by 2002:adf:f246:: with SMTP id b6mr31544819wrp.92.1562753578695; 
 Wed, 10 Jul 2019 03:12:58 -0700 (PDT)
Received: from [10.32.224.100] (red-hat-inc.vlan560.asr1.mad1.gblx.net.
 [159.63.51.90])
 by smtp.gmail.com with ESMTPSA id h8sm1735702wmf.12.2019.07.10.03.12.57
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jul 2019 03:12:58 -0700 (PDT)
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20190709194330.837-1-marcandre.lureau@redhat.com>
 <20190709194330.837-4-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <aec37022-129a-f821-7e42-95831743115b@redhat.com>
Date: Wed, 10 Jul 2019 12:12:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190709194330.837-4-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v2 3/5] tests: specify the address family
 when checking bind
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, berrange@redhat.com,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/9/19 9:43 PM, Marc-André Lureau wrote:
> getaddrinfo() may succeed with PF_UNSPEC, but fail when more specific.
> 
> (this allows to skip some tests that would fail under podman)
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/socket-helpers.c | 17 +++++++++++++----
>  tests/socket-helpers.h | 11 -----------
>  2 files changed, 13 insertions(+), 15 deletions(-)
> 
> diff --git a/tests/socket-helpers.c b/tests/socket-helpers.c
> index 8112763f5b..19a51e887e 100644
> --- a/tests/socket-helpers.c
> +++ b/tests/socket-helpers.c
> @@ -30,7 +30,16 @@
>  # define EAI_ADDRFAMILY 0
>  #endif
>  
> -int socket_can_bind_connect(const char *hostname)
> +/*
> + * @hostname: a DNS name or numeric IP address
> + *
> + * Check whether it is possible to bind & connect to ports
> + * on the DNS name or IP address @hostname. If an IP address
> + * is used, it must not be a wildcard address.
> + *
> + * Returns 0 on success, -1 on error with errno set
> + */
> +static int socket_can_bind_connect(const char *hostname, int family)
>  {
>      int lfd = -1, cfd = -1, afd = -1;
>      struct addrinfo ai, *res = NULL;
> @@ -44,7 +53,7 @@ int socket_can_bind_connect(const char *hostname)
>  
>      memset(&ai, 0, sizeof(ai));
>      ai.ai_flags = AI_CANONNAME | AI_ADDRCONFIG;
> -    ai.ai_family = AF_UNSPEC;
> +    ai.ai_family = family;
>      ai.ai_socktype = SOCK_STREAM;
>  
>      /* lookup */
> @@ -129,7 +138,7 @@ int socket_check_protocol_support(bool *has_ipv4, bool *has_ipv6)
>  {
>      *has_ipv4 = *has_ipv6 = false;
>  
> -    if (socket_can_bind_connect("127.0.0.1") < 0) {
> +    if (socket_can_bind_connect("127.0.0.1", PF_INET) < 0) {
>          if (errno != EADDRNOTAVAIL) {
>              return -1;
>          }
> @@ -137,7 +146,7 @@ int socket_check_protocol_support(bool *has_ipv4, bool *has_ipv6)
>          *has_ipv4 = true;
>      }
>  
> -    if (socket_can_bind_connect("::1") < 0) {
> +    if (socket_can_bind_connect("::1", PF_INET6) < 0) {
>          if (errno != EADDRNOTAVAIL) {
>              return -1;
>          }
> diff --git a/tests/socket-helpers.h b/tests/socket-helpers.h
> index 9de0e6b151..512a004811 100644
> --- a/tests/socket-helpers.h
> +++ b/tests/socket-helpers.h
> @@ -20,17 +20,6 @@
>  #ifndef TESTS_SOCKET_HELPERS_H
>  #define TESTS_SOCKET_HELPERS_H
>  
> -/*
> - * @hostname: a DNS name or numeric IP address
> - *
> - * Check whether it is possible to bind & connect to ports
> - * on the DNS name or IP address @hostname. If an IP address
> - * is used, it must not be a wildcard address.
> - *
> - * Returns 0 on success, -1 on error with errno set
> - */
> -int socket_can_bind_connect(const char *hostname);
> -
>  /*
>   * @has_ipv4: set to true on return if IPv4 is available
>   * @has_ipv6: set to true on return if IPv6 is available
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

