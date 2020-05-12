Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3509FC2D0F7
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 20:55:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 042E42312A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 20:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVCj61M5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 042E42312A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYbwM-0000FS-1g
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 16:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jYbvb-00085h-PB
 for qemu-devel@nongnu.org; Tue, 12 May 2020 16:55:03 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35113)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jYbva-0006Kp-Sx
 for qemu-devel@nongnu.org; Tue, 12 May 2020 16:55:03 -0400
Received: by mail-wm1-x344.google.com with SMTP id n5so10545900wmd.0
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 13:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=hXm5wQtc9/KGmnodh8sooHEgjDsADYij2hSf0uZyS64=;
 b=VVCj61M5vR1ibHrDtdWNRbb+cwKxJor9tdL/r9i9Tyv+PDNKjW9EqYVIHaswDONG81
 /0jPxosUVTnADWeS3oqNwClWvMOqxlabd1LFFYKQ9ppc3JUluN9tmMOpiI2rZ+5QB2PW
 eT9PYvlxZr+zpP/4MKGoMnPhmqaLO7094hQVL41ERBunLq9GBFoBn6hkkukh5ccddIdk
 crcRp9df8Nc1wGJUz2NVJGqyecoWQXkHD9R1uMjX3r6aCxZgu9fYto6i0rKrKqiFkP0A
 /1sTxw/tpQuz4vhL/6lgJhyFTVwye441C78IHBcZwFGrhdKy9nqOnBxS+Fm/9BiEzHA3
 I9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hXm5wQtc9/KGmnodh8sooHEgjDsADYij2hSf0uZyS64=;
 b=IN+ehzIQ/xjfseBZ+hoGMaXWLV3fN4HftJOWp/9idyMUrQGtMTaN9Vz2qrHTxh2S5v
 4cSDY0eRC7umLQ+A6bo/ZGkPlbBxMbliLMI0WbVHZCvzXlCfuSbcoxKcwKvi/qvwpp32
 ENLederhfHK2F8BiFaPvFK6D0ZvcPat/jTHzkxBj/jYqt/MkB4LEycvg0tud3hYzmY5j
 NUBTsJBbWFMDdSCX8+OE9cxRv+oK5YN0vrwweEaF8j+rX+Bx9ngCN0kcXD/0THIE8Be1
 k38IfQXF4+F4b80nUL4F4dbKC1pHp6vUWUr1o8PrtPUJ6Ifwz6iWri6Ce6q6lk/PUYHR
 zF5Q==
X-Gm-Message-State: AGi0PuaUQL+1bl/Rpqj9NWtu5cogzLguVX/YufRseI9mH+evSSw56rU2
 lttKTyczvWXGyH3zopuQo+k=
X-Google-Smtp-Source: APiQypJXv6sTCAF6QiL8AL7EJn5tRuBZjwRhKP0ZVK2FC6/soUVxmAMzRuSjFvVzGw581X0QCCeNew==
X-Received: by 2002:a1c:1b4d:: with SMTP id b74mr10949040wmb.123.1589316901140; 
 Tue, 12 May 2020 13:55:01 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id t4sm26338015wri.54.2020.05.12.13.54.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2020 13:55:00 -0700 (PDT)
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIIDAvMl0gdXNlIHVuc2lnbmVkIHR5cGUg?=
 =?UTF-8?Q?for_MegasasState_fields?=
To: "Ding, Ren" <rding@gatech.edu>, P J P <ppandit@redhat.com>
References: <20200507105718.1319187-1-ppandit@redhat.com>
 <26201c24-c483-85a7-2f4b-b3cc56d4b8b7@redhat.com>
 <nycvar.YSQ.7.76.2005122357030.1451610@xnncv>
 <BN6PR07MB341283EBBF78F86AAA995382CABE0@BN6PR07MB3412.namprd07.prod.outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4a9f8ae4-ef42-5a82-6d36-fb30f2878c6a@amsat.org>
Date: Tue, 12 May 2020 22:54:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <BN6PR07MB341283EBBF78F86AAA995382CABE0@BN6PR07MB3412.namprd07.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, "Zhao, Hanqing" <hanqing@gatech.edu>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Ren,

On 5/12/20 8:49 PM, Ding, Ren wrote:
> Hi all,
> 
> To clarify, the bug has been reported 6 months ago with the commit 
> version of 98b2e3c9ab3abfe476a2b02f8f51813edb90e72d, which was the 
> upstream back then. The reproducing driver along with the ASAN log we 
> provided was for that version specifically.

When I first read I thought you'd have miswriten 'months' for 'days' or 
'weeks', but this commit is 6 *months* old indeed.

The cover describes the bug as OOB, so I suppose this is a security 
issue. Now a 6 months embargo surprises me. I was expecting some period 
in a 30-90days range to be the default. However reading the 'Publication 
embargo' chapter on https://www.qemu.org/contribute/security-process/, 
it is only stated "Embargo periods will be negotiated by mutual 
agreement between members of the security team and other relevant 
parties to the problem." Shouldn't be a maximum upper limit on the 
embargo period? Are there QEMU security bugs embargoed for more than a 
year? That would be a shame.

