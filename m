Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA6EC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 10:31:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1CF22074D
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 10:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1CF22074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZXcs-0005PH-0J
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 06:31:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jZXcB-0004ZI-11
 for qemu-devel@nongnu.org; Fri, 15 May 2020 06:30:51 -0400
Received: from indium.canonical.com ([91.189.90.7]:49072)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jZXcA-0007zO-1l
 for qemu-devel@nongnu.org; Fri, 15 May 2020 06:30:50 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jZXc6-0002f7-Ao
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 10:30:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 50E242E80BA
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 10:30:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2020 10:25:03 -0000
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: berrange christophe-lyon laurent-vivier philmd
 pmaydell
X-Launchpad-Bug-Reporter: Christophe Lyon (christophe-lyon)
X-Launchpad-Bug-Modifier: Peter Maydell (pmaydell)
References: <158935359452.19393.4863679569975227091.malonedeb@chaenomeles.canonical.com>
Message-Id: <158953830340.17798.12072365993396231445.malone@soybean.canonical.com>
Subject: [Bug 1878348] Re: --static build fails in v5.0 (since
 5010cec2bc87dafab39b3913c8ca91f88df9c540)
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="0385b538081bc4718df6fb844a3afc89729c94ce";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 13a8aef7c633bca352059cb18794105bb9aa4f16
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 04:30:58
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1878348 <1878348@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some people want the system emulation to be statically linked, which is
why we don't refuse to do it entirely; and static vs not changes a bunch
of stuff like CFLAGS which we assume to be common across the whole
build. So if you want some statically linked binaries and some not
statically linked, then yes, you should configure and build twice. (Use
separate build directories, one for each config.)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1878348

Title:
  --static build fails in v5.0 (since
  5010cec2bc87dafab39b3913c8ca91f88df9c540)

Status in QEMU:
  New

Bug description:
  Hi,

  Since commit 5010cec2bc87dafab39b3913c8ca91f88df9c540, building qemu
  fails when configured with --static (eg ../configure --target-
  list=3Dx86_64-softmmu,x86_64-linux-user --enable-debug --static).

  On ubuntu 16.04, it fails to find -lffi and -lselinux.

  After I apt-get install libffi-dev libselinux1-dev, the build still fails:
  ../backends/dbus-vmstate.o: In function `_nocheck__trace_dbus_vmstate_pre=
_save':
  /home/christophe.lyon/src/qemu/build-static/backends/trace.h:29: undefine=
d reference to `_TRACE_DBUS_VMSTATE_PRE_SAVE_DSTATE'
  ../backends/dbus-vmstate.o: In function `_nocheck__trace_dbus_vmstate_pos=
t_load':
  /home/christophe.lyon/src/qemu/build-static/backends/trace.h:52: undefine=
d reference to `_TRACE_DBUS_VMSTATE_POST_LOAD_DSTATE'
  ../backends/dbus-vmstate.o: In function `_nocheck__trace_dbus_vmstate_loa=
ding':
  /home/christophe.lyon/src/qemu/build-static/backends/trace.h:75: undefine=
d reference to `_TRACE_DBUS_VMSTATE_LOADING_DSTATE'
  ../backends/dbus-vmstate.o: In function `_nocheck__trace_dbus_vmstate_sav=
ing':
  /home/christophe.lyon/src/qemu/build-static/backends/trace.h:98: undefine=
d reference to `_TRACE_DBUS_VMSTATE_SAVING_DSTATE'
  collect2: error: ld returned 1 exit status

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1878348/+subscriptions

