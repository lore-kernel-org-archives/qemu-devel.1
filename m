Return-Path: <SRS0=M+f9=AC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE2CC433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 21:10:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39B68206C1
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 21:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYUa5OAV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39B68206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jn7EQ-0006cD-Eb
	for qemu-devel@archiver.kernel.org; Sun, 21 Jun 2020 17:10:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jn7Dn-00063j-UA; Sun, 21 Jun 2020 17:09:48 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38517)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jn7Dm-0006cP-AU; Sun, 21 Jun 2020 17:09:47 -0400
Received: by mail-wm1-x342.google.com with SMTP id f18so1332395wml.3;
 Sun, 21 Jun 2020 14:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=naHYszvW/t/CWgDpOh9VRRS76DufzIaIyT7gEtT/zms=;
 b=dYUa5OAVS/QJPU4Iw/Z1oINWM9WI/jE9M/oI8AzJ/+FD4vaMafLFA6C+iit+aiJOn2
 lpoR2bVZ2nfWMU9nTeANdTbGoHpSaA/MrlktBWg5YvvjcoNqaRfTPui3Vnn9EtAPTyv+
 9+jUFeRM7wp4vTfnrsG6Cx83ck6GwCcFPM/vkSJhwB6dAAGvjxtKO8GcKMkmz0r0843K
 xmYJW+HDRFDkAkK1tYnTWM6bU7CCpKneQXVSlsFVTGVDCx7p85RaESGJxnvsSp/wDIAi
 9Rea981xUGCe0T/g+gi3Fb84GDp1zcYorliABqnxjmP5FVIjp7jqkKs7jexqo7e9g368
 MDTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=naHYszvW/t/CWgDpOh9VRRS76DufzIaIyT7gEtT/zms=;
 b=rW7ghLN/CSC1CyeVIbkdVkWOV+KVqH93qCZ2NoWuYcf5qCOY2xGXKcAsl3hFPUwZSJ
 uOARBmF5Mgd3KZKodmmz4itqSaM4j8i59/Kntyfp5TZs1wBp4UPrvKRV877lgSp1GISE
 oBTzXBjgFe0dWD4JvtKgQRua1XwuqNDet1ynQJOKG2S1W4vp4+ownz0qWkSJW9pt6QNF
 8yNJM8hLb3dXWNkkBO4M44Ov87TQE9hdME98EuCEbhFAcsT/P3EbA9etRd1xyYJbQXHp
 eD99rTQFAMX0OYRQs0d/lS6va61vzVwifzmMgphOQSGsPLSxJL8Rq0ioUVo9Ym2nJoiz
 uRLQ==
X-Gm-Message-State: AOAM530iAaTZLOCCTI7XGoj0895G1D+NgAcIgLaCQsD0+owsGH13XAOr
 7moimPKgqUwllSrhBN1HcEs=
X-Google-Smtp-Source: ABdhPJzhWhKgV/jdVfoVS/l7WnK+mL1OP8BAFzByI0v5pc0Som4wXvmuYMqTl/qdBxMBep87N3n57w==
X-Received: by 2002:a1c:7e49:: with SMTP id z70mr14619472wmc.24.1592773784559; 
 Sun, 21 Jun 2020 14:09:44 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id o15sm14106629wmm.31.2020.06.21.14.09.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Jun 2020 14:09:44 -0700 (PDT)
Subject: Re: [PATCH v3 5/7] hw/misc/mps2-fpgaio: Use the LED device
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200620230719.32139-1-f4bug@amsat.org>
 <20200620230719.32139-6-f4bug@amsat.org>
 <754c5ed3-9882-9261-80b4-f9e39ace170b@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <468e3d38-539d-e981-313c-7ac3d45e3ac5@amsat.org>
Date: Sun, 21 Jun 2020 23:09:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <754c5ed3-9882-9261-80b4-f9e39ace170b@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/21/20 11:00 PM, Richard Henderson wrote:
> On 6/20/20 4:07 PM, Philippe Mathieu-Daudé wrote:
>> +    DeviceState *led[2];
> 
> Perhaps better as LEDState?  And perhaps return that from create_led.

I guess I first thought about using an opaque structure
with forward typedef declaration, but in this case I also
prefer your suggestion.

Thanks :)

