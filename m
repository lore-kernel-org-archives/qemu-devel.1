Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9368CC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 23:15:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CF0A206F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 23:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FPnRehPO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CF0A206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwwYP-00059n-Ea
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 18:15:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60636)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iwwXR-00044I-0X
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:14:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iwwXO-0000Ye-71
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:14:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40116
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iwwXN-0000Vk-Tr
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:14:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580339661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Mhg3VSz4wWW1QtCbVzRa6h8LKr6U3LR5/uzOvBT52V0=;
 b=FPnRehPOCKzlGPeiGZlaeqT/m1LtgGeomPLPGnH+vI1JJL0EOepToSmaJXt2Mcx1JDym+7
 NbDFr1DiDMJiI3lC8eQoKsJHmtuRXDVjZQBjUDu33ie5uEiOIEx27tS/3RxgLO9Jo4X1SU
 LWQiJKvQodguZ4r5/U2zcAK5Ag5/KkI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-MnuQyI4UOVCxI4O02kjjow-1; Wed, 29 Jan 2020 18:14:16 -0500
X-MC-Unique: MnuQyI4UOVCxI4O02kjjow-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E962477;
 Wed, 29 Jan 2020 23:14:15 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-184.brq.redhat.com [10.40.205.184])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 949B85DA7E;
 Wed, 29 Jan 2020 23:14:04 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/10] python: Explicit usage of Python 3
Date: Thu, 30 Jan 2020 00:13:52 +0100
Message-Id: <20200129231402.23384-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

These are mechanical sed patches used to convert the
code base to Python 3, as suggested on this thread:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg675024.html

Regards,

Phil.

