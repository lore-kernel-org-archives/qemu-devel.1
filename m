Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CD6C0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 16:45:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9D1E20693
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 16:45:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9D1E20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsVFk-0001qm-Uc
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 12:45:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54937)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hsVFH-0001Fy-Mu
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 12:45:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hsVFF-00073l-M2
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 12:45:03 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33442)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hsVFE-00072w-M4
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 12:45:01 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so66629209wru.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 09:45:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=44PWnsZlugzoF8OgUVXZACuqPGycODVBbu6h4inAI8o=;
 b=RNy0CBOZelP6cSuqp6SEVByQs0ATlfqEiQp6FJWqsETRlOGXTwj6kcQOLIbhc2f2KI
 +aKVvmiqEd3r20fwv9Ac34xj2mqSU5/jBRfXqYf+D9oBppDRnDyxwh3sT9E8l51fYuXJ
 YnGa6u7LaeWIvHrEFen+VXQJk1CSNGR4J915mcwa2c5WEN+58tckYiKpiLSfC4X2kNSz
 m0UezqV9Ol4zyvbynweTDk9TFPbVxzdagwWqK2Nu7KovZwbYvR7bzcw4DA82AcWLTHnV
 nbdsWqswIEROJxfB8sJb/YKCoJUAgSsJydSt1BFQMwSiWT5pBEsunl3H7zF59lWSS+hl
 IxNA==
X-Gm-Message-State: APjAAAXDeQ9WA5ObeqSjdk7W9W6eJVjLHCYo16QcvspTDF+B+ObOk3u/
 fdVxK2RYtNo5ZmV0dfuvg9M0GQ==
X-Google-Smtp-Source: APXvYqyxNaQbCpzEb+xWh4DJMWsbihpOAJ8VYcDfTamWG5R6SzfItdFfDyhi3S+O1mCc7qBb9fVfJQ==
X-Received: by 2002:a5d:628d:: with SMTP id k13mr1679873wru.69.1564505099684; 
 Tue, 30 Jul 2019 09:44:59 -0700 (PDT)
Received: from [192.168.43.238] (63.red-95-127-155.staticip.rima-tde.net.
 [95.127.155.63])
 by smtp.gmail.com with ESMTPSA id k124sm107600279wmk.47.2019.07.30.09.44.58
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 30 Jul 2019 09:44:59 -0700 (PDT)
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <1564502498-805893-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1564502498-805893-4-git-send-email-andrey.shinkevich@virtuozzo.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <7a78ef04-4120-20d9-d5f4-6572c5676344@redhat.com>
Date: Tue, 30 Jul 2019 18:44:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1564502498-805893-4-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH 3/3] i386/kvm: initialize struct at full
 before ioctl call
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
Cc: vsementsov@virtuozzo.com, berto@igalia.com, ehabkost@redhat.com,
 kvm@vger.kernel.org, mtosatti@redhat.com, mdroth@linux.vnet.ibm.com,
 armbru@redhat.com, pbonzini@redhat.com, den@openvz.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/30/19 6:01 PM, Andrey Shinkevich wrote:
> Not the whole structure is initialized before passing it to the KVM.
> Reduce the number of Valgrind reports.
> 
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>  target/i386/kvm.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index dbbb137..ed57e31 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -190,6 +190,7 @@ static int kvm_get_tsc(CPUState *cs)
>          return 0;
>      }
>  
> +    memset(&msr_data, 0, sizeof(msr_data));

I wonder the overhead of this one...

>      msr_data.info.nmsrs = 1;
>      msr_data.entries[0].index = MSR_IA32_TSC;
>      env->tsc_valid = !runstate_is_running();
> @@ -1706,6 +1707,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
>  
>      if (has_xsave) {
>          env->xsave_buf = qemu_memalign(4096, sizeof(struct kvm_xsave));
> +        memset(env->xsave_buf, 0, sizeof(struct kvm_xsave));

OK

>      }
>  
>      max_nested_state_len = kvm_max_nested_state_length();
> @@ -3477,6 +3479,7 @@ static int kvm_put_debugregs(X86CPU *cpu)
>          return 0;
>      }
>  
> +    memset(&dbgregs, 0, sizeof(dbgregs));

OK

>      for (i = 0; i < 4; i++) {
>          dbgregs.db[i] = env->dr[i];
>      }

We could remove 'dbgregs.flags = 0;'

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

