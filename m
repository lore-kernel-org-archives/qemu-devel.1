Return-Path: <SRS0=giGJ=6X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84291C28CBC
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 14:13:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AF27206D6
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 14:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UrZjarKg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AF27206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXQEo-0001vv-FT
	for qemu-devel@archiver.kernel.org; Sat, 09 May 2020 10:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saket.sinha89@gmail.com>)
 id 1jXQDG-0000UQ-Bv
 for qemu-devel@nongnu.org; Sat, 09 May 2020 10:12:22 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e]:46651)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <saket.sinha89@gmail.com>)
 id 1jXQDF-0006Lm-Ia
 for qemu-devel@nongnu.org; Sat, 09 May 2020 10:12:22 -0400
Received: by mail-lf1-x12e.google.com with SMTP id g10so3677515lfj.13
 for <qemu-devel@nongnu.org>; Sat, 09 May 2020 07:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=L4QfdJ2hYWz+WObolcEgbMv4ud2U7AXh85HCnB22OCw=;
 b=UrZjarKgASSy+gVT0Mf9pmPT7apq27+ggd5LpgQiE6EmgR9a9DV8w6Ek5AefVDY6qW
 M16nob46ByQjTq5uid9n88RRxXFV9wtWteOlUSFoBZi5hcb+nmyoxYw5c4RHUll6LeQB
 zUN4mKKzj+eZSP1e3OB/jFTae63d+r+OHeAy5XSvgGjKnWq6wMpBkIAwxjrGCh4uxM5F
 JCl7+F+ojJn8uJ+AUYkfN8ga7ncS3oFI9+Aix+hUv3INu4mlF8AMAGAo9EIrn5mdZ2x9
 1VOK/6UGYKpRl8wV+CTJVSR8aJcIIe/s6j84+U5QojXfT1Rw/Ow40ei1rrRoKd5C5nne
 oIMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=L4QfdJ2hYWz+WObolcEgbMv4ud2U7AXh85HCnB22OCw=;
 b=WhAW1cjf2e5P7y3SrxRviG0T/OulRBvuzJjDoZ38VXrcBdRmNlgy0e55mp/Fqrmtzl
 L/k8qzPmOrGoVwoA6qSssFqUFzplVG3Juf+tEm+1+QYBFsMgjpJ9lo1kXX2xHly56R1t
 3xPhKe+Li3crzpVmWF3WVAAtb+C4lr7w6eER+TnUVVVulPqEvNLyTitjrevGDcrAAP+N
 trQMK4Uc70fFpYdLWYJZd8uUq9oFLIETb7bJHIGJIEy6uIHWaTb7MdTx8Ci3YtcVXDGf
 ElJB9rgbpYBtgGBg66Bd7lbIsbNH+CXVJPQCO8GmGDEP/O98ikuUUxnYQVSVa0FWNqQJ
 obFA==
X-Gm-Message-State: AOAM532LRS5r37jdpzNK3ixUHSXXGW7Ei5PUEcGwwK59t/vvq2YifSvc
 kbAgHlnknNEyQopJTPGjYEKZmrAHN0O1BNuXlXs=
X-Google-Smtp-Source: ABdhPJyCo42iP8/ykulkL7yXL3awjoTt63O+Zzyo+j3AgC8kOWPR1aK60veUOHkj9oS67LnerX4/7iKAc2rY4qE4UX0=
X-Received: by 2002:a19:f512:: with SMTP id j18mr5038076lfb.33.1589033539114; 
 Sat, 09 May 2020 07:12:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAK25hWN3kJcW-dcpryFrvZ50t7Y0Z=MZM66-8NMuhwjRpNo2aQ@mail.gmail.com>
 <CAK25hWMj5PyQFZVN5AToHjdySvi6iZ4zjZeUJQR85jNgoeLeAw@mail.gmail.com>
In-Reply-To: <CAK25hWMj5PyQFZVN5AToHjdySvi6iZ4zjZeUJQR85jNgoeLeAw@mail.gmail.com>
From: Saket Sinha <saket.sinha89@gmail.com>
Date: Sat, 9 May 2020 16:11:43 +0200
Message-ID: <CAK25hWOPS1wGORXgtv8hUNu9-mLO+5C_k3Cj=8pnoFWmjuhJdg@mail.gmail.com>
Subject: Fwd: Qemu Support for Virtio Video V4L2 driver
To: Dmitry Sepp <dmitry.sepp@opensynergy.com>,
 Kiran Pawar <Kiran.Pawar@opensynergy.com>, 
 Samiullah Khawaja <samiullah.khawaja@opensynergy.com>, qemu-devel@nongnu.org, 
 virtio-dev@lists.oasis-open.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=saket.sinha89@gmail.com; helo=mail-lf1-x12e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

As suggested on #qemu-devel IRC channel, I am including virtio-dev, Gerd and
Michael to point in the right direction how to move forward with Qemu
support for Virtio Video V4L2 driver
posted in [1].

[1]: https://patchwork.linuxtv.org/patch/61717/

Regards,
Saket Sinha

On Sat, May 9, 2020 at 1:09 AM Saket Sinha <saket.sinha89@gmail.com> wrote:
>
> Hi ,
>
> This is to inquire about Qemu support for Virtio Video V4L2 driver
> posted in [1].
> I am currently not aware of any upstream effort for Qemu reference
> implementation and would like to discuss how to proceed with the same.
>
> [1]: https://patchwork.linuxtv.org/patch/61717/
>
> Regards,
> Saket Sinha

