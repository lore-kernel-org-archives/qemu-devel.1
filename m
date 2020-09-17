Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32483C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 17:09:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63BE8206CA
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 17:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yEkloMDV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63BE8206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIxPS-0003Q0-Il
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 13:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kIxMO-0008Ei-5g
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 13:06:16 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36666)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kIxMM-00062u-9i
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 13:06:15 -0400
Received: by mail-wr1-x442.google.com with SMTP id z1so2880552wrt.3
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 10:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=YLGBbGhq3qo921u43dT0Kw2MJiy8JvwoZTD/f0mJQJ0=;
 b=yEkloMDVdT3b1Au63g6UuGL9fSEHCSZwGlGSzknAoO6XHFumZXiFlCMniJvug19hTF
 hmWN3KYCbiy3s4wsWGDuUl3T/sj9ezTp0MFGWf462+xsqGPLVJJsXK3lMrLS+rdIxKiV
 x1a+KVu3xXdi8HlIZhAsycOGhH9OEPkSE0u9XtKSULNA08iQ8tp1KuB5f8M2BCz8dgSn
 Z92Wk+KqdIe5Q/j2BlUu1hDHCJtwZb4eCEsFs4i2T5ke0cDs5bNew/kw88+IRPLZVgns
 tsSyRKCZYveSS8eHcQrw9fPT7Od9duDFsK8eT25GcA6kajMdXiP0u7LLEQL7ZrMZvPoJ
 2ALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=YLGBbGhq3qo921u43dT0Kw2MJiy8JvwoZTD/f0mJQJ0=;
 b=DCCltI9mcW0GyDA3gXAs53cg1U02N/2gc207gWyCblHXXJA2Tt8LS3PnRLX9+Zp8Hj
 j2hMcq/bsR8U1bY02UTp5168t16cnhQUSjAHauPG6hHghdnZN3MGkdmFotpa1U2D33m+
 HfezbW0FdG0ZKwMft9bm6WPX6ugKXGs+fWafsc8CGUx7bKfHHDa0MjAGXYtf76WUFlKW
 MJWSdhYXyMKl7kSVliaDam3CxEJzCs6ak0Che3d7ykJXF7kX8kP7nKtnLj+6DS7oqVqb
 GLdSvr0/+0esDjx7tVRy5txoRG/fQQunvto5o0n6TvzYda3rr7sQOq9isnAOpoSoJJIT
 8bOw==
X-Gm-Message-State: AOAM532t2jT9tfnHoo4FpK2fU86tA8Av7dTH2ry2TcwOOPfbRwqs0YgU
 WLdzDD8vFWLETuoKIDY+RsV8GA==
X-Google-Smtp-Source: ABdhPJyR6c0onzfD0cYiNHiACl2Qjajf1n0EQLuq6wznUwqefxP+bved41rDsHMFzqrTC5tXaYy/bw==
X-Received: by 2002:a05:6000:11c5:: with SMTP id
 i5mr33969323wrx.18.1600362372518; 
 Thu, 17 Sep 2020 10:06:12 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e18sm239522wrx.50.2020.09.17.10.06.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2020 10:06:11 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AF3DC1FF7E;
 Thu, 17 Sep 2020 18:06:10 +0100 (BST)
References: <20200914230210.2185860-1-richard.henderson@linaro.org>
 <20200914230210.2185860-5-richard.henderson@linaro.org>
 <1eb5fb1b-4341-88e9-16b1-f9db78eceadb@redhat.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2 04/10] disas: Clean up CPUDebug initialization
In-reply-to: <1eb5fb1b-4341-88e9-16b1-f9db78eceadb@redhat.com>
Date: Thu, 17 Sep 2020 18:06:10 +0100
Message-ID: <875z8cxri5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: luoyonggang@gmail.com, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> On 15/09/2020 01.02, Richard Henderson wrote:
>> Rename several functions, dropping "generic" and making "host"
>> vs "target" clearer.  Make a bunch of functions static that are
>> not used outside this file. Replace INIT_DISASSEMBLE_INFO with
>> a trio of functions.
>>=20
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  include/disas/dis-asm.h |  60 --------
>>  disas.c                 | 326 ++++++++++++++++++----------------------
>>  2 files changed, 148 insertions(+), 238 deletions(-)
>>=20
>> diff --git a/include/disas/dis-asm.h b/include/disas/dis-asm.h
>> index 9856bf7921..d2418c977e 100644
>> --- a/include/disas/dis-asm.h
>> +++ b/include/disas/dis-asm.h
>> @@ -461,67 +461,7 @@ int print_insn_riscv32          (bfd_vma, disassemb=
le_info*);
>>  int print_insn_riscv64          (bfd_vma, disassemble_info*);
>>  int print_insn_rx(bfd_vma, disassemble_info *);
>>=20=20
>> -#if 0
>> -/* Fetch the disassembler for a given BFD, if that support is available=
.  */
>> -disassembler_ftype disassembler(bfd *);
>> -#endif
>> -
>>  
>
> By the way, while you're at it, could you please also remove the form
> feed character in this file here? ... that looks really confusing in my
> e-mail client otherwise.

I'm not entirely convinced that is from Richard. I've been seeing rouge
^L and ^M's from all sorts of normally unix clean contributors. I smell
mailing list shenanigans.

--=20
Alex Benn=C3=A9e

