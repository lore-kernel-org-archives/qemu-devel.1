Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9F7C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 17:56:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DFC9207F7
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 17:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rjikRcBD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DFC9207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjnuO-0008Gu-Or
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 13:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jjntL-0006gR-Ja; Fri, 12 Jun 2020 13:54:59 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51005)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jjntK-0004BT-0E; Fri, 12 Jun 2020 13:54:59 -0400
Received: by mail-wm1-x344.google.com with SMTP id l17so8952935wmj.0;
 Fri, 12 Jun 2020 10:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=p75piuRGRVdgKrKUdWtk1/TByzVc4JQeMSyMnV9UFU8=;
 b=rjikRcBDQeK+zQ7+ulLj+9QEGm5yyg6TCkrHk013URk7NhUSnyJES7MTCK8VPJPKc+
 IJzFAA58xODzS2T9KEnCMy0aVc4wAu9/wO2IYA1XzOd+ikgIdFqg6AOlrNSkLbTlPqTy
 01unp6dV86Su+sv6VRP/BRrOyqdPWcfRpxfYkt9JuEp2IbaTcKTbbQjgSaS1Aw9yXtpu
 YGt2YRmNbSXJzyW2nV6JLfcIDHRXpV7i2N/ackAZHP1XNVqpJwsmU4wi+c15Bj+fTveR
 VtvJ/1KtG3P+IZKwNP3qV0lsxlRlkvwNttjfcRFA1kEkiVk89WkqjIm7am5oJSSXSnZs
 Qytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=p75piuRGRVdgKrKUdWtk1/TByzVc4JQeMSyMnV9UFU8=;
 b=gaQJXuDU1+3nqkbiuK+bqDh3teaQMt8fIhJB7X8ImDSY6jHTTXbQXJzaza38DuI/M5
 5G18l79Yb8yn/DIOfbOvA7DCaVx9dmgzMxWTUDI3sOPUZ2fzPVWI65sZVOyxryhTcMZd
 +AnyrGtXjRhM8BhTRGHncLlrcVCFxs+vXiNH1vZC9ZlY4CX8Asm1HSan8DVhYRxQXatd
 HKOnYsoxO+16JF1vElUnn+khr95RkgxceDSezLkxywOyDsytUoMsnmVNjtg078XEiTu+
 hkP388FRhjjsBMwNCzxpoRo3GRLOq3kIQFKuQER1SOOEPUPQnB/QX0QmwKZTtnh94O9R
 SrXQ==
X-Gm-Message-State: AOAM533l9tBYvdEjQpmOHdLx3XqH9vGKjUWNvKwSS+cJN2CxhUhk0xAW
 BP8bZemcqCqzcv6l+bQa93Hk5Tc0
X-Google-Smtp-Source: ABdhPJweeqU2QSOHqoQkhmDZbgXq30e+gvb2y36PpbYjeLpKDj5wYo3tvUiSY9gVQOfVdIQUfMjEww==
X-Received: by 2002:a1c:4189:: with SMTP id o131mr119559wma.110.1591984483567; 
 Fri, 12 Jun 2020 10:54:43 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id e12sm11288658wro.52.2020.06.12.10.54.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 10:54:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 0/5] hw/misc: Add LED device
Date: Fri, 12 Jun 2020 19:54:35 +0200
Message-Id: <20200612175440.9901-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Esteban Bosse <estebanbosse@gmail.com>,
 qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

These patches are part of the GSoC unselected 'QEMU visualizer'
project.  As the AVR port is not merged, I switched to microbit
to keep working on it.

This series presents a proof of concept of LED device that can
be easily connected to a GPIO.
The LED emit QMP events, so an external visualizer can display
the LED events.

Since v1: addressed Eric Blake review comments
- Added QMP rate limit

This is stable enough to be used for the GSoC UI.

Next steps planned:

- integrate Zephyr test

- have a centralized container for all the machine's LEDs, to
track state changes in a single place and send less QMP events
(grouping changes, restricted to what actually changed).
[see to include keyboard LEDs].

- look at LED array/matrix such 7segments.

Regards,

Phil.

$ git backport-diff -u rfc-v1
Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/5:[0004] [FC] 'hw/misc: Add a LED device'
002/5:[0027] [FC] 'hw/misc/led: Add LED_STATUS_CHANGED QAPI event'
003/5:[----] [--] 'hw/misc/led: Add create_led_by_gpio_id() helper'
004/5:[----] [--] 'hw/arm/microbit: Add a fake LED to use as proof-of-concept with Zephyr'
005/5:[----] [--] 'hw/arm/tosa: Use LED device for the Bluetooth led'

Philippe Mathieu-Daudé (5):
  hw/misc: Add a LED device
  hw/misc/led: Add LED_STATUS_CHANGED QAPI event
  hw/misc/led: Add create_led_by_gpio_id() helper
  hw/arm/microbit: Add a fake LED to use as proof-of-concept with Zephyr
  hw/arm/tosa: Use LED device for the Bluetooth led

 qapi/led.json         |  47 ++++++++++++++++
 qapi/qapi-schema.json |   1 +
 include/hw/misc/led.h |  45 +++++++++++++++
 hw/arm/microbit.c     |   3 +
 hw/arm/tosa.c         |   7 +--
 hw/misc/led.c         | 126 ++++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS           |   7 +++
 hw/arm/Kconfig        |   2 +
 hw/misc/Kconfig       |   3 +
 hw/misc/Makefile.objs |   1 +
 hw/misc/trace-events  |   3 +
 qapi/Makefile.objs    |   2 +-
 12 files changed, 242 insertions(+), 5 deletions(-)
 create mode 100644 qapi/led.json
 create mode 100644 include/hw/misc/led.h
 create mode 100644 hw/misc/led.c

-- 
2.21.3


