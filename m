Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5A6C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 12:20:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FA4720989
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 12:20:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FA4720989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53542 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOi21-0008Qc-Eh
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 08:20:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hOi0M-0007YY-Vk
	for qemu-devel@nongnu.org; Thu, 09 May 2019 08:18:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hOi0L-0004eD-Tq
	for qemu-devel@nongnu.org; Thu, 09 May 2019 08:18:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hOi0L-0004bw-MO
	for qemu-devel@nongnu.org; Thu, 09 May 2019 08:18:29 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 83A0B18DF44;
	Thu,  9 May 2019 12:18:26 +0000 (UTC)
Received: from localhost (ovpn-117-236.ams2.redhat.com [10.36.117.236])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7655A60603;
	Thu,  9 May 2019 12:18:21 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 13:18:18 +0100
Message-Id: <20190509121820.16294-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Thu, 09 May 2019 12:18:26 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 0/2] security.rst: add Security Guide to
 developer docs
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v3:
 * Split into security.texi for qemu-doc and secure-coding-practices.rst =
for
   the developer documentation [danpb]
 * Mentioned that QEMU can be started as non-root using UNIX groups on
   /dev/kvm, /dev/net/tun, etc [Alex Bennee]
 * Kept Acked-by and Reviewed-by since the v3 changes are minor
v2:
 * Added mention of passthrough USB and PCI devices [philmd]
 * Reworded resource limits [philmd]
 * Added qemu_log_mask(LOG_GUEST_ERROR) [philmd]

At KVM Forum 2018 I gave a presentation on security in QEMU:
https://www.youtube.com/watch?v=3DYAdRf_hwxU8 (video)
https://vmsplice.net/~stefan/stefanha-kvm-forum-2018.pdf (slides)

This patch series extends the QEMU documentation to cover security topics=
,
though this is just the beginning and we could flesh it out more in the f=
uture.

Stefan Hajnoczi (2):
  docs: add Secure Coding Practices to developer docs
  docs: add Security chapter to the documentation

 Makefile                               |   2 +-
 docs/devel/index.rst                   |   1 +
 docs/devel/secure-coding-practices.rst | 106 ++++++++++++++++++++
 docs/security.texi                     | 131 +++++++++++++++++++++++++
 qemu-doc.texi                          |   3 +
 5 files changed, 242 insertions(+), 1 deletion(-)
 create mode 100644 docs/devel/secure-coding-practices.rst
 create mode 100644 docs/security.texi

--=20
2.21.0


