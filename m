Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F63C352A4
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 21:52:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4EF92072C
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 21:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUqDwgyW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4EF92072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1GyX-0006TO-QV
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 16:52:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46922)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <becholey@gmail.com>) id 1j1GFc-0000sv-8D
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 16:05:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <becholey@gmail.com>) id 1j1GFY-0005qe-AG
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 16:05:50 -0500
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231]:34411)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <becholey@gmail.com>) id 1j1GFX-0005d8-Mr
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 16:05:48 -0500
Received: by mail-lj1-x231.google.com with SMTP id x7so9057034ljc.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 13:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=ISe4DDhuA7yAx5iqGCdiX+aQ+FDLrbOVddZQEvFkTlI=;
 b=OUqDwgyWaC1c6v9/7uNRkHoO4dIX1briw+nU9+10+hqsOsioc7UNgMZe3mQlkxql0Z
 1h/pp4QlhBRZ+0IIcIPRcEWt1mp1nDY3D4ueUGfJbW9xIICAD1MfH/A41EvtdBkXPt/L
 CqOZ5mkkFPg/xaAhHyaSc8/npOi8N6wl8Wf+jxoIJSgxG5LLh2zyq7PeXI+NXChPeUwQ
 dXKkUDRwv7u5yN5Q/AiWVA5D0lq2yZkXPUrWB72lqwEw/MV64oW22oQOhSmMyoWu/IId
 XfmtzX8PWkHIbZ+Fc35OIey69K21PWRRoWBHR6tf+/tyitEMDKGlmsqnVpMQtUiIbebI
 rnbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=ISe4DDhuA7yAx5iqGCdiX+aQ+FDLrbOVddZQEvFkTlI=;
 b=LBDpKaQ/QjSFLssrlQpfzL7FWoDDiQh+OWon74ZX0Gi1qFrph30NjsowwHQHflR78K
 ySvasjRd67ZJPVCRMgtaOp7MqSS2hOx/WLofEc9hIB0nU5smNDxS1h4MpjmE26NCVlZY
 6tYGQUgps0Dmby2MN1aA0m2ZzbBKPFDhcXfZ7EUgQYOY/M9VbGtAEY3WtFz9jmK29yEq
 MrExnpu3TNWvrQR8Q3VLQeZ083OvzFpgNmHmB4b0IAfKcxO4SL2dqrZc8hGNjhWRRPsD
 TddWq9rOKKTfxSvZdhpRvXiCtOaAaANk9yhDWigF37j8gVuIeqi7LXtICoCbEhwT0ybX
 p3pA==
X-Gm-Message-State: APjAAAUQUKPw+JPinmbIelsBKYIExWSVa+gB7T6T7mfZRxb+768+ubTc
 +n7EeS8M1J7QN1AJSg4fy9+eg/2HrbAqNRrzUdKpkrYuSZE=
X-Google-Smtp-Source: APXvYqx2PYAQJaXUP6aM5fTXzW7xPzS4OxvRsg0hFl9fW9GlUgAtOmCqQ3OnNMaHTrnawqCRUiCH0g3XAzmGCUd2kwU=
X-Received: by 2002:a2e:a36a:: with SMTP id i10mr2001145ljn.107.1581368743011; 
 Mon, 10 Feb 2020 13:05:43 -0800 (PST)
MIME-Version: 1.0
From: =?UTF-8?Q?Alexandre_B=C3=A9choley?= <alexandre.becholey@gmail.com>
Date: Mon, 10 Feb 2020 13:06:40 -0800
Message-ID: <CAJjb=44YrmxEZwEDWC7=Qc_gS=qrhKJstJS-AzQP89F=mr_KPg@mail.gmail.com>
Subject: Support for XSAVES intel instructions in QEMU
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::231
X-Mailman-Approved-At: Mon, 10 Feb 2020 16:50:05 -0500
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

Dear QEMU developers,

I am running Hyper-V on qemu+kvm. During it initialization, it checks
for XSAVES support: first it executes CPUID with EAX = 0xd and ECX = 1
and looks at bit 3 in the returned value of EAX (Supports
XSAVES/XRSTORS and IA32_XSS [1]), and then it reads the MSR
IA32_VMX_PROCBASED_CTLS2 (index 0x48B) and looks at bit 20 (Enable
XSAVES/XSTORS [2]). If there is any inconsistencies between the two,
i.e. CPUID shows that XSAVES is supported and the bit is not enabled
in the MSR, Hyper-V decides to fail and stops its initialization. It
used to work until last spring/summer where something might have
changed in either KVM or QEMU.

It seems that KVM sets the correct flags (in CPUID and the MSR) when
the host CPU supports XSAVES. In QEMU, based on comments in
target/i386/cpu.c it seems that XSAVES is not added in
builtin_x86_defs[].features[FEAT_VMX_SECONDARY_CTLS] because it might
break live migration. Therefore, when setting the MSR for the vcpu,
QEMU is masking off the feature.

I have tested two possible solutions:
- adding the flag in .features[FEAT_VMX_SECONDARY_CTLS]
- removing the support of the instruction in
feature_word_info[FEAT_XSAVE].feat_names

Both solutions work and Hyper-v is happily running. I can provide a
patch for the solution you might consider applying. Otherwise, is
there a better way to fix the issue?

Many thanks,
Alexandre

Ref:
[1] Intel SDM Volume 2A, chapter 3, page 196
[2] Intel SDM Volume 3C, chapter 24, page 11

