Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36562C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 10:21:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08EE720730
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 10:21:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08EE720730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isOl2-0006Q5-6d
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 05:21:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54555)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1isOk7-0005f3-7p
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 05:20:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1isOk3-0007PX-2c
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 05:20:43 -0500
Received: from indium.canonical.com ([91.189.90.7]:41188)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1isOk2-0007OQ-Sv
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 05:20:39 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1isOk1-00009v-F0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 10:20:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 6ED702E80C8
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 10:20:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jan 2020 10:13:35 -0000
From: Max Reitz <1859989@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: 5-plamen xanclic
X-Launchpad-Bug-Reporter: pevogam (5-plamen)
X-Launchpad-Bug-Modifier: Max Reitz (xanclic)
References: <157918316689.4864.12553262908100217782.malonedeb@wampee.canonical.com>
Message-Id: <157925601569.23128.14572633577549563237.malone@gac.canonical.com>
Subject: [Bug 1859989] Re: qemu-img has broken output with large snapshot names
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="f1052173880d8dae43faa7c2fc45da1b42227143";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 4d8cfe4cbcde9dbc5bdd53d15cbcee9823e6ecf5
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 91.189.90.7
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
Reply-To: Bug 1859989 <1859989@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I=E2=80=99ve just seen that launchpad collapses the spaces in the snapshot.=
..
All I can say is that diff tells me the output from 2.12.0 and 4.1.1 is
exactly the same, with only one difference: 2.12.0 prints the VM SIZE as
=E2=80=9C0=E2=80=9D (without a unit), whereas 4.1.1 prints =E2=80=9C0 B=E2=
=80=9D.

But now I just realized you probably mean that there is no space between
the snapshot name and the VM state size in your example.  OK, I thought
you meant the fact that the headers are not aligned to the table body
columns.

That seems to be because the size is printed in a 7-wide field, which
isn=E2=80=99t sufficient for three-digit sizes with unit prefixes; so =E2=
=80=9C747 MiB=E2=80=9D
is not prefixed by a space.  I think de38b5005e9 is to blame which which
(from what I can tell) effectively changed the output from using SI
prefixes to IEC prefixes (which requires one more character), adds a
space before and a =E2=80=9CB=E2=80=9D after the prefix (another two additi=
onal
characters), and by always printing three digits, which may require a
decimal point (so another character).  But it didn=E2=80=99t grow the field
width.  So I think we should do that.

Max

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1859989

Title:
  qemu-img has broken output with large snapshot names

Status in QEMU:
  New

Bug description:
  On Qemu 4.1.1 the output of snapshots breaks if the chosen state name
  is too long:

  ```
  # qemu-img snapshot -l /mnt/local/some_image.qcow2
  Snapshot list:
  ID        TAG                 VM SIZE                DATE       VM CLOCK
  1         online_provider_with_dhcp747 MiB 2020-01-15 12:05:01   00:00:45=
.873
  ```

  Prior to 4.1.1 this used to work with extra tabs for the VM SIZE
  values. The collision is also disabling us from using a regex on top
  of this output to detect the snapshot.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1859989/+subscriptions

