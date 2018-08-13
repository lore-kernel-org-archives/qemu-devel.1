Received: from eggs.gnu.org ([2001:4830:134:3::10]:51712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fpGNe-0005Wh-Ub
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:11:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fpGNb-0006b2-L1
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:11:46 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:57049)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fpGNb-0006aW-Cs
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:11:43 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon, 13 Aug 2018 13:11:29 -0400
Message-Id: <20180813171132.21939-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH 0/3] synchronization profiler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Weil <sw@weilnetz.de>, Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>

This series adds a synchronization profiler, similar to the one
described in
  https://www.usenix.org/system/files/conference/atc12/atc12-final237.pdf
, although without using perf counters.

The profiler allows us to identify what wait times in locks/condvars are,
and where they are coming from. This info is very useful to
identify scalability bottlenecks imposed by locks, particularly
the BQL. I have patches (currently out of tree) to switch the
BQL for per-CPU locks to keep track of CPU state; the profiler was
really useful when doing that work.

The profiler is disabled by default, and can be enabled by configuring
with --enable-sync-profiler. Overhead is pretty low though, see
patch 1's commit log.

You can fetch the patches from:
  https://github.com/cota/qemu/tree/sync-profiler

Note that checkpatch gives some warnings, but they are false positives.

Thanks,

		Emilio
