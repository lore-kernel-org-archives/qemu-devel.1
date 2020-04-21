Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89458C54FCC
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 19:14:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF799206D9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 19:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q8FYAaTY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF799206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQyLc-0005Yh-Dt
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 15:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50820)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pauldzim@gmail.com>) id 1jQyKo-00057d-GJ
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 15:13:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <pauldzim@gmail.com>) id 1jQyKn-00018h-IZ
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 15:13:30 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:55913)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jQyKn-00015a-3v
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 15:13:29 -0400
Received: by mail-pj1-x1043.google.com with SMTP id a32so1771206pje.5
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 12:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ToCopmRtqIqbkCLzyjj4W92sScJsLrQBCI3+f4OqXEE=;
 b=q8FYAaTYqvjHRi0NLCErDczeS2Oef0C7pSRlKrN9eZLEztKffrw2m5qNapU8uT9BHu
 JZMVgF/pIj4Ryy0c7L2tFwe/aL2AoxFrKHNfZ8VKzO5Lf/3Uu/bePUfiV1uHEEf3A1cw
 iMDQQFoS4FJ3v3tF5iMNX8WQ4aO56U8Q6TOoc/kzWknezBopjHk35yWZ7NJNKJUEygah
 RawO+evS8RS3l3+CZaXSukQb5G6LtWUU4RN8MfHj0z8fX7+lmth6UAuwlZHTYNmD22aZ
 08aN45uUg0YwkUWBeWnWVVl0H4PVq5ZzK2g2nlsZeczhx/Hz0fREYcQu2LxOjMo7Oa2X
 cpvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ToCopmRtqIqbkCLzyjj4W92sScJsLrQBCI3+f4OqXEE=;
 b=BX9kpG75v5C5VhsX/y7uZx2QPOaG6/Xd+qUYgeLWxbedl9dD9Uj5fRHUdTfbF38Asp
 Hnxg/RSdBEbmS2LIC48ILpy5oPfaj1orcZLZZv0E4vGu4jXEEpPWKzH/Dlx/P+1rPmQV
 ozLprHxOQY26IohBorJRu07okpB677OlD6srVSQfmBWm8V213DummhE+TX5Vrs1J1gbn
 woXVI9JPZZEnSBPpKa22u4QnmtbYDCthqi94aB0dMwC4h0AbXjFA3tCiBD2MXCqg6ios
 Yj5FoMxc4j3HJJ2eFH0sD21agCxfcp2rrcnjkHNTBmhJeDBf8cB6Wwee98HH7o0ArfUx
 /Qgg==
X-Gm-Message-State: AGi0PuYWZrMjqjMeJbv985lIDNlE7mhradCkizon4x3jrewSlfCOohil
 stgghC31agAfKvSGwiZuIC8=
X-Google-Smtp-Source: APiQypKvughncRWdEO1vsxKgJQHPuc2A79NteepgdpDaKlhS5WjkJJqOtEOFdN4OAzc1yWoS125tPw==
X-Received: by 2002:a17:902:82c4:: with SMTP id
 u4mr22210939plz.219.1587496407522; 
 Tue, 21 Apr 2020 12:13:27 -0700 (PDT)
Received: from [192.168.0.3] ([75.167.104.59])
 by smtp.gmail.com with ESMTPSA id j134sm2854925pgc.7.2020.04.21.12.13.26
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 21 Apr 2020 12:13:27 -0700 (PDT)
Subject: Re: [PATCH] hw/usb/hcd-dwc2: Simplified I/O memory regions
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200421071333.24706-1-f4bug@amsat.org>
From: Paul Zimmerman <pauldzim@gmail.com>
Message-ID: <4ab8a2f0-8b55-c96c-e827-3d3e739e7cc7@gmail.com>
Date: Tue, 21 Apr 2020 12:13:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200421071333.24706-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=pauldzim@gmail.com; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::1043
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/21/20 12:13 AM, Philippe Mathieu-Daudé wrote:
> Use 1 container holding 2 regions:
> - I/O registers
> - FIFOs
> 
> Remove all the static base addresses.
> 
> Name address space.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> Sometime a patch is cleaner/quicker than explanations.
> Suggestion to be squashed on patch:
> 'dwc-hsotg (dwc2) USB host controller emulation'
> 
> Further simplificatio would be to move some exploded read/write
> functions directly into dwc2_hsotg_read/write.
> 
> Based-on: <20200421014551.10426-1-pauldzim@gmail.com>
> ---
>   hw/usb/hcd-dwc2.h |  17 +----
>   hw/usb/hcd-dwc2.c | 181 ++++++++++++++++++++++------------------------
>   2 files changed, 88 insertions(+), 110 deletions(-)

<snip>

Ooh, yes, that looks much cleaner and simpler, thanks! I will test this
and fold it into the next version of the patch.

>   static Property dwc2_usb_properties[] = {
>       DEFINE_PROP_UINT32("usb_version", DWC2State, usb_version, 2),
> +    /* FIXME isn't 'usb_version=2' const? */

This allows to switch between full-speed and high-speed at boot time,
which I've found very useful for testing purposes.

> +    DEFINE_PROP_END_OF_LIST()
>   };
>   
>   static void dwc2_class_init(ObjectClass *klass, void *data)

Thanks,
Paul

