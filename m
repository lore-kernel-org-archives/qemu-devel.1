Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DD6C04AB1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 16:56:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 005A02086A
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 16:56:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 005A02086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60522 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQEFi-0002Kv-Ab
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 12:56:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hQEEv-000211-Cb
	for qemu-devel@nongnu.org; Mon, 13 May 2019 12:55:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hQEEt-0000pA-UM
	for qemu-devel@nongnu.org; Mon, 13 May 2019 12:55:49 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40378)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hQEEt-0000o2-OJ
	for qemu-devel@nongnu.org; Mon, 13 May 2019 12:55:47 -0400
Received: by mail-pf1-f193.google.com with SMTP id u17so7507595pfn.7
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 09:55:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
	:mime-version:content-transfer-encoding;
	bh=ah6GWwfR1g+tDsx1lcSLI2FHFTAjFKmbKebHaxFmxBQ=;
	b=gpGAjRxIqhBQVREzvjQk8wRUHLrRgYKpPyDD6Frjn9/7Kq6XQALG8TP1McJJL4H+lv
	JgkNuWT07nyHo8sON4VmDaMS7rQ4Tum5/g3vaKtKPRgwKsyBtMv6yXTX8UfL0aEmaGaP
	OllshbZC4bD3ijHKgaDEy46jBEOge0xABjly+ZUt+oyz0Cx7b3sbDkzYZihJE7jDOwyB
	E7pLxxRjeu6l1cc9SuRwCIE+SPHvkGKGeclrL0tsiOjbIat6hE5HNygV1xHeZ4MYri8P
	IdHws1TDdD0wOGcAa62iUTkkMu7oQYIenRW7aEHniUW3nxylxmhbeEzRcAl2leTcCiwY
	wBEg==
X-Gm-Message-State: APjAAAV7TvVck7wJXIQ+uSEkrPnJVc5SLLofk/e+yvQLMs03m04gbG1I
	cWtArx3sqqqVQwz5Qa7Eb1tgTqYhtL8=
X-Google-Smtp-Source: APXvYqwX4Ozs5dF8Ahytdhe1nrcdFy2KBYy8S4FVvfpCTPWBJCD84CoFNgbFz6XQ61sfCtmPOSeejg==
X-Received: by 2002:a63:c106:: with SMTP id w6mr28863993pgf.422.1557766545380; 
	Mon, 13 May 2019 09:55:45 -0700 (PDT)
