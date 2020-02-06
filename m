Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE26C35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:32:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB0F120658
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IKo8vS7g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB0F120658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izolL-00068k-00
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 16:32:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34593)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izoaH-0008RJ-47
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:21:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izoaD-00040H-IO
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:21:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47845
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izoaB-0003qc-Te
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:21:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581024066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kQPivTNaNgryAGxSuK4oFyJ8NwgmfXPtXUqAUdzpmTM=;
 b=IKo8vS7gI/iy0AGhgyqBgDerewJHpasYXFIyMUUKq3Rn0V1Vd3j5Phzsxp9OCGTM7fOf4O
 u17FTDMe2YKwQoJA/tv/hDEycub7ufu/b1aZAo4xoYUyyEHXoO45MiaXnw/EHPybRT0lnN
 Ai+GyDbphbyy9iDOdB181V+HsSwPmGo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-6txW_qSLN0SFs70fjAlY0w-1; Thu, 06 Feb 2020 16:21:04 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E0DE8010D6;
 Thu,  6 Feb 2020 21:21:03 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-120.brq.redhat.com [10.40.204.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B631D60BEC;
 Thu,  6 Feb 2020 21:21:01 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 18/46] tests: rename virtio_seg_max_adjust to
 virtio_check_params
Date: Thu,  6 Feb 2020 22:19:08 +0100
Message-Id: <20200206211936.17098-19-philmd@redhat.com>
In-Reply-To: <20200206211936.17098-1-philmd@redhat.com>
References: <20200206211936.17098-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 6txW_qSLN0SFs70fjAlY0w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Cornelia Huck <cohuck@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Denis Plotnikov <dplotnikov@virtuozzo.com>

Since, virtio_seg_max_adjust checks not only seg_max, but also
virtqueue_size parameter, let's make the test more general and
add new parameters to be checked there in the future.

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-Id: <20200129140702.5411-5-dplotnikov@virtuozzo.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 .../{virtio_seg_max_adjust.py =3D> virtio_check_params.py}          | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename tests/acceptance/{virtio_seg_max_adjust.py =3D> virtio_check_params=
.py} (100%)

diff --git a/tests/acceptance/virtio_seg_max_adjust.py b/tests/acceptance/v=
irtio_check_params.py
similarity index 100%
rename from tests/acceptance/virtio_seg_max_adjust.py
rename to tests/acceptance/virtio_check_params.py
--=20
2.21.1


