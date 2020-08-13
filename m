Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8716BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 19:57:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4798320716
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 19:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDD/df8y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4798320716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6JMG-0005au-FS
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 15:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1k6JLe-00054q-95; Thu, 13 Aug 2020 15:57:14 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:39554)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1k6JLc-0002EQ-4N; Thu, 13 Aug 2020 15:57:14 -0400
Received: by mail-qk1-x743.google.com with SMTP id n129so6317403qkd.6;
 Thu, 13 Aug 2020 12:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=npOUMXNMSWHROSluUwnLetPOcozIro38RWUtoCap6Sc=;
 b=bDD/df8y5b7RlHFH3mB3CO/3PB8BJzyrILjSR9DCGTFnh16Ne5FVj5h2qMPHjWMrib
 AAasDGKKHtFzzaR37pKtCQ2BNGUFVBNgsRZ6ImWPlx9++9L6/F+oitttkkiGruqEZSRC
 uOpVUbgHT1nuuLBUtVrVg3GichnBaXZXnsCXa5FNLvTA+PV6ecjk4ri2ko20F0GD9Kb0
 Bevs8sCM0ZBQR51eW68Hpa/tzmWedW1FeOLO1sEAAcY2w/sEhhqIieNNFHsTvyXMupDx
 qM9NWTINlI9n81v0w9Vbg1TMbrC0HxSv0DcPve2ssw6p9kJKEC8+luAlj3bkg5wFPso9
 SeKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=npOUMXNMSWHROSluUwnLetPOcozIro38RWUtoCap6Sc=;
 b=QKQtjpEPZdIKsH3rIo1k6i/s/zBXfyh/5ZCM+1ByYzt9fgA48Xvj98Dgy3kQmctWzn
 V/HQf4T/xGYFVNuqyB+Dq4Xhem3uTSt3jyFiMMvHmzqxYd/3rgl7a2ShOvTXGcx29vM0
 2pgttN7tipbN5G1RCBBCr9oesvhSQMtx6VZxJ/p9HTbO91moN2oDipsJMON9CIhqTlJW
 YYlsayAeYYc4zhzZ3DbANR1fZxmzmH5RX+dR/tRDZp+NaKP2RYZSIgR++F5e67Ucy/A0
 HlOeOlmbvoPIouj0t7CpRC8f97GxcbgCz6j1A1E2abszix6RJcysLpkviwCtWfA+dNjn
 Co9g==
X-Gm-Message-State: AOAM530JbmeNXuhXLeXEewXoSrl0RScDIDm3g3IzOHR0uqUtG5BtVPEd
 rjxfT3Q/c7yEySN5inaWkF4n3ucI
X-Google-Smtp-Source: ABdhPJyi0SrGIO5y6NcS14QUSw0siwRZyi16aVQLvBaFik6WZAuir5KyvdHKuYMx5AsjV/RhvdWdJw==
X-Received: by 2002:a05:620a:628:: with SMTP id
 8mr6446273qkv.103.1597348629838; 
 Thu, 13 Aug 2020 12:57:09 -0700 (PDT)
Received: from ?IPv6:2804:431:c7c6:303f:d1dc:35d8:e9f6:c8b?
 ([2804:431:c7c6:303f:d1dc:35d8:e9f6:c8b])
 by smtp.gmail.com with ESMTPSA id k24sm8033028qtb.26.2020.08.13.12.57.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2020 12:57:08 -0700 (PDT)
Subject: Re: [PATCH 01/14] spapr: Simplify error handling in
 spapr_phb_realize()
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <159707843034.1489912.1082061742626355958.stgit@bahia.lan>
 <159707843851.1489912.6108405733810934642.stgit@bahia.lan>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <2c8847d7-0f87-4fb1-8551-2e4fdb8f2708@gmail.com>
Date: Thu, 13 Aug 2020 16:57:04 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <159707843851.1489912.6108405733810934642.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::743;
 envelope-from=danielhb413@gmail.com; helo=mail-qk1-x743.google.com
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
Cc: qemu-ppc@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Greg,

This patch is breaking guest startup in ppc-for-5.2 for me. The process
gives an almost instant segfault. Here's what I'm doing:

