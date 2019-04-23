Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713BBC10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 13:49:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45AB1217D9
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 13:49:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45AB1217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54192 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIvnt-00049i-KE
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 09:49:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIvn2-0003qg-KF
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 09:48:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIvn0-0002n8-LN
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 09:48:52 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42927)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hIvmy-0002eQ-Mq
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 09:48:50 -0400
Received: by mail-wr1-f65.google.com with SMTP id g3so20300669wrx.9
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 06:48:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=kVtNZHAyAwB03XbZKrCkIsN1cZrETKy44BQ9Zv6u5T8=;
	b=dOHRt8qqKeldgtpvCLPksDsl3OQJxLjsNz+J3sWkzCySaoMcee62tSUv2COna13t3K
	YXTHMdB1HgvJpHwdxpoHvzUkZ6B/W3VwcTe1xCymC5EFkl54bhF0qX42s/TS6489Pyz4
	QUpt9NcDhnJzKpmcUtLVAJH0WE/oE8emCECCRHamSBKrQAprWya3vadUTngWVCagb8ca
	ZPQzE2CmndumuyeN0UOOPJIi1B8qTOssKQJTV/vpdyOS/7IuZQotL1RFGRprqWlIpuRM
	lebyWicH1b9cdmIcFnC2x9RvIF4WKux08Ur4ku0hSdaTPSGCS4JjJ+LKtNvQVfyEmkbo
	CzRg==
X-Gm-Message-State: APjAAAW0pCg2sCboKGykWiVxyVGlJ2c9+7dlb24zrVtCqlKEYe2JofJx
	ge50KoFJzF9pPQgX2Prd5n9qnA==
X-Google-Smtp-Source: APXvYqxQ9LFbXl24Lr05+ZR0Hxly/B0JOpnoTUn3jUFLtuJ0mNXtsAjQll7kNITAXxkwVol1h21G0Q==
X-Received: by 2002:adf:d850:: with SMTP id k16mr10902747wrl.35.1556027324970; 
	Tue, 23 Apr 2019 06:48:44 -0700 (PDT)
Received: from [192.168.1.25] (atoulouse-656-1-803-163.w86-221.abo.wanadoo.fr.
	[86.221.12.163]) by smtp.gmail.com with ESMTPSA id
	w11sm31298550wre.15.2019.04.23.06.48.43
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Apr 2019 06:48:44 -0700 (PDT)
To: =?UTF-8?B?SmFrdWIgSmVybcOhxZk=?= <jakub.jermar@kernkonzept.com>,
	qemu-devel@nongnu.org
References: <20190423110034.1260142-1-jakub.jermar@kernkonzept.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <ab4b6d04-74f9-2f12-829d-9df8c1b1c4ca@redhat.com>
Date: Tue, 23 Apr 2019 15:48:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190423110034.1260142-1-jakub.jermar@kernkonzept.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v2] mips: Decide to map PAGE_EXEC in
 map_address
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
	Leon Alrae <leon.alrae@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>,
	Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423134842.A5ARwvduHp2qLvyj3VbOzn1uWfHu9xIQtW-L_NR-yiA@z>

Hi Jakub,

On 4/23/19 1:00 PM, Jakub Jermář wrote:
> This commit addresses QEMU Bug #1825311:
> 
>   mips_cpu_handle_mmu_fault renders all accessed pages executable
> 
> It allows finer-grained control over whether the accessed page should be
> executable by moving the decision to the underlying map_address
> function, which has more information for this.
> 
> As a result, pages that have the XI bit set in the TLB and are accessed
> for read/write, don't suddenly end up being executable.
> 

Fixes: https://bugs.launchpad.net/qemu/+bug/1825311

> Signed-off-by: Jakub Jermář <jakub.jermar@kernkonzept.com>
> ---
>  target/mips/helper.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/target/mips/helper.c b/target/mips/helper.c
> index c44cdca3b5..132d073fbe 100644
> --- a/target/mips/helper.c
> +++ b/target/mips/helper.c
> @@ -43,7 +43,7 @@ int no_mmu_map_address (CPUMIPSState *env, hwaddr *physical, int *prot,
>                          target_ulong address, int rw, int access_type)
>  {
>      *physical = address;
> -    *prot = PAGE_READ | PAGE_WRITE;
> +    *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
>      return TLBRET_MATCH;
>  }
>  
> @@ -61,7 +61,7 @@ int fixed_mmu_map_address (CPUMIPSState *env, hwaddr *physical, int *prot,
>      else
>          *physical = address;
>  
> -    *prot = PAGE_READ | PAGE_WRITE;
> +    *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
>      return TLBRET_MATCH;
>  }
>  
> @@ -101,6 +101,9 @@ int r4k_map_address (CPUMIPSState *env, hwaddr *physical, int *prot,
>                  *prot = PAGE_READ;
>                  if (n ? tlb->D1 : tlb->D0)
>                      *prot |= PAGE_WRITE;
> +                if (!(n ? tlb->XI1 : tlb->XI0)) {
> +                    *prot |= PAGE_EXEC;
> +                }

This was indeed missed in commit 2fb58b73746e.

>                  return TLBRET_MATCH;
>              }
>              return TLBRET_DIRTY;
> @@ -182,7 +185,7 @@ static int get_seg_physical_address(CPUMIPSState *env, hwaddr *physical,
>      } else {
>          /* The segment is unmapped */
>          *physical = physical_base | (real_address & segmask);
> -        *prot = PAGE_READ | PAGE_WRITE;
> +        *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
>          return TLBRET_MATCH;
>      }
>  }
> @@ -913,8 +916,8 @@ int mips_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
>      }
>      if (ret == TLBRET_MATCH) {
>          tlb_set_page(cs, address & TARGET_PAGE_MASK,
> -                     physical & TARGET_PAGE_MASK, prot | PAGE_EXEC,
> -                     mmu_idx, TARGET_PAGE_SIZE);
> +                     physical & TARGET_PAGE_MASK, prot, mmu_idx,
> +                     TARGET_PAGE_SIZE);
>          ret = 0;
>      } else if (ret < 0)
>  #endif
> @@ -936,8 +939,8 @@ int mips_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
>                                             address, rw, access_type, mmu_idx);
>                  if (ret == TLBRET_MATCH) {
>                      tlb_set_page(cs, address & TARGET_PAGE_MASK,
> -                            physical & TARGET_PAGE_MASK, prot | PAGE_EXEC,
> -                            mmu_idx, TARGET_PAGE_SIZE);
> +                            physical & TARGET_PAGE_MASK, prot, mmu_idx,
> +                            TARGET_PAGE_SIZE);
>                      ret = 0;
>                      return ret;
>                  }
> 

Your patch looks correct, but I'd like to test it.
Do you have a reproducer?
Can you describe the command line you used?

Thanks,

Phil.

