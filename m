Received: from eggs.gnu.org ([2001:4830:134:3::10]:49567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fYA28-0003Y8-Lf
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:58:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fYA27-0003qG-PN
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:58:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42198 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fYA27-0003pm-KS
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:58:51 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 27 Jun 2018 13:58:41 +0100
Message-Id: <20180627125847.5413-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/6] Tracing patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Peter Maydell <peter.maydell@linaro.org>

The following changes since commit 00928a421d47f49691cace1207481b7aad31b1=
f1:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-201=
80626' into staging (2018-06-26 18:23:49 +0100)

are available in the Git repository at:

  git://github.com/stefanha/qemu.git tags/tracing-pull-request

for you to fetch changes up to ec09f877532210e28e1d4b6b12896d3eb6d8e8d1:

  trace: forbid floating point types (2018-06-27 11:09:29 +0100)

----------------------------------------------------------------
Pull request

 * Trace TCG atomic memory accesses
 * Document that trace event arguments cannot be floating point

----------------------------------------------------------------

Emilio G. Cota (5):
  trace: fix misreporting of TCG access sizes for user-space
  trace: simplify trace_mem functions
  trace: expand mem_info:size_shift to 3 bits
  trace: add trace_mem_build_info_no_se_be/le
  trace: enable tracing of TCG atomics

Stefan Hajnoczi (1):
  trace: forbid floating point types

 docs/devel/tracing.txt                    |  5 ++
 accel/tcg/atomic_template.h               | 87 +++++++++++++++++++++--
 include/exec/cpu_ldst_useronly_template.h | 11 ++-
 trace/mem-internal.h                      | 58 ++++++++-------
 trace/mem.h                               |  2 +-
 migration/trace-events                    |  2 +-
 qapi/trace-events                         |  2 +-
 scripts/tracetool/__init__.py             |  2 -
 8 files changed, 130 insertions(+), 39 deletions(-)

--=20
2.17.1
