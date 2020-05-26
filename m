Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C25C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 08:18:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D9DB20776
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 08:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSUiKduX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D9DB20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdUnM-0003vr-Be
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 04:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdUmL-0002Sh-FQ
 for qemu-devel@nongnu.org; Tue, 26 May 2020 04:17:42 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43716)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdUmK-0006pK-Q8
 for qemu-devel@nongnu.org; Tue, 26 May 2020 04:17:41 -0400
Received: by mail-wr1-x442.google.com with SMTP id i15so19428730wrx.10
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 01:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=rVeWaYkh+55WUlfx5f1RL+YYPQaKW76HE6852F1yfa8=;
 b=YSUiKduXyZTM6GhVpUUud2lmPlwCLGL+taV+4zW4bxXgjmARE4pbT4CywhJ2jC25+s
 QqRaL7nw2j9aU5jYW8EH3J3eIihxGrAxKEx74X/ys6jaJ/lxPHNhglBWOfllMFYSDuyV
 iaQXVkyZS/Cyili69SDbnDpkS9KKDTKG6aiVxLZ2L0slSkCX57gLFtJZPDKwqHasLbf9
 l9HCXByQ2dWEOKALZf8MIU5v1XlZQcfwf+iLHNKlXwM6wnNnsEBsklYFJirGKIi2wnsY
 DlUJ3VLacNiub+XpHO2S4axWEflg0KqcK/ApKvHrgAhA7TApLAQSGI/h6XH/pwW2Ejt5
 oV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rVeWaYkh+55WUlfx5f1RL+YYPQaKW76HE6852F1yfa8=;
 b=lGbgerFNEqwXFJxaFBbJAQARz0Ts/adH2brZXpsYiVYltV1U6Xsk4rQq6eICmcy2wS
 37gK3D95VUot2CAZBqXHCGe3g8Il+4CkrSwnv3bOc8eSFEp0t52pvlZDfL0cfZGifnxa
 6h7HecmGJXXRFSY5QkaPsO0QLK48eoLNAkRW+Gg6c+PIRKJvjBAjl3guSXiDf4l/r257
 +Ex1U98tHOqeWThadmWDT+ctp6CEASFsEV1SPLk0U4o5xkXwc+oEkkLllZVVlXXOsIVi
 UpdumFbgE5EEh6arc4Kw65cTBzHLYAM7PSozjYu0oUaHLUfduvezqu8SmC/HQ/LzPE1w
 dP+Q==
X-Gm-Message-State: AOAM533P++/dwcKmlXeHIOK1ql4UHxH/mFSDiuRtdmo8mQeIBCtXgdDZ
 XUoQTYr7RCa+juNhLjp2VkY=
X-Google-Smtp-Source: ABdhPJwju761sjSflCgsbM7SGseVCPaM7EuO4ZRWYnzoA1g19+FotE21J49sFX6hR1A4ALeNZ5qL3w==
X-Received: by 2002:a5d:538e:: with SMTP id d14mr18649020wrv.174.1590481059177; 
 Tue, 26 May 2020 01:17:39 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id t8sm9737901wro.56.2020.05.26.01.17.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2020 01:17:38 -0700 (PDT)
Subject: Re: [PATCH 1/2] hw/mips/mips_int: De-duplicate KVM interrupt delivery
To: Thomas Huth <thuth@redhat.com>, chen huacai <zltjiangshi@gmail.com>,
 qemu-level <qemu-devel@nongnu.org>
References: <20200429082916.10669-1-f4bug@amsat.org>
 <20200429082916.10669-2-f4bug@amsat.org>
 <CABDp7VoyvX2vD6awEC-GwnEu8SW=pMPPR7mrfKCSzamrnomPKg@mail.gmail.com>
 <dc94a9f4-b6c9-97fa-4515-3e51ef9b816a@amsat.org>
 <193e8262-fa43-2132-02ae-e8bceca86c80@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <997e7635-93fa-d711-4c10-1cf3c02f2482@amsat.org>
Date: Tue, 26 May 2020 10:17:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <193e8262-fa43-2132-02ae-e8bceca86c80@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Huacai Chen <chenhuacai@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/26/20 9:57 AM, Thomas Huth wrote:
> On 12/05/2020 09.08, Philippe Mathieu-Daudé wrote:
>> On 4/29/20 10:48 AM, chen huacai wrote:
>>> Hi, Philippe,
>>>
>>> On Wed, Apr 29, 2020 at 4:30 PM Philippe Mathieu-Daudé
>>> <f4bug@amsat.org> wrote:
>>>>
>>>> Refactor duplicated code in a single place.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>> ---
>>>>   hw/mips/mips_int.c | 11 +++--------
>>>>   1 file changed, 3 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/hw/mips/mips_int.c b/hw/mips/mips_int.c
>>>> index 796730b11d..4a1bf846da 100644
>>>> --- a/hw/mips/mips_int.c
>>>> +++ b/hw/mips/mips_int.c
>>>> @@ -47,17 +47,12 @@ static void cpu_mips_irq_request(void *opaque,
>>>> int irq, int level)
>>>>
>>>>       if (level) {
>>>>           env->CP0_Cause |= 1 << (irq + CP0Ca_IP);
>>>> -
>>>> -        if (kvm_enabled() && irq == 2) {
>>>> -            kvm_mips_set_interrupt(cpu, irq, level);
>>>> -        }
>>>> -
>>>>       } else {
>>>>           env->CP0_Cause &= ~(1 << (irq + CP0Ca_IP));
>>>> +    }
>>>>
>>>> -        if (kvm_enabled() && irq == 2) {
>>>> -            kvm_mips_set_interrupt(cpu, irq, level);
>>>> -        }
>>>> +    if (kvm_enabled() && irq == 2) {
>>>> +        kvm_mips_set_interrupt(cpu, irq, level);
>>>>       }
>>>>
>>>>       if (env->CP0_Cause & CP0Ca_IP_mask) {
>>>> -- 
>>>> 2.21.1
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Thanks, queued to mips-next.

