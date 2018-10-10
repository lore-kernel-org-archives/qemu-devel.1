Received: from eggs.gnu.org ([2001:4830:134:3::10]:58944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gAFnW-0002od-0Z
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 10:49:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gAFnP-0004bo-Mm
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 10:49:13 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:39191)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gAFnP-0004aQ-Ez
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 10:49:07 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed, 10 Oct 2018 10:48:49 -0400
Message-Id: <20181010144853.13005-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH 0/4] some TCG fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>

The first patch we've seen before -- I'm taking it from the
atomic interrupt_request series.

The other three patches are related to TCG profiling. One
of them is a build fix that I suspect has gone unnoticed
due to its dependence on CONFIG_PROFILER.

The series is checkpatch-clean. You can fetch it from:
  https://github.com/cota/qemu/tree/tcg-profile

Thanks,

		Emilio
