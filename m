Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDE1C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 14:51:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC412206A2
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 14:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qCS+3YzM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC412206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhxeU-0003rp-3k
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 10:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52877)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hhxAC-0005Gz-5i
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 10:20:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hhxAA-0000L8-Nu
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 10:20:11 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36737)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hhxAA-0000JQ-GT
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 10:20:10 -0400
Received: by mail-wr1-x443.google.com with SMTP id n4so14109020wrs.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 07:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=e0eSTWXS81cyAjTjY0gOE2I9p8eua4Cc+NKwToq5OhQ=;
 b=qCS+3YzMH5TytIhyob+MfY5Cq+y6Dv7r+S2QEAu8ym8Ds/ADPPplUpcG4VVtNoeijY
 v38+vxwy01N8I0BYfy4T6DN17705O/oF0kauRTbHLlHGnOPLYzA+SaM5lxsGU8HkbYkj
 N7LtFazXze1rJ5dVIF5AtrjQcCQKRB/rRSwzyBKcy9U3lAn63CeRpRnLm+g1GurHeQ9g
 ZmNZN/IlDqjMWLn8Yc4D1ijXKXd7yRIcMdxYkMwN28YSzuNQpwimT813OCVrHpVW75+I
 /J4uY+KXNbS1nqbI+jjTtHtNkHlVBG9lpIDuKE18lXTexcfdYYwK857OVo6mmUXQ84Bn
 tQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=e0eSTWXS81cyAjTjY0gOE2I9p8eua4Cc+NKwToq5OhQ=;
 b=EgDhH9Pajbnh4QhXaA/kprNWrbHdoRt84BMQm7/C0kTYOoh56ENFnuIr56DrS6bYTZ
 shaa+cXpWsuNRQ6SptFKQck+/WBOqZYkoio5KMy9pvra5ncZXbGkmPjaqAFm1J2G18Jx
 lcnp1y5vCONklgHK2c+yWu1apwrdMH7NuNL/lEykqv/dkWxPt1ZVSp7A2vNTC1zbL/dR
 tqx1gY+KmuDCrM4WbmqojtCRfRp/v4ISO5ii6ReneXj6wJDAJGfMMq6PyhmJJyvCnSQK
 OMyNSmIvf9RL/pWaywLBBxIx7TS2FIQ82iw1e34BeOtSS8eoyAnwI1TOMvVxikgYh3hG
 xQGA==
X-Gm-Message-State: APjAAAWz9s90v7m6bLmzQuv5PyRQKzYNhBr5hrdpFnjOuGOiUbaSAmUD
 6mz0FrBQ3L4u7GD/z9JQ0ad5UA==
X-Google-Smtp-Source: APXvYqwJi3i7w+n44L2hFuVkagyXwwFtC9jHezUXyc/+TlFREM6lVxTG75yGtKn6hIi7vH7rv4aDXQ==
X-Received: by 2002:adf:f812:: with SMTP id s18mr19603583wrp.32.1561990808350; 
 Mon, 01 Jul 2019 07:20:08 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id j7sm14760231wru.54.2019.07.01.07.20.07
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 01 Jul 2019 07:20:07 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 300551FF87;
 Mon,  1 Jul 2019 15:20:07 +0100 (BST)
References: <20190614171200.21078-1-alex.bennee@linaro.org>
 <20190614171200.21078-23-alex.bennee@linaro.org>
 <CADYwmhFz6jjhK0_D1WGMqLcV5XvWaT5mRgtfbbhrU8vchuoAZA@mail.gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pranith Kumar <bobby.prani@gmail.com>
In-reply-to: <CADYwmhFz6jjhK0_D1WGMqLcV5XvWaT5mRgtfbbhrU8vchuoAZA@mail.gmail.com>
Date: Mon, 01 Jul 2019 15:20:07 +0100
Message-ID: <878sthsup4.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v3 22/50] *-user: plugin syscalls
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
Cc: Riku Voipio <riku.voipio@iki.fi>, "Emilio G. Cota" <cota@braap.org>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Pranith Kumar <bobby.prani@gmail.com> writes:

