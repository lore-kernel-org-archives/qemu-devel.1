Return-Path: <SRS0=clLO=73=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA6AC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 10:59:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDE7A20739
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 10:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDE7A20739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkQM0-0003Gl-50
	for qemu-devel@archiver.kernel.org; Sun, 14 Jun 2020 06:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jkQLD-0002lG-PX; Sun, 14 Jun 2020 06:58:19 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:56088
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jkQLC-0000eb-8L; Sun, 14 Jun 2020 06:58:19 -0400
Received: from host217-39-64-113.range217-39.btcentralplus.com
 ([217.39.64.113] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jkQLG-0005SP-FN; Sun, 14 Jun 2020 11:58:26 +0100
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <cover.1592055375.git.balaton@eik.bme.hu>
 <c637ae5d399e5681bb4f21662c7240590e7182e1.1592055375.git.balaton@eik.bme.hu>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 mQENBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAG0ME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPokB
 OAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63LkBDQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABiQEfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
Message-ID: <470996b7-26a5-2f3b-25c1-5812a4cf4f12@ilande.co.uk>
Date: Sun, 14 Jun 2020 11:58:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <c637ae5d399e5681bb4f21662c7240590e7182e1.1592055375.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 217.39.64.113
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 5/5] mac_oldworld: Map macio to expected address at
 reset
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk;
 helo=mail.default.ilande.uk0.bigv.io
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Howard Spoelstra <hsp.cat7@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/06/2020 14:36, BALATON Zoltan wrote:

> Add a reset function that maps macio to the address expected by the
> firmware of the board at startup.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/ppc/mac.h          | 12 ++++++++++++
>  hw/ppc/mac_oldworld.c | 17 +++++++++++++++--
>  2 files changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/mac.h b/hw/ppc/mac.h
> index 6af87d1fa0..35a5f21163 100644
> --- a/hw/ppc/mac.h
> +++ b/hw/ppc/mac.h
> @@ -57,6 +57,18 @@
>  #define OLDWORLD_IDE1_IRQ      0xe
>  #define OLDWORLD_IDE1_DMA_IRQ  0x3
>  
> +/* g3beige machine */
> +#define TYPE_HEATHROW_MACHINE MACHINE_TYPE_NAME("g3beige")
> +#define HEATHROW_MACHINE(obj) OBJECT_CHECK(HeathrowMachineState, (obj), \
> +                                           TYPE_HEATHROW_MACHINE)
> +
> +typedef struct HeathrowMachineState {
> +    /*< private >*/
> +    MachineState parent;
> +
> +    PCIDevice *macio_pci;
> +} HeathrowMachineState;
> +
>  /* New World IRQs */
>  #define NEWWORLD_CUDA_IRQ      0x19
>  #define NEWWORLD_PMU_IRQ       0x19
> diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
> index 9138752ccb..fa9527410d 100644
> --- a/hw/ppc/mac_oldworld.c
> +++ b/hw/ppc/mac_oldworld.c
> @@ -73,6 +73,15 @@ static uint64_t translate_kernel_address(void *opaque, uint64_t addr)
>      return (addr & 0x0fffffff) + KERNEL_LOAD_ADDR;
>  }
>  
> +static void ppc_heathrow_reset(MachineState *machine)
> +{
> +    HeathrowMachineState *m = HEATHROW_MACHINE(machine);
> +
> +    qemu_devices_reset();
> +    pci_default_write_config(m->macio_pci, PCI_COMMAND, PCI_COMMAND_MEMORY, 2);
> +    pci_default_write_config(m->macio_pci, PCI_BASE_ADDRESS_0, 0xf3000000, 4);
> +}
> +
>  static void ppc_heathrow_cpu_reset(void *opaque)
>  {
>      PowerPCCPU *cpu = opaque;
> @@ -91,6 +100,7 @@ const MemoryRegionOps machine_id_reg_ops = {
>  
>  static void ppc_heathrow_init(MachineState *machine)
>  {
> +    HeathrowMachineState *hm = HEATHROW_MACHINE(machine);
>      ram_addr_t ram_size = machine->ram_size;
>      const char *kernel_filename = machine->kernel_filename;
>      const char *kernel_cmdline = machine->kernel_cmdline;
> @@ -298,7 +308,8 @@ static void ppc_heathrow_init(MachineState *machine)
>      ide_drive_get(hd, ARRAY_SIZE(hd));
>  
>      /* MacIO */
> -    macio = OLDWORLD_MACIO(pci_create(pci_bus, -1, TYPE_OLDWORLD_MACIO));
> +    hm->macio_pci = pci_create(pci_bus, -1, TYPE_OLDWORLD_MACIO);
> +    macio = OLDWORLD_MACIO(hm->macio_pci);
>      dev = DEVICE(macio);
>      qdev_prop_set_uint64(dev, "frequency", tbfreq);
>      object_property_set_link(OBJECT(macio), OBJECT(pic_dev), "pic",
> @@ -450,6 +461,7 @@ static void heathrow_class_init(ObjectClass *oc, void *data)
>  
>      mc->desc = "Heathrow based PowerMAC";
>      mc->init = ppc_heathrow_init;
> +    mc->reset = ppc_heathrow_reset;
>      mc->block_default_type = IF_IDE;
>      mc->max_cpus = MAX_CPUS;
>  #ifndef TARGET_PPC64
> @@ -466,9 +478,10 @@ static void heathrow_class_init(ObjectClass *oc, void *data)
>  }
>  
>  static const TypeInfo ppc_heathrow_machine_info = {
> -    .name          = MACHINE_TYPE_NAME("g3beige"),
> +    .name          = TYPE_HEATHROW_MACHINE,
>      .parent        = TYPE_MACHINE,
>      .class_init    = heathrow_class_init,
> +    .instance_size = sizeof(HeathrowMachineState),
>      .interfaces = (InterfaceInfo[]) {
>          { TYPE_FW_PATH_PROVIDER },
>          { }

This doesn't feel right to me - either the PROM should be configuring the BARs as it
requires before trying to use the macio device, or the macio device has a fixed
mapping. Possibly the latter could be true given that things are so early in the boot
process?

Are there any hints in the macio "reg" and "address" properties suggesting that this
might be the case?


ATB,

Mark.

