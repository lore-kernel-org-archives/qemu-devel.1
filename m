Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F77C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 21:51:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22E3220736
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 21:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZG8Blawt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22E3220736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYGKr-0003lx-JK
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 17:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jYGK9-0003M4-OM
 for qemu-devel@nongnu.org; Mon, 11 May 2020 17:50:57 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37042)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jYGK8-0007tx-QW
 for qemu-devel@nongnu.org; Mon, 11 May 2020 17:50:57 -0400
Received: by mail-wm1-x341.google.com with SMTP id z72so11473655wmc.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 14:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:cc:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=WmbSqiYDTwKvFHiJUrw4BN39jPt3zmF96/DDP0v/SUo=;
 b=ZG8BlawtEU26fl3G0ylKuPDlGBz8SKrlRTUXzB0yGc91IMmdqH6jBMm0BF7YTnpJ61
 rcLzpOiUyR23FWOwv5/qGSvmZMRwzVZjVKY2ihflANQCWX10zEeF9h3sLzLDsaF/JOGU
 oz6j+SFSnoNGiyI5ug8mjJydenbSty3/6TY2atE/+rsuKqOUAFTTUdrwzHKYoi+jSQs0
 MYJxTxis0dwnj5u2aqIt2XAtQEttsX2lohi2tAhIpIaDQ/q2rsAPmcua8I2lsRisS7C5
 HWk2Do2/tbimiEhTgRS2sSmsQxX9SiestDaiD2KkrJ4mLsZnvBWlM+WLiXzh10R0n4T/
 xLaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:cc:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WmbSqiYDTwKvFHiJUrw4BN39jPt3zmF96/DDP0v/SUo=;
 b=CN/hCtphp0fBqufr41FqjVqoyavXTLvrUyYPRg7koq5BtctPiRs1UovqYzxFKUHm7z
 /3czaTYNJTvbtW78a9EK43tVclqbxDgiZosWjNlPJlZxuWXZRJCi1yIv041s0F5VeYIU
 e3sXZ95wpJl0eOkuDSKLVp+AbnGR9Gv/CE4gNIZDtmPs+4VUGoW2S1IekhSLxtb1BVtW
 PurbtFMwA5c2ra0utjFcT9x0KXqG9SEuCAAJ0KxOdkpQnDnC2EMhiMQrgfLIEIRbNqB3
 XMtx3GG9i1YfP2Pyk7bYuMumkEqrn7/wYj7wiIbcPyLseO5mzqmX3fqLjMa16b03AwVg
 o6tw==
X-Gm-Message-State: AGi0Pua/rMhQFqBQy98MDPEsO37J91lf913Xv40fqtPRVy3q3Qin5I+s
 OBxvCBqY2vQThggc62lBkb0=
X-Google-Smtp-Source: APiQypLrtwFmJf7P5Be70MbuvX2a40Cye50VrhKTvOvIyimwY6v9XEUWX67u5dSObW2kNjAs/8JW4A==
X-Received: by 2002:a05:600c:2046:: with SMTP id
 p6mr33893797wmg.177.1589233854844; 
 Mon, 11 May 2020 14:50:54 -0700 (PDT)
Received: from [192.168.1.37] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id z11sm19175263wro.48.2020.05.11.14.50.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2020 14:50:53 -0700 (PDT)
Subject: Re: [Bug 1878054] [NEW] Hang with high CPU usage in
 sdhci_data_transfer
To: Bug 1878054 <1878054@bugs.launchpad.net>, qemu-devel@nongnu.org
References: <158921780313.11557.11335648957795976711.malonedeb@wampee.canonical.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1e971c7d-ef5b-ecf2-c64d-0dd0d740b127@amsat.org>
Date: Mon, 11 May 2020 23:50:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <158921780313.11557.11335648957795976711.malonedeb@wampee.canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+Peter who was the previous maintainer.

On 5/11/20 7:23 PM, Alexander Bulekov wrote:
> Public bug reported:
> 
> Hello,
> While fuzzing, I found an input that causes QEMU to hang with 100% CPU usage.
> I have waited several minutes, and QEMU is still unresponsive. Using gdb, It
> appears that it is stuck in an sdhci_data_transfer:

Quick analysis of the attached file show the SDHCI starts multi-block 
DMA transfer (for 0xffea blocks), while the SD card is not initialized.

The card keeps returning zero data (because not in the SENDING state).

The problem seems related to this comment in 
sdhci_sdma_transfer_multi_blocks():

     /* XXX: Some sd/mmc drivers (for example, u-boot-slp) do not 
account for
      * possible stop at page boundary if initial address is not page 
aligned,
      * allow them to work properly */
     if ((s->sdmasysad % boundary_chk) == 0) {
         page_aligned = true;
     }

Setting page_aligned to false avoid the infinite loop.

You found a case where s->blkcnt is never decremented (thus the infinite 
loop & unresponsiveness). See:

             if (((boundary_count + begin) < block_size) && page_aligned) {
                 s->data_count = boundary_count + begin;
                 boundary_count = 0;
              } else {
                 s->data_count = block_size;
                 boundary_count -= block_size - begin;
                 if (s->trnmod & SDHC_TRNS_BLK_CNT_EN) {
                     s->blkcnt--;
                 }
             }

