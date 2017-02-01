Received: from eggs.gnu.org ([2001:4830:134:3::10]:42094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cYyei-0004SZ-4I
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 12:25:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cYyee-0001VA-Vu
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 12:25:16 -0500
Received: from indium.canonical.com ([91.189.90.7]:44417)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cYyee-0001Uu-QA
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 12:25:12 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cYyed-0007av-Vm
	for <qemu-devel@nongnu.org>; Wed, 01 Feb 2017 17:25:11 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E5D5C2E80C0
	for <qemu-devel@nongnu.org>; Wed,  1 Feb 2017 17:25:11 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Feb 2017 17:13:47 -0000
From: Narcis Garcia <1583421@bugs.launchpad.net>
Reply-To: Bug 1583421 <1583421@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160519041741.20886.94270.malonedeb@wampee.canonical.com>
Message-Id: <20170201171347.27297.50407.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1583421] Re: Please provide an option to print
 the default hardware configuration as command-line options,
 to make -nodefaults easier to use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

It's also necessary to document default hardware configuration of each
past release, because using defaults becomes a problem to keep guest OS
licenses when upgrading Qemu version.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1583421

Title:
  Please provide an option to print the default hardware configuration
  as command-line options, to make -nodefaults easier to use

Status in QEMU:
  New

Bug description:
  For full customization of the default set of hardware qemu supports, a
  user can pass -nodefaults and then manually specify each device they
  want.  Many specific options document what they translate to in terms
  of the full configuration model; however, the defaults for any given
  platform don't.

  I'd love to have documentation of the default hardware configuration,
  in terms of qemu command-line options, to make it easy to run qemu
  -nodefaults, paste in the default command-line, and edit it.

  As this varies by emulated machine, perhaps qemu could have a command-
  line option to print a specific machine (e.g. pc-i440fx-2.5) in the
  form of qemu command-line options?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1583421/+subscriptions
