Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3941C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 08:14:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDA1A206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 08:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmgNUf38"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDA1A206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jffaU-0005eV-39
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 04:14:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jffZv-000566-3V; Mon, 01 Jun 2020 04:13:51 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35768)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jffZu-0007sF-AH; Mon, 01 Jun 2020 04:13:50 -0400
Received: by mail-wm1-x341.google.com with SMTP id q25so1488096wmj.0;
 Mon, 01 Jun 2020 01:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=gBVOAPGbk2ZC7+R4MJVMWGJ2mnZz6fnC8zO0ZzHe3DQ=;
 b=FmgNUf38gOznC7XN8kOYq3bWaG1TCFLMsQnbtBshX2xtU68yHwM0UKr5Slmz9VKitT
 lnMSegoK0P7hnAkER3MtzqcNIlX32gzjGFF8tkspBgxUpATVWYOx+Se3ldPblOVDX78B
 eHan0PTlYrUUE1iF0pLvRnK9TvfDqVX3V4atP8wEFIIHYQ2KaUraMlOWvWpq0s42v/lV
 QqjkmrZAMg7y3KS4Q/+Z9hIs5PPl++VJjj8ySVAr3rD9DGELodSvN4obmK454DTU5Mga
 gIVbB3uvTfrTZHcw7KAncVQJu4lWJscX/0/LF8LqVAVXY6pJQM4Xkp3Bbk+LHdRx7vxk
 OEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gBVOAPGbk2ZC7+R4MJVMWGJ2mnZz6fnC8zO0ZzHe3DQ=;
 b=FKQhm1agkXoZJvF3u3Cg+MG83KSyU8g6vXppX8L3hMrI4Y5fMFqdSCy8gvbsDbf4n2
 qc1gP3riaDvpkPRDr/F+fHtJOh8a2oHQfv/VfXtSusuTajvgvLigvK+rCSG2xCKm6JoH
 nKnjMS4Ko5bZU63dzqhgrBI6z4Rk1QDoJYPwZTEXPQYoeHJJQcI6qjUIGpFRPlQFMFOZ
 cVtDW3iOcFM96SrOto0nVMD4FZIm5ibX6RDDaYCr39eBaQKpIsCHpTVBY0R+ibCqDHee
 Sxef6XnunYA5sMY32a19sikVnq76c9oCmTGQluJ3G7o3lT7UGPhrif7sJew1RIJOjL9X
 83bA==
X-Gm-Message-State: AOAM532GHkEFwlKmaYwVgmo0jBFNU5fcXrgOxvghEGCNkhl4FZRbzvCB
 KgklBz+Cty04iSzKZvllvGI=
X-Google-Smtp-Source: ABdhPJyUgIpW5FzpJp1vEnfNk9LXq5yG0rKBs7rlfLfCDDDcLgs9MJDAGto+T85v35o/2Fv0mWbW8Q==
X-Received: by 2002:a1c:9e13:: with SMTP id h19mr1600547wme.107.1590999228193; 
 Mon, 01 Jun 2020 01:13:48 -0700 (PDT)
Received: from [192.168.1.34] (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id l18sm10965634wmj.22.2020.06.01.01.13.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2020 01:13:47 -0700 (PDT)
Subject: Re: [RFC PATCH 6/6] memory: Use CPU register size as default
 access_size_max
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200531175425.10329-1-f4bug@amsat.org>
 <20200531175425.10329-7-f4bug@amsat.org>
 <CAFEAcA_awdfsv=UJYQmnyCH6cFVz9O9kjUQ9+_jBb_rz73JepA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <37085286-471b-7f94-f8b3-e98eef1604dd@amsat.org>
Date: Mon, 1 Jun 2020 10:13:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_awdfsv=UJYQmnyCH6cFVz9O9kjUQ9+_jBb_rz73JepA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
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

On 5/31/20 9:14 PM, Peter Maydell wrote:
> On Sun, 31 May 2020 at 18:54, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> Do not restrict 64-bit CPU to 32-bit max access by default.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>> RFC because this probably require an audit of all devices
>> used on 64-bit targets.
>> But if we find such problematic devices, they should instead
>> enforce their access_size_max = 4 rather than expecting the
>> default value to be valid...
>> ---
>>  memory.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/memory.c b/memory.c
>> index fd6f3d6aca..1d6bb5cdb0 100644
>> --- a/memory.c
>> +++ b/memory.c
>> @@ -1370,7 +1370,7 @@ bool memory_region_access_valid(MemoryRegion *mr,
>>
>>      access_size_max = mr->ops->valid.max_access_size;
>>      if (!mr->ops->valid.max_access_size) {
>> -        access_size_max = 4;
>> +        access_size_max = TARGET_LONG_SIZE;
>>      }
> 
> This is definitely not the right approach. TARGET_LONG_SIZE
> is a property of the CPU, but memory_region_access_valid()
> is testing properties of the MemoryRegion (ie the device
> being addressed). One can have devices in a system with a
> 64-bit CPU which can only handle being accessed at 32-bit
> width (indeed, it's pretty common). The behaviour of a device
> shouldn't change depending on whether we happened to compile
> it into a system with TARGET_LONG_SIZE=4 or 8.

Agreed.

> 
> (If you want to argue that we should make all our devices
> explicit about the valid.max_access_size rather than relying
> on "default means 4" then I wouldn't necessarily disagree.)

Yes, I'd rather not have access_size_max set automagically, but fixing
this require a long audit, and I suppose nobody cares.
I'll drop this patch. Thanks for the review!

> 
> thanks
> -- PMM
> 

