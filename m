Received: from eggs.gnu.org ([2001:4830:134:3::10]:38006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fU9xa-00065j-AY
	for qemu-devel@nongnu.org; Sat, 16 Jun 2018 08:05:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fU9xX-0001QG-5w
	for qemu-devel@nongnu.org; Sat, 16 Jun 2018 08:05:38 -0400
Received: from indium.canonical.com ([91.189.90.7]:48922)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fU9xW-0001Ps-VI
	for qemu-devel@nongnu.org; Sat, 16 Jun 2018 08:05:35 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fU9xV-0000NO-W1
	for <qemu-devel@nongnu.org>; Sat, 16 Jun 2018 12:05:33 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id ED6D72E80C8
	for <qemu-devel@nongnu.org>; Sat, 16 Jun 2018 12:05:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 16 Jun 2018 12:00:05 -0000
From: Shimi Gersner <gersner@gmail.com>
Reply-To: Bug 1777236 <1777236@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <152915040560.6976.16916534721422810737.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1777236] [NEW] NVME is missing support for
 mandatory features through "Get/Set Feature" command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

The following are features which are marked as mandatory by the 1.2 specifi=
cation (NVMe 1.2, Section 5.14.1, Figure 108) as currently not implemented
 - 0x1 Arbitration
 - 0x2 Power Management
 - 0x4 Temperature Threshold
 - 0x5 Error Recovery
 - 0x6 Interrupt Coalescing
 - 0x7 Interrupt Vector Configuration
 - 0x8 Write Atomicity Normal
 - 0x9 Asynchronous Event Configuration

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1777236

Title:
  NVME is missing support for mandatory features through "Get/Set
  Feature" command

Status in QEMU:
  New

Bug description:
  The following are features which are marked as mandatory by the 1.2 speci=
fication (NVMe 1.2, Section 5.14.1, Figure 108) as currently not implemented
   - 0x1 Arbitration
   - 0x2 Power Management
   - 0x4 Temperature Threshold
   - 0x5 Error Recovery
   - 0x6 Interrupt Coalescing
   - 0x7 Interrupt Vector Configuration
   - 0x8 Write Atomicity Normal
   - 0x9 Asynchronous Event Configuration

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1777236/+subscriptions
