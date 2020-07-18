Return-Path: <SRS0=NumX=A5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C68C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2020 10:39:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 439DE2073A
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2020 10:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uxqzfu3W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 439DE2073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwkG1-0001Px-Gw
	for qemu-devel@archiver.kernel.org; Sat, 18 Jul 2020 06:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jwkFR-0000yK-KC
 for qemu-devel@nongnu.org; Sat, 18 Jul 2020 06:39:17 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:36544)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jwkFP-0001e8-Qa
 for qemu-devel@nongnu.org; Sat, 18 Jul 2020 06:39:17 -0400
Received: by mail-wm1-x32e.google.com with SMTP id 17so20795114wmo.1
 for <qemu-devel@nongnu.org>; Sat, 18 Jul 2020 03:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:cc:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=9awyZiitf6Y509wA1W7XcvOKOPt0pGw1pms+VI3I4Io=;
 b=Uxqzfu3WZE55gVv1Bm4wiEYOLlq9QKEBICz1oKh0NZHE4y9Juf80AuXrd8PLnISIsH
 d2do8s5q3/hAEMrPepdsxiz3lFth8gJxwiu4U0SrjnhfKUI9p4nlJOtzbY59a3/lR8PI
 AanCVUYGY5GveDZXf/dXXD98JzXkToddOG9OeW8h448H8+Tfs1YmyEpk29M+Jq0/ZzrC
 s3aScGQ8QldvXk5lCy6ik+9K145HXfdxLQHM40GyIBKlrntG7vE+RVeNuGMFHQIedvPP
 Ct4+ioT/+90jD6MfShVYt5X9BnUfjW9ErW5FEXDMLAk0FbIswxCCQkDCbC0ONScC3ikY
 +n5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:cc:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9awyZiitf6Y509wA1W7XcvOKOPt0pGw1pms+VI3I4Io=;
 b=OfnAILMCbGIGmPhZ1mswF3elXq0jjXU7yVbxka8diewR9RJXUun8F5M2N2vm2qUltE
 69IlgFRlr9cUlykTbgpnQ+mgKHqRSsTbDiFYoPqQLuSTUOW22LgFO4UjBkQptr9+QWCI
 k7+jlzkbMWoZwGgl4KMd+6ptZ2QeIS0F0WuimA+bTdX99yEmRh4RY+AyOcG4UuO4Q+rO
 tF3uEe+O9smtwnSJPwUkWzeljZ/XtojfnbXVQm9qUuXDZJID2z8bPVXzAoVl1ytsXtme
 Rp4X0zql6eMXLaouvJiInTM2U9OPt1nluXyT+RIZTWuPrObLJRyQBIwuFNvvwX2dQEIx
 zGcw==
X-Gm-Message-State: AOAM533cP8ZpdVT0YjjIa0g4UySjGdct30/Lxe5bnuoYBKQdnL+0VtdE
 jwzeq7B8eWp9ouqgRTVqX60=
X-Google-Smtp-Source: ABdhPJysswb5dgfLjVJerg9O/ZEvu1jRzow8kdq5S5ccEPkT2Jr3v4utiSBHK2IBHwCUNSypLSO6AA==
X-Received: by 2002:a7b:c44d:: with SMTP id l13mr13797596wmi.66.1595068753543; 
 Sat, 18 Jul 2020 03:39:13 -0700 (PDT)
Received: from [192.168.1.43] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id z63sm20986671wmb.2.2020.07.18.03.39.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Jul 2020 03:39:12 -0700 (PDT)
Subject: Re: [Bug 1878057] Re: null-ptr dereference in megasas_command_complete
To: qemu-devel@nongnu.org, Hannes Reinecke <hare@suse.com>
References: <158921834595.12757.16112597546001644574.malonedeb@wampee.canonical.com>
 <159506787209.11805.3527732807105189455.malone@soybean.canonical.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f79d5601-afec-086c-20e1-e5d5c1d8f420@amsat.org>
Date: Sat, 18 Jul 2020 12:39:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <159506787209.11805.3527732807105189455.malone@soybean.canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32e.google.com
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
Cc: Bug 1878057 <1878057@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Hannes who doesn't have a Launchpad account.

