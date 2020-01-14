Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E05C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 15:33:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C4172467D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 15:33:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C4172467D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irOC3-0001Ol-Rk
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 10:33:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39259)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1irNwL-00066E-21
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:17:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1irNwH-0006B0-4l
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:17:08 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:58729)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1irNwG-00067T-Rj
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:17:05 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MFsAJ-1islmU1PzT-00HPqM; Tue, 14 Jan 2020 16:16:37 +0100
Subject: Re: [PATCH v5 06/20] linux-user: x86_64: Update syscall numbers to
 kernel 5.5 rc3 level
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1578947683-21011-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1578947683-21011-7-git-send-email-aleksandar.markovic@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <e8043e91-24e5-341d-1514-35449d874286@vivier.eu>
Date: Tue, 14 Jan 2020 16:16:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1578947683-21011-7-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:JMHVgdUD58PZ+T8bn+XtcGa1tzF7pmXyTnlyqw6afbIEaEZy6d8
 eWINVqNIQhT9PvHozsWu6k1x6aPeHhCxTzMcwmPywmkVDNYHpzVslYp9G9AMjQkG6LNBZUo
 I2WgCCIVkp/P+erq7PNLsqzttcs9+W2DAZpZhmfD0W6XHW9Q6KIbzjxYfZL22NagqKDY9mr
 O+U9huZI0SM9krSlcapyw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zQXzo/Sp/xA=:szoVV4oV3Ylh/ZaDD/PfsD
 8xegt55icwKohIt7ATdGTx6YXGjdvMRB1CFVFesDYdTfAah9e2MSfxnOmaBJhVgH/diSvBMQf
 HcRkycTqiMop4Gs3SkVoPVG5th6OmvNOHiM0NEYCD/kT+M+jqkMsuiyeMq5T+LtgpcL3qotWo
 ptIYm0dyKvirRJhZjCiBHFi4AYO2G0ZAjta0pqz7ISVg3A7V9KMXl/T6EDsZDFeiH/7hpVw7w
 NYG/Vs/1sEG8nBlEd1nk42P2Gkb0RCL6vCqHOV4SVxgKToTyFMFdCAhPI4rfZ1cU4rVgtp0Op
 CULQtCNofcLtKzuSPnZGSXeUt6Crx1j95pH5H4kejuUhnvu7jOVM0OYt54bQAIwTxTdHwuRoP
 2/+W2vpGNXa/eKpyawuG8Cv30oe6nLErH3F7Dy6T5JSaanfQq+J89Zz+iM4aiONqlFMI4/BsB
 eiJJqje4fjmL8sIuMSVIx3xGLlnXvJCi2s+QN9X6/PTR6DbqfERt55XBKNp/qeB9DRXNqX7XL
 8ODX26or+Uv2hAfDsSYhcjqB9Ymwp+DF2yAhEsJIKVLPfuADaDs8kydBFDbP8zRwsXWjdI1xK
 jTsVsDdeaz8G+/P3j6XHYzymruI9bj36tlKL2L167xW/wXDlME8re4YsVyJ3q4B1Q8suwiXgt
 fkPjzk9769dMYIq+VNWTRtWh77W1POMjbm2rRXBwj1yTziqsguv5oXup6093Hwh3X4C+k6oaq
 5svBp3sao7VEi6FPZA7Wr1O1q4MOswwnQQqDvfW+ZTDgwkOCB4MZXmj4dDBcrx4Xriccn1kZk
 ByMCcnlJORbBkwYXrNokFRR0Y/cTThMTSkZqWqxsh/5Zv7Vkep90FATefPhosC8QU4ohuy/Es
 Nr2ZTASD+jx+hoSWnHHglhSrVQ4QRZW8eAGIYgvrM=
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 amarkovic@wavecomp.com, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 13/01/2020 à 21:34, Aleksandar Markovic a écrit :
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Update x86_64 syscall numbers based on Linux kernel tag v5.5-rc3
> (commit 46cf053e).
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> ---
> 
> cc: Paolo Bonzini <pbonzini@redhat.com>
> cc: Richard Henderson <rth@twiddle.net>
> cc: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  linux-user/x86_64/syscall_nr.h | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/linux-user/x86_64/syscall_nr.h b/linux-user/x86_64/syscall_nr.h
> index 9b6981e..e5d14ec 100644
> --- a/linux-user/x86_64/syscall_nr.h
> +++ b/linux-user/x86_64/syscall_nr.h
> @@ -328,5 +328,29 @@
>  #define TARGET_NR_membarrier            324
>  #define TARGET_NR_mlock2                325
>  #define TARGET_NR_copy_file_range       326
> +#define TARGET_NR_preadv2               327
> +#define TARGET_NR_pwritev2              328
> +#define TARGET_NR_pkey_mprotect         329
> +#define TARGET_NR_pkey_alloc            330
> +#define TARGET_NR_pkey_free             331
> +#define TARGET_NR_statx                 332
> +#define TARGET_NR_io_pgetevents         333
> +#define TARGET_NR_rseq                  334
> +/*
> + * don't use numbers 387 through 423, add new calls after the last
> + * 'common' entry
> + */
> +#define TARGET_NR_pidfd_send_signal     424
> +#define TARGET_NR_io_uring_setup        425
> +#define TARGET_NR_io_uring_enter        426
> +#define TARGET_NR_io_uring_register     427
> +#define TARGET_NR_open_tree             428
> +#define TARGET_NR_move_mount            429
> +#define TARGET_NR_fsopen                430
> +#define TARGET_NR_fsconfig              431
> +#define TARGET_NR_fsmount               432
> +#define TARGET_NR_fspick                433
> +#define TARGET_NR_pidfd_open            434
> +#define TARGET_NR_clone3                435
>  
>  #endif
> 

And what about to update linux-user/i386/syscall_nr.h too?

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

