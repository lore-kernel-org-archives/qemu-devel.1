Received: from eggs.gnu.org ([2001:4830:134:3::10]:55803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fyBgN-0002Is-NA
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 04:00:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fyBgI-0007OU-Nw
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 03:59:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42986 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fyBgI-0007NL-He
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 03:59:54 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  7 Sep 2018 11:59:36 +0400
Message-Id: <20180907075948.26917-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 00/12] Various qemu command line options
 help improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, eblake@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

This is a compilation of patches I have to improve command line help
support. The "qemu-option" patches have already been sent earlier, I
modified the first to fix an issue reported by Markus. The other
patches add support for -object help. A few related patches for QOM,
to fix/improve some minor issues.

v2: after Eric Blake review
- add "qdev-monitor: print help to stdout"
- add "cutils: add qemu_pstrcmp"
- use consistently "arg=3Dtype - desc" help format

Marc-Andr=C3=A9 Lureau (12):
  qdev-monitor: print help to stdout
  cutils: add qemu_pstrcmp
  qemu-option: add help fallback to print the list of options
  qemu-option: improve qemu_opts_print_help() output
  qom/object: fix iterating properties over a class
  qom/object: register 'type' property as class property
  tests/qom-proplist: check duplicate "bv" property registration failed
  tests/qom-proplist: check properties are not listed multiple times
  tests/qom-proplist: check class properties iterator
  vl: handle -object help
  hostmem: add some properties description
  vl: list user creatable properties when 'help' is argument

 include/monitor/monitor.h  |  2 ++
 include/qemu/cutils.h      | 12 +++++++
 backends/hostmem-memfd.c   |  9 +++++
 backends/hostmem.c         | 14 ++++++++
 monitor.c                  | 16 +++++++--
 qdev-monitor.c             | 32 ++++++++++-------
 qom/object.c               |  9 ++---
 qom/object_interfaces.c    |  6 ++--
 tests/check-qom-proplist.c | 58 ++++++++++++++++++++-----------
 util/cutils.c              |  5 +++
 util/qemu-option.c         | 71 +++++++++++++++++++++++++++++++-------
 vl.c                       | 53 ++++++++++++++++++++++++++--
 12 files changed, 227 insertions(+), 60 deletions(-)

--=20
2.19.0.rc1
