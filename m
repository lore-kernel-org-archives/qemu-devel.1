Received: from eggs.gnu.org ([2001:4830:134:3::10]:34971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ff9Xo-0003wU-9q
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 15:52:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ff9Xj-0007uO-FN
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 15:52:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51284)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ff9Xj-0007uC-8w
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 15:52:23 -0400
Date: Mon, 16 Jul 2018 16:52:14 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180716195214.GN31657@localhost.localdomain>
References: <20180510204148.11687-1-babu.moger@amd.com>
	<20180510204148.11687-2-babu.moger@amd.com>
	<42cdb351-425b-edd2-a4b2-c8e5ffeeec76@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <42cdb351-425b-edd2-a4b2-c8e5ffeeec76@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 1/8] i386: Helpers to encode cache
 information consistently
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Babu Moger <babu.moger@amd.com>, mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com, mtosatti@redhat.com, rth@twiddle.net, geoff@hostfission.com, kash@tripleback.net, qemu-devel@nongnu.org, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, aurelien@aurel32.net

On Mon, Jul 16, 2018 at 10:20:09AM -0300, Philippe Mathieu-Daud=E9 wrote:
[...]
> > +enum CacheType {
> > +    DCACHE,
>=20
> I just noticed this clashes on mips host:
[...]
> In file included from /usr/include/mips-linux-gnu/sys/cachectl.h:26:0,
>                  from /tmp/qemu-test/src/tcg/mips/tcg-target.h:202,
>                  from /tmp/qemu-test/src/include/exec/cpu-defs.h:29,
>                  from /tmp/qemu-test/src/target/i386/cpu.h:34,
>                  from /tmp/qemu-test/src/exec.c:23:
> /tmp/qemu-test/src/target/i386/cpu.h:1053:5: error: expected identifier
> before '(' token
>      DCACHE,
>      ^

Oops.  I will take a look and submit a fix.  Thanks for the
report!

--=20
Eduardo
