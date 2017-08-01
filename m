Received: from eggs.gnu.org ([2001:4830:134:3::10]:35708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dcTSc-0003xt-P7
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 05:27:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dcTSY-0004vL-Pc
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 05:27:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55722)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dcTSY-0004vA-JV
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 05:27:26 -0400
Date: Tue, 1 Aug 2017 10:27:17 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170801092717.GE12670@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170731140718.22010-1-stefanha@redhat.com>
	<20170731140718.22010-3-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170731140718.22010-3-stefanha@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/2] trace: add
 trace_event_get_state_backends()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, "Denis V. Lunev" <den@openvz.org>, =?utf-8?B?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>

On Mon, Jul 31, 2017 at 03:07:18PM +0100, Stefan Hajnoczi wrote:
> Code that checks dstate is unaware of SystemTap and LTTng UST dstate, s=
o
> the following trace event will not fire when solely enabled by SystemTa=
p
> or LTTng UST:
>=20
>   if (trace_event_get_state(TRACE_MY_EVENT)) {
>       str =3D g_strdup_printf("Expensive string to generate ...",
>                             ...);
>       trace_my_event(str);
>       g_free(str);
>   }
>=20
> Add trace_event_get_state_backends() to fetch backend dstate.  Those
> backends that use QEMU dstate fetch it as part of
> generate_h_backend_dstate().
>=20
> Update existing trace_event_get_state() callers to use
> trace_event_get_state_backends() instead.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> v2:
>  * Use _backends() postfix to clarify function purpose [Llu=C3=ADs]
> ---
>  docs/devel/tracing.txt |  2 +-
>  trace/control.h        | 18 +++++++++++++++++-
>  hw/usb/hcd-ohci.c      | 13 +++++--------
>  net/colo-compare.c     | 11 ++++++-----
>  net/filter-rewriter.c  |  4 ++--
>  5 files changed, 31 insertions(+), 17 deletions(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
