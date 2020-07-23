Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2D8C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 05:52:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8A33207F5
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 05:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O68o2lEp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8A33207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyU9w-0005cf-1S
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 01:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jyU9N-0005CZ-BQ
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 01:52:13 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:40837)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jyU9L-0002qz-03
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 01:52:13 -0400
Received: by mail-ot1-x344.google.com with SMTP id c25so3549067otf.7
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 22:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=R7eyETZlPv+DUuGqe2AaCJDgastEZOj8ri+OYVVJ/Tw=;
 b=O68o2lEpMXtmj5QPr56fwgyE//XPVj33pemJtEon98WQ3SRcdgoz8kz96iPcNppGNO
 9Ku/5pKrtOiSvHolZverzDdN5/IHYcsQnGrvL1HeODgQEbrBAvg0Q8Wl16nB6Xs431S6
 a3zDjrb2fsfxUFFg9BvGIn5EPKGH4m1WL6kIQDf8X1GUwwqnTCQmSZEtsbzpcXE+bQ79
 VOuOdi8h/7D7QN8TilrIwcmJn30nv0Ia+K/Uqla/zh3MWVHIpBVUpBKVbtR6wMXLauwk
 uhY2J/H5ggrbE4aozRzl61Cs3iNcLa+OlhNzO7f9yXIFwGe9QbsIg+11mpxGlR8QPDfr
 tpZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=R7eyETZlPv+DUuGqe2AaCJDgastEZOj8ri+OYVVJ/Tw=;
 b=QefGAlefkYYVIfOMgo/5Q1JfK1B1OEaUltUWcfCqnFwBtnHcdYfOkARkMPdKa0AcZ1
 64uS6WWRO/rdaScRhN0d9gU7UnpFpziZSafJPtgD6xHS0QHByOfMBPsyASOPCU5tYNVR
 N/NQ6Ec8h2USvqd5qjNy7xHQRimCihcWcg9ITmW2+efzt8n0vvfuBRO05ivzXLMAS3es
 3GkpqWnnqEqJazounIomH2ZkpslcgBKEX6qPsW89d9UOkbZr+YVFAua30HwW9Z2JQRjU
 rkRBeD7/cbsipCQmozK8J8DWaSsxh9MHDN7zyNoU8EGuJM628Ys4Q6CK33mxamzxzmQv
 Bj1A==
X-Gm-Message-State: AOAM531R1sBAcPSX4L6Y9b3yO55SY2sb+Fb8I0Ys5xLmd/cKzIwz/eEy
 I1rbOyTISFS2fIBHhGJ8on6DIMnd7balkL10Cn0=
X-Google-Smtp-Source: ABdhPJzJFDBjfqykMNB4mhBpVW6Hw5fnTHuwj5U8wpybmsUz0ArV7pxcJUzTLS2OB1YW8VHqySvJ83KG73Vc+ElnSMU=
X-Received: by 2002:a9d:787:: with SMTP id 7mr2835019oto.333.1595483529645;
 Wed, 22 Jul 2020 22:52:09 -0700 (PDT)
MIME-Version: 1.0
References: <159548011952.31456.8249433335836304327.malonedeb@chaenomeles.canonical.com>
In-Reply-To: <159548011952.31456.8249433335836304327.malonedeb@chaenomeles.canonical.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 23 Jul 2020 13:51:33 +0800
Message-ID: <CAKXe6SK1=KoP4Vmyo-3pMsE+5BzMYwT-+uvqRY3zgi0qCiuENA@mail.gmail.com>
Subject: Re: [Bug 1888606] [NEW] Heap-use-after-free in
 virtio_gpu_ctrl_response
To: Bug 1888606 <1888606@bugs.launchpad.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x344.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>,
 P J P <ppandit@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Alexander Bulekov <1888606@bugs.launchpad.net> =E4=BA=8E2020=E5=B9=B47=E6=
