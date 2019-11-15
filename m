Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1158BC43215
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 12:34:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E127B20723
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 12:34:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E127B20723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVaoO-0000kI-Sa
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 07:34:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45259)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Filip.Bozuta@rt-rk.com>) id 1iVan4-0007pB-Hz
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 07:33:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Filip.Bozuta@rt-rk.com>) id 1iVan3-0003JX-8P
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 07:33:30 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:50425 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Filip.Bozuta@rt-rk.com>)
 id 1iVan2-00030Y-TI
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 07:33:29 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 9085D1A21B7;
 Fri, 15 Nov 2019 13:32:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw493-lin.domain.local (rtrkw493-lin.domain.local
 [10.10.14.93])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 57A121A1D8B;
 Fri, 15 Nov 2019 13:32:23 +0100 (CET)
From: Filip Bozuta <Filip.Bozuta@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 for 5.0 0/6] linux-user: Add support for real time clock
 ioctls
Date: Fri, 15 Nov 2019 13:32:10 +0100
Message-Id: <1573821136-30219-1-git-send-email-Filip.Bozuta@rt-rk.com>
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 89.216.37.149
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
Cc: laurent@viver.eu, Filip.Bozuta@rt-rk.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add ioctls for all RTC features that are currently supported in linux kernel.

This series covers following 22 iocts:

    * RTC_AIE_ON
    * RTC_AIE_OFF
    * RTC_UIE_ON
    * RTC_UIE_OFF
    * RTC_PIE_ON
    * RTC_PIE_OFF
    * RTC_WIE_ON
    * RTC_WIE_OFF
    * RTC_ALM_SET
    * RTC_ALM_READ
    * RTC_RD_TIME
    * RTC_SET_TIME
    * RTC_IRQP_READ
    * RTC_IRQP_SET
    * RTC_EPOCH_READ
    * RTC_EPOCH_SET
    * RTC_WKALM_SET
    * RTC_WKALM_RD
    * RTC_PLL_GET
    * RTC_PLL_SET
    * RTC_VL_READ
    * RTC_VL_CLR

The functionalities of individual ioctls were described in this series
patch commit messages.

Testing method:

    Mini test programs were written for each ioctl. Those programs were
    compiled (sometimes using cross-compilers) for the following 
    architectures:

        * Intel 64-bit (little endian)
        * Power pc 32-bit (big endian)
        * Power pc 64-bit (big endian)

    The corresponding native programs were executed without using 
    QEMU on following hosts:

        * Intel(R) Core(TM) i7-4790K CPU @ 4.00GHz
        *.7447A, (ppc32 host)

    All applicable compiled programs were in turn executed through QEMU
    and the results obtained were the same ones gotten for native
    execution.

Example of a test program:

    For ioctl RTC_RD_TIME we have used the following test program:

    #include <stdio.h>
    #include <stdlib.h>
    #include <linux/rtc.h>
    #include <fcntl.h>
    #include <linux/input.h>
    #include <sys/types.h>
    #include <unistd.h>

    #define ERROR -1

    int main()
    {

        int fd = open("/dev/rtc", O_RDWR | O_NONBLOCK);

        if(fd == ERROR)
        {
            perror("open");
            return -1;
        }

        struct rtc_time cur_time;

        if(ioctl(fd, RTC_RD_TIME, &cur_time) < 0)
        {
            perror("ioctl");
            return -1;
        }

        printf("Second: %d, Minute: %d, Hour: %d, Day: %d, Month: %d, Year: %d,",
            cur_time.tm_sec, cur_time.tm_min, cur_time.tm_hour, 
            cur_time.tm_mday, cur_time.tm_mon, cur_time.tm_year);

        return 0;
    }

Limitations of testing:
    
    My test host (intel pc) has RTC that doesn't support all
    RTC features that are accessible through ioctls. This
    means that testing can't discover functionality errors
    related to the third argument of ioctls that are used
    for features that are not supported. For example,
    running my test program for ioctl RTC_EPOCH_READ gives
    the error output: inappropriate ioctl for device. As 
    expected, i get the same output through QEMU which means
    that this ioctl is recognized in QEMU but doesn't really
    do anything beacuse it is not supported in my computer's
    RTC.

    Conclusion: Some RTC ioctls need to be tested on computers
    that support their functionalities so that we can be sure
    that they are really supported in QEMU. In absence of such
    test hosts, we need to carefully check the specifications
    of those ioctls manually and update implementations
    accordingly.

v3:

    * changed two instances of MK_PTR(TYPE_ULONG) to TYPE_ULONG

v2:

    * added description of each ioctl in patches
    * wrote a more detailed cover letter with description of testing
    * changed one instance of TYPE_INT to MK_PTR(TYPE_INT)

Filip Bozuta (6):
  linux-user: Add support for enable/disable RTC features using ioctls
  linux-user: Add support for read/set RTC time and alarm using ioctls
  linux-user: Add support for read/set RTC periodic interrupt and epoch
    using ioctls
  linux-user: Add support for get/set RTC wakeup alarm using ioctls
  linux-user: Add support for get/set RTC PLL correction using ioctls
  linux-user: Add support for read/clear RTC voltage low detector using
    ioctls

 linux-user/ioctls.h        | 23 +++++++++++++++++++++++
 linux-user/syscall.c       |  1 +
 linux-user/syscall_defs.h  | 36 ++++++++++++++++++++++++++++++++++++
 linux-user/syscall_types.h | 25 +++++++++++++++++++++++++
 4 files changed, 85 insertions(+)

-- 
2.7.4


