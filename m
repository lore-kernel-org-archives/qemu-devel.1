Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C240C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 11:05:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 107DB206F7
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 11:05:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 107DB206F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLm3I-0004px-AQ
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 07:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47747)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLlxH-0003zi-CW
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 06:59:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLlxG-0008JJ-5a
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 06:59:43 -0400
Received: from mail-yb1-f170.google.com ([209.85.219.170]:45362)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLlxG-0008J2-1u; Tue, 07 Apr 2020 06:59:42 -0400
Received: by mail-yb1-f170.google.com with SMTP id g6so1558089ybh.12;
 Tue, 07 Apr 2020 03:59:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=Na9xCxBm4Tshe3h18hsYXdtVqOzNqRhZ57fIcoOnEYo=;
 b=cMYKGtt7XTMeqxia540ETEU6TF9V76Lj7PZW57MhRcfGu1srMsW17zKhQaRwCDxkqi
 adZv2sX2ukDOyzgz7lS6ZUGYu2B93oXXDKlLhHiNsH/ICNR28Id8KBYG6jBvvOY1TD+p
 VeBJB2xW6AL0da2lC2+iwWp0RqkbYZx7suqci/oDXNqiL2dfCEUgDWGKFHoRk/j0BZyj
 LeozFWXL3sV9cgAP5tA1eoyvuT61EwBf2l2d6UoKtSMABXOX3mjjWIUhAVL55gU6bNug
 +uE6O994YnGLlA6Is2RDyZGiMP7S7g7AcXk+qOdidGf5PUuAeVzScUuImY7eOeUqSNY1
 m7mA==
X-Gm-Message-State: AGi0PuYP4E95jNQgpufPda8Ax7892pfixCPSZ9n++beIr7V+tbhEft0/
 k/nMdsCW7XNWPBZI6N8HAyQ5PMdr3zhFx8hCil7QhKxnzL0=
X-Google-Smtp-Source: APiQypKlPRJVb8OEyMbNcNGZZPeO4EQWDfDIAuyfQX6pEzY770/LCMpKS0Zeh+E1V3dxwJOuIFpOIO+chI3fXm58p28=
X-Received: by 2002:a5b:78a:: with SMTP id b10mr2809564ybq.483.1586257181142; 
 Tue, 07 Apr 2020 03:59:41 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 7 Apr 2020 12:59:30 +0200
Message-ID: <CAAdtpL7gSqz+R5LfbvsuxeeCzf1K-omHSeYo2eTOFYaMS1bp6A@mail.gmail.com>
Subject: QEMU 5.1: Can we require each new device/machine to provided a test?
To: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.219.170
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
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-discuss@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

Following Markus thread on deprecating unmaintained (untested) code
(machines) [1] and the effort done to gather the information shared in
the replies [2], and the various acceptance tests added, is it
feasible to require for the next release that each new device/machine
is provided a test covering it?

If no, what is missing?

Thanks,

Phil.

[1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg604682.html
[2] https://wiki.qemu.org/Testing/Acceptance#Machines

