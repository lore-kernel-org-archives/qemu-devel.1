Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F64EC433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 11:50:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF68C2070A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 11:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwIvtGaB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF68C2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxUJC-0007yJ-V8
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 07:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jxUFu-0003tf-7s
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 07:46:50 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:33463)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jxUFs-0006Ko-1p
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 07:46:49 -0400
Received: by mail-oi1-x241.google.com with SMTP id k22so14183916oib.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 04:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=2/AkzMiTS13DccquY7jGQx2CWUNtFH42zmi7DFUaj14=;
 b=EwIvtGaBJsGozenntl4+VkwhqEINH+/uHs7sBOjCxwlqoTp5cw/ueFBFIZb9Yx5Pxw
 hB1FdTMi7YKdq4zCeRttUtv+GSlkSSObj9UvyiPAxYCJqhVYBzTq2wN3Ne/YFQ8+pz8f
 DDPrnJ6U/SM3qYtHkPWj6Aha5iPPhq59Pa+qlIFdF3lLE/4WGEEOHDI8saxz5zQZvP2K
 vlLAPKOlXl/SIwT9kNJQ4z/9sA3T4WWyVl1uSvh9VzlAezXH08owYvYyRAYdDb/GXN0S
 DqnyUTSmatU6UeoXo3HlanXlIvYu+BB4DTKqgR9uk1UvLvUL4mBhI8eGH7SwGKLjexcg
 bfhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=2/AkzMiTS13DccquY7jGQx2CWUNtFH42zmi7DFUaj14=;
 b=TtNp1Oj1gwQP2qfVOX8s9WYf3an2Z1xHcSb7U/iquXlVLOn4H7BSn/8lboovAV2Nai
 xjGQcw0uehH/PeYKoqLosWe//NC47jT3W1pl9hEGe9+IFu86xHeN5AvnL7o8PwWq42uY
 uhIUsuWaIBEg9yW5e7nI3tNaTxAbolDmyOEt3Xdxkzfp+GuCZ6Hwf/TUZ+xo3GJ9K4fq
 Wa1yS59sQf5zfKWkPDYTR6i/NhkPsh3/hMy0sYOR9JQxtt7IXxbgSCMTlHosAIRvK9pT
 Vv//ids4DbJvDJgqqMvMBEQkb4FMxroXwphhLnUOJDvmbcwO1GO6TOjTq1nkS0vaLVCj
 3gKQ==
X-Gm-Message-State: AOAM5319mAUlG17yr0NRxo+1Ej7KPqB8FORqTqmjuIh/+ov5clIdSB54
 qq8Ms4alVOFbHvn8TCbHVqtOiQLW9T2XSnkwsDc=
X-Google-Smtp-Source: ABdhPJzbv9oow91CXEUj/xbmuM2NzN98NpySLhCCAGna4r7U/zooE/kfmg1E38XWWjIpo7JLonZN6lMEC6EiwbFxdPM=
X-Received: by 2002:aca:524c:: with SMTP id g73mr16863060oib.150.1595245606761; 
 Mon, 20 Jul 2020 04:46:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200716192335.1212638-1-ppandit@redhat.com>
 <CAKXe6SKL3aNiOKKLEMof6GGNjYLcX9fvfSf-0PBSX48rh4--FQ@mail.gmail.com>
 <20200717012151.tlfmc6hsfia22f4e@mozz.bu.edu>
 <4e4909ae-db2f-4a32-ae5c-d52149e80a8c@redhat.com>
 <nycvar.YSQ.7.78.906.2007171016480.950384@xnncv>
 <3620abab-a464-8e3c-d5b9-0bd80b35e2f1@redhat.com>
 <nycvar.YSQ.7.78.906.2007171326100.4380@xnncv>
 <CAKXe6SJbJaEepRVFtNy=5fhJrw8+Gax=mcwFuhfXrHTgo+wmog@mail.gmail.com>
 <nycvar.YSQ.7.78.906.2007200752230.4380@xnncv>
 <20200720033304.sttpqr337xsf4rna@mozz.bu.edu>
