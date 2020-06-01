Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D0DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 07:32:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13F87206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 07:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1u27jNw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13F87206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfevt-0006t4-AT
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 03:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfeu9-0004zx-Sl; Mon, 01 Jun 2020 03:30:41 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35472)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfeu8-0006or-Vc; Mon, 01 Jun 2020 03:30:41 -0400
Received: by mail-wr1-x444.google.com with SMTP id x14so10447791wrp.2;
 Mon, 01 Jun 2020 00:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=t6CZAjpKvay5efhgiUihqDKzDXLlIyFmAam5uOA+cz8=;
 b=C1u27jNwhBi2EhwdP8TKxbFuLZNgUzojprZaL2cVyOQkw4ZraQorN7AlfEh7CWg2c0
 8tnOZH4hjyD9YdwpJ54yMWDdbg/aO6o85jdxRRKpRKsr2HBlxjhtmslPjWoBDA4B3rRI
 3f76/q03DFkyfH8cMJ9Gto8sXq5rQfaC2moePn5bypWLwB5qQxrngtOtlVSO0j2yUshb
 PDuihwHZWh3uiKyM93ngRV6iBARN3X0wHisyyGGq9mJaLcRzN7apMTJp9yaS8bThiZlJ
 DNt9pWOnp9ApI6cj4epw+ZZJVRT9huS6akpNuwRF3csK1dRr+jfPQqe4kK7vlRVaF2JC
 MQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=t6CZAjpKvay5efhgiUihqDKzDXLlIyFmAam5uOA+cz8=;
 b=P3VOo2t3XBKmrJdm27kYt8q6Kj2jYlbNm79wtpAQdchEHKSZJmuLUWmw/yuDxuW3j+
 Cz4MQW/hAQeo95N746SVp7xY/HaO9nAVvqEhMHCtzER3/X1MkiEWJBzU1FSBFAo6jQdl
 7K0K3CF6x+ikFxxxddPlzClywLJ+GVA8ykEbzVa4diMG1lNsIdqQ6VxSwKhq10svc3kP
 +YS3Y3EwLuNRULPunluWA8NsoN+sB6PNYCNAOpMxVldDBdReVq9u0Zh5NJUCqI9atHqo
 jnJRHp5M1Ib0sjQ+kBHg7vmTxLcJ642aZDAk8iHr+Vp8CvOMvXp662hU2/GZ6SrIZCMr
 xnrw==
X-Gm-Message-State: AOAM5334//oUNV+4QG0sGfHrLnC4iR2etgpkPlvVVVe60eayGQ0hfh2B
 +7LgLlGUwm7MW1sHPyhBW+0=
X-Google-Smtp-Source: ABdhPJwzgT5jD5UKJDfVzKlbO18pehVKjWTmZsizlm7VfZ+gyAEyOb6krlFGryDTeoFdff65jCaEYg==
X-Received: by 2002:adf:ed51:: with SMTP id u17mr19044328wro.285.1590996638485; 
 Mon, 01 Jun 2020 00:30:38 -0700 (PDT)
Received: from [192.168.1.34] (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id s5sm10401894wme.37.2020.06.01.00.30.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2020 00:30:37 -0700 (PDT)
Subject: Re: [PATCH 4/6] exec/cpu-common: Do not restrict CPU to 32-bit memory
 access maximum
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200531175425.10329-1-f4bug@amsat.org>
 <20200531175425.10329-5-f4bug@amsat.org>
 <CAFEAcA9bDjiQnr7bw8QiixGtFmFszN6RuN3D-jNEL8mNmk987Q@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f1e075e7-bf80-054a-4b44-69984c637c2f@amsat.org>
Date: Mon, 1 Jun 2020 09:30:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9bDjiQnr7bw8QiixGtFmFszN6RuN3D-jNEL8mNmk987Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/31/20 9:41 PM, Peter Maydell wrote:
> On Sun, 31 May 2020 at 18:54, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> Most CPUs can do 64-bit operations. Update the CPUReadMemoryFunc
>> and CPUWriteMemoryFunc prototypes.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  include/exec/cpu-common.h |  4 ++--
>>  hw/usb/hcd-musb.c         | 12 ++++++------
>>  2 files changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
>> index b47e5630e7..5ac766e3b6 100644
>> --- a/include/exec/cpu-common.h
>> +++ b/include/exec/cpu-common.h
>> @@ -43,8 +43,8 @@ extern ram_addr_t ram_size;
>>
>>  /* memory API */
>>
>> -typedef void CPUWriteMemoryFunc(void *opaque, hwaddr addr, uint32_t value);
>> -typedef uint32_t CPUReadMemoryFunc(void *opaque, hwaddr addr);
>> +typedef void CPUWriteMemoryFunc(void *opaque, hwaddr addr, uint64_t value);
>> +typedef uint64_t CPUReadMemoryFunc(void *opaque, hwaddr addr);
> 
> I don't think the type of these functions has anything to do with the
> CPU's capabilities, does it? The typedefs are a legacy remnant from before
> the conversion to MemoryRegions:
>  * before MemoryRegions, devices provided separate functions for
>    byte/word/long reads and writes (64-bit writes were simply
>    impossible with the ancient APIs, which required a 3-element
>    function pointer array for read and the same for write)
>  * the initial MemoryRegion conversion introduced the new-style
>    "one read/write fn for all widths" APIs, but also supported
>    old-style six-function devices, for ease of conversion, using
>    MemoryRegionOps::old_mmio.
>  * in commit 62a0db942dec6ebfe we were finally able to drop the
>    old_mmio (having changed over the last devices using old-style).
>    (I see I forgot to delete the now-unused MemoryRegionMmio typedef.)
> 
> The only remaining user of these typedefs is hw/usb/hcd-musb.c,
> which is still not converted to QOM/qdev. It uses them to allow
> its one user (hw/usb/tusb6010.c) to perform reads/writes on the
> underlying musb registers.

Indeed you are correct, I have been short-sighted.

> 
> There's no point in changing these typedefs to pass or return
> a 64-bit data type, because their sole use is in the musb_read[]
> and musb_write[] arrays, which only allow for 1, 2 or 4 byte
> accesses, depending on which array element you use.
> 
> Possible cleanups here:
> Easy:
>  * delete the unused MmeoryRegionMmio
>  * move these typedefs into include/hw/usb.h and rename them
>    to MUSBReadFunc and MUSBWriteFunc, since that's all they're
>    used for now

Agreed.

> Tricky:
>  * convert the hw/usb/hcd-musb.c code to QOM/qdev, which would
>    include refactoring the current musb_read/musb_write so that
>    instead of the tusb6010.c code calling function entries in these
>    arrays the hcd-musb.c code exposed a MemoryRegion; the tusb6010
>    code would access it via memory_region_dispatch_read/write

Left as TODO.

Thanks for reviewing this patch.

> 
> thanks
> -- PMM
> 

