Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7066CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 18:27:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC88120578
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 18:27:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC88120578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNhpB-0002U7-I5
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 14:27:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40099)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iNgsc-0005QT-GP
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 13:26:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iNgsa-0006KO-8g
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 13:26:34 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:58911)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iNgsY-0006HT-8C; Thu, 24 Oct 2019 13:26:30 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MnaTt-1hgPYw3RLx-00jWFm; Thu, 24 Oct 2019 19:26:23 +0200
Subject: Re: [PATCH 1/3] util/async: avoid useless cast
To: Frediano Ziglio <fziglio@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
References: <20191023122652.2999-1-fziglio@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <17410622-d980-730d-ae77-9fa53a64a9d4@vivier.eu>
Date: Thu, 24 Oct 2019 19:26:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191023122652.2999-1-fziglio@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:k1hPNn20zvIcs/x7bUo89AxCJEyYRCM6OJP4pp/MJ200PRAPkIH
 veCJ+d2ta61yCV6/6hBhvDkOXjJzE5Dkk2ZCm1NueNz0gZNxgLlRNH3/Qwd5w8N6Re+IEvG
 oxzVJKim+PBs8SiUyHW1tpZHuAWbSabmJXYv/uMFXGF6soBa//oYpielE9pR2mb7Rl8UgsY
 XuVeU2i+XMTqF7JKsjz1Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ku2i3mIkSKU=:qLYETMCEAg82cqCZzuoEQF
 8uwECz/9qKBvdVkpJvULtiVoydEhjpa2FQy4stBeonv9jaW+8t9Onbrrr8M0AHKQZAym50PKZ
 sp6jvdtyXEBzkT5s5cCfe2HNaq27iXlkGSuFypM1ZiPUx8uSVo/ZxwoYAG81GrV0GbckW1mVr
 MbfUZcBRHyUe/0z0RNxB5XtaCFu9maOMR4FAbbVewQDHQfgcrw5YC8rDEukXssvP5N3+mxS0G
 2v7HJEYO5ynXnR9uwdkSfw+ezM/oahPiv24zf9GydZuSTXSjKSiDOUMBT6Z5ZSf6S6nWfLTBb
 v0izP5xCHVD0vrmUyrOMlY4kOPaaZLOd+VEADn9cOv8G3cCdwYe2WhE0o80iQ4gcnSn2cCJZ7
 sc0yj46uQEOXFvo5xh75xsXunfB/snJ3k5xytjSL7bHo+51VJhkEjCDtTcmrdE4y401uW7pms
 0feQ6RB4Ssph8SvlmyRFzkiqnkxfGvBDg7aazbgnyXXLD/DZIv0PRAObp3u5jXZIVQ3epnIt/
 MvTQUCQRCkiEHBLak57ZnUxhjndOMDeT3EaAxB7yj99yn/XXOEWkl5OtJhVhzs/g0ZRaRooe6
 EI5YBsFnj0JAxGYp/lWdwmt/eVTXM0XgRch6/e5fsu2LIH3iZyKsCZIGhOL3KqudluLYl/0kb
 fhsDZKKFryBVWFgzAUc9s1VN755kf5TPzaatR/f5dtSNSYy8zuZQz8zNtiJa1KQkiw4SelhXL
 3OoZkZgdM/nI2bLyrQ5DcnxoNOJxpUNq0LZTld51TZGbJNQXD7/5MwSNyWwaEcx1x604ViQc5
 GPgSghQpKjjJ57/khgGMVVGd5VGxAeu5f25LJKZV8zEHa1vCk6yJJg0QS7KG9mgqF+E0qSKdK
 OqrI+XlNkYub0OkWEH2oYbPPTXKMfMZEOgDapslYo=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.187
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 23/10/2019 à 14:26, Frediano Ziglio a écrit :
> event_notifier_dummy_cb is already compatible with EventNotifierHandler.
> 
> Signed-off-by: Frediano Ziglio <fziglio@redhat.com>
> ---
>  util/async.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/util/async.c b/util/async.c
> index ca83e32c7f..b1fa5319e5 100644
> --- a/util/async.c
> +++ b/util/async.c
> @@ -429,7 +429,6 @@ AioContext *aio_context_new(Error **errp)
>  
>      aio_set_event_notifier(ctx, &ctx->notifier,
>                             false,
> -                           (EventNotifierHandler *)
>                             event_notifier_dummy_cb,
>                             event_notifier_poll);
>  #ifdef CONFIG_LINUX_AIO
> 

Applied to my trivial-patches branch.

Thanks,
Laurent

