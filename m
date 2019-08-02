Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F43DC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 18:06:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCEFF20665
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 18:06:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCEFF20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htbx2-0007MY-G8
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 14:06:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57612)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1htbrq-0005NO-6m
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 14:01:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1htbrm-0004da-Cp
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 14:01:24 -0400
Received: from indium.canonical.com ([91.189.90.7]:55274)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1htbri-000470-1w
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 14:01:20 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1htbrI-0001T3-Kb
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2019 18:00:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 98BE72E80BA
 for <qemu-devel@nongnu.org>; Fri,  2 Aug 2019 18:00:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Aug 2019 17:50:31 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1838763@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Confirmed; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ausername philmd
X-Launchpad-Bug-Reporter: =?utf-8?b?5ZGo5paH6Z2SIChhdXNlcm5hbWUp?=
X-Launchpad-Bug-Modifier: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
References: <156474593196.25727.15962542236379825575.malonedeb@soybean.canonical.com>
Message-Id: <156476823156.29390.6137979148026708321.malone@wampee.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19014";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: e002c049948c34a237472f5565958ec0980432e6
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1838763] Re: Bugs in SSH module (ssh.c)
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
Reply-To: Bug 1838763 <1838763@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

$ uname -smrv
Linux 5.1.17 #7 SMP Wed Jul 10 08:35:08 UTC 2019 aarch64

$ lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 18.04.2 LTS
Release:        18.04
Codename:       bionic

$ dpkg -l|fgrep libssh
ii  libssh-4:arm64                       0.8.0~20170825.94fa1e38-1ubuntu0.2=
 arm64        tiny C SSH library (OpenSSL flavor)
ii  libssh-dev                           0.8.0~20170825.94fa1e38-1ubuntu0.2=
 arm64        tiny C SSH library. Development files (OpenSSL flavor)

$ ./configure
...
libssh support    yes
...

$ make
...
  CC      block/ssh.o
block/ssh.c: In function 'check_host_key_knownhosts':
block/ssh.c:281:28: error: storage size of 'state' isn't known
     enum ssh_known_hosts_e state;
                            ^~~~~
block/ssh.c:289:13: error: implicit declaration of function 'ssh_session_is=
_known_server' [-Werror=3Dimplicit-function-declaration]
     state =3D ssh_session_is_known_server(s->session);
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
block/ssh.c:289:13: error: nested extern declaration of 'ssh_session_is_kno=
wn_server' [-Werror=3Dnested-externs]
block/ssh.c:293:10: error: 'SSH_KNOWN_HOSTS_OK' undeclared (first use in th=
is function); did you mean 'SSH_OPTIONS_HOSTKEYS'?
     case SSH_KNOWN_HOSTS_OK:
          ^~~~~~~~~~~~~~~~~~
          SSH_OPTIONS_HOSTKEYS
block/ssh.c:293:10: note: each undeclared identifier is reported only once =
for each function it appears in
block/ssh.c:297:10: error: 'SSH_KNOWN_HOSTS_CHANGED' undeclared (first use =
in this function); did you mean 'SSH_KNOWN_HOSTS_OK'?
     case SSH_KNOWN_HOSTS_CHANGED:
          ^~~~~~~~~~~~~~~~~~~~~~~
          SSH_KNOWN_HOSTS_OK
block/ssh.c:301:48: error: 'SSH_PUBLICKEY_HASH_SHA256' undeclared (first us=
e in this function); did you mean 'SSH_PUBLICKEY_HASH_SHA1'?
             r =3D ssh_get_publickey_hash(pubkey, SSH_PUBLICKEY_HASH_SHA256,
                                                ^~~~~~~~~~~~~~~~~~~~~~~~~
                                                SSH_PUBLICKEY_HASH_SHA1
block/ssh.c:307:27: error: implicit declaration of function 'ssh_get_finger=
print_hash'; did you mean 'ssh_get_pubkey_hash'? [-Werror=3Dimplicit-functi=
on-declaration]
             fingerprint =3D ssh_get_fingerprint_hash(SSH_PUBLICKEY_HASH_SH=
A256,
                           ^~~~~~~~~~~~~~~~~~~~~~~~
                           ssh_get_pubkey_hash
block/ssh.c:307:27: error: nested extern declaration of 'ssh_get_fingerprin=
t_hash' [-Werror=3Dnested-externs]
block/ssh.c:324:10: error: 'SSH_KNOWN_HOSTS_OTHER' undeclared (first use in=
 this function); did you mean 'SSH_KNOWN_HOSTS_OK'?
     case SSH_KNOWN_HOSTS_OTHER:
          ^~~~~~~~~~~~~~~~~~~~~
          SSH_KNOWN_HOSTS_OK
block/ssh.c:329:10: error: 'SSH_KNOWN_HOSTS_UNKNOWN' undeclared (first use =
in this function); did you mean 'SSH_KNOWN_HOSTS_CHANGED'?
     case SSH_KNOWN_HOSTS_UNKNOWN:
          ^~~~~~~~~~~~~~~~~~~~~~~
          SSH_KNOWN_HOSTS_CHANGED
block/ssh.c:333:10: error: 'SSH_KNOWN_HOSTS_NOT_FOUND' undeclared (first us=
e in this function); did you mean 'SSH_KNOWN_HOSTS_UNKNOWN'?
     case SSH_KNOWN_HOSTS_NOT_FOUND:
          ^~~~~~~~~~~~~~~~~~~~~~~~~
          SSH_KNOWN_HOSTS_UNKNOWN
block/ssh.c:337:10: error: 'SSH_KNOWN_HOSTS_ERROR' undeclared (first use in=
 this function); did you mean 'SSH_KNOWN_HOSTS_OTHER'?
     case SSH_KNOWN_HOSTS_ERROR:
          ^~~~~~~~~~~~~~~~~~~~~
          SSH_KNOWN_HOSTS_OTHER
block/ssh.c:281:28: error: unused variable 'state' [-Werror=3Dunused-variab=
le]
     enum ssh_known_hosts_e state;
                            ^~~~~
cc1: all warnings being treated as errors
rules.mak:69: recipe for target 'block/ssh.o' failed
make: *** [block/ssh.o] Error 1

** Changed in: qemu
       Status: New =3D> Confirmed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1838763

Title:
  Bugs in SSH module (ssh.c)

Status in QEMU:
  Confirmed

Bug description:
  I installed gcc-8&libssh* on my Ubuntu 18.04 arm64.When I was
  compiling any version of qemu like 3.1.0 4.0.0or 4.1.0 with SSH
  support,the GCC went wrong.It said some vars undeclared
  like'SSH_KNOWN_HOSTS_OTHER','SSH_KNOWN_HOST_UNKNOWN',etc.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1838763/+subscriptions

