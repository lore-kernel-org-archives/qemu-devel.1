Received: from eggs.gnu.org ([209.51.188.92]:51613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hGMxW-00031L-W3
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:13:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hGMxV-0006nZ-Ux
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:13:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41100)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hGMxV-0006i6-Ip
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:13:05 -0400
Date: Tue, 16 Apr 2019 13:12:41 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190416121241.GL31311@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1555416373-28690-1-git-send-email-puwen@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1555416373-28690-1-git-send-email-puwen@hygon.cn>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] i386: Add new Hygon 'Dhyana' CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pu Wen <puwen@hygon.cn>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com

On Tue, Apr 16, 2019 at 08:06:13PM +0800, Pu Wen wrote:
> Add a new base CPU model called 'Dhyana' to model processors from Hygon
> Dhyana(family 18h), which derived from AMD EPYC(family 17h).
>=20
> The following features bits have been removed compare to AMD EPYC:
> aes, pclmulqdq, sha_ni
>=20
> The Hygon Dhyana support to KVM in Linux is already accepted upstream[1=
].
> So add Hygon Dhyana support to Qemu is necessary to create Hygon's own
> CPU model.
>=20
> Reference:
> [1] https://git.kernel.org/tip/fec98069fb72fb656304a3e52265e0c2fc9adf87
>=20
> Signed-off-by: Pu Wen <puwen@hygon.cn>
> ---
> v2->v3:
>   - Remove the Dhyana machine types in the back-compat property tables
>     since there is no Dhyana CPU model in older QEMU releases.
>=20
> v1->v2:
>   - Remove CPU model 'Dhyana' and rename the CPU model 'Dhyana-IBPB' to
>     'Dhyana' because Dhyana CPUs already have the IBPB feature.
>=20
>  target/i386/cpu.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++=
+++
>  target/i386/cpu.h |  2 ++
>  2 files changed, 52 insertions(+)

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
