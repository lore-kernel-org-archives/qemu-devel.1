Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239C5C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 13:06:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E88FC24970
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 13:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="IUInBYh7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E88FC24970
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX2hW-0002dz-2A
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 09:06:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jX2Yi-0002MT-8k
 for qemu-devel@nongnu.org; Fri, 08 May 2020 08:56:56 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:43008)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jX2Yh-00089g-7h
 for qemu-devel@nongnu.org; Fri, 08 May 2020 08:56:55 -0400
Received: by mail-yb1-xb41.google.com with SMTP id o198so866397ybg.10
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 05:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yawplcW+s6eTVKC/zWKsoN6KA2rF31bdzEEW/HgGGac=;
 b=IUInBYh76Q54mYfArJG3VoyNFXlZ2uUWKhnBJ5ynLRwgyAzPfZ8HiFPeKQp49qwEVh
 vYN5EXqf6wirszmOkD3iCOeaI40Ue9O6f/FihrM5ExbPwr2Pcml1DgjEhRbwSoQhVOkf
 9Mk0AN0/PxB9jBABQiZRIS3tBUUMcnxrI3icYDME79rx5ekJn8c4yxcenhUf3VNnl+QW
 WjOUsEVzne10Wddjb3OAPOnmhYJMOxKGfmjxmiNagDZEa+88L6t6gPWc+wsFXH0PdB0x
 Hyh0A5I3gsNJ/gm5e71JiMfAqzlk8y0vsLjNZz2cVj5equ7y7OC2/x1+btomwbTCCfjf
 6pIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yawplcW+s6eTVKC/zWKsoN6KA2rF31bdzEEW/HgGGac=;
 b=YBXmzr9RZzv4HYdhEX4q6CJ4QXG5Y8kGgETyyvuC/KrLg++Bh3fyJ8znjJrd2TtHos
 rK1J+aCMMfKOfKDBIHfwl/HGtcOo4cU3A3r7sCCdEIkoYvwLhIIJETMUQ/Iu6MryUcCI
 hCDA4RQMt52ln50XW2FZRmpAa1H+yJQ+BcmOn4kbS+bfsRzCE0SUA0JXYbSj5mPx+u5G
 2hLOc0b8sFXsWmwFYP7sTT/i3vgcdeVz/X0k1NAx4ZrtXx3V8eMQZX8gQr7wrJaNP63Z
 fjLwcLRx/91oSeWCPU+/mY5sRYBRHAqe7SsCtnOWtvrk3u79RuRYTKuBXFgaJGegLMSW
 O7Pw==
X-Gm-Message-State: AGi0PuYzbQ7R3qh54CfHQPmk6NmpJJ0shh9h4mwuf2DKbqn9cCB+o7d6
 VC/f/hvLuVIc//cGnsUh7ORsNJvLrqUdinMinwqVJL/0v6g=
X-Google-Smtp-Source: APiQypKxxEd1TGBRwSCDhZNf082yNPNfFXZFbv2vI/UNFGTTUyusYAtHqa1ZGphjjFekvadl2Gga7GrrG1MzCKYMsbA=
X-Received: by 2002:a25:3a03:: with SMTP id h3mr4467883yba.265.1588942613672; 
 Fri, 08 May 2020 05:56:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200508125452.7802-1-yuri.benditovich@daynix.com>
In-Reply-To: <20200508125452.7802-1-yuri.benditovich@daynix.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Fri, 8 May 2020 15:56:41 +0300
Message-ID: <CAOEp5OcvTsw-pqMKoK-5K0NRS_bt7P2MRr_pJiSH0cHNvdp9ww@mail.gmail.com>
Subject: Re: [PATCH 0/7] reference implementation of RSS and hash report
To: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, 
 quintela@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000000e8aea05a5228872"
Received-SPF: none client-ip=2607:f8b0:4864:20::b41;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-yb1-xb41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Yan Vugenfirer <yan@daynix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000000e8aea05a5228872
Content-Type: text/plain; charset="UTF-8"

