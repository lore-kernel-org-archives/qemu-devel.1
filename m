Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C6EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 16:43:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A40CA2064B
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 16:43:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A40CA2064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3027-0006gj-RU
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 12:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k2zzy-0002te-1L
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 12:41:10 -0400
Received: from relay64.bu.edu ([128.197.228.104]:45919)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k2zzw-0002X0-7Y
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 12:41:09 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 074GeVsQ027477
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 4 Aug 2020 12:40:35 -0400
Date: Tue, 4 Aug 2020 12:40:31 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v3 4/8] hw/display/artist.c: fix out of bounds check
Message-ID: <20200804164015.sgkv64dnj6pmifo6@mozz.bu.edu>
References: <20200804140056.7690-1-deller@gmx.de>
 <20200804140056.7690-5-deller@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804140056.7690-5-deller@gmx.de>
User-Agent: NeoMutt/20180716
Received-SPF: pass client-ip=128.197.228.104; envelope-from=alxndr@bu.edu;
 helo=relay64.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 12:40:58
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
Cc: peter.maydell@linaro.org, Sven Schnelle <svens@stackframe.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Helge, Sven,
I think this patch introduces an issue:

cat << EOF | ./hppa-softmmu/qemu-system-hppa -m 64 -display none \
-qtest stdio -accel qtest
writeq 0xf810049f 0x7ed7087fffffff0d
writew 0xf8118001 0x30fb
writew 0xf8118000 0x5bfb
writeq 0xf81005fb 0xd8d8d8d83d83d6
EOF

AddressSanitizer:DEADLYSIGNAL
=================================================================
==440==ERROR: AddressSanitizer: SEGV on unknown address 0x7fc4f3c87fff (pc 0x55a0e0ef024f bp 0x7ffcf40a8740 sp 0x7ffcf40a7f00 T0)
==440==The signal is caused by a WRITE memory access.
    #0 0x55a0e0ef024f in vram_bit_write /hw/display/artist.c:397:39
    #1 0x55a0e0ee82ab in artist_reg_write /hw/display/artist.c:886:9
    #2 0x55a0e05dc7a3 in memory_region_write_accessor /softmmu/memory.c:483:5
    #3 0x55a0e05dbadc in access_with_adjusted_size /softmmu/memory.c:539:18
    #4 0x55a0e05d9873 in memory_region_dispatch_write /softmmu/memory.c:1466:16
    #5 0x55a0dfc87056 in flatview_write_continue /exec.c:3176:23
    #6 0x55a0dfc6f866 in flatview_write /exec.c:3216:14
    #7 0x55a0dfc6f387 in address_space_write /exec.c:3308:18
    #8 0x55a0e0683604 in qtest_process_command /softmmu/qtest.c:452:13
    #9 0x55a0e067ac08 in qtest_process_inbuf /softmmu/qtest.c:710:9
    #10 0x55a0e0679895 in qtest_read /softmmu/qtest.c:722:5
    #11 0x55a0e2b35c43 in qemu_chr_be_write_impl /chardev/char.c:188:9
    #12 0x55a0e2b35dc7 in qemu_chr_be_write /chardev/char.c:200:9
    #13 0x55a0e2b4a0b3 in fd_chr_read /chardev/char-fd.c:68:9
    #14 0x55a0e2c9e474 in qio_channel_fd_source_dispatch /io/channel-watch.c:84:12
    #15 0x7fc52b5d3897 in g_main_context_dispatch (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x4e897)
    #16 0x55a0e309637b in glib_pollfds_poll /util/main-loop.c:217:9
    #17 0x55a0e3093aab in os_host_main_loop_wait /util/main-loop.c:240:5
    #18 0x55a0e3093444 in main_loop_wait /util/main-loop.c:516:11
    #19 0x55a0e069bd00 in qemu_main_loop /softmmu/vl.c:1676:9
    #20 0x55a0e2cd6261 in main /softmmu/main.c:49:5
    #21 0x7fc52a159e0a in __libc_start_main /build/glibc-GwnBeO/glibc-2.30/csu/../csu/libc-start.c:308:16
    #22 0x55a0dfb7a729 in _start (/home/alxndr/Development/qemu/general-fuzz/build/hppa-softmmu/qemu-system-hppa+0x22d4729)

