Received: from eggs.gnu.org ([2001:4830:134:3::10]:59374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e9Xwc-0000dv-0r
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 10:55:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e9XwS-000705-NY
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 10:55:10 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:51936)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1e9XwS-0006zJ-ID
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 10:55:00 -0400
Received: by mail-wm0-x22b.google.com with SMTP id b9so23836306wmh.0
	for <qemu-devel@nongnu.org>; Tue, 31 Oct 2017 07:55:00 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 31 Oct 2017 14:54:37 +0000
Message-Id: <20171031145444.13766-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH 0/7] Add @Group support and some
 aarch64.risu cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi Peter,

My RISU patch queue was running a little long so I thought I should
push up stuff that was ready. The first few patches are simply
clean-ups to the aarch64.risu file, mostly removing duplicate blocks
that have crept in.

There is a prerequisite clean-up patch which moves the filtering into
the common risugen code and passes an array of keys to the backend.

Then I add support for @GroupName annotations which allow for a nicer
selection of groups of instructions. This works across all
architectures now.

Finally a big (but mechanical) update of the aarch64.risu file. I've
aligned the names of the major groups to what the ASL/ARM ARM uses and
added some example @Groups for the gross sections. I expect to add
more fine-grained groups later as we add the new half-precision and
SVE instructions.

Alex Bennée (7):
  aarch64.risu: document naming conventions
  aarch64.risu: remove duplicate AdvSIMD Scalar 3 same block
  aarch64.risu: remove duplicate AdvSIMD scalar 2 reg misc block
  aarch64.risu: update AdvancedSIMD across lanes
  risugen/risugen_$arch: factor out instruction selection
  risugen: support @GroupName in risu files
  aarch64.risu: clean-up and annotate with groups

 README           |  10 ++
 aarch64.risu     | 423 +++++++++++++++++++++++++++++--------------------------
 risugen          |  49 ++++++-
 risugen_arm.pm   |  18 +--
 risugen_m68k.pm  |  18 +--
 risugen_ppc64.pm |  18 +--
 6 files changed, 285 insertions(+), 251 deletions(-)

-- 
2.14.2
