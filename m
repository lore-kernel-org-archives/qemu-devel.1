Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF8FC31E51
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 11:37:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07F5F2070B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 11:37:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07F5F2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55776 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdCQb-0002HG-Bz
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 07:37:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46583)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hdCOd-0001CP-Ix
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 07:35:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hdCOc-0001Oo-2S
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 07:35:27 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42448)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hdCOb-0001LM-Rk
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 07:35:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id x17so13561736wrl.9
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 04:35:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lS6qvJvzkkQKXebfKpOZWeaymyj1AiU1S8MFIcdf/LM=;
 b=Nc92ToJGqb+NhPe7FpYfmo5xT/ILIVzwG7AiMVmB+qyj7zN2RgPjH81fBPI1y8/dWO
 L+oDr7lZIWQcajUp1VDf5HNoi3jUstUlHFsjELxLRgv+oXXSXJlLstEuAv7pfJ0dtBBf
 4ypJp6K1r7TpDPJ+QCl61EbopxeXVWz1fXJZ34W28p4Va53SEOaeKosX9y3R0WT8iyXc
 wlzd9qXhhzQ6o1tdSNTpHBVRgHNcyoUsYgg2+lWyYvxSR/j0Jj8sY3T4DnOOjFUlVZtS
 VgqOgE2aiNVayxKnZW8R18Ae24jVipUCTxGkIEFIidLTbGaJhgJM7EvfvLbI5lg4Jt9L
 ZTFQ==
X-Gm-Message-State: APjAAAWxIE7M6CExSa6BjrIhAD/puT7oOW78ZNBFYglb+BhprXkAuhYp
 Zt9JpG5a13dkRjsUp/r7gcFJhw==
X-Google-Smtp-Source: APXvYqzVRjSJpYFxNInWulZeE/TIcse4SF6qjM6N0yJVsHcC4Q0fhbVQbn15zeg8IrurLJJBdQAWNw==
X-Received: by 2002:a5d:4841:: with SMTP id n1mr23634326wrs.320.1560857724776; 
 Tue, 18 Jun 2019 04:35:24 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id a64sm2199018wmf.1.2019.06.18.04.35.23
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Jun 2019 04:35:24 -0700 (PDT)
To: Anthony PERARD <anthony.perard@citrix.com>, qemu-devel@nongnu.org
References: <20190618112341.513-1-anthony.perard@citrix.com>
 <20190618112341.513-5-anthony.perard@citrix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <47fc71d2-bb77-4744-b709-41b5d476252b@redhat.com>
Date: Tue, 18 Jun 2019 13:35:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190618112341.513-5-anthony.perard@citrix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v2 4/4] xen: Avoid VLA
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
Cc: xen-devel@lists.xenproject.org, Paul Durrant <paul.durrant@citrix.com>,
 Stefano Stabellini <sstabellini@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/18/19 1:23 PM, Anthony PERARD wrote:
> Avoid using a variable length array.
> 
> We allocate the `dirty_bitmap' buffer only once when we start tracking
> for dirty bits.
> 

Suggested-by: Paul Durrant <Paul.Durrant@citrix.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
> ---
> 
> Notes:
>     v2:
>     - Allocate the bitmap buffer only once when we start tracking dirty bits.
>       (instead of at every function call)
>     
>     Was suggested by Peter here:
>     <CAFEAcA88+A2oCkQnxKDEdpmfCZSmPzWMBg01wDDV68bMZoY5Jg@mail.gmail.com>
>     "should we try to stop using variable length arrays?"
> 
>  hw/i386/xen/xen-hvm.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
> index ae3deb4ef3..469f1260a4 100644
> --- a/hw/i386/xen/xen-hvm.c
> +++ b/hw/i386/xen/xen-hvm.c
> @@ -119,6 +119,8 @@ typedef struct XenIOState {
>      DeviceListener device_listener;
>      hwaddr free_phys_offset;
>      const XenPhysmap *log_for_dirtybit;
> +    /* Buffer used by xen_sync_dirty_bitmap */
> +    unsigned long *dirty_bitmap;
>  
>      Notifier exit;
>      Notifier suspend;
> @@ -464,6 +466,8 @@ static int xen_remove_from_physmap(XenIOState *state,
>      QLIST_REMOVE(physmap, list);
>      if (state->log_for_dirtybit == physmap) {
>          state->log_for_dirtybit = NULL;
> +        g_free(state->dirty_bitmap);
> +        state->dirty_bitmap = NULL;
>      }
>      g_free(physmap);
>  
> @@ -614,7 +618,7 @@ static void xen_sync_dirty_bitmap(XenIOState *state,
>  {
>      hwaddr npages = size >> TARGET_PAGE_BITS;
>      const int width = sizeof(unsigned long) * 8;
> -    unsigned long bitmap[DIV_ROUND_UP(npages, width)];
> +    size_t bitmap_size = DIV_ROUND_UP(npages, width);
>      int rc, i, j;
>      const XenPhysmap *physmap = NULL;
>  
> @@ -626,13 +630,14 @@ static void xen_sync_dirty_bitmap(XenIOState *state,
>  
>      if (state->log_for_dirtybit == NULL) {
>          state->log_for_dirtybit = physmap;
> +        state->dirty_bitmap = g_new(unsigned long, bitmap_size);
>      } else if (state->log_for_dirtybit != physmap) {
>          /* Only one range for dirty bitmap can be tracked. */
>          return;
>      }
>  
>      rc = xen_track_dirty_vram(xen_domid, start_addr >> TARGET_PAGE_BITS,
> -                              npages, bitmap);
> +                              npages, state->dirty_bitmap);
>      if (rc < 0) {
>  #ifndef ENODATA
>  #define ENODATA  ENOENT
> @@ -646,8 +651,8 @@ static void xen_sync_dirty_bitmap(XenIOState *state,
>          return;
>      }
>  
> -    for (i = 0; i < ARRAY_SIZE(bitmap); i++) {
> -        unsigned long map = bitmap[i];
> +    for (i = 0; i < bitmap_size; i++) {
> +        unsigned long map = state->dirty_bitmap[i];
>          while (map != 0) {
>              j = ctzl(map);
>              map &= ~(1ul << j);
> @@ -677,6 +682,8 @@ static void xen_log_stop(MemoryListener *listener, MemoryRegionSection *section,
>  
>      if (old & ~new & (1 << DIRTY_MEMORY_VGA)) {
>          state->log_for_dirtybit = NULL;
> +        g_free(state->dirty_bitmap);
> +        state->dirty_bitmap = NULL;
>          /* Disable dirty bit tracking */
>          xen_track_dirty_vram(xen_domid, 0, 0, NULL);
>      }
> 

