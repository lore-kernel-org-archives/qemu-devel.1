Received: from eggs.gnu.org ([2001:4830:134:3::10]:57416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lcapitulino@redhat.com>) id 1ejmkA-00019t-K0
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 09:00:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lcapitulino@redhat.com>) id 1ejmk7-0001fB-H4
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 09:00:06 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49036 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lcapitulino@redhat.com>)
	id 1ejmk7-0001e3-Cq
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 09:00:03 -0500
Date: Thu, 8 Feb 2018 09:00:00 -0500
From: Luiz Capitulino <lcapitulino@redhat.com>
Message-ID: <20180208090000.3bfc5cd6@redhat.com>
In-Reply-To: <20180208092928.GN20703@redhat.com>
References: <20180207175014.11157-1-lcapitulino@redhat.com>
	<20180207175014.11157-3-lcapitulino@redhat.com>
	<20180208092928.GN20703@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] qmp: document query-cpus performance
 issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com, ehabkost@redhat.com, mihajlov@linux.vnet.ibm.com

On Thu, 8 Feb 2018 09:29:28 +0000
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Wed, Feb 07, 2018 at 12:50:14PM -0500, Luiz Capitulino wrote:
> > Signed-off-by: Luiz Capitulino <lcapitulino@redhat.com>
> > ---
> >  qapi-schema.json | 4 ++++
> >  1 file changed, 4 insertions(+)
> >=20
> > diff --git a/qapi-schema.json b/qapi-schema.json
> > index 82d6f12b53..0665a14dba 100644
> > --- a/qapi-schema.json
> > +++ b/qapi-schema.json
> > @@ -526,6 +526,10 @@
> >  #
> >  # Returns a list of information about each virtual CPU.
> >  #
> > +# WARNING: This command incurs a performance penalty for latency
> > +#          sensitive workloads and hence it's not recommended to
> > +#          to be used in production. Use query-cpus-fast instead =20
>=20
> I suggest being more explicit about exactly what the problem is, so people
> understand implications if they choose to still use it. ie

I'll add your text.

>=20
>   This command causes vCPU threads to exit to userspace, which causes
>   an small interruption guest CPU execution. This will have a negative
>   impact on realtime guests and other latency sensitive guest workloads.
>   It is recommended to use query-cpus-fast instead of this command to
>   avoid the vCPU interruption.
>=20
> Regards,
> Daniel