> Minor nits.
>
> On Fri, Jun 14, 2019 at 11:41 AM Alex Benn=C3=A9e <alex.bennee@linaro.org=
> wrote:
>>
>> From: "Emilio G. Cota" <cota@braap.org>
>>
>> Signed-off-by: Emilio G. Cota <cota@braap.org>
>> ---
>>  bsd-user/syscall.c   | 9 +++++++++
>>  linux-user/syscall.c | 3 +++
>>  2 files changed, 12 insertions(+)
>>
>> diff --git a/bsd-user/syscall.c b/bsd-user/syscall.c
>> index 84a983a9a1..50e47d217c 100644
>> --- a/bsd-user/syscall.c
>> +++ b/bsd-user/syscall.c
>> @@ -323,6 +323,8 @@ abi_long do_freebsd_syscall(void *cpu_env, int num, =
abi_long arg1,
>>      gemu_log("freebsd syscall %d\n", num);
>>  #endif
>>      trace_guest_user_syscall(cpu, num, arg1, arg2, arg3, arg4, arg5, ar=
g6, arg7, arg8);
>> +    qemu_plugin_vcpu_syscall(cpu, num, arg1, arg2, arg3, arg4, arg5, ar=
g6, arg7,
>> +                             arg8);
>
> Looking at the previous line, seems like you can avoid splitting this
> line into 2. Keeps it more consistent that way.

Technically the trace line is over-long... I can make them both
consistent with each other but it would be nicer to wrap them both into
a common function.

Unfortunately this seems a little tricky for *-user as they are kept
pretty separate.

>
>>      if(do_strace)
>>          print_freebsd_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
>>
>> @@ -404,6 +406,7 @@ abi_long do_freebsd_syscall(void *cpu_env, int num, =
abi_long arg1,
>>      if (do_strace)
>>          print_freebsd_syscall_ret(num, ret);
>>      trace_guest_user_syscall_ret(cpu, num, ret);
>> +    qemu_plugin_vcpu_syscall_ret(cpu, num, ret);
>>      return ret;
>>   efault:
>>      ret =3D -TARGET_EFAULT;
>> @@ -422,6 +425,8 @@ abi_long do_netbsd_syscall(void *cpu_env, int num, a=
bi_long arg1,
>>      gemu_log("netbsd syscall %d\n", num);
>>  #endif
>>      trace_guest_user_syscall(cpu, num, arg1, arg2, arg3, arg4, arg5, ar=
g6, 0, 0);
>> +    qemu_plugin_vcpu_syscall(cpu, num, arg1, arg2, arg3, arg4, arg5, ar=
g6, 0,
>> +                             0);
>
> ditto.
>
>>      if(do_strace)
>>          print_netbsd_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
>>
>> @@ -480,6 +485,7 @@ abi_long do_netbsd_syscall(void *cpu_env, int num, a=
bi_long arg1,
>>      if (do_strace)
>>          print_netbsd_syscall_ret(num, ret);
>>      trace_guest_user_syscall_ret(cpu, num, ret);
>> +    qemu_plugin_vcpu_syscall_ret(cpu, num, ret);
>>      return ret;
>>   efault:
>>      ret =3D -TARGET_EFAULT;
>> @@ -498,6 +504,8 @@ abi_long do_openbsd_syscall(void *cpu_env, int num, =
abi_long arg1,
>>      gemu_log("openbsd syscall %d\n", num);
>>  #endif
>>      trace_guest_user_syscall(cpu, num, arg1, arg2, arg3, arg4, arg5, ar=
g6, 0, 0);
>> +    qemu_plugin_vcpu_syscall(cpu, num, arg1, arg2, arg3, arg4, arg5, ar=
g6, 0,
>> +                             0);
>
> ditto.
>
>>      if(do_strace)
>>          print_openbsd_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
>>
>> @@ -556,6 +564,7 @@ abi_long do_openbsd_syscall(void *cpu_env, int num, =
abi_long arg1,
>>      if (do_strace)
>>          print_openbsd_syscall_ret(num, ret);
>>      trace_guest_user_syscall_ret(cpu, num, ret);
>> +    qemu_plugin_vcpu_syscall_ret(cpu, num, ret);
>>      return ret;
>>   efault:
>>      ret =3D -TARGET_EFAULT;
>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>> index b187c1281d..7f3cfdee84 100644
>> --- a/linux-user/syscall.c
>> +++ b/linux-user/syscall.c
>> @@ -11724,6 +11724,8 @@ abi_long do_syscall(void *cpu_env, int num, abi_=
long arg1,
>>
>>      trace_guest_user_syscall(cpu, num, arg1, arg2, arg3, arg4,
>>                               arg5, arg6, arg7, arg8);
>> +    qemu_plugin_vcpu_syscall(cpu, num, arg1, arg2, arg3, arg4, arg5, ar=
g6, arg7,
>> +                             arg8);
>
> This I am not sure.
>
>
>>
>>      if (unlikely(do_strace)) {
>>          print_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
>> @@ -11736,5 +11738,6 @@ abi_long do_syscall(void *cpu_env, int num, abi_=
long arg1,
>>      }
>>
>>      trace_guest_user_syscall_ret(cpu, num, ret);
>> +    qemu_plugin_vcpu_syscall_ret(cpu, num, ret);
>>      return ret;
>>  }
>> --
>> 2.20.1
>>
>>


--
Alex Benn=C3=A9e

