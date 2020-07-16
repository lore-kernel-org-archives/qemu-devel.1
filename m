Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8968BC433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 09:42:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5817F2065D
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 09:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NV6Y8FD5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5817F2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw0Po-0006cI-MD
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 05:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1jw0PE-00067J-5v; Thu, 16 Jul 2020 05:42:20 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:34369)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1jw0PC-0004hh-Ge; Thu, 16 Jul 2020 05:42:19 -0400
Received: by mail-qt1-x844.google.com with SMTP id w34so4391517qte.1;
 Thu, 16 Jul 2020 02:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=35wWFZYsgjxKhlzRkt/hqrCBvNSntuG0Se1BDCFWWDI=;
 b=NV6Y8FD5s+JgwPZ0gDkSNeW5OhKVeRlsGVnR/gAsKGcWuuQvUDulDoSEKbFBw2NU1Z
 DKMYtXI6mj0deSlO/5OrEOzNA8z57z4coTEZk0U37YLkv5YFbdJv2ohuFbS+k7XU+GC2
 H7qqQXMahp/maeRJL/KK3s0DPnRlmm4h0thBP5eIn5+1p9RofgRudS6k6esQqaUvucIo
 Oduty59+E+wgsjAUcggfyduB30YAUyDRP+Z6trcrqd3+9lewfpZIloqRaQ1X/DXq24Ql
 HdBh+goTi8SzkPndE9Eqkxf6TQiQGcC4fpXqHA97ItFenC//ye3EtEUa7RhPI31knRrQ
 Nzuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=35wWFZYsgjxKhlzRkt/hqrCBvNSntuG0Se1BDCFWWDI=;
 b=RZPajGuVe6w2TPwSoVvf3NxG4s58VnCIQO8FBG6gCYcWiSd2OEftQTTWP1ti+R1WGs
 0JgHvaKFaymR6I1QCMQvz5FwmlyXxMjjOyZUosTPXqFTqzI52z7RAbZ6uPW4U3j+htjL
 YSAtcRW0TupERCe3ZXeaNk0Y0EnOMLM/QAaNkrl7Wn+cVP5Q0Se48IMTwo7OfjWr5Q1R
 Hu7i+xajS4v/GI87467rCiqlosHd2xWd2S36kUZiXQKuOQsMdunhehNdnpabkHOdQsBl
 YOpVKnzV0jFN7s72qoPB9D97D/XFMjD5gl0PL852CkW9ujVtkyp+Cs/btUevzYYUfjPM
 aOug==
X-Gm-Message-State: AOAM532JbHqMP8J1jbDvoR9Js78AHiqVLKNTLafFoJP68CRmFpJ59DvN
 ciAg+LRjkOHal3ppzsbAYUrdHcOI
X-Google-Smtp-Source: ABdhPJxzYzfLTPgcmoRFh9+suLZWsXWDkUDxx7oJXGYU+QfUAPSdugD2brX70zy93hCCQ5+WvIZIDg==
X-Received: by 2002:aed:35d8:: with SMTP id d24mr4306358qte.246.1594892536379; 
 Thu, 16 Jul 2020 02:42:16 -0700 (PDT)
Received: from ?IPv6:2804:431:c7c6:9447:1f8b:580e:61d9:b1a4?
 ([2804:431:c7c6:9447:1f8b:580e:61d9:b1a4])
 by smtp.gmail.com with ESMTPSA id z4sm6371396qkb.66.2020.07.16.02.42.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2020 02:42:15 -0700 (PDT)
Subject: Re: [PATCH v3] spapr: Add a new level of NUMA for GPUs
To: David Gibson <david@gibson.dropbear.id.au>,
 Reza Arbab <arbab@linux.ibm.com>
References: <1590177213-4513-1-git-send-email-arbab@linux.ibm.com>
 <20200525050550.GA23110@umbus.fritz.box>
 <20200525174927.aky64nw7p7xztqzh@arbab-vm>
 <20200716050459.GM93134@umbus.fritz.box>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <cdbdf33f-f63b-ea5b-befc-0b94904b42ca@gmail.com>
Date: Thu, 16 Jul 2020 06:42:11 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200716050459.GM93134@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::844;
 envelope-from=danielhb413@gmail.com; helo=mail-qt1-x844.google.com
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
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 7/16/20 2:04 AM, David Gibson wrote:
> On Mon, May 25, 2020 at 12:49:27PM -0500, Reza Arbab wrote:
>> On Mon, May 25, 2020 at 03:05:50PM +1000, David Gibson wrote:
>>> On Fri, May 22, 2020 at 02:53:33PM -0500, Reza Arbab wrote:
>>>> --- a/hw/ppc/spapr_pci_nvlink2.c
>>>> +++ b/hw/ppc/spapr_pci_nvlink2.c
>>>> @@ -362,7 +362,7 @@ void spapr_phb_nvgpu_ram_populate_dt(SpaprPhbState *sphb, void *fdt)
>>>>           uint32_t associativity[] = {
>>>>               cpu_to_be32(0x4),
>>>>               SPAPR_GPU_NUMA_ID,
>>>> -            SPAPR_GPU_NUMA_ID,
>>>> +            cpu_to_be32(nvslot->numa_id),
>>>>               SPAPR_GPU_NUMA_ID,
>>>>               cpu_to_be32(nvslot->numa_id)
>>>
>>>
>>> This doesn't look quite right.  In the new case we'll get {
>>> GPU_NUMA_ID, nvslot->numa_id, GPU_NUMA_ID, nvslot->numa_id }.
>>
>> The associativity reference points are 4 (and now 2), so this is what we
>> want. I think what you've noticed is that reference points are 1-based
>> ordinals:
>>
>> 	"...the “ibm,associativity-reference-points” property indicates
>> boundaries between associativity domains presented by the
>> “ibm,associativity” property containing “near” and “far” resources. The
>> first such boundary in the list represents the 1 based ordinal in the
>> associativity lists of the most significant boundary, with subsequent
>> entries indicating progressively less significant boundaries."
> 
> Right.. AIUI, associativity-reference-points indicates which leves are
> "important" from a NUMA distance point of view (though the spec is
> very confusing).  But, I'm pretty sure, that ignoring
> reference-points, the individual ibm,associativity lists are supposed
> to describe a correct hierarchy, even if some levels will get ignored
> for distance purposes.  So once you've split up into "numa_id" nodes
> at the second level, you can't then go back to just 2 nodes (main
> vs. gpu) at the third.


I believe Reza should go with what Skiboot already does in this situation:

(hw/npu2.c)

dt_add_property_cells(mem, "ibm,associativity", 4, chip_id, chip_id, chip_id, chip_id);

Which would translate here to:

         uint32_t associativity[] = {
             cpu_to_be32(0x4),
             cpu_to_be32(nvslot->numa_id),
             cpu_to_be32(nvslot->numa_id),
             cpu_to_be32(nvslot->numa_id),
             cpu_to_be32(nvslot->numa_id),
         };


In the end it doesn't matter for the logic since the refpoints are always
0x4 0x4 0x2, meaning that we're ignoring the 1st and 3rd elements entirely
anyways, but at least make the intention clearer: GPUs are always at the
maximum distance from everything else.



Thanks,


DHB



> 
> 

