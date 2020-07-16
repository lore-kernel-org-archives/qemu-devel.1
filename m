Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D83C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 16:41:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62AA52070E
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 16:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NaVSv5s1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62AA52070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw6wV-0005MJ-LN
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 12:41:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1jw6vr-0004py-3g; Thu, 16 Jul 2020 12:40:27 -0400
Received: from mail-qv1-xf43.google.com ([2607:f8b0:4864:20::f43]:46017)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1jw6vp-000886-JI; Thu, 16 Jul 2020 12:40:26 -0400
Received: by mail-qv1-xf43.google.com with SMTP id u8so2968605qvj.12;
 Thu, 16 Jul 2020 09:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=EdnCkhLLQQ4iKOgyvIdVF++NV8KLJA7oPpw+msS+o+M=;
 b=NaVSv5s1pcBPdKlBQNsEmYPgR5NufctaroDRyTMdHUsplhindDw1g0DRGYXxUHtWmP
 neQTSg5y9C0OcYbmndD7vkr5+2RDWb0nyTjOA3vKMzQO5MgA+YLgN5+LbDLOg7Hx7LrT
 yYUQE7Sr+3b5XOF94nvTZGwh/vVWrQ4oYnA3ttcenAdPc50/Datf4efhJYmDxV+MmjUK
 muDA1xJB9IcleHCqiHf9jqOy2RQQGyLu1H1QYjZc6HqbvTmqO1hYpSf/j3rWTcB+EYru
 +Lbw5U2N/o4erFsUjIwAcjs6FdnNeEMKDSWTwbjMXTaByLPmzNBnQ+i7rPz3lhbxbsUt
 qIAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EdnCkhLLQQ4iKOgyvIdVF++NV8KLJA7oPpw+msS+o+M=;
 b=hR3jikwv/Mrrn/ffd2ZsC+dT75JHiOPiWJI6LJYxH6gyqlNMolra/EWE7DeCVNylUZ
 R85+KJyekjGXvFD7I9qcz2aApJr++XFUeWeFFF6L+ILZYZaROI4JZUAI8rpCSTssuZXU
 JOYbLyd3NYngQzOfalvt35tfSi+09CTf3b3SSDX/GEAw9Xoe7z1Pm3dV51/ahYiZp9Hz
 p4TXarG94p00anxRuSw9OFwlYSup5CuEq9U/NPVTa/FarvfW2pBs8lBa3+QGV4ZvM1sA
 6FwWwHJ1OEcn+c2dzja0YVHQUgKN+De1IZPhpsWKhgbWMDuF6U2GWkFAC9wkBm7Gn5pV
 yUwg==
X-Gm-Message-State: AOAM532wXnj0ronDAJegSoxLNxBoGQ89gYTui68Xl+Xl338HJEMSoUFs
 nyI7d4cwp0YN5rOjDrnj+BSuI7WQ
X-Google-Smtp-Source: ABdhPJzstrJYWsH33dee44mk++Ymb4TwC8eNDfTfoWz4ak0bdTbpRMrSPvyHtESZazfCno4ROHZEjw==
X-Received: by 2002:ad4:4f4b:: with SMTP id eu11mr5269625qvb.142.1594917624404; 
 Thu, 16 Jul 2020 09:40:24 -0700 (PDT)
Received: from ?IPv6:2804:431:c7c6:9447:1f8b:580e:61d9:b1a4?
 ([2804:431:c7c6:9447:1f8b:580e:61d9:b1a4])
 by smtp.gmail.com with ESMTPSA id j203sm7619667qke.13.2020.07.16.09.40.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2020 09:40:23 -0700 (PDT)
Subject: Re: [PATCH v3] spapr: Add a new level of NUMA for GPUs
To: Reza Arbab <arbab@linux.ibm.com>
References: <1590177213-4513-1-git-send-email-arbab@linux.ibm.com>
 <20200525050550.GA23110@umbus.fritz.box>
 <20200525174927.aky64nw7p7xztqzh@arbab-vm>
 <20200716050459.GM93134@umbus.fritz.box>
 <cdbdf33f-f63b-ea5b-befc-0b94904b42ca@gmail.com>
 <20200716160017.jw27huiqs2ghk4c4@arbab-vm>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <326ed981-5a8c-0ef2-5b88-a893a53956cd@gmail.com>
Date: Thu, 16 Jul 2020 13:40:19 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200716160017.jw27huiqs2ghk4c4@arbab-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f43;
 envelope-from=danielhb413@gmail.com; helo=mail-qv1-xf43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: Daniel Henrique Barboza <danielhb@linux.ibm.com>,
 Leonardo Augusto Guimaraes Garcia <lagarcia@linux.ibm.com>,
 Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 7/16/20 1:00 PM, Reza Arbab wrote:
> On Thu, Jul 16, 2020 at 06:42:11AM -0300, Daniel Henrique Barboza wrote:
>> Which would translate here to:
>>
>>        uint32_t associativity[] = {
>>            cpu_to_be32(0x4),
>>            cpu_to_be32(nvslot->numa_id),
>>            cpu_to_be32(nvslot->numa_id),
>>            cpu_to_be32(nvslot->numa_id),
>>            cpu_to_be32(nvslot->numa_id),
>>        };
> 
> Sure, that's how it originally was in v1 of the patch.

Yeah, Greg commented this in v2 about this chunk:

------------
This is a guest visible change. It should theoretically be controlled
with a compat property of the PHB (look for "static GlobalProperty" in
spapr.c). But since this code is only used for GPU passthrough and we
don't support migration of such devices, I guess it's okay. Maybe just
mention it in the changelog.
--------------

By all means you can mention in changelog/code comment why the associativity
of the GPU is nvslot->numa_id 4 times in a row, but I believe this
format is still clearer for us to understand. It also makes it equal
to skiboot.

And it deprecates the SPAPR_GPU_NUMA_ID macro, allowing us to use its value
(1) for other internal purposes regarding NUMA without collision with the
GPU semantics.



Thanks,


DHB


> 
> I'll send a v4 today. It's been a while so I need to rebase anyway.
> 

