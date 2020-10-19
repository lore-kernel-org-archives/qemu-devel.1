Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F3FC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 09:46:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EABDD22200
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 09:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DCcsaJ4M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EABDD22200
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kURjz-0004xo-UB
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 05:46:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chirantan@google.com>)
 id 1kURhx-0003eM-Pr
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 05:44:03 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:36962)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chirantan@google.com>)
 id 1kURht-0001lb-Jd
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 05:44:00 -0400
Received: by mail-yb1-xb42.google.com with SMTP id h196so4289329ybg.4
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 02:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IU61rKhjzfPzJqH+1xCGCRSkuJrT8mWWfaH6FNyCnc0=;
 b=DCcsaJ4MCIQoGio0fQNnl4n7RYkGwWk5sLewn/MusDeRJ72731LXKwi1x9XBT/hFT9
 DaX5oSFsB8Ghi6rL6tj+d2qrnWDhZah+uxIlk2stdAMcW3bVGyOOMXPAzCqaCqUAsaWr
 8IHJGw7jwH+T94XWhB1POqy8+I7JaUXlYtzVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IU61rKhjzfPzJqH+1xCGCRSkuJrT8mWWfaH6FNyCnc0=;
 b=nfI2HXSaWtmBUsYAjAbedVThN1SDCNYNF1aUxeCxebH2cKyo2p17tdpeteD3jw3ZvK
 r8h/B+VXY5rKvL2pxI20TmCnaenTZBSJB3cYV+hlKks+L4u+EjxS3v4AsTLBitrGZKMM
 tBGVg2+Y6IhzhDUO8NlaPWUkVJneyW1baEVYsZ7y63K+qGapwvSGBUMCrYsCPvspbpSV
 NxhVg4E5F4Vz05KkrxxNehZEmPjI2Mo9icAPk0YFx5B5lPUpSrA3L6hzFVZ9j8qfuTKD
 aZLHeJsbgy9PBo9GB2Gj6hGkHOYg9YTg0FOqA4q3k1HqMLoS5Qa986B/kzH4nLwhjjYb
 N+hw==
X-Gm-Message-State: AOAM531zWko6lucKru9/5l4Eyz6gzqQmPwgxT/UEEzLORO6vEGsRkxhu
 Z7ZKi4ytTprFaLemftOOx+MkKQOvAxjzNpwszIfaSg==
X-Google-Smtp-Source: ABdhPJzoe4ojhXq+JJ3czyhvlSlz0KEKDqwkzjFeD9gBJPRNIP9RustT3pSmMa1ZUTYy2Mm/pk3xJd+IcTbnbaVBElw=
X-Received: by 2002:a25:ea02:: with SMTP id p2mr20867776ybd.95.1603100631861; 
 Mon, 19 Oct 2020 02:43:51 -0700 (PDT)
MIME-Version: 1.0
References: <20201008085534.16070-1-stefanha@redhat.com>
In-Reply-To: <20201008085534.16070-1-stefanha@redhat.com>
From: Chirantan Ekbote <chirantan@chromium.org>
Date: Mon, 19 Oct 2020 18:43:41 +0900
Message-ID: <CAJFHJrohwGOvZax=anXZdFeuTT+uZAJ89Hu9CohgnE-tJEKTiw@mail.gmail.com>
Subject: Re: [Virtio-fs] [PATCH v3] virtiofsd: add container-friendly -o
 sandbox=chroot option
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b42;
 envelope-from=chirantan@google.com; helo=mail-yb1-xb42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -92
X-Spam_score: -9.3
X-Spam_bar: ---------
X-Spam_report: (-9.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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
Cc: vromanso@redhat.com, qemu-devel@nongnu.org, rmohr@redhat.com,
 virtio-fs-list <virtio-fs@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,
 mpatel@redhat.com, Vivek Goyal <vgoyal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 8, 2020 at 5:55 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> virtiofsd cannot run in a container because CAP_SYS_ADMIN is required to
> create namespaces.
>

In crosvm we deal with this by also creating a user namespace, which
then allows us to create the mount, net, and pid namespaces as well.
Could that also work for virtiofsd?

