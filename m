Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D29BC47257
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 17:28:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47B7320707
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 17:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BLnYA3jh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47B7320707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVetk-00082w-Fk
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 13:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVepx-0001wr-Co
 for qemu-devel@nongnu.org; Mon, 04 May 2020 13:25:01 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32494
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVepw-0005Gj-2b
 for qemu-devel@nongnu.org; Mon, 04 May 2020 13:25:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588613099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=iA8FqqMjH3exPTKpefZtcF5t6yrp6h6MGztNneH3c1g=;
 b=BLnYA3jhsrIIyYWpbkEhDb0AMgMSRMj8J7T3TOGdtTw0+C4Bkmyv/waRYi1jNZiUAOBapH
 WYwezVSKwZlY14c/Yc6Z5mYPbdpg0mKehuysJ5gLwgCXljGDQci8W4JmSd+AN0ONdvJRiq
 xzJ1rghj/59PJ85Ua4oqQqOayUNMJps=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-pMM__hxpM0WrONQyXSNj9A-1; Mon, 04 May 2020 13:24:51 -0400
X-MC-Unique: pMM__hxpM0WrONQyXSNj9A-1
Received: by mail-wr1-f70.google.com with SMTP id h12so200687wrr.19
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 10:24:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=D57NXlFkbN/fOUMJdqhRrNFq2S4cg5DUCwfIfYPqP+M=;
 b=ulRukPWN9Lhu6AFzgH3VKDKkQ9FyMdYKpoPs40fk/PkbVl74ThvOPD72f22nTiXlH5
 f8YI+EJWJU31W+AskewP1WHeB9q1JjsV6j9VF3vZcQl9MvzILYotzfntfn0zUjKm3jiN
 Op5D8Wm0kFA+hhVadLGE4OIYUdIJd4Pkcwd9rvQaW90797pXcP+Efa4iM7FAuluK5hG2
 Qb5+XrcvGoxwrWJFJVDNvLixhtmRKFW04NhLqHwcDNyir26/zblrbQ38Yat4nFI1Xfgz
 blTCyMVqREGQg7aYluMMLeIVmu+L8GnByVX47sWwlkqlS2FpcSaY1W1VWOCSrOl+KF5h
 XWeg==
X-Gm-Message-State: AGi0Pua676PUmFXcu3IUSbtB7Gc0Rf5BNMA7buKkhnbMpAkb+xg4+5if
 xT5sT4ZwI7lmJKDUq0v9wKBA3qfFAk5LqdlCO3hG8u2LzrdLTAhw1NGVAoXzE/k7VFXW8YH63jv
 l07WhOzX5q92ZBpU=
X-Received: by 2002:a05:6000:11cb:: with SMTP id
 i11mr97444wrx.339.1588613089893; 
 Mon, 04 May 2020 10:24:49 -0700 (PDT)
X-Google-Smtp-Source: APiQypKlMkuZVlpdhvOiUO/wJ9lpx6/7GL132j3ags+a+xtmueRGFMqRPnaCzL9cnThYF0yyKCtz5w==
X-Received: by 2002:a05:6000:11cb:: with SMTP id
 i11mr97414wrx.339.1588613089638; 
 Mon, 04 May 2020 10:24:49 -0700 (PDT)
Received: from x1w.redhat.com (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id a8sm7329475wrg.85.2020.05.04.10.24.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 10:24:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/5] target/arm: Restrict TCG cpus to TCG accel
Date: Mon,  4 May 2020 19:24:43 +0200
Message-Id: <20200504172448.9402-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 08:14:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These are the uncontroversial patches from "Support disabling
TCG on ARM (part 2)"
https://www.mail-archive.com/qemu-devel@nongnu.org/msg689168.html

The other patches are blocked by the "accel: Allow targets to
use Kconfig" series:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg689024.html

Patch #4 is new "Restrict v8M IDAU interface to Aarch32 CPUs".

Since v2:
- Fixed set_feature() clash trying to KISS
  https://www.mail-archive.com/qemu-devel@nongnu.org/msg697523.html
- Fixed aarch64-linux-user build failure reported by Peter:
  https://www.mail-archive.com/qemu-devel@nongnu.org/msg699319.html

Since v1:
- Dropped 'Make set_feature() available for other files' patch
  which fails to build with KVM only, see:
https://lists.gnu.org/archive/html/qemu-devel/2020-04/msg03843.html

Many thanks to Richard Henderson for his patience (again...)!

Regards,

Phil.

Philippe Mathieu-Daud=C3=A9 (4):
  target/arm/kvm: Inline set_feature() calls
  target/arm/cpu: Use ARRAY_SIZE() to iterate over ARMCPUInfo[]
  target/arm/cpu: Restrict v8M IDAU interface to Aarch32 CPUs
  target/arm: Restrict TCG cpus to TCG accel

Thomas Huth (1):
  target/arm: Make set_feature() available for other files

 target/arm/cpu.h         |  10 +
 target/arm/cpu.c         | 662 +-------------------------------------
 target/arm/cpu64.c       |  18 +-
 target/arm/cpu_tcg.c     | 664 +++++++++++++++++++++++++++++++++++++++
 target/arm/kvm32.c       |  13 +-
 target/arm/kvm64.c       |  22 +-
 target/arm/Makefile.objs |   1 +
 7 files changed, 698 insertions(+), 692 deletions(-)
 create mode 100644 target/arm/cpu_tcg.c

--=20
2.21.3


