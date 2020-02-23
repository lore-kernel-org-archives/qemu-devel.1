Return-Path: <SRS0=CqNf=4L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF62C35673
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2020 23:27:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AD3C206E2
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2020 23:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z/WUJpkv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AD3C206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j60fA-0000e1-69
	for qemu-devel@archiver.kernel.org; Sun, 23 Feb 2020 18:27:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37672)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j60cp-0005lO-KM
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 18:25:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j60co-0004OL-Gb
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 18:25:27 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48273
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j60co-0004O0-CK
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 18:25:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582500325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4RA2RXjVvief1/X+N/X14XUkKx3HWkHABgxWL5qIrf0=;
 b=Z/WUJpkvgYWrs/D2btkM006Ul/ObiBh8F/EZi/amvtZMOSEan+vTVcHmqBgQIRG6FkviyX
 6zWSsPdAy+ntDzdR4CBpnOMQLjPZh0QHz3cjQnwmRIvXFH20PrEPdi3pI+FVTOR/wd3XZY
 0ejnMMIzLwzUsU/sqLQPugug+mZeh9Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-zWGRxfWpPSmQr4Fm_VlHGA-1; Sun, 23 Feb 2020 18:25:20 -0500
X-MC-Unique: zWGRxfWpPSmQr4Fm_VlHGA-1
Received: by mail-wr1-f70.google.com with SMTP id p8so4653804wrw.5
 for <qemu-devel@nongnu.org>; Sun, 23 Feb 2020 15:25:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jQfvOcsnThQ84nK0vy5Vkt9YJVQSFCuJ8L7E/yhcLcU=;
 b=sAp7/gY4TUuv5Lp0R+WDmmZelVW/LKjSqpDrbeEJLdhCYfICxSyUw/YvLxLiAIL4Cz
 ZD8S2dqc4udSXRRtdFKWdyLCvxvOfTJcmZwOFO3Y3bvd65hH72mEuL3ftrQuyzhhQopV
 UoEXlmV7Heu6GcL3hgQjFKU0AutIN8goDFfZtOzIF4NS6TMM7roVikkJPqbcgVdJafOB
 PC4O8PlWmvRQioVYscjD/dSjyCut1R8ufWWPm3cHfqfrkW2+T3uGWwnLYEX7Mmmt27Lr
 FmH2UIv5ylV4kIm8e6iT+xzMtmZEhzRT9N+bFTTB3DTyId/6T7G9HFWItI7TbtGaf28p
 Kgpg==
X-Gm-Message-State: APjAAAWsPUykHDXznLc7pTPoFn5y9OQ10EhQhOkdkO8WMnaxMFsCpM6W
 JS/sG66XB/q3nzrUzXB90fBZ0I3woJ6stgtMIDxpOmDc3flUtY6VUWSm2PxKA8wUrbTCcZ1fuOQ
 g/SX8O1oF6B1OsTs=
X-Received: by 2002:a5d:4dc5:: with SMTP id f5mr64411061wru.114.1582500318817; 
 Sun, 23 Feb 2020 15:25:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqy58mtcfEtpuNKi1b4kRyO3RJ5YotKTa1tpZRy+XZOauf3Lys/wzcDOLKNgkHtXoD6PzG2KGg==
X-Received: by 2002:a5d:4dc5:: with SMTP id f5mr64411045wru.114.1582500318622; 
 Sun, 23 Feb 2020 15:25:18 -0800 (PST)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id c9sm15671102wrq.44.2020.02.23.15.25.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2020 15:25:18 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] hw/arm/integratorcp: Map Audio controller and parallel
 flash
Date: Mon, 24 Feb 2020 00:25:14 +0100
Message-Id: <20200223232516.13802-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

While looking whether Thomas's test patch [*] requires a respin
or not, I noticed we could complete the integrator model.
Thomas patch still applies properly ;)

[*] https://www.mail-archive.com/qemu-devel@nongnu.org/msg675828.html

Philippe Mathieu-Daud=C3=A9 (2):
  hw/arm/integratorcp: Map the audio codec controller
  hw/arm/integratorcp: Map a CFI parallel flash

 hw/arm/integratorcp.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

--=20
2.21.1


