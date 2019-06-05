Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41652C282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 08:58:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B7A22075C
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 08:58:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B7A22075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37697 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYRkz-0002Au-4L
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 04:58:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hYRkF-0001rr-4y
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 04:58:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hYRkE-0004EE-5L
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 04:58:07 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33020)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hYRkD-0003ev-Uz
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 04:58:06 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so6167389wru.0
	for <qemu-devel@nongnu.org>; Wed, 05 Jun 2019 01:57:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=dgBH8xsFsCM56UpHYQXks4m/hjEYSAZAzTFBBJIOJc4=;
	b=Ua6WeFiNsXbkjoEJoNvm8fzm/KIpQGkM78IZkDXJXuo4UrhJShXqy8imAvfR9wkiIy
	RlMkneGfliIRMJSTdUSwCt3k3mZ871Qw0UEMEuA3xoWWOuOD1iHQLP2pVVlpzw8qbadk
	cniZPl0XjXcXYgJXBpKli7id15q4ntEOOGK23zd5mP5fZ/0cgSeD7LVgMEapadIHpKfn
	kFUG3GTCheySKDRu9agK6OfE6ikqoq6FBRAfPlUEAv4zmCqfoMdc6bbAQZm0zD0srPbU
	UVQBj6kcXHyvQ3wCURskCkGz+rJyxylRDDyD0h/gLrcbspBmcQyQwHJsbfmdFodCwtxv
	/jTg==
X-Gm-Message-State: APjAAAUlhApZcyxQuQDXsZBdqfiAq7Wf4IGNaTtTMk1t9CF5oXLYr7Bl
	DaHNIidRjmTAR1rrFsBzNK/0UQ==
X-Google-Smtp-Source: APXvYqwGUlpEWp5x95Rd9KzAzmYvWP9xzEUI2miMhD7CYzW828wFVW7YTjQRLqxVP+cddSxtOXb8ww==
X-Received: by 2002:a5d:6b90:: with SMTP id n16mr24773934wrx.206.1559725067277;
	Wed, 05 Jun 2019 01:57:47 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
	[88.21.202.183]) by smtp.gmail.com with ESMTPSA id
	q14sm16946719wrw.60.2019.06.05.01.57.46
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Wed, 05 Jun 2019 01:57:46 -0700 (PDT)
To: Lidong Chen <lidong.chen@oracle.com>, qemu-devel@nongnu.org
References: <cover.1559710447.git.lidong.chen@oracle.com>
	<2410fe0d6dc7d5afdec8e3b8901b32e71ed303a5.1559710447.git.lidong.chen@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <9fdf1275-b2b5-c823-9213-2f3021ebd6a8@redhat.com>
Date: Wed, 5 Jun 2019 10:57:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <2410fe0d6dc7d5afdec8e3b8901b32e71ed303a5.1559710447.git.lidong.chen@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [Qemu-devel PATCH v2 2/2] util/main-loop: Fix
 incorrect assertion
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, liran.alon@oracle.com,
	liq3ea@gmail.com, armbru@redhat.com, darren.kenny@oracle.com,
	marcandre.lureau@gmail.com, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch doesn't seem related to the series cover.

On 6/5/19 8:21 AM, Lidong Chen wrote:
> The check for poll_fds in g_assert() was incorrect. The correct assertion
> should check "n_poll_fds + w->num <= ARRAY_SIZE(poll_fds)" because the
> subsequent for-loop is doing access to poll_fds[n_poll_fds + i] where i
> is in [0, w->num).
> 

Suggested-by: Peter Maydell <peter.maydell@linaro.org>

> Signed-off-by: Lidong Chen <lidong.chen@oracle.com>
> Reviewed-by: Liran Alon <liran.alon@oracle.com>
> Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  util/main-loop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/util/main-loop.c b/util/main-loop.c
> index e1e349c..a9f4e8d 100644
> --- a/util/main-loop.c
> +++ b/util/main-loop.c
> @@ -422,7 +422,7 @@ static int os_host_main_loop_wait(int64_t timeout)
>      g_main_context_prepare(context, &max_priority);
>      n_poll_fds = g_main_context_query(context, max_priority, &poll_timeout,
>                                        poll_fds, ARRAY_SIZE(poll_fds));
> -    g_assert(n_poll_fds <= ARRAY_SIZE(poll_fds));
> +    g_assert(n_poll_fds + w->num <= ARRAY_SIZE(poll_fds));
>  
>      for (i = 0; i < w->num; i++) {
>          poll_fds[n_poll_fds + i].fd = (DWORD_PTR)w->events[i];
> 

