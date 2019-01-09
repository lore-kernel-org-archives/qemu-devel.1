Received: from eggs.gnu.org ([209.51.188.92]:49934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1ghBvX-0006O8-U5
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 06:21:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1ghBvX-0000UY-7E
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 06:21:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50690)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1ghBvT-0000PA-Jy
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 06:21:37 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 950C72D7E9
	for <qemu-devel@nongnu.org>; Wed,  9 Jan 2019 11:21:27 +0000 (UTC)
Date: Wed, 9 Jan 2019 12:21:25 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20190109112125.GO3259@paraplu.home>
References: <20190109085113.GA23677@paraplu> <20190109110208.GH3998@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190109110208.GH3998@redhat.com>
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
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com

On Wed, Jan 09, 2019 at 11:02:08AM +0000, Daniel P. Berrang=E9 wrote:
> On Wed, Jan 09, 2019 at 09:51:13AM +0100, Kashyap Chamarthy wrote:

[...]

> > That said, in qapi/misc.json "@object-add" doesn't document any of th=
e
> > "props".  Is it on purpose?  Maybe because it is a 1:1 mapping of the
> > command-line `-object` (which _is_ documented in qemu-doc.texi).
> >=20
> > Is it a good idea to send a patch to document the "props" in
> > qapi/misc.json?  Or would it be needless duplication?
>=20
> It is not practical at this time because object_add uses QOM object
> properties and these are exclusively defined in code, not QAPI schema.
>=20
> There's a long term todo item to use QAPI schema to define QOM objects,
> which would then auto-generate the boilerplate QOM code, at which point
> it all becomes self-documenting.=20

Didn't know about this; thanks for the background.  Then, I'll hold off
submitting any patch to qapi/misc.json.

> That's basically lacking dev resources to work on it though...

Noted.

[...]

--=20
/kashyap
