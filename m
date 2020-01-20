Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E46C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 11:22:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AF7B207E0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 11:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eT1GrvC7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AF7B207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itV8Y-0002BL-Dk
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 06:22:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44729)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pdurrant@gmail.com>) id 1itV56-0006Tm-K2
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 06:18:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pdurrant@gmail.com>) id 1itV55-0002XE-HB
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 06:18:56 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:37347)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pdurrant@gmail.com>) id 1itV55-0002Wi-A7
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 06:18:55 -0500
Received: by mail-pg1-x544.google.com with SMTP id q127so15399836pga.4
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 03:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=InfBUYsx02Tl3TB3B9224lsuPzFzVcbK4KeXE6wA3yw=;
 b=eT1GrvC7wLxcHU6JkiFrQw4m0k9i/W+X9rZw4aOCuUX5qq0M6FhKNX2x04lg1MDr/R
 qWusui/IUiZ35xG44qa5m4q6bIcTeDULTqVR14OlgJUBSh+68QnE7FECfpYwPFqVjHIg
 3e7VGpo0Jav+NqQO4HgTH1HWjkTlLJm6UpA3xHyBH/JB7lRgcyfLa8zGvStBvH+t6+Gq
 HGEguzfqQAIW7spHMe5Trcby4FtXjO0WtmJng0DXPuDyjkJHe7AR1ZSorTcu6Z1JnbVq
 mE9zGK7+vkPjVfRz2Gyqp8oz0m6W/o20UYxPpc37kZ7gFwD7t5yZKU9d3ljzjIW+rS1b
 kajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=InfBUYsx02Tl3TB3B9224lsuPzFzVcbK4KeXE6wA3yw=;
 b=ehuHSEWkwupLyV0PGjVf14zXYkdWzgazke0YcJyaYGNow16X4wWKZcJU28y9pEynOI
 mQxLkW5rIMBQiKi1fh9FwdsdJ9WsYR9lOm/gfNP6whjbv1GYyFMKlP37+LV71qT9OTfg
 EYXKFvnt+9dkg9krfSd3qVAAhUhYXKSMwRJTZnjEg6ywq47Ocl9K/9Hp7TDkukY/lvjo
 0J8DJH4eFX8I4ZesI13hpq99orHyfxkZZqBpjUHfcaMsb8dwEPTtrGRKCNdU8cbJ/+XT
 F47uo1K0KD9lYwuoh7AQJ13A78hx9dzpFdKclxpYYbrCIkkIW3IKNqzdHl+Rrq867U/y
 WZig==
X-Gm-Message-State: APjAAAWxtDvPpnLhWNQZ/4Zyc09n5PiEgos2sd9gsNiGmDTOsxqVij8H
 vmL9PyqHehi6w6GHAFA9SJr5xD39WEHKY0g8AkQ=
X-Google-Smtp-Source: APXvYqxJWDeMCD2etRjGFFrleeWmXTZnzBWH8+zT2fAL2a2rcojBhrR1N4DkQj0aIvVK8o2fVUMoC1AI6TYMfjaMFIE=
X-Received: by 2002:a62:1684:: with SMTP id 126mr16861182pfw.234.1579519133383; 
 Mon, 20 Jan 2020 03:18:53 -0800 (PST)
MIME-Version: 1.0
References: <20200113174521.3336-1-olaf@aepfle.de>
 <20200116180321.24968-1-olaf@aepfle.de>
 <0335edd2-3d33-88f8-2ab4-4791f7289885@redhat.com>
 <20200117102244.22edd8a6.olaf@aepfle.de>
 <ea3a65c3-bd69-7815-6893-cb1cd8b9cfd6@redhat.com>
 <20200117140616.18cb8c45.olaf@aepfle.de>
In-Reply-To: <20200117140616.18cb8c45.olaf@aepfle.de>
From: Paul Durrant <pdurrant@gmail.com>
Date: Mon, 20 Jan 2020 11:18:41 +0000
Message-ID: <CACCGGhCO_OqPq__t+V9RrFMYhXCJ5N4PPkq9CASJULV2rTkT-g@mail.gmail.com>
Subject: Re: [PATCH v2] hw/i386: disable smbus migration for xenfv
To: Olaf Hering <olaf@aepfle.de>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 Jan 2020 at 13:06, Olaf Hering <olaf@aepfle.de> wrote:
>
> Am Fri, 17 Jan 2020 11:27:59 +0100
> schrieb Paolo Bonzini <pbonzini@redhat.com>:
>
> > It doesn't even try to be compatible for all existing and future guests.
>
> This looks like the underlying bug.
>
> What would future domUs lose if 'xenfv' would be locked to 'pc-i440fx-3.0'?
>

I guess eventually that pc type would be removed and then we'd have a
compat issue. Ideally I think libxl should simply not use xenfv and
then it can be deprecated and removed, and then such issues can be
dealt with directly in xl/libxl.

  Paul

>
> Olaf

