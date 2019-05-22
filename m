Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05840C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 11:48:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9DC62173C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 11:48:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9DC62173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40963 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTPjW-0007G9-02
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 07:48:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hTPiU-0006w9-47
	for qemu-devel@nongnu.org; Wed, 22 May 2019 07:47:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hTPiT-0007uz-1S
	for qemu-devel@nongnu.org; Wed, 22 May 2019 07:47:30 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37820)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hTPiS-0007tp-Qg
	for qemu-devel@nongnu.org; Wed, 22 May 2019 07:47:28 -0400
Received: by mail-wm1-f66.google.com with SMTP id 7so1877823wmo.2
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 04:47:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=eVUjS9C2MdPYE8tA8n1OgpSIkB/ZJdDIV6fMd/Pa2Rc=;
	b=CqctoKC5/2KC6AooDGcpj+SSlOlUDjaxl/6GPWsIY+n1jTtOurbkMsNTBtdUAFCySg
	GrwTWdyEB1K/zEytzBaGHnebUaGP4h25CjP6t6FREf0yGthLZPx1MtPfZ9oWNIV/eXQb
	XaURe2fXo17a9M7PWbKC9KRwLbF6Ak0rKaAdtXn5Qob5gahl7eizC2BYa3FCUwVGBYOL
	sNVNd6GaJLhDFyxkPEC4I1HuJGYKbjtyByeuMaMjrq9eC7M1oMEHXFiQbTRZHSIo2Kik
	TZYMdq75zHsK1H/+cMS4JD7n8VUmdVd2T8NyT6gVrrImA5I9UsNMGoXH4CRy2bBeBZ2l
	2AuA==
X-Gm-Message-State: APjAAAXfnFBXtPwzJSaDKSskBRMNKRdRAFBoAiAJFP1fySFzDEABhzfu
	qIE8AZ+HEx/4c5S1d2XEUt9g3Q==
X-Google-Smtp-Source: APXvYqySo6o6bWgrHcOjsHNVgetXFfKKz3E9QzskdLuEUcfuvI1dRo4O/vkLOf2jP5z6FCC/qzmH/g==
X-Received: by 2002:a05:600c:2116:: with SMTP id
	u22mr7008701wml.58.1558525647480; 
	Wed, 22 May 2019 04:47:27 -0700 (PDT)
Received: from [10.201.33.53] ([195.166.127.210])
	by smtp.gmail.com with ESMTPSA id
	d17sm18989772wrw.18.2019.05.22.04.47.26
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Wed, 22 May 2019 04:47:26 -0700 (PDT)
To: Cornelia Huck <cohuck@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20190521152810.21353-1-cohuck@redhat.com>
	<20190521152810.21353-3-cohuck@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <6e216877-60be-ddcd-3f15-604e870ca8ba@redhat.com>
Date: Wed, 22 May 2019 13:47:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190521152810.21353-3-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PULL v3 47/55] linux headers: update against
 Linux 5.2-rc1
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
Cc: qemu-s390x@nongnu.org,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
	Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/21/19 5:28 PM, Cornelia Huck wrote:
> commit a188339ca5a396acc588e5851ed7e19f66b0ebd9
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
[...]
>  #define __NR_mq_notify 184
>  __SC_COMP(__NR_mq_notify, sys_mq_notify, compat_sys_mq_notify)
>  #define __NR_mq_getsetattr 185
> @@ -536,8 +567,10 @@ __SC_COMP(__NR_msgsnd, sys_msgsnd, compat_sys_msgsnd)
>  __SYSCALL(__NR_semget, sys_semget)
>  #define __NR_semctl 191
>  __SC_COMP(__NR_semctl, sys_semctl, compat_sys_semctl)
> +#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
>  #define __NR_semtimedop 192
> -__SC_COMP(__NR_semtimedop, sys_semtimedop, compat_sys_semtimedop)
> +__SC_COMP(__NR_semtimedop, sys_semtimedop, sys_semtimedop_time32)
> +#endif
>  #define __NR_semop 193
>  __SYSCALL(__NR_semop, sys_semop)
[...]

https://app.shippable.com/github/qemu/qemu/runs/1703/summary/console

It seems this commit introduce a regression on mips32:

  CC      mipsel-linux-user/linux-user/syscall.o
./linux-user/syscall.c: In function 'safe_semtimedop':
./linux-user/syscall.c:697:25: error: '__NR_semtimedop' undeclared
(first use in this function)
     return safe_syscall(__NR_##name, arg1, arg2, arg3, arg4); \
                         ^
./linux-user/syscall.c:769:1: note: in expansion of macro 'safe_syscall4'
 safe_syscall4(int, semtimedop, int, semid, struct sembuf *, tsops,
 ^~~~~~~~~~~~~
./linux-user/syscall.c:697:25: note: each undeclared identifier is
reported only once for each function it appears in
     return safe_syscall(__NR_##name, arg1, arg2, arg3, arg4); \
                         ^
./linux-user/syscall.c:769:1: note: in expansion of macro 'safe_syscall4'
 safe_syscall4(int, semtimedop, int, semid, struct sembuf *, tsops,
 ^~~~~~~~~~~~~
./linux-user/syscall.c:770:45: error: control reaches end of non-void
function [-Werror=return-type]
               unsigned, nsops, const struct timespec *, timeout)
                                             ^
./linux-user/syscall.c:695:61: note: in definition of macro 'safe_syscall4'
 static type safe_##name(type1 arg1, type2 arg2, type3 arg3, type4 arg4) \
                                                             ^~~~~
cc1: all warnings being treated as errors
./rules.mak:69: recipe for target 'linux-user/syscall.o' failed
make[1]: *** [linux-user/syscall.o] Error 1
Makefile:458: recipe for target 'subdir-mipsel-linux-user' failed
make: *** [subdir-mipsel-linux-user] Error 2

