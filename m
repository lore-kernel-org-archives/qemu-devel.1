Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4E1FA3732
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 09:09:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43F392089C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 09:09:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43F392089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL1my-0007OC-FF
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 05:09:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49859)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iL1m8-0006Ya-Bf
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 05:08:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iL1m7-0001Wa-1Y
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 05:08:52 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:36997)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iL1m6-0001VB-Oo
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 05:08:50 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1N7Qgn-1hyNYT2dlF-017nOi; Thu, 17 Oct 2019 11:08:40 +0200
Subject: Re: [PATCH] ui: fix keymap file search in input-barrier object
References: <20190923220658.27007-1-laurent@vivier.eu>
To: Gerd Hoffmann <kraxel@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <3aeb80b7-0c8b-7baa-aa99-f654e43b1537@vivier.eu>
Date: Thu, 17 Oct 2019 11:08:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190923220658.27007-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:fPqL7UAr2uV4DF+CjU6JzX/gXJcY/B1zN2n+nXKKOEkNCrCsft/
 NaSu0wzprTcTqw7nQJl+MQ5800Fu012R9Q70xjHdQuVuYV2RdQATbY1YS84SYsNwm26RDaU
 ZDLYNCSAWjTh6gv/tvEudGGpyPrntrvPHEyPRb9roW20WQ1hC2uOAB3Ek10IQE5HHkgG6PI
 BRJUsafE8UVxGvcnJmIiA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ASvA9nVmmT0=:PNhjpTC29xSm2GQU4rchAf
 QNJB76kcMfqC0C8utUlWNd1DzAtoBhuA5d76kGlmyTcL3rTVPFzCKfBvkHuJhNvQAiuSq2Oo0
 KwD0fzAWzwkVMdKj16raChJ9B/t5T8gwGY5KPajbDTm5tF/ZOUIsIwfU/0F+ggSOd06mxaTxZ
 v2kGYraf2XTmBGhFlUPzd2rNAFxQ5PGBXnFNr66hwx/Q5s0O5AlKM+LNlF6zTxph373a+0ClM
 2m/p8W1yydBMgU005AAnyfA/XNzHiAl5XTmQ2uHsI0nv0EzBsqv0J2nm7mgqoUyKHxYnem+Hx
 tlMzbDjihWUvyQi7hZIQyXFw/48iguv/4NXWCVhpZLs2XnBJIVNkh63iJzZPUY9R92ff7KRKB
 cBoUTYcut6bc6hSnlBnMoklgVGZ41JeReuQcry0c11+wzBVhkFCjH246JDnJN5xKbAB9lL/cR
 vyQO7sNAyQNDFOjynyeQNt/7KAkQSCvA6hlKvKQHKJLLgh6TT+2l22K6GnHtytiQ5DNFYADV7
 lrs2xNR1ydogom85y/+3Jg9AuhNbvmuYTMOozWwl4X5OgsGBR1G+V32T1OO4G5PyD/lqfcisx
 +oUYsEsz5QqDYkcRM61DwCQE/zC4ZG6+BNHvUKXtRuPew/CjuOIvWS8pBho1ZpMQc7QcIf9Z/
 fEPWwPS55f0B66791LhbvflG7yftigxdskTgYapN7WKC7y4mmQO2qjqPnrCqUgFOAW+0fFg9f
 fAaLw+TPy7voak9ZBvRsqjV+fiLGfeRUy8wiOZYoRcOF7SCkJ16Rr7/g4w1pNzQSp1AJIUCu/
 cmmPxJBbYj6X8/P82spVU3j5/OEy11FQ64QBLf7XYup5ScJgF9HSd2Fc8lU181h3CGiJGxmZC
 8xJmUTJ839FVNGEdF1d1wx6dSO8/1lans3bJmp2ZQ=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.134
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
Cc: Anthony PERARD <anthony.perard@citrix.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping?

Le 24/09/2019 à 00:06, Laurent Vivier a écrit :
> If we try to start QEMU with "-k en-us", qemu prints a message and exits
> with:
> 
>     qemu-system-i386: could not read keymap file: 'en-us'
> 
> It's because this function is called way too early, before
> qemu_add_data_dir() is called, and so qemu_find_file() fails.
> 
> To fix that, move init_keyboard_layout() from the class init function to the
> instance init function.
> 
> Reported-by: Anthony PERARD <anthony.perard@citrix.com>
> Fixes: 6105683da35b ("ui: add an embedded Barrier client")
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  ui/input-barrier.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/ui/input-barrier.c b/ui/input-barrier.c
> index a2c961f285a4..fe35049b83a2 100644
> --- a/ui/input-barrier.c
> +++ b/ui/input-barrier.c
> @@ -682,6 +682,13 @@ static void input_barrier_instance_init(Object *obj)
>  {
>      InputBarrier *ib = INPUT_BARRIER(obj);
>  
> +    /* always use generic keymaps */
> +    if (keyboard_layout && !kbd_layout) {
> +        /* We use X11 key id, so use VNC name2keysym */
> +        kbd_layout = init_keyboard_layout(name2keysym, keyboard_layout,
> +                                          &error_fatal);
> +    }
> +
>      ib->saddr.type = SOCKET_ADDRESS_TYPE_INET;
>      ib->saddr.u.inet.host = g_strdup("localhost");
>      ib->saddr.u.inet.port = g_strdup("24800");
> @@ -719,13 +726,6 @@ static void input_barrier_class_init(ObjectClass *oc, void *data)
>      UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
>  
>      ucc->complete = input_barrier_complete;
> -
> -    /* always use generic keymaps */
> -    if (keyboard_layout) {
> -        /* We use X11 key id, so use VNC name2keysym */
> -        kbd_layout = init_keyboard_layout(name2keysym, keyboard_layout,
> -                                          &error_fatal);
> -    }
>  }
>  
>  static const TypeInfo input_barrier_info = {
> 


