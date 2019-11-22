Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5565C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 22:42:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FA1920708
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 22:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sjI5g7MR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FA1920708
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYHcq-0001Sn-Gk
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 17:42:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44521)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1iYHcC-0000zq-Kj
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 17:41:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1iYHcB-0000zX-Ie
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 17:41:24 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:46424)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1iYHcB-0000yc-B3
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 17:41:23 -0500
Received: by mail-pl1-x641.google.com with SMTP id l4so3688423plt.13
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 14:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=KlErY0hNW4227X/7K3YZfer053bUFpvJk9lWakDSPhs=;
 b=sjI5g7MRBVeX8zsDOp0ahBkJ5VOT0XjCKaruB0PcvbeOSD5PP4dgQGCyQzaeLP36l1
 +9iHA8WU+cJpSOX2j97lxpnLPy/OQQ/lVwBIRqFJcIgNURVFC5nyv0qLq5Gs8MMgh9sC
 Q80jCTuQGynsssFYAGwGNlOfj+AHs1O3+Mapv0F+WKuhqNu4j8Uz6cOM/b3FoOeNFUF4
 HUeBCWAK3wHbzrgsfGgjzC1gqMEfUL1iN52urZm41OvPGtNG7u1CSK93L75T2z0I0QPa
 wIvVMkKv7VqlXbXa/iNMKVhDfowDQBGdZ01AdGCuP9tFB7p+RUjvSIpBGYVNrQjrOdJ8
 syWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=KlErY0hNW4227X/7K3YZfer053bUFpvJk9lWakDSPhs=;
 b=gFy7txecgS9W50XHJZm/W9qF0VY3+EnSBxqrKYAVHlviarztf62S7CCF2ejDEnXrbO
 xY5rfKrroqmmcP0YkdbUxq/HtBLLlqxZdaTlFRyVkWYF+dqIkjmYkTeXhpbgVmUCu6TA
 K6ov5MQ6WLHpn7T2hw+8mJYmvDAyQmsM+8/TfijpaWQVBstCQg9PlBTltKIb3Dzp3r+O
 Tur+cZ7uyfrKnGoRXLUkxm3sbl795MApcSSfTtqb57uRPyaA8YQsIaBBMrVwvfvYFlfn
 pJbXuvUVmBAquTipzvuHkKZYO33pQrxK07wI/U/kM5lUWzeWiY7Z/LWRjadrlzvdCH2s
 zycA==
X-Gm-Message-State: APjAAAWcUSxJh0TX+yNKIyk6vzNNUY3P9izzoR99ctOZlqHy1VIsufXF
 xqLfWo4pND7JpnP90f1dMQxNMA==
X-Google-Smtp-Source: APXvYqzafzdfmOf7eQOHus/oblgfFOgOk1gNtcyRJ/aCX7KY6++pciodoe6krxij0JSlzyzpkBoGCQ==
X-Received: by 2002:a17:90a:1742:: with SMTP id
 2mr21867558pjm.93.1574462481086; 
 Fri, 22 Nov 2019 14:41:21 -0800 (PST)
Received: from localhost ([2620:15c:211:200:12cb:e51e:cbf0:6e3f])
 by smtp.gmail.com with ESMTPSA id j5sm8148917pfe.100.2019.11.22.14.41.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2019 14:41:20 -0800 (PST)
Date: Fri, 22 Nov 2019 14:41:20 -0800 (PST)
X-Google-Original-Date: Fri, 22 Nov 2019 14:40:46 PST (-0800)
Subject: Re: [PATCH] riscv: virt: Allow PCI address 0
In-Reply-To: <1574436472-6017-1-git-send-email-bmeng.cn@gmail.com>
CC: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, sagark@eecs.berkeley.edu,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
From: Palmer Dabbelt <palmerdabbelt@google.com>
To: bmeng.cn@gmail.com
Message-ID: <mhng-9c6e7c80-7375-4bba-8ba5-7b9a6eb141d7@palmerdabbelt.mtv.corp.google.com>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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

On Fri, 22 Nov 2019 07:27:52 PST (-0800), bmeng.cn@gmail.com wrote:
> When testing e1000 with the virt machine, e1000's I/O space cannot
> be accessed. Debugging shows that the I/O BAR (BAR1) is correctly
> written with address 0 plus I/O enable bit, but QEMU's "info pci"
> shows that:
>
>   Bus  0, device   1, function 0:
>     Ethernet controller: PCI device 8086:100e
>   ...
>       BAR1: I/O at 0xffffffffffffffff [0x003e].
>   ...
>
> It turns out we should set pci_allow_0_address to true to allow 0
> PCI address, otherwise pci_bar_address() treats such address as
> PCI_BAR_UNMAPPED.
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> ---
>
>  hw/riscv/virt.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 23f340d..411bef5 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -603,6 +603,7 @@ static void riscv_virt_machine_class_init(ObjectClass *oc, void *data)
>      mc->init = riscv_virt_board_init;
>      mc->max_cpus = 8;
>      mc->default_cpu_type = VIRT_CPU;
> +    mc->pci_allow_0_address = true;
>  }
>
>  static const TypeInfo riscv_virt_machine_typeinfo = {

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

I've put this on for-next, as I don't think this is 4.2 material.

Thanks!

