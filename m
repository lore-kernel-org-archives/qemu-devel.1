Return-Path: <SRS0=EQsI=67=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2ABC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 23:25:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 849EF20735
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 23:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rA5L+mc1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 849EF20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaSeW-0001Bw-KW
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 19:25:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <agrecascino123@gmail.com>)
 id 1jaSLa-0007a2-6w
 for qemu-devel@nongnu.org; Sun, 17 May 2020 19:05:35 -0400
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e]:34446)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <agrecascino123@gmail.com>)
 id 1jaSLV-0005S2-0C
 for qemu-devel@nongnu.org; Sun, 17 May 2020 19:05:29 -0400
Received: by mail-qk1-x72e.google.com with SMTP id 190so8464724qki.1
 for <qemu-devel@nongnu.org>; Sun, 17 May 2020 16:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=to:from:subject:message-id:date:user-agent:mime-version
 :content-transfer-encoding:content-language;
 bh=dlMCA2GrxTJy0Uo8MeufI/IHN/yWy8B3dbbxHc58vNc=;
 b=rA5L+mc1e20oRRe6R5rPDP5G7mSegzWJEbNobl4EufdNhCD7l6vGrdI6tSzSClpA6l
 F1LeG6nTUl1wu0xjp4iwQH0Gll1LMqarcPbFyfVMdQb6PkWZiGKrjrPAmyDJLbvIzBDT
 wEMW/u1c9byAeJqw08zkS6IrRytt+0AufjWpYdz1ysChvhgqYNOOoV1j6V2BlT4OZzkD
 so9T1S0CXXpjGLtAVYmQnWTnUY0kJWGplyXf/dxDKe2V3M9k0zl8xsO2rRVyhzLykbMk
 WtgdDwD+FO6AOUIlnsh2pKAPsUx4SDW2tfDXlpy7n2ADTky7VvvAoUjSUg9XKKXsEZ7A
 E/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:from:subject:message-id:date:user-agent
 :mime-version:content-transfer-encoding:content-language;
 bh=dlMCA2GrxTJy0Uo8MeufI/IHN/yWy8B3dbbxHc58vNc=;
 b=fC6Mg0Q08KHE0ZGSdWegToIryCzoU9zm34OdsoOC9oAgVkZTfvZUq9Tvia8srNyYJB
 zyyogR1nCCLNcW3FUQTkag1qSHn0DDekubIebZ3bdGLMPAUL5QuoFreQCZ+82GAHgeBx
 G1kaXfWBIGk8nH++6kwJ4wTzW0n5gbhHozMhTjmfENI9iRl8L2DQv2jYQysXAlGnmM/5
 gzpA8f02A4yPnlTMpc/b4hXyMKcO6OVFkaTZaBl02MEAZ5Veri+Ge+78JYqVjHb6pfSN
 hkQ4PsSI7a7vHs3SgEpMxwg6AmSm/d8agGLRWN0BpuaCxa4E5kezR2VlnFK2qp/FsAQV
 T7uA==
X-Gm-Message-State: AOAM5336LdDbpCTzNYGGD1YIw8+SAWp0R+zXNH4Kl84ElyZBZJh8t+3r
 QI6Sjxhw04agBYmBDvKQJ3RnVQ==
X-Google-Smtp-Source: ABdhPJxihfeuwjoVKQQWsqOxon3+0WLJK9Oivnwldc7Ti5ONwMaqS14YSzucLjUSoJOhxWraa6hhwg==
X-Received: by 2002:a05:620a:6bc:: with SMTP id
 i28mr13512873qkh.330.1589756719315; 
 Sun, 17 May 2020 16:05:19 -0700 (PDT)
Received: from ?IPv6:2600:1700:3c90:1b60:59ed:1669:f53f:1f0e?
 ([2600:1700:3c90:1b60:59ed:1669:f53f:1f0e])
 by smtp.gmail.com with ESMTPSA id g26sm7574475qtk.76.2020.05.17.16.05.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 May 2020 16:05:18 -0700 (PDT)
To: qemu-devel@nongnu.org
From: "Catherine A. Frederick" <agrecascino123@gmail.com>
Subject: [RFC] Various questions about TCG implementation, DRM patches dealing
 with pointers over guest-host barrier.
Message-ID: <9d75f1f6-3440-8dec-9266-4841362844d0@gmail.com>
Date: Sun, 17 May 2020 19:05:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=2607:f8b0:4864:20::72e;
 envelope-from=agrecascino123@gmail.com; helo=mail-qk1-x72e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, I've been patching TCG for my own purposes recently and I was 
wondering a few things. That being:

- Is the TCG backend expected to handle bad cases for instructions? I 
was wondering as I found a situation where a very large shift constant 
reaches the backend and causes an illegal instruction to be generated. 
Is the frontend expected to clean this up, or is the backend supposed to 
be able to deal with these? I currently patched the bug via clipping the 
shift constant between 0 and 64.

- I've been implementing an instruction scheduler(list scheduler, with 
priority given to most successors) for TCG and currently if I replace 
instructions in s->ops(the TCG context) I get a crash later in 
tcg_reg_alloc_op, even if the instruction stream is identical. Is there 
anything else I need to move when I do this?

- Is insn_start necessary to have in order(and what does it do?)? These 
currently are serializing instructions in my scheduler and significantly 
limit my reordering as they create lots of dependencies every few 
instructions.

- Is it "okay" to use g2h and h2g directly in code in syscall.c? 
Currently it seems like TYPE_PTRVOID doesn't do this conversion, and as 
such, most of the calls made over the guest-host barrier made by DRM 
seem to fail spectacularly across bittedness lines. I think a more ideal 
solution would be implementing types that do this automatically, so I 
don't have to deal with the difference in struct size using macros, but 
in the short term I don't really have another option.

My last email didn't seem to reach you all, but here's to hoping this 
one does. Thanks!


