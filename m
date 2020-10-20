Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5532C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 00:22:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC6D522240
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 00:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a81vpPTa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC6D522240
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUfQ0-0006XH-Qi
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 20:22:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kUfNk-0005rt-4n
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 20:20:04 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:40623)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kUfNi-0008TK-39
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 20:20:03 -0400
Received: by mail-pg1-x542.google.com with SMTP id x13so988230pgp.7
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 17:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=xRzqJ6T7Dt2auHg6QrCUtkueg2WEpBuVpNhgLM+Th1s=;
 b=a81vpPTa/34Eu3VFfeinhLaguCz9steEE681zUFuVLobjyG4uhoSBk46YHLDZoln9L
 AtSRlPVVmYtyMuDgXPLj2GBaAqUxn8Omo7CxVq9VOXA7wHXz95Rw4MbTVaepVsS3K1Gh
 zZMNZBI3TXD30yUPo0/i5LfFtoD8kyqyaryZkpqNdy2BFb/L+u05nkplbmYe9//RSNud
 LfWbQ7vZemZH3p52UaY3SIPPMuyP9aNI1wSmKAvH7tl8xHmM2MkwMfq94mPS2GlcfXPZ
 eNfSEVpfOxo7NA+jiz7lcqP5ny1YQPtq+96Yi2IeajYxw2kVJaRXM/UehB/A7odCv/iS
 /7Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xRzqJ6T7Dt2auHg6QrCUtkueg2WEpBuVpNhgLM+Th1s=;
 b=Qbguh8jwmoUUcrseM5NYLXE4RSZ/inhYc9s+ujDyLaPzivsRGSt8EYcOTJTJ6QsSOu
 z7y3CsQrottnCTXc/4WyoLvoSl3PJHgYlPCXJNnwst+hocNOlQzMlyB2Mdo4ywjj+H3C
 28sC+3Kwmshd8NGE6+zii29yM9r9jdNv2zBFa+kq5h73gq4lX8DyE2H4K4sJ+BlszmhI
 hgMY7yK9HZTrY8a5wyuqEJ39EOtA59fsmPBVGKCuYgGMHzGkOrYsOcHrZy9Xg8Is61po
 sjcUZVhywfZPCKDZ59Bwe+TTvOzHkWXu9ci2cgOMHdcU93hhtbnAM4Xeink06R4B7of3
 kTQg==
X-Gm-Message-State: AOAM533e0VXOL3SolGeTNF4DpNpSO/OQLxYo1mJL40J+RZPUTKyctm4G
 U2qmdys9Y/jlycWZJ56HzULgu8+x23hWFA==
X-Google-Smtp-Source: ABdhPJzxXpDmNRn7bUhXT0Brj2GmP4rR8+o3isdqEGakh1qs2wyw5MyBKgzFGbase1TBqFtv3tWztw==
X-Received: by 2002:aa7:8429:0:b029:155:d4ac:3914 with SMTP id
 q9-20020aa784290000b0290155d4ac3914mr107221pfn.33.1603153199734; 
 Mon, 19 Oct 2020 17:19:59 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id k25sm125748pfi.42.2020.10.19.17.19.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2020 17:19:59 -0700 (PDT)
Subject: Re: [PATCH v2 6/9] tcg: implement mirror mapped JIT for iOS
To: Joelle van Dyne <j@getutm.app>, BALATON Zoltan <balaton@eik.bme.hu>
References: <20201019013928.72770-1-j@getutm.app>
 <20201019013928.72770-7-j@getutm.app>
 <aa4c227-c33-72dc-92c6-75792f60b58e@eik.bme.hu>
 <CA+E+eSAYV50ACGaAvd_e-eR3FoSiBq6EXqDVRH7vJZyYHvhA8w@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b1a9e0c9-4327-6950-bc58-8c79dbe8b8a0@linaro.org>
Date: Mon, 19 Oct 2020 17:19:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+E+eSAYV50ACGaAvd_e-eR3FoSiBq6EXqDVRH7vJZyYHvhA8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/19/20 3:39 PM, Joelle van Dyne wrote:
>> Explicit cast may not be needed here so this could be a macro if caling it
>> differently helps or why don't you just use tcg_mirror_prr_rw directly
>> everywhere?
> 
> There are quite a bit of code that depends on tcg_insn_unit * type such as
> 
> *tcg_code_ptr_rw(s, code_ptr) = insn;
> 
> and
> 
> (tcg_code_ptr_rw(s, p))[i] = NOP;
> 
> I think it's cleaner to not have to manually cast in every one of 30+
> instances of this. In v1, I used a macro but was told to use an inline
> function instead.

Yep.

>> Is that !defined or are you missing an implementation and #else here?
> No, `flush_dcache_range` is only needed when mirror mapped (after
> writing to the RW mirror). Now there is no iOS compatible compiler for
> any other arch than x86 and ARM. However, in the slim chance that
> Apple decides to change arch again in the future and moves to RISC-V
> or something, then we get a nice compiler error.

*shrug* As opposed to the nice compiler error you get for a missing function
declaration?

That said, I think __builtin___clear_cache() may be the target-independent
runtime function that you need.  Both GCC and LLVM support this, and I'd be
surprised if that doesn't carry through to iOS.

>> Maybe this patch could be split up some more, making the RW offset
>> handling and cache management separate patches even if they don't work
>> separately just to make it easier to review.
> 
> I can probably do that for v3 but imo most of the LOC here is because
> the same change has to be done to every TCG target. No matter how you
> split up the patches, it will look like a lot of changes.

It occurs to me that the majority of the code changes in patches 5 and 6 are
due to your choice that code_gen_buffer points to the RX copy and not the RW copy.

Swap the two, and instead have an inline function that produces the executable
pointer from the rw pointer, and suddenly there are very much fewer changes
required.

For the most part, tcg/$cpu/ generates pc-relative code, so it need not
consider the absolute address.  There are a few exceptions including,
obviously, 32-bit x86.  But the number of places that occurs is small.

There's the assignment to tb->tc.ptr of course, and
tcg_ctx.code_gen_prologue/epilogue.

In any case, each of these changes (generic, per tcg backend) can occur before
you finally add a non-zero displacement that actually separates the RX and RW
mappings.

Finally, I'd like to have this implemented on Linux as well, or I'm afraid the
feature will bit-rot.  This can be trivially done by either (1)
MREMAP_DONTUNMAP or (2) mapping from posix shared memory instead of MAP_ANON so
that you can map the same memory twice.  Thus virtually all of the ifdefs
should go away.


r~