$ sudo ./qemu-system-ppc64 -machine pseries-5.1,accel=kvm,usb=off,dump-guest-core=off -m 65536\
-overcommit mem-lock=off -smp 4,sockets=4,cores=1,threads=1 -rtc base=utc -display none -vga none -nographic -boot menu=on \
-device spapr-pci-host-bridge,index=1,id=pci.1 -device spapr-pci-host-bridge,index=2,id=pci.2 \
-device spapr-pci-host-bridge,index=3,id=pci.3 -device spapr-pci-host-bridge,index=4,id=pci.4 \
-device qemu-xhci,id=usb,bus=pci.0,addr=0x2 \
-drive file=/home/danielhb/f32.qcow2,format=qcow2,if=none,id=drive-virtio-disk0 \
-device virtio-blk-pci,scsi=off,bus=pci.0,addr=0x3,drive=drive-virtio-disk0,id=virtio-disk0,bootindex=1 \
-device usb-kbd,id=input0,bus=usb.0,port=1 -device usb-mouse,id=input1,bus=usb.0,port=2 \
-device virtio-balloon-pci,id=balloon0,bus=pci.0,addr=0x4 -msg timestamp=on \
-machine cap-ccf-assist=off
Segmentation fault
$


GDB points this backtrace:

Thread 1 "qemu-system-ppc" received signal SIGSEGV, Segmentation fault.
error_vprepend (errp=0x7fffffffe400, fmt=0x100ec2698 "can't allocate LSIs: ", ap=0x7fffffffe290 "\030") at /home/danielhb/qemu/util/error.c:134
134         g_string_append(newmsg, (*errp)->msg);
Missing separate debuginfos, use: dnf debuginfo-install glib2-2.64.4-1.fc32.ppc64le libblkid-2.35.2-1.fc32.ppc64le libffi-3.1-24.fc32.ppc64le libgcrypt-1.8.5-3.fc32.ppc64le libgpg-error-1.36-3.fc32.ppc64le libmount-2.35.2-1.fc32.ppc64le libselinux-3.0-5.fc32.ppc64le libxml2-2.9.10-3.fc32.ppc64le ncurses-libs-6.1-15.20191109.fc32.ppc64le numactl-libs-2.0.12-4.fc32.ppc64le pcre-8.44-1.fc32.ppc64le pcre2-10.35-4.fc32.ppc64le pixman-0.40.0-1.fc32.ppc64le xz-libs-5.2.5-1.fc32.ppc64le zlib-1.2.11-21.fc32.ppc64le
(gdb) bt
#0  error_vprepend (errp=0x7fffffffe400, fmt=0x100ec2698 "can't allocate LSIs: ", ap=0x7fffffffe290 "\030") at /home/danielhb/qemu/util/error.c:134
#1  0x0000000100c1e9cc in error_prepend (errp=0x7fffffffe400, fmt=0x100ec2698 "can't allocate LSIs: ") at /home/danielhb/qemu/util/error.c:144
#2  0x00000001004cdad4 in spapr_phb_realize (dev=0x101d6cb90, errp=0x7fffffffe400) at /home/danielhb/qemu/hw/ppc/spapr_pci.c:1982
#3  0x0000000100735f70 in device_set_realized (obj=0x101d6cb90, value=true, errp=0x7fffffffe568) at /home/danielhb/qemu/hw/core/qdev.c:864
#4  0x0000000100a5aae4 in property_set_bool (obj=0x101d6cb90, v=0x101d6daa0, name=0x100f13df8 "realized", opaque=0x1016d2430, errp=0x7fffffffe568) at /home/danielhb/qemu/qom/object.c:2202
#5  0x0000000100a57d64 in object_property_set (obj=0x101d6cb90, name=0x100f13df8 "realized", v=0x101d6daa0, errp=0x1016156c0 <error_fatal>) at /home/danielhb/qemu/qom/object.c:1349
#6  0x0000000100a5cb38 in object_property_set_qobject (obj=0x101d6cb90, name=0x100f13df8 "realized", value=0x101d6c950, errp=0x1016156c0 <error_fatal>)
     at /home/danielhb/qemu/qom/qom-qobject.c:28
