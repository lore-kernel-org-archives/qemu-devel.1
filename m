Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75424C48BD6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 14:23:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 429C120828
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 14:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tru-agency.20150623.gappssmtp.com header.i=@tru-agency.20150623.gappssmtp.com header.b="AyBlyC6U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 429C120828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tru.agency
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgVIl-0007Ds-Gb
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 10:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33390)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <devanshu@tru.agency>) id 1hgNCZ-00015I-57
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 01:44:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <devanshu@tru.agency>) id 1hgNCX-0002H2-QJ
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 01:44:07 -0400
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36]:43774)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <devanshu@tru.agency>) id 1hgNCX-0002Eb-AM
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 01:44:05 -0400
Received: by mail-yb1-xb36.google.com with SMTP id 5so852692ybj.10
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2019 22:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tru-agency.20150623.gappssmtp.com; s=20150623;
 h=mime-version:from:date:message-id:subject:to;
 bh=FH8L9XugYTc1dXWOZy32m4CJp3s4dBPLd2vBbpVcljQ=;
 b=AyBlyC6UVpDN4gEyMaFakYW6zFgdW+HTbGe7Xr204HcXVPJGGc+co06tNtpTBnEpJI
 Ac/8qS91Vnos8MilaFn5ulDNurR0GcJcq7jdDG8vUSlmgSn6PTAzEtw7iAFuu2SKXZr8
 ODF+Gpvm8XxEFW7DV6PhXVVcaX+JpfqjOLppW/D2Bn6/zFkmVW9EvsivZjZ31SEEr/Oq
 Vekaeicju98R24710grT/u4M5leUiLz2b7HwXy+W0lwWHPRCsWzy6w0JmAJplHyZLLRR
 JBvJ8OI77xAQH/ZTm8zpOfyrsQ8ZhjsAe68Sq8yhBsXGcGkS0vnczXhr1oYb0Nbv4vwc
 aA1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=FH8L9XugYTc1dXWOZy32m4CJp3s4dBPLd2vBbpVcljQ=;
 b=SvIkoHGDXfht1XIU0r37Z1wsnY3L+xDhvBqmtwCsvo6ufnyo/3Pww4r00RTxD0pKtm
 fY5zJlEPzI5Y9WJczGEL6h+SJrwuSLtGWOD0fJRfD3kq7RtQLRDD7mXGBG+w7c0WhL6s
 98tOc4KF9N/lbJR140BjbCdRv0GLQhxIrhYZCT0LDC13pwlM8/KDY8QNQHveH+mc5lLP
 e5W5+TRYZa2kB9wJqn1F9jc3jVmICT0Ml3McubRPiNdwmX1V15R+uxAyyIPYWTW0yUFl
 DZ+Xh9289pSNjsqMjkENulR6/BO+uSkbx7Y2AqDQmFzN6aWo0Zb32MqZWf71V63JokYL
 PcjA==
X-Gm-Message-State: APjAAAXjXtBtKeP78NBW417HeG/IsQrZ+QpX3Kn3KJVykASPlvi7hRzM
 Rs5D/qPoStaFPpDSCy+yHwMtoMPnXZYsvMJc4NwsiA8Btpm1
X-Google-Smtp-Source: APXvYqyyztz3Zh8xIa/aUBEcYf0alFgHVgJpzTE7+O1tVm+ozZXNzESP4L1O8SKLRsfUKuh3sGtbIMkJ9Md9MdfthdQ=
X-Received: by 2002:a25:804e:: with SMTP id a14mr1451106ybn.465.1561614243049; 
 Wed, 26 Jun 2019 22:44:03 -0700 (PDT)
MIME-Version: 1.0
From: Devanshu Goyal <devanshu@tru.agency>
Date: Thu, 27 Jun 2019 11:13:52 +0530
Message-ID: <CAGz47Su_8mykUWaoxA34AD0Y8v_PgWE9wA5EQB+V25EgW9gH_w@mail.gmail.com>
To: qemu-devel@nongnu.org
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b36
X-Mailman-Approved-At: Thu, 27 Jun 2019 10:13:37 -0400
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: [Qemu-devel] Nothing to Boot Error
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

Hi All,

I am trying to install macOS HighSierra using qemu-system-x86_64 . I am
stuck at IPXE Error that says : *Nothing to boot: No such file or directory
(http://ipxe.org/2d03e13b <http://ipxe.org/2d03e13b>)*

*Host System : macOS Mojave*
*Command : **qemu-system-x86_64 -boot d -cdrom
/Users/devanshu/Desktop/macOSsierra.iso -m 4096M -hda
/Users/devanshu/Documents/qemu/Qemu-4.0-OSX-24-04-2019/apple.img*

*Looking forward to hearing from you*

-- 
Regards,
*Devanshu Goyal*
