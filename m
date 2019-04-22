Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F26C10F11
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 22:22:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C78A3205F4
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 22:22:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C78A3205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45050 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIhK5-0006gm-U1
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 18:22:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIhIX-0005Wr-Ny
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 18:20:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIhIW-00008X-CH
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 18:20:25 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38881)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hIhIW-00007p-1w
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 18:20:24 -0400
Received: by mail-wm1-f66.google.com with SMTP id w15so16118068wmc.3
	for <qemu-devel@nongnu.org>; Mon, 22 Apr 2019 15:20:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=fmlT+uvn+HzUkm0kC4nK+zrgB+DlqOOgi6KWsb635jY=;
	b=X3zV1wNv50UXOcODjXN3174nmyulwyhQAcdt1+QOQsJ9GtvI57JOrmsx/PZTVQRKn7
	ZxrJfaXhiLU6eEZP1erndhj+Vsx4o1jz4YSSsEx4PPfxSqFBl4ClTv7kAHU1PUz7iL5N
	KgjtrMNQdURi3kYFuXargErsGEVRi51h7nkaJwvJYHdqzdiKq3lqLruRbO2y5hALFIPd
	YHlDQPoMF5qfPPdJFGNbJsfU/L2a2nflBawn/rur/VI4o+FJ8nUjaVvl8lZ/qShzPzPz
	AMQn+0FM6q2hZrXt/gHS9lvYr4amKcwt7RRDCPMutl+4cbqI4c/YjJBJhlKoSUHW10o2
	CMcw==
X-Gm-Message-State: APjAAAWaqTArGmA0+Idauaz14XHDO6VV2eugxOOwq1Qx65Qn67hOhXpX
	8NFTke93httsumTwJybNPZ5VFg==
X-Google-Smtp-Source: APXvYqx+KjLw3hm12hw8/tGfX1locTbGMGQCyAxADoqGHGNNDspw86yWU2SikbjNU5NfVjXimhbhWQ==
X-Received: by 2002:a1c:244:: with SMTP id 65mr285382wmc.42.1555971622711;
	Mon, 22 Apr 2019 15:20:22 -0700 (PDT)
Received: from [192.168.1.25] (atoulouse-656-1-803-163.w86-221.abo.wanadoo.fr.
	[86.221.12.163]) by smtp.gmail.com with ESMTPSA id
	n1sm10547274wmc.19.2019.04.22.15.20.21
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 22 Apr 2019 15:20:22 -0700 (PDT)
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20190422210448.2488-1-ehabkost@redhat.com>
	<20190422210448.2488-3-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <1058eb0f-2842-85dc-4896-c5937352783b@redhat.com>
Date: Tue, 23 Apr 2019 00:20:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190422210448.2488-3-ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH 2/3] qtest: Don't compile qtest accel on
 non-POSIX systems
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190422222021.mvJl5l1VnUwb7smZzgJ4NmLeLySAhwrc-WpBd5PqmJ8@z>

On 4/22/19 11:04 PM, Eduardo Habkost wrote:
> qtest_available() will always return 0 on non-POSIX systems.
> It's simpler to just not compile the accelerator code on those
> systems instead of relying on the AccelClass::available function.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
mingw64:
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  include/sysemu/qtest.h | 9 ---------
>  accel/qtest.c          | 1 -
>  accel/Makefile.objs    | 2 +-
>  3 files changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/include/sysemu/qtest.h b/include/sysemu/qtest.h
> index 70aa40aa72..096ddfc20c 100644
> --- a/include/sysemu/qtest.h
> +++ b/include/sysemu/qtest.h
> @@ -27,13 +27,4 @@ bool qtest_driver(void);
>  
>  void qtest_init(const char *qtest_chrdev, const char *qtest_log, Error **errp);
>  
> -static inline int qtest_available(void)
> -{
> -#ifdef CONFIG_POSIX
> -    return 1;
> -#else
> -    return 0;
> -#endif
> -}
> -
>  #endif
> diff --git a/accel/qtest.c b/accel/qtest.c
> index a02b3c26c7..5b88f55921 100644
> --- a/accel/qtest.c
> +++ b/accel/qtest.c
> @@ -34,7 +34,6 @@ static void qtest_accel_class_init(ObjectClass *oc, void *data)
>  {
>      AccelClass *ac = ACCEL_CLASS(oc);
>      ac->name = "QTest";
> -    ac->available = qtest_available;
>      ac->init_machine = qtest_init_accel;
>      ac->allowed = &qtest_allowed;
>  }
> diff --git a/accel/Makefile.objs b/accel/Makefile.objs
> index 2a5ed46940..8b498d39d8 100644
> --- a/accel/Makefile.objs
> +++ b/accel/Makefile.objs
> @@ -1,5 +1,5 @@
>  obj-$(CONFIG_SOFTMMU) += accel.o
> -obj-$(CONFIG_SOFTMMU) += qtest.o
> +obj-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_POSIX)) += qtest.o
>  obj-$(CONFIG_KVM) += kvm/
>  obj-$(CONFIG_TCG) += tcg/
>  obj-y += stubs/
> 

