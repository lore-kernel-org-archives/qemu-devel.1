Received: from eggs.gnu.org ([209.51.188.92]:60678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ght1q-0004hH-CB
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 04:23:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ght1p-0005ew-4X
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 04:23:02 -0500
Date: Fri, 11 Jan 2019 09:22:53 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190111092253.GC18491@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1547194672-24169-1-git-send-email-thuth@redhat.com>
	<1547194672-24169-3-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1547194672-24169-3-git-send-email-thuth@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 2/3] ppc: Fix duplicated typedefs to be
 able to compile with Clang in gnu99 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, qemu-ppc@nongnu.org, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

On Fri, Jan 11, 2019 at 09:17:51AM +0100, Thomas Huth wrote:
> When compiling the ppc code with clang and -std=3Dgnu99, there are a
> couple of warnings/errors like this one:
>=20
>   CC      ppc64-softmmu/hw/intc/xics.o
> In file included from hw/intc/xics.c:35:
> include/hw/ppc/xics.h:43:25: error: redefinition of typedef 'ICPState' =
is a C11 feature
>       [-Werror,-Wtypedef-redefinition]
> typedef struct ICPState ICPState;
>                         ^
> target/ppc/cpu.h:1181:25: note: previous definition is here
> typedef struct ICPState ICPState;
>                         ^
> Work around the problems by including the proper headers instead.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  include/hw/ppc/spapr.h      |  5 +++--
>  include/hw/ppc/spapr_xive.h |  2 --
>  target/ppc/cpu.h            | 13 +++++++++----
>  3 files changed, 12 insertions(+), 8 deletions(-)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
