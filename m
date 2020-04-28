Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97204C83002
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 02:17:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D838206D9
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 02:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U4Peu2w3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D838206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTFoN-0007mM-Hf
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 22:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40030)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stevensd@chromium.org>) id 1jTFmr-000742-Ng
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 22:15:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <stevensd@chromium.org>) id 1jTFmj-0006fb-Jh
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 22:15:53 -0400
Received: from mail-qv1-xf36.google.com ([2607:f8b0:4864:20::f36]:40683)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stevensd@chromium.org>)
 id 1jTFmj-0006d2-4a
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 22:15:45 -0400
Received: by mail-qv1-xf36.google.com with SMTP id fb4so9684074qvb.7
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 19:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5qjpfbRytZyeo0NEeT7L64ywSvRr9/JiXyn8JtkVE5g=;
 b=U4Peu2w3y+2zYOTOoHw3XWC+B1oefKr0deto2utH575i/QwhRJLZ4YHWI6JRy2LBVA
 Ws6cyeuIcFw46pmzdkFfrvM8ErCQVa8TcFrp54foK4AqdagD1YGfZzp2bQ7GbXtG+05e
 CKUca7uEm2uKXsl+UxDfa3/hkbYPWPLd6dVb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5qjpfbRytZyeo0NEeT7L64ywSvRr9/JiXyn8JtkVE5g=;
 b=Vk18m3Ww1Z0+dHnf7/K7oczg0lj+KiCHJjPYOAV0C5hlth/kZLy9j1h9geb878TpIG
 B3BvXlMDJo/MY1ukOXOFnLLSz3SZ7PPefv7I0NY7ugJ24563VAz9y9OR6gkeZ0Oj1U2M
 3CI8JZpOhHsA7mf0T+kyVTYJT5gYwudC0P4f84zrOQj6OJae/oXePwScMmFuIhcT5nPs
 DXH0yN0x+JGMz0t57f4Dx+wwt26+hm92dZcoYQRwL1dMpvy9jYn5vFAKtf6lMoCBdJKd
 d8iintjIB3xZvP4FgYEWIGEMKf3ED33Ftyzc7jgv7oogPoA5qYLBQv1sE8r2FLuk4QoQ
 GbLw==
X-Gm-Message-State: AGi0PuYuQt6ukMbo/7fpgkuNJzWLbf3neBALK69jpa6ZLwDXmI4ajNP/
 g8DnsrwQeuoU77UNTenoyOLWw78ty5grKQhKCX90+A==
X-Google-Smtp-Source: APiQypI11PrfSdZV+AHi0vP5wMOtWWuPtxdnUDT7N+gy4iwKkfuUSHYvgLSde6jmWMAR3cyhI5lOBrMJqr8uUs4lYTw=
X-Received: by 2002:ad4:45ae:: with SMTP id y14mr26110317qvu.145.1588040141593; 
 Mon, 27 Apr 2020 19:15:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200319021823.57219-1-stevensd@chromium.org>
 <20200320064143.4b2kyskr5clxsczs@sirius.home.kraxel.org>
In-Reply-To: <20200320064143.4b2kyskr5clxsczs@sirius.home.kraxel.org>
From: David Stevens <stevensd@chromium.org>
Date: Tue, 28 Apr 2020 11:15:30 +0900
Message-ID: <CAD=HUj4xUzNw67R233XM3ruaG2cqxF9nWv0xDgML27-CxwuHoQ@mail.gmail.com>
Subject: [virtio-comment] Request vote for the patch: Cross-device resource
 sharing
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f36;
 envelope-from=stevensd@chromium.org; helo=mail-qv1-xf36.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::f36
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
Cc: Zach Reizner <zachr@chromium.org>,
 Alexandre Courbot <acourbot@chromium.org>, qemu-devel <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, Alex Lau <alexlau@chromium.org>,
 Tomasz Figa <tfiga@chromium.org>, Keiichi Watanabe <keiichiw@chromium.org>,
 virtio-comment@lists.oasis-open.org,
 =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>,
 Dylan Reid <dgreid@chromium.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Pawel Osciak <posciak@chromium.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Request for a vote.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/76

Thanks,
David

On Fri, Mar 20, 2020 at 3:41 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Thu, Mar 19, 2020 at 11:18:21AM +0900, David Stevens wrote:
> > Hi all,
> >
> > This is the next iteration of patches for adding support for sharing
> > resources between different virtio devices. The corresponding Linux
> > implementation is [1].
> >
> > In addition to these patches, the most recent virtio-video patchset
> > includes a patch for importing objects into that device [2].
>
> Looks good to me.
>
> So, open a github issue to kick the TC vote process and get this merged?
> (see virtio-spec/.github/PULL_REQUEST_TEMPLATE.md).
>
> cheers,
>   Gerd
>