Philippe Mathieu-Daud=C3=A9 (10):
  scripts: Explicit usage of Python 3
  tests/qemu-iotests: Explicit usage of Python 3
  tests: Explicit usage of Python 3
  scripts/minikconf: Explicit usage of Python 3
  tests/acceptance: Remove shebang header
  scripts/tracetool: Remove shebang header
  tests/vm: Remove shebang header
  tests/qemu-iotests: Explicit usage of Python 3
  scripts: Explicit usage of Python 3
  tests/qemu-iotests/check: Update to match Python 3 interpreter

 scripts/analyse-9p-simpletrace.py                | 2 +-
 scripts/analyse-locks-simpletrace.py             | 2 +-
 scripts/decodetree.py                            | 2 +-
 scripts/device-crash-test                        | 2 +-
 scripts/kvm/kvm_flightrecorder                   | 2 +-
 scripts/minikconf.py                             | 1 +
 scripts/qapi-gen.py                              | 2 +-
 scripts/qmp/qemu-ga-client                       | 2 +-
 scripts/qmp/qmp                                  | 2 +-
 scripts/qmp/qmp-shell                            | 2 +-
 scripts/qmp/qom-fuse                             | 2 +-
 scripts/render_block_graph.py                    | 2 +-
 scripts/replay-dump.py                           | 2 +-
 scripts/simpletrace.py                           | 2 +-
 scripts/tracetool.py                             | 2 +-
 scripts/tracetool/__init__.py                    | 1 -
 scripts/tracetool/backend/__init__.py            | 1 -
 scripts/tracetool/backend/dtrace.py              | 1 -
 scripts/tracetool/backend/ftrace.py              | 1 -
 scripts/tracetool/backend/log.py                 | 1 -
 scripts/tracetool/backend/simple.py              | 1 -
 scripts/tracetool/backend/syslog.py              | 1 -
 scripts/tracetool/backend/ust.py                 | 1 -
 scripts/tracetool/format/__init__.py             | 1 -
 scripts/tracetool/format/c.py                    | 1 -
 scripts/tracetool/format/d.py                    | 1 -
 scripts/tracetool/format/h.py                    | 1 -
 scripts/tracetool/format/log_stap.py             | 1 -
 scripts/tracetool/format/simpletrace_stap.py     | 1 -
 scripts/tracetool/format/stap.py                 | 1 -
 scripts/tracetool/format/tcg_h.py                | 1 -
 scripts/tracetool/format/tcg_helper_c.py         | 1 -
 scripts/tracetool/format/tcg_helper_h.py         | 1 -
 scripts/tracetool/format/tcg_helper_wrapper_h.py | 1 -
 scripts/tracetool/format/ust_events_c.py         | 1 -
 scripts/tracetool/format/ust_events_h.py         | 1 -
 scripts/tracetool/transform.py                   | 1 -
 scripts/tracetool/vcpu.py                        | 1 -
 scripts/vmstate-static-checker.py                | 2 +-
 tests/acceptance/virtio_seg_max_adjust.py        | 1 -
 tests/acceptance/x86_cpu_model_versions.py       | 1 -
 tests/docker/travis.py                           | 2 +-
 tests/qapi-schema/test-qapi.py                   | 2 +-
 tests/qemu-iotests/030                           | 2 +-
 tests/qemu-iotests/040                           | 2 +-
 tests/qemu-iotests/041                           | 2 +-
 tests/qemu-iotests/044                           | 2 +-
 tests/qemu-iotests/045                           | 2 +-
 tests/qemu-iotests/055                           | 2 +-
 tests/qemu-iotests/056                           | 2 +-
 tests/qemu-iotests/057                           | 2 +-
 tests/qemu-iotests/065                           | 2 +-
 tests/qemu-iotests/093                           | 2 +-
 tests/qemu-iotests/096                           | 2 +-
 tests/qemu-iotests/118                           | 2 +-
 tests/qemu-iotests/124                           | 2 +-
 tests/qemu-iotests/129                           | 2 +-
 tests/qemu-iotests/132                           | 2 +-
 tests/qemu-iotests/136                           | 2 +-
 tests/qemu-iotests/139                           | 2 +-
 tests/qemu-iotests/147                           | 2 +-
 tests/qemu-iotests/148                           | 2 +-
 tests/qemu-iotests/149                           | 2 +-
 tests/qemu-iotests/151                           | 2 +-
 tests/qemu-iotests/152                           | 2 +-
 tests/qemu-iotests/155                           | 2 +-
 tests/qemu-iotests/163                           | 2 +-
 tests/qemu-iotests/165                           | 2 +-
 tests/qemu-iotests/169                           | 2 +-
 tests/qemu-iotests/194                           | 2 +-
 tests/qemu-iotests/196                           | 2 +-
 tests/qemu-iotests/199                           | 2 +-
 tests/qemu-iotests/202                           | 2 +-
 tests/qemu-iotests/203                           | 2 +-
 tests/qemu-iotests/205                           | 2 +-
 tests/qemu-iotests/206                           | 2 +-
 tests/qemu-iotests/207                           | 2 +-
 tests/qemu-iotests/208                           | 2 +-
 tests/qemu-iotests/209                           | 2 +-
 tests/qemu-iotests/210                           | 2 +-
 tests/qemu-iotests/211                           | 2 +-
 tests/qemu-iotests/212                           | 2 +-
 tests/qemu-iotests/213                           | 2 +-
 tests/qemu-iotests/216                           | 2 +-
 tests/qemu-iotests/218                           | 2 +-
 tests/qemu-iotests/219                           | 2 +-
 tests/qemu-iotests/222                           | 2 +-
 tests/qemu-iotests/224                           | 2 +-
 tests/qemu-iotests/228                           | 2 +-
 tests/qemu-iotests/234                           | 2 +-
 tests/qemu-iotests/235                           | 2 +-
 tests/qemu-iotests/236                           | 2 +-
 tests/qemu-iotests/237                           | 2 +-
 tests/qemu-iotests/238                           | 2 +-
 tests/qemu-iotests/242                           | 2 +-
 tests/qemu-iotests/245                           | 2 +-
 tests/qemu-iotests/246                           | 2 +-
 tests/qemu-iotests/248                           | 2 +-
 tests/qemu-iotests/254                           | 2 +-
 tests/qemu-iotests/255                           | 2 +-
 tests/qemu-iotests/256                           | 2 +-
 tests/qemu-iotests/257                           | 2 +-
 tests/qemu-iotests/258                           | 2 +-
 tests/qemu-iotests/260                           | 2 +-
 tests/qemu-iotests/262                           | 2 +-
 tests/qemu-iotests/264                           | 2 +-
 tests/qemu-iotests/266                           | 2 +-
 tests/qemu-iotests/277                           | 2 +-
 tests/qemu-iotests/280                           | 2 +-
 tests/qemu-iotests/281                           | 2 +-
 tests/qemu-iotests/check                         | 2 +-
 tests/qemu-iotests/nbd-fault-injector.py         | 2 +-
 tests/qemu-iotests/qcow2.py                      | 2 +-
 tests/qemu-iotests/qed.py                        | 2 +-
 tests/vm/basevm.py                               | 1 -
 tests/vm/centos                                  | 2 +-
 tests/vm/fedora                                  | 2 +-
 tests/vm/freebsd                                 | 2 +-
 tests/vm/netbsd                                  | 2 +-
 tests/vm/openbsd                                 | 2 +-
 tests/vm/ubuntu.i386                             | 2 +-
 121 files changed, 95 insertions(+), 120 deletions(-)
 mode change 100755 =3D> 100644 tests/acceptance/virtio_seg_max_adjust.py
 mode change 100755 =3D> 100644 tests/vm/basevm.py

--=20
2.21.1