In-Reply-To: <20200720033304.sttpqr337xsf4rna@mozz.bu.edu>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 20 Jul 2020 19:46:10 +0800
Message-ID: <CAKXe6SKV8=B2rb6EY72W17r6-oz5nx9VQndH9gSyafubOU4rJg@mail.gmail.com>
Subject: Re: [PATCH] net: check payload length limit for all frames
To: Alexander Bulekov <alxndr@bu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x241.google.com
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
Cc: Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, P J P <ppandit@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Alexander Bulekov <alxndr@bu.edu> =E4=BA=8E2020=E5=B9=B47=E6=9C=8820=E6=97=
=A5=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=8811:33=E5=86=99=E9=81=93=EF=BC=9A
>
> On 200720 0754, P J P wrote:
> > +-- On Fri, 17 Jul 2020, Li Qiang wrote --+
> > | P J P <ppandit@redhat.com> =E4=BA=8E2020=E5=B9=B47=E6=9C=8817=E6=97=
=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=885:09=E5=86=99=E9=81=93=EF=BC=9A
> > | > @Alex, would it be possible to share the reproduces on the upstream=
 bug
> > | > LP#1886362?
> > |
> > | Maybe you mean the reproducer of your patch?
> >
> > Yes.
> >
> > | If you or Alex could share it, I'm glad to analysis this issue.
> >
> > @Alex ...?
>
> Happy to share it, as long as it is fine with qemu-security:
> I reduced it further, from the original that I sent:
>
> cat << EOF | ./i386-softmmu/qemu-system-i386 -M pc-q35-5.0 \
> -netdev user,id=3Dqtest-bn0 -device e1000e,netdev=3Dqtest-bn0 \
> -display none -nodefaults -nographic -qtest stdio
> outl 0xcf8 0x80000810
> outl 0xcfc 0xe0000000
> outl 0xcf8 0x80000804
> outw 0xcfc 0x7
> write 0xe0000758 0x4 0xfffff1ff
> write 0xe0000760 0x6 0xffffdf000000
> write 0xe0000768 0x4 0x0efffff1
> write 0xe0005008 0x4 0x18ffff27
> write 0xe0000c 0x1 0x66
> write 0xe03320 0x1 0xff
> write 0xe03620 0x1 0xff
> write 0xe00000f3 0x1 0xdf
> write 0xe0000100 0x6 0xdfffffdf0000
> write 0xe0000110 0x5 0xdfffffdf00
> write 0xe000011a 0x3 0xffffff
> write 0xe0000128 0x5 0x7e00ffffff
> write 0xe0000403 0x1 0xdf
> write 0xe0000420 0x4 0xdfffffdf
> write 0xe000042a 0x3 0xffffff
> write 0xe0000438 0x1 0x7e
> EOF
>
> Here are the ASAN Stacktraces:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D7909=3D=3DERROR: AddressSanitizer: heap-use-after-free on address 0=
x606000032f18 at pc 0x561dd4409b96 bp 0x7ffdfe983030 sp 0x7ffdfe983028
> READ of size 8 at 0x606000032f18 thread T0
>     #0 0x561dd4409b95 in e1000e_write_packet_to_guest /home/alxndr/Develo=
pment/qemu/hw/net/e1000e_core.c:1587:41
>     #1 0x561dd4403fa2 in e1000e_receive_iov /home/alxndr/Development/qemu=
/hw/net/e1000e_core.c:1709:9
>     #2 0x561dd43fd91a in e1000e_nc_receive_iov /home/alxndr/Development/q=
emu/hw/net/e1000e.c:213:12
>     #3 0x561dd43c82e7 in net_tx_pkt_sendv /home/alxndr/Development/qemu/h=
w/net/net_tx_pkt.c:553:9
>     #4 0x561dd43c65e6 in net_tx_pkt_send /home/alxndr/Development/qemu/hw=
/net/net_tx_pkt.c:629:9
>     #5 0x561dd43c9c78 in net_tx_pkt_send_loopback /home/alxndr/Developmen=
t/qemu/hw/net/net_tx_pkt.c:642:11
>     #6 0x561dd4472cf6 in e1000e_tx_pkt_send /home/alxndr/Development/qemu=
/hw/net/e1000e_core.c:664:16
>     #7 0x561dd446f296 in e1000e_process_tx_desc /home/alxndr/Development/=
qemu/hw/net/e1000e_core.c:743:17
>     #8 0x561dd446ce68 in e1000e_start_xmit /home/alxndr/Development/qemu/=
hw/net/e1000e_core.c:934:9
>     #9 0x561dd445635d in e1000e_set_tdt /home/alxndr/Development/qemu/hw/=
net/e1000e_core.c:2451:9
>     #10 0x561dd440f19e in e1000e_core_write /home/alxndr/Development/qemu=
/hw/net/e1000e_core.c:3265:9
>     #11 0x561dd43f77b7 in e1000e_mmio_write /home/alxndr/Development/qemu=
/hw/net/e1000e.c:109:5
>     #12 0x561dd2ff62a3 in memory_region_write_accessor /home/alxndr/Devel=
opment/qemu/softmmu/memory.c:483:5
>     #13 0x561dd2ff5747 in access_with_adjusted_size /home/alxndr/Developm=
ent/qemu/softmmu/memory.c:544:18
>     #14 0x561dd2ff3366 in memory_region_dispatch_write /home/alxndr/Devel=
opment/qemu/softmmu/memory.c:1465:16
>     #15 0x561dd23a5476 in flatview_write_continue /home/alxndr/Developmen=
t/qemu/exec.c:3176:23
>     #16 0x561dd238de86 in flatview_write /home/alxndr/Development/qemu/ex=
ec.c:3216:14
>     #17 0x561dd238d9a7 in address_space_write /home/alxndr/Development/qe=
mu/exec.c:3307:18
>     #18 0x561dd30a43b1 in qtest_process_command /home/alxndr/Development/=
qemu/softmmu/qtest.c:567:9
>     #19 0x561dd3094b38 in qtest_process_inbuf /home/alxndr/Development/qe=
mu/softmmu/qtest.c:710:9
>     #20 0x561dd30937c5 in qtest_read /home/alxndr/Development/qemu/softmm=
u/qtest.c:722:5
>     #21 0x561dd5f33993 in qemu_chr_be_write_impl /home/alxndr/Development=
/qemu/chardev/char.c:188:9
>     #22 0x561dd5f33b17 in qemu_chr_be_write /home/alxndr/Development/qemu=
/chardev/char.c:200:9
>     #23 0x561dd5f47e03 in fd_chr_read /home/alxndr/Development/qemu/chard=
ev/char-fd.c:68:9
>     #24 0x561dd609c1c4 in qio_channel_fd_source_dispatch /home/alxndr/Dev=
elopment/qemu/io/channel-watch.c:84:12
>     #25 0x7f58c0237897 in g_main_context_dispatch (/usr/lib/x86_64-linux-=
gnu/libglib-2.0.so.0+0x4e897)
>     #26 0x561dd6495f2b in glib_pollfds_poll /home/alxndr/Development/qemu=
/util/main-loop.c:217:9
>     #27 0x561dd649365b in os_host_main_loop_wait /home/alxndr/Development=
/qemu/util/main-loop.c:240:5
>     #28 0x561dd6492ff4 in main_loop_wait /home/alxndr/Development/qemu/ut=
il/main-loop.c:516:11
>     #29 0x561dd30b4e00 in qemu_main_loop /home/alxndr/Development/qemu/so=
ftmmu/vl.c:1676:9
>     #30 0x561dd60d3fb1 in main /home/alxndr/Development/qemu/softmmu/main=
.c:49:5
>     #31 0x7f58bedbde0a in __libc_start_main /build/glibc-GwnBeO/glibc-2.3=
0/csu/../csu/libc-start.c:308:16
>     #32 0x561dd2298919 in _start (/home/alxndr/Development/qemu/build-asa=
n/i386-softmmu/qemu-system-i386+0x2b3d919)
>
> 0x606000032f18 is located 24 bytes inside of 64-byte region [0x606000032f=
00,0x606000032f40)
> freed by thread T0 here:
>     #0 0x561dd231108d in free (/home/alxndr/Development/qemu/build-asan/i=
386-softmmu/qemu-system-i386+0x2bb608d)
>     #1 0x561dd43e3129 in net_rx_pkt_iovec_realloc /home/alxndr/Developmen=
t/qemu/hw/net/net_rx_pkt.c:80:9
>     #2 0x561dd43d0666 in net_rx_pkt_pull_data /home/alxndr/Development/qe=
mu/hw/net/net_rx_pkt.c:103:9
>     #3 0x561dd43d2cf6 in net_rx_pkt_attach_iovec_ex /home/alxndr/Developm=
ent/qemu/hw/net/net_rx_pkt.c:158:5
>     #4 0x561dd440360f in e1000e_receive_iov /home/alxndr/Development/qemu=
/hw/net/e1000e_core.c:1695:5
>     #5 0x561dd43fd91a in e1000e_nc_receive_iov /home/alxndr/Development/q=
emu/hw/net/e1000e.c:213:12
>     #6 0x561dd43c82e7 in net_tx_pkt_sendv /home/alxndr/Development/qemu/h=
w/net/net_tx_pkt.c:553:9
>     #7 0x561dd43c65e6 in net_tx_pkt_send /home/alxndr/Development/qemu/hw=
/net/net_tx_pkt.c:629:9
>     #8 0x561dd43c9c78 in net_tx_pkt_send_loopback /home/alxndr/Developmen=
t/qemu/hw/net/net_tx_pkt.c:642:11
>     #9 0x561dd4472cf6 in e1000e_tx_pkt_send /home/alxndr/Development/qemu=
/hw/net/e1000e_core.c:664:16
>     #10 0x561dd446f296 in e1000e_process_tx_desc /home/alxndr/Development=
/qemu/hw/net/e1000e_core.c:743:17
>     #11 0x561dd446ce68 in e1000e_start_xmit /home/alxndr/Development/qemu=
/hw/net/e1000e_core.c:934:9
>     #12 0x561dd4453602 in e1000e_set_tctl /home/alxndr/Development/qemu/h=
w/net/e1000e_core.c:2431:9
>     #13 0x561dd440f19e in e1000e_core_write /home/alxndr/Development/qemu=
/hw/net/e1000e_core.c:3265:9
>     #14 0x561dd43f77b7 in e1000e_mmio_write /home/alxndr/Development/qemu=
/hw/net/e1000e.c:109:5
>     #15 0x561dd2ff62a3 in memory_region_write_accessor /home/alxndr/Devel=
opment/qemu/softmmu/memory.c:483:5
>     #16 0x561dd2ff5747 in access_with_adjusted_size /home/alxndr/Developm=
ent/qemu/softmmu/memory.c:544:18
>     #17 0x561dd2ff3366 in memory_region_dispatch_write /home/alxndr/Devel=
opment/qemu/softmmu/memory.c:1465:16
>     #18 0x561dd23a5476 in flatview_write_continue /home/alxndr/Developmen=
t/qemu/exec.c:3176:23
>     #19 0x561dd238de86 in flatview_write /home/alxndr/Development/qemu/ex=
ec.c:3216:14
>     #20 0x561dd238d9a7 in address_space_write /home/alxndr/Development/qe=
mu/exec.c:3307:18
>     #21 0x561dd238e265 in address_space_rw /home/alxndr/Development/qemu/=
exec.c:3317:16
>     #22 0x561dd442e72e in dma_memory_rw_relaxed /home/alxndr/Development/=
qemu/include/sysemu/dma.h:87:18
>     #23 0x561dd442e053 in dma_memory_rw /home/alxndr/Development/qemu/inc=
lude/sysemu/dma.h:110:12
>     #24 0x561dd442df8f in pci_dma_rw /home/alxndr/Development/qemu/includ=
e/hw/pci/pci.h:790:5
>     #25 0x561dd442c24f in pci_dma_write /home/alxndr/Development/qemu/inc=
lude/hw/pci/pci.h:803:12
>     #26 0x561dd442af8f in e1000e_write_to_rx_buffers /home/alxndr/Develop=
ment/qemu/hw/net/e1000e_core.c:1412:9
>     #27 0x561dd4409a0b in e1000e_write_packet_to_guest /home/alxndr/Devel=
opment/qemu/hw/net/e1000e_core.c:1582:21
>     #28 0x561dd4403fa2 in e1000e_receive_iov /home/alxndr/Development/qem=
u/hw/net/e1000e_core.c:1709:9
>     #29 0x561dd43fd91a in e1000e_nc_receive_iov /home/alxndr/Development/=
qemu/hw/net/e1000e.c:213:12
>

