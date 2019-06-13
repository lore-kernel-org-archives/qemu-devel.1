Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1D1C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 19:26:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1E0D2147A
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 19:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=illinois-edu.20150623.gappssmtp.com header.i=@illinois-edu.20150623.gappssmtp.com header.b="nfL07gsy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1E0D2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=illinois.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44813 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbVMJ-0008C1-KB
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 15:26:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45736)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <rgovind3@illinois.edu>) id 1hbTuo-0001to-A8
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 13:53:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rgovind3@illinois.edu>) id 1hbTum-00074Q-Rs
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 13:53:34 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a]:37235)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <rgovind3@illinois.edu>)
 id 1hbTum-0006xg-Bz
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 13:53:32 -0400
Received: by mail-pf1-x42a.google.com with SMTP id 19so11462489pfa.4
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 10:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=illinois-edu.20150623.gappssmtp.com; s=20150623;
 h=mime-version:from:date:message-id:subject:to;
 bh=rbAA23dYwkYFlfACU+t7B4fOcSZszt3dbLVXUdAKWGU=;
 b=nfL07gsyMhXtaec3euKnowDTzioTGctfHbEoHly3KJkF0sucJU4HSd4PI0HS/Dv4YC
 7Srb6NFZReSdUIA7jk/Xtze9oTBkYAJn4EfA88RY+xWJahoAut0lne2AdEbuL7AaC8zV
 GmT2eFER8r1kyal0+isFVbnL9m4CFK0mhSOVQjSCrXUWucC3R7nUzEtFeEL2C8Zy4xgw
 +iOYo1765hjpU0ZS6BGuHWy122zhBBt48FB2IYVLyjGEhyfpOVIdQsZ6yBHaVg6IXaav
 SYJjmr0gY4GbF/xSv1oOgxTuNbu1P9BVfSx4cIxvd0koqZmF+bcNHstJ9c1na+aKBJ0o
 B6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=rbAA23dYwkYFlfACU+t7B4fOcSZszt3dbLVXUdAKWGU=;
 b=d53fsFZDqwiH3ZcJJCmPSe2SEoOgZUjafFERydRmyzrqP9/snHBq6cTgcRFB8PzQ+d
 qYqna/rqqJpmOdKF8BLZnNRbfwz+n5HYU1pww/dVCIzJtluDCZBLk7jpFHhfHxTajLti
 us9ewqWNABkYLp61iuSrS3lI5wyEBjDNTa8lSmm15fS2h9ZhmXNhOr6kEp9nNW6bRcWk
 Dzc5y1eR9nGp9ypEYpYHrEjgt8dehhJEzg8ZLf0Wxdh6Kruc+rdXaqlpot0MwH0PwN4c
 BvMqApb31NPxdsA0qJ6iyiUBukakkeZ8Bo5MJFh/g8iI+JXhxXzliOrOxtGnVDTL6O2h
 QrHg==
X-Gm-Message-State: APjAAAX18a8iEOWlebp8F4i0PiOJiaC3UYtM+GDBDT0koiHpEUOfooub
 mbC8+Sch9O25+BzJr+xRK2aXBEhoKLENQNzgde5CpxXp
X-Google-Smtp-Source: APXvYqyBpTNVobghyt0d9MIiPZdS8/P4OGBeG1frl1BbBqCk6OAHNjAokmYaTSCQ/8T+lG0oAZs7KObvQJ2k+FYA3o4=
X-Received: by 2002:a63:4e10:: with SMTP id c16mr31336620pgb.214.1560448407523; 
 Thu, 13 Jun 2019 10:53:27 -0700 (PDT)
MIME-Version: 1.0
From: Rahul Govind <rgovind3@illinois.edu>
Date: Thu, 13 Jun 2019 10:53:16 -0700
Message-ID: <CALP2uw1A6GiZm_-Pa4Yq2+HUpNbGbp1ioZd9-RK0HR_yTEEAhg@mail.gmail.com>
To: qemu-devel@nongnu.org
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42a
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: [Qemu-devel] Virtual I2C adapter and I2C external simulator
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

Hi Everyone,

I'm working on a project that involves building on top of existing QEMU
work, and I'm trying to virtualize I2C devices that are shared between
multiple VMs. I've been reading QEMU documentation and source code to get a
better idea of how to add something like this to QEMU (since it doesn't
look like something similar is already present) but I'm not sure how to
proceed. I do have a few ideas and I would be grateful if anyone could give
me feedback on them or suggestions for alternative solutions.

More specifically, I wish to virtualize a couple of devices that sit on the
I2C bus. However, directly virtualizing the devices doesn't seem feasible
since there are many other devices like multiplexers on the way to these
devices. Also, what we need is to handle is just reads/write/ioctls on
/dev/i2c-N.

I was wondering if there is a way to create a device that
- 1) Emulates an I2C adapter, say /dev/i2c-0.
- 2) Handles any reads/writes/ioctls sent to /dev/i2c-0, reformats any
ioctls as IO, and then sends this to a simulator on the host.

This approach is just based on the ipmi interface and ipmi-bmc-extern
device already present in QEMU, where ipmi-bmc-extern can communicate
through a chardev with a simulator running on the host. Having a simulator
on the host would be nice to have since it lets us write the simulator in a
higher level language, and as previously mentioned, we have a few cases
where multiple VMs share the same I2C device. However, I'm not sure if this
even makes sense in the case of I2C.

If this approach doesn't make sense, what method would you recommend to
have virtual I2C devices which are shared between multiple VMs?

Any suggestions or guidance is much appreciated!

Thanks in advance.

Sincerely,
Rahul Govind.
