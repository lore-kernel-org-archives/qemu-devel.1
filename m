Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4943CC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 19:27:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0A6220850
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 19:27:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0A6220850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59878 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOohf-0005v2-K7
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 15:27:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hOogk-0005AL-0V
	for qemu-devel@nongnu.org; Thu, 09 May 2019 15:26:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hOogi-0001va-6O
	for qemu-devel@nongnu.org; Thu, 09 May 2019 15:26:41 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:59093)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hOogh-0001v6-8V
	for qemu-devel@nongnu.org; Thu, 09 May 2019 15:26:39 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
	1MA7b8-1haJwP27o2-00BbpY; Thu, 09 May 2019 21:26:03 +0200
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1556905846-14074-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1556905846-14074-6-git-send-email-aleksandar.markovic@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <e8107377-4e60-e0bd-8095-9c30bf8613a1@vivier.eu>
Date: Thu, 9 May 2019 21:26:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1556905846-14074-6-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+rl+XQHFaJcItFthHhhzqeLG/6qlDK49WrirEmWjCMAbfog5TBx
	s6wvnbwXRCpPf5FdsDF4tYsyKMYloK4mn9QLUHf3SfNWZKqSLK6tlHY4ZnmWJutyPlfUEwM
	HO783/480VyrLnztizjMbuNc9SG+oG+q+Vl8ZTNBix83z5BFsXzQzJV7a3yfZAtVfbI3/qD
	DT26P2bh1F4ULM91ORUZA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Apxjs//Xptw=:ub/LHBY79gu5j5nQqr/z3D
	IpAVGzqrtC6RiMbbfQsU7Dh/+oEgUlnKGuTOAD5Pc/we5ct37tjmLSwokD4ETlYgLnoY7HS1N
	QS9Ngl9r+gwRO7C7XPHcJov3C1cbFmta6NHs2UXlkGOo2iDbgvt+lDnVU+OubICyqit/uvsWI
	rcDagNwqV7sAymjJcRe+C/xPChQ6OiWxqvuvTCBBVwKwV67TCuMwblGsne96JzwlqCzrUO9FL
	1MTASt1sHKJDD4pIdpwNsH82CqoSTiGtLwm7vInTzzavyYe/qT+dHyR3aBbaJuFUJlmmcmJYE
	pKQqJikroGhTuwPS6ji1SRXlAZ6d9FGcHHHHyTnQHiiZ7D5YjeDH57YnEBcaqQg5nbsVOWzHL
	gEjovj4VCXUdHWRcwFfNaKbcbmp8j1VmuoZACzWw3BLsMoY83aCRaMWwnb9Nd3+NWL2Fl7KsS
	zxPk0NOn9nJYX9YX5Tdlb27JaP94NxkcGFQi8ki7EoCxwzwWHmUnJsTIde17tkjAmxExXQ9CQ
	wNM1fVupiMsMs5QcpYIVjtqF+lvWyUwF4d51C1gR2Z8/00aFTy7ZaTCI2UQ44vjML5qL/yvXL
	7kD28259hF9cO5q3Z81mFddF+a229o4BOl0/1o+A5p0WgUtMVpRSYNkjG3KcJuGWoGAOb6UB8
	u+mXDQ7h5GLytFTv7ppaBJPy88q4nqXmgT6KzJjAnh8QOf0JdiWxKZqUSh2PZp0GJ+tztauP4
	/eocySVgDJ6/YFgh35YkufCnFHFVKrmc62/AnsE/qOCl8RQ/ph/S8w+Fq5s=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
Subject: Re: [Qemu-devel] [PATCH v4 5/5] linux-user: Sanitize interp_info
 and, for mips only, init field fp_abi
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
Cc: lvivier@redhat.com, thuth@redhat.com, daniel.santos@pobox.com,
	arikalo@wavecomp.com, jcmvbkbc@gmail.com, amarkovic@wavecomp.com,
	nchen@wavecomp.com, philmd@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/05/2019 19:50, Aleksandar Markovic wrote:
> From: Daniel Santos <daniel.santos@pobox.com>
> 
> Sanitize interp_info structure in load_elf_binary() and, for MIPS only,
> init its field fp_abi to MIPS_ABI_FP_UNKNOWN. This fixes appearances of
> "Unexpected FPU mode" message in some MIPS use cases. Currently, this
> bug is a complete stopper for some MIPS binaries.
> 
> In load_elf_binary(), struct image_info interp_info is used without
> being properly initialized. One result is that when the ELF's program
> header doesn't contain an entry for the ABI flags, then the value of
> the struct image_info's fp_abi field is set to whatever happened to
> be in stack memory at the time.
> 
> Backporting to 4.0 and, if possible, to 3.1 is recommended.
> 
> Fixes: https://bugs.launchpad.net/qemu/+bug/1825002
> 
> Signed-off-by: Daniel Santos <daniel.santos@pobox.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>   linux-user/elfload.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index c1a2602..7f09d57 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -2698,6 +2698,11 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
>       char *elf_interpreter = NULL;
>       char *scratch;
>   
> +    memset(&interp_info, 0, sizeof(interp_info));
> +#ifdef TARGET_MIPS
> +    interp_info.fp_abi = MIPS_ABI_FP_UNKNOWN;
> +#endif
> +
>       info->start_mmap = (abi_ulong)ELF_START_MMAP;
>   
>       load_elf_image(bprm->filename, bprm->fd, info,
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>


