Return-Path: <SRS0=PtAT=XD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CDEC433EF
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 19:41:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ED0A2067D
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 19:41:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ED0A2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i733Y-0006X5-Jz
	for qemu-devel@archiver.kernel.org; Sun, 08 Sep 2019 15:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57048)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <th.huth@gmail.com>) id 1i732x-000662-43
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 15:40:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <th.huth@gmail.com>) id 1i732w-0006c9-30
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 15:40:26 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37208)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1i732v-0006bA-Rc
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 15:40:26 -0400
Received: by mail-wr1-f68.google.com with SMTP id i1so10969209wro.4
 for <qemu-devel@nongnu.org>; Sun, 08 Sep 2019 12:40:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jCB43qTlXAcw0P8gWG1JY82MIYh2dV/H2n2IkDzApb8=;
 b=TG6tDkxXcSmDAzSlKqp64c5i5DmA0D5x5iBlnWUnDiI/52DnAQAz/RP56cH9EQvd7W
 w8byu3E9ujRmTpImZNPYUszf5xUZaf6LkMOiEsTNi72yUr/a56/hPh541CeMap6aP63/
 Js7UOcultHIihQd1zXyU2zhUgNuNsafqIcGE0pvBPyORd4AXbkoapAQdDJrWh85TVp3H
 6kbvTBCafqBZ4AP1h9OcCv5qy2HkDD5JI+xgUGQx4Q7ghDZJ8vTfPsgLa5M6V++AZ7CQ
 mpxYrANZ4ZNEvg1eHATr+6QSzOfO57uWadVPbYyXwd491E72bBRrS7hVCYLBuHlRzFft
 LRJg==
X-Gm-Message-State: APjAAAWmT6jVj6Ruap5t+tRmSiRWjQg7kohHl2mrpbyVEmVBRUn2I12u
 aw6oJKAoLHE6WvvxQ1GQ+T8=
X-Google-Smtp-Source: APXvYqxnHVIYUJ+Kvy6t++frZ7Gc95jMpIt/eaOG1P67xxh8apcGzRONrZuWhQH+hFSHYFmwBf2BtA==
X-Received: by 2002:adf:dc81:: with SMTP id r1mr15552473wrj.52.1567971623877; 
 Sun, 08 Sep 2019 12:40:23 -0700 (PDT)
Received: from thl530.multi.box (pD9575A28.dip0.t-ipconnect.de. [217.87.90.40])
 by smtp.gmail.com with ESMTPSA id a6sm3888551wrr.85.2019.09.08.12.40.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Sep 2019 12:40:23 -0700 (PDT)
Date: Sun, 8 Sep 2019 21:40:18 +0200
From: Thomas Huth <huth@tuxfamily.org>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Message-ID: <20190908214018.6cc84109@thl530.multi.box>
In-Reply-To: <20190813134921.30602-4-philmd@redhat.com>
References: <20190813134921.30602-1-philmd@redhat.com>
 <20190813134921.30602-4-philmd@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [RFC PATCH v3 3/3] tests/acceptance: Run commands
 sending VNC keys
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
Cc: Fam Zheng <fam@euphon.net>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am Tue, 13 Aug 2019 15:49:21 +0200
schrieb Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>:

> Proof of concept to interract with a framebuffer via VNC.
>=20
> This test send 'mem' and 'help' to the firmware prompt
> within the single X terminal opened.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> This test is limited because the '-vnc' option only allow
> to bind TCP port. To allow parallel testing, I should try
> to bind within a range instead of ':0'.

Maybe it would be better to use the "sendkey" HMP command here?

 Thomas

