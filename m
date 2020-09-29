Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00D0C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:56:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF0EC20757
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:56:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF0EC20757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNMfV-00042x-T5
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 16:56:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kNMex-0003dI-2w
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 16:55:39 -0400
Received: from indium.canonical.com ([91.189.90.7]:37654)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kNMeu-00005z-TB
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 16:55:38 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kNMet-0002p6-43
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 20:55:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 1CD272E8053
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 20:55:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2020 20:46:55 -0000
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
Message-Id: <160141241539.22432.5241417331889314566.malone@gac.canonical.com>
Subject: [Bug 1897783] Re: avocado tests not running on aarch64 host
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="d685c0a40836eb9844ed835c9700f20633c1d7af"; Instance="production"
X-Launchpad-Hash: 4c47099173252e9d878b8c6c877af75dbcab0289
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

This seems to happen on this specific machine, not because it's an
aarch64 machine, but because it has python3-minimal installed.  The docs
on the acceptance test state that:

---
Note: the build environment must be using a Python 3 stack, and have
the ``venv`` and ``pip`` packages installed.  If necessary, make sure
``configure`` is called with ``--python=3D`` and that those modules are
available.  On Debian and Ubuntu based systems, depending on the
specific version, they may be on packages named ``python3-venv`` and
``python3-pip``.
---

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

