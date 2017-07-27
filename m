Received: from eggs.gnu.org ([2001:4830:134:3::10]:42011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1darXk-0000vG-JU
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 18:46:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1darXh-0001xC-Ry
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 18:46:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34799
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1darXh-0001wu-Lw
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 18:46:05 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6RMdPnw098532
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 18:46:05 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2byp6qq7ud-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 18:46:04 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 27 Jul 2017 18:46:04 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <150119181625.29297.6660999538265637711@loki>
References: <20170726214010.420-1-f4bug@amsat.org>
	<20170726214010.420-4-f4bug@amsat.org>
	<150119181625.29297.6660999538265637711@loki>
Date: Thu, 27 Jul 2017 17:45:53 -0500
Message-Id: <150119555360.29297.17510166454299981899@loki>
Subject: Re: [Qemu-devel] [PATCH for 2.10 3/4] fdt: probe for v1.4.2 using
 fdt_setprop_inplace_namelen_partial()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, John Arbuckle <programmingkidx@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: James Hogan <james.hogan@imgtec.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, Yongbok Kim <yongbok.kim@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>

Quoting Michael Roth (2017-07-27 16:43:36)
> Quoting Philippe Mathieu-Daud=C3=A9 (2017-07-26 16:40:09)
> > instead of fdt_first_subnode() which is v1.4.0
> > =

> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> =

> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>

Doh, please ignore that. I meant:

Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>

> =

> > ---
> >  configure | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > =

> > diff --git a/configure b/configure
> > index 0d5bdb3ae9..2d803d6a77 100755
> > --- a/configure
> > +++ b/configure
> > @@ -3565,7 +3565,10 @@ if test "$fdt" !=3D "no" ; then
> >    cat > $TMPC << EOF
> >  #include <libfdt.h>
> >  #include <libfdt_env.h>
> > -int main(void) { fdt_first_subnode(0, 0); return 0; }
> > +int main(void) {
> > +    fdt_setprop_inplace_namelen_partial(0, 0, 0, 0, 0, 0, 0);
> > +    return 0;
> > +}
> >  EOF
> >    if compile_prog "" "$fdt_libs" ; then
> >      # system DTC is good - use it
> > -- =

> > 2.13.3
> > =

> > =

> =

>=20