=9C=8823=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=881:02=E5=86=99=E9=81=
=93=EF=BC=9A
>
> Public bug reported:
>
> Hello,
> Here is a reproducer (build with --enable-sanitizers):
> cat << EOF | ./i386-softmmu/qemu-system-i386 -nographic -M pc -nodefaults=
 -m 512M -device virtio-vga -qtest stdio
> outl 0xcf8 0x80001018
> outl 0xcfc 0xe0800000
> outl 0xcf8 0x80001020
> outl 0xcf8 0x80001004
> outw 0xcfc 0x7
> writeq 0xe0801024 0x10646c00776c6cff
> writeq 0xe080102d 0xe0801000320000
> writeq 0xe0801015 0x12b2901ba000000
> write 0x10646c02 0x1 0x2c
> write 0x999 0x1 0x25
> write 0x8 0x1 0x78
> write 0x2c7 0x1 0x32
> write 0x2cb 0x1 0xff
> write 0x2cc 0x1 0x7e
> writeq 0xe0803000 0xf2b8f0540ff83
> EOF
>
> The ASAN trace:
> =3D=3D29798=3D=3DERROR: AddressSanitizer: heap-use-after-free on address =
0x60d0000050e8 at pc 0x560629814761 bp 0x7ffe916eb1e0 sp 0x7ffe916eb1d8
> READ of size 8 at 0x60d0000050e8 thread T0
>     #0 0x560629814760 in virtio_gpu_ctrl_response /home/alxndr/Developmen=
t/qemu/hw/display/virtio-gpu.c:181:42
>     #1 0x56062981adc8 in virtio_gpu_ctrl_response_nodata /home/alxndr/Dev=
elopment/qemu/hw/display/virtio-gpu.c:193:5
>     #2 0x56062981adc8 in virtio_gpu_simple_process_cmd /home/alxndr/Devel=
opment/qemu/hw/display/virtio-gpu.c:791:9
>     #3 0x5606298175f8 in virtio_gpu_process_cmdq /home/alxndr/Development=
/qemu/hw/display/virtio-gpu.c:820:9
>     #4 0x56062a8f1c96 in aio_bh_poll /home/alxndr/Development/qemu/util/a=
sync.c:164:13
>     #5 0x56062a887b9d in aio_dispatch /home/alxndr/Development/qemu/util/=
aio-posix.c:380:5
>     #6 0x56062a8f6b1c in aio_ctx_dispatch /home/alxndr/Development/qemu/u=
til/async.c:306:5
>     #7 0x7f0d5e1cf9ed in g_main_context_dispatch (/usr/lib/x86_64-linux-g=
nu/libglib-2.0.so.0+0x4e9ed)
>     #8 0x56062a919571 in glib_pollfds_poll /home/alxndr/Development/qemu/=
util/main-loop.c:217:9
>     #9 0x56062a919571 in os_host_main_loop_wait /home/alxndr/Development/=
qemu/util/main-loop.c:240:5
>     #10 0x56062a919571 in main_loop_wait /home/alxndr/Development/qemu/ut=
il/main-loop.c:516:11
>     #11 0x560629094a64 in qemu_main_loop /home/alxndr/Development/qemu/so=
ftmmu/vl.c:1676:9
>     #12 0x56062a749ab5 in main /home/alxndr/Development/qemu/softmmu/main=
.c:49:5
>     #13 0x7f0d5cd55e0a in __libc_start_main (/lib/x86_64-linux-gnu/libc.s=
o.6+0x26e0a)
>     #14 0x5606288ba889 in _start (/home/alxndr/Development/qemu/build/i38=
6-softmmu/qemu-system-i386+0x24d0889)
>
> 0x60d0000050e8 is located 56 bytes inside of 136-byte region [0x60d000005=
0b0,0x60d000005138)
> freed by thread T0 here:
>     #0 0x56062893250d in free (/home/alxndr/Development/qemu/build/i386-s=
oftmmu/qemu-system-i386+0x254850d)
>     #1 0x560629827730 in virtio_gpu_reset /home/alxndr/Development/qemu/h=
w/display/virtio-gpu.c:1160:9
>     #2 0x560628e81d34 in virtio_reset /home/alxndr/Development/qemu/hw/vi=
rtio/virtio.c:1999:9
>     #3 0x560629f08773 in virtio_pci_reset /home/alxndr/Development/qemu/h=
w/virtio/virtio-pci.c:1841:5
>     #4 0x560629043ab6 in memory_region_write_accessor /home/alxndr/Develo=
pment/qemu/softmmu/memory.c:483:5
>     #5 0x560629043473 in access_with_adjusted_size /home/alxndr/Developme=
nt/qemu/softmmu/memory.c:544:18
>     #6 0x560629042c99 in memory_region_dispatch_write /home/alxndr/Develo=
pment/qemu/softmmu/memory.c
>     #7 0x560628990a37 in flatview_write_continue /home/alxndr/Development=
/qemu/exec.c:3176:23
>     #8 0x56062899041a in address_space_write_cached_slow /home/alxndr/Dev=
elopment/qemu/exec.c:3789:12
>     #9 0x560628e6f9bb in vring_used_write /home/alxndr/Development/qemu/h=
w/virtio/virtio.c:347:5
>     #10 0x560628e6f9bb in virtqueue_split_fill /home/alxndr/Development/q=
emu/hw/virtio/virtio.c:788:5
>     #11 0x560628e6f9bb in virtqueue_fill /home/alxndr/Development/qemu/hw=
/virtio/virtio.c:852:9
>     #12 0x560628e7205e in virtqueue_push /home/alxndr/Development/qemu/hw=
/virtio/virtio.c:917:5
>     #13 0x560629814246 in virtio_gpu_ctrl_response /home/alxndr/Developme=
nt/qemu/hw/display/virtio-gpu.c:180:5
>     #14 0x56062981adc8 in virtio_gpu_ctrl_response_nodata /home/alxndr/De=
velopment/qemu/hw/display/virtio-gpu.c:193:5
>     #15 0x56062981adc8 in virtio_gpu_simple_process_cmd /home/alxndr/Deve=
lopment/qemu/hw/display/virtio-gpu.c:791:9
>     #16 0x5606298175f8 in virtio_gpu_process_cmdq /home/alxndr/Developmen=
t/qemu/hw/display/virtio-gpu.c:820:9
>     #17 0x56062a8f1c96 in aio_bh_poll /home/alxndr/Development/qemu/util/=
async.c:164:13
>     #18 0x56062a887b9d in aio_dispatch /home/alxndr/Development/qemu/util=
/aio-posix.c:380:5
>     #19 0x56062a8f6b1c in aio_ctx_dispatch /home/alxndr/Development/qemu/=
util/async.c:306:5
>     #20 0x7f0d5e1cf9ed in g_main_context_dispatch (/usr/lib/x86_64-linux-=
gnu/libglib-2.0.so.0+0x4e9ed)
>

