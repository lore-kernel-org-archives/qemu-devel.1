Return-Path: <SRS0=+z+v=72=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494A4C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 20:08:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AF102074D
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 20:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIGDE0b2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AF102074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkCSC-000518-Aw
	for qemu-devel@archiver.kernel.org; Sat, 13 Jun 2020 16:08:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jkCRb-0004BW-DV
 for qemu-devel@nongnu.org; Sat, 13 Jun 2020 16:07:59 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:44530)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jkCRZ-0002yz-MY
 for qemu-devel@nongnu.org; Sat, 13 Jun 2020 16:07:59 -0400
Received: by mail-io1-xd44.google.com with SMTP id p20so13783845iop.11
 for <qemu-devel@nongnu.org>; Sat, 13 Jun 2020 13:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=F2BgXIBU45wYqE2t0XwliDDK/RR4M7/g3ZNQnxsHaY0=;
 b=VIGDE0b2vpaASoPBo7M5qVJPCQRVy+2mH70D1J8o0ePQVkNovxf8S1Ps1zFFVZWYPI
 PcpFFyQi5ZlMLvGlIINVfrQEynGaN7+2FaZbFUUHjuNqt22bvOQuvCD9vasV4cBOEWas
 cPVHYvbgPD2vmsjnJbuJJX6UQm2AOflQXzbs7k3d6ibEsC+ZZR03d5KfqzPNM8pSo/QU
 syAskuTXp4voaPeMEW1OKJyJJgVCwi+VJAcLwAnt4cunHkNK/k5v0sPLncpUbP03GYKg
 Wo/CvmcemTP3OT7mw5KLJ/CZSqSDtdn2kJW96CZ+raUV9ar0MEqssX20Sq/9u4z5eT5a
 MQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=F2BgXIBU45wYqE2t0XwliDDK/RR4M7/g3ZNQnxsHaY0=;
 b=Qpkq6QKiq2WLmaFxasYrr/bnaHlhiqa3yhcoTteRWEjG0wWRVL4NukK0iVZB7TnPFR
 vvPEMCuXHNY4hCHIV/6DUdjTVwVjtFr7k7R8XVEMXMl9lCSscZVV0XTYVDjQcbNdpTpP
 gXPEga0Fsz3k2n3qojWBdAsL22wHxR1agv75tltHDanV07LhJ9UDAqwZHe++tUp1yjUq
 gF1CdVeW5PfhTag6qL1At8lSDaeJdnCG9ljPEzR8ckrsnbhTyjc3OkNhE5DLvk3czpnE
 jNi4hENutWYCWdKGFBpjCtlS0KgXQpq6vJraCK+gFuStuXc81k+npvdusKFzVQ+ajsSB
 0i8A==
X-Gm-Message-State: AOAM531DGoQaBZWxmP3ESnDVJxi23Vv1p2TK+d/xu4gccUjOU2bp+lQ3
 u2bPph5dLnvehZlaCyWDs8XdmHwc6Hi0N77wHzE=
X-Google-Smtp-Source: ABdhPJwGbX7afssEKzJp+hkCrwVftno5fSDiEzKEKHntLabjH6u2/2D9dxfelaWzSzBfC92pcb0WzyLkuI20EgEdjqs=
X-Received: by 2002:a6b:5f06:: with SMTP id t6mr19426944iob.88.1592078871362; 
 Sat, 13 Jun 2020 13:07:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200527041212.12700.60627.stgit@localhost.localdomain>
 <20200527041414.12700.50293.stgit@localhost.localdomain>
In-Reply-To: <20200527041414.12700.50293.stgit@localhost.localdomain>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sat, 13 Jun 2020 13:07:40 -0700
Message-ID: <CAKgT0UdPC1s0c-wqsNc4x8DeZhtZQVMmLArWQ=Z345Mkof650Q@mail.gmail.com>
Subject: Re: [PATCH v25 QEMU 3/3] virtio-balloon: Replace free page hinting
 references to 'report' with 'hint'
To: David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=alexander.duyck@gmail.com; helo=mail-io1-xd44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 26, 2020 at 9:14 PM Alexander Duyck
<alexander.duyck@gmail.com> wrote:
>
> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>
> In an upcoming patch a feature named Free Page Reporting is about to be
> added. In order to avoid any confusion we should drop the use of the word
> 'report' when referring to Free Page Hinting. So what this patch does is go
> through and replace all instances of 'report' with 'hint" when we are
> referring to free page hinting.
>
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> ---
>  hw/virtio/virtio-balloon.c         |   78 ++++++++++++++++++------------------
>  include/hw/virtio/virtio-balloon.h |   20 +++++----
>  2 files changed, 49 insertions(+), 49 deletions(-)
>
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index 3e2ac1104b5f..dc15409b0bb6 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c

...

> @@ -817,14 +817,14 @@ static int virtio_balloon_post_load_device(void *opaque, int version_id)
>      return 0;
>  }
>
> -static const VMStateDescription vmstate_virtio_balloon_free_page_report = {
> +static const VMStateDescription vmstate_virtio_balloon_free_page_hint = {
>      .name = "virtio-balloon-device/free-page-report",
>      .version_id = 1,
>      .minimum_version_id = 1,
>      .needed = virtio_balloon_free_page_support,
>      .fields = (VMStateField[]) {
> -        VMSTATE_UINT32(free_page_report_cmd_id, VirtIOBalloon),
> -        VMSTATE_UINT32(free_page_report_status, VirtIOBalloon),
> +        VMSTATE_UINT32(free_page_hint_cmd_id, VirtIOBalloon),
> +        VMSTATE_UINT32(free_page_hint_status, VirtIOBalloon),
>          VMSTATE_END_OF_LIST()
>      }
>  };

So I noticed this patch wasn't in the list of patches pulled, but that
is probably for the best since I believe the change above might have
broken migration as VMSTATE_UINT32 does a stringify on the first
parameter.
Any advice on how to address it, or should I just give up on renaming
free_page_report_cmd_id and free_page_report_status?

Looking at this I wonder why we even need to migrate these values? It
seems like if we are completing a migration the cmd_id should always
be "DONE" shouldn't it? It isn't as if we are going to migrate the
hinting from one host to another. We will have to start over which is
essentially the signal that the "DONE" value provides. Same thing for
the status. We shouldn't be able to migrate unless both of these are
already in the "DONE" state so if anything I wonder if we shouldn't
have that as the initial state for the device and just drop the
migration info.

Thanks.

- Alex

