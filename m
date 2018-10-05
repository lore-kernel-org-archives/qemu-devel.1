Received: from eggs.gnu.org ([2001:4830:134:3::10]:58539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g8PER-0007u8-6n
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 08:29:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g8PEN-0005OG-VR
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 08:29:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1g8PEN-0005Lq-NS
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 08:29:19 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  5 Oct 2018 16:28:58 +0400
Message-Id: <20181005122910.11745-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 00/12] Option patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The following changes since commit b8e5671a8cd196e7262802ca895bf87d504169=
89:

  Merge remote-tracking branch 'remotes/elmarco/tags/chardev-pull-request=
' into staging (2018-10-03 14:07:49 +0100)

are available in the Git repository at:

  https://github.com/elmarco/qemu.git tags/option-pull-request

for you to fetch changes up to 1195fa2b08d98ab503155c5cee8831d1ef91aac5:

  vl: list user creatable properties when 'help' is argument (2018-10-05 =
16:27:09 +0400)

----------------------------------------------------------------
CLI help improvements

PULLv2:
 - fix uninitialized "seentype" variable in qom-test

----------------------------------------------------------------

Marc-Andr=C3=A9 Lureau (12):
  qdev-monitor: print help to stdout
  cutils: add qemu_pstrcmp0()
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

 include/monitor/monitor.h  |  3 ++
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
 12 files changed, 228 insertions(+), 60 deletions(-)

--=20
2.19.0.271.gfe8321ec05
