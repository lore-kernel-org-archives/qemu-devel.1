Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515FEC4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 11:22:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C28D923A40
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 11:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wlgBJ955"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C28D923A40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNDiM-0008NX-Gp
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 07:22:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNDPb-0004vZ-Ch
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 07:03:11 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:43115)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNDPZ-0002mZ-8E
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 07:03:11 -0400
Received: by mail-ej1-x641.google.com with SMTP id o8so14353734ejb.10
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 04:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tHKOkpBgqa62L4atJLA/Pt7C+RMCC8T5PQ0jG0HGHrw=;
 b=wlgBJ955Xmf7HInKV1BAVlN6t1G4Vf7l6iKl0+M5VNEbUQ/X6PBUgrNXQLS7YaSZth
 LbCAjyUA8DNnLSyszlt3V5rO0pJpt7FWKnmEzQlwxL+zuX7WRr+s1GQg9IEC/9Y+DnQ6
 nfdyPzl37urLmGYxELnnS6GwYcfIANpffjMngZ1/Q0dfhxfl7YIDDvbIm9DEeBBiqsO3
 M85RthkH7F7lSpIF+53u49PQxfbx5+7msqxmeHNfkNb6i90gJtlTlW58lRZjg6lOxfgT
 mJXe+N7N5soiOrRnYItEPx4Jcls+TVXGaYbVt2Lr3fwucqmWqCJ3J0oE6Y5Ob9ExYmGF
 TMzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tHKOkpBgqa62L4atJLA/Pt7C+RMCC8T5PQ0jG0HGHrw=;
 b=YmnvZdLUUa0sYyfsNq5Iex7vjrymCRhaQRibDK6b2o5wPNAr8HFhoqUQS2Bl1zAiyu
 8G2j/4rx1VEwUBLK5PC9jRoiQH4glBSAWxITAETjkHA/Vbs1RkIXOeX6vqQWU6t9EUVK
 SHJP/gagWibNzNIr72G6xqlfXF3iibOCNHJE1oW0S4gxp8Bm0JbeGNEkNUqXcs/cLFza
 DWS4saM/YRbHC0hzgQY9CxJA8CLMM7v+f8SKQr8KrnZu16gGzc8rwbOCN9SXmmi6z27S
 3MSWSLPfXlxdlPBHyHL77Er9JfQR4YePR2HnKmaHTsQJaT3DXjtZv5Q4v2dk+Qz5oNcK
 n9ew==
X-Gm-Message-State: AOAM5314xO9vD6Avd1K8W0AHM4FhoX449CcHshpLymu5vMKkBmVNAOdF
 Q4yJxWbnaxM7yI8AKkWRQ3J4xDz9IYcmDpwzVESO9Q==
X-Google-Smtp-Source: ABdhPJyEGkJDCI0RhnMdPB0RyWcNPruXDFV2Zl1depNPQbfG1xx/e7gsbxbYkOCRsezSVnxp/JOzVoS9TbYuSMk35HQ=
X-Received: by 2002:a17:907:20d9:: with SMTP id
 qq25mr3100855ejb.382.1601377386760; 
 Tue, 29 Sep 2020 04:03:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200929071948.281157-1-mst@redhat.com>
In-Reply-To: <20200929071948.281157-1-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Sep 2020 12:02:55 +0100
Message-ID: <CAFEAcA9mx0=ysL3r0hRF-GdSX1zuyCAL_i7QdnVTdZp3Mu8pMQ@mail.gmail.com>
Subject: Re: [PULL v4 00/48] virtio,pc,acpi: fixes, tests
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x641.google.com
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

On Tue, 29 Sep 2020 at 08:21, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> Changes from v3:
> - dropped reconnect tests
> - added more fixes, an smbios feature
>
> The following changes since commit 74504514b154ebebdff577d88e4bf5c13074e9ed:
>
>   Merge remote-tracking branch 'remotes/alistair/tags/pull-register-20200927' into staging (2020-09-28 16:49:10 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 8138405528c29af2a850cd672a8f8a0b33b7ab40:
>
>   libvhost-user: return on error in vu_log_queue_fill() (2020-09-29 03:06:12 -0400)
>
> ----------------------------------------------------------------
> virtio,pc,acpi: fixes, tests
>
> Fixes and tests all over the place.
> Batch iommu updates for vdpa.
> Removal of deprecated cpu hotplug commands.
> SMBIOS OEM string support.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

