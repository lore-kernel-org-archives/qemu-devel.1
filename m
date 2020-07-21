Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD955C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 14:29:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A33962070A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 14:29:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A33962070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxtGn-0007A4-Ar
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 10:29:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jxtFr-0006Ap-Cs
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 10:28:27 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:34713)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jxtFl-0004RB-Bu
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 10:28:27 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1N1feo-1kzR8s1C36-01209U; Tue, 21 Jul 2020 16:28:18 +0200
Subject: Re: [PATCH v2 2/4] linux-user: Add strace support for printing
 arguments of truncate()/ftruncate() and getsid()
To: Filip Bozuta <Filip.Bozuta@syrmia.com>, qemu-devel@nongnu.org
References: <20200713095058.106624-1-Filip.Bozuta@syrmia.com>
 <20200713095058.106624-3-Filip.Bozuta@syrmia.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <4644b42b-d0e1-ac62-9283-e21a0bf68ca7@vivier.eu>
Date: Tue, 21 Jul 2020 16:28:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200713095058.106624-3-Filip.Bozuta@syrmia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:kQKi8DUOabxCh21A5S7/NR7SNaNz3PvOKTnM6krdtXOZ9cThpEE
 Vb21jFwkWkC2biRz+WuZPjgrHBkhLuYb7/DgKVYN7lStVl/OBnQesxrl6RR+4XhdprIhVhk
 tKB9GXnRQuDXeEfW7oHxlTutvC5crYtw9Ni2FuyJzFIglYGJIKzpZBVhKrOLzxtcIaQSS6T
 LEWX7Hh7Nk4K3xBlCObrg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RCccuzwbqBE=:hnR6eX63lNpUYtlycfbVEr
 gG0htt8A0LR2QoWu8vkyHyaiT8jGSJ3/c99wLZDf+6DTyn6/C7J+Y3lN3BWDDqPBu/Bh51sNK
 gZWgzlSdILnqvpFu/7rir8QItxggkFlB2O30o/WDLoTFQelk8hGnMmKEnBh3AyUzBIS5AvBqg
 wWM9EbX9MP3Yt5uXyIFw9+66PmcXoK817E7KZ037bbNheldBpVgcc1y57pzIOl7S6LcoOXLtE
 07RPMh6nCG0/P1z6wbmnN0M3xDh/0U9JNUzPCwyt+HSktwnUBxBbTLg4U6MvBctpGP+McOtMg
 VmsVO5m1eg3AgBGAbH3hYgxj6Ls12sB+U1E7tBsfMwlYY3qjimLyDHzsyXyQbxmg6BOl5eBhQ
 h3DiAGJZPAmflV8afhk11HIfBrRXSyiS9LvtzgIEbWo2N+3/VTgk+tkeYepwlRaJVz/mqGf9e
 b87nwMG4L+J7ZARAvwz7ZMMokDFcoujR7Zn8pSDl87Z04+M5thfCIRkQjGHn88DH/owCmDSvN
 phVEpO4/OXdzkeI39HNKl3fmh4XVbZ4GONhJRm9GukaR8MnG/uXfZgVzTZA/Umo9SSWg6mzro
 DnUwAlRd/05HQ7mcYD8hEbem0K50oFMTvOfLDqI6FZ2xIS2jKknu9mOo7tBpHHxoQFIzlwhxO
 qV9SDhK9C2LrWHJG/jKALaYNrUrKFMAHxfzEqWgxuLOYN7yl1SYgZVn0Az/TFqhYf+v/Eqweu
 Gve/VHKOT6BoNOdvmNAQwrZP86iVcJfV14l6EXWFVjmVZSEC+xRAMuZ7O+0QhL0seLbFInxYG
 CdVeQ8At2cOUA2uOioHeS0gP0vmcS+yCkhP906b/fmyARKhM4/e52Q9eBiG6MU16wT0frcd
Received-SPF: none client-ip=212.227.17.24; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 10:28:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 13/07/2020 à 11:50, Filip Bozuta a écrit :
> This patch implements strace argument printing functionality for following syscalls:
> 
>     * truncate, ftruncate - truncate a file to a specified length
> 
>         int truncate/truncate64(const char *path, off_t length)
>         int ftruncate/ftruncate64(int fd, off_t length)
>         man page: https://man7.org/linux/man-pages/man2/truncate.2.html
> 
>     * getsid - get session ID
> 
>         pid_t getsid(pid_t pid)
>         man page: https://man7.org/linux/man-pages/man2/getsid.2.html
> 
> Implementation notes:
> 
>     Syscalls truncate/truncate64 take string argument types and thus a
>     separate print function "print_truncate/print_truncate64" is stated in
>     file "strace.list". This function is defined and implemented in "strace.c"
>     by using an existing function used to print string arguments: "print_string()".
>     For syscall ftruncate64, a separate printing function was also stated in
>     "strace.c" as it requires a special kind of handling.
>     The other syscalls have only primitive argument types, so the rest of the
>     implementation was handled by stating an appropriate printing format in file
>     "strace.list".
>     Function "regpairs_aligned()" was cut & pasted from "syscall.c" to "qemu.h"
>     as it is used by functions "print_truncate64()" and "print_ftruncate64()"
>     to print the offset arguments of "truncate64()" and "ftruncate64()".
> 
> Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
> ---
>  linux-user/qemu.h      | 35 +++++++++++++++++++++++++++++++
>  linux-user/strace.c    | 47 ++++++++++++++++++++++++++++++++++++++++++
>  linux-user/strace.list | 10 ++++-----
>  linux-user/syscall.c   | 32 ----------------------------
>  4 files changed, 87 insertions(+), 37 deletions(-)
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>



