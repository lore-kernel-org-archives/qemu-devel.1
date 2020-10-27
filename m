Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E40EC56201
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 09:11:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0D8422258
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 09:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgAmzHxo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0D8422258
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXL0h-0000Bf-OB
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 05:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXKzR-0007Ly-0u
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 05:10:01 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:33064)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXKzO-000864-8h
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 05:10:00 -0400
Received: by mail-ed1-x541.google.com with SMTP id w23so647028edl.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 02:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=FDC2IS94hJ6ZVOE+OcjNmrUZyrVlDpOnGcM+dMktz+A=;
 b=JgAmzHxoAo6/PHRKsXv/9auOSxgW8pX6xbIEce7qmZ4mj7OPpvSaiafzAJvXPuWu3J
 KkbbJZvjRvXIN+tv4eEpr+bKpVjaRG4O51yTa24CdNKHIjxIXR4MTO+G++qKsv6yN2uX
 z35ov9/+JE0URjk08gBflNRvn6Ha/B3mq93YyOzDreNnU6FjUoGLrg3w/ZFHueHuCHbC
 Jd9TPC/EYzDIhMHtefKrfKl2xzSb/fu7xDn2Bw/vfUKMKZdpJVWBwuNDOk/U0Yzik25k
 /bGp0OrpEQF0Hyi2sum2Fa8SAuTzE5s+jCAY7qWv9RocWBeQpuZ3BDsjnYOzumeNsgUc
 7jjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FDC2IS94hJ6ZVOE+OcjNmrUZyrVlDpOnGcM+dMktz+A=;
 b=rybGjsczKjND76krhedeY6/1GPqhBIaFMOIIA/8+A7ZBeEdmV3hvg3oI9FF4DuW8Hr
 YR+eFqPlg+ElUCLzoef9QQe3Q68YwmK3eYHXWYxf1F8eUeOrA12LOl9V1h3kHK3yYUem
 i1wSZWGgThxsYdP8WaFe7zVXCygubAGXmok54KoT4kJHuFmazQ86/F32F037znWpXL9d
 VdtktJinHPTKCgaqrMTMpny0SMcA689BsoKXZekhVQOheOqHtlggoyZEOb+mT3Isu4GC
 zmgaPJjq1r6f1ZFySptaBjskxUYUlVz0kKjQLRsnrBu8IsN5wlvsHbfyqODFUN4ZSC4f
 ZjhA==
X-Gm-Message-State: AOAM531MGl7gi/yswwnFCddPmAEkh3Wj6CWGPeGNda0idANg5Dy4IV6P
 2N7V2q3hY+i8E9GbJ307i0w=
X-Google-Smtp-Source: ABdhPJxLLRy/qMpsm8B+Zhz0nCiQzbGI7Ct+t4LWHf4WAB/JKDKfAuSZpX8iLg0DZa4YWPJFIAv5FQ==
X-Received: by 2002:a50:c01e:: with SMTP id r30mr1137597edb.176.1603789796463; 
 Tue, 27 Oct 2020 02:09:56 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id bu23sm526329edb.69.2020.10.27.02.09.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2020 02:09:55 -0700 (PDT)
Subject: Re: [PATCH 5/9] dev-serial: replace DeviceOutVendor/DeviceInVendor
 with equivalent macros from usb.h
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 kraxel@redhat.com, samuel.thibault@ens-lyon.org
References: <20201026083401.13231-1-mark.cave-ayland@ilande.co.uk>
 <20201026083401.13231-6-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4f6d7e47-1585-38bf-ee2c-59a21c652d06@amsat.org>
Date: Tue, 27 Oct 2020 10:09:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201026083401.13231-6-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-2.167,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/26/20 9:33 AM, Mark Cave-Ayland wrote:
> The DeviceOutVendor and DeviceInVendor macros can be replaced with their
> equivalent VendorDeviceOutRequest and VendorDeviceRequest macros from usb.h.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/usb/dev-serial.c | 25 ++++++++++---------------
>  1 file changed, 10 insertions(+), 15 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


