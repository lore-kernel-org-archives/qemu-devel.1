Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B843C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 15:56:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E3BE2071E
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 15:56:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E3BE2071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAEpx-00076V-Tw
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 11:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kAEp8-0006G5-G4
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 11:55:54 -0400
Received: from indium.canonical.com ([91.189.90.7]:41688)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kAEp6-0000Kf-2r
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 11:55:54 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kAEp3-0003XW-M5
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 15:55:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 6B5362E80EA
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 15:55:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2020 15:46:42 -0000
From: John Snow <1874678@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Wishlist; assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: jnsnow philmd rohits134
X-Launchpad-Bug-Reporter: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
X-Launchpad-Bug-Modifier: John Snow (jnsnow)
References: <158772236083.23646.1538920873771593848.malonedeb@chaenomeles.canonical.com>
Message-Id: <159828400247.375.28582290610671242.malone@wampee.canonical.com>
Subject: [Bug 1874678] Re: [Feature request] python-qemu package
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="99c2d833c8d727fd05148486920aca032e908071"; Instance="production"
X-Launchpad-Hash: de227dbddbaa99782b1be96f06b3feaa7eb24f4b
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 11:55:50
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
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
Reply-To: Bug 1874678 <1874678@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Rohit! I am actively involved in pursuing this at the moment. I have
patches that do a lot of this work, but they are not complete and did
not get merged in time for 5.1. I will have to update my development
branches (soon) and share that code.

If you'd like to help, there are three main areas of consideration:

(1) I would like to ensure that all code in ./python/qemu is 100%
pylint/mypy/flake8 compliant. I have many patches for this in
particular. Once it's compliant, we need to prevent regressions: This
task is less well defined in my head. Ideally the package is checked
pythonically (via pytest, perhaps?) as well as via hooks in the QEMU
source tree itself as a `make check-python` style target that can be
checked from e.g. gitlab CI.

For now, the python package will live in the QEMU source tree, so it
needs to function in both contexts simultaneously.

I consider this a requisite for packaging our SDK because it will help
us prevent a certain class of regressions. By smoothing out the API and
its typing in advance, the package will be less turbulent and, if needs
be, easier to refactor with confidence in the future.


(2) The code itself needs packaging glue (setup.py et al.). I also have pat=
ches here that move ./python/qemu to ./python/qemu/core and installs this a=
s a PEP-420 namespace package, 'qemu.core'. The idea was to add different Q=
EMU modules over time -- possibly with different dependencies, etc.

One of the ideas is for everything in ./python to be checked using the
same flake8/mypy/pylint regimes for consistency; but if we were to
upload any packages to PyPI, I want to be able to upload them
separately. e.g.

./python/qemu/core =3D=3D> PyPI "qemu"
./python/qemu/qapi =3D=3D> PyPI "qemu.qapi"

I didn't figure out how facilitate that just yet -- at the moment, any
subpackages present in-tree get uploaded as part of the core API, and
that's not what I wanted to do. Some subpackages we create are going to
be ones we don't want to ever upload to PyPI, but having them in a
standard package form will help with regression testing and development
in-tree.


(3) Versioning is a complex topic and needs some consensus.

- Do we version the subpackages separately, or should they use the parent Q=
EMU version?
- Should we release point fixes, or only release alongside official QEMU re=
leases?
- How do we indicate beta status? If we release at version 5.2, people migh=
t expect SDK API stability, but we can't promise that yet!
- QEMU does not use semver, but Python ecosystem largely does. The QEMU dep=
recation policy may not mesh well with Python's expected behavior.

There's a lot there to think about before we push a package to PyPI.
Pushing to PyPI, however, is not a requisite for accomplishing the first
two tasks -- so we can shelf this for a little bit.


If you have some experience with python packaging and distribution and woul=
d like to help, let me know. You can sign up for the qemu development maili=
ng list [1], and send a mail introducing yourself and CC the following folk=
s:

John Snow <jsnow@redhat.com>
Cleber Rosa <crosa@redhat.com>
Eduardo Habkost <ehabkost@redhat.com>

Thanks,
--js


[1] https://lists.gnu.org/mailman/listinfo/qemu-devel

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1874678

Title:
  [Feature request] python-qemu package

Status in QEMU:
  New

Bug description:
  It would be useful to have the python/qemu/ files published as a
  Python pip package, so users from distribution can also use the QEMU
  python methods (in particular for testing) without having to clone the
  full repository.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1874678/+subscriptions

