Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69C5C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 20:52:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5ED7206BF
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 20:52:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5ED7206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42345 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hR0tK-0007Oy-1F
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 16:52:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hR0rN-0005oj-Sm
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:50:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hR0rM-0001A2-11
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:50:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39354)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hR0rJ-00018S-U2
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:50:43 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 913AC30820C9
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 20:50:40 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-17.ams2.redhat.com
	[10.36.112.17])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A4CEB1820D;
	Wed, 15 May 2019 20:50:39 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 15 May 2019 22:50:15 +0200
Message-Id: <1557953433-19663-4-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1557953433-19663-1-git-send-email-pbonzini@redhat.com>
References: <1557953433-19663-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Wed, 15 May 2019 20:50:40 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 03/21] Declare -realtime as deprecated
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
Cc: Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

The old -realtime mlock=on|off parameter does exactly the same as the
new -overcommit mem-lock=on|off parameter. Additionally, "-realtime"
does not activate any additional "realtime" capabilities as the name
might indicate. We should avoid to confuse the users this way, so
let's deprecate the old -realtime option.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20190411175345.19414-1-thuth@redhat.com>
---
 qemu-deprecated.texi | 5 +++++
 vl.c                 | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 842e71b..ab62dd7 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -72,6 +72,11 @@ backend settings instead of environment variables.  To ease migration to
 the new format, the ``-audiodev-help'' option can be used to convert
 the current values of the environment variables to ``-audiodev'' options.
 
+@subsection -realtime (since 4.1)
+
+The @code{-realtime mlock=on|off} argument has been replaced by the
+@code{-overcommit mem-lock=on|off} argument.
+
 @section QEMU Machine Protocol (QMP) commands
 
 @subsection block-dirty-bitmap-add "autoload" parameter (since 2.12.0)
diff --git a/vl.c b/vl.c
index b670951..2e44f7d 100644
--- a/vl.c
+++ b/vl.c
@@ -3927,6 +3927,8 @@ int main(int argc, char **argv, char **envp)
                 }
                 break;
             case QEMU_OPTION_realtime:
+                warn_report("'-realtime mlock=...' is deprecated, please use "
+                             "'-overcommit mem-lock=...' instead");
                 opts = qemu_opts_parse_noisily(qemu_find_opts("realtime"),
                                                optarg, false);
                 if (!opts) {
-- 
1.8.3.1



