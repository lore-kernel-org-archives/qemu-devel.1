Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F89C3F2C4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 22:26:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C888B24697
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 22:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpUENfL2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C888B24697
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7Rbx-0002Kh-U5
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 17:26:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52625)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanrin@gmail.com>) id 1j7RbM-0001rT-3F
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 17:25:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanrin@gmail.com>) id 1j7RbL-0004Vm-4S
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 17:25:52 -0500
Received: from mail-il1-x136.google.com ([2607:f8b0:4864:20::136]:37104)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanrin@gmail.com>)
 id 1j7RbI-0004TQ-Mu; Thu, 27 Feb 2020 17:25:48 -0500
Received: by mail-il1-x136.google.com with SMTP id a6so1034302ilc.4;
 Thu, 27 Feb 2020 14:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=og8/PzNpkNq+rWPuX7MbGq1KP2aUdViTqHVHcST3FdQ=;
 b=GpUENfL2ycFGGl+wi6BxOCQOnqtH9QSzPMzTatFkAuHbr8Gu+ZZDiHp9TjBbBWmRtE
 fQVrHckMMx9qEpfXY/3Jl27ZWUs5JYoagLsnZC2o6mF8Q6CSnTamLUuI7oigOLfLTfA5
 Mep2r/FIkqMh9o+8/HvUeNzHVX2p35BqQCcOo1PTGhfQOCr6eak0zWHm47vs4cj9k5kR
 lNJyAEDoZD8RdgfWG3n+NOPRPM2CiRhPfa2yQkswEWGb1GdxT+v8YUaBz9ctx88U9JRP
 kXhEVwN9AMqXYf9OOz2y2FVq5l7O3dnlY20zj7oVIrP2evpzo4VJfKnjYOC1N0ZevKvP
 ieYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=og8/PzNpkNq+rWPuX7MbGq1KP2aUdViTqHVHcST3FdQ=;
 b=Eqj9tArbkUcXpTmYM6iZZJFix5ai23L8FeLm7PNmodaL6GbOohl8SvOln1pO2gOKQx
 uuv7/SH3Hj6CTUwE/pIYboBMT2av26Qhm4+K8jHhGNgxA1S+IKo+cIOjZ+RcklMaUCou
 2T+9MbyMeuk/6Ze7I57q447KrHFbahvy+eSaX+tqqoV3OrpI0unwSFPWhCU7JS+zIUg7
 ugdVEn+DwhAzKdVvNDf7s46UBH4fdMekg68qScENhLXGriD2KPOQ+d4/YD2mQJkuDtUq
 s/KKFHMewGQ6SLOMwhhSznzjY3zTXQgwZhnOHg7Bqiaa0VQDWQYPtNkeyBJJlG2D1dHh
 JNjw==
X-Gm-Message-State: APjAAAUocdmR6lXPopX0feFUtQvp8ZyA9QjCRT9Q9As5H/lCWCoUZf61
 /ZcQC2BTNUtMHW/CpF6gtc8iQCW/ll3Bwurmkq5+AvCi
X-Google-Smtp-Source: APXvYqyRKzTFQwTZcZfYRTHcrqcQtTtOc0d10RgMT98xm4xwtQRqLy/GrMak3mjn6fOZvNdUqZI5lanu0sckMTM+Uxs=
X-Received: by 2002:a92:9507:: with SMTP id y7mr1392134ilh.243.1582842347523; 
 Thu, 27 Feb 2020 14:25:47 -0800 (PST)
MIME-Version: 1.0
References: <CAAxjCEzHQz4cG_8m7S6=CwCBoN5daQs+KVyuU5GL5Tq3Bky1NA@mail.gmail.com>
 <CAAxjCEx79Fkjw9tFbSMo+b1LGv2LNivLRXf1GS9JsYnXrNVVkQ@mail.gmail.com>
 <CAAxjCEwv61e87ZUz-jueL9AkzaNbY3pRoFmf2dah-p9W8nosWA@mail.gmail.com>
 <CAAxjCEx__TsY75b0iecG1a_wUO2MF2UMVP50nFHQi2Ouyu0znw@mail.gmail.com>
In-Reply-To: <CAAxjCEx__TsY75b0iecG1a_wUO2MF2UMVP50nFHQi2Ouyu0znw@mail.gmail.com>
From: Stefan Ring <stefanrin@gmail.com>
Date: Thu, 27 Feb 2020 23:25:36 +0100
Message-ID: <CAAxjCExb8GKP0Y8hwEbv=DETfu1dG3++umYV0n8vX6kxuJW3pQ@mail.gmail.com>
Subject: Re: Strange data corruption issue with gluster (libgfapi) and ZFS
To: qemu-block@nongnu.org, qemu-devel@nongnu.org, integration@gluster.org
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::136
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

On Thu, Feb 27, 2020 at 10:12 PM Stefan Ring <stefanrin@gmail.com> wrote:
> Victory! I have a reproducer in the form of a plain C libgfapi client.
>
> However, I have not been able to trigger corruption by just executing
> the simple pattern in an artificial way. Currently, I need to feed my
> reproducer 2 GB of data that I streamed out of the qemu block driver.
> I get two possible end states out of my reproducer: The correct one or
> a corrupted one, where 48 KB are zeroed out. It takes no more than 10
> runs to get each of them at least once. The corrupted end state is
> exactly the same that I got from the real qemu process from where I
> obtained the streamed trace. This gives me a lot of confidence in the
> soundness of my reproducer.
>
> More details will follow.

Ok, so the exact sequence of activity around the corruption is this:

8700 and so on are the sequential request numbers. All of these
requests are writes. Blocks are 512 bytes.

8700
  grows the file to a certain size (2134144 blocks)

<8700 retires, nothing in flight>

8701
  writes 55 blocks inside currently allocated file range, close to the
end (7 blocks short)

8702
  writes 54 blocks from the end of 8701, growing the file by 47 blocks

<8702 retires, 8701 remains in flight>

8703
  writes from the end of 8702, growing the file by 81 blocks

<8703 retires, 8701 remains in flight>

8704
  writes 1623 blocks also from the end of 8702, growing the file by 1542 blocks

<8701 retires>
<8704 retires>

The exact range covered by 8703 ends up zeroed out.

If 8701 retires earlier (before 8702 is issued), everything is fine.