> 
> #0   memory_region_access_valid (mr=<optimized out>, addr=0x10284920, size=<optimized out>, is_write=0xff, attrs=...) at /home/alxndr/Development/qemu/memory.c:1378
> #1   memory_region_dispatch_write (mr=<optimized out>, addr=<optimized out>, data=<optimized out>, op=MO_32, attrs=...) at /home/alxndr/Development/qemu/memory.c:1463
> #2   flatview_write_continue (fv=<optimized out>, addr=0x10284920, attrs=..., ptr=<optimized out>, len=0xb7, addr1=0x5555582798e0, l=<optimized out>, mr=0x5555582798e0 <io_mem_unassigned>) at /home/alxndr/Development/qemu/exec.c:3137
> #3   flatview_write (fv=0x606000045da0, addr=<optimized out>, attrs=..., buf=<optimized out>, len=<optimized out>) at /home/alxndr/Development/qemu/exec.c:3177
> #4   address_space_write (as=<optimized out>, addr=<optimized out>, attrs=..., buf=0xaaaab04f325, len=0x4) at /home/alxndr/Development/qemu/exec.c:3268
> #5   address_space_rw (as=0x5555572509ac <unassigned_mem_ops+44>, addr=0x5555582798e0, attrs=..., attrs@entry=..., buf=0xaaaab04f325, len=0x4, is_write=0xb8, is_write@entry=0x1) at
> /home/alxndr/Development/qemu/exec.c:3278
> #6   dma_memory_rw_relaxed (as=0x5555572509ac <unassigned_mem_ops+44>, addr=0x5555582798e0, buf=0xaaaab04f325, len=0x4, dir=DMA_DIRECTION_FROM_DEVICE) at /home/alxndr/Development/qemu/include/sysemu/dma.h:87
> #7   dma_memory_rw (as=0x5555572509ac <unassigned_mem_ops+44>, addr=0x5555582798e0, buf=0xaaaab04f325, len=0x4, dir=DMA_DIRECTION_FROM_DEVICE) at /home/alxndr/Development/qemu/include/sysemu/dma.h:110
> #8   dma_memory_write (as=0x5555572509ac <unassigned_mem_ops+44>, addr=0x5555582798e0, buf=0xaaaab04f325, len=0x4) at /home/alxndr/Development/qemu/include/sysemu/dma.h:122
> #9   sdhci_sdma_transfer_multi_blocks (s=<optimized out>) at /home/alxndr/Development/qemu/hw/sd/sdhci.c:618
> #10  sdhci_data_transfer (opaque=0x61e000021080) at /home/alxndr/Development/qemu/hw/sd/sdhci.c:891
> #11  sdhci_send_command (s=0x61e000021080) at /home/alxndr/Development/qemu/hw/sd/sdhci.c:364
> #12  sdhci_write (opaque=<optimized out>, offset=0xc, val=<optimized out>, size=<optimized out>) at /home/alxndr/Development/qemu/hw/sd/sdhci.c:1158
> #13  memory_region_write_accessor (mr=<optimized out>, addr=<optimized out>, value=<optimized out>, size=<optimized out>, shift=<optimized out>, mask=<optimized out>, attrs=...) at
> /home/alxndr/Development/qemu/memory.c:483
> #14  access_with_adjusted_size (addr=<optimized out>, value=<optimized out>, size=<optimized out>, access_size_min=<optimized out>, access_size_max=<optimized out>, access_fn=<optimized out>, mr=0x61e0000219f0, attrs=...) at /home/alxndr/Development/qemu/memory.c:544
> #15  memory_region_dispatch_write (mr=<optimized out>, addr=<optimized out>, data=0x1ffe0ff, op=<optimized out>, attrs=...) at /home/alxndr/Development/qemu/memory.c:1476
> #16  flatview_write_continue (fv=<optimized out>, addr=0xe106800c, attrs=..., ptr=<optimized out>, len=0xff3, addr1=0x5555582798e0, l=<optimized out>, mr=0x61e0000219f0) at /home/alxndr/Development/qemu/exec.c:3137
> #17  flatview_write (fv=0x606000045da0, addr=<optimized out>, attrs=..., buf=<optimized out>, len=<optimized out>) at /home/alxndr/Development/qemu/exec.c:3177
> #18  address_space_write (as=<optimized out>, addr=<optimized out>, attrs=..., attrs@entry=..., buf=0xaaaab04f325, buf@entry=0x62100008ad00, len=0x4) at /home/alxndr/Development/qemu/exec.c:3268
> #19  qtest_process_command (chr=<optimized out>, chr@entry=0x55555827c040 <qtest_chr>, words=<optimized out>) at /home/alxndr/Development/qemu/qtest.c:567
> #20  qtest_process_inbuf (chr=0x55555827c040 <qtest_chr>, inbuf=0x61900000f640) at /home/alxndr/Development/qemu/qtest.c:710
> 
> 
> I am attaching the qtest commands for reproducing it.
> I can reproduce it in a qemu 5.0 build using:
> 
> qemu-system-i386 -M pc-q35-5.0 -qtest stdio -device sdhci-pci,sd-spec-
> version=3 -device sd-card,drive=mydrive -drive if=sd,index=0,file=null-
> co://,format=raw,id=mydrive -nographic -nographic -serial none -monitor
> none < attachment
> 
> Please let me know if I can provide any further info.
> -Alex
> 
> ** Affects: qemu
>       Importance: Undecided
>           Status: New
> 

