Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3AB0C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 20:49:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 596DF20674
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 20:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B3F6pgeO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 596DF20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRiHz-0001Rh-Bv
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 16:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRiEU-0006Zk-I6
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 16:46:19 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:35368)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRiER-0006YB-OJ
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 16:46:18 -0400
Received: by mail-ej1-x641.google.com with SMTP id u21so20465770eja.2
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2020 13:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Zd7z4Zeb1k14kVm7EXjC3JkEyZMOY9MA5z0PafSZ+sc=;
 b=B3F6pgeO0Tn8KgvLLQ3yUAnVQ1ELii/Ue3tGgjguk8AYbFaAT1uG5HLzFF2hsMWdtB
 wSn7br303hLqFQzfp1OgLtnCUGUX/4OHAFgqZ2E4D5lO0JFP9++wh44/wQnHpnZrMNc6
 1N854ZV2ZCrvwlySz5Fx6NcqBa2IhrE5fspiZEhyyoMrJSy/KaFI1lbPJXoqKmeoO2fg
 EVFCbAR3AZ092bpKKyKZOoWCWu1gFtEpGvrfotQQuQyiv0y1JR1kxnq6pybym3hBu9Gj
 /F3vxOeb29N+W/eyrrDyxow1o9luvHmPyoSnrtA/RusMWLhpKfNmmjRlY2GBhd3T1sqk
 hRqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Zd7z4Zeb1k14kVm7EXjC3JkEyZMOY9MA5z0PafSZ+sc=;
 b=SqPHf0vuhru1KCLHH7KpoShlAgnspAOhNqoMBNQOCPEKCfawlMGTIKwBWJcM1znT15
 PUgxD5sfiCn2+rMZMe1qhjrXofeBtHbVLbW1c1HD+6ZKC6EkGA5JMhxhx3BEcfkSYYlf
 kIg5f6STWlC68joA1mAT330956J9VRH+1slfGkt/rBbycZEQ96UyvOEnqox7LOIY3JY0
 kIL1f5vsDJEm8/0CEGuS7AtyIHH2i1soLfSZSGI5e+9Tffl9XF35rqzGCwsMKXBEtUgg
 nCCkA441KmFKPY/klRahIO6vhInbWmbEQHbf0iOciIoBjXR7CKpO5VXVOPnytk9Mbx9p
 X1dg==
X-Gm-Message-State: AOAM533F71WLOcfkCAdOzxvTvYRb6kaGm0+K3VqyUI6pYn8B7prDhfF6
 BVW/J0qlegFFcyvtnNG1WhNjnkw8f79bhPvuqOORfQ==
X-Google-Smtp-Source: ABdhPJxocql7lB8canWSvJt1PqUPILVS6Md83pZvWOTIyQmRjhuDvkuehfWmq8SyYEP3bQCkcax6ga2CdgWJKWGj1Qk=
X-Received: by 2002:a17:906:1f42:: with SMTP id
 d2mr24587356ejk.407.1602449172696; 
 Sun, 11 Oct 2020 13:46:12 -0700 (PDT)
MIME-Version: 1.0
References: <20201011194918.3219195-1-f4bug@amsat.org>
 <20201011194918.3219195-4-f4bug@amsat.org>
In-Reply-To: <20201011194918.3219195-4-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 11 Oct 2020 21:46:01 +0100
Message-ID: <CAFEAcA8hbkrTo0VpLtjFDtXc5CL7zK+X8ppX==P9_+q_V8-pAw@mail.gmail.com>
Subject: Re: [PATCH 3/4] hw/pci-host/versatile: Add WINDOW_COUNT definition to
 replace magic '3'
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 qemu-arm <qemu-arm@nongnu.org>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 11 Oct 2020 at 20:49, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> Use self-explicit WINDOW_COUNT definition instead of a magic value.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/pci-host/versatile.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/hw/pci-host/versatile.c b/hw/pci-host/versatile.c
> index b4951023f4e..4d9565de4b1 100644
> --- a/hw/pci-host/versatile.c
> +++ b/hw/pci-host/versatile.c
> @@ -72,6 +72,8 @@ enum {
>      PCI_VPB_IRQMAP_FORCE_OK,
>  };
>
> +#define WINDOW_COUNT 3
> +
>  struct PCIVPBState {
>      PCIHostState parent_obj;
>
> @@ -86,18 +88,18 @@ struct PCIVPBState {
>       * The offsets into pci_mem_space are controlled by the imap registe=
rs.
>       */
>      MemoryRegion pci_io_window;
> -    MemoryRegion pci_mem_window[3];
> +    MemoryRegion pci_mem_window[WINDOW_COUNT];
>      PCIBus pci_bus;
>      PCIDevice pci_dev;
>
>      /* Constant for life of device: */
>      int realview;
> -    uint32_t mem_win_size[3];
> +    uint32_t mem_win_size[WINDOW_COUNT];
>      uint8_t irq_mapping_prop;
>
>      /* Variable state: */
> -    uint32_t imap[3];
> -    uint32_t smap[3];
> +    uint32_t imap[WINDOW_COUNT];
> +    uint32_t smap[WINDOW_COUNT];

Strictly speaking, this is conflating two separate
things which both happen to be equal to three.

The versatile/realview PCI controller has:
 * three memory windows in the system address space
   - those are represented by the pci_mem_window[] array
   - mem_win_size[] holds the size of each window
     (which is fixed but varies between the different
     implementations of this controller on different boards)
   - the device IMAPn registers allow the guest to
     configure the mapping from "a CPU access to an
     address in window n" to "a PCI address on the PCI bus,
     and our imap[] array holds those register values
 * three PCI BARs which represent memory windows on the
     PCI bus which bus-master PCI devices can use to
     write back into the system address space
   - the device SMAPn registers allow the guest to configure
     the mapping from "a bus-master access to an address
     on the PCI bus wherever the guest mapped BAR n"
     to "a system address", and the smap[] array holds
     those register values
There's no inherent reason why the number of PCI BARs
needs to be the same as the number of system address
space memory windows, so they shouldn't really share
the same constant.

(We don't actually implement the behaviour of the SMAP
registers and the BARs, because Linux always configures
the PCI controller to a 1:1 mapping of PCI space to
system address space. So we get away with just having
our implementation be "always do direct accesses".)

thanks
-- PMM

