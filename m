Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292F1C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 11:09:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFAB821738
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 11:09:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFAB821738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51838 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hItJA-0004fU-2w
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 07:09:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hItI7-00047M-4J
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:08:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hItI6-0008H5-As
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:08:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hItI6-0008FZ-48
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:08:46 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B030581F0F
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 11:08:44 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 42CB15C3FA;
	Tue, 23 Apr 2019 11:08:44 +0000 (UTC)
Date: Tue, 23 Apr 2019 08:08:42 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Message-ID: <20190423110842.GB25134@habkost.net>
References: <20190422210448.2488-1-ehabkost@redhat.com>
	<20190422210448.2488-2-ehabkost@redhat.com>
	<91f001e1-a47a-9eb0-f9af-746699f72fb4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <91f001e1-a47a-9eb0-f9af-746699f72fb4@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Tue, 23 Apr 2019 11:08:44 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] fixup! qtest: Move accel code to accel/qtest.c
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423110842.OKqcSaiVoaSeA9_w9RC1yNwbwSJpAaHHfj7pnmdNQAY@z>

On Tue, Apr 23, 2019 at 07:07:06AM +0200, Thomas Huth wrote:
> On 22/04/2019 23.04, Eduardo Habkost wrote:
> > QTest has two parts: the server (-qtest) and the accelerator
> > (-machine accel=qtest).  The accelerator depends on CONFIG_POSIX
> > due to its usage of sigwait(), but the server doesn't.
> > 
> > Move the accel code to accel/qtest.c.  Later we will disable
> > compilation of accel/qtest.c on non-POSIX systems.
> > 
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  accel/qtest.c       | 55 +++++++++++++++++++++++++++++++++++++++++++++
> 
> New file ==> You should update MAINTAINERS here as well.

Oops, sorry!  Fixup below.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 56139ac8ab..cf3156d952 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2024,6 +2024,7 @@ M: Laurent Vivier <lvivier@redhat.com>
 R: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
 F: qtest.c
+F: accel/qtest.c
 F: tests/libqtest.*
 F: tests/libqos/
 F: tests/*-test.c
-- 
2.18.0.rc1.1.g3f1ff2140

-- 
Eduardo

