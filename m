Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F963C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 01:38:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22BB320758
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 01:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sendgrid.net header.i=@sendgrid.net header.b="e7xGNKN/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22BB320758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaUjJ-0002bK-99
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 21:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounces+16159052-3d09-qemu-devel=nongnu.org@sendgrid.net>)
 id 1jaUim-0002CM-Hf
 for qemu-devel@nongnu.org; Sun, 17 May 2020 21:37:36 -0400
Received: from o1.dev.nutanix.com ([198.21.4.205]:20869)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounces+16159052-3d09-qemu-devel=nongnu.org@sendgrid.net>)
 id 1jaUil-0001Qa-BX
 for qemu-devel@nongnu.org; Sun, 17 May 2020 21:37:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sendgrid.net;
 h=from:subject:to:cc:content-type:content-transfer-encoding;
 s=smtpapi; bh=8Fk+D+aUEY4cOny3UXyZu+fvdPj1+z0ifHVz+4fvyFo=;
 b=e7xGNKN/yTJC04r3yD+yRR8QuwuilLY0CTeOSj13hD7v7iuFB1AM9dS8eB2Vnb5k2UMZ
 FxDK8Lg0El4ORCEpaXXBxIBrdyjKoUZQk4C4/r6X9oltuanVnUizJNvwsuHL8IcO1m27m9
 dO1WJaLbi3jRY26B8OlUNgTMjenOSs1S4=
Received: by filterdrecv-p3iad2-8ddf98858-4rnwn with SMTP id
 filterdrecv-p3iad2-8ddf98858-4rnwn-19-5EC1E6DC-8
 2020-05-18 01:37:32.171207712 +0000 UTC m=+4581007.025919072
Received: from localhost.localdomain.com (unknown)
 by ismtpd0032p1las1.sendgrid.net (SG) with ESMTP
 id RyjVfV0SSzWbmPRpabXt-g Mon, 18 May 2020 01:37:31.795 +0000 (UTC)
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: checkpatch error checking target arch in libvhost-user
Date: Mon, 18 May 2020 01:37:32 +0000 (UTC)
Message-Id: <1588417318-5055-1-git-send-email-raphael.norwitz@nutanix.com>
X-Mailer: git-send-email 1.8.3.1
X-SG-EID: =?us-ascii?Q?YCLURHX+pjNDm1i7d69iKyMnQi=2FdvWah9veFa8nllaoUC0ScIWrCgiaWGu43Vg?=
 =?us-ascii?Q?xFdB4istXUBpN9H93OJgc8zW=2FJAG0mPpBxz6yk3?=
 =?us-ascii?Q?VQ=2FGic+fM5i64LrKUXYWloHH+z=2Fqz9Y0TQhALQK?=
 =?us-ascii?Q?pqhmbq4waoWOP9rg9pQXN3Uu8=2FrClu3KRKmXUiA?=
 =?us-ascii?Q?0Eh8lUdzeIIf88Al8P008Uarg966rh0y5cVWkSG?=
 =?us-ascii?Q?zSW8Q9jusFaSrJqOZKCovxLn=2FW2HRXfPUR4qJjc?=
 =?us-ascii?Q?b1K2qwaS7LuJdsOqakH9A=3D=3D?=
To: qemu-devel@nongnu.org, marcandre.lureau@redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.21.4.205;
 envelope-from=bounces+16159052-3d09-qemu-devel=nongnu.org@sendgrid.net;
 helo=o1.dev.nutanix.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 21:37:32
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: marcandre.lureau@gmail.com, Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hey Marc-Andre,

I'm working on a patchset with changes to libvhost-user. I'm hitting the
following checkpatch error:

Checking 0011-Lift-max-ram-slots-limit-in-libvhost-user.patch...
WARNING: architecture specific defines should be avoided
#117: FILE: contrib/libvhost-user/libvhost-user.h:38:
+#if defined(__i386__) || defined(__x86_64__) || \

total: 0 errors, 1 warnings, 120 lines checked

0011-Lift-max-ram-slots-limit-in-libvhost-user.patch has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.

I'm trying to set the maximum number of ram slots to the max supported by the
target architecture, and I don't know how to check that other than using these
macros. I see other architecture specific macro checks in libvhost-user.h,
such as here:
https://u16159052.ct.sendgrid.net/ls/click?upn=nHC8zHLUbSCl8801JuFxA5IdcFluFbhkOaN0W6nB6sLdfiznj-2FjAzM5FRqjRFWnMRnCWGbBIBOa9D0WJ4d1Dc3pvHvScsomf772bjiFIvKp8WAltnuQtFL02yD-2FAsRP43foG_E8SO-2FEypfU855L0ybQoiQY4Xaj8Z6NYzBoBK89OH-2BiJs2oVXUe9lHVA11uxF6eAFNBHYjrZ2L2x0rg8pxpJb7k58gV-2F0Pcs9b1FHGfiCxHVycMD52nL6rnjHYR0U2e5u-2Bb-2FDyF1ZIH76E5Zwe4Oe1vSdsfafOUWalRu1CMBhlsPO2TcpqiXnBFj1QaM1IrTe5RuhZMjTr5ZROvgb1i-2B74VaAbgKu-2FcfcA8Sk1-2BYxpqTTxs3x6f-2BYkMHAu-2BqEUJdY

Should I ignore this warning? If not, do you have any other suggestions?

Thanks,
Raphael

