Received: from eggs.gnu.org ([209.51.188.92]:40516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJMfe-0003Rw-5Y
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:31:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJMZA-00008R-Eh
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:24:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50746)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hJMZA-00007n-9F
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:24:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8075012E4FE
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 18:24:19 +0000 (UTC)
Date: Wed, 24 Apr 2019 15:24:15 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190424182415.GI18406@habkost.net>
References: <20190423212246.3542-1-ehabkost@redhat.com>
	<20190423212246.3542-2-ehabkost@redhat.com>
	<76b8bb16-2e71-c41f-0d4a-79f6df059092@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <76b8bb16-2e71-c41f-0d4a-79f6df059092@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] qapi: SupportStatusInfo struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, mprivozn@redhat.com, Markus Armbruster <armbru@redhat.com>

On Wed, Apr 24, 2019 at 12:23:33AM +0200, Philippe Mathieu-Daud=E9 wrote:
> Hi Eduardo,
>=20
> On 4/23/19 11:22 PM, Eduardo Habkost wrote:
> > This struct will be used to represent support and deprecation
> > status of QEMU features.
>=20
> Excellent idea!
>=20
> >=20
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  qapi/common.json | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >=20
> > diff --git a/qapi/common.json b/qapi/common.json
> > index 99d313ef3b..b59d0dc66b 100644
> > --- a/qapi/common.json
> > +++ b/qapi/common.json
> > @@ -193,3 +193,27 @@
> >               'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
> >               'sh4eb', 'sparc', 'sparc64', 'tricore', 'unicore32',
> >               'x86_64', 'xtensa', 'xtensaeb' ] }
> > +
> > +##
> > +# @SupportStatusInfo:
> > +#
> > +# Information on support status of a given feature
> > +# (e.g. machine type)
>=20
> Hopefully it is generic, we can use it for devices too.

Yes, I want to keep it generic.

>=20
> > +#
> > +# @deprecated: if true, the given feature is deprecated and may be r=
emoved
> > +#              in future versions of QEMU according to the QEMU depr=
ecation
> > +#              policy.
> > +#
> > +# @status-message: Human readable message describing support status
> > +#                  of the feature.
> > +#
> > +# @suggested-alternative: Optional.  Suggested alternative for a dep=
recated
> > +#                         feature.  For machine types, this should b=
e the name
> > +#                         of an available machine-type.
> > +#
> > +# Since: 4.1
> > +##
> > +{ 'struct': 'SupportStatusInfo',
> > +  'data': { 'deprecated': 'bool',
> > +            '*status-message': 'str',
>=20
> This one shouldn't be optional IMHO, we should enforce developpers to
> give a reason for their deprecation.
>=20
> With this argument not optional:
>=20
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

I might agree with you if you show me what would be a good
"reason for deprecation" string for pc-0.15 and spapr.  :)

The only information contained in these machines today is "use
another machine instead", and this is already encoded in the
suggested-alternative field.

--=20
Eduardo