Received: from localhost ([12.206.222.5]) by smtp.gmail.com with ESMTPSA id
	q19sm19372104pff.96.2019.05.13.09.55.43
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 13 May 2019 09:55:44 -0700 (PDT)
Date: Mon, 13 May 2019 09:55:44 -0700 (PDT)
X-Google-Original-Date: Mon, 13 May 2019 09:47:44 PDT (-0700)
In-Reply-To: <20190513081844.26699-5-armbru@redhat.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: armbru@redhat.com
Message-ID: <mhng-5f5db13d-9ab7-414b-8979-4e119c319f78@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.210.193
Subject: Re: [Qemu-devel] [PULL 4/9] linux-user/nios2 linux-user/riscv:
 Clean up header guards
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 13 May 2019 01:18:39 PDT (-0700), armbru@redhat.com wrote:
> Reuse of the same guard symbol in multiple headers is okay as long as
> they cannot be included together.  scripts/clean-header-guards.pl
> can't tell, so it warns.
>
> Since we can avoid guard symbol reuse easily, do so: use guard symbol
> ${target^^}_${fname^^} for linux-user/$target/$fname, just like we did
> in commit a9c94277f0..3500385697.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Message-Id: <20190315145123.28030-4-armbru@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  linux-user/nios2/target_cpu.h     | 4 ++--
>  linux-user/nios2/target_signal.h  | 6 +++---
>  linux-user/nios2/target_structs.h | 4 ++--
>  linux-user/nios2/target_syscall.h | 6 +++---
>  linux-user/riscv/target_cpu.h     | 4 ++--
>  linux-user/riscv/target_signal.h  | 6 +++---
>  linux-user/riscv/target_structs.h | 4 ++--
>  7 files changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/linux-user/nios2/target_cpu.h b/linux-user/nios2/target_cpu.h
> index 14f63338fa..5596c05c9c 100644
> --- a/linux-user/nios2/target_cpu.h
> +++ b/linux-user/nios2/target_cpu.h
> @@ -17,8 +17,8 @@
>   * License along with this library; if not, see <http://www.gnu.org/licenses/>.
>   */
>  
> -#ifndef TARGET_CPU_H
> -#define TARGET_CPU_H
> +#ifndef NIOS2_TARGET_CPU_H
> +#define NIOS2_TARGET_CPU_H
>  
>  static inline void cpu_clone_regs(CPUNios2State *env, target_ulong newsp)
>  {
> diff --git a/linux-user/nios2/target_signal.h b/linux-user/nios2/target_signal.h
> index 7776bcdbfd..fe48721b3d 100644
> --- a/linux-user/nios2/target_signal.h
> +++ b/linux-user/nios2/target_signal.h
> @@ -1,5 +1,5 @@
> -#ifndef TARGET_SIGNAL_H
> -#define TARGET_SIGNAL_H
> +#ifndef NIOS2_TARGET_SIGNAL_H
> +#define NIOS2_TARGET_SIGNAL_H
>  
>  /* this struct defines a stack used during syscall handling */
>  
> @@ -18,4 +18,4 @@ typedef struct target_sigaltstack {
>  
>  #include "../generic/signal.h"
>  
> -#endif /* TARGET_SIGNAL_H */
> +#endif /* NIOS2_TARGET_SIGNAL_H */
> diff --git a/linux-user/nios2/target_structs.h b/linux-user/nios2/target_structs.h
> index 8713772089..7145251706 100644
> --- a/linux-user/nios2/target_structs.h
> +++ b/linux-user/nios2/target_structs.h
> @@ -16,8 +16,8 @@
>   * You should have received a copy of the GNU Lesser General Public
>   * License along with this library; if not, see <http://www.gnu.org/licenses/>.
>   */
> -#ifndef TARGET_STRUCTS_H
> -#define TARGET_STRUCTS_H
> +#ifndef NIOS2_TARGET_STRUCTS_H
> +#define NIOS2_TARGET_STRUCTS_H
>  
>  struct target_ipc_perm {
>      abi_int __key;                      /* Key.  */
> diff --git a/linux-user/nios2/target_syscall.h b/linux-user/nios2/target_syscall.h
> index ca6b7e69f6..f3b2a500f4 100644
> --- a/linux-user/nios2/target_syscall.h
> +++ b/linux-user/nios2/target_syscall.h
> @@ -1,5 +1,5 @@
> -#ifndef TARGET_SYSCALL_H
> -#define TARGET_SYSCALL_H
> +#ifndef NIOS2_TARGET_SYSCALL_H
> +#define NIOS2_TARGET_SYSCALL_H
>  
>  #define UNAME_MACHINE "nios2"
>  #define UNAME_MINIMUM_RELEASE "3.19.0"
> @@ -34,4 +34,4 @@ struct target_pt_regs {
>  #define TARGET_MLOCKALL_MCL_CURRENT 1
>  #define TARGET_MLOCKALL_MCL_FUTURE  2
>  
> -#endif  /* TARGET_SYSCALL_H */
> +#endif /* NIOS2_TARGET_SYSCALL_H */
> diff --git a/linux-user/riscv/target_cpu.h b/linux-user/riscv/target_cpu.h
> index 7e090f376a..90f9a4171e 100644
> --- a/linux-user/riscv/target_cpu.h
> +++ b/linux-user/riscv/target_cpu.h
> @@ -1,5 +1,5 @@
> -#ifndef TARGET_CPU_H
> -#define TARGET_CPU_H
> +#ifndef RISCV_TARGET_CPU_H
> +#define RISCV_TARGET_CPU_H
>  
>  static inline void cpu_clone_regs(CPURISCVState *env, target_ulong newsp)
>  {
> diff --git a/linux-user/riscv/target_signal.h b/linux-user/riscv/target_signal.h
> index c8b1455800..f113ba9a55 100644
> --- a/linux-user/riscv/target_signal.h
> +++ b/linux-user/riscv/target_signal.h
> @@ -1,5 +1,5 @@
> -#ifndef TARGET_SIGNAL_H
> -#define TARGET_SIGNAL_H
> +#ifndef RISCV_TARGET_SIGNAL_H
> +#define RISCV_TARGET_SIGNAL_H
>  
>  typedef struct target_sigaltstack {
>      abi_ulong ss_sp;
> @@ -15,4 +15,4 @@ typedef struct target_sigaltstack {
>  
>  #include "../generic/signal.h"
>  
> -#endif /* TARGET_SIGNAL_H */
> +#endif /* RISCV_TARGET_SIGNAL_H */
> diff --git a/linux-user/riscv/target_structs.h b/linux-user/riscv/target_structs.h
> index 4f0462c497..ea3e5ed17e 100644
> --- a/linux-user/riscv/target_structs.h
> +++ b/linux-user/riscv/target_structs.h
> @@ -4,8 +4,8 @@
>   * This is a copy of ../aarch64/target_structs.h atm.
>   *
>   */
> -#ifndef TARGET_STRUCTS_H
> -#define TARGET_STRUCTS_H
> +#ifndef RISCV_TARGET_STRUCTS_H
> +#define RISCV_TARGET_STRUCTS_H
>  
>  struct target_ipc_perm {
>      abi_int __key;                      /* Key.  */
> -- 
> 2.17.2

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

I'm assuming this is going in through someone else's tree, so I'm not going to
pick it up into mine.