Please ignore mistaken v7 instead of v8

On Fri, May 8, 2020 at 3:54 PM Yuri Benditovich <yuri.benditovich@daynix.com>
wrote:

> Support for VIRTIO_NET_F_RSS and VIRTIO_NET_F_HASH_REPORT
> features in QEMU for reference purpose.
> Implements Toeplitz hash calculation for incoming
> packets according to configuration provided by driver.
> Uses calculated hash for decision on receive virtqueue
> and/or reports the hash in the virtio header
>
> Changes from v7:
> Patch 7.1: removed (RSS and hash report definitions)
> Patch 7.2: delete configuration struct with RSS definitions
> Patch 7.4: delete duplicated packet structure
> Added patch 7 - adapt RSC definitions to updated header
>
> Yuri Benditovich (7):
>   virtio-net: implement RSS configuration command
>   virtio-net: implement RX RSS processing
>   tap: allow extended virtio header with hash info
>   virtio-net: reference implementation of hash report
>   vmstate.h: provide VMSTATE_VARRAY_UINT16_ALLOC macro
>   virtio-net: add migration support for RSS and hash report
>   virtio-net: align RSC fields with updated virtio-net header
>
>  hw/net/trace-events            |   3 +
>  hw/net/virtio-net.c            | 387 +++++++++++++++++++++++++++++----
>  include/hw/virtio/virtio-net.h |  16 ++
>  include/migration/vmstate.h    |  10 +
>  net/tap.c                      |   3 +-
>  5 files changed, 379 insertions(+), 40 deletions(-)
>
> --
> 2.17.1
>
>

--0000000000000e8aea05a5228872
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Please ignore mistaken v7 instead of v8</div><br><div clas=
s=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, May 8, 2020=
 at 3:54 PM Yuri Benditovich &lt;<a href=3D"mailto:yuri.benditovich@daynix.=
com">yuri.benditovich@daynix.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">Support for VIRTIO_NET_F_RSS and VIRTIO_NE=
T_F_HASH_REPORT<br>
features in QEMU for reference purpose.<br>
Implements Toeplitz hash calculation for incoming<br>
packets according to configuration provided by driver.<br>
Uses calculated hash for decision on receive virtqueue<br>
and/or reports the hash in the virtio header<br>
<br>
Changes from v7:<br>
Patch 7.1: removed (RSS and hash report definitions)<br>
Patch 7.2: delete configuration struct with RSS definitions<br>
Patch 7.4: delete duplicated packet structure<br>
Added patch 7 - adapt RSC definitions to updated header<br>
<br>
Yuri Benditovich (7):<br>
=C2=A0 virtio-net: implement RSS configuration command<br>
=C2=A0 virtio-net: implement RX RSS processing<br>
=C2=A0 tap: allow extended virtio header with hash info<br>
=C2=A0 virtio-net: reference implementation of hash report<br>
=C2=A0 vmstate.h: provide VMSTATE_VARRAY_UINT16_ALLOC macro<br>
=C2=A0 virtio-net: add migration support for RSS and hash report<br>
=C2=A0 virtio-net: align RSC fields with updated virtio-net header<br>
<br>
=C2=A0hw/net/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A03 +<br>
=C2=A0hw/net/virtio-net.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 387 ++=
+++++++++++++++++++++++++++----<br>
=C2=A0include/hw/virtio/virtio-net.h |=C2=A0 16 ++<br>
=C2=A0include/migration/vmstate.h=C2=A0 =C2=A0 |=C2=A0 10 +<br>
=C2=A0net/tap.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A03 +-<br>
=C2=A05 files changed, 379 insertions(+), 40 deletions(-)<br>
<br>
-- <br>
2.17.1<br>
<br>
</blockquote></div>

--0000000000000e8aea05a5228872--

