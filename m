Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9F4C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 15:57:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F23792186A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 15:57:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F23792186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoVGA-0003SJ-7A
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 11:57:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36924)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hoVFz-00030e-Vb
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 11:57:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hoVFh-0001PM-FZ
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 11:57:01 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37648)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hoVFP-0000Cz-QP
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 11:56:43 -0400
Received: by mail-wm1-f66.google.com with SMTP id f17so29468172wme.2
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 08:53:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=J41fUfVIJ5Ra3tQ4MoeIoCpV24vRR4c2zNpyUQxDXXY=;
 b=Vd5ZZbeQnPOSC+PhZBtfGLTRU8+PFhdYaTNlBzoKnVW0gxr7KVTuDtBeLUr1fIHcXu
 PiLTKPmLQSFfWdQBETI0KlP4TCASBMR34vDoA/JGlqEIGVCZT298L5+0OBtlkMxRAuBK
 cJlZ96R67zqAmXzTO+hVGyYTsFQKsi5/jrlOBDjLr56mcOojtolN25Otn17DVn9Z2EVf
 mJeUlBFeEyHCSUQrR+spQ7cYOCRbYXba8eE6bme17UjLN2Dk9hOF7Leezd2+W6O6HJgB
 N8nt8LTlkLm5P7IndIF/OsNL6TuEsWqdky3JU92Gc71ZuHH9Y5KdCJIXKLVjBjjLmEKf
 q0/Q==
X-Gm-Message-State: APjAAAWuLiwKBhir5zJNPoAZkEutenQ1Vqzhm2ygbMuk6Vy5XsM5hh7b
 T/ckA2tVee/TDu0CMCTx2B5YMA==
X-Google-Smtp-Source: APXvYqy+awTUTsqqoqeGo9k6cYpDAnV3bpyMDHrad0AjwwXWuSF52ZACwpynduKGoiFN5XnOk5pkrg==
X-Received: by 2002:a1c:9dc5:: with SMTP id g188mr50044109wme.93.1563551633678; 
 Fri, 19 Jul 2019 08:53:53 -0700 (PDT)
Received: from [192.168.1.37] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id f192sm37396701wmg.30.2019.07.19.08.53.52
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 19 Jul 2019 08:53:53 -0700 (PDT)
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20190719150313.29198-1-eblake@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <fd58019b-7317-4d0c-8632-75e30979eedb@redhat.com>
Date: Fri, 19 Jul 2019 17:53:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190719150313.29198-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH] nbd: Initialize reply on failure
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Thomas Huth <thuth@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/19/19 5:03 PM, Eric Blake wrote:
> We've had two separate reports of a caller running into use of
> uninitialized data if s->quit is set (one detected by gcc -O3, another
> by valgrind), due to checking 'nbd_reply_is_simple(reply) || s->quit'
> in the wrong order. Rather than chasing down which callers need to
> pre-initialize reply, it's easier to guarantee that reply will always
> be set by nbd_co_receive_one_chunk() even on failure.
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Reported-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
> 
> Replaces: https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg04477.html
> Replaces: https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg03712.html
> 
>  block/nbd.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/block/nbd.c b/block/nbd.c
> index 8d565cc624ec..f751a8e633e5 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -640,6 +640,7 @@ static coroutine_fn int nbd_co_receive_one_chunk(
>                                            request_ret, qiov, payload, errp);
> 
>      if (ret < 0) {
> +        memset(reply, 0, sizeof *reply);

I never had problem with sizeof without parenthesis, but here I find it
not easy to review.

Anyhow, this definitively looks like 4.1 material.

Preferently with sizeof(), but I don't mind, so:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>          s->quit = true;
>      } else {
>          /* For assert at loop start in nbd_connection_entry */
> 

