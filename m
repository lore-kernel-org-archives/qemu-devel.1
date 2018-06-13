Received: from eggs.gnu.org ([2001:4830:134:3::10]:37136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fTAXo-0005wY-8i
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 14:30:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fTAXj-0002mH-BX
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 14:30:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fTAXi-0002ig-JQ
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 14:30:50 -0400
Date: Wed, 13 Jun 2018 15:30:41 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180613183041.GF24764@localhost.localdomain>
References: <20180530184156.15634-1-crosa@redhat.com>
	<20180530184156.15634-6-crosa@redhat.com>
	<a8ec6474-707b-8272-7a79-a842f11d2f7f@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <a8ec6474-707b-8272-7a79-a842f11d2f7f@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 5/5] Acceptance tests: add Linux kernel
 boot and console checking test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Amador Pahim <amador@pahim.org>

On Wed, May 30, 2018 at 05:57:52PM -0300, Philippe Mathieu-Daud=E9 wrote:
[...]
> > +class BootLinuxConsole(Test):
> > +    """
> > +    Boots a x86_64 Linux kernel and checks that the console is opera=
tional
> > +    and the kernel command line is properly passed from QEMU to the =
kernel
> > +
> > +    :avocado: enable
> > +    :avocado: tags=3Dx86_64
>=20
> Can you move tags=3Dx86_64 to the test() method?

I'm queueing this patch as is, as the tag here seems harmless.  A
follow-up patch will be required if you want to move the tag.

--=20
Eduardo
