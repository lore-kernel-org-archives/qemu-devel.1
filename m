Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4F7C3A59D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 11:33:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7619320851
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 11:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jSjEW9gT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7619320851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzfuZ-0000L5-GB
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 07:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57782)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1hzftY-00089W-B7
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 07:32:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hzftX-0001Li-0B
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 07:32:16 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:42813)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hzftW-0001L2-D2
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 07:32:14 -0400
Received: by mail-ot1-x32e.google.com with SMTP id j7so1321288ota.9
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 04:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=klK5nyDE3cWLKUqOVsCrBBc91IAn/L4KSnqDcZTyyCY=;
 b=jSjEW9gTmyXnXR5XYwOfFyjw0INvNsXScsgtkTIojecu2BZA3OYKZVhnpV3ybsg5gr
 QJMq34x7awYpeX7/HKaXr+oHPu7DDxdLuHrYwBVjKlatenY07wrYsNDDr6kdmjOS+Dld
 XlVV1ipYFsN+wnSzyoIy10CmmYWNJznda5m+I1CGDG7jwuLVWCktoSFYbpCeGWOJYYh9
 OfrZ+JG2RMHL+mzhPS9qdU10pLul+KK3daiMe5tQgCrEJAG8yjeM4W3KDcAXt/T8f9Co
 ZCeca1+bvb37j8y4NkC6kmN54dDQpWXn4nHCgs/dJCy2woAojUL+qZVaJ8QYh+v2LEmq
 oxFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=klK5nyDE3cWLKUqOVsCrBBc91IAn/L4KSnqDcZTyyCY=;
 b=eCLSr9I0S8Of0W5q0jNoJSzpGh8pt4HtqxHRiU7k3yhMUNmnbxerQXkLHbmr8K+1n2
 kodW6wzZvKOh0aeoAfWhbshtZcJesMxKzcbTNxItu4na6qVKOKjovTOVxeU5SBpgfi/G
 +DcmLNwop8UH4YX367FWBVeqSb0WbNrfCZKAsEqOz7veZV9BMfF21wJDYfiXYvdxLR3y
 8PmzovsFNzfwKgGAElx4F3YtRFUrCJPkXEOvVHZVKGhXpNlFKMm0K/uTRoNA/m1E9JOf
 kleWj8jWzggoKYmcj+U1t9JYYFOmvRBNCV6l9IZtfwJHQ1QZ5/CK3SqcufwTM3ikjmZ/
 T6vw==
X-Gm-Message-State: APjAAAUtlSDO2f8F1Zm0u+yUN34x/UIC8UUiQY4ewEhe6vKJ30HvKRx2
 cmERzlAkhZqWHb790AND0rIch0JfOX5nrWOFhF7AYw==
X-Google-Smtp-Source: APXvYqwipU0/ZWdWMOMiaiUaXXFtB2pX3131/X7vg0jP7M+yUV9f1OIrKaP71p8MfMjZasFfUXQDS/XMR/7Ljuu0j2c=
X-Received: by 2002:a9d:4817:: with SMTP id c23mr16507129otf.97.1566214333523; 
 Mon, 19 Aug 2019 04:32:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190816231318.8650-1-jsnow@redhat.com>
In-Reply-To: <20190816231318.8650-1-jsnow@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Aug 2019 12:32:02 +0100
Message-ID: <CAFEAcA8gJg71hqxpbyCvQQPYgE6yzJt8k6XxnJ9+AC8wjt7jDg@mail.gmail.com>
To: John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32e
Subject: Re: [Qemu-devel] [PULL 00/36] Bitmaps patches
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
 qemu-stable <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 17 Aug 2019 at 00:13, John Snow <jsnow@redhat.com> wrote:
>
> The following changes since commit afd760539308a5524accf964107cdb1d54a059e3:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20190816' into staging (2019-08-16 17:21:40 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/jnsnow/qemu.git tags/bitmaps-pull-request
>
> for you to fetch changes up to a5f8a60b3eafd5563af48546d5d126d448e62ac5:
>
>   tests/test-hbitmap: test next_zero and _next_dirty_area after truncate (2019-08-16 18:29:43 -0400)
>
> ----------------------------------------------------------------
> Pull request
>
> Rebase notes:
>
> 011/36:[0003] [FC] 'block/backup: upgrade copy_bitmap to BdrvDirtyBitmap'
> 016/36:[----] [-C] 'iotests: Add virtio-scsi device helper'
> 017/36:[0002] [FC] 'iotests: add test 257 for bitmap-mode backups'
> 030/36:[0011] [FC] 'block/backup: teach TOP to never copy unallocated regions'
> 032/36:[0018] [FC] 'iotests/257: test traditional sync modes'
>
> 11: A new hbitmap call was added late in 4.1, changed to
>     bdrv_dirty_bitmap_next_zero.
> 16: Context-only (self.has_quit is new context in 040)
> 17: Removed 'auto' to follow upstream trends in iotest fashion
> 30: Handled explicitly on-list with R-B from Max.
> 32: Fix capitalization in test, as mentioned on-list.
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

