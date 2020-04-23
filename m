Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A48C55186
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 10:42:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 356A120776
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 10:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IX2ILECN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 356A120776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRZJ1-0000Uz-Bd
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 06:42:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34902)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jRZI9-0008CO-9K
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 06:41:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jRZI8-0003qH-BM
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 06:41:13 -0400
Received: from mail-qk1-x72c.google.com ([2607:f8b0:4864:20::72c]:35846)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jRZI7-0003oo-TC; Thu, 23 Apr 2020 06:41:12 -0400
Received: by mail-qk1-x72c.google.com with SMTP id l25so5858748qkk.3;
 Thu, 23 Apr 2020 03:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=so6nADBIT1YLUBLJxjJPUV9triNRdN1h5xFkMDO6eE0=;
 b=IX2ILECNpzHPfs34TzBgVig50YMTHjOsFLTC8m9eLLHyqvKygRxgS9GfCqfO8F0qv/
 dd+bNoRDRQspCSMxHYWMOigwoOJtbezm3if+lljrO6KCLV8EodUZwV3cyJRCboRAlFz9
 +tls+VVb6DyjEx7zBlcUnUCOXF2gNxwCYjCq929rTgkFiZgnV2e5lMw5/87uWqNJepik
 LNM62ZHJrD5oBuY5EGcZT10Evs319+qwNhxyYrviVEFVxF2oEIqBKPcCzlo/AebdyjEb
 U8mQ9JM8S8vnSoWEK08rVfvWtGYtd3FV9vvR44Ae6IJsgXU5zffH1ec7mYMA7aQkuDVs
 CTWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=so6nADBIT1YLUBLJxjJPUV9triNRdN1h5xFkMDO6eE0=;
 b=U/fCfuCGVvHKfuk6QvS9oLQNdvRQoTaw/dPcuZaKara35/HIbsgU4D2wFmxKUDDiwx
 u640c8c/OoPtI1pnktR6iMQsB2iROCS/QqDgYQ+5fsM6AoGe6DYHu6lLhZFl1pNwIWsY
 lHwO0iGRg3wJQR7LRXqJahqpxsP7bRvKTULdfZcDN1+iFgC0nJG1Umpm6uJdTXJUr2TP
 Jb6+fmhyKmerblCxC4WZYezeXobHRqW1bKflZ0TTM5MAuwlvLbpu4zmi+o1ZO3fbp2tt
 shC7LWPWj05qXC+D9gZn7ulC+Hljf1H7HbVFEk94aAY3zHdwMH7aM3EEdfa2S+mjiWc+
 2+Yg==
X-Gm-Message-State: AGi0PuZdu8L2/ltWVZm1uQp5t+m0qQ3OBomK41Igak4ViOdeWsT7pHGn
 HkLUkTLXv/EAvDLWOBktuNAV8Uy+sA5QnSnIAM4=
X-Google-Smtp-Source: APiQypJPX8lsPiNtvl7jPKhLP5n4a2PNKihUVzUl6whnI8r4dkTEj1wSrysEGWzPNaNTYo5inHYJiwwoBsVuNQl9DRg=
X-Received: by 2002:a37:b185:: with SMTP id a127mr2715267qkf.87.1587638470542; 
 Thu, 23 Apr 2020 03:41:10 -0700 (PDT)
MIME-Version: 1.0
References: <00fc01d61256$35f849c0$a1e8dd40$@fau.de>
 <877dyfc1if.fsf@dusky.pond.sub.org>
 <20200422161813.GI47385@stefanha-x1.localdomain>
 <006e01d61958$de787120$9b695360$@fau.de>
In-Reply-To: <006e01d61958$de787120$9b695360$@fau.de>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 23 Apr 2020 11:40:58 +0100
Message-ID: <CAJSP0QVeEZmSps3R8Hg+j=-BZR7_+FeOkm+m12A=gMULosP3Sg@mail.gmail.com>
Subject: Re: Integration of qemu-img
To: janine.schneider@fau.de
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::72c;
 envelope-from=stefanha@gmail.com; helo=mail-qk1-x72c.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::72c
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
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 23, 2020 at 11:20 AM <janine.schneider@fau.de> wrote:
> this requires the user of the application to install qemu first right?
> If this is the case then this is unfortunately not an option. The user shall
> not be bothered with installing anything else then the tool.

Hi Janine,
Please use Reply-All to keep the email CC list in tact.  That way
qemu-devel@nongnu.org will receive our replies and the discussion will
stay on the mailing list.  Thanks!

It's common for applications to consist of more than a single
executable file.  They could have shared libraries, data files, or
other executables like qemu-img.exe.  You can distribute qemu-img.exe
together with your application as part of a zip file or installer.

Regardless of whether you ship qemu-img.exe or build a library, please
check QEMU's software license so that you can follow the terms of the
GPL open source license.

Stefan

