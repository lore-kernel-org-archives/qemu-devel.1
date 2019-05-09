Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A32C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:09:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 375632173C
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:09:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 375632173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58110 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOmXe-00074x-64
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 13:09:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hOmRC-0001i4-P2
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:02:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hOmRB-0006c7-MP
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:02:30 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:49069)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hOmRB-0006bf-DD
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:02:29 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
	1MDyoW-1hWVg617P2-009wnW; Thu, 09 May 2019 19:02:18 +0200
To: Giuseppe Musacchio <thatlemon@gmail.com>, qemu-devel@nongnu.org
References: <20190503122007.lkjsvztgt4ycovac@debian>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <466e8902-df09-1f20-1c9e-9e625608744e@vivier.eu>
Date: Thu, 9 May 2019 19:02:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190503122007.lkjsvztgt4ycovac@debian>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:jQVOXQQ9GYng1acHe89GwQNWYZj+tHoSJzGrxHWxUI8x4LPFXLg
	NNxcT+SU1tXU1znxTdNynY005fDHrYmb2LTJOINBlBDWlmBaQW4GNn1pDrijdZUJ3bgf0wD
	4WhvmQMorLOxini4IIdTPmM1CF/bIjM5GVS8GZXkjF1RuHqOV92w3DBs1DJJ59b9Vw9X4Uc
	ylccJ+utLkQy3FG853+jw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dywa3hX6Q6I=:S6g0RkvMFzJoDnPib75HVC
	5rQ/ZFbV8WP0+SrVShVLhW/uUJFLtRMHpDvfg2j6NHOqJ72xvGHwJTPEgBMtCnpf7zWHK8sKO
	f10dDnwNQ2uULCHufiWHLc7QJ6PNUoosgfYiZa07OXbU/chtCIcKnEoS9OHtD0kq2eUJjDEGg
	QFWsB2FiIsYvNyVZu3aHyvX/Gn2GSnZ0tEpFSZemVc2nhAXNIpij7833VPHoMAVdvrHUoGSfM
	sqWVWhcKMEe7Ses9fEOCL1na/J4yX885QkJ8ZhoQPGX8au9B2awqBgBqPc7WF7ZD8DSCBP1ID
	WoUglz/G+86qvwhb/O3BrW+v5RJhldSIEuNasvAfXerL3zvvcv9yf5YLsilJWuhVnNQTBtJsh
	KyYKdYbTfvL2wPiGLUIuipw6unKV7H5d+cRIoevVAzIN4nAXM9yPFiYSWPw1cbMQBoTzML21i
	5GsTUWKxUkAm77gpHeTBONNSjtuetAXjMmhHIcp+/wd0WsL5xHODHzFAo0yjQveawaP+vcmR/
	SZ9kErEtuxtjMGfPioo4o/vYCPVsrt+fTbkFP72jDCxgUeuYIXCTKQOH5+YFmrR7KxYfG0XZZ
	ZsP30WD1ec99KekIspIAt1TvRuEOg/dv+qbE44japu1hfmYJt+BBisUI9HWJM9aZSP6nNNifn
	h5NzQf/3EeSybz8DesVD3j1LzphEnTqJc5vljdQJJR6oJhWW5tuB7+9j2pM1JQQfmeVM1TqP0
	RAl34hkMevynBpK8jq9+ONV9RoOOHV0VtHRqjdB1E1+JxZzTTdGj2HEr/Zg=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.134
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: elf: Map empty PT_LOAD
 segments
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
Cc: peter.maydell@linaro.org, riku.voipio@iki.fi
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/05/2019 14:20, Giuseppe Musacchio wrote:
> Some PT_LOAD segments may be completely zeroed out and their p_filesize
> is zero, in that case the loader should just allocate a page that's at
> least p_memsz bytes large (plus eventual alignment padding).
> 
> Calling zero_bss does this job for us, all we have to do is make sure we
> don't try to mmap a zero-length page.
> 
> Signed-off-by: Giuseppe Musacchio <thatlemon@gmail.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   linux-user/elfload.c | 18 +++++++++++++-----
>   1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index c1a2602..138735b 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -2366,11 +2366,19 @@ static void load_elf_image(const char *image_name, int image_fd,
>               vaddr_ps = TARGET_ELF_PAGESTART(vaddr);
>               vaddr_len = TARGET_ELF_PAGELENGTH(eppnt->p_filesz + vaddr_po);
>   
> -            error = target_mmap(vaddr_ps, vaddr_len,
> -                                elf_prot, MAP_PRIVATE | MAP_FIXED,
> -                                image_fd, eppnt->p_offset - vaddr_po);
> -            if (error == -1) {
> -                goto exit_perror;
> +            /*
> +             * Some segments may be completely empty without any backing file
> +             * segment, in that case just let zero_bss allocate an empty buffer
> +             * for it.
> +             */
> +            if (eppnt->p_filesz != 0) {
> +                error = target_mmap(vaddr_ps, vaddr_len, elf_prot,
> +                                    MAP_PRIVATE | MAP_FIXED,
> +                                    image_fd, eppnt->p_offset - vaddr_po);
> +
> +                if (error == -1) {
> +                    goto exit_perror;
> +                }
>               }
>   
>               vaddr_ef = vaddr + eppnt->p_filesz;
> 

Applied to my linux-user branch.

Thanks,
Laurent

