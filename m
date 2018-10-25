Received: from eggs.gnu.org ([2001:4830:134:3::10]:60593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gFZZV-0000wo-Cm
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 02:56:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gFZZS-0001Mw-4j
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 02:56:45 -0400
References: <38b0df70-338e-c842-95bb-c1a5fbd54b7b@vivier.eu>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <678d990b-e016-6ce0-ec8b-39891dc56a90@redhat.com>
Date: Thu, 25 Oct 2018 07:56:33 +0100
MIME-Version: 1.0
In-Reply-To: <38b0df70-338e-c842-95bb-c1a5fbd54b7b@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Call for patches for the qemu-trivial pull request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel qemu-devel <qemu-devel@nongnu.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>

On 2018-10-23 11:04, Laurent Vivier wrote:
> Hi,
>=20
> I'm going to collect patches for the next pull request for the
> qemu-trivial I'd like to do before the softfreeze.
>=20
> As we didn't have any pull request for more than 3 months and some of
> the patches have been pushed through another maintainer branches, it's =
a
> little bit difficult to collect correctly the patches to send.
>=20
> So, it would be helpful if any of you knowing that some patches have to
> be added to the pull request send me their list.

For October, I'd suggest:

 configs/alpha: Remove unused CONFIG_PARALLEL_ISA
 https://lists.nongnu.org/archive/html/qemu-trivial/2018-10/msg00081.html

 vga_int: remove unused function protype
 https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg04798.html

 piix: use TYPE_FOO constants than string constats
 https://lists.nongnu.org/archive/html/qemu-trivial/2018-10/msg00071.html

 memory.h: fix types in comments
 (title should be changed with s/types/typos/)
 https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg01570.html

 tests/tcg/README: fix location for lm32 tests
 https://lists.nongnu.org/archive/html/qemu-trivial/2018-10/msg00007.html

 qemu-iotests: fix filename containing checks
 https://lists.nongnu.org/archive/html/qemu-trivial/2018-10/msg00008.html

 qemu-iotests: make 218 executable
 https://lists.nongnu.org/archive/html/qemu-trivial/2018-10/msg00009.html

 docs/devel/testing.rst: add missing newlines after code block
 https://lists.nongnu.org/archive/html/qemu-trivial/2018-10/msg00011.html

 scripts/decodetree.py: remove unused imports
 https://lists.nongnu.org/archive/html/qemu-trivial/2018-10/msg00012.html

 scripts/qemu.py: remove trailing quotes on docstring
 https://lists.nongnu.org/archive/html/qemu-trivial/2018-10/msg00015.html

... will try to have a look at the previous months later ...

 Thomas
