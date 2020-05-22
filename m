Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80DDC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 02:54:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4A72207D8
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 02:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pUdgcFrN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4A72207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbxpT-00082c-UF
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 22:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jbxot-0007MF-6T
 for qemu-devel@nongnu.org; Thu, 21 May 2020 22:53:59 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:44142)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jbxos-0001Le-9e
 for qemu-devel@nongnu.org; Thu, 21 May 2020 22:53:58 -0400
Received: by mail-ej1-x644.google.com with SMTP id x20so11256378ejb.11
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 19:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=UYu+4PVuOTHXrYR3jnMc9A4ofzVjGkZt1MIzfzRxN44=;
 b=pUdgcFrNAy0mxCt+FzVRUW7IsG0kLD46qzxS0P14l11JRYoikvzmM9hJARVDTsZU6b
 t8n2vsGxK0K3VH0VJB8VNYEsy7EdQGTmxw6zODpgAOMq4jnx3Gffr9PDxpjVYrUL4Sce
 HzrvY44xKn2e1PkxfTDqYT+yOOLw7QqRqsm9j3g49jop83HnVPq76HgedqSoGDLaCzAS
 l8WSKTOsTdtkD0Kg6bsbS0LoyQ6c0Dzg3rNCu3qzn8R9gFOl8uAGzSKqOdrTUfTwGkzW
 6BPyL9XNAP/T4QmtohA3K5PE2prfVd3lzV7NhbXplWv8xB6xPKjoyKZ70LUCXLB1JK+r
 De5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=UYu+4PVuOTHXrYR3jnMc9A4ofzVjGkZt1MIzfzRxN44=;
 b=eWy8VO84Fqn63vKdjEutBCa5Bwq6bxUnj1qj8sHqPxn4+9leXUrKyEkKgNHs9Vl/pn
 Z7shE/scI8cOo6jzLeSBLDtKXC5/jfPQoQPXazsYFFej9semte+vr/ja5tpS04rYtraT
 gwldEwei5OVtcxjLRuvI/VEy7DBbwj82JRPEg+T18HnzpL38ZqmK1uZAGc1nCjZUqb5+
 z29SXGCoK6J7OORe9AkZXhBEg7GcLuwJPyl2M/tbMh7rXYq6vP7SJ5+HUuSfbfYp7e7F
 ll2ws9fglFxAtGJMb66/xX60FDyZcFSdah0rOBiSieLo2/WZpBiE0+548gMDxmHIMu1R
 EgrA==
X-Gm-Message-State: AOAM531UfLBRAt8OGTEqgwd+oTTW8jR7R1SaNpvsItg8rliVwVPy/LrM
 OFYxk59bpedY2CPnBhsRhXY=
X-Google-Smtp-Source: ABdhPJyc85+R2xKr3FV3RyBjFQgMLUvPjIQDa+gfhmqp+hi9l+zn4wEVyuR93aKUKOWp3hLchafHPw==
X-Received: by 2002:a17:906:1b4a:: with SMTP id
 p10mr5816186ejg.299.1590116035660; 
 Thu, 21 May 2020 19:53:55 -0700 (PDT)
Received: from jondnuc (IGLD-84-229-154-20.inter.net.il. [84.229.154.20])
 by smtp.gmail.com with ESMTPSA id r21sm6398792ejs.48.2020.05.21.19.53.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 19:53:55 -0700 (PDT)
Date: Fri, 22 May 2020 05:53:53 +0300
From: Jon Doron <arilou@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 0/6] hyperv: VMBus implementation
Message-ID: <20200522025353.GC2900329@jondnuc>
References: <20200424123444.3481728-1-arilou@gmail.com>
 <fd3d2c9f-f163-f430-caf3-6468b6ac7548@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <fd3d2c9f-f163-f430-caf3-6468b6ac7548@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=arilou@gmail.com; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: mail@maciej.szmigiero.name, eyakovlev@virtuozzo.com, ehabkost@redhat.com,
 rvkagan@gmail.com, qemu-devel@nongnu.org, liran.alon@oracle.com,
 vkuznets@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/05/2020, Paolo Bonzini wrote:
>On 24/04/20 14:34, Jon Doron wrote:
>> This is a rebase of the old patchset from Roman for HyperV VMBus
>> implementation.
>>
>> How to use:
>> -device vmbus-bridge
>>
>> Later on new paravirtualized devices can be implemented on top of it
>> (Network/SCSI/etc.)
>>
>> VMBus is a collection of technologies.  At its lowest layer, it's a message
>> passing and signaling mechanism, allowing efficient passing of messages to and
>> from guest VMs.  A layer higher, it's a mechanism for defining channels of
>> communication, where each channel is tagged with a type (which implies a
>> protocol) and a instance ID.  A layer higher than that, it's a bus driver,
>> serving as the basis of device enumeration within a VM, where a channel can
>> optionally be exposed as a paravirtual device.  When a server-side (paravirtual
>> back-end) component wishes to offer a channel to a guest VM, it does so by
>> specifying a channel type, a mode, and an instance ID.  VMBus then exposes this
>> in the guest.
>>
>> More information about VMBus can be found in the file
>> vmbuskernelmodeclientlibapi.h in Microsoft's WDK.
>>
>> v4:
>> Decided to ditch the patch that envolves handling of EOM as there is
>> still a discussion going on with it in the KVM mailing list.
>>
>> v3:
>> Fixed an error asan
>>
>> v2:
>> Rebased on top of latest patchset from Roman and Maciej
>>
>> Jon Doron (6):
>>   hyperv: expose API to determine if synic is enabled
>>   vmbus: add vmbus protocol definitions
>>   vmbus: vmbus implementation
>>   i386:pc: whitelist dynamic vmbus-bridge
>>   i386: Hyper-V VMBus ACPI DSDT entry
>>   vmbus: add infrastructure to save/load vmbus requests
>>
>>  Makefile.objs                    |    1 +
>>  hw/hyperv/Kconfig                |    5 +
>>  hw/hyperv/Makefile.objs          |    1 +
>>  hw/hyperv/hyperv.c               |    8 +
>>  hw/hyperv/trace-events           |   18 +
>>  hw/hyperv/vmbus.c                | 2778 ++++++++++++++++++++++++++++++
>>  hw/i386/acpi-build.c             |   43 +
>>  hw/i386/pc_piix.c                |    2 +
>>  hw/i386/pc_q35.c                 |    2 +
>>  include/hw/hyperv/hyperv.h       |    1 +
>>  include/hw/hyperv/vmbus-bridge.h |   35 +
>>  include/hw/hyperv/vmbus-proto.h  |  222 +++
>>  include/hw/hyperv/vmbus.h        |  230 +++
>>  13 files changed, 3346 insertions(+)
>>  create mode 100644 hw/hyperv/trace-events
>>  create mode 100644 hw/hyperv/vmbus.c
>>  create mode 100644 include/hw/hyperv/vmbus-bridge.h
>>  create mode 100644 include/hw/hyperv/vmbus-proto.h
>>  create mode 100644 include/hw/hyperv/vmbus.h
>>
>
>Queued, thanks.  I'll take a look at the EOM handling threads next.
>
>Paolo
>

Hi Paolo, there is no need to look at the EOM, we have scraped it as you 
can see in v4 :) 