Seems again when we write back to virtio used vring, we write to the
MMIO addresspace.

Thanks,
Li Qiang


> previously allocated by thread T0 here:
>     #0 0x56062893278d in malloc (/home/alxndr/Development/qemu/build/i386=
-softmmu/qemu-system-i386+0x254878d)
>     #1 0x7f0d5e1d5500 in g_malloc (/usr/lib/x86_64-linux-gnu/libglib-2.0.=
so.0+0x54500)
>     #2 0x560628e7844b in virtqueue_split_pop /home/alxndr/Development/qem=
u/hw/virtio/virtio.c:1524:12
>     #3 0x560628e7844b in virtqueue_pop /home/alxndr/Development/qemu/hw/v=
irtio/virtio.c:1693:16
>     #4 0x560629829633 in virtio_gpu_handle_ctrl /home/alxndr/Development/=
qemu/hw/display/virtio-gpu.c:878:15
>     #5 0x560629829633 in virtio_gpu_ctrl_bh /home/alxndr/Development/qemu=
/hw/display/virtio-gpu.c:893:5
>     #6 0x56062a8f1c96 in aio_bh_poll /home/alxndr/Development/qemu/util/a=
sync.c:164:13
>     #7 0x56062a887b9d in aio_dispatch /home/alxndr/Development/qemu/util/=
aio-posix.c:380:5
>     #8 0x56062a8f6b1c in aio_ctx_dispatch /home/alxndr/Development/qemu/u=
til/async.c:306:5
>     #9 0x7f0d5e1cf9ed in g_main_context_dispatch (/usr/lib/x86_64-linux-g=
nu/libglib-2.0.so.0+0x4e9ed)
>
>
> With -trace virtio\* -trace pci\* :
> [I 1595480025.666147] OPENED
> 31900@1595480025.706962:virtio_set_status vdev 0x633000019640 val 0
> 31900@1595480025.710297:virtio_set_status vdev 0x633000019640 val 0
> [R +0.046276] outl 0xcf8 0x80001018
> OK
> [S +0.046313] OK
> [R +0.046332] outl 0xcfc 0xe0800000
> 31900@1595480025.712490:pci_cfg_write virtio-vga 02:0 @0x18 <- 0xe0800000
> OK
> [S +0.046356] OK
> [R +0.046365] outl 0xcf8 0x80001020
> OK
> [S +0.046370] OK
> [R +0.046379] outl 0xcf8 0x80001004
> OK
> [S +0.046383] OK
> [R +0.046391] outw 0xcfc 0x7
> 31900@1595480025.712544:pci_cfg_write virtio-vga 02:0 @0x4 <- 0x7
> 31900@1595480025.712551:pci_update_mappings_add d=3D0x633000000800 00:02.=
0 2,0xe0800000+0x4000
> OK
> [S +0.047572] OK
> [R +0.047597] writeq 0xe0801024 0x10646c00776c6cff
> OK
> [S +0.047610] OK
> [R +0.047619] writeq 0xe080102d 0xe0801000320000
> OK
> [S +0.047627] OK
> [R +0.047636] writeq 0xe0801015 0x12b2901ba000000
> OK
> [S +0.047650] OK
> [R +0.047660] write 0x10646c02 0x1 0x2c
> OK
> [S +0.047769] OK
> [R +0.047782] write 0x999 0x1 0x25
> OK
> [S +0.047907] OK
> [R +0.047920] write 0x8 0x1 0x78
> OK
> [S +0.047927] OK
> [R +0.047935] write 0x2c7 0x1 0x32
> OK
> [S +0.047941] OK
> [R +0.047949] write 0x2cb 0x1 0xff
> OK
> [S +0.047954] OK
> [R +0.047962] write 0x2cc 0x1 0x7e
> OK
> [S +0.047967] OK
> [R +0.047975] writeq 0xe0803000 0xf2b8f0540ff83
> 31900@1595480025.714133:virtio_queue_notify vdev 0x633000019640 n 0 vq 0x=
7fe20b13d800
> OK
> [S +0.047996] OK
> 31900@1595480025.714386:virtio_notify vdev 0x633000019640 vq 0x7fe20b13d8=
00
> 31900@1595480025.714406:virtio_gpu_features virgl 0
> 31900@1595480025.714413:virtio_notify vdev 0x633000019640 vq 0x7fe20b13d8=
00
> 31900@1595480025.714421:virtio_set_status vdev 0x633000019640 val 0
> *CRASH*
>
> Please let me know if I can provide any further info.
> -Alex
>
> ** Affects: qemu
>      Importance: Undecided
>          Status: New
>
> --
> You received this bug notification because you are a member of qemu-
> devel-ml, which is subscribed to QEMU.
> https://bugs.launchpad.net/bugs/1888606
>
> Title:
>   Heap-use-after-free in virtio_gpu_ctrl_response
>
> Status in QEMU:
>   New
>
> Bug description:
>   Hello,
>   Here is a reproducer (build with --enable-sanitizers):
>   cat << EOF | ./i386-softmmu/qemu-system-i386 -nographic -M pc -nodefaul=
ts -m 512M -device virtio-vga -qtest stdio
>   outl 0xcf8 0x80001018
>   outl 0xcfc 0xe0800000
>   outl 0xcf8 0x80001020
>   outl 0xcf8 0x80001004
>   outw 0xcfc 0x7
>   writeq 0xe0801024 0x10646c00776c6cff
>   writeq 0xe080102d 0xe0801000320000
>   writeq 0xe0801015 0x12b2901ba000000
>   write 0x10646c02 0x1 0x2c
>   write 0x999 0x1 0x25
>   write 0x8 0x1 0x78
>   write 0x2c7 0x1 0x32
>   write 0x2cb 0x1 0xff
>   write 0x2cc 0x1 0x7e
>   writeq 0xe0803000 0xf2b8f0540ff83
>   EOF
>
>   The ASAN trace:
>   =3D=3D29798=3D=3DERROR: AddressSanitizer: heap-use-after-free on addres=
s 0x60d0000050e8 at pc 0x560629814761 bp 0x7ffe916eb1e0 sp 0x7ffe916eb1d8
>   READ of size 8 at 0x60d0000050e8 thread T0
>       #0 0x560629814760 in virtio_gpu_ctrl_response /home/alxndr/Developm=
ent/qemu/hw/display/virtio-gpu.c:181:42
>       #1 0x56062981adc8 in virtio_gpu_ctrl_response_nodata /home/alxndr/D=
evelopment/qemu/hw/display/virtio-gpu.c:193:5
>       #2 0x56062981adc8 in virtio_gpu_simple_process_cmd /home/alxndr/Dev=
elopment/qemu/hw/display/virtio-gpu.c:791:9
>       #3 0x5606298175f8 in virtio_gpu_process_cmdq /home/alxndr/Developme=
nt/qemu/hw/display/virtio-gpu.c:820:9
>       #4 0x56062a8f1c96 in aio_bh_poll /home/alxndr/Development/qemu/util=
/async.c:164:13
>       #5 0x56062a887b9d in aio_dispatch /home/alxndr/Development/qemu/uti=
l/aio-posix.c:380:5
>       #6 0x56062a8f6b1c in aio_ctx_dispatch /home/alxndr/Development/qemu=
/util/async.c:306:5
>       #7 0x7f0d5e1cf9ed in g_main_context_dispatch (/usr/lib/x86_64-linux=
-gnu/libglib-2.0.so.0+0x4e9ed)
>       #8 0x56062a919571 in glib_pollfds_poll /home/alxndr/Development/qem=
u/util/main-loop.c:217:9
>       #9 0x56062a919571 in os_host_main_loop_wait /home/alxndr/Developmen=
t/qemu/util/main-loop.c:240:5
>       #10 0x56062a919571 in main_loop_wait /home/alxndr/Development/qemu/=
util/main-loop.c:516:11
>       #11 0x560629094a64 in qemu_main_loop /home/alxndr/Development/qemu/=
softmmu/vl.c:1676:9
>       #12 0x56062a749ab5 in main /home/alxndr/Development/qemu/softmmu/ma=
in.c:49:5
>       #13 0x7f0d5cd55e0a in __libc_start_main (/lib/x86_64-linux-gnu/libc=
.so.6+0x26e0a)
>       #14 0x5606288ba889 in _start (/home/alxndr/Development/qemu/build/i=
386-softmmu/qemu-system-i386+0x24d0889)
>
>   0x60d0000050e8 is located 56 bytes inside of 136-byte region [0x60d0000=
050b0,0x60d000005138)
>   freed by thread T0 here:
>       #0 0x56062893250d in free (/home/alxndr/Development/qemu/build/i386=
-softmmu/qemu-system-i386+0x254850d)
>       #1 0x560629827730 in virtio_gpu_reset /home/alxndr/Development/qemu=
/hw/display/virtio-gpu.c:1160:9
>       #2 0x560628e81d34 in virtio_reset /home/alxndr/Development/qemu/hw/=
virtio/virtio.c:1999:9
>       #3 0x560629f08773 in virtio_pci_reset /home/alxndr/Development/qemu=
/hw/virtio/virtio-pci.c:1841:5
>       #4 0x560629043ab6 in memory_region_write_accessor /home/alxndr/Deve=
lopment/qemu/softmmu/memory.c:483:5
>       #5 0x560629043473 in access_with_adjusted_size /home/alxndr/Develop=
ment/qemu/softmmu/memory.c:544:18
>       #6 0x560629042c99 in memory_region_dispatch_write /home/alxndr/Deve=
lopment/qemu/softmmu/memory.c
>       #7 0x560628990a37 in flatview_write_continue /home/alxndr/Developme=
nt/qemu/exec.c:3176:23
>       #8 0x56062899041a in address_space_write_cached_slow /home/alxndr/D=
evelopment/qemu/exec.c:3789:12
>       #9 0x560628e6f9bb in vring_used_write /home/alxndr/Development/qemu=
/hw/virtio/virtio.c:347:5
>       #10 0x560628e6f9bb in virtqueue_split_fill /home/alxndr/Development=
/qemu/hw/virtio/virtio.c:788:5
>       #11 0x560628e6f9bb in virtqueue_fill /home/alxndr/Development/qemu/=
hw/virtio/virtio.c:852:9
>       #12 0x560628e7205e in virtqueue_push /home/alxndr/Development/qemu/=
hw/virtio/virtio.c:917:5
>       #13 0x560629814246 in virtio_gpu_ctrl_response /home/alxndr/Develop=
ment/qemu/hw/display/virtio-gpu.c:180:5
>       #14 0x56062981adc8 in virtio_gpu_ctrl_response_nodata /home/alxndr/=
Development/qemu/hw/display/virtio-gpu.c:193:5
>       #15 0x56062981adc8 in virtio_gpu_simple_process_cmd /home/alxndr/De=
velopment/qemu/hw/display/virtio-gpu.c:791:9
>       #16 0x5606298175f8 in virtio_gpu_process_cmdq /home/alxndr/Developm=
ent/qemu/hw/display/virtio-gpu.c:820:9
>       #17 0x56062a8f1c96 in aio_bh_poll /home/alxndr/Development/qemu/uti=
l/async.c:164:13
>       #18 0x56062a887b9d in aio_dispatch /home/alxndr/Development/qemu/ut=
il/aio-posix.c:380:5
>       #19 0x56062a8f6b1c in aio_ctx_dispatch /home/alxndr/Development/qem=
u/util/async.c:306:5
>       #20 0x7f0d5e1cf9ed in g_main_context_dispatch (/usr/lib/x86_64-linu=
x-gnu/libglib-2.0.so.0+0x4e9ed)
>
>   previously allocated by thread T0 here:
>       #0 0x56062893278d in malloc (/home/alxndr/Development/qemu/build/i3=
86-softmmu/qemu-system-i386+0x254878d)
>       #1 0x7f0d5e1d5500 in g_malloc (/usr/lib/x86_64-linux-gnu/libglib-2.=
0.so.0+0x54500)
>       #2 0x560628e7844b in virtqueue_split_pop /home/alxndr/Development/q=
emu/hw/virtio/virtio.c:1524:12
>       #3 0x560628e7844b in virtqueue_pop /home/alxndr/Development/qemu/hw=
/virtio/virtio.c:1693:16
>       #4 0x560629829633 in virtio_gpu_handle_ctrl /home/alxndr/Developmen=
t/qemu/hw/display/virtio-gpu.c:878:15
>       #5 0x560629829633 in virtio_gpu_ctrl_bh /home/alxndr/Development/qe=
mu/hw/display/virtio-gpu.c:893:5
>       #6 0x56062a8f1c96 in aio_bh_poll /home/alxndr/Development/qemu/util=
/async.c:164:13
>       #7 0x56062a887b9d in aio_dispatch /home/alxndr/Development/qemu/uti=
l/aio-posix.c:380:5
>       #8 0x56062a8f6b1c in aio_ctx_dispatch /home/alxndr/Development/qemu=
/util/async.c:306:5
>       #9 0x7f0d5e1cf9ed in g_main_context_dispatch (/usr/lib/x86_64-linux=
-gnu/libglib-2.0.so.0+0x4e9ed)
>
>
>   With -trace virtio\* -trace pci\* :
>   [I 1595480025.666147] OPENED
>   31900@1595480025.706962:virtio_set_status vdev 0x633000019640 val 0
>   31900@1595480025.710297:virtio_set_status vdev 0x633000019640 val 0
>   [R +0.046276] outl 0xcf8 0x80001018
>   OK
>   [S +0.046313] OK
>   [R +0.046332] outl 0xcfc 0xe0800000
>   31900@1595480025.712490:pci_cfg_write virtio-vga 02:0 @0x18 <- 0xe08000=
00
>   OK
>   [S +0.046356] OK
>   [R +0.046365] outl 0xcf8 0x80001020
>   OK
>   [S +0.046370] OK
>   [R +0.046379] outl 0xcf8 0x80001004
>   OK
>   [S +0.046383] OK
>   [R +0.046391] outw 0xcfc 0x7
>   31900@1595480025.712544:pci_cfg_write virtio-vga 02:0 @0x4 <- 0x7
>   31900@1595480025.712551:pci_update_mappings_add d=3D0x633000000800 00:0=
2.0 2,0xe0800000+0x4000
>   OK
>   [S +0.047572] OK
>   [R +0.047597] writeq 0xe0801024 0x10646c00776c6cff
>   OK
>   [S +0.047610] OK
>   [R +0.047619] writeq 0xe080102d 0xe0801000320000
>   OK
>   [S +0.047627] OK
>   [R +0.047636] writeq 0xe0801015 0x12b2901ba000000
>   OK
>   [S +0.047650] OK
>   [R +0.047660] write 0x10646c02 0x1 0x2c
>   OK
>   [S +0.047769] OK
>   [R +0.047782] write 0x999 0x1 0x25
>   OK
>   [S +0.047907] OK
>   [R +0.047920] write 0x8 0x1 0x78
>   OK
>   [S +0.047927] OK
>   [R +0.047935] write 0x2c7 0x1 0x32
>   OK
>   [S +0.047941] OK
>   [R +0.047949] write 0x2cb 0x1 0xff
>   OK
>   [S +0.047954] OK
>   [R +0.047962] write 0x2cc 0x1 0x7e
>   OK
>   [S +0.047967] OK
>   [R +0.047975] writeq 0xe0803000 0xf2b8f0540ff83
>   31900@1595480025.714133:virtio_queue_notify vdev 0x633000019640 n 0 vq =
0x7fe20b13d800
>   OK
>   [S +0.047996] OK
>   31900@1595480025.714386:virtio_notify vdev 0x633000019640 vq 0x7fe20b13=
d800
>   31900@1595480025.714406:virtio_gpu_features virgl 0
>   31900@1595480025.714413:virtio_notify vdev 0x633000019640 vq 0x7fe20b13=
d800
>   31900@1595480025.714421:virtio_set_status vdev 0x633000019640 val 0
>   *CRASH*
>
>   Please let me know if I can provide any further info.
>   -Alex
>
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1888606/+subscriptions
>

