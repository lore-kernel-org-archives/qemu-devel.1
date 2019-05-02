Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F352C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 08:15:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61F7F20651
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 08:15:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61F7F20651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47166 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM6sP-0002ac-C1
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 04:15:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hM6rc-0002HD-12
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:14:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hM6ra-0005dt-5p
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:14:43 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:40047)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hM6rY-0005aT-7M; Thu, 02 May 2019 04:14:40 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1N7hw4-1ghsD944X4-014imF; Thu, 02 May 2019 10:14:22 +0200
To: Alistair Francis <Alistair.Francis@wdc.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <cover.1556666645.git.alistair.francis@wdc.com>
	<c4d2b1de9efadcf1c900b91361af9302823a72a9.1556666645.git.alistair.francis@wdc.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <a5dcdddb-a243-a657-c054-6d46964ebeb6@vivier.eu>
Date: Thu, 2 May 2019 10:14:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <c4d2b1de9efadcf1c900b91361af9302823a72a9.1556666645.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:w8YsW3msqOvJ+oqfdOxI8zH9nKrK9tDJINAvsNA+Iyw8nM26Z7h
	m+x1JkNCXaxkivqRspOpCIv6y8VmjmMI6pQJOhWXHEV2WsadlzRRzVsL9sDCEC2843d6+2D
	mdj34JatILOVfl9v7MmHTrmsUarP5RvCbCWsHqgin7bPyz+3vK0y+3AHExizevOijhiGQxv
	lW2SpwVXB7QnlekfqMCZg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:25S53eKCRLY=:KjPPXVBpH4L2QP21CqIYcz
	nDylwlhBAx/y2yVJlHBgdKtBEXynJjaZo09PX6VQz7LljJI7Py20CO+oIw7UQERlNAwzd8suW
	0CM3109dhJuBTQnbR8iSNxLRx8AwC0l8Yw2JpyPb61gU7uEhR7RQU2QE90TGIhJqR9gp8JeLf
	/zuqZTUYQnKgyqgzm8cu5U5v8mHt3uibetKcpMogpUKiynuBN4ae6Fggb+PiaDPkm6p1KIKO/
	tTYzgIejEKpoKkIZgtnisr2OlcJF/wq5/GUT0kpSeRl3tSy2G1cbBSbjCuHP2i174k3EpRqQS
	pYX609RtFn6XXUnrq0YOBAVJak7dKLys68jH+SLMiip//WhcdnurHl2nDcrLduUKgJq+KqioE
	gtXo+9HMc4twlZn9UoFRQrKD2oKvyTgiEdu2G0V9mkUyuvIzrklUNomBJr+92/5IzEYyQBEAG
	/v3+Ub/1szp2AC4N4Amy882FFEkmhbw6GWsC0T4xFqm1L4hRqQWkbW3ghoyzSbh6aG22uhypf
	sDJ1SbVcvAJQ/VVAec5LPk8OjZLrSbbbtFaL6qpwByW3pYa2ylk6Gc6/dPU0fPjn19Xt/1Wsm
	wl8s0rR5pHXq3SccUBpcVwPIzuIkEbdnM5r9ntHDzx0DHyC3mOAOrIhE0l8lcBHd/cdKGF2f9
	u/X+cQ6hRPAWYfB8rNVqR6VJaoPfFaXUu4tFcKKM6//pxYj61D+2642Nb6NkfjUxk5Eq7awar
	qVjIEOztmY3lOs2ixUsT/WXUnywNpbE6gAFSeyPhgITiTH/45WooOpz5SSo=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
Subject: Re: [Qemu-devel] [PATCH v2 5/5] linux-user/elfload: Fix GCC 9 build
 warnings
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
	"alistair23@gmail.com" <alistair23@gmail.com>,
	"riku.voipio@iki.fi" <riku.voipio@iki.fi>,
	"kraxel@redhat.com" <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502081418.K9Y_UVLsTgxfOBrkuADR7CMwlZ2VeSf3c3mSx8R0Kzk@z>

On 01/05/2019 01:29, Alistair Francis wrote:
> Fix this warning when building with GCC9 on Fedora 30:
> In function ‘strncpy’,
>     inlined from ‘fill_psinfo’ at /home/alistair/qemu/linux-user/elfload.c:3208:12,
>     inlined from ‘fill_note_info’ at /home/alistair/qemu/linux-user/elfload.c:3390:5,
>     inlined from ‘elf_core_dump’ at /home/alistair/qemu/linux-user/elfload.c:3539:9:
> /usr/include/bits/string_fortified.h:106:10: error: ‘__builtin_strncpy’ specified bound 16 equals destination size [-Werror=stringop-truncation]
>   106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  linux-user/elfload.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index c1a26021f8..d08fe23466 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -2872,7 +2872,7 @@ struct target_elf_prpsinfo {
>      target_gid_t pr_gid;
>      target_pid_t pr_pid, pr_ppid, pr_pgrp, pr_sid;
>      /* Lots missing */
> -    char    pr_fname[16];           /* filename of executable */
> +    char    pr_fname[16] QEMU_NONSTRING; /* filename of executable */
>      char    pr_psargs[ELF_PRARGSZ]; /* initial part of arg list */
>  };
>  
> 


Applied to my linux-user branch.

Thanks,
Laurent

