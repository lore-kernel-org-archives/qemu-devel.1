Received: from eggs.gnu.org ([2001:4830:134:3::10]:37037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ds8am-0008JI-RW
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 10:24:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ds8aj-0006UI-NA
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 10:24:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ds8aj-0006Ti-Gf
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 10:24:37 -0400
Date: Wed, 13 Sep 2017 15:24:35 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170913142435.GA15565@stefanha-x1.localdomain>
References: <150525662577.19850.13767570977540117247.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <150525662577.19850.13767570977540117247.stgit@frigg.lan>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] trace: Immediately apply per-vCPU state
 changes if a vCPU is being created
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>
Cc: qemu-devel@nongnu.org

On Wed, Sep 13, 2017 at 01:50:25AM +0300, Llu=EDs Vilanova wrote:
> Right now, function trace_event_set_vcpu_state_dynamic() asynchronously=
 enables
> events in the case a vCPU is executing TCG code. If the vCPU is being c=
reated
> this makes some events like "guest_cpu_enter" to not be traced.
>=20
> Signed-off-by: Llu=EDs Vilanova <vilanova@ac.upc.edu>
> Reviewed-by: Emilio G. Cota <cota@braap.org>
> ---
>=20
> Changes in v2
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> * Use RUN_ON_CPU_NULL [Emilio G. Cota].
> * Rebase on fcea73709b.
> ---
>  trace/control-target.c |   18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)

Thanks, applied to my tracing tree:
https://github.com/stefanha/qemu/commits/tracing

Stefan
