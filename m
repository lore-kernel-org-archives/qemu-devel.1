Received: from eggs.gnu.org ([2001:4830:134:3::10]:46165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dQTc2-0003YQ-Nm
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 03:11:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dQTbx-0002KM-Qe
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 03:11:38 -0400
Received: from mail-yw0-x243.google.com ([2607:f8b0:4002:c05::243]:35201)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1dQTbx-0002Js-MS
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 03:11:33 -0400
Received: by mail-yw0-x243.google.com with SMTP id z21so4576551ywz.2
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 00:11:32 -0700 (PDT)
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Thu, 29 Jun 2017 03:11:27 -0400
Message-Id: <20170629071129.29362-1-bobby.prani@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/2] Pending MTTCG patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, pbonzini@redhat.com, ehabkost@redhat.com

Hello,

Please find these two pending MTTCG fixes I have in my repo.

I've reworked the async_safe_* patch according to pbonzini's suggestion.

Thanks,

Pranith Kumar (2):
  Revert "exec.c: Fix breakpoint invalidation race"
  mttcg/i386: Patch instruction using async_safe_* framework

 exec.c             | 25 ++++++++++++++-----
 hw/i386/kvmvapic.c | 73 +++++++++++++++++++++++++++++++-----------------------
 2 files changed, 61 insertions(+), 37 deletions(-)

-- 
2.13.0
