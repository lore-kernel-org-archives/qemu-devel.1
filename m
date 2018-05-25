Received: from eggs.gnu.org ([2001:4830:134:3::10]:34732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fMKb7-0004PJ-QJ
	for qemu-devel@nongnu.org; Fri, 25 May 2018 17:50:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fMKb3-0005cM-Nd
	for qemu-devel@nongnu.org; Fri, 25 May 2018 17:50:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38982 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fMKb3-0005bC-K0
	for qemu-devel@nongnu.org; Fri, 25 May 2018 17:50:01 -0400
Date: Sat, 26 May 2018 00:49:56 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180526003056-mutt-send-email-mst@kernel.org>
References: <1527266793-301361-1-git-send-email-mst@redhat.com>
	<1527266793-301361-6-git-send-email-mst@redhat.com>
	<0c23ec8f-242e-3731-6da8-27a07185770c@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <0c23ec8f-242e-3731-6da8-27a07185770c@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 05/20] trace: use local path for local
 headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, peter.maydell@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>

On Fri, May 25, 2018 at 06:29:29PM -0300, Philippe Mathieu-Daud=E9 wrote:
> On 05/25/2018 01:47 PM, Michael S. Tsirkin wrote:
> > When pulling in headers that are in the same directory as C file (as
> > opposed to one in include/), we should use its relative path, without=
 a
> > directory.
> >=20
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> > Tested-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> > Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> > Tested-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
>=20
> This reminds me of this project:
>=20
> https://github.com/noidontdig/gitdown
>=20
>     gitdown is a script which moderates your git
>     committing activity based on your blood alcohol
>     content (BAC).
>=20
> :P

Oh I have a script that attaches signatures, and it does not check for du=
plicates.

I started rewriting it using git interpret-trailers but Junio asked me
to rework interpret-trailers first and I didn't bother yet.

> > ---
> >  trace/control.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/trace/control.h b/trace/control.h
> > index 1903e22..eb65c8e 100644
> > --- a/trace/control.h
> > +++ b/trace/control.h
> > @@ -267,6 +267,6 @@ char *trace_opt_parse(const char *optarg);
> >  uint32_t trace_get_vcpu_event_count(void);
> > =20
> > =20
> > -#include "trace/control-internal.h"
> > +#include "control-internal.h"
> > =20
> >  #endif /* TRACE__CONTROL_H */
> >=20
