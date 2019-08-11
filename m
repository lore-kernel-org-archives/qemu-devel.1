Return-Path: <SRS0=60Ee=WH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437F3C433FF
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 21:34:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16E9220844
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 21:34:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16E9220844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwvTm-0003YS-8K
	for qemu-devel@archiver.kernel.org; Sun, 11 Aug 2019 17:34:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58155)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <balaton@eik.bme.hu>) id 1hwvSy-000207-1z
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 17:33:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1hwvSw-00045v-V4
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 17:33:27 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:55462)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1hwvSw-0003yR-NU
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 17:33:26 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 679AA74C707;
 Sun, 11 Aug 2019 23:33:12 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id CBA497456CB; Sun, 11 Aug 2019 23:33:11 +0200 (CEST)
Message-Id: <cover.1565558093.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Sun, 11 Aug 2019 23:14:53 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
Subject: [Qemu-devel] [PATCH 0/7] Resend of all outstanding ati-vga patches
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

This is the latest version of all outstanding ati-vga patches
collected in one series. Some of these or previous versions of them
were sent individually before but these are now superceding all
previous patches that are not yet in master and this series is all
that should be needed.

This should fix color problems due to endianness with most drivers (if
such problems remain with some Linux drivers those should be cross
checked with real hardware), fixes running FCode ROM with appropriate
OpenBIOS patches for mac99 and includes fixes that will be needed to
get picture with MacOS 9 but that may also need VBlank interrupts
emulated so it won't boot yet.

Regards,
BALATON Zoltan

BALATON Zoltan (7):
  ati-vga: Add registers for getting apertures
  ati-vga: Add some register definitions for debugging
  ati-vga: Fix GPIO_MONID register write
  ati-vga: Fix cursor color with guest_hwcursor=3Dtrue
  ati-vga: Fix hardware cursor image offset
  ati-vga: Attempt to handle CRTC offset not exact multiple of stride
  ati-vga: Add limited support for big endian frame buffer aperture

 hw/display/ati.c      | 68 +++++++++++++++++++++++++++++++++++++--------=
------
 hw/display/ati_dbg.c  |  9 +++++++
 hw/display/ati_int.h  |  1 +
 hw/display/ati_regs.h | 11 +++++++++
 4 files changed, 71 insertions(+), 18 deletions(-)

--=20
2.13.7


