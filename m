Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B280C33CB3
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 19:36:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 388BB206D5
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 19:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BF7xdbSk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 388BB206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isXPU-0003Mv-4o
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 14:36:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40155)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jkz@google.com>) id 1isXIS-0004wY-Uv
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 14:28:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jkz@google.com>) id 1isXIR-0004IE-Pm
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 14:28:44 -0500
Received: from mail-vs1-xe43.google.com ([2607:f8b0:4864:20::e43]:37538)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jkz@google.com>) id 1isXIR-0004He-MQ
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 14:28:43 -0500
Received: by mail-vs1-xe43.google.com with SMTP id x18so15546726vsq.4
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 11:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=z/WfrYKoMjf/YnG0hiNCf8lrPUaPq1aZnENTJ5Ep9Ok=;
 b=BF7xdbSkHv1OvCx6DezIFfVujBln9jUZ5zX9LyWq7hPeL9usrKjTzZLJ0iCPxIqeFh
 RpqoM++shK4jcfmBazDSBD/U7hC2kbDC3VK9YMaqKkmHHARuakBZouN6ktWrsA+11cK+
 gCmuAWCnubEWqVd5qpfcghpZJix0ffBHcr7nZU1Z1SdXQx5uxiR7elqR1B/r6nf8mL/g
 k0b5Tg75zgwb60TkW9SWM9qyUXRqFsPWrqdr6IvekTAklcbeeY2X9rmOUhnoJs8Te/wz
 oBEi+/s2/8EoenUcKJ3BhUalJbK9YsRw+Lsor3jHe1V45lEJf1rNQXqIrrRQoc5Fskxc
 CS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=z/WfrYKoMjf/YnG0hiNCf8lrPUaPq1aZnENTJ5Ep9Ok=;
 b=MiCSmnNufJX3qdSO2plPm8ME+w0lYj6eEfD5e0ACn/Fvo8GhzoOtQflcZqR0QonEKj
 ao0y0n6qPtDKLTsB5ZgajdotZ0FOpwNxDLxnXkVcKTUjy9SB+8vaH6qSk4wDyVJRYzGw
 cZFO2ktIiqBaic9Iw6m2FbsQgdWjUixHRvvIWHWuY+1jl1ItPRl0PslyCjoj6AhWGVoj
 /2FE0kRpoauDPW3kyjf2v6aMa5tzCX220IdgwQksy36G1esL1Mmy95Lk0NoNKl7DXiOb
 1MSbvpWUpQz7RwSVMwQSO0jdoYvIVFPHpxNqCOGMLz0Ym13+TLnc58XucF1rH8OGff5U
 gOAQ==
X-Gm-Message-State: APjAAAXwfBQLoh+GfDQXSu3/Z9sR2KcGcHPjxHX3s8nlCHPL8AQ/peQO
 pTcmK2jrmA2cgGdQ3ZT9/deIIswbPXjN+WERSBnnIQ==
X-Google-Smtp-Source: APXvYqxDesWhh6AoU5Is05Z7UM71vJeASlgH9frhWGSMlR8xTKlK5y6lJKFQEMi0R0CFCqCQjREwvdpHGksn6wPZOPs=
X-Received: by 2002:a05:6102:194:: with SMTP id
 r20mr5880613vsq.16.1579289322498; 
 Fri, 17 Jan 2020 11:28:42 -0800 (PST)
MIME-Version: 1.0
References: <20200114030138.260347-1-jkz@google.com>
 <20200114030138.260347-3-jkz@google.com>
 <af635ec8-b1a7-30c3-958a-6fdb0ab8d202@vivier.eu>
In-Reply-To: <af635ec8-b1a7-30c3-958a-6fdb0ab8d202@vivier.eu>
From: Josh Kunz <jkz@google.com>
Date: Fri, 17 Jan 2020 11:28:31 -0800
Message-ID: <CADgy-2sSvWCsfDYnbEUWBpK+dHO8+xMreR13a9=0jXDGaMpRkg@mail.gmail.com>
Subject: Re: [PATCH 2/4] linux-user: Use `qemu_log' for strace
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, armbru@redhat.com, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::e43
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

On Tue, Jan 14, 2020 at 1:09 AM Laurent Vivier <laurent@vivier.eu> wrote:
> This is really a special case as the flags are all given at the same
> time, could you use directly qemu_set_log() in main()?

Fixed in v2.

> > +/* Remove (subtract) the given log flags from the current log mask. */
> > +static inline void qemu_del_log(int log_flags)
> > +{
> > +    qemu_set_log(qemu_loglevel & ~(log_flags));
> > +}
>
> Unused and unneeded.

Removed in v2. Also removed `qemu_add_log`.

