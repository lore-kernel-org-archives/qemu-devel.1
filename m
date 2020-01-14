Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97A6C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 14:34:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDE592467D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 14:34:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDE592467D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irNGc-0000EU-UW
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 09:34:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59580)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1irNFJ-0007nS-2X
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 09:32:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1irNFF-0000p1-CC
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 09:32:40 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:36151)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1irNFF-0000os-2x
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 09:32:37 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MlsWZ-1jZXsc1SgF-00j27z; Tue, 14 Jan 2020 15:32:21 +0100
Subject: Re: [PATCH v5 13/20] linux-user: Add support for FITRIM ioctl
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1578947683-21011-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1578947683-21011-14-git-send-email-aleksandar.markovic@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <d0019bc9-7003-af76-949b-77867a80504a@vivier.eu>
Date: Tue, 14 Jan 2020 15:32:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1578947683-21011-14-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:SKFjUdQ2SVX3fIIBVoI8wwsL84dW9lWjtj9GntoFnADfZdhB0Fc
 V09Hz50rAHcnQfcPksE4sle6qjWjqBpe7QkZCkcBm2g+QfLSJ8JeMoA+KAo9hysTA7cWrJ2
 4D4zF0ildEyQ9HoZvMVzw8ARDiqT9T8KWtum6zgwW604+unJK6O4QPrc8LyAmyY9jNPllc9
 ackrPQhEo4Ls+6Md/VtYg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9skTf99oBEs=:UQjPDKGdEyU2MzuUe7aRLB
 2DnceD/mpu+Lxn+zdct3KpNGax8SoLaZM3NAP96XkO8uXjzhkTBtylXMHF5jKybTevLRXagQY
 ha8MG00IgLffjcL/2hsCMlGgpkfkygV/E63uQSnO/RA0HMIrRDkk1eioELw6mIUZaSinRE6b6
 nco/6ef+0QYYqVjaLxpUL0ZmBjS1PLPqomi7RlmzXVyOhwM4MoxOFucSijFViRZRS3RqJA6UN
 Tvl+7iSfxVREuhHMd7YEcf9aLFG7E5Xc+6VH4Zj3VvvP2dmKnxKsU2Aw+8thHBVVjFEKD3YLi
 UQAi2Hjle057/IAtdMK1Q3UQG5fQYgInAXdeNmKMDutJKTdSlmJTEPc6JiDfup4ml7vN3hUd1
 BWuonA8f/XdwTWR2XIGzox9CNsdA8ExnAFyRdwH71fTkZ85mkd+SbNn0fqY4oja/LI3Pm5RoZ
 SZBf+E0+asFbecEtZANERT7jgVoNlh36YSIYeGQVcKNstVdc6Nejgm5CaqVqKamT7rBmWh4/k
 Ws6BcaFbwWVZjueM6jJ9f1AqOyYVveNyYGkijN+BF3X54pv0+Bj1n8fHcaShKcKzPV9cNnhPN
 yha/Ei0vzcRtt2N8abZQKF0VfMlLaWVbSQxHgoPO4HA1dqJK1dZmLJ0ZeccaH/zvVR0Uk7O0S
 hnZVkeW/CsDaFEfJP8iQs5jXr7SP+0kplMMhxyOJ0rU7YhpKpvb/rEe+tIHYnBOedRcZe2gbT
 M/wZKd+/VzU8g/7Wjpk2+hZ/nApsGkocbJ8H+EDqU95oBU2aurcau0kWim0670K8mK/9VniJo
 bE9XTUIZoXHUUQ97iM6z2oR8PjZksLvN6FAgb58IHjU/FiOUFEM/dIjatqprwRAAXyHJZ6Nq5
 sR1YY6KbA74ewwBucQ/TijzQnw6D3u+KoJcKfZ43A=
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
Cc: amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 13/01/2020 à 21:34, Aleksandar Markovic a écrit :
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> FITRIM ioctl accepts a pointer to the structure
> 
> struct fstrim_range {
> 	__u64 start;
> 	__u64 len;
> 	__u64 minlen;
> };
> 
> as its third argument.
> 
> All ioctls in this group (FI* ioctl) are guarded with "#ifdef", so the
> guards are used in this implementation too for consistency (however,
> many of ioctls in FI* group became old enough that their #ifdef guards
> could be removed, bit this is out of the scope of this patch).
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  linux-user/ioctls.h       | 3 +++
>  linux-user/syscall_defs.h | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index e1b89a7..e4f0a04 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -123,6 +123,9 @@
>  #ifdef FIBMAP
>       IOCTL(FIBMAP, IOC_W | IOC_R, MK_PTR(TYPE_LONG))
>  #endif
> +#ifdef FITRIM
> +     IOCTL(FITRIM, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_fstrim_range)))

It seems STRUCT_fstrim_range is not defined.

> +#endif
>  #ifdef FICLONE
>       IOCTL(FICLONE, IOC_W, TYPE_INT)
>       IOCTL(FICLONERANGE, IOC_W, MK_PTR(MK_STRUCT(STRUCT_file_clone_range)))
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index 12cd3de..40851e9 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -908,6 +908,7 @@ struct target_pollfd {
>  #define TARGET_FIBMAP     TARGET_IO(0x00,1)  /* bmap access */
>  #define TARGET_FIGETBSZ   TARGET_IO(0x00,2)  /* get the block size used for bmap */
>  
> +#define TARGET_FITRIM     TARGET_IOWR('X', 121, struct fstrim_range)

I think you need a "#ifdef" here too.

>  #define TARGET_FICLONE    TARGET_IOW(0x94, 9, int)
>  #define TARGET_FICLONERANGE TARGET_IOW(0x94, 13, struct file_clone_range)
>  
> 

Thanks,
Laurent