AddressSanitizer can not provide additional info.
SUMMARY: AddressSanitizer: SEGV /hw/display/artist.c:397:39 in vram_bit_write
==440==ABORTING

I bisected it to this patch.
Thanks
-Alex

On 200804 1600, Helge Deller wrote:
> From: Sven Schnelle <svens@stackframe.org>
> 
> Fix the following runtime warning with artist framebuffer:
> "write outside bounds: wants 1256x1023, max size 1280x1024"
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>  hw/display/artist.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/display/artist.c b/hw/display/artist.c
> index 6261bfe65b..de56200dbf 100644
> --- a/hw/display/artist.c
> +++ b/hw/display/artist.c
> @@ -340,14 +340,13 @@ static void vram_bit_write(ARTISTState *s, int posx, int posy, bool incr_x,
>  {
>      struct vram_buffer *buf;
>      uint32_t vram_bitmask = s->vram_bitmask;
> -    int mask, i, pix_count, pix_length, offset, height, width;
> +    int mask, i, pix_count, pix_length, offset, width;
>      uint8_t *data8, *p;
> 
>      pix_count = vram_write_pix_per_transfer(s);
>      pix_length = vram_pixel_length(s);
> 
>      buf = vram_write_buffer(s);
> -    height = buf->height;
>      width = buf->width;
> 
>      if (s->cmap_bm_access) {
> @@ -367,13 +366,6 @@ static void vram_bit_write(ARTISTState *s, int posx, int posy, bool incr_x,
>          pix_count = size * 8;
>      }
> 
> -    if (posy * width + posx + pix_count > buf->size) {
> -        qemu_log("write outside bounds: wants %dx%d, max size %dx%d\n",
> -                 posx, posy, width, height);
> -        return;
> -    }
> -
> -
>      switch (pix_length) {
>      case 0:
>          if (s->image_bitmap_op & 0x20000000) {
> @@ -381,8 +373,11 @@ static void vram_bit_write(ARTISTState *s, int posx, int posy, bool incr_x,
>          }
> 
>          for (i = 0; i < pix_count; i++) {
> -            artist_rop8(s, p + offset + pix_count - 1 - i,
> -                        (data & 1) ? (s->plane_mask >> 24) : 0);
> +            uint32_t off = offset + pix_count - 1 - i;
> +            if (off < buf->size) {
> +                artist_rop8(s, p + off,
> +                            (data & 1) ? (s->plane_mask >> 24) : 0);
> +            }
>              data >>= 1;
>          }
>          memory_region_set_dirty(&buf->mr, offset, pix_count);
> @@ -398,7 +393,10 @@ static void vram_bit_write(ARTISTState *s, int posx, int posy, bool incr_x,
>          for (i = 3; i >= 0; i--) {
>              if (!(s->image_bitmap_op & 0x20000000) ||
>                  s->vram_bitmask & (1 << (28 + i))) {
> -                artist_rop8(s, p + offset + 3 - i, data8[ROP8OFF(i)]);
> +                uint32_t off = offset + 3 - i;
> +                if (off < buf->size) {
> +                    artist_rop8(s, p + off, data8[ROP8OFF(i)]);
> +                }
>              }
>          }
>          memory_region_set_dirty(&buf->mr, offset, 3);
> @@ -420,7 +418,7 @@ static void vram_bit_write(ARTISTState *s, int posx, int posy, bool incr_x,
>              break;
>          }
> 
> -        for (i = 0; i < pix_count; i++) {
> +        for (i = 0; i < pix_count && offset + i < buf->size; i++) {
>              mask = 1 << (pix_count - 1 - i);
> 
>              if (!(s->image_bitmap_op & 0x20000000) ||
> --
> 2.21.3
> 
> 

