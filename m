Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D487C2BA2B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 07:41:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12C972064A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 07:41:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12C972064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOz96-0001q2-3e
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 03:41:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39373)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jOz8T-0001KD-JO
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 03:40:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jOz8S-00072q-Ck
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 03:40:33 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:34235)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jOz8S-000724-4X
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 03:40:32 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1N0FE1-1j58Qe1bYF-00xIsb; Thu, 16 Apr 2020 09:39:55 +0200
Subject: Re: [PATCH] linux-user/syscall.c: add target-to-host mapping for
 epoll_create1()
To: Sergei Trofimovich <slyfox@gentoo.org>, qemu-devel@nongnu.org
References: <20200415220508.5044-1-slyfox@gentoo.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <fe098fc1-4e89-0679-4aae-76e716b9e789@vivier.eu>
Date: Thu, 16 Apr 2020 09:39:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200415220508.5044-1-slyfox@gentoo.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:k26MwutozzYxnI/tFCpPxabnnjzm328Vh0V/5VunXLvj5QJDURM
 1h0YwFU5P2HHEsfdD0wtbwhjsgp3LqRQFQoQtTN8U0GPKb7ubGLMPPKcFVu/GXO/0dGEQT5
 TFSNm7wtAetBGLWplExXpytv5wxVGFimD7ySCFFop5oXOh+7ykx4igSzmcpsmQTuuTIxfv5
 5sHtNYym8z1IykpRnEUtw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Nds2S9INWzc=:8w1u2DTpRxV4wXuabhY37B
 h+5MG+S8f6y5z1wTgtnj9Xjn7DiWaMS1IW1Sj2TZFOFrf0kjVF+ByCCXsv44/g2+EH+FiyMvL
 mJSSTgJ4aktNTb/9bw60vSgZptN/ulhAoyKlXkC4KU1/VgrHYcmDQs8agR0P4YR0NTwTAtJM7
 n7/Xfgeejf+irk76pbeCPAmgqXcJ3T6gfpuYDmfUMxj8jtys7p97QaR+DN31NXugUnP1iIFiq
 byokKxewFk7pCa+Ri069RTsMWmIgfnq5+NiYk+5iGiQggWcq+e7NBYEwvNmJHA7o0d9STIwKS
 KSIdUCALAiL8Gt9x/JDv07e5MdbMkPZ3s+W/e1sCbYrOYyhnIzKr9u/PQQYNNrek8qZ9kjtgW
 lNl0eWTWZ4X3NZnC2mgwgXfu4wSjgSKDWft3TVAQgHlutVzzid71luK6GyxwRqogstMlbzUzh
 qowSiUG6SeiuMcZMcXSrVrbm+vHaF0UC9Jyr6hwzCWEKY5MSS3D5sw3zHPrzQM+2VHtZKvkAt
 ewLB6XTkt5i8SWevOKNoM2MMEYzgMwW2nb/24uTKQI+MXwpUHWvblhnyjxZJRVO2QRFjt+7Zr
 WGnCykOv/0el86pDMohl2YhTbQl5kABtrm7Kddm3tQXq2tVscvkdNJFP6C3I4FIqpTcTEu6Qf
 7Z151csQqv3PVmJ4GJPLmLzOJ+wRs26Qwk44DuYBp12hQOzguLP+W8Msiu+v8FCCLvyurjukS
 IYoNwqloi57X5rJMzieRbBpCLYCRZTdK5U5yf0Xs3eaxnW5ICCrxfx5wThPd/w7BPeAgWkEam
 ZFtzwUKCId86F7xaEXrTlurs0IpgdOHdivFqugWWMoyjiJzanvkNCPR8qOx5xb5Cbd/GNPY
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
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
Cc: Riku Voipio <riku.voipio@iki.fi>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 16/04/2020 à 00:05, Sergei Trofimovich a écrit :
> Noticed by Barnabás Virágh as a python-3.7 failue on qemu-alpha.
> 
> The bug shows up on alpha as it's one of the targets where
> EPOLL_CLOEXEC differs from other targets:
>     sysdeps/unix/sysv/linux/alpha/bits/epoll.h: EPOLL_CLOEXEC  = 01000000
>     sysdeps/unix/sysv/linux/bits/epoll.h:        EPOLL_CLOEXEC = 02000000
> 
> Bug: https://bugs.gentoo.org/717548
> Reported-by: Barnabás Virágh
> Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
> CC: Riku Voipio <riku.voipio@iki.fi>
> CC: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/syscall.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 674f70e70a..05f03919ff 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -12012,7 +12012,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>  #endif
>  #if defined(TARGET_NR_epoll_create1) && defined(CONFIG_EPOLL_CREATE1)
>      case TARGET_NR_epoll_create1:
> -        return get_errno(epoll_create1(arg1));
> +        return get_errno(epoll_create1(target_to_host_bitmask(arg1, fcntl_flags_tbl)));
>  #endif
>  #if defined(TARGET_NR_epoll_ctl)
>      case TARGET_NR_epoll_ctl:
> 

Applied to my linux-user-for-5.0 branch.

Thanks,
Laurent

