Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9AFC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:33:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C3372222D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y9LU/7sk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C3372222D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUvVg-0000w9-8h
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 13:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kUvQP-0002YA-7h
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:27:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52426)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kUvQN-0008W9-B7
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:27:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603214870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=38l43bFMAeTPB/kXmffxzr0rFB5Z1ElU3lCOZZacp3I=;
 b=Y9LU/7sku8zbfwxT1GJ+QGMBfKp8yZfNBrRTsS2o16dgzgUAc9MqzPy61krz0zmdEGCSQU
 3ljrv3nRvAX4gGjrlRPAv68BRI121dyPRJcDpbABidAYnkqbRx0YXQVOK9j8Fp5J35zFJF
 d9ZveQNbDatmYPe7nqQi3Bcn78xquSw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-urBM2DHDOMGJJKB64fry2w-1; Tue, 20 Oct 2020 13:27:45 -0400
X-MC-Unique: urBM2DHDOMGJJKB64fry2w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1AAD51006C8E;
 Tue, 20 Oct 2020 17:27:44 +0000 (UTC)
Received: from scv.redhat.com (ovpn-115-172.rdu2.redhat.com [10.10.115.172])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1055E26372;
 Tue, 20 Oct 2020 17:27:42 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/21] Python patches
Date: Tue, 20 Oct 2020 13:27:21 -0400
Message-Id: <20201020172742.1483258-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:15:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 4c41341af76cfc85b5a6c0f87de4838672ab9f89=
:=0D
=0D
  Merge remote-tracking branch 'remotes/aperard/tags/pull-xen-20201020' int=
o staging (2020-10-20 11:20:36 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  https://gitlab.com/jsnow/qemu.git tags/python-pull-request=0D
=0D
for you to fetch changes up to 5e44bef7cc532cd89ee46c78341266caa66f4437:=0D
=0D
  python/qemu/qmp.py: Fix settimeout operation (2020-10-20 09:37:57 -0400)=
=0D
=0D
----------------------------------------------------------------=0D
Pull request=0D
=0D
----------------------------------------------------------------=0D
=0D
John Snow (21):=0D
  MAINTAINERS: Add Python library stanza=0D
  python/qemu: use isort to lay out imports=0D
  python/machine.py: Fix monitor address typing=0D
  python/machine.py: reorder __init__=0D
  python/machine.py: Don't modify state in _base_args()=0D
  python/machine.py: Handle None events in events_wait=0D
  python/machine.py: use qmp.command=0D
  python/machine.py: Add _qmp access shim=0D
  python/machine.py: fix _popen access=0D
  python/qemu: make 'args' style arguments immutable=0D
  iotests.py: Adjust HMP kwargs typing=0D
  python/qemu: Add mypy type annotations=0D
  python/qemu/console_socket.py: Correct type of recv()=0D
  python/qemu/console_socket.py: fix typing of settimeout=0D
  python/qemu/console_socket.py: Clarify type of drain_thread=0D
  python/qemu/console_socket.py: Add type hint annotations=0D
  python/qemu/console_socket.py: avoid encoding to/from string=0D
  python/qemu/qmp.py: Preserve error context on re-raise=0D
  python: add mypy config=0D
  python/qemu/qmp.py: re-raise OSError when encountered=0D
  python/qemu/qmp.py: Fix settimeout operation=0D
=0D
 MAINTAINERS                   |   9 +-=0D
 python/mypy.ini               |   4 +=0D
 python/qemu/.isort.cfg        |   7 +=0D
 python/qemu/accel.py          |   9 +-=0D
 python/qemu/console_socket.py |  54 +++---=0D
 python/qemu/machine.py        | 306 +++++++++++++++++++++-------------=0D
 python/qemu/qmp.py            |  89 ++++++----=0D
 python/qemu/qtest.py          |  55 +++---=0D
 tests/qemu-iotests/iotests.py |   2 +-=0D
 9 files changed, 325 insertions(+), 210 deletions(-)=0D
 create mode 100644 python/mypy.ini=0D
 create mode 100644 python/qemu/.isort.cfg=0D
=0D
--=20=0D
2.26.2=0D
=0D


