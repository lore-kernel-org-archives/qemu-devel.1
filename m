Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039DEC4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 16:16:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E038206B7
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 16:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e8QxCqiN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E038206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kahvb-0006WB-2f
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 11:15:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kahuV-0005dg-63
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 11:14:51 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534]:42860)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kahuT-00086V-9P
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 11:14:50 -0500
Received: by mail-ed1-x534.google.com with SMTP id a71so2123788edf.9
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 08:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UB+YfZ2yqpXkxpjLnKrK3kRv1AJefWkxDVEfg7sCu/4=;
 b=e8QxCqiNtLmFaRVHAyJQQuMgOiQamlZvH5Qjzq7RGFWRMSbfas6gcvd9yWXefAYFYq
 TXnLApfyZVNd30yIvuxXrUY3yhJmaooZ1w96lPpQyE2gZdNpouVLOzHmMGdB4hZ+Deak
 0+G6yfCBiqiMPyiRg1uFxMggHuN/dig+lwoRINhakprHhidUVLPlNa/OpHsjm5p+XwIw
 NF7ODpJnmWPnxttlFNd1qUNzzEx9OZMlycwcSD+RDy//GUqpcm0dEh+sDr/2M5m4hFVY
 W/4We3ZQfruy49+NBLxm4FF58/WAkTaXp8TaFZTjZv8UrMQMu8DDBcQMS76xclWi6bfC
 ZoGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UB+YfZ2yqpXkxpjLnKrK3kRv1AJefWkxDVEfg7sCu/4=;
 b=R+vzkSolHQko6E6KPL/69c2/FfEm4HgP2s2cd7xwbdaJJtYnt1n53ZDHZPTTHAndpx
 cqQoxT77XiB+t7RQdhRV7bi7fosxvCePwfV3Wy6JYHpCGPcV9r1TRbjJgS7MYXeJnLpb
 5Ajwj/zrteILMq3vZ2lTks/qTC+fWJa0YQU0FdQqNO+N6h5Us3nF+rKf7b81WVZIPRfG
 iUoe2c83YzRqXhbxfT0M3dM2BeKAnmW3a+3MIRt5Li505236kT3fYB4KQwaW0oqc4qeP
 qvFXzEb7TZYLCoUwT5u61mPI4ljBrCETl8zjIGSPPKKgWSfwU9T/1ybR09Y88UYNlCtQ
 jXlg==
X-Gm-Message-State: AOAM530FrA7ce+w/Ll72rjoo3m1QioYyo6q77Mi/J9Kk8tg+wLTOKZnp
 1e1VXNqpF6tDbjRKGSnw8CjR29VHoSMj7U7ONqOqvA==
X-Google-Smtp-Source: ABdhPJwhX+reW4Tk5x1OHhWHY6caYhRup47CRr465TGlMHmP9ZjNyhk9zaFbCxY2OZbbXMWXokDbdEyOfuPBQ4n/pXc=
X-Received: by 2002:a50:fa92:: with SMTP id w18mr3269320edr.44.1604592887559; 
 Thu, 05 Nov 2020 08:14:47 -0800 (PST)
MIME-Version: 1.0
References: <20201104184040.285057-1-mst@redhat.com>
In-Reply-To: <20201104184040.285057-1-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Nov 2020 16:14:35 +0000
Message-ID: <CAFEAcA9n-YDiRQ2tL-0fMeyHLR39TTsjBRcF9538Ck=HOTknGQ@mail.gmail.com>
Subject: Re: [PULL v3 00/31] pc,pci,vhost,virtio: fixes
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 4 Nov 2020 at 18:41, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> changes from v2:
>     drop patches causing issues on BE
>
> The following changes since commit c7a7a877b716cf14848f1fd5c754d293e2f8d852:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20201102' into staging (2020-11-03 10:38:05 +0000)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 9f6df01d0e128c2df179789b37140d6aeddfcb92:
>
>   contrib/vhost-user-blk: fix get_config() information leak (2020-11-03 16:39:05 -0500)
>
> ----------------------------------------------------------------
> pc,pci,vhost,virtio: fixes
>
> Lots of fixes all over the place.
> virtio-mem and virtio-iommu patches are kind of fixes but
> it seems better to just make them behave sanely than
> try to educate users about the limitations ...
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

