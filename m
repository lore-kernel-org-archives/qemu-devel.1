Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5D7C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 17:39:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4616621E6E
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 17:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qKntDSdM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4616621E6E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvPuF-0006O6-G7
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 13:39:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56628)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hvPtg-0005fJ-Qw
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 13:38:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hvPtf-0000EQ-KA
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 13:38:48 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:43593)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hvPtf-0000B9-B0
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 13:38:47 -0400
Received: by mail-pl1-x642.google.com with SMTP id 4so34848010pld.10
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 10:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=EA88qvAzozVrUA6CGxNTtnZOOxPhbdBbqz6cQni2U8I=;
 b=qKntDSdMHrPkk+J4UwBLYb43bMqF9cNsmBdbtO0FK8JganyV7uyTQ8or9BAogOmaro
 pga5jjzH1qGtSpHdpxvq2oB7RYGMiyslKp9kHAEBGErVqDVqocpyhVv2Nod0voV8ff84
 SY6MT11IbZ8/SpjtnTg2+3ZNywYLl3+vIRChQpDQBiw06QLyYmw/eC896UH9umWOpX6y
 oEFGMIHkr8kBjvr8aD9hoV2T/yCNdY5AEwcNv4DO/tnu+C9k8jy9YydwN/nL1Vd9Is8g
 qg1v7NJsMJGWr4eOTVKqHjvcZvF/04lucLcGFb9Oc8o1N84TJxpua/YiYrAU54tVwKKk
 majA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EA88qvAzozVrUA6CGxNTtnZOOxPhbdBbqz6cQni2U8I=;
 b=WHUMvTG0lsQJYKMHkDQdrkIBy+M7mxF4DlQlYTcVZi/WfI5Yaalgs5l6SAnQ9ER35e
 hdjCveAppERN5nDjqdT1Mc/1+d5bDQyALtsWUYHj2reBHE99vNWLLjVRGqwP/gQHqv2p
 q7BVaJR0TqY2StuaeO2r9Q0CB/Kms1NS130CyFU/gz+DjfKw+WDHtt85Z6rxR5zolzLb
 vFOv69LqUHzuMAUdZ00YJUjh87hLhVsiPLxY2iGbKdcEzcHq5wDn7nXTpabrLEnXPEDF
 QSsPes451U+LWwkhlrjruKHT/s/oTqak2gCj1DlJ2v1NpWdWpZKgyIezEIt73ojnt+3Q
 q9Gw==
X-Gm-Message-State: APjAAAX2KIYCJYBpN0qc4RkQmug4fyXDY01QQdhe5DZBN4vQf4iw6kx4
 jxvygQeQUxPqONjzh989p8CUHA==
X-Google-Smtp-Source: APXvYqwqmCPo/smyD47WHlQMbe+H96vmsz+ljj5kBopE78f/Xl5o/xo4bT3nHsJiUOP7TbKuiz8wIw==
X-Received: by 2002:aa7:8555:: with SMTP id y21mr10575549pfn.104.1565199525861; 
 Wed, 07 Aug 2019 10:38:45 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q7sm105394539pff.2.2019.08.07.10.38.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Aug 2019 10:38:44 -0700 (PDT)
To: tony.nguyen@bt.com, qemu-devel@nongnu.org
References: <45ec4924e0b34a3d9124e2db06af75b4@tpw09926dag18e.domain1.systemhost.net>
 <1565166819111.14515@bt.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <d2f24c92-d210-7e0e-b787-3986123824d4@linaro.org>
Date: Wed, 7 Aug 2019 10:38:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1565166819111.14515@bt.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: Re: [Qemu-devel] [PATCH v6 21/26] cputlb: Replace size and endian
 operands for MemOp
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
Cc: fam@euphon.net, peter.maydell@linaro.org, walling@linux.ibm.com,
 dmitry.fleytman@gmail.com, imammedo@redhat.com, sagark@eecs.berkeley.edu,
 david@redhat.com, jasowang@redhat.com, palmer@sifive.com,
 mark.cave-ayland@ilande.co.uk, laurent@vivier.eu, keith.busch@intel.com,
 jcmvbkbc@gmail.com, frederic.konrad@adacore.com, pbonzini@redhat.com,
 kraxel@redhat.com, edgar.iglesias@gmail.com, gxt@mprc.pku.edu.cn,
 pburton@wavecomp.com, marex@denx.de, robh@kernel.org, hare@suse.com,
 sstabellini@kernel.org, berto@igalia.com, proljc@gmail.com,
 qemu-block@nongnu.org, arikalo@wavecomp.com, jslaby@suse.cz, deller@gmx.de,
 mst@redhat.com, magnus.damm@gmail.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, mreitz@redhat.com, hpoussin@reactos.org,
 joel@jms.id.au, anthony.perard@citrix.com, xen-devel@lists.xenproject.org,
 rth@twiddle.net, philmd@redhat.com, green@moxielogic.com, atar4qemu@gmail.com,
 antonynpavlov@gmail.com, jiri@resnulli.us, ehabkost@redhat.com,
 minyard@acm.org, sw@weilnetz.de, alistair@alistair23.me, chouteau@adacore.com,
 b.galvani@gmail.com, eric.auger@redhat.com, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, peter.chubb@nicta.com.au, yuval.shaia@oracle.com,
 stefanha@redhat.com, marcandre.lureau@redhat.com, shorne@gmail.com,
 sundeep.lkml@gmail.com, jsnow@redhat.com, david@gibson.dropbear.id.au,
 kwolf@redhat.com, crwulff@gmail.com, qemu-riscv@nongnu.org,
 xiaoguangrong.eric@gmail.com, i.mitsyanko@gmail.com, lersek@redhat.com,
 cohuck@redhat.com, alex.williamson@redhat.com, Andrew.Baumann@microsoft.com,
 jcd@tribudubois.net, andrew@aj.id.au, michael@walle.cc,
 paul.durrant@citrix.com, qemu-ppc@nongnu.org, huth@tuxfamily.org,
 amarkovic@wavecomp.com, kbastian@mail.uni-paderborn.de, jan.kiszka@web.de,
 stefanb@linux.ibm.com, andrew.smirnov@gmail.com, aurelien@aurel32.net,
 clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/7/19 1:33 AM, tony.nguyen@bt.com wrote:
> @@ -1246,7 +1246,7 @@ typedef uint64_t FullLoadHelper(CPUArchState *env, target_ulong addr,
> 
>  static inline uint64_t __attribute__((always_inline))
>  load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
> -            uintptr_t retaddr, size_t size, bool big_endian, bool code_read,
> +            uintptr_t retaddr, MemOp op, bool code_read,

I assume the code generation is the same, or nearly so, for these functions?
It seems like it should be, since we're replacing one set of constant arguments
with another, and the compiler should be able to fold away the same set of tests.

But we should at least have a look...

> +    switch (op) {
> +    case MO_8:
>          res = ldub_p(haddr);
>          break;
> +    case MO_BEUW:
> +        res = lduw_be_p(haddr);

I don't like mixing a bare size with size+sign+endian.
I think you should go ahead and pass MO_UB.

> @@ -1605,30 +1605,27 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
> 
>   do_aligned_access:
>      haddr = (void *)((uintptr_t)addr + entry->addend);
> -    switch (size) {
> -    case 1:
> +    switch (op) {
> +    case MO_8:

Likewise.


r~

