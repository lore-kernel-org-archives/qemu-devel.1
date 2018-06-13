Received: from eggs.gnu.org ([2001:4830:134:3::10]:50261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fTC4q-0003mY-UW
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 16:09:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fTC4m-0002HW-6K
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 16:09:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fTC4l-0002HB-Vx
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 16:09:04 -0400
Date: Wed, 13 Jun 2018 17:08:58 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180613200858.GM7451@localhost.localdomain>
References: <20180612173437.14462-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180612173437.14462-1-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] configure: Enable out-of-tree acceptance
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Fam Zheng <famz@redhat.com>, Amador Pahim <amador@pahim.org>, Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org

On Tue, Jun 12, 2018 at 02:34:37PM -0300, Philippe Mathieu-Daud=E9 wrote:
> Currently to run Avocado acceptance tests in an out-of-tree
> build directory, we need to use the full path to the test:
>=20
>   build_dir$ avocado run /full/path/to/sources/qemu/tests/acceptance/bo=
ot_linux_console.py
>=20
> This patch adds a symlink in the build tree to simplify the
> tests invocation, allowing the same command than in in-tree builds:
>=20
>   build_dir$ avocado run tests/acceptance/boot_linux_console.py
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

Queued on python-next, thanks!

--=20
Eduardo
