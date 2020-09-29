Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B633BC4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:47:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 919752072E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:47:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 919752072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNMX4-0007aq-LR
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 16:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kNMVX-0006kf-At
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 16:45:57 -0400
Received: from indium.canonical.com ([91.189.90.7]:36264)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kNMVK-000797-O1
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 16:45:48 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kNMVE-00021B-2T
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 20:45:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id EE5E62E80EA
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 20:45:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2020 20:37:42 -0000
From: Cleber Rosa <1897783@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: cleber-gnu philmd
X-Launchpad-Bug-Reporter: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
X-Launchpad-Bug-Modifier: Cleber Rosa (cleber-gnu)
References: <160140299141.23116.14910893698614529826.malonedeb@wampee.canonical.com>
Message-Id: <160141186275.22741.12404528895502297905.malone@wampee.canonical.com>
Subject: [Bug 1897783] Re: avocado tests not running on aarch64 host
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="d685c0a40836eb9844ed835c9700f20633c1d7af"; Instance="production"
X-Launchpad-Hash: 135652bda154cd5574b92f5dfcd76e0d94b413ef
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 14:15:34
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -66
X-Spam_score: -6.7
X-Spam_bar: ------
X-Spam_report: (-6.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.199, RCVD_IN_DNSWL_HI=-5,
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
Reply-To: Bug 1897783 <1897783@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Looks like an installation problem.  On Ubuntu 20.04, python3-pip
depends on python3-wheel:


$ apt-cache show python3-pip | grep Depends
Depends: ca-certificates, python3-distutils, python3-setuptools, python3-wh=
eel, python-pip-whl (=3D 20.0.2-5ubuntu1), python3:any


And it gets pulled during an installation attempt:

$ apt install python3-pip =

Reading package lists... Done
Building dependency tree       =

Reading state information... Done
The following additional packages will be installed:
  binutils binutils-aarch64-linux-gnu binutils-common build-essential ca-ce=
rtificates cpp cpp-9 dirmngr dpkg-dev fakeroot file g++ g++-9 gcc
  gcc-9 gcc-9-base gnupg gnupg-l10n gnupg-utils gpg gpg-agent gpg-wks-clien=
t gpg-wks-server gpgconf gpgsm libalgorithm-diff-perl
  libalgorithm-diff-xs-perl libalgorithm-merge-perl libasan5 libasn1-8-heim=
dal libassuan0 libatomic1 libbinutils libc-dev-bin libc6-dev
  libcc1-0 libcrypt-dev libctf-nobfd0 libctf0 libdpkg-perl libexpat1 libexp=
at1-dev libfakeroot libfile-fcntllock-perl libgcc-9-dev
  libgdbm-compat4 libgdbm6 libgomp1 libgssapi3-heimdal libhcrypto4-heimdal =
libheimbase1-heimdal libheimntlm0-heimdal libhx509-5-heimdal
  libisl22 libitm1 libkrb5-26-heimdal libksba8 libldap-2.4-2 libldap-common=
 liblocale-gettext-perl liblsan0 libmagic-mgc libmagic1 libmpc3
  libmpdec2 libmpfr6 libnpth0 libperl5.30 libpython3-dev libpython3-stdlib =
libpython3.8 libpython3.8-dev libpython3.8-minimal
  libpython3.8-stdlib libreadline8 libroken18-heimdal libsasl2-2 libsasl2-m=
odules libsasl2-modules-db libsqlite3-0 libssl1.1 libstdc++-9-dev
  libtsan0 libubsan1 libwind0-heimdal linux-libc-dev make manpages manpages=
-dev mime-support netbase openssl patch perl perl-modules-5.30
  pinentry-curses python-pip-whl python3 python3-dev python3-distutils pyth=
on3-lib2to3 python3-minimal python3-pkg-resources python3-setuptools
  python3-wheel python3.8 python3.8-dev python3.8-minimal readline-common x=
z-utils zlib1g-dev

This is on:

lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 20.04.1 LTS
Release:        20.04
Codename:       focal

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1897783

Title:
  avocado tests not running on aarch64 host

Status in QEMU:
  New

Bug description:
  $ lsb_release -a
  No LSB modules are available.
  Distributor ID: Ubuntu
  Description:    Ubuntu 20.04.1 LTS
  Release:        20.04
  Codename:       focal

  $ make check-venv
    VENV    /home/phil/qemu/build/tests/venv
    PIP     /home/phil/qemu/tests/requirements.txt
    ERROR: Command errored out with exit status 1:
     command: /home/phil/qemu/build/tests/venv/bin/python -u -c 'import sys=
, setuptools, tokenize; sys.argv[0] =3D '"'"'/tmp/pip-install-w1h2bh4a/pycd=
lib/setup.py'"'"'; __file__=3D'"'"'/tmp/pip-install-w1h2bh4a/pycdlib/setup.=
py'"'"';f=3Dgetattr(tokenize, '"'"'open'"'"', open)(__file__);code=3Df.read=
().replace('"'"'\r\n'"'"', '"'"'\n'"'"');f.close();exec(compile(code, __fil=
e__, '"'"'exec'"'"'))' bdist_wheel -d /tmp/pip-wheel-ic25ctcg
         cwd: /tmp/pip-install-w1h2bh4a/pycdlib/
    Complete output (6 lines):
    usage: setup.py [global_opts] cmd1 [cmd1_opts] [cmd2 [cmd2_opts] ...]
       or: setup.py --help [cmd1 cmd2 ...]
       or: setup.py --help-commands
       or: setup.py cmd --help
    =

    error: invalid command 'bdist_wheel'
    ----------------------------------------
    ERROR: Failed building wheel for pycdlib
  $

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1897783/+subscriptions

