Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53884C76186
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 19:10:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B39521849
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 19:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghOVymUA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B39521849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hq0Ah-00047b-67
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 15:09:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51350)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hq0AW-0003eY-Td
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 15:09:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hq0AW-0004DI-3T
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 15:09:48 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:41649)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1hq0AV-0004Cb-SH; Tue, 23 Jul 2019 15:09:48 -0400
Received: by mail-io1-xd43.google.com with SMTP id j5so80038597ioj.8;
 Tue, 23 Jul 2019 12:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=whY49upHW0kNMXAwtTZx0THvn/Q0uJafV8zoniqwlU8=;
 b=ghOVymUAJI9zg7Pi9YVf3OvcvzszlPVDIXa3Kb0lqOewbD8iPh6ZVMamVH29oVKdkc
 n3a7d/FILONSd6ZKjYB7dqpuXtpkwEDFePBeD0QYJ7uJe+CERI8jqCxmApExAjM6hr2z
 /UGUIc2eXYHAJfFkTaXu2exI2TBRaDG0XJQ0iNZ8TmTPvi/b9U5lVl+dcOuP3VYW9njL
 xXlpF/IF0xhi9COaVwDt/yurZlA9d0KqbELcodg2ffEBg6kyJDZzRXf5OdmlyCAoOCmX
 oeeh8NyeKALwFf4boqLR4gU1M994r6RW3bpfxXe3se0W4mDfsblm9AsBlRdN975WKe72
 7aog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=whY49upHW0kNMXAwtTZx0THvn/Q0uJafV8zoniqwlU8=;
 b=HVd6FMP7NiODuCWiCwoxpJU23aQP02tQjGWGN5Y14G450VXnC0C0O0jjxI3zwP08zp
 IrvhZ0HUU/9XDiEDxiJAHe/nafOT+NpKxPuhk4b9+HFdFftzostvSdyisaXNfacWwSgA
 FVk+Ksi6ngMSBekNmn4P0tOWo55ZhDwZ6z26J72Z2ei4Nv5guMALWfcTfcL8B3V5FBYH
 Xe0LLKUozgN9ctFWP+3PIe1rd2p4vlyU7HZpipSntEiDbb9FklGnAcZa7PT6oUabssog
 z3lo37+vyw+6gIF3z7q8ONZ0Fsrrz9X69OsHo8nh03O1DK0daLympIeunhIzGfnN/8fa
 JyPw==
X-Gm-Message-State: APjAAAWQzS2mQcBr40geFvsEdlRDLuCVYU+eROoZCPvWMD8LvtHVN2uG
 7T2z9LON6nNpiEGJiYhOIKY32llXw1bd1CwX++4=
X-Google-Smtp-Source: APXvYqzaELW2pycdoubl2RrxNksC0li4NqGxCj0ScM3R/+zID19efwA3YQBs/3wzOda4+fiubhq1F4fzQ5m1LQJZGp8=
X-Received: by 2002:a5e:8e4a:: with SMTP id r10mr62329167ioo.100.1563908986771; 
 Tue, 23 Jul 2019 12:09:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190723190623.21537-1-stefanha@redhat.com>
In-Reply-To: <20190723190623.21537-1-stefanha@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 23 Jul 2019 20:09:35 +0100
Message-ID: <CAJSP0QV3SyY3F9-6OEXqVOEfSHbhp4yAa2nB-1nHWYVnz3qm7A@mail.gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d43
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] util/async: hold AioContext
 ref to prevent use-after-free
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 23, 2019 at 8:06 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
> So if co causes ctx to be freed then we're in trouble.  Fix this problem
> by holding a reference to ctx.

For QEMU 4.2.  I'm not aware of a way to trigger this bug in QEMU
proper.  This fix just makes tests/test-bdrv-drain more reliable.

Stefan

