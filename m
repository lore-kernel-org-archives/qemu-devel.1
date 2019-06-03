Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0FCC04AB6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 08:45:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1469F26927
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 08:45:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1469F26927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59773 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXib6-0007fF-61
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 04:45:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hXiZS-0006c1-4A
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 04:43:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hXiRC-0002O9-SL
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 04:35:29 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37165)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hXiRB-0001wh-65
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 04:35:25 -0400
Received: by mail-wm1-f65.google.com with SMTP id 22so1821909wmg.2
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 01:35:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=Sm1YepoPl0KDVv1MDJXkSOGM8/1GGanp5UrIk8m5ta4=;
	b=TqxrLQve/2b9fUPJaadchvXsjXTaD++mP+h2c8JmgJ40lijwl4c55IFAIbYVkEbLM2
	VOVmvA0VlBYi1EY2iH6fayUIyzuOUT4TmAOwMD0pxAKBmJpvbxUpK5CrG8vUHfDEMFWz
	6r4/FzSxoAPcJwuou5p2bhaIEejUifSpitZttWI/sWM4msMECqwKb9VzD2UwYhhEAKei
	hVWvi0H063wgvHnuPhy6WTB5L0lzK0NPSkohHOHhzUtCxitxE3FO9mr9sk9RTfKuZBsf
	xHzRonjUxKHgPqF6tTanSbiGUxYUihmpKFmspVr93ZBQKBdQ388wfxHvzkAJP3W+CUEh
	iqDQ==
X-Gm-Message-State: APjAAAUrmyBxsB8RYRsGA4mAgWA8zSa8DNbwazTQvM2SV7keHpTL8/e5
	iHTELu2KueS9PWiRZvPLJJs+nw==
X-Google-Smtp-Source: APXvYqx8A9/KfOqCj6vbZu/K1ZMnqX4VRstMAftAH1EkuoieNBbHVRMgP5IZ6UInWgGZbGnpLX4arg==
X-Received: by 2002:a1c:44d7:: with SMTP id
	r206mr13850386wma.164.1559550901207; 
	Mon, 03 Jun 2019 01:35:01 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
	[88.21.202.183]) by smtp.gmail.com with ESMTPSA id
	y133sm10533472wmg.5.2019.06.03.01.34.59
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 01:35:00 -0700 (PDT)
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20190603081335.8185-2-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <a586ecb9-08b2-33ed-0926-47c75b2f8f80@redhat.com>
Date: Mon, 3 Jun 2019 10:34:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190603081335.8185-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH] qgraph: fix qos_node_contains with options
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
Cc: thuth@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/3/19 10:13 AM, Paolo Bonzini wrote:
> Currently, if qos_node_contains was passed options, it would still
> create an edge without any options.  Instead, in that case
> NULL acts as a terminator.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/libqos/qgraph.c | 12 ++++++++----
>  tests/libqos/qgraph.h | 15 +++++++++------
>  2 files changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/tests/libqos/qgraph.c b/tests/libqos/qgraph.c
> index b149caaaa9..7a7ae2a19e 100644
> --- a/tests/libqos/qgraph.c
> +++ b/tests/libqos/qgraph.c
> @@ -632,15 +632,19 @@ void qos_node_create_driver(const char *name, QOSCreateDriverFunc function)
>  }
>  
>  void qos_node_contains(const char *container, const char *contained,
> -                       ...)
> +                       QOSGraphEdgeOptions *opts, ...)
>  {
>      va_list va;
> -    va_start(va, contained);
> -    QOSGraphEdgeOptions *opts;
>  
> +    if (opts == NULL) {
> +        add_edge(container, contained, QEDGE_CONTAINS, NULL);
> +        return;
> +    }
> +
> +    va_start(va, opts);
>      do {
> -        opts = va_arg(va, QOSGraphEdgeOptions *);
>          add_edge(container, contained, QEDGE_CONTAINS, opts);

'opts' argument is non-null, you use add it, ...

> +        opts = va_arg(va, QOSGraphEdgeOptions *);

... and fill it (now used as local variable) with the next vararg after
the 'opts' from the call arguments. OK.
Interesting optimization, although not trivial to review.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>      } while (opts != NULL);
>  
>      va_end(va);
> diff --git a/tests/libqos/qgraph.h b/tests/libqos/qgraph.h
> index e799095b30..3a25dda4b2 100644
> --- a/tests/libqos/qgraph.h
> +++ b/tests/libqos/qgraph.h
> @@ -453,14 +453,16 @@ void qos_node_create_machine_args(const char *name,
>  void qos_node_create_driver(const char *name, QOSCreateDriverFunc function);
>  
>  /**
> - * qos_node_contains(): creates an edge of type QEDGE_CONTAINS and
> - * adds it to the edge list mapped to @container in the
> + * qos_node_contains(): creates one or more edges of type QEDGE_CONTAINS
> + * and adds them to the edge list mapped to @container in the
>   * edge hash table.
>   *
> - * This edge will have @container as source and @contained as destination.
> + * The edges will have @container as source and @contained as destination.
>   *
> - * It also has the possibility to add optional NULL-terminated
> - * @opts parameters (see %QOSGraphEdgeOptions)
> + * If @opts is NULL, a single edge will be added with no options.
> + * If @opts is non-NULL, the arguments after @contained represent a
> + * NULL-terminated list of %QOSGraphEdgeOptions structs, and an
> + * edge will be added for each of them.
>   *
>   * This function can be useful when there are multiple devices
>   * with the same node name contained in a machine/other node
> @@ -480,7 +482,8 @@ void qos_node_create_driver(const char *name, QOSCreateDriverFunc function);
>   * For contains, op1.arg and op1.size_arg represent the arg to pass
>   * to @contained constructor to properly initialize it.
>   */
> -void qos_node_contains(const char *container, const char *contained, ...);
> +void qos_node_contains(const char *container, const char *contained,
> +                       QOSGraphEdgeOptions *opts, ...);
>  
>  /**
>   * qos_node_produces(): creates an edge of type QEDGE_PRODUCES and
> 

