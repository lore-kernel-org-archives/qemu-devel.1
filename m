Received: from eggs.gnu.org ([209.51.188.92]:40579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1ghBLt-0003Ue-FF
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 05:44:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1ghBLs-0002Ib-NX
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 05:44:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47224)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1ghBLs-0002IQ-Ht
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 05:44:48 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CBF748830F
	for <qemu-devel@nongnu.org>; Wed,  9 Jan 2019 10:44:47 +0000 (UTC)
Date: Wed, 9 Jan 2019 11:44:43 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20190109104443.GN3259@paraplu.home>
References: <20190109085113.GA23677@paraplu>
	<16805fd6-6326-4acc-ee99-ac0899a8cf1e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <16805fd6-6326-4acc-ee99-ac0899a8cf1e@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Should the "props" be documented for QMP
 `object-add`?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>

On Wed, Jan 09, 2019 at 11:31:18AM +0100, Philippe Mathieu-Daud=E9 wrote:
> Hi Kashyap,

Hi,

> On 1/9/19 9:51 AM, Kashyap Chamarthy wrote:

[...]

> > That said, in qapi/misc.json "@object-add" doesn't document any of th=
e
> > "props".  Is it on purpose?  Maybe because it is a 1:1 mapping of the
> > command-line `-object` (which _is_ documented in qemu-doc.texi).
> >=20
> > Is it a good idea to send a patch to document the "props" in
> > qapi/misc.json?  Or would it be needless duplication?
>=20
> IMHO the 1:1 mapping is only obvious for developpers who implement such
> commands and for 3rd party libs using QMP.

Even for developers who use QMP to implement higher layer tools, it
might take non-trivial amount of squinting to realize that it's a 1:1
mapping.  It should at least be mentioned in the relevant QMP doc
("explicit is better than implicit").  I'll submit a patch and see if it
flies. :-)

> For end-users, a command-line comment is helpful.
>=20
> This remind me of this patch:
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg06623.html
>=20
> +/**
> + * QAuthZSimple:
> + *
> + * This authorization driver provides a simple mechanism
> + * for granting access based on an exact matched username.
> + *
> + * To create an instance of this class via QMP:
> + *
> + *  {
> + *    "execute": "object-add",
> + *    "arguments": {
> + *      "qom-type": "authz-simple",
> + *      "id": "authz0",
> + *      "parameters": {
> + *        "identity": "fred"
> + *      }
> + *    }
> + *  }
> + *
> + * Or via the command line
> + *
> + *   -object authz-simple,id=3Dauthz0,identity=3Dfred

Yeah, that's a convenient example.  And in this specific case, it is
useful for those reading the code.

--=20
/kashyap
