Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AA9C33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 10:15:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A8F42467A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 10:15:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A8F42467A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irfi6-0008A8-Aj
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 05:15:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59236)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1irfhO-0007gj-JG
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 05:14:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1irfhN-0007kb-Fk
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 05:14:54 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:41767)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1irfhN-0007jC-6r
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 05:14:53 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MREqy-1j3iP32odg-00N9TW; Wed, 15 Jan 2020 11:14:37 +0100
Subject: Re: [PATCH 0/3] linux-user: Implement x86_64 vsyscalls
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200114210921.11216-1-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <7f8c782f-6ee2-bc7c-db94-4b0784ed58eb@vivier.eu>
Date: Wed, 15 Jan 2020 11:14:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200114210921.11216-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:3Ht1J5rxPmQt27JTSexsMAZXmAyGYzookMDNBiOzi9+qUeHuSvj
 Q6PIkU/T6ejy2AnUoMP1I7J5JZgpZ8HBUNxT2lQ4SHs2CzppJzLkPznIeQu8UtOYVHRHkgx
 uOprrnb3qNsZmWc/U47ZA+dGKxWk4BWI5QMJ/UiWGW+I9Xp9ZOH1G3lVpLhFnRtbr29JdxS
 l1+1pS3Aw88XwqA3mGM5g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YyefoOZyIOI=:eAxW+7nC5ToeKW8VR8RtCB
 5NFA9Ll8gYaoMGdYJTHV95A1Wiv/S6fLbqjJInh0TtUhLR2qeQGNH/UohUHshzD4e05X04UQc
 RxvUIs+m1GZU44SIxO13WYjbyx2ZllfuWPvo+CJUICOZ7HNjklDicEsjtDyUbt3KeU1TT9Qdo
 vFWVAXUQiWOeIqk8H5WwrjUxpRC2HnFEY6dIOphZFrELVArc8DA4/DzPloElGrOLWaUucR7kj
 4enJUurOokPVCoGVRzlu1CKvq/vBI8ZGLCO/yKdnhdCy/SYTTd38RhtCh97ks4Zrl4PwKmUIH
 nN86nIiZUAlCsaXycT6Vw+LD8TOwUIQj7UShBrgVaik+CIa42WeY7jNSvYPLO9ARA3KMa5DVi
 f1AzePQjH1tb8Kd7TvV8dOn4CQ7i3tn15Qll7bm7MxRS2jOE+fdfK75TEoxD4IhXkeAn73rVr
 /oZe7V7XQJP/Tt7hWbaF6qyAId2hftUZkev2/m5o/YCj9U1UJR4m4HAxJGOjKjsc4jtZmdhrE
 cO2I7K/gEHzNEL3YUAlwfi9p3T1SRBUsNste3ZUY8m6+UKJq7BVTDXSYFoQKS5miQlkC57Ebi
 t/PxnMpu0SKl+Clv7Mv62yn/9nTMA6PYKCn3jD/J2x9PxXyNtg1jfw2PQ3kgcb54wzRfI1RBD
 +ib4hRcoWAMwQ5ETht1MO6R4wjI7uW8Hfriqx28QtX8wTM9tJ8WEBZ+a4PoarT4GSWVidqMEO
 4dlqu/yb/BrKosFHJK/GyO+fQjbNJyuevcOs6xPH/r9lXhZskXGxgMRdd3ztPLWUQA1bfi651
 8be445Ul7OKAiyMVURLG4rHI6rqDZQbmieWORWGgCdOsgzcty+uZvztp7XeLl5uAkfl4d9Pgd
 5gy0tUe1osJqfH8+OAJA==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.135
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
Cc: pbonzini@redhat.com, riku.voipio@iki.fi, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 14/01/2020 à 22:09, Richard Henderson a écrit :
> The x86_64 abi has a legacy vsyscall page.  The kernel folk
> have been trying to deprecate this since at least v3.1, but
> 
> (1) We don't implement the vdso that replaces vsyscalls,
> (2) As of v5.5, the vsyscall page is still enabled by default.
> 
> This lack is affecting Peter's linux-user testing.
> 
> The dependency is not obvious because Peter is running the tests
> on x86_64, so the host is providing a vsyscall page to qemu.
> 
> Because of how user-only memory operations are handled, with no
> validation of guest vs host pages, so long as qemu chooses to
> run with guest_base == 0, the guest may Just So Happen to read
> the host's vsyscall page.
> 
> Complicating this, new OS releases may use a kernel configured
> with CONFIG_LEGACY_VSYSCALL_XONLY=y, which means the the vsyscall
> page cannot be read, only executed.  Which means that the guest
> then cannot read the host vsyscall page during translation and
> will SIGSEGV.
> 
> Exactly which of these many variables is affecting Peter's testing
> with Ubuntu 18.04 of my TCG merge, I'm not exactly sure.  I suspect
> that it is the change to drop the textseg_addr adjustment to user-only
> static binaries.  IIRC bionic does not support -static-pie, which is
> the preferred replacement.  This could mean that the host and guest
> binaries overlap, which leads to guest_base != 0.
> 
> I vaguely remember someone (Paolo?) implementing something like
> this many years ago, but clearly it never got merged.
> 
> In any case, this emulation has been missing for too long.
> 
> 
> r~
> 
> 
> Richard Henderson (3):
>   target/i386: Renumber EXCP_SYSCALL
>   linux-user/i386: Split out gen_signal
>   linux-user/i386: Emulate x86_64 vsyscalls
> 
>  target/i386/cpu.h          |   6 +-
>  linux-user/i386/cpu_loop.c | 197 ++++++++++++++++++++++++++-----------
>  target/i386/translate.c    |  16 ++-
>  3 files changed, 155 insertions(+), 64 deletions(-)
> 

Thank you Richard.

I'll take this series through the linux-user branch except if you prefer
to do the pull request yourself via another branch (x86 tcg?).

Thanks,
Laurent

