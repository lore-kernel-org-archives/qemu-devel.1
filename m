Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FA7C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 10:59:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50F1520820
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 10:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KOvGPADx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50F1520820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49752 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfMhX-0007LQ-Fp
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 06:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50748)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hfMg7-0006si-MR
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 06:58:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hfMg6-0007Pr-KN
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 06:58:27 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:33895)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hfMg6-0007M9-Cx
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 06:58:26 -0400
Received: by mail-wm1-x342.google.com with SMTP id w9so13972287wmd.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 03:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=mxsXIae0jHJhD9qMhmOZ1UD7fM0YC33jCIgvSCj7eC4=;
 b=KOvGPADxXaan2/1eX9NJFzDyqpp/GgT5xTj4NctpZ7L0hWmtYtG4M4XmuprVsSYgj0
 VsRzkWAOHamUIbLbwrcF7SowsVxdxTb8Y7LYYdDC+Ob1CUflb94qo1oXtmLiR/hK6rtk
 DJJmnlmIH4kALPjWQwBUwXgt3KL4tv+dQPeB/8CcnOd+NoWeb7ccP7Sf/Kj2FuIY/ooh
 uJlkHbxZtEIv914S01p/hqEUqOaTXy5qfiVZT3bns6Tkuc5VsAxCGIatH99/oM5nuCsL
 WS30YSERzOQ+CU3/NKFZAXTY/0VflJEIQBTjA+hSo3nMOJtCp5SnB+89D5DnuVV+qnM/
 CyUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=mxsXIae0jHJhD9qMhmOZ1UD7fM0YC33jCIgvSCj7eC4=;
 b=qjSjfpAijunCdLoaV+b+FeQQTXZ2PvgumNMf/3aM8e2Bv3OEYbYwn2Qw9JMmvo+A00
 niM1jjj8v/0HPEXXk8kxHKw8EWr6Y/OB8jMOv5kYGTmPMDGoEMFsfbxpB0PukC6gFpvV
 j9KgcAhYcIAFbi4dE1dGO6XWS5ftRY5ZQp1AmcwwhJ7701Ew2aIPS+/6/wTJPVuCMJr5
 xGwbzlSR/DrU3ZPljxTiSllFFhW9gvK5N2XiAb96i6PhxxtiLh5U/IGU6BJ7OKzI5RX2
 ekllpxIAXJ3DFod/4UGZ8/mQ4RP9Qf4/S/J3WAFDuB/0ALm0lKBOID97vlrP3QU3d/zH
 nkwA==
X-Gm-Message-State: APjAAAXiB6EIAk4VuwHLk0BumB9/jujpP7RqsxI9SccFgZQhSbBqMNYK
 M+t3HXxwvytWS4milloLXNV1PK1jyok=
X-Google-Smtp-Source: APXvYqwqN8zIt9mhGB/Y896fb/Yh9YXteKU9NgeHS3LecM07QN3xJBWBoYCcvtL7rJLIVEPzLq10FQ==
X-Received: by 2002:a1c:c549:: with SMTP id v70mr15220921wmf.135.1561373904581; 
 Mon, 24 Jun 2019 03:58:24 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id f12sm23922824wrg.5.2019.06.24.03.58.23
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 24 Jun 2019 03:58:23 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6D2061FF87;
 Mon, 24 Jun 2019 11:58:23 +0100 (BST)
References: <20190523105440.27045-1-rkagan@virtuozzo.com>
 <20190523105440.27045-2-rkagan@virtuozzo.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190523105440.27045-2-rkagan@virtuozzo.com>
Date: Mon, 24 Jun 2019 11:58:23 +0100
Message-ID: <87sgrz1c8g.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [RFC PATCH 1/2] cpus-common: nuke finish_safe_work
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Roman Kagan <rkagan@virtuozzo.com> writes:

> It was introduced in commit b129972c8b41e15b0521895a46fd9c752b68a5e,
> with the following motivation:

I can't find this commit in my tree.

>
>   Because start_exclusive uses CPU_FOREACH, merge exclusive_lock with
>   qemu_cpu_list_lock: together with a call to exclusive_idle (via
>   cpu_exec_start/end) in cpu_list_add, this protects exclusive work
>   against concurrent CPU addition and removal.
>
> However, it seems to be redundant, because the cpu-exclusive
> infrastructure provides suffificent protection against the newly added
> CPU starting execution while the cpu-exclusive work is running, and the
> aforementioned traversing of the cpu list is protected by
> qemu_cpu_list_lock.
>
> Besides, this appears to be the only place where the cpu-exclusive
> section is entered with the BQL taken, which has been found to trigger
> AB-BA deadlock as follows:
>
>     vCPU thread                             main thread
>     -----------                             -----------
> async_safe_run_on_cpu(self,
>                       async_synic_update)
> ...                                         [cpu hot-add]
> process_queued_cpu_work()
>   qemu_mutex_unlock_iothread()
>                                             [grab BQL]
>   start_exclusive()                         cpu_list_add()
>   async_synic_update()                        finish_safe_work()
>     qemu_mutex_lock_iothread()                  cpu_exec_start()
>
> So remove it.  This paves the way to establishing a strict nesting rule
> of never entering the exclusive section with the BQL taken.
>
> Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
> ---
>  cpus-common.c | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/cpus-common.c b/cpus-common.c
> index 3ca58c64e8..023cfebfa3 100644
> --- a/cpus-common.c
> +++ b/cpus-common.c
> @@ -69,12 +69,6 @@ static int cpu_get_free_index(void)
>      return cpu_index;
>  }
>
> -static void finish_safe_work(CPUState *cpu)
> -{
> -    cpu_exec_start(cpu);
> -    cpu_exec_end(cpu);
> -}
> -

This makes sense to me intellectually but I'm worried I've missed the
reason for it being introduced. Without finish_safe_work we have to wait
for the actual vCPU thread function to acquire and release the BQL and
enter it's first cpu_exec_start().

I guess I'd be happier if we had a hotplug test where we could stress
test the operation and be sure we've not just moved the deadlock
somewhere else.

>  void cpu_list_add(CPUState *cpu)
>  {
>      qemu_mutex_lock(&qemu_cpu_list_lock);
> @@ -86,8 +80,6 @@ void cpu_list_add(CPUState *cpu)
>      }
>      QTAILQ_INSERT_TAIL_RCU(&cpus, cpu, node);
>      qemu_mutex_unlock(&qemu_cpu_list_lock);
> -
> -    finish_safe_work(cpu);
>  }
>
>  void cpu_list_remove(CPUState *cpu)


--
Alex Benn=C3=A9e

