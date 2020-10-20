Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF08C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 19:11:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDB592224A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 19:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YGeOjY6V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDB592224A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUx31-0006HG-4H
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 15:11:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kUx1a-0005PO-0e
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 15:10:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52882)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kUx1Y-00064V-4S
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 15:10:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603221019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=p/ehmEAg0FOwLSoYHI40MWFn2z+n5B98VX0L6vQ8x/c=;
 b=YGeOjY6VFIdJ47fGLjq61jXhcIi7Unj1dS5MG5bCSlFKjLRzKQbfIzALSnpB0BzXBOMLhG
 Ijt/vqf12chWtq/pVtSA/0nb27VwtT6+A3kPPx4JR6FFmUN55QTMOEG8uWgwTvVMSpfkVl
 HAEyU3hrgPZhVHYauxmeyu3CGlLqPEY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-zYjpKcudOgS8lRbx43G2Vg-1; Tue, 20 Oct 2020 15:10:16 -0400
X-MC-Unique: zYjpKcudOgS8lRbx43G2Vg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 870A08049D3;
 Tue, 20 Oct 2020 19:10:15 +0000 (UTC)
Received: from [10.10.115.172] (ovpn-115-172.rdu2.redhat.com [10.10.115.172])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5F8FB10013D0;
 Tue, 20 Oct 2020 19:10:14 +0000 (UTC)
To: QEMU Developers <qemu-devel@nongnu.org>
From: John Snow <jsnow@redhat.com>
Subject: [PULL v2 00/21] Python patches
Message-ID: <3d61f127-d3b0-c8b5-877b-434228bcf275@redhat.com>
Date: Tue, 20 Oct 2020 15:10:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Eduardo Habkost <ehabkost@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 4c41341af76cfc85b5a6c0f87de4838672ab9f89:

   Merge remote-tracking branch 'remotes/aperard/tags/pull-xen-20201020' 
into staging (2020-10-20 11:20:36 +0100)

are available in the Git repository at:

   https://gitlab.com/jsnow/qemu.git tags/python-pull-request

for you to fetch changes up to 39cf73c3494045b4418c9c1db8e803640e2150dc:

   python/qemu/qmp.py: Fix settimeout operation (2020-10-20 15:00:06 -0400)

----------------------------------------------------------------
Pull request V2 - Squashed small change in from Nir on 20/21.

----------------------------------------------------------------

John Snow (21):
   MAINTAINERS: Add Python library stanza
   python/qemu: use isort to lay out imports
   python/machine.py: Fix monitor address typing
   python/machine.py: reorder __init__
   python/machine.py: Don't modify state in _base_args()
   python/machine.py: Handle None events in events_wait
   python/machine.py: use qmp.command
   python/machine.py: Add _qmp access shim
   python/machine.py: fix _popen access
   python/qemu: make 'args' style arguments immutable
   iotests.py: Adjust HMP kwargs typing
   python/qemu: Add mypy type annotations
   python/qemu/console_socket.py: Correct type of recv()
   python/qemu/console_socket.py: fix typing of settimeout
   python/qemu/console_socket.py: Clarify type of drain_thread
   python/qemu/console_socket.py: Add type hint annotations
   python/qemu/console_socket.py: avoid encoding to/from string
   python/qemu/qmp.py: Preserve error context on re-raise
   python: add mypy config
   python/qemu/qmp.py: re-raise OSError when encountered
   python/qemu/qmp.py: Fix settimeout operation

  MAINTAINERS                   |   9 +-
  python/mypy.ini               |   4 +
  python/qemu/.isort.cfg        |   7 +
  python/qemu/accel.py          |   9 +-
  python/qemu/console_socket.py |  54 +++---
  python/qemu/machine.py        | 306 +++++++++++++++++++++-------------
  python/qemu/qmp.py            |  89 ++++++----
  python/qemu/qtest.py          |  55 +++---
  tests/qemu-iotests/iotests.py |   2 +-
  9 files changed, 325 insertions(+), 210 deletions(-)
  create mode 100644 python/mypy.ini
  create mode 100644 python/qemu/.isort.cfg

-- 
2.26.2


