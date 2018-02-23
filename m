Received: from eggs.gnu.org ([2001:4830:134:3::10]:48124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1epFYB-0003gQ-Rz
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:46:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1epFY8-00086F-LF
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:46:19 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:56264)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1epFY8-00084e-EY
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:46:16 -0500
Received: by mail-wm0-x242.google.com with SMTP id q83so5472610wme.5
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 07:46:16 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 23 Feb 2018 15:46:05 +0000
Message-Id: <20180223154613.2096-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH REPOST v1 0/8] Group support and random
 clean-ups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, richard.henderson@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

This is essentially a re-post but with a wider distribution. There is
one extra patch which adds the FP16 1 source data processing. This is for
discussion on how best to represent all the different architectural
versions by using the second field in the aarch64.risu file.

Alex Bennée (8):
  risugen: support @GroupName in risu files
  aarch64.risu: clean-up and annotate with groups
  aarch64.risu: add cryptographic extensions for v8.2
  new contrib/generate_all.sh: batch risugen script
  contrib/run_risu.sh: allow appending of QEMU_FLAGS
  contrib/run_risu.sh: don't set -e
  contrib/run_risu.sh: add a visual cue for a clean-run
  aarch64.risu: update Floating-point data-processing (1 source)

 README                  |  10 ++
 aarch64.risu            | 287 +++++++++++++++++++++++++++++++++---------------
 contrib/generate_all.sh |  96 ++++++++++++++++
 contrib/run_risu.sh     |  10 +-
 risugen                 |  24 +++-
 5 files changed, 335 insertions(+), 92 deletions(-)
 create mode 100755 contrib/generate_all.sh

-- 
2.15.1
