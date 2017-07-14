Received: from eggs.gnu.org ([2001:4830:134:3::10]:44227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dVxdj-0005XT-IR
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:16:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dVxdf-0007Fw-Gc
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:16:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42280)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dVxdf-0007Fg-A6
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:15:59 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri, 14 Jul 2017 11:15:47 +0100
Message-Id: <20170714101549.28665-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v4 0/2] Document deprecated features & support
 lifecycle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

This is a followup to

  v1: https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg02390.html
  v2: https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg01286.html
  v3: https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg00651.html

I would really strongly like to see this documented in time for the
2.10 release, so that we can start the clock ticking on our deprecation
policy and thus actually delete some stuff in the not too distant
future.

The goal is to clarify to users & app developers what they can expect
from QEMU in terms of feature lifecycle & any deprecation policy should
it be neccessary to remove features.

The list of features marked as deprecated was determined by looking at
the QEMU source for the word "deprecated'. It was then compared with
the doc Thomas put up at http://wiki.qemu.org/Features/LegacyRemoval

Key differences with the wiki page that Thomas wrote up vs patch 2
in this series

 - Deprecated features are given a fixed lifespan of 2 releases,
   rather than listing deletion at a future "major" v3.0.0 release.
   This ensures that applications like libvirt have a predictable
   fixed amount of time to react to deprecations.

 - Only lists features which are currently officially deprecated,
   no list of possible future candidates. The wiki page is probably
   a good place to maintain a list of future possible deprecations.
   To turn them into actual deprecations, a patch to the QEMU doc
   can then be posted & reviewed in the normal manner.

 - Not listing the '-6' and '-e' args to qemu-img create. Those
   were never deprecations, because the functionality was
   immediately turned into a fatal error. Patches to delete these
   have been merged now

Changed in v4:

 - Misc typos / wording clarification (Thomas)

Changed in v3:

 - Rename appendix to "Deprecated features" (Markus)
 - List all currently deprecated features
 - Document that deprecated features will be removed after
   2 releases of being deprecated
 - Clarify that clock for removing historically deprecated
   features starts with the forthcoming release.

Changed in v2:

 - Split into 2 patches so we can consider each suggested addition
   independantly.

Daniel P. Berrange (2):
  docs: document support lifetime for features
  docs: document deprecated features in appendix

 qemu-doc.texi | 205 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 205 insertions(+)

-- 
2.13.0
