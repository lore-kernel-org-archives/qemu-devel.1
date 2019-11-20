Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2983AC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 10:00:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA77322429
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 10:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bUIcqQTm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA77322429
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXMms-0004RI-Vi
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 05:00:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49486)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iXMlr-0003cd-NA
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 04:59:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iXMlq-0004fx-LE
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 04:59:35 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20782
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iXMlq-0004fl-HO
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 04:59:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574243974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Z2xd3M3tiXP0Dqy8cIxALAd/wWaz02NtNyCEX6zrE08=;
 b=bUIcqQTmH77Q7uZGmXRTlYni8f1dkwqEGlxg0dkdfYKqj0AZpFB/QdTIL6soqz/FXJJL4g
 d6OTkZpPTG7o5mhRN5EwoU18LKXfSQ9BRrOeJMvMM3Y6bjNGYRk+P1qvVWEO3wfzM/eqUN
 vdE7kW0aYAWUNIy4b4O1ZzQRScHVQ8c=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-Eg3HlL5ZOn6DMd-23TUapQ-1; Wed, 20 Nov 2019 04:59:33 -0500
Received: by mail-qv1-f70.google.com with SMTP id w2so16735573qvz.10
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 01:59:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=/t2R2phiaDkjRZIymqwYoEV3HWCER9tcdkBnsMPy1Mg=;
 b=k6TG546uUm9f4xA1nESpT9STQImqCMPfXNcoBdvxMUs12ctMoUS1GnGVhWSxmaaamm
 rUHMf4MrJWx1sJnDZ2AS8MLl5NNIc/TDsQXCHsyL9/YyileB98ne2j02UMzPa6Evrh2F
 LzAe/Vn3Uvk6Qdelp7pPSjAkV3CmSc6968JLRr7Lr0KJOIALMS3ntnFGJ0F/k5f2Ak1x
 8uMyoqt8IWCdLye4y4BZta6V3ylJmpeHMBRygPnFD2gNizbBhFvdTyLpxbt1vJqfItkh
 vsnp1roTzDkpGaXBBxdWRB0pSUohov1rN6ca2DYvR+vj49MQ8m3krCmmDHotOoIZ/N2f
 0BPA==
X-Gm-Message-State: APjAAAVRqVCuxdRGXhtAsk/kR71PoRgNKF27S1LSY2m7/sp2ypmrR+iG
 VGdjWYLK0gY5D1a1OaKlpuyOc8q3sndi0Qrnu/sEECGrr/gjKWqO2n5ajgUE+vN8IcAbO+TDKLT
 KCNilOkhZ2doVb6E=
X-Received: by 2002:ac8:7943:: with SMTP id r3mr1749080qtt.49.1574243972296;
 Wed, 20 Nov 2019 01:59:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqwvk3uIMGUtQbNSPZx5SUe2+Xej/adS5qrOGKX2GnHAFGszmdesh8BrrYO+jqtpG5843+MXEQ==
X-Received: by 2002:ac8:7943:: with SMTP id r3mr1749071qtt.49.1574243972114;
 Wed, 20 Nov 2019 01:59:32 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
 by smtp.gmail.com with ESMTPSA id j89sm13699358qte.72.2019.11.20.01.59.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2019 01:59:31 -0800 (PST)
Date: Wed, 20 Nov 2019 04:59:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/3] virtio, acpi: fixes
Message-ID: <20191120095904.11384-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-MC-Unique: Eg3HlL5ZOn6DMd-23TUapQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 39e2821077e6dcf788b7c2a9ef50970ec7995437=
:

  Update version for v4.2.0-rc2 release (2019-11-19 19:34:10 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 6c77aa909e0eec6531e2398d0e9e60ec6a9339c6:

  tests: acpi: always retain dumped ACPI tables in case of error (2019-11-2=
0 04:57:22 -0500)

----------------------------------------------------------------
virtio, acpi: fixes

A couple of bugfixes.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Igor Mammedov (1):
      tests: acpi: always retain dumped ACPI tables in case of error

Stefan Hajnoczi (1):
      vhost-user-input: use free(elem) instead of g_free(elem)

Xie Yongji (1):
      libvhost-user: Zero memory allocated for VuVirtqInflightDesc

 contrib/libvhost-user/libvhost-user.c | 2 +-
 contrib/vhost-user-input/main.c       | 4 ++--
 tests/bios-tables-test.c              | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)


