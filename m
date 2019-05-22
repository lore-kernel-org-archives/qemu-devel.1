Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807F3C18E7D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 09:20:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4953F20675
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 09:20:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4953F20675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39018 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTNPt-0006gJ-H4
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 05:20:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTNLq-0004GY-7r
	for qemu-devel@nongnu.org; Wed, 22 May 2019 05:16:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTNLp-0000m8-37
	for qemu-devel@nongnu.org; Wed, 22 May 2019 05:15:58 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:37425)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hTNLo-0000lH-QQ
	for qemu-devel@nongnu.org; Wed, 22 May 2019 05:15:57 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1MOzGc-1hHLCA0mRI-00PLGK; Wed, 22 May 2019 11:14:58 +0200
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1558282527-22183-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1558282527-22183-6-git-send-email-aleksandar.markovic@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <6a227315-4437-7086-58ff-7754c04c2e01@vivier.eu>
Date: Wed, 22 May 2019 11:14:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1558282527-22183-6-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+kQ6+cfxM/hWXHfn2J83nCo8qFRVkB1ny1HY6fCwF6pY1Ruesn1
	14S9KTzhVrfknzRA626A/puwQDTf8zF4M2Ds/ZG9dnL3hpgPTpdBwquDUtqXce6suqjyTmp
	sa/CqRK3MNFUJGk8SQW3MJIBJh9bmhiLN9ktvkTVkoIs/8iHoQDM2VHYBwEhIup9IZXfveZ
	7hOGj1GPnpmTnrw4d6xYA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ncf4ONkxW1k=:6fnYYVTdd+7UbnQ3437gJc
	wSAK1uMbrZCYflTu57ciRih21kQFvxVZ6BShmcGjhi/K0c0jaM246YYjEu1gR7xq/zLejLkAw
	YzhmHubdStMEVXZ12375S/ccdMou0K8mW3sA423vWpgQesZejQz4Bd5LvSowGQENd4mGf4MGy
	FT44wXppQ7tqhabO/apRUYE/E1XCnAmOyXumErqukYnOTF2oNsG8ONpvtYippIgrvFSxu10hg
	pUxOuHxwMX2/KIeEGthmEWSd0AtTUmaGLznWGkBW3X2MHfgB5K0Yc6RRl7QisnxrAUyvvkVu/
	HQuR5x1HYG3C+0i3bomaGQgnDryo9BBYgUargXzeHYPK9AN4lJne18AzmhWZNp9Pv+vcUMdaq
	Wkrpj0EIvAUdV0q9xGdVTgCqs5X3WNeOK/1rsIyJjUhogyXRGQ2dpAVxIUZO8OUun6qTaf9Od
	nYfEMSfvQMTlucT7OKjUsm3IWVKvwHs3G+wqubu7a2mnbt1zESICCjNhBjvret7+GBQUhfVOS
	yxkFjgzxbb0LzcQ8L4wSY2rfgTz01pKKEbGtcMgN2t4g+wBpZyIWcKs73soeAt28pWLc/KaEM
	zIHrvl6L77AJWU2C+eoXnyofc9yBhJYH2qdBajUV3c1KCJDpdzKP1y+N7eb3xNVUmzpvCUp/L
	d4N9WozRggsLQ4Vg0pUsY2vvDev80pEbbwrQ+hwvN1LGR9aNCp2fOS51cdDZOKYzBtV1oftep
	pCFUgg4ZAmdDO2dOJVQ4HxqdQlHZQmLCrfs7N3bsPoGJ+oMzPX//KQhuKhA=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
Subject: Re: [Qemu-devel] [PATCH v6 5/6] linux-user: Sanitize interp_info
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

On 19/05/2019 18:15, Aleksandar Markovic wrote:
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
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
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

Applied to my linux-user branch.

Thanks,
Laurent

