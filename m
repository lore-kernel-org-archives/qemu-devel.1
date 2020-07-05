Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7624BC433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 18:22:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4181320739
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 18:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aU6SzMrb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4181320739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1js9Hc-0006Cr-Jh
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 14:22:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1js9H5-0005nz-DG
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 14:21:59 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:40058)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1js9H3-0004fI-EC
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 14:21:59 -0400
Received: by mail-ot1-x342.google.com with SMTP id c25so12492299otf.7
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2020 11:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=wv02hObGRF56zCp5oGe0EYsLfIvs4c4RedqIvrRTR9s=;
 b=aU6SzMrbkmZKzbZQfS564zE2Hod4GJy6sqyorDNbTE3hMHbboPajoDYgRZyaLMc79C
 Dy6O/3RKywtY4Q1fVTL35gwuwscpilwmkRoeSbOtxHUyS/5I8WcqQDgl1NSdjbMBCESS
 6cPX9C2tNLFMsm1pJQAvt4QzEVzx02zKCl0mCiK7vaQ17eJWk9tCQIedm4on7IhDzrmj
 3vQscHJFmCLSuUVdOL3jXA+A6Rp0tFgZyfrkkZ2tPvw7jrNNXDesDdQDfKbQuZeBqx2H
 lvGlsHMgCzFkhDn3+lqFZpH0KAg+mVPV04JYejFURrMGE2QZmllT+Z09lQN5k+zjo6y1
 Ou7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=wv02hObGRF56zCp5oGe0EYsLfIvs4c4RedqIvrRTR9s=;
 b=rprstJ8u6xpaZDbAhPXqQocdMw4B+YRphiKfpu/dcNdpuzXFsTT3BFoistZrliQkq9
 2rEhxz84jU0Aq+JxO3AvneRpO8NUtpez3rsP1LuhveVnPFUxsZuxgPqzbkETYe++2md2
 yizdr0R/lAd1iokU/BPo9t1mIsIxh70TUEG03GbtMM7YMgW/9eM/HGY0jfdc++QnLLf8
 WGqMHe4trOlM7mqOnVdN5cnLHtoTrBmDkycwE0vM+YWIyyGcyTZOxz3A7sK8hb867wMg
 Syzj1X4mDWi6GCDYwckSseZ7apc7LkhfuBGGXvSS4Sj7AhJ1epMZlM8jLrVlx8Lr0lMD
 Y1Gg==
X-Gm-Message-State: AOAM531/epxlYUkYB+ur1SENIf0Rbhs2+Ue8rJ2/z8scSglwGsDnIyim
 oS+5KvMvRZ2KgRoB0rMxd4GYCSWV1flieFrRJx6VN6o1kZg=
X-Google-Smtp-Source: ABdhPJwcMAL9qIPfvuc934JIrUGqgMYam8cyMHoBJ7U8PhJDl5utVlIvlbG/DZaZsQL1b4D7Al/Vr6DymPPqALjwdtE=
X-Received: by 2002:a05:6830:10ce:: with SMTP id
 z14mr31111832oto.135.1593973316109; 
 Sun, 05 Jul 2020 11:21:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200703165405.17672-1-peter.maydell@linaro.org>
 <20200703165405.17672-6-peter.maydell@linaro.org>
In-Reply-To: <20200703165405.17672-6-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 5 Jul 2020 19:21:45 +0100
Message-ID: <CAFEAcA9+RE_Fk3XrnqCD5b3HMK8L+RDVyz+BkUd0bGRJQXB-1A@mail.gmail.com>
Subject: Re: [PULL 05/34] virtio-iommu: Implement RESV_MEM probe request
To: QEMU Developers <qemu-devel@nongnu.org>, Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 3 Jul 2020 at 17:54, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> From: Eric Auger <eric.auger@redhat.com>
>
> This patch implements the PROBE request. At the moment,
> only THE RESV_MEM property is handled. The first goal is
> to report iommu wide reserved regions such as the MSI regions
> set by the machine code. On x86 this will be the IOAPIC MSI
> region, [0xFEE00000 - 0xFEEFFFFF], on ARM this may be the ITS
> doorbell.

> @@ -452,6 +524,17 @@ static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
>          case VIRTIO_IOMMU_T_UNMAP:
>              tail.status = virtio_iommu_handle_unmap(s, iov, iov_cnt);
>              break;
> +        case VIRTIO_IOMMU_T_PROBE:
> +        {
> +            struct virtio_iommu_req_tail *ptail;
> +
> +            output_size = s->config.probe_size + sizeof(tail);
> +            buf = g_malloc0(output_size);
> +
> +            ptail = (struct virtio_iommu_req_tail *)
> +                        (buf + s->config.probe_size);
> +            ptail->status = virtio_iommu_handle_probe(s, iov, iov_cnt, buf);
> +        }
>          default:
>              tail.status = VIRTIO_IOMMU_S_UNSUPP;
>          }

Hi Eric -- Coverity points out (CID 1430180) that this new case
has neither a 'break' nor a /* fallthrough */ comment. Which is correct?

thanks
-- PMM

