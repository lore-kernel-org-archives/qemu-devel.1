Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46794C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 16:28:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D55B2076E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 16:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UZ5ZQ1WS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D55B2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRIEU-0001oV-4f
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 12:28:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37016)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1jRIDU-0001GG-7i
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 12:27:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1jRIDS-0002xY-TE
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 12:27:15 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39416
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jRIDS-0002ln-Be
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 12:27:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587572832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8xA1hRT0kEZGcRA8kSIGg9pJZ56ml9qDprqmDfJM8zg=;
 b=UZ5ZQ1WSzcGnBwueuoUKzFhU34tQhyd1AcOb9YaKBINpEzz/KwG5dQyfKzOHS0PAtq6uKc
 6ZbDAIkTf7H0DsvLDFX8nGRj3L3RYyKq01IxvNk3Tdo8LYy0nVRilaIKkgEXkrcuPtCYk1
 cGBtnTnXfYFuPW7kUOCQHPupqdr9EqI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-qiVWtcXkMr-rYZpXoJD6hQ-1; Wed, 22 Apr 2020 12:27:09 -0400
X-MC-Unique: qiVWtcXkMr-rYZpXoJD6hQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D4C213FB;
 Wed, 22 Apr 2020 16:27:08 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-113-154.ams2.redhat.com
 [10.36.113.154])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C22A31000327;
 Wed, 22 Apr 2020 16:27:00 +0000 (UTC)
Subject: Re: [PATCH 2/5] Revert "hw/display/ramfb: lock guest resolution after
 it's set"
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200422100211.30614-1-kraxel@redhat.com>
 <20200422100211.30614-3-kraxel@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <239e23ac-47c6-7be0-b96e-6ef06543516e@redhat.com>
Date: Wed, 22 Apr 2020 18:26:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200422100211.30614-3-kraxel@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 02:57:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, hqm03ster@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/22/20 12:02, Gerd Hoffmann wrote:
> This reverts commit a9e0cb67b7f4c485755659f9b764c38b5f970de4.
> 
> This breaks OVMF.  Reproducer: Just hit 'ESC' at early boot to enter
> firmware setup.  OVMF wants switch from (default) 800x600 to 640x480 for
> that, and this patch blocks it.
> 
> Cc: Hou Qiming <hqm03ster@gmail.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/display/ramfb.c | 26 ++++----------------------
>  1 file changed, 4 insertions(+), 22 deletions(-)

(1) I've verified that, after applying patches #1 and #2 in this series,
the resultant state of "hw/display/ramfb.c" matches the one at
a9e0cb67b7f4^ (note the caret), modulo:

- commit 71e8a9158558 ("Include sysemu/reset.h a lot less", 2019-08-16), and

- commit 85eb7c18ee39 ("Let cpu_[physical]_memory() calls pass a boolean
'is_write' argument", 2020-02-20).

So:

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

(2) I've also tested this patch (i.e., built QEMU with patches #1 and #2
applied -- patch #1 is needed for context --, and entered the OVMF Setup
TUI while using ramfb).

Tested-by: Laszlo Ersek <lersek@redhat.com>

Thanks!
Laszlo

> diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
> index bd4746dc1768..9d41c2ad2868 100644
> --- a/hw/display/ramfb.c
> +++ b/hw/display/ramfb.c
> @@ -31,7 +31,6 @@ struct RAMFBState {
>      DisplaySurface *ds;
>      uint32_t width, height;
>      struct RAMFBCfg cfg;
> -    bool locked;
>  };
>  
>  static void ramfb_unmap_display_surface(pixman_image_t *image, void *unused)
> @@ -72,25 +71,18 @@ static DisplaySurface *ramfb_create_display_surface(int width, int height,
>  static void ramfb_fw_cfg_write(void *dev, off_t offset, size_t len)
>  {
>      RAMFBState *s = dev;
> -    uint32_t fourcc, format, width, height;
> +    uint32_t fourcc, format;
>      hwaddr stride, addr;
>  
> -    width     = be32_to_cpu(s->cfg.width);
> -    height    = be32_to_cpu(s->cfg.height);
> +    s->width  = be32_to_cpu(s->cfg.width);
> +    s->height = be32_to_cpu(s->cfg.height);
>      stride    = be32_to_cpu(s->cfg.stride);
>      fourcc    = be32_to_cpu(s->cfg.fourcc);
>      addr      = be64_to_cpu(s->cfg.addr);
>      format    = qemu_drm_format_to_pixman(fourcc);
>  
>      fprintf(stderr, "%s: %dx%d @ 0x%" PRIx64 "\n", __func__,
> -            width, height, addr);
> -    if (s->locked) {
> -        fprintf(stderr, "%s: resolution locked, change rejected\n", __func__);
> -        return;
> -    }
> -    s->locked = true;
> -    s->width = width;
> -    s->height = height;
> +            s->width, s->height, addr);
>      s->ds = ramfb_create_display_surface(s->width, s->height,
>                                           format, stride, addr);
>  }
> @@ -110,13 +102,6 @@ void ramfb_display_update(QemuConsole *con, RAMFBState *s)
>      dpy_gfx_update_full(con);
>  }
>  
> -static void ramfb_reset(void *opaque)
> -{
> -    RAMFBState *s = (RAMFBState *)opaque;
> -    s->locked = false;
> -    memset(&s->cfg, 0, sizeof(s->cfg));
> -}
> -
>  RAMFBState *ramfb_setup(Error **errp)
>  {
>      FWCfgState *fw_cfg = fw_cfg_find();
> @@ -129,12 +114,9 @@ RAMFBState *ramfb_setup(Error **errp)
>  
>      s = g_new0(RAMFBState, 1);
>  
> -    s->locked = false;
> -
>      rom_add_vga("vgabios-ramfb.bin");
>      fw_cfg_add_file_callback(fw_cfg, "etc/ramfb",
>                               NULL, ramfb_fw_cfg_write, s,
>                               &s->cfg, sizeof(s->cfg), false);
> -    qemu_register_reset(ramfb_reset, s);
>      return s;
>  }
> 


