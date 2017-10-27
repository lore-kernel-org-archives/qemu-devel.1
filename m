Received: from eggs.gnu.org ([2001:4830:134:3::10]:48886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e7ymQ-00077A-H3
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 03:10:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e7ymP-0007ri-7E
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 03:10:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e7ymO-0007qY-UF
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 03:10:09 -0400
Date: Fri, 27 Oct 2017 08:10:03 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171027071003.GB24218@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171026130426.10626-1-berrange@redhat.com>
	<5670f64b-15e5-0747-8ab0-c329a83537ee@amsat.org>
	<9b36faef-8798-9d3c-3803-c1800f3a4e2f@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9b36faef-8798-9d3c-3803-c1800f3a4e2f@ozlabs.ru>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] build: allow automatic git submodule
 updates to be disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

On Fri, Oct 27, 2017 at 03:10:17PM +1100, Alexey Kardashevskiy wrote:
> On 27/10/17 00:33, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 10/26/2017 10:04 AM, Daniel P. Berrange wrote:
> >> Some people building QEMU use VPATH builds where the source director=
y is on a
> >> read-only volume. In such a case 'scripts/git-submodules.sh update' =
will always
> >> fail and users are required to run it manually themselves on their o=
riginal
> >> writable source directory.
> >>
> >> While this is already supported, it is nice to give users a command =
line flag
> >> to configure to permanently disable automatic submodule updates, as =
it means
> >> they won't get hard to diagnose failures from git-submodules.sh at a=
n arbitrary
> >> later date.
> >>
> >> This patch thus introduces a flag '--disable-git-update' which will =
prevent
> >> 'make' from ever running 'scripts/git-submodules.sh update'. It will=
 still run
> >> the 'status' command to determine if a submodule update is needed, b=
ut when it
> >> does this it'll simply stop and print a message instructing the deve=
loper what
> >> todo. eg
> >>
> >> $ ./configure  --target-list=3Dx86_64-softmmu --disable-git-update
> >> ...snip...
> >>
> >> $ make
> >>   GEN     config-host.h
> >>   GEN     trace/generated-tcg-tracers.h
> >>   GEN     trace/generated-helpers-wrappers.h
> >>   GEN     trace/generated-helpers.h
> >>   GEN     trace/generated-helpers.c
> >>   GEN     module_block.h
> >>
> >> GIT submodule checkout is out of date. Please run
> >>   scripts/git-submodule.sh update ui/keycodemapdb
> >> from the source directory checkout /home/berrange/src/virt/qemu
> >=20
> > Clean :)
> >=20
> >>
> >> make: *** [Makefile:31: git-submodule-update] Error 1
> >>
> >> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> >=20
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>=20
>=20
> What tree did you apply on top of? Does not apply for me :-/

Oh sorry, I forgot that it was on-top of my previously sent patch:

https://lists.gnu.org/archive/html/qemu-devel/2017-10/msg05054.html

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
