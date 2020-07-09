Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF1FC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 15:55:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E74452077D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 15:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWmJ1qj3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E74452077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtYt2-0004uV-52
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 11:55:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jtYq6-0000Y8-RT
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 11:51:58 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:37695)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jtYq4-0006Xq-BI
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 11:51:58 -0400
Received: by mail-ot1-x341.google.com with SMTP id w17so2029309otl.4
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 08:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=XHwMvtYcnPMDQZFU+/0OEm73P/eIA9qBy4Qh8oglNkQ=;
 b=CWmJ1qj3m12S9qMJmfo0HxI58tW9jWsp4VH++wgueeb5OBGv6iibkrdmJGS89to5qM
 c2Hb+5o/uWdUcyLamLx/bVpnaEiiRyW2MZcew3o3NsCGX9/RBk9n2RGIqXcUx1XwXwgZ
 31BtLMyJaU66i6I0d4+ID788GLabuf9LAv/GKCUXHrQ50gAAFhmUFBUeD3/p/ds/1Zos
 4naNtSnZWw1FX1uVzOUjUbdBu0itibI2PLbkFQUziVC6BWxHtZHDNijfuVOUeymbHIWQ
 NcnKRbqLF/PbBD9TQMq5wmeDc1xpBnlbiPQGoSXOBg+XOvUBDdns/UWec8sWQvtfkeme
 iVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=XHwMvtYcnPMDQZFU+/0OEm73P/eIA9qBy4Qh8oglNkQ=;
 b=DcaPFMtYW1sQKNnEgCGe1s5pu/1oWtd/PbTSgvRR4yP4hXQQ6/KyKb/XSdNbYF5gdA
 ztx0i9XqzwlBQZ5to4ig3JOnwlc1WX5DEKmDoxxLf17CTZInScJIJtuzWd/VhTlCpetM
 o5Foi2RltXO3DnRkizOwci3iXJ1hCjCanfzcAS/JF3ft1Sj8KoRbeq71sShyLn665HuF
 CMf8beE48vlChwnIRjTqyv3TxIjFfIls5CAyxlWPNkxizo3Do86/ZWptjwsMD4ci+4j4
 iSh90JamkWAQqvD0nO48GvswrJMERGe9XlobRuLwUcGK/Efg0k3vo1vmuD1S6pmlKsBm
 kx3w==
X-Gm-Message-State: AOAM530lrF8tk+nsBb1Q+9LhZ7NQfQ4U5MId7ZSZkOYCbeuP5wjYsfiK
 2SpaFXiQRp/+B0iwVWyYsQf5CL4i6B0IyEmy/aoGOA+V4S8=
X-Google-Smtp-Source: ABdhPJwhTJNlAsHCq442y1KtfCUus/fJZjjcZOetzXeyf7K66sNPRelH36SMjYeOwZdq2RbW9QbhGX1dUCsgF4DRIwE=
X-Received: by 2002:a05:6830:15c3:: with SMTP id
 j3mr50699773otr.353.1594309915074; 
 Thu, 09 Jul 2020 08:51:55 -0700 (PDT)
MIME-Version: 1.0
References: <159400349818.1851.7243060688419202620.malonedeb@wampee.canonical.com>
In-Reply-To: <159400349818.1851.7243060688419202620.malonedeb@wampee.canonical.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 9 Jul 2020 23:51:18 +0800
Message-ID: <CAKXe6S+J3nARveToQjECbwV224gs66WkqGHybUhfw35t1+V8og@mail.gmail.com>
Subject: Re: [Bug 1886362] [NEW] Heap use-after-free in lduw_he_p through
 e1000e_write_to_rx_buffers