#7  0x0000000100a581fc in object_property_set_bool (obj=0x101d6cb90, name=0x100f13df8 "realized", value=true, errp=0x1016156c0 <error_fatal>) at /home/danielhb/qemu/qom/object.c:1416
#8  0x0000000100734178 in qdev_realize (dev=0x101d6cb90, bus=0x10198e250, errp=0x1016156c0 <error_fatal>) at /home/danielhb/qemu/hw/core/qdev.c:379
#9  0x00000001007341dc in qdev_realize_and_unref (dev=0x101d6cb90, bus=0x10198e250, errp=0x1016156c0 <error_fatal>) at /home/danielhb/qemu/hw/core/qdev.c:386
#10 0x00000001007463c0 in sysbus_realize_and_unref (dev=0x101d6cb90, errp=0x1016156c0 <error_fatal>) at /home/danielhb/qemu/hw/core/sysbus.c:260
#11 0x00000001004a6960 in spapr_create_default_phb () at /home/danielhb/qemu/hw/ppc/spapr.c:2652
#12 0x00000001004a7428 in spapr_machine_init (machine=0x101965800) at /home/danielhb/qemu/hw/ppc/spapr.c:2940
#13 0x000000010074a3b0 in machine_run_board_init (machine=0x101965800) at /home/danielhb/qemu/hw/core/machine.c:1135
#14 0x000000010054f390 in qemu_init (argc=42, argv=0x7ffffffff0a8, envp=0x7ffffffff200) at /home/danielhb/qemu/softmmu/vl.c:4355
#15 0x0000000100b8ee00 in main (argc=42, argv=0x7ffffffff0a8, envp=0x7ffffffff200) at /home/danielhb/qemu/softmmu/main.c:48
(gdb)


Removing this patch (i.e. resetting HEAD at "target/ppc: Integrate icount
to purr, vtb, and tbu40") allows me to get the guest rolling.



Thanks,


Daniel



On 8/10/20 1:53 PM, Greg Kurz wrote:
> The spapr_phb_realize() function has a local_err variable which
> is used to:
> 
> 1) check failures of spapr_irq_findone() and spapr_irq_claim()
> 
> 2) prepend extra information to the error message
> 
> Recent work from Markus Armbruster highlighted we get better
> code when testing the return value of a function, rather than
> setting up all the local_err boiler plate. For similar reasons,
> it is now preferred to use ERRP_GUARD() and error_prepend()
> rather than error_propagate_prepend().
> 
> Since spapr_irq_findone() and spapr_irq_claim() return negative
> values in case of failure, do both changes.
> 
> This is just cleanup, no functional impact.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>   hw/ppc/spapr_pci.c |   16 +++++++---------
>   1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 363cdb3f7b8d..0a418f1e6711 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1796,6 +1796,7 @@ static void spapr_phb_destroy_msi(gpointer opaque)
>   
>   static void spapr_phb_realize(DeviceState *dev, Error **errp)
>   {
> +    ERRP_GUARD();
>       /* We don't use SPAPR_MACHINE() in order to exit gracefully if the user
>        * tries to add a sPAPR PHB to a non-pseries machine.
>        */
> @@ -1813,7 +1814,6 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
>       uint64_t msi_window_size = 4096;
>       SpaprTceTable *tcet;
>       const unsigned windows_supported = spapr_phb_windows_supported(sphb);
> -    Error *local_err = NULL;
>   
>       if (!spapr) {
>           error_setg(errp, TYPE_SPAPR_PCI_HOST_BRIDGE " needs a pseries machine");
> @@ -1964,13 +1964,12 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
>   
>       /* Initialize the LSI table */
>       for (i = 0; i < PCI_NUM_PINS; i++) {
> -        uint32_t irq = SPAPR_IRQ_PCI_LSI + sphb->index * PCI_NUM_PINS + i;
> +        int irq = SPAPR_IRQ_PCI_LSI + sphb->index * PCI_NUM_PINS + i;
>   
>           if (smc->legacy_irq_allocation) {
> -            irq = spapr_irq_findone(spapr, &local_err);
> -            if (local_err) {
> -                error_propagate_prepend(errp, local_err,
> -                                        "can't allocate LSIs: ");
> +            irq = spapr_irq_findone(spapr, errp);
> +            if (irq < 0) {
> +                error_prepend(errp, "can't allocate LSIs: ");
>                   /*
>                    * Older machines will never support PHB hotplug, ie, this is an
>                    * init only path and QEMU will terminate. No need to rollback.
> @@ -1979,9 +1978,8 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
>               }
>           }
>   
> -        spapr_irq_claim(spapr, irq, true, &local_err);
> -        if (local_err) {
> -            error_propagate_prepend(errp, local_err, "can't allocate LSIs: ");
> +        if (spapr_irq_claim(spapr, irq, true, errp) < 0) {
> +            error_prepend(errp, "can't allocate LSIs: ");
>               goto unrealize;
>           }
>   
> 
> 
> 

