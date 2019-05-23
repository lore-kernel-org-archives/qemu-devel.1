Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9ECAC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:19:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CE192075B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:19:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CE192075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36049 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTnco-0006t3-Ne
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 09:19:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hTnIY-0005W1-UJ
	for qemu-devel@nongnu.org; Thu, 23 May 2019 08:58:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hTnIX-0003gH-J5
	for qemu-devel@nongnu.org; Thu, 23 May 2019 08:58:18 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46652)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hTnIW-0003Z7-UW
	for qemu-devel@nongnu.org; Thu, 23 May 2019 08:58:17 -0400
Received: by mail-wr1-f65.google.com with SMTP id r7so6145570wrr.13
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 05:58:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=+t49dihkvC440Fv1Lq8bQbYkGfawugJ4sF+NR2cF2n8=;
	b=RXvQoqpP892BomK3C8b7wQjQIRCSyutpFKean3wYeBCteOveDyrRY6bvVoNV9yKhyI
	+y8QvxEsgtwdzHT55/fVcP3SVUFnKSjtAfTj8BZK4/tZ6Dz0/O79aa4HW5DzDKliwduI
	153DGwLQUD7+pL5NKos5FGphLUrUupGUZO7ZU9vAqPP88PkrfkTCfLeN5lGJ7zGlje4g
	rFblf9H6R7Y8jgKCJbMKxn8yMvupWtd5m7qTzdFcnPfVANRXUirvoLRi6hEahvVX4hJ+
	i9ZdcxcfN3mpFibCLxgsAILP58qBe1HCg4Qsg5dlHGEPlN5oTODrHzG/rc4eKSNjWNB1
	fA2g==
X-Gm-Message-State: APjAAAVgmOcO/KY/2r/VMfHJksdNJZKOBn5KEz5tiNkfcPipfmNTGkRY
	po0kU0bQ1S0CVBwVu8vEfB/wXw==
X-Google-Smtp-Source: APXvYqwBVqvW+8npuzBxYXAI8PMiuu6mjUOwdP/2znU+6+akRcwHCqFFqD2fqc0T4qggy/UkXr/6fg==
X-Received: by 2002:adf:ce90:: with SMTP id r16mr8017068wrn.156.1558616289841; 
	Thu, 23 May 2019 05:58:09 -0700 (PDT)
Received: from [192.168.1.38] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228]) by smtp.gmail.com with ESMTPSA id
	x9sm12238668wmf.27.2019.05.23.05.58.08
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 05:58:09 -0700 (PDT)
To: Laurent Vivier <laurent@vivier.eu>, Cornelia Huck <cohuck@redhat.com>,
	Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20190521152810.21353-1-cohuck@redhat.com>
	<20190521152810.21353-3-cohuck@redhat.com>
	<6e216877-60be-ddcd-3f15-604e870ca8ba@redhat.com>
	<20190522140729.25970e17.cohuck@redhat.com>
	<6b101b85-4985-4736-acad-59389b00de55@vivier.eu>
	<20190522142421.746f7495.cohuck@redhat.com>
	<CAL1e-=j5joi3ssA-7Q2PVp841ywj41Ntz_MSKdB4w27Z9JvcEQ@mail.gmail.com>
	<20190523135602.4c80c959.cohuck@redhat.com>
	<e01100bc-50ee-5cc2-2802-a098acc720ac@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <e3ce17c4-c1d6-20b4-0e7c-6c23e6a08e48@redhat.com>
Date: Thu, 23 May 2019 14:58:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e01100bc-50ee-5cc2-2802-a098acc720ac@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/23/19 2:30 PM, Laurent Vivier wrote:
> On 23/05/2019 13:56, Cornelia Huck wrote:
>> On Wed, 22 May 2019 15:22:23 +0200
>> Aleksandar Markovic <aleksandar.m.mail@gmail.com> wrote:
>>
>>> The alternative way of invoking via IPCV6 (else part of “ifdef
>>> __NR_MSGSND”) should work for MIPS in the present stage of headers and
>>> kernel.
>>
>> I tried to do that so that we have at least a workaround for now; but
>> this fails building on my x86 laptop (the safe_syscall6 for ipc
>> complains about missing __NR_ipc). Maybe I'm holding it wrong (should
>> that be conditional on the host?), but I think that really needs to be
>> done by the mips maintainers...
>>
> 
> Perhaps a simple workaround could be:
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index e311fcda0517..5b431736032c 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -761,14 +761,8 @@ safe_syscall2(int, nanosleep, const struct timespec *, req,
>  safe_syscall4(int, clock_nanosleep, const clockid_t, clock, int, flags,
>                const struct timespec *, req, struct timespec *, rem)
>  #endif
> -#ifdef __NR_msgsnd
> -safe_syscall4(int, msgsnd, int, msgid, const void *, msgp, size_t, sz,
> -              int, flags)
> -safe_syscall5(int, msgrcv, int, msgid, void *, msgp, size_t, sz,
> -              long, msgtype, int, flags)
> -safe_syscall4(int, semtimedop, int, semid, struct sembuf *, tsops,
> -              unsigned, nsops, const struct timespec *, timeout)
> -#else
> +
> +#ifdef __NR_ipc
>  /* This host kernel architecture uses a single ipc syscall; fake up
>   * wrappers for the sub-operations to hide this implementation detail.
>   * Annoyingly we can't include linux/ipc.h to get the constant definitions
> @@ -783,14 +777,30 @@ safe_syscall4(int, semtimedop, int, semid, struct sembuf *, tsops,
>  
>  safe_syscall6(int, ipc, int, call, long, first, long, second, long, third,
>                void *, ptr, long, fifth)
> +#endif
> +
> +#ifdef __NR_msgsnd
> +safe_syscall4(int, msgsnd, int, msgid, const void *, msgp, size_t, sz,
> +              int, flags)
> +#else
>  static int safe_msgsnd(int msgid, const void *msgp, size_t sz, int flags)
>  {
>      return safe_ipc(Q_IPCCALL(0, Q_MSGSND), msgid, sz, flags, (void *)msgp, 0);
>  }
> +#endif
> +#ifdef __NR_msgrcv
> +safe_syscall5(int, msgrcv, int, msgid, void *, msgp, size_t, sz,
> +              long, msgtype, int, flags)
> +#else
>  static int safe_msgrcv(int msgid, void *msgp, size_t sz, long type, int flags)
>  {
>      return safe_ipc(Q_IPCCALL(1, Q_MSGRCV), msgid, sz, flags, msgp, type);
>  }
> +#endif
> +#ifdef __NR_semtimedop
> +safe_syscall4(int, semtimedop, int, semid, struct sembuf *, tsops,
> +              unsigned, nsops, const struct timespec *, timeout)
> +#else
>  static int safe_semtimedop(int semid, struct sembuf *tsops, unsigned nsops,
>                             const struct timespec *timeout)
>  {
> 

Works for me!
I have no idea if this is the proper fix, but this fix my test setup.
Can you send a proper patch?

Thanks :)

Phil.

