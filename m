Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761FEC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 19:02:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42E7020663
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 19:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mfvkRgLM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42E7020663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpz3C-0001oF-I9
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 15:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jpz1R-0000fE-Rv
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 15:00:53 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:37474)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jpz1M-0006k8-O1
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 15:00:53 -0400
Received: by mail-wm1-x331.google.com with SMTP id o2so17156084wmh.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 12:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=H2dqSMC8xHqPnX99k29N87b3vP+L+ekA78ODI4l+FgQ=;
 b=mfvkRgLMsWli+It1TbiwbI5QuRb0v/adpt7eyT+UvhyEWi3lZouE4Jla+Yf0ofSVrT
 wZrpWGMUtzdyjtaohrC8C2yreebUApMy+nE3T/yKU2ly/TxbibZ8g4xLwjuSGupZRF63
 +mDeJ2NiX/NCoMBMYtxQCzoY43FC5f12C8hv5nxP7cclirOmiw4WIMIg5hieATqNjmco
 gJ4c0GTEBnrLBn4JEyTC/VdUIDa9fXQplEJcZFEubd/NNrk8+D7w5zTyKk/ZAPawxahD
 hbXJKhpEyeUm6Sh1ADVE9NzcVGDxb4Lsuk9ou7DjKKkxpTaEdnSGdcL6lfGqrr7yi4A8
 ZXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=H2dqSMC8xHqPnX99k29N87b3vP+L+ekA78ODI4l+FgQ=;
 b=q84imSHdeSHWMjRxfd3siTmmvG/1JfQRFLiEiV1JunwipmANtOZ1lRxw2hluzcdkKj
 lLis0woiOhkRtRgL/Mg//CkC5DUftww4VlYICABm/IJ1wkNOTt/cGWOfVmQvhfHe0F9A
 oaLPRJqFLt6RVXYSaNmDzMljYjYwCGvrGIr1AYoW809+ZvxliEi6FKRDWa1Li1b97rcs
 rUOGR/kk+lioyEwzbzzu4cYWnVXT5gj08HJ9Ke08UUBvAQjOgLcExLrdJLujiskYhEiO
 ExtxJmBtDPsgWX0zCEs+7n6mUR81fwvzboGJRTdKiNrLC9bzquKLYt0sFqbScD3xrWQr
 FR0w==
X-Gm-Message-State: AOAM533dkAMfacdOgT0N5XpMyKwo6P9B7icybm8VMy7Fn3aqaTCs+VsZ
 y1NCP20M4/KemmhjOZBPELZ1t98Q7EU=
X-Google-Smtp-Source: ABdhPJxMCg6xAtpZPdFJgxzk5AYzFl8JetGW7D6GkD2J+2AEJHPYwQ63hhtLXby1+ZeWzyrn/rWdbw==
X-Received: by 2002:a1c:ed17:: with SMTP id l23mr18967788wmh.73.1593457247031; 
 Mon, 29 Jun 2020 12:00:47 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x14sm755540wrt.60.2020.06.29.12.00.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2020 12:00:45 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 55D001FF7E;
 Mon, 29 Jun 2020 20:00:44 +0100 (BST)
References: <158947246472.30762.752698283456022174.malonedeb@chaenomeles.canonical.com>
 <159344662125.1630.9077511492884316123.malone@chaenomeles.canonical.com>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Bug 1878645 <1878645@bugs.launchpad.net>
Subject: Re: [Bug 1878645] Re: null-ptr dereference in tcg_handle_interrupt
In-reply-to: <159344662125.1630.9077511492884316123.malone@chaenomeles.canonical.com>
Date: Mon, 29 Jun 2020 20:00:44 +0100
Message-ID: <871rlxsnmr.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Alexander Bulekov <1878645@bugs.launchpad.net> writes:

> I don't think this is a qtest-specific error:=20
> cat << EOF| qemu-system-i386 -M q35 -nographic -serial none -monitor stdio
> o/4 0xcf8 0x8400f841
> o/4 0xcfc 0xaa215d6d
> o/4 0x6d30 0x2ef8ffbe
> o/1 0xb2 0x20
> EOF
>
> ...
> Segmentation fault

Both this and the qtest have the same problem of depending on
current_cpu which is a TLS variable which will never be correct from the
qtest or monitor context. There are only a few other cases.

sun4m:cpu_halt_signal does:

    if (level && current_cpu) {
        cpu_interrupt(current_cpu, CPU_INTERRUPT_HALT);
    }

pxa2xx:pxa2xx_pwrmode_write does a bare:

    /* Suspend */
    cpu_interrupt(current_cpu, CPU_INTERRUPT_HALT);

but given the context has a CPUARMState *env it could arguably use that
to derive current_cpu but as it's only triggered by a system register
write you can't actually trigger from a monitor/qtest command.

I would suggest either:

        } else if (current_cpu) {
            cpu_interrupt(current_cpu, CPU_INTERRUPT_SMI);
        }

or possibly:

        } else {
            cpu_interrupt(current_cpu ? current_cpu : first_cpu, CPU_INTERR=
UPT_SMI);
        }

if you really care about triggering a real IRQ from outside the CPU context.

--=20
Alex Benn=C3=A9e

