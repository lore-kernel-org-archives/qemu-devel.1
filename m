Received: from eggs.gnu.org ([2001:4830:134:3::10]:53398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dV5Kj-0005sX-3N
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 20:16:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dV5Ke-0006wb-2w
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 20:16:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:58706)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1dV5Kd-0006w5-TA
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 20:16:44 -0400
Date: Tue, 11 Jul 2017 17:16:26 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <a94d4bc2-7c47-0bee-0c4f-bb8108e510a9@redhat.com>
Message-ID: <alpine.DEB.2.10.1707111716060.26679@sstabellini-ThinkPad-X260>
References: <20170711082326.12990-1-pbonzini@redhat.com>
	<CAFEAcA_JuAm-xamF4Jc6UGqQ8YQyyJqEg8SYtoetawhVJVKq+A@mail.gmail.com>
	<a94d4bc2-7c47-0bee-0c4f-bb8108e510a9@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] build: disable Xen on ARM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Stefano Stabellini <sstabellini@kernel.org>, Anthony PERARD <anthony.perard@citrix.com>

On Tue, 11 Jul 2017, Paolo Bonzini wrote:
> On 11/07/2017 11:53, Peter Maydell wrote:
> > On 11 July 2017 at 09:23, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >> While ARM could present the xenpv machine, it does not and trying to=
 enable
> >> it breaks compilation.
> >>
> >> Fixes: 3b6b75506de44c5070639943c30a0ad5850f5d02
> >> Reported-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> >> ---
> >>  configure | 1 -
> >>  1 file changed, 1 deletion(-)
> >>
> >> diff --git a/configure b/configure
> >> index a2bec60a97..97b02244fe 100755
> >> --- a/configure
> >> +++ b/configure
> >> @@ -203,7 +203,6 @@ supported_xen_target() {
> >>      test "$xen" =3D "yes" || return 1
> >>      glob "$1" "*-softmmu" || return 1
> >>      case "${1%-softmmu}:$cpu" in
> >> -        arm:arm | aarch64:aarch64 | \
> >>          i386:i386 | i386:x86_64 | x86_64:i386 | x86_64:x86_64)
> >>              return 0
> >>          ;;
> >=20
> > Does this actually do the right thing? It's still testing
> > target-cpu:guest-cpu, if I'm reading it correctly, whereas
> > previously we only looked at target-cpu to decide whether
> > to set CONFIG_XEN.
> >=20
> > In particular, I thought that for aarch64/arm Xen setups
> > we would end up building an i386-softmmu target on an
> > arm/aarch64 host and wanted CONFIG_XEN to be set in that
> > setup ?
>=20
> Yes, that's correct.

Yes, you are right. The patch is good, thanks!
