Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C5CC76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 06:58:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5D9A20818
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 06:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vzi3QxDD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5D9A20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hndtQ-0006pC-Um
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 02:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47851)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sjitindarsingh@gmail.com>) id 1hndtG-0006OZ-10
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 02:58:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sjitindarsingh@gmail.com>) id 1hndtF-0003A3-5T
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 02:58:13 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:46683)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sjitindarsingh@gmail.com>)
 id 1hndtE-00038O-S7; Wed, 17 Jul 2019 02:58:13 -0400
Received: by mail-pl1-x642.google.com with SMTP id c2so11413832plz.13;
 Tue, 16 Jul 2019 23:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:mime-version
 :content-transfer-encoding;
 bh=bE10wn8R+tZGo4bBS0Mh+WZFVs9IUUVPFPjEiZ/u47s=;
 b=Vzi3QxDDopQqRQcQtV34tUCAnA+zadiU5m7OGYEH47z9rDu+BTXMfCTRiXIi8L06em
 5ZI2PywDZc/wtXEZxSMHqB+3Knk2a3wl+eU4K0zwXVMDrJ94M3Y7Kzky08oJJ6R+GhsF
 0OTDb3v2+sQ2Udb48ehJPwRoXNsAjnZ+YofhOsF1cCOilJaGvUr91Afoo2KGAklluq8o
 eUrVq8Dog0he5Y1VE4t55r5XRpD1T5nk6NhQIOzf+zXtzKnV4mOg+spCuDhOkwA9CfbE
 RKstfH3TwSy4M3Z5O5Fn6vsKPUDu26wcayuypAJ6i6AK9fKmAwOig3ZYFE5gAoFxULUH
 yibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:mime-version
 :content-transfer-encoding;
 bh=bE10wn8R+tZGo4bBS0Mh+WZFVs9IUUVPFPjEiZ/u47s=;
 b=UmuHpMuoNrx74g/l5tVVXwvTIgQMbpl5wOQv9dx4eAO6nLbVq/ruI0v+fkfAoGzRDB
 hFox+HWRs45G0VQcQHlVwxMIq3+vnmCqWCo8q2gYR0fB8akcG9pyszIImoqg5DdUXu5A
 HqcVrbKlskjpZPUfB9zwaiVCojGI4sJVb0Wd2OAGNZk4y6HEKj6ZDDyKOXfZ85JwxYYk
 VSO6MHd1aV+UegHT4i9Z41x7ifAjyBFIwwYxiIWvAPDGOQFAr8yJ0WbpY60QxSfbCF+d
 G2UDkXYf7MtNgwjk7QYbe5qYNYUGgKHi6JazjWFXqlx1FLae5U7CqAcZeVgD28Z/QehQ
 77ug==
X-Gm-Message-State: APjAAAUTR5XhKCAH5wdXOopw8xr8qJRjUJ4k/wcdmjwnaRaVZG1/QPyS
 0J4wiR77CHv2VIw+90h3F7vcx2K9
X-Google-Smtp-Source: APXvYqzbdjzqyvyBJZsDgGKk78TeAPuZaioS/VzLdlD1HmZM2Sf+EFWW7GsL7ViyrBQ/xHdHPZWUOA==
X-Received: by 2002:a17:902:b08a:: with SMTP id
 p10mr41644160plr.83.1563346690967; 
 Tue, 16 Jul 2019 23:58:10 -0700 (PDT)
Received: from surajjs2.ozlabs.ibm.com ([122.99.82.10])
 by smtp.googlemail.com with ESMTPSA id 35sm19136143pgw.91.2019.07.16.23.58.08
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jul 2019 23:58:10 -0700 (PDT)
Message-ID: <1563346686.2145.11.camel@gmail.com>
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 17 Jul 2019 16:58:06 +1000
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [QEMU] crypto/random: Fall back to /dev/random when
 getrandom returns EAGAIN
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
Cc: lvivier@redhat.com, richard.henderson@linaro.org, qemu-ppc@nongnu.org,
 berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

I'm trying to use qemu inside a a guest, however since there isn't
enough entropy for the rng getrandom() blocks. This means I am unable
to even get output from 'qemu --help' for example. This is annoying at
best.

Thinking about ways to work around this obviously the major one is to
have an entropy source for the guest.

In cases where this isn't possible I think it would make sense to fall
back to the old /dev/random source when the getrandom() syscall returns
EAGAIN indicating that it would block.

Alternatively it would be nice to have a config option to disable the
new getrandom interface, along the lines of --disable-getrandom.

If you feel that either of the approaches would be statisfactory I'd be
happy to send a patch. Otherwise if we can have a discussion here with
regards to how to progress.

Kind Regards,
Suraj

