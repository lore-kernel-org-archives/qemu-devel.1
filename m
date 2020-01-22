Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFA3C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 22:34:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD27F2465A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 22:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GfaxX1GW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD27F2465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuOaM-00037y-BG
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 17:34:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33416)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iuOYg-0001fy-W7
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 17:33:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iuOYf-0001OS-Ll
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 17:33:10 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52740
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iuOYf-0001Mn-Dd
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 17:33:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579732388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=y+2ODqT76uugPLAdTz+E3ltxqeaDxIe2uHBWSBTOU9A=;
 b=GfaxX1GWp0CaV6nu17qEqczgDbqP3+Mt/p2pkK4rybrnnTJqZZA3WgCisRuy0wu+WM1TWL
 IwRW0kDUHg+LBGIwmehsVXWGyJXc2Nh8mibLzMjZmF5hmBT2Bou19pb1O4OkQmFiTUlFjB
 PTXsn3mkoOQ5+rFVJ+2FBx+u7KJL+eY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-khpmJ2_SOdi_voJgD5Fqog-1; Wed, 22 Jan 2020 17:33:04 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F89B800D48;
 Wed, 22 Jan 2020 22:33:03 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-78.brq.redhat.com [10.40.204.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A9F22845A5;
 Wed, 22 Jan 2020 22:32:51 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
Subject: [PATCH 0/6] tests/acceptance/virtio_seg_max_adjust: Restrict it to
 Linux/X86
Date: Wed, 22 Jan 2020 23:32:41 +0100
Message-Id: <20200122223247.30419-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: khpmJ2_SOdi_voJgD5Fqog-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently our CI is mostly restricted to Linux/X86.
We want to have more, but until there we have to run these tests
manually, which is why we didn't noticed earlier this test was
failing on OSX.

Actually this test might have catched a bug, see:
https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg05119.html

This series contains the patches I used to debug the problem,
and few fixes while manually testing on heterogeneous environments.

Note that I have no idea what virtio/seg_max_adjust is used for,
it just happened to broke my Avocado queue while rebasing it on
a more recent /master.

Tested on Linux/FreeBSD/OSX, X86/Aarch64.

Regards,

Phil.

Philippe Mathieu-Daud=C3=A9 (6):
  tests/acceptance/virtio_seg_max_adjust: Only remove listed machines
  tests/acceptance/virtio_seg_max_adjust: Improve exception logging
  tests/acceptance/virtio_seg_max_adjust: List machine being tested
  tests/acceptance/virtio_seg_max_adjust: Only test Xen as superuser
  tests/acceptance/virtio_seg_max_adjust: Restrict to X86 architecture
  tests/acceptance/virtio_seg_max_adjust: Restrict to Linux host

 tests/acceptance/virtio_seg_max_adjust.py | 37 +++++++++++++++++++----
 1 file changed, 31 insertions(+), 6 deletions(-)

--=20
2.21.1


