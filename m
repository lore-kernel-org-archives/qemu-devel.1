Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D34C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 10:52:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F514206B5
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 10:52:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F514206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8LhM-0000MX-Tz
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 06:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k8LgN-0007iW-3Z
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 06:51:03 -0400
Received: from indium.canonical.com ([91.189.90.7]:44552)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k8LgK-0004Dw-Uh
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 06:51:02 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k8LgI-0004h7-Ni
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2020 10:50:58 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id AD6152E8023
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2020 10:50:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2020 10:36:53 -0000
From: Jonathan Wakely <1886155@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: jwakely mliska
X-Launchpad-Bug-Reporter: Martin Liska (mliska)
X-Launchpad-Bug-Modifier: Jonathan Wakely (jwakely)
References: <159376359338.16005.10195773015354828175.malonedeb@soybean.canonical.com>
Message-Id: <159783341366.32636.16429140323070349472.malone@wampee.canonical.com>
Subject: =?utf-8?q?=5BBug_1886155=5D_Re=3A_error=3A_argument_2_of_=E2=80=98?=
 =?utf-8?b?X19hdG9taWNfbG9hZOKAmSBkaXNjYXJkcyDigJhjb25zdOKAmSBxdWFsaWZpZXI=?=
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="99c2d833c8d727fd05148486920aca032e908071"; Instance="production"
X-Launchpad-Hash: b9a61b3f4528808d5056b512348df1f8e2c8341c
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 06:50:59
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1886155 <1886155@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It looks like `typeof_strip_qual` doesn't work for pointer types.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1886155

Title:
  error: argument 2 of =E2=80=98__atomic_load=E2=80=99 discards =E2=80=98co=
nst=E2=80=99 qualifier

Status in QEMU:
  New

Bug description:
  GCC 11 reports the following errors:

  [  125s] In file included from /home/abuild/rpmbuild/BUILD/qemu-5.0.0/inc=
lude/qemu/seqlock.h:17,
  [  125s]                  from /home/abuild/rpmbuild/BUILD/qemu-5.0.0/inc=
lude/qemu/qht.h:10,
  [  125s]                  from /home/abuild/rpmbuild/BUILD/qemu-5.0.0/uti=
l/qht.c:69:
  [  125s] /home/abuild/rpmbuild/BUILD/qemu-5.0.0/util/qht.c: In function '=
qht_do_lookup':
  [  125s] /home/abuild/rpmbuild/BUILD/qemu-5.0.0/include/qemu/atomic.h:153=
:5: error: argument 2 of '__atomic_load' discards 'const' qualifier [-Werro=
r=3Dincompatible-pointer-types]
  [  125s]   153 |     __atomic_load(ptr, valptr, __ATOMIC_RELAXED);       \
  [  125s]       |     ^~~~~~~~~~~~~
  [  125s] /home/abuild/rpmbuild/BUILD/qemu-5.0.0/include/qemu/atomic.h:161=
:5: note: in expansion of macro 'atomic_rcu_read__nocheck'
  [  125s]   161 |     atomic_rcu_read__nocheck(ptr, &_val);             \
  [  125s]       |     ^~~~~~~~~~~~~~~~~~~~~~~~
  [  125s] /home/abuild/rpmbuild/BUILD/qemu-5.0.0/util/qht.c:499:27: note: =
in expansion of macro 'atomic_rcu_read'
  [  125s]   499 |                 void *p =3D atomic_rcu_read(&b->pointers=
[i]);
  [  125s]       |                           ^~~~~~~~~~~~~~~
  [  125s] /home/abuild/rpmbuild/BUILD/qemu-5.0.0/include/qemu/atomic.h:153=
:5: error: argument 2 of '__atomic_load' discards 'const' qualifier [-Werro=
r=3Dincompatible-pointer-types]
  [  125s]   153 |     __atomic_load(ptr, valptr, __ATOMIC_RELAXED);       \
  [  125s]       |     ^~~~~~~~~~~~~
  [  125s] /home/abuild/rpmbuild/BUILD/qemu-5.0.0/include/qemu/atomic.h:161=