On 7/18/20 12:24 PM, Philippe Mathieu-Daudé wrote:
> Might be relevant:
> 
> commit 6df5718bd3ec56225c44cf96440c723c1b611b87
> Author: Hannes Reinecke <hare@suse.de>
> Date:   Wed Oct 29 13:00:15 2014 +0100
> 
>     megasas: Rework frame queueing algorithm
>     
>     Windows requires the frames to be unmapped, otherwise we run
>     into a race condition where the updated frame data is not
>     visible to the guest.
>     With that we can simplify the queue algorithm and use a bitmap
>     for tracking free frames.
> 
>  /*
>   * This absolutely needs to be locked if
>   * qemu ever goes multithreaded.
>   */
>  static MegasasCmd *megasas_enqueue_frame(MegasasState *s,
>      hwaddr frame, uint64_t context, int count)
> 
> Using -trace scsi\* -trace megasas\*:
> 
> megasas_qf_enqueue frame 0x0 count 0 context 0x0 head 0x0 tail 0x0 busy 1
> megasas_handle_scsi LD SCSI dev 1/0/0 sdev 0x5555573f5560 xfer 0
> scsi_req_parsed target 0 lun 0 tag 0 command 53 dir 0 length 0
> scsi_req_parsed_lba target 0 lun 0 tag 0 command 53 lba 0
> scsi_req_alloc target 0 lun 0 tag 0
> scsi_disk_new_request Command: lun=0 tag=0x0 data= 0x35 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
> megasas_scsi_nodata scmd 0: no data to be transferred
> megasas_mmio_invalid_writel addr 0x44: 0x3101
> megasas_mmio_invalid_writel addr 0x48: 0x44b0100
> megasas_mmio_invalid_writel addr 0x4c: 0x380100
> megasas_mmio_invalid_writel addr 0x50: 0x4b010000
> megasas_mmio_invalid_writel addr 0x54: 0x3f010004
> megasas_mmio_invalid_writel addr 0x58: 0x1000000
> megasas_mmio_invalid_writel addr 0x5c: 0x100044b
> megasas_mmio_invalid_writel addr 0x60: 0x46
> megasas_mmio_invalid_writel addr 0x64: 0x44b01
> megasas_mmio_invalid_writel addr 0x68: 0x4d01
> megasas_mmio_invalid_writel addr 0x6c: 0x44b0100
> megasas_mmio_invalid_writel addr 0x70: 0x540100
> megasas_mmio_invalid_writel addr 0x74: 0x4b010000
> megasas_mmio_invalid_writel addr 0x78: 0x5b010004
> megasas_mmio_invalid_writel addr 0x7c: 0x1000000
> megasas_mmio_invalid_writel addr 0x80: 0x100044b
> megasas_mmio_invalid_writel addr 0x84: 0x62
> megasas_mmio_invalid_writel addr 0x88: 0x44b01
> megasas_mmio_invalid_writel addr 0x8c: 0x6901
> megasas_mmio_invalid_writel addr 0x90: 0x44b0100
> megasas_mmio_invalid_writel addr 0x94: 0x700100
> megasas_mmio_invalid_writel addr 0x98: 0x4b010000
> megasas_mmio_invalid_writel addr 0x9c: 0x77010004
> megasas_mmio_writel reg MFI_ODCR0: 0x1000000
> megasas_mmio_invalid_writel addr 0xa4: 0x100044b
> megasas_mmio_invalid_writel addr 0xa8: 0x7e
> megasas_mmio_invalid_writel addr 0xac: 0x44b01
> megasas_mmio_invalid_writel addr 0xb0: 0x8501
> megasas_mmio_invalid_writel addr 0xb4: 0x44b0100
> megasas_mmio_invalid_writel addr 0xb8: 0x8c0100
> megasas_mmio_invalid_writel addr 0xbc: 0x4b010000
> megasas_mmio_writel reg MFI_IQPL: 0x4
> megasas_qf_new frame 0x1 addr 0x0
> megasas_enqueue_frame fr: 0x7fffa1e00000
> megasas_qf_enqueue frame 0x1 count 2 context 0x0 head 0x0 tail 0x0 busy 2
> megasas_init_firmware pa 0x0 
> megasas_init_queue queue at 0x0 len 0 head 0x0 tail 0x0 flags 0x0
> megasas_unmap_frame fr: 0x7fffa1e44b00
> megasas_unmap_frame fr: 0x7fffa1e00000
> megasas_qf_complete_noirq context 0x0 
> scsi_req_dequeue target 0 lun 0 tag 0
> scsi_aio_complete
> megasas_command_complete scmd 0: status 0x0, residual 0
> megasas_scsi_complete scmd 0: status 0x0, len 0/0
> 
> The frame is unmapped when the complete callback occurs.
> Then SIGSEGV in megasas_command_complete():
> 
> 1856 static void megasas_command_complete(SCSIRequest *req, uint32_t status,
> 1857                                      size_t resid)
> 1858 {
> 1859     MegasasCmd *cmd = req->hba_private;
> 1860     uint8_t cmd_status = MFI_STAT_OK;
> 1861 
> 1862     trace_megasas_command_complete(cmd->index, status, resid);
> 1863 
> 1864     if (req->io_canceled) {
> 1865         return;
> 1866     }
> 1867 
> 1868     if (cmd->dcmd_opcode != -1) {
> 1869         /*
> 1870          * Internal command complete
> 1871          */
> 1872         cmd_status = megasas_finish_internal_dcmd(cmd, req, resid);
> 1873         if (cmd_status == MFI_STAT_INVALID_STATUS) {
> 1874             return;
> 1875         }
> 1876     } else {
> 1877         req->status = status;
> 1878         trace_megasas_scsi_complete(cmd->index, req->status,
> 1879                                     cmd->iov_size, req->cmd.xfer);
> 1880         if (req->status != GOOD) {
> 1881             cmd_status = MFI_STAT_SCSI_DONE_WITH_ERROR;
> 1882         }
> 1883         if (req->status == CHECK_CONDITION) {
> 1884             megasas_copy_sense(cmd);
> 1885         }
> 1886 
> 1887         cmd->frame->header.scsi_status = req->status;
> 
>              ^^^^^^^^^^ This is NULL.
> 
> 1888     }
> 1889     cmd->frame->header.cmd_status = cmd_status;
> 1890     megasas_complete_command(cmd);
> 1891 }
> 
> ** Changed in: qemu
>        Status: New => Confirmed
> 


