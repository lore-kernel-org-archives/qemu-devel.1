Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E74C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 09:31:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C99B220855
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 09:31:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C99B220855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGfPB-0004Bm-Kr
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 05:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kGfOT-0003iY-UM
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 05:30:58 -0400
Received: from indium.canonical.com ([91.189.90.7]:50856)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kGfOR-0000ej-Q5
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 05:30:57 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kGfOP-0005X3-I9
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 09:30:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 6B9A82E80EC
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 09:30:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2020 09:20:39 -0000
From: Laurent Vivier <1895053@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: linux-user
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: laurent-vivier petunia2000
X-Launchpad-Bug-Reporter: Petunia (petunia2000)
X-Launchpad-Bug-Modifier: Laurent Vivier (laurent-vivier)
References: <159968542073.11462.1191604929312152807.malonedeb@chaenomeles.canonical.com>
Message-Id: <159981603909.20744.6274336627539261661.malone@wampee.canonical.com>
Subject: [Bug 1895053] Re: Cannot nspawn raspbian 10 [FAILED] Failed to start
 Journal Service.
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="83bdf6c8a3a5f87722c8927e54838522f3e57504"; Instance="production"
X-Launchpad-Hash: 797664c6764551ecf8a30f24df8d3bc81b3b222d
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 02:05:39
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1895053 <1895053@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We can try to see what is failing by enabling qemu strace.
To do that, I don't know a better solution than using a wrapper.

Once /mnt is mounted, copy qemu-arm-static inside with a new name:

  sudo cp /usr/bin/qemu-arm-static /mnt/usr/bin/qemu-arm-org

Then create the wrapper:

cat > qemu-wrapper.c <<EOF
#include <stdio.h>
#include <unistd.h>
#include <string.h>

static const char *baseargv[] =3D {
        "-strace",
};

int main(int argc, char **argv, char **envp) {
        char *newargv[argc + sizeof(baseargv) / sizeof(char *) + 1];
        int current =3D 0;

        newargv[current] =3D argv[0];
        current++;

        memcpy(&newargv[current], baseargv, sizeof(baseargv));
        current +=3D sizeof(baseargv) / sizeof(char *);

        memcpy(&newargv[current], &argv[1], sizeof(*argv) * (argc - 1));
        current +=3D argc - 1;

        newargv[current] =3D NULL;

        return execve("/usr/bin/qemu-arm-org", newargv, envp);
}
EOF
  cc --static -o qemu-wrapper qemu-wrapper.c

  sudo cp  qemu-wrapper /mnt/usr/bin/qemu-arm-static

And then:

  systemd-nspawn  --boot --directory=3D/mnt

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1895053

Title:
  Cannot nspawn raspbian 10 [FAILED] Failed to start Journal Service.

Status in QEMU:
  New

Bug description:
  Hi, I'm using nspawn and asked the question @systemd-devel. They redirect=
ed me to you, guessing that nspawn calls a syscall or ioctl qemu isnt aware=
 of and can't implement properly?
  They were like: "Sorry, that's not my department." ^^

  Maybe you can reproduce the issue or help me investigating whats wrong
  or put the ball right back into their court? :D

  Testscript:
  wget https://downloads.raspberrypi.org/raspios_lite_armhf_latest -o r.zip
  unzip r.zip
  LOOP=3D$(losetup --show -Pf *raspios-buster-armhf-lite.img)
  mount ${LOOP}p2 /mnt
  mount ${LOOP}p1 /mnt/boot
  systemd-nspawn --bind /usr/bin/qemu-arm-static --boot --directory=3D/mnt =
-- systemd.log_level=3Ddebug

  Output:
  see attachment

  System:
  uname -a
  Linux MArch 5.8.7-arch1-1 #1 SMP PREEMPT Sat, 05 Sep 2020 12:31:32 +0000
  x86_64 GNU/Linux

  qemu-arm-static --version
  qemu-arm version 5.1.0

  systemd-nspawn --version
  systemd 246 (246.4-1-arch)
  +PAM +AUDIT -SELINUX -IMA -APPARMOR +SMACK -SYSVINIT +UTMP +LIBCRYPTSETUP
  +GCRYPT +GNUTLS +ACL +XZ +LZ4 +ZSTD +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2=
 -IDN
  +PCRE2 default-hierarchy=3Dhybrid

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1895053/+subscriptions

