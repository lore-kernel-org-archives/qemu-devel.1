Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF2EC32771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 08:07:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 053822253D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 08:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S5ISIX3y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 053822253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuB2f-0006wH-RU
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 03:07:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43913)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iuB1U-0005hy-3V
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 03:06:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iuB1R-0006HL-Fh
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 03:05:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54650
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iuB1R-0006Gs-1V
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 03:05:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579680355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dkKcvEmIDrxqbsCNL9a6DzMingX3/c66VskQkVxbeXs=;
 b=S5ISIX3yh2RzCDUmO/kE1xUJ9HYDa+PJlShBuu3fu3e7/soBCq/sqYQa+XofvTJtea2jwj
 hYs0phcHGLW/rDUjRCxBIMKZ+mztC+hqt1FJF8hSzd9qKRFe8qc5XS0jM3G+aWelDo6uSR
 NaY56dmG0hPUBzpUkw7AS8w+UR6BStA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-BcHKckKuP5mfP9KBe6tWtQ-1; Wed, 22 Jan 2020 03:05:53 -0500
Received: by mail-wr1-f71.google.com with SMTP id y7so2695974wrm.3
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 00:05:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:mime-version
 :content-disposition;
 bh=384K8UdPPJuPvBq5li8Od+bOugZgLArbpF3HoOWVM4o=;
 b=Ap/A1dEQIxlEDXEVj2vkqbUzRFdpdcw5TrFVQt+TztcTBQZjhEngLByuTGk61FM9TX
 j5w53GNG5H5dobwdpQ3tR2mdma9hcrvsM5LoaCMYHU3JQBvlA42MVZP0Fo28iTFGG+j2
 TPukLStCrWWMaWsGicqx7Fswsrpy2nHwm68M5tiKlbP+Eu0Md49JcFiwOxagI8P1po6q
 SfGHLJoJrBxDzM2l3bvy8DlURs0Mp4fVe0aiUg3WDHRekMs40mIuPdd+b5eK8LUh7hBf
 EwqRR+F0305xJWzmHQBQh4h5v5IuLChnahFGDQ1k2bLKqhQ+oi2jd7uwPjhLJQzttsPn
 vvVA==
X-Gm-Message-State: APjAAAUD8taOBngJQttBl7hLgOkAKLy7CciyCx/G0g6EBgYG9iiVzdag
 88LxVeEJDdyN556b9+7ahw6DxI4w/QC+19DrwJ80hEIi9mV6JnXvsJnozwPsnk+gkmRG/bpm2n2
 XMx3HJTCLmTEnxMU=
X-Received: by 2002:adf:cf12:: with SMTP id o18mr9671233wrj.361.1579680352390; 
 Wed, 22 Jan 2020 00:05:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqxq5dK//Zhdvv+0Wm1iiKLrPTQPUM1I3MoS+FroUxTqJD8Kw+4uwHLiEpsy6jNb/T4X0pJyFA==
X-Received: by 2002:adf:cf12:: with SMTP id o18mr9671209wrj.361.1579680352139; 
 Wed, 22 Jan 2020 00:05:52 -0800 (PST)
Received: from redhat.com (bzq-79-176-0-156.red.bezeqint.net. [79.176.0.156])
 by smtp.gmail.com with ESMTPSA id
 u16sm2720816wmj.41.2020.01.22.00.05.50 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 00:05:51 -0800 (PST)
Date: Wed, 22 Jan 2020 03:05:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/5] bios-tables-test: more documentation
Message-ID: <20200122080538.591734-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: BcHKckKuP5mfP9KBe6tWtQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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

Better error messages, documentation tweaks to help
people follow the process for expected file updates.

Michael S. Tsirkin (5):
  bios-tables-test: tell people how to update
  bios-tables-test: fix up DIFF generation
  bios-tables-test: default diff command
  bios-tables-test: fix path to allowed diff
  rebuild-expected-aml.sh: remind about the process

 tests/qtest/bios-tables-test.c          | 32 ++++++++++++-------------
 tests/data/acpi/rebuild-expected-aml.sh |  7 ++++++
 2 files changed, 23 insertions(+), 16 deletions(-)

--=20
MST


