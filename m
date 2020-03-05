Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C70C3F2D7
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 01:06:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9498620842
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 01:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bH2l9nJf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9498620842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9exc-0006Co-Pj
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 20:06:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39428)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9ewa-00046c-MW
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 20:04:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9ewZ-0005GR-Di
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 20:04:56 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45372
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9ewZ-0005Fl-7s
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 20:04:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583370294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ASuvXJzSwaay1xbKHLSIhs2mAWSbDz0oulJY6D76muw=;
 b=bH2l9nJfpl00DmiLWPfsJqhct0Atj8EK+RcQUpIBkXLDOXlCcXURERLEnkctques+b//JX
 SxS36bD1HpkE4y6raPSkHM0P/o+8+OXGMQPSa/sYigvNkV94/Pc24L7LGMFAYj7Y1W0Lo5
 lC8UhdAThy4trA0yzKms+EgaSjpE6os=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-N6PMxI_5MKSNpZcuE_jKFQ-1; Wed, 04 Mar 2020 20:04:50 -0500
X-MC-Unique: N6PMxI_5MKSNpZcuE_jKFQ-1
Received: by mail-wr1-f70.google.com with SMTP id n12so1610822wrp.19
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 17:04:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=fm9u3HbkueAjiabsbTX9B1kjiGGd9Wj6z2DYzKRIZKE=;
 b=ebzeTqKDo3Lgy4l/J3MJwy/++d0NAxtQjNPqd/jPngcNxWfC41V5BZnABHgdEOkQq6
 tVgM/BUgx6GJ8bEbQ9YCjQ4UJEPFEQ0V/ubjmVPbRN0NEbseELTosAfA8xLSiJX5Vfg6
 x56c5v+QtxNmOFKrqQD6iss6OZQJXkKkjs8vDO1HG0N6gJGlCDTJBcYpTCtVoqzM9h88
 gzb3bjRLtpvhURK3HPeqWSa1JBc0dCWlhiALaLi+ANG4TSkO7Zu6CSZbUklcGQZrXXez
 SFwvOGzOQDUGbaeJr8ORLAKmRe4+StJI1bu8Q9mwZKPIOkPPrP66g/xOHDUBoCYxWOcf
 Jc0A==
X-Gm-Message-State: ANhLgQ1Msrsq9ayqtMA0GUDHnBEGfKDdg1BYTH4ovQ02lITxUjlmcgPg
 8mIJJvBAqOOT17F3LJnDj+MYrkhAYMqXJ55+fkoqX+fNpvGX1/86ONdAHqBjhFSltJYJ2vFGHgJ
 39rvmbDj4ZFNcS8U=
X-Received: by 2002:a1c:a515:: with SMTP id o21mr6098366wme.124.1583370289253; 
 Wed, 04 Mar 2020 17:04:49 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtFHPd6DevqhvKtgWk19aGA+th8kpFNpqu6vlf2jO/7T3jFqDrpCT0SrzLlWlKVkwxjehcq4A==
X-Received: by 2002:a1c:a515:: with SMTP id o21mr6098337wme.124.1583370288963; 
 Wed, 04 Mar 2020 17:04:48 -0800 (PST)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id o5sm7228822wmb.8.2020.03.04.17.04.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2020 17:04:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] hw/net,virtfs-proxy-helper: Reduce .data footprint
Date: Thu,  5 Mar 2020 02:04:43 +0100
Message-Id: <20200305010446.17029-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-trivial@nongnu.org,
 Jason Wang <jasowang@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

More memory footprint reduction, similar to:
https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg00984.html

The elf-dissector tool [1] [2] helped to notice the big array.

[1] https://phabricator.kde.org/source/elf-dissector/
[2] https://www.volkerkrause.eu/2019/06/22/elf-dissector-aarch64-support.ht=
ml

Philippe Mathieu-Daud=C3=A9 (3):
  hw/net/e1000: Add readops/writeops typedefs
  hw/net/e1000: Move macreg[] arrays to .rodata to save 1MiB of .data
  virtfs-proxy-helper: Make the helper_opts[] array const

 fsdev/virtfs-proxy-helper.c | 2 +-
 hw/net/e1000.c              | 6 ++++--
 hw/net/e1000e_core.c        | 6 ++++--
 3 files changed, 9 insertions(+), 5 deletions(-)

--=20
2.21.1


