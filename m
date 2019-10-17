Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972D7FA3736
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:02:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70B9B20640
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:02:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70B9B20640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL5QP-0007bT-Mk
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 09:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59337)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mszeredi@redhat.com>) id 1iL5P8-0007C4-Gt
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:01:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mszeredi@redhat.com>) id 1iL5P7-0007I2-HM
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:01:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34718)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mszeredi@redhat.com>) id 1iL5P7-0007Hi-CD
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:01:21 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9398310F15
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 13:01:20 +0000 (UTC)
Received: by mail-io1-f70.google.com with SMTP id x13so3019392ioa.18
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:01:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zDw1M3KLzlJuy9gbpF+6dsUU1T17+FSCB9ygr/h9leM=;
 b=MAS3jcA3H7LC0qAfsY0QYX2d9r54rq1UVR7IJwOlvw490JfaQR/gSSwWVq+fyU0Rz7
 wrBoDNoNVSCNtogZcNzjYfo8jGmOZoTdIxN/6XHL+bhtwZ+hSu8beE2iiXlon9MM+7xg
 WIWo7zN5uHT29orghHGxN1efXzjDoc1/YFPRB7gUx2po4y0CHp5eiA3o31U/R1L62x3E
 G5HkBxE/+yv23kaqW0fMY/Mih6jTbF9mALG6FlkSge9EDJ9BNnuzQJppR8HpFKmOPyT5
 c5Z0dMlXVBoAUDYUhrvmMKHXtDemGSvgbPqVaGxEYAeBBObFe0czGZ5+k3yAV2StqMk1
 gV8Q==
X-Gm-Message-State: APjAAAXRUYjljpI7VIdvIaTLvyeEOXrYV0FINv02UTQDWA2HJw6DzrUk
 uDS5xYmuyWQmkMt2JDEH5pgqHy38e79no7H8tIjduKVsrT++QKzwltYqSzUpIcZCIUZ052PEozi
 yTAFACvPPmWlHI6cOROV2NsVgKCGaSmY=
X-Received: by 2002:a92:985d:: with SMTP id l90mr3739185ili.286.1571317279910; 
 Thu, 17 Oct 2019 06:01:19 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxjKX/UnHwA4GrzHj3OzKvu5+cp1Xz3UomB3RP6HZ+3nHRvwaGdbLSla3cYzXwDHYv4spksF5dznPc8ZYj/kAM=
X-Received: by 2002:a92:985d:: with SMTP id l90mr3739166ili.286.1571317279752; 
 Thu, 17 Oct 2019 06:01:19 -0700 (PDT)
MIME-Version: 1.0
References: <20191016103754.2047-1-misono.tomohiro@jp.fujitsu.com>
 <20191017100528.GA24790@stefanha-x1.localdomain>
 <CAOssrKfR=sfE1RzOXzvPbdQg-g7i5-f8W9y8bWFnO=gyJ2VMsg@mail.gmail.com>
In-Reply-To: <CAOssrKfR=sfE1RzOXzvPbdQg-g7i5-f8W9y8bWFnO=gyJ2VMsg@mail.gmail.com>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Thu, 17 Oct 2019 15:01:08 +0200
Message-ID: <CAOssrKc7j5jvg9gSJdzOZOW8NWipWU+MKbonZ6Mv-1+TpENMxg@mail.gmail.com>
Subject: Re: [Virtio-fs] [PATCH 0/2] virtiofsd: Two fix for xattr operation
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: virtio-fs@redhat.com, Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 17, 2019 at 1:23 PM Miklos Szeredi <mszeredi@redhat.com> wrote:

> I see why this is being done, and it's not easy to fix properly
> without the ..at() versions of these syscalls.  One idea is to fork()
> + fchdir(lo->proc_self_fd) + ..xattr().  Another related idea is to do
> a unshare(CLONE_FS) after each thread's startup (will pthread library

Apparently Samba does this, so it should be safe.

Thanks,
Miklos