> 
> Thanks,
> 
> Ren
> 
> *发件人: *P J P <mailto:ppandit@redhat.com>
> *发送时间: *2020年5月12日14:37
> *收件人: *Philippe Mathieu-Daudé <mailto:philmd@redhat.com>
> *抄送: *QEMU Developers <mailto:qemu-devel@nongnu.org>; Fam Zheng 
> <mailto:fam@euphon.net>; Paolo Bonzini <mailto:pbonzini@redhat.com>; 
> Ding, Ren <mailto:rding@gatech.edu>; Marc-André Lureau 
> <mailto:marcandre.lureau@redhat.com>
> *主题: *Re: [PATCH 0/2] use unsigned type for MegasasState fields
> 
> +-- On Tue, 12 May 2020, Philippe Mathieu-Daudéwrote --+
> | Cc'ing Marc-Andréour signed/unsigned conversion expert (with Paolo).
> 
>    megasas_init_firmware
>      pa_lo = le32_to_cpu(initq->pi_addr_lo);
>      pa_hi = le32_to_cpu(initq->pi_addr_hi);
>      s->producer_pa = ((uint64_t) pa_hi << 32) | pa_lo;
>      s->reply_queue_head = ldl_le_pci_dma(pcid, s->producer_pa);
> 
> IIUC, here ldl_le_pci_dma() returns an 'uint32_t' type, but since
> 'reply_queue_head' is a signed int, large 'uint32_t' value turns negative.
> 
> | Do you have a reproducer?
> 
>    Yes, there is a reproducer with ASAN, though it did not work for me.
> Ren(CC'd) had shared this trace:
> 
> AddressSanitizer: heap-buffer-overflow on address 0x7f9159054058 at pc 
> 0x55763514b5cd bp 0x7f9179bd6d90 sp 0x7f9179bd6d88
> READ of size 8 at 0x7f9159054058 thread T2
>    #0 0x55763514b5cc in megasas_lookup_frame 
> /home/ren/tmp/redacted-dbg/qemu/hw/scsi/megasas.c:449:30
>    #1 0x55763513205c in megasas_handle_abort 
> /home/ren/tmp/redacted-dbg/qemu/hw/scsi/megasas.c:1904:17
>    #2 0x55763512d0f8 in megasas_handle_frame 
> /home/ren/tmp/redacted-dbg/qemu/hw/scsi/megasas.c:1961:24
>    #3 0x55763512ba7d in megasas_mmio_write 
> /home/ren/tmp/redacted-dbg/qemu/hw/scsi/megasas.c:2122:9
>    #4 0x55763515247c in megasas_port_write 
> /home/ren/tmp/redacted-dbg/qemu/hw/scsi/megasas.c:2173:5
>    #5 0x557634621b3b in memory_region_write_accessor 
> /home/ren/tmp/redacted-dbg/qemu/memory.c:483:5
>    #6 0x557634621741 in access_with_adjusted_size 
> /home/ren/tmp/redacted-dbg/qemu/memory.c:544:18
>    #7 0x557634620498 in memory_region_dispatch_write 
> /home/ren/tmp/redacted-dbg/qemu/memory.c:1482:16
>    #8 0x5576344b6b6c in flatview_write_continue 
> /home/ren/tmp/redacted-dbg/qemu/exec.c:3161:23
>    #9 0x5576344a87d9 in flatview_write 
> /home/ren/tmp/redacted-dbg/qemu/exec.c:3201:14
>    #10 0x5576344a8376 in address_space_write 
> /home/ren/tmp/redacted-dbg/qemu/exec.c:3291:18
>    #11 0x5576344a8af4 in address_space_rw 
> /home/ren/tmp/redacted-dbg/qemu/exec.c:3301:16
>    #12 0x557634689e10 in kvm_handle_io 
> /home/ren/tmp/redacted-dbg/qemu/accel/kvm/kvm-all.c:2086:9
>    #13 0x557634688a45 in kvm_cpu_exec 
> /home/ren/tmp/redacted-dbg/qemu/accel/kvm/kvm-all.c:2332:13
>    #14 0x5576345ee7aa in qemu_kvm_cpu_thread_fn 
> /home/ren/tmp/redacted-dbg/qemu/cpus.c:1299:17
>    #15 0x557635a11509 in qemu_thread_start 
> /home/ren/tmp/redacted-dbg/qemu/util/qemu-thread-posix.c:519:9
>    #16 0x7f918cec26b9 in start_thread 
> (/lib/x86_64-linux-gnu/libpthread.so.0+0x76b9)
>    #17 0x7f918c5d441c in clone 
> /build/glibc-LK5gWL/glibc-2.23/misc/../sysdeps/unix/sysv/linux/x86_64/clone.S:109

This is previous information useful for the commit description, thanks 
for sharing it!

> 
> 
> Thank you.
> --
> Prasad J Pandit / Red Hat Product Security Team
> 8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D
> 