:5: note: in expansion of macro 'atomic_rcu_read__nocheck'
  [  125s]   161 |     atomic_rcu_read__nocheck(ptr, &_val);             \
  [  125s]       |     ^~~~~~~~~~~~~~~~~~~~~~~~
  [  125s] /home/abuild/rpmbuild/BUILD/qemu-5.0.0/util/qht.c:506:13: note: =
in expansion of macro 'atomic_rcu_read'
  [  125s]   506 |         b =3D atomic_rcu_read(&b->next);
  [  125s]       |             ^~~~~~~~~~~~~~~
  [  125s] /home/abuild/rpmbuild/BUILD/qemu-5.0.0/util/qht.c: In function '=
qht_lookup_custom':
  [  125s] /home/abuild/rpmbuild/BUILD/qemu-5.0.0/include/qemu/atomic.h:153=
:5: error: argument 2 of '__atomic_load' discards 'const' qualifier [-Werro=
r=3Dincompatible-pointer-types]
  [  125s]   153 |     __atomic_load(ptr, valptr, __ATOMIC_RELAXED);       \
  [  125s]       |     ^~~~~~~~~~~~~
  [  125s] /home/abuild/rpmbuild/BUILD/qemu-5.0.0/include/qemu/atomic.h:161=
:5: note: in expansion of macro 'atomic_rcu_read__nocheck'
  [  125s]   161 |     atomic_rcu_read__nocheck(ptr, &_val);             \
  [  125s]       |     ^~~~~~~~~~~~~~~~~~~~~~~~
  [  125s] /home/abuild/rpmbuild/BUILD/qemu-5.0.0/util/qht.c:534:11: note: =
in expansion of macro 'atomic_rcu_read'
  [  125s]   534 |     map =3D atomic_rcu_read(&ht->map);
  [  125s]       |           ^~~~~~~~~~~~~~~
  [  125s] /home/abuild/rpmbuild/BUILD/qemu-5.0.0/util/qht.c: In function '=
qht_statistics_init':
  [  125s] /home/abuild/rpmbuild/BUILD/qemu-5.0.0/include/qemu/atomic.h:153=
:5: error: argument 2 of '__atomic_load' discards 'const' qualifier [-Werro=
r=3Dincompatible-pointer-types]
  [  125s]   153 |     __atomic_load(ptr, valptr, __ATOMIC_RELAXED);       \
  [  125s]       |     ^~~~~~~~~~~~~
  [  125s] /home/abuild/rpmbuild/BUILD/qemu-5.0.0/include/qemu/atomic.h:161=
:5: note: in expansion of macro 'atomic_rcu_read__nocheck'
  [  125s]   161 |     atomic_rcu_read__nocheck(ptr, &_val);             \
  [  125s]       |     ^~~~~~~~~~~~~~~~~~~~~~~~
  [  125s] /home/abuild/rpmbuild/BUILD/qemu-5.0.0/util/qht.c:907:11: note: =
in expansion of macro 'atomic_rcu_read'
  [  125s]   907 |     map =3D atomic_rcu_read(&ht->map);
  [  125s]       |           ^~~~~~~~~~~~~~~
  [  125s] /home/abuild/rpmbuild/BUILD/qemu-5.0.0/include/qemu/atomic.h:153=
:5: error: argument 2 of '__atomic_load' discards 'const' qualifier [-Werro=
r=3Dincompatible-pointer-types]
  [  125s]   153 |     __atomic_load(ptr, valptr, __ATOMIC_RELAXED);       \
  [  125s]       |     ^~~~~~~~~~~~~
  [  125s] /home/abuild/rpmbuild/BUILD/qemu-5.0.0/include/qemu/atomic.h:161=
:5: note: in expansion of macro 'atomic_rcu_read__nocheck'
  [  125s]   161 |     atomic_rcu_read__nocheck(ptr, &_val);             \
  [  125s]       |     ^~~~~~~~~~~~~~~~~~~~~~~~
  [  125s] /home/abuild/rpmbuild/BUILD/qemu-5.0.0/util/qht.c:941:21: note: =
in expansion of macro 'atomic_rcu_read'
  [  125s]   941 |                 b =3D atomic_rcu_read(&b->next);
  [  125s]       |                     ^~~~~~~~~~~~~~~

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1886155/+subscriptions

