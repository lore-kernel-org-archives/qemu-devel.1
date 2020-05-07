Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F594C38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 12:12:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0187A2075E
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 12:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6aWz9Pi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0187A2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWfNo-000197-2d
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 08:12:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jWfN2-0000H1-BB
 for qemu-devel@nongnu.org; Thu, 07 May 2020 08:11:20 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53650)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jWfN1-0001G2-Bf
 for qemu-devel@nongnu.org; Thu, 07 May 2020 08:11:19 -0400
Received: by mail-wm1-x344.google.com with SMTP id k12so6216131wmj.3
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 05:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=wFVKzsYazuYKj9heOP0kOc+xOXwZKNaQI+1syNAe7nw=;
 b=I6aWz9PinYdDL2Xq1qEgKDQ/b/d3dIjL+jTkyjvbBUGSvPWEJa3WrLKsomaQZmIQZ6
 q6GOJVMlzDXjjZqfu+p/mcA3bPpg7OyDDYU0Ybmh3ADqy7B4C9ooE4ylTcVngppiecPU
 p53doAurX4EcwJC1lOQ+FlA/AjRACV0R2JhEuLpxKdO3OlcaDBJrE96Lcx4Q11Hq4ojT
 kRN73rNpgIOrz1aunSJZ2dsjId17C8YrLH+3AYqKJPdRBHQc2k5gnnq0SwzIUinf5flk
 EINaCym/k8kiybNxkE+Pg6xs99GIplZLQ8ZRyZIOHnHktX/gW/j5D2EWf7Q8PhOw+6fJ
 8wFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=wFVKzsYazuYKj9heOP0kOc+xOXwZKNaQI+1syNAe7nw=;
 b=j3E1fhODm1BICkzyZ86JglUWr/SXbSxGtvnImttYobDYJcv/tOQuIjsvSj/Aa23Ujc
 X4c5f3cTjrwgNxHxtXv4Wy3uQupggujIwVjrzrIqybfQv0FlUBCFd9N7iYU+fciIcLjc
 Jw0m8xfKlF2R2UKAjR+UBTo2UD0R4/52Hgbzfq6irnRdEEMDRU1Fwl7kWOQTokB61VxS
 xaRVbzx2i+yqqfNgEDU1pvZBa7PfcMWtF9mq6/V8Z7zN48XluFsAN0qlT/66nEzSirKN
 bRBiBOrT1W7oj6x8b18Mx0TXo8saQdfEIbBpC8qRqtbQDKBpStywJz656Teg1f3g2DJS
 rDhA==
X-Gm-Message-State: AGi0Pub9zIatlH1oyva3VfI7wxOtdBRGerNA6uEdS7OYElCy6JqgqtBx
 uoeW15MymMUDxX2+zvsQ6TvS6BeVUC/pW/cha18=
X-Google-Smtp-Source: APiQypIrutgCXbulDuAlppfAP6QmfR1GsEMUzPJyU74jqdfzmnkrsibTkvJbih7/k7aJeZ7N5jQMz0hzTsZIfDhSnEg=
X-Received: by 2002:a7b:c74d:: with SMTP id w13mr9755931wmk.36.1588853477169; 
 Thu, 07 May 2020 05:11:17 -0700 (PDT)
MIME-Version: 1.0
References: <1588500367-1056-2-git-send-email-chenhc@lemote.com>
 <20200506234214.2887220735@mail.kernel.org>
In-Reply-To: <20200506234214.2887220735@mail.kernel.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Thu, 7 May 2020 14:10:55 +0200
Message-ID: <CAHiYmc4u6iM8BsEX-bHgFk6eD36FcE=_P-n29U0P=51Cyb5YVA@mail.gmail.com>
Subject: Re: [PATCH V3 01/14] KVM: MIPS: Define KVM_ENTRYHI_ASID to
 cpu_asid_mask(&boot_cpu_data)
To: Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kvm@vger.kernel.org, QEMU Developers <qemu-devel@nongnu.org>,
 stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Huacai Chen <chenhc@lemote.com>, Xing Li <lixing@loongson.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D1=87=D0=B5=D1=82, 7. =D0=BC=D0=B0=D1=98 2020. =D1=83 01:43 Sasha Levin <s=
ashal@kernel.org> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=
=D0=BB=D0=B0:
>
> Hi
>
> [This is an automated email]
>
> This commit has been processed because it contains a -stable tag.
> The stable tag indicates that it's relevant for the following trees: all
>
> The bot has tested the following trees: v5.6.10, v5.4.38, v4.19.120, v4.1=
4.178, v4.9.221, v4.4.221.
>
> v5.6.10: Build OK!
> v5.4.38: Build OK!
> v4.19.120: Build OK!
> v4.14.178: Build OK!
> v4.9.221: Build OK!
> v4.4.221: Failed to apply! Possible dependencies:
>     029499b47738 ("KVM: x86: MMU: Make mmu_set_spte() return emulate valu=
e")
>     19d194c62b25 ("MIPS: KVM: Simplify TLB_* macros")
>     403015b323a2 ("MIPS: KVM: Move non-TLB handling code out of tlb.c")
>     7ee0e5b29d27 ("KVM: x86: MMU: Remove unused parameter of __direct_map=
()")
>     9fbfb06a4065 ("MIPS: KVM: Arrayify struct kvm_mips_tlb::tlb_lo*")
>     ba049e93aef7 ("kvm: rename pfn_t to kvm_pfn_t")
>     bdb7ed8608f8 ("MIPS: KVM: Convert headers to kernel sized types")
>     ca64c2beecd4 ("MIPS: KVM: Abstract guest ASID mask")
>     caa1faa7aba6 ("MIPS: KVM: Trivial whitespace and style fixes")
>     e6207bbea16c ("MIPS: KVM: Use MIPS_ENTRYLO_* defs from mipsregs.h")
>
>
> NOTE: The patch will not be queued to stable trees until it is upstream.
>
> How should we proceed with this patch?
>

Hi, Sasha.

Please wait for the the review of the whole series. It might also be
the case that this patch will be upstreamed before the whole series,
but please do not rush or skip regular review process.

Thanks for you involvement and efforts!

Aleksandar

> --
> Thanks
> Sasha
>

