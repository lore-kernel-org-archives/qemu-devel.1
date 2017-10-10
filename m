Received: from eggs.gnu.org ([2001:4830:134:3::10]:49145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1vQz-0005HE-UL
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:23:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1vQy-0000y9-Lu
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:23:01 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:54813)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e1vQy-0000xk-Cs
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:23:00 -0400
Received: by mail-wm0-x22d.google.com with SMTP id i124so5838815wmf.3
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 07:23:00 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Oct 2017 15:22:38 +0100
Message-ID: <CAFEAcA-KNF0Q2HisqN8s0zhm1dyPxFrKri6tYNpUai_=OnAppw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] updating to a u-boot without the case-sensitive
 filename clash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Hi; we currently have an issue with the u-boot we're using where it
has a file and a directory that differ only in case (scripts/Kconfig
and scripts/kconfig/). This means that QEMU's release tarballs won't
unpack on a case-insensitive filesystem (OSX, Windows).

u-boot have now fixed this upstream:
http://git.denx.de/?p=u-boot.git;a=commitdiff;h=610eec7f0593574c034054ba54fc1c934755e208

but we need to decide how best to get this fix into QEMU so that
our tarballs will unpack, both for the upcoming QEMU 2.11 and
ideally for future point releases based on 2.10.

I can see a couple of options:
 (1) wait for next u-boot release (scheduled for Nov 13, 2017),
     and move to that
     [downsides: would be in the middle of QEMU's own release cycle,
      pretty late to fix any problems with the new version;
      rather a big change to put into stable]
 (2) move to u-boot current head-of-unstable
     [downsides: would mean running some random git commit version,
      also not really very suitable for stable]
 (3) backport the upstream fix to sit on top of the u-boot version
     we're currently using (I think the patch should apply as-is)
     [downsides: would need to figure out how to get that commit into
      the mirror of the u-boot repo that we use; would a build of it
      claim a misleading u-boot version number?]
 (4) suggest your better idea here!

Thoughts?

(Proposals for automated tests to ensure we don't run into the
case-sensitivity problem again in future also welcome.)

thanks
-- PMM
