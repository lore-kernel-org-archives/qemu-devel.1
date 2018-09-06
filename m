Received: from eggs.gnu.org ([2001:4830:134:3::10]:48411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fxvxX-00086S-Gj
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 11:12:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fxvxT-0001Je-HJ
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 11:12:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58532 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fxvxS-0001EH-I3
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 11:12:35 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  6 Sep 2018 19:12:17 +0400
Message-Id: <20180906151227.25514-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 00/10] Various qemu command line options help
 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

This is a compilation of patches I have to improve command line help
support. The first 2 patches have already been sent earlier, I
modified the first to fix an issue reported by Markus. The other
patches add support for -object help. A few preliminary patches for
QOM, to fix/improve some minor issues.

Marc-Andr=C3=A9 Lureau (10):
  qemu-option: add help fallback to print the list of options
  qemu-option: improve qemu_opts_print_help() output
  qom/object: fix iterating properties over a class
  qom/object: register 'type' property as class property
  tests/qom-proplist: check duplicate "bv" property registration failed
  tests/qom-proplist: check properties are not listed multiple times
  tests/qom-proplist: check class properties iterator
  vl: handle -object ?
  hostmem: add some properties description
  vl: list user creatable propeties if '?' as argument

 backends/hostmem-memfd.c   |  9 +++++
 backends/hostmem.c         | 14 +++++++
 qom/object.c               |  9 +++--
 qom/object_interfaces.c    |  6 +--
 tests/check-qom-proplist.c | 58 +++++++++++++++++-----------
 util/qemu-option.c         | 77 +++++++++++++++++++++++++++++++-------
 vl.c                       | 58 ++++++++++++++++++++++++++--
 7 files changed, 187 insertions(+), 44 deletions(-)

--=20
2.19.0.rc1
