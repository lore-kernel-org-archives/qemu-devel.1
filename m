Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9B0C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 16:16:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA8A820792
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 16:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dt8hLf2v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA8A820792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0SH1-00085p-5B
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 12:16:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0SFs-0007EH-Pk
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 12:15:04 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:41969)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0SFr-0001MZ-1d
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 12:15:04 -0400
Received: by mail-ot1-x343.google.com with SMTP id a65so6112611otc.8
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 09:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YKuV9mT4W6LVxvir/cBkccFXpVVJTl97kX7s4byRvnk=;
 b=Dt8hLf2v6jNQwE7OcabwIOfZqrnemU5/dKabTbfz34VkH8y4of0ZUsoiy7uHu5yLPe
 TDObSMGWwAwFLfLEGabOyRMuwfLwXRZa9oRJwzINO9K6O9JUbEdxKzjYnlUSBZhIE09J
 7v2dLZjr7q+qvXqh1abbzK/eN+/sQE8Y5CgWhXGGMIzslj24WTrY2X8i3IbYQfXvaDhy
 wtxT3eEUYPgG5PiIdsOV820rjnE343dKdUOOlerYfcr5Ms9uhqVrycGwIz0qc4sAoauO
 2Tq7m3ZoexYS+2yHZqm2IfRQQtX3qeqId93F7fqRcIpe1teFqEV5mSDLP4Q5A2HOHzFK
 UW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YKuV9mT4W6LVxvir/cBkccFXpVVJTl97kX7s4byRvnk=;
 b=YSrqQ8s4KcubRw/v0U6b6xE61Q1x3sXRMTLRq+aMEyeyYvf4NfNf+1hDyfiLRXWrJe
 OjQ5AXMfKJx8dSxKbXHiSbfLyr5i3uFUoICnm5rNDH2S875Ye9Yprlb2gJFNpbkfnyWk
 3TKZuElv30GTslKZ+lg7orcUc98flz6pCOZMv+7V0kv8ZCh4QHFFO+Uaz99StZZYxL/h
 jTel+abaCo2kXZE/SyUqS9cCvG8FJy5jra96UYM/wFpT2sRIF5Doe3Li4trqtp9nbakS
 71uYM3y3M2nGVmmr32IKUWsw/iTMPltGRjL5Hrez50/VTcklvGDRnZRBIgs6IdBR/0FF
 0bWA==
X-Gm-Message-State: AOAM533ezIntZVIrdpVYznGeXn17sMdAOd1HEYTUPZOo8Zt46plN6QCk
 1G2AoL07a62ltYUJAWyFmojZUBk9yR6W0lKqhrLFqQ==
X-Google-Smtp-Source: ABdhPJy8ezAat9cCKmtpWItkz+Vz0p7uXrSt8wbjoD4y47bcUQKt6TEmgmyip1YnqOppozDKSLxJaBx7nbpbcPtYYcs=
X-Received: by 2002:a05:6830:1bd3:: with SMTP id
 v19mr24926834ota.91.1595952901625; 
 Tue, 28 Jul 2020 09:15:01 -0700 (PDT)
MIME-Version: 1.0
References: <1595927419-27346-1-git-send-email-jasowang@redhat.com>
In-Reply-To: <1595927419-27346-1-git-send-email-jasowang@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2020 17:14:50 +0100
Message-ID: <CAFEAcA-AJ62Uq+JYkPSR8b=BASxGrEoAcWtne6+01Z8NimJrSA@mail.gmail.com>
Subject: Re: [PULL V2 0/3] Net patches
To: Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
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

On Tue, 28 Jul 2020 at 10:10, Jason Wang <jasowang@redhat.com> wrote:
>
> The following changes since commit 93ea484375ab473379dd9c836261ef484bd71ab1:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2020-07-27 21:00:01 +0100)
>
> are available in the git repository at:
>
>   https://github.com/jasowang/qemu.git tags/net-pull-request
>
> for you to fetch changes up to 22dc8663d9fc7baa22100544c600b6285a63c7a3:
>
>   net: forbid the reentrant RX (2020-07-28 16:57:58 +0800)
>
> ----------------------------------------------------------------
> Want to send earlier but most patches just come.
>
> - fix vhost-vdpa issues when no peer
> - fix virtio-pci queue enabling index value
> - forbid reentrant RX
>
> Changes from V1:
>
> - drop the patch that has been merged
>
> ----------------------------------------------------------------
> Jason Wang (2):
>       virtio-net: check the existence of peer before accessing vDPA config
>       net: forbid the reentrant RX
>
> Yuri Benditovich (1):
>       virtio-pci: fix wrong index in virtio_pci_queue_enabled


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

