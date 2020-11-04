Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6724C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 21:29:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F89520825
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 21:29:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F89520825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaQLK-0002Vh-4p
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 16:29:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kaQKI-0001fA-C1
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 16:28:18 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:36533)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kaQKF-0005o0-Sd
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 16:28:18 -0500
Received: from [192.168.100.1] ([82.252.154.198]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MTAW9-1kln6226l5-00UXH3; Wed, 04 Nov 2020 22:28:13 +0100
Subject: Re: [PATCH] linux-user: Check copy_from_user() return value in
 vma_dump_size()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20201103141532.19912-1-peter.maydell@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <c83bbc22-f1e1-7bbf-73e8-0fd1e5ce219d@vivier.eu>
Date: Wed, 4 Nov 2020 22:28:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201103141532.19912-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:vWpBNzL6W0MVnuOEivTiyJMAlCOaWH0X975jhINj4P0HO7sKXZF
 RZPiohZ17gkn5Eb+92HkdTg3Htcwh/kX5hvsdbdgjtJgJAOgxjT3FOgUvmzf6FAaKZexP3H
 603ruoH4TRAEpyJlNRldEj3o3P8Ppkg7st7EXkqyiW4y5zLw7STatFaTz6Irhp5DwCYqBgq
 xYIIurEj4L40QeZU/SK0g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xoZkzREqbWU=:nxo6q4/8wLaofOP5MCVjF1
 hofDBQhPcXG5n87TmZZTO5A/1a0CO0kRalenBTjQUIKhiYDVoFtQlc9Y162RNqKxikkooMcNA
 uGI2pl6TcUQnoRdcyxyzu15fc8+obLyOKnyd6ClJIpADLqx1X2MTU+e1jWNfIVT51cSt0PuAE
 MlGQ57hCNdeDePc8L81pgK0kLckhcMIjjmjUENPl3gWcCZHjHRuFXu6RMUGGTZkqz/RuaEiQl
 EPg6ELI2KD96ElqdCNTNTbwLQsQ6nYMzWi3K1wjORKgKeHEbkS0Qcq3yybP+qyIOpCDTjqlAX
 mlU3oo25bRXRBLLi+JCygPCCd94BueUcccp5aZNBhcV5OQUB4SUuBLCT20z1jTOa5pwaEOCGZ
 WYBPoAJq42Tu65xUVxwFe3JuuIuZdGKMBnmV2utZ9dfb4bxQ1D+o5UzBCVxYDhUVloKRHu7KO
 wNSwJObOFA==
Received-SPF: none client-ip=212.227.17.13; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 16:28:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Le 03/11/2020 à 15:15, Peter Maydell a écrit :
> Coverity points out that we don't check the return value from
> copy_from_user() in vma_dump_size(). This is to some extent
> a "can't happen" error since we've already checked the page
> with an access_ok() call earlier, but it's simple enough to
> handle the error anyway.
> 
> Fixes: Coverity CID 1432362
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  linux-user/elfload.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index bf8c1bd2533..e19d0b5cb05 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -3484,7 +3484,9 @@ static abi_ulong vma_dump_size(const struct vm_area_struct *vma)
>      if (vma->vma_flags & PROT_EXEC) {
>          char page[TARGET_PAGE_SIZE];
>  
> -        copy_from_user(page, vma->vma_start, sizeof (page));
> +        if (copy_from_user(page, vma->vma_start, sizeof (page))) {
> +            return 0;
> +        }
>          if ((page[EI_MAG0] == ELFMAG0) &&
>              (page[EI_MAG1] == ELFMAG1) &&
>              (page[EI_MAG2] == ELFMAG2) &&
> 

Applied to my linux-user-for-5.2 branch.

Thanks,
Laurent


