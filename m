Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFC3C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 12:47:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7AE7206E3
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 12:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3A2CaRJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7AE7206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxrgU-0001YM-91
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 08:47:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jxrfY-0000Vx-HZ; Tue, 21 Jul 2020 08:46:52 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:38950)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jxrfW-0005el-Tc; Tue, 21 Jul 2020 08:46:52 -0400
Received: by mail-wr1-x42d.google.com with SMTP id q5so21063133wru.6;
 Tue, 21 Jul 2020 05:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=o9OyYZ1PvfyceNDHrZdu2M/SQe0CGMxOggIZTgQa7v0=;
 b=P3A2CaRJvqs4IovbDtVpUTDw2+RJDUAwma3JVadd1lA9pE5woMm15wFyilIWmUDiM3
 1voIHYFIYFVbaZI/U/64ar+kSfYSL6Vz69P8ZQ08t0YmgsAADNqqED32mv0zLrCd18MC
 uYq6scLm+9pMGClkpHOuNC2EYN92Pd3B8qMoavIUEpqbSW7GU5bBqAzTUEi29bnGrc69
 g+OURDikngdwrFP5IRbLVwidfoEByqRnrf/Bma0GEYWAYx7vDIshyN4LRtYlp9lX/QSH
 Pr4xEsZq7puLM02+X/OhyYisyWn1kt+cZ0BzZC1qAP/rZjd+etwnM1ULM3Kkey+gLhDz
 bOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=o9OyYZ1PvfyceNDHrZdu2M/SQe0CGMxOggIZTgQa7v0=;
 b=gMTsf8RzixIBPyzjdJ+Uj92vsa2Htck/0/7sVhvHn2JRQDFEIexaybIA+y+4YuhtF/
 i+B3o4jksDOWkXcfHPdho5QuOxZ058jKhBF6iMLwCCaKvGUV+JuaxzmWy9W5RiJD9Xp5
 ULhoayP1aTqHyFGUPPXTLK8u4EUWz35Yr0iuOnuQy4yt5roZ+uaHU7B50UeqviWHNxk4
 ZZADZtjZpXiZ5V7inPemebHcmLGE3E5cZbOU48AMbkduIsd/YJZT6AwDttYqkoAHofES
 BiQ3ZhyRrSAwaZdGVezwKZR9BwI9cVtIfqsqxgY57bmilRUeifo7ltQoNq9779CY2SvF
 dUUw==
X-Gm-Message-State: AOAM531jVgVcNCaUjZBfIlxCJLuL8xQpvqYFw2vV31lEIPot/DKaDExH
 Hw6CCWo/cKO/8uwcKQbCVvTRcTK34no=
X-Google-Smtp-Source: ABdhPJwz88kcp6W3iWCvBZt4VNeC+XWCcQJ2Ug+CGkziooShlU9PVBu7jN47MHcg3QND3klb4U0HPA==
X-Received: by 2002:a5d:6683:: with SMTP id l3mr27745298wru.288.1595335609190; 
 Tue, 21 Jul 2020 05:46:49 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id j24sm7687925wrb.49.2020.07.21.05.46.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2020 05:46:48 -0700 (PDT)
Subject: Re: [PATCH-for-5.1] hw/isa/isa-superio: Fix IDE controller realization
To: Markus Armbruster <armbru@redhat.com>
References: <20200720172348.23465-1-f4bug@amsat.org>
 <87zh7t9tda.fsf@dusky.pond.sub.org>
 <c0c7fd3d-fa14-df6f-ecb9-44a7a2a783e6@amsat.org>
 <87wo2x8a1z.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f77d2060-5f9a-e81e-8f61-0b22b7d4ca22@amsat.org>
Date: Tue, 21 Jul 2020 14:46:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87wo2x8a1z.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/21/20 11:57 AM, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
> 
>> On 7/21/20 10:15 AM, Markus Armbruster wrote:
>>> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
>>>
>>>> When realizing a Super I/O with IDE controller [*], we get:
>>>>
>>>>   qom/object.c:1684: object_property_try_add_child: Assertion `!child->parent' failed.
>>>>   Aborted (core dumped)
>>>>
>>>> This is because the device is already realized when we try to
>>>> add the QOM property to the parent. Fix by realizing *after*
>>>> adding the QOM relationship.
>>>>
>>>> [*] Set ISASuperIOClass::ide.count = N with N not zero
>>>
>>> Is this a latent bug, or can it bite in master?  If the latter, can you
>>> show how to reproduce?
>>
>> Latent bug for master:
>>
>> $ git grep ide.count
>> hw/isa/isa-superio.c:149:    if (k->ide.count && (!k->ide.is_enabled ||
>> k->ide.is_enabled(sio, 0))) {
>> hw/isa/isa-superio.c:197:    sc->ide.count = 0;
>> hw/isa/smc37c669-superio.c:100:    sc->ide.count = 0;
>> hw/isa/vt82c686.c:529:    sc->ide.count = 0;
>>
>> I hit it rebasing undergoing series for 5.2 and testing them.
> 
> Let's tweak the commit message like this
> 
>     [*] Set ISASuperIOClass::ide.count = N with N not zero (no such
>     thing currently exists; the bug is latent)
> 
> Preferably with that or something like it:
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

OK. I still consider it worthwhile fixing for 5.1, as while it
doesn't bite master, forks might be affected, since the bug is
in master.

