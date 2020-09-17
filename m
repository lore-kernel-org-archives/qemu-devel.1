Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBFBC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 08:42:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14CE120715
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 08:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hTSqejk/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14CE120715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIpUU-0008UU-8b
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 04:42:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kIpTj-0007sc-Oe
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 04:41:19 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:33036)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kIpTi-0008R9-48
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 04:41:19 -0400
Received: by mail-wr1-x42c.google.com with SMTP id m6so1132091wrn.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 01:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Qy61yhKunS5zPGzFxm8S6IsW6RL2wLbHZpxpsZwVxOs=;
 b=hTSqejk/EeqHWePbfyW5rQ+oiWQ5QczMzNbboR76EOSlPlOL6n2dQAV9eVCR8CUiNF
 DPQrYax0xCN+97MayR4SPrQ0aZdaoNBBpl0nkTpYIsf/VJ3zef6W5GD7VeinL7ikqvr6
 NgEaeii+go9lEuu04DM1CyTWEMBawVO/ZoZeIff1LkK5fy9pfbK29Rkib2anZijpRr/S
 EA7kkcFYJfDgnWzElT/LFyV3HSKdGUYdHBitPaT+oH9vzcAP35Ef9y3c7XE022+TF6bV
 O/wAYbcpODuEvsbb0w6kqBAiR7bZPAVG0s5UPENWVcd49QaaFKsx63XO1sD2f57V1jQE
 kfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Qy61yhKunS5zPGzFxm8S6IsW6RL2wLbHZpxpsZwVxOs=;
 b=r+VYAQGe3zmUANjIK+M4QdtSgL9hvwq2iTXKWt2G5BlhQ3ZWLf2JAuu5to1uscefUu
 z9ltld59lB8NSgOtHCWHxOisdqjXxwi3AibYT2CE0C9kWsmY+2drPnUPlRPH0ee7fy9V
 UyBmqtT1jYYh1Rn3XshJSWQqDa/cJqpSr7mFij6h4jHuWIeLVvCOOCLyuzAiIk8KP0Wi
 OS1l87IJd0nMfWSLMRhzk6/XsZ4xs/hKwA/kXtt8BN0CGqgHbSUaAOlVsxS2XH6YnsLE
 W7klDechYU+yKyTRt8EnV3UrA7LWAhhWVfYETEpNILlG/Z6KQx7XmyvTx/V6P8apnVRk
 evxw==
X-Gm-Message-State: AOAM530eH7ecEeLiH9zdRdHIrQ1tMpG3W5ZIheBllOPL7FQF3sqxT8/r
 0JZ7s3vN+uM9L+up0Ue9auYEng==
X-Google-Smtp-Source: ABdhPJx0Ak/118xTy5iGU/v/k78+7r1YtGkJbWOpwbDaFootWwsbT5T+OcHgWlYVtcvZY8Zk5FGrwA==
X-Received: by 2002:adf:df05:: with SMTP id y5mr33684125wrl.39.1600332076507; 
 Thu, 17 Sep 2020 01:41:16 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i6sm41054357wra.1.2020.09.17.01.41.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2020 01:41:15 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EEE4F1FF7E;
 Thu, 17 Sep 2020 09:41:14 +0100 (BST)
References: <tencent_EAC696641F035EB7E9885302EAAE37455907@qq.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: casmac <climber.cui@qq.com>
Subject: Re: Why QEMU translates one instruction to a =?utf-8?Q?TB?=
 =?utf-8?Q?=EF=BC=9F?=
In-reply-to: <tencent_EAC696641F035EB7E9885302EAAE37455907@qq.com>
Date: Thu, 17 Sep 2020 09:41:14 +0100
Message-ID: <874knwztg5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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
Cc: "Peter&nbsp;Maydell" <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


casmac <climber.cui@qq.com> writes:

> Hi all,=20
> &nbsp;&nbsp; &nbsp; We try to add DSP architecure to QEMU 4.2. To load th=
e  COFF format object file, we have added loader code to load content from=
=20
> &nbsp;  the object file. The rom_add_blob() function is used. We firstly =
 analyze the COFF file to figure out which sections are chained
> &nbsp; together(so each chain forms a "memory blob"), and then allocate t=
he memory blobs.=20
> &nbsp;=20
> &nbsp; The psuedo code looks like:
> &nbsp;=20
> &nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; for(i=3D0; i<BADTYPE; i++){
> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if(ary_sect_chain[i].exist) &nb=
sp; //there is a chain of sections to allocate=20
> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; {
> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ary_sect_chain[i]=
.mem_region =3D g_new(MemoryRegion, 1);
> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; memory_region_ini=
t_ram(...);
> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; memory_region_add=
_subregion(sysmem, ....);
> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; rom_add_blob(....=
);
> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }
> &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; }
> &nbsp;=20
<snip>

> &nbsp; &nbsp; if (unlikely(entry-&gt;addr_code &amp; TLB_MMIO)) {
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; /* The region is not backed by
> RAM.&nbsp; */

This is the crux of it. If the address looked up isn't in a RAM region
then the TLB code can't assume a contiguous page of instructions or that
the instruction executed on one read will be the same on the next so it
will only execute a single instruction at a time and not cache the
resulting TB either forcing a fresh re-translation each time.

All TLB_MMIO access basically force the slow path.

I suspect there is something wrong in your memory region mappings.

--=20
Alex Benn=C3=A9e

