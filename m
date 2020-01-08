Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56653C33C9E
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 11:21:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21C89206F0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 11:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ev4RH5Jn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21C89206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip9Oq-0002Ow-C0
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 06:21:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48592)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stevensd@chromium.org>) id 1ip9OE-0001yw-Sj
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 06:20:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stevensd@chromium.org>) id 1ip9OD-0003F3-Oi
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 06:20:42 -0500
Received: from mail-qv1-xf42.google.com ([2607:f8b0:4864:20::f42]:36509)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stevensd@chromium.org>)
 id 1ip9OD-0003EC-J5
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 06:20:41 -0500
Received: by mail-qv1-xf42.google.com with SMTP id m14so1224450qvl.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 03:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xxgIwr+DRKj1MmNqhPAiOzH9LOv+L8Guy1zzK98nfVc=;
 b=ev4RH5JnknR4vJHlIBRoOHMjLFmGW+2jqCTnmxWdo0jZX0eLIqkWuO/Vmxlj05rA1c
 cVGiijk9DZEvQoIdE7BfDB9snl7nNxGc9GI71JUMlbwGYrLKAPZX5PRDM1y62YnRaMJ1
 h/q7G7CWMILTkpKHZoIjBy2GlrjW+b80YG/Q0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xxgIwr+DRKj1MmNqhPAiOzH9LOv+L8Guy1zzK98nfVc=;
 b=uRcc3Mv/ECiKYYaCp/1cKGLeoJjVEqQ8d+To1M4HCZIM9A2NdPeI3KNeuWSKvq5Yoj
 WlNl2mZ5d9I72U/3Zd/52dYM+ySSwRFcRuHQkhV/z9tYdsJThDYnrUo2sGVV5fEzg0IU
 pw0GE/IlSa3TcADyCajeHgbkg1WYsrZXYSqwSqtPFingHXbOqDl7vgzHmnc1AeyelDA5
 ZQSPlUEnDtGYI0OrtTh1idcy7TyI/uvg1158wHGSYdmB3mKoB/n1Yb6JdoEkEOUL7P91
 OFlNsu+H0EGleC6au1j7KjoMapVQV7UkNQRO9QOthAQJ3u1p6nJO3C1RR2IoZpcLSARP
 k8Bw==
X-Gm-Message-State: APjAAAVbhM9hXuO7qXIb1UxOWO4DRVj5SYhzzHehgCU7Rc0A/7YCrDPh
 iF5/izrPMYWJHbp1HGSnw/aDJ8vy3FBOP/wbX9eZZw==
X-Google-Smtp-Source: APXvYqyc45wpWHTk2TOEdgv6NBR1ueaW9vMFeywp7uP136rJBpd4XC/ZZrKtZJmlHu7FTra9OKY86zzqYbF/8q9hS3U=
X-Received: by 2002:a05:6214:983:: with SMTP id
 dt3mr3618211qvb.145.1578482440626; 
 Wed, 08 Jan 2020 03:20:40 -0800 (PST)
MIME-Version: 1.0
References: <CAD=HUj5U-TxqbPJiRRbyMHON21sht75q3nisvwvKrO+Bf=n8ng@mail.gmail.com>
 <20200108104459.qikjl4n2j5wkwslu@sirius.home.kraxel.org>
In-Reply-To: <20200108104459.qikjl4n2j5wkwslu@sirius.home.kraxel.org>
From: David Stevens <stevensd@chromium.org>
Date: Wed, 8 Jan 2020 20:20:29 +0900
Message-ID: <CAD=HUj7Y9x_cpWvKF-7oK_jcgKXfQxXe-198JbkCA=LyERvA4A@mail.gmail.com>
Subject: Re: [virtio-dev][RFC PATCH v1 2/2] virtio-gpu: add the ability to
 export resources
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f42
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
Cc: virtio-dev@lists.oasis-open.org, Zach Reizner <zachr@chromium.org>,
 Alexandre Courbot <acourbot@chromium.org>, qemu-devel <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, Alex Lau <alexlau@chromium.org>,
 Tomasz Figa <tfiga@chromium.org>, Keiichi Watanabe <keiichiw@chromium.org>,
 =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>,
 Dylan Reid <dgreid@chromium.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Pawel Osciak <posciak@chromium.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> Is there a specific reason why you want the host pick the uuid?  I would
> let the guest define the uuid, i.e. move the uuid fields to
> virtio_gpu_export_resource and scratch virtio_gpu_resp_export_resource.

Sending the uuid in the original request doesn't really buy us
anything, at least in terms of asynchronicity. The guest would still
need to wait for the response to arrive before it could safely pass
the uuid to any other virtio devices, to prevent a race where the
import fails because it is processed before virtio-gpu processes the
export. Perhaps this wouldn't be the case if we supported sharing
fences between virtio devices, but even then, fences are more of a
thing for the operation of a pipeline, not for the setup of a
pipeline.

At that point, I think it's just a matter of aesthetics. I lean
slightly towards returning the uuid from the host, since that rules
out any implementation with the aforementioned race. That being said,
if there are any specific reasons or preferences to assigning the uuid
from the guest, I can switch to that direction.

-David

