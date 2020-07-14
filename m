Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6DDC433E6
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 07:34:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43658206F0
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 07:34:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43658206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvFS6-0003FJ-Ct
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 03:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jvFR9-0001YR-Ld
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 03:33:11 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:42057)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jvFR6-00024T-68
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 03:33:11 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MMnru-1kBfrK2xgy-00IhZz; Tue, 14 Jul 2020 09:33:06 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 5/7] linux-user: add netlink RTM_SETLINK command
Date: Tue, 14 Jul 2020 09:32:57 +0200
Message-Id: <20200714073259.1464675-6-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200714073259.1464675-1-laurent@vivier.eu>
References: <20200714073259.1464675-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:YTr5QFQR2Wca624ayED3bdxReXiTeZe/3JxL/lhehSe2StzQ/T5
 jZkSwbVvsiD2UL5UPdLvSDNcYKEGfv9ozDlRv9Dup45WebNunsfP+JmX+we8qBj20z02aSy
 6xp0gQ9P2OOPgeS1uxeIfqL1br3xkyn0uKSPV937c5NfK12ZCpnydgnXFQs68pZAc669Ln/
 WlAGByhblPgOxTLV+lvCQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:py25baA/w8o=:6nfN6g+EWhM2fUy8em6n4P
 +kSsPl7wvqJV32LS9tCwFJUFKPXaM+pnZCC5jM9+PgzDlC/Z7rpWZmBSvv593Aq1NEEwsLyN9
 9TCoYxCe2lh0LlplvvbrdzH1E4l7lLiIJlMliMAB/ith19lffgjYQkXAbFcg9xohTsDbDoJaU
 FklNIGtChfHciSQ+pFOIs2eAW/hJEocLES3mP6I36GT6NjVq3UB9l3mBZXtNuUXk/uQw+zFwQ
 SElZ0kILEeBDMNdPAzOlCxTZFWL18bnSMWTxa6vmEjDNH+T8Kozdhqu2B6GKsuyewHUqg6uYr
 FlNMPtqENSSnuafp0rHCXB+5oRbJ5ju+F19tpNitTMdrH+F6JcGZf+XgWzTYWghTmQInS4z+j
 FAlbnAbFM8KkwHEL8ymgZia+UkuxqH3BNuWdXCmtAdWtkFgR94P/aE3ihb7TcvDXzOejGC/b7
 Jubl4RB+KKmob3ORmKoxqXNb8dxwopgDo5EDAfDRRRQacGuZ9GxMTiwZSwj+lSKB9deKEtLFX
 HJcQxv0K7U8xk4/HcQm6gz6XJ2rjSHaVnJGldwjmQ/Gt1wkCSY7LMZ7IJ2jezDzb3Cvckxys1
 ap07eDdyHblduxp4uM8RmlSk3GLdUh5A1ARQ93zrhTKZsVbk5m7SQFoZ4aLEyAlsnJDy5hEkl
 wAOOpG8k04Qz5kHXPqDFRcYmMk7FJsayI40IcopG1y5RSCmeBWrV6BgzJSQbTG9sEYHz+wufC
 0HHUGZ8k6bgsOKLS1jNx13EWuQ4XGLb9beEQHCHCWC8P+Rd4ZbLelb6kKgUTU29cwVNVhi3QX
 9hbyVNtGEBixnDdghKymPUXmly72dS9pZZZVfMrAczeDNSV50tPCWX9tOMZCu0/QfP6D0Gh
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 03:33:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This command is needed to be able to boot systemd in a container.

  $ sudo systemd-nspawn -D /chroot/armhf/sid/ -b
  Spawning container sid on /chroot/armhf/sid.
  Press ^] three times within 1s to kill container.
  systemd 245.6-2 running in system mode.
  Detected virtualization systemd-nspawn.
  Detected architecture arm.

  Welcome to Debian GNU/Linux bullseye/sid!

  Set hostname to <virt-arm>.
  Failed to enqueue loopback interface start request: Operation not supported
  Caught <SEGV>, dumped core as pid 3.
  Exiting PID 1...
  Container sid failed with error code 255.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200709072332.890440-2-laurent@vivier.eu>
---
 linux-user/fd-trans.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/fd-trans.c b/linux-user/fd-trans.c
index 5d49a53552b2..1486c81aaa27 100644
--- a/linux-user/fd-trans.c
+++ b/linux-user/fd-trans.c
@@ -1204,6 +1204,7 @@ static abi_long target_to_host_data_route(struct nlmsghdr *nlh)
         break;
     case RTM_NEWLINK:
     case RTM_DELLINK:
+    case RTM_SETLINK:
         if (nlh->nlmsg_len >= NLMSG_LENGTH(sizeof(*ifi))) {
             ifi = NLMSG_DATA(nlh);
             ifi->ifi_type = tswap16(ifi->ifi_type);
-- 
2.26.2


