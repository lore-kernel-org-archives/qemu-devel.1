Received: from eggs.gnu.org ([2001:4830:134:3::10]:59049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cmCGf-0000z1-Er
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 23:35:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cmCGb-0005Wz-IQ
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 23:35:05 -0500
Received: from indium.canonical.com ([91.189.90.7]:55221)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cmCGb-0005WT-C8
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 23:35:01 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cmCGZ-0008Bb-KW
	for <qemu-devel@nongnu.org>; Fri, 10 Mar 2017 04:34:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 95CA22E80CB
	for <qemu-devel@nongnu.org>; Fri, 10 Mar 2017 04:34:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Mar 2017 04:17:19 -0000
From: Launchpad Bug Tracker <887883@bugs.launchpad.net>
Reply-To: Bug 887883 <887883@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20111109053151.5724.96789.malonedeb@wampee.canonical.com>
Message-Id: <20170310041721.26893.54903.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 887883] Re: Coverity scan revealed defects
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/887883

Title:
  Coverity scan revealed defects

Status in QEMU:
  Expired

Bug description:
  Coverity scan detected some issues such as  RESOURCE_LEAK and
  REVERSE_INULL etc on qemu-1.0rc1:

  Analysis summary report:
  ------------------------
  Files analyzed                 : 830
  Total LoC input to cov-analyze : 576549
  Functions analyzed             : 20721
  Paths analyzed                 : 858376
  New defects found              : 428 Total
                                     2 ARRAY_VS_SINGLETON
                                     9 CHECKED_RETURN
                                    19 CONSTANT_EXPRESSION_RESULT
                                    60 DEADCODE
                                    43 FORWARD_NULL
                                    14 INFINITE_LOOP
                                    36 MISSING_BREAK
                                     3 MISSING_LOCK
                                    47 NEGATIVE_RETURNS
                                     1 NO_EFFECT
                                    11 NULL_RETURNS
                                    51 OVERRUN_STATIC
                                     1 RESOURCE_LEAK
                                    79 REVERSE_INULL
                                    20 SIGN_EXTENSION
                                     7 SIZEOF_MISMATCH
                                    15 UNINIT
                                     5 UNREACHABLE
                                     2 UNUSED_VALUE
                                     3 USE_AFTER_FREE

  For details, please see attachment.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/887883/+subscriptions
