Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021A7C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 17:27:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9CAC214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 17:27:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9CAC214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwUeJ-0002gJ-V8
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 12:27:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47240)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iwUdS-0002Ee-5c
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:26:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iwUdQ-0002Bz-Ru
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:26:45 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:56757)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iwUdQ-00029d-JG
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:26:44 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1M2w4S-1izmQP1gA0-003JNk; Tue, 28 Jan 2020 18:26:41 +0100
Subject: Re: [PATCH v2 0/5] linux-user: Implement x86_64 vsyscalls
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200116194341.402-1-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <7da64d23-9e67-db73-f93c-d04f48f33a35@vivier.eu>
Date: Tue, 28 Jan 2020 18:26:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200116194341.402-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:t/b5eXp4GIQwIa5yzCCWxzj7LRHxJVveo1vOhA2ZJk2UlZtO/x8
 w+fB4FkgENiv6y/BJx4oT5IkqWx8vj291b+DVJW1z5hYaPGtk4pnt6IV4LMhY22gIcc6++z
 EQOFV2xVycyarSANMoOIULYmnaAyLZIaOLE7dozgogW5rF7wLwanxzgXJvm8fzaTCd3Xlxk
 2Yyr1OYtFg+f8B0Ca9I6w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ldJtppqNArs=:h95uLyA1vAV+B24tJPljJw
 +n9lTIz7NDTksqQ2JLwlEAoD6e71LqfiWSlEfc3AaPl5YRFMYQg4EYFK/eLO+7q9FsBTA6iPl
 amvK+DecfxPewFOcvQEdkJu3221lqyNJDU8o2NY5HzW9Xm9Qrx3nGvjoGRSI5EWLgcKWT6+lM
 p/gPH17K9caMd6YZgEFLFaPE65qE06N3aBDp3iKQbVpFW83tsXj+pZVD8B980TmmgIfVDEO5d
 d7iGEqU9UUaBJkLILZqjcZuk4lz6u0G8QI7d0VP2LqT1rtv+7eIUKR3sWvk9z2TIicXyt9C/3
 2kMxzI3b+zqiHRcrYINYT/N7DroikW11N9WTXSFzr+lP/RDn8Wk3iik8Xba5e81ATmPnixfE+
 ZiYABer6lMsQGOO0ao3NyrzTYSuahQA9zArx/Lvw9pOT04Q0jQoWR2lVLGNeRbEGM1a0jJ27G
 pqHxOyO55bCtxD9BXw/ojzxLhu8xLmDNDrrqn96pfuaDLQiTIhhpMBL1+QRAvhOXFe+DnLReI
 NqJc9SiO9smpXQj9Ft3V5JyXR1jOZeMjqGHlXkXRhlkTkUfY1D3DykjEieBlmZn0dICTYtisZ
 /fEJ7Xp4FkZ+34NCLRAEopwrTzabdWbSwOys+nv18UEtdItzRve6hd4iwTaGfjkKmpcD+h48a
 Xo5dwgW6RsVod4TQ5ic2vGtOMRC3CtUlEX50g2VZcnQ4klvWXM+4mkolpqqUuwDYtPbd/KSPX
 iisGMR5dQCLqUeE8wkQ1tJQXAZG8CkajGvhfHK5E2avMVtsjhciTed32o81RbXSzTcHMaPqxq
 HVh116WVlOxoVxrTQJqn176dekvl8ihL9rFJ20nJ3ErRDPFvIRBdI9NTes4ej+QL08UWOee
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.131
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 16/01/2020 à 20:43, Richard Henderson a écrit :
> Changes since v2:
> 
>   * Add /proc/self/maps line
> 
> 	I'm not sure this is really necessary.  The linux kernel
> 	self-test checks for it, and modifies the set of tests that
> 	it runs based on it.  But otherwise I think it's unused.
> 
>   * Fix errors in base gettimeofday syscall
> 
> 	This is also checked by test_vsyscall, as noticed by AJB.
> 

Hi Richard,

do you plan to send a v3?

Thanks,
Laurent

> r~
> 
> 
> Original blurb:
> 
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
> Richard Henderson (5):
>   target/i386: Renumber EXCP_SYSCALL
>   linux-user/i386: Split out gen_signal
>   linux-user/i386: Emulate x86_64 vsyscalls
>   linux-user: Add x86_64 vsyscall page to /proc/self/maps
>   linux-user: Flush out implementation of gettimeofday
> 
>  target/i386/cpu.h          |   6 +-
>  linux-user/i386/cpu_loop.c | 198 ++++++++++++++++++++++++++-----------
>  linux-user/syscall.c       |  36 ++++++-
>  target/i386/translate.c    |  16 ++-
>  4 files changed, 190 insertions(+), 66 deletions(-)
> 


