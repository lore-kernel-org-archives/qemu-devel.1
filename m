Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62ACCA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 10:43:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FDB72067B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 10:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GG3LZPtH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FDB72067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMV9U-0007kC-O5
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 06:43:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44043)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elohimes@gmail.com>) id 1iMV8P-0006eg-Hl
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 06:41:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elohimes@gmail.com>) id 1iMV8O-0004pU-Dn
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 06:41:57 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:35582)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1iMV8O-0004ou-A1
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 06:41:56 -0400
Received: by mail-qk1-x743.google.com with SMTP id w2so12102934qkf.2
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 03:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7Ew5mIQbvmnx2MM7UhhgiBqdzGxtCSzfiB1uo5sHWmE=;
 b=GG3LZPtHYYG6qEwePvYmR4XAks7Fo2TPcxiejkvCqk6k49eSLZc4T8fepSVQzaifkp
 QijmoZFv0tg+NSLRCxMaACA/oKxCnCbplBM/wC1s/qMtEi4oJkZPilmGuVI9xhQ0tvAg
 UXJM2Do/g3jUaj0r11ZPWLePnasTP/+2jMVIVXHix94fyULBrNaiHdDRG8ld7RzKs0DU
 73XfiBtW3JhRoh0Hb+Cy6UQDAvY4wgVda+CBXEw9gDxK23SlUCFEWUh0JGgVa0t3zjHl
 /faFsorpzD4d3BrgUyWKaQu4uIFWtUr0a1+eGyYEqt9MMA25DGKutfN3NrPzqFFi5z7J
 e24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7Ew5mIQbvmnx2MM7UhhgiBqdzGxtCSzfiB1uo5sHWmE=;
 b=hmQk8zzooOn9WvZ8EvtR+NFTebtLF846eiMBMUYVlvKwsw/T/jDVfuD0Hobd/ZvACK
 8CftiTI5qYnfnyWcY14E6cHzqJP+yqVNLsYJ1Az7yx7CSxGmNuUbfu7JfJFRn8j3PHuP
 sh+epgQTA8xuS+OFOyVw54SK7dXbB+pQrEFXpbFXNOmppW2izdIF5PKimy5scexoG65R
 Zhebunllqq5+S+y2NAqibxK26ByMUE4yGbVQfqHVXCnOHgZqO6/S7FnowSkC8nTzv4eg
 AXMDvbwBZIGiPHCopX9XJ1UaJEe9ZhRFSH2rhUC1Qy8KH6ChDZDsS3A3p/qA25/rkX0/
 Hw5g==
X-Gm-Message-State: APjAAAVtOSdWA5as/gcJAt+AQ05H9HSslhpXhTaoe0JUECZ39aGk3Dn0
 dG8TIoXv0xyCF1D6xgEy7uNgzB5Pkje5uhdlUcg=
X-Google-Smtp-Source: APXvYqzbY+YtL55rLkWQiUAQlohk70dIaBjJK4oocG20+6wq5MC8Hgol2K2CmzQuP2ADrh/iNFbXEgPlFaEeySpuMrM=
X-Received: by 2002:a37:d8e:: with SMTP id 136mr18638914qkn.249.1571654515359; 
 Mon, 21 Oct 2019 03:41:55 -0700 (PDT)
MIME-Version: 1.0
References: <20191017163859.23184-1-felipe@nutanix.com>
 <CAONzpcbR+OjcrfavTnFXVopG-YsTdnFCT=no0eFei4oanfmj1Q@mail.gmail.com>
 <17B5A7A6-F790-4D10-8921-06A83DA18077@nutanix.com>
 <CAONzpcYDDUde0PLVtGYuwGm79RvU-VubXqDs=4F_8yp+-pz-Zg@mail.gmail.com>
 <B53729BD-5A55-4D27-88BE-F8ED2A39D41F@nutanix.com>
 <FF7FC980937D6342B9D289F5F3C7C2625B873307@SHSMSX103.ccr.corp.intel.com>
In-Reply-To: <FF7FC980937D6342B9D289F5F3C7C2625B873307@SHSMSX103.ccr.corp.intel.com>
From: Yongji Xie <elohimes@gmail.com>
Date: Mon, 21 Oct 2019 18:41:44 +0800
Message-ID: <CAONzpcZLm6e4mQa7d_UoKopOcEBQ4awzS5p3AXGJGUqOha-LMw@mail.gmail.com>
Subject: Re: [PATCH] vhost-user-scsi: implement handle_output
To: "Liu, Changpeng" <changpeng.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::743
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Felipe Franciosi <felipe@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 21 Oct 2019 at 16:20, Liu, Changpeng <changpeng.liu@intel.com> wrote:
>
> There is some logic in vhost_user_blk_handle_output() for now, it's not empty as vhost-user-scsi.
> There should be other issue if it can't start from SeaBIOS.
>

No, it's the same issue. We can see the notify is triggered from the
VIRTIO_PCI_CAP_PCI_CFG region in configuration space. And looks like
seabios also support this notify mode:

void vp_init_simple(struct vp_device *vp, struct pci_device *pci)
{
....
vp_cap->mode = (addr > 0xffffffffll) ?
                    VP_ACCESS_PCICFG : VP_ACCESS_MMIO;
....
}

Thanks,
Yongji