To: Bug 1886362 <1886362@bugs.launchpad.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Alexander Bulekov <1886362@bugs.launchpad.net> =E4=BA=8E2020=E5=B9=B47=E6=
=9C=886=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=8810:51=E5=86=99=E9=81=
=93=EF=BC=9A
>
> Public bug reported:
>
> Hello,
> This reproducer causes a heap-use-after free. QEMU Built with --enable-sa=
nitizers:
> cat << EOF | ./i386-softmmu/qemu-system-i386 -M q35,accel=3Dqtest \
> -qtest stdio -nographic -monitor none -serial none
> outl 0xcf8 0x80001010
> outl 0xcfc 0xe1020000
> outl 0xcf8 0x80001014
> outl 0xcf8 0x80001004
> outw 0xcfc 0x7
> outl 0xcf8 0x800010a2
> write 0xe102003b 0x1 0xff
> write 0xe1020103 0x1e 0xffffff055c5e5c30be4511d084fffffffffffffffffffffff=
fffffffffff
> write 0xe1020420 0x4 0xffffffff
> write 0xe1020424 0x4 0xffffffff
> write 0xe102042b 0x1 0xff
> write 0xe1020430 0x4 0x055c5e5c
> write 0x5c041 0x1 0x04
> write 0x5c042 0x1 0x02
> write 0x5c043 0x1 0xe1
> write 0x5c048 0x1 0x8a
> write 0x5c04a 0x1 0x31
> write 0x5c04b 0x1 0xff
> write 0xe1020403 0x1 0xff
> EOF
>


This bug is interesting.

We first set the e1000e BAR0 to '0xe1020000'.
Then we trigger a path:
e1000e_mmio_write->...e1000e_process_tx_desc->net_tx_pkt_add_raw_fragment.
In the last function we allocate an io vector 'ventry->iov_base'.

Then we continue:
e1000e_tx_pkt_send->net_tx_pkt_send_loopback...->e1000e_nc_receive_iov-->
e1000e_write_packet_to_guest->e1000e_write_to_rx_buffers.

Here comes the interesting part.  e1000e_write_to_rx_buffers write to
the e1000e's MMIO!
Not a RAM. So another round address dispatch is begin. This time we
also goes to the
 e1000e_mmio_write->...e1000e_process_tx_desc, However this time we goes to
'net_tx_pkt_reset' so the io vector allocated in
'net_tx_pkt_add_raw_fragment' was freed.


Then in 'e1000e_write_to_rx_buffers' while loop. It will access the
freed io vector.

Summar as this:
The guest trigger a e1000e packet send and set the data's address to
the e1000e's MMIO address
so this trigger another MMIO write and causes this UAF.

Maybe we should check whether the address is a RAM address in 'dma_memory_r=
w'?
But it is a hot path. I'm not sure it is right. Hope more discussion.

Add Paolo and Jason.

Thanks,
Li Qiang


