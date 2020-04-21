Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1BBC54FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:18:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 121E22064C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIjbl7cO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 121E22064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQrql-0006tM-6n
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 08:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58970)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQrpM-0004uk-Ky
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:16:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQrpI-0005vZ-UR
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:16:36 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:40530)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQrpI-0005rh-Eb; Tue, 21 Apr 2020 08:16:32 -0400
Received: by mail-wr1-x42c.google.com with SMTP id k13so15017456wrw.7;
 Tue, 21 Apr 2020 05:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=huvSKrhwbgnnyBc8SFTyGesgTCOFYnJW8oU3B5ttXk0=;
 b=iIjbl7cOzsklTG+yNcO4jW0X1JPwvYVJNIZwUhp1uGHocVcQnia//77Oo/Q9nss+GF
 ZGovnobWbYyp2Bz0lbvG3xd1WaR1J5vMiGottxN7V23Rptwz3K7HzrLkr6Az7cIbWxF8
 sLoCVuj2r59WGbT2ikrCVHBNebBqUPS9T12uLc4SrXCq1qFUQsq2fXYhXuCQPd/WpOYm
 dmbJHi0ow6T+nhDbeMs1euBJ1SI1Yb2KRMtIkEpeQzkd2517IwyC2bfjeb1Rs62tOAuf
 rooRt3reLDP9Rjb2LYjnk9ZlP45qeq/SEGuf6Sc/eoChneCfoXfeN/Fwj+IsRaMpb7aj
 UQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=huvSKrhwbgnnyBc8SFTyGesgTCOFYnJW8oU3B5ttXk0=;
 b=AvTfKDr3gcvjNaExN8qxOO0UGctNGNxXRqSYQvnNzSOJNdhihSjO+z16vgoUUHFB77
 ipd3HAwV0yzAdb7sZ0X4E0/6YfszSD8G0P/vpbJCjVacH0MuVCpV9KVTsd4L81F8nlIk
 gpXkMVbzcsm5tifGu0Gqa90nJfyjaFvEBXbs06H2FjSMkj/YZxnviu6dm03sZE4OWLFq
 6X48OvxwHWpNLiVPNHyhJ6WN1+HU7S7aL21pmm3yhpe/AyYbhGUfIL+w6EY8NLxI7BOe
 2Ti/DIZgQZdsGYinK6Nn+lBJp16yvx8nIw9nx5iMNEOLxyl9LdJ3eqysiNXXEyogpFzs
 1+2g==
X-Gm-Message-State: AGi0Pub/vrxaDMno+xh9Z1iIWA5LBmT2eVCXjA1pnj3bz9xHO138KKAY
 FU2tfkWhvuWJHdu5wu0UMulvSW6g8CI=
X-Google-Smtp-Source: APiQypKbLPg5jAwERC099E5WmYT+SzxtZFkeWcINgt/NfsldvPgF+bmSPcaHNuupechgDfhpPqDO9w==
X-Received: by 2002:a5d:4dcb:: with SMTP id f11mr23469392wru.174.1587471389101; 
 Tue, 21 Apr 2020 05:16:29 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id z76sm3761140wmc.9.2020.04.21.05.16.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 05:16:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 00/17] hw/misc: Introduce a temperature sensor interface
Date: Tue, 21 Apr 2020 14:16:09 +0200
Message-Id: <20200421121626.23791-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42c.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::42c
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
 Joaquin de Andres <me@xcancerberox.com.ar>, Michael Tokarev <mjt@tls.msk.ru>,
 Keith Busch <keith.busch@intel.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-arm@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This series is part of a bigger one I was preparing for a GSoC
project, but unfortunately no student got interested.

The idea is to allow device with temperature sensors to use a
common API with temperature operations.

While guest are running, you can modify the temperatures to check
the guest reactions. Some devices can trigger IRQ when temperature
pass thresholds. Somehow similar to inject NMI.

Some devices could also modify their temperature regarding their
workload.

The tsc2xxxx devices are interesting but can't be converted as
they predate QOM/QDev.

Temperature changes rate is <1Hz (not enforced in this model) so
using a QMP to get/set is acceptable.
The query-temperature-sensors command is for informative purpose,
also acceptable for QMP use.

Next step might be to publish QMP events when temperature change.

The original goal is to better interface ADCs with real world data.
Here using QMP is not an option. Here the idea is to use the
AudioState and audio_sample API from "audio.h" but it seems not
very used, see: https://bugs.launchpad.net/qemu/+bug/1861677

What is not clear yet to me is what's the best way to externally
set a specific sensor temperature. The TMPxxx I2C sensors use
object_property_set_int(). I could move that to the temp-sensor
interface but it seems a bit overkill. Any simpler idea?

Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Cédric Le Goater <clg@kaod.org>
Cc: Joel Stanley <joel@jms.id.au>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Joaquin de Andres <me@xcancerberox.com.ar>

Philippe Mathieu-Daudé (17):
  hw/misc: Introduce the temperature sensor interface
  hw/misc/temp-sensor: Add 'query-temperature-sensors' QMP command
  hw/misc/temp-sensor: Add 'info temp' HMP command
  hw/misc/tmp105: Extract get_temp_mC() and set_temp_mC() helpers
  hw/misc/tmp105: Implement the 'temperature-sensor' qdev interface
  hw/misc/tmp421: Add definition for SENSORS_COUNT
  hw/misc/tmp421: Extract get_temp_mC() helper
  hw/misc/tmp421: Extract set_temp_mC() helper
  hw/misc/tmp421: Implement the 'temperature-sensor' qdev interface
  hw/misc/bcm2835_thermal: Hold the temperature in the device state
  hw/misc/bcm2835_thermal: Implement the 'temperature-sensor' interface
  hw/misc/bcm2835_property: Hold the temperature in the device state
  hw/misc/bcm2835_property: Implement the 'temperature-sensor' interface
  hw/display/ads7846: Implement the 'temperature-sensor' qdev interface
  hw/ide/qdev: Implement the 'temperature-sensor' qdev interface
  hw/misc/imx6ul_ccm: Implement the 'temperature-sensor' qdev interface
  tests/qtest/tmp105-test: Trivial test for TempSensorClass

 qapi/misc.json                     |  24 +++++++
 include/hw/misc/bcm2835_property.h |   1 +
 include/hw/misc/bcm2835_thermal.h  |   1 +
 include/hw/misc/temp-sensor.h      |  69 +++++++++++++++++++
 include/monitor/hmp.h              |   1 +
 hw/display/ads7846.c               |  38 +++++++++++
 hw/ide/qdev.c                      |  14 ++++
 hw/misc/bcm2835_property.c         |  39 ++++++++++-
 hw/misc/bcm2835_thermal.c          |  42 ++++++++++--
 hw/misc/imx6ul_ccm.c               |   7 ++
 hw/misc/temp-sensor.c              | 102 +++++++++++++++++++++++++++++
 hw/misc/tmp105.c                   |  51 +++++++++++----
 hw/misc/tmp421.c                   |  74 ++++++++++++++++-----
 tests/qtest/tmp105-test.c          |  18 +++++
 MAINTAINERS                        |   6 ++
 hmp-commands-info.hx               |  11 ++++
 hw/misc/Makefile.objs              |   1 +
 17 files changed, 463 insertions(+), 36 deletions(-)
 create mode 100644 include/hw/misc/temp-sensor.h
 create mode 100644 hw/misc/temp-sensor.c

-- 
2.21.1


