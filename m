Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF35C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 08:46:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6F582071E
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 08:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H47o7gWT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6F582071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZA0c-0007Hp-AS
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 03:46:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52749)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iZ9z5-00063r-DU
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 03:44:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iZ9z1-0004l0-KX
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 03:44:37 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20669
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iZ9z1-0004jq-3v
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 03:44:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574671473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EGzop1PgONB/O4b6ftFiN0wFZtW57mNLKus6FhPRtgU=;
 b=H47o7gWTOCw7uTRw5h5eOG9oXDYloyq3RwK3de4vTif8rDgLuzOX10Qk3z31KcGiF9V04N
 cY663w8K0gLBezpeTDKog71tvqlGLFsa46MGOCuCCh2aJWDW3zX9PLSfcWe/eq19leQ3A0
 5ZvKIaZMtsKg0qta8i/ZPMIMfvLO7tY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-lg1d1Dr1PQy-LZN6ngIudw-1; Mon, 25 Nov 2019 03:44:32 -0500
Received: by mail-qt1-f200.google.com with SMTP id x50so9793439qth.4
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 00:44:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:content-transfer-encoding;
 bh=whQfjRAQ6JKMH+LqG2d+ip7uPFLhrAqIgAXO0s9734A=;
 b=TncybW2hSlRQG4TMFF0EJ7WyWzmlGSHH9f9bun+amVtukoRVpPnmtKUjkEStg3NXqE
 6Df6P4c9ymSXe0ibUb0qcJTMhNycl4n8oaecQroQ2dEbtKrXHujBHgttcI98qvqB0cuX
 IjTJKWQ+oMntX3IL7j35qdbAQxgfJHJ5aifhV9lxnSrryOHt38UgtXA5L/nzfJYo9HCQ
 4jJjsrIkJVcx1R8+Dg9xWKmj57+1Yj16/A/PBiOmy8EF1vNtpJoaC7KZBzl4yQoci9AH
 sdB/7R8Btce8sfZgciuk7STiHxoX+2hLYn7fpwgAvEceGyn1cofqUv/ZBODYbkAQN2WB
 c/Qw==
X-Gm-Message-State: APjAAAWtmu9PwSpM12Ts/EL3WiT9VMnvJb0ywCUGnHsEvt4QBzZJ7wNN
 2nCCmSJvf+EMFRUcOjCqRhmbi3mABQEJZYgMFEGRJNs/Ewe/8xSezFCR68i76fpEcXtVftkLZ16
 3RenhcbSAqRDqpU4=
X-Received: by 2002:ac8:788:: with SMTP id l8mr18471844qth.267.1574671471836; 
 Mon, 25 Nov 2019 00:44:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqxObQX1u85oe7QsJrcG/SjZhMLeH79aJf/Lp1fGOHX2t046K8dCk4tQ2CvNU+rRJoMS7D2ccw==
X-Received: by 2002:ac8:788:: with SMTP id l8mr18471838qth.267.1574671471617; 
 Mon, 25 Nov 2019 00:44:31 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
 by smtp.gmail.com with ESMTPSA id y24sm3016298qki.104.2019.11.25.00.44.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2019 00:44:30 -0800 (PST)
Date: Mon, 25 Nov 2019 03:44:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/3] virtio, pc: fixes
Message-ID: <20191125084403.324866-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-MC-Unique: lg1d1Dr1PQy-LZN6ngIudw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 2061735ff09f9d5e67c501a96227b470e7de69b1=
:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into sta=
ging (2019-11-21 17:18:40 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to e48929c787ed0ebed87877c97ac90c3a47ef7dda:

  intel_iommu: TM field should not be in reserved bits (2019-11-25 03:42:58=
 -0500)

----------------------------------------------------------------
virtio, pc: fixes

More small bugfixes.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Marc-Andr=C3=A9 Lureau (1):
      virtio-input: fix memory leak on unrealize

Qi, Yadong (2):
      intel_iommu: refine SL-PEs reserved fields checking
      intel_iommu: TM field should not be in reserved bits

 hw/i386/intel_iommu_internal.h | 18 +++++++++++-------
 hw/i386/intel_iommu.c          | 40 +++++++++++++++++++++++---------------=
--
 hw/input/virtio-input.c        |  3 +++
 3 files changed, 37 insertions(+), 24 deletions(-)


