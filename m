Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5311C7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 15:17:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B8D42173B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 15:17:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B8D42173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnPD2-0002HX-9M
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 11:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57216)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hnPCp-0001rj-JO
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 11:17:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hnPCo-0006Nw-K2
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 11:17:27 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55045)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hnPCo-0006Ng-Dw
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 11:17:26 -0400
Received: by mail-wm1-f67.google.com with SMTP id p74so19042115wme.4
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 08:17:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NgIxx5jWq23bTnzRZIW6yqTSGa5Zs+czQ6jBrOjPPSo=;
 b=WPyGM6gaTkNCS/C05AlMVDPF17Sik67E7LG0G5hOoHTRevW0qItL2S4IElkmp66EbI
 To5hvWh/Nemzk9awlNVbZnG0+qLLBWaMhGY3bjeItSwBulZFbZeFGI1szzTyAJwGAj3A
 2/zjZJdVjgr56LhoHJTTX48urERzThPcng2NvLsz7hi+GBt8OL3bqYPLSA3jyKCGbusd
 iHDpVtZiAkFLjhTW6Y4CL5gWpI7DrGjbmAtnvLczdlaP15d4UmGO242IxtkkuP8+9XM3
 5pR//+Je5gN430ASBmoQX0IDlkfYvyKWeA/KVKFghsIgGRrzVjTOGBuPh/FJOrPqg2IG
 1HGg==
X-Gm-Message-State: APjAAAUa5t7iubRdUcU+WY/YQOaWid/YTzvow6bsITby8u3iXvCyYlkN
 Q9wCZ5O8iGaGyxjAo9caJ2m0BQ==
X-Google-Smtp-Source: APXvYqxj0igqutRkr+xxikqu4Pfo4sRJO8vVW4g0O7qcPKtBLocpRX8sft+B7HD/s4mJTfhWz26Tyg==
X-Received: by 2002:a1c:7e90:: with SMTP id
 z138mr30160562wmc.128.1563290245403; 
 Tue, 16 Jul 2019 08:17:25 -0700 (PDT)
Received: from [192.168.1.38] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id g19sm23025453wmg.10.2019.07.16.08.17.24
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jul 2019 08:17:24 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190716140133.8578-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <935ee13e-e980-5831-e048-a6e51f013f79@redhat.com>
Date: Tue, 16 Jul 2019 17:17:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190716140133.8578-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [RFC PATCH for 4.1] linux-user: unparent CPU
 object before unref
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/16/19 4:01 PM, Alex Bennée wrote:
> When a CPU object is created it is parented during it's realize stage.
> If we don't unparent before the "final" unref we will never finzalize

"finalize"

> the object leading to a memory leak. For most setups you probably
> won't notice but with anything that creates and destroys a lot of
> threads this will add up. This goes especially for architectures which
> allocate a lot of memory in their CPU structures.
> 
> Fixes: https://bugs.launchpad.net/qemu/+bug/1836558
> Cc: 1836558@bugs.launchpad.net
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  linux-user/syscall.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 39a37496fed..4c9313fd9d0 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -7183,6 +7183,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>                            NULL, NULL, 0);
>              }
>              thread_cpu = NULL;
> +            object_unparent(OBJECT(cpu));
>              object_unref(OBJECT(cpu));
>              g_free(ts);
>              rcu_unregister_thread();
> 

