Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FDCC48BE7
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 07:43:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC5C620844
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 07:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5Fgg9N/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC5C620844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkOJa-0000jl-LY
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 03:43:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36732)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <smaudet2@gmail.com>) id 1hkIkI-0003MH-D5
 for qemu-devel@nongnu.org; Sun, 07 Jul 2019 21:47:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <smaudet2@gmail.com>) id 1hkIkE-000415-Fb
 for qemu-devel@nongnu.org; Sun, 07 Jul 2019 21:47:08 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:36258)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <smaudet2@gmail.com>) id 1hkIkC-0003hF-2U
 for qemu-devel@nongnu.org; Sun, 07 Jul 2019 21:47:04 -0400
Received: by mail-oi1-x22e.google.com with SMTP id w7so11357377oic.3
 for <qemu-devel@nongnu.org>; Sun, 07 Jul 2019 18:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=MahICUuQ6SZjZZLLPUdHjN8T+mq9Dy9zcudO00EK+v4=;
 b=E5Fgg9N/dLlTF7tvyInxg1aRDbN0u/q9bz6ympfL5SdtBIfJqnYEHP58O8qnpZtIet
 wcaC0sI1CkRYCDmyuyq7qbjy97SKTk646fx4D3ZpBPw7fZxQ9tD0bdwZ0nYWznWTjg07
 QyQ46oFCwrOuPhMnXTS6wHil5p2khzMqNBfk7Ngyb3HoFUj/6oW2Y8YhfyuEeBJOTT1+
 T+zp8DX6LVCBcDzz5P8eGu9HBAKmm2jjwh2btRGh4ldC8l5R4KusdVBPtGHOqtLwWB+N
 GQu3dYnCkkLFgoK1hgbnJFVgeXhMHyYyj//1IlQSmCQ8bwfZilBAhKxoa+np5RkekuCE
 8Rug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=MahICUuQ6SZjZZLLPUdHjN8T+mq9Dy9zcudO00EK+v4=;
 b=KgxM9wj5kQpe2GIJoJTQfzVaeegq1EdC1HrZS9c+fjVZqwZaEAI1fgS/Bm37FWbIM8
 /9Mu/mp2hB5l4PtNhYdo4c5YMo+cGBfVae79eHn7WD2HiRn1gX+4MObLvlKbagIoLyLM
 8Z9T15E9tU5pqmAYMn49EquAJ2okTzprG5Nvr4Z+92XewE6QQq7+RO3LZCfyHDFfbkzX
 pFeNHTWWzJKsMXi8F2X/6E1xTofhgs+TbnoXsNoMhDjxAmvIVtzmXBny2O+Cigw5HSXz
 NQWkD1ljoXWh5ny+oNeooKfMIPhM8o3tcj1oWwoUDqm1gYKteEZgy9NXtaIyxKyt4d0E
 jsbQ==
X-Gm-Message-State: APjAAAUyjlupFttgdwmgk/Fia6Av9AQSHcPn5ErY2JS+LX2pONyHAbxJ
 tiJWvUcu7iYh+4vKabtwbptLVaOWVUVfQJA0c7R894np
X-Google-Smtp-Source: APXvYqwAfew4txJKPkcn2dZ4kXIw69lKiHjg/vmTpQZTBqvrGRdG7M7yziI5syLPJdywkMkR4nJcrg3GJmARlWE6RhA=
X-Received: by 2002:aca:c5d0:: with SMTP id v199mr7348052oif.144.1562550406452; 
 Sun, 07 Jul 2019 18:46:46 -0700 (PDT)
MIME-Version: 1.0
From: Sebastian Audet <smaudet2@gmail.com>
Date: Sun, 7 Jul 2019 21:46:32 -0400
Message-ID: <CAB8WYtoXtTxS18a6iOUfQKUFiaiz08jy69eQF3xp4nxoFsx4Mw@mail.gmail.com>
To: qemu-devel@nongnu.org
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22e
X-Mailman-Approved-At: Mon, 08 Jul 2019 03:42:43 -0400
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: [Qemu-devel] Use Case for Qemu BT
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

So...this is not really a use-case per-say as it is actually a thing I
would like to do but can't at present...

Win 10 is lacking an ad2p sink and this means if I'm using it to play a
windows-only game and want to stream from e.g. my phone to my computer, I
can't (natively). Enter Linux, which mostly ignores most of the crazy crap
from MS... and VirtualBox which can see my bluetooth adapter, relay to the
audio outputs, problem solved (yay? - well I also had to modify a kernel
parameter and some config files, but it worked at least)!

So anyhow, the bluetooth stuff not working from qemu is a bit of a shame -
VBox is bad at virtualizing stuff I guess unless the OS explicitly says
"hey I support this!" and I was hoping to use a super-light-weight distro
to solve my problem, not the mega-behemoths such as Manjaro, Ubuntu,
Fedora...

I'm not familiar with the project, so I don't know, but it seems like this
shouldn't have changed very much, and probably should just work? The only
way I know bit-rot happens at the protocol layer is that a bunch of
developers made a bunch of changes they didn't have any business making, or
the original code wasn't written very well to begin with...

Anyhow, cheers. Hope to see BT live in Qemu again someday!
