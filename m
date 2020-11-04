Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF52C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 21:25:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 154922076D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 21:25:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 154922076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaQH9-0008Mc-0D
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 16:25:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kaQGb-0007xX-A0
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 16:24:29 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:48597)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kaQGZ-0005Oy-Nz
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 16:24:29 -0500
Received: from [192.168.100.1] ([82.252.154.198]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MTiHb-1kmL3M3Pfp-00U4a3; Wed, 04 Nov 2020 22:24:25 +0100
Subject: Re: [PATCH] linux-user: Check copy_from_user() return value in
 vma_dump_size()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20201103141532.19912-1-peter.maydell@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <6d19a37d-f7a2-9257-3b58-03a5231b2311@vivier.eu>
Date: Wed, 4 Nov 2020 22:24:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201103141532.19912-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:XakDRKori1/IzKCj3RFAY0JHDk0QhF+F5CwZWKpUvZRREW8XwaV
 FKQHNwWZocg1hkRF0yC5BtIhXRoRDeu2gKeT6YsZ7XTTPZScgd8eRl5FUGOaD5SgWYZ89wa
 Ho4r7933yGzWi2RUe9Xzq6jXZeknAJQqAfTH61dhBn03UNLYOSXThYsKTLpGZ6rxkhghjFM
 ja+ACqRrnBdIBJVmTiMhQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:I3aXxU5EBo8=:A1jHOXQsFmCx8ikFvxx5dY
 FHPgkLK4/2sdl4y2TLdIzFAIixHddQGXfeBTBWiPZkTupXykcwtRm1GSKQ3A5mQhZBYVUSLeI
 UT9yKkpUc6FxB5ejLqE7u4V81Y7GdVlXkzbZ1KwdAQi8yjUjO9KKNgpvBCfRIh4v+vCheuaTX
 uH9qXCk1jyEteDxs9sSH55VW31K7verjBxK+fOIx/Et+PmeP1mVT4v+BrcpoJUkk3w1jlYDAr
 AuhVcsl3drOO0fwE6VZxJhLjBBBoOcy8Tmfvs/JXszXQ/F1PWXdLLGvphO5J8DhK3Va1rYfPK
 hLodPsPKkbfdK6P+1jQQoutHrV7QXt3J7wZX2CwZljQSs9uFsyilhtdB5oqb9rKESOF8+qPPw
 6NsL/h0ofPosQ2DEU4ZHqwzw4sG5824fMOSCtb6fAHtF/berctJcQWQqcf7cf
Received-SPF: none client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 16:24:26
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

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

