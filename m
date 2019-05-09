Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6411C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 15:51:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8FD42173C
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 15:51:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8FD42173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56858 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOlKk-0003EK-SW
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 11:51:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hOlJb-0001qp-PT
	for qemu-devel@nongnu.org; Thu, 09 May 2019 11:50:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hOlJa-0008E0-76
	for qemu-devel@nongnu.org; Thu, 09 May 2019 11:50:35 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:58385)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hOlJZ-0008Cz-SY
	for qemu-devel@nongnu.org; Thu, 09 May 2019 11:50:34 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
	1M7auL-1hLk6C1pkr-007zqJ; Thu, 09 May 2019 17:50:21 +0200
To: Giuseppe Musacchio <thatlemon@gmail.com>, qemu-devel@nongnu.org
References: <20190503122007.lkjsvztgt4ycovac@debian>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <7fb7832d-4e02-8fb1-f8a3-ed81a71774d5@vivier.eu>
Date: Thu, 9 May 2019 17:50:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190503122007.lkjsvztgt4ycovac@debian>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:/Bd32PGJ1fx6ItS8YPqc0LsQYmAZLIOa+ruwhsS/cTPUgcNSZT+
	rWg5a3Zrs8Ns+xPsAmBI52oEDBOnjGYptoAKy623vgWDXZjAzcpHvrvkJ4/2+Kh/xyCXHl6
	THoaK/IGh6b6H6tnzfIjVoQtA21/f+uEj63fBmNzJNzWq/o6A7kVlGL30JwuWXuw1eUIwiZ
	B8WptJpXlUtPAP/AGFGVg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AhfMfm5L3vM=:yNgdcgI7UDVOh/rhMIzHuw
	7Nc0s6qlve6M4VFHL3h8GqwDmEHIno05YKW/USqyHAL4DnJ/2Fx+a/jwG6ZsbN9rlCVjwos47
	2olOfUyEd2/Ub6toqNfrVfSgZiTGyFr853cmZD1HS+Y1bFkW8g5MisQ4qRKGGXOKlyrYkHk51
	h3JesdMCfkkVOWxsA5YymoJDj6Lsd/zCM7rOAgyTNhiJj49NH2iWFN7HBjVKR10Wcm8e0xAaH
	XGBUf4fX+vvRD7LW/sBhYqGXxau4Xkj5JHnyjyFqFAXWKBK8d+ByPFcbheM2rmz77MZg2R6/x
	r0DAAKipNkafCktPW+XPrT6ET9n9rT6an3nHnPFiL3wkvotDNu20KBKVP6f83UstGyC7CezIf
	zLc/O6ZzgpOr/QHZt8hKl33C/VPbObxprXoUZIgeTb8nTD0zYC1qdVmGKLF+mx1z/PKxBXJVp
	rvwu0Bi3ES2l7BCZnB5CtUSs9FJzSRDPDfWAz+q4ZqFeRviYBUxpbEAWBBKPAEW10ObVDFqBc
	DkyfzIlpn9gWGJh/MpFyMgHuDAjb1VLGUqlqeJxzTCZYat/3rF7pNwWjal6qrd1pYWj6AAIar
	mZkJEBO7I/rP8DgpzBu2XIThhTL4R9ZN/qFCTQiTdF+XtzQRXvmHf6NKN67j77JtfGLlhOIy3
	HvutujYjP4NNq0of+Es5pLffy3V/UpIpVPwZ4o2dphI4oPMi91rgyN4zhQrM81a/AEhWS1JbO
	w0/04OQgVdI0SmjtZfheBSqTskkN2ckeJKdD8sAdTr72482dFJ0wFS+6M0E=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.130
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

I don't find the mail from Peter with his R-b.
Did I miss it?

Thanks,
Laurent

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


