Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C44C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 15:57:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70F6920720
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 15:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rbAtQmgY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70F6920720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxudm-0002Mf-Ox
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 11:57:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxudE-0001x0-Hj
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 11:56:40 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:37812)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxudB-0002cw-SA
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 11:56:40 -0400
Received: by mail-oi1-x234.google.com with SMTP id 12so17631677oir.4
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 08:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=9WHJOR4K/wLw2zEE2mWrWVFrH6DLnOht1WDiRE/PK2s=;
 b=rbAtQmgYIWfJl5j0r7maT6iN6XpENyluNDQ7pLDdogcT6m9Lm/JHayDC86n/W30Poe
 XTKSBLyZSoo6pj0XBatAp+NwIG17TQCK7jj6YKO+ceNk7ENHqVztkSW+AvkNsLAjW7NY
 Sr0wPaPZmvRt4TME0qrJ0XIampywi4cOiW6ZhCOZ0YafUFPAVTfYx7+lm0U0lbN2SfQB
 wSi6K+ySZXk4LWvMLss99ZJ+6Iv5q1H3yghwky674BFIRSPQZNQew47U+vwaYl/aKAoW
 jNUiUPY3+J/i8XqJJeoAKrRcrcvc/fMhmH5Od79KCusfzpe+HfOwfhFuNd8JXeGOJi4k
 74ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=9WHJOR4K/wLw2zEE2mWrWVFrH6DLnOht1WDiRE/PK2s=;
 b=D2bf3npGEYp8+It1c55dAmQexieZINOFl+0/2fpnU5oK79qzBgSop2KghMl8BVN2Sq
 XMeQsuAFedZ5MGxWpd2Nvh+faf0Fx7mB0q2I71CRGdJc3Y+lz3jMisxAlNBEULE7EvtG
 rNCEUAb917WmQtYN29QwritesWDVBwa2WjF3FohTIuNCb0SqEy7M2mYApj2PkENIAZop
 H5J/x6Yexb5II6tM271b5I0icvJIA4EYJuVCadhoOFqXXmBOYMEv8A9Nh9Iw/ekj9c+K
 1x4gegDPC52vQJaVqP2BuxP/gas0eXYULNHvLTMfY+5IqrVZ6ZzNbOg1cEXFhfLlfBdg
 4QHg==
X-Gm-Message-State: AOAM531oPKgT6nnaXZxG6ZOFVb4v0cCklkDVAxKByEDGBTQ/2F7O5Uky
 j0xG5A6uNmyhoz3unwczgb1NFa8NZb2z71W3fqqykrqD
X-Google-Smtp-Source: ABdhPJysoq0J26GSIoY9Fh/VeduvR52Y5j6La17M7V7gIqBMenGeX0n3+0FhqTCdOCZ71M2n77p8Q2CehPq5loBI0XQ=
X-Received: by 2002:aca:1706:: with SMTP id j6mr3434460oii.146.1595346996399; 
 Tue, 21 Jul 2020 08:56:36 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Jul 2020 16:56:25 +0100
Message-ID: <CAFEAcA9+9ZQY2CxZ9V4bZrkAGR5eUapbwSk6sNyFGyyd39Y=1Q@mail.gmail.com>
Subject: please try to avoid sending pullreqs late on release-candidate day
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x234.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It is not helpful if everybody sends their pullrequests late
on the Tuesday afternoon, as there just isn't enough time in the
day to merge test and apply them all before I have to cut the tag.
Please, if you can, try to send pullrequests earlier, eg Monday.

thanks
-- PMM

