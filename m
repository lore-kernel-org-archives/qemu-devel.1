Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B500C00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 09:03:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBD0C206DA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 09:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OPOpuuPR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBD0C206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip7F1-0003Pf-So
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 04:03:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50655)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stevensd@chromium.org>) id 1ip7E1-0002Lr-6P
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 04:02:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stevensd@chromium.org>) id 1ip7E0-0005nm-2F
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 04:02:01 -0500
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:34326)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stevensd@chromium.org>)
 id 1ip7Dz-0005mr-Ru
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 04:02:00 -0500
Received: by mail-qt1-x841.google.com with SMTP id 5so2210583qtz.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 01:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:from:date:message-id:subject:to;
 bh=WHSYiEZw5wlSC7tUwmcTwZpPtavvDB2Fab3d3t9x1NE=;
 b=OPOpuuPRQW4jTCBDS2skbSJYwdnxsh7R1ASm6+2ERzVa2g1BauUlMddybPbFUl/RV/
 FaL9PoBhjG0B+vWi9/8QfWxIPJFl0R8VLwTyG3EVn99BAN8aBnTf3RQ2ufA+HcL3+Gsi
 OMfyzZVZ6o/5OfRDeaTE7xiMwYYeZRi+oqz6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=WHSYiEZw5wlSC7tUwmcTwZpPtavvDB2Fab3d3t9x1NE=;
 b=LdINOplFtOYWZkdHesHTiT47GMulsY1SKVVRJ7lhqdo47seEK4WVRySx3qr9gQCPsA
 ZGe3RtYaeeNHGLV3f8Ap7qBngnA3goUF1lHNTxE2Vl+7k1scxpY7jJ0Kv0zMADskIXYN
 IhHuY+istN9YEofdb1WRHBoYBZFCsqKB/oiBqe7Hwq9l1QKhUQNEC/QeKBhUnc3B3G0O
 ShH3zeE5CuixViLPteXs1/HzCkeOc/1vZJKQYZSZ5GHMn2PYFGyaVrEZt2C+sN/oheV/
 cptjqNimy2ftSQoasI/WwMYbDLteJ4/6I2XJy246dXicrl8QzTAfVvX9QDXXUmM/aPV+
 0GzA==
X-Gm-Message-State: APjAAAWNaqpZX1Ge8i9/yqDJN2eZa9PFjfHDDUxegmyCnmxJIEx11fDP
 J+nYdConrznSBG1sPab+U+RupfOCpP3iH0uSPcs2eQ==
X-Google-Smtp-Source: APXvYqyBRzVeZYL41+XIKfp/Un2raJtMLZFvgW5CdRGhgYmtwbPbqLeuphryWP5P28vmQPxTxDDUC09sPeeUH1PKQXA=
X-Received: by 2002:ac8:65ce:: with SMTP id t14mr2684487qto.72.1578474118231; 
 Wed, 08 Jan 2020 01:01:58 -0800 (PST)
MIME-Version: 1.0
From: David Stevens <stevensd@chromium.org>
Date: Wed, 8 Jan 2020 18:01:47 +0900
Message-ID: <CAD=HUj5AsJSw0rP8YVa2jmK-aK6R3=OyppwcRh5aJw_i=eP-SQ@mail.gmail.com>
Subject: [virtio-dev][RFC PATCH v1 0/2] Cross-device resource sharing
To: virtio-dev@lists.oasis-open.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Dylan Reid <dgreid@chromium.org>, Tomasz Figa <tfiga@chromium.org>, 
 Zach Reizner <zachr@chromium.org>, Keiichi Watanabe <keiichiw@chromium.org>, 
 Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, 
 =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, 
 Pawel Osciak <posciak@chromium.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, 
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::841
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

This RFC comes from the recent discussion on buffer sharing [1],
specifically about the need to share resources between different
virtio devices. For a concrete use case, this can be used to share
virtio-gpu allocated buffers with the recently proposed virtio video
device [2], without the need to memcpy decoded frames through the
guest.

[1] https://markmail.org/thread/jeh5xjjxvylyrbur
[2] https://markmail.org/thread/yb25fim2dqfuktgf