> The Output:
> =3D=3D22689=3D=3DERROR: AddressSanitizer: heap-use-after-free on address =
0x62500026800e at pc 0x55b93bb18bfa bp 0x7fffdbe844f0 sp 0x7fffdbe83cb8
> READ of size 2 at 0x62500026800e thread T0
>     #0  in __asan_memcpy (/build/i386-softmmu/qemu-system-i386+)
>     #1  in lduw_he_p /include/qemu/bswap.h:332:5
>     #2  in ldn_he_p /include/qemu/bswap.h:550:1
>     #3  in flatview_write_continue /exec.c:3145:19
>     #4  in flatview_write /exec.c:3186:14
>     #5  in address_space_write /exec.c:3280:18
>     #6  in address_space_rw /exec.c:3290:16
>     #7  in dma_memory_rw_relaxed /include/sysemu/dma.h:87:18
>     #8  in dma_memory_rw /include/sysemu/dma.h:113:12
>     #9  in pci_dma_rw /include/hw/pci/pci.h:789:5
>     #10  in pci_dma_write /include/hw/pci/pci.h:802:12
>     #11  in e1000e_write_to_rx_buffers /hw/net/e1000e_core.c:1412:9
>     #12  in e1000e_write_packet_to_guest /hw/net/e1000e_core.c:1582:21
>     #13  in e1000e_receive_iov /hw/net/e1000e_core.c:1709:9
>     #14  in e1000e_nc_receive_iov /hw/net/e1000e.c:213:12
>     #15  in net_tx_pkt_sendv /hw/net/net_tx_pkt.c:544:9
>     #16  in net_tx_pkt_send /hw/net/net_tx_pkt.c:620:9
>     #17  in net_tx_pkt_send_loopback /hw/net/net_tx_pkt.c:633:11
>     #18  in e1000e_tx_pkt_send /hw/net/e1000e_core.c:664:16
>     #19  in e1000e_process_tx_desc /hw/net/e1000e_core.c:743:17
>     #20  in e1000e_start_xmit /hw/net/e1000e_core.c:934:9
>     #21  in e1000e_set_tctl /hw/net/e1000e_core.c:2431:9
>     #22  in e1000e_core_write /hw/net/e1000e_core.c:3265:9
>     #23  in e1000e_mmio_write /hw/net/e1000e.c:109:5
>     #24  in memory_region_write_accessor /memory.c:483:5
>     #25  in access_with_adjusted_size /memory.c:544:18
>     #26  in memory_region_dispatch_write /memory.c:1476:16
>     #27  in flatview_write_continue /exec.c:3146:23
>     #28  in flatview_write /exec.c:3186:14
>     #29  in address_space_write /exec.c:3280:18
>     #30  in qtest_process_command /qtest.c:567:9
>     #31  in qtest_process_inbuf /qtest.c:710:9
>     #32  in qtest_read /qtest.c:722:5
>     #33  in qemu_chr_be_write_impl /chardev/char.c:188:9
>     #34  in qemu_chr_be_write /chardev/char.c:200:9
>     #35  in fd_chr_read /chardev/char-fd.c:68:9
>     #36  in qio_channel_fd_source_dispatch /io/channel-watch.c:84:12
>     #37  in g_main_context_dispatch (/usr/lib/x86_64-linux-gnu/libglib-2.=
0.so.0+)
>     #38  in glib_pollfds_poll /util/main-loop.c:219:9
>     #39  in os_host_main_loop_wait /util/main-loop.c:242:5
>     #40  in main_loop_wait /util/main-loop.c:518:11
>     #41  in qemu_main_loop /softmmu/vl.c:1664:9
>     #42  in main /softmmu/main.c:52:5
>     #43  in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+)
>     #44  in _start (/build/i386-softmmu/qemu-system-i386+)
>
> 0x62500026800e is located 14 bytes inside of 138-byte region [0x625000268=
000,0x62500026808a)
> freed by thread T0 here:
>     #0  in free (/build/i386-softmmu/qemu-system-i386+)
>     #1  in qemu_vfree /util/oslib-posix.c:238:5
>     #2  in address_space_unmap /exec.c:3616:5
>     #3  in dma_memory_unmap /include/sysemu/dma.h:148:5
>     #4  in pci_dma_unmap /include/hw/pci/pci.h:839:5
>     #5  in net_tx_pkt_reset /hw/net/net_tx_pkt.c:453:9
>     #6  in e1000e_process_tx_desc /hw/net/e1000e_core.c:749:9
>     #7  in e1000e_start_xmit /hw/net/e1000e_core.c:934:9
>     #8  in e1000e_set_tctl /hw/net/e1000e_core.c:2431:9
>     #9  in e1000e_core_write /hw/net/e1000e_core.c:3265:9
>     #10  in e1000e_mmio_write /hw/net/e1000e.c:109:5
>     #11  in memory_region_write_accessor /memory.c:483:5
>     #12  in access_with_adjusted_size /memory.c:544:18
>     #13  in memory_region_dispatch_write /memory.c:1476:16
>     #14  in flatview_write_continue /exec.c:3146:23
>     #15  in flatview_write /exec.c:3186:14
>     #16  in address_space_write /exec.c:3280:18
>     #17  in address_space_rw /exec.c:3290:16
>     #18  in dma_memory_rw_relaxed /include/sysemu/dma.h:87:18
>     #19  in dma_memory_rw /include/sysemu/dma.h:113:12
>     #20  in pci_dma_rw /include/hw/pci/pci.h:789:5
>     #21  in pci_dma_write /include/hw/pci/pci.h:802:12
>     #22  in e1000e_write_to_rx_buffers /hw/net/e1000e_core.c:1412:9
>     #23  in e1000e_write_packet_to_guest /hw/net/e1000e_core.c:1582:21
>     #24  in e1000e_receive_iov /hw/net/e1000e_core.c:1709:9
>     #25  in e1000e_nc_receive_iov /hw/net/e1000e.c:213:12
>     #26  in net_tx_pkt_sendv /hw/net/net_tx_pkt.c:544:9
>     #27  in net_tx_pkt_send /hw/net/net_tx_pkt.c:620:9
>     #28  in net_tx_pkt_send_loopback /hw/net/net_tx_pkt.c:633:11
>     #29  in e1000e_tx_pkt_send /hw/net/e1000e_core.c:664:16
>
> previously allocated by thread T0 here:
>     #0  in posix_memalign (/build/i386-softmmu/qemu-system-i386+)
>     #1  in qemu_try_memalign /util/oslib-posix.c:198:11
>     #2  in qemu_memalign /util/oslib-posix.c:214:27
>     #3  in address_space_map /exec.c:3558:25
>     #4  in dma_memory_map /include/sysemu/dma.h:138:9
>     #5  in pci_dma_map /include/hw/pci/pci.h:832:11
>     #6  in net_tx_pkt_add_raw_fragment /hw/net/net_tx_pkt.c:391:24
>     #7  in e1000e_process_tx_desc /hw/net/e1000e_core.c:731:14
>     #8  in e1000e_start_xmit /hw/net/e1000e_core.c:934:9
>     #9  in e1000e_set_tctl /hw/net/e1000e_core.c:2431:9
>     #10  in e1000e_core_write /hw/net/e1000e_core.c:3265:9
>     #11  in e1000e_mmio_write /hw/net/e1000e.c:109:5
>     #12  in memory_region_write_accessor /memory.c:483:5
>     #13  in access_with_adjusted_size /memory.c:544:18
>     #14  in memory_region_dispatch_write /memory.c:1476:16
>     #15  in flatview_write_continue /exec.c:3146:23
>     #16  in flatview_write /exec.c:3186:14
>     #17  in address_space_write /exec.c:3280:18
>     #18  in qtest_process_command /qtest.c:567:9
>     #19  in qtest_process_inbuf /qtest.c:710:9
>     #20  in qtest_read /qtest.c:722:5
>     #21  in qemu_chr_be_write_impl /chardev/char.c:188:9
>     #22  in qemu_chr_be_write /chardev/char.c:200:9
>     #23  in fd_chr_read /chardev/char-fd.c:68:9
>     #24  in qio_channel_fd_source_dispatch /io/channel-watch.c:84:12
>     #25  in g_main_context_dispatch (/usr/lib/x86_64-linux-gnu/libglib-2.=
0.so.0+)
>
> -Alex
>
> ** Affects: qemu
>      Importance: Undecided
>          Status: New
>
> --
> You received this bug notification because you are a member of qemu-
> devel-ml, which is subscribed to QEMU.
> https://bugs.launchpad.net/bugs/1886362
>
> Title:
>   Heap use-after-free in lduw_he_p through e1000e_write_to_rx_buffers
>
> Status in QEMU:
>   New
>
> Bug description:
>   Hello,
>   This reproducer causes a heap-use-after free. QEMU Built with --enable-=
sanitizers:
>   cat << EOF | ./i386-softmmu/qemu-system-i386 -M q35,accel=3Dqtest \
>   -qtest stdio -nographic -monitor none -serial none
>   outl 0xcf8 0x80001010
>   outl 0xcfc 0xe1020000
>   outl 0xcf8 0x80001014
>   outl 0xcf8 0x80001004
>   outw 0xcfc 0x7
>   outl 0xcf8 0x800010a2
>   write 0xe102003b 0x1 0xff
>   write 0xe1020103 0x1e 0xffffff055c5e5c30be4511d084fffffffffffffffffffff=
fffffffffffff
>   write 0xe1020420 0x4 0xffffffff
>   write 0xe1020424 0x4 0xffffffff
>   write 0xe102042b 0x1 0xff
>   write 0xe1020430 0x4 0x055c5e5c
>   write 0x5c041 0x1 0x04
>   write 0x5c042 0x1 0x02
>   write 0x5c043 0x1 0xe1
>   write 0x5c048 0x1 0x8a
>   write 0x5c04a 0x1 0x31
>   write 0x5c04b 0x1 0xff
>   write 0xe1020403 0x1 0xff
>   EOF
>
>   The Output:
>   =3D=3D22689=3D=3DERROR: AddressSanitizer: heap-use-after-free on addres=
s 0x62500026800e at pc 0x55b93bb18bfa bp 0x7fffdbe844f0 sp 0x7fffdbe83cb8
>   READ of size 2 at 0x62500026800e thread T0
>       #0  in __asan_memcpy (/build/i386-softmmu/qemu-system-i386+)
>       #1  in lduw_he_p /include/qemu/bswap.h:332:5
>       #2  in ldn_he_p /include/qemu/bswap.h:550:1
>       #3  in flatview_write_continue /exec.c:3145:19
>       #4  in flatview_write /exec.c:3186:14
>       #5  in address_space_write /exec.c:3280:18
>       #6  in address_space_rw /exec.c:3290:16
>       #7  in dma_memory_rw_relaxed /include/sysemu/dma.h:87:18
>       #8  in dma_memory_rw /include/sysemu/dma.h:113:12
>       #9  in pci_dma_rw /include/hw/pci/pci.h:789:5
>       #10  in pci_dma_write /include/hw/pci/pci.h:802:12
>       #11  in e1000e_write_to_rx_buffers /hw/net/e1000e_core.c:1412:9
>       #12  in e1000e_write_packet_to_guest /hw/net/e1000e_core.c:1582:21
>       #13  in e1000e_receive_iov /hw/net/e1000e_core.c:1709:9
>       #14  in e1000e_nc_receive_iov /hw/net/e1000e.c:213:12
>       #15  in net_tx_pkt_sendv /hw/net/net_tx_pkt.c:544:9
>       #16  in net_tx_pkt_send /hw/net/net_tx_pkt.c:620:9
>       #17  in net_tx_pkt_send_loopback /hw/net/net_tx_pkt.c:633:11
>       #18  in e1000e_tx_pkt_send /hw/net/e1000e_core.c:664:16
>       #19  in e1000e_process_tx_desc /hw/net/e1000e_core.c:743:17
>       #20  in e1000e_start_xmit /hw/net/e1000e_core.c:934:9
>       #21  in e1000e_set_tctl /hw/net/e1000e_core.c:2431:9
>       #22  in e1000e_core_write /hw/net/e1000e_core.c:3265:9
>       #23  in e1000e_mmio_write /hw/net/e1000e.c:109:5
>       #24  in memory_region_write_accessor /memory.c:483:5
>       #25  in access_with_adjusted_size /memory.c:544:18
>       #26  in memory_region_dispatch_write /memory.c:1476:16
>       #27  in flatview_write_continue /exec.c:3146:23
>       #28  in flatview_write /exec.c:3186:14
>       #29  in address_space_write /exec.c:3280:18
>       #30  in qtest_process_command /qtest.c:567:9
>       #31  in qtest_process_inbuf /qtest.c:710:9
>       #32  in qtest_read /qtest.c:722:5
>       #33  in qemu_chr_be_write_impl /chardev/char.c:188:9
>       #34  in qemu_chr_be_write /chardev/char.c:200:9
>       #35  in fd_chr_read /chardev/char-fd.c:68:9
>       #36  in qio_channel_fd_source_dispatch /io/channel-watch.c:84:12
>       #37  in g_main_context_dispatch (/usr/lib/x86_64-linux-gnu/libglib-=
2.0.so.0+)
>       #38  in glib_pollfds_poll /util/main-loop.c:219:9
>       #39  in os_host_main_loop_wait /util/main-loop.c:242:5
>       #40  in main_loop_wait /util/main-loop.c:518:11
>       #41  in qemu_main_loop /softmmu/vl.c:1664:9
>       #42  in main /softmmu/main.c:52:5
>       #43  in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+)
>       #44  in _start (/build/i386-softmmu/qemu-system-i386+)
>
>   0x62500026800e is located 14 bytes inside of 138-byte region [0x6250002=
68000,0x62500026808a)
>   freed by thread T0 here:
>       #0  in free (/build/i386-softmmu/qemu-system-i386+)
>       #1  in qemu_vfree /util/oslib-posix.c:238:5
>       #2  in address_space_unmap /exec.c:3616:5
>       #3  in dma_memory_unmap /include/sysemu/dma.h:148:5
>       #4  in pci_dma_unmap /include/hw/pci/pci.h:839:5
>       #5  in net_tx_pkt_reset /hw/net/net_tx_pkt.c:453:9
>       #6  in e1000e_process_tx_desc /hw/net/e1000e_core.c:749:9
>       #7  in e1000e_start_xmit /hw/net/e1000e_core.c:934:9
>       #8  in e1000e_set_tctl /hw/net/e1000e_core.c:2431:9
>       #9  in e1000e_core_write /hw/net/e1000e_core.c:3265:9
>       #10  in e1000e_mmio_write /hw/net/e1000e.c:109:5
>       #11  in memory_region_write_accessor /memory.c:483:5
>       #12  in access_with_adjusted_size /memory.c:544:18
>       #13  in memory_region_dispatch_write /memory.c:1476:16
>       #14  in flatview_write_continue /exec.c:3146:23
>       #15  in flatview_write /exec.c:3186:14
>       #16  in address_space_write /exec.c:3280:18
>       #17  in address_space_rw /exec.c:3290:16
>       #18  in dma_memory_rw_relaxed /include/sysemu/dma.h:87:18
>       #19  in dma_memory_rw /include/sysemu/dma.h:113:12
>       #20  in pci_dma_rw /include/hw/pci/pci.h:789:5
>       #21  in pci_dma_write /include/hw/pci/pci.h:802:12
>       #22  in e1000e_write_to_rx_buffers /hw/net/e1000e_core.c:1412:9
>       #23  in e1000e_write_packet_to_guest /hw/net/e1000e_core.c:1582:21
>       #24  in e1000e_receive_iov /hw/net/e1000e_core.c:1709:9
>       #25  in e1000e_nc_receive_iov /hw/net/e1000e.c:213:12
>       #26  in net_tx_pkt_sendv /hw/net/net_tx_pkt.c:544:9
>       #27  in net_tx_pkt_send /hw/net/net_tx_pkt.c:620:9
>       #28  in net_tx_pkt_send_loopback /hw/net/net_tx_pkt.c:633:11
>       #29  in e1000e_tx_pkt_send /hw/net/e1000e_core.c:664:16
>
>   previously allocated by thread T0 here:
>       #0  in posix_memalign (/build/i386-softmmu/qemu-system-i386+)
>       #1  in qemu_try_memalign /util/oslib-posix.c:198:11
>       #2  in qemu_memalign /util/oslib-posix.c:214:27
>       #3  in address_space_map /exec.c:3558:25
>       #4  in dma_memory_map /include/sysemu/dma.h:138:9
>       #5  in pci_dma_map /include/hw/pci/pci.h:832:11
>       #6  in net_tx_pkt_add_raw_fragment /hw/net/net_tx_pkt.c:391:24
>       #7  in e1000e_process_tx_desc /hw/net/e1000e_core.c:731:14
>       #8  in e1000e_start_xmit /hw/net/e1000e_core.c:934:9
>       #9  in e1000e_set_tctl /hw/net/e1000e_core.c:2431:9
>       #10  in e1000e_core_write /hw/net/e1000e_core.c:3265:9
>       #11  in e1000e_mmio_write /hw/net/e1000e.c:109:5
>       #12  in memory_region_write_accessor /memory.c:483:5
>       #13  in access_with_adjusted_size /memory.c:544:18
>       #14  in memory_region_dispatch_write /memory.c:1476:16
>       #15  in flatview_write_continue /exec.c:3146:23
>       #16  in flatview_write /exec.c:3186:14
>       #17  in address_space_write /exec.c:3280:18
>       #18  in qtest_process_command /qtest.c:567:9
>       #19  in qtest_process_inbuf /qtest.c:710:9
>       #20  in qtest_read /qtest.c:722:5
>       #21  in qemu_chr_be_write_impl /chardev/char.c:188:9
>       #22  in qemu_chr_be_write /chardev/char.c:200:9
>       #23  in fd_chr_read /chardev/char-fd.c:68:9
>       #24  in qio_channel_fd_source_dispatch /io/channel-watch.c:84:12
>       #25  in g_main_context_dispatch (/usr/lib/x86_64-linux-gnu/libglib-=
2.0.so.0+)
>
>   -Alex
>
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1886362/+subscriptions
>