This seems is the same issue as LP#1886362 .
Look at the free path.
Here the 'e1000e_write_to_rx_buffers' trigger DMA and then go to
address space dispatch. So the DMA is not RAM but a MMIO range.
Then we go to another send path, and in that we frees the 'iov'.

Alex do you tried my patch to solve LP#1886362 ?
I have tried it and it seems no this UAF triggered.

Thanks,
Li Qiang


> previously allocated by thread T0 here:
>     #0 0x561dd231130d in malloc (/home/alxndr/Development/qemu/build-asan=
/i386-softmmu/qemu-system-i386+0x2bb630d)
>     #1 0x7f58c023d500 in g_malloc (/usr/lib/x86_64-linux-gnu/libglib-2.0.=
so.0+0x54500)
>     #2 0x561dd43d0666 in net_rx_pkt_pull_data /home/alxndr/Development/qe=
mu/hw/net/net_rx_pkt.c:103:9
>     #3 0x561dd43d2cf6 in net_rx_pkt_attach_iovec_ex /home/alxndr/Developm=
ent/qemu/hw/net/net_rx_pkt.c:158:5
>     #4 0x561dd440360f in e1000e_receive_iov /home/alxndr/Development/qemu=
/hw/net/e1000e_core.c:1695:5
>     #5 0x561dd43fd91a in e1000e_nc_receive_iov /home/alxndr/Development/q=
emu/hw/net/e1000e.c:213:12
>     #6 0x561dd43c82e7 in net_tx_pkt_sendv /home/alxndr/Development/qemu/h=
w/net/net_tx_pkt.c:553:9
>     #7 0x561dd43c65e6 in net_tx_pkt_send /home/alxndr/Development/qemu/hw=
/net/net_tx_pkt.c:629:9
>     #8 0x561dd43c9c78 in net_tx_pkt_send_loopback /home/alxndr/Developmen=
t/qemu/hw/net/net_tx_pkt.c:642:11
>     #9 0x561dd4472cf6 in e1000e_tx_pkt_send /home/alxndr/Development/qemu=
/hw/net/e1000e_core.c:664:16
>     #10 0x561dd446f296 in e1000e_process_tx_desc /home/alxndr/Development=
/qemu/hw/net/e1000e_core.c:743:17
>     #11 0x561dd446ce68 in e1000e_start_xmit /home/alxndr/Development/qemu=
/hw/net/e1000e_core.c:934:9
>     #12 0x561dd445635d in e1000e_set_tdt /home/alxndr/Development/qemu/hw=
/net/e1000e_core.c:2451:9
>     #13 0x561dd440f19e in e1000e_core_write /home/alxndr/Development/qemu=
/hw/net/e1000e_core.c:3265:9
>     #14 0x561dd43f77b7 in e1000e_mmio_write /home/alxndr/Development/qemu=
/hw/net/e1000e.c:109:5
>     #15 0x561dd2ff62a3 in memory_region_write_accessor /home/alxndr/Devel=
opment/qemu/softmmu/memory.c:483:5
>     #16 0x561dd2ff5747 in access_with_adjusted_size /home/alxndr/Developm=
ent/qemu/softmmu/memory.c:544:18
>     #17 0x561dd2ff3366 in memory_region_dispatch_write /home/alxndr/Devel=
opment/qemu/softmmu/memory.c:1465:16
>     #18 0x561dd23a5476 in flatview_write_continue /home/alxndr/Developmen=
t/qemu/exec.c:3176:23
>     #19 0x561dd238de86 in flatview_write /home/alxndr/Development/qemu/ex=
ec.c:3216:14
>     #20 0x561dd238d9a7 in address_space_write /home/alxndr/Development/qe=
mu/exec.c:3307:18
>     #21 0x561dd30a43b1 in qtest_process_command /home/alxndr/Development/=
qemu/softmmu/qtest.c:567:9
>     #22 0x561dd3094b38 in qtest_process_inbuf /home/alxndr/Development/qe=
mu/softmmu/qtest.c:710:9
>     #23 0x561dd30937c5 in qtest_read /home/alxndr/Development/qemu/softmm=
u/qtest.c:722:5
>     #24 0x561dd5f33993 in qemu_chr_be_write_impl /home/alxndr/Development=
/qemu/chardev/char.c:188:9
>     #25 0x561dd5f33b17 in qemu_chr_be_write /home/alxndr/Development/qemu=
/chardev/char.c:200:9
>     #26 0x561dd5f47e03 in fd_chr_read /home/alxndr/Development/qemu/chard=
ev/char-fd.c:68:9
>     #27 0x561dd609c1c4 in qio_channel_fd_source_dispatch /home/alxndr/Dev=
elopment/qemu/io/channel-watch.c:84:12
>     #28 0x7f58c0237897 in g_main_context_dispatch (/usr/lib/x86_64-linux-=
gnu/libglib-2.0.so.0+0x4e897)
>
> Let me know if I can help with anything else!
> -Alex
>
> > Thank you.
> > --
> > Prasad J Pandit / Red Hat Product Security Team
> > 8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D
>

